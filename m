Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220621B598
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 08:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708677276; cv=none; b=QXPN5RebamhhZbT5Bf/DCWLPM1mdXZptdqA23mCSmdR2R/k2JcCMe4LIe+387ccN0gsXqal84BZHMZnKIAglWzQAHDKTNi1PBll6w4GRYvgV9BdpJJOaq8Y2W+uTrw5rw2eGJtKvph2h/HrNc+9IXtET1c4vYVQ/6JR8ZwE4KEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708677276; c=relaxed/simple;
	bh=xFO640Fh+rm1jbBaHe53rGrBWZjTCVBI5rQIe52HUig=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=C7zCV1FZWDP+z1M1FGn3BQIBSaclyzxsx+92qUSiWZWNT/eDlAyHPTAXBboIeueYUxC3DYoaSL9G5ddbTfVI3J67QVNTCUH4z2zBolmAnAlUR3Lg/5PZikjySm07i1A8ZZ0wEd3Wq1WJ960VrNQcS5wFPPXSmAMvlj8+FJhz0rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOXdru9i; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOXdru9i"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-512b13bf764so856210e87.0
        for <git@vger.kernel.org>; Fri, 23 Feb 2024 00:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708677271; x=1709282071; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkH4jreFEObzu448xaus0SGNLlqiivck8SqNOgYuHfw=;
        b=nOXdru9iGSGRqlUopQt5laYLYNoC/lbrQoRPMV8+yIKaAqQuvLY4jDVxsCNhReVeQr
         NBbPARWX8H+OkgjQeha2rLPZxtuaSHEs8xwSIyhj7JUaQ+GLXNNE50XEdpTnD2X1JDG1
         zTa80vDi6e8n6irco8NSQhw1WeIS+VIc6rGz6B4M2G6QjlSF+tlyF9pWnliYFi2Rlgqb
         44Drmr2MYfeBPTt2bGoOvfB/T+QomphqoZyQM2oEMJ1PNXQtfdp0Jo1JNxtfsT7NiNqz
         JTQXbjQ3Ty2v/DUaIVuYLqcu+cYhhf+D4SGU0Xs5w9qLigjMJ6xZYe18svvgTFwkVEw2
         hUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708677271; x=1709282071;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TkH4jreFEObzu448xaus0SGNLlqiivck8SqNOgYuHfw=;
        b=eL4gTwvt+r5kK5C8WlOqzh4YqF3x57pz5+Glx4vyurcFr13ovVPhcRormykvETcAyt
         c7ip+lngyAoOQdRuAb9UT6w7eds35EaRmBfgwia52ur4WQ5jws0bc22ERIkf1ldDWcmj
         qENcyAWntpLttirCNUNPoRi7d3eZbEjte6cl1FK1SOLPUEHF3PE2w9evPIhgaplNZnap
         ErPQOIjkZyXjTNGXKCd63J+NTZmCO6+WXFIrXBmI+zMNX8UarCZ/BC5VY6UTM2E0RIb8
         SRPhLUqdLCxSNczH+BDANR7RUvGGmDZ/D4Gdrlec5BVs2h1N7iYnn+Ghks6y1QOpDq9N
         Af5g==
X-Gm-Message-State: AOJu0YxFM+/zx+G2YpcIb8FhWVgy6ISF/NBxc5k2OG8M8C8JU4jvto5B
	f/kG4fgWpN8Ihtfc0fZdnGZDRvrQB/Fmscy4zfwNB7oYCoAeKkyYFrODlfJQ
X-Google-Smtp-Source: AGHT+IHqVrNAg4I50tl13Jk4ykKQGaq6evD11czwJ+vSmh9IWGMbHJEKQutjWJ5vdN1hXEjms38AKA==
X-Received: by 2002:a05:6512:2394:b0:512:e303:c034 with SMTP id c20-20020a056512239400b00512e303c034mr1303872lfv.7.1708677270693;
        Fri, 23 Feb 2024 00:34:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l6-20020a1c7906000000b0040fddaf9ff4sm1443435wme.40.2024.02.23.00.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 00:34:30 -0800 (PST)
