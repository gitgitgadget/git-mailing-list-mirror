Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9A115AD8F
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 13:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713446089; cv=none; b=iSPW1VG4pBGYzhR+xL2VdDh1QFuxQXgLwiCXaxCv0BtGofvQvbcXTh6mTLGxlXWrgogCTHjBkfisbXnZAENM4KmqoPJvsWdAkIlbDE8/s7OQXA92cW0HMcC2KuhV7F2f9Pw42MbwgxB6YlrD2OS6+PVCs4CIqLraqgKMYPjhVtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713446089; c=relaxed/simple;
	bh=oBOUTC7ojT9s7Hxkdo0O1M3WiOe6msX6M4gzzMurSPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lur7TNwibtPMyLaOgFvQbqp5wTgirOuR65+R5WGhTJldVUno05TD6jSoAHUP/8F/ThVbw1WYfthFrV+FDAGI02JKERpAFglMH8A3qqDYY4xXduDag2bEFxirfkY5fBN/AOT+5MRrnS+5u+Ge1IzVZywT8aZ4pRZAywVPW+f5+5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzSFX7Fk; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzSFX7Fk"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-418e06c0ef4so7213105e9.0
        for <git@vger.kernel.org>; Thu, 18 Apr 2024 06:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713446085; x=1714050885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JR+k+GZgqEhcKG3byGCxmQbqHTcKkrHPcXc8jGWGxoE=;
        b=hzSFX7FkBeud1iZ1yaztG6VIDQJPw9EuURv5gV4BLTgvLeQVEuFl6KGhT82l+lEV+0
         9x2rub5PkIoD7Lh1KRVeRDChiaboly67q2qk55B2NC/+x3YlCqj/w5o/k270IHevECQd
         6+Oadx4pLbjkLmv+lOqoDypWAv+dMBg5XpN67dLJgIF+ZoX/2B/YjQQGWFlGurPheRv5
         4jhloK/0iIR0A4QALrKPPSpPX6MhA5D02t+3uUssRQwPEgnF6+wiA3C5gP704/0V0rI0
         ldYUHjR7MD397r7vz77LjTxFip3SQAt1yqAO5lBGnpdee7WYUb/npN3oB7yQuGAJO8Ll
         wdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713446085; x=1714050885;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JR+k+GZgqEhcKG3byGCxmQbqHTcKkrHPcXc8jGWGxoE=;
        b=Z4IrVOo8WLYHWwpINaq0XFP02bE+xug7gHeTYhLGX4moXh9hHTWjAdoB6HqA74J8iu
         n/TbReuQ4YZeGOlMu9fXoprpprVqQmsHFMI3ee5pQdia08YSuE06lGroTLY/swdVCYAP
         n1ER6yB5BD73+Tt+NuyISiKTK52CdAZDVbBcztXZy+qZ4ZvZ+Yxcey4Z6L2kUjIaxBEs
         q3HF9W4+a6WcWOXkZ41Edi23sZoBHBX7DxNlS9Mt4v4AW+8yEr/jHMkcLLkCGyzc1jRV
         FfnY3Wl2GAjQxco5YeFPKIq5OEsgaNeCNXjels66xNTVqNRI+Ikj99uXdfBP1AGTvm/z
         QIaQ==
X-Gm-Message-State: AOJu0YxRzyomf2jjXBYKVCik58mzi76bmiJg/4RP4g745Rg6wbhuxFz3
	U3u1/qztT3ooiTSg0t47DU11qsJ57as7W4fFBTD4Yzfcn5mrSY+0L8uL+g==
X-Google-Smtp-Source: AGHT+IEVZMoh9SJaTc4ZXDXh40MIvs5O33crpF9H9f3gl5bGrklC6ZSpnKCEUVMirIW8WzEa6Ucjcg==
X-Received: by 2002:a05:600c:4f0e:b0:418:37e1:3f73 with SMTP id l14-20020a05600c4f0e00b0041837e13f73mr2670674wmq.2.1713446085328;
        Thu, 18 Apr 2024 06:14:45 -0700 (PDT)
