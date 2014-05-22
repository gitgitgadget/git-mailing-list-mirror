From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH] Get rid of the non portable shell export VAR=VALUE costruct
Date: Thu, 22 May 2014 05:48:16 -0700
Message-ID: <1400762896-24324-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 22 14:48:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnSQB-00015g-AW
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 14:48:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753918AbaEVMsW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 08:48:22 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:51251 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842AbaEVMsU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 08:48:20 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb1so2488664pad.9
        for <git@vger.kernel.org>; Thu, 22 May 2014 05:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=EYZAKEGvtnHB6O0+gx4XED2JD6yyYPyrt2V5r7W+Cl4=;
        b=kjOwfiygLC06GRbC2yoWn0MPL6gVCa8tAxGfwCyUYcRU2xeeeSK5/NiA6WdcnsenUR
         aVQTpGTb9PSdlD4tHkU8c7N9WZ6RzoPUVwIqpILt8Wq7kDFHQxnIKSsYCONVtsuf0OU5
         45ewRw2R4/23lu9Te6Ty7cdCHslGgTMcR7DSfnMBI4dOd8GB+x/2PrF5klgzVyxl7Adg
         iySlnwRa5tuuOdfa2w0jJfd78k+6XaABQq2qij7f4mO5+dvBC/zJoMJcsWoln8Ss3arQ
         RNiGRyUlGVQVStt+B10IEuFCqQSxJ+UaUJYLDKnCMP4vWm1Q3qjZH2FFTLcgTEu5xFeN
         Po/Q==
X-Received: by 10.68.213.97 with SMTP id nr1mr66411946pbc.52.1400762899863;
        Thu, 22 May 2014 05:48:19 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id wl5sm3049025pbc.13.2014.05.22.05.48.18
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 22 May 2014 05:48:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249899>

Found by check-non-portable-shell.pl

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 contrib/subtree/t/t7900-subtree.sh |    2 +-
 git-remote-testgit.sh              |    2 +-
 git-stash.sh                       |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 66ce4b0..c1d0b23 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -8,7 +8,7 @@ This test verifies the basic operation of the merge, pull, add
 and split subcommands of git subtree.
 '
 
-export TEST_DIRECTORY=$(pwd)/../../../t
+TEST_DIRECTORY=$(pwd)/../../../t && export TEST_DIRECTORY
 
 . ../../../t/test-lib.sh
 
diff --git a/git-remote-testgit.sh b/git-remote-testgit.sh
index 1c006a0..9d1ce76 100755
--- a/git-remote-testgit.sh
+++ b/git-remote-testgit.sh
@@ -13,7 +13,7 @@ refspec="${GIT_REMOTE_TESTGIT_REFSPEC-$default_refspec}"
 
 test -z "$refspec" && prefix="refs"
 
-export GIT_DIR="$url/.git"
+GIT_DIR="$url/.git" && export GIT_DIR
 
 force=
 
diff --git a/git-stash.sh b/git-stash.sh
index 4798bcf..0bb1af8 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -94,7 +94,7 @@ create_stash () {
 		# ease of unpacking later.
 		u_commit=$(
 			untracked_files | (
-				export GIT_INDEX_FILE="$TMPindex"
+				GIT_INDEX_FILE="$TMPindex" && export GIT_INDEX_FILE &&
 				rm -f "$TMPindex" &&
 				git update-index -z --add --remove --stdin &&
 				u_tree=$(git write-tree) &&
-- 
1.7.10.4
