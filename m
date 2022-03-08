Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7DEC433FE
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 00:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240099AbiCHAPz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 19:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239309AbiCHAPx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 19:15:53 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345DA3525D
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 16:14:57 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id e13-20020a17090301cd00b00150145346f9so8170773plh.23
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 16:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Si1dBc7Zz/WOYpIhW0V4lursSPVz3ZjgkG0OcmCCYFo=;
        b=HwCFrPDG88ouf6QG9hIr6HS8Om5M6eEgP0PBI3KphkN/cl3jggr93YfOU1mLBw+Df+
         rshwD/I8/Ds6ae80V3QNpuKR06TZYJv0HOGV7Wj0gWzlCyNzc6L16RahP/m827d9RO8W
         GdvdSg9DxVKrQX8xOpfM6mFEMk6KoQlwFa3MIkmYAh5tL3Xq1Pe6ICpnXRMdrzKVmm36
         vz/nlqz781nYji0YC+Pcyz+q32JfZQU7YGufZOV8p9WxaV4l9MjeKV0USOfHZzAz/NjR
         AZw52ojI7MGOwby5UCoN8/rg4FZ01FojrOH8J7541eFHGjOLKIrJSD3od7nxx27ojBNB
         IqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Si1dBc7Zz/WOYpIhW0V4lursSPVz3ZjgkG0OcmCCYFo=;
        b=uMB7GLzxDaTsM44m4PvlvKQyvUyMec+NJm9XGOtHe5GPVqhFMDJoB4nPOw6W5wl2cb
         j+4tIB3JCc/KkR6/FLT61C4JPiU4Z6/t6ravUpsrm6lWVkdPxAo/GF8Z/W2J3JAUpn69
         ZLvCzZzfjS1An9gPVruRGz8ZSief42ixafzY+puH4pfsE8po3rSSFAbIKZQi49lVA6Ba
         KoHVQfdD7yqK//QbZ6kpxvxOPENKLTfI/7Glk2rMZpQZBNgLrFhSEOFHxMF7O8MM2KHI
         wTvPzN2ukgIcfyvmhRo/mrZCp1jo+inPWHmMC+YsAWWekrJl2yCwCu0zkdIdFgmwcx2a
         sqGw==
X-Gm-Message-State: AOAM530a5agrMPgmzNRzUyaepyGgi/4OmRHN1P6wF5Xfh+TrMHhM/Gvf
        WM4hxW/aEW+eYGges02TuwD0drzqCghz7PSyg0mac21KIGW7SrKF2iDbTXDryyNAKV1ixhFbaJF
        bOwsW1iZL23RM/KyDtmPHvJgAbA/3c+s/OuzYebhNZV0K1537JNWZxb7L5CYcG5k=
X-Google-Smtp-Source: ABdhPJwDoNJZgGZMFRCPCOEJ3quDiF07I5xjazfqlw7PnmFvElK75rAqbSb2e86KWWaDIQoAu7pv/f6qvzC01Q==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:3887:b0:1bf:6f18:67e with SMTP id
 mu7-20020a17090b388700b001bf6f18067emr1671924pjb.69.1646698496574; Mon, 07
 Mar 2022 16:14:56 -0800 (PST)
Date:   Mon,  7 Mar 2022 16:14:26 -0800
In-Reply-To: <20220308001433.94995-1-chooglen@google.com>
Message-Id: <20220308001433.94995-4-chooglen@google.com>
Mime-Version: 1.0
References: <20220304005757.70107-1-chooglen@google.com> <20220308001433.94995-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v5 03/10] t5526: create superproject commits with test helper
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
 t/t5526-fetch-submodules.sh | 95 ++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 50 deletions(-)

diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index e7136b68ba..aa6bb9867c 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -40,7 +40,7 @@ write_expected_super () {
 # a file that contains the expected err if that new commit were fetched.
 # These output files get concatenated in the right order by
 # verify_fetch_result().
-add_upstream_commit() {
+add_submodule_commits () {
 	(
 		cd submodule &&
 		echo new >> subfile &&
@@ -61,6 +61,30 @@ add_upstream_commit() {
 	)
 }
 
+# For each superproject in the test setup, update its submodule, add the
+# submodule and create a new commit with the submodule change.
+#
+# This requires add_submodule_commits() to be called first, otherwise
+# the submodules will not have changed and cannot be "git add"-ed.
+add_superproject_commits () {
+	(
+		cd submodule &&
+		(
+			cd subdir/deepsubmodule &&
+			git fetch &&
+			git checkout -q FETCH_HEAD
+		) &&
+		git add subdir/deepsubmodule &&
+		git commit -m "new deep submodule"
+	) &&
+	git add submodule &&
+	git commit -m "new submodule" &&
+	super_head=$(git rev-parse --short HEAD) &&
+	sub_head=$(git -C submodule rev-parse --short HEAD) &&
+	write_expected_super $super_head &&
+	write_expected_sub $sub_head
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
-		write_expected_sub $new_head
-	) &&
-	git add submodule &&
-	git commit -m "new submodule" &&
-	new_head=$(git rev-parse --short HEAD) &&
-	write_expected_super $new_head &&
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
-		write_expected_sub $new_head
-	) &&
+	add_submodule_commits &&
 	(
 		cd downstream &&
 		git config fetch.recurseSubmodules true &&
@@ -402,10 +399,8 @@ test_expect_success "'--recurse-submodules=on-demand' doesn't recurse when no ne
 '
 
 test_expect_success "'--recurse-submodules=on-demand' recurses as deep as necessary (and ignores config)" '
-	git add submodule &&
-	git commit -m "new submodule" &&
-	new_head=$(git rev-parse --short HEAD) &&
-	write_expected_super $new_head &&
+	add_submodule_commits &&
+	add_superproject_commits &&
 	(
 		cd downstream &&
 		git config fetch.recurseSubmodules false &&
@@ -425,7 +420,7 @@ test_expect_success "'--recurse-submodules=on-demand' recurses as deep as necess
 '
 
 test_expect_success "'--recurse-submodules=on-demand' stops when no new submodule commits are found in the superproject (and ignores config)" '
-	add_upstream_commit &&
+	add_submodule_commits &&
 	echo a >> file &&
 	git add file &&
 	git commit -m "new file" &&
@@ -446,7 +441,7 @@ test_expect_success "'fetch.recurseSubmodules=on-demand' overrides global config
 		cd downstream &&
 		git fetch --recurse-submodules
 	) &&
-	add_upstream_commit &&
+	add_submodule_commits &&
 	git config --global fetch.recurseSubmodules false &&
 	git add submodule &&
 	git commit -m "new submodule" &&
@@ -472,7 +467,7 @@ test_expect_success "'submodule.<sub>.fetchRecurseSubmodules=on-demand' override
 		cd downstream &&
 		git fetch --recurse-submodules
 	) &&
-	add_upstream_commit &&
+	add_submodule_commits &&
 	git config fetch.recurseSubmodules false &&
 	git add submodule &&
 	git commit -m "new submodule" &&
@@ -522,7 +517,7 @@ test_expect_success "'fetch.recurseSubmodules=on-demand' works also without .git
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

