Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 697B51F453
	for <e@80x24.org>; Sat, 27 Oct 2018 21:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbeJ1GMP (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Oct 2018 02:12:15 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36868 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728472AbeJ1GMP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Oct 2018 02:12:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id g9-v6so4667272wrq.4
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 14:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jNzQCnH/U1d1VuAl6d4fUv8+LipC2Bp9wwBpHyXrkuQ=;
        b=hudwuN1FUVfjnVgtHjAhKgyfKlCvY6iXZUCiVqV/PVabGB9MbeszPwOcktSuvLtLhe
         0sgPE10RfCf2Evp9ayflkGf++QbyJviGyTCrPbfSLN3TkskfJwb3ygLoYqjiSwKn80ry
         7/EwnqZe0o1/xb03GU64BqMxyMDEwFQW2wIYPSB5b1oqwNlgROJLKPmLiMvDhW01DDG2
         v+r8hr5o/OfiZHsgiHW2dy/H67Wl37h02iY+Fi2laQZ7b7f52k0PxmXf5M5cf17p3Z65
         BxQG7ixZduEwROzQgKCrjbSl+oKrks96IIUaL5pt6IKulNXcMUxRi5Pdu1Ujv1SzBloF
         qz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jNzQCnH/U1d1VuAl6d4fUv8+LipC2Bp9wwBpHyXrkuQ=;
        b=h6vYJ1p9V6B3EtUmpXUSP2muDn6rcsSo/d/eqIwmgdr3yVNEmLkig+W5AW4OqP5F7D
         trmydaLprE/l2hKP6aTR142jwEGjNkbWQPuhDZrEaVyGvVTM/nMP5SRE5YHuTLMbSYQt
         GTGY6AitFXqtDvqtqdQfAv4k0hsOKIzRKTaiJNVGD/veFMnE9QMe1lOGTjqdHxvbj3BI
         We7lvNAnq4br4L4zfG93u5DNledgMMK0I3zZut5KlUiL9Fx0uWoIRdUFaHTLokO3V+LQ
         1g6VvPOLzGIADFs+nfM0fz7TYAQOvoeWEfk/3WZ8t5MV/znuGf6K58Sxjt1+9nAV/IZc
         IpCA==
X-Gm-Message-State: AGRZ1gJ5T2N5jzagOoA8pgY/Y/1O2vp5fu+q8QJtcGqOepcEAkDOS6Km
        ucgokH8BdJPBUPhsrsdzrZVevQau
X-Google-Smtp-Source: AJdET5eq9urSIHYD+GiXK5lI5ygGrItDqBxpaaaM80fKGjvdIvSr+t5IC0re/7CeckBncOQv6mB74g==
X-Received: by 2002:adf:efcb:: with SMTP id i11-v6mr9267303wrp.204.1540675793913;
        Sat, 27 Oct 2018 14:29:53 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-658-1-19-179.w86-222.abo.wanadoo.fr. [86.222.18.179])
        by smtp.googlemail.com with ESMTPSA id t198-v6sm9842514wmd.9.2018.10.27.14.29.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 14:29:53 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v2 02/16] sequencer: make the todo_list structure public
Date:   Sat, 27 Oct 2018 23:29:16 +0200
Message-Id: <20181027212930.9303-3-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181027212930.9303-1-alban.gruin@gmail.com>
References: <20181007195418.25752-1-alban.gruin@gmail.com>
 <20181027212930.9303-1-alban.gruin@gmail.com>
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
No changes since v1.

 sequencer.c | 66 +++++++++--------------------------------------------
 sequencer.h | 48 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 55 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 9c8bd3f632..f791729271 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1401,31 +1401,6 @@ static int allow_empty(struct replay_opts *opts, struct commit *commit)
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
@@ -1897,26 +1872,7 @@ enum todo_item_flags {
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
@@ -2017,7 +1973,7 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 	return !item->commit;
 }
 
