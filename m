From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: git log --graph --oneline issues (very small edge case)
Date: Fri, 19 Dec 2014 11:27:46 -0500
Organization: PD Inc
Message-ID: <71B93170AE5D4ED08EF12CED427299C4@black>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 19 17:27:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y20PB-0008Sk-8I
	for gcvg-git-2@plane.gmane.org; Fri, 19 Dec 2014 17:27:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935AbaLSQ1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2014 11:27:49 -0500
Received: from mail.pdinc.us ([67.90.184.27]:35412 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750953AbaLSQ1s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Dec 2014 11:27:48 -0500
Received: from black (five-58.pdinc.us [192.168.5.58])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id sBJGRlRa018203
	for <git@vger.kernel.org>; Fri, 19 Dec 2014 11:27:47 -0500
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AdAbqLkQxEFAQInPQBCFHex4S+XtsA==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261580>

When a repo has multiple initial commits, the oneline graph can get borked.

It will put a commit * with no parent directly above the next commit * with no children. This gives the false impression that the two commits are a sequence on a branch. E.g:

* xxxxxxx update of A (#0011)
* xxxxxxx merge of B->A (#0010)
|\
| * xxxxxxx update of B (#0009)
* | xxxxxxx update of A (#0008)
* | xxxxxxx update of A (#0007)
| * xxxxxxx update of B (#0006)
| * xxxxxxx update of B (#0005)
| * xxxxxxx inital commit B (#0004)
| * xxxxxxx update of A' (#0003)
| * xxxxxxx fork of A (#0002)
|/
* xxxxxxx intial commit A (#0001)

It should put a blank line after a commit without a parent, like so:

* xxxxxxx update of A (#0011)
* xxxxxxx merge of B->A (#0010)
|\
| * xxxxxxx update of B (#0009)
* | xxxxxxx update of A (#0008)
* | xxxxxxx update of A (#0007)
| * xxxxxxx update of B (#0006)
| * xxxxxxx update of B (#0005)
| * xxxxxxx inital commit B (#0004)
|
| * xxxxxxx update of A' (#0003)
| * xxxxxxx fork of A (#0002)
|/
* xxxxxxx intial commit A (#0001)

Unless it is the last commit to be output.

I hit this in the wild https://github.com/pdinc-oss/CipherShed.git, but now that the branches are merged the graph looks fine.

-Jason

--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
This message is copyright PD Inc, subject to license 20080407P00.
