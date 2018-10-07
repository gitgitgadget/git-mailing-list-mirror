Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD8751F97E
	for <e@80x24.org>; Sun,  7 Oct 2018 20:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbeJHDIf (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Oct 2018 23:08:35 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:44270 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbeJHDIe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Oct 2018 23:08:34 -0400
Received: by mail-wr1-f42.google.com with SMTP id 63-v6so18541123wra.11
        for <git@vger.kernel.org>; Sun, 07 Oct 2018 13:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HLjRGmA5Nr28hviHtC8+wS6925KBgEIBRfTCYqrlMx8=;
        b=QQ9M3vYwp/MJgS9ot999IOuikcAYiL6BKgiLhnQoGTBFpH74EYgzavxQEK/Uha7ouY
         7w/c8ODHaFRspYtnEF2UoegWPAB9Eagxx5xq7SRLQMPFpKO/rG8UtheK6Z28gaI/0rLC
         voNC2DxCW1Jmm+5+CWgk5JeWKSu1B2KarYjGIsbmbnvD2V6YI6W5An2lI+rz4tM1lkHB
         9K8ahKhxzsp9apfloERARPILjsEwuP0kBpkQ7bY58S9dddCtvQ02WKFTJE534ZNPh9e8
         4dCUu5Zgt0eZubTyQqvjBjuloR71TeY/EVg8XYSm6g1RMPa+HEfyQGgsjylIIADUk0eJ
         4GUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HLjRGmA5Nr28hviHtC8+wS6925KBgEIBRfTCYqrlMx8=;
        b=H4v3z5tlRwQBO0r65V/cweeR8q8q9jVilUlhgDbsyB+jUpAvnx7176Df1TaCNaguBf
         9+RABewGZQVNGZ17FFz56gjkSOjLvCGcnFBxHcQzQNW731H/Yp72lRTJO0F4z0cRd/k9
         d9ZGg9C/2N9mAuKzu4YM6/gG9M+60C1zWFqtWSMvwq5rJpdTjqfczE0a7SaNgS7sW165
         +oGbhrfsvtOuiPEpnyNef10Zc6ijmBT+GgpaTFIeGEDKnb8q7fXMxk/qX0TQQO2SWACu
         EvcIVw8ubGJmiD6qt3tpsTm8OSgHmDeLd6ZY0zH360UN1xTzw3jdo9A8rN0s4kNHQ1If
         zLUw==
X-Gm-Message-State: ABuFfog0NNX2Yrd55vV1LkiSRPQKY52Un4FBx9sm5cxiTGPGMPQH5t51
        rg7RTT7DZ2Za2ZJ2QmoMjMlijIt6
X-Google-Smtp-Source: ACcGV63LmlzqA1yJ3GxUTx5ku4fdbjpm9lQCvyJ+utUm0ITwUA1KlLlhWasMzYr34x2JW5rwCO6eNg==
X-Received: by 2002:adf:9f0f:: with SMTP id l15-v6mr14390007wrf.206.1538942409500;
        Sun, 07 Oct 2018 13:00:09 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-60-162.w92-136.abo.wanadoo.fr. [92.136.157.162])
        by smtp.googlemail.com with ESMTPSA id u76-v6sm17082538wmd.10.2018.10.07.13.00.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 13:00:09 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH 02/15] sequencer: make the todo_list structure public
Date:   Sun,  7 Oct 2018 21:54:05 +0200
Message-Id: <20181007195418.25752-3-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181007195418.25752-1-alban.gruin@gmail.com>
References: <20181007195418.25752-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes the structures todo_list and todo_item, and the functions
todo_list_release() and parse_insn_buffer(), accessible outside of
sequencer.c.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 66 +++++++++--------------------------------------------
 sequencer.h | 48 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 55 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index ed798b95d1..bb8ca2477f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1443,31 +1443,6 @@ static int allow_empty(struct replay_opts *opts, struct commit *commit)
 		return 1;
 }
 
