Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DF1C4321E
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 12:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbiK2MBd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 07:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbiK2MAn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 07:00:43 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4032F5CD1C
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 04:00:26 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id x17so21697709wrn.6
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 04:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ucKVYggdyqe1GM9y3Iunw8MVkk85v1VcMUE6nzgC04=;
        b=X++AnydvRAuKM7vefH4YD6TnBrEYXlRHyiPpQceVoiSFYwVfvHpjX7iK/MbNpIYBhI
         t7zLIeBN67T2FfIp1BwVRQjhyewevbSSS5yetTRwxymNGCq/qamiBSJrnJDu+BVyaMkK
         igWAzplbCFoT/njoS3rigAKdt2Paw+dd5iK0SPZvOxaBg3bG6J/H2PKxp9k51LZjq8ab
         Kz9rJpzaTWCleQTZP0o/XJhGLxkZryuKRBHeNGYKgpmUoxl+WP15Rd3PcyNF5ICAajxt
         Bs9QqGMR/G17aJGu6e99jAhNIC9jrMLhhkx2SqgOHs6VDnUozQFnO8wKs1AllH/3HbM+
         DPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ucKVYggdyqe1GM9y3Iunw8MVkk85v1VcMUE6nzgC04=;
        b=J8+Nhr5RtgMEVDfRhUsfYiRZVRb8gntyEDS9D+ED1fWgjqG6rrOcgJbnk1gksF6cBK
         C0lpd/oRdVA8ltZUHuWJYizgi87kdhE8kuBKGOMuAT7Awn4eNTMeCwNXrWwvm0mIUnx/
         q5ZeyS+qezhTNmxzlEtxAAowww+K45hKTuvtlcfd/dCM9QioSUzizNDNE72XKHr0gDiW
         aOc9t/Y/rMCu9RvS5vk+Y7+t3W7qYdCnh+QJGSslZD6Ove68TZLb084C6O7Kl16TCxAn
         e44ZBWoFFqzrjT9AluWIiErjXNUrBRqOvUj58kzme9phIyceTXnz96u72e/HlN3DRzlt
         UPtQ==
X-Gm-Message-State: ANoB5pn5hcKKLfaOefopxYnb5glJu0RYrsGmgWBisA+yqhCwvhMmZsL7
        V5O/52IE2W/RKyeFY67QDeNQQOlOHZM=
X-Google-Smtp-Source: AA0mqf6K12KyVcZ9sLUSu6yv21zKK5QAgn+2pwhkLmrcStxRtOrpvNzMLoCOikNNNG7Z0LJNRoZl3Q==
X-Received: by 2002:a5d:58e2:0:b0:242:1df1:b3ec with SMTP id f2-20020a5d58e2000000b002421df1b3ecmr4033389wrd.697.1669723224242;
        Tue, 29 Nov 2022 04:00:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r11-20020a05600c35cb00b003a84375d0d1sm1976151wmq.44.2022.11.29.04.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 04:00:23 -0800 (PST)
Message-Id: <115d12819c35ee754e7401c5cac31408563c2416.1669723221.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1398.v3.git.1669723221.gitgitgadget@gmail.com>
References: <pull.1398.v2.git.1669344333627.gitgitgadget@gmail.com>
        <pull.1398.v3.git.1669723221.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Nov 2022 12:00:20 +0000
Subject: [PATCH v3 1/2] [RFC] diff: introduce --scope option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Many of git commands, such as "git grep", "git diff", they
will search the "full-tree" scope of the entire git repository,
which is reasonable under normal circumstances, but if the user
uses sparse checkout in a git monorepo, it's very possible that
he just wants to use files within the sparse specification,
perhaps because:

* He wants to be able to focus on his subprojects, the output
of other subprojects will only interfere with him.

* He's using partial cloning at the same time, and he doesn't
want to be able to execute the above git commands download a
large number of blobs which out of sparse specification, which
is a waste of time and may cause the size of the git repository
to gradually expand.

So we need a way to restrict git commands to the sparse
specification. Implementing "diff --scope" is the first step
in this plan. We are looking for a suitable option to choose:
restrict the path scope of diff to the sparse specification
or keep the full tree scope (default action now). "--scope=sparse",
"--scope=all" are the parameters corresponding to these two
cases.

