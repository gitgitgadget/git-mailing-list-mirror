Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F6E420248
	for <e@80x24.org>; Tue,  5 Mar 2019 19:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfCETSc (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 14:18:32 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55720 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfCETSb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 14:18:31 -0500
Received: by mail-wm1-f66.google.com with SMTP id q187so3682386wme.5
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 11:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PoquIq1ifuHTOIcfAq865z7tmefTGOG1xO5uTwU7HHc=;
        b=s8YA4gCPzKVJBEFCpZ5yjXSGt5rb9HxcCERAlnZ86Db1njvFaO0+tqtgQtTcgdvime
         KsmeaDaqYHtbN9lrwRsD42U3+SGgcP5UUGTE1u5pc+nl3xKv7T/O3nmE818x6PuUE5Ft
         4ns70wWKpTC/AfgnYsqP0pCM60NpC2IPsw+w0ggClMjnQ61vfCI1NyS1TzKmXmEJNv+a
         Bo+umWIMIqmCswOjIasvtX/9JlGZHK5lHo9r9lQ0iyYwsD69byQjavrnIGOjLQ8yHGQP
         9t3gwi9bjNxIDH7DVuCV7KeGPCh7CGzF+eZN9DOrmYx4+uWb92kxyYaX6xcTJ7FApHYJ
         WO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PoquIq1ifuHTOIcfAq865z7tmefTGOG1xO5uTwU7HHc=;
        b=qPRQ9A+D/5gfh7q3kpVD3IrEP9jfvNsnr2oAi6Jo4ETfxqb3TeWRZdKsajjqrE/bhu
         jHVNN3Y1RKwXwwqMCmlAVSwDl0/gZuzXCD40k4ES8XtTaiIAzsVusxv+zpAjYqePiRfq
         iMDnNWgnnqcn3PBMDH9qoeJ69zDPui3ysJI3VToUqvNu9J6M0xfvvCmuGHc3vjcC2d7J
         vLnchE6Vc+zLtvVF80Cqdlv/yeJV7T1XEMKmq2u2sHEhe6jqfXX3rWuBEza9/Ip/V5GQ
         MiY0Hbd07oEQYClKW/lE/ZG/H/lVN/rPi6oKCO7RD22kJRsnQsLYWalx4UhBXsoXrf+N
         qv6A==
X-Gm-Message-State: APjAAAXvo8EDKZ26b89C6kfk+lqjrET6GHw3LrsISZIEoUrRNtU52aIe
        taC0INx12ucUUiLKMTHU8VryRpYQ
X-Google-Smtp-Source: APXvYqyHtN3/cFAu3iLb0uhmu+5uu+HYJd7BaMXrKIimWCsa99ZUNi5vj6UeiQsXQoGQ+d3/jNFWYw==
X-Received: by 2002:a1c:5fc5:: with SMTP id t188mr83105wmb.86.1551813508212;
        Tue, 05 Mar 2019 11:18:28 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-67-51.w92-136.abo.wanadoo.fr. [92.136.29.51])
        by smtp.googlemail.com with ESMTPSA id r6sm10038219wrx.48.2019.03.05.11.18.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 11:18:27 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v8 03/18] sequencer: remove the 'arg' field from todo_item
Date:   Tue,  5 Mar 2019 20:17:50 +0100
Message-Id: <20190305191805.13561-4-alban.gruin@gmail.com>
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

The 'arg' field of todo_item used to store the address of the first byte
of the parameter of a command in a todo list.  It was associated with
the length of the parameter (the 'arg_len' field).

This replaces the 'arg' field by 'arg_offset'.  This new field does not
store the address of the parameter, but the position of the first
character of the parameter in the buffer.  todo_item_get_arg() is added
to return the address of the parameter of an item.

This will prevent todo_list_add_exec_commands() from having to do awful
pointer arithmetics when growing the todo list buffer.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
No changes since v7.

 sequencer.c | 67 ++++++++++++++++++++++++++++++-----------------------
 sequencer.h |  6 +++--
 2 files changed, 42 insertions(+), 31 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 25cc7a9a91..c844a9b7f3 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1999,8 +1999,14 @@ static struct todo_item *append_new_todo(struct todo_list *todo_list)
 	return todo_list->items + todo_list->nr++;
 }
 
