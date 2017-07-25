Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29C0D1F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 21:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751635AbdGYVkH (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 17:40:07 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33500 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751681AbdGYVkE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 17:40:04 -0400
Received: by mail-pf0-f178.google.com with SMTP id s70so63050187pfs.0
        for <git@vger.kernel.org>; Tue, 25 Jul 2017 14:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7oSBaTOqReot/le+EM4Eg4l09PzRM3XfFv8Scl2NcNI=;
        b=bhyLsboHEbZ1KkoNpb98PhjytJ/76PXZ6Rz9dPTsqwleCWGDQXIBx3GXAci/jPaq8X
         w4Jxaf8BYkbEV/JAfNY4DhHVZzLbdWeF1/DzLdPMqq+uSF0V3ykqKJXyXRrxcnQmKXF/
         xMuWudjj1Amv7LQeE6PwpeOZVUn0+uz9XJHpRR4QJDfOYbk1jJBWZ6fKUXKdn+PNRHNU
         VvNJQmpeGy8o9rl/k1WA/lqruUNnqYUIXk7mIKa4+5duQWjHUB9mk2vYPart0YeBbFTI
         MsVXDGDWFeCcwmg5pfw+3eUbeghA16Udzp9ymNzg4I6AAEYyUIaOIPeOnAB93tm9wIBS
         tFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7oSBaTOqReot/le+EM4Eg4l09PzRM3XfFv8Scl2NcNI=;
        b=JL3BnZw45UBVRnIfzD55WTJ8326G2MGmBQAGaXah51ro2l0gekeh210whI2xrn1908
         o3oqleTpKvEGlCbpViZLXzd4yuvxtF3etCjdmlaw2E7SvhgNabXt4xoWyzIyB0Ehv19q
         v/i1LcU6lIyw4Pud8F2lTTev/WFh6sBXDkXdGD/6OOuDteTjFmDMAYVh261QxPveQ0I9
         V/EUMwwpykctRrsGLk2hd7OoffMyfjsuRGFulo25yMNWP19nK0wb85skgl+fYxKqQWph
         sooKRY0Vy3FPBNAO8W0le7UmIPI2wdFseDaMXO7t2viypJhotErbRtpuX/DAHRY7IPwd
         QUAA==
X-Gm-Message-State: AIVw113Obeok+N6tLPB2lNyV9vEHZ25xnyJD5OkghwrfhNyLHM4xFXZ/
        66iEFaAPEYp+Pz7jDLOTYg==
X-Received: by 10.99.186.30 with SMTP id k30mr4520674pgf.87.1501018803719;
        Tue, 25 Jul 2017 14:40:03 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id m186sm27068839pfc.54.2017.07.25.14.40.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Jul 2017 14:40:02 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 15/15] submodule: remove gitmodules_config
Date:   Tue, 25 Jul 2017 14:39:28 -0700
Message-Id: <20170725213928.125998-16-bmwill@google.com>
X-Mailer: git-send-email 2.14.0.rc0.400.g1c36432dff-goog
In-Reply-To: <20170725213928.125998-1-bmwill@google.com>
References: <20170725213928.125998-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that the submodule-config subsystem can lazily read the gitmodules
file we no longer need to explicitly pre-read the gitmodules by calling
'gitmodules_config()' so let's remove it.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/checkout.c               |  1 -
 builtin/commit.c                 |  1 -
 builtin/diff-files.c             |  1 -
 builtin/diff-index.c             |  1 -
 builtin/diff-tree.c              |  1 -
 builtin/diff.c                   |  2 --
 builtin/fetch.c                  |  4 ----
 builtin/grep.c                   |  4 ----
 builtin/mv.c                     |  1 -
 builtin/read-tree.c              |  2 --
 builtin/reset.c                  |  2 --
 builtin/rm.c                     |  1 -
 builtin/submodule--helper.c      | 14 --------------
 submodule.c                      | 15 ---------------
 submodule.h                      |  2 --
 t/helper/test-submodule-config.c |  1 -
 16 files changed, 53 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 246e0cd16..63ae16afc 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1179,7 +1179,6 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	opts.prefix = prefix;
 	opts.show_progress = -1;
 
