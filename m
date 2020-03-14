Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D603C10DCE
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 04:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BAA520575
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 04:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qG/YfbKu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgCOEzi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Mar 2020 00:55:38 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:34500 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgCOEzi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Mar 2020 00:55:38 -0400
Received: by mail-lj1-f176.google.com with SMTP id s13so14933090ljm.1
        for <git@vger.kernel.org>; Sat, 14 Mar 2020 21:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ftQDiJizTOtP0QcekVoFF73SnUn8cFs+C+BqLKuJbls=;
        b=qG/YfbKuayrcd7xBhGxUlPH5brgVPg6I9034gdHRAZYlugVSyT9XqdgAKoHPTGnIPE
         EUWfHE0rfnnTpaWlo0QueDhZ+r9QR/lYko6QjItUnZnCdwE9D7gWixcIEibSUCACmybe
         nslvCjmvJQs7qbVNGkks7m/QimrBJkh1ca4JVjo1QHcSU6IXCh6hIAwleF1kvdBSsJ8U
         PF/kBlwIsNdRfGda7POhtCmG5l7SC8Dz7/JTganb2Ei3CLsJYXlDC0uN5BP7/jcJUEef
         043pQfSRZkVW59qSe7uHoelxT6jxtCY7pSdKfmFxOnm79r1obJyU7xIY+Qhz/bYnotok
         Im7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ftQDiJizTOtP0QcekVoFF73SnUn8cFs+C+BqLKuJbls=;
        b=b4OPOtp6xayqlQFVJkFIPLkSRomC8a8A/hbyI7Ly5Ivtay2bedckKsMi7tceqx6SZk
         4H6/qLaBOwFugINXXO6/3Z46O7ZDBw+tSPaxNoeY/+jMl8bwNCEPSZ90h/9HIvUkDA16
         THTkkTfKikbREobp0qoHgJrjxTbATQ/VJGxZAO5JwDwrZKJZr10qWu7lNGYfZffbIJYK
         VQrTgbtTuC0QoiGmfiM0HgAWL/1i+qJd4mr4ryUMFclOiDxQVLchyuIOTOFQscfV0SjO
         +H3szEpkafP3UNSzJcWlnh8qjXe4hXDcpJMlshY+sDvwehFVLwUlVtjL5hxWeYWdsyFN
         Iryw==
X-Gm-Message-State: ANhLgQ03QoXhObWOSphBJL/VUQK/nrJieuKnMjHfuZPIYGnRYEuo9qm6
        I4xaU0fBID6UirPENk5ecGX45XeL
X-Google-Smtp-Source: ADFU+vtnpDdVeP9Eyw4dVH7ZUIg/Dpy+3oaKdXKxNlFbtj6feEq7fQhwCUf4Eubrq33G/f53ppbR4g==
X-Received: by 2002:aa7:dc4f:: with SMTP id g15mr9870670edu.244.1584169899189;
        Sat, 14 Mar 2020 00:11:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id qw14sm841604ejb.14.2020.03.14.00.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2020 00:11:38 -0700 (PDT)
Message-Id: <892933752c638a9ed938e046e466dd1e927058a6.1584169893.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
References: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 14 Mar 2020 07:11:32 +0000
Subject: [PATCH 6/7] sparse-checkout: use new update_sparsity() function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Remove the equivalent of 'git read-tree -mu HEAD' in the sparse-checkout
codepaths for setting the SKIP_WORKTREE bits and instead use the new
update_sparsity() function.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c          | 39 +++++++-----------------------
 t/t1091-sparse-checkout-builtin.sh | 32 +++++++++++++++++-------
 2 files changed, 32 insertions(+), 39 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 740da4b6d54..5d3ec2e6be9 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -97,47 +97,32 @@ static int update_working_directory(struct pattern_list *pl)
 	int result = 0;
 	struct unpack_trees_options o;
 	struct lock_file lock_file = LOCK_INIT;
-	struct object_id oid;
-	struct tree *tree;
-	struct tree_desc t;
 	struct repository *r = the_repository;
 
-	if (repo_read_index_unmerged(r))
-		die(_("you need to resolve your current index first"));
-
-	if (get_oid("HEAD", &oid))
-		return 0;
-
-	tree = parse_tree_indirect(&oid);
-	parse_tree(tree);
-	init_tree_desc(&t, tree->buffer, tree->size);
-
 	memset(&o, 0, sizeof(o));
 	o.verbose_update = isatty(2);
-	o.merge = 1;
 	o.update = 1;
-	o.fn = oneway_merge;
 	o.head_idx = -1;
 	o.src_index = r->index;
 	o.dst_index = r->index;
 	o.skip_sparse_checkout = 0;
 	o.pl = pl;
-	o.keep_pattern_list = !!pl;
 
