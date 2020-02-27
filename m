Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5D7C4BA34
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 00:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A95624650
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 00:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBx6soLo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgB0AOb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 19:14:31 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42297 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbgB0AOa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 19:14:30 -0500
Received: by mail-wr1-f65.google.com with SMTP id p18so1076659wre.9
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 16:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+5JPc+9mlZajQhoQ80y3gj2AYyhZxZcfXfwXgDdaoRU=;
        b=TBx6soLotutxQIs2HmC7smZVGnvaMvdLg6aFHIDRzy/yDOC6uDyHUeLv1e2f6Mvpu2
         qmSkKFV0YBJW4nIDSLFX3T05U5YEWJOgQsmxY3BtNRqVQ9xfDOJuiPEAcS+vch+KhbRz
         sur564bpqFkJVSu13OWzXnqnsvuWLjemZ928/3HFD+rN0aI6DNHN1BY1pY77h+G8aGsx
         Jz8MxNj2x7XJy7koqlnrJcAolNJ9WDAzBwer021w0SMcI3OYjBtSvuEBocsKbaXLOscx
         Mu3l/GfaDBT/Cq8Tp88nbfInQWgAw676nfESOkigBJdnbqqoeIOKUYyzhfz3w1Uvo5f7
         +3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+5JPc+9mlZajQhoQ80y3gj2AYyhZxZcfXfwXgDdaoRU=;
        b=iMgPjzaLk8PmRdlthjKOuqFh/DH/eJuxRNEXVlWF89EIxFHGmEbhpMpzk3udYZn8eO
         gVlHfPLTfqOQtBH2zUS+OFh1XwTx6vXNqjfeedZLZxj2s4qGq9f4SWktQ+H2OcyEdZAN
         ZV/mmHt+iBnz5xMi3z/q+ipPSWgviKtuFEXngoCnLW4A8lmv/Ct2e2T6zbfYGNq+fYyt
         XosIrYjrIGJa8+2qhq6v9brqOf+p0ou7xRdjrydkptrvoJTODEEGuQViz80kAUWeMboa
         e5I/ghzLAuByqq0JGoQEYzpqwcX/9c7YI8QE8LY+ngosrd/UFMvNxSLTpde9z6+KqfL8
         1mSQ==
X-Gm-Message-State: APjAAAVgqEaHQqQl5v0l6DHSO5MhTvoWQL3FoG23apY+iugDiC60dyTH
        gxaiq+4EUhw9UprHIw34v6R0lD2K
X-Google-Smtp-Source: APXvYqxcmgb8myDdxqAP8N+iIXJYsYdteajjHi9XAi05S7Vha09KvS40Z1FwaRiad6b+sjg/WGzlOw==
X-Received: by 2002:adf:f18e:: with SMTP id h14mr1165145wro.51.1582762467431;
        Wed, 26 Feb 2020 16:14:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o4sm5044828wrx.25.2020.02.26.16.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 16:14:27 -0800 (PST)
Message-Id: <f0fd134c8d0c6a50415d6a74e1f7a508ee2e1209.1582762465.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.716.git.git.1582762465.gitgitgadget@gmail.com>
References: <pull.716.git.git.1582762465.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 Feb 2020 00:14:21 +0000
Subject: [PATCH 2/5] t6020, t6022, t6035: update merge tests to use test
 helper functions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Make use of test_path_is_file, test_write_lines, and similar helpers
in these old test files.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6020-merge-df.sh             | 12 ++++----
 t/t6022-merge-rename.sh         | 54 ++++++++++++++++-----------------
 t/t6035-merge-dir-to-symlink.sh | 28 ++++++++---------
 3 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/t/t6020-merge-df.sh b/t/t6020-merge-df.sh
index 46b506b3b7b..cf662068da1 100755
--- a/t/t6020-merge-df.sh
+++ b/t/t6020-merge-df.sh
@@ -83,9 +83,9 @@ test_expect_success 'modify/delete + directory/file conflict' '
 	test 4 -eq $(git ls-files -u | wc -l) &&
 	test 1 -eq $(git ls-files -o | wc -l) &&
 
-	test -f letters/file &&
-	test -f letters.txt &&
-	test -f letters~modify
+	test_path_is_file letters/file &&
+	test_path_is_file letters.txt &&
+	test_path_is_file letters~modify
 '
 
 test_expect_success 'modify/delete + directory/file conflict; other way' '
@@ -99,9 +99,9 @@ test_expect_success 'modify/delete + directory/file conflict; other way' '
 	test 4 -eq $(git ls-files -u | wc -l) &&
 	test 1 -eq $(git ls-files -o | wc -l) &&
 
-	test -f letters/file &&
-	test -f letters.txt &&
-	test -f letters~HEAD
+	test_path_is_file letters/file &&
+	test_path_is_file letters.txt &&
+	test_path_is_file letters~HEAD
 '
 
 test_done
diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index 1e34e1f48bb..6f196aaf276 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -295,8 +295,8 @@ test_expect_success 'Rename+D/F conflict; renamed file merges + dir not in way'
 	git merge --strategy=recursive dir-not-in-way &&
 
 	git diff --quiet &&