It is worth noting that "--scope" option only works on diff
commands specify "--cached" or "REVISION", because normal
"git diff" has retrict the scope of diff files to the sparse
specificaiton by default, while "git diff --cached" or
"git diff REVSION" will compare to the commit history, and
"--scope" options can works here to restrict or not.

Add "--scope" option to git "diff-index" and "git diff-tree"
too, because they also meet the above: specify "--cached",
or "REVISION". Meanwhile, "git diff-no-index", "git diff-files"
don't have this option.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 Documentation/diff-options.txt   |  33 ++++
 builtin/diff-index.c             |  24 ++-
 builtin/diff-tree.c              |  11 ++
 builtin/diff.c                   |  23 ++-
 cache.h                          |   5 +
 diff-lib.c                       |  43 +++++
 diff.c                           |   2 +
 diff.h                           |   7 +
 dir.c                            |  52 ++++++
 dir.h                            |   4 +
 parse-options.h                  |   7 +
 t/t1090-sparse-checkout-scope.sh | 276 +++++++++++++++++++++++++++++++
 tree-diff.c                      |   7 +
 13 files changed, 488 insertions(+), 6 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 3674ac48e92..778b22ae982 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -195,6 +195,39 @@ For instance, if you configured the `diff.algorithm` variable to a
 non-default value and want to use the default one, then you
 have to use `--diff-algorithm=default` option.
 
+ifdef::git-diff[]
+ifdef::git-diff-index[]
+ifdef::git-diff-tree[]
+
+--scope=[sparse|all]::
+	Restrict or not restrict diff path scope in sparse specification.
+	The variants are as follows:
+
++
+--
+`sparse`;;
+	When using diff to compare commit history, restrict the
+	scope of file path comparisons to the sparse specification.
+	See sparse specification in link:technical/sparse-checkout.html
+	[the sparse-checkout design document] for more information.
+`all`;;
+	When using diff to compare commit history, the file comparison
+	scope is full-tree. This is consistent with the current default
+	behavior.
+--
++
+
+Note that `--scope` option only take effect if diff command specify
+`--cached` or `REVISION`.
+
+The behavior of this `--scope` option is experimental and may change
+in the future. See link:technical/sparse-checkout.html [the sparse-checkout
+design document] for more information.
+
+endif::git-diff-tree[]
+endif::git-diff-index[]
+endif::git-diff[]
+
 --stat[=<width>[,<name-width>[,<count>]]]::
 	Generate a diffstat. By default, as much space as necessary
 	will be used for the filename part, and the rest for the graph
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 35dc9b23eef..27a510c30da 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -20,6 +20,11 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 	int i;
 	int result;
 
+	struct option sparse_scope_options[] = {
+		OPT_SPARSE_SCOPE(&rev.diffopt.scope),
+		OPT_END()
+	};
+
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(diff_cache_usage);
 
@@ -35,6 +40,13 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 	diff_merges_suppress_m_parsing();
 
 	argc = setup_revisions(argc, argv, &rev, NULL);
+
+	argc = parse_options(argc, argv, prefix, sparse_scope_options, NULL,
+			     PARSE_OPT_KEEP_DASHDASH |
+			     PARSE_OPT_KEEP_UNKNOWN_OPT |
+			     PARSE_OPT_KEEP_ARGV0 |
+			     PARSE_OPT_NO_INTERNAL_HELP);
+
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 
@@ -65,9 +77,15 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 			perror("repo_read_index_preload");
 			return -1;
 		}
-	} else if (repo_read_index(the_repository) < 0) {
-		perror("repo_read_index");
-		return -1;
+	} else {
+		if (repo_read_index(the_repository) < 0) {
+			perror("read_cache");
+			return -1;
+		}
+		if (rev.diffopt.scope == SPARSE_SCOPE_SPARSE &&
+		    strcmp(rev.pending.objects[0].name, "HEAD"))
+			diff_collect_changes_index(&rev.diffopt.pathspec,
+						   &rev.diffopt.change_index_files);
 	}
 	result = run_diff_index(&rev, option);
 	result = diff_result_code(&rev.diffopt, result);
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 25b853b85ca..31cac0c2614 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -115,6 +115,11 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 	int read_stdin = 0;
 	int merge_base = 0;
 
