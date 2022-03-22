Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBE6C433EF
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 18:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240399AbiCVSZk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 14:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240386AbiCVSZV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 14:25:21 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D5F90FF3
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:23:40 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u16so23630781wru.4
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Wtvb5FDBX3WUfcTKnEkmdS/WLRWMd9ydoFseLbjp70o=;
        b=j1qMyXHMMcfyPAI+ZZvU6uF+XvZ2LGPGwb1xcSepaD8oRGNn8PULad1dFMh8aO+Yb1
         hbdsrr+lAl1KqhR4BH6hRt6TAqWC7ziCOJegq4ZqWaDixwZtXg9dPb7/QPrFRG1MWEqf
         ypW/XOImXEMVyS+lkgXiayNmLaYtNASGrRHFeJC6+RDHSF/4n8riDyE6WcfClsk+fGw/
         r5wUWXA0OBugbywibfLwYpd1xzbROA1ldC4q7QhidpJyJzBRzcdVghFIvFdGlXt9Qb1h
         OUEL6JQZEqay0m16Yd2QXHOQbEXDXvhkhxhNIq+In3lF2f2MCZybaont6aF75DxfLTQ5
         Lfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Wtvb5FDBX3WUfcTKnEkmdS/WLRWMd9ydoFseLbjp70o=;
        b=NsBewe27u5dnN0wFmPM3xIOzqH6ohUuJ2/vEnbnAuhe+U0L+Rs+h3WynN7lhUgj6cM
         HnxyghEDikRLgTF6OMyvdKZcvs50+Oy+DFTQdxwYuBylqy96xLbo6I8pzGNa0FsxQdJ0
         4A31q1TL4zSCjsWcYdicHogZOd5mEjS+cRTocpjFutvCD8cvG8KHBwoiUI3ScromLKnz
         8ifT2HQtS9FUn6pDsSTtTiHhD9Z+n2LVJCh99GVXSGssZVoLbUdI1aCjJCfp0i5wdgp4
         gecgz1V2n09o/3flG78xZwKvhPAZjmkl5bC72GAd5z4pI34Rdf9WuA3xs8oiahjcOo4p
         gx0A==
X-Gm-Message-State: AOAM531mPqM9pcVCqP9ZwMLkNUoJ1kMrzhHF7UD9ykqikdOq3hRmyz06
        ehSXY3SgS8J0kD5KoDG7bXEsCnYpqPw=
X-Google-Smtp-Source: ABdhPJxEXZYXe50Eot8ToMqLgCRMAvNJmL1xy5Xeh/8kKLI0//RaZ8oLkYaj44Kpr3IKGQmmrBfvuA==
X-Received: by 2002:adf:806e:0:b0:1e3:2a17:bd60 with SMTP id 101-20020adf806e000000b001e32a17bd60mr23053742wrk.719.1647973418816;
        Tue, 22 Mar 2022 11:23:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j5-20020a05600c1c0500b0038ca4fdf7a5sm3674870wms.9.2022.03.22.11.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:23:37 -0700 (PDT)
Message-Id: <e78eb20c1bfeaceb58b5c3ad6d8d8a892c04394f.1647973380.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
References: <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
        <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Mar 2022 18:22:48 +0000
Subject: [PATCH v3 15/27] fsmonitor--daemon: rename listener thread related
 variables
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Rename platform-specific listener thread related variables
and data types as we prepare to add another backend thread
type.

[] `struct fsmonitor_daemon_backend_data` becomes `struct fsm_listen_data`
[] `state->backend_data` becomes `state->listen_data`
[] `state->error_code` becomes `state->listen_error_code`

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fsmonitor--daemon.c          |  6 +++---
 compat/fsmonitor/fsm-listen-darwin.c | 30 ++++++++++++++--------------
 compat/fsmonitor/fsm-listen-win32.c  | 28 +++++++++++++-------------
 compat/fsmonitor/fsm-listen.h        |  2 +-
 fsmonitor--daemon.h                  |  6 +++---
 5 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 8033916aa63..af91bc2fb4c 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1226,8 +1226,8 @@ cleanup:
 
 	if (err)
 		return err;
-	if (state->error_code)
-		return state->error_code;
+	if (state->listen_error_code)
+		return state->listen_error_code;
 	return 0;
 }
 
@@ -1242,7 +1242,7 @@ static int fsmonitor_run_daemon(void)
 	hashmap_init(&state.cookies, cookies_cmp, NULL, 0);
 	pthread_mutex_init(&state.main_lock, NULL);
 	pthread_cond_init(&state.cookies_cond, NULL);
-	state.error_code = 0;
+	state.listen_error_code = 0;
 	state.current_token_data = fsmonitor_new_token_data();
 
 	/* Prepare to (recursively) watch the <worktree-root> directory. */
diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index 14105f45c18..07113205a61 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -27,7 +27,7 @@
 #include "fsm-listen.h"
 #include "fsmonitor--daemon.h"
 