-	test -f dir &&
-	printf "1\n2\n3\n4\n5555\n6\n7\n8\n9\n10\n11\n" >expected &&
+	test_path_is_file dir &&
+	test_write_lines 1 2 3 4 5555 6 7 8 9 10 11 >expected &&
 	test_cmp expected dir
 '
 
@@ -316,8 +316,8 @@ test_expect_success 'Rename+D/F conflict; renamed file merges but dir in way' '
 	test_must_fail git diff --quiet &&
 	test_must_fail git diff --cached --quiet &&
 
-	test -f dir/file-in-the-way &&
-	test -f dir~HEAD &&
+	test_path_is_file dir/file-in-the-way &&
+	test_path_is_file dir~HEAD &&
 	test_cmp expected dir~HEAD
 '
 
@@ -338,8 +338,8 @@ test_expect_success 'Same as previous, but merged other way' '
 	test_must_fail git diff --quiet &&
 	test_must_fail git diff --cached --quiet &&
 
-	test -f dir/file-in-the-way &&
-	test -f dir~renamed-file-has-no-conflicts &&
+	test_path_is_file dir/file-in-the-way &&
+	test_path_is_file dir~renamed-file-has-no-conflicts &&
 	test_cmp expected dir~renamed-file-has-no-conflicts
 '
 
@@ -355,7 +355,7 @@ test_expect_success 'Rename+D/F conflict; renamed file cannot merge, dir not in
 	test_must_fail git diff --quiet &&
 	test_must_fail git diff --cached --quiet &&
 
-	test -f dir &&
+	test_path_is_file dir &&
 	cat >expected <<-\EOF &&
 	1
 	2
@@ -391,8 +391,8 @@ test_expect_success 'Rename+D/F conflict; renamed file cannot merge and dir in t
 	test_must_fail git diff --quiet &&
 	test_must_fail git diff --cached --quiet &&
 
-	test -f dir/file-in-the-way &&
-	test -f dir~HEAD &&
+	test_path_is_file dir/file-in-the-way &&
+	test_path_is_file dir~HEAD &&
 	test_cmp expected dir~HEAD
 '
 
@@ -409,8 +409,8 @@ test_expect_success 'Same as previous, but merged other way' '
 	test_must_fail git diff --quiet &&
 	test_must_fail git diff --cached --quiet &&
 
-	test -f dir/file-in-the-way &&
-	test -f dir~renamed-file-has-conflicts &&
+	test_path_is_file dir/file-in-the-way &&
+	test_path_is_file dir~renamed-file-has-conflicts &&
 	cat >expected <<-\EOF &&
 	1
 	2
@@ -463,9 +463,9 @@ test_expect_success 'both rename source and destination involved in D/F conflict
 
 	test_must_fail git diff --quiet &&
 
-	test -f destdir/foo &&
-	test -f one &&
-	test -f destdir~HEAD &&
+	test_path_is_file destdir/foo &&
+	test_path_is_file one &&
+	test_path_is_file destdir~HEAD &&
 	test "stuff" = "$(cat destdir~HEAD)"
 '
 
@@ -506,9 +506,9 @@ test_expect_success 'pair rename to parent of other (D/F conflicts) w/ untracked
 
 	test 4 -eq $(find . | grep -v .git | wc -l) &&
 
-	test -d one &&
-	test -f one~rename-two &&
-	test -f two &&
+	test_path_is_dir one &&
+	test_path_is_file one~rename-two &&
+	test_path_is_file two &&
 	test "other" = $(cat one~rename-two) &&
 	test "stuff" = $(cat two)
 '
@@ -526,8 +526,8 @@ test_expect_success 'pair rename to parent of other (D/F conflicts) w/ clean sta
 
 	test 3 -eq $(find . | grep -v .git | wc -l) &&
 
-	test -f one &&
-	test -f two &&
+	test_path_is_file one &&
+	test_path_is_file two &&
 	test "other" = $(cat one) &&
 	test "stuff" = $(cat two)
 '
@@ -567,11 +567,11 @@ test_expect_success 'check handling of differently renamed file with D/F conflic
 	test 1 -eq "$(git ls-files -u original | wc -l)" &&
 	test 2 -eq "$(git ls-files -o | wc -l)" &&
 
-	test -f one/file &&
-	test -f two/file &&
-	test -f one~HEAD &&
-	test -f two~second-rename &&
-	! test -f original
+	test_path_is_file one/file &&
+	test_path_is_file two/file &&
+	test_path_is_file one~HEAD &&
+	test_path_is_file two~second-rename &&
+	test_path_is_missing original
 '
 
 test_expect_success 'setup rename one file to two; directories moving out of the way' '
@@ -606,9 +606,9 @@ test_expect_success 'check handling of differently renamed file with D/F conflic
 	test 1 -eq "$(git ls-files -u original | wc -l)" &&
 	test 0 -eq "$(git ls-files -o | wc -l)" &&
 
-	test -f one &&
-	test -f two &&
-	! test -f original
+	test_path_is_file one &&
+	test_path_is_file two &&
+	test_path_is_missing original
 '
 
 test_expect_success 'setup avoid unnecessary update, normal rename' '
