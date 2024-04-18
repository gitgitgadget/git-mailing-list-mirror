Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD8F15D5BE
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 13:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713446089; cv=none; b=gCfUvgx1rXzCiz00ZNhI0cKR7wh+WFvKZ5oC1w+e6yOMfwBIidakXziSFJSQkNRauIhKojdrOneR5pYXDa9YItqxm1zVlqR06fO/HpXaXrS0UAvkvdOq8cibKvxGlD99uRs9axnGJ2btGJdUmCuSBbFL6AzXUqQput08HbHO7Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713446089; c=relaxed/simple;
	bh=55U2Hjj8HfkmHHjtt7utIolZ0dKAQqp7OiLgq4W7wN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XpAJTmlUkm/PzJxs2lXSXvFKSKkiZ5gchZanMndTNoI1Evo7sYqLIplY1NG+VUOi3s6+xrVHIZmbw0Q1rAQRR2/gmS8qfT/yY5OJzM6FeHcFKaCSn1evhQl//qBB6gw+CHlhYn7YKyGlTAxpwjWu4o596UF1YluyFK6l3/ElS+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQW4TETm; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQW4TETm"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-418c2bf2f90so5083915e9.1
        for <git@vger.kernel.org>; Thu, 18 Apr 2024 06:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713446086; x=1714050886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1AzTNEc8LT6OXfXlafBYZVhSfw0BtXBFIBWbBfJS+zg=;
        b=JQW4TETmL1prwWsAlNy+JndzzDyL2EyJahQWjwlDTri1SzwVDwmrDvcbU9f7DiFtjn
         4QshFb0Eq/DzwSm5Ioeb0kQYZreFFGEOZp5vtaZHqZekkdidWTQK4prwpl0PGIs0YcEU
         dQM1FyvnQ1rhMjtszpcEWx6nU0/YkIP1qh1gzhFb8xTK/IPhxB22biMZL4cjXu85Z3cs
         2O6+9k3AOmryIc7AXQD6MF8J+WmoQfCxiWDOOZLV7wUoivIBc1Q0lJulhdO5zVbJ/qgW
         pz+Gv+BofjcrG2QA6oIjoY4/I3W+IAKYl6oR4iJeOPxPA+db5DQUdqBgmDPuJzPbhY++
         rPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713446086; x=1714050886;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1AzTNEc8LT6OXfXlafBYZVhSfw0BtXBFIBWbBfJS+zg=;
        b=FmkpJxqnkg6Cdr/d/X6wJ7/Mxbycogl4NNg1WeHUb2XpKtXS88sNwu4awOa5XVQLEI
         +T6zds1gr8LvGdldu9KWLkUdBb13Yu1dR7/9FsFfhniUPMAzXQrJARuJ/Dj2oYxGxulB
         SuZDnpLgL5PBZl9wvq/O33RjwVwaI5gnAA0eCIwEzyk8/Ks1E0OBRf1wOFoEJHWbd3Xo
         dnUxqPAS6ZA/A4VApsvryagL4lZOe+RnoQVlx/+IDJoU11zKNrCZCHI0BWackWM6dVjh
         d2BF2gPeEI5J6ZlonYOOp3s2CktXltbQZImizxw02yHgovlnDJgYC/pxJKlPop/OIavl
         ZwmQ==
X-Gm-Message-State: AOJu0YxFPbwZKkAKoNTCHd53beLeIKZYFl9vyYYRDwSHLtE2IJaD1NMn
	xLeiQxOg8x7sbWWBkoTaM+9PhwiZTPxBU9lTcNk6pOTdOWFVaTvsSXtBpQ==
X-Google-Smtp-Source: AGHT+IFfvjKDsGj7ebLFX/9FCI3B9x2ZDpwW6+X+h8rGxDcR8eqHM2xKfcfgXqQf7icVwVm7j9xjpg==
X-Received: by 2002:a05:600c:4447:b0:418:2ab6:7123 with SMTP id v7-20020a05600c444700b004182ab67123mr1917149wmn.10.1713446085909;
        Thu, 18 Apr 2024 06:14:45 -0700 (PDT)
Received: from localhost.localdomain ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id r14-20020a05600c458e00b00417e5b71188sm2682748wmo.34.2024.04.18.06.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 06:14:45 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: David Bimmler <david.bimmler@isovalent.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 4/5] sequencer: store commit message in private context
Date: Thu, 18 Apr 2024 14:14:08 +0100
Message-ID: <fcef79ede656ba8e6dcd153e115095c123e0f05d.1713445918.git.phillip.wood@dunelm.org.uk>
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

Add an strbuf to "struct replay_ctx" to hold the current commit
message. This does not change the behavior but it will allow us to fix a
bug with "git rebase --signoff" in the next commit. A future patch
series will use the changes here to avoid writing the commit message to
disc unless there are conflicts or the commit is being reworded.

