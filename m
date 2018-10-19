Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 167F61F453
	for <e@80x24.org>; Fri, 19 Oct 2018 14:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbeJSW71 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 18:59:27 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42903 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbeJSW70 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 18:59:26 -0400
Received: by mail-lj1-f196.google.com with SMTP id y71-v6so31082638lje.9
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 07:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tgoHYdxKd3mq8WkmOaKCdottldfFDfZzUVpbfBX9cyA=;
        b=FIKB2Xe5qAL5pGNbuDICJL10x4+wDKNS0XwkBE4L0QB4D10ymBqhmC8e6yInSiZ88f
         zNnQeCvHbs3G/jVFSq2QJJwZqbYZxs8i64raxxQQcwiPhVJrIMYZTAX7uRgnr8Gxy0cE
         0tnCHHz/F+2c9KEkY9KU063oBa0XQRdze+5vAvgLevCZsQa1KDQ3Oigm5KGhgdQ/86u6
         czP8tWGYzhabsh1k2ATQonzBytQJS/vCzYd5RW/PM40sQMGI+oZoD3YTB415GGe+dr5t
         vZC0tt0vtMZvxayWb6ahy365KIf6whTp2myOQa+tA2VztU31r5vL0z/1wZL007W0WbP+
         F9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tgoHYdxKd3mq8WkmOaKCdottldfFDfZzUVpbfBX9cyA=;
        b=Y00JwM99WBbnSr1RTT0F/vAccfu2OqPldpsUhecGt2p5gJYgL0BjGZxaL63+W1hBrj
         c3AbAbsEa1JBfxv3XQ45qHGOQV6txyg51r4NHaY6Yem5KCRQqyXHV+W9sJNlASoA4IUl
         RgGe8+1XriYjzD890BfcVt/vVL55U9G7dWOHIoUI+qEp8BFR0VZ9uBSurNDI70H5cfkf
         pTFHeA3BuLVpHlgb4na8Bg2dTGdJ9xLDEtNm+kPCcDCsGgoRA5gNu3ZowqKc1SPEiJjE
         +MmeghDgAGuxse2e+hqbUC8AOU4YzU/zceZOv0HjPfEM9iEYWYKTSojFeXgHzTQfYI7S
         LebA==
X-Gm-Message-State: ABuFfojJssZgCE3cBDxxDLYY65UNSbRdFJIgm5HxnjkNH4MFX0WZBVQ2
        9zJGQYk+E6AQVIYxCFnhWyc0wsJv
X-Google-Smtp-Source: ACcGV6279/VBgoMRcxlySSJ5Dh3cgkVF/qGwyqRUr9U1+MaO9XyJTO4zJuTvh7x5kE4lWagtOCnrPA==
X-Received: by 2002:a2e:5645:: with SMTP id k66-v6mr22508514ljb.48.1539960775429;
        Fri, 19 Oct 2018 07:52:55 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g64-v6sm4002414lfe.87.2018.10.19.07.52.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 07:52:54 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 11/19] read-cache.c: kill read_index()
Date:   Fri, 19 Oct 2018 16:52:29 +0200
Message-Id: <20181019145237.16079-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181019145237.16079-1-pclouds@gmail.com>
References: <20181019145237.16079-1-pclouds@gmail.com>
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
 cache.h             | 11 +++--------
 merge-recursive.c   |  2 +-
 merge.c             |  2 +-
 preload-index.c     | 11 ++++++-----
 read-cache.c        | 11 ++++-------
 repository.h        |  6 ++++++
 rerere.c            |  6 +++---
 revision.c          |  4 ++--
 sequencer.c         | 22 +++++++++++-----------
 sha1-name.c         |  6 +++---
 15 files changed, 46 insertions(+), 47 deletions(-)

diff --git a/apply.c b/apply.c
index 122e6ddf92..f5d507a64f 100644
--- a/apply.c
+++ b/apply.c
@@ -4017,7 +4017,7 @@ static int read_apply_cache(struct apply_state *state)
 		return read_index_from(state->repo->index, state->index_file,
 				       get_git_dir());
 	else
-		return read_index(state->repo->index);
+		return repo_read_index(state->repo);
 }
 
 /* This function tries to read the object name from the current index */
