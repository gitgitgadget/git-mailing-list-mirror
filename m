Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB43C433EF
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 18:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240092AbiCVSC0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 14:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240055AbiCVSCH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 14:02:07 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B1866638
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:00:38 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v22so10642178wra.2
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CagY9EkHGPSukr9Gcxdb9icbGtAz+5el1oCyBPufJIs=;
        b=Owh2cvnrfD6YwHFJ2v0Xsp09L0rGB61YEU6G0Trf996CxZQA16XrobR2Vnqqh4fZie
         w5RhgWaacZt/Dq2GiEh3aKRjCKeAD7PXD6SoDiHPoIN5VK4WzRhgQRU6PGAosf4LMcjx
         rc0jRC2MMAp7aRi1qJZCkqulwrXXl0hv8+J1YNabpf10Jn35gXAl1IoXu89KfLJfEcx+
         CsVorYn1In2t0fRrMgjA1L0XgvD4XMuwpX5QaFIeQqtK2cqeg65/x2404NT6kNYaDr0x
         3/T7SvMY+p05x9xaf5SmRo0DfzA68nbDgNGvfMfn0ZRxJOrQOSjlBnWCvk/DBubEVxRq
         OomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CagY9EkHGPSukr9Gcxdb9icbGtAz+5el1oCyBPufJIs=;
        b=y/vexnufUvpP/Jgk3VxA93oLRiXZzYe96TXxHEvukPVG/yj+hgYTa22sQB0WXla+sJ
         V7cyxn1dKGYP4FfvQoJUiC0UdF8MOlSTRgDeoxV5DOi8E2xGdzP700GOsHJbH1h/XbY8
         4hawkmvGuFNb+PoCfSeqcvQuQtuR2sTBceIbLu8/PX+bBcmGJBrJ5UQQe/icP/PQ4HKa
         ifCasQ+eat6DQKkVmYA7LE0wtcCxun00lQq6MtvY5gHzbxOrBl00M0iZ2E+9Bb2F4r7R
         C5WYYy7cWYGMtIyMaS1AF+J1p9YhdjbjgvRf8Hh0kw7ULc8MDziMxAD8gishYsPFxEvW
         3IvA==
X-Gm-Message-State: AOAM532py6PYwSd8uH8B0MVGMx9fII+4SUT++82xlgsueON6Ly5rzm8k
        3+ySzd9AIFoL/Fkfp8L8ZKVHSwf8+G8=
X-Google-Smtp-Source: ABdhPJwYXbI14LvRodnGnfXNFeXAavH2nH/HP3Zyp09cg/p+OHChhZje8Wdn76ThO7+ZIuwKkXm0uw==
X-Received: by 2002:a5d:64e5:0:b0:1fb:5b9a:1a20 with SMTP id g5-20020a5d64e5000000b001fb5b9a1a20mr23332414wri.34.1647972036755;
        Tue, 22 Mar 2022 11:00:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j1-20020a5d6181000000b00203fc0e79a3sm9902444wru.46.2022.03.22.11.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:00:36 -0700 (PDT)
Message-Id: <39f43fabe024917e6c84b8916197b0dc0add97fc.1647972010.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
References: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
        <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Mar 2022 17:59:55 +0000
Subject: [PATCH v7 14/29] fsmonitor--daemon: create token-based changed path
 cache
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach fsmonitor--daemon to build a list of changed paths and associate
them with a token-id.  This will be used by the platform-specific
backends to accumulate changed paths in response to filesystem events.

The platform-specific file system listener thread receives file system
events containing one or more changed pathnames (with whatever
bucketing or grouping that is convenient for the file system).  These
paths are accumulated (without locking) by the file system layer into
a `fsmonitor_batch`.

