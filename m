From: "Luck, Tony" <tony.luck@intel.com>
Subject: [PATCH] Update howto using-topic-branches
Date: Tue, 8 Nov 2005 15:52:02 -0800
Message-ID: <200511082352.jA8Nq2fW007877@agluck-lia64.sc.intel.com>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 00:53:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZdG7-0001ke-4E
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 00:52:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965094AbVKHXwI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 18:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965123AbVKHXwH
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 18:52:07 -0500
Received: from fmr23.intel.com ([143.183.121.15]:39856 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S965094AbVKHXwG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2005 18:52:06 -0500
Received: from scsfmr100.sc.intel.com (scsfmr100.sc.intel.com [10.3.253.9])
	by scsfmr003.sc.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id jA8Nq32F007865;
	Tue, 8 Nov 2005 23:52:03 GMT
Received: from intel.com (agluck-lia64.sc.intel.com [143.183.251.239])
	by scsfmr100.sc.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with ESMTP id jA8H2cCT027208;
	Tue, 8 Nov 2005 17:02:38 GMT
Received: from agluck-lia64.sc.intel.com (agluck-lia64.sc.intel.com [127.0.0.1])
	by intel.com (Postfix) with ESMTP id D817919F00;
	Tue,  8 Nov 2005 15:52:02 -0800 (PST)
Received: (from aegl@localhost)
	by agluck-lia64.sc.intel.com (8.13.1/8.13.1/Submit) id jA8Nq2fW007877;
	Tue, 8 Nov 2005 15:52:02 -0800
To: Junio C Hamano <junkio@cox.net>
X-Scanned-By: MIMEDefang 2.52 on 10.3.253.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11368>

"git resolve" is being deprecated in favour of "git merge".
Update the documentation to reflect this.

Signed-off-by: Tony Luck <tony.luck@intel.com>

---

Untested ... I'll update my real scripts to do it this way soon.

diff --git a/Documentation/howto/using-topic-branches.txt b/Documentation/howto/using-topic-branches.txt
index c6c635a..4698abe 100644
--- a/Documentation/howto/using-topic-branches.txt
+++ b/Documentation/howto/using-topic-branches.txt
@@ -9,7 +9,7 @@ GIT as a Linux subsystem maintainer.
 
 -Tony
 
-Last updated w.r.t. GIT 0.99.5
+Last updated w.r.t. GIT 0.99.9f
 
 Linux subsystem maintenance using GIT
 -------------------------------------
@@ -89,8 +89,8 @@ out at the current tip of the linus bran
 
 These can be easily kept up to date by merging from the "linus" branch:
 
- $ git checkout test && git resolve test linus "Auto-update from upstream"
- $ git checkout release && git resolve release linus "Auto-update from upstream"
+ $ git checkout test && git merge "Auto-update from upstream" test linus
+ $ git checkout release && git merge "Auto-update from upstream" release linus
 
 Set up so that you can push upstream to your public tree (you need to
 log-in to the remote system and create an empty tree there before the
@@ -128,7 +128,7 @@ commit to this branch.
 When you are happy with the state of this change, you can pull it into the
 "test" branch in preparation to make it public:
 
- $ git checkout test && git resolve test speed-up-spinlocks "Pull speed-up-spinlock changes"
+ $ git checkout test && git merge "Pull speed-up-spinlock changes" test speed-up-spinlocks
 
 It is unlikely that you would have any conflicts here ... but you might if you
 spent a while on this step and had also pulled new versions from upstream.
@@ -138,7 +138,7 @@ same branch into the "release" tree read
 see the value of keeping each patch (or patch series) in its own branch.  It
 means that the patches can be moved into the "release" tree in any order.
 
- $ git checkout release && git resolve release speed-up-spinlocks "Pull speed-up-spinlock changes"
+ $ git checkout release && git merge "Pull speed-up-spinlock changes" release speed-up-spinlocks
 
 After a while, you will have a number of branches, and despite the
 well chosen names you picked for each of them, you may forget what
@@ -190,7 +190,7 @@ Here are some of the scripts that I use 
 
 case "$1" in
 test|release)
-	git checkout $1 && git resolve $1 linus "Auto-update from upstream"
+	git checkout $1 && git merge "Auto-update from upstream" $1 linus
 	;;
 linus)
 	before=$(cat .git/refs/heads/linus)
@@ -231,7 +231,7 @@ test|release)
 		echo $1 already merged into $2 1>&2
 		exit 1
 	fi
-	git checkout $2 && git resolve $2 $1 "Pull $1 into $2 branch"
+	git checkout $2 && git merge "Pull $1 into $2 branch" $2 $1
 	;;
 *)
 	usage
