From: Bryan Donlan <bdonlan@fushizen.net>
Subject: [PATCH v3 10/10] Rename the test trash directory to contain spaces.
Date: Sun,  4 May 2008 01:38:00 -0400
Message-ID: <1209879480-16910-11-git-send-email-bdonlan@fushizen.net>
References: <1207810216-27871-1-git-send-email-bdonlan@fushizen.net>
 <1209879480-16910-1-git-send-email-bdonlan@fushizen.net>
 <1209879480-16910-2-git-send-email-bdonlan@fushizen.net>
 <1209879480-16910-3-git-send-email-bdonlan@fushizen.net>
 <1209879480-16910-4-git-send-email-bdonlan@fushizen.net>
 <1209879480-16910-5-git-send-email-bdonlan@fushizen.net>
 <1209879480-16910-6-git-send-email-bdonlan@fushizen.net>
 <1209879480-16910-7-git-send-email-bdonlan@fushizen.net>
 <1209879480-16910-8-git-send-email-bdonlan@fushizen.net>
 <1209879480-16910-9-git-send-email-bdonlan@fushizen.net>
 <1209879480-16910-10-git-send-email-bdonlan@fushizen.net>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Adam Roben <aroben@apple.com>, gitster@pobox.com,
	Bryan Donlan <bdonlan@fushizen.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 04 07:39:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsWwi-0004V4-4l
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 07:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbYEDFiv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 01:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751746AbYEDFiv
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 01:38:51 -0400
Received: from satoko.is.fushizen.net ([64.71.152.231]:37809 "EHLO
	satoko.is.fushizen.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737AbYEDFiu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 01:38:50 -0400
Received: from cpe-74-69-246-7.maine.res.rr.com ([74.69.246.7] helo=shion)
	by satoko.is.fushizen.net with esmtpa (Exim 4.69)
	(envelope-from <bd@fushizen.net>)
	id 1JsWvG-0001Mm-UQ; Sun, 04 May 2008 05:38:07 +0000
Received: from bd by shion with local (Exim 4.69)
	(envelope-from <bd@shion.is.fushizen.net>)
	id 1JsWvB-0004PP-JV; Sun, 04 May 2008 01:38:01 -0400
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1209879480-16910-10-git-send-email-bdonlan@fushizen.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81138>

In order to help prevent regressions in the future, rename the trash directory
for all tests to contain spaces. This patch also corrects two failures that
were caused or exposed by this change.

Signed-off-by: Bryan Donlan <bdonlan@fushizen.net>
---
 t/.gitignore                         |    2 +-
 t/t6200-fmt-merge-msg.sh             |    6 +++---
 t/t9121-git-svn-fetch-renamed-dir.sh |   12 ++++++------
 t/test-lib.sh                        |    4 ++--
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/t/.gitignore b/t/.gitignore
index fad67c0..11ffd91 100644
--- a/t/.gitignore
+++ b/t/.gitignore
@@ -1 +1 @@
-trash
+/trash directory
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 526d7d1..9c0b926 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -82,14 +82,14 @@ test_expect_success 'merge-msg test #1' '
 	git diff actual expected
 '
 
-cat >expected <<\EOF
-Merge branch 'left' of ../trash
+cat >expected <<EOF
+Merge branch 'left' of ../$test
 EOF
 
 test_expect_success 'merge-msg test #2' '
 
 	git checkout master &&
-	git fetch ../trash left &&
+	git fetch ../"$test" left &&
 
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
 	git diff actual expected
diff --git a/t/t9121-git-svn-fetch-renamed-dir.sh b/t/t9121-git-svn-fetch-renamed-dir.sh
index 5143ed6..99230b0 100755
--- a/t/t9121-git-svn-fetch-renamed-dir.sh
+++ b/t/t9121-git-svn-fetch-renamed-dir.sh
@@ -7,14 +7,14 @@ test_description='git-svn can fetch renamed directories'
 
 . ./lib-git-svn.sh
 
-test_expect_success 'load repository with renamed directory' "
-	svnadmin load -q $rawsvnrepo < ../t9121/renamed-dir.dump
-	"
+test_expect_success 'load repository with renamed directory' '
+	svnadmin load -q "$rawsvnrepo" < ../t9121/renamed-dir.dump
+	'
 
-test_expect_success 'init and fetch repository' "
-	git svn init $svnrepo/newname &&
+test_expect_success 'init and fetch repository' '
+	git svn init "$svnrepo/newname" &&
 	git svn fetch
-	"
+	'
 
 test_done
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 04e098b..5002fb0 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -411,14 +411,14 @@ fi
 . ../GIT-BUILD-OPTIONS
 
 # Test repository
-test=trash
+test="trash directory"
 rm -fr "$test" || {
 	trap - exit
 	echo >&5 "FATAL: Cannot prepare test area"
 	exit 1
 }
 
-test_create_repo $test
+test_create_repo "$test"
 cd "$test"
 
 this_test=$(expr "./$0" : '.*/\(t[0-9]*\)-[^/]*$')
-- 
1.5.5.1.128.g03a943