The changes in do_pick_commit() are a mechanical replacement of "msgbuf"
with "ctx->message". In do_merge() the code to write commit message to
disc is factored out of the conditional now that both branches store the
message in the same buffer.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 96 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 50 insertions(+), 46 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index edc49c94cce..31e4d3fdec0 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -211,6 +211,11 @@ static GIT_PATH_FUNC(rebase_path_keep_redundant_commits, "rebase-merge/keep_redu
  * A 'struct replay_ctx' represents the private state of the sequencer.
  */
 struct replay_ctx {
+	/*
+	 * The commit message that will be used except at the end of a
+	 * chain of fixup and squash commands.
+	 */
+	struct strbuf message;
 	/*
 	 * The list of completed fixup and squash commands in the
 	 * current chain.
@@ -226,13 +231,18 @@ struct replay_ctx {
 	 * current chain.
 	 */
 	int current_fixup_count;
+	/*
+	 * Whether message contains a commit message.
+	 */
+	unsigned have_message :1;
 };
 
 struct replay_ctx* replay_ctx_new(void)
 {
 	struct replay_ctx *ctx = xcalloc(1, sizeof(*ctx));
 
 	strbuf_init(&ctx->current_fixups, 0);
+	strbuf_init(&ctx->message, 0);
 
 	return ctx;
 }
@@ -399,6 +409,7 @@ static const char *gpg_sign_opt_quoted(struct replay_opts *opts)
 static void replay_ctx_release(struct replay_ctx *ctx)
 {
 	strbuf_release(&ctx->current_fixups);
+	strbuf_release(&ctx->message);
 }
 
 void replay_opts_release(struct replay_opts *opts)
@@ -2205,7 +2216,6 @@ static int do_pick_commit(struct repository *r,
 	const char *base_label, *next_label;
 	char *author = NULL;
 	struct commit_message msg = { NULL, NULL, NULL, NULL };
-	struct strbuf msgbuf = STRBUF_INIT;
 	int res, unborn = 0, reword = 0, allow, drop_commit;
 	enum todo_command command = item->command;
 	struct commit *commit = item->commit;
@@ -2304,7 +2314,7 @@ static int do_pick_commit(struct repository *r,
 		next = parent;
 		next_label = msg.parent_label;
 		if (opts->commit_use_reference) {
-			strbuf_addstr(&msgbuf,
+			strbuf_addstr(&ctx->message,
 				"# *** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
 		} else if (skip_prefix(msg.subject, "Revert \"", &orig_subject) &&
 			   /*
@@ -2313,21 +2323,21 @@ static int do_pick_commit(struct repository *r,
 			    * thus requiring excessive complexity to deal with.
 			    */
 			   !starts_with(orig_subject, "Revert \"")) {
-			strbuf_addstr(&msgbuf, "Reapply \"");
-			strbuf_addstr(&msgbuf, orig_subject);
+			strbuf_addstr(&ctx->message, "Reapply \"");
+			strbuf_addstr(&ctx->message, orig_subject);
 		} else {
-			strbuf_addstr(&msgbuf, "Revert \"");
-			strbuf_addstr(&msgbuf, msg.subject);
-			strbuf_addstr(&msgbuf, "\"");
+			strbuf_addstr(&ctx->message, "Revert \"");
+			strbuf_addstr(&ctx->message, msg.subject);
+			strbuf_addstr(&ctx->message, "\"");
 		}
-		strbuf_addstr(&msgbuf, "\n\nThis reverts commit ");
-		refer_to_commit(opts, &msgbuf, commit);
+		strbuf_addstr(&ctx->message, "\n\nThis reverts commit ");
+		refer_to_commit(opts, &ctx->message, commit);
 
 		if (commit->parents && commit->parents->next) {
-			strbuf_addstr(&msgbuf, ", reversing\nchanges made to ");
-			refer_to_commit(opts, &msgbuf, parent);
+			strbuf_addstr(&ctx->message, ", reversing\nchanges made to ");
+			refer_to_commit(opts, &ctx->message, parent);
 		}
-		strbuf_addstr(&msgbuf, ".\n");
+		strbuf_addstr(&ctx->message, ".\n");
 	} else {
 		const char *p;
 
@@ -2336,21 +2346,22 @@ static int do_pick_commit(struct repository *r,
 		next = commit;
 		next_label = msg.label;
 
-		/* Append the commit log message to msgbuf. */
+		/* Append the commit log message to ctx->message. */
 		if (find_commit_subject(msg.message, &p))
-			strbuf_addstr(&msgbuf, p);
+			strbuf_addstr(&ctx->message, p);
 
 		if (opts->record_origin) {
-			strbuf_complete_line(&msgbuf);
-			if (!has_conforming_footer(&msgbuf, NULL, 0))
-				strbuf_addch(&msgbuf, '\n');
-			strbuf_addstr(&msgbuf, cherry_picked_prefix);
-			strbuf_addstr(&msgbuf, oid_to_hex(&commit->object.oid));
-			strbuf_addstr(&msgbuf, ")\n");
+			strbuf_complete_line(&ctx->message);
+			if (!has_conforming_footer(&ctx->message, NULL, 0))
+				strbuf_addch(&ctx->message, '\n');
+			strbuf_addstr(&ctx->message, cherry_picked_prefix);
+			strbuf_addstr(&ctx->message, oid_to_hex(&commit->object.oid));
+			strbuf_addstr(&ctx->message, ")\n");
 		}
 		if (!is_fixup(command))
 			author = get_author(msg.message);
 	}
+	ctx->have_message = 1;
 
 	if (command == TODO_REWORD)
 		reword = 1;
@@ -2381,7 +2392,7 @@ static int do_pick_commit(struct repository *r,
 	}
 
 	if (opts->signoff && !is_fixup(command))
-		append_signoff(&msgbuf, 0, 0);
+		append_signoff(&ctx->message, 0, 0);
 
 	if (is_rebase_i(opts) && write_author_script(msg.message) < 0)
 		res = -1;
@@ -2390,17 +2401,17 @@ static int do_pick_commit(struct repository *r,
 		 !strcmp(opts->strategy, "ort") ||
 		 command == TODO_REVERT) {
 		res = do_recursive_merge(r, base, next, base_label, next_label,
-					 &head, &msgbuf, opts);
+					 &head, &ctx->message, opts);
 		if (res < 0)
 			goto leave;
 
-		res |= write_message(msgbuf.buf, msgbuf.len,
+		res |= write_message(ctx->message.buf, ctx->message.len,
 				     git_path_merge_msg(r), 0);
 	} else {
 		struct commit_list *common = NULL;
 		struct commit_list *remotes = NULL;
 
-		res = write_message(msgbuf.buf, msgbuf.len,
+		res = write_message(ctx->message.buf, ctx->message.len,
 				    git_path_merge_msg(r), 0);
 
 		commit_list_insert(base, &common);
@@ -2485,7 +2496,6 @@ static int do_pick_commit(struct repository *r,
 leave:
 	free_message(commit, &msg);
 	free(author);
-	strbuf_release(&msgbuf);
 	update_abort_safety_file();
 
 	return res;
@@ -3952,6 +3962,7 @@ static int do_merge(struct repository *r,
 		    const char *arg, int arg_len,
 		    int flags, int *check_todo, struct replay_opts *opts)
 {
+	struct replay_ctx *ctx = opts->ctx;
 	int run_commit_flags = 0;
 	struct strbuf ref_name = STRBUF_INIT;
 	struct commit *head_commit, *merge_commit, *i;
@@ -4080,40 +4091,31 @@ static int do_merge(struct repository *r,
 		write_author_script(message);
 		find_commit_subject(message, &body);
 		len = strlen(body);
-		ret = write_message(body, len, git_path_merge_msg(r), 0);
+		strbuf_add(&ctx->message, body, len);
 		repo_unuse_commit_buffer(r, commit, message);
-		if (ret) {
-			error_errno(_("could not write '%s'"),
-				    git_path_merge_msg(r));
-			goto leave_merge;
-		}
 	} else {
 		struct strbuf buf = STRBUF_INIT;
-		int len;
 
 		strbuf_addf(&buf, "author %s", git_author_info(0));
 		write_author_script(buf.buf);
-		strbuf_reset(&buf);
+		strbuf_release(&buf);
 
 		if (oneline_offset < arg_len) {
-			p = arg + oneline_offset;
-			len = arg_len - oneline_offset;
+			strbuf_add(&ctx->message, arg + oneline_offset,
+				   arg_len - oneline_offset);
 		} else {
-			strbuf_addf(&buf, "Merge %s '%.*s'",
+			strbuf_addf(&ctx->message, "Merge %s '%.*s'",
 				    to_merge->next ? "branches" : "branch",
 				    merge_arg_len, arg);
-			p = buf.buf;
-			len = buf.len;
-		}
-
-		ret = write_message(p, len, git_path_merge_msg(r), 0);
-		strbuf_release(&buf);
-		if (ret) {
-			error_errno(_("could not write '%s'"),
-				    git_path_merge_msg(r));
-			goto leave_merge;
 		}
 	}
+	ctx->have_message = 1;
+	if (write_message(ctx->message.buf, ctx->message.len,
+			  git_path_merge_msg(r), 0)) {
+		    ret = error_errno(_("could not write '%s'"),
+				      git_path_merge_msg(r));
+		    goto leave_merge;
+	}
 
 	if (strategy || to_merge->next) {
 		/* Octopus merge */
@@ -4885,6 +4887,8 @@ static int pick_commits(struct repository *r,
 				return stopped_at_head(r);
 			}
 		}
+		strbuf_reset(&ctx->message);
+		ctx->have_message = 0;
 		if (item->command <= TODO_SQUASH) {
 			res = pick_one_commit(r, todo_list, opts, &check_todo,
 					      &reschedule);
-- 
2.44.0.661.ge68cfcc6c2f

