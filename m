Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA45C433FE
	for <git@archiver.kernel.org>; Fri, 26 Nov 2021 22:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245356AbhKZWsf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Nov 2021 17:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245267AbhKZWqX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Nov 2021 17:46:23 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D583AC0613F1
        for <git@vger.kernel.org>; Fri, 26 Nov 2021 14:41:13 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id y196so9246394wmc.3
        for <git@vger.kernel.org>; Fri, 26 Nov 2021 14:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lc7TvF1XSj8/an5Sx4LM6ai9FEMe/WJN/D0Ss50+tg4=;
        b=PULKX5zuYWH+2SIim6JPC+BcC2m40kRibZ2JcbwN1ywvmCKmKhG119yKudDW7pyAAL
         W/cywO6em3t+Jl5Bzb4xDaxlGzUmnGYD6+ekuOKn7ik1IqyYrKBaXhhkQlNRi77dIlPL
         vq33boPI8zaz20EVio94h6x1c01UiRWyDF3pQbjYQ6bowM5MuyGsW/7jdCdHmn0LV524
         AdKk8KHBbHP4JfsU+G5Ia7FqoDiNp0O1ZfzLuA8m9oIqFXcpDZ7ZYleocMqUogNEkDKK
         gZfeOBBoj+u6lYT8bsrbELfSFkyY4YKSD7DUgyuGxaCrd5IKq8vFit7EXS7v9jm/iAYF
         eETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lc7TvF1XSj8/an5Sx4LM6ai9FEMe/WJN/D0Ss50+tg4=;
        b=N2plic7qOHevOuc49ppiQi9fVGAmDM9uI7e1caqfDQsmsGzfPTgr21eAFzszbn73IH
         Zt356bNYvrNlG6Yzf7P9chXXq1O9Pa8DI1iCFkinNzyVBxMfIqTVPlQhL+aXAKpjw7Sl
         N0Ami6qoVsKmvddanc+chpxoL3nZhYQavP9mtBzJhEHPWSNTcVqrF9KaGxRuygdhU8q7
         hItK9xMr2GmYHmDKCYCS5AX6/v1VBljqE97mOYDbvc7wtbXDCDMtGEs4XedvXI82WB0X
         HtMeftoNnZsStus/IA3JcUOT6l8bwddVRPEaHfEWQ4Y1nFOCPVmaCbiMznWAGx8oIuEv
         FQzQ==
X-Gm-Message-State: AOAM533gm7cDtevNGVmMEGNNtDgNl/JkmrB8S8csqZnOOTErlI1m2JoA
        OFusAydgB5LsvHdtP7Ey8rstQNzhBB4=
X-Google-Smtp-Source: ABdhPJxzOL+bMvXrIBSk0DAEZeH4doHu5VmBkno8vRJM4o3iaJApreO40KHI2Mx+QGPeytUkXnM5jg==
X-Received: by 2002:a1c:2685:: with SMTP id m127mr19228526wmm.42.1637966472293;
        Fri, 26 Nov 2021 14:41:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y12sm6715712wrn.73.2021.11.26.14.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 14:41:11 -0800 (PST)
Message-Id: <7eb6281be4b4a1e514719db5c886ab81fe4a5034.1637966463.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com>
References: <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
        <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Nov 2021 22:41:02 +0000
Subject: [PATCH v3 11/11] t2501: simplify the tests since we can now assume
 desired behavior
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

We no longer are dealing with a mixture of previous and desired
behavior, so simplify the tests a bit.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t2501-cwd-empty.sh | 105 +++++++++++--------------------------------
 1 file changed, 27 insertions(+), 78 deletions(-)

diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
index 8f299fd3b19..88e27b16e11 100755
--- a/t/t2501-cwd-empty.sh
+++ b/t/t2501-cwd-empty.sh
@@ -32,9 +32,6 @@ test_expect_success setup '
 '
 
 test_incidental_dir_removal () {
-	works=$1 &&
-	shift &&
-
 	test_when_finished "git reset --hard" &&
 
 	git checkout foo/bar/baz^{commit} &&
@@ -44,81 +41,49 @@ test_incidental_dir_removal () {
 		cd foo &&
 		"$@" &&
 
-		# Although we want pwd & git status to pass, test for existing
-		# rather than desired behavior.
-		if [[ $works == "success" ]]; then
-			pwd -P &&
-			git status --porcelain
-		else
-			! pwd -P &&
-			test_might_fail git status --porcelain
-		fi
+		pwd -P &&
+		git status --porcelain
 	) &&
 	test_path_is_missing foo/bar/baz &&
 	test_path_is_missing foo/bar &&
 
-	# Although we want dir to be present, test for existing rather
-	# than desired behavior.
-	if [[ $works == "success" ]]; then
-		test_path_is_dir foo
-	else
-		test_path_is_missing foo
-	fi
+	test_path_is_dir foo
 }
 
 test_required_dir_removal () {
-	works=$1 &&
-	shift &&
-
 	git checkout df_conflict^{commit} &&
 	test_when_finished "git clean -fdx" &&
 
 	(
 		cd dirORfile &&
 
-		# We'd like for the command to fail (much as it would if there
-		# was an untracked file there), and for pwd & git status to
-		# succeed afterwards.  But test for existing rather than
-		# desired behavior.
-		if [[ $works == "success" ]]; then
-			test_must_fail "$@" 2>../error &&
-			grep "Refusing to remove.*current working directory" ../error &&
-			pwd -P &&
-			git status --porcelain
-		else
-			"$@" &&
-			! pwd -P &&
-			test_might_fail git status --porcelain
-		fi
+		test_must_fail "$@" 2>../error &&
+		grep "Refusing to remove.*current working directory" ../error &&
+		pwd -P &&
+		git status --porcelain
 	) &&
 
-	# Although we want dirORfile to be present, test for existing rather
-	# than desired behavior.
-	if [[ $works == "success" ]]; then
-		test_path_is_dir dirORfile
-	else
-		test_path_is_file dirORfile
-	fi
+	test_path_is_dir dirORfile
 }
 
 test_expect_success 'checkout does not clean cwd incidentally' '