-	gitmodules_config();
 	git_config(git_checkout_config, &opts);
 
 	opts.track = BRANCH_TRACK_UNSPECIFIED;
diff --git a/builtin/commit.c b/builtin/commit.c
index 4bbac014a..18ad714d9 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -195,7 +195,6 @@ static void determine_whence(struct wt_status *s)
 static void status_init_config(struct wt_status *s, config_fn_t fn)
 {
 	wt_status_prepare(s);
-	gitmodules_config();
 	git_config(fn, s);
 	determine_whence(s);
 	init_diff_ui_defaults();
diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 17bf84d18..e88493ffe 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -26,7 +26,6 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	init_revisions(&rev, prefix);
-	gitmodules_config();
 	rev.abbrev = 0;
 	precompose_argv(argc, argv);
 
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 185e6f9b5..9d772f8f2 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -23,7 +23,6 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	init_revisions(&rev, prefix);
-	gitmodules_config();
 	rev.abbrev = 0;
 	precompose_argv(argc, argv);
 
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 31d2cb410..d66499909 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -110,7 +110,6 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	init_revisions(opt, prefix);
-	gitmodules_config();
 	opt->abbrev = 0;
 	opt->diff = 1;
 	opt->disable_stdin = 1;
diff --git a/builtin/diff.c b/builtin/diff.c
index 7cde6abbc..7e3ebcea3 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -315,8 +315,6 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 			no_index = DIFF_NO_INDEX_IMPLICIT;
 	}
 
-	if (!no_index)
-		gitmodules_config();
 	init_diff_ui_defaults();
 	git_config(git_diff_ui_config, NULL);
 	precompose_argv(argc, argv);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 3fe99073d..132e3224e 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1360,10 +1360,6 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	if (depth || deepen_since || deepen_not.nr)
 		deepen = 1;
 
-	if (recurse_submodules != RECURSE_SUBMODULES_OFF) {
-		gitmodules_config();
-	}
-
 	if (all) {
 		if (argc == 1)
 			die(_("fetch --all does not take a repository argument"));
diff --git a/builtin/grep.c b/builtin/grep.c
index ac06d2d33..2d65f27d0 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1048,10 +1048,6 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	}
 #endif
 
-	if (recurse_submodules) {
-		gitmodules_config();
-	}
-
 	if (show_in_pager && (cached || list.nr))
 		die(_("--open-files-in-pager only works on the worktree"));
 
diff --git a/builtin/mv.c b/builtin/mv.c
index 94fbaaa5d..ffdd5f01a 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -131,7 +131,6 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	struct stat st;
 	struct string_list src_for_dst = STRING_LIST_INIT_NODUP;
 
-	gitmodules_config();
 	git_config(git_default_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, builtin_mv_options,
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index d5f618d08..bf87a2710 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -164,8 +164,6 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 	argc = parse_options(argc, argv, unused_prefix, read_tree_options,
 			     read_tree_usage, 0);
 
-	load_submodule_cache();
-
 	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
 
 	prefix_set = opts.prefix ? 1 : 0;
diff --git a/builtin/reset.c b/builtin/reset.c
index 772d078b8..50488d273 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -309,8 +309,6 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 						PARSE_OPT_KEEP_DASHDASH);
 	parse_args(&pathspec, argv, prefix, patch_mode, &rev);
 
