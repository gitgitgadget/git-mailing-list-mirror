From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/2] t/am: use test_path_is_missing() where appropriate
Date: Fri, 14 Jun 2013 13:17:38 +0530
Message-ID: <1371196058-23948-3-git-send-email-artagnon@gmail.com>
References: <1371196058-23948-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 14 09:46:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnOht-0004O6-RH
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 09:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752271Ab3FNHpy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 03:45:54 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:51498 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239Ab3FNHpx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 03:45:53 -0400
Received: by mail-pd0-f180.google.com with SMTP id 10so318965pdi.25
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 00:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=g3iBrdU6KB2u1at0FZyMbblMTfF7mP/wit7qo1jsY2c=;
        b=mMRF6hclR5QiTDfJloKRY9mlFrkXEz3XMRo5I2vC+6knZc+/ETbaggqtqslaZ6nwZE
         KZ8u9Gc0Xf0xaMrR+oI2s3nL6QmWQYkWihKJqN2Lex7RDdL6HnQqB2kblJ2n3E8t4UGl
         Unb4IrS5yya9WTili0DmjdqgM5g9kmYrgwluI6sXXL29p2qBmKOw/gt/IyhIf0l2OqcR
         qfvo7Za4Ph9VopvLzqHoDxMorCZLv57V5Kj5AocV0pNIzPyp+1CyiRmJhTnlDESpB3j7
         6BiK6JBG9ENA9MjEkTkg8kzk9PD9j4cEx97PGolG3wQPeIIwiF88FS4zZVDIauoBvWAF
         7yKQ==
X-Received: by 10.66.155.199 with SMTP id vy7mr1350327pab.69.1371195952612;
        Fri, 14 Jun 2013 00:45:52 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id fn9sm1413129pab.2.2013.06.14.00.45.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 14 Jun 2013 00:45:51 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.380.g67e7d64.dirty
In-Reply-To: <1371196058-23948-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227793>

Replace instances of ! test -d with test_path_is_missing.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t4150-am.sh | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 6c2cc3e..5edb79a 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -147,7 +147,7 @@ test_expect_success 'am applies patch correctly' '
 	git checkout first &&
 	test_tick &&
 	git am <patch1 &&
-	! test -d .git/rebase-apply &&
+	test_path_is_missing .git/rebase-apply &&
 	git diff --exit-code second &&
 	test "$(git rev-parse second)" = "$(git rev-parse HEAD)" &&
 	test "$(git rev-parse second^)" = "$(git rev-parse HEAD^)"
@@ -158,7 +158,7 @@ test_expect_success 'am applies patch e-mail not in a mbox' '
 	git reset --hard &&
 	git checkout first &&
 	git am patch1.eml &&
-	! test -d .git/rebase-apply &&
+	test_path_is_missing .git/rebase-apply &&
 	git diff --exit-code second &&
 	test "$(git rev-parse second)" = "$(git rev-parse HEAD)" &&
 	test "$(git rev-parse second^)" = "$(git rev-parse HEAD^)"
@@ -169,7 +169,7 @@ test_expect_success 'am applies patch e-mail not in a mbox with CRLF' '
 	git reset --hard &&
 	git checkout first &&
 	git am patch1-crlf.eml &&
-	! test -d .git/rebase-apply &&
+	test_path_is_missing .git/rebase-apply &&
 	git diff --exit-code second &&
 	test "$(git rev-parse second)" = "$(git rev-parse HEAD)" &&
 	test "$(git rev-parse second^)" = "$(git rev-parse HEAD^)"
@@ -180,7 +180,7 @@ test_expect_success 'am applies patch e-mail with preceding whitespace' '
 	git reset --hard &&
 	git checkout first &&
 	git am patch1-ws.eml &&
-	! test -d .git/rebase-apply &&
+	test_path_is_missing .git/rebase-apply &&
 	git diff --exit-code second &&
 	test "$(git rev-parse second)" = "$(git rev-parse HEAD)" &&
 	test "$(git rev-parse second^)" = "$(git rev-parse HEAD^)"
@@ -206,7 +206,7 @@ test_expect_success 'am changes committer and keeps author' '
 	git reset --hard &&
 	git checkout first &&
 	git am patch2 &&
-	! test -d .git/rebase-apply &&
+	test_path_is_missing .git/rebase-apply &&
 	test "$(git rev-parse master^^)" = "$(git rev-parse HEAD^^)" &&
 	git diff --exit-code master..HEAD &&
 	git diff --exit-code master^..HEAD^ &&
