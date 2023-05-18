Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF192C77B73
	for <git@archiver.kernel.org>; Thu, 18 May 2023 20:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjERUE1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 16:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjERUEK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 16:04:10 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6252B1716
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:03:41 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f420618d5bso16019515e9.1
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684440219; x=1687032219;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X13CbSEPFsVaekiJUpfKoyxpS+t3QC/WUgonTA1XvVY=;
        b=YCNT70Wx2lCVnIMgGKpryWqyUBMF2PBWK686xKSlQwN+FUffjZ5njuwa/rlLnxJuW9
         ZRI81RP5XbYgUpDn216w2mmwa0KrB4BB4T8E0wy55/XbgBirkJoOi7oh6nlFzRw3j1as
         ZTVyObEftXW+3RMazUzrPioGD3XsPYPGhLfbIZEgaNlM9dzif0VNFtihVPkyXgDpZD80
         iQ7YxTf+tFI2FPqA8iQCkThQ9sMNdeaQDrH+dHKIEmX0EdRyRSHWxBAqAkpC3xW/dOCN
         dZKjJeKUzIFakF62PoZHtuVIwYyT1ihDjwDVl4f/wqEUyVH9R3m6QZ5maBnJ16YxtVvg
         9etQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684440219; x=1687032219;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X13CbSEPFsVaekiJUpfKoyxpS+t3QC/WUgonTA1XvVY=;
        b=QIQqUwsdIBpjATJ+3/9BugqomCqviRnC3+nLwkY74xNlnAUuhjNzybgfnfNf4Iky1M
         8Ut2b1feZa0K2/X1pln4e43mTokq2uGAk4rLCRh0bN20/fQfxxy1Kd6ah4zot6sdMkIh
         bDnAgSRdmICjuZtkmvNMR71zeviO8bN33cI+VK6bfGZf2ksn9ODS2QWXlrhBZl4p3bn3
         f26Pl7vA+XW1dvtZCaLreSVDilzr+KJuR1oJY3dVPuCAEDqMbGzw79n6YfsP9m+eOoZX
         jBAh1oyIKgfwf9ZO7f7/b/SLwfHhh5Sx8IO+ogNvfAoeH8YsG+z7PC5LAu2vL02Ngwx4
         AmTQ==
X-Gm-Message-State: AC+VfDyfavQRkLwbmajy6hdPbxkTx/dbA5z7LR3LIWKyTx1r9Pc0Ph12
        6PqGXj/kEGxB+0MyGWJzknnH+O6Lo1A=
X-Google-Smtp-Source: ACHHUZ4oPAZVQJnlhnLXw52fBY5CmhekR8pGfq653ImGzG8jDND+NAd9jHVeBG53LiTjmqXbAU8U1w==
X-Received: by 2002:a7b:c7ce:0:b0:3f4:2158:68ae with SMTP id z14-20020a7bc7ce000000b003f4215868aemr2301876wmk.15.1684440219492;
        Thu, 18 May 2023 13:03:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y9-20020a05600c364900b003f4266965fbsm250046wmq.5.2023.05.18.13.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 13:03:39 -0700 (PDT)
Message-Id: <3ddb6dbe9d5b2bbede84e389e57a33ded8bc7b3f.1684440206.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1513.git.git.1684440205.gitgitgadget@gmail.com>
References: <pull.1513.git.git.1684440205.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 May 2023 20:03:24 +0000
Subject: [PATCH 19/20] t6050-replace: modernize test format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Some tests still use the old format with four spaces indentation.
Standardize the tests to the new format with tab indentation.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t6050-replace.sh | 296 ++++++++++++++++++++++-----------------------
 1 file changed, 148 insertions(+), 148 deletions(-)

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index 2500acc2ef8..c9925edf20e 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -62,59 +62,59 @@ HASH6=
 HASH7=
 
 test_expect_success 'set up buggy branch' '