-static int parse_insn_buffer(char *buf, struct todo_list *todo_list)
+int todo_list_parse_insn_buffer(char *buf, struct todo_list *todo_list)
 {
 	struct todo_item *item;
 	char *p = buf, *next_p;
@@ -2115,7 +2071,7 @@ static int read_populate_todo(struct todo_list *todo_list,
 		return error(_("could not stat '%s'"), todo_file);
 	fill_stat_data(&todo_list->stat, &st);
 
-	res = parse_insn_buffer(todo_list->buf.buf, todo_list);
+	res = todo_list_parse_insn_buffer(todo_list->buf.buf, todo_list);
 	if (res) {
 		if (is_rebase_i(opts))
 			return error(_("please fix this using "
@@ -2146,7 +2102,7 @@ static int read_populate_todo(struct todo_list *todo_list,
 		FILE *f = fopen_or_warn(rebase_path_msgtotal(), "w");
 
 		if (strbuf_read_file(&done.buf, rebase_path_done(), 0) > 0 &&
-				!parse_insn_buffer(done.buf.buf, &done))
+				!todo_list_parse_insn_buffer(done.buf.buf, &done))
 			todo_list->done_nr = count_commands(&done);
 		else
 			todo_list->done_nr = 0;
@@ -4276,7 +4232,7 @@ int sequencer_add_exec_commands(const char *commands)
 	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
 		return error(_("could not read '%s'."), todo_file);
 
-	if (parse_insn_buffer(todo_list.buf.buf, &todo_list)) {
+	if (todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list)) {
 		todo_list_release(&todo_list);
 		return error(_("unusable todo list: '%s'"), todo_file);
 	}
@@ -4311,7 +4267,7 @@ int transform_todos(unsigned flags)
 	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
 		return error(_("could not read '%s'."), todo_file);
 
-	if (parse_insn_buffer(todo_list.buf.buf, &todo_list)) {
+	if (todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list)) {
 		todo_list_release(&todo_list);
 		return error(_("unusable todo list: '%s'"), todo_file);
 	}
@@ -4397,7 +4353,7 @@ int check_todo_list(void)
 		goto leave_check;
 	}
 	advise_to_edit_todo = res =
-		parse_insn_buffer(todo_list.buf.buf, &todo_list);
+		todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list);
 
 	if (res || check_level == MISSING_COMMIT_CHECK_IGNORE)
 		goto leave_check;
@@ -4416,7 +4372,7 @@ int check_todo_list(void)
 		goto leave_check;
 	}
 	strbuf_release(&todo_file);
-	res = !!parse_insn_buffer(todo_list.buf.buf, &todo_list);
+	res = !!todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list);
 
 	/* Find commits in git-rebase-todo.backup yet unseen */
 	for (i = todo_list.nr - 1; i >= 0; i--) {
@@ -4498,7 +4454,7 @@ static int skip_unnecessary_picks(struct object_id *output_oid)
 
 	if (strbuf_read_file_or_whine(&todo_list.buf, todo_file) < 0)
 		return -1;
-	if (parse_insn_buffer(todo_list.buf.buf, &todo_list) < 0) {
+	if (todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list) < 0) {
 		todo_list_release(&todo_list);
 		return -1;
 	}
@@ -4586,7 +4542,7 @@ int complete_action(struct replay_opts *opts, unsigned flags,
 	if (strbuf_read_file(buf, todo_file, 0) < 0)
 		return error_errno(_("could not read '%s'."), todo_file);
 
-	if (parse_insn_buffer(buf->buf, &todo_list)) {
+	if (todo_list_parse_insn_buffer(buf->buf, &todo_list)) {
 		todo_list_release(&todo_list);
 		return error(_("unusable todo list: '%s'"), todo_file);
 	}
@@ -4694,7 +4650,7 @@ int rearrange_squash(void)
 
 	if (strbuf_read_file_or_whine(&todo_list.buf, todo_file) < 0)
 		return -1;
-	if (parse_insn_buffer(todo_list.buf.buf, &todo_list) < 0) {
+	if (todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list) < 0) {
 		todo_list_release(&todo_list);
 		return -1;
 	}
diff --git a/sequencer.h b/sequencer.h
index aab280f276..cc69473bc2 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -67,6 +67,54 @@ enum missing_commit_check_level {
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

