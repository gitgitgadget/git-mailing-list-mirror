From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 6/8] t3901: Use ISO8859-1 instead of ISO-8859-1 for backward compatibility
Date: Mon, 18 May 2009 18:44:43 -0500
Message-ID: <KfeKNR3Jm6YKvPIcYGBMpKMgDQvtEffFhDQ5lsZU861rwPvLMbXRKufUbP1Cj7yuYKrGcvxDsnU@cipher.nrlssc.navy.mil>
References: <KfeKNR3Jm6YKvPIcYGBMpCbbOxxIaBRphS4qzgN2W9mXIvp7Hl8SgBQzbAhZRV4A4Q6X14JTLR4@cipher.nrlssc.navy.mil> <KfeKNR3Jm6YKvPIcYGBMpKjNOsMcmMNMJ1vr-EBr-eE371H-Rg69NOM1rMB2Oa5nCGVe2SMGKdc@cipher.nrlssc.navy.mil> <KfeKNR3Jm6YKvPIcYGBMpLkRr97IFN82BZR2bJNHFQYwhjGgwGRoIAkKO5m1EZb7M9epcX8P-fk@cipher.nrlssc.navy.mil> <KfeKNR3Jm6YKvPIcYGBMpEj60b9ww0Dv2XSyNy2qLE-KEaaF8D8q9OHVC3tPAPSzNe1CJUXJDfA@cipher.nrlssc.navy.mil> <KfeKNR3Jm6YKvPIcYGBMpGlk83sgTnCuuc7WdvYgBn_Ja9b0yZjdlJxTSSCaDWC05irzAQVk1uM@cipher.nrlssc.navy.mil> <KfeKNR3Jm6YKvPIcYGBMpPhpa6XnDlrUaNKPjrH6NYGZK9NzwH2STGreDnkCUEwiMxu0BD6uSgk@cipher.nrlssc.navy.mil>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 19 01:45:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6CWk-0003iT-IF
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 01:45:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754152AbZERXpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 19:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754054AbZERXpI
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 19:45:08 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50119 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753324AbZERXo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 19:44:59 -0400
Received: by mail.nrlssc.navy.mil id n4INitKU024906; Mon, 18 May 2009 18:45:00 -0500
In-Reply-To: <KfeKNR3Jm6YKvPIcYGBMpPhpa6XnDlrUaNKPjrH6NYGZK9NzwH2STGreDnkCUEwiMxu0BD6uSgk@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 18 May 2009 23:44:55.0918 (UTC) FILETIME=[A5C8C8E0:01C9D812]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119476>

Some ancient platforms do not have an extensive list of alternate names for
character encodings.  For example, Solaris 7 does not know that ISO-8859-1
is the same as ISO8859-1.  Modern platforms do know this, so use the older
name.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t3901-i18n-patch.sh |   40 ++++++++++++++++++++--------------------
 1 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/t/t3901-i18n-patch.sh b/t/t3901-i18n-patch.sh
index b04f74a..31a5770 100755
--- a/t/t3901-i18n-patch.sh
+++ b/t/t3901-i18n-patch.sh
@@ -17,9 +17,9 @@ check_encoding () {
 		git cat-file commit HEAD~$j |
 		case "$header" in
 		8859)
-			grep "^encoding ISO-8859-1" ;;
+			grep "^encoding ISO8859-1" ;;
 		*)
