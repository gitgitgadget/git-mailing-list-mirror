Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7132C1F6A9
	for <e@80x24.org>; Sat,  5 Jan 2019 05:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfAEFwi (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Jan 2019 00:52:38 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40245 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfAEFwi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jan 2019 00:52:38 -0500
Received: by mail-pf1-f194.google.com with SMTP id i12so19260938pfo.7
        for <git@vger.kernel.org>; Fri, 04 Jan 2019 21:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RUG69agAZso64LcTbk2e+B8dkZsE5QsDnV2HN8riIKE=;
        b=dbEQhQwD92lBJGPuAvQYd6+EEU0nLj8BKqkEteOZE8vUSa5kwEPdZ+3Hel/6UViIPS
         ZrfAdm/z4JvefwRfWqU2m2HfziQJG1d8bJ+Okdt4mzwLe5QI9qoAAXqOjIEPH/Xj55UB
         tJ6bf1c1t5ismDRfdQGIWmoRR6OJZakhKu4ecm3cP+C3CU5NeG5JOJA8xkx9sB/vc4jw
         iEu7FWrbBJ50n+vvUQjU/ql8rK16PEfFYSk/tQZ5Qc8VNihS5znnlADgTGqwzSkyZm/0
         5175nOGZ5DICsl+eNaNhqrZwiBfd2FOcVFGtbDHkJMsRrJZvYricuX88/qQa9uCfChEM
         8LZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RUG69agAZso64LcTbk2e+B8dkZsE5QsDnV2HN8riIKE=;
        b=SZ/hc23FnXvHxMwA6rjUqf4A4ldJZWtK8m7oIsfJfRYaY19DcCiX1RIND4LEl6Wnti
         9G3Bnt8P+mf8US47orThgPVEIzZE9dUie6X1cmdBfcQfta804IuYNp4GEOVhj8kU+Bus
         81CcTND0z+cosdjxKAM0kzIptQUdLY4HEHAzANNv0yN0SCI9uGjqvOxLmjy8EIWNG176
         IzC2byCoxYT2ZF6x6CdCWb4DoxpBTC1aSF1PcR2RoYMIju0l7uApz4s9zx2TDzEiUkfS
         G/iccg022XEelDApAMAGfVcSotwVJGgl2YqVWX59pHYa2KQ8O1hXcz7le5yjfohDpkQ5
         6tdg==
X-Gm-Message-State: AJcUukfalK5k1mcyUgcvu36ltXEzLJadZlBtSsX4BakPTLBbPi9EwI5M
        OJpdpeWA6XN2UGnBnnBCu4heOrzDZtk=
X-Google-Smtp-Source: ALg8bN6DBYfu9jab1Z3/fIUhXmIq2lvFKxLX1/c+Eu67xHWWajnyEPe+0dcntIslhPBnvWbfBJ3+aQ==
X-Received: by 2002:a63:ab08:: with SMTP id p8mr3892983pgf.87.1546667556478;
        Fri, 04 Jan 2019 21:52:36 -0800 (PST)
Received: from ash ([171.232.90.54])
        by smtp.gmail.com with ESMTPSA id z13sm98835142pgf.84.2019.01.04.21.52.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 21:52:35 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 05 Jan 2019 12:52:31 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 04/10] read-cache.c: kill read_index()
Date:   Sat,  5 Jan 2019 12:51:47 +0700
Message-Id: <20190105055153.3256-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20190105055153.3256-1-pclouds@gmail.com>
References: <20190105055153.3256-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

read_index() shares the same problem as hold_locked_index(): it
assumes $GIT_DIR/index. Move all call sites to repo_read_index()
instead. read_index_preload() and read_index_unmerged() are also
killed as a consequence.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 apply.c             |  2 +-
 blame.c             |  4 ++--
 builtin/am.c        |  2 +-
 builtin/commit.c    |  2 +-
 builtin/diff-tree.c |  2 +-
 builtin/rebase.c    |  8 ++++----
 cache.h             | 11 +++--------
 merge-recursive.c   |  2 +-
 merge.c             |  2 +-
 preload-index.c     | 11 ++++++-----
 read-cache.c        | 11 ++++-------
 repository.h        |  6 ++++++
 rerere.c            |  6 +++---
 revision.c          |  4 ++--
 sequencer.c         | 20 ++++++++++----------
 sha1-name.c         |  6 +++---
 16 files changed, 49 insertions(+), 50 deletions(-)

