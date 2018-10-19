Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 650F31F453
	for <e@80x24.org>; Fri, 19 Oct 2018 14:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeJSW7U (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 18:59:20 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34055 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbeJSW7U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 18:59:20 -0400
Received: by mail-lj1-f193.google.com with SMTP id j17-v6so31124291lja.1
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 07:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QcFlIXl5iPjK3zP1ZW2iheowNvvdVY2b/yTRdLz2OdU=;
        b=b8cd+uGaVYQdpx70lZmXDeYsJAPkpiIvYMZRXSes9BiVhs6+J44OdHLD1WIn+fkZjl
         lWv2joE2iSgY3mmv+LPOKyXe9jYuJJBZGpAlzZYUbxuQ1EKg5huRu+yBUkoxE+5Rz/qX
         5NTry5HJPWrWJHAYqWMgOX+vsXKH7dEAG/NWJuIvbSx78XhWQVG/6ndMKic3vGiwlZ6r
         ql+1D4/KZcq9sl3+oLx106GnNteTX+nVzlPE1AT0FfWlhQx+fRMariwJ1GbuyvhAPih3
         PNZdhPcOW2E8MZ4vcPqwpWgZF/Su4zNBsNUrexeHbe79sCDspjxSr1PqfasfGOOJuou1
         lzng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QcFlIXl5iPjK3zP1ZW2iheowNvvdVY2b/yTRdLz2OdU=;
        b=RBR2GG+J239Dt3NEgRht5uHnCdCSOakWwiTtc8RQd68NH+HX4/kt3gy1h5jOHisNDn
         9ZPqg0Sc0OCbl6IiBgb2nwAH+OOHZLkH9OfVGFX5AC3AYtZq+MunqdwvfeJD+FYMKKYw
         mQmJYb0dl5KFx9LVujxgABc3OgReAyoDVZaAaCDk2Dydu7DV23GsiCVlZoVQ7F8IXHmD
         78cjmQ59A8/6mslCDjpH48l179Bi1Voq26ZNtYOWTe4iuV4aueX/ADx5OwjXUekHG0tr
         h/3uTbaNVgrEeYhtZw9mkp2ODGHSBweRqBVhOxywE90ggSd78NWKSYR7k5ftlKdwuzzW
         LyNg==
X-Gm-Message-State: ABuFfogh8aRVlv+GBIXupOHcNo/2jcA7rWnVH/VAW79kDvIy5EnlbXWh
        bC5cJrCQYiLqRlcD4rWcyarUHhuz
X-Google-Smtp-Source: ACcGV62MjrS564vID6S+13op3++KEIHZsPXwLP1jqsw3YkZIVKF2LzDld41RHm+u492LIgFEzy1UVw==
X-Received: by 2002:a2e:6f0c:: with SMTP id k12-v6mr23266449ljc.66.1539960769732;
        Fri, 19 Oct 2018 07:52:49 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g64-v6sm4002414lfe.87.2018.10.19.07.52.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 07:52:49 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 06/19] sequencer.c: remove implicit dependency on the_repository
Date:   Fri, 19 Oct 2018 16:52:24 +0200
Message-Id: <20181019145237.16079-7-pclouds@gmail.com>
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

Note that the_hash_algo stays, even if we can easily replace it with
repo->hash_algo. My reason is I still believe tying hash_algo to a
struct repository is a wrong move. But if I'm wrong, we can always go
for another round of conversion.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/rebase--helper.c |  10 ++--
 builtin/revert.c         |   2 +-
 sequencer.c              | 108 +++++++++++++++++++++------------------
 sequencer.h              |  12 ++---
 4 files changed, 70 insertions(+), 62 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index b66cd8cd41..605fcaa89c 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -76,14 +76,14 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		return !!sequencer_make_script(the_repository, stdout,
 					       argc, argv, flags);
 	if ((command == SHORTEN_OIDS || command == EXPAND_OIDS) && argc == 1)
-		return !!transform_todos(flags);
+		return !!transform_todos(the_repository, flags);
 	if (command == CHECK_TODO_LIST && argc == 1)
