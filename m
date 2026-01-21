Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F20426688
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 21:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769032533; cv=pass; b=idiLjTcd4mbmm1aqOMkXE6xgCVitrL6PWU/FXfc0e6W5MXvrlhZLA08p3K8RpLZZXKNGKcwVZpDmOfQ2D0wu+dKC8hINge2sa303NcgNq+JrrSfQCsVt4EIGhKH9N0N1w4c4cF4Znsf1YHhFNfBVVSbRYHlnbzRvoJz9qRY0cnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769032533; c=relaxed/simple;
	bh=CblEZ15eTiv2MHbwEu/kLIAs+6b7q6p6GqQOFz9vZy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fheVOZ/XJcD6oPWl28+3c0LMaBFKBJhhWZR0PzQy2SXLnD2A7h1hy4n9wxdT8lD8gdGhALqOTASfJaEJsDnzMfJP7ucv/fQnzVPyiNOD0nbu77YVbis5gyjove6DjD7yYG11eWwtIVI8mWIsW+RnBa36aeIOHlzlm6xmyHJB72M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=QQMTtg8f; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="QQMTtg8f"
ARC-Seal: i=1; a=rsa-sha256; t=1769032517; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RDRJ1G1qPkCrFGnyjEfXkSp8i0T6GdtBnR+ov8lqXccHtVmQO9vF+MuPRxb87oJZxDRjlVc1uQIsvE1E0ZQ/aS6VWh2pHxZrY/OkJR6brRKhB07JXPnK09pzLRccC3O/nPsKnQHi7N7cjqsD0GNeG2mYQdY+4wvkNHaqgpbbiWw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769032517; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=j/1gVibTKYO1fog7Y9/9POhUZUaOKPIpFuRD9TlrwrU=; 
	b=X3zt1lsTUEXfxFO1uLze18/R31B4LyOCTDX8XEPOO5onBpzxUldpItkiNkSWhcP1YODSu0gQqrRzOMXC3yi0EY+seFz2tQHHEt0G6NdPAQF7sgZR6hCbo8I2PiYsXc/aFDBT0VdzwmH6g1o8SnakRCjg0amYBEj/b+xDyRX46w4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769032517;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=j/1gVibTKYO1fog7Y9/9POhUZUaOKPIpFuRD9TlrwrU=;
	b=QQMTtg8fPvYtDNUPut8vhnw0qhFpqtifvG1+L7sQ2LdrDfx8d16zOH89PMvnKt5N
	6+32i12HLTdu6m19FRqNjCvXPb/DRms8OrNP1TP/0HObTXVKYCHoNw5bzicUZi8PsTS
	eDyI6pIQO7EbM9iFe809Wo7z23OaqUJ6dJomTkws=
Received: by mx.zohomail.com with SMTPS id 1769032516713355.01091021875925;
	Wed, 21 Jan 2026 13:55:16 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org,
	Jeff King <peff@peff.net>
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH v7 12/12] receive-pack: convert receive hooks to hook API
Date: Wed, 21 Jan 2026 23:54:36 +0200
Message-ID: <20260121215436.1473800-13-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260121215436.1473800-1-adrian.ratiu@collabora.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20260121215436.1473800-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

This converts the last remaining hooks to the new hook API, for
the same benefits as the previous conversions (no need to toggle
signals, manage custom struct child_process, call find_hook(),
prepares for specifying hooks via configs, etc.).

See the previous four commits for a more details explanation how
this all works.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 builtin/receive-pack.c | 194 +++++++++++++++++++----------------------
 1 file changed, 91 insertions(+), 103 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index bcd019786e..13a0502cea 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -749,7 +749,7 @@ static int check_cert_push_options(const struct string_list *push_options)
 	return retval;
 }
 