-     echo "line 1" >>hello &&
-     echo "line 2" >>hello &&
-     echo "line 3" >>hello &&
-     echo "line 4" >>hello &&
-     add_and_commit_file hello "4 lines" &&
-     HASH1=$(git rev-parse --verify HEAD) &&
-     echo "line BUG" >>hello &&
-     echo "line 6" >>hello &&
-     echo "line 7" >>hello &&
-     echo "line 8" >>hello &&
-     add_and_commit_file hello "4 more lines with a BUG" &&
-     HASH2=$(git rev-parse --verify HEAD) &&
-     echo "line 9" >>hello &&
-     echo "line 10" >>hello &&
-     add_and_commit_file hello "2 more lines" &&
-     HASH3=$(git rev-parse --verify HEAD) &&
-     echo "line 11" >>hello &&
-     add_and_commit_file hello "1 more line" &&
-     HASH4=$(git rev-parse --verify HEAD) &&
-     sed -e "s/BUG/5/" hello >hello.new &&
-     mv hello.new hello &&
-     add_and_commit_file hello "BUG fixed" &&
-     HASH5=$(git rev-parse --verify HEAD) &&
-     echo "line 12" >>hello &&
-     echo "line 13" >>hello &&
-     add_and_commit_file hello "2 more lines" &&
-     HASH6=$(git rev-parse --verify HEAD) &&
-     echo "line 14" >>hello &&
-     echo "line 15" >>hello &&
-     echo "line 16" >>hello &&
-     add_and_commit_file hello "again 3 more lines" &&
-     HASH7=$(git rev-parse --verify HEAD)
+	echo "line 1" >>hello &&
+	echo "line 2" >>hello &&
+	echo "line 3" >>hello &&
+	echo "line 4" >>hello &&
+	add_and_commit_file hello "4 lines" &&
+	HASH1=$(git rev-parse --verify HEAD) &&
+	echo "line BUG" >>hello &&
+	echo "line 6" >>hello &&
+	echo "line 7" >>hello &&
+	echo "line 8" >>hello &&
+	add_and_commit_file hello "4 more lines with a BUG" &&
+	HASH2=$(git rev-parse --verify HEAD) &&
+	echo "line 9" >>hello &&
+	echo "line 10" >>hello &&
+	add_and_commit_file hello "2 more lines" &&
+	HASH3=$(git rev-parse --verify HEAD) &&
+	echo "line 11" >>hello &&
+	add_and_commit_file hello "1 more line" &&
+	HASH4=$(git rev-parse --verify HEAD) &&
+	sed -e "s/BUG/5/" hello >hello.new &&
+	mv hello.new hello &&
+	add_and_commit_file hello "BUG fixed" &&
+	HASH5=$(git rev-parse --verify HEAD) &&
+	echo "line 12" >>hello &&
+	echo "line 13" >>hello &&
+	add_and_commit_file hello "2 more lines" &&
+	HASH6=$(git rev-parse --verify HEAD) &&
+	echo "line 14" >>hello &&
+	echo "line 15" >>hello &&
+	echo "line 16" >>hello &&
+	add_and_commit_file hello "again 3 more lines" &&
+	HASH7=$(git rev-parse --verify HEAD)
 '
 
 test_expect_success 'replace the author' '
-     git cat-file commit $HASH2 | grep "author A U Thor" &&
-     R=$(git cat-file commit $HASH2 | sed -e "s/A U/O/" | git hash-object -t commit --stdin -w) &&
-     git cat-file commit $R | grep "author O Thor" &&
-     git update-ref refs/replace/$HASH2 $R &&
-     git show HEAD~5 | grep "O Thor" &&
-     git show $HASH2 | grep "O Thor"
+	git cat-file commit $HASH2 | grep "author A U Thor" &&
+	R=$(git cat-file commit $HASH2 | sed -e "s/A U/O/" | git hash-object -t commit --stdin -w) &&
+	git cat-file commit $R | grep "author O Thor" &&
+	git update-ref refs/replace/$HASH2 $R &&
+	git show HEAD~5 | grep "O Thor" &&
+	git show $HASH2 | grep "O Thor"
 '
 
 test_expect_success 'test --no-replace-objects option' '
