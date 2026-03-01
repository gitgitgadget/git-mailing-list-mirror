Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D7D2D837C
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 18:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772390783; cv=pass; b=C1K4MZg6tAkYFuq/MbX2pF8CNp3HTGH/+P1jP+42YJRzFkSHIem/+CDNWkhxypvaOsafxKzDrmgKbzbG+P8TVm043aYX9V0BnpvSNTMgkDQRDyqwE+KHLnkzx73/yJ2nWxrQxlYZMhOjZe6QUYiAxJ+HcTwxlmRygJxO8fDtuDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772390783; c=relaxed/simple;
	bh=nZBpuzt/TzTsczlS6JPfWpOeKMMLAVypDfGkXbk0JYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PgMTNRT+HB1U4jDMoUvBOR/IXV1HykNe18vlK0irP4EniwIgPWJsvBR4h//SCjDuMw3Pes/23GwUz0tXXoO1Q/6M2IePFtritLqf+/ZkippQCWdJiFUY3fqA06FdgAhpaZ1dJXRdZga7DcQXk2wAgpM2IO3EY6JlsFnjEWekMqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=H7VtklER; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="H7VtklER"
ARC-Seal: i=1; a=rsa-sha256; t=1772390761; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fopThdLjuyPjzvfmT5s2uVZP401daqAVjafw4bukuBlkhNk0k89TvrTd44YtZnwNh4aOelyHbMawgx1pmaYszHR9uO2jIkafj8+5jbLvXlQpJAEALKhtxm96DHgM9iDU676TOycEIfNeJ9OXv3gH/UU2puR5l9TCRDF+7YRVbzM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772390761; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=p64eCHZyjRJ7NkKMFJhKmHuVsOfIeWSeqfg4TUuqtKc=; 
	b=UKDRNJM8E1pJ0ylW0LbOppewZsFvZtnBcJsmNALLxDhmyqSJogtm0XeUaFdv2koiomVRtp1TwAV9TAlODbv3GGjOsCBqGJZ0Tpr+Slqzs9J9syjZXqgwe3FSyCAe3ibYmkCmoaqmgYLMmuGzmBS0CMscQrxH+CUyHEou+EBfsqY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772390761;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=p64eCHZyjRJ7NkKMFJhKmHuVsOfIeWSeqfg4TUuqtKc=;
	b=H7VtklERtspZUQHKGKcx3eQVQd8LHj/8oaUPQYhDhnQ84RRifXzIPb9OUS+TVHWX
	tmLKx29JH9NHcgg/d/L2GPJFuNOZxik17jTtaIk71CmP/RmgV1C0RkWlp3EIQ89TJty
	1gvMnP1V55ygvU5oiLjJJ/BPQb8wiO9YdLaGSO5I=
Received: by mx.zohomail.com with SMTPS id 1772390759567373.1357524957282;
	Sun, 1 Mar 2026 10:45:59 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v3 01/12] hook: add internal state alloc/free callbacks
Date: Sun,  1 Mar 2026 20:44:49 +0200
Message-ID: <20260301184500.1488433-2-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260301184500.1488433-1-adrian.ratiu@collabora.com>
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
 <20260301184500.1488433-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Some hooks use opaque structs to keep internal state between callbacks.

Because hooks ran sequentially (jobs == 1) with one command per hook,
these internal states could be allocated on the stack for each hook run.

Next commits add the ability to run multiple commands for each hook, so
the states cannot be shared or stored on the stack anymore, especially
since down the line we will also enable parallel execution (jobs > 1).

Add alloc/free helpers for each hook, doing a "deep" alloc/init & free
of their internal opaque struct.

The alloc callback takes a context pointer, to initialize the struct at
at the time of resource acquisition.

These callbacks must always be provided together: no alloc without free
and no free without alloc, otherwise a BUG() is triggered.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 builtin/receive-pack.c | 36 +++++++++++++++++++++++++++++-------
 hook.c                 | 12 ++++++++++++
 hook.h                 | 29 ++++++++++++++++++++++++++++-
 refs.c                 | 25 ++++++++++++++++++++-----
 transport.c            | 28 +++++++++++++++++++++-------
 5 files changed, 110 insertions(+), 20 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 2d2b33d73d..0f3ba93e95 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -901,6 +901,27 @@ static int feed_receive_hook_cb(int hook_stdin_fd, void *pp_cb UNUSED, void *pp_
 	return state->cmd ? 0 : 1;  /* 0 = more to come, 1 = EOF */
 }
 
