From: Larry D'Anna <larry@elder-gods.org>
Subject: [PATCH] git-diff: add a test for git diff --quiet -w
Date: Sun, 21 Feb 2010 21:58:44 -0500
Message-ID: <1266807524-28487-1-git-send-email-larry@elder-gods.org>
Cc: Larry D'Anna <larry@elder-gods.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 04:32:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjOVh-00040c-3a
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 03:59:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754283Ab0BVC6r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2010 21:58:47 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:56593 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754050Ab0BVC6r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2010 21:58:47 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id 1BF1C822195; Sun, 21 Feb 2010 21:58:46 -0500 (EST)
X-Mailer: git-send-email 1.7.0.rc2.40.g7d8aa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140556>

This patch adds two test cases for:

6977c25 git diff --quiet -w: check and report the status

Signed-off-by: Larry D'Anna <larry@elder-gods.org>
---
 t/t4017-diff-retval.sh |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/t/t4017-diff-retval.sh b/t/t4017-diff-retval.sh
index 60dd201..14f80ca 100755
--- a/t/t4017-diff-retval.sh
+++ b/t/t4017-diff-retval.sh
@@ -5,6 +5,9 @@ test_description='Return value of diffs'
 . ./test-lib.sh
 
 test_expect_success 'setup' '
+	echo "1 " >a &&
+	git add . &&
+	git commit -m zeroth &&
 	echo 1 >a &&
 	git add . &&
 	git commit -m first &&
@@ -13,6 +16,16 @@ test_expect_success 'setup' '
 	git commit -a -m second
 '
 
+test_expect_success 'git diff --quiet -w  HEAD^^ HEAD^' '
+	git diff --quiet -w HEAD^^ HEAD^
+	test $? = 0
+'
+
+test_expect_success 'git diff --quiet -w  HEAD^ HEAD' '
+	git diff --quiet -w HEAD^ HEAD
+	test $? = 1
+'
+
 test_expect_success 'git diff-tree HEAD^ HEAD' '
 	git diff-tree --exit-code HEAD^ HEAD
 	test $? = 1
-- 
1.7.0.rc2.40.g7d8aa