When the file system layer has drained the kernel event queue, it will
"publish" them to our token queue and make them visible to concurrent
client worker threads.  The token layer is free to combine and/or de-dup
paths within these batches for efficient presentation to clients.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fsmonitor--daemon.c | 230 +++++++++++++++++++++++++++++++++++-
 fsmonitor--daemon.h         |  40 +++++++
 2 files changed, 268 insertions(+), 2 deletions(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 1c7c156288d..69312119b07 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -181,17 +181,27 @@ struct fsmonitor_token_data {
 	uint64_t client_ref_count;
 };
 
+struct fsmonitor_batch {
+	struct fsmonitor_batch *next;
+	uint64_t batch_seq_nr;
+	const char **interned_paths;
+	size_t nr, alloc;
+	time_t pinned_time;
+};
+
 static struct fsmonitor_token_data *fsmonitor_new_token_data(void)
 {
 	static int test_env_value = -1;
 	static uint64_t flush_count = 0;
 	struct fsmonitor_token_data *token;
+	struct fsmonitor_batch *batch;
 
 	CALLOC_ARRAY(token, 1);
+	batch = fsmonitor_batch__new();
 
 	strbuf_init(&token->token_id, 0);
-	token->batch_head = NULL;
-	token->batch_tail = NULL;
+	token->batch_head = batch;
+	token->batch_tail = batch;
 	token->client_ref_count = 0;
 
 	if (test_env_value < 0)
@@ -217,9 +227,143 @@ static struct fsmonitor_token_data *fsmonitor_new_token_data(void)
 		strbuf_addf(&token->token_id, "test_%08x", test_env_value++);
 	}
 
+	/*
+	 * We created a new <token_id> and are starting a new series
+	 * of tokens with a zero <seq_nr>.
+	 *
+	 * Since clients cannot guess our new (non test) <token_id>
+	 * they will always receive a trivial response (because of the
+	 * mismatch on the <token_id>).  The trivial response will
+	 * tell them our new <token_id> so that subsequent requests
+	 * will be relative to our new series.  (And when sending that
+	 * response, we pin the current head of the batch list.)
+	 *
+	 * Even if the client correctly guesses the <token_id>, their
+	 * request of "builtin:<token_id>:0" asks for all changes MORE
+	 * RECENT than batch/bin 0.
+	 *
+	 * This implies that it is a waste to accumulate paths in the
+	 * initial batch/bin (because they will never be transmitted).
+	 *
+	 * So the daemon could be running for days and watching the
+	 * file system, but doesn't need to actually accumulate any
+	 * paths UNTIL we need to set a reference point for a later
+	 * relative request.
+	 *
+	 * However, it is very useful for testing to always have a
+	 * reference point set.  Pin batch 0 to force early file system
+	 * events to accumulate.
+	 */
+	if (test_env_value)
+		batch->pinned_time = time(NULL);
+
 	return token;
 }
 
