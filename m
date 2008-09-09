From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] t7501: always use test_cmp instead of diff
Date: Wed, 10 Sep 2008 01:37:51 +0200
Message-ID: <1221003471-17064-1-git-send-email-vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 01:47:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdCvb-0007ps-GY
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 01:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbYIIXqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 19:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbYIIXqR
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 19:46:17 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:34201 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbYIIXqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 19:46:16 -0400
Received: from vmobile.example.net (catv-80-98-230-81.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTPA id 2CE30149C5E;
	Wed, 10 Sep 2008 01:46:15 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id E693184CA; Wed, 10 Sep 2008 01:37:51 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95465>

This should make the output more readable (by default using diff -u)
when some tests fail.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

 t/t7501-commit.sh |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 0edd9dd..6f8c038 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -141,7 +141,7 @@ EOF
 
 test_expect_success \
     'validate git-rev-list output.' \
-    'diff current expected'
+    'test_cmp current expected'
 
 test_expect_success 'partial commit that involves removal (1)' '
 
@@ -151,7 +151,7 @@ test_expect_success 'partial commit that involves removal (1)' '
 	git commit -m "Partial: add elif" elif &&
 	git diff-tree --name-status HEAD^ HEAD >current &&
 	echo "A	elif" >expected &&
-	diff expected current
+	test_cmp expected current
 
 '
 
@@ -160,7 +160,7 @@ test_expect_success 'partial commit that involves removal (2)' '
 	git commit -m "Partial: remove file" file &&
 	git diff-tree --name-status HEAD^ HEAD >current &&
 	echo "D	file" >expected &&
-	diff expected current
+	test_cmp expected current
 
 '
 
@@ -171,7 +171,7 @@ test_expect_success 'partial commit that involves removal (3)' '
 	git commit -m "Partial: modify elif" elif &&
 	git diff-tree --name-status HEAD^ HEAD >current &&
 	echo "M	elif" >expected &&
-	diff expected current
+	test_cmp expected current
 
 '
 
@@ -187,7 +187,7 @@ test_expect_success 'amend commit to fix author' '
 		expected &&
 	git commit --amend --author="$author" &&
 	git cat-file -p HEAD > current &&
-	diff expected current
+	test_cmp expected current
 
 '
 
@@ -256,7 +256,7 @@ test_expect_success 'amend commit to fix author' '
 		expected &&
 	git commit --amend --author="$author" &&
 	git cat-file -p HEAD > current &&
-	diff expected current
+	test_cmp expected current
 
 '
 
-- 
1.6.0.1