-	test_incidental_dir_removal success git checkout init
+	test_incidental_dir_removal git checkout init
 '
 
 test_expect_success 'checkout fails if cwd needs to be removed' '
-	test_required_dir_removal success git checkout fd_conflict
+	test_required_dir_removal git checkout fd_conflict
 '
 
 test_expect_success 'reset --hard does not clean cwd incidentally' '
-	test_incidental_dir_removal success git reset --hard init
+	test_incidental_dir_removal git reset --hard init
 '
 
 test_expect_success 'reset --hard fails if cwd needs to be removed' '
-	test_required_dir_removal success git reset --hard fd_conflict
+	test_required_dir_removal git reset --hard fd_conflict
 '
 
 test_expect_success 'merge does not clean cwd incidentally' '
-	test_incidental_dir_removal success git merge reverted
+	test_incidental_dir_removal git merge reverted
 '
 
 # This file uses some simple merges where
@@ -147,46 +112,43 @@ test_expect_success 'merge fails if cwd needs to be removed; recursive friendly'
 GIT_TEST_MERGE_ALGORITHM=ort
 
 test_expect_success 'merge fails if cwd needs to be removed' '
-	test_required_dir_removal success git merge fd_conflict
+	test_required_dir_removal git merge fd_conflict
 '
 
 test_expect_success 'cherry-pick does not clean cwd incidentally' '
-	test_incidental_dir_removal success git cherry-pick reverted
+	test_incidental_dir_removal git cherry-pick reverted
 '
 
 test_expect_success 'cherry-pick fails if cwd needs to be removed' '
-	test_required_dir_removal success git cherry-pick fd_conflict
+	test_required_dir_removal git cherry-pick fd_conflict
 '
 
 test_expect_success 'rebase does not clean cwd incidentally' '
-	test_incidental_dir_removal success git rebase reverted
+	test_incidental_dir_removal git rebase reverted
 '
 
 test_expect_success 'rebase fails if cwd needs to be removed' '
-	test_required_dir_removal success git rebase fd_conflict
+	test_required_dir_removal git rebase fd_conflict
 '
 
 test_expect_success 'revert does not clean cwd incidentally' '
-	test_incidental_dir_removal success git revert HEAD
+	test_incidental_dir_removal git revert HEAD
 '
 
 test_expect_success 'revert fails if cwd needs to be removed' '
-	test_required_dir_removal success git revert undo_fd_conflict
+	test_required_dir_removal git revert undo_fd_conflict
 '
 
 test_expect_success 'rm does not clean cwd incidentally' '
-	test_incidental_dir_removal success git rm bar/baz.t
+	test_incidental_dir_removal git rm bar/baz.t
 '
 
 test_expect_success 'apply does not remove cwd incidentally' '
 	git diff HEAD HEAD~1 >patch &&
-	test_incidental_dir_removal success git apply ../patch
+	test_incidental_dir_removal git apply ../patch
 '
 
 test_incidental_untracked_dir_removal () {
-	works=$1 &&
-	shift &&
-
 	test_when_finished "git reset --hard" &&
 
 	git checkout foo/bar/baz^{commit} &&
@@ -198,36 +160,23 @@ test_incidental_untracked_dir_removal () {
 		cd untracked &&
 		"$@" &&
 
-		# Although we want pwd & git status to pass, test for existing
-		# rather than desired behavior.
-		if [[ $works == "success" ]]; then
-			pwd -P &&
-			git status --porcelain
-		else
-			! pwd -P &&
-			test_might_fail git status --porcelain
-		fi
+		pwd -P &&
+		git status --porcelain
 	) &&
 	test_path_is_missing empty &&
 	test_path_is_missing untracked/random &&
 
-	# Although we want dir to be present, test for existing rather
-	# than desired behavior.
-	if [[ $works == "success" ]]; then
-		test_path_is_dir untracked
-	else
-		test_path_is_missing untracked
-	fi
+	test_path_is_dir untracked
 }
 
 test_expect_success 'clean does not remove cwd incidentally' '
-	test_incidental_untracked_dir_removal success \
+	test_incidental_untracked_dir_removal \
 		git -C .. clean -fd -e warnings . >warnings &&
 	grep "Refusing to remove current working directory" warnings
 '
 
 test_expect_success 'stash does not remove cwd incidentally' '
-	test_incidental_untracked_dir_removal success \
+	test_incidental_untracked_dir_removal \
 		git stash --include-untracked
 '
 
-- 
gitgitgadget
