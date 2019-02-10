Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D76AE1F453
	for <e@80x24.org>; Sun, 10 Feb 2019 13:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfBJN1c (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Feb 2019 08:27:32 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40019 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbfBJN1a (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Feb 2019 08:27:30 -0500
Received: by mail-wm1-f67.google.com with SMTP id q21so11786057wmc.5
        for <git@vger.kernel.org>; Sun, 10 Feb 2019 05:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GyI1/KTY2mSiSd43Sv7znguxqUauw5shFzD3u75E6Yg=;
        b=pTmagMTuUVgcWdtvsQov0nhL4bXBWNsGhUi5GRF9AaJGRPCgCB07ItdZXVrbQkRx9x
         yiHWRhrYHJMEZ12V+jqYA57Ji8815RVelQq+9m7XuLANMafrVMi2z50B054PricACFBZ
         RdirCNtepu0QnlciaSvbqeP+QAaw+ok1vN+P+ZMWozNVY6bvd1TQrIA6bto/izmiy3tM
         Jgm8wbCE/WpCHaRWQ7ZY1rd8VcCI8KmOwlTe7NSzJf+/fL7j0dya+qVWSNhjiTXSVxKU
         Wi7pY9a63LnKzLRKTYt0jCn/iRhCBN4w2aEYrUAx7+FoVGAJOOFi0pMTWVHDeq3ZQunC
         Yngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GyI1/KTY2mSiSd43Sv7znguxqUauw5shFzD3u75E6Yg=;
        b=iwZSv7/QkzkAehR1BJQoVZu/5sFEJZrQdLaTxizy7McAgqgW+67u48eHXTWyCrLgNt
         frjnfwxDVsnDk0jNpcXTdtrte2DZ9/vuZWnk11MwaBB2tsDisy+Xr9BFVjPI2uPhpWEU
         n/6GWfFaPQgERwDg2J4D+kRgvvif6/Jof7QC377kTAKmypWUBpl9dl37gkPP1wfqiMVB
         4D2NVb1hiyaIZ//pV5KDTSqpvpkre5JjygD0XZZrXbjnWhESsBZLArI2W9IFmtqNOepS
         N6Y287TXyff2skRFSFs41vYICPKAGAPwHsB5MSuyDvOtF5u92JaZecdXrTBY3OrxA4mv
         yE7w==
X-Gm-Message-State: AHQUAubZi3DrfrhwVamQYQtRoOOWpEkI5SLohOEHraWcNYYEynPaCygy
        m64/bMy2xoYi6hkP5HaASUJDZ7eV
X-Google-Smtp-Source: AHgI3IZ+cXq51zGyBF8kLvEPPe0dLxdqQTCGLsBiQlfxxbAo7OlQyzrvnJtbb9gtZ/NiOHdRWvP2Bw==
X-Received: by 2002:a1c:c441:: with SMTP id u62mr6351608wmf.69.1549805245544;
        Sun, 10 Feb 2019 05:27:25 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-21-92.w86-222.abo.wanadoo.fr. [86.222.20.92])
        by smtp.googlemail.com with ESMTPSA id z26sm5266314wml.44.2019.02.10.05.27.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 05:27:25 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v7 16/16] rebase--interactive: move several functions to rebase--interactive.c
Date:   Sun, 10 Feb 2019 14:26:48 +0100
Message-Id: <20190210132648.12821-17-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190210132648.12821-1-alban.gruin@gmail.com>
References: <20190129150159.10588-1-alban.gruin@gmail.com>
 <20190210132648.12821-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As sequencer_add_exec_commands(), rearrange_squash_in_todo_file(), and
transform_todo_file() are only needed inside of rebase--interactive.c
for rebase -p, they are moved there from sequencer.c.

The parameter r (repository) is dropped from them, and the error
handling of rearrange_squash_in_todo_file() is slightly improved.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/rebase--interactive.c | 81 +++++++++++++++++++++++++++++++++--
 sequencer.c                   | 79 ++--------------------------------
 sequencer.h                   |  7 ++-
 3 files changed, 84 insertions(+), 83 deletions(-)

diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
index 370d584683..fb11f23692 100644
--- a/builtin/rebase--interactive.c
+++ b/builtin/rebase--interactive.c
@@ -13,6 +13,81 @@ static GIT_PATH_FUNC(path_state_dir, "rebase-merge/")
 static GIT_PATH_FUNC(path_squash_onto, "rebase-merge/squash-onto")
 static GIT_PATH_FUNC(path_interactive, "rebase-merge/interactive")
 
