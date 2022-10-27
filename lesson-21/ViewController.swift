//
//  ViewController.swift
//  lesson-21
//
//  Created by Vinicius da Luz on 25/10/22.
//

import UIKit


precedencegroup ExponentiationPrecedence {
  associativity: right
  higherThan: MultiplicationPrecedence
}

infix operator ** : ExponentiationPrecedence

func ** (_ base: Double, _ exp: Double) -> Double {
  return pow(base, exp)
}

enum Operation: String{
    case NULL = "Null"
    case Add = "+"
    case Subtract = "-"
    case Divide = "/"
    case Multiply = "*"
    case Exponent = "^"
    case Percentage = "%"
}

class ViewController: UIViewController {

    var runningNumber: String = ""
    var firstValue: String = ""
    var secondValue: String = ""
    var result: String = ""
    var currentOperation: Operation = .NULL
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        outputDisplay.text = "0"
    }

    @IBOutlet weak var outputDisplay: UILabel!
    
    @IBAction func numberPressed(_ sender: UIButton) {
       // sender.titleLabel?.text ?? ""
        if runningNumber.count <= 9 {
            runningNumber += "\(sender.tag)"
            outputDisplay.text = runningNumber
        }
    }
    
    @IBAction func resetACPressed(_ sender: UIButton) {
        runningNumber = ""
        firstValue = ""
        secondValue = ""
        result = ""
        currentOperation = .NULL
        outputDisplay.text = "0"
    }
    
    @IBAction func exponentialPressed(_ sender: UIButton) {
        operation(operation: .Exponent)
    }
    @IBAction func dotPressed(_ sender: UIButton) {
        if runningNumber.count <= 8 {
            if !(runningNumber.contains(".")){
                runningNumber += "."
                outputDisplay.text = runningNumber
            }
        } 
    }
    
    @IBAction func porcentagePressed(_ sender: UIButton) {
        operation(operation: .Percentage)
    }
    
    @IBAction func dividePressed(_ sender: UIButton) {
        operation(operation: .Divide)
    }
    
    @IBAction func multiplyPressed(_ sender: UIButton) {
        operation(operation: .Multiply)
    }
    
    @IBAction func subtractPressed(_ sender: UIButton) {
        operation(operation: .Subtract)
    }
    
    @IBAction func addPressed(_ sender: UIButton) {
        operation(operation: .Add)
    }
    
    @IBAction func equalPressed(_ sender: UIButton) {
        operation(operation: currentOperation)
    }
    
    func operation(operation: Operation){
        if currentOperation != .NULL{
            if runningNumber != "" {
                secondValue = runningNumber
                runningNumber = ""
                
                if currentOperation == .Add {
                    result = "\(Double(firstValue)! + Double(secondValue)!)"
                }else if currentOperation == .Subtract{
                    result = "\(Double(firstValue)! - Double(secondValue)!)"
                }else if currentOperation == .Multiply{
                    result = "\(Double(firstValue)! * Double(secondValue)!)"
                }else if currentOperation == .Divide{
                    result = "\(Double(firstValue)! / Double(secondValue)!)"
                }else if currentOperation == .Exponent{
                    result = "\(Double(firstValue)! ** Double(secondValue)!)"
                }else if currentOperation == .Percentage{
                    result = "\(Double(firstValue)! * ((Double(secondValue)! * 0.01)))"
                }
                firstValue = result
                
                if(Double(result)!.truncatingRemainder(dividingBy: 1) == 0){
                    result = "\(Int(Double(result)!))"
                }
                outputDisplay.text = result
            }
            currentOperation = operation
            
        }else{
            firstValue = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
    
}

