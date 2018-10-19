Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CD331F453
	for <e@80x24.org>; Fri, 19 Oct 2018 14:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbeJSW7V (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 18:59:21 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35811 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbeJSW7U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 18:59:20 -0400
Received: by mail-lj1-f194.google.com with SMTP id o14-v6so31121755ljj.2
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 07:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bqkpFh4S8uCn4cLGALv/GM9IHvcXVuMhVI6aR2//fHY=;
        b=FevEz9oQ4GFSK6ocZOQ+7VNaSgEDiyb3piXssXu0IAFDeJVy258shrXndhsjaSey9c
         dMEUY2Yi/AMOKCnMyqkJZPbiF5TDpJ2ql+rSDIuPg5GgCMTRv2kOU6ZkIK5JNo72Z0lm
         09pkvY/RoofSBlZNN6cFu4yyQ16+/Cnvv3DATONiau4kBEsxhLvzIqvl1S5M6eenqyd5
         6yL52NjuEKwWF0xg5zAXwxYiZrc1KIDamk69l8bsNu0kCUivwIju4+jVWGkbnNwJNJJu
         zeOlGCXs9sse+GyDI8dx065Xi+1Ies2tu/lGRUoNtVHd04Q8QXpiHJUDNyl6E65ugfw/
         I2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bqkpFh4S8uCn4cLGALv/GM9IHvcXVuMhVI6aR2//fHY=;
        b=A/VNCXIAN+tuLqaG4pnr9sHcjiUBHGBTwyra2xf1jtwrjj8uSXB+1I9vq53n6w5QDT
         WXq3rVUEFSG77zgA9eYb4gLuCC0KTTo4wtiBi5tooor9GariBhdYiOTjw40n+DdegRlR
         mZTihHqeTywabjHYuENumH2IzUaftHNylGg9l9NXX5Sk7JmiHbv+rNFkSAstN4/NDHjw
         Q0aDWIkuKCcqfKSGxMR/V9ZQ71KckKUQsZVighXTGk0WBNZaMoxtwPayc8QIOy79BPfS
         8WzxS7MNT2k2gHacbwWxwMII3DR2XRbhQ9fxMjwh47fXOReO2CQcXoaDRKF4AgvkYc7B
         ynsg==
X-Gm-Message-State: ABuFfoiqnvkO7EAwEhcfX9ZNk1QPfl0d4RzxExGmTcFluYGO8GduX3db
        ow5Mn3b8PA/VB26kSx4tUMs9nzuE
X-Google-Smtp-Source: ACcGV63/GfKf48hXa3Bz2zuE0Jq4VOxQj/QdlsiMpo1Cmo3g6svsTLQYJspBlgBgUBwmWKTk8WIyvQ==
X-Received: by 2002:a2e:1b15:: with SMTP id b21-v6mr20042871ljb.104.1539960768635;
        Fri, 19 Oct 2018 07:52:48 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g64-v6sm4002414lfe.87.2018.10.19.07.52.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 07:52:47 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 05/19] sequencer.c: remove implicit dependency on the_index
Date:   Fri, 19 Oct 2018 16:52:23 +0200
Message-Id: <20181019145237.16079-6-pclouds@gmail.com>
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

Since we're going to pass 'struct repository *' around most of the
time instead of 'struct index_state *' because most sequencer.c
operations need more than just the index, the_repository is replaced
as well in the functions that now take 'struct repository
*'. the_repository is still present in this file, but total clean up
will be done later. It's not the main focus of this patch.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/commit.c         |   3 +-
 builtin/merge.c          |   2 +-
 builtin/rebase--helper.c |   5 +-
 builtin/revert.c         |   4 +-
 sequencer.c              | 319 ++++++++++++++++++++++-----------------
 sequencer.h              |  15 +-
 6 files changed, 197 insertions(+), 151 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 379d8c5cdf..f7bbba944d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1679,7 +1679,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 			flags |= SUMMARY_INITIAL_COMMIT;
 		if (author_date_is_interesting())
 			flags |= SUMMARY_SHOW_AUTHOR_DATE;
-		print_commit_summary(prefix, &oid, flags);
+		print_commit_summary(the_repository, prefix,
+				     &oid, flags);
 	}
 
 	UNLEAK(err);
diff --git a/builtin/merge.c b/builtin/merge.c
index 4aa6071598..db22119c93 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -896,7 +896,7 @@ static int suggest_conflicts(void)
 	filename = git_path_merge_msg(the_repository);
 	fp = xfopen(filename, "a");
 
-	append_conflicts_hint(&msgbuf);
+	append_conflicts_hint(&the_index, &msgbuf);
 	fputs(msgbuf.buf, fp);
 	strbuf_release(&msgbuf);
 	fclose(fp);
diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index f7c2a5fdc8..b66cd8cd41 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -69,11 +69,12 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 			  "--rebase-merges"));
 
 	if (command == CONTINUE && argc == 1)
-		return !!sequencer_continue(&opts);
+		return !!sequencer_continue(the_repository, &opts);
 	if (command == ABORT && argc == 1)
 		return !!sequencer_remove_state(&opts);
 	if (command == MAKE_SCRIPT && argc > 1)
-		return !!sequencer_make_script(stdout, argc, argv, flags);
+		return !!sequencer_make_script(the_repository, stdout,
+					       argc, argv, flags);
 	if ((command == SHORTEN_OIDS || command == EXPAND_OIDS) && argc == 1)
 		return !!transform_todos(flags);
 	if (command == CHECK_TODO_LIST && argc == 1)
diff --git a/builtin/revert.c b/builtin/revert.c
index c93393c89b..cd9f068195 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -199,10 +199,10 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 		return ret;
 	}
 	if (cmd == 'c')
-		return sequencer_continue(opts);
+		return sequencer_continue(the_repository, opts);
 	if (cmd == 'a')
 		return sequencer_rollback(opts);
-	return sequencer_pick_revisions(opts);
+	return sequencer_pick_revisions(the_repository, opts);
 }
 
 int cmd_revert(int argc, const char **argv, const char *prefix)