+static int add_exec_commands(struct string_list *commands)
+{
+	const char *todo_file = rebase_path_todo();
+	struct todo_list todo_list = TODO_LIST_INIT;
+	int res;
+
+	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
+		return error_errno(_("could not read '%s'."), todo_file);
+
+	if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
+					&todo_list)) {
+		todo_list_release(&todo_list);
+		return error(_("unusable todo list: '%s'"), todo_file);
+	}
+
+	todo_list_add_exec_commands(&todo_list, commands);
+	res = todo_list_write_to_file(the_repository, &todo_list,
+				      todo_file, NULL, NULL, -1, 0);
+	todo_list_release(&todo_list);
+
+	if (res)
+		return error_errno(_("could not write '%s'."), todo_file);
+	return 0;
+}
+
+static int rearrange_squash_in_todo_file(void)
+{
+	const char *todo_file = rebase_path_todo();
+	struct todo_list todo_list = TODO_LIST_INIT;
+	int res = 0;
+
+	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
+		return error_errno(_("could not read '%s'."), todo_file);
+	if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
+					&todo_list)) {
+		todo_list_release(&todo_list);
+		return error(_("unusable todo list: '%s'"), todo_file);
+	}
+
+	res = todo_list_rearrange_squash(&todo_list);
+	if (!res)
+		res = todo_list_write_to_file(the_repository, &todo_list,
+					      todo_file, NULL, NULL, -1, 0);
+
+	todo_list_release(&todo_list);
+
+	if (res)
+		return error_errno(_("could not write '%s'."), todo_file);
+	return 0;
+}
+
+static int transform_todo_file(unsigned flags)
+{
+	const char *todo_file = rebase_path_todo();
+	struct todo_list todo_list = TODO_LIST_INIT;
+	int res;
+
+	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
+		return error_errno(_("could not read '%s'."), todo_file);
+
+	if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
+					&todo_list)) {
+		todo_list_release(&todo_list);
+		return error(_("unusable todo list: '%s'"), todo_file);
+	}
+
+	res = todo_list_write_to_file(the_repository, &todo_list, todo_file,
+				      NULL, NULL, -1, flags);
+	todo_list_release(&todo_list);
+
+	if (res)
+		return error_errno(_("could not write '%s'."), todo_file);
+	return 0;
+}
+
 static int edit_todo_file(unsigned flags)
 {
 	const char *todo_file = rebase_path_todo();
@@ -276,16 +351,16 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 	}
 	case SHORTEN_OIDS:
 	case EXPAND_OIDS:
-		ret = transform_todo_file(the_repository, flags);
+		ret = transform_todo_file(flags);
 		break;
 	case CHECK_TODO_LIST:
 		ret = check_todo_list_from_file(the_repository);
 		break;
 	case REARRANGE_SQUASH:
-		ret = rearrange_squash_in_todo_file(the_repository);
+		ret = rearrange_squash_in_todo_file();
 		break;
 	case ADD_EXEC:
-		ret = sequencer_add_exec_commands(the_repository, &commands);
+		ret = add_exec_commands(&commands);
 		break;
 	default:
 		BUG("invalid command '%d'", command);
diff --git a/sequencer.c b/sequencer.c
index df8b239fdc..7d35f83f4c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4499,8 +4499,8 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
  * Add commands after pick and (series of) squash/fixup commands
  * in the todo list.
  */
