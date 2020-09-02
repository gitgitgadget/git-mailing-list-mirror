Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CB8C433E2
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 06:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B609206C0
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 06:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="sif4C9Nq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgIBGSY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 02:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbgIBGSU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 02:18:20 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915E9C061244
        for <git@vger.kernel.org>; Tue,  1 Sep 2020 23:18:19 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id w186so3395518qkd.1
        for <git@vger.kernel.org>; Tue, 01 Sep 2020 23:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UF6C88903hKDDHik13yeH62wpFrYGOwCxVe0dPt1sJE=;
        b=sif4C9Nqm93E1JOimzm4sEZfRDmxv7Yht0yBvKQ+pTshPR231z9BlE/UeUjUi2Gns4
         QkIHP0Lkx+6hD7dGFBQFX01PLKwSGw+gJJk6ZfmtB2VwjojWoVcFGJjPH0QgohDwD2Mu
         R8ZM8WLKjc0s0fgZ8sAhIJO3tgu9uq+FXhuiTYhtyaASc2hWzpfN7qvZIbSJSKFlofyS
         xwGeiWAHkMxYvcP+GuJBKHEW0/ktvjFDJazBgpjpeFkQqNTuBzgN/zGUlX+FMq6Bhyrp
         sWyDuWoWc6yMLpwKL8Z/sSubDxYLZ3NwrW+78H1Vh/f6Gj+gzgXO/T1br727ZtOZBJnK
         /zlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UF6C88903hKDDHik13yeH62wpFrYGOwCxVe0dPt1sJE=;
        b=Ifsgw2fbeNTEQP9AQ+MgQQNzMi1vSroMIPZpYI1yLRM0LuEK+BSKzsIBGbM1+WL6R3
         GB7cQs+LRKH0XJRV54//aF9qDvTt5eBNCmd4ZD9H4aF3nv5b2bGD46bBwMDze+mPiszE
         SnFnIRZ3ZrOBWAjQd3kOvG8CiKumGbS27/7gqVt99kd6w48iUKv5OvQAzz7vcngvDx1w
         a3rWjtmQ/frLtxg3ESi2QJ2OJDC4BFIPKCuWOcPNR5r3e2AEuW3tEYP1USMy/WdmYEbR
         u7gIcCJgD6TH8VutkyrmqA7eFiPvAtXm2q15i2/CcMDHPutf1U1XeNhBBi0yz/fe6lT5
         d30w==
X-Gm-Message-State: AOAM533At+FATmaK9wFWgo1SbP0Ila+Ua9aFFoxz3TgEm/Sm0Ln83LFB
        pU8JfXR/Ml1GbvtIYrywCy022TIY5Z/IiQ==
X-Google-Smtp-Source: ABdhPJzg0tZ0aQUzNBXBiWfdX6rCRXZk5ge1mseM0i4MUb/XEhXgAUkrAkclpwjsbmLQ1Xg0N6Svmw==
X-Received: by 2002:a05:620a:1257:: with SMTP id a23mr5418994qkl.207.1599027498158;
        Tue, 01 Sep 2020 23:18:18 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:81:83eb::1001])
        by smtp.gmail.com with ESMTPSA id x28sm3731234qki.55.2020.09.01.23.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 23:18:17 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, newren@gmail.com,
        jonathantanmy@google.com, jrnieder@gmail.com
Subject: [PATCH v5 7/8] grep: honor sparse checkout patterns
Date:   Wed,  2 Sep 2020 03:17:36 -0300
Message-Id: <902556a7b60974539ea2ce390bfd8f161d998270.1599026986.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1599026986.git.matheus.bernardino@usp.br>
References: <cover.1599026986.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One of the main uses for a sparse checkout is to allow users to focus on
the subset of files in a repository in which they are interested. But
git-grep currently ignores the sparsity patterns and reports all matches
found outside this subset, which kind of goes in the opposite direction.
There are some use cases for ignoring the sparsity patterns and the next
commit will add an option to obtain this behavior, but here we start by
making grep honor the sparsity boundaries in every case where this is
relevant:

