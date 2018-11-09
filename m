Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5695F1F453
	for <e@80x24.org>; Fri,  9 Nov 2018 08:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbeKIRsX (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 12:48:23 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35603 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbeKIRr7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 12:47:59 -0500
Received: by mail-wm1-f67.google.com with SMTP id t15-v6so1093383wmt.0
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 00:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FcjhqDLWqeSOFhuzUuhqeT3vuOH78r9kJ6FN+M08c3w=;
        b=D3nwBKDriYFQCrHCJ2EYyyAKASmNfvcPvHa+NjsCt3NPPAOIAspfFsKIXmxwtlXK3C
         Nudi2M/X9pS0SVR37Xm/RdVREPSk+NwXt93FgvHLtkLFgXCRLAqCJHz1YGfz5zuWZzqT
         TIDOJQU/6aKrgKvPQJwwu/Zlb5HjO3UKT8t/X9pFF/mquF9YUw3as5EGtqDxbGbSpa7o
         tGydOEynwoE+g2h82J1wXXMO1CUwZ1WgxPhX4woPU1WCtSWI2b/MFRzp1RvJ5Ldd31ET
         rwBB1fE7CqWRMv9XjiFUZHtF3eEnXPzQv8n1fXWi86hQdV5Pc8kg757y0D91fueMHjhh
         aeww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FcjhqDLWqeSOFhuzUuhqeT3vuOH78r9kJ6FN+M08c3w=;
        b=m+UymS4REBu3soV/HNOks0mVg6KezOKltSdZLRG1lq2l0+JAQTp8M51TnkRrC6CBRK
         xxCJ9N69vk4X7UxyJqnY3EudsTU0Cg6KeYY3Y7OQc6RK6bhcGZoY9ZXfZkE7FJDVjW+V
         NvsKDiistob/GDy++vQSTQrALSy9MoY23Oy+AJ/bpUVvKGhoryvYGg3A1CATNzvNx8B5
         jfPOPsohfMSPN4/DBZxdHQnU7COkw2vmsvs3NVID8+UzKKmTEdqwjrCDyUfgbFaRVN6r
         kdWKEsp8vnwnodv6U7Rvtg0Yga4IOqC4eENrjoCfxzD2yfAdlGbB2vt7WaEPtOXmasDk
         j6Mg==
X-Gm-Message-State: AGRZ1gLmyuP2LLDgscR9ty7m35Cz9PJpzrIT0X+7UT4gCTKnDBnJe+WL
        0K7WUfGMHjk6FHiP7NMHMj1VZShO
X-Google-Smtp-Source: AJdET5e0kfd1LGKYFvI89nQPfiEj+b+qL9DQMZsoVXNBezVP81Dk/cAcdYGTyvDm7uuFYt/BydTzrQ==
X-Received: by 2002:a1c:ee0c:: with SMTP id m12-v6mr3932529wmh.75.1541750912390;
        Fri, 09 Nov 2018 00:08:32 -0800 (PST)
Received: from andromeda.lan (atoulouse-658-1-60-221.w92-136.abo.wanadoo.fr. [92.136.157.221])
        by smtp.googlemail.com with ESMTPSA id x194-v6sm3003973wmd.41.2018.11.09.00.08.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 00:08:31 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v3 02/16] sequencer: make the todo_list structure public
Date:   Fri,  9 Nov 2018 09:07:51 +0100
Message-Id: <20181109080805.6350-3-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181109080805.6350-1-alban.gruin@gmail.com>
References: <20181027212930.9303-1-alban.gruin@gmail.com>
 <20181109080805.6350-1-alban.gruin@gmail.com>
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
 sequencer.c | 67 +++++++++--------------------------------------------
 sequencer.h | 49 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 56 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 07cc91d8db..7adbeaa27d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1443,32 +1443,6 @@ static int allow_empty(struct replay_opts *opts, struct commit *commit)
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
@@ -1939,26 +1913,7 @@ enum todo_item_flags {
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
@@ -2060,7 +2015,7 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 	return !item->commit;
 }
 