@@ -258,7 +258,7 @@ test_expect_success 'am --keep really keeps the subject' '
 	git reset --hard &&
 	git checkout HEAD^ &&
 	git am --keep patch4 &&
-	! test -d .git/rebase-apply &&
+	test_path_is_missing .git/rebase-apply &&
 	git cat-file commit HEAD >actual &&
 	grep "Re: Re: Re: \[PATCH 1/5 v2\] \[foo\] third" actual
 '
@@ -268,7 +268,7 @@ test_expect_success 'am --keep-non-patch really keeps the non-patch part' '
 	git reset --hard &&
 	git checkout HEAD^ &&
 	git am --keep-non-patch patch4 &&
-	! test -d .git/rebase-apply &&
+	test_path_is_missing .git/rebase-apply &&
 	git cat-file commit HEAD >actual &&
 	grep "^\[foo\] third" actual
 '
@@ -283,7 +283,7 @@ test_expect_success 'am -3 falls back to 3-way merge' '
 	test_tick &&
 	git commit -m "copied stuff" &&
 	git am -3 lorem-move.patch &&
-	! test -d .git/rebase-apply &&
+	test_path_is_missing .git/rebase-apply &&
 	git diff --exit-code lorem
 '
 
@@ -297,7 +297,7 @@ test_expect_success 'am -3 -p0 can read --no-prefix patch' '
 	test_tick &&
 	git commit -m "copied stuff" &&
 	git am -3 -p0 lorem-zero.patch &&
-	! test -d .git/rebase-apply &&
+	test_path_is_missing .git/rebase-apply &&
 	git diff --exit-code lorem
 '
 
@@ -307,7 +307,7 @@ test_expect_success 'am can rename a file' '
 	git reset --hard &&
 	git checkout lorem^0 &&
 	git am rename.patch &&
-	! test -d .git/rebase-apply &&
+	test_path_is_missing .git/rebase-apply &&
 	git update-index --refresh &&
 	git diff --exit-code rename
 '
@@ -318,7 +318,7 @@ test_expect_success 'am -3 can rename a file' '
 	git reset --hard &&
 	git checkout lorem^0 &&
 	git am -3 rename.patch &&
-	! test -d .git/rebase-apply &&
+	test_path_is_missing .git/rebase-apply &&
 	git update-index --refresh &&
 	git diff --exit-code rename
 '
@@ -329,7 +329,7 @@ test_expect_success 'am -3 can rename a file after falling back to 3-way merge'
 	git reset --hard &&
 	git checkout lorem^0 &&
 	git am -3 rename-add.patch &&
-	! test -d .git/rebase-apply &&
+	test_path_is_missing .git/rebase-apply &&
 	git update-index --refresh &&
 	git diff --exit-code rename
 '
@@ -358,7 +358,7 @@ test_expect_success 'am pauses on conflict' '
 test_expect_success 'am --skip works' '
 	echo goodbye >expected &&
 	git am --skip &&
-	! test -d .git/rebase-apply &&
+	test_path_is_missing .git/rebase-apply &&
 	git diff --exit-code lorem2^^ -- file &&
 	test_cmp expected another
 '
@@ -379,7 +379,7 @@ test_expect_success 'am --resolved works' '
 	echo resolved >>file &&
 	git add file &&
 	git am --resolved &&
-	! test -d .git/rebase-apply &&
+	test_path_is_missing .git/rebase-apply &&
 	test_cmp expected another
 '
 
@@ -388,7 +388,7 @@ test_expect_success 'am takes patches from a Pine mailbox' '
 	git reset --hard &&
 	git checkout first &&
 	cat pine patch1 | git am &&
-	! test -d .git/rebase-apply &&
+	test_path_is_missing .git/rebase-apply &&
 	git diff --exit-code master^..HEAD
 '
 
@@ -397,7 +397,7 @@ test_expect_success 'am fails on mail without patch' '
 	git reset --hard &&
 	test_must_fail git am <failmail &&
 	git am --abort &&
-	! test -d .git/rebase-apply
+	test_path_is_missing .git/rebase-apply
 '
 
 test_expect_success 'am fails on empty patch' '
@@ -406,7 +406,7 @@ test_expect_success 'am fails on empty patch' '
 	echo "---" >>failmail &&
 	test_must_fail git am <failmail &&
 	git am --skip &&
-	! test -d .git/rebase-apply
+	test_path_is_missing .git/rebase-apply
 '
 
 test_expect_success 'am works from stdin in subdirectory' '
-- 
1.8.3.1.380.g67e7d64.dirty