diff --git a/blame.c b/blame.c
index d84c937780..6e3de62379 100644
--- a/blame.c
+++ b/blame.c
@@ -183,7 +183,7 @@ static struct commit *fake_working_tree_commit(struct repository *r,
 	unsigned mode;
 	struct strbuf msg = STRBUF_INIT;
 
-	read_index(r->index);
+	repo_read_index(r);
 	time(&now);
 	commit = alloc_commit_node(the_repository);
 	commit->object.parsed = 1;
@@ -265,7 +265,7 @@ static struct commit *fake_working_tree_commit(struct repository *r,
 	 * want to run "diff-index --cached".
 	 */
 	discard_index(r->index);
-	read_index(r->index);
+	repo_read_index(r);
 
 	len = strlen(path);
 	if (!mode) {
diff --git a/builtin/am.c b/builtin/am.c
index 3ee9a9d2a9..d2af94500c 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2328,7 +2328,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 	/* Ensure a valid committer ident can be constructed */
 	git_committer_info(IDENT_STRICT);
 
-	if (read_index_preload(&the_index, NULL, 0) < 0)
+	if (repo_read_index_preload(the_repository, NULL, 0) < 0)
 		die(_("failed to read the index"));
 
 	if (in_progress) {
diff --git a/builtin/commit.c b/builtin/commit.c
index f7bbba944d..7eda5e4b7e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1363,7 +1363,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	if (status_format != STATUS_FORMAT_PORCELAIN &&
 	    status_format != STATUS_FORMAT_PORCELAIN_V2)
 		progress_flag = REFRESH_PROGRESS;
-	read_index_preload(&the_index, &s.pathspec, progress_flag);
+	repo_read_index_preload(the_repository, &s.pathspec, progress_flag);
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
diff --git a/cache.h b/cache.h
index ef2483ce45..d9303ae25f 100644
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
@@ -659,16 +659,11 @@ extern int daemonize(void);
 
 /* Initialize and use the cache information */
 struct lock_file;
-extern int read_index(struct index_state *);
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
index c186812ff2..b025c10e31 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3443,7 +3443,7 @@ int merge_recursive(struct merge_options *o,
 
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
index 9e7152ab14..5327c59923 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -7,6 +7,7 @@
 #include "fsmonitor.h"
 #include "config.h"
 #include "progress.h"
+#include "repository.h"
 
 #ifdef NO_PTHREADS
 static void preload_index(struct index_state *index,
@@ -153,12 +154,12 @@ static void preload_index(struct index_state *index,
 }
 #endif
 
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
index 7ad3330942..8844f723e9 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1726,11 +1726,6 @@ static int read_index_extension(struct index_state *istate,
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
@@ -3196,12 +3191,14 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
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
index 13927de7e0..7abf7c8d41 100644
--- a/rerere.c
+++ b/rerere.c
@@ -558,7 +558,7 @@ static int find_conflict(struct repository *r, struct string_list *conflict)
 {
 	int i;
 
-	if (read_index(r->index) < 0)
+	if (repo_read_index(r) < 0)
 		return error(_("index file corrupt"));
 
 	for (i = 0; i < r->index->cache_nr;) {
@@ -592,7 +592,7 @@ int rerere_remaining(struct repository *r, struct string_list *merge_rr)
 
 	if (setup_rerere(merge_rr, RERERE_READONLY))
 		return 0;
-	if (read_index(r->index) < 0)
+	if (repo_read_index(r) < 0)
 		return error(_("index file corrupt"));
 
 	for (i = 0; i < r->index->cache_nr;) {
@@ -1104,7 +1104,7 @@ int rerere_forget(struct repository *r, struct pathspec *pathspec)
 	struct string_list conflict = STRING_LIST_INIT_DUP;
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
 
-	if (read_index(r->index) < 0)
+	if (repo_read_index(r) < 0)
 		return error(_("index file corrupt"));
 
 	fd = setup_rerere(&merge_rr, RERERE_NOAUTOUPDATE);
diff --git a/revision.c b/revision.c
index b5108b75ab..3138c11ec5 100644
--- a/revision.c
+++ b/revision.c
@@ -1372,7 +1372,7 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned int flags)
 {
 	struct worktree **worktrees, **p;
 
-	read_index(revs->repo->index);
+	repo_read_index(revs->repo);
 	do_add_index_objects_to_pending(revs, revs->repo->index);
 
 	if (revs->single_worktree)
@@ -1518,7 +1518,7 @@ static void prepare_show_merge(struct rev_info *revs)
 	head->object.flags |= SYMMETRIC_LEFT;
 
 	if (!istate->cache_nr)
-		read_index(istate);
+		repo_read_index(revs->repo);
 	for (i = 0; i < istate->cache_nr; i++) {
 		const struct cache_entry *ce = istate->cache[i];
 		if (!ce_stage(ce))
diff --git a/sequencer.c b/sequencer.c
index ced05cd73d..3620a42649 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -441,9 +441,9 @@ static struct tree *empty_tree(struct repository *r)
 	return lookup_tree(r, the_hash_algo->empty_tree);
 }
 
-static int error_dirty_index(struct index_state *istate, struct replay_opts *opts)
+static int error_dirty_index(struct repository *repo, struct replay_opts *opts)
 {
-	if (read_index_unmerged(istate))
+	if (repo_read_index_unmerged(repo))
 		return error_resolve_conflict(_(action_name(opts)));
 
 	error(_("your local changes would be overwritten by %s."),
@@ -478,7 +478,7 @@ static int fast_forward_to(struct repository *r,
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf err = STRBUF_INIT;
 
-	read_index(r->index);
+	repo_read_index(r);
 	if (checkout_fast_forward(r, from, to, 1))
 		return -1; /* the callee should have complained already */
 
@@ -538,7 +538,7 @@ static int do_recursive_merge(struct repository *r,
 	if (repo_hold_locked_index(r, &index_lock, LOCK_REPORT_ON_ERROR) < 0)
 		return -1;
 
-	read_index(r->index);
+	repo_read_index(r);
 
 	init_merge_options(&o);
 	o.ancestor = base ? base_label : "(empty tree)";
@@ -1709,7 +1709,7 @@ static int do_pick_commit(struct repository *r,
 			oidcpy(&head, the_hash_algo->empty_tree);
 		if (index_differs_from(unborn ? empty_tree_oid_hex() : "HEAD",
 				       NULL, 0))
-			return error_dirty_index(r->index, opts);
+			return error_dirty_index(r, opts);
 	}
 	discard_index(r->index);
 
@@ -1936,7 +1936,7 @@ static int read_and_refresh_cache(struct repository *r,
 {
 	struct lock_file index_lock = LOCK_INIT;
 	int index_fd = repo_hold_locked_index(r, &index_lock, 0);
-	if (read_index_preload(r->index, NULL, 0) < 0) {
+	if (repo_read_index_preload(r, NULL, 0) < 0) {
 		rollback_lock_file(&index_lock);
 		return error(_("git %s: failed to read the index"),
 			_(action_name(opts)));
@@ -2742,7 +2742,7 @@ static int do_exec(struct repository *r, const char *command_line)
 					  child_env.argv);
 
 	/* force re-reading of the cache */
-	if (discard_index(r->index) < 0 || read_index(r->index) < 0)
+	if (discard_index(r->index) < 0 || repo_read_index(r) < 0)
 		return error(_("could not read index"));
 
 	dirty = require_clean_work_tree(r, "rebase", NULL, 1, 1);
@@ -2908,7 +2908,7 @@ static int do_reset(struct repository *r,
 	unpack_tree_opts.merge = 1;
 	unpack_tree_opts.update = 1;
 
-	if (read_index_unmerged(r->index)) {
+	if (repo_read_index_unmerged(r)) {
 		rollback_lock_file(&lock);
 		strbuf_release(&ref_name);
 		return error_resolve_conflict(_(action_name(opts)));
@@ -3162,7 +3162,7 @@ static int do_merge(struct repository *r,
 
 		/* force re-reading of the cache */
 		if (!ret && (discard_index(r->index) < 0 ||
-			     read_index(r->index) < 0))
+			     repo_read_index(r) < 0))
 			ret = error(_("could not read index"));
 		goto leave_merge;
 	}
@@ -3184,7 +3184,7 @@ static int do_merge(struct repository *r,
 		commit_list_insert(j->item, &reversed);
 	free_commit_list(bases);
 
-	read_index(r->index);
+	repo_read_index(r);
 	init_merge_options(&o);
 	o.branch1 = "HEAD";
 	o.branch2 = ref_name.buf;
@@ -3785,7 +3785,7 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
 				goto release_todo_list;
 		}
 		if (index_differs_from("HEAD", NULL, 0)) {
-			res = error_dirty_index(r->index, opts);
+			res = error_dirty_index(r, opts);
 			goto release_todo_list;
 		}
 		todo_list.current++;
diff --git a/sha1-name.c b/sha1-name.c
index faa60f69e3..8669ad0b47 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1749,9 +1749,9 @@ static int get_oid_with_context_1(const char *name,
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
2.19.1.647.g708186aaf9