diff --git a/apply.c b/apply.c
index 08cde3c4bf..e040c0b957 100644
--- a/apply.c
+++ b/apply.c
@@ -4019,7 +4019,7 @@ static int read_apply_cache(struct apply_state *state)
 		return read_index_from(state->repo->index, state->index_file,
 				       get_git_dir());
 	else
-		return read_index(state->repo->index);
+		return repo_read_index(state->repo);
 }
 
 /* This function tries to read the object name from the current index */
diff --git a/blame.c b/blame.c
index 43861437f7..da57233cbb 100644
--- a/blame.c
+++ b/blame.c
@@ -188,7 +188,7 @@ static struct commit *fake_working_tree_commit(struct repository *r,
 	unsigned mode;
 	struct strbuf msg = STRBUF_INIT;
 
-	read_index(r->index);
+	repo_read_index(r);
 	time(&now);
 	commit = alloc_commit_node(r);
 	commit->object.parsed = 1;
@@ -270,7 +270,7 @@ static struct commit *fake_working_tree_commit(struct repository *r,
 	 * want to run "diff-index --cached".
 	 */
 	discard_index(r->index);
-	read_index(r->index);
+	repo_read_index(r);
 
 	len = strlen(path);
 	if (!mode) {
diff --git a/builtin/am.c b/builtin/am.c
index d32044545d..901dc55078 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2278,7 +2278,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 	/* Ensure a valid committer ident can be constructed */
 	git_committer_info(IDENT_STRICT);
 
-	if (read_index_preload(&the_index, NULL, 0) < 0)
+	if (repo_read_index_preload(the_repository, NULL, 0) < 0)
 		die(_("failed to read the index"));
 
 	if (in_progress) {
diff --git a/builtin/commit.c b/builtin/commit.c
index e29fb5e3eb..19eb6cff86 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1367,7 +1367,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	if (status_format != STATUS_FORMAT_PORCELAIN &&
 	    status_format != STATUS_FORMAT_PORCELAIN_V2)
 		progress_flag = REFRESH_PROGRESS;
-	read_index(&the_index);
+	repo_read_index(the_repository);
 	refresh_index(&the_index,
 		      REFRESH_QUIET|REFRESH_UNMERGED|progress_flag,
 		      &s.pathspec, NULL, NULL);
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index ef996126d7..42bc1eb41d 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -165,7 +165,7 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 
 		if (opt->diffopt.detect_rename) {
 			if (!the_index.cache)
-				read_index(&the_index);
+				repo_read_index(the_repository);
 			opt->diffopt.setup |= DIFF_SETUP_USE_SIZE_CACHE;
 		}
 		while (fgets(line, sizeof(line), stdin)) {
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 00de70365e..ce5f5b5a17 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -576,7 +576,7 @@ static int reset_head(struct object_id *oid, const char *action,
 	if (!detach_head)
 		unpack_tree_opts.reset = 1;
 
-	if (read_index_unmerged(the_repository->index) < 0) {
+	if (repo_read_index_unmerged(the_repository) < 0) {
 		ret = error(_("could not read index"));
 		goto leave_reset_head;
 	}
@@ -1015,7 +1015,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			die(_("Cannot read HEAD"));
 
 		fd = hold_locked_index(&lock_file, 0);
-		if (read_index(the_repository->index) < 0)
+		if (repo_read_index(the_repository) < 0)
 			die(_("could not read index"));
 		refresh_index(the_repository->index, REFRESH_QUIET, NULL, NULL,
 			      NULL);
@@ -1368,7 +1368,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			get_fork_point(options.upstream_name, head);
 	}
 
-	if (read_index(the_repository->index) < 0)
+	if (repo_read_index(the_repository) < 0)
 		die(_("could not read index"));
 
 	if (options.autostash) {
@@ -1423,7 +1423,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			putchar('\n');
 
 			if (discard_index(the_repository->index) < 0 ||
-				read_index(the_repository->index) < 0)
+				repo_read_index(the_repository) < 0)
 				die(_("could not read index"));
 		}
 	}
diff --git a/cache.h b/cache.h
index 634c9ce325..3715808f52 100644
--- a/cache.h
+++ b/cache.h
@@ -408,11 +408,11 @@ void validate_cache_entries(const struct index_state *istate);
 #define active_cache_changed (the_index.cache_changed)
 #define active_cache_tree (the_index.cache_tree)
 
-#define read_cache() read_index(&the_index)
+#define read_cache() repo_read_index(the_repository)
 #define read_cache_from(path) read_index_from(&the_index, (path), (get_git_dir()))
-#define read_cache_preload(pathspec) read_index_preload(&the_index, (pathspec), 0)
+#define read_cache_preload(pathspec) repo_read_index_preload(the_repository, (pathspec), 0)
 #define is_cache_unborn() is_index_unborn(&the_index)
-#define read_cache_unmerged() read_index_unmerged(&the_index)
+#define read_cache_unmerged() repo_read_index_unmerged(the_repository)
 #define discard_cache() discard_index(&the_index)
 #define unmerged_cache() unmerged_index(&the_index)
 #define cache_name_pos(name, namelen) index_name_pos(&the_index,(name),(namelen))
@@ -661,19 +661,14 @@ extern int daemonize(void);
 
 /* Initialize and use the cache information */
 struct lock_file;
-extern int read_index(struct index_state *);
 extern void preload_index(struct index_state *index,
 			  const struct pathspec *pathspec,
 			  unsigned int refresh_flags);
-extern int read_index_preload(struct index_state *,
-			      const struct pathspec *pathspec,
-			      unsigned int refresh_flags);
 extern int do_read_index(struct index_state *istate, const char *path,
 			 int must_exist); /* for testting only! */
 extern int read_index_from(struct index_state *, const char *path,
 			   const char *gitdir);
 extern int is_index_unborn(struct index_state *);
-extern int read_index_unmerged(struct index_state *);
 
 /* For use with `write_locked_index()`. */
 #define COMMIT_LOCK		(1 << 0)
diff --git a/merge-recursive.c b/merge-recursive.c
index 8dba939d8f..5fbd4253c1 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3576,7 +3576,7 @@ int merge_recursive(struct merge_options *o,
 
 	discard_cache();
 	if (!o->call_depth)
-		read_cache();
+		repo_read_index(the_repository);
 
 	o->ancestor = "merged common ancestors";
 	clean = merge_trees(o, get_commit_tree(h1), get_commit_tree(h2),
diff --git a/merge.c b/merge.c
index dbbc9d9f80..7c1d756c3f 100644
--- a/merge.c
+++ b/merge.c
@@ -37,7 +37,7 @@ int try_merge_command(struct repository *r,
 	argv_array_clear(&args);
 
 	discard_index(r->index);
-	if (read_index(r->index) < 0)
+	if (repo_read_index(r) < 0)
 		die(_("failed to read the cache"));
 	resolve_undo_clear_index(r->index);
 
diff --git a/preload-index.c b/preload-index.c
index c7dc3f2b9f..e73600ee78 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -8,6 +8,7 @@
 #include "config.h"
 #include "progress.h"
 #include "thread-utils.h"
+#include "repository.h"
 
 /*
  * Mostly randomly chosen maximum thread counts: we
@@ -146,12 +147,12 @@ void preload_index(struct index_state *index,
 	trace_performance_leave("preload index");
 }
 
-int read_index_preload(struct index_state *index,
-		       const struct pathspec *pathspec,
-		       unsigned int refresh_flags)
+int repo_read_index_preload(struct repository *repo,
+			    const struct pathspec *pathspec,
+			    unsigned int refresh_flags)
 {
-	int retval = read_index(index);
+	int retval = repo_read_index(repo);
 
-	preload_index(index, pathspec, refresh_flags);
+	preload_index(repo->index, pathspec, refresh_flags);
 	return retval;
 }
diff --git a/read-cache.c b/read-cache.c
index 1030e11051..afbf976107 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1733,11 +1733,6 @@ static int read_index_extension(struct index_state *istate,
 	return 0;
 }
 
-int read_index(struct index_state *istate)
-{
-	return read_index_from(istate, get_index_file(), get_git_dir());
-}
-
 static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
 					    unsigned int version,
 					    struct ondisk_cache_entry *ondisk,
@@ -3218,12 +3213,14 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
  * state can call this and check its return value, instead of calling
  * read_cache().
  */
-int read_index_unmerged(struct index_state *istate)
+int repo_read_index_unmerged(struct repository *repo)
 {
+	struct index_state *istate;
 	int i;
 	int unmerged = 0;
 
-	read_index(istate);
+	repo_read_index(repo);
+	istate = repo->index;
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
 		struct cache_entry *new_ce;
diff --git a/repository.h b/repository.h
index 968330218f..cc3879add4 100644
--- a/repository.h
+++ b/repository.h
@@ -7,6 +7,7 @@ struct config_set;
 struct git_hash_algo;
 struct index_state;
 struct lock_file;
+struct pathspec;
 struct raw_object_store;
 struct submodule_cache;
 
@@ -135,4 +136,9 @@ int repo_hold_locked_index(struct repository *repo,
 			   struct lock_file *lf,
 			   int flags);
 
+int repo_read_index_preload(struct repository *,
+			    const struct pathspec *pathspec,
+			    unsigned refresh_flags);
+int repo_read_index_unmerged(struct repository *);
+
 #endif /* REPOSITORY_H */
diff --git a/rerere.c b/rerere.c
index fb0fdb2392..17abb47321 100644
--- a/rerere.c
+++ b/rerere.c
@@ -561,7 +561,7 @@ static int find_conflict(struct repository *r, struct string_list *conflict)
 {
 	int i;
 
-	if (read_index(r->index) < 0)
+	if (repo_read_index(r) < 0)
 		return error(_("index file corrupt"));
 
 	for (i = 0; i < r->index->cache_nr;) {
@@ -595,7 +595,7 @@ int rerere_remaining(struct repository *r, struct string_list *merge_rr)
 
 	if (setup_rerere(r, merge_rr, RERERE_READONLY))
 		return 0;
-	if (read_index(r->index) < 0)
+	if (repo_read_index(r) < 0)
 		return error(_("index file corrupt"));
 
 	for (i = 0; i < r->index->cache_nr;) {
@@ -1107,7 +1107,7 @@ int rerere_forget(struct repository *r, struct pathspec *pathspec)
 	struct string_list conflict = STRING_LIST_INIT_DUP;
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
 
-	if (read_index(r->index) < 0)
+	if (repo_read_index(r) < 0)
 		return error(_("index file corrupt"));
 
 	fd = setup_rerere(r, &merge_rr, RERERE_NOAUTOUPDATE);
diff --git a/revision.c b/revision.c
index 13e0519c02..c51ea6a052 100644
--- a/revision.c
+++ b/revision.c
@@ -1384,7 +1384,7 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned int flags)
 {
 	struct worktree **worktrees, **p;
 
-	read_index(revs->repo->index);
+	repo_read_index(revs->repo);
 	do_add_index_objects_to_pending(revs, revs->repo->index, flags);
 
 	if (revs->single_worktree)
@@ -1530,7 +1530,7 @@ static void prepare_show_merge(struct rev_info *revs)
 	head->object.flags |= SYMMETRIC_LEFT;
 
 	if (!istate->cache_nr)
-		read_index(istate);
+		repo_read_index(revs->repo);
 	for (i = 0; i < istate->cache_nr; i++) {
 		const struct cache_entry *ce = istate->cache[i];
 		if (!ce_stage(ce))
diff --git a/sequencer.c b/sequencer.c
index 668c232b05..c2c9cc7e2b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -446,9 +446,9 @@ static struct tree *empty_tree(struct repository *r)
 	return lookup_tree(r, the_hash_algo->empty_tree);
 }
 
-static int error_dirty_index(struct index_state *istate, struct replay_opts *opts)
+static int error_dirty_index(struct repository *repo, struct replay_opts *opts)
 {
-	if (read_index_unmerged(istate))
+	if (repo_read_index_unmerged(repo))
 		return error_resolve_conflict(_(action_name(opts)));
 
 	error(_("your local changes would be overwritten by %s."),
@@ -483,7 +483,7 @@ static int fast_forward_to(struct repository *r,
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf err = STRBUF_INIT;
 
-	read_index(r->index);
+	repo_read_index(r);
 	if (checkout_fast_forward(r, from, to, 1))
 		return -1; /* the callee should have complained already */
 
@@ -543,7 +543,7 @@ static int do_recursive_merge(struct repository *r,
 	if (repo_hold_locked_index(r, &index_lock, LOCK_REPORT_ON_ERROR) < 0)
 		return -1;
 
-	read_index(r->index);
+	repo_read_index(r);
 
 	init_merge_options(&o);
 	o.ancestor = base ? base_label : "(empty tree)";
@@ -1766,7 +1766,7 @@ static int do_pick_commit(struct repository *r,
 			oidcpy(&head, the_hash_algo->empty_tree);
 		if (index_differs_from(r, unborn ? empty_tree_oid_hex() : "HEAD",
 				       NULL, 0))
-			return error_dirty_index(r->index, opts);
+			return error_dirty_index(r, opts);
 	}
 	discard_index(r->index);
 
@@ -2854,7 +2854,7 @@ static int do_exec(struct repository *r, const char *command_line)
 					  child_env.argv);
 
 	/* force re-reading of the cache */
-	if (discard_index(r->index) < 0 || read_index(r->index) < 0)
+	if (discard_index(r->index) < 0 || repo_read_index(r) < 0)
 		return error(_("could not read index"));
 
 	dirty = require_clean_work_tree(r, "rebase", NULL, 1, 1);
@@ -3023,7 +3023,7 @@ static int do_reset(struct repository *r,
 	unpack_tree_opts.merge = 1;
 	unpack_tree_opts.update = 1;
 
-	if (read_index_unmerged(r->index)) {
+	if (repo_read_index_unmerged(r)) {
 		rollback_lock_file(&lock);
 		strbuf_release(&ref_name);
 		return error_resolve_conflict(_(action_name(opts)));
@@ -3277,7 +3277,7 @@ static int do_merge(struct repository *r,
 
 		/* force re-reading of the cache */
 		if (!ret && (discard_index(r->index) < 0 ||
-			     read_index(r->index) < 0))
+			     repo_read_index(r) < 0))
 			ret = error(_("could not read index"));
 		goto leave_merge;
 	}
@@ -3299,7 +3299,7 @@ static int do_merge(struct repository *r,
 		commit_list_insert(j->item, &reversed);
 	free_commit_list(bases);
 
-	read_index(r->index);
+	repo_read_index(r);
 	init_merge_options(&o);
 	o.branch1 = "HEAD";
 	o.branch2 = ref_name.buf;
@@ -3972,7 +3972,7 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
 				goto release_todo_list;
 		}
 		if (index_differs_from(r, "HEAD", NULL, 0)) {
-			res = error_dirty_index(r->index, opts);
+			res = error_dirty_index(r, opts);
 			goto release_todo_list;
 		}
 		todo_list.current++;
diff --git a/sha1-name.c b/sha1-name.c
index b24502811b..a0fc1008ec 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1723,9 +1723,9 @@ static int get_oid_with_context_1(const char *name,
 		if (flags & GET_OID_RECORD_PATH)
 			oc->path = xstrdup(cp);
 
-		if (!active_cache)
-			read_cache();
-		pos = cache_name_pos(cp, namelen);
+		if (!the_index.cache)
+			repo_read_index(the_repository);
+		pos = index_name_pos(&the_index, cp, namelen);
 		if (pos < 0)
 			pos = -pos - 1;
 		while (pos < active_nr) {
-- 
2.20.0.482.g66447595a7