Received: from localhost.localdomain ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id r14-20020a05600c458e00b00417e5b71188sm2682748wmo.34.2024.04.18.06.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 06:14:44 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: David Bimmler <david.bimmler@isovalent.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 3/5] sequencer: move current fixups to private context
Date: Thu, 18 Apr 2024 14:14:07 +0100
Message-ID: <2e4a2168733cb226a6fd660cb0d0bd700a1e7d86.1713445918.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.44.0.661.ge68cfcc6c2f
In-Reply-To: <cover.1713445918.git.phillip.wood@dunelm.org.uk>
References: <cover.1713445918.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The list of current fixups is an implementation detail of the sequencer
and so it should not be stored in the public options struct.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 89 ++++++++++++++++++++++++++++++++++-------------------
 sequencer.h |  5 ---
 2 files changed, 57 insertions(+), 37 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 6ddf6a8aa1e..edc49c94cce 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -211,17 +211,29 @@ static GIT_PATH_FUNC(rebase_path_keep_redundant_commits, "rebase-merge/keep_redu
  * A 'struct replay_ctx' represents the private state of the sequencer.
  */
 struct replay_ctx {
+	/*
+	 * The list of completed fixup and squash commands in the
+	 * current chain.
+	 */
+	struct strbuf current_fixups;
 	/*
 	 * Stores the reflog message that will be used when creating a
 	 * commit. Points to a static buffer and should not be free()'d.
 	 */
 	const char *reflog_message;
+	/*
+	 * The number of completed fixup and squash commands in the
+	 * current chain.
+	 */
+	int current_fixup_count;
 };
 
 struct replay_ctx* replay_ctx_new(void)
 {
 	struct replay_ctx *ctx = xcalloc(1, sizeof(*ctx));
 
+	strbuf_init(&ctx->current_fixups, 0);
+
 	return ctx;
 }
 
@@ -384,17 +396,24 @@ static const char *gpg_sign_opt_quoted(struct replay_opts *opts)
 	return buf.buf;
 }
 
+static void replay_ctx_release(struct replay_ctx *ctx)
+{
+	strbuf_release(&ctx->current_fixups);
+}
+
 void replay_opts_release(struct replay_opts *opts)
 {
+	struct replay_ctx *ctx = opts->ctx;
+
 	free(opts->gpg_sign);
 	free(opts->reflog_action);
 	free(opts->default_strategy);
 	free(opts->strategy);
 	strvec_clear (&opts->xopts);
-	strbuf_release(&opts->current_fixups);
 	if (opts->revs)
 		release_revisions(opts->revs);
 	free(opts->revs);
+	replay_ctx_release(ctx);
 	free(opts->ctx);
 }
 
@@ -1876,10 +1895,10 @@ static void add_commented_lines(struct strbuf *buf, const void *str, size_t len)
 }
 
 /* Does the current fixup chain contain a squash command? */
-static int seen_squash(struct replay_opts *opts)
+static int seen_squash(struct replay_ctx *ctx)
 {
-	return starts_with(opts->current_fixups.buf, "squash") ||
-		strstr(opts->current_fixups.buf, "\nsquash");
+	return starts_with(ctx->current_fixups.buf, "squash") ||
+		strstr(ctx->current_fixups.buf, "\nsquash");
 }
 
 static void update_comment_bufs(struct strbuf *buf1, struct strbuf *buf2, int n)