-     git cat-file commit $HASH2 | grep "author O Thor" &&
-     git --no-replace-objects cat-file commit $HASH2 | grep "author A U Thor" &&
-     git show $HASH2 | grep "O Thor" &&
-     git --no-replace-objects show $HASH2 | grep "A U Thor"
+	git cat-file commit $HASH2 | grep "author O Thor" &&
+	git --no-replace-objects cat-file commit $HASH2 | grep "author A U Thor" &&
+	git show $HASH2 | grep "O Thor" &&
+	git --no-replace-objects show $HASH2 | grep "A U Thor"
 '
 
 test_expect_success 'test GIT_NO_REPLACE_OBJECTS env variable' '
-     GIT_NO_REPLACE_OBJECTS=1 git cat-file commit $HASH2 | grep "author A U Thor" &&
-     GIT_NO_REPLACE_OBJECTS=1 git show $HASH2 | grep "A U Thor"
+	GIT_NO_REPLACE_OBJECTS=1 git cat-file commit $HASH2 | grep "author A U Thor" &&
+	GIT_NO_REPLACE_OBJECTS=1 git show $HASH2 | grep "A U Thor"
 '
 
 test_expect_success 'test core.usereplacerefs config option' '
@@ -132,64 +132,64 @@ tagger T A Gger <> 0 +0000
 EOF
 
 test_expect_success 'tag replaced commit' '
-     git update-ref refs/tags/mytag $(git mktag <tag.sig)
+	git update-ref refs/tags/mytag $(git mktag <tag.sig)
 '
 
 test_expect_success '"git fsck" works' '
-     git fsck main >fsck_main.out &&
-     test_i18ngrep "dangling commit $R" fsck_main.out &&
-     test_i18ngrep "dangling tag $(git show-ref -s refs/tags/mytag)" fsck_main.out &&
-     test -z "$(git fsck)"
+	git fsck main >fsck_main.out &&
+	test_i18ngrep "dangling commit $R" fsck_main.out &&
+	test_i18ngrep "dangling tag $(git show-ref -s refs/tags/mytag)" fsck_main.out &&
+	test -z "$(git fsck)"
 '
 
 test_expect_success 'repack, clone and fetch work' '
-     git repack -a -d &&
-     git clone --no-hardlinks . clone_dir &&
-     (
-	  cd clone_dir &&
-	  git show HEAD~5 | grep "A U Thor" &&
-	  git show $HASH2 | grep "A U Thor" &&
-	  git cat-file commit $R &&
-	  git repack -a -d &&
-	  test_must_fail git cat-file commit $R &&
-	  git fetch ../ "refs/replace/*:refs/replace/*" &&
-	  git show HEAD~5 | grep "O Thor" &&
-	  git show $HASH2 | grep "O Thor" &&
-	  git cat-file commit $R
-     )
+	git repack -a -d &&
+	git clone --no-hardlinks . clone_dir &&
+	(
+		cd clone_dir &&
+		git show HEAD~5 | grep "A U Thor" &&
+		git show $HASH2 | grep "A U Thor" &&
+		git cat-file commit $R &&
+		git repack -a -d &&
+		test_must_fail git cat-file commit $R &&
+		git fetch ../ "refs/replace/*:refs/replace/*" &&
+		git show HEAD~5 | grep "O Thor" &&
+		git show $HASH2 | grep "O Thor" &&
+		git cat-file commit $R
+	)
 '
 
 test_expect_success '"git replace" listing and deleting' '
-     test "$HASH2" = "$(git replace -l)" &&
-     test "$HASH2" = "$(git replace)" &&
-     aa=${HASH2%??????????????????????????????????????} &&
-     test "$HASH2" = "$(git replace --list "$aa*")" &&
-     test_must_fail git replace -d $R &&
-     test_must_fail git replace --delete &&
-     test_must_fail git replace -l -d $HASH2 &&
-     git replace -d $HASH2 &&
-     git show $HASH2 | grep "A U Thor" &&
-     test -z "$(git replace -l)"
+	test "$HASH2" = "$(git replace -l)" &&
+	test "$HASH2" = "$(git replace)" &&
+	aa=${HASH2%??????????????????????????????????????} &&
+	test "$HASH2" = "$(git replace --list "$aa*")" &&
+	test_must_fail git replace -d $R &&
+	test_must_fail git replace --delete &&
+	test_must_fail git replace -l -d $HASH2 &&
+	git replace -d $HASH2 &&
+	git show $HASH2 | grep "A U Thor" &&
+	test -z "$(git replace -l)"
 '
 
 test_expect_success '"git replace" replacing' '
