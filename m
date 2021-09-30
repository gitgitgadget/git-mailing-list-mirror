Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5570C433FE
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 14:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99E1E61A53
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 14:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351919AbhI3Ows (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 10:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349797AbhI3Owr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 10:52:47 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D41C06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 07:51:04 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id q2so664173wrc.4
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 07:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gGCfyG6tsBdfVw7efmwpQlI96WeOhFsi+r0liCqT06s=;
        b=ca2XUPJ5FZtgYCvvlZQ38seqbWWCr2Cr6p/+IaHFiYh26Q6yZLBWY8Wf4ECFesr+ib
         eXmlAwU4I5gewKjrILEPtXmnZbSdoLJaGkm6CPczvxYhrTf4EYzeTFDcKsY7lzdg2mUQ
         uTUBTB6sfjjDvbk28zmqBtVnYJlMX2oeQUKN/+xowpVaCPw5wcO5HIgBHjPSuWaDB/ap
         Hcm11VoaddiL0IdHnisIJ1N5/og/82WbmkKMcgmRVCJfr23kxKvbMcrfYXA8e011cn9q
         QSLn8lk8zg3OYBliZz+jBJlepV97rEF0Szl+EGTImrx36U9vyyGdmIog3UNz45pSKW5F
         mOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gGCfyG6tsBdfVw7efmwpQlI96WeOhFsi+r0liCqT06s=;
        b=0Vlr/+Xi4qQBq8quhZ+JsnaIBN5jc86Mj8huG5y/4hbswkGvCEIme7rhgh6pHtDaf1
         eFgV4gdPYu5sVLzzsPLFTEDdF7A1mJK6nEphM1+0FD5BdX64JhWT+QKFmyXSJj9FobVw
         7N8szLN+4ubb6laYR7lx+oubVe4F6pPdt9RoGgQr43Eh8UhLj14Xb3ZXIPU9tB0sUJMi
         JRcxx6hYOvw4Spjgul6Gcnmb9EhQ8DOj3CPIFmre/fSMh/VSMaINJQCUTbva7KG9lm7X
         hHm3gflqFAk5GTlQRGvzmQXZKzuSa5ekgi0OkZPgMxpuJfylzqkoRZqnYrXQiiM4SrlT
         H/Hg==
X-Gm-Message-State: AOAM531cMqJ1omqoKMKNVWCNJlbs3BK1QtVtm2xQTIAAkBzJsePnJZRH
        jc6gDx5wvIaxUHgxR3jqqlVUeyzRNR8=
X-Google-Smtp-Source: ABdhPJyfHDTDWOZF0YPfJfBQzM76OMrOU0FmMnmC9yCxePGVcr+ICigX4rvBLMKlBnQG4QIIp5lkMQ==
X-Received: by 2002:adf:e643:: with SMTP id b3mr6887644wrn.67.1633013463395;
        Thu, 30 Sep 2021 07:51:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d2sm3197952wrc.32.2021.09.30.07.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 07:51:03 -0700 (PDT)
Message-Id: <65905bf4e001118e8b9ced95c1bcecbacb6334ac.1633013461.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
From:   "Kevin Willford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Sep 2021 14:50:55 +0000
Subject: [PATCH 1/7] reset: behave correctly with sparse-checkout
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
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
 builtin/reset.c                          | 39 +++++++++++++++
 t/t1092-sparse-checkout-compatibility.sh |  4 +-
 t/t7114-reset-sparse-checkout.sh         | 61 ++++++++++++++++++++++++
 3 files changed, 101 insertions(+), 3 deletions(-)
 create mode 100755 t/t7114-reset-sparse-checkout.sh

diff --git a/builtin/reset.c b/builtin/reset.c
index 51c9e2f43ff..8ffcd713720 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -25,6 +25,8 @@
 #include "cache-tree.h"
 #include "submodule.h"
 #include "submodule-config.h"
+#include "dir.h"
+#include "entry.h"
 
 #define REFRESH_INDEX_DELAY_WARNING_IN_MS (2 * 1000)
 
@@ -127,12 +129,49 @@ static void update_index_from_diff(struct diff_queue_struct *q,
 		struct diff_options *opt, void *data)
 {
 	int i;
+	int pos;
 	int intent_to_add = *(int *)data;
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filespec *one = q->queue[i]->one;
+		struct diff_filespec *two = q->queue[i]->two;
 		int is_missing = !(one->mode && !is_null_oid(&one->oid));
+		int was_missing = !two->mode && is_null_oid(&two->oid);
 		struct cache_entry *ce;
+		struct cache_entry *ce_before;
+		struct checkout state = CHECKOUT_INIT;
+
+		/*
+		 * When using the sparse-checkout feature the cache entries
+		 * that are added here will not have the skip-worktree bit
+		 * set. Without this code there is data that is lost because
+		 * the files that would normally be in the working directory
+		 * are not there and show as deleted for the next status.
+		 * In the case of added files, they just disappear.
+		 *
+		 * We need to create the previous version of the files in
+		 * the working directory so that they will have the right
+		 * content and the next status call will show modified or
+		 * untracked files correctly.
+		 */
+		if (core_apply_sparse_checkout && !file_exists(two->path)) {
+			pos = cache_name_pos(two->path, strlen(two->path));
+			if ((pos >= 0 && ce_skip_worktree(active_cache[pos])) &&
+			    (is_missing || !was_missing)) {
+				state.force = 1;
+				state.refresh_cache = 1;
+				state.istate = &the_index;
+
+				ce_before = make_cache_entry(&the_index, two->mode,
+							     &two->oid, two->path,
+							     0, 0);
+				if (!ce_before)
+					die(_("make_cache_entry failed for path '%s'"),
+						two->path);
+
+				checkout_entry(ce_before, &state, NULL, NULL);
+			}
+		}
 
 		if (is_missing && !intent_to_add) {
 			remove_file_from_cache(one->path);
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