+	struct option sparse_scope_options[] = {
+		OPT_SPARSE_SCOPE(&opt->diffopt.scope),
+		OPT_END()
+	};
+
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(diff_tree_usage);
 
@@ -131,6 +136,12 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 	prefix = precompose_argv_prefix(argc, argv, prefix);
 	argc = setup_revisions(argc, argv, opt, &s_r_opt);
 
+	argc = parse_options(argc, argv, prefix, sparse_scope_options, NULL,
+			     PARSE_OPT_KEEP_DASHDASH |
+			     PARSE_OPT_KEEP_UNKNOWN_OPT |
+			     PARSE_OPT_KEEP_ARGV0 |
+			     PARSE_OPT_NO_INTERNAL_HELP);
+
 	memset(&w, 0, sizeof(w));
 	userformat_find_requirements(NULL, &w);
 
diff --git a/builtin/diff.c b/builtin/diff.c
index 163f2c6a874..8c2a847ec94 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -162,9 +162,15 @@ static int builtin_diff_index(struct rev_info *revs,
 			perror("repo_read_index_preload");
 			return -1;
 		}
-	} else if (repo_read_index(the_repository) < 0) {
-		perror("repo_read_cache");
-		return -1;
+	} else {
+		if (repo_read_index(the_repository) < 0) {
+			perror("read_cache");
+			return -1;
+		}
+		if (revs->diffopt.scope == SPARSE_SCOPE_SPARSE &&
+		    strcmp(revs->pending.objects[0].name, "HEAD"))
+			diff_collect_changes_index(&revs->diffopt.pathspec,
+						   &revs->diffopt.change_index_files);
 	}
 	return run_diff_index(revs, option);
 }
@@ -403,6 +409,11 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	int result = 0;
 	struct symdiff sdiff;
 
+	struct option sparse_scope_options[] = {
+		OPT_SPARSE_SCOPE(&rev.diffopt.scope),
+		OPT_END()
+	};
+
 	/*
 	 * We could get N tree-ish in the rev.pending_objects list.
 	 * Also there could be M blobs there, and P pathspecs. --cached may
@@ -507,6 +518,12 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 		diff_setup_done(&rev.diffopt);
 	}
 
+	argc = parse_options(argc, argv, prefix, sparse_scope_options, NULL,
+			     PARSE_OPT_KEEP_DASHDASH |
+			     PARSE_OPT_KEEP_UNKNOWN_OPT |
+			     PARSE_OPT_KEEP_ARGV0 |
+			     PARSE_OPT_NO_INTERNAL_HELP);
+
 	rev.diffopt.flags.recursive = 1;
 	rev.diffopt.rotate_to_strict = 1;
 
diff --git a/cache.h b/cache.h
index 07d40b0964b..2731656573e 100644
--- a/cache.h
+++ b/cache.h
@@ -1058,6 +1058,11 @@ extern int core_apply_sparse_checkout;
 extern int core_sparse_checkout_cone;
 extern int sparse_expect_files_outside_of_patterns;
 
+enum sparse_scope {
+	SPARSE_SCOPE_ALL = 0,
+	SPARSE_SCOPE_SPARSE,
+};
+
 /*
  * Returns the boolean value of $GIT_OPTIONAL_LOCKS (or the default value).
  */
