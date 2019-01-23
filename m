Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFAD81F453
	for <e@80x24.org>; Wed, 23 Jan 2019 20:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfAWU7Y (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 15:59:24 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35254 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbfAWU7Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 15:59:24 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so4143453wrb.2
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 12:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZLrJvqGo9/a7DxNTFFnBPgKMldEvQMgdwBXGdrm58Ug=;
        b=Cwg0WjhMi0fswX0ndq9NY7A8NVVs0Pc7sQLu/dH59wJDI3fI+/FEI22zGq/NvGdUhG
         ZoMVzJgTyt/UgqMxAlqeWEUUOQotSQq4S1K6UNVi1OjZky2px0iHRZXbHBJRQIKmZ4lM
         i9KxVLAaDWyCi3F94ly//TfxOq6b4Ya89cCJunX3WyEzF6m0Rhka8WZmHbVYlXyfupJv
         IkAlrKDV6tJf4r/4alM5MHeSlkWTMOlgvkfFy04ds05/OvpLnIp15KXm/Ooj2eQSdOTV
         0Uo2z2B/dRYEP6auzphH2j6lboIDqGvcx07eFDtdr9D3CGISYWApqSgsDUACTEU8v7DH
         AEww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZLrJvqGo9/a7DxNTFFnBPgKMldEvQMgdwBXGdrm58Ug=;
        b=XmZHPWbtq3AEK3b85hJHg93hSxepaCtxP1wMv3Fiyc0p9a/QAQw2RQoM9Mr1TOlPzA
         YXthJeJu12aeGqqE06MlEk2l/1eWawCyO6rfyUmKm/Yoa7hbfp85YaGK21EF2UJaTl07
         Fp/lWiVWb8byVcXlAJK+RnnDPh5hYRFnaX4qFi77eht8lJQWnUgY2MAI5jkMXP5OJQ57
         xLTr1AFdtn197nX4arZQB0IxvFgbCjt7qmaW0t7UKgagS4WTZvqVgf3vxPjigYvsqZzO
         /NKMKQ4vxDWS0N1XcIuZy3VvR55ykZol/SyhqaGOf0Hqy41MxBkRPpY4qBsMB8K0pHa5
         aIlw==
X-Gm-Message-State: AJcUukf6xy9lnASeeKD801KYBm2emYS4tAPb85lvAGYetTcIF7UfQXEK
        ttxoKlihvSnPEHCJJzkBIhCB3MOQ
X-Google-Smtp-Source: ALg8bN6jDLZ5itbrSUjc4DWc/JvFEuIPZDmHIMdEMH5g2Gw444SpmbHuap4FqZCzCmnSQgXB888n9A==
X-Received: by 2002:a5d:5409:: with SMTP id g9mr4417861wrv.88.1548277161449;
        Wed, 23 Jan 2019 12:59:21 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-2-163.w86-222.abo.wanadoo.fr. [86.222.145.163])
        by smtp.googlemail.com with ESMTPSA id h13sm80634127wrp.61.2019.01.23.12.59.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 12:59:20 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v5 02/16] sequencer: make the todo_list structure public