-static void prepare_push_cert_sha1(struct child_process *proc)
+static void prepare_push_cert_sha1(struct run_hooks_opt *opt)
 {
 	static int already_done;
 
@@ -775,23 +775,23 @@ static void prepare_push_cert_sha1(struct child_process *proc)
 		nonce_status = check_nonce(sigcheck.payload);
 	}
 	if (!is_null_oid(&push_cert_oid)) {
-		strvec_pushf(&proc->env, "GIT_PUSH_CERT=%s",
+		strvec_pushf(&opt->env, "GIT_PUSH_CERT=%s",
 			     oid_to_hex(&push_cert_oid));
-		strvec_pushf(&proc->env, "GIT_PUSH_CERT_SIGNER=%s",
+		strvec_pushf(&opt->env, "GIT_PUSH_CERT_SIGNER=%s",
 			     sigcheck.signer ? sigcheck.signer : "");
-		strvec_pushf(&proc->env, "GIT_PUSH_CERT_KEY=%s",
+		strvec_pushf(&opt->env, "GIT_PUSH_CERT_KEY=%s",
 			     sigcheck.key ? sigcheck.key : "");
-		strvec_pushf(&proc->env, "GIT_PUSH_CERT_STATUS=%c",
+		strvec_pushf(&opt->env, "GIT_PUSH_CERT_STATUS=%c",
 			     sigcheck.result);
 		if (push_cert_nonce) {
-			strvec_pushf(&proc->env,
+			strvec_pushf(&opt->env,
 				     "GIT_PUSH_CERT_NONCE=%s",
 				     push_cert_nonce);
-			strvec_pushf(&proc->env,
+			strvec_pushf(&opt->env,
 				     "GIT_PUSH_CERT_NONCE_STATUS=%s",
 				     nonce_status);
 			if (nonce_status == NONCE_SLOP)
-				strvec_pushf(&proc->env,
+				strvec_pushf(&opt->env,
 					     "GIT_PUSH_CERT_NONCE_SLOP=%ld",
 					     nonce_stamp_slop);
 		}
@@ -803,94 +803,25 @@ struct receive_hook_feed_state {
 	struct ref_push_report *report;
 	int skip_broken;
 	struct strbuf buf;
-	const struct string_list *push_options;
 };
 
-typedef int (*feed_fn)(void *, const char **, size_t *);
-static int run_and_feed_hook(const char *hook_name, feed_fn feed,
-			     struct receive_hook_feed_state *feed_state)
+static int feed_receive_hook_cb(int hook_stdin_fd, void *pp_cb UNUSED, void *pp_task_cb)
 {
-	struct child_process proc = CHILD_PROCESS_INIT;
-	struct async muxer;
-	int code;
-	const char *hook_path = find_hook(the_repository, hook_name);
-
-	if (!hook_path)
-		return 0;
-
-	strvec_push(&proc.args, hook_path);
-	proc.in = -1;
-	proc.stdout_to_stderr = 1;
-	proc.trace2_hook_name = hook_name;
-
-	if (feed_state->push_options) {
-		size_t i;
-		for (i = 0; i < feed_state->push_options->nr; i++)
-			strvec_pushf(&proc.env,
-				     "GIT_PUSH_OPTION_%"PRIuMAX"=%s",
-				     (uintmax_t)i,
-				     feed_state->push_options->items[i].string);
-		strvec_pushf(&proc.env, "GIT_PUSH_OPTION_COUNT=%"PRIuMAX"",
-			     (uintmax_t)feed_state->push_options->nr);
-	} else
-		strvec_pushf(&proc.env, "GIT_PUSH_OPTION_COUNT");
-
-	if (tmp_objdir)
-		strvec_pushv(&proc.env, tmp_objdir_env(tmp_objdir));
-
-	if (use_sideband) {
-		memset(&muxer, 0, sizeof(muxer));
-		muxer.proc = copy_to_sideband;
-		muxer.in = -1;
-		code = start_async(&muxer);
-		if (code)
-			return code;
-		proc.err = muxer.in;
-	}
-
-	prepare_push_cert_sha1(&proc);
-
-	code = start_command(&proc);
-	if (code) {
-		if (use_sideband)
-			finish_async(&muxer);
-		return code;
-	}
-
-	sigchain_push(SIGPIPE, SIG_IGN);
-
-	while (1) {
-		const char *buf;
-		size_t n;
-		if (feed(feed_state, &buf, &n))
-			break;
-		if (write_in_full(proc.in, buf, n) < 0)
-			break;
-	}
-	close(proc.in);
-	if (use_sideband)
-		finish_async(&muxer);
-
-	sigchain_pop(SIGPIPE);
-
-	return finish_command(&proc);
-}
-
-static int feed_receive_hook(void *state_, const char **bufp, size_t *sizep)
-{
-	struct receive_hook_feed_state *state = state_;
+	struct receive_hook_feed_state *state = pp_task_cb;
 	struct command *cmd = state->cmd;
 
+	strbuf_reset(&state->buf);
+
 	while (cmd &&
 	       state->skip_broken && (cmd->error_string || cmd->did_not_exist))
 		cmd = cmd->next;
+
 	if (!cmd)
-		return -1; /* EOF */
-	if (!bufp)
-		return 0; /* OK, can feed something. */
-	strbuf_reset(&state->buf);
+		return 1;  /* no more commands left */
+
 	if (!state->report)
 		state->report = cmd->report;
+
 	if (state->report) {
 		struct object_id *old_oid;
 		struct object_id *new_oid;
@@ -899,23 +830,33 @@ static int feed_receive_hook(void *state_, const char **bufp, size_t *sizep)
 		old_oid = state->report->old_oid ? state->report->old_oid : &cmd->old_oid;
 		new_oid = state->report->new_oid ? state->report->new_oid : &cmd->new_oid;
 		ref_name = state->report->ref_name ? state->report->ref_name : cmd->ref_name;
+
 		strbuf_addf(&state->buf, "%s %s %s\n",
 			    oid_to_hex(old_oid), oid_to_hex(new_oid),
 			    ref_name);
+
 		state->report = state->report->next;
 		if (!state->report)
-			state->cmd = cmd->next;
+			cmd = cmd->next;
 	} else {
 		strbuf_addf(&state->buf, "%s %s %s\n",
 			    oid_to_hex(&cmd->old_oid), oid_to_hex(&cmd->new_oid),
 			    cmd->ref_name);
-		state->cmd = cmd->next;
+		cmd = cmd->next;
 	}
-	if (bufp) {
-		*bufp = state->buf.buf;
-		*sizep = state->buf.len;
+
+	state->cmd = cmd;
+
+	if (state->buf.len > 0) {
+		int ret = write_in_full(hook_stdin_fd, state->buf.buf, state->buf.len);
+		if (ret < 0) {
+			if (errno == EPIPE)
+				return 1; /* child closed pipe */
+			return ret;
+		}
 	}
-	return 0;
+
+	return state->cmd ? 0 : 1;  /* 0 = more to come, 1 = EOF */
 }
 
 static int run_receive_hook(struct command *commands,
@@ -923,20 +864,67 @@ static int run_receive_hook(struct command *commands,
 			    int skip_broken,
 			    const struct string_list *push_options)
 {
-	struct receive_hook_feed_state state;
-	int status;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct command *iter = commands;
+	struct receive_hook_feed_state feed_state;
+	struct async muxer;
+	int ret;
+	int saved_stderr = -1;
+	int muxer_started = 0;
 
-	strbuf_init(&state.buf, 0);
-	state.cmd = commands;
-	state.skip_broken = skip_broken;
-	state.report = NULL;
-	if (feed_receive_hook(&state, NULL, NULL))
+	/* if there are no valid commands, don't invoke the hook at all. */
+	while (iter && skip_broken && (iter->error_string || iter->did_not_exist))
+		iter = iter->next;
+	if (!iter)
 		return 0;
-	state.cmd = commands;
-	state.push_options = push_options;
-	status = run_and_feed_hook(hook_name, feed_receive_hook, &state);
-	strbuf_release(&state.buf);
-	return status;
+
+	if (push_options) {
+		for (int i = 0; i < push_options->nr; i++)
+			strvec_pushf(&opt.env, "GIT_PUSH_OPTION_%d=%s", i,
+				     push_options->items[i].string);
+		strvec_pushf(&opt.env, "GIT_PUSH_OPTION_COUNT=%"PRIuMAX"",
+					     (uintmax_t)push_options->nr);
+	} else {
+		strvec_push(&opt.env, "GIT_PUSH_OPTION_COUNT");
+	}
+
+	if (tmp_objdir)
+		strvec_pushv(&opt.env, tmp_objdir_env(tmp_objdir));
+
+	prepare_push_cert_sha1(&opt);
+
+	if (use_sideband) {
+		memset(&muxer, 0, sizeof(muxer));
+		muxer.proc = copy_to_sideband;
+		muxer.in = -1;
+		if (!start_async(&muxer)) {
+			muxer_started = 1;
+			saved_stderr = dup(STDERR_FILENO);
+			if (saved_stderr >= 0)
+				dup2(muxer.in, STDERR_FILENO);
+			close(muxer.in);
+		}
+	}
+
+	/* set up stdin callback */
+	feed_state.cmd = commands;
+	feed_state.skip_broken = skip_broken;
+	feed_state.report = NULL;
+	strbuf_init(&feed_state.buf, 0);
+	opt.feed_pipe_cb_data = &feed_state;
+	opt.feed_pipe = feed_receive_hook_cb;
+
+	ret = run_hooks_opt(the_repository, hook_name, &opt);
+
+	strbuf_release(&feed_state.buf);
+	if (saved_stderr >= 0) {
+		dup2(saved_stderr, STDERR_FILENO);
+		close(saved_stderr);
+	}
+	if (muxer_started)
+		finish_async(&muxer);
+
+	return ret;
 }
 
 static int run_update_hook(struct command *cmd)
-- 
2.52.0.732.gb351b5166d.dirty

