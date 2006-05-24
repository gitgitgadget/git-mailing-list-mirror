From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: t0000: add -f flag to checkout
Date: Tue, 23 May 2006 19:13:18 -0700
Message-ID: <11484367982046-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed May 24 04:13:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiisH-0005Lj-Jn
	for gcvg-git@gmane.org; Wed, 24 May 2006 04:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932546AbWEXCNW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 22:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbWEXCNW
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 22:13:22 -0400
Received: from hand.yhbt.net ([66.150.188.102]:29060 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932546AbWEXCNW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 22:13:22 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 53D0E2DC01A;
	Tue, 23 May 2006 19:13:20 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 23 May 2006 19:13:18 -0700
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-Mailer: git-send-email 1.3.2.g7d11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20657>

Some changes to the latest git.git made this test croak.  So
we'll always just force everything when using a new branch.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 contrib/git-svn/t/t0000-contrib-git-svn.sh |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

9439cefac1aa09cdc8553f452d84ddf71be2f909
diff --git a/contrib/git-svn/t/t0000-contrib-git-svn.sh b/contrib/git-svn/t/t0000-contrib-git-svn.sh
index 80ad357..f400202 100644
--- a/contrib/git-svn/t/t0000-contrib-git-svn.sh
+++ b/contrib/git-svn/t/t0000-contrib-git-svn.sh
@@ -71,7 +71,7 @@ test_expect_success \
 
 
 name='try a deep --rmdir with a commit'
-git checkout -b mybranch remotes/git-svn
+git checkout -f -b mybranch remotes/git-svn
 mv dir/a/b/c/d/e/file dir/file
 cp dir/file file
 git update-index --add --remove dir/a/b/c/d/e/file dir/file file
@@ -97,7 +97,7 @@ test_expect_code 1 "$name" \
 
 name='detect node change from directory to file #1'
 rm -rf dir $GIT_DIR/index
-git checkout -b mybranch2 remotes/git-svn
+git checkout -f -b mybranch2 remotes/git-svn
 mv bar/zzz zzz
 rm -rf bar
 mv zzz bar
@@ -112,7 +112,7 @@ test_expect_code 1 "$name" \
 
 name='detect node change from file to directory #2'
 rm -f $GIT_DIR/index
-git checkout -b mybranch3 remotes/git-svn
+git checkout -f -b mybranch3 remotes/git-svn
 rm bar/zzz
 git-update-index --remove bar/zzz
 mkdir bar/zzz
@@ -127,7 +127,7 @@ test_expect_code 1 "$name" \
 
 name='detect node change from directory to file #2'
 rm -f $GIT_DIR/index
-git checkout -b mybranch4 remotes/git-svn
+git checkout -f -b mybranch4 remotes/git-svn
 rm -rf dir
 git update-index --remove -- dir/file
 touch dir
@@ -142,7 +142,7 @@ test_expect_code 1 "$name" \
 
 name='remove executable bit from a file'
 rm -f $GIT_DIR/index
-git checkout -b mybranch5 remotes/git-svn
+git checkout -f -b mybranch5 remotes/git-svn
 chmod -x exec.sh
 git update-index exec.sh
 git commit -m "$name"
-- 
1.3.2.g7d11