-/*
- * Note that ordering matters in this enum. Not only must it match the mapping
- * below, it is also divided into several sections that matter.  When adding
- * new commands, make sure you add it in the right section.
- */
-enum todo_command {
-	/* commands that handle commits */
-	TODO_PICK = 0,
-	TODO_REVERT,
-	TODO_EDIT,
-	TODO_REWORD,
-	TODO_FIXUP,
-	TODO_SQUASH,
-	/* commands that do something else than handling a single commit */
-	TODO_EXEC,
-	TODO_LABEL,
-	TODO_RESET,
-	TODO_MERGE,
-	/* commands that do nothing but are counted for reporting progress */
-	TODO_NOOP,
-	TODO_DROP,
-	/* comments (not counted for reporting progress) */
-	TODO_COMMENT
-};
-
 static struct {
 	char c;
 	const char *str;
@@ -1937,26 +1912,7 @@ enum todo_item_flags {
 	TODO_EDIT_MERGE_MSG = 1
 };
 
-struct todo_item {
-	enum todo_command command;
-	struct commit *commit;
-	unsigned int flags;
-	const char *arg;
-	int arg_len;
-	size_t offset_in_buf;
-};
-
-struct todo_list {
-	struct strbuf buf;
-	struct todo_item *items;
-	int nr, alloc, current;
-	int done_nr, total_nr;
-	struct stat_data stat;
-};
-
-#define TODO_LIST_INIT { STRBUF_INIT }
-
-static void todo_list_release(struct todo_list *todo_list)
+void todo_list_release(struct todo_list *todo_list)
 {
 	strbuf_release(&todo_list->buf);
 	FREE_AND_NULL(todo_list->items);
@@ -2057,7 +2013,7 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 	return !item->commit;
 }
 
-static int parse_insn_buffer(char *buf, struct todo_list *todo_list)
+int todo_list_parse_insn_buffer(char *buf, struct todo_list *todo_list)
 {
 	struct todo_item *item;
 	char *p = buf, *next_p;
@@ -2152,7 +2108,7 @@ static int read_populate_todo(struct todo_list *todo_list,
 		return error(_("could not stat '%s'"), todo_file);
 	fill_stat_data(&todo_list->stat, &st);
 
-	res = parse_insn_buffer(todo_list->buf.buf, todo_list);
+	res = todo_list_parse_insn_buffer(todo_list->buf.buf, todo_list);
 	if (res) {
 		if (is_rebase_i(opts))
 			return error(_("please fix this using "
@@ -2183,7 +2139,7 @@ static int read_populate_todo(struct todo_list *todo_list,
 		FILE *f = fopen_or_warn(rebase_path_msgtotal(), "w");
 
 		if (strbuf_read_file(&done.buf, rebase_path_done(), 0) > 0 &&
-				!parse_insn_buffer(done.buf.buf, &done))
+				!todo_list_parse_insn_buffer(done.buf.buf, &done))
 			todo_list->done_nr = count_commands(&done);
 		else
 			todo_list->done_nr = 0;
@@ -4429,7 +4385,7 @@ int sequencer_add_exec_commands(const char *commands)
 	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
 		return error(_("could not read '%s'."), todo_file);
 
-	if (parse_insn_buffer(todo_list.buf.buf, &todo_list)) {
+	if (todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list)) {
 		todo_list_release(&todo_list);
 		return error(_("unusable todo list: '%s'"), todo_file);
 	}
@@ -4485,7 +4441,7 @@ int transform_todos(unsigned flags)
 	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
 		return error(_("could not read '%s'."), todo_file);
 
-	if (parse_insn_buffer(todo_list.buf.buf, &todo_list)) {
+	if (todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list)) {
 		todo_list_release(&todo_list);
 		return error(_("unusable todo list: '%s'"), todo_file);
 	}
@@ -4571,7 +4527,7 @@ int check_todo_list(void)
 		goto leave_check;
 	}
 	advise_to_edit_todo = res =
-		parse_insn_buffer(todo_list.buf.buf, &todo_list);
+		todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list);
 
 	if (res || check_level == MISSING_COMMIT_CHECK_IGNORE)
 		goto leave_check;
@@ -4590,7 +4546,7 @@ int check_todo_list(void)
 		goto leave_check;
 	}
 	strbuf_release(&todo_file);
-	res = !!parse_insn_buffer(todo_list.buf.buf, &todo_list);
+	res = !!todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list);
 
 	/* Find commits in git-rebase-todo.backup yet unseen */
 	for (i = todo_list.nr - 1; i >= 0; i--) {
@@ -4672,7 +4628,7 @@ static int skip_unnecessary_picks(struct object_id *output_oid)
 
 	if (strbuf_read_file_or_whine(&todo_list.buf, todo_file) < 0)
 		return -1;
-	if (parse_insn_buffer(todo_list.buf.buf, &todo_list) < 0) {
+	if (todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list) < 0) {
 		todo_list_release(&todo_list);
 		return -1;
 	}
@@ -4760,7 +4716,7 @@ int complete_action(struct replay_opts *opts, unsigned flags,
 	if (strbuf_read_file(buf, todo_file, 0) < 0)
 		return error_errno(_("could not read '%s'."), todo_file);
 
-	if (parse_insn_buffer(buf->buf, &todo_list)) {
+	if (todo_list_parse_insn_buffer(buf->buf, &todo_list)) {
 		todo_list_release(&todo_list);
 		return error(_("unusable todo list: '%s'"), todo_file);
 	}
@@ -4868,7 +4824,7 @@ int rearrange_squash(void)
 
 	if (strbuf_read_file_or_whine(&todo_list.buf, todo_file) < 0)
 		return -1;
-	if (parse_insn_buffer(todo_list.buf.buf, &todo_list) < 0) {
+	if (todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list) < 0) {
 		todo_list_release(&todo_list);
 		return -1;
 	}
diff --git a/sequencer.h b/sequencer.h
index 660cff5050..c786dee543 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -72,6 +72,54 @@ enum missing_commit_check_level {
 int write_message(const void *buf, size_t len, const char *filename,
 		  int append_eol);
 
+/*
+ * Note that ordering matters in this enum. Not only must it match the mapping
+ * of todo_command_info (in sequencer.c), it is also divided into several
+ * sections that matter.  When adding new commands, make sure you add it in the
+ * right section.
+ */
+enum todo_command {
+	/* commands that handle commits */
+	TODO_PICK = 0,
+	TODO_REVERT,
+	TODO_EDIT,
+	TODO_REWORD,
+	TODO_FIXUP,
+	TODO_SQUASH,
+	/* commands that do something else than handling a single commit */
+	TODO_EXEC,
+	TODO_LABEL,
+	TODO_RESET,
+	TODO_MERGE,
+	/* commands that do nothing but are counted for reporting progress */
+	TODO_NOOP,
+	TODO_DROP,
+	/* comments (not counted for reporting progress) */
+	TODO_COMMENT
+};
+
+struct todo_item {
+	enum todo_command command;
+	struct commit *commit;
+	unsigned int flags;
+	const char *arg;
+	int arg_len;
+	size_t offset_in_buf;
+};
+
+struct todo_list {
+	struct strbuf buf;
+	struct todo_item *items;
+	int nr, alloc, current;
+	int done_nr, total_nr;
+	struct stat_data stat;
+};
+
+#define TODO_LIST_INIT { STRBUF_INIT }
+
+int todo_list_parse_insn_buffer(char *buf, struct todo_list *todo_list);
+void todo_list_release(struct todo_list *todo_list);
+
 /* Call this to setup defaults before parsing command line options */
 void sequencer_init_config(struct replay_opts *opts);
 int sequencer_pick_revisions(struct replay_opts *opts);
-- 
2.19.1

