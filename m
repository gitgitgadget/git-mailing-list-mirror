Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEE3C433FE
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 13:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1746E613D5
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 13:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbhJENWy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 09:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234950AbhJENWu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 09:22:50 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF6FC061760
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 06:21:00 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id g193-20020a1c20ca000000b0030d55f1d984so3021731wmg.3
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 06:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cYtH0ucxg2svi35ld1sfbei8Bkq0DfTY/p92ZD7PBbs=;
        b=CV7cKd+8n9VqjjO8qS5MJFeTQLqW/6sWQt7KUrQX+c8OXZLkG4e0DK5ibYE93vs3OR
         GJgOdMfTZpvhWrbq4NdOM4S90LRyy/rzOs7r282H0ohCYsKy6Z07+N6r0nHXi/rY7xIH
         f9/GbQppUUI9j9Hj8bvEAb7lieshj5a6TijT+qC2+DYEFoSZeSjR/SIkDnZ/5Vkx4lCv
         4x0rv02uVV9Z/+/V7mt7EUlUR85OJilWnnCsueuX0Z3JzAABggyAUU6ByvehvF9XVMPJ
         iWzn6O0aCGtGN5d4KSmhktWLOEWMsbQ8QmpfgGv/n33Y+v3G5VCyFRHyxYNtMnW5fXtz
         Ng1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cYtH0ucxg2svi35ld1sfbei8Bkq0DfTY/p92ZD7PBbs=;
        b=ZlP7RwMIIISX8H7iZm7FnTutyR8MtiQNefwTg4XhJ1cfiCKLZf0h5Kg/MDVXyDZhuB
         kkM/RbzpyI7NKfPUCUD2VtiGKGVayZMeC3IcwlnDw1UiATWUW5XRR9+HaUoCvnXKx77Q
         39Mq9jc69YNKmBOVknor3Q2z4YmGbr06Etv6/ANOsk2zgExgFevifsJcChp6ZC+ly9kE
         3enNGfrE+6OjSiEh2M4+8jZwc25MWil+8jnx/OX5NxGeQkuWa1V7RXGaC4RF4EZJ0AhF
         RVq9xvD3R6T/O30X/UME2Vd38AYRlDOUhiH+9L0/j12EX1vAJYQjln75elAW7nCb7Nns
         dvFA==
X-Gm-Message-State: AOAM532wY16h+fUulg5p7vOWLpjliTpQGErq3dEaUbHIgfVDDkhQC7dH
        AWCKeR081B1sNzbJEmCf76Ey4kgeV1g=
X-Google-Smtp-Source: ABdhPJxGsA6QoCtj47lNtLqrd5udUD+FciZ4TZl6uglUOW+g/5oljlID8TbI9E5McCrRU7GHp3cN8w==
X-Received: by 2002:a1c:f405:: with SMTP id z5mr3448629wma.72.1633440058874;
        Tue, 05 Oct 2021 06:20:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f1sm19499998wri.43.2021.10.05.06.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 06:20:58 -0700 (PDT)
Message-Id: <22c69bc60308fef13acd7c3aab4e11e175c89440.1633440057.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
        <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
From:   "Kevin Willford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Oct 2021 13:20:51 +0000
Subject: [PATCH v2 1/7] reset: behave correctly with sparse-checkout
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Kevin Willford <kewillf@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kevin Willford <kewillf@microsoft.com>

When using the sparse checkout feature, 'git reset' will add entries to
the index that will have the skip-worktree bit off but will leave the
working directory empty. File data is lost because the index version of
the files has been changed but there is nothing that is in the working
directory. This will cause the next 'git status' call to show either
deleted for files modified or deleting or nothing for files added. The
added files should be shown as untracked and modified files should be
shown as modified.

To fix this when the reset is running if there is not a file in the
working directory and if it will be missing with the new index entry or
was not missing in the previous version, we create the previous index
version of the file in the working directory so that status will report
correctly and the files will be availble for the user to deal with.

This fixes a documented failure from t1092 that was created in 19a0acc
(t1092: test interesting sparse-checkout scenarios, 2021-01-23).

Signed-off-by: Kevin Willford <kewillf@microsoft.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/reset.c                          | 24 ++++++++--
 t/t1092-sparse-checkout-compatibility.sh |  4 +-
 t/t7114-reset-sparse-checkout.sh         | 61 ++++++++++++++++++++++++
 3 files changed, 83 insertions(+), 6 deletions(-)
 create mode 100755 t/t7114-reset-sparse-checkout.sh

diff --git a/builtin/reset.c b/builtin/reset.c
index 51c9e2f43ff..3b75d3b2f20 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -25,6 +25,8 @@
 #include "cache-tree.h"
 #include "submodule.h"
 #include "submodule-config.h"