Message-ID: <5942c27f4390d5bafea0a63f71b1193a57e8e770.1708677266.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1651.v4.git.1708677266.gitgitgadget@gmail.com>
References: <pull.1651.v3.git.1708612605.gitgitgadget@gmail.com>
	<pull.1651.v4.git.1708677266.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Feb 2024 08:34:23 +0000
Subject: [PATCH v4 4/6] Always check `parse_tree*()`'s return value
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
    Eric Sunshine <sunshine@sunshineco.com>,
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
index f02434bc155..9ab0901d629 100644
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
+			return error(_("unable to read tree (%s)"),
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
+			die(_("unable to read tree (%s)"), oid_to_hex(rev));
 	} else {
 		parse_commit_or_die(new_branch_info->commit);
 		*source_tree = repo_get_commit_tree(the_repository,
 						    new_branch_info->commit);
+		if (!*source_tree)
+			die(_("unable to read tree (%s)"),
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
index 2d4ce5b3886..3492a575a6c 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -447,12 +447,18 @@ static int real_merge(struct merge_tree_options *o,
 		if (repo_get_oid_treeish(the_repository, merge_base, &base_oid))
 			die(_("could not parse as tree '%s'"), merge_base);
 		base_tree = parse_tree_indirect(&base_oid);
+		if (!base_tree)
+			die(_("unable to read tree (%s)"), oid_to_hex(&base_oid));
 		if (repo_get_oid_treeish(the_repository, branch1, &head_oid))
 			die(_("could not parse as tree '%s'"), branch1);
 		parent1_tree = parse_tree_indirect(&head_oid);
+		if (!parent1_tree)
+			die(_("unable to read tree (%s)"), oid_to_hex(&head_oid));
 		if (repo_get_oid_treeish(the_repository, branch2, &merge_oid))
 			die(_("could not parse as tree '%s'"), branch2);
 		parent2_tree = parse_tree_indirect(&merge_oid);
+		if (!parent2_tree)
+			die(_("unable to read tree (%s)"), oid_to_hex(&merge_oid));
 
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
index 4b018d20e3b..fd36fc5bd95 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -119,6 +119,10 @@ static int reset_index(const char *ref, const struct object_id *oid, int reset_t
 
 	if (reset_type == MIXED || reset_type == HARD) {
 		tree = parse_tree_indirect(oid);
+		if (!tree) {
+			error(_("unable to read tree (%s)"), oid_to_hex(oid));
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
index 79d9e18f63d..910ba38ff05 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4983,6 +4983,9 @@ static void merge_ort_nonrecursive_internal(struct merge_options *opt,
 
 	if (result->clean >= 0) {
 		result->tree = parse_tree_indirect(&working_tree_oid);
+		if (!result->tree)
+			die(_("unable to read tree (%s)"),
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
index 48da0adf851..080bcb6d656 100644
--- a/reset.c
+++ b/reset.c
@@ -158,6 +158,11 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
 	}
 
 	tree = parse_tree_indirect(oid);
+	if (!tree) {
+		ret = error(_("unable to read tree (%s)"), oid_to_hex(oid));
+		goto leave_reset_head;
+	}
+
 	prime_cache_tree(r, r->index, tree);
 
 	if (write_locked_index(r->index, &lock, COMMIT_LOCK) < 0) {
diff --git a/sequencer.c b/sequencer.c
index d584cac8ed9..33d12b2ffd1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -715,6 +715,8 @@ static int do_recursive_merge(struct repository *r,
 	o.show_rename_progress = 1;
 
 	head_tree = parse_tree_indirect(head);
+	if (!head_tree)
+		return error(_("unable to read tree (%s)"), oid_to_hex(head));
 	next_tree = next ? repo_get_commit_tree(r, next) : empty_tree(r);
 	base_tree = base ? repo_get_commit_tree(r, base) : empty_tree(r);
 
@@ -3887,6 +3889,8 @@ static int do_reset(struct repository *r,
 	}
 
 	tree = parse_tree_indirect(&oid);
+	if (!tree)
+		return error(_("unable to read tree (%s)"), oid_to_hex(&oid));
 	prime_cache_tree(r, r->index, tree);
 
 	if (write_locked_index(r->index, &lock, COMMIT_LOCK) < 0)
-- 
gitgitgadget