- git grep in worktree
- git grep --cached
- git grep $REVISION

For the worktree and cached cases, we iterate over paths without the
SKIP_WORKTREE bit set, and limit our searches to these paths. For the
$REVISION case, we limit the paths we search to those that match the
sparsity patterns. (We do not check the SKIP_WORKTREE bit for the
$REVISION case, because $REVISION may contain paths that do not exist in
HEAD and thus for which we have no SKIP_WORKTREE bit to consult. The
sparsity patterns tell us how the SKIP_WORKTREE bit would be set if we
were to check out $REVISION, so we consult those. Also, we don't use the
sparsity patterns with the worktree or cached cases, both because we
have a bit we can check directly and more efficiently, and because
unmerged entries from a merge or a rebase could cause more files to
temporarily be present than the sparsity patterns would normally
select.)

Note that there is a special case here: `git grep $TREE`. In this case,
we cannot know whether $TREE corresponds to the root of the repository
or some sub-tree, and thus there is no way for us to know which sparsity
patterns, if any, apply. So the $TREE case will not use sparsity
patterns or any SKIP_WORKTREE bits and will instead always search all
files within the $TREE.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/grep.c                   | 125 ++++++++++++++++++--
 t/t7011-skip-worktree-reading.sh |   9 --
 t/t7817-grep-sparse-checkout.sh  | 195 +++++++++++++++++++++++++++++++
 3 files changed, 312 insertions(+), 17 deletions(-)
 create mode 100755 t/t7817-grep-sparse-checkout.sh

diff --git a/builtin/grep.c b/builtin/grep.c
index f58979bc3f..a32815de0a 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -410,7 +410,7 @@ static int grep_cache(struct grep_opt *opt,
 		      const struct pathspec *pathspec, int cached);
 static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 		     struct tree_desc *tree, struct strbuf *base, int tn_len,
