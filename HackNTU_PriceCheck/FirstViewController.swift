//
//  FirstViewController.swift
//  HackNTU_PriceCheck
//
//  Created by Joseph Lin on 2016/12/17.
//  Copyright © 2016年 TuDou Team. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    let screenWidth = UIScreen.main.bounds.size.width
    
    @IBOutlet weak var scrollView: LTInfiniteScrollView!
    
    @IBAction func scanQRCodeCameraButton(_ sender: UIButton) {
    }
    @IBAction func searchBarFilterButton(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        scrollView.dataSource = self
        scrollView.delegate = self
        scrollView.maxScrollDistance = 5
        view.addSubview(scrollView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollView.reloadData(initialIndex: 0)
    }
}

extension FirstViewController: LTInfiniteScrollViewDataSource {
    
    func viewAtIndex(_ index: Int, reusingView view: UIView?) -> UIView {
        if let label = view as? UILabel {
            label.text = "\(index)"
            return label
        }
        else {
            let size = screenWidth / CGFloat(numberOfVisibleViews())
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: size, height: size))
            label.textAlignment = .center
            label.backgroundColor = UIColor.darkGray
            label.textColor = UIColor.white
            label.layer.cornerRadius = size / 2
            label.layer.masksToBounds = true
            label.text = "\(index)"
            return label
        }
    }
    
    func numberOfViews() -> Int {
        return 50
    }
    
    func numberOfVisibleViews() -> Int {
        return 6
    }
}

extension FirstViewController: LTInfiniteScrollViewDelegate {
    
    func updateView(_ view: UIView, withProgress progress: CGFloat, scrollDirection direction: LTInfiniteScrollView.ScrollDirection) {
        let size = screenWidth / CGFloat(numberOfVisibleViews())
        
        var transform = CGAffineTransform.identity
        // scale
        let scale = (1.4 - 0.3 * (fabs(progress)))
        transform = transform.scaledBy(x: scale, y: scale)
        
        // translate
        var translate = size / 4 * progress
        if progress > 1 {
            translate = size / 4
        }
        else if progress < -1 {
            translate = -size / 4
        }
        transform = transform.translatedBy(x: translate, y: 0)
        
        view.transform = transform
    }
    
    func scrollViewDidScrollToIndex(_ scrollView: LTInfiniteScrollView, index: Int) {
        print("scroll to index: \(index)")
    }
}
