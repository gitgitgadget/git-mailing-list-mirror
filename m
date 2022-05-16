Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B208C433EF
	for <git@archiver.kernel.org>; Mon, 16 May 2022 18:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245028AbiEPSMJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 14:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344594AbiEPSLs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 14:11:48 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5873D4A0
        for <git@vger.kernel.org>; Mon, 16 May 2022 11:11:47 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id g17so3463292wrb.11
        for <git@vger.kernel.org>; Mon, 16 May 2022 11:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9zxer5sFKSbxR68vZth3Kwgw3B0891otUOZh0T2dqTg=;
        b=SZumQRp1rUIvgYIIa+WT2ppXMie6yDHydwFN3jlMjBh/5zvSTixJWpK1ibAVchVicH
         Huh4Xb25IyXRqPNb8a+kkviDNeVIPpFvoG0C5vd2r2MoNxeBfgs7arxa7H6ojag63qIP
         pkHOH5UWqFnFhGWE0N9JyGz8T/YGxxJNGlQ31LrfdKAfXzp9/0gCnTujC7QQVqCo61Wx
         0Hjp2krYaXvb6AQ7tThePWuNmyyo/bSA+/RoPz68zJvoH5hOc9PhboQk/U1GD4x/rvnh
         diFmHHwh+Y3aRrdW5ApvGGJYuat6F/98zLuM78DonyE3E4cSQCKvFDHn/Zu4nKKHdNi8
         NANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9zxer5sFKSbxR68vZth3Kwgw3B0891otUOZh0T2dqTg=;
        b=u1tKUJCTz38knnNxBmQ33CvUNZMymI1G61YRyuUN6kTBWNpKq8xSYUeCfC0Tdf8VK/
         JfWdrZmndjkBaoHs2tEur6pGqfWH7HpzD/eG1Puu5Kxd7y3gMvSygfAmS7+X7xgiQ4On
         EmQwLZQbyfwH2EvzdojUH0e9B1fm06LL4ZOrWxYtr9VCjZCQq1OMJ8QYlxng2BgcAJaC
         SV02Ww9ax3vEVoKysNmDj+X0c9IlkPxCqZtxHUUn+Kb0or4KsIktEED4n2BYQQRyT1z4
         6wYU9E0qyY6+Gs2gR+8UDhmmVFBQHgrXIFKC8TkqNGCK25ehzTsuzYHRbVD8G1B/O+7r
         YLSQ==
X-Gm-Message-State: AOAM532nNfO70M1lZYik2Tl8xutRJ8FVwdkAvIrp4S4zGnd0mZzL56yT
        l4akEV9ItK1kArNJxu522k8G4PaVRWA=
X-Google-Smtp-Source: ABdhPJzYI1lg+HgFU9hjrrm3Q/76GyQ5t4BiDWo/TlaVVk7Qpg958gzIjMn22K8zKr4vOSyj1bsahw==
X-Received: by 2002:adf:e646:0:b0:20a:c4fa:4991 with SMTP id b6-20020adfe646000000b0020ac4fa4991mr14934264wrn.413.1652724705183;
        Mon, 16 May 2022 11:11:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m6-20020a05600c460600b003942a244f2fsm6217wmo.8.2022.05.16.11.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 11:11:44 -0700 (PDT)
Message-Id: <b8a349c6deeb4b970075629d0c292b2ae9f7d0d3.1652724693.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
References: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 May 2022 18:11:33 +0000
Subject: [PATCH 8/8] sparse-checkout: integrate with sparse index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When modifying the sparse-checkout definition, the sparse-checkout
builtin calls update_sparsity() to modify the SKIP_WORKTREE bits of all
cache entries in the index. Before, we needed the index to be fully
expanded in order to ensure we had the full list of files necessary that
match the new patterns.

Insert a call to reset_sparse_directories() that expands sparse
directories that are within the new pattern list, but only far enough
that every necessary file path now exists as a cache entry. The
remaining logic within update_sparsity() will modify the SKIP_WORKTREE
bits appropriately.

This allows us to disable command_requires_full_index within the
sparse-checkout builtin. Add tests that demonstrate that we are not
expanding to a full index unnecessarily.

We can see the improved performance in the p2000 test script:

Test                           HEAD~1            HEAD
------------------------------------------------------------------------
2000.24: git ... (sparse-v3)   2.14(1.55+0.58)   1.57(1.03+0.53) -26.6%
2000.25: git ... (sparse-v4)   2.20(1.62+0.57)   1.58(0.98+0.59) -28.2%

These reductions of 26-28% are small compared to most examples, but the
time is dominated by writing a new copy of the base repository to the
worktree and then deleting it again. The fact that the previous index
expansion was such a large portion of the time is telling how important
it is to complete this sparse index integration.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/sparse-checkout.c                |  3 +++
 t/t1092-sparse-checkout-compatibility.sh | 25 ++++++++++++++++++++++++
 unpack-trees.c                           |  4 ++++
 3 files changed, 32 insertions(+)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index cbff6ad00b0..0157b292b36 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -937,6 +937,9 @@ int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
 	if (argc > 0) {
 		if (!strcmp(argv[0], "list"))
 			return sparse_checkout_list(argc, argv);
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 93bcfd20bbc..614357fc48c 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1552,6 +1552,31 @@ test_expect_success 'ls-files' '
 	ensure_not_expanded ls-files --sparse
 '
 
+test_expect_success 'sparse index is not expanded: sparse-checkout' '
+	init_repos &&
+
+	ensure_not_expanded sparse-checkout set deep/deeper2 &&
+	ensure_not_expanded sparse-checkout set deep/deeper1 &&
+	ensure_not_expanded sparse-checkout set deep &&
+	ensure_not_expanded sparse-checkout add folder1 &&
+	ensure_not_expanded sparse-checkout set deep/deeper1 &&
+	ensure_not_expanded sparse-checkout set folder2 &&
+
+	# Demonstrate that the checks that "folder1/a" is a file
+	# do not cause a sparse-index expansion (since it is in the
+	# sparse-checkout cone).
+	echo >>sparse-index/folder2/a &&
+	git -C sparse-index add folder2/a &&
+
+	ensure_not_expanded sparse-checkout add folder1 &&
+
+	# Skip checks here, since deep/deeper1 is inside a sparse directory
+	# that must be expanded to check whether `deep/deeper1` is a file
+	# or not.
+	ensure_not_expanded sparse-checkout set --skip-checks deep/deeper1 &&
+	ensure_not_expanded sparse-checkout set
+'
+
 # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
 # in this scenario, but it shouldn't.
 test_expect_success 'reset mixed and checkout orphan' '
diff --git a/unpack-trees.c b/unpack-trees.c
index 7f528d35cc2..9745e0dfc34 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -18,6 +18,7 @@
 #include "promisor-remote.h"
 #include "entry.h"
 #include "parallel-checkout.h"
+#include "sparse-index.h"
 
 /*
  * Error messages expected by scripts out of plumbing commands such as
@@ -2018,6 +2019,9 @@ enum update_sparsity_result update_sparsity(struct unpack_trees_options *o)
 			goto skip_sparse_checkout;
 	}
 
+	/* Expand sparse directories as needed */
+	expand_to_pattern_list(o->src_index, o->pl);
+
 	/* Set NEW_SKIP_WORKTREE on existing entries. */
 	mark_all_ce_unused(o->src_index);
 	mark_new_skip_worktree(o->pl, o->src_index, 0,
-- 
gitgitgadget