-		     int check_attr);
+		     int is_root_tree);
 
 static int grep_submodule(struct grep_opt *opt,
 			  const struct pathspec *pathspec,
@@ -508,6 +508,10 @@ static int grep_cache(struct grep_opt *opt,
 
 	for (nr = 0; nr < repo->index->cache_nr; nr++) {
 		const struct cache_entry *ce = repo->index->cache[nr];
+
+		if (ce_skip_worktree(ce))
+			continue;
+
 		strbuf_setlen(&name, name_base_len);
 		strbuf_addstr(&name, ce->name);
 
@@ -520,8 +524,7 @@ static int grep_cache(struct grep_opt *opt,
 			 * cache entry are identical, even if worktree file has
 			 * been modified, so use cache version instead
 			 */
-			if (cached || (ce->ce_flags & CE_VALID) ||
-			    ce_skip_worktree(ce)) {
+			if (cached || (ce->ce_flags & CE_VALID)) {
 				if (ce_stage(ce) || ce_intent_to_add(ce))
 					continue;
 				hit |= grep_oid(opt, &ce->oid, name.buf,
@@ -552,9 +555,76 @@ static int grep_cache(struct grep_opt *opt,
 	return hit;
 }
 
-static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
-		     struct tree_desc *tree, struct strbuf *base, int tn_len,
-		     int check_attr)
+static struct pattern_list *get_sparsity_patterns(struct repository *repo)
+{
+	struct pattern_list *patterns;
+	char *sparse_file;
+	int sparse_config, cone_config;
+
+	if (repo_config_get_bool(repo, "core.sparsecheckout", &sparse_config) ||
+	    !sparse_config) {
+		return NULL;
+	}
+
+	sparse_file = repo_git_path(repo, "info/sparse-checkout");
+	patterns = xcalloc(1, sizeof(*patterns));
+
+	if (repo_config_get_bool(repo, "core.sparsecheckoutcone", &cone_config))
+		cone_config = 0;
+	patterns->use_cone_patterns = cone_config;
+
+	if (add_patterns_from_file_to_list(sparse_file, "", 0, patterns, NULL)) {
+		if (file_exists(sparse_file)) {
+			warning(_("failed to load sparse-checkout file: '%s'"),
+				sparse_file);
+		}
+		free(sparse_file);
+		free(patterns);
+		return NULL;
+	}
+
+	free(sparse_file);
+	return patterns;
+}
+
+static int path_in_sparse_checkout(struct strbuf *path, int prefix_len,
+				   unsigned int entry_mode,
+				   struct index_state *istate,
+				   struct pattern_list *sparsity,
+				   enum pattern_match_result parent_match,
+				   enum pattern_match_result *match)
+{
+	int dtype = DT_UNKNOWN;
+	int is_dir = S_ISDIR(entry_mode);
+
+	if (parent_match == MATCHED_RECURSIVE) {
+		*match = parent_match;
+		return 1;
+	}
+
+	if (is_dir && !is_dir_sep(path->buf[path->len - 1]))
+		strbuf_addch(path, '/');
+
+	*match = path_matches_pattern_list(path->buf, path->len,
+					   path->buf + prefix_len, &dtype,
+					   sparsity, istate);
+	if (*match == UNDECIDED)
+		*match = parent_match;
+
+	if (is_dir)
+		strbuf_trim_trailing_dir_sep(path);
+
+	if (*match == NOT_MATCHED &&
+		(!is_dir || (is_dir && sparsity->use_cone_patterns)))
+	     return 0;
+
+	return 1;
+}
+
+static int do_grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
+			struct tree_desc *tree, struct strbuf *base, int tn_len,
+			int check_attr, struct pattern_list *sparsity,
+			enum pattern_match_result default_sparsity_match)
 {
 	struct repository *repo = opt->repo;
 	int hit = 0;
@@ -570,6 +640,7 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 
 	while (tree_entry(tree, &entry)) {
 		int te_len = tree_entry_len(&entry);
+		enum pattern_match_result sparsity_match = 0;
 
 		if (match != all_entries_interesting) {
 			strbuf_addstr(&name, base->buf + tn_len);
@@ -586,6 +657,19 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 
 		strbuf_add(base, entry.path, te_len);
 
+		if (sparsity) {
+			struct strbuf path = STRBUF_INIT;
+			strbuf_addstr(&path, base->buf + tn_len);
+
+			if (!path_in_sparse_checkout(&path, old_baselen - tn_len,
+						     entry.mode, repo->index,
+						     sparsity, default_sparsity_match,
+						     &sparsity_match)) {
+				strbuf_setlen(base, old_baselen);
+				continue;
+			}
+		}
+
 		if (S_ISREG(entry.mode)) {
 			hit |= grep_oid(opt, &entry.oid, base->buf, tn_len,
 					 check_attr ? base->buf + tn_len : NULL);
@@ -602,8 +686,8 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 
 			strbuf_addch(base, '/');
 			init_tree_desc(&sub, data, size);
-			hit |= grep_tree(opt, pathspec, &sub, base, tn_len,
-					 check_attr);
+			hit |= do_grep_tree(opt, pathspec, &sub, base, tn_len,
+					    check_attr, sparsity, sparsity_match);
 			free(data);
 		} else if (recurse_submodules && S_ISGITLINK(entry.mode)) {
 			hit |= grep_submodule(opt, pathspec, &entry.oid,
@@ -621,6 +705,31 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 	return hit;
 }
 
+/*
+ * Note: sparsity patterns and paths' attributes will only be considered if
+ * is_root_tree has true value. (Otherwise, we cannot properly perform pattern
+ * matching on paths.)
+ */
+static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
+		     struct tree_desc *tree, struct strbuf *base, int tn_len,
+		     int is_root_tree)
+{
+	struct pattern_list *patterns = NULL;
+	int ret;
+
+	if (is_root_tree)
+		patterns = get_sparsity_patterns(opt->repo);
+
+	ret = do_grep_tree(opt, pathspec, tree, base, tn_len, is_root_tree,
+			   patterns, 0);
+
+	if (patterns) {
+		clear_pattern_list(patterns);
+		free(patterns);
+	}
+	return ret;
+}
+
 static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 		       struct object *obj, const char *name, const char *path)
 {
diff --git a/t/t7011-skip-worktree-reading.sh b/t/t7011-skip-worktree-reading.sh
index 37525cae3a..26852586ac 100755
--- a/t/t7011-skip-worktree-reading.sh
+++ b/t/t7011-skip-worktree-reading.sh
@@ -109,15 +109,6 @@ test_expect_success 'ls-files --modified' '
 	test -z "$(git ls-files -m)"
 '
 
-test_expect_success 'grep with skip-worktree file' '
-	git update-index --no-skip-worktree 1 &&
-	echo test > 1 &&
-	git update-index 1 &&
-	git update-index --skip-worktree 1 &&
-	rm 1 &&
-	test "$(git grep --no-ext-grep test)" = "1:test"
-'
-
 echo ":000000 100644 $ZERO_OID $EMPTY_BLOB A	1" > expected
 test_expect_success 'diff-index does not examine skip-worktree absent entries' '
 	setup_absent &&
diff --git a/t/t7817-grep-sparse-checkout.sh b/t/t7817-grep-sparse-checkout.sh
new file mode 100755
index 0000000000..b3109e3479
--- /dev/null
+++ b/t/t7817-grep-sparse-checkout.sh
@@ -0,0 +1,195 @@
+#!/bin/sh
+
+test_description='grep in sparse checkout
+
+This test creates a repo with the following structure:
+
+.
+|-- a
+|-- b
+|-- dir
+|   `-- c
+|-- sub
+|   |-- A
+|   |   `-- a
+|   `-- B
+|       `-- b
+`-- sub2
+    `-- a
+
+Where the outer repository has non-cone mode sparsity patterns, sub is a
+submodule with cone mode sparsity patterns and sub2 is a submodule that is
+excluded by the superproject sparsity patterns. The resulting sparse checkout
+should leave the following structure in the working tree:
+
+.
+|-- a
+|-- sub
+|   `-- B
+|       `-- b
+`-- sub2
+    `-- a
+
+But note that sub2 should have the SKIP_WORKTREE bit set.
+'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo "text" >a &&
+	echo "text" >b &&
+	mkdir dir &&
+	echo "text" >dir/c &&
+
+	git init sub &&
+	(
+		cd sub &&
+		mkdir A B &&
+		echo "text" >A/a &&
+		echo "text" >B/b &&
+		git add A B &&
+		git commit -m sub &&
+		git sparse-checkout init --cone &&
+		git sparse-checkout set B
+	) &&
+
+	git init sub2 &&
+	(
+		cd sub2 &&
+		echo "text" >a &&
+		git add a &&
+		git commit -m sub2
+	) &&
+
+	git submodule add ./sub &&
+	git submodule add ./sub2 &&
+	git add a b dir &&
+	git commit -m super &&
+	git sparse-checkout init --no-cone &&
+	git sparse-checkout set "/*" "!b" "!/*/" "sub" &&
+
+	git tag -am tag-to-commit tag-to-commit HEAD &&
+	tree=$(git rev-parse HEAD^{tree}) &&
+	git tag -am tag-to-tree tag-to-tree $tree &&
+
+	test_path_is_missing b &&
+	test_path_is_missing dir &&
+	test_path_is_missing sub/A &&
+	test_path_is_file a &&
+	test_path_is_file sub/B/b &&
+	test_path_is_file sub2/a
+'
+
+# The test below checks a special case: the sparsity patterns exclude '/b'
+# and sparse checkout is enabled, but the path exists in the working tree (e.g.
+# manually created after `git sparse-checkout init`). In this case, grep should
+# skip it.
+test_expect_success 'grep in working tree should honor sparse checkout' '
+	cat >expect <<-EOF &&
+	a:text
+	EOF
+	echo "new-text" >b &&
+	test_when_finished "rm b" &&
+	git grep "text" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'grep unmerged file despite not matching sparsity patterns' '
+	cat >expect <<-EOF &&
+	b:modified-b-in-branchX
+	b:modified-b-in-branchY
+	EOF
+	test_when_finished "test_might_fail git merge --abort && \
+			    git checkout master" &&
+
+	git sparse-checkout disable &&
+	git checkout -b branchY master &&
+	test_commit modified-b-in-branchY b &&
+	git checkout -b branchX master &&
+	test_commit modified-b-in-branchX b &&
+
+	git sparse-checkout init &&
+	test_path_is_missing b &&
+	test_must_fail git merge branchY &&
+	git grep "modified-b" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'grep --cached should honor sparse checkout' '
+	cat >expect <<-EOF &&
+	a:text
+	EOF
+	git grep --cached "text" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'grep <commit-ish> should honor sparse checkout' '
+	commit=$(git rev-parse HEAD) &&
+	cat >expect_commit <<-EOF &&
+	$commit:a:text
+	EOF
+	cat >expect_tag-to-commit <<-EOF &&
+	tag-to-commit:a:text
+	EOF
+	git grep "text" $commit >actual_commit &&
+	test_cmp expect_commit actual_commit &&
+	git grep "text" tag-to-commit >actual_tag-to-commit &&
+	test_cmp expect_tag-to-commit actual_tag-to-commit
+'
+
+test_expect_success 'grep <tree-ish> should ignore sparsity patterns' '
+	commit=$(git rev-parse HEAD) &&
+	tree=$(git rev-parse HEAD^{tree}) &&
+	cat >expect_tree <<-EOF &&
+	$tree:a:text
+	$tree:b:text
+	$tree:dir/c:text
+	EOF
+	cat >expect_tag-to-tree <<-EOF &&
+	tag-to-tree:a:text
+	tag-to-tree:b:text
+	tag-to-tree:dir/c:text
+	EOF
+	git grep "text" $tree >actual_tree &&
+	test_cmp expect_tree actual_tree &&
+	git grep "text" tag-to-tree >actual_tag-to-tree &&
+	test_cmp expect_tag-to-tree actual_tag-to-tree
+'
+
+# Note that sub2/ is present in the worktree but it is excluded by the sparsity
+# patterns, so grep should not recurse into it.
+test_expect_success 'grep --recurse-submodules should honor sparse checkout in submodule' '
+	cat >expect <<-EOF &&
+	a:text
+	sub/B/b:text
+	EOF
+	git grep --recurse-submodules "text" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'grep --recurse-submodules --cached should honor sparse checkout in submodule' '
+	cat >expect <<-EOF &&
+	a:text
+	sub/B/b:text
+	EOF
+	git grep --recurse-submodules --cached "text" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'grep --recurse-submodules <commit-ish> should honor sparse checkout in submodule' '
+	commit=$(git rev-parse HEAD) &&
+	cat >expect_commit <<-EOF &&
+	$commit:a:text
+	$commit:sub/B/b:text
+	EOF
+	cat >expect_tag-to-commit <<-EOF &&
+	tag-to-commit:a:text
+	tag-to-commit:sub/B/b:text
+	EOF
+	git grep --recurse-submodules "text" $commit >actual_commit &&
+	test_cmp expect_commit actual_commit &&
+	git grep --recurse-submodules "text" tag-to-commit >actual_tag-to-commit &&
+	test_cmp expect_tag-to-commit actual_tag-to-commit
+'
+
+test_done
-- 
2.28.0

