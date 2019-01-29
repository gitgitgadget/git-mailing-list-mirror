Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B058C1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 15:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbfA2PDH (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 10:03:07 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52976 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728918AbfA2PDF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 10:03:05 -0500
Received: by mail-wm1-f67.google.com with SMTP id m1so18206074wml.2
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 07:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uy4RhQGhplpP4LbuKVoxJx6M6uMl+4iXzkAm5ztPKl8=;
        b=E5IHTWRLiGmG6rg4Ve39UhY9HHXNfMt5oXhElV+X3MIZEBKgB0xvJpFxB1sWCmdN4K
         5URhQLVfTFLVSQrs5nbuxEE3/Mgumr0NC6sY4v0w1aPMqHxxBIE4A2DBAxjhzzFi4jB9
         ZbYfw8TdPxnhK6FVzdVaSGRFc3hZXcaskggOHI4gn+y1AT8jtV0IkRCP6ESM9yJXuett
         UqYBXPdghQ3CNN/lceAEuBQGqigqEUlgnmlICf3396hASHh78ZsilSQj1bSyMvCxKUd4
         BIlZqMXG2436zuTXbiTzaw+8nju4ASwuWc0pCyzjU6lXy5sph2Yo/nZL2ZUqDZX9qnOC
         n7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uy4RhQGhplpP4LbuKVoxJx6M6uMl+4iXzkAm5ztPKl8=;
        b=qBn+4IynrcQGmAaJ+HrNoGNMvwp9Ip5RJhj0LshZvIwVN2BKtqywquvjSZZca+Uld5
         QPeBF5qz0gCfghmLZT7jVVQbtlRKTZrlo8w43vRfz80vEnhd+ZtwGesEuAlK1SKF/hkL
         fLDdQL8oxWy8bWN5oHqG0cu+1bIDyUVABWNOe3PNEWrHti4EW4L2Gw7Bx3Zdah7EKBF+
         npad2+0Bbkikp0MHgrB9Y0YZ5EkPOfRs4uVICZsFbPKuVggjWW+fTDRgIVspLbpOFgd7
         k2BGSB4iIWb9fO+YIjk2ClK22yN2spj95tI9Ov9iuBYq56tZ4fpmdjk6LDO6apLqSEg1
         4vew==
X-Gm-Message-State: AJcUukdvKuo0FAs8V6TF6dhRLO0fVAZsVVg2KwrBlvqFJrcM3LzaMXOd
        ouY8K3n6aZ+NqA9caTx2GwJCO69L
X-Google-Smtp-Source: ALg8bN7Fij4P0+21wqNss75oR9144g3P8Q6vg2c3Xx0v8t4tSnJM/ORaNicIgFEL32nhwHkg41C4xA==
X-Received: by 2002:a1c:f509:: with SMTP id t9mr22870010wmh.76.1548774181849;
        Tue, 29 Jan 2019 07:03:01 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-47-104.w86-221.abo.wanadoo.fr. [86.221.54.104])
        by smtp.googlemail.com with ESMTPSA id 129sm4420851wmd.18.2019.01.29.07.03.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 07:03:01 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v6 03/16] sequencer: remove the 'arg' field from todo_item
Date:   Tue, 29 Jan 2019 16:01:46 +0100
Message-Id: <20190129150159.10588-4-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129150159.10588-1-alban.gruin@gmail.com>
References: <20190123205821.27459-1-alban.gruin@gmail.com>
 <20190129150159.10588-1-alban.gruin@gmail.com>
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
 sequencer.c | 67 ++++++++++++++++++++++++++++++-----------------------
 sequencer.h |  6 +++--
 2 files changed, 42 insertions(+), 31 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 5b84a20532..0e7ab16a05 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1949,8 +1949,14 @@ static struct todo_item *append_new_todo(struct todo_list *todo_list)
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
@@ -1964,7 +1970,7 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
 	if (bol == eol || *bol == '\r' || *bol == comment_line_char) {
 		item->command = TODO_COMMENT;
 		item->commit = NULL;
-		item->arg = bol;
+		item->arg_offset = bol - buf;
 		item->arg_len = eol - bol;
 		return 0;
 	}
@@ -1991,7 +1997,7 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
 			return error(_("%s does not accept arguments: '%s'"),
 				     command_to_string(item->command), bol);
 		item->commit = NULL;