+const char *todo_item_get_arg(struct todo_list *todo_list,
+			      struct todo_item *item)
+{
+	return todo_list->buf.buf + item->arg_offset;
+}
+
 static int parse_insn_line(struct repository *r, struct todo_item *item,
-			   const char *bol, char *eol)
+			   const char *buf, const char *bol, char *eol)
 {
 	struct object_id commit_oid;
 	char *end_of_object_name;
@@ -2014,7 +2020,7 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
 	if (bol == eol || *bol == '\r' || *bol == comment_line_char) {
 		item->command = TODO_COMMENT;
 		item->commit = NULL;
-		item->arg = bol;
+		item->arg_offset = bol - buf;
 		item->arg_len = eol - bol;
 		return 0;
 	}
@@ -2041,7 +2047,7 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
 			return error(_("%s does not accept arguments: '%s'"),
 				     command_to_string(item->command), bol);
 		item->commit = NULL;
-		item->arg = bol;
+		item->arg_offset = bol - buf;
 		item->arg_len = eol - bol;
 		return 0;
 	}
@@ -2053,7 +2059,7 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
 	if (item->command == TODO_EXEC || item->command == TODO_LABEL ||
 	    item->command == TODO_RESET) {
 		item->commit = NULL;
-		item->arg = bol;
+		item->arg_offset = bol - buf;
 		item->arg_len = (int)(eol - bol);
 		return 0;
 	}
@@ -2067,7 +2073,7 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
 		} else {
 			item->flags |= TODO_EDIT_MERGE_MSG;
 			item->commit = NULL;
-			item->arg = bol;
+			item->arg_offset = bol - buf;
 			item->arg_len = (int)(eol - bol);
 			return 0;
 		}
@@ -2079,8 +2085,9 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
 	status = get_oid(bol, &commit_oid);
 	*end_of_object_name = saved;
 
-	item->arg = end_of_object_name + strspn(end_of_object_name, " \t");
-	item->arg_len = (int)(eol - item->arg);
+	bol = end_of_object_name + strspn(end_of_object_name, " \t");
+	item->arg_offset = bol - buf;
+	item->arg_len = (int)(eol - bol);
 
 	if (status < 0)
 		return -1;