Date:   Wed, 23 Jan 2019 21:58:07 +0100
Message-Id: <20190123205821.27459-3-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190123205821.27459-1-alban.gruin@gmail.com>
References: <20181229160413.19333-1-alban.gruin@gmail.com>
 <20190123205821.27459-1-alban.gruin@gmail.com>
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
Unchanged since v4.

 sequencer.c | 69 ++++++++++-------------------------------------------
 sequencer.h | 50 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 57 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index a7afaf6882..5b84a20532 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1460,32 +1460,6 @@ static int allow_empty(struct repository *r,
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
-	TODO_BREAK,
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
@@ -1962,26 +1936,7 @@ enum todo_item_flags {
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
@@ -2084,8 +2039,8 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
 	return !item->commit;
 }
 
-static int parse_insn_buffer(struct repository *r, char *buf,
-			     struct todo_list *todo_list)
+int todo_list_parse_insn_buffer(struct repository *r, char *buf,
+				struct todo_list *todo_list)
 {
 	struct todo_item *item;
 	char *p = buf, *next_p;
@@ -2184,7 +2139,7 @@ static int read_populate_todo(struct repository *r,
 		return error(_("could not stat '%s'"), todo_file);
 	fill_stat_data(&todo_list->stat, &st);
 
-	res = parse_insn_buffer(r, todo_list->buf.buf, todo_list);
+	res = todo_list_parse_insn_buffer(r, todo_list->buf.buf, todo_list);
 	if (res) {
 		if (is_rebase_i(opts))
 			return error(_("please fix this using "
@@ -2215,7 +2170,7 @@ static int read_populate_todo(struct repository *r,
 		FILE *f = fopen_or_warn(rebase_path_msgtotal(), "w");
 
 		if (strbuf_read_file(&done.buf, rebase_path_done(), 0) > 0 &&
-		    !parse_insn_buffer(r, done.buf.buf, &done))
+		    !todo_list_parse_insn_buffer(r, done.buf.buf, &done))
 			todo_list->done_nr = count_commands(&done);
 		else
 			todo_list->done_nr = 0;
@@ -4501,7 +4456,7 @@ int sequencer_add_exec_commands(struct repository *r,
 	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
 		return error(_("could not read '%s'."), todo_file);
 
-	if (parse_insn_buffer(r, todo_list.buf.buf, &todo_list)) {
+	if (todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list)) {
 		todo_list_release(&todo_list);
 		return error(_("unusable todo list: '%s'"), todo_file);
 	}
@@ -4557,7 +4512,7 @@ int transform_todos(struct repository *r, unsigned flags)
 	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
 		return error(_("could not read '%s'."), todo_file);
 
-	if (parse_insn_buffer(r, todo_list.buf.buf, &todo_list)) {
+	if (todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list)) {
 		todo_list_release(&todo_list);
 		return error(_("unusable todo list: '%s'"), todo_file);
 	}
@@ -4643,7 +4598,7 @@ int check_todo_list(struct repository *r)
 		goto leave_check;
 	}
 	advise_to_edit_todo = res =
-		parse_insn_buffer(r, todo_list.buf.buf, &todo_list);
+		todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list);
 
 	if (res || check_level == MISSING_COMMIT_CHECK_IGNORE)
 		goto leave_check;
@@ -4662,7 +4617,7 @@ int check_todo_list(struct repository *r)
 		goto leave_check;
 	}
 	strbuf_release(&todo_file);
-	res = !!parse_insn_buffer(r, todo_list.buf.buf, &todo_list);
+	res = !!todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list);
 
 	/* Find commits in git-rebase-todo.backup yet unseen */
 	for (i = todo_list.nr - 1; i >= 0; i--) {
@@ -4744,7 +4699,7 @@ static int skip_unnecessary_picks(struct repository *r, struct object_id *output
 
 	if (strbuf_read_file_or_whine(&todo_list.buf, todo_file) < 0)
 		return -1;
-	if (parse_insn_buffer(r, todo_list.buf.buf, &todo_list) < 0) {
+	if (todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list) < 0) {
 		todo_list_release(&todo_list);
 		return -1;
 	}
@@ -4832,7 +4787,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 	if (strbuf_read_file(buf, todo_file, 0) < 0)
 		return error_errno(_("could not read '%s'."), todo_file);
 
-	if (parse_insn_buffer(r, buf->buf, &todo_list)) {
+	if (todo_list_parse_insn_buffer(r, buf->buf, &todo_list)) {
 		todo_list_release(&todo_list);
 		return error(_("unusable todo list: '%s'"), todo_file);
 	}
@@ -4940,7 +4895,7 @@ int rearrange_squash(struct repository *r)
 
 	if (strbuf_read_file_or_whine(&todo_list.buf, todo_file) < 0)
 		return -1;
-	if (parse_insn_buffer(r, todo_list.buf.buf, &todo_list) < 0) {
+	if (todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list) < 0) {
 		todo_list_release(&todo_list);
 		return -1;
 	}
diff --git a/sequencer.h b/sequencer.h
index d2c18edd3a..7dc4d8946b 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -73,6 +73,56 @@ enum missing_commit_check_level {
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
+	TODO_BREAK,
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
+int todo_list_parse_insn_buffer(struct repository *r, char *buf,
+				struct todo_list *todo_list);
+void todo_list_release(struct todo_list *todo_list);
+
 /* Call this to setup defaults before parsing command line options */
 void sequencer_init_config(struct replay_opts *opts);
 int sequencer_pick_revisions(struct repository *repo,
-- 
2.20.1

