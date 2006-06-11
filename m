From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 1/5] git-svn: t0000: add -f flag to checkout
Date: Sun, 11 Jun 2006 00:03:41 -0700
Message-ID: <11500094271080-git-send-email-normalperson@yhbt.net>
References: <11500094252972-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Jun 11 09:04:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpJzL-0005iD-VV
	for gcvg-git@gmane.org; Sun, 11 Jun 2006 09:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWFKHDv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 03:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWFKHDt
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 03:03:49 -0400
Received: from hand.yhbt.net ([66.150.188.102]:29105 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1750801AbWFKHDs (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jun 2006 03:03:48 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 6C57B7DC020;
	Sun, 11 Jun 2006 00:03:47 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 11 Jun 2006 00:03:47 -0700
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-Mailer: git-send-email 1.3.3.g2dc7b-dirty
In-Reply-To: <11500094252972-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21636>

Some changes to the latest git.git made this test croak.  So
we'll always just force everything when using a new branch.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 contrib/git-svn/t/t0000-contrib-git-svn.sh |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/contrib/git-svn/t/t0000-contrib-git-svn.sh b/contrib/git-svn/t/t0000-contrib-git-svn.sh
index 8b3a0d9..a07fbad 100644
--- a/contrib/git-svn/t/t0000-contrib-git-svn.sh
+++ b/contrib/git-svn/t/t0000-contrib-git-svn.sh
@@ -32,7 +32,7 @@ test_expect_success \
 
 
 name='try a deep --rmdir with a commit'
-git checkout -b mybranch remotes/git-svn
+git checkout -f -b mybranch remotes/git-svn
 mv dir/a/b/c/d/e/file dir/file
 cp dir/file file
 git update-index --add --remove dir/a/b/c/d/e/file dir/file file
@@ -58,7 +58,7 @@ test_expect_code 1 "$name" \
 
 name='detect node change from directory to file #1'
 rm -rf dir $GIT_DIR/index
-git checkout -b mybranch2 remotes/git-svn
+git checkout -f -b mybranch2 remotes/git-svn
 mv bar/zzz zzz
 rm -rf bar
 mv zzz bar
@@ -73,7 +73,7 @@ test_expect_code 1 "$name" \
 
 name='detect node change from file to directory #2'
 rm -f $GIT_DIR/index
-git checkout -b mybranch3 remotes/git-svn
+git checkout -f -b mybranch3 remotes/git-svn
 rm bar/zzz
 git-update-index --remove bar/zzz
 mkdir bar/zzz
@@ -88,7 +88,7 @@ test_expect_code 1 "$name" \
 
 name='detect node change from directory to file #2'
 rm -f $GIT_DIR/index
-git checkout -b mybranch4 remotes/git-svn
+git checkout -f -b mybranch4 remotes/git-svn
 rm -rf dir
 git update-index --remove -- dir/file
 touch dir
@@ -103,7 +103,7 @@ test_expect_code 1 "$name" \
 
 name='remove executable bit from a file'
 rm -f $GIT_DIR/index
-git checkout -b mybranch5 remotes/git-svn
+git checkout -f -b mybranch5 remotes/git-svn
 chmod -x exec.sh
 git update-index exec.sh
 git commit -m "$name"
-- 
1.3.3.g2dc7b-dirty
