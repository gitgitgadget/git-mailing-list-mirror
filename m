Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0135C20248
	for <e@80x24.org>; Tue,  5 Mar 2019 19:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfCETSq (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 14:18:46 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43560 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfCETSp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 14:18:45 -0500
Received: by mail-wr1-f67.google.com with SMTP id d17so10733587wre.10
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 11:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LoQWDUOOQ+pwIsJbZkzzFiTmz1imzdCKzsY2hF8jS/M=;
        b=q4+4zY2Qs5VMPHGgFy6KYqe3sdEbdXE+7S9ZDOCZxzYttwXdk+zADII6hYJxWTV69o
         t4DAmrzZ8fYx7rEgrSldt7dtgtl3rE/wrDgrLnPkVHcIt3nt1y+uDwU3jzIkFA6FZTk5
         aiIqrI+dvR5VsVnWRj1/OVXxKU9a2sUTZACs9LrIbk6wK6gpiGPriK3G/b1j0GvMutka
         3jrwyXho3B+prn+cYXucib7r0aygWim5eybQqKnCkvwn1MIyqsDAZwIc69nJx9HZguN8
         ld7+7hmOuiCtd8WxYXcrTIxopVfLuCktxWczzhg8TIqUbh9jlux+f3GbdtNMZadP8X/e
         KsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LoQWDUOOQ+pwIsJbZkzzFiTmz1imzdCKzsY2hF8jS/M=;
        b=BtlX004xrpNJFxzsjI2dOUCs9V2wTSOjcmETtT0REwVfsNkLOO8sMiZ3XnL3PeOfQL
         osdgKUl+NSCRouw7s0VnK/rS/1UAqRYoqkl/AjMWm26KhqZSOPVdoc8F2Id4Mo0Vblai
         Pz0yYao9qHyqK5r/Em8eZAYbpfh1lbFPdDLjELAiKt9GG1/mi7S8NjuxvOSvOwXf0Wdu
         oUseNS+boqMGAcoFiVzsMiGNuJ7JCu+c2vD5J9vWmKOb7xRwxjbUmKPtObZQdK5Cpq5/
         Oaj4myAhojNVk+QF0htSJJPF9tbdJYYyjPRs0+DjrQ9jTc0HZ+p5izC2qb355SZKosvT
         svAg==
X-Gm-Message-State: APjAAAVmNMBxsTyD/D8mJs920mINeo12XTQA4v9W57rB3RWrW697iHqB
        AFdG5tF+4e2rAzuQdyoufkuiw7b8
X-Google-Smtp-Source: APXvYqzsKXgmwRB11PsNXGwQE9OJWbdUrS0LoJAy51WTldNMyQ5MqdPgOyFrczpEiPOwKeZ6/Lo0SQ==
X-Received: by 2002:adf:d0c9:: with SMTP id z9mr315384wrh.132.1551813522325;
        Tue, 05 Mar 2019 11:18:42 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-67-51.w92-136.abo.wanadoo.fr. [92.136.29.51])
        by smtp.googlemail.com with ESMTPSA id r6sm10038219wrx.48.2019.03.05.11.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 11:18:41 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v8 10/18] sequencer: change complete_action() to use the refactored functions
Date:   Tue,  5 Mar 2019 20:17:57 +0100
Message-Id: <20190305191805.13561-11-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190305191805.13561-1-alban.gruin@gmail.com>
References: <20190210132648.12821-1-alban.gruin@gmail.com>
 <20190305191805.13561-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

complete_action() used functions that read the todo-list file, made some
changes to it, and wrote it back to the disk.

The previous commits were dedicated to separate the part that deals with
the file from the actual logic of these functions.  Now that this is
done, we can call directly the "logic" functions to avoid useless file
access.