+struct fsmonitor_batch *fsmonitor_batch__new(void)
+{
+	struct fsmonitor_batch *batch;
+
+	CALLOC_ARRAY(batch, 1);
+
+	return batch;
+}
+
+void fsmonitor_batch__free_list(struct fsmonitor_batch *batch)
+{
+	while (batch) {
+		struct fsmonitor_batch *next = batch->next;
+
+		/*
+		 * The actual strings within the array of this batch
+		 * are interned, so we don't own them.  We only own
+		 * the array.
+		 */
+		free(batch->interned_paths);
+		free(batch);
+
+		batch = next;
+	}
+}
+
+void fsmonitor_batch__add_path(struct fsmonitor_batch *batch,
+			       const char *path)
+{
+	const char *interned_path = strintern(path);
+
+	trace_printf_key(&trace_fsmonitor, "event: %s", interned_path);
+
+	ALLOC_GROW(batch->interned_paths, batch->nr + 1, batch->alloc);
+	batch->interned_paths[batch->nr++] = interned_path;
+}
+
+static void fsmonitor_batch__combine(struct fsmonitor_batch *batch_dest,
+				     const struct fsmonitor_batch *batch_src)
+{
+	size_t k;
+
+	ALLOC_GROW(batch_dest->interned_paths,
+		   batch_dest->nr + batch_src->nr + 1,
+		   batch_dest->alloc);
+
+	for (k = 0; k < batch_src->nr; k++)
+		batch_dest->interned_paths[batch_dest->nr++] =
+			batch_src->interned_paths[k];
+}
+
+static void fsmonitor_free_token_data(struct fsmonitor_token_data *token)
+{
+	if (!token)
+		return;
+
+	assert(token->client_ref_count == 0);
+
+	strbuf_release(&token->token_id);
+
+	fsmonitor_batch__free_list(token->batch_head);
+
+	free(token);
+}
+
+/*
+ * Flush all of our cached data about the filesystem.  Call this if we
+ * lose sync with the filesystem and miss some notification events.
+ *
+ * [1] If we are missing events, then we no longer have a complete
+ *     history of the directory (relative to our current start token).
+ *     We should create a new token and start fresh (as if we just
+ *     booted up).
+ *
+ * If there are no concurrent threads reading the current token data
+ * series, we can free it now.  Otherwise, let the last reader free
+ * it.
+ *
+ * Either way, the old token data series is no longer associated with
+ * our state data.
+ */
+static void with_lock__do_force_resync(struct fsmonitor_daemon_state *state)
+{
+	/* assert current thread holding state->main_lock */
+
+	struct fsmonitor_token_data *free_me = NULL;
+	struct fsmonitor_token_data *new_one = NULL;
+
+	new_one = fsmonitor_new_token_data();
+
+	if (state->current_token_data->client_ref_count == 0)
+		free_me = state->current_token_data;
+	state->current_token_data = new_one;
+
+	fsmonitor_free_token_data(free_me);
+}
+
+void fsmonitor_force_resync(struct fsmonitor_daemon_state *state)
+{
+	pthread_mutex_lock(&state->main_lock);
+	with_lock__do_force_resync(state);
+	pthread_mutex_unlock(&state->main_lock);
+}
+
 static ipc_server_application_cb handle_client;
 
 static int handle_client(void *data,
@@ -329,6 +473,81 @@ enum fsmonitor_path_type fsmonitor_classify_path_absolute(
 	return fsmonitor_classify_path_gitdir_relative(rel);
 }
 
+/*
+ * We try to combine small batches at the front of the batch-list to avoid
+ * having a long list.  This hopefully makes it a little easier when we want
+ * to truncate and maintain the list.  However, we don't want the paths array
+ * to just keep growing and growing with realloc, so we insert an arbitrary
+ * limit.
+ */
+#define MY_COMBINE_LIMIT (1024)
+
+void fsmonitor_publish(struct fsmonitor_daemon_state *state,
+		       struct fsmonitor_batch *batch,
+		       const struct string_list *cookie_names)
+{
+	if (!batch && !cookie_names->nr)
+		return;
+
+	pthread_mutex_lock(&state->main_lock);
+
+	if (batch) {
+		struct fsmonitor_batch *head;
+
+		head = state->current_token_data->batch_head;
+		if (!head) {
+			BUG("token does not have batch");
+		} else if (head->pinned_time) {
+			/*
+			 * We cannot alter the current batch list
+			 * because:
+			 *
+			 * [a] it is being transmitted to at least one
+			 * client and the handle_client() thread has a
+			 * ref-count, but not a lock on the batch list
+			 * starting with this item.
+			 *
+			 * [b] it has been transmitted in the past to
+			 * at least one client such that future
+			 * requests are relative to this head batch.
+			 *
+			 * So, we can only prepend a new batch onto
+			 * the front of the list.
+			 */
+			batch->batch_seq_nr = head->batch_seq_nr + 1;
+			batch->next = head;
+			state->current_token_data->batch_head = batch;
+		} else if (!head->batch_seq_nr) {
+			/*
+			 * Batch 0 is unpinned.  See the note in
+			 * `fsmonitor_new_token_data()` about why we
+			 * don't need to accumulate these paths.
+			 */
+			fsmonitor_batch__free_list(batch);
+		} else if (head->nr + batch->nr > MY_COMBINE_LIMIT) {
+			/*
+			 * The head batch in the list has never been
+			 * transmitted to a client, but folding the
+			 * contents of the new batch onto it would
+			 * exceed our arbitrary limit, so just prepend
+			 * the new batch onto the list.
+			 */
+			batch->batch_seq_nr = head->batch_seq_nr + 1;
+			batch->next = head;
+			state->current_token_data->batch_head = batch;
+		} else {
+			/*
+			 * We are free to add the paths in the given
+			 * batch onto the end of the current head batch.
+			 */
+			fsmonitor_batch__combine(head, batch);
+			fsmonitor_batch__free_list(batch);
+		}
+	}
+
+	pthread_mutex_unlock(&state->main_lock);
+}
+
 static void *fsm_listen__thread_proc(void *_state)
 {
 	struct fsmonitor_daemon_state *state = _state;
@@ -343,6 +562,13 @@ static void *fsm_listen__thread_proc(void *_state)
 
 	fsm_listen__loop(state);
 
+	pthread_mutex_lock(&state->main_lock);
+	if (state->current_token_data &&
+	    state->current_token_data->client_ref_count == 0)
+		fsmonitor_free_token_data(state->current_token_data);
+	state->current_token_data = NULL;
+	pthread_mutex_unlock(&state->main_lock);
+
 	trace2_thread_exit();
 	return NULL;
 }
diff --git a/fsmonitor--daemon.h b/fsmonitor--daemon.h
index 8c3a71a48bd..010fbfe60e9 100644
--- a/fsmonitor--daemon.h
+++ b/fsmonitor--daemon.h
@@ -12,6 +12,27 @@
 struct fsmonitor_batch;
 struct fsmonitor_token_data;
 
+/*
+ * Create a new batch of path(s).  The returned batch is considered
+ * private and not linked into the fsmonitor daemon state.  The caller
+ * should fill this batch with one or more paths and then publish it.
+ */
+struct fsmonitor_batch *fsmonitor_batch__new(void);
+
+/*
+ * Free the list of batches starting with this one.
+ */
+void fsmonitor_batch__free_list(struct fsmonitor_batch *batch);
+
+/*
+ * Add this path to this batch of modified files.
+ *
+ * The batch should be private and NOT (yet) linked into the fsmonitor
+ * daemon state and therefore not yet visible to worker threads and so
+ * no locking is required.
+ */
+void fsmonitor_batch__add_path(struct fsmonitor_batch *batch, const char *path);
+
 struct fsmonitor_daemon_backend_data; /* opaque platform-specific data */
 
 struct fsmonitor_daemon_state {
@@ -117,5 +138,24 @@ enum fsmonitor_path_type fsmonitor_classify_path_absolute(
 	struct fsmonitor_daemon_state *state,
 	const char *path);
 
+/*
+ * Prepend the this batch of path(s) onto the list of batches associated
+ * with the current token.  This makes the batch visible to worker threads.
+ *
+ * The caller no longer owns the batch and must not free it.
+ *
+ * Wake up the client threads waiting on these cookies.
+ */
+void fsmonitor_publish(struct fsmonitor_daemon_state *state,
+		       struct fsmonitor_batch *batch,
+		       const struct string_list *cookie_names);
+
+/*
+ * If the platform-specific layer loses sync with the filesystem,
+ * it should call this to invalidate cached data and abort waiting
+ * threads.
+ */
+void fsmonitor_force_resync(struct fsmonitor_daemon_state *state);
+
 #endif /* HAVE_FSMONITOR_DAEMON_BACKEND */
 #endif /* FSMONITOR_DAEMON_H */
-- 
gitgitgadget