diff --git a/diff-lib.c b/diff-lib.c
index 2edea41a234..d660ecf0c62 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -445,6 +445,13 @@ static void do_oneway_diff(struct unpack_trees_options *o,
 
 	match_missing = revs->match_missing;
 
+	if (revs->diffopt.scope == SPARSE_SCOPE_SPARSE &&
+	    ((o->index_only && revs->pending.objects[0].name &&
+	      strcmp(revs->pending.objects[0].name, "HEAD") &&
+	      !index_file_in_sparse_specification(idx ? idx : tree, &revs->diffopt.change_index_files)) ||
+	     (!o->index_only && !worktree_file_in_sparse_specification(idx))))
+		return;
+
 	if (cached && idx && ce_stage(idx)) {
 		struct diff_filepair *pair;
 		pair = diff_unmerge(&revs->diffopt, idx->name);
@@ -598,6 +605,42 @@ void diff_get_merge_base(const struct rev_info *revs, struct object_id *mb)
 	free_commit_list(merge_bases);
 }
 
+static void diff_collect_updated_cb(struct diff_queue_struct *q,
+					 struct diff_options *options,
+					 void *data) {
+	int i;
+	struct strset *change_index_files = (struct strset *)data;
+
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+
+		strset_add(change_index_files, p->two->path);
+		if (p->status == DIFF_STATUS_RENAMED)
+			strset_add(change_index_files, p->one->path);
+	}
+}
+
+void diff_collect_changes_index(struct pathspec *pathspec, struct strset *change_index_files)
+{
+	struct rev_info rev;
+	struct setup_revision_opt opt;
+
+	repo_init_revisions(the_repository, &rev, NULL);
+	memset(&opt, 0, sizeof(opt));
+	opt.def = "HEAD";
+	setup_revisions(0, NULL, &rev, &opt);
+
+	rev.diffopt.ita_invisible_in_index = 1;
+	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
+	rev.diffopt.format_callback = diff_collect_updated_cb;
+	rev.diffopt.format_callback_data = change_index_files;
+	rev.diffopt.flags.recursive = 1;
+
+	copy_pathspec(&rev.prune_data, pathspec);
+	run_diff_index(&rev, 1);
+	release_revisions(&rev);
+}
+
 int run_diff_index(struct rev_info *revs, unsigned int option)
 {
 	struct object_array_entry *ent;
diff --git a/diff.c b/diff.c
index 1054a4b7329..c719e9779a9 100644
--- a/diff.c
+++ b/diff.c
@@ -4663,6 +4663,7 @@ void repo_diff_setup(struct repository *r, struct diff_options *options)
 	options->color_moved = diff_color_moved_default;
 	options->color_moved_ws_handling = diff_color_moved_ws_default;
 
+	strset_init(&options->change_index_files);
 	prep_parse_options(options);
 }
 
@@ -6514,6 +6515,7 @@ void diff_free(struct diff_options *options)
 	diff_free_ignore_regex(options);
 	clear_pathspec(&options->pathspec);
 	FREE_AND_NULL(options->parseopts);
+	strset_clear(&options->change_index_files);
 }
 
 void diff_flush(struct diff_options *options)
diff --git a/diff.h b/diff.h
index fd33caeb25d..31b255744db 100644
--- a/diff.h
+++ b/diff.h
@@ -8,6 +8,7 @@
 #include "pathspec.h"
 #include "object.h"
 #include "oidset.h"
+#include "strmap.h"
 
 /**
  * The diff API is for programs that compare two sets of files (e.g. two trees,
@@ -285,6 +286,9 @@ struct diff_options {
 	/* diff-filter bits */
 	unsigned int filter, filter_not;
 
+	/* diff sparse-checkout scope */
+	enum sparse_scope scope;
+
 	int use_color;
 
 	/* Number of context lines to generate in patch output. */
@@ -397,6 +401,7 @@ struct diff_options {
 	struct option *parseopts;
 	struct strmap *additional_path_headers;
 
+	struct strset change_index_files;
 	int no_free;
 };
 
@@ -696,4 +701,6 @@ void print_stat_summary(FILE *fp, int files,
 			int insertions, int deletions);
 void setup_diff_pager(struct diff_options *);
 
+void diff_collect_changes_index(struct pathspec *pathspec, struct strset *files);
+
 #endif /* DIFF_H */
diff --git a/dir.c b/dir.c
index d604d1bab98..5d47d5abf1a 100644
--- a/dir.c
+++ b/dir.c
@@ -18,6 +18,7 @@
 #include "ewah/ewok.h"
 #include "fsmonitor.h"
 #include "submodule-config.h"