-     git replace $HASH2 $R &&
-     git show $HASH2 | grep "O Thor" &&
-     test_must_fail git replace $HASH2 $R &&
-     git replace -f $HASH2 $R &&
-     test_must_fail git replace -f &&
-     test "$HASH2" = "$(git replace)"
+	git replace $HASH2 $R &&
+	git show $HASH2 | grep "O Thor" &&
+	test_must_fail git replace $HASH2 $R &&
+	git replace -f $HASH2 $R &&
+	test_must_fail git replace -f &&
+	test "$HASH2" = "$(git replace)"
 '
 
 test_expect_success '"git replace" resolves sha1' '
-     SHORTHASH2=$(git rev-parse --short=8 $HASH2) &&
-     git replace -d $SHORTHASH2 &&
-     git replace $SHORTHASH2 $R &&
-     git show $HASH2 | grep "O Thor" &&
-     test_must_fail git replace $HASH2 $R &&
-     git replace -f $HASH2 $R &&
-     test_must_fail git replace --force &&
-     test "$HASH2" = "$(git replace)"
+	SHORTHASH2=$(git rev-parse --short=8 $HASH2) &&
+	git replace -d $SHORTHASH2 &&
+	git replace $SHORTHASH2 $R &&
+	git show $HASH2 | grep "O Thor" &&
+	test_must_fail git replace $HASH2 $R &&
+	git replace -f $HASH2 $R &&
+	test_must_fail git replace --force &&
+	test "$HASH2" = "$(git replace)"
 '
 
 # This creates a side branch where the bug in H2
@@ -207,79 +207,79 @@ test_expect_success '"git replace" resolves sha1' '
 # Then we replace H6 with P6.
 #
 test_expect_success 'create parallel branch without the bug' '
-     git replace -d $HASH2 &&
-     git show $HASH2 | grep "A U Thor" &&
-     git checkout $HASH1 &&
-     git cherry-pick $HASH2 &&
-     git show $HASH5 | git apply &&
-     git commit --amend -m "hello: 4 more lines WITHOUT the bug" hello &&
-     PARA2=$(git rev-parse --verify HEAD) &&
-     git cherry-pick $HASH3 &&
-     PARA3=$(git rev-parse --verify HEAD) &&
-     git cherry-pick $HASH4 &&
-     PARA4=$(git rev-parse --verify HEAD) &&
-     git cherry-pick $HASH6 &&
-     PARA6=$(git rev-parse --verify HEAD) &&
-     git replace $HASH6 $PARA6 &&
-     git checkout main &&
-     cur=$(git rev-parse --verify HEAD) &&
-     test "$cur" = "$HASH7" &&
-     git log --pretty=oneline | grep $PARA2 &&
-     git remote add cloned ./clone_dir
+	git replace -d $HASH2 &&
+	git show $HASH2 | grep "A U Thor" &&
+	git checkout $HASH1 &&
+	git cherry-pick $HASH2 &&
+	git show $HASH5 | git apply &&
+	git commit --amend -m "hello: 4 more lines WITHOUT the bug" hello &&
+	PARA2=$(git rev-parse --verify HEAD) &&
+	git cherry-pick $HASH3 &&
+	PARA3=$(git rev-parse --verify HEAD) &&
+	git cherry-pick $HASH4 &&
+	PARA4=$(git rev-parse --verify HEAD) &&
+	git cherry-pick $HASH6 &&
+	PARA6=$(git rev-parse --verify HEAD) &&
+	git replace $HASH6 $PARA6 &&
+	git checkout main &&
+	cur=$(git rev-parse --verify HEAD) &&
+	test "$cur" = "$HASH7" &&
+	git log --pretty=oneline | grep $PARA2 &&
+	git remote add cloned ./clone_dir
 '
 
 test_expect_success 'push to cloned repo' '
-     git push cloned $HASH6^:refs/heads/parallel &&
-     (
-	  cd clone_dir &&
-	  git checkout parallel &&
-	  git log --pretty=oneline | grep $PARA2
-     )
+	git push cloned $HASH6^:refs/heads/parallel &&
+	(
+		cd clone_dir &&
+		git checkout parallel &&
+		git log --pretty=oneline | grep $PARA2
+	)
 '
 
 test_expect_success 'push branch with replacement' '
