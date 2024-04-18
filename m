Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C331487F0
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 13:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713446088; cv=none; b=JObYJ0C9LHf4xoZM9zWt1cEr3b5b+EG6QLitAKOIr5STIoej4rEtOJ22KvhoYajGZnu7gEUV0XoBWWgIXpgaAVmmIkHBBpELbVAP08KBgbd30GxdMHq8SChQBpic+xGQZucbnC+o/VmPp9nxN1v5IWL3fSJpV9eel5gxDPQ8KB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713446088; c=relaxed/simple;
	bh=ZupEspvFSPdBw/p5dB8kVHRIAA14bnuwtAkakFFU5QA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VeNohjtgi+Rz0vGfKP2NMU4A0NPD/pjC4+m1ynzTYI2FjGHQh1rbmXsrESLctsfeN4loGxx14atX8MaA6xxh7Rj9g6wtowRWkhopa4ZDV8wMqYuILbM+E4hU7uqwMQpeQggvhrBI7Hn7tb4jj8KN+2zCKGzvxC5xvJUkZYplK2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5mxC883; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5mxC883"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-418c979ddf3so6770005e9.0
        for <git@vger.kernel.org>; Thu, 18 Apr 2024 06:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713446084; x=1714050884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EAVZcYnHNHgcvHTQdiwfcnCFvp3HBvn67/bgcx1K/QQ=;
        b=G5mxC883pnj7NKwSfyv7VKp9DacENSGrLlFR0w6lQDmRWnm6Zc3bb3TVOsFVY9yBzl
         0FhkM+lsgtdwXlZ1Ew3zQuYuAhHpgKtb+9skDfHqncwHi9r3v79RDyk2lwIGALWOaX+y
         CFvy3B53jdNROeM2mmZlXls8O6rezxtI0UBrrHzdPoFfooRQ4t2wFPPkNd9MSe6ZYOLy
         ZIOIwL6dQrDYzNkR8l4pAGSrEYdthqJrq3hBjQVlArtnAkjF10xD3i6IVBYfax1S423N
         x5N9HoEF+tK4SOkZOkan90MtO+0KpL+TPghfE9S5Q/fL258USnzKtVzDgxAgUaYJ/rYh
         Jw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713446084; x=1714050884;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EAVZcYnHNHgcvHTQdiwfcnCFvp3HBvn67/bgcx1K/QQ=;
        b=bDuk6hDcemx4VVBuMEk4ZKsr9Fumz534itfEV6pJt45hnUT9RtxARqVkiBEIIDpbr+
         /oYXlouxZB3Hh2wIWv+/pOEmkIY0zfmUVLSPG/wC57dsyXMURBDoOLVncQoukt1y8Kxg
         1rAdNty8ApJfhBm/GNTbeuuJu0/Q0GPwK2XlSdyjx5VtGtWoYi8GRnA1gkhLcXZiv0J6
         CydETCWYFOaBnUfKvtPi/Ig7GbJzmhPbGSWVGugfy8lXdPH335OdTtS/VKD0LNUr/fbM
         VzfLgzAFAWto5FFz332E9ouGr1limxj3bEAJq/q52m+zD5pwrCYjL4mPT4CWhq9n0d5U
         9Bnw==
X-Gm-Message-State: AOJu0YyekZ3WD3NYU+erTfhHIiTICFB0xjkJHCoJRHa87oMMY6dDeYQK
	MTSk4tYfQOUvJn/qLUn32WIype8cry4kNRRQrN14Oeq5lbHJQX5vnIUmNA==
X-Google-Smtp-Source: AGHT+IGWinfRs196eB/J+Rg0XKFrp8ZwVlxhoft+2DmmrEhDibboLEwtmxW3EYTz2KAVhTp0QxW1Yw==
X-Received: by 2002:a05:600c:4587:b0:418:7451:a385 with SMTP id r7-20020a05600c458700b004187451a385mr1810111wmo.40.1713446083609;
        Thu, 18 Apr 2024 06:14:43 -0700 (PDT)
Received: from localhost.localdomain ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id r14-20020a05600c458e00b00417e5b71188sm2682748wmo.34.2024.04.18.06.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 06:14:43 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: David Bimmler <david.bimmler@isovalent.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 2/5] sequencer: start removing private fields from public API
Date: Thu, 18 Apr 2024 14:14:06 +0100
Message-ID: <2beedb4547013629a507d646d582ca6b3f420c2c.1713445918.git.phillip.wood@dunelm.org.uk>
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

"struct replay_opts" has a number of fields that are for internal
use. While they are marked as private having them in a public struct is
a distraction for callers and means that every time the internal details
are changed we have to recompile all the files that include sequencer.h
even though the public API is unchanged. This commit starts the process
of removing the private fields by adding an opaque pointer to a "struct
replay_ctx" to "struct replay_opts" and moving the "reflog_message"
member to the new private struct.