@@ -1955,6 +1974,7 @@ static int append_squash_message(struct strbuf *buf, const char *body,
 			 enum todo_command command, struct replay_opts *opts,
 			 unsigned flag)
 {
+	struct replay_ctx *ctx = opts->ctx;
 	const char *fixup_msg;
 	size_t commented_len = 0, fixup_off;
 	/*
@@ -1963,21 +1983,21 @@ static int append_squash_message(struct strbuf *buf, const char *body,
 	 * squashing commit messages.
 	 */
 	if (starts_with(body, "amend!") ||
-	    ((command == TODO_SQUASH || seen_squash(opts)) &&
+	    ((command == TODO_SQUASH || seen_squash(ctx)) &&
 	     (starts_with(body, "squash!") || starts_with(body, "fixup!"))))
 		commented_len = commit_subject_length(body);
 
 	strbuf_addf(buf, "\n%c ", comment_line_char);
 	strbuf_addf(buf, _(nth_commit_msg_fmt),
-		    ++opts->current_fixup_count + 1);
+		    ++ctx->current_fixup_count + 1);
 	strbuf_addstr(buf, "\n\n");
 	strbuf_add_commented_lines(buf, body, commented_len, comment_line_char);
 	/* buf->buf may be reallocated so store an offset into the buffer */
 	fixup_off = buf->len;
 	strbuf_addstr(buf, body + commented_len);
 
 	/* fixup -C after squash behaves like squash */
-	if (is_fixup_flag(command, flag) && !seen_squash(opts)) {
+	if (is_fixup_flag(command, flag) && !seen_squash(ctx)) {
 		/*
 		 * We're replacing the commit message so we need to
 		 * append the Signed-off-by: trailer if the user
@@ -2011,12 +2031,13 @@ static int update_squash_messages(struct repository *r,
 				  struct replay_opts *opts,
 				  unsigned flag)
 {
+	struct replay_ctx *ctx = opts->ctx;
 	struct strbuf buf = STRBUF_INIT;
 	int res = 0;
 	const char *message, *body;
 	const char *encoding = get_commit_output_encoding();
 
-	if (opts->current_fixup_count > 0) {
+	if (ctx->current_fixup_count > 0) {
 		struct strbuf header = STRBUF_INIT;
 		char *eol;
 
@@ -2029,10 +2050,10 @@ static int update_squash_messages(struct repository *r,
 
 		strbuf_addf(&header, "%c ", comment_line_char);
 		strbuf_addf(&header, _(combined_commit_msg_fmt),
-			    opts->current_fixup_count + 2);
+			    ctx->current_fixup_count + 2);
 		strbuf_splice(&buf, 0, eol - buf.buf, header.buf, header.len);
 		strbuf_release(&header);
-		if (is_fixup_flag(command, flag) && !seen_squash(opts))
+		if (is_fixup_flag(command, flag) && !seen_squash(ctx))
 			update_squash_message_for_fixup(&buf);
 	} else {
 		struct object_id head;
@@ -2079,7 +2100,7 @@ static int update_squash_messages(struct repository *r,
 	} else if (command == TODO_FIXUP) {
 		strbuf_addf(&buf, "\n%c ", comment_line_char);
 		strbuf_addf(&buf, _(skip_nth_commit_msg_fmt),
-			    ++opts->current_fixup_count + 1);
+			    ++ctx->current_fixup_count + 1);
 		strbuf_addstr(&buf, "\n\n");
 		strbuf_add_commented_lines(&buf, body, strlen(body),
 					   comment_line_char);
@@ -2093,12 +2114,12 @@ static int update_squash_messages(struct repository *r,
 	strbuf_release(&buf);
 
 	if (!res) {
-		strbuf_addf(&opts->current_fixups, "%s%s %s",
-			    opts->current_fixups.len ? "\n" : "",
+		strbuf_addf(&ctx->current_fixups, "%s%s %s",
+			    ctx->current_fixups.len ? "\n" : "",
 			    command_to_string(command),
 			    oid_to_hex(&commit->object.oid));
-		res = write_message(opts->current_fixups.buf,
-				    opts->current_fixups.len,
+		res = write_message(ctx->current_fixups.buf,
+				    ctx->current_fixups.len,
 				    rebase_path_current_fixups(), 0);
 	}
 
@@ -2176,6 +2197,7 @@ static int do_pick_commit(struct repository *r,
 			  struct replay_opts *opts,
 			  int final_fixup, int *check_todo)
 {
+	struct replay_ctx *ctx = opts->ctx;
 	unsigned int flags = should_edit(opts) ? EDIT_MSG : 0;
 	const char *msg_file = should_edit(opts) ? NULL : git_path_merge_msg(r);
 	struct object_id head;
@@ -2456,8 +2478,8 @@ static int do_pick_commit(struct repository *r,
 		unlink(rebase_path_fixup_msg());
 		unlink(rebase_path_squash_msg());
 		unlink(rebase_path_current_fixups());
-		strbuf_reset(&opts->current_fixups);
-		opts->current_fixup_count = 0;
+		strbuf_reset(&ctx->current_fixups);
+		ctx->current_fixup_count = 0;
 	}
 
 leave:
@@ -3019,6 +3041,8 @@ static void read_strategy_opts(struct replay_opts *opts, struct strbuf *buf)
 
 static int read_populate_opts(struct replay_opts *opts)
 {
+	struct replay_ctx *ctx = opts->ctx;
+
 	if (is_rebase_i(opts)) {
 		struct strbuf buf = STRBUF_INIT;
 		int ret = 0;
@@ -3078,13 +3102,13 @@ static int read_populate_opts(struct replay_opts *opts)
 		read_strategy_opts(opts, &buf);
 		strbuf_reset(&buf);
 
-		if (read_oneliner(&opts->current_fixups,
+		if (read_oneliner(&ctx->current_fixups,
 				  rebase_path_current_fixups(),
 				  READ_ONELINER_SKIP_IF_EMPTY)) {
-			const char *p = opts->current_fixups.buf;
-			opts->current_fixup_count = 1;
+			const char *p = ctx->current_fixups.buf;
+			ctx->current_fixup_count = 1;
 			while ((p = strchr(p, '\n'))) {
-				opts->current_fixup_count++;
+				ctx->current_fixup_count++;
 				p++;
 			}
 		}
@@ -5066,6 +5090,7 @@ static int commit_staged_changes(struct repository *r,
 				 struct replay_opts *opts,
 				 struct todo_list *todo_list)
 {
+	struct replay_ctx *ctx = opts->ctx;
 	unsigned int flags = ALLOW_EMPTY | EDIT_MSG;
 	unsigned int final_fixup = 0, is_clean;
 
@@ -5102,7 +5127,7 @@ static int commit_staged_changes(struct repository *r,
 		 * the commit message and if there was a squash, let the user
 		 * edit it.
 		 */
-		if (!is_clean || !opts->current_fixup_count)
+		if (!is_clean || !ctx->current_fixup_count)
 			; /* this is not the final fixup */
 		else if (!oideq(&head, &to_amend) ||
 			 !file_exists(rebase_path_stopped_sha())) {
@@ -5111,20 +5136,20 @@ static int commit_staged_changes(struct repository *r,
 				unlink(rebase_path_fixup_msg());
 				unlink(rebase_path_squash_msg());
 				unlink(rebase_path_current_fixups());
-				strbuf_reset(&opts->current_fixups);
-				opts->current_fixup_count = 0;
+				strbuf_reset(&ctx->current_fixups);
+				ctx->current_fixup_count = 0;
 			}
 		} else {
 			/* we are in a fixup/squash chain */
-			const char *p = opts->current_fixups.buf;
-			int len = opts->current_fixups.len;
+			const char *p = ctx->current_fixups.buf;
+			int len = ctx->current_fixups.len;
 
-			opts->current_fixup_count--;
+			ctx->current_fixup_count--;
 			if (!len)
 				BUG("Incorrect current_fixups:\n%s", p);
 			while (len && p[len - 1] != '\n')
 				len--;
-			strbuf_setlen(&opts->current_fixups, len);
+			strbuf_setlen(&ctx->current_fixups, len);
 			if (write_message(p, len, rebase_path_current_fixups(),
 					  0) < 0)
 				return error(_("could not write file: '%s'"),
@@ -5141,7 +5166,7 @@ static int commit_staged_changes(struct repository *r,
 			 * actually need to re-commit with a cleaned up commit
 			 * message.
 			 */
-			if (opts->current_fixup_count > 0 &&
+			if (ctx->current_fixup_count > 0 &&
 			    !is_fixup(peek_command(todo_list, 0))) {
 				final_fixup = 1;
 				/*
@@ -5214,14 +5239,14 @@ static int commit_staged_changes(struct repository *r,
 		unlink(rebase_path_fixup_msg());
 		unlink(rebase_path_squash_msg());
 	}
-	if (opts->current_fixup_count > 0) {
+	if (ctx->current_fixup_count > 0) {
 		/*
 		 * Whether final fixup or not, we just cleaned up the commit
 		 * message...
 		 */
 		unlink(rebase_path_current_fixups());
-		strbuf_reset(&opts->current_fixups);
-		opts->current_fixup_count = 0;
+		strbuf_reset(&ctx->current_fixups);
+		ctx->current_fixup_count = 0;
 	}
 	return 0;
 }
diff --git a/sequencer.h b/sequencer.h
index 069f06400d2..c15b9a64020 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -69,10 +69,6 @@ struct replay_opts {
 	/* Reflog */
 	char *reflog_action;
 
-	/* Used by fixup/squash */
-	struct strbuf current_fixups;
-	int current_fixup_count;
-
 	/* placeholder commit for -i --root */
 	struct object_id squash_onto;
 	int have_squash_onto;
@@ -86,7 +82,6 @@ struct replay_opts {
 #define REPLAY_OPTS_INIT {			\
 	.edit = -1,				\
 	.action = -1,				\
-	.current_fixups = STRBUF_INIT,		\
 	.xopts = STRVEC_INIT,			\
 	.ctx = replay_ctx_new(),		\
 }
-- 
2.44.0.661.ge68cfcc6c2f