diff --git a/sequencer.c b/sequencer.c
index 90435593a4..6b79359114 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -440,9 +440,9 @@ static struct tree *empty_tree(void)
 	return lookup_tree(the_repository, the_repository->hash_algo->empty_tree);
 }
 
-static int error_dirty_index(struct replay_opts *opts)
+static int error_dirty_index(struct index_state *istate, struct replay_opts *opts)
 {
-	if (read_cache_unmerged())
+	if (read_index_unmerged(istate))
 		return error_resolve_conflict(_(action_name(opts)));
 
 	error(_("your local changes would be overwritten by %s."),
@@ -467,15 +467,18 @@ static void update_abort_safety_file(void)
 		write_file(git_path_abort_safety_file(), "%s", "");
 }
 
-static int fast_forward_to(const struct object_id *to, const struct object_id *from,
-			int unborn, struct replay_opts *opts)
+static int fast_forward_to(struct repository *r,
+			   const struct object_id *to,
+			   const struct object_id *from,
+			   int unborn,
+			   struct replay_opts *opts)
 {
 	struct ref_transaction *transaction;
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf err = STRBUF_INIT;
 
-	read_index(&the_index);
-	if (checkout_fast_forward(the_repository, from, to, 1))
+	read_index(r->index);
+	if (checkout_fast_forward(r, from, to, 1))
 		return -1; /* the callee should have complained already */
 
 	strbuf_addf(&sb, _("%s: fast-forward"), _(action_name(opts)));
@@ -501,24 +504,26 @@ static int fast_forward_to(const struct object_id *to, const struct object_id *f
 	return 0;
 }
 
-void append_conflicts_hint(struct strbuf *msgbuf)
+void append_conflicts_hint(struct index_state *istate,
+			   struct strbuf *msgbuf)
 {
 	int i;
 
 	strbuf_addch(msgbuf, '\n');
 	strbuf_commented_addf(msgbuf, "Conflicts:\n");
-	for (i = 0; i < active_nr;) {
-		const struct cache_entry *ce = active_cache[i++];
+	for (i = 0; i < istate->cache_nr;) {
+		const struct cache_entry *ce = istate->cache[i++];
 		if (ce_stage(ce)) {
 			strbuf_commented_addf(msgbuf, "\t%s\n", ce->name);
-			while (i < active_nr && !strcmp(ce->name,
-							active_cache[i]->name))
+			while (i < istate->cache_nr &&
+			       !strcmp(ce->name, istate->cache[i]->name))
 				i++;
 		}
 	}
 }
 
-static int do_recursive_merge(struct commit *base, struct commit *next,
+static int do_recursive_merge(struct repository *r,
+			      struct commit *base, struct commit *next,
 			      const char *base_label, const char *next_label,
 			      struct object_id *head, struct strbuf *msgbuf,
 			      struct replay_opts *opts)
@@ -532,7 +537,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	if (hold_locked_index(&index_lock, LOCK_REPORT_ON_ERROR) < 0)
 		return -1;
 
-	read_cache();
+	read_index(r->index);
 
 	init_merge_options(&o);
 	o.ancestor = base ? base_label : "(empty tree)";
@@ -561,7 +566,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 		return clean;
 	}
 
-	if (write_locked_index(&the_index, &index_lock,
+	if (write_locked_index(r->index, &index_lock,
 			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 		/*
 		 * TRANSLATORS: %s will be "revert", "cherry-pick" or
@@ -571,26 +576,26 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 			_(action_name(opts)));
 
 	if (!clean)
-		append_conflicts_hint(msgbuf);
+		append_conflicts_hint(r->index, msgbuf);
 
 	return !clean;
 }
 
-static struct object_id *get_cache_tree_oid(void)
+static struct object_id *get_cache_tree_oid(struct index_state *istate)
 {
-	if (!active_cache_tree)
-		active_cache_tree = cache_tree();
+	if (!istate->cache_tree)
+		istate->cache_tree = cache_tree();
 
-	if (!cache_tree_fully_valid(active_cache_tree))
-		if (cache_tree_update(&the_index, 0)) {
+	if (!cache_tree_fully_valid(istate->cache_tree))
+		if (cache_tree_update(istate, 0)) {
 			error(_("unable to update cache tree"));
 			return NULL;
 		}
 
-	return &active_cache_tree->oid;
+	return &istate->cache_tree->oid;
 }
 
-static int is_index_unchanged(void)
+static int is_index_unchanged(struct index_state *istate)
 {
 	struct object_id head_oid, *cache_tree_oid;
 	struct commit *head_commit;
@@ -611,7 +616,7 @@ static int is_index_unchanged(void)
 	if (parse_commit(head_commit))
 		return -1;
 
-	if (!(cache_tree_oid = get_cache_tree_oid()))
+	if (!(cache_tree_oid = get_cache_tree_oid(istate)))
 		return -1;
 
 	return oideq(cache_tree_oid, get_commit_tree_oid(head_commit));
@@ -816,7 +821,9 @@ N_("you have staged changes in your working tree\n"
  * interactive rebase: in that case, we will want to retain the
  * author metadata.
  */
-static int run_git_commit(const char *defmsg, struct replay_opts *opts,
+static int run_git_commit(struct repository *r,
+			  const char *defmsg,
+			  struct replay_opts *opts,
 			  unsigned int flags)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
@@ -839,7 +846,7 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 		if (!defmsg)
 			BUG("root commit without message");
 
-		if (!(cache_tree_oid = get_cache_tree_oid()))
+		if (!(cache_tree_oid = get_cache_tree_oid(r->index)))
 			res = -1;
 
 		if (!res)
@@ -1066,7 +1073,9 @@ void commit_post_rewrite(const struct commit *old_head,
 	run_rewrite_hook(&old_head->object.oid, new_head);
 }
 
-static int run_prepare_commit_msg_hook(struct strbuf *msg, const char *commit)
+static int run_prepare_commit_msg_hook(struct repository *r,
+				       struct strbuf *msg,
+				       const char *commit)
 {
 	struct argv_array hook_env = ARGV_ARRAY_INIT;
 	int ret;
@@ -1076,7 +1085,7 @@ static int run_prepare_commit_msg_hook(struct strbuf *msg, const char *commit)
 	if (write_message(msg->buf, msg->len, name, 0))
 		return -1;
 
-	argv_array_pushf(&hook_env, "GIT_INDEX_FILE=%s", get_index_file());
+	argv_array_pushf(&hook_env, "GIT_INDEX_FILE=%s", r->index_file);
 	argv_array_push(&hook_env, "GIT_EDITOR=:");
 	if (commit)
 		ret = run_hook_le(hook_env.argv, "prepare-commit-msg", name,
@@ -1132,7 +1141,9 @@ static const char *implicit_ident_advice(void)
 
 }
 
-void print_commit_summary(const char *prefix, const struct object_id *oid,
+void print_commit_summary(struct repository *r,
+			  const char *prefix,
+			  const struct object_id *oid,
 			  unsigned int flags)
 {
 	struct rev_info rev;
@@ -1143,7 +1154,7 @@ void print_commit_summary(const char *prefix, const struct object_id *oid,
 	struct strbuf author_ident = STRBUF_INIT;
 	struct strbuf committer_ident = STRBUF_INIT;
 
-	commit = lookup_commit(the_repository, oid);
+	commit = lookup_commit(r, oid);
 	if (!commit)
 		die(_("couldn't look up newly created commit"));
 	if (parse_commit(commit))
@@ -1176,7 +1187,7 @@ void print_commit_summary(const char *prefix, const struct object_id *oid,
 	strbuf_release(&author_ident);
 	strbuf_release(&committer_ident);
 
-	repo_init_revisions(the_repository, &rev, prefix);
+	repo_init_revisions(r, &rev, prefix);
 	setup_revisions(0, NULL, &rev, NULL);
 
 	rev.diff = 1;
@@ -1242,7 +1253,8 @@ static int parse_head(struct commit **head)
  *   0 - success
  *   1 - run 'git commit'
  */
-static int try_to_commit(struct strbuf *msg, const char *author,
+static int try_to_commit(struct repository *r,
+			 struct strbuf *msg, const char *author,
 			 struct replay_opts *opts, unsigned int flags,
 			 struct object_id *oid)
 {
@@ -1286,7 +1298,7 @@ static int try_to_commit(struct strbuf *msg, const char *author,
 		commit_list_insert(current_head, &parents);
 	}
 
-	if (write_index_as_tree(&tree, &the_index, get_index_file(), 0, NULL)) {
+	if (write_index_as_tree(&tree, r->index, r->index_file, 0, NULL)) {
 		res = error(_("git write-tree failed to write a tree"));
 		goto out;
 	}
@@ -1299,7 +1311,7 @@ static int try_to_commit(struct strbuf *msg, const char *author,
 	}
 
 	if (find_hook("prepare-commit-msg")) {
-		res = run_prepare_commit_msg_hook(msg, hook_commit);
+		res = run_prepare_commit_msg_hook(r, msg, hook_commit);
 		if (res)
 			goto out;
 		if (strbuf_read_file(&commit_msg, git_path_commit_editmsg(),
@@ -1348,7 +1360,8 @@ static int try_to_commit(struct strbuf *msg, const char *author,
 	return res;
 }
 
-static int do_commit(const char *msg_file, const char *author,
+static int do_commit(struct repository *r,
+		     const char *msg_file, const char *author,
 		     struct replay_opts *opts, unsigned int flags)
 {
 	int res = 1;
@@ -1363,20 +1376,20 @@ static int do_commit(const char *msg_file, const char *author,
 					     "from '%s'"),
 					   msg_file);
 
-		res = try_to_commit(msg_file ? &sb : NULL, author, opts, flags,
-				    &oid);
+		res = try_to_commit(r, msg_file ? &sb : NULL,
+				    author, opts, flags, &oid);
 		strbuf_release(&sb);
 		if (!res) {
-			unlink(git_path_cherry_pick_head(the_repository));
-			unlink(git_path_merge_msg(the_repository));
+			unlink(git_path_cherry_pick_head(r));
+			unlink(git_path_merge_msg(r));
 			if (!is_rebase_i(opts))
-				print_commit_summary(NULL, &oid,
+				print_commit_summary(r, NULL, &oid,
 						SUMMARY_SHOW_AUTHOR_DATE);
 			return res;
 		}
 	}
 	if (res == 1)
-		return run_git_commit(msg_file, opts, flags);
+		return run_git_commit(r, msg_file, opts, flags);
 
 	return res;
 }
@@ -1404,7 +1417,9 @@ static int is_original_commit_empty(struct commit *commit)
 /*
  * Do we run "git commit" with "--allow-empty"?
  */
-static int allow_empty(struct replay_opts *opts, struct commit *commit)
+static int allow_empty(struct repository *r,
+		       struct replay_opts *opts,
+		       struct commit *commit)
 {
 	int index_unchanged, empty_commit;
 
@@ -1421,7 +1436,7 @@ static int allow_empty(struct replay_opts *opts, struct commit *commit)
 	if (!opts->allow_empty)
 		return 0; /* let "git commit" barf as necessary */
 
-	index_unchanged = is_index_unchanged();
+	index_unchanged = is_index_unchanged(r->index);
 	if (index_unchanged < 0)
 		return index_unchanged;
 	if (!index_unchanged)
@@ -1652,11 +1667,14 @@ static void record_in_rewritten(struct object_id *oid,
 		flush_rewritten_pending();
 }
 
-static int do_pick_commit(enum todo_command command, struct commit *commit,
-		struct replay_opts *opts, int final_fixup)
+static int do_pick_commit(struct repository *r,
+			  enum todo_command command,
+			  struct commit *commit,
+			  struct replay_opts *opts,
+			  int final_fixup)
 {
 	unsigned int flags = opts->edit ? EDIT_MSG : 0;
-	const char *msg_file = opts->edit ? NULL : git_path_merge_msg(the_repository);
+	const char *msg_file = opts->edit ? NULL : git_path_merge_msg(r);
 	struct object_id head;
 	struct commit *base, *next, *parent;
 	const char *base_label, *next_label;
@@ -1672,7 +1690,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		 * that represents the "current" state for merge-recursive
 		 * to work on.
 		 */
-		if (write_index_as_tree(&head, &the_index, get_index_file(), 0, NULL))
+		if (write_index_as_tree(&head, r->index, r->index_file, 0, NULL))
 			return error(_("your index file is unmerged."));
 	} else {
 		unborn = get_oid("HEAD", &head);
@@ -1687,9 +1705,9 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 			oidcpy(&head, the_hash_algo->empty_tree);
 		if (index_differs_from(unborn ? empty_tree_oid_hex() : "HEAD",
 				       NULL, 0))
-			return error_dirty_index(opts);
+			return error_dirty_index(r->index, opts);
 	}
-	discard_cache();
+	discard_index(r->index);
 
 	if (!commit->parents)
 		parent = NULL;
@@ -1725,7 +1743,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	     (!parent && unborn))) {
 		if (is_rebase_i(opts))
 			write_author_script(msg.message);
-		res = fast_forward_to(&commit->object.oid, &head, unborn,
+		res = fast_forward_to(r, &commit->object.oid, &head, unborn,
 			opts);
 		if (res || command != TODO_REWORD)
 			goto leave;
@@ -1798,12 +1816,12 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 			flags |= CLEANUP_MSG;
 			msg_file = rebase_path_fixup_msg();
 		} else {
-			const char *dest = git_path_squash_msg(the_repository);
+			const char *dest = git_path_squash_msg(r);
 			unlink(dest);
 			if (copy_file(dest, rebase_path_squash_msg(), 0666))
 				return error(_("could not rename '%s' to '%s'"),
 					     rebase_path_squash_msg(), dest);
-			unlink(git_path_merge_msg(the_repository));
+			unlink(git_path_merge_msg(r));
 			msg_file = dest;
 			flags |= EDIT_MSG;
 		}
@@ -1815,23 +1833,23 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	if (is_rebase_i(opts) && write_author_script(msg.message) < 0)
 		res = -1;
 	else if (!opts->strategy || !strcmp(opts->strategy, "recursive") || command == TODO_REVERT) {
-		res = do_recursive_merge(base, next, base_label, next_label,
+		res = do_recursive_merge(r, base, next, base_label, next_label,
 					 &head, &msgbuf, opts);
 		if (res < 0)
 			goto leave;
 
 		res |= write_message(msgbuf.buf, msgbuf.len,
-				     git_path_merge_msg(the_repository), 0);
+				     git_path_merge_msg(r), 0);
 	} else {
 		struct commit_list *common = NULL;
 		struct commit_list *remotes = NULL;
 
 		res = write_message(msgbuf.buf, msgbuf.len,
-				    git_path_merge_msg(the_repository), 0);
+				    git_path_merge_msg(r), 0);
 
 		commit_list_insert(base, &common);
 		commit_list_insert(next, &remotes);
-		res |= try_merge_command(the_repository, opts->strategy,
+		res |= try_merge_command(r, opts->strategy,
 					 opts->xopts_nr, (const char **)opts->xopts,
 					common, oid_to_hex(&head), remotes);
 		free_commit_list(common);
@@ -1860,11 +1878,11 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		      : _("could not apply %s... %s"),
 		      short_commit_name(commit), msg.subject);
 		print_advice(res == 1, opts);
-		repo_rerere(the_repository, opts->allow_rerere_auto);
+		repo_rerere(r, opts->allow_rerere_auto);
 		goto leave;
 	}
 
-	allow = allow_empty(opts, commit);
+	allow = allow_empty(r, opts, commit);
 	if (allow < 0) {
 		res = allow;
 		goto leave;
@@ -1873,7 +1891,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	if (!opts->no_commit) {
 fast_forward_edit:
 		if (author || command == TODO_REVERT || (flags & AMEND_MSG))
-			res = do_commit(msg_file, author, opts, flags);
+			res = do_commit(r, msg_file, author, opts, flags);
 		else
 			res = error(_("unable to parse commit author"));
 	}
@@ -1909,18 +1927,19 @@ static int prepare_revs(struct replay_opts *opts)
 	return 0;
 }
 
-static int read_and_refresh_cache(struct replay_opts *opts)
+static int read_and_refresh_cache(struct repository *r,
+				  struct replay_opts *opts)
 {
 	struct lock_file index_lock = LOCK_INIT;
 	int index_fd = hold_locked_index(&index_lock, 0);
-	if (read_index_preload(&the_index, NULL, 0) < 0) {
+	if (read_index_preload(r->index, NULL, 0) < 0) {
 		rollback_lock_file(&index_lock);
 		return error(_("git %s: failed to read the index"),
 			_(action_name(opts)));
 	}
-	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL, NULL);
+	refresh_index(r->index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL, NULL);
 	if (index_fd >= 0) {
-		if (write_locked_index(&the_index, &index_lock,
+		if (write_locked_index(r->index, &index_lock,
 				       COMMIT_LOCK | SKIP_IF_UNCHANGED)) {
 			return error(_("git %s: failed to refresh the index"),
 				_(action_name(opts)));
@@ -2583,7 +2602,9 @@ static int save_opts(struct replay_opts *opts)
 	return res;
 }
 
-static int make_patch(struct commit *commit, struct replay_opts *opts)
+static int make_patch(struct repository *r,
+		      struct commit *commit,
+		      struct replay_opts *opts)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct rev_info log_tree_opt;
@@ -2599,7 +2620,7 @@ static int make_patch(struct commit *commit, struct replay_opts *opts)
 
 	strbuf_addf(&buf, "%s/patch", get_dir(opts));
 	memset(&log_tree_opt, 0, sizeof(log_tree_opt));
-	repo_init_revisions(the_repository, &log_tree_opt, NULL);
+	repo_init_revisions(r, &log_tree_opt, NULL);
 	log_tree_opt.abbrev = 0;
 	log_tree_opt.diff = 1;
 	log_tree_opt.diffopt.output_format = DIFF_FORMAT_PATCH;
@@ -2639,17 +2660,19 @@ static int intend_to_amend(void)
 	return write_message(p, strlen(p), rebase_path_amend(), 1);
 }
 
-static int error_with_patch(struct commit *commit,
-	const char *subject, int subject_len,
-	struct replay_opts *opts, int exit_code, int to_amend)
+static int error_with_patch(struct repository *r,
+			    struct commit *commit,
+			    const char *subject, int subject_len,
+			    struct replay_opts *opts,
+			    int exit_code, int to_amend)
 {
 	if (commit) {
-		if (make_patch(commit, opts))
+		if (make_patch(r, commit, opts))
 			return -1;
 	} else if (copy_file(rebase_path_message(),
-			     git_path_merge_msg(the_repository), 0666))
+			     git_path_merge_msg(r), 0666))
 		return error(_("unable to copy '%s' to '%s'"),
-			     git_path_merge_msg(the_repository), rebase_path_message());
+			     git_path_merge_msg(r), rebase_path_message());
 
 	if (to_amend) {
 		if (intend_to_amend())
@@ -2680,21 +2703,24 @@ static int error_with_patch(struct commit *commit,
 	return exit_code;
 }
 
-static int error_failed_squash(struct commit *commit,
-	struct replay_opts *opts, int subject_len, const char *subject)
+static int error_failed_squash(struct repository *r,
+			       struct commit *commit,
+			       struct replay_opts *opts,
+			       int subject_len,
+			       const char *subject)
 {
 	if (copy_file(rebase_path_message(), rebase_path_squash_msg(), 0666))
 		return error(_("could not copy '%s' to '%s'"),
 			rebase_path_squash_msg(), rebase_path_message());
-	unlink(git_path_merge_msg(the_repository));
-	if (copy_file(git_path_merge_msg(the_repository), rebase_path_message(), 0666))
+	unlink(git_path_merge_msg(r));
+	if (copy_file(git_path_merge_msg(r), rebase_path_message(), 0666))
 		return error(_("could not copy '%s' to '%s'"),
 			     rebase_path_message(),
-			     git_path_merge_msg(the_repository));
-	return error_with_patch(commit, subject, subject_len, opts, 1, 0);
+			     git_path_merge_msg(r));
+	return error_with_patch(r, commit, subject, subject_len, opts, 1, 0);
 }
 
-static int do_exec(const char *command_line)
+static int do_exec(struct repository *r, const char *command_line)
 {
 	struct argv_array child_env = ARGV_ARRAY_INIT;
 	const char *child_argv[] = { NULL, NULL };
@@ -2709,10 +2735,10 @@ static int do_exec(const char *command_line)
 					  child_env.argv);
 
 	/* force re-reading of the cache */
-	if (discard_cache() < 0 || read_cache() < 0)
+	if (discard_index(r->index) < 0 || read_index(r->index) < 0)
 		return error(_("could not read index"));
 
-	dirty = require_clean_work_tree(the_repository, "rebase", NULL, 1, 1);
+	dirty = require_clean_work_tree(r, "rebase", NULL, 1, 1);
 
 	if (status) {
 		warning(_("execution failed: %s\n%s"
@@ -2778,9 +2804,9 @@ static int safe_append(const char *filename, const char *fmt, ...)
 	return 0;
 }
 
-static int do_label(const char *name, int len)
+static int do_label(struct repository *r, const char *name, int len)
 {
-	struct ref_store *refs = get_main_ref_store(the_repository);
+	struct ref_store *refs = get_main_ref_store(r);
 	struct ref_transaction *transaction;
 	struct strbuf ref_name = STRBUF_INIT, err = STRBUF_INIT;
 	struct strbuf msg = STRBUF_INIT;
@@ -2821,7 +2847,9 @@ static int do_label(const char *name, int len)
 static const char *reflog_message(struct replay_opts *opts,
 	const char *sub_action, const char *fmt, ...);
 
-static int do_reset(const char *name, int len, struct replay_opts *opts)
+static int do_reset(struct repository *r,
+		    const char *name, int len,
+		    struct replay_opts *opts)
 {
 	struct strbuf ref_name = STRBUF_INIT;
 	struct object_id oid;
@@ -2867,13 +2895,13 @@ static int do_reset(const char *name, int len, struct replay_opts *opts)
 	memset(&unpack_tree_opts, 0, sizeof(unpack_tree_opts));
 	setup_unpack_trees_porcelain(&unpack_tree_opts, "reset");
 	unpack_tree_opts.head_idx = 1;
-	unpack_tree_opts.src_index = &the_index;
-	unpack_tree_opts.dst_index = &the_index;
+	unpack_tree_opts.src_index = r->index;
+	unpack_tree_opts.dst_index = r->index;
 	unpack_tree_opts.fn = oneway_merge;
 	unpack_tree_opts.merge = 1;
 	unpack_tree_opts.update = 1;
 
-	if (read_cache_unmerged()) {
+	if (read_index_unmerged(r->index)) {
 		rollback_lock_file(&lock);
 		strbuf_release(&ref_name);
 		return error_resolve_conflict(_(action_name(opts)));
@@ -2895,9 +2923,9 @@ static int do_reset(const char *name, int len, struct replay_opts *opts)
 	}
 
 	tree = parse_tree_indirect(&oid);
-	prime_cache_tree(&the_index, tree);
+	prime_cache_tree(r->index, tree);
 
-	if (write_locked_index(&the_index, &lock, COMMIT_LOCK) < 0)
+	if (write_locked_index(r->index, &lock, COMMIT_LOCK) < 0)
 		ret = error(_("could not write index"));
 	free((void *)desc.buffer);
 
@@ -2930,7 +2958,9 @@ static struct commit *lookup_label(const char *label, int len,
 	return commit;
 }
 
-static int do_merge(struct commit *commit, const char *arg, int arg_len,
+static int do_merge(struct repository *r,
+		    struct commit *commit,
+		    const char *arg, int arg_len,
 		    int flags, struct replay_opts *opts)
 {
 	int run_commit_flags = (flags & TODO_EDIT_MERGE_MSG) ?
@@ -2997,7 +3027,7 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 			ret = error(_("octopus merge cannot be executed on "
 				      "top of a [new root]"));
 		else
-			ret = fast_forward_to(&to_merge->item->object.oid,
+			ret = fast_forward_to(r, &to_merge->item->object.oid,
 					      &head_commit->object.oid, 0,
 					      opts);
 		goto leave_merge;
@@ -3016,11 +3046,11 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 		write_author_script(message);
 		find_commit_subject(message, &body);
 		len = strlen(body);
-		ret = write_message(body, len, git_path_merge_msg(the_repository), 0);
+		ret = write_message(body, len, git_path_merge_msg(r), 0);
 		unuse_commit_buffer(commit, message);
 		if (ret) {
 			error_errno(_("could not write '%s'"),
-				    git_path_merge_msg(the_repository));
+				    git_path_merge_msg(r));
 			goto leave_merge;
 		}
 	} else {
@@ -3042,11 +3072,11 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 			len = buf.len;
 		}
 
-		ret = write_message(p, len, git_path_merge_msg(the_repository), 0);
+		ret = write_message(p, len, git_path_merge_msg(r), 0);
 		strbuf_release(&buf);
 		if (ret) {
 			error_errno(_("could not write '%s'"),
-				    git_path_merge_msg(the_repository));
+				    git_path_merge_msg(r));
 			goto leave_merge;
 		}
 	}
@@ -3082,7 +3112,7 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 
 	if (can_fast_forward) {
 		rollback_lock_file(&lock);
-		ret = fast_forward_to(&commit->object.oid,
+		ret = fast_forward_to(r, &commit->object.oid,
 				      &head_commit->object.oid, 0, opts);
 		goto leave_merge;
 	}
@@ -3107,7 +3137,7 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 		argv_array_push(&cmd.args, "--no-log");
 		argv_array_push(&cmd.args, "--no-stat");
 		argv_array_push(&cmd.args, "-F");
-		argv_array_push(&cmd.args, git_path_merge_msg(the_repository));
+		argv_array_push(&cmd.args, git_path_merge_msg(r));
 		if (opts->gpg_sign)
 			argv_array_push(&cmd.args, opts->gpg_sign);
 
@@ -3117,22 +3147,23 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 					oid_to_hex(&j->item->object.oid));
 
 		strbuf_release(&ref_name);
-		unlink(git_path_cherry_pick_head(the_repository));
+		unlink(git_path_cherry_pick_head(r));
 		rollback_lock_file(&lock);
 
 		rollback_lock_file(&lock);
 		ret = run_command(&cmd);
 
 		/* force re-reading of the cache */
-		if (!ret && (discard_cache() < 0 || read_cache() < 0))
+		if (!ret && (discard_index(r->index) < 0 ||
+			     read_index(r->index) < 0))
 			ret = error(_("could not read index"));
 		goto leave_merge;
 	}
 
 	merge_commit = to_merge->item;
 	write_message(oid_to_hex(&merge_commit->object.oid), GIT_SHA1_HEXSZ,
-		      git_path_merge_head(the_repository), 0);
-	write_message("no-ff", 5, git_path_merge_mode(the_repository), 0);
+		      git_path_merge_head(r), 0);
+	write_message("no-ff", 5, git_path_merge_mode(r), 0);
 
 	bases = get_merge_bases(head_commit, merge_commit);
 	if (bases && oideq(&merge_commit->object.oid,
@@ -3146,7 +3177,7 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 		commit_list_insert(j->item, &reversed);
 	free_commit_list(bases);
 
-	read_cache();
+	read_index(r->index);
 	init_merge_options(&o);
 	o.branch1 = "HEAD";
 	o.branch2 = ref_name.buf;
@@ -3171,23 +3202,23 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 	 */
 	ret = !ret;
 
-	if (active_cache_changed &&
-	    write_locked_index(&the_index, &lock, COMMIT_LOCK)) {
+	if (r->index->cache_changed &&
+	    write_locked_index(r->index, &lock, COMMIT_LOCK)) {
 		ret = error(_("merge: Unable to write new index file"));
 		goto leave_merge;
 	}
 
 	rollback_lock_file(&lock);
 	if (ret)
-		repo_rerere(the_repository, opts->allow_rerere_auto);
+		repo_rerere(r, opts->allow_rerere_auto);
 	else
 		/*
 		 * In case of problems, we now want to return a positive
 		 * value (a negative one would indicate that the `merge`
 		 * command needs to be rescheduled).
 		 */
-		ret = !!run_git_commit(git_path_merge_msg(the_repository), opts,
-				     run_commit_flags);
+		ret = !!run_git_commit(r, git_path_merge_msg(r), opts,
+				       run_commit_flags);
 
 leave_merge:
 	strbuf_release(&ref_name);
@@ -3297,7 +3328,9 @@ N_("Could not execute the todo command\n"
 "    git rebase --edit-todo\n"
 "    git rebase --continue\n");
 
-static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
+static int pick_commits(struct repository *r,
+			struct todo_list *todo_list,
+			struct replay_opts *opts)
 {
 	int res = 0, reschedule = 0;
 
@@ -3305,7 +3338,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 	if (opts->allow_ff)
 		assert(!(opts->signoff || opts->no_commit ||
 				opts->record_origin || opts->edit));
-	if (read_and_refresh_cache(opts))
+	if (read_and_refresh_cache(r, opts))
 		return -1;
 
 	while (todo_list->current < todo_list->nr) {
@@ -3338,7 +3371,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 				setenv("GIT_REFLOG_ACTION", reflog_message(opts,
 					command_to_string(item->command), NULL),
 					1);
-			res = do_pick_commit(item->command, item->commit,
+			res = do_pick_commit(r, item->command, item->commit,
 					opts, is_final_fixup(todo_list));
 			if (is_rebase_i(opts) && res < 0) {
 				/* Reschedule */
@@ -3358,7 +3391,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 						_("Stopped at %s...  %.*s\n"),
 						short_commit_name(commit),
 						item->arg_len, item->arg);
-				return error_with_patch(commit,
+				return error_with_patch(r, commit,
 					item->arg, item->arg_len, opts, res,
 					!res);
 			}
@@ -3368,7 +3401,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			if (res && is_fixup(item->command)) {
 				if (res == 1)
 					intend_to_amend();
-				return error_failed_squash(item->commit, opts,
+				return error_failed_squash(r, item->commit, opts,
 					item->arg_len, item->arg);
 			} else if (res && is_rebase_i(opts) && item->commit) {
 				int to_amend = 0;
@@ -3387,7 +3420,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 				      oideq(&opts->squash_onto, &oid))))
 					to_amend = 1;
 
-				return res | error_with_patch(item->commit,
+				return res | error_with_patch(r, item->commit,
 						item->arg, item->arg_len, opts,
 						res, to_amend);
 			}
@@ -3397,7 +3430,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			struct stat st;
 
 			*end_of_arg = '\0';
-			res = do_exec(item->arg);
+			res = do_exec(r, item->arg);
 			*end_of_arg = saved;
 
 			/* Reread the todo file if it has changed. */
@@ -3414,13 +3447,13 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 				todo_list->current = -1;
 			}
 		} else if (item->command == TODO_LABEL) {
-			if ((res = do_label(item->arg, item->arg_len)))
+			if ((res = do_label(r, item->arg, item->arg_len)))
 				reschedule = 1;
 		} else if (item->command == TODO_RESET) {
-			if ((res = do_reset(item->arg, item->arg_len, opts)))
+			if ((res = do_reset(r, item->arg, item->arg_len, opts)))
 				reschedule = 1;
 		} else if (item->command == TODO_MERGE) {
-			if ((res = do_merge(item->commit,
+			if ((res = do_merge(r, item->commit,
 					    item->arg, item->arg_len,
 					    item->flags, opts)) < 0)
 				reschedule = 1;
@@ -3429,7 +3462,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 						    peek_command(todo_list, 1));
 			if (res > 0)
 				/* failed with merge conflicts */
-				return error_with_patch(item->commit,
+				return error_with_patch(r, item->commit,
 							item->arg,
 							item->arg_len, opts,
 							res, 0);
@@ -3445,7 +3478,8 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			if (save_todo(todo_list, opts))
 				return -1;
 			if (item->commit)
-				return error_with_patch(item->commit,
+				return error_with_patch(r,
+							item->commit,
 							item->arg,
 							item->arg_len, opts,
 							res, 0);
@@ -3510,7 +3544,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			struct object_id orig, head;
 
 			memset(&log_tree_opt, 0, sizeof(log_tree_opt));
-			repo_init_revisions(the_repository, &log_tree_opt, NULL);
+			repo_init_revisions(r, &log_tree_opt, NULL);
 			log_tree_opt.diff = 1;
 			log_tree_opt.diffopt.output_format =
 				DIFF_FORMAT_DIFFSTAT;
@@ -3577,16 +3611,17 @@ static int continue_single_pick(void)
 	return run_command_v_opt(argv, RUN_GIT_CMD);
 }
 
-static int commit_staged_changes(struct replay_opts *opts,
+static int commit_staged_changes(struct repository *r,
+				 struct replay_opts *opts,
 				 struct todo_list *todo_list)
 {
 	unsigned int flags = ALLOW_EMPTY | EDIT_MSG;
 	unsigned int final_fixup = 0, is_clean;
 
-	if (has_unstaged_changes(the_repository, 1))
+	if (has_unstaged_changes(r, 1))
 		return error(_("cannot rebase: You have unstaged changes."));
 
-	is_clean = !has_uncommitted_changes(the_repository, 0);
+	is_clean = !has_uncommitted_changes(r, 0);
 
 	if (file_exists(rebase_path_amend())) {
 		struct strbuf rev = STRBUF_INIT;
@@ -3686,7 +3721,7 @@ static int commit_staged_changes(struct replay_opts *opts,
 	}
 
 	if (is_clean) {
-		const char *cherry_pick_head = git_path_cherry_pick_head(the_repository);
+		const char *cherry_pick_head = git_path_cherry_pick_head(r);
 
 		if (file_exists(cherry_pick_head) && unlink(cherry_pick_head))
 			return error(_("could not remove CHERRY_PICK_HEAD"));
@@ -3694,7 +3729,7 @@ static int commit_staged_changes(struct replay_opts *opts,
 			return 0;
 	}
 
-	if (run_git_commit(final_fixup ? NULL : rebase_path_message(),
+	if (run_git_commit(r, final_fixup ? NULL : rebase_path_message(),
 			   opts, flags))
 		return error(_("could not commit staged changes."));
 	unlink(rebase_path_amend());
@@ -3714,12 +3749,12 @@ static int commit_staged_changes(struct replay_opts *opts,
 	return 0;
 }
 
-int sequencer_continue(struct replay_opts *opts)
+int sequencer_continue(struct repository *r, struct replay_opts *opts)
 {
 	struct todo_list todo_list = TODO_LIST_INIT;
 	int res;
 
-	if (read_and_refresh_cache(opts))
+	if (read_and_refresh_cache(r, opts))
 		return -1;
 
 	if (read_populate_opts(opts))
@@ -3727,7 +3762,7 @@ int sequencer_continue(struct replay_opts *opts)
 	if (is_rebase_i(opts)) {
 		if ((res = read_populate_todo(&todo_list, opts)))
 			goto release_todo_list;
-		if (commit_staged_changes(opts, &todo_list))
+		if (commit_staged_changes(r, opts, &todo_list))
 			return -1;
 	} else if (!file_exists(get_todo_path(opts)))
 		return continue_single_pick();
@@ -3736,14 +3771,14 @@ int sequencer_continue(struct replay_opts *opts)
 
 	if (!is_rebase_i(opts)) {
 		/* Verify that the conflict has been resolved */
-		if (file_exists(git_path_cherry_pick_head(the_repository)) ||
-		    file_exists(git_path_revert_head(the_repository))) {
+		if (file_exists(git_path_cherry_pick_head(r)) ||
+		    file_exists(git_path_revert_head(r))) {
 			res = continue_single_pick();
 			if (res)
 				goto release_todo_list;
 		}
 		if (index_differs_from("HEAD", NULL, 0)) {
-			res = error_dirty_index(opts);
+			res = error_dirty_index(r->index, opts);
 			goto release_todo_list;
 		}
 		todo_list.current++;
@@ -3757,27 +3792,30 @@ int sequencer_continue(struct replay_opts *opts)
 		strbuf_release(&buf);
 	}
 
-	res = pick_commits(&todo_list, opts);
+	res = pick_commits(r, &todo_list, opts);
 release_todo_list:
 	todo_list_release(&todo_list);
 	return res;
 }
 
-static int single_pick(struct commit *cmit, struct replay_opts *opts)
+static int single_pick(struct repository *r,
+		       struct commit *cmit,
+		       struct replay_opts *opts)
 {
 	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
-	return do_pick_commit(opts->action == REPLAY_PICK ?
+	return do_pick_commit(r, opts->action == REPLAY_PICK ?
 		TODO_PICK : TODO_REVERT, cmit, opts, 0);
 }
 
-int sequencer_pick_revisions(struct replay_opts *opts)
+int sequencer_pick_revisions(struct repository *r,
+			     struct replay_opts *opts)
 {
 	struct todo_list todo_list = TODO_LIST_INIT;
 	struct object_id oid;
 	int i, res;
 
 	assert(opts->revs);
-	if (read_and_refresh_cache(opts))
+	if (read_and_refresh_cache(r, opts))
 		return -1;
 
 	for (i = 0; i < opts->revs->pending.nr; i++) {
@@ -3789,8 +3827,8 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 			continue;
 
 		if (!get_oid(name, &oid)) {
-			if (!lookup_commit_reference_gently(the_repository, &oid, 1)) {
-				enum object_type type = oid_object_info(the_repository,
+			if (!lookup_commit_reference_gently(r, &oid, 1)) {
+				enum object_type type = oid_object_info(r,
 									&oid,
 									NULL);
 				return error(_("%s: can't cherry-pick a %s"),
@@ -3819,7 +3857,7 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 			return error(_("empty commit set passed"));
 		if (get_revision(opts->revs))
 			BUG("unexpected extra commit from walk");
-		return single_pick(cmit, opts);
+		return single_pick(r, cmit, opts);
 	}
 
 	/*
@@ -3838,7 +3876,7 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 	if (save_opts(opts))
 		return -1;
 	update_abort_safety_file();
-	res = pick_commits(&todo_list, opts);
+	res = pick_commits(r, &todo_list, opts);
 	todo_list_release(&todo_list);
 	return res;
 }
@@ -4242,7 +4280,8 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 	return 0;
 }
 
-int sequencer_make_script(FILE *out, int argc, const char **argv,
+int sequencer_make_script(struct repository *r, FILE *out,
+			  int argc, const char **argv,
 			  unsigned flags)
 {
 	char *format = NULL;
@@ -4254,7 +4293,7 @@ int sequencer_make_script(FILE *out, int argc, const char **argv,
 	const char *insn = flags & TODO_LIST_ABBREVIATE_CMDS ? "p" : "pick";
 	int rebase_merges = flags & TODO_LIST_REBASE_MERGES;
 
-	repo_init_revisions(the_repository, &revs, NULL);
+	repo_init_revisions(r, &revs, NULL);
 	revs.verbose_header = 1;
 	if (!rebase_merges)
 		revs.max_parents = 1;
diff --git a/sequencer.h b/sequencer.h
index c986bc8251..ad151e95c7 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -5,6 +5,7 @@
 #include "strbuf.h"
 
 struct commit;
+struct repository;
 
 const char *git_path_commit_editmsg(void);
 const char *git_path_seq_dir(void);
@@ -64,8 +65,9 @@ struct replay_opts {
 
 /* Call this to setup defaults before parsing command line options */
 void sequencer_init_config(struct replay_opts *opts);
-int sequencer_pick_revisions(struct replay_opts *opts);
-int sequencer_continue(struct replay_opts *opts);
+int sequencer_pick_revisions(struct repository *repo,
+			     struct replay_opts *opts);
+int sequencer_continue(struct repository *repo, struct replay_opts *opts);
 int sequencer_rollback(struct replay_opts *opts);
 int sequencer_remove_state(struct replay_opts *opts);
 
@@ -79,7 +81,8 @@ int sequencer_remove_state(struct replay_opts *opts);
  * commits should be rebased onto the new base, this flag needs to be passed.
  */
 #define TODO_LIST_REBASE_COUSINS (1U << 4)
-int sequencer_make_script(FILE *out, int argc, const char **argv,
+int sequencer_make_script(struct repository *repo, FILE *out,
+			  int argc, const char **argv,
 			  unsigned flags);
 
 int sequencer_add_exec_commands(const char *command);
@@ -98,7 +101,7 @@ extern const char sign_off_header[];
  */
 void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag);
 
-void append_conflicts_hint(struct strbuf *msgbuf);
+void append_conflicts_hint(struct index_state *istate, struct strbuf *msgbuf);
 int message_is_empty(const struct strbuf *sb,
 		     enum commit_msg_cleanup_mode cleanup_mode);
 int template_untouched(const struct strbuf *sb, const char *template_file,
@@ -112,6 +115,8 @@ void commit_post_rewrite(const struct commit *current_head,
 
 #define SUMMARY_INITIAL_COMMIT   (1 << 0)
 #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
-void print_commit_summary(const char *prefix, const struct object_id *oid,
+void print_commit_summary(struct repository *repo,
+			  const char *prefix,
+			  const struct object_id *oid,
 			  unsigned int flags);
 #endif
-- 
2.19.1.647.g708186aaf9