The parsing of the list has to be done by the caller.  If the buffer of
the todo list provided by the caller is empty, a `noop' command is
directly added to the todo list, without touching the buffer.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
No changes since v7.

 builtin/rebase--interactive.c | 20 +++------
 sequencer.c                   | 79 +++++++++++++++--------------------
 sequencer.h                   |  2 +-
 3 files changed, 41 insertions(+), 60 deletions(-)

diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
index b4190e58e1..ffbe14cef5 100644
--- a/builtin/rebase--interactive.c
+++ b/builtin/rebase--interactive.c
@@ -71,7 +71,6 @@ static int do_interactive_rebase(struct replay_opts *opts, unsigned flags,
 	const char *head_hash = NULL;
 	char *revisions = NULL, *shortrevisions = NULL;
 	struct argv_array make_script_args = ARGV_ARRAY_INIT;
-	FILE *todo_list_file;
 	struct todo_list todo_list = TODO_LIST_INIT;
 
 	if (prepare_branch_to_be_rebased(opts, switch_to))
@@ -94,14 +93,6 @@ static int do_interactive_rebase(struct replay_opts *opts, unsigned flags,
 	if (!upstream && squash_onto)
 		write_file(path_squash_onto(), "%s\n", squash_onto);
 
-	todo_list_file = fopen(rebase_path_todo(), "w");
-	if (!todo_list_file) {
-		free(revisions);
-		free(shortrevisions);
-
-		return error_errno(_("could not open %s"), rebase_path_todo());
-	}
-
 	argv_array_pushl(&make_script_args, "", revisions, NULL);
 	if (restrict_revision)
 		argv_array_push(&make_script_args, restrict_revision);
@@ -109,16 +100,17 @@ static int do_interactive_rebase(struct replay_opts *opts, unsigned flags,
 	ret = sequencer_make_script(the_repository, &todo_list.buf,
 				    make_script_args.argc, make_script_args.argv,
 				    flags);
-	fputs(todo_list.buf.buf, todo_list_file);
-	fclose(todo_list_file);
 
 	if (ret)
 		error(_("could not generate todo list"));
 	else {
 		discard_cache();
-		ret = complete_action(the_repository, opts, flags,
-				      shortrevisions, onto_name, onto,
-				      head_hash, commands, autosquash);
+		if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
+						&todo_list))
+			BUG("unusable todo list");
+
+		ret = complete_action(the_repository, opts, flags, shortrevisions, onto_name,
+				      onto, head_hash, commands, autosquash, &todo_list);
 	}
 
 	free(revisions);
diff --git a/sequencer.c b/sequencer.c
index cf716fa5b8..1d5cd2fc27 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4817,93 +4817,82 @@ static int skip_unnecessary_picks(struct repository *r, struct object_id *output
 	return 0;
 }
 
+static int todo_list_rearrange_squash(struct todo_list *todo_list);
+
 int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
 		    const char *onto, const char *orig_head, struct string_list *commands,
-		    unsigned autosquash)
+		    unsigned autosquash, struct todo_list *todo_list)
 {
 	const char *shortonto, *todo_file = rebase_path_todo();
-	struct todo_list todo_list = TODO_LIST_INIT;
-	struct strbuf *buf = &(todo_list.buf);
+	struct todo_list new_todo = TODO_LIST_INIT;
+	struct strbuf *buf = &todo_list->buf;
 	struct object_id oid;
-	struct stat st;
 
 	get_oid(onto, &oid);
 	shortonto = find_unique_abbrev(&oid, DEFAULT_ABBREV);
 
-	if (!lstat(todo_file, &st) && st.st_size == 0 &&
-	    write_message("noop\n", 5, todo_file, 0))
-		return -1;
+	if (buf->len == 0) {
+		struct todo_item *item = append_new_todo(todo_list);
+		item->command = TODO_NOOP;
+		item->commit = NULL;
+		item->arg_len = item->arg_offset = item->flags = item->offset_in_buf = 0;
+	}
 
-	if (autosquash && rearrange_squash_in_todo_file(r))
+	if (autosquash && todo_list_rearrange_squash(todo_list))
 		return -1;
 
 	if (commands->nr)
-		sequencer_add_exec_commands(r, commands);
+		todo_list_add_exec_commands(todo_list, commands);
 
-	if (strbuf_read_file(buf, todo_file, 0) < 0)
-		return error_errno(_("could not read '%s'."), todo_file);
-
-	if (todo_list_parse_insn_buffer(r, buf->buf, &todo_list)) {
-		todo_list_release(&todo_list);
-		return error(_("unusable todo list: '%s'"), todo_file);
-	}
-
-	if (count_commands(&todo_list) == 0) {
+	if (count_commands(todo_list) == 0) {
 		apply_autostash(opts);
 		sequencer_remove_state(opts);
-		todo_list_release(&todo_list);
 
 		return error(_("nothing to do"));
 	}
 
-	strbuf_addch(buf, '\n');
-	strbuf_commented_addf(buf, Q_("Rebase %s onto %s (%d command)",
-				      "Rebase %s onto %s (%d commands)",
-				      count_commands(&todo_list)),
-			      shortrevisions, shortonto, count_commands(&todo_list));
-	append_todo_help(0, flags & TODO_LIST_KEEP_EMPTY, buf);
-
-	if (write_message(buf->buf, buf->len, todo_file, 0)) {
-		todo_list_release(&todo_list);
-		return -1;
-	}
+	if (todo_list_write_to_file(r, todo_list, todo_file,
+				    shortrevisions, shortonto, -1,
+				    flags | TODO_LIST_SHORTEN_IDS | TODO_LIST_APPEND_TODO_HELP))
+		return error_errno(_("could not write '%s'"), todo_file);
 
 	if (copy_file(rebase_path_todo_backup(), todo_file, 0666))
 		return error(_("could not copy '%s' to '%s'."), todo_file,
 			     rebase_path_todo_backup());
 
-	if (transform_todo_file(r, flags | TODO_LIST_SHORTEN_IDS))
-		return error(_("could not transform the todo list"));
-
-	strbuf_reset(buf);
-
-	if (launch_sequence_editor(todo_file, buf, NULL)) {
+	if (launch_sequence_editor(todo_file, &new_todo.buf, NULL)) {
 		apply_autostash(opts);
 		sequencer_remove_state(opts);
-		todo_list_release(&todo_list);
 
 		return -1;
 	}
 
-	strbuf_stripspace(buf, 1);
-	if (buf->len == 0) {
+	strbuf_stripspace(&new_todo.buf, 1);
+	if (new_todo.buf.len == 0) {
 		apply_autostash(opts);
 		sequencer_remove_state(opts);
-		todo_list_release(&todo_list);
+		todo_list_release(&new_todo);
 
 		return error(_("nothing to do"));
 	}
 
-	todo_list_release(&todo_list);
-
-	if (check_todo_list_from_file(r)) {
+	if (todo_list_parse_insn_buffer(r, new_todo.buf.buf, &new_todo) ||
+	    todo_list_check(todo_list, &new_todo)) {
+		fprintf(stderr, _(edit_todo_list_advice));
 		checkout_onto(opts, onto_name, onto, orig_head);
+		todo_list_release(&new_todo);
+
 		return -1;
 	}
 
-	if (transform_todo_file(r, flags & ~(TODO_LIST_SHORTEN_IDS)))
-		return error(_("could not transform the todo list"));
+	if (todo_list_write_to_file(r, &new_todo, todo_file, NULL, NULL, -1,
+				    flags & ~(TODO_LIST_SHORTEN_IDS))) {
+		todo_list_release(&new_todo);
+		return error_errno(_("could not write '%s'"), todo_file);
+	}
+
+	todo_list_release(&new_todo);
 
 	if (opts->allow_ff && skip_unnecessary_picks(r, &oid))
 		return error(_("could not skip unnecessary pick commands"));
diff --git a/sequencer.h b/sequencer.h
index e25f5151d3..7029b39cd6 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -152,7 +152,7 @@ int check_todo_list_from_file(struct repository *r);
 int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
 		    const char *onto, const char *orig_head, struct string_list *commands,
-		    unsigned autosquash);
+		    unsigned autosquash, struct todo_list *todo_list);
 int rearrange_squash_in_todo_file(struct repository *r);
 
 extern const char sign_off_header[];
-- 
2.20.1

