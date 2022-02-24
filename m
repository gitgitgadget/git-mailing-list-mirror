Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76C2C433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 10:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbiBXKJj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 05:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbiBXKJg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 05:09:36 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3579C28A120
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 02:08:58 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id b9-20020a17090aa58900b001b8b14b4aabso1155739pjq.9
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 02:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bav4/cQIrIBkAQqQ2XU5cOLEdpDsTHrsRwskRe9HtGw=;
        b=ORbhE7h5PM/UxWVskDAizjwYoN7HvQFYJiVFSuN5TdBtQPcLPUyTW7B5wKKf83azy2
         2ZaSek5/XbPGRiizKL45a1WEOrhk0ER8yPkGRM/6h3SWfRSB5XSyApCRh7jEEp9nPsXr
         CCuTHAMbjF1zW4Hd65xsQfYO9Xwge7QcW1M/0OT713HaFJCaqkPvt9Ap//Il7n9oH3rd
         Wri8HTbcSpFqmYvCZTCmNzm1xuUCy+oKNihFct5kjgjTZkGUR8E05TbR+NMOMSGkHqjS
         +eYlzl/s2F+ej6oF55rKJh9t2J9HzVCrW45/zTzXhHIAaBRW5GLtHlCWvKQU+mpPJvWU
         e8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bav4/cQIrIBkAQqQ2XU5cOLEdpDsTHrsRwskRe9HtGw=;
        b=qrKXgAB7yfYPU2YtmzqYOYVSqxK/PEYNU0C0izYLAlqsOzUCEeFUUYBWHu20DV0z1J
         s+ATJAYo+AA+6Ml6ybZBMJFnKUwX2638t6T/j8LE+Vj5/buFl/2A5dBojHAW2P3UwsgD
         Nj4O1oANx4jwvEIN/A0hB8tzaC1MqoLV+cDOdL+5RBUlNXnvabfCS4MfImibpRnDlBgq
         NINNVs4hSyL6hRd0QhoMVoSB5cMXbyEEeE2/6NN1idOpe/Mpvp90iqk49XEz1qfvDKdP
         tuLrc27a/9+Lk+YCq54maHqdXYn8jB3uegd458rBm4/WPQHi0mGRz2u0lFeXFs+eL8h6
         FnRw==
X-Gm-Message-State: AOAM533k5lt40caJl7F8j7frqzMyep+kMpKQA2y8VURNntmnwcP8xRIn
        MLN2JrmP2QyIPNbyK+iiVqoVXXLlD/Co+HXdLDvft3utDyOghJHEYhP0E7xDZNHI28c3S/TjfIl
        rwLsRrrAKUX3UV9klS2lndXRHM+BczmC1C9vCF1s0REm9PwxRORr+lP1HPla+Yuc=
X-Google-Smtp-Source: ABdhPJyge+k9qIoDdJwLQwP7hYXdWBBuaLdEZuKS0kiPcGoUvmBC5/bhAEvMAZ9hBSppAGoEdNSW4TOMVXIbCQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:3d0f:b0:1bb:80e9:3b45 with SMTP
 id h15-20020a17090a3d0f00b001bb80e93b45mr2020087pjc.31.1645697337633; Thu, 24
 Feb 2022 02:08:57 -0800 (PST)
Date:   Thu, 24 Feb 2022 18:08:35 +0800
In-Reply-To: <20220224100842.95827-1-chooglen@google.com>
Message-Id: <20220224100842.95827-4-chooglen@google.com>
Mime-Version: 1.0
References: <20220215172318.73533-1-chooglen@google.com> <20220224100842.95827-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH v3 03/10] t5526: create superproject commits with test helper
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A few tests in t5526 use this pattern as part of their setup:

1. Create new commits in the upstream submodules (using
   add_upstream_commit()).
2. In the upstream superprojects, add the new submodule commits from the
   previous step.

A future commit will add more tests with this pattern, so reduce the
verbosity of present and future tests by introducing a test helper that
creates superproject commits. Since we now have two helpers that add
upstream commits, rename add_upstream_commit() to
add_submodule_commits().

Signed-off-by: Glen Choo <chooglen@google.com>
---
 t/t5526-fetch-submodules.sh | 94 +++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 50 deletions(-)

diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index a3890e2f6c..ee4dd5a4a9 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -43,7 +43,7 @@ check_super() {
 # a file that contains the expected err if that new commit were fetched.
 # These output files get concatenated in the right order by
 # verify_fetch_result().
-add_upstream_commit() {
+add_submodule_commits() {
 	(
 		cd submodule &&
 		echo new >> subfile &&
@@ -64,6 +64,30 @@ add_upstream_commit() {
 	)
 }
 
+# For each superproject in the test setup, update its submodule, add the
+# submodule and create a new commit with the submodule change.
+#
+# This requires add_submodule_commits() to be called first, otherwise
+# the submodules will not have changed and cannot be "git add"-ed.
+add_superproject_commits() {
+(
+	cd submodule &&
+	(
+		cd subdir/deepsubmodule &&
+		git fetch &&
+		git checkout -q FETCH_HEAD
+	) &&
+		git add subdir/deepsubmodule &&
+		git commit -m "new deep submodule"
+	) &&
+	git add submodule &&
+	git commit -m "new submodule" &&
+	super_head=$(git rev-parse --short HEAD) &&
+	sub_head=$(git -C submodule rev-parse --short HEAD) &&
+	check_super $super_head &&
+	check_sub $sub_head
+}
+
 # Verifies that the expected repositories were fetched. This is done by
 # concatenating the files expect.err.[super|sub|deep] in the correct
 # order and comparing it to the actual stderr.
@@ -117,7 +141,7 @@ test_expect_success setup '
 '
 
 test_expect_success "fetch --recurse-submodules recurses into submodules" '
-	add_upstream_commit &&
+	add_submodule_commits &&
 	(
 		cd downstream &&
 		git fetch --recurse-submodules >../actual.out 2>../actual.err
@@ -127,7 +151,7 @@ test_expect_success "fetch --recurse-submodules recurses into submodules" '
 '
 
 test_expect_success "submodule.recurse option triggers recursive fetch" '
-	add_upstream_commit &&
+	add_submodule_commits &&
 	(
 		cd downstream &&
 		git -c submodule.recurse fetch >../actual.out 2>../actual.err
@@ -137,7 +161,7 @@ test_expect_success "submodule.recurse option triggers recursive fetch" '
 '
 
 test_expect_success "fetch --recurse-submodules -j2 has the same output behaviour" '
-	add_upstream_commit &&
+	add_submodule_commits &&
 	(
 		cd downstream &&
 		GIT_TRACE="$TRASH_DIRECTORY/trace.out" git fetch --recurse-submodules -j2 2>../actual.err
@@ -148,7 +172,7 @@ test_expect_success "fetch --recurse-submodules -j2 has the same output behaviou
 '
 
 test_expect_success "fetch alone only fetches superproject" '
-	add_upstream_commit &&
+	add_submodule_commits &&
 	(
 		cd downstream &&
 		git fetch >../actual.out 2>../actual.err
@@ -177,7 +201,7 @@ test_expect_success "using fetchRecurseSubmodules=true in .gitmodules recurses i
 '
 
 test_expect_success "--no-recurse-submodules overrides .gitmodules config" '
-	add_upstream_commit &&
+	add_submodule_commits &&
 	(
 		cd downstream &&
 		git fetch --no-recurse-submodules >../actual.out 2>../actual.err
@@ -226,7 +250,7 @@ test_expect_success "--quiet propagates to parallel submodules" '
 '
 
 test_expect_success "--dry-run propagates to submodules" '
-	add_upstream_commit &&
+	add_submodule_commits &&
 	(
 		cd downstream &&
 		git fetch --recurse-submodules --dry-run >../actual.out 2>../actual.err
@@ -245,7 +269,7 @@ test_expect_success "Without --dry-run propagates to submodules" '
 '
 
 test_expect_success "recurseSubmodules=true propagates into submodules" '
-	add_upstream_commit &&
+	add_submodule_commits &&
 	(
 		cd downstream &&
 		git config fetch.recurseSubmodules true &&
@@ -256,7 +280,7 @@ test_expect_success "recurseSubmodules=true propagates into submodules" '
 '
 
 test_expect_success "--recurse-submodules overrides config in submodule" '
-	add_upstream_commit &&
+	add_submodule_commits &&
 	(
 		cd downstream &&
 		(
@@ -270,7 +294,7 @@ test_expect_success "--recurse-submodules overrides config in submodule" '
 '
 
 test_expect_success "--no-recurse-submodules overrides config setting" '
-	add_upstream_commit &&
+	add_submodule_commits &&
 	(
 		cd downstream &&
 		git config fetch.recurseSubmodules true &&
@@ -309,7 +333,7 @@ test_expect_success "Recursion stops when no new submodule commits are fetched"
 '
 
 test_expect_success "Recursion doesn't happen when new superproject commits don't change any submodules" '
-	add_upstream_commit &&
+	add_submodule_commits &&
 	echo a > file &&
 	git add file &&
 	git commit -m "new file" &&
@@ -334,7 +358,7 @@ test_expect_success "Recursion picks up config in submodule" '
 			git config fetch.recurseSubmodules true
 		)
 	) &&
-	add_upstream_commit &&
+	add_submodule_commits &&
 	git add submodule &&
 	git commit -m "new submodule" &&
 	new_head=$(git rev-parse --short HEAD) &&
@@ -352,23 +376,8 @@ test_expect_success "Recursion picks up config in submodule" '
 '
 
 test_expect_success "Recursion picks up all submodules when necessary" '
-	add_upstream_commit &&
-	(
-		cd submodule &&
-		(
-			cd subdir/deepsubmodule &&
-			git fetch &&
-			git checkout -q FETCH_HEAD
-		) &&
-		git add subdir/deepsubmodule &&
-		git commit -m "new deepsubmodule" &&
-		new_head=$(git rev-parse --short HEAD) &&
-		check_sub $new_head
-	) &&
-	git add submodule &&
-	git commit -m "new submodule" &&
-	new_head=$(git rev-parse --short HEAD) &&
-	check_super $new_head &&
+	add_submodule_commits &&
+	add_superproject_commits &&
 	(
 		cd downstream &&
 		git fetch >../actual.out 2>../actual.err
@@ -378,19 +387,7 @@ test_expect_success "Recursion picks up all submodules when necessary" '
 '
 
 test_expect_success "'--recurse-submodules=on-demand' doesn't recurse when no new commits are fetched in the superproject (and ignores config)" '
-	add_upstream_commit &&
-	(
-		cd submodule &&
-		(
-			cd subdir/deepsubmodule &&
-			git fetch &&
-			git checkout -q FETCH_HEAD
-		) &&
-		git add subdir/deepsubmodule &&
-		git commit -m "new deepsubmodule" &&
-		new_head=$(git rev-parse --short HEAD) &&
-		check_sub $new_head
-	) &&
+	add_submodule_commits &&
 	(
 		cd downstream &&
 		git config fetch.recurseSubmodules true &&
@@ -402,10 +399,7 @@ test_expect_success "'--recurse-submodules=on-demand' doesn't recurse when no ne
 '
 
 test_expect_success "'--recurse-submodules=on-demand' recurses as deep as necessary (and ignores config)" '
-	git add submodule &&
-	git commit -m "new submodule" &&
-	new_head=$(git rev-parse --short HEAD) &&
-	check_super $new_head &&
+	add_superproject_commits &&
 	(
 		cd downstream &&
 		git config fetch.recurseSubmodules false &&
@@ -425,7 +419,7 @@ test_expect_success "'--recurse-submodules=on-demand' recurses as deep as necess
 '
 
 test_expect_success "'--recurse-submodules=on-demand' stops when no new submodule commits are found in the superproject (and ignores config)" '
-	add_upstream_commit &&
+	add_submodule_commits &&
 	echo a >> file &&
 	git add file &&
 	git commit -m "new file" &&
@@ -446,7 +440,7 @@ test_expect_success "'fetch.recurseSubmodules=on-demand' overrides global config
 		cd downstream &&
 		git fetch --recurse-submodules
 	) &&
-	add_upstream_commit &&
+	add_submodule_commits &&
 	git config --global fetch.recurseSubmodules false &&
 	git add submodule &&
 	git commit -m "new submodule" &&
@@ -472,7 +466,7 @@ test_expect_success "'submodule.<sub>.fetchRecurseSubmodules=on-demand' override
 		cd downstream &&
 		git fetch --recurse-submodules
 	) &&
-	add_upstream_commit &&
+	add_submodule_commits &&
 	git config fetch.recurseSubmodules false &&
 	git add submodule &&
 	git commit -m "new submodule" &&
@@ -522,7 +516,7 @@ test_expect_success "'fetch.recurseSubmodules=on-demand' works also without .git
 		cd downstream &&
 		git fetch --recurse-submodules
 	) &&
-	add_upstream_commit &&
+	add_submodule_commits &&
 	git add submodule &&
 	git rm .gitmodules &&
 	git commit -m "new submodule without .gitmodules" &&
-- 
2.33.GIT

