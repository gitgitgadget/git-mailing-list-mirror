Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9538A823C3
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 16:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707324471; cv=none; b=tQ6zpbrIMljLUze4v+AvLJnglfLXvyfnJ29w5E2nGEmFv21vcZ+pBsYKgaPEArzcIfqP80q5yZv9uOz6quGM61nnhwG32zIA64jYOqg45xlc5hzOuEda1Sa32uPMMm2tPwO3bWLObbQHjogpanQ/NsKjaAYlosJ1NC858rRO3lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707324471; c=relaxed/simple;
	bh=6aEUjPpwEbnaYV3kXz/jrdo3l6oDJIDXkOyJXDDAdhY=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=W5cU+ftNHnpGEfk+KZklvnzp5iIijFy1mQdEk3V9KoyOUmgtC8EMugPsgINtKJzaLbM0Ejy81mG6vTq7D6b6cKT2R4wVJ/WhFdLqSgzeNiqKQ9z9wQvV59MR6iCvMdkI7duy1gyLnCzm8E/FZW4k1kLV7mY4Fjc+pXw2zybfWDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRCH4Qjc; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRCH4Qjc"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4101fc00832so3743815e9.3
        for <git@vger.kernel.org>; Wed, 07 Feb 2024 08:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707324467; x=1707929267; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ad2cPhi69GjEqH2CIRTbzXTU/IPqUZKRLZ5wvFohiWs=;
        b=MRCH4QjcpmpPFYg7HFmW920ZOj7rrRsaSRxH9uD/ogNA9/FxXKISXwyBbTnuknUwHI
         l1I5AZUZ13Rt+tjj57LHovfpZKf+dan859ut4gAYvZKxqvylDk4jQQ78Fu4xOoiwZ86b
         FYAz1w9dr4dgEteVc8Tn9NsQO0oZpUNlSmeh2S5f8ZQRrPm7Taa49fzhL0m3K1Dz8ljm
         9LzPW4HyfYoY6nEBUN/dJO1AtboCCQwu9C4tDwIQki1o7TLBkQLeunBtQt2KiXsjrM6X
         XkHpTTA/d9bXSI77W/WxWTLGWWfAjfor7Dz10ctNlZrJE8WT7RKiKPwzBpTHb5Ln1FAJ
         cCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707324467; x=1707929267;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ad2cPhi69GjEqH2CIRTbzXTU/IPqUZKRLZ5wvFohiWs=;
        b=Y7xke7SysfpyEuA2MGrSMEpQufi6XblY2RxfcxWjj/bYsKSwQ4wpiWJsv+dsMyh9Zz
         QoozvBAGRp6ZsH3jlsmazQWxwd8KbpoipwbZeMWMJ8oyE+peFEgjLFuyQqiR4adZME45
         HLUKnHfj5DKvtYj8D9z7IycTxNF4/1Jg0meLUKxfnPQy7PSI5mfJycKbnlOUHY6PEsqF
         cRZwi5ktk9XjP7pdqV9YfbOFaNwZbRgMeCXqFWmfIO0zn0vmSS8GZB5ZM8rN17zZPeXX
         DFKVHm6LKI80XaOyiIXoZIB//tPTDaUD9ZMIiSicZpBuXD4VbgUTY8CCpOI4mDqC1vI2
         MvaQ==
X-Gm-Message-State: AOJu0YxI1TRjA7nwvfho6Mnmu4xaZrCsncf/itUwofOoRBUVza1LU4ff
	SXOFMuGnxVTgYZnANx/hIDHNenlWIxs4BgtVEVDXUNaXuQvQAb5vxNsxEgIr
X-Google-Smtp-Source: AGHT+IEoES3v/C6ePWsNrs/x43zjcKSFBC4o9IbjlYhRAinf2faH1neQHEC6tDa1lkFC3vF08Lv3UQ==
X-Received: by 2002:a05:600c:3d93:b0:410:219f:121b with SMTP id bi19-20020a05600c3d9300b00410219f121bmr645955wmb.21.1707324467408;
        Wed, 07 Feb 2024 08:47:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWybh4Cr5NUdAgI1FiGEsqhdAWjKH5pRydUR5x/rqef9gOvmROrHfB1cBoCKgroOMqxfIoxSfjUKx7oyaQ8edQUhUg+NLXT0TnWyw==
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fa25-20020a05600c519900b0041022558ac2sm743225wmb.18.2024.02.07.08.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 08:47:46 -0800 (PST)
Message-ID: <ffd38ad602a53dfe72cdbfe0d098ca43e7443895.1707324462.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1651.v2.git.1707324461.gitgitgadget@gmail.com>
References: <pull.1651.git.1707212981.gitgitgadget@gmail.com>
	<pull.1651.v2.git.1707324461.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 07 Feb 2024 16:47:40 +0000
Subject: [PATCH v2 4/5] Always check `parse_tree*()`'s return value
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Otherwise we may easily run into serious crashes: For example, if we run
`init_tree_desc()` directly after a failed `parse_tree()`, we are
accessing uninitialized data or trying to dereference `NULL`.