The sequencer currently updates the state files on disc each time it
processes a command in the todo list. This is an artifact of the
scripted implementation and makes the code hard to reason about as it is
not possible to get a complete view of the state in memory. In the
future we will add new members to "struct replay_ctx" to remedy this and
avoid writing state to disc unless the sequencer stops for user
interaction.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 36 ++++++++++++++++++++++++++++++------
 sequencer.h |  6 +++++-
 2 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index e4146b4cdfa..6ddf6a8aa1e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -207,6 +207,24 @@ static GIT_PATH_FUNC(rebase_path_no_reschedule_failed_exec, "rebase-merge/no-res
 static GIT_PATH_FUNC(rebase_path_drop_redundant_commits, "rebase-merge/drop_redundant_commits")
 static GIT_PATH_FUNC(rebase_path_keep_redundant_commits, "rebase-merge/keep_redundant_commits")
 
+/*
+ * A 'struct replay_ctx' represents the private state of the sequencer.
+ */
+struct replay_ctx {
+	/*
+	 * Stores the reflog message that will be used when creating a
+	 * commit. Points to a static buffer and should not be free()'d.
+	 */
+	const char *reflog_message;
+};
+
+struct replay_ctx* replay_ctx_new(void)
+{
+	struct replay_ctx *ctx = xcalloc(1, sizeof(*ctx));
+
+	return ctx;
+}
+
 /**
  * A 'struct update_refs_record' represents a value in the update-refs
  * list. We use a string_list to map refs to these (before, after) pairs.
@@ -377,6 +395,7 @@ void replay_opts_release(struct replay_opts *opts)
 	if (opts->revs)
 		release_revisions(opts->revs);
 	free(opts->revs);
+	free(opts->ctx);
 }
 
 int sequencer_remove_state(struct replay_opts *opts)
@@ -1054,6 +1073,7 @@ static int run_git_commit(const char *defmsg,
 			  struct replay_opts *opts,
 			  unsigned int flags)
 {
+	struct replay_ctx *ctx = opts->ctx;
 	struct child_process cmd = CHILD_PROCESS_INIT;
 
 	if ((flags & CLEANUP_MSG) && (flags & VERBATIM_MSG))
@@ -1071,7 +1091,7 @@ static int run_git_commit(const char *defmsg,
 			     gpg_opt, gpg_opt);
 	}
 
-	strvec_pushf(&cmd.env, GIT_REFLOG_ACTION "=%s", opts->reflog_message);
+	strvec_pushf(&cmd.env, GIT_REFLOG_ACTION "=%s", ctx->reflog_message);
 
 	if (opts->committer_date_is_author_date)
 		strvec_pushf(&cmd.env, "GIT_COMMITTER_DATE=%s",
@@ -1457,6 +1477,7 @@ static int try_to_commit(struct repository *r,
 			 struct replay_opts *opts, unsigned int flags,
 			 struct object_id *oid)
 {
+	struct replay_ctx *ctx = opts->ctx;
 	struct object_id tree;
 	struct commit *current_head = NULL;
 	struct commit_list *parents = NULL;
@@ -1618,7 +1639,7 @@ static int try_to_commit(struct repository *r,
 		goto out;
 	}
 
-	if (update_head_with_reflog(current_head, oid, opts->reflog_message,
+	if (update_head_with_reflog(current_head, oid, ctx->reflog_message,
 				    msg, &err)) {
 		res = error("%s", err.buf);
 		goto out;
@@ -4725,11 +4746,12 @@ static int pick_one_commit(struct repository *r,
 			   struct replay_opts *opts,
 			   int *check_todo, int* reschedule)
 {
+	struct replay_ctx *ctx = opts->ctx;
 	int res;
 	struct todo_item *item = todo_list->items + todo_list->current;
 	const char *arg = todo_item_get_arg(todo_list, item);
 	if (is_rebase_i(opts))
-		opts->reflog_message = reflog_message(
+		ctx->reflog_message = reflog_message(
 			opts, command_to_string(item->command), NULL);
 
 	res = do_pick_commit(r, item, opts, is_final_fixup(todo_list),
@@ -4786,9 +4808,10 @@ static int pick_commits(struct repository *r,
 			struct todo_list *todo_list,
 			struct replay_opts *opts)
 {
+	struct replay_ctx *ctx = opts->ctx;
 	int res = 0, reschedule = 0;
 
-	opts->reflog_message = sequencer_reflog_action(opts);
+	ctx->reflog_message = sequencer_reflog_action(opts);
 	if (opts->allow_ff)
 		assert(!(opts->signoff || opts->no_commit ||
 			 opts->record_origin || should_edit(opts) ||
@@ -5205,6 +5228,7 @@ static int commit_staged_changes(struct repository *r,
 
 int sequencer_continue(struct repository *r, struct replay_opts *opts)
 {
+	struct replay_ctx *ctx = opts->ctx;
 	struct todo_list todo_list = TODO_LIST_INIT;
 	int res;
 
@@ -5224,7 +5248,7 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
 			unlink(rebase_path_dropped());
 		}
 
-		opts->reflog_message = reflog_message(opts, "continue", NULL);
+		ctx->reflog_message = reflog_message(opts, "continue", NULL);
 		if (commit_staged_changes(r, opts, &todo_list)) {
 			res = -1;
 			goto release_todo_list;
@@ -5276,7 +5300,7 @@ static int single_pick(struct repository *r,
 			TODO_PICK : TODO_REVERT;
 	item.commit = cmit;
 
-	opts->reflog_message = sequencer_reflog_action(opts);
+	opts->ctx->reflog_message = sequencer_reflog_action(opts);
 	return do_pick_commit(r, &item, opts, 0, &check_todo);
 }
 
diff --git a/sequencer.h b/sequencer.h
index dcef7bb99c0..069f06400d2 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -29,6 +29,9 @@ enum commit_msg_cleanup_mode {
 	COMMIT_MSG_CLEANUP_ALL
 };
 
+struct replay_ctx;
+struct replay_ctx* replay_ctx_new(void);
+
 struct replay_opts {
 	enum replay_action action;
 
@@ -78,13 +81,14 @@ struct replay_opts {
 	struct rev_info *revs;
 
 	/* Private use */
-	const char *reflog_message;
+	struct replay_ctx *ctx;
 };
 #define REPLAY_OPTS_INIT {			\
 	.edit = -1,				\
 	.action = -1,				\
 	.current_fixups = STRBUF_INIT,		\
 	.xopts = STRVEC_INIT,			\
+	.ctx = replay_ctx_new(),		\
 }
 
 /*
-- 
2.44.0.661.ge68cfcc6c2f

