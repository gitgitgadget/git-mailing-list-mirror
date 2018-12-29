Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A3321F405
	for <e@80x24.org>; Sat, 29 Dec 2018 16:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbeL2QFG (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Dec 2018 11:05:06 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45358 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbeL2QFG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Dec 2018 11:05:06 -0500
Received: by mail-ed1-f66.google.com with SMTP id d39so19652915edb.12
        for <git@vger.kernel.org>; Sat, 29 Dec 2018 08:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qB2GR/RLIh66mZtBO4QIsSUi1IbY9OqgaGYi/odatcU=;
        b=HGkUoJS8QBNAax8K8KD2loz/SgXH5fEhte9IAud34I1GtGCacC4o6OYneBlXDiFTdQ
         S3v0tGykvxGEoQopSN6ebkNU4T0tkSDIYZBvUt2DIs45db7bcZJ3AmVKY78KtDBmco4m
         RFBrC4FrB+hmkJN+0IPPqgIfSrTnV45SRNe2aiSeFxNrraVm9hrGs03Ss4OqF8MlPswX
         JJYKCUUivUTOEVoqyhL1f6jwXLt85c8vZpJKzqKpPaQkZvWNQaH60ilYP1yXM3HTvPxC
         C987dzXrLQqMHB5gVVFnb824wW9/pU3s5L5parh9Qoqu6mGJaCS5qEd6OO+lx7yYJulR
         hBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qB2GR/RLIh66mZtBO4QIsSUi1IbY9OqgaGYi/odatcU=;
        b=V9huRRhgPmIBIoGuhzw6YP6x3POTlTXQ6Ujr7fy/bmqpoC7YKHgEXmW4NQeBrfq+kC
         nadDgNtfo5FszPpNq8KgiWfOL0MNMIMqfXr7dxXbVivZl+qjICahlN/8wEYyXXyWJHtf
         JYAcSsLbVbCb9zjtVQTU2QI1e2c4zNLewUULhoyNkocZxjouX0upZUXJ8/PNV73+01JE
         l6tmYoCyZZTV5tt7PGZrlWHrqwJRoNfkeCt2MqteNLnxG+kvf3lLl9geTVUxmqcKLCmU
         8v1ak8cJp8zzC2egUX+TcJi4C/3AUdwWvaI99D8W+ymcWm2ccot+w64/OMnQcvEHM+ra
         EVjw==
X-Gm-Message-State: AA+aEWaGSKrrWehI3vuhO8+wPzW0j1w97kA1QhvVMCMUx8h/moD/nEIZ
        mGxERYNdSNzV5StumVowpr3gIMV4
X-Google-Smtp-Source: AFSGD/XTfLdlQQTkrVp2+tA92yJU3WBJ701RkKjxrO080nWFVTzmyuef9ZV/KuMGqDQOgbDTwc80tA==
X-Received: by 2002:a50:a826:: with SMTP id j35mr26972185edc.230.1546099502097;
        Sat, 29 Dec 2018 08:05:02 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-184-107.w86-199.abo.wanadoo.fr. [86.199.39.107])
        by smtp.googlemail.com with ESMTPSA id b49sm15108663edb.73.2018.12.29.08.05.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Dec 2018 08:05:01 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v4 02/16] sequencer: make the todo_list structure public
Date:   Sat, 29 Dec 2018 17:03:59 +0100
Message-Id: <20181229160413.19333-3-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181229160413.19333-1-alban.gruin@gmail.com>
References: <20181109080805.6350-1-alban.gruin@gmail.com>
 <20181229160413.19333-1-alban.gruin@gmail.com>
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
Some changes were introduced because of the conflict resolution with
nd/the-index.  They mostly consist of adding a parameter ("r") when
calling todo_list_parse_insn_buffer.

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