-		return !!check_todo_list();
+		return !!check_todo_list(the_repository);
 	if (command == SKIP_UNNECESSARY_PICKS && argc == 1)
-		return !!skip_unnecessary_picks();
+		return !!skip_unnecessary_picks(the_repository);
 	if (command == REARRANGE_SQUASH && argc == 1)
-		return !!rearrange_squash();
+		return !!rearrange_squash(the_repository);
 	if (command == ADD_EXEC && argc == 2)
-		return !!sequencer_add_exec_commands(argv[1]);
+		return !!sequencer_add_exec_commands(the_repository, argv[1]);
 	usage_with_options(builtin_rebase_helper_usage, options);
 }
diff --git a/builtin/revert.c b/builtin/revert.c
index cd9f068195..1fa75b2773 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -201,7 +201,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 	if (cmd == 'c')
 		return sequencer_continue(the_repository, opts);
 	if (cmd == 'a')
-		return sequencer_rollback(opts);
+		return sequencer_rollback(the_repository, opts);
 	return sequencer_pick_revisions(the_repository, opts);
 }
 
diff --git a/sequencer.c b/sequencer.c
index 6b79359114..2c2ea2b45d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -351,7 +351,8 @@ static void free_message(struct commit *commit, struct commit_message *msg)
 	unuse_commit_buffer(commit, msg->message);
 }
 
-static void print_advice(int show_hint, struct replay_opts *opts)
+static void print_advice(struct repository *r, int show_hint,
+			 struct replay_opts *opts)
 {
 	char *msg = getenv("GIT_CHERRY_PICK_HELP");
 
@@ -362,7 +363,7 @@ static void print_advice(int show_hint, struct replay_opts *opts)
 		 * (typically rebase --interactive) wants to take care
 		 * of the commit itself so remove CHERRY_PICK_HEAD
 		 */
-		unlink(git_path_cherry_pick_head(the_repository));
+		unlink(git_path_cherry_pick_head(r));
 		return;
 	}
 
@@ -435,9 +436,9 @@ static int read_oneliner(struct strbuf *buf,
 	return 1;
 }
 
-static struct tree *empty_tree(void)
+static struct tree *empty_tree(struct repository *r)
 {
-	return lookup_tree(the_repository, the_repository->hash_algo->empty_tree);
+	return lookup_tree(r, the_hash_algo->empty_tree);
 }
 
 static int error_dirty_index(struct index_state *istate, struct replay_opts *opts)
@@ -548,8 +549,8 @@ static int do_recursive_merge(struct repository *r,
 	o.show_rename_progress = 1;
 
 	head_tree = parse_tree_indirect(head);
-	next_tree = next ? get_commit_tree(next) : empty_tree();
-	base_tree = base ? get_commit_tree(base) : empty_tree();
+	next_tree = next ? get_commit_tree(next) : empty_tree(r);
+	base_tree = base ? get_commit_tree(base) : empty_tree(r);
 
 	for (xopt = opts->xopts; xopt != opts->xopts + opts->xopts_nr; xopt++)
 		parse_merge_opt(&o, *xopt);
@@ -595,15 +596,16 @@ static struct object_id *get_cache_tree_oid(struct index_state *istate)
 	return &istate->cache_tree->oid;
 }
 
-static int is_index_unchanged(struct index_state *istate)
+static int is_index_unchanged(struct repository *r)
 {
 	struct object_id head_oid, *cache_tree_oid;
 	struct commit *head_commit;
+	struct index_state *istate = r->index;
 
 	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &head_oid, NULL))
 		return error(_("could not resolve HEAD commit"));
 
