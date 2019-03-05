Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4E2620248
	for <e@80x24.org>; Tue,  5 Mar 2019 19:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfCETS3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 14:18:29 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45813 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfCETS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 14:18:29 -0500
Received: by mail-wr1-f68.google.com with SMTP id w17so10726681wrn.12
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 11:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pr0S+1y7z01nkUr37WLhEGPAxYcGl4QJHurrptt1+m8=;
        b=TCIAYblVpfsHPZUmEJmZWp+P+XnVTxWHPcxG1z9sjX94cJ9KMmrty9oE3f2b43cWGE
         S3cX2VK0D9D2gWPnEFt5zq2Cg5RNDAbRLL0DTIuvLP07ItVvh0I8gt2nb2ZVIuikNs7/
         5HYXav21hJRpAsduCG4ttndIyWaBN349IESgCx2obfIyvVWfH8lFKljeAbr2ws607iXw
         hOBlNx09/09xn8dav9hpPdAOw83sBh7JhzBN4IGBBax/aj1l7SJEuYxdgqNWrxwO1xWN
         UpqvL4b2mOCJGoWhxZ7YHWMAF6Nqrz3wKSV7Qn+sgWT/QNrJH51LCGeV84yrSU7DTEKT
         3sxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pr0S+1y7z01nkUr37WLhEGPAxYcGl4QJHurrptt1+m8=;
        b=ldprKJp5l5M+Iy/pSACikbuoR7ewu5zCVpD2DB9s5z03hQghT6OK/fzlpn90CFF2RI
         t4cKv8w9ge279NizpRQjzc65/G3KfE00rCNf/yWiZ9vZcJdkywJ6j/Hq/cJcpeovCNI0
         xRNqLh4MDAFRu8Smp1FzwhgPunUG+pGFojlntY1BJsOUHLoUWCFS+NhwuQ0UYS/q7PdN
         jTRI5ctFSX2+QDLQlHlbJXS6nga0RUwyXtozJ2GSP3phzJCdTcnegGjng12EqakOWVcR
         2C3rXpoLahiBjoCQqLtPkcRUa7E57VObgmQwKKVHSW9MnQ0RUrrR9mxmWpjEUrw/ZITk
         7kyg==
X-Gm-Message-State: APjAAAVeDfKHr6a5nQAJeaGQPxWAsQtEOInnseFpn44c3Q5cOLJor6P8
        6nWPvZxW9w6FC2+/iMUMrnKdj0Us
X-Google-Smtp-Source: APXvYqzdHt+mkljgXRshyNJ8AvRWBZONKgWtAgcSlnJNasdZEF915M1wlcqszizBlaR7AgL3gi+/5w==
X-Received: by 2002:adf:b601:: with SMTP id f1mr332584wre.158.1551813506171;
        Tue, 05 Mar 2019 11:18:26 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-67-51.w92-136.abo.wanadoo.fr. [92.136.29.51])
        by smtp.googlemail.com with ESMTPSA id r6sm10038219wrx.48.2019.03.05.11.18.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 11:18:25 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v8 02/18] sequencer: make the todo_list structure public
Date:   Tue,  5 Mar 2019 20:17:49 +0100
Message-Id: <20190305191805.13561-3-alban.gruin@gmail.com>
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

