Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 112BA207E3
	for <e@80x24.org>; Tue,  2 May 2017 22:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751755AbdEBWYF (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 18:24:05 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:34644 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751685AbdEBWXp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 18:23:45 -0400
Received: by mail-pg0-f44.google.com with SMTP id v1so68093493pgv.1
        for <git@vger.kernel.org>; Tue, 02 May 2017 15:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l/ATEf54P4wtT7ZC8cE7TorGY3z9KlAPf4ACYDG5WWU=;
        b=P7dZ+UuR3/OiceIsnZS25m1Ij/lM+w3VBVl+acMtzCNpxy/0RbF4thbaRkKkUjyEb9
         ji+YbjS6F/LvIsKjvouyDT3eUbJ0JSBxfyH45+DMSGWN21ly2sYDabIBS6vr2N1nwD50
         6eqnKLdh7CG6QxPzqphqwO3H++vp5FQcBzj21S3oCyHUoqIQcQRcP/6Yzrw14VidUH68
         bkxKoEQogbu6DzsoYtArTpISa5uWAt0W90pkgcozJ7X8Tb4UKo1Hi9PXwpcFY6n2bQY3
         ANnNmPvnNqIxIzjQLzGaRxfD8NmHkaEPHUQKHjrZRF+bzfyOZmcNpMeZepn/I0CZMp/X
         kb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l/ATEf54P4wtT7ZC8cE7TorGY3z9KlAPf4ACYDG5WWU=;
        b=OZF8V5TSKValU/JM7ZWoxbovSYlCQ4rvw3dtRlvYqwhxRxbJHhHPJVYWQQBT12iHel
         HZt6jSDn4cGwbz9k0BygnAadBGt5O51bnH0V95BTQlYdUi/PSssTZpJdaD3VqVmeZAEs
         VvUVqJz7DNtuzAzGIXk5/oWNZ4RoJH0yC/WBcRiR35/q8aZl2idGDz/nsHbH1f/E5Za8
         aRhuBuT7a1R0/CAdeUdIbRqH+2k/zUYLCThM1mLV7yq5mQzC6Jmrl4IB//VUDcJ9Pjy+
         CI6a2f7vdh6/jfcID7tnnImFn0TolWwjcnq4Lp40X12Zrbve48ncN4VBmRE/6c1Cv588
         JZgA==
X-Gm-Message-State: AN3rC/4GByUBpszREfxZcARljO9iXmR9fnADe+vXC570WsmsvaeQHkax
        qec66/WMH/5jHBjo
X-Received: by 10.99.114.3 with SMTP id n3mr36072107pgc.130.1493763824586;
        Tue, 02 May 2017 15:23:44 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c805:cf1:74c5:2e74])
        by smtp.gmail.com with ESMTPSA id b68sm636072pfa.127.2017.05.02.15.23.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 May 2017 15:23:43 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, git@jeffhostetler.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 13/24] cache.h: drop is_cache_unborn(), discard_cache(), unmerged_cache()
Date:   Tue,  2 May 2017 15:23:11 -0700
Message-Id: <20170502222322.21055-14-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.rc1.39.ga6db8bfa24
In-Reply-To: <20170502222322.21055-1-sbeller@google.com>
References: <20170502222322.21055-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

cocci semantic patch:
@@ @@
-is_cache_unborn()
+is_index_unborn(&the_index)
@@ @@
-discard_cache()
+discard_index(&the_index)
@@ @@
-unmerged_cache()
+unmerged_index(&the_index)

Additionally the defines in cache.h were removed manually.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/am.c                        |  8 ++++----
 builtin/blame.c                     |  2 +-
 builtin/checkout.c                  |  4 ++--
 builtin/commit.c                    | 10 +++++-----
 builtin/diff.c                      |  2 +-
 builtin/pull.c                      |  2 +-
 builtin/read-tree.c                 |  2 +-
 builtin/reset.c                     |  2 +-
 cache.h                             |  3 ---
 merge-recursive.c                   |  8 ++++----
 merge.c                             |  2 +-
 sequencer.c                         |  4 ++--
 t/helper/test-lazy-init-name-hash.c | 10 +++++-----
 t/helper/test-read-cache.c          |  2 +-
 wt-status.c                         |  2 +-
 15 files changed, 30 insertions(+), 33 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index bb0927fbcc..38fc4566f7 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1556,7 +1556,7 @@ static int run_apply(const struct am_state *state, const char *index_file)
 
 	if (index_file) {
 		/* Reload index as apply_all_patches() will have modified it. */
-		discard_cache();
+		discard_index(&the_index);
 		read_index_from(&the_index, index_file);
 	}
 
