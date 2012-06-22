From: Ivan Kanis <ivan.kanis@googlemail.com>
Subject: security flaw with smart http
Date: Fri, 22 Jun 2012 12:12:25 +0200 (7 hours, 36 minutes, 16 seconds ago)
Message-ID: <87fw9ns0cp.fsf@kanis.fr>
Mime-Version: 1.0
Content-Type: text/plain
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 22 19:50:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Si7zh-0005Ir-O1
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 19:50:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762643Ab2FVRty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 13:49:54 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:49191 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755914Ab2FVRtr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 13:49:47 -0400
Received: by weyu7 with SMTP id u7so1374803wey.19
        for <git@vger.kernel.org>; Fri, 22 Jun 2012 10:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:subject:date:face:message-id:user-agent:mime-version
         :content-type;
        bh=z43gtO6ZDE88sjm2tELv+kgGC7Ji7F/ttYM/zqXnx/k=;
        b=nVXxcFU4uzt/pNLGDzMfPx9V8ou6wWqMbwytJjr08pf0e8G5y3CfHXpO9riacQcrfY
         gjfzTPipymj9yR5+js7tXPJSW5oO/j+SieRJ+tjF7iMPUm5PKIawWSejlKKt5ExlUwH2
         m2tEcmoJhaN6usZRLcfg5x8XodlPaQR6cyFQjEn6y2SZnM9XVu7YD7J7+Ao3Z4akedX5
         73VNkfHBUBRzwaw8c9HmRkBoAFqy47Rtp59iQxM3afmeeSJcpIrazuFijQYUPyMMgdIn
         nwIQl0RVFKeVIaOOvWAnnkIdWz1wDSuSFxPwR8FXM8L+ACEERv9Oqjr0h8KM/q0/+vSv
         YxXQ==
Received: by 10.180.19.138 with SMTP id f10mr6364225wie.18.1340387386364;
        Fri, 22 Jun 2012 10:49:46 -0700 (PDT)
Received: from yan ([89.83.137.164])
        by mx.google.com with ESMTPS id fm1sm53283529wib.10.2012.06.22.10.49.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 22 Jun 2012 10:49:45 -0700 (PDT)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAAXNSR0IArs4c6QAAAB5QTFRF
 IBkXUxMTOCwoTC4qcUY8iFxQmmper31txpaJ/v/8aKZ1oAAAAcVJREFUOMt100tu2zAQAFDCXnUZ
 oAcIqG68LZULVLQBbwuSiffm6AIRRyeotAySJoVu2+FPpJWWC3/4NKOZocSW/yxWfnJ2+Bdwzhj7
 8gleWVy7DXC2rkMNr2V/zRbghXIwthf3VbIA9Ffc71vZCSFyCEsBggtNS8ludwvfmhYA0Vn9o4DP
 zMWxR7+cPWzAYFzwM0ModtdmcDbDS6i/hT7L+RZof5yCXGrYe5jn2YO6BYMjgY+51tCIAqHgBLwR
 pwLnGuRjAKyBJkuN4yd4U92uCY1vUr2D/c5b8DuxyQwfOHUeaLqDJhnkkuGXbB56h2C1IVBdgncc
 bBi6feroa9B6jUDojnQPQKupbyXyeeCE1oT7Oqrt+SnfY3mkiyGA/3AmD3H5g32CcBx6hY8pRkwJ
 9PpcjRGobUfprFnhAa1vepwcgMOhwG+pdSgKHFU9HAvoAH6XUl7lDUCCq5Qb6GMbVm3Aj++qDYCt
 wdBc/YHgOFCmS3mjDMRcSE2qY4E3Q3PVIQRQmeodNH4QEbRUFZzW+VotzwX4yTcRTySOML1qjcE5
 hTirVqDHkMAP0PjAywp3d18JZtqzvr9zDYD+GaSKtE6Zlr/DLPNFmOcvBAAAAABJRU5ErkJggg==
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200450>

Hi,

I think we found a security flaw with git http smart backend. We are
running git version 1.0.7.4 on our server. Adding random words after the
password and the authentication still succeeds. 

It's very easy to reproduce, say the username is ivan and the password
is the word secret:

% git pull
Username: ivan
Password: secretfoo
Already up to date.

Pull succeeds although the password is wrong! Can someone try to
reproduce with a more up to date git server?
-- 
Ivan Kanis
http://ivan.kanis.fr
