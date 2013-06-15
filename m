From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3 2/2] t/am: use test_path_is_missing() where appropriate
Date: Sat, 15 Jun 2013 18:13:12 +0530
Message-ID: <1371300192-6222-3-git-send-email-artagnon@gmail.com>
References: <1371300192-6222-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 15 14:45:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnprO-0001iF-7f
	for gcvg-git-2@plane.gmane.org; Sat, 15 Jun 2013 14:45:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754130Ab3FOMpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jun 2013 08:45:35 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:41798 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754078Ab3FOMpK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jun 2013 08:45:10 -0400
Received: by mail-pb0-f52.google.com with SMTP id xa12so1367477pbc.25
        for <git@vger.kernel.org>; Sat, 15 Jun 2013 05:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=S7r0RK1S8FMX/xrpMwpUF02HGZ/qhJ3bNVZB3v+z/q8=;
        b=WvjDeObJgaN0rw5FNJiNO11/woFpSErfuxMT6ANcnBYwT2YHX7OBnu75iYhuFApgjv
         WEsTgieuoYhJqfYDIYMDEgrQbY+uQonPLfB7aIvZYNahiRTc4HXakSsd2dO2/eGe0iBb
         pHla4BxAXlkQZnLFNgzj2K7oSLJv2i3ph2wfeWA0/VOxOZNUt2mMqw1NrZPyjnNr5mP0
         Uw2m13qTyCYFruJ9ACFqw0IVqZ2ln5Eu6FFco2g2tLQU+wIuABG9EIt2UsbtizII0Wv9
         hHPZbroAWjN+yXFIYbe8qpqwNGSOjatpKAqeI8BG5qUdrMh4/D7bex1rJVdLEc59laL7
         iOVg==
X-Received: by 10.66.83.7 with SMTP id m7mr6360432pay.150.1371300309934;
        Sat, 15 Jun 2013 05:45:09 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id pl9sm6194950pbc.5.2013.06.15.05.45.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 15 Jun 2013 05:45:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.383.g8881048.dirty
In-Reply-To: <1371300192-6222-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227948>

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
1.8.3.1.383.g8881048.dirty
