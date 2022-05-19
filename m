Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3415FC433FE
	for <git@archiver.kernel.org>; Thu, 19 May 2022 17:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243448AbiESRyF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 13:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243591AbiESRxa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 13:53:30 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FDF18B29
        for <git@vger.kernel.org>; Thu, 19 May 2022 10:52:53 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id l38-20020a05600c1d2600b00395b809dfbaso3106534wms.2
        for <git@vger.kernel.org>; Thu, 19 May 2022 10:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ajeaHxnLCh9ucVB3v4mh6XIqKDB2XVBegW9+7kiuB5A=;
        b=GCpoJNEVWoJ0D9DLEh5KumOc/p7IRKaqgi4+NVAtlHS3WMnBeQ787TbXD88MMcbv/H
         8S8ar+OvVGjH9HOhPjzqPdzblB9RQu4Qulm5u4o90Ods9BwcBBkwNGS3xxi3JaA/cbSJ
         0p+afjPpLE0naAeCC+gKA2rDuvIHFZ34ALY9s5whqPKWITdnoGQspw94GzRixHMjHPrD
         byFo9rJ6Yq67V1K30VuhE6xy9TTOW77oEXgH2uXBqQ1JutH49v4iEmT19PAc5smGcfXE
         qS4PqKv71Jez8jigzCbeO3XEp6RxxrqsoB9e62+MAUXPLdnnHgYuE53c5Tvsoi7K2iw7
         7i/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ajeaHxnLCh9ucVB3v4mh6XIqKDB2XVBegW9+7kiuB5A=;
        b=b1J/tsu0RKTPUAWw/bbEFEpcZvWfjErhTTtHEBL7j7WcH/+Qz9L9g3PIl49pn3J77X
         /u3uDJH/Vvr44h8Kgf5p6QFgPYkvytRA9PdUtYEsY8NiidAT/AA3HU57I5SXdcRbt+ao
         rfNTQqYtNw/pQFd8vJ46hxRhBrp3hC+vqtctetlEWTisJDr84AGZjr9bM0nYXuKSH/3g
         j1dOb0SiU46ATiQnNdELwZK339YYrhJzgOsnMypmnPRKp92XNfKAJvLifcZwtunX+zwc
         Oroy6/k+14xMJbDQ3N0XPWuXsuryqSQcoEiouoVzb61x3Mtcs/bzSbZ+BHI0i4Oc3cSF
         mUuw==
X-Gm-Message-State: AOAM533wwmbrJXyLFWhuvH4oDnNQee+5jqAgrMn6x7KPrUJx5eZumZnH
        LW4BlRggTNd6h5vmYHaE4eZpd+NlOjM=
X-Google-Smtp-Source: ABdhPJx3rSRESryAxgLdtatgkKmOJwaH99x7JZsACuxXk7AC0uO+ozcSZx+1xbj2ZOFOVCXKFVepnw==
X-Received: by 2002:a05:600c:1f19:b0:396:e98e:35e1 with SMTP id bd25-20020a05600c1f1900b00396e98e35e1mr5495491wmb.84.1652982771572;
        Thu, 19 May 2022 10:52:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w9-20020adf8bc9000000b0020d07958bb3sm276784wra.3.2022.05.19.10.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 10:52:51 -0700 (PDT)
Message-Id: <ad9ed6973d5ed1a73a1b7e2c4f88208cbb0b31c8.1652982759.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
References: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
        <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 May 2022 17:52:38 +0000
Subject: [PATCH v2 10/10] sparse-checkout: integrate with sparse index
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
index 785820f9fd5..73f4cf47314 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1584,6 +1584,31 @@ test_expect_success 'ls-files' '
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