+#include "parse-options.h"
 
 /*
  * Tells read_directory_recursive how a file or directory should be treated.
@@ -1503,6 +1504,57 @@ int path_in_cone_mode_sparse_checkout(const char *path,
 	return path_in_sparse_checkout_1(path, istate, 1);
 }
 
+int path_in_sparse_patterns(const char *path, int is_dir) {
+	struct strbuf sb = STRBUF_INIT;
+
+	strbuf_addstr(&sb, path);
+	if (!sb.len)
+		return 0;
+	if (is_dir && sb.buf[sb.len - 1] != '/')
+		strbuf_addch(&sb, '/');
+	if (!path_in_sparse_checkout_1(sb.buf,
+				       the_repository->index,
+				       core_sparse_checkout_cone))
+		return 0;
+	strbuf_release(&sb);
+	return 1;
+}
+
+/* Expand sparse-checkout specification (worktree) */
+int worktree_file_in_sparse_specification(const struct cache_entry *worktree_check_ce)
+{
+	return worktree_check_ce && !ce_skip_worktree(worktree_check_ce);
+}
+
+/* Expand sparse-checkout specification (index) */
+int index_file_in_sparse_specification(const struct cache_entry *ce, struct strset *change_index_files)
+{
+	if (!ce->ce_namelen)
+		return 0;
+	if (change_index_files && strset_contains(change_index_files, ce->name))
+		return 1;
+	return path_in_sparse_patterns(ce->name, 0);
+}
+
+int opt_sparse_scope(const struct option *option,
+				const char *optarg, int unset)
+{
+	enum sparse_scope *scope = option->value;
+
+	BUG_ON_OPT_NEG_NOARG(unset, optarg);
+
+	if (!core_apply_sparse_checkout)
+		return error(_("this git repository don't "
+			       "use sparse-checkout, --scope option cannot be used"));
+	if (!strcmp(optarg, "all"))
+		*scope = SPARSE_SCOPE_ALL;
+	else if (!strcmp(optarg, "sparse"))
+		*scope = SPARSE_SCOPE_SPARSE;
+	else
+		return error(_("invalid --scope value: %s"), optarg);
+	return 0;
+}
+
 static struct path_pattern *last_matching_pattern_from_lists(
 		struct dir_struct *dir, struct index_state *istate,
 		const char *pathname, int pathlen,
diff --git a/dir.h b/dir.h
index 674747d93af..14c1bac6e20 100644
--- a/dir.h
+++ b/dir.h
@@ -4,6 +4,7 @@
 #include "cache.h"
 #include "hashmap.h"
 #include "strbuf.h"
+#include "strmap.h"
 
 /**
  * The directory listing API is used to enumerate paths in the work tree,
@@ -401,6 +402,9 @@ int path_in_sparse_checkout(const char *path,
 			    struct index_state *istate);
 int path_in_cone_mode_sparse_checkout(const char *path,
 				      struct index_state *istate);
+int path_in_sparse_patterns(const char *path, int is_dir);
+int index_file_in_sparse_specification(const struct cache_entry *ce, struct strset *change_index_files);
+int worktree_file_in_sparse_specification(const struct cache_entry *worktree_check_ce);
 
 struct dir_entry *dir_add_ignored(struct dir_struct *dir,
 				  struct index_state *istate,
diff --git a/parse-options.h b/parse-options.h
index b6ef86e0d15..37ca2714f87 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -356,6 +356,13 @@ int parse_opt_passthru_argv(const struct option *, const char *, int);
 /* value is enum branch_track* */
 int parse_opt_tracking_mode(const struct option *, const char *, int);
 
+int opt_sparse_scope(const struct option *option,
+				const char *optarg, int unset);
+
+#define OPT_SPARSE_SCOPE(var) OPT_CALLBACK_F(0, "scope", (var), N_("[sparse|all]"), \
+				N_("restrict path scope in sparse specification"), \
+				PARSE_OPT_NONEG, opt_sparse_scope)
+
 #define OPT__VERBOSE(var, h)  OPT_COUNTUP('v', "verbose", (var), (h))
 #define OPT__QUIET(var, h)    OPT_COUNTUP('q', "quiet",   (var), (h))
 #define OPT__VERBOSITY(var) \
diff --git a/t/t1090-sparse-checkout-scope.sh b/t/t1090-sparse-checkout-scope.sh
index 3a14218b245..e6ec8e8c1e4 100755
--- a/t/t1090-sparse-checkout-scope.sh
+++ b/t/t1090-sparse-checkout-scope.sh
@@ -106,4 +106,280 @@ test_expect_success 'in partial clone, sparse checkout only fetches needed blobs
 	test_cmp expect actual
 '
 