-     git cat-file commit $PARA3 | grep "author A U Thor" &&
-     S=$(git cat-file commit $PARA3 | sed -e "s/A U/O/" | git hash-object -t commit --stdin -w) &&
-     git cat-file commit $S | grep "author O Thor" &&
-     git replace $PARA3 $S &&
-     git show $HASH6~2 | grep "O Thor" &&
-     git show $PARA3 | grep "O Thor" &&
-     git push cloned $HASH6^:refs/heads/parallel2 &&
-     (
-	  cd clone_dir &&
-	  git checkout parallel2 &&
-	  git log --pretty=oneline | grep $PARA3 &&
-	  git show $PARA3 | grep "A U Thor"
-     )
+	git cat-file commit $PARA3 | grep "author A U Thor" &&
+	S=$(git cat-file commit $PARA3 | sed -e "s/A U/O/" | git hash-object -t commit --stdin -w) &&
+	git cat-file commit $S | grep "author O Thor" &&
+	git replace $PARA3 $S &&
+	git show $HASH6~2 | grep "O Thor" &&
+	git show $PARA3 | grep "O Thor" &&
+	git push cloned $HASH6^:refs/heads/parallel2 &&
+	(
+		cd clone_dir &&
+		git checkout parallel2 &&
+		git log --pretty=oneline | grep $PARA3 &&
+		git show $PARA3 | grep "A U Thor"
+	)
 '
 
 test_expect_success 'fetch branch with replacement' '
-     git branch tofetch $HASH6 &&
-     (
-	  cd clone_dir &&
-	  git fetch origin refs/heads/tofetch:refs/heads/parallel3 &&
-	  git log --pretty=oneline parallel3 >output.txt &&
-	  ! grep $PARA3 output.txt &&
-	  git show $PARA3 >para3.txt &&
-	  grep "A U Thor" para3.txt &&
-	  git fetch origin "refs/replace/*:refs/replace/*" &&
-	  git log --pretty=oneline parallel3 >output.txt &&
-	  grep $PARA3 output.txt &&
-	  git show $PARA3 >para3.txt &&
-	  grep "O Thor" para3.txt
-     )
+	git branch tofetch $HASH6 &&
+	(
+		cd clone_dir &&
+		git fetch origin refs/heads/tofetch:refs/heads/parallel3 &&
+		git log --pretty=oneline parallel3 >output.txt &&
+		! grep $PARA3 output.txt &&
+		git show $PARA3 >para3.txt &&
+		grep "A U Thor" para3.txt &&
+		git fetch origin "refs/replace/*:refs/replace/*" &&
+		git log --pretty=oneline parallel3 >output.txt &&
+		grep $PARA3 output.txt &&
+		git show $PARA3 >para3.txt &&
+		grep "O Thor" para3.txt
+	)
 '
 
 test_expect_success 'bisect and replacements' '
-     git bisect start $HASH7 $HASH1 &&
-     test "$PARA3" = "$(git rev-parse --verify HEAD)" &&
-     git bisect reset &&
-     GIT_NO_REPLACE_OBJECTS=1 git bisect start $HASH7 $HASH1 &&
-     test "$HASH4" = "$(git rev-parse --verify HEAD)" &&
-     git bisect reset &&
-     git --no-replace-objects bisect start $HASH7 $HASH1 &&
-     test "$HASH4" = "$(git rev-parse --verify HEAD)" &&
-     git bisect reset
+	git bisect start $HASH7 $HASH1 &&
+	test "$PARA3" = "$(git rev-parse --verify HEAD)" &&
+	git bisect reset &&
+	GIT_NO_REPLACE_OBJECTS=1 git bisect start $HASH7 $HASH1 &&
+	test "$HASH4" = "$(git rev-parse --verify HEAD)" &&
+	git bisect reset &&
+	git --no-replace-objects bisect start $HASH7 $HASH1 &&
+	test "$HASH4" = "$(git rev-parse --verify HEAD)" &&
+	git bisect reset
 '
 
 test_expect_success 'index-pack and replacements' '
-- 
gitgitgadget