-static int parse_insn_buffer(char *buf, struct todo_list *todo_list)
+int todo_list_parse_insn_buffer(char *buf, struct todo_list *todo_list)
 {
 	struct todo_item *item;
 	char *p = buf, *next_p;
@@ -2158,7 +2113,7 @@ static int read_populate_todo(struct todo_list *todo_list,
 		return error(_("could not stat '%s'"), todo_file);
 	fill_stat_data(&todo_list->stat, &st);
 
-	res = parse_insn_buffer(todo_list->buf.buf, todo_list);
+	res = todo_list_parse_insn_buffer(todo_list->buf.buf, todo_list);
 	if (res) {
 		if (is_rebase_i(opts))
 			return error(_("please fix this using "
@@ -2189,7 +2144,7 @@ static int read_populate_todo(struct todo_list *todo_list,
 		FILE *f = fopen_or_warn(rebase_path_msgtotal(), "w");
 
 		if (strbuf_read_file(&done.buf, rebase_path_done(), 0) > 0 &&
-				!parse_insn_buffer(done.buf.buf, &done))
+				!todo_list_parse_insn_buffer(done.buf.buf, &done))
 			todo_list->done_nr = count_commands(&done);
 		else
 			todo_list->done_nr = 0;
@@ -4454,7 +4409,7 @@ int sequencer_add_exec_commands(const char *commands)
 	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
 		return error(_("could not read '%s'."), todo_file);
 
-	if (parse_insn_buffer(todo_list.buf.buf, &todo_list)) {
+	if (todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list)) {
 		todo_list_release(&todo_list);
 		return error(_("unusable todo list: '%s'"), todo_file);
 	}
@@ -4510,7 +4465,7 @@ int transform_todos(unsigned flags)
 	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
 		return error(_("could not read '%s'."), todo_file);
 
-	if (parse_insn_buffer(todo_list.buf.buf, &todo_list)) {
+	if (todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list)) {
 		todo_list_release(&todo_list);
 		return error(_("unusable todo list: '%s'"), todo_file);
 	}
@@ -4596,7 +4551,7 @@ int check_todo_list(void)
 		goto leave_check;
 	}
 	advise_to_edit_todo = res =
-		parse_insn_buffer(todo_list.buf.buf, &todo_list);
+		todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list);
 
 	if (res || check_level == MISSING_COMMIT_CHECK_IGNORE)
 		goto leave_check;
@@ -4615,7 +4570,7 @@ int check_todo_list(void)
 		goto leave_check;
 	}
 	strbuf_release(&todo_file);
-	res = !!parse_insn_buffer(todo_list.buf.buf, &todo_list);
+	res = !!todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list);
 
 	/* Find commits in git-rebase-todo.backup yet unseen */
 	for (i = todo_list.nr - 1; i >= 0; i--) {
@@ -4697,7 +4652,7 @@ static int skip_unnecessary_picks(struct object_id *output_oid)
 
 	if (strbuf_read_file_or_whine(&todo_list.buf, todo_file) < 0)
 		return -1;
-	if (parse_insn_buffer(todo_list.buf.buf, &todo_list) < 0) {
+	if (todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list) < 0) {
 		todo_list_release(&todo_list);
 		return -1;
 	}
@@ -4785,7 +4740,7 @@ int complete_action(struct replay_opts *opts, unsigned flags,
 	if (strbuf_read_file(buf, todo_file, 0) < 0)
 		return error_errno(_("could not read '%s'."), todo_file);
 
-	if (parse_insn_buffer(buf->buf, &todo_list)) {
+	if (todo_list_parse_insn_buffer(buf->buf, &todo_list)) {
 		todo_list_release(&todo_list);
 		return error(_("unusable todo list: '%s'"), todo_file);
 	}
@@ -4893,7 +4848,7 @@ int rearrange_squash(void)
 
 	if (strbuf_read_file_or_whine(&todo_list.buf, todo_file) < 0)
 		return -1;
-	if (parse_insn_buffer(todo_list.buf.buf, &todo_list) < 0) {
+	if (todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list) < 0) {
 		todo_list_release(&todo_list);
 		return -1;
 	}
diff --git a/sequencer.h b/sequencer.h
index 660cff5050..84f813305f 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -72,6 +72,55 @@ enum missing_commit_check_level {
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
+int todo_list_parse_insn_buffer(char *buf, struct todo_list *todo_list);
+void todo_list_release(struct todo_list *todo_list);
+
 /* Call this to setup defaults before parsing command line options */
 void sequencer_init_config(struct replay_opts *opts);
 int sequencer_pick_revisions(struct replay_opts *opts);
-- 
2.19.1.872.ga867da739e