-	resolve_undo_clear_index(r->index);
 	setup_work_tree();
 
-	cache_tree_free(&r->index->cache_tree);
-
 	repo_hold_locked_index(r, &lock_file, LOCK_DIE_ON_ERROR);
 
-	core_apply_sparse_checkout = 1;
-	result = unpack_trees(1, &t, &o);
+	result = update_sparsity(&o);
 
-	if (!result) {
-		prime_cache_tree(r, r->index, tree);
+	if (result == 1)
+		/*
+		 * We don't do any special handling of warnings from untracked
+		 * files in the way or dirty entries that can't be removed.
+		 */
+		result = 0;
+	if (!result)
 		write_locked_index(r->index, &lock_file, COMMIT_LOCK);
-	} else
+	else
 		rollback_lock_file(&lock_file);
 
 	return result;
@@ -304,8 +289,6 @@ static int sparse_checkout_init(int argc, const char **argv)
 	};
 
 	repo_read_index(the_repository);
-	require_clean_work_tree(the_repository,
-				N_("initialize sparse-checkout"), NULL, 1, 0);
 
 	argc = parse_options(argc, argv, NULL,
 			     builtin_sparse_checkout_init_options,
@@ -560,8 +543,6 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix,
 	};
 
 	repo_read_index(the_repository);
-	require_clean_work_tree(the_repository,
-				N_("set sparse-checkout patterns"), NULL, 1, 0);
 
 	argc = parse_options(argc, argv, prefix,
 			     builtin_sparse_checkout_set_options,
@@ -577,8 +558,6 @@ static int sparse_checkout_disable(int argc, const char **argv)
 	struct strbuf match_all = STRBUF_INIT;
 
 	repo_read_index(the_repository);
-	require_clean_work_tree(the_repository,
-				N_("disable sparse-checkout"), NULL, 1, 0);
 
 	memset(&pl, 0, sizeof(pl));
 	hashmap_init(&pl.recursive_hashmap, pl_hashmap_cmp, NULL, 0);
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 8607a8e6d1a..0d93d3983e0 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -277,16 +277,23 @@ test_expect_success 'cone mode: add parent path' '
 	check_files repo a deep folder1
 '
 
-test_expect_success 'revert to old sparse-checkout on bad update' '
+test_expect_success 'not-up-to-date does not block rest of sparsification' '
 	test_when_finished git -C repo sparse-checkout disable &&
 	test_when_finished git -C repo reset --hard &&
 	git -C repo sparse-checkout set deep &&
+
 	echo update >repo/deep/deeper2/a &&
 	cp repo/.git/info/sparse-checkout expect &&
-	test_must_fail git -C repo sparse-checkout set deep/deeper1 2>err &&
-	test_i18ngrep "cannot set sparse-checkout patterns" err &&
-	test_cmp repo/.git/info/sparse-checkout expect &&
-	check_files repo/deep a deeper1 deeper2
+	test_write_lines "!/deep/*/" "/deep/deeper1/" >>expect &&
+
+	git -C repo sparse-checkout set deep/deeper1 2>err &&
+
+	test_i18ngrep "Cannot update sparse checkout" err &&
+	test_cmp expect repo/.git/info/sparse-checkout &&
+	check_files repo/deep a deeper1 deeper2 &&
+	check_files repo/deep/deeper1 a deepest &&
+	check_files repo/deep/deeper1/deepest a &&
+	check_files repo/deep/deeper2 a
 '
 
 test_expect_success 'revert to old sparse-checkout on empty update' '
@@ -316,12 +323,19 @@ test_expect_success '.gitignore should not warn about cone mode' '
 	test_i18ngrep ! "disabling cone patterns" err
 '
 
-test_expect_success 'sparse-checkout (init|set|disable) fails with dirty status' '
+test_expect_success 'sparse-checkout (init|set|disable) warns with dirty status' '
 	git clone repo dirty &&
 	echo dirty >dirty/folder1/a &&
-	test_must_fail git -C dirty sparse-checkout init &&
-	test_must_fail git -C dirty sparse-checkout set /folder2/* /deep/deeper1/* &&
-	test_must_fail git -C dirty sparse-checkout disable &&
+
+	git -C dirty sparse-checkout init 2>err &&
+	test_i18ngrep "warning.*Cannot update sparse checkout" err &&
+
+	git -C dirty sparse-checkout set /folder2/* /deep/deeper1/* &&
+	test_i18ngrep "warning.*Cannot update sparse checkout" err &&
+
+	git -C dirty sparse-checkout disable &&
+	test_i18ngrep "warning.*Cannot update sparse checkout" err &&
+
 	git -C dirty reset --hard &&
 	git -C dirty sparse-checkout init &&
 	git -C dirty sparse-checkout set /folder2/* /deep/deeper1/* &&
-- 
gitgitgadget