-struct fsmonitor_daemon_backend_data
+struct fsm_listen_data
 {
 	CFStringRef cfsr_worktree_path;
 	CFStringRef cfsr_gitdir_path;
@@ -158,7 +158,7 @@ static void fsevent_callback(ConstFSEventStreamRef streamRef,
 			     const FSEventStreamEventId event_ids[])
 {
 	struct fsmonitor_daemon_state *state = ctx;
-	struct fsmonitor_daemon_backend_data *data = state->backend_data;
+	struct fsm_listen_data *data = state->listen_data;
 	char **paths = (char **)event_paths;
 	struct fsmonitor_batch *batch = NULL;
 	struct string_list cookie_list = STRING_LIST_INIT_DUP;
@@ -350,11 +350,11 @@ int fsm_listen__ctor(struct fsmonitor_daemon_state *state)
 		NULL,
 		NULL
 	};
-	struct fsmonitor_daemon_backend_data *data;
+	struct fsm_listen_data *data;
 	const void *dir_array[2];
 
 	CALLOC_ARRAY(data, 1);
-	state->backend_data = data;
+	state->listen_data = data;
 
 	data->cfsr_worktree_path = CFStringCreateWithCString(
 		NULL, state->path_worktree_watch.buf, kCFStringEncodingUTF8);
@@ -386,18 +386,18 @@ int fsm_listen__ctor(struct fsmonitor_daemon_state *state)
 failed:
 	error(_("Unable to create FSEventStream."));
 
-	FREE_AND_NULL(state->backend_data);
+	FREE_AND_NULL(state->listen_data);
 	return -1;
 }
 
 void fsm_listen__dtor(struct fsmonitor_daemon_state *state)
 {
-	struct fsmonitor_daemon_backend_data *data;
+	struct fsm_listen_data *data;
 
-	if (!state || !state->backend_data)
+	if (!state || !state->listen_data)
 		return;
 
-	data = state->backend_data;
+	data = state->listen_data;
 
 	if (data->stream) {
 		if (data->stream_started)
@@ -407,14 +407,14 @@ void fsm_listen__dtor(struct fsmonitor_daemon_state *state)
 		FSEventStreamRelease(data->stream);
 	}
 
-	FREE_AND_NULL(state->backend_data);
+	FREE_AND_NULL(state->listen_data);
 }
 
 void fsm_listen__stop_async(struct fsmonitor_daemon_state *state)
 {
-	struct fsmonitor_daemon_backend_data *data;
+	struct fsm_listen_data *data;
 
-	data = state->backend_data;
+	data = state->listen_data;
 	data->shutdown_style = SHUTDOWN_EVENT;
 
 	CFRunLoopStop(data->rl);
@@ -422,9 +422,9 @@ void fsm_listen__stop_async(struct fsmonitor_daemon_state *state)
 
 void fsm_listen__loop(struct fsmonitor_daemon_state *state)
 {
-	struct fsmonitor_daemon_backend_data *data;
+	struct fsm_listen_data *data;
 
-	data = state->backend_data;
+	data = state->listen_data;
 
 	data->rl = CFRunLoopGetCurrent();
 
@@ -441,7 +441,7 @@ void fsm_listen__loop(struct fsmonitor_daemon_state *state)
 
 	switch (data->shutdown_style) {
 	case FORCE_ERROR_STOP:
-		state->error_code = -1;
+		state->listen_error_code = -1;
 		/* fall thru */
 	case FORCE_SHUTDOWN:
 		ipc_server_stop_async(state->ipc_server_data);
@@ -453,7 +453,7 @@ void fsm_listen__loop(struct fsmonitor_daemon_state *state)
 	return;
 
 force_error_stop_without_loop:
-	state->error_code = -1;
+	state->listen_error_code = -1;
 	ipc_server_stop_async(state->ipc_server_data);
 	return;
 }
diff --git a/compat/fsmonitor/fsm-listen-win32.c b/compat/fsmonitor/fsm-listen-win32.c
index c43d92b9620..be2d93f47b2 100644
--- a/compat/fsmonitor/fsm-listen-win32.c
+++ b/compat/fsmonitor/fsm-listen-win32.c
@@ -54,7 +54,7 @@ struct one_watch
 	wchar_t dotgit_shortname[16]; /* for 8.3 name */
 };
 
-struct fsmonitor_daemon_backend_data
+struct fsm_listen_data
 {
 	struct one_watch *watch_worktree;
 	struct one_watch *watch_gitdir;
@@ -263,7 +263,7 @@ static enum get_relative_result get_relative_longname(
 
 void fsm_listen__stop_async(struct fsmonitor_daemon_state *state)
 {
-	SetEvent(state->backend_data->hListener[LISTENER_SHUTDOWN]);
+	SetEvent(state->listen_data->hListener[LISTENER_SHUTDOWN]);
 }
 
 static struct one_watch *create_watch(struct fsmonitor_daemon_state *state,
@@ -337,7 +337,7 @@ static void destroy_watch(struct one_watch *watch)
 	free(watch);
 }
 
-static int start_rdcw_watch(struct fsmonitor_daemon_backend_data *data,
+static int start_rdcw_watch(struct fsm_listen_data *data,
 			    struct one_watch *watch)
 {
 	DWORD dwNotifyFilter =
@@ -516,7 +516,7 @@ static int process_1_worktree_event(
  */
 static int process_worktree_events(struct fsmonitor_daemon_state *state)
 {
-	struct fsmonitor_daemon_backend_data *data = state->backend_data;
+	struct fsm_listen_data *data = state->listen_data;
 	struct one_watch *watch = data->watch_worktree;
 	struct strbuf path = STRBUF_INIT;
 	struct string_list cookie_list = STRING_LIST_INIT_DUP;
@@ -646,7 +646,7 @@ force_shutdown:
  */
 static int process_gitdir_events(struct fsmonitor_daemon_state *state)
 {
-	struct fsmonitor_daemon_backend_data *data = state->backend_data;
+	struct fsm_listen_data *data = state->listen_data;
 	struct one_watch *watch = data->watch_gitdir;
 	struct strbuf path = STRBUF_INIT;
 	struct string_list cookie_list = STRING_LIST_INIT_DUP;
@@ -704,11 +704,11 @@ skip_this_path:
 
 void fsm_listen__loop(struct fsmonitor_daemon_state *state)
 {
-	struct fsmonitor_daemon_backend_data *data = state->backend_data;
+	struct fsm_listen_data *data = state->listen_data;
 	DWORD dwWait;
 	int result;
 
-	state->error_code = 0;
+	state->listen_error_code = 0;
 
 	if (start_rdcw_watch(data, data->watch_worktree) == -1)
 		goto force_error_stop;
@@ -773,7 +773,7 @@ void fsm_listen__loop(struct fsmonitor_daemon_state *state)
 	}
 
 force_error_stop:
-	state->error_code = -1;
+	state->listen_error_code = -1;
 
 force_shutdown:
 	/*
@@ -790,7 +790,7 @@ clean_shutdown:
 
 int fsm_listen__ctor(struct fsmonitor_daemon_state *state)
 {
-	struct fsmonitor_daemon_backend_data *data;
+	struct fsm_listen_data *data;
 
 	CALLOC_ARRAY(data, 1);
 
@@ -823,7 +823,7 @@ int fsm_listen__ctor(struct fsmonitor_daemon_state *state)
 		data->nr_listener_handles++;
 	}
 
-	state->backend_data = data;
+	state->listen_data = data;
 	return 0;
 
 failed:
@@ -836,16 +836,16 @@ failed:
 
 void fsm_listen__dtor(struct fsmonitor_daemon_state *state)
 {
-	struct fsmonitor_daemon_backend_data *data;
+	struct fsm_listen_data *data;
 
-	if (!state || !state->backend_data)
+	if (!state || !state->listen_data)
 		return;
 
-	data = state->backend_data;
+	data = state->listen_data;
 
 	CloseHandle(data->hEventShutdown);
 	destroy_watch(data->watch_worktree);
 	destroy_watch(data->watch_gitdir);
 
-	FREE_AND_NULL(state->backend_data);
+	FREE_AND_NULL(state->listen_data);
 }
diff --git a/compat/fsmonitor/fsm-listen.h b/compat/fsmonitor/fsm-listen.h
index f0539349baf..41650bf8972 100644
--- a/compat/fsmonitor/fsm-listen.h
+++ b/compat/fsmonitor/fsm-listen.h
@@ -33,7 +33,7 @@ void fsm_listen__dtor(struct fsmonitor_daemon_state *state);
  * do so if the listener thread receives a normal shutdown signal from
  * the IPC layer.)
  *
- * It should set `state->error_code` to -1 if the daemon should exit
+ * It should set `state->listen_error_code` to -1 if the daemon should exit
  * with an error.
  */
 void fsm_listen__loop(struct fsmonitor_daemon_state *state);
diff --git a/fsmonitor--daemon.h b/fsmonitor--daemon.h
index 223c2131b58..2c6fa1a5d91 100644
--- a/fsmonitor--daemon.h
+++ b/fsmonitor--daemon.h
@@ -33,7 +33,7 @@ void fsmonitor_batch__free_list(struct fsmonitor_batch *batch);
  */
 void fsmonitor_batch__add_path(struct fsmonitor_batch *batch, const char *path);
 
-struct fsmonitor_daemon_backend_data; /* opaque platform-specific data */
+struct fsm_listen_data; /* opaque platform-specific data for listener thread */
 
 struct fsmonitor_daemon_state {
 	pthread_t listener_thread;
@@ -50,8 +50,8 @@ struct fsmonitor_daemon_state {
 	int cookie_seq;
 	struct hashmap cookies;
 
-	int error_code;
-	struct fsmonitor_daemon_backend_data *backend_data;
+	int listen_error_code;
+	struct fsm_listen_data *listen_data;
 
 	struct ipc_server_data *ipc_server_data;
 	struct strbuf path_ipc;
-- 
gitgitgadget