-	load_submodule_cache();
-
 	unborn = !strcmp(rev, "HEAD") && get_oid("HEAD", &oid);
 	if (unborn) {
 		/* reset on unborn branch: treat as reset to empty tree */
diff --git a/builtin/rm.c b/builtin/rm.c
index 4057e73fa..d91451fea 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -255,7 +255,6 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	struct pathspec pathspec;
 	char *seen;
 
-	gitmodules_config();
 	git_config(git_default_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, builtin_rm_options,
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c16249e30..d74855b2d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -275,8 +275,6 @@ static void module_list_active(struct module_list *list)
 	int i;
 	struct module_list active_modules = MODULE_LIST_INIT;
 
-	gitmodules_config();
-
 	for (i = 0; i < list->nr; i++) {
 		const struct cache_entry *ce = list->entries[i];
 
@@ -337,9 +335,6 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 	struct strbuf sb = STRBUF_INIT;
 	char *upd = NULL, *url = NULL, *displaypath;
 
-	/* Only loads from .gitmodules, no overlay with .git/config */
-	gitmodules_config();
-
 	if (prefix && get_super_prefix())
 		die("BUG: cannot have prefix and superprefix");
 	else if (prefix)
@@ -475,7 +470,6 @@ static int module_name(int argc, const char **argv, const char *prefix)
 	if (argc != 2)
 		usage(_("git submodule--helper name <path>"));
 
-	gitmodules_config();
 	sub = submodule_from_path(&null_oid, argv[1]);
 
 	if (!sub)
@@ -1033,8 +1027,6 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	if (pathspec.nr)
 		suc.warn_if_uninitialized = 1;
 
-	gitmodules_config();
-
 	run_processes_parallel(max_jobs,
 			       update_clone_get_next_task,
 			       update_clone_start_failure,
@@ -1075,8 +1067,6 @@ static const char *remote_submodule_branch(const char *path)
 	const char *branch = NULL;
 	char *key;
 
-	gitmodules_config();
-
 	sub = submodule_from_path(&null_oid, path);
 	if (!sub)
 		return NULL;
@@ -1195,8 +1185,6 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, embed_gitdir_options,
 			     git_submodule_helper_usage, 0);
 
-	gitmodules_config();
-
 	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
 		return 1;
 
@@ -1212,8 +1200,6 @@ static int is_active(int argc, const char **argv, const char *prefix)
 	if (argc != 2)
 		die("submodule--helper is-active takes exactly 1 argument");
 
-	gitmodules_config();
-
 	return !is_submodule_active(the_repository, argv[1]);
 }
 
diff --git a/submodule.c b/submodule.c
index 7ebd639f4..1e4ff4e51 100644
--- a/submodule.c
+++ b/submodule.c
@@ -208,19 +208,6 @@ int option_parse_recurse_submodules_worktree_updater(const struct option *opt,
 	return 0;
 }
 
-void load_submodule_cache(void)
-{
-	if (config_update_recurse_submodules == RECURSE_SUBMODULES_OFF)
-		return;
-
-	gitmodules_config();
-}
-
-void gitmodules_config(void)
-{
-	repo_read_gitmodules(the_repository);
-}
-
 /*
  * Determine if a submodule has been initialized at a given 'path'
  */
@@ -1109,7 +1096,6 @@ int submodule_touches_in_range(struct object_id *excl_oid,
 	struct argv_array args = ARGV_ARRAY_INIT;
 	int ret;
 
-	gitmodules_config();
 	/* No need to check if there are no submodules configured */
 	if (!submodule_from_path(NULL, NULL))
 		return 0;
@@ -2016,7 +2002,6 @@ int submodule_to_gitdir(struct strbuf *buf, const char *submodule)
 		strbuf_addstr(buf, git_dir);
 	}
 	if (!is_git_directory(buf->buf)) {
-		gitmodules_config();
 		sub = submodule_from_path(&null_oid, submodule);
 		if (!sub) {
 			ret = -1;
diff --git a/submodule.h b/submodule.h
index 36fc7f7cf..7d0b5aa43 100644
--- a/submodule.h
+++ b/submodule.h
@@ -46,8 +46,6 @@ extern int git_default_submodule_config(const char *var, const char *value, void
 struct option;
 int option_parse_recurse_submodules_worktree_updater(const struct option *opt,
 						     const char *arg, int unset);
-void load_submodule_cache(void);
-extern void gitmodules_config(void);
 extern int is_submodule_active(struct repository *repo, const char *path);
 /*
  * Determine if a submodule has been populated at a given 'path' by checking if
diff --git a/t/helper/test-submodule-config.c b/t/helper/test-submodule-config.c
index f4a7c431c..f23db3b19 100644
--- a/t/helper/test-submodule-config.c
+++ b/t/helper/test-submodule-config.c
@@ -32,7 +32,6 @@ int cmd_main(int argc, const char **argv)
 		die_usage(argc, argv, "Wrong number of arguments.");
 
 	setup_git_directory();
-	gitmodules_config();
 
 	while (*arg) {
 		struct object_id commit_oid;
-- 
2.14.0.rc0.400.g1c36432dff-goog