-	head_commit = lookup_commit(the_repository, &head_oid);
+	head_commit = lookup_commit(r, &head_oid);
 
 	/*
 	 * If head_commit is NULL, check_commit, called from
@@ -1221,7 +1223,7 @@ void print_commit_summary(struct repository *r,
 	strbuf_release(&format);
 }
 
-static int parse_head(struct commit **head)
+static int parse_head(struct repository *r, struct commit **head)
 {
 	struct commit *current_head;
 	struct object_id oid;
@@ -1229,7 +1231,7 @@ static int parse_head(struct commit **head)
 	if (get_oid("HEAD", &oid)) {
 		current_head = NULL;
 	} else {
-		current_head = lookup_commit_reference(the_repository, &oid);
+		current_head = lookup_commit_reference(r, &oid);
 		if (!current_head)
 			return error(_("could not parse HEAD"));
 		if (!oideq(&oid, &current_head->object.oid)) {
@@ -1269,7 +1271,7 @@ static int try_to_commit(struct repository *r,
 	enum commit_msg_cleanup_mode cleanup;
 	int res = 0;
 
-	if (parse_head(&current_head))
+	if (parse_head(r, &current_head))
 		return -1;
 
 	if (flags & AMEND_MSG) {
@@ -1436,7 +1438,7 @@ static int allow_empty(struct repository *r,
 	if (!opts->allow_empty)
 		return 0; /* let "git commit" barf as necessary */
 
-	index_unchanged = is_index_unchanged(r->index);
+	index_unchanged = is_index_unchanged(r);
 	if (index_unchanged < 0)
 		return index_unchanged;
 	if (!index_unchanged)
@@ -1538,8 +1540,10 @@ static int is_pick_or_similar(enum todo_command command)
 	}
 }
 