-static void todo_list_add_exec_commands(struct todo_list *todo_list,
-					struct string_list *commands)
+void todo_list_add_exec_commands(struct todo_list *todo_list,
+				 struct string_list *commands)
 {
 	struct strbuf *buf = &todo_list->buf;
 	size_t base_offset = buf->len;
@@ -4559,30 +4559,6 @@ static void todo_list_add_exec_commands(struct todo_list *todo_list,
 	todo_list->alloc = alloc;
 }
 
-int sequencer_add_exec_commands(struct repository *r,
-				struct string_list *commands)
-{
-	const char *todo_file = rebase_path_todo();
-	struct todo_list todo_list = TODO_LIST_INIT;
-	int res;
-
-	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
-		return error_errno(_("could not read '%s'."), todo_file);
-
-	if (todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list)) {
-		todo_list_release(&todo_list);
-		return error(_("unusable todo list: '%s'"), todo_file);
-	}
-
-	todo_list_add_exec_commands(&todo_list, commands);
-	res = todo_list_write_to_file(r, &todo_list, todo_file, NULL, NULL, -1, 0);
-	todo_list_release(&todo_list);
-
-	if (res)
-		return error_errno(_("could not write '%s'."), todo_file);
-	return 0;
-}
-
 static void todo_list_to_strbuf(struct repository *r, struct todo_list *todo_list,
 				struct strbuf *buf, int num, unsigned flags)
 {
@@ -4649,29 +4625,6 @@ int todo_list_write_to_file(struct repository *r, struct todo_list *todo_list,
 	return res;
 }
 
-int transform_todo_file(struct repository *r, unsigned flags)
-{
-	const char *todo_file = rebase_path_todo();
-	struct todo_list todo_list = TODO_LIST_INIT;
-	int res;
-
-	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
-		return error_errno(_("could not read '%s'."), todo_file);
-
-	if (todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list)) {
-		todo_list_release(&todo_list);
-		return error(_("unusable todo list: '%s'"), todo_file);
-	}
-
-	res = todo_list_write_to_file(r, &todo_list, todo_file,
-				      NULL, NULL, -1, flags);
-	todo_list_release(&todo_list);
-
-	if (res)
-		return error_errno(_("could not write '%s'."), todo_file);
-	return 0;
-}
-
 static const char edit_todo_list_advice[] =
 N_("You can fix this with 'git rebase --edit-todo' "
 "and then run 'git rebase --continue'.\n"
@@ -4754,8 +4707,6 @@ static int skip_unnecessary_picks(struct repository *r,
 	return 0;
 }
 
-static int todo_list_rearrange_squash(struct todo_list *todo_list);
-
 int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
 		    const char *onto, const char *orig_head, struct string_list *commands,
@@ -4862,7 +4813,7 @@ define_commit_slab(commit_todo_item, struct todo_item *);
  * message will have to be retrieved from the commit (as the oneline in the
  * script cannot be trusted) in order to normalize the autosquash arrangement.
  */
-static int todo_list_rearrange_squash(struct todo_list *todo_list)
+int todo_list_rearrange_squash(struct todo_list *todo_list)
 {
 	struct hashmap subject2item;
 	int rearranged = 0, *next, *tail, i, nr = 0, alloc = 0;
@@ -5000,27 +4951,3 @@ static int todo_list_rearrange_squash(struct todo_list *todo_list)
 
 	return 0;
 }
-
-int rearrange_squash_in_todo_file(struct repository *r)
-{
-	const char *todo_file = rebase_path_todo();
-	struct todo_list todo_list = TODO_LIST_INIT;
-	int res = 0;
-
-	if (strbuf_read_file_or_whine(&todo_list.buf, todo_file) < 0)
-		return -1;
-	if (todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list) < 0) {
-		todo_list_release(&todo_list);
-		return -1;
-	}
-
-	res = todo_list_rearrange_squash(&todo_list);
-	if (!res)
-		res = todo_list_write_to_file(r, &todo_list, todo_file, NULL, NULL, -1, 0);
-
-	todo_list_release(&todo_list);
-
-	if (res)
-		return error_errno(_("could not write '%s'."), todo_file);
-	return 0;
-}
diff --git a/sequencer.h b/sequencer.h
index b0688ba2a1..7cca49eff2 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -143,15 +143,14 @@ int sequencer_remove_state(struct replay_opts *opts);
 int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
 			  const char **argv, unsigned flags);
 
-int sequencer_add_exec_commands(struct repository *r,
-				struct string_list *commands);
-int transform_todo_file(struct repository *r, unsigned flags);
+void todo_list_add_exec_commands(struct todo_list *todo_list,
+				 struct string_list *commands);
 int check_todo_list_from_file(struct repository *r);
 int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
 		    const char *onto, const char *orig_head, struct string_list *commands,
 		    unsigned autosquash, struct todo_list *todo_list);
-int rearrange_squash_in_todo_file(struct repository *r);
+int todo_list_rearrange_squash(struct todo_list *todo_list);
 
 extern const char sign_off_header[];
 
-- 
2.20.1