This makes the structures todo_list and todo_item, and the functions
todo_list_release() and parse_insn_buffer(), accessible outside of
sequencer.c.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
No changes since v7.

 sequencer.c | 69 ++++++++++-------------------------------------------
 sequencer.h | 50 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 57 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index d605199a54..25cc7a9a91 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1510,32 +1510,6 @@ static int allow_empty(struct repository *r,
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
@@ -2012,26 +1986,7 @@ enum todo_item_flags {
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
@@ -2134,8 +2089,8 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
 	return !item->commit;
 }
 
-static int parse_insn_buffer(struct repository *r, char *buf,
-			     struct todo_list *todo_list)
+int todo_list_parse_insn_buffer(struct repository *r, char *buf,
+				struct todo_list *todo_list)
 {
 	struct todo_item *item;
 	char *p = buf, *next_p;
@@ -2234,7 +2189,7 @@ static int read_populate_todo(struct repository *r,
 		return error(_("could not stat '%s'"), todo_file);
 	fill_stat_data(&todo_list->stat, &st);
 
-	res = parse_insn_buffer(r, todo_list->buf.buf, todo_list);
+	res = todo_list_parse_insn_buffer(r, todo_list->buf.buf, todo_list);
 	if (res) {
 		if (is_rebase_i(opts))
 			return error(_("please fix this using "
@@ -2265,7 +2220,7 @@ static int read_populate_todo(struct repository *r,
 		FILE *f = fopen_or_warn(rebase_path_msgtotal(), "w");
 
 		if (strbuf_read_file(&done.buf, rebase_path_done(), 0) > 0 &&
-		    !parse_insn_buffer(r, done.buf.buf, &done))
+		    !todo_list_parse_insn_buffer(r, done.buf.buf, &done))
 			todo_list->done_nr = count_commands(&done);
 		else
 			todo_list->done_nr = 0;
@@ -4556,7 +4511,7 @@ int sequencer_add_exec_commands(struct repository *r,
 	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
 		return error(_("could not read '%s'."), todo_file);
 
-	if (parse_insn_buffer(r, todo_list.buf.buf, &todo_list)) {
+	if (todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list)) {
 		todo_list_release(&todo_list);
 		return error(_("unusable todo list: '%s'"), todo_file);
 	}
@@ -4612,7 +4567,7 @@ int transform_todos(struct repository *r, unsigned flags)
 	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
 		return error(_("could not read '%s'."), todo_file);
 
-	if (parse_insn_buffer(r, todo_list.buf.buf, &todo_list)) {
+	if (todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list)) {
 		todo_list_release(&todo_list);
 		return error(_("unusable todo list: '%s'"), todo_file);
 	}
@@ -4698,7 +4653,7 @@ int check_todo_list(struct repository *r)
 		goto leave_check;
 	}
 	advise_to_edit_todo = res =
-		parse_insn_buffer(r, todo_list.buf.buf, &todo_list);
+		todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list);
 
 	if (res || check_level == MISSING_COMMIT_CHECK_IGNORE)
 		goto leave_check;
@@ -4717,7 +4672,7 @@ int check_todo_list(struct repository *r)
 		goto leave_check;
 	}
 	strbuf_release(&todo_file);
-	res = !!parse_insn_buffer(r, todo_list.buf.buf, &todo_list);
+	res = !!todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list);
 
 	/* Find commits in git-rebase-todo.backup yet unseen */
 	for (i = todo_list.nr - 1; i >= 0; i--) {
@@ -4799,7 +4754,7 @@ static int skip_unnecessary_picks(struct repository *r, struct object_id *output
 
 	if (strbuf_read_file_or_whine(&todo_list.buf, todo_file) < 0)
 		return -1;
-	if (parse_insn_buffer(r, todo_list.buf.buf, &todo_list) < 0) {
+	if (todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list) < 0) {
 		todo_list_release(&todo_list);
 		return -1;
 	}
@@ -4887,7 +4842,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 	if (strbuf_read_file(buf, todo_file, 0) < 0)
 		return error_errno(_("could not read '%s'."), todo_file);
 
-	if (parse_insn_buffer(r, buf->buf, &todo_list)) {
+	if (todo_list_parse_insn_buffer(r, buf->buf, &todo_list)) {
 		todo_list_release(&todo_list);
 		return error(_("unusable todo list: '%s'"), todo_file);
 	}
@@ -4995,7 +4950,7 @@ int rearrange_squash(struct repository *r)
 
 	if (strbuf_read_file_or_whine(&todo_list.buf, todo_file) < 0)
 		return -1;
-	if (parse_insn_buffer(r, todo_list.buf.buf, &todo_list) < 0) {
+	if (todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list) < 0) {
 		todo_list_release(&todo_list);
 		return -1;
 	}
diff --git a/sequencer.h b/sequencer.h
index 9d83f0f3e9..c6360bac66 100644
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