-static int update_squash_messages(enum todo_command command,
-		struct commit *commit, struct replay_opts *opts)
+static int update_squash_messages(struct repository *r,
+				  enum todo_command command,
+				  struct commit *commit,
+				  struct replay_opts *opts)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int res;
@@ -1568,7 +1572,7 @@ static int update_squash_messages(enum todo_command command,
 
 		if (get_oid("HEAD", &head))
 			return error(_("need a HEAD to fixup"));
-		if (!(head_commit = lookup_commit_reference(the_repository, &head)))
+		if (!(head_commit = lookup_commit_reference(r, &head)))
 			return error(_("could not read HEAD"));
 		if (!(head_message = get_commit_buffer(head_commit, NULL)))
 			return error(_("could not read HEAD's commit message"));
@@ -1807,7 +1811,7 @@ static int do_pick_commit(struct repository *r,
 	if (command == TODO_REWORD)
 		flags |= EDIT_MSG | VERIFY_MSG;
 	else if (is_fixup(command)) {
-		if (update_squash_messages(command, commit, opts))
+		if (update_squash_messages(r, command, commit, opts))
 			return -1;
 		flags |= AMEND_MSG;
 		if (!final_fixup)
@@ -1877,7 +1881,7 @@ static int do_pick_commit(struct repository *r,
 		      ? _("could not revert %s... %s")
 		      : _("could not apply %s... %s"),
 		      short_commit_name(commit), msg.subject);
-		print_advice(res == 1, opts);
+		print_advice(r, res == 1, opts);
 		repo_rerere(r, opts->allow_rerere_auto);
 		goto leave;
 	}
@@ -1984,7 +1988,8 @@ static struct todo_item *append_new_todo(struct todo_list *todo_list)
 	return todo_list->items + todo_list->nr++;
 }
 
-static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
+static int parse_insn_line(struct repository *r, struct todo_item *item,
+			   const char *bol, char *eol)
 {
 	struct object_id commit_oid;
 	char *end_of_object_name;
@@ -2068,11 +2073,12 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 	if (status < 0)
 		return -1;
 
-	item->commit = lookup_commit_reference(the_repository, &commit_oid);
+	item->commit = lookup_commit_reference(r, &commit_oid);
 	return !item->commit;
 }
 
-static int parse_insn_buffer(char *buf, struct todo_list *todo_list)
+static int parse_insn_buffer(struct repository *r, char *buf,
+			     struct todo_list *todo_list)
 {
 	struct todo_item *item;
 	char *p = buf, *next_p;
@@ -2088,7 +2094,7 @@ static int parse_insn_buffer(char *buf, struct todo_list *todo_list)
 
 		item = append_new_todo(todo_list);
 		item->offset_in_buf = p - todo_list->buf.buf;
-		if (parse_insn_line(item, p, eol)) {
+		if (parse_insn_line(r, item, p, eol)) {
 			res = error(_("invalid line %d: %.*s"),
 				i, (int)(eol - p), p);
 			item->command = TODO_NOOP;
@@ -2149,8 +2155,9 @@ static ssize_t strbuf_read_file_or_whine(struct strbuf *sb, const char *path)
 	return len;
 }
 
-static int read_populate_todo(struct todo_list *todo_list,
-			struct replay_opts *opts)
+static int read_populate_todo(struct repository *r,
+			      struct todo_list *todo_list,
+			      struct replay_opts *opts)
 {
 	struct stat st;
 	const char *todo_file = get_todo_path(opts);
@@ -2165,7 +2172,7 @@ static int read_populate_todo(struct todo_list *todo_list,
 		return error(_("could not stat '%s'"), todo_file);
 	fill_stat_data(&todo_list->stat, &st);
 
-	res = parse_insn_buffer(todo_list->buf.buf, todo_list);
+	res = parse_insn_buffer(r, todo_list->buf.buf, todo_list);
 	if (res) {
 		if (is_rebase_i(opts))
 			return error(_("please fix this using "
@@ -2196,7 +2203,7 @@ static int read_populate_todo(struct todo_list *todo_list,
 		FILE *f = fopen_or_warn(rebase_path_msgtotal(), "w");
 
 		if (strbuf_read_file(&done.buf, rebase_path_done(), 0) > 0 &&
-				!parse_insn_buffer(done.buf.buf, &done))
+		    !parse_insn_buffer(r, done.buf.buf, &done))
 			todo_list->done_nr = count_commands(&done);
 		else
 			todo_list->done_nr = 0;
@@ -2459,12 +2466,12 @@ static int reset_for_rollback(const struct object_id *oid)
 	return run_command_v_opt(argv, RUN_GIT_CMD);
 }
 
-static int rollback_single_pick(void)
+static int rollback_single_pick(struct repository *r)
 {
 	struct object_id head_oid;
 
-	if (!file_exists(git_path_cherry_pick_head(the_repository)) &&
-	    !file_exists(git_path_revert_head(the_repository)))
+	if (!file_exists(git_path_cherry_pick_head(r)) &&
+	    !file_exists(git_path_revert_head(r)))
 		return error(_("no cherry-pick or revert in progress"));
 	if (read_ref_full("HEAD", 0, &head_oid, NULL))
 		return error(_("cannot resolve HEAD"));
@@ -2473,7 +2480,7 @@ static int rollback_single_pick(void)
 	return reset_for_rollback(&head_oid);
 }
 
-int sequencer_rollback(struct replay_opts *opts)
+int sequencer_rollback(struct repository *r, struct replay_opts *opts)
 {
 	FILE *f;
 	struct object_id oid;
@@ -2487,7 +2494,7 @@ int sequencer_rollback(struct replay_opts *opts)
 		 * If CHERRY_PICK_HEAD or REVERT_HEAD indicates
 		 * a single-cherry-pick in progress, abort that.
 		 */
-		return rollback_single_pick();
+		return rollback_single_pick(r);
 	}
 	if (!f)
 		return error_errno(_("cannot open '%s'"), git_path_head_file());
@@ -3441,7 +3448,7 @@ static int pick_commits(struct repository *r,
 						  get_todo_path(opts));
 			else if (match_stat_data(&todo_list->stat, &st)) {
 				todo_list_release(todo_list);
-				if (read_populate_todo(todo_list, opts))
+				if (read_populate_todo(r, todo_list, opts))
 					res = -1; /* message was printed */
 				/* `current` will be incremented below */
 				todo_list->current = -1;
@@ -3601,12 +3608,12 @@ static int pick_commits(struct repository *r,
 	return sequencer_remove_state(opts);
 }
 
-static int continue_single_pick(void)
+static int continue_single_pick(struct repository *r)
 {
 	const char *argv[] = { "commit", NULL };
 
-	if (!file_exists(git_path_cherry_pick_head(the_repository)) &&
-	    !file_exists(git_path_revert_head(the_repository)))
+	if (!file_exists(git_path_cherry_pick_head(r)) &&
+	    !file_exists(git_path_revert_head(r)))
 		return error(_("no cherry-pick or revert in progress"));
 	return run_command_v_opt(argv, RUN_GIT_CMD);
 }
@@ -3705,7 +3712,7 @@ static int commit_staged_changes(struct repository *r,
 				struct commit *commit;
 				const char *path = rebase_path_squash_msg();
 
-				if (parse_head(&commit) ||
+				if (parse_head(r, &commit) ||
 				    !(p = get_commit_buffer(commit, NULL)) ||
 				    write_message(p, strlen(p), path, 0)) {
 					unuse_commit_buffer(commit, p);
@@ -3760,20 +3767,20 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
 	if (read_populate_opts(opts))
 		return -1;
 	if (is_rebase_i(opts)) {
-		if ((res = read_populate_todo(&todo_list, opts)))
+		if ((res = read_populate_todo(r, &todo_list, opts)))
 			goto release_todo_list;
 		if (commit_staged_changes(r, opts, &todo_list))
 			return -1;
 	} else if (!file_exists(get_todo_path(opts)))
-		return continue_single_pick();
-	else if ((res = read_populate_todo(&todo_list, opts)))
+		return continue_single_pick(r);
+	else if ((res = read_populate_todo(r, &todo_list, opts)))
 		goto release_todo_list;
 
 	if (!is_rebase_i(opts)) {
 		/* Verify that the conflict has been resolved */
 		if (file_exists(git_path_cherry_pick_head(r)) ||
 		    file_exists(git_path_revert_head(r))) {
-			res = continue_single_pick();
+			res = continue_single_pick(r);
 			if (res)
 				goto release_todo_list;
 		}
@@ -4346,7 +4353,8 @@ int sequencer_make_script(struct repository *r, FILE *out,
  * Add commands after pick and (series of) squash/fixup commands
  * in the todo list.
  */
-int sequencer_add_exec_commands(const char *commands)
+int sequencer_add_exec_commands(struct repository *r,
+				const char *commands)
 {
 	const char *todo_file = rebase_path_todo();
 	struct todo_list todo_list = TODO_LIST_INIT;
@@ -4357,7 +4365,7 @@ int sequencer_add_exec_commands(const char *commands)
 	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
 		return error(_("could not read '%s'."), todo_file);
 
-	if (parse_insn_buffer(todo_list.buf.buf, &todo_list)) {
+	if (parse_insn_buffer(r, todo_list.buf.buf, &todo_list)) {
 		todo_list_release(&todo_list);
 		return error(_("unusable todo list: '%s'"), todo_file);
 	}
@@ -4402,7 +4410,7 @@ int sequencer_add_exec_commands(const char *commands)
 	return i;
 }
 
-int transform_todos(unsigned flags)
+int transform_todos(struct repository *r, unsigned flags)
 {
 	const char *todo_file = rebase_path_todo();
 	struct todo_list todo_list = TODO_LIST_INIT;
@@ -4413,7 +4421,7 @@ int transform_todos(unsigned flags)
 	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
 		return error(_("could not read '%s'."), todo_file);
 
-	if (parse_insn_buffer(todo_list.buf.buf, &todo_list)) {
+	if (parse_insn_buffer(r, todo_list.buf.buf, &todo_list)) {
 		todo_list_release(&todo_list);
 		return error(_("unusable todo list: '%s'"), todo_file);
 	}
@@ -4486,7 +4494,7 @@ define_commit_slab(commit_seen, unsigned char);
  * Check if there is an unrecognized command or a
  * bad SHA-1 in a command.
  */
-int check_todo_list(void)
+int check_todo_list(struct repository *r)
 {
 	enum check_level check_level = get_missing_commit_check_level();
 	struct strbuf todo_file = STRBUF_INIT;
@@ -4503,7 +4511,7 @@ int check_todo_list(void)
 		goto leave_check;
 	}
 	advise_to_edit_todo = res =
-		parse_insn_buffer(todo_list.buf.buf, &todo_list);
+		parse_insn_buffer(r, todo_list.buf.buf, &todo_list);
 
 	if (res || check_level == CHECK_IGNORE)
 		goto leave_check;
@@ -4522,7 +4530,7 @@ int check_todo_list(void)
 		goto leave_check;
 	}
 	strbuf_release(&todo_file);
-	res = !!parse_insn_buffer(todo_list.buf.buf, &todo_list);
+	res = !!parse_insn_buffer(r, todo_list.buf.buf, &todo_list);
 
 	/* Find commits in git-rebase-todo.backup yet unseen */
 	for (i = todo_list.nr - 1; i >= 0; i--) {
@@ -4586,7 +4594,7 @@ static int rewrite_file(const char *path, const char *buf, size_t len)
 }
 
 /* skip picking commits whose parents are unchanged */
-int skip_unnecessary_picks(void)
+int skip_unnecessary_picks(struct repository *r)
 {
 	const char *todo_file = rebase_path_todo();
 	struct strbuf buf = STRBUF_INIT;
@@ -4604,7 +4612,7 @@ int skip_unnecessary_picks(void)
 
 	if (strbuf_read_file_or_whine(&todo_list.buf, todo_file) < 0)
 		return -1;
-	if (parse_insn_buffer(todo_list.buf.buf, &todo_list) < 0) {
+	if (parse_insn_buffer(r, todo_list.buf.buf, &todo_list) < 0) {
 		todo_list_release(&todo_list);
 		return -1;
 	}
@@ -4690,7 +4698,7 @@ define_commit_slab(commit_todo_item, struct todo_item *);
  * message will have to be retrieved from the commit (as the oneline in the
  * script cannot be trusted) in order to normalize the autosquash arrangement.
  */
-int rearrange_squash(void)
+int rearrange_squash(struct repository *r)
 {
 	const char *todo_file = rebase_path_todo();
 	struct todo_list todo_list = TODO_LIST_INIT;
@@ -4701,7 +4709,7 @@ int rearrange_squash(void)
 
 	if (strbuf_read_file_or_whine(&todo_list.buf, todo_file) < 0)
 		return -1;
-	if (parse_insn_buffer(todo_list.buf.buf, &todo_list) < 0) {
+	if (parse_insn_buffer(r, todo_list.buf.buf, &todo_list) < 0) {
 		todo_list_release(&todo_list);
 		return -1;
 	}
diff --git a/sequencer.h b/sequencer.h
index ad151e95c7..1232157da2 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -68,7 +68,7 @@ void sequencer_init_config(struct replay_opts *opts);
 int sequencer_pick_revisions(struct repository *repo,
 			     struct replay_opts *opts);
 int sequencer_continue(struct repository *repo, struct replay_opts *opts);
-int sequencer_rollback(struct replay_opts *opts);
+int sequencer_rollback(struct repository *repo, struct replay_opts *opts);
 int sequencer_remove_state(struct replay_opts *opts);
 
 #define TODO_LIST_KEEP_EMPTY (1U << 0)
@@ -85,11 +85,11 @@ int sequencer_make_script(struct repository *repo, FILE *out,
 			  int argc, const char **argv,
 			  unsigned flags);
 
-int sequencer_add_exec_commands(const char *command);
-int transform_todos(unsigned flags);
-int check_todo_list(void);
-int skip_unnecessary_picks(void);
-int rearrange_squash(void);
+int sequencer_add_exec_commands(struct repository *repo, const char *command);
+int transform_todos(struct repository *repo, unsigned flags);
+int check_todo_list(struct repository *repo);
+int skip_unnecessary_picks(struct repository *repo);
+int rearrange_squash(struct repository *repo);
 
 extern const char sign_off_header[];
 
-- 
2.19.1.647.g708186aaf9