+#include "dir.h"
+#include "entry.h"
 
 #define REFRESH_INDEX_DELAY_WARNING_IN_MS (2 * 1000)
 
@@ -130,11 +132,27 @@ static void update_index_from_diff(struct diff_queue_struct *q,
 	int intent_to_add = *(int *)data;
 
 	for (i = 0; i < q->nr; i++) {
+		int pos;
 		struct diff_filespec *one = q->queue[i]->one;
-		int is_missing = !(one->mode && !is_null_oid(&one->oid));
+		struct diff_filespec *two = q->queue[i]->two;
+		int is_in_reset_tree = one->mode && !is_null_oid(&one->oid);
 		struct cache_entry *ce;
 
-		if (is_missing && !intent_to_add) {
+		/*
+		 * If the file being reset has `skip-worktree` enabled, we need
+		 * to check it out to prevent the file from being hard reset.
+		 */
+		pos = cache_name_pos(two->path, strlen(two->path));
+		if (pos >= 0 && ce_skip_worktree(active_cache[pos])) {
+			struct checkout state = CHECKOUT_INIT;
+			state.force = 1;
+			state.refresh_cache = 1;
+			state.istate = &the_index;
+
+			checkout_entry(active_cache[pos], &state, NULL, NULL);
+		}
+
+		if (!is_in_reset_tree && !intent_to_add) {
 			remove_file_from_cache(one->path);
 			continue;
 		}
@@ -144,7 +162,7 @@ static void update_index_from_diff(struct diff_queue_struct *q,
 		if (!ce)
 			die(_("make_cache_entry failed for path '%s'"),
 			    one->path);
-		if (is_missing) {
+		if (!is_in_reset_tree) {
 			ce->ce_flags |= CE_INTENT_TO_ADD;
 			set_object_name_for_intent_to_add_entry(ce);
 		}
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 886e78715fe..c5977152661 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -459,9 +459,7 @@ test_expect_failure 'blame with pathspec outside sparse definition' '
 	test_all_match git blame deep/deeper2/deepest/a
 '
 
-# NEEDSWORK: a sparse-checkout behaves differently from a full checkout
-# in this scenario, but it shouldn't.
-test_expect_failure 'checkout and reset (mixed)' '
+test_expect_success 'checkout and reset (mixed)' '
 	init_repos &&
 
 	test_all_match git checkout -b reset-test update-deep &&
diff --git a/t/t7114-reset-sparse-checkout.sh b/t/t7114-reset-sparse-checkout.sh
new file mode 100755
index 00000000000..a8029707fb1
--- /dev/null
+++ b/t/t7114-reset-sparse-checkout.sh
@@ -0,0 +1,61 @@
+#!/bin/sh
+
+test_description='reset when using a sparse-checkout'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_tick &&
+	echo "checkout file" >c &&
+	echo "modify file" >m &&
+	echo "delete file" >d &&
+	git add . &&
+	git commit -m "initial commit" &&
+	echo "added file" >a &&
+	echo "modification of a file" >m &&
+	git rm d &&
+	git add . &&
+	git commit -m "second commit" &&
+	git checkout -b endCommit
+'
+
+test_expect_success 'reset when there is a sparse-checkout' '
+	echo "/c" >.git/info/sparse-checkout &&
+	test_config core.sparsecheckout true &&
+	git checkout -B resetBranch &&
+	test_path_is_missing m &&
+	test_path_is_missing a &&
+	test_path_is_missing d &&
+	git reset HEAD~1 &&
+	echo "checkout file" >expect &&
+	test_cmp expect c &&
+	echo "added file" >expect &&
+	test_cmp expect a &&
+	echo "modification of a file" >expect &&
+	test_cmp expect m &&
+	test_path_is_missing d
+'
+
+test_expect_success 'reset after deleting file without skip-worktree bit' '
+	git checkout -f endCommit &&
+	git clean -xdf &&
+	cat >.git/info/sparse-checkout <<-\EOF &&
+	/c
+	/m
+	EOF
+	test_config core.sparsecheckout true &&
+	git checkout -B resetAfterDelete &&
+	test_path_is_file m &&
+	test_path_is_missing a &&
+	test_path_is_missing d &&
+	rm -f m &&
+	git reset HEAD~1 &&
+	echo "checkout file" >expect &&
+	test_cmp expect c &&
+	echo "added file" >expect &&
+	test_cmp expect a &&
+	test_path_is_missing m &&
+	test_path_is_missing d
+'
+
+test_done
-- 
gitgitgadget