+test_expect_success 'setup two' '
+	git init repo &&
+	(
+		cd repo &&
+		mkdir in out1 out2 &&
+		for i in $(test_seq 6)
+		do
+			echo "in $i" >in/"$i" &&
+			echo "out1 $i" >out1/"$i" &&
+			echo "out2 $i" >out2/"$i" || return 1
+		done &&
+		git add in out1 out2 &&
+		git commit -m init &&
+		for i in $(test_seq 6)
+		do
+			echo "in $i" >>in/"$i" &&
+			echo "out1 $i" >>out1/"$i" || return 1
+		done &&
+		git add in out1 &&
+		git commit -m change &&
+		git sparse-checkout set "in"
+	)
+'
+
+reset_sparse_checkout_state() {
+	git -C repo reset --hard HEAD &&
+	git -C repo sparse-checkout reapply
+}
+
+reset_and_change_index() {
+	reset_sparse_checkout_state &&
+	# add new ce
+	oid=$(echo "new thing" | git -C repo hash-object --stdin -w) &&
+	git -C repo update-index --add --cacheinfo 100644 $oid in/7 &&
+	git -C repo update-index --add --cacheinfo 100644 $oid out1/7 &&
+	# rm ce
+	git -C repo update-index --remove in/6 &&
+	git -C repo update-index --remove out1/6 &&
+	# modify ce
+	git -C repo update-index --cacheinfo 100644 $oid out1/5 &&
+	# mv ce1 -> ce2
+	oid=$(git -C repo ls-files --format="%(objectname)" in/4) &&
+	git -C repo update-index --add --cacheinfo 100644 $oid in/8 &&
+	git -C repo update-index --remove in/4 &&
+	oid=$(git -C repo ls-files --format="%(objectname)" out1/4) &&
+	git -C repo update-index --add --cacheinfo 100644 $oid out1/8 &&
+	git -C repo update-index --remove out1/4 &&
+	# chmod ce
+	git -C repo update-index --chmod +x in/3 &&
+	git -C repo update-index --chmod +x out1/3
+}
+
+reset_and_change_worktree() {
+	reset_sparse_checkout_state &&
+	rm -rf repo/out1 repo/out2 &&
+	mkdir repo/out1 repo/out2 &&
+	# add new file
+	echo "in 7" >repo/in/7 &&
+	echo "out1 7" >repo/out1/7 &&
+	git -C repo add --sparse in/7 out1/7 &&
+	# create out old file
+	>repo/out1/6 &&
+	# rm file
+	rm repo/in/6 &&
+	# modify file
+	echo "out1 x" >repo/out1/5 &&
+	# mv file1 -> file2
+	mv repo/in/4 repo/in/3 &&
+	# chmod file
+	chmod +x repo/in/2 &&
+	# add new file, mark skipworktree
+	echo "in 8" >repo/in/8 &&
+	echo "out1 8" >repo/out1/8 &&
+	echo "out2 8" >repo/out2/8 &&
+	git -C repo add --sparse in/8 out1/8 out2/8 &&
+	git -C repo update-index --skip-worktree in/8 &&
+	git -C repo update-index --skip-worktree out1/8 &&
+	git -C repo update-index --skip-worktree out2/8 &&
+	rm repo/in/8 repo/out1/8
+}
+
+# git diff --cached REV
+
+test_expect_success 'git diff --cached --scope=all' '
+	reset_and_change_index &&
+	cat >expected <<-EOF &&
+M	in/1
+M	in/2
+M	in/3
+M	in/4
+M	in/5
+M	in/6
+A	in/7
+A	in/8
+M	out1/1
+M	out1/2
+M	out1/3
+M	out1/5
+D	out1/6
+A	out1/7
+R050	out1/4	out1/8
+	EOF
+	git -C repo diff --name-status --cached --scope=all HEAD~ >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git diff --cached --scope=sparse' '
+	reset_and_change_index &&
+	cat >expected <<-EOF &&
+M	in/1
+M	in/2
+M	in/3
+M	in/4
+M	in/5
+M	in/6
+A	in/7
+A	in/8
+M	out1/3
+M	out1/5
+D	out1/6
+A	out1/7
+R050	out1/4	out1/8
+	EOF
+	git -C repo diff --name-status --cached --scope=sparse HEAD~ >actual &&
+	test_cmp expected actual
+'
+
+# git diff REV
+
+test_expect_success 'git diff REVISION --scope=all' '
+	reset_and_change_worktree &&
+	cat >expected <<-EOF &&
+M	in/1
+M	in/2
+M	in/3
+D	in/4
+M	in/5
+D	in/6
+A	in/7
+M	out1/1
+M	out1/2
+M	out1/3
+M	out1/4
+M	out1/5
+M	out1/6
+A	out1/7
+A	out2/8
+	EOF
+	git -C repo diff --name-status --scope=all HEAD~ >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git diff REVISION --scope=sparse' '
+	reset_and_change_worktree &&
+	cat >expected <<-EOF &&
+M	in/1
+M	in/2
+M	in/3
+D	in/4
+M	in/5
+D	in/6
+A	in/7
+M	out1/5
+M	out1/6
+A	out1/7
+A	out2/8
+	EOF
+	git -C repo diff --name-status --scope=sparse HEAD~ >actual &&
+	test_cmp expected actual
+'
+
+# git diff REV1 REV2
+
+test_expect_success 'git diff two REVISION --scope=all' '
+	reset_sparse_checkout_state &&
+	cat >expected <<-EOF &&
+M	in/1
+M	in/2
+M	in/3
+M	in/4
+M	in/5
+M	in/6
+M	out1/1
+M	out1/2
+M	out1/3
+M	out1/4
+M	out1/5
+M	out1/6
+	EOF
+	git -C repo diff --name-status --scope=all HEAD~ HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git diff two REVISION --scope=sparse' '
+	reset_sparse_checkout_state &&
+	cat >expected <<-EOF &&
+M	in/1
+M	in/2
+M	in/3
+M	in/4
+M	in/5
+M	in/6
+	EOF
+	git -C repo diff --name-status --scope=sparse HEAD~ HEAD >actual &&
+	test_cmp expected actual
+'
+
+# git diff-index
+
+test_expect_success 'git diff-index --cached --scope=all' '
+	reset_and_change_index &&
+	cat >expected <<-EOF &&
+M	in/1
+M	in/2
+M	in/3
+M	in/4
+M	in/5
+M	in/6
+A	in/7
+A	in/8
+M	out1/1
+M	out1/2
+M	out1/3
+D	out1/4
+M	out1/5
+D	out1/6
+A	out1/7
+A	out1/8
+	EOF
+	git -C repo diff-index --name-status --cached --scope=all HEAD~ >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git diff-index --cached --scope=sparse' '
+	reset_and_change_index &&
+	cat >expected <<-EOF &&
+M	in/1
+M	in/2
+M	in/3
+M	in/4
+M	in/5
+M	in/6
+A	in/7
+A	in/8
+M	out1/3
+D	out1/4
+M	out1/5
+D	out1/6
+A	out1/7
+A	out1/8
+	EOF
+	git -C repo diff-index --name-status --cached --scope=sparse HEAD~ >actual &&
+	test_cmp expected actual
+'
+
+# git diff-tree
+
+test_expect_success 'git diff-tree --scope=all' '
+	reset_sparse_checkout_state &&
+	cat >expected <<-EOF &&
+M	in
+M	out1
+	EOF
+	git -C repo diff-tree --name-status --scope=all HEAD~ HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git diff-tree --scope=sparse' '
+	reset_sparse_checkout_state &&
+	cat >expected <<-EOF &&
+M	in
+	EOF
+	git -C repo diff-tree --name-status --scope=sparse HEAD~ HEAD >actual &&
+	test_cmp expected actual
+'
+
 test_done
diff --git a/tree-diff.c b/tree-diff.c
index 69031d7cbae..72ca0ab38bc 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -5,6 +5,7 @@
 #include "diff.h"
 #include "diffcore.h"
 #include "tree.h"
+#include "dir.h"
 
 /*
  * internal mode marker, saying a tree entry != entry of tp[imin]
@@ -76,6 +77,12 @@ static int tree_entry_pathcmp(struct tree_desc *t1, struct tree_desc *t2)
 static int emit_diff_first_parent_only(struct diff_options *opt, struct combine_diff_path *p)
 {
 	struct combine_diff_parent *p0 = &p->parent[0];
+
+	if (opt->scope == SPARSE_SCOPE_SPARSE &&
+	    !path_in_sparse_patterns(p->path,
+				     S_ISDIR(p->mode) ||
+				     S_ISDIR(p0->mode)))
+		return 0;
 	if (p->mode && p0->mode) {
 		opt->change(opt, p0->mode, p->mode, &p0->oid, &p->oid,
 			1, 1, p->path, 0, 0);
-- 
gitgitgadget