-		item->arg = bol;
+		item->arg_offset = bol - buf;
 		item->arg_len = eol - bol;
 		return 0;
 	}
@@ -2003,7 +2009,7 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
 	if (item->command == TODO_EXEC || item->command == TODO_LABEL ||
 	    item->command == TODO_RESET) {
 		item->commit = NULL;
-		item->arg = bol;
+		item->arg_offset = bol - buf;
 		item->arg_len = (int)(eol - bol);
 		return 0;
 	}
@@ -2017,7 +2023,7 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
 		} else {
 			item->flags |= TODO_EDIT_MERGE_MSG;
 			item->commit = NULL;
-			item->arg = bol;
+			item->arg_offset = bol - buf;
 			item->arg_len = (int)(eol - bol);
 			return 0;
 		}
@@ -2029,8 +2035,9 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
 	status = get_oid(bol, &commit_oid);
 	*end_of_object_name = saved;
 
-	item->arg = end_of_object_name + strspn(end_of_object_name, " \t");
-	item->arg_len = (int)(eol - item->arg);
+	bol = end_of_object_name + strspn(end_of_object_name, " \t");
+	item->arg_offset = bol - buf;
+	item->arg_len = (int)(eol - bol);
 
 	if (status < 0)
 		return -1;
@@ -2058,11 +2065,11 @@ int todo_list_parse_insn_buffer(struct repository *r, char *buf,
 
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
@@ -2402,7 +2409,7 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
 
 		item->command = command;
 		item->commit = commit;
-		item->arg = NULL;
+		item->arg_offset = 0;
 		item->arg_len = 0;
 		item->offset_in_buf = todo_list->buf.len;
 		subject_len = find_commit_subject(commit_buffer, &subject);
@@ -3438,6 +3445,8 @@ static int pick_commits(struct repository *r,
 
 	while (todo_list->current < todo_list->nr) {
 		struct todo_item *item = todo_list->items + todo_list->current;
+		const char *arg = todo_item_get_arg(todo_list, item);
+
 		if (save_todo(todo_list, opts))
 			return -1;
 		if (is_rebase_i(opts)) {
@@ -3488,10 +3497,9 @@ static int pick_commits(struct repository *r,
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
@@ -3500,7 +3508,7 @@ static int pick_commits(struct repository *r,
 				if (res == 1)
 					intend_to_amend();
 				return error_failed_squash(r, item->commit, opts,
-					item->arg_len, item->arg);
+					item->arg_len, arg);
 			} else if (res && is_rebase_i(opts) && item->commit) {
 				int to_amend = 0;
 				struct object_id oid;
@@ -3519,16 +3527,16 @@ static int pick_commits(struct repository *r,
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
@@ -3545,14 +3553,14 @@ static int pick_commits(struct repository *r,
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
@@ -3561,9 +3569,8 @@ static int pick_commits(struct repository *r,
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
 
@@ -3578,9 +3585,8 @@ static int pick_commits(struct repository *r,
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
@@ -4520,7 +4526,8 @@ int transform_todos(struct repository *r, unsigned flags)
 	for (item = todo_list.items, i = 0; i < todo_list.nr; i++, item++) {
 		/* if the item is not a command write it and continue */
 		if (item->command >= TODO_COMMENT) {
-			strbuf_addf(&buf, "%.*s\n", item->arg_len, item->arg);
+			strbuf_addf(&buf, "%.*s\n", item->arg_len,
+				    todo_item_get_arg(&todo_list, item));
 			continue;
 		}
 
@@ -4550,7 +4557,8 @@ int transform_todos(struct repository *r, unsigned flags)
 		if (!item->arg_len)
 			strbuf_addch(&buf, '\n');
 		else
-			strbuf_addf(&buf, " %.*s\n", item->arg_len, item->arg);
+			strbuf_addf(&buf, " %.*s\n", item->arg_len,
+				    todo_item_get_arg(&todo_list, item));
 	}
 
 	i = write_message(buf.buf, buf.len, todo_file, 0);
@@ -4626,7 +4634,8 @@ int check_todo_list(struct repository *r)
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
index 7dc4d8946b..cdb9ed7a2d 100644
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