+static void *receive_hook_feed_state_alloc(void *feed_pipe_ctx)
+{
+	struct receive_hook_feed_state *init_state = feed_pipe_ctx;
+	struct receive_hook_feed_state *data;
+	CALLOC_ARRAY(data, 1);
+	data->report = init_state->report;
+	data->cmd = init_state->cmd;
+	data->skip_broken = init_state->skip_broken;
+	strbuf_init(&data->buf, 0);
+	return data;
+}
+
+static void receive_hook_feed_state_free(void *data)
+{
+	struct receive_hook_feed_state *d = data;
+	if (!d)
+		return;
+	strbuf_release(&d->buf);
+	free(d);
+}
+
 static int run_receive_hook(struct command *commands,
 			    const char *hook_name,
 			    int skip_broken,
@@ -908,7 +929,11 @@ static int run_receive_hook(struct command *commands,
 {
 	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
 	struct command *iter = commands;
-	struct receive_hook_feed_state feed_state;
+	struct receive_hook_feed_state feed_init_state = {
+		.cmd = commands,
+		.skip_broken = skip_broken,
+		.buf = STRBUF_INIT,
+	};
 	struct async sideband_async;
 	int sideband_async_started = 0;
 	int saved_stderr = -1;
@@ -938,16 +963,13 @@ static int run_receive_hook(struct command *commands,
 	prepare_sideband_async(&sideband_async, &saved_stderr, &sideband_async_started);
 
 	/* set up stdin callback */
-	feed_state.cmd = commands;
-	feed_state.skip_broken = skip_broken;
-	feed_state.report = NULL;
-	strbuf_init(&feed_state.buf, 0);
-	opt.feed_pipe_cb_data = &feed_state;
+	opt.feed_pipe_ctx = &feed_init_state;
 	opt.feed_pipe = feed_receive_hook_cb;
+	opt.feed_pipe_cb_data_alloc = receive_hook_feed_state_alloc;
+	opt.feed_pipe_cb_data_free = receive_hook_feed_state_free;
 
 	ret = run_hooks_opt(the_repository, hook_name, &opt);
 
-	strbuf_release(&feed_state.buf);
 	finish_sideband_async(&sideband_async, saved_stderr, sideband_async_started);
 
 	return ret;
diff --git a/hook.c b/hook.c
index cde7198412..a9ade11952 100644
--- a/hook.c
+++ b/hook.c
@@ -133,6 +133,8 @@ static int notify_hook_finished(int result,
 
 static void run_hooks_opt_clear(struct run_hooks_opt *options)
 {
+	if (options->feed_pipe_cb_data_free)
+		options->feed_pipe_cb_data_free(options->feed_pipe_cb_data);
 	strvec_clear(&options->env);
 	strvec_clear(&options->args);
 }
@@ -172,6 +174,16 @@ int run_hooks_opt(struct repository *r, const char *hook_name,
 	if (!options->jobs)
 		BUG("run_hooks_opt must be called with options.jobs >= 1");
 
+	/*
+	 * Ensure cb_data copy and free functions are either provided together,
+	 * or neither one is provided.
+	 */
+	if (!options->feed_pipe_cb_data_alloc != !options->feed_pipe_cb_data_free)
+		BUG("feed_pipe_cb_data_alloc and feed_pipe_cb_data_free must be set together");
+
+	if (options->feed_pipe_cb_data_alloc)
+		options->feed_pipe_cb_data = options->feed_pipe_cb_data_alloc(options->feed_pipe_ctx);
+
 	if (options->invoked_hook)
 		*options->invoked_hook = 0;
 
diff --git a/hook.h b/hook.h
index 20eb56fd63..630e1a3c85 100644
--- a/hook.h
+++ b/hook.h
@@ -5,6 +5,9 @@
 
 struct repository;
 
+typedef void (*hook_data_free_fn)(void *data);
+typedef void *(*hook_data_alloc_fn)(void *init_ctx);
+
 struct run_hooks_opt
 {
 	/* Environment vars to be set for each hook */
@@ -88,10 +91,34 @@ struct run_hooks_opt
 	 * It can be accessed directly via the third callback arg 'pp_task_cb':
 	 * struct ... *state = pp_task_cb;
 	 *
-	 * The caller is responsible for managing the memory for this data.
+	 * The caller is responsible for managing the memory for this data by
+	 * providing alloc/free callbacks to `run_hooks_opt`.
+	 *
 	 * Only useful when using `run_hooks_opt.feed_pipe`, otherwise ignore it.
 	 */
 	void *feed_pipe_cb_data;
+
+	/**
+	 * Some hooks need to create a fresh `feed_pipe_cb_data` internal state,
+	 * so they can keep track of progress without affecting one another.
+	 *
+	 * If provided, this function will be called to alloc & initialize the
+	 * `feed_pipe_cb_data` for each hook.
+	 *
+	 * The caller must provide a `feed_pipe_cb_data_free` callback to free
+	 * this memory (missing callback will trigger a bug). Use only the cb to
+	 * free the memory, do not free it manually in the caller.
+	 *
+	 * The `feed_pipe_ctx` pointer can be used to pass initialization data.
+	 */
+	hook_data_alloc_fn feed_pipe_cb_data_alloc;
+
+	/**
+	 * Called to free the memory initialized by `feed_pipe_cb_data_alloc`.
+	 *
+	 * Must always be provided when `feed_pipe_cb_data_alloc` is provided.
+	 */
+	hook_data_free_fn feed_pipe_cb_data_free;
 };
 
 #define RUN_HOOKS_OPT_INIT { \
diff --git a/refs.c b/refs.c
index 7cfb866aab..bd91c5c882 100644
--- a/refs.c
+++ b/refs.c
@@ -2597,24 +2597,39 @@ static int transaction_hook_feed_stdin(int hook_stdin_fd, void *pp_cb, void *pp_
 	return 0; /* no more input to feed */
 }
 
+static void *transaction_feed_cb_data_alloc(void *feed_pipe_ctx UNUSED)
+{
+	struct transaction_feed_cb_data *data;
+	CALLOC_ARRAY(data, 1);
+	strbuf_init(&data->buf, 0);
+	data->index = 0;
+	return data;
+}
+
+static void transaction_feed_cb_data_free(void *data)
+{
+	struct transaction_feed_cb_data *d = data;
+	if (!d)
+		return;
+	strbuf_release(&d->buf);
+	free(d);
+}
+
 static int run_transaction_hook(struct ref_transaction *transaction,
 				const char *state)
 {
 	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
-	struct transaction_feed_cb_data feed_ctx = { 0 };
 	int ret = 0;
 
 	strvec_push(&opt.args, state);
 
 	opt.feed_pipe = transaction_hook_feed_stdin;
 	opt.feed_pipe_ctx = transaction;
-	opt.feed_pipe_cb_data = &feed_ctx;
-
-	strbuf_init(&feed_ctx.buf, 0);
+	opt.feed_pipe_cb_data_alloc = transaction_feed_cb_data_alloc;
+	opt.feed_pipe_cb_data_free = transaction_feed_cb_data_free;
 
 	ret = run_hooks_opt(transaction->ref_store->repo, "reference-transaction", &opt);
 
-	strbuf_release(&feed_ctx.buf);
 	return ret;
 }
 
diff --git a/transport.c b/transport.c
index faa166a575..56a4015389 100644
--- a/transport.c
+++ b/transport.c
@@ -1358,21 +1358,37 @@ static int pre_push_hook_feed_stdin(int hook_stdin_fd, void *pp_cb UNUSED, void
 	return 0;
 }
 
+static void *pre_push_hook_data_alloc(void *feed_pipe_ctx)
+{
+	struct feed_pre_push_hook_data *data;
+	CALLOC_ARRAY(data, 1);
+	strbuf_init(&data->buf, 0);
+	data->refs = (struct ref *)feed_pipe_ctx;
+	return data;
+}
+
+static void pre_push_hook_data_free(void *data)
+{
+	struct feed_pre_push_hook_data *d = data;
+	if (!d)
+		return;
+	strbuf_release(&d->buf);
+	free(d);
+}
+
 static int run_pre_push_hook(struct transport *transport,
 			     struct ref *remote_refs)
 {
 	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
-	struct feed_pre_push_hook_data data;
 	int ret = 0;
 
 	strvec_push(&opt.args, transport->remote->name);
 	strvec_push(&opt.args, transport->url);
 
-	strbuf_init(&data.buf, 0);
-	data.refs = remote_refs;
-
 	opt.feed_pipe = pre_push_hook_feed_stdin;
-	opt.feed_pipe_cb_data = &data;
+	opt.feed_pipe_ctx = remote_refs;
+	opt.feed_pipe_cb_data_alloc = pre_push_hook_data_alloc;
+	opt.feed_pipe_cb_data_free = pre_push_hook_data_free;
 
 	/*
 	 * pre-push hooks expect stdout & stderr to be separate, so don't merge
@@ -1382,8 +1398,6 @@ static int run_pre_push_hook(struct transport *transport,
 
 	ret = run_hooks_opt(the_repository, "pre-push", &opt);
 
-	strbuf_release(&data.buf);
-
 	return ret;
 }
 
-- 
2.52.0.732.gb351b5166d.dirty

