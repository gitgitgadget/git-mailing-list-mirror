From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-branch: add -r switch to list refs/remotes/*
Date: Thu, 2 Mar 2006 12:23:17 -0800
Message-ID: <20060302202317.GA6708@hand.yhbt.net>
References: <20060302055831.GA16600@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Mar 02 21:23:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEuKY-0000g1-Cd
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 21:23:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbWCBUXT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 15:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbWCBUXT
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 15:23:19 -0500
Received: from hand.yhbt.net ([66.150.188.102]:56794 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932500AbWCBUXT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 15:23:19 -0500
Received: by hand.yhbt.net (Postfix, from userid 500)
	id 15A182DC08D; Thu,  2 Mar 2006 12:23:18 -0800 (PST)
To: git list <git@vger.kernel.org>, Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060302055831.GA16600@localdomain>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17105>

If we decide to use refs/remotes/, having a convenient way to
list them would be nice.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 git-branch.sh |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

05fb74c2a8d4bf3692a7553c5225d25ab54f358a
diff --git a/git-branch.sh b/git-branch.sh
index 6ac961e..663a3a3 100755
--- a/git-branch.sh
+++ b/git-branch.sh
@@ -48,6 +48,12 @@ If you are sure you want to delete it, r
     exit 0
 }
 
+ls_remote_branches () {
+    git-rev-parse --symbolic --all |
+    sed -ne 's|^refs/\(remotes/\)|\1|p' |
+    sort
+}
+
 force=
 while case "$#,$1" in 0,*) break ;; *,-*) ;; *) break ;; esac
 do
@@ -56,6 +62,10 @@ do
 		delete_branch "$@"
 		exit
 		;;
+	-r)
+		ls_remote_branches
+		exit
+		;;
 	-f)
 		force="$1"
 		;;
-- 
1.2.3.gc55f
