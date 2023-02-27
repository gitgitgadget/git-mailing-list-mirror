Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC84C64ED8
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 15:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjB0P2k (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 10:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjB0P2f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 10:28:35 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C49330E2
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 07:28:29 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id m25-20020a7bcb99000000b003e7842b75f2so4070231wmi.3
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 07:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68C0omPWjHuvknyuECeLxPbnkoBhw243omtWOKp8Tz4=;
        b=k/ErE1Yv2o/zZE6zmnEMbN9M3NQRUXZTOX+8700bqZKkNG1I8NkpNQeujaG6ZJT7Nb
         ln/eGZrdYOtJjlTLRjiqpjzzRXp3hRVxyNNVvemfNhfH8YxT+VYCji+JFzbU+PglnCEF
         gk/sGez+nfD5/s1FGLa0Cqpdhc1KgDwIiJB9Y78j5Ih21QZObyo2EULr2MZD/p1+s5RJ
         eciVnjYC7OHhX41TAnoouMTVxzLut5H9Bv52ysU/87dZHtP4KggseAMEdH9zPP879ySn
         Xe/cgnFMw4nzPlLHIIMn22jFb1pAKQbW8uN6owQFZpDHpJsb9YwQc8Wt5SImZUFPzlOQ
         1wkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68C0omPWjHuvknyuECeLxPbnkoBhw243omtWOKp8Tz4=;
        b=6ULf7OdeGwyzO1YanZVgEpGXT7r5z/+sfj6HaR6gqCgP/FuXgei+9hmVKKXfKeW3xh
         4nYfN9W32pccAVtbs5aeS/gp4Oh8ksX95MmMOGO6l0TfKFofegd7Wurss9iGio0xSmTk
         K8fuEIf6PHQU+pjGVD8owQ7bhcaLh6TacvmIbFNYLYz9KQZflAF4EO3EKEz/BjKnO95E
         xplBFhJBI4qYRQ8zjexhGVlXViJhpoFfYIHHgBqoE6Iw4xghKCXkTS1hL2VGJewlNH+0
         YTaRo/1Gw6e9TpWwEybVct33zkLbRfRKDInXXm7hPT40ACXByZbJDFhu65NS9TK2xrcl
         AF3g==
X-Gm-Message-State: AO0yUKXLknj0brabfAqtMGVVNnxEO17pWDJS18SKMOU3qkw0guC9QIjE
        7MCnKVZ2DuoaPfuRYWbV6vBsM7Wz62c=
X-Google-Smtp-Source: AK7set9steWchjY21CaMGW6JVI2ZSKaEaRMvhKnamw5TAFTikzKLEZ82pKSEhKJvyb1nN5/Vle53Rw==
X-Received: by 2002:a05:600c:1f18:b0:3eb:1d0c:ad71 with SMTP id bd24-20020a05600c1f1800b003eb1d0cad71mr7766477wmb.23.1677511707334;
        Mon, 27 Feb 2023 07:28:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id az34-20020a05600c602200b003e6efc0f91csm9392604wmb.42.2023.02.27.07.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 07:28:27 -0800 (PST)
Message-Id: <cd3d4894afbd4f98b777a2b56741e4915ae51e5d.1677511700.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1149.v3.git.1677511700.gitgitgadget@gmail.com>
References: <pull.1149.v2.git.1677291960.gitgitgadget@gmail.com>
        <pull.1149.v3.git.1677511700.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Feb 2023 15:28:14 +0000
Subject: [PATCH v3 07/13] sparse-checkout: avoid using internal API of
 unpack-trees
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

struct unpack_trees_options has the following field and comment:

	struct pattern_list *pl; /* for internal use */

Despite the internal-use comment, commit e091228e17 ("sparse-checkout:
update working directory in-process", 2019-11-21) starting setting this
field from an external caller.  At the time, the only way around that
would have been to modify unpack_trees() to take an extra pattern_list
argument, and there's a lot of callers of that function.  However, when
we split update_sparsity() off as a separate function, with
sparse-checkout being the sole caller, the need to update other callers
went away.  Fix this API problem by adding a pattern_list argument to
update_sparsity() and stop setting the internal o.pl field directly.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c |  3 +--
 unpack-trees.c            | 18 +++++++++++-------
 unpack-trees.h            |  3 ++-
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index c3738154918..4b7390ce367 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -219,14 +219,13 @@ static int update_working_directory(struct pattern_list *pl)
 	o.dst_index = r->index;
 	index_state_init(&o.result, r);
 	o.skip_sparse_checkout = 0;
-	o.pl = pl;
 
 	setup_work_tree();
 
 	repo_hold_locked_index(r, &lock_file, LOCK_DIE_ON_ERROR);
 
 	setup_unpack_trees_porcelain(&o, "sparse-checkout");
-	result = update_sparsity(&o);
+	result = update_sparsity(&o, pl);
 	clear_unpack_trees_porcelain(&o);
 
 	if (result == UPDATE_SPARSITY_WARNINGS)
diff --git a/unpack-trees.c b/unpack-trees.c
index bad3120a76e..6e4ca6fe800 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2091,10 +2091,10 @@ return_failed:
  *
  * CE_NEW_SKIP_WORKTREE is used internally.
  */
-enum update_sparsity_result update_sparsity(struct unpack_trees_options *o)
+enum update_sparsity_result update_sparsity(struct unpack_trees_options *o,
+					    struct pattern_list *pl)
 {
 	enum update_sparsity_result ret = UPDATE_SPARSITY_SUCCESS;
-	struct pattern_list pl;
 	int i;
 	unsigned old_show_all_errors;
 	int free_pattern_list = 0;
@@ -2111,11 +2111,12 @@ enum update_sparsity_result update_sparsity(struct unpack_trees_options *o)
 	trace_performance_enter();
 
 	/* If we weren't given patterns, use the recorded ones */
-	if (!o->pl) {
-		memset(&pl, 0, sizeof(pl));
+	if (!pl) {
 		free_pattern_list = 1;
-		populate_from_existing_patterns(o, &pl);
+		pl = xcalloc(1, sizeof(*pl));
+		populate_from_existing_patterns(o, pl);
 	}
+	o->pl = pl;
 
 	/* Expand sparse directories as needed */
 	expand_index(o->src_index, o->pl);
@@ -2147,8 +2148,11 @@ enum update_sparsity_result update_sparsity(struct unpack_trees_options *o)
 
 	display_warning_msgs(o);
 	o->show_all_errors = old_show_all_errors;
-	if (free_pattern_list)
-		clear_pattern_list(&pl);
+	if (free_pattern_list) {
+		clear_pattern_list(pl);
+		free(pl);
+		o->pl = NULL;
+	}
 	trace_performance_leave("update_sparsity");
 	return ret;
 }
diff --git a/unpack-trees.h b/unpack-trees.h
index 3a7b3e5f007..f3a6e4f90ef 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -112,7 +112,8 @@ enum update_sparsity_result {
 	UPDATE_SPARSITY_WORKTREE_UPDATE_FAILURES = -2
 };
 
-enum update_sparsity_result update_sparsity(struct unpack_trees_options *options);
+enum update_sparsity_result update_sparsity(struct unpack_trees_options *options,
+					    struct pattern_list *pl);
 
 int verify_uptodate(const struct cache_entry *ce,
 		    struct unpack_trees_options *o);
-- 
gitgitgadget