@@ -2108,11 +2115,11 @@ int todo_list_parse_insn_buffer(struct repository *r, char *buf,
 
 		item = append_new_todo(todo_list);
 		item->offset_in_buf = p - todo_list->buf.buf;
-		if (parse_insn_line(r, item, p, eol)) {
+		if (parse_insn_line(r, item, buf, p, eol)) {
 			res = error(_("invalid line %d: %.*s"),
 				i, (int)(eol - p), p);
 			item->command = TODO_COMMENT + 1;
-			item->arg = p;
+			item->arg_offset = p - buf;
 			item->arg_len = (int)(eol - p);
 			item->commit = NULL;
 		}
@@ -2452,7 +2459,7 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
 
 		item->command = command;
 		item->commit = commit;
-		item->arg = NULL;
+		item->arg_offset = 0;
 		item->arg_len = 0;
 		item->offset_in_buf = todo_list->buf.len;
 		subject_len = find_commit_subject(commit_buffer, &subject);
@@ -3491,6 +3498,8 @@ static int pick_commits(struct repository *r,
 
 	while (todo_list->current < todo_list->nr) {
 		struct todo_item *item = todo_list->items + todo_list->current;
+		const char *arg = todo_item_get_arg(todo_list, item);
+
 		if (save_todo(todo_list, opts))
 			return -1;
 		if (is_rebase_i(opts)) {
@@ -3542,10 +3551,9 @@ static int pick_commits(struct repository *r,
 					fprintf(stderr,
 						_("Stopped at %s...  %.*s\n"),
 						short_commit_name(commit),
-						item->arg_len, item->arg);
+						item->arg_len, arg);
 				return error_with_patch(r, commit,
-					item->arg, item->arg_len, opts, res,
-					!res);
+					arg, item->arg_len, opts, res, !res);
 			}
 			if (is_rebase_i(opts) && !res)
 				record_in_rewritten(&item->commit->object.oid,
@@ -3554,7 +3562,7 @@ static int pick_commits(struct repository *r,
 				if (res == 1)
 					intend_to_amend();
 				return error_failed_squash(r, item->commit, opts,
-					item->arg_len, item->arg);
+					item->arg_len, arg);
 			} else if (res && is_rebase_i(opts) && item->commit) {
 				int to_amend = 0;
 				struct object_id oid;
@@ -3573,16 +3581,16 @@ static int pick_commits(struct repository *r,
 					to_amend = 1;
 
 				return res | error_with_patch(r, item->commit,
-						item->arg, item->arg_len, opts,
+						arg, item->arg_len, opts,
 						res, to_amend);
 			}
 		} else if (item->command == TODO_EXEC) {
-			char *end_of_arg = (char *)(item->arg + item->arg_len);
+			char *end_of_arg = (char *)(arg + item->arg_len);
 			int saved = *end_of_arg;
 			struct stat st;
 
 			*end_of_arg = '\0';
-			res = do_exec(r, item->arg);
+			res = do_exec(r, arg);
 			*end_of_arg = saved;
 
 			/* Reread the todo file if it has changed. */
@@ -3599,14 +3607,14 @@ static int pick_commits(struct repository *r,
 				todo_list->current = -1;
 			}
 		} else if (item->command == TODO_LABEL) {
-			if ((res = do_label(r, item->arg, item->arg_len)))
+			if ((res = do_label(r, arg, item->arg_len)))
 				reschedule = 1;
 		} else if (item->command == TODO_RESET) {
-			if ((res = do_reset(r, item->arg, item->arg_len, opts)))
+			if ((res = do_reset(r, arg, item->arg_len, opts)))
 				reschedule = 1;
 		} else if (item->command == TODO_MERGE) {
 			if ((res = do_merge(r, item->commit,
-					    item->arg, item->arg_len,
+					    arg, item->arg_len,
 					    item->flags, opts)) < 0)
 				reschedule = 1;
 			else if (item->commit)
@@ -3615,9 +3623,8 @@ static int pick_commits(struct repository *r,
 			if (res > 0)
 				/* failed with merge conflicts */
 				return error_with_patch(r, item->commit,
-							item->arg,
-							item->arg_len, opts,
-							res, 0);
+							arg, item->arg_len,
+							opts, res, 0);
 		} else if (!is_noop(item->command))
 			return error(_("unknown command %d"), item->command);
 
@@ -3632,9 +3639,8 @@ static int pick_commits(struct repository *r,
 			if (item->commit)
 				return error_with_patch(r,
 							item->commit,
-							item->arg,
-							item->arg_len, opts,
-							res, 0);
+							arg, item->arg_len,
+							opts, res, 0);
 		}
 
 		todo_list->current++;
@@ -4575,7 +4581,8 @@ int transform_todos(struct repository *r, unsigned flags)
 	for (item = todo_list.items, i = 0; i < todo_list.nr; i++, item++) {
 		/* if the item is not a command write it and continue */
 		if (item->command >= TODO_COMMENT) {
-			strbuf_addf(&buf, "%.*s\n", item->arg_len, item->arg);
+			strbuf_addf(&buf, "%.*s\n", item->arg_len,
+				    todo_item_get_arg(&todo_list, item));
 			continue;
 		}
 
@@ -4605,7 +4612,8 @@ int transform_todos(struct repository *r, unsigned flags)
 		if (!item->arg_len)
 			strbuf_addch(&buf, '\n');
 		else
-			strbuf_addf(&buf, " %.*s\n", item->arg_len, item->arg);
+			strbuf_addf(&buf, " %.*s\n", item->arg_len,
+				    todo_item_get_arg(&todo_list, item));
 	}
 
 	i = write_message(buf.buf, buf.len, todo_file, 0);
@@ -4681,7 +4689,8 @@ int check_todo_list(struct repository *r)
 		if (commit && !*commit_seen_at(&commit_seen, commit)) {
 			strbuf_addf(&missing, " - %s %.*s\n",
 				    short_commit_name(commit),
-				    item->arg_len, item->arg);
+				    item->arg_len,
+				    todo_item_get_arg(&todo_list, item));
 			*commit_seen_at(&commit_seen, commit) = 1;
 		}
 	}
diff --git a/sequencer.h b/sequencer.h
index c6360bac66..50d552429c 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -104,9 +104,9 @@ struct todo_item {
 	enum todo_command command;
 	struct commit *commit;
 	unsigned int flags;
-	const char *arg;
 	int arg_len;
-	size_t offset_in_buf;
+	/* The offset of the command and its argument in the strbuf */
+	size_t offset_in_buf, arg_offset;
 };
 
 struct todo_list {
@@ -122,6 +122,8 @@ struct todo_list {
 int todo_list_parse_insn_buffer(struct repository *r, char *buf,
 				struct todo_list *todo_list);
 void todo_list_release(struct todo_list *todo_list);
+const char *todo_item_get_arg(struct todo_list *todo_list,
+			      struct todo_item *item);
 
 /* Call this to setup defaults before parsing command line options */
 void sequencer_init_config(struct replay_opts *opts);
-- 
2.20.1