Note that the `parse_tree()` function already takes care of showing an
error message. The `parse_tree_indirectly()` and
`repo_get_commit_tree()` functions do not, therefore those latter call
sites need to show a useful error message while the former do not.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/checkout.c   | 19 ++++++++++++++++---
 builtin/clone.c      |  3 ++-
 builtin/commit.c     |  3 ++-
 builtin/merge-tree.c |  6 ++++++
 builtin/read-tree.c  |  3 ++-
 builtin/reset.c      |  4 ++++
 cache-tree.c         |  4 ++--
 merge-ort.c          |  3 +++
 merge-recursive.c    |  3 ++-
 merge.c              |  5 ++++-
 reset.c              |  5 +++++
 sequencer.c          |  4 ++++
 12 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index f02434bc155..84108ec3635 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -707,7 +707,8 @@ static int reset_tree(struct tree *tree, const struct checkout_opts *o,
 	init_checkout_metadata(&opts.meta, info->refname,
 			       info->commit ? &info->commit->object.oid : null_oid(),
 			       NULL);
-	parse_tree(tree);
+	if (parse_tree(tree) < 0)
+		return 128;
 	init_tree_desc(&tree_desc, tree->buffer, tree->size);
 	switch (unpack_trees(1, &tree_desc, &opts)) {
 	case -2:
@@ -786,9 +787,15 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		if (new_branch_info->commit)
 			BUG("'switch --orphan' should never accept a commit as starting point");
 		new_tree = parse_tree_indirect(the_hash_algo->empty_tree);
-	} else
+		if (!new_tree)
+			BUG("unable to read empty tree");
+	} else {
 		new_tree = repo_get_commit_tree(the_repository,
 						new_branch_info->commit);
+		if (!new_tree)
+			return error(_("unable to read tree %s"),
+				     oid_to_hex(&new_branch_info->commit->object.oid));
+	}
 	if (opts->discard_changes) {
 		ret = reset_tree(new_tree, opts, 1, writeout_error, new_branch_info);
 		if (ret)
@@ -823,7 +830,8 @@ static int merge_working_tree(const struct checkout_opts *opts,
 				oid_to_hex(old_commit_oid));
 
 		init_tree_desc(&trees[0], tree->buffer, tree->size);
-		parse_tree(new_tree);
+		if (parse_tree(new_tree) < 0)
+			exit(128);
 		tree = new_tree;
 		init_tree_desc(&trees[1], tree->buffer, tree->size);
 
@@ -1239,10 +1247,15 @@ static void setup_new_branch_info_and_source_tree(
 	if (!new_branch_info->commit) {
 		/* not a commit */
 		*source_tree = parse_tree_indirect(rev);
+		if (!*source_tree)
+			die(_("unable to read tree %s"), oid_to_hex(rev));
 	} else {
 		parse_commit_or_die(new_branch_info->commit);
 		*source_tree = repo_get_commit_tree(the_repository,
 						    new_branch_info->commit);
+		if (!*source_tree)
+			die(_("unable to read tree %s"),
+			    oid_to_hex(&new_branch_info->commit->object.oid));
 	}
 }
 
diff --git a/builtin/clone.c b/builtin/clone.c
index c6357af9498..4410b55be98 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -736,7 +736,8 @@ static int checkout(int submodule_progress, int filter_submodules)
 	tree = parse_tree_indirect(&oid);
 	if (!tree)
 		die(_("unable to parse commit %s"), oid_to_hex(&oid));
-	parse_tree(tree);
+	if (parse_tree(tree) < 0)
+		exit(128);
 	init_tree_desc(&t, tree->buffer, tree->size);
 	if (unpack_trees(1, &t, &opts) < 0)
 		die(_("unable to checkout working tree"));
diff --git a/builtin/commit.c b/builtin/commit.c
index 781af2e206c..0723f06de7a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -339,7 +339,8 @@ static void create_base_index(const struct commit *current_head)
 	tree = parse_tree_indirect(&current_head->object.oid);
 	if (!tree)
 		die(_("failed to unpack HEAD tree object"));
-	parse_tree(tree);
+	if (parse_tree(tree) < 0)
+		exit(128);
 	init_tree_desc(&t, tree->buffer, tree->size);
 	if (unpack_trees(1, &t, &opts))
 		exit(128); /* We've already reported the error, finish dying */
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 2d4ce5b3886..ba84d00deee 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -447,12 +447,18 @@ static int real_merge(struct merge_tree_options *o,
 		if (repo_get_oid_treeish(the_repository, merge_base, &base_oid))
 			die(_("could not parse as tree '%s'"), merge_base);
 		base_tree = parse_tree_indirect(&base_oid);
+		if (!base_tree)
+			die(_("unable to read tree %s"), oid_to_hex(&base_oid));
 		if (repo_get_oid_treeish(the_repository, branch1, &head_oid))
 			die(_("could not parse as tree '%s'"), branch1);
 		parent1_tree = parse_tree_indirect(&head_oid);
+		if (!parent1_tree)
+			die(_("unable to read tree %s"), oid_to_hex(&head_oid));
 		if (repo_get_oid_treeish(the_repository, branch2, &merge_oid))
 			die(_("could not parse as tree '%s'"), branch2);
 		parent2_tree = parse_tree_indirect(&merge_oid);
+		if (!parent2_tree)
+			die(_("unable to read tree %s"), oid_to_hex(&merge_oid));
 
 		opt.ancestor = merge_base;
 		merge_incore_nonrecursive(&opt, base_tree, parent1_tree, parent2_tree, &result);
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 8196ca9dd85..5923ed36893 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -263,7 +263,8 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 	cache_tree_free(&the_index.cache_tree);
 	for (i = 0; i < nr_trees; i++) {
 		struct tree *tree = trees[i];
-		parse_tree(tree);
+		if (parse_tree(tree) < 0)
+			return 128;
 		init_tree_desc(t+i, tree->buffer, tree->size);
 	}
 	if (unpack_trees(nr_trees, t, &opts))
diff --git a/builtin/reset.c b/builtin/reset.c
index 4b018d20e3b..f030f57f4e9 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -119,6 +119,10 @@ static int reset_index(const char *ref, const struct object_id *oid, int reset_t
 
 	if (reset_type == MIXED || reset_type == HARD) {
 		tree = parse_tree_indirect(oid);
+		if (!tree) {
+			error(_("unable to read tree %s"), oid_to_hex(oid));
+			goto out;
+		}
 		prime_cache_tree(the_repository, the_repository->index, tree);
 	}
 
diff --git a/cache-tree.c b/cache-tree.c
index 641427ed410..c6508b64a5c 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -779,8 +779,8 @@ static void prime_cache_tree_rec(struct repository *r,
 			struct cache_tree_sub *sub;
 			struct tree *subtree = lookup_tree(r, &entry.oid);
 
-			if (!subtree->object.parsed)
-				parse_tree(subtree);
+			if (!subtree->object.parsed && parse_tree(subtree) < 0)
+				exit(128);
 			sub = cache_tree_sub(it, entry.path);
 			sub->cache_tree = cache_tree();
 
diff --git a/merge-ort.c b/merge-ort.c
index 79d9e18f63d..534ddaf16ba 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4983,6 +4983,9 @@ static void merge_ort_nonrecursive_internal(struct merge_options *opt,
 
 	if (result->clean >= 0) {
 		result->tree = parse_tree_indirect(&working_tree_oid);
+		if (!result->tree)
+			die(_("unable to read tree %s"),
+			    oid_to_hex(&working_tree_oid));
 		/* existence of conflicted entries implies unclean */
 		result->clean &= strmap_empty(&opt->priv->conflicted);
 	}
diff --git a/merge-recursive.c b/merge-recursive.c
index e3beb0801b1..10d41bfd487 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -410,7 +410,8 @@ static inline int merge_detect_rename(struct merge_options *opt)
 
 static void init_tree_desc_from_tree(struct tree_desc *desc, struct tree *tree)
 {
-	parse_tree(tree);
+	if (parse_tree(tree) < 0)
+		exit(128);
 	init_tree_desc(desc, tree->buffer, tree->size);
 }
 
diff --git a/merge.c b/merge.c
index b60925459c2..14a7325859d 100644
--- a/merge.c
+++ b/merge.c
@@ -80,7 +80,10 @@ int checkout_fast_forward(struct repository *r,
 		return -1;
 	}
 	for (i = 0; i < nr_trees; i++) {
-		parse_tree(trees[i]);
+		if (parse_tree(trees[i]) < 0) {
+			rollback_lock_file(&lock_file);
+			return -1;
+		}
 		init_tree_desc(t+i, trees[i]->buffer, trees[i]->size);
 	}
 
diff --git a/reset.c b/reset.c
index 48da0adf851..a93fdbc12e3 100644
--- a/reset.c
+++ b/reset.c
@@ -158,6 +158,11 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
 	}
 
 	tree = parse_tree_indirect(oid);
+	if (!tree) {
+		ret = error(_("unable to read tree %s"), oid_to_hex(oid));
+		goto leave_reset_head;
+	}
+
 	prime_cache_tree(r, r->index, tree);
 
 	if (write_locked_index(r->index, &lock, COMMIT_LOCK) < 0) {
diff --git a/sequencer.c b/sequencer.c
index d584cac8ed9..407473bab28 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -715,6 +715,8 @@ static int do_recursive_merge(struct repository *r,
 	o.show_rename_progress = 1;
 
 	head_tree = parse_tree_indirect(head);
+	if (!head_tree)
+		return error(_("unable to read tree %s"), oid_to_hex(head));
 	next_tree = next ? repo_get_commit_tree(r, next) : empty_tree(r);
 	base_tree = base ? repo_get_commit_tree(r, base) : empty_tree(r);
 
@@ -3887,6 +3889,8 @@ static int do_reset(struct repository *r,
 	}
 
 	tree = parse_tree_indirect(&oid);
+	if (!tree)
+		return error(_("unable to read tree %s"), oid_to_hex(&oid));
 	prime_cache_tree(r, r->index, tree);
 
 	if (write_locked_index(r->index, &lock, COMMIT_LOCK) < 0)
-- 
gitgitgadget

