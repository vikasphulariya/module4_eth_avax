// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
contract Assessment is ERC20 {
    address public owner;
    string[] public RedemableItems;
    constructor() ERC20("VikasPhulriya", "VP") {
        owner = msg.sender;
        RedemableItems = new string[](4);
        RedemableItems[0] = "Item 1";
        RedemableItems[1] = "Item 2";
        RedemableItems[2] = "Item 3";
        RedemableItems[3] = "Item 4";}

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can call this function");
        _;
    }

    function mint(address to, uint256 value) public onlyOwner {
        require(to != address(0), "Invalid address");
        require(value > 0, "Invalid value");

        _mint(to, value);
    }

    function transfer(address to, uint256 value) public override returns (bool) {
        require(to != address(0), "Invalid address");
        require(value > 0, "Invalid value");

        return super.transfer(to, value);
    }

     function redeem(uint256 itemId,uint256 cost) public payable  {
          require(
            bytes(RedemableItems[itemId]).length > 0,
            "Item does not exist"
        );

        require(
            balanceOf(msg.sender) >= cost,
            "Insufficient balance"
        );
        _burn(_msgSender(),cost);
        
    }

    function burn(uint256 value) public {
        require(value > 0, "Invalid value");
        require(value <= balanceOf(msg.sender), "Insufficient balance");

        _burn(msg.sender, value);
    }
}