diff --git a/t/t6035-merge-dir-to-symlink.sh b/t/t6035-merge-dir-to-symlink.sh
index 9324ea44162..2eddcc7664e 100755
--- a/t/t6035-merge-dir-to-symlink.sh
+++ b/t/t6035-merge-dir-to-symlink.sh
@@ -31,19 +31,19 @@ test_expect_success 'a/b-2/c/d is kept when clobbering symlink b' '
 	git rm --cached a/b &&
 	git commit -m "untracked symlink remains" &&
 	git checkout -f start^0 &&
-	test -f a/b-2/c/d
+	test_path_is_file a/b-2/c/d
 '
 
 test_expect_success 'checkout should not have deleted a/b-2/c/d' '
 	git checkout HEAD^0 &&
 	git reset --hard master &&
 	 git checkout start^0 &&
-	 test -f a/b-2/c/d
+	 test_path_is_file a/b-2/c/d
 '
 
 test_expect_success 'setup for merge test' '
 	git reset --hard &&
-	test -f a/b-2/c/d &&
+	test_path_is_file a/b-2/c/d &&
 	echo x > a/x &&
 	git add a/x &&
 	git commit -m x &&
@@ -54,7 +54,7 @@ test_expect_success 'Handle D/F conflict, do not lose a/b-2/c/d in merge (resolv
 	git reset --hard &&
 	git checkout baseline^0 &&
 	git merge -s resolve master &&
-	test -f a/b-2/c/d
+	test_path_is_file a/b-2/c/d
 '
 
 test_expect_success SYMLINKS 'a/b was resolved as symlink' '
@@ -65,7 +65,7 @@ test_expect_success 'Handle D/F conflict, do not lose a/b-2/c/d in merge (recurs
 	git reset --hard &&
 	git checkout baseline^0 &&
 	git merge -s recursive master &&
-	test -f a/b-2/c/d
+	test_path_is_file a/b-2/c/d
 '
 
 test_expect_success SYMLINKS 'a/b was resolved as symlink' '
@@ -76,7 +76,7 @@ test_expect_success 'Handle F/D conflict, do not lose a/b-2/c/d in merge (resolv
 	git reset --hard &&
 	git checkout master^0 &&
 	git merge -s resolve baseline^0 &&
-	test -f a/b-2/c/d
+	test_path_is_file a/b-2/c/d
 '
 
 test_expect_success SYMLINKS 'a/b was resolved as symlink' '
@@ -87,7 +87,7 @@ test_expect_success 'Handle F/D conflict, do not lose a/b-2/c/d in merge (recurs
 	git reset --hard &&
 	git checkout master^0 &&
 	git merge -s recursive baseline^0 &&
-	test -f a/b-2/c/d
+	test_path_is_file a/b-2/c/d
 '
 
 test_expect_success SYMLINKS 'a/b was resolved as symlink' '
@@ -99,8 +99,8 @@ test_expect_failure 'do not lose untracked in merge (resolve)' '
 	git checkout baseline^0 &&
 	>a/b/c/e &&
 	test_must_fail git merge -s resolve master &&
-	test -f a/b/c/e &&
-	test -f a/b-2/c/d
+	test_path_is_file a/b/c/e &&
+	test_path_is_file a/b-2/c/d
 '
 
 test_expect_success 'do not lose untracked in merge (recursive)' '
@@ -108,8 +108,8 @@ test_expect_success 'do not lose untracked in merge (recursive)' '
 	git checkout baseline^0 &&
 	>a/b/c/e &&
 	test_must_fail git merge -s recursive master &&
-	test -f a/b/c/e &&
-	test -f a/b-2/c/d
+	test_path_is_file a/b/c/e &&
+	test_path_is_file a/b-2/c/d
 '
 
 test_expect_success 'do not lose modifications in merge (resolve)' '
@@ -140,7 +140,7 @@ test_expect_success 'merge should not have D/F conflicts (resolve)' '
 	git reset --hard &&
 	git checkout baseline^0 &&
 	git merge -s resolve test2 &&
-	test -f a/b/c/d
+	test_path_is_file a/b/c/d
 '
 
 test_expect_success SYMLINKS 'a/b-2 was resolved as symlink' '
@@ -151,7 +151,7 @@ test_expect_success 'merge should not have D/F conflicts (recursive)' '
 	git reset --hard &&
 	git checkout baseline^0 &&
 	git merge -s recursive test2 &&
-	test -f a/b/c/d
+	test_path_is_file a/b/c/d
 '
 
 test_expect_success SYMLINKS 'a/b-2 was resolved as symlink' '
@@ -162,7 +162,7 @@ test_expect_success 'merge should not have F/D conflicts (recursive)' '
 	git reset --hard &&
 	git checkout -b foo test2 &&
 	git merge -s recursive baseline^0 &&
-	test -f a/b/c/d
+	test_path_is_file a/b/c/d
 '
 
 test_expect_success SYMLINKS 'a/b-2 was resolved as symlink' '
-- 
gitgitgadget