@@ -1599,7 +1599,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 	if (build_fake_ancestor(state, index_path))
 		return error("could not build fake ancestor");
 
-	discard_cache();
+	discard_index(&the_index);
 	read_index_from(&the_index, index_path);
 
 	if (write_index_as_tree(orig_tree.hash, &the_index, index_path, 0, NULL))
@@ -1632,7 +1632,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 
 	say(state, stdout, _("Falling back to patching base and 3-way merge..."));
 
-	discard_cache();
+	discard_index(&the_index);
 	read_index(&the_index);
 
 	/*
@@ -1938,7 +1938,7 @@ static void am_resolve(struct am_state *state)
 		die_user_resolve(state);
 	}
 
-	if (unmerged_cache()) {
+	if (unmerged_index(&the_index)) {
 		printf_ln(_("You still have unmerged paths in your index.\n"
 			"Did you forget to use 'git add'?"));
 		die_user_resolve(state);
diff --git a/builtin/blame.c b/builtin/blame.c
index cbb7c1fd9d..b47aae25d4 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2394,7 +2394,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 	 * bits; we are not going to write this index out -- we just
 	 * want to run "diff-index --cached".
 	 */
-	discard_cache();
+	discard_index(&the_index);
 	read_index(&the_index);
 
 	len = strlen(path);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index abcc45a74f..a6cd8c0f37 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -510,13 +510,13 @@ static int merge_working_tree(const struct checkout_opts *opts,
 
 		refresh_cache(REFRESH_QUIET);
 
-		if (unmerged_cache()) {
+		if (unmerged_index(&the_index)) {
 			error(_("you need to resolve your current index first"));
 			return 1;
 		}
 
 		/* 2-way merge to the new branch */
-		topts.initial_checkout = is_cache_unborn();
+		topts.initial_checkout = is_index_unborn(&the_index);
 		topts.update = 1;
 		topts.merge = 1;
 		topts.gently = opts->merge && old->commit;
diff --git a/builtin/commit.c b/builtin/commit.c
index 687e7c8a3a..ef12ea3991 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -301,7 +301,7 @@ static void create_base_index(const struct commit *current_head)
 	struct tree_desc t;
 
 	if (!current_head) {
-		discard_cache();
+		discard_index(&the_index);
 		return;
 	}
 
@@ -369,7 +369,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 		else
 			unsetenv(INDEX_ENVIRONMENT);
 
-		discard_cache();
+		discard_index(&the_index);
 		read_index_from(&the_index, get_lock_file_path(&index_lock));
 		if (update_main_cache_tree(WRITE_TREE_SILENT) == 0) {
 			if (reopen_lock_file(&index_lock) < 0)
@@ -464,7 +464,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 	if (list_paths(&partial, !current_head ? NULL : "HEAD", prefix, &pathspec))
 		exit(1);
 
-	discard_cache();
+	discard_index(&the_index);
 	if (read_index(&the_index) < 0)
 		die(_("cannot read the index"));
 
@@ -487,7 +487,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 	if (write_locked_index(&the_index, &false_lock, CLOSE_LOCK))
 		die(_("unable to write temporary index file"));
 
-	discard_cache();
+	discard_index(&the_index);
 	ret = get_lock_file_path(&false_lock);
 	read_index_from(&the_index, ret);
 	return ret;
@@ -948,7 +948,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	 * and write it out as a tree.  We must do this before we invoke
 	 * the editor and after we invoke run_status above.
 	 */
-	discard_cache();
+	discard_index(&the_index);
 	read_index_from(&the_index, index_file);
 	if (update_main_cache_tree(0)) {
 		error(_("Error building trees"));
diff --git a/builtin/diff.c b/builtin/diff.c
index 0ae33bce2b..1efd0d6b61 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -209,7 +209,7 @@ static void refresh_index_quietly(void)
 	fd = hold_locked_index(lock_file, 0);
 	if (fd < 0)
 		return;
-	discard_cache();
+	discard_index(&the_index);
 	read_index(&the_index);
 	refresh_cache(REFRESH_QUIET|REFRESH_UNMERGED);
 	update_index_if_able(&the_index, lock_file);
diff --git a/builtin/pull.c b/builtin/pull.c
index 42578cee05..57f9833367 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -805,7 +805,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		if (opt_autostash != -1)
 			autostash = opt_autostash;
 
-		if (is_null_oid(&orig_head) && !is_cache_unborn())
+		if (is_null_oid(&orig_head) && !is_index_unborn(&the_index))
 			die(_("Updating an unborn branch with changes added to the index."));
 
 		if (!autostash)
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 61f5f6f028..2b8f0a0b3a 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -234,7 +234,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 			break;
 		case 2:
 			opts.fn = twoway_merge;
-			opts.initial_checkout = is_cache_unborn();
+			opts.initial_checkout = is_index_unborn(&the_index);
 			break;
 		case 3:
 		default:
diff --git a/builtin/reset.c b/builtin/reset.c
index 4a4eb723dd..f8073b1caa 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -179,7 +179,7 @@ static void set_reflog_message(struct strbuf *sb, const char *action,
 
 static void die_if_unmerged_cache(int reset_type)
 {
-	if (is_merge() || unmerged_cache())
+	if (is_merge() || unmerged_index(&the_index))
 		die(_("Cannot do a %s reset in the middle of a merge."),
 		    _(reset_type_names[reset_type]));
 
diff --git a/cache.h b/cache.h
index 4b8e8c31fe..a021d6e988 100644
--- a/cache.h
+++ b/cache.h
@@ -354,9 +354,6 @@ extern void free_name_hash(struct index_state *istate);
 
 
 #ifndef NO_THE_INDEX_COMPATIBILITY_MACROS
-#define is_cache_unborn() is_index_unborn(&the_index)
-#define discard_cache() discard_index(&the_index)
-#define unmerged_cache() unmerged_index(&the_index)
 #define cache_name_pos(name, namelen) index_name_pos(&the_index,(name),(namelen))
 #define add_cache_entry(ce, option) add_index_entry(&the_index, (ce), (option))
 #define rename_cache_entry_at(pos, new_name) rename_index_entry_at(&the_index, (pos), (new_name))
diff --git a/merge-recursive.c b/merge-recursive.c
index b8b3a153f1..eb0f0c6960 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -283,7 +283,7 @@ struct tree *write_tree_from_memory(struct merge_options *o)
 {
 	struct tree *result = NULL;
 
-	if (unmerged_cache()) {
+	if (unmerged_index(&the_index)) {
 		int i;
 		fprintf(stderr, "BUG: There are unmerged index entries:\n");
 		for (i = 0; i < the_index.cache_nr; i++) {
@@ -1942,7 +1942,7 @@ int merge_trees(struct merge_options *o,
 		return -1;
 	}
 
-	if (unmerged_cache()) {
+	if (unmerged_index(&the_index)) {
 		struct string_list *entries, *re_head, *re_merge;
 		int i;
 		string_list_clear(&o->current_file_set, 1);
@@ -2058,7 +2058,7 @@ int merge_recursive(struct merge_options *o,
 		 * overwritten it: the committed "conflicts" were
 		 * already resolved.
 		 */
-		discard_cache();
+		discard_index(&the_index);
 		saved_b1 = o->branch1;
 		saved_b2 = o->branch2;
 		o->branch1 = "Temporary merge branch 1";
@@ -2074,7 +2074,7 @@ int merge_recursive(struct merge_options *o,
 			return err(o, _("merge returned no commit"));
 	}
 
-	discard_cache();
+	discard_index(&the_index);
 	if (!o->call_depth)
 		read_index(&the_index);
 
diff --git a/merge.c b/merge.c
index 06509a6df2..e1f93e9714 100644
--- a/merge.c
+++ b/merge.c
@@ -36,7 +36,7 @@ int try_merge_command(const char *strategy, size_t xopts_nr,
 	ret = run_command_v_opt(args.argv, RUN_GIT_CMD);
 	argv_array_clear(&args);
 
-	discard_cache();
+	discard_index(&the_index);
 	if (read_index(&the_index) < 0)
 		die(_("failed to read the cache"));
 	resolve_undo_clear_index(&the_index);
diff --git a/sequencer.c b/sequencer.c
index f20e05fe60..274eda243a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -958,7 +958,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		if (index_differs_from(unborn ? EMPTY_TREE_SHA1_HEX : "HEAD", 0, 0))
 			return error_dirty_index(opts);
 	}
-	discard_cache();
+	discard_index(&the_index);
 
 	if (!commit->parents)
 		parent = NULL;
@@ -1845,7 +1845,7 @@ static int do_exec(const char *command_line)
 	status = run_command_v_opt(child_argv, RUN_USING_SHELL);
 
 	/* force re-reading of the cache */
-	if (discard_cache() < 0 || read_index(&the_index) < 0)
+	if (discard_index(&the_index) < 0 || read_index(&the_index) < 0)
 		return error(_("could not read index"));
 
 	dirty = require_clean_work_tree("rebase", NULL, 1, 1);
diff --git a/t/helper/test-lazy-init-name-hash.c b/t/helper/test-lazy-init-name-hash.c
index bd747dcbcd..5512c97647 100644
--- a/t/helper/test-lazy-init-name-hash.c
+++ b/t/helper/test-lazy-init-name-hash.c
@@ -52,7 +52,7 @@ static void dump_run(void)
 		ce = hashmap_iter_next(&iter_cache);
 	}
 
-	discard_cache();
+	discard_index(&the_index);
 }
 
 /*
@@ -92,7 +92,7 @@ static uint64_t time_runs(int try_threaded)
 				   the_index.cache_nr);
 		fflush(stdout);
 
-		discard_cache();
+		discard_index(&the_index);
 	}
 
 	avg = sum / count;
@@ -118,7 +118,7 @@ static void analyze_run(void)
 
 	read_index(&the_index);
 	cache_nr_limit = the_index.cache_nr;
-	discard_cache();
+	discard_index(&the_index);
 
 	nr = analyze;
 	while (1) {
@@ -138,7 +138,7 @@ static void analyze_run(void)
 			t2s = getnanotime();
 			sum_single += (t2s - t1s);
 			the_index.cache_nr = cache_nr_limit;
-			discard_cache();
+			discard_index(&the_index);
 
 			read_index(&the_index);
 			the_index.cache_nr = nr; /* cheap truncate of index */
@@ -147,7 +147,7 @@ static void analyze_run(void)
 			t2m = getnanotime();
 			sum_multi += (t2m - t1m);
 			the_index.cache_nr = cache_nr_limit;
-			discard_cache();
+			discard_index(&the_index);
 
 			if (!nr_threads_used)
 				printf("    [size %8d] [single %f]   non-threaded code path used\n",
diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index b4aa339ddb..084778c52f 100644
--- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -8,7 +8,7 @@ int cmd_main(int argc, const char **argv)
 	setup_git_directory();
 	for (i = 0; i < cnt; i++) {
 		read_index(&the_index);
-		discard_cache();
+		discard_index(&the_index);
 	}
 	return 0;
 }
diff --git a/wt-status.c b/wt-status.c
index ff0e70a25a..d17d4cb6ca 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -2247,7 +2247,7 @@ int has_uncommitted_changes(int ignore_submodules)
 	struct rev_info rev_info;
 	int result;
 
-	if (is_cache_unborn())
+	if (is_index_unborn(&the_index))
 		return 0;
 
 	init_revisions(&rev_info, NULL);
-- 
2.13.0.rc1.39.ga6db8bfa24