-			grep "^encoding ISO-8859-1"; test "$?" != 0 ;;
+			grep "^encoding ISO8859-1"; test "$?" != 0 ;;
 		esac || {
 			bad=1
 			break
@@ -55,7 +55,7 @@ test_expect_success setup '
 	git commit -s -m "Second on side" &&
 
 	# the second one on the side branch is ISO-8859-1
-	git config i18n.commitencoding ISO-8859-1 &&
+	git config i18n.commitencoding ISO8859-1 &&
 	# use author and committer name in ISO-8859-1 to match it.
 	. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
 	test_tick &&
@@ -68,14 +68,14 @@ test_expect_success setup '
 '
 
 test_expect_success 'format-patch output (ISO-8859-1)' '
-	git config i18n.logoutputencoding ISO-8859-1 &&
+	git config i18n.logoutputencoding ISO8859-1 &&
 
 	git format-patch --stdout master..HEAD^ >out-l1 &&
 	git format-patch --stdout HEAD^ >out-l2 &&
-	grep "^Content-Type: text/plain; charset=ISO-8859-1" out-l1 &&
-	grep "^From: =?ISO-8859-1?q?=C1=E9=ED=20=F3=FA?=" out-l1 &&
-	grep "^Content-Type: text/plain; charset=ISO-8859-1" out-l2 &&
-	grep "^From: =?ISO-8859-1?q?=C1=E9=ED=20=F3=FA?=" out-l2
+	grep "^Content-Type: text/plain; charset=ISO8859-1" out-l1 &&
+	grep "^From: =?ISO8859-1?q?=C1=E9=ED=20=F3=FA?=" out-l1 &&
+	grep "^Content-Type: text/plain; charset=ISO8859-1" out-l2 &&
+	grep "^From: =?ISO8859-1?q?=C1=E9=ED=20=F3=FA?=" out-l2
 '
 
 test_expect_success 'format-patch output (UTF-8)' '
@@ -110,7 +110,7 @@ test_expect_success 'rebase (U/U)' '
 
 test_expect_success 'rebase (U/L)' '
 	git config i18n.commitencoding UTF-8 &&
-	git config i18n.logoutputencoding ISO-8859-1 &&
+	git config i18n.logoutputencoding ISO8859-1 &&
 	. "$TEST_DIRECTORY"/t3901-utf8.txt &&
 
 	git reset --hard side &&
@@ -121,8 +121,8 @@ test_expect_success 'rebase (U/L)' '
 
 test_expect_success 'rebase (L/L)' '
 	# In this test we want ISO-8859-1 encoded commits as the result
-	git config i18n.commitencoding ISO-8859-1 &&
-	git config i18n.logoutputencoding ISO-8859-1 &&
+	git config i18n.commitencoding ISO8859-1 &&
+	git config i18n.logoutputencoding ISO8859-1 &&
 	. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
 
 	git reset --hard side &&
@@ -134,7 +134,7 @@ test_expect_success 'rebase (L/L)' '
 test_expect_success 'rebase (L/U)' '
 	# This is pathological -- use UTF-8 as intermediate form
 	# to get ISO-8859-1 results.
-	git config i18n.commitencoding ISO-8859-1 &&
+	git config i18n.commitencoding ISO8859-1 &&
 	git config i18n.logoutputencoding UTF-8 &&
 	. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
 
@@ -162,8 +162,8 @@ test_expect_success 'cherry-pick(U/U)' '
 test_expect_success 'cherry-pick(L/L)' '
 	# Both the commitencoding and logoutputencoding is set to ISO-8859-1
 
-	git config i18n.commitencoding ISO-8859-1 &&
-	git config i18n.logoutputencoding ISO-8859-1 &&
+	git config i18n.commitencoding ISO8859-1 &&
+	git config i18n.logoutputencoding ISO8859-1 &&
 	. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
 
 	git reset --hard master &&
@@ -178,7 +178,7 @@ test_expect_success 'cherry-pick(U/L)' '
 	# Commitencoding is set to UTF-8 but logoutputencoding is ISO-8859-1
 
 	git config i18n.commitencoding UTF-8 &&
-	git config i18n.logoutputencoding ISO-8859-1 &&
+	git config i18n.logoutputencoding ISO8859-1 &&
 	. "$TEST_DIRECTORY"/t3901-utf8.txt &&
 
 	git reset --hard master &&
@@ -193,7 +193,7 @@ test_expect_success 'cherry-pick(L/U)' '
 	# Again, the commitencoding is set to ISO-8859-1 but
 	# logoutputencoding is set to UTF-8.
 
-	git config i18n.commitencoding ISO-8859-1 &&
+	git config i18n.commitencoding ISO8859-1 &&
 	git config i18n.logoutputencoding UTF-8 &&
 	. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
 
@@ -218,7 +218,7 @@ test_expect_success 'rebase --merge (U/U)' '
 
 test_expect_success 'rebase --merge (U/L)' '
 	git config i18n.commitencoding UTF-8 &&
-	git config i18n.logoutputencoding ISO-8859-1 &&
+	git config i18n.logoutputencoding ISO8859-1 &&
 	. "$TEST_DIRECTORY"/t3901-utf8.txt &&
 
 	git reset --hard side &&
@@ -229,8 +229,8 @@ test_expect_success 'rebase --merge (U/L)' '
 
 test_expect_success 'rebase --merge (L/L)' '
 	# In this test we want ISO-8859-1 encoded commits as the result
-	git config i18n.commitencoding ISO-8859-1 &&
-	git config i18n.logoutputencoding ISO-8859-1 &&
+	git config i18n.commitencoding ISO8859-1 &&
+	git config i18n.logoutputencoding ISO8859-1 &&
 	. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
 
 	git reset --hard side &&
@@ -242,7 +242,7 @@ test_expect_success 'rebase --merge (L/L)' '
 test_expect_success 'rebase --merge (L/U)' '
 	# This is pathological -- use UTF-8 as intermediate form
 	# to get ISO-8859-1 results.
-	git config i18n.commitencoding ISO-8859-1 &&
+	git config i18n.commitencoding ISO8859-1 &&
 	git config i18n.logoutputencoding UTF-8 &&
 	. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
 
-- 
1.6.3.1.24.g152f4
