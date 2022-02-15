Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA0AC43219
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 16:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241242AbiBOQAv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 11:00:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241149AbiBOQA3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 11:00:29 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C3CC0846
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:59:54 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id d14-20020a05600c34ce00b0037bf4d14dc7so1705274wmq.3
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TAUHD55rHQCQbT+0+ox3IidX3Y7QpfUp5PFWbkeQsuY=;
        b=Q4MFY1jLscN9HrXCoX+tadxL/UpTjP8Evn1lvbj/jELk5AhH4FlDN4RFn9RiU5+qiW
         jbC4yXXe+8hRSagUVJubbNt9AfAzOfftBpCi+oaov+7OJVR86ANm0FjnA0r39XfmPa6z
         3puk52R73h804vVVtvoT2qqA6KcaNuutNoRlpe3mp7hriMoN+1UT1Dxf8o+sladXg1Yq
         HodiQL0fNboNEtjZsnUgWztlab2nWu1eQnuB19ZCcAwNSaIu7kL9uGj/12L2/DzmcMTf
         LH60ox4HdUPoBDH3litHWuS5gYEKaDWsQ+05UfeLaJGLxvstdbk7fu1kuHyaXba5lDEw
         /w6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TAUHD55rHQCQbT+0+ox3IidX3Y7QpfUp5PFWbkeQsuY=;
        b=kWI/njg2Rq0ytaFXgVdXIbnwlLFDg7aAddjyctUpaPyrAVUJERT9GZGy+0QiAqQtn8
         J/YlRhsKdNTLlwd5Z+rVHsztoV5RwO/N64H+VocjGdXdEDMgDzFwP4OLoD3vRgNzXygK
         RQldVfPixFLegF1aOZSyBDGgJVOT2hBeAlXEgXDeodZqt+IspEyz5JVgb0R5qo32VsNA
         n6wtTiCXB1GcO2dbxKmOUfZL/NDyB+CYu2tyDb0kfsNNeEBJGIw1W9mDgbjLyUGYPnH4
         ILJY9kV3IOKOlhIXChmM1GMg1bYfniB4i9bOQ6AOv8lD2yVN/K/CktTD/ycBgnsC+CCA
         91mA==
X-Gm-Message-State: AOAM533UA0jqSRVVeL5t+5tIGD0AsBsoo5e0kjAF+M2VQaDKwHLDQ/l+
        NZLj1fQol6uiLxq7ntc8Kn9e3hrwdjk=
X-Google-Smtp-Source: ABdhPJwddKbbOumOZ5hF5pKKIYUu3d+TFZLd88+RygiI3RhbxvzoHDsHcpWjBM5jlAyC7XWkBeG4cw==
X-Received: by 2002:a05:600c:414c:b0:37b:c80e:e3dc with SMTP id h12-20020a05600c414c00b0037bc80ee3dcmr3636046wmm.116.1644940792605;
        Tue, 15 Feb 2022 07:59:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k34sm15269438wms.35.2022.02.15.07.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 07:59:52 -0800 (PST)
Message-Id: <4a77f5b1fdef3af20fbfefccccc5fee194eb3422.1644940774.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Feb 2022 15:59:27 +0000
Subject: [PATCH 17/23] fsmonitor--daemon: stub in health thread
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create another thread to watch over the daemon process and
automatically shut it down if necessary.

This commit creates the basic framework for a "health" thread
to monitor the daemon and/or the file system.  Later commits
will add platform-specific code to do the actual work.

The "health" thread is intended to monitor conditions that
would be difficult to track inside the IPC thread pool and/or
the file system listener threads.  For example, when there are
file system events outside of the watched worktree root or if
we want to have an idle-timeout auto-shutdown feature.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile                             |  6 ++-
 builtin/fsmonitor--daemon.c          | 39 +++++++++++++++
 compat/fsmonitor/fsm-health-darwin.c | 24 ++++++++++
 compat/fsmonitor/fsm-health-win32.c  | 72 ++++++++++++++++++++++++++++
 compat/fsmonitor/fsm-health.h        | 47 ++++++++++++++++++
 contrib/buildsystems/CMakeLists.txt  |  2 +
 fsmonitor--daemon.h                  |  4 ++
 7 files changed, 192 insertions(+), 2 deletions(-)
 create mode 100644 compat/fsmonitor/fsm-health-darwin.c
 create mode 100644 compat/fsmonitor/fsm-health-win32.c
 create mode 100644 compat/fsmonitor/fsm-health.h

diff --git a/Makefile b/Makefile
index ed3d5231ea1..85a61934f21 100644
--- a/Makefile
+++ b/Makefile
@@ -467,8 +467,9 @@ all::
 #
 # If your platform supports a built-in fsmonitor backend, set
 # FSMONITOR_DAEMON_BACKEND to the "<name>" of the corresponding
-# `compat/fsmonitor/fsm-listen-<name>.c` that implements the
-# `fsm_listen__*()` routines.
+# `compat/fsmonitor/fsm-listen-<name>.c` and
+# `compat/fsmonitor/fsm-health-<name>.c` files
+# that implement the `fsm_listen__*()` and `fsm_health__*()` routines.
 #
 # If your platform has os-specific ways to tell if a repo is incompatible with
 # fsmonitor (whether the hook or ipc daemon version), set FSMONITOR_OS_SETTINGS
@@ -1944,6 +1945,7 @@ endif
 ifdef FSMONITOR_DAEMON_BACKEND
 	COMPAT_CFLAGS += -DHAVE_FSMONITOR_DAEMON_BACKEND
 	COMPAT_OBJS += compat/fsmonitor/fsm-listen-$(FSMONITOR_DAEMON_BACKEND).o
+	COMPAT_OBJS += compat/fsmonitor/fsm-health-$(FSMONITOR_DAEMON_BACKEND).o
 endif
 
 ifdef FSMONITOR_OS_SETTINGS
diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index f3fb865a9d8..591433e897d 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -3,6 +3,7 @@
 #include "parse-options.h"
 #include "fsmonitor.h"
 #include "fsmonitor-ipc.h"
+#include "compat/fsmonitor/fsm-health.h"
 #include "compat/fsmonitor/fsm-listen.h"
 #include "fsmonitor--daemon.h"
 #include "simple-ipc.h"
@@ -1124,6 +1125,18 @@ void fsmonitor_publish(struct fsmonitor_daemon_state *state,
 	pthread_mutex_unlock(&state->main_lock);
 }
 
+static void *fsm_health__thread_proc(void *_state)
+{
+	struct fsmonitor_daemon_state *state = _state;
+
+	trace2_thread_start("fsm-health");
+
+	fsm_health__loop(state);
+
+	trace2_thread_exit();
+	return NULL;
+}
+
 static void *fsm_listen__thread_proc(void *_state)
 {
 	struct fsmonitor_daemon_state *state = _state;
@@ -1162,6 +1175,7 @@ static int fsmonitor_run_daemon_1(struct fsmonitor_daemon_state *state)
 		 */
 		.uds_disallow_chdir = 0
 	};
+	int health_started = 0;
 	int listener_started = 0;
 	int err = 0;
 
@@ -1189,6 +1203,17 @@ static int fsmonitor_run_daemon_1(struct fsmonitor_daemon_state *state)
 	}
 	listener_started = 1;
 
+	/*
+	 * Start the health thread to watch over our process.
+	 */
+	if (pthread_create(&state->health_thread, NULL,
+			   fsm_health__thread_proc, state) < 0) {
+		ipc_server_stop_async(state->ipc_server_data);
+		err = error(_("could not start fsmonitor health thread"));
+		goto cleanup;
+	}
+	health_started = 1;
+
 	/*
 	 * The daemon is now fully functional in background threads.
 	 * Our primary thread should now just wait while the threads
@@ -1211,10 +1236,17 @@ cleanup:
 		pthread_join(state->listener_thread, NULL);
 	}
 
+	if (health_started) {
+		fsm_health__stop_async(state);
+		pthread_join(state->health_thread, NULL);
+	}
+
 	if (err)
 		return err;
 	if (state->listen_error_code)
 		return state->listen_error_code;
+	if (state->health_error_code)
+		return state->health_error_code;
 	return 0;
 }
 
@@ -1230,6 +1262,7 @@ static int fsmonitor_run_daemon(void)
 	pthread_mutex_init(&state.main_lock, NULL);
 	pthread_cond_init(&state.cookies_cond, NULL);
 	state.listen_error_code = 0;
+	state.health_error_code = 0;
 	state.current_token_data = fsmonitor_new_token_data();
 
 	/* Prepare to (recursively) watch the <worktree-root> directory. */
@@ -1309,6 +1342,11 @@ static int fsmonitor_run_daemon(void)
 		goto done;
 	}
 
+	if (fsm_health__ctor(&state)) {
+		err = error(_("could not initialize health thread"));
+		goto done;
+	}
+
 	/*
 	 * CD out of the worktree root directory.
 	 *
@@ -1332,6 +1370,7 @@ done:
 	pthread_cond_destroy(&state.cookies_cond);
 	pthread_mutex_destroy(&state.main_lock);
 	fsm_listen__dtor(&state);
+	fsm_health__dtor(&state);
 
 	ipc_server_free(state.ipc_server_data);
 
diff --git a/compat/fsmonitor/fsm-health-darwin.c b/compat/fsmonitor/fsm-health-darwin.c
new file mode 100644
index 00000000000..b9f709e8548
--- /dev/null
+++ b/compat/fsmonitor/fsm-health-darwin.c
@@ -0,0 +1,24 @@
+#include "cache.h"
+#include "config.h"
+#include "fsmonitor.h"
+#include "fsm-health.h"
+#include "fsmonitor--daemon.h"
+
+int fsm_health__ctor(struct fsmonitor_daemon_state *state)
+{
+	return 0;
+}
+
+void fsm_health__dtor(struct fsmonitor_daemon_state *state)
+{
+	return;
+}
+
+void fsm_health__loop(struct fsmonitor_daemon_state *state)
+{
+	return;
+}
+
+void fsm_health__stop_async(struct fsmonitor_daemon_state *state)
+{
+}
diff --git a/compat/fsmonitor/fsm-health-win32.c b/compat/fsmonitor/fsm-health-win32.c
new file mode 100644
index 00000000000..94b1d020f25
--- /dev/null
+++ b/compat/fsmonitor/fsm-health-win32.c
@@ -0,0 +1,72 @@
+#include "cache.h"
+#include "config.h"
+#include "fsmonitor.h"
+#include "fsm-health.h"
+#include "fsmonitor--daemon.h"
+
+struct fsm_health_data
+{
+	HANDLE hEventShutdown;
+
+	HANDLE hHandles[1]; /* the array does not own these handles */
+#define HEALTH_SHUTDOWN 0
+	int nr_handles; /* number of active event handles */
+};
+
+int fsm_health__ctor(struct fsmonitor_daemon_state *state)
+{
+	struct fsm_health_data *data;
+
+	CALLOC_ARRAY(data, 1);
+
+	data->hEventShutdown = CreateEvent(NULL, TRUE, FALSE, NULL);
+
+	data->hHandles[HEALTH_SHUTDOWN] = data->hEventShutdown;
+	data->nr_handles++;
+
+	state->health_data = data;
+	return 0;
+}
+
+void fsm_health__dtor(struct fsmonitor_daemon_state *state)
+{
+	struct fsm_health_data *data;
+
+	if (!state || !state->health_data)
+		return;
+
+	data = state->health_data;
+
+	CloseHandle(data->hEventShutdown);
+
+	FREE_AND_NULL(state->health_data);
+}
+
+void fsm_health__loop(struct fsmonitor_daemon_state *state)
+{
+	struct fsm_health_data *data = state->health_data;
+
+	for (;;) {
+		DWORD dwWait = WaitForMultipleObjects(data->nr_handles,
+						      data->hHandles,
+						      FALSE, INFINITE);
+
+		if (dwWait == WAIT_OBJECT_0 + HEALTH_SHUTDOWN)
+			goto clean_shutdown;
+
+		error(_("health thread wait failed [GLE %ld]"),
+		      GetLastError());
+		goto force_error_stop;
+	}
+
+force_error_stop:
+	state->health_error_code = -1;
+	ipc_server_stop_async(state->ipc_server_data);
+clean_shutdown:
+	return;
+}
+
+void fsm_health__stop_async(struct fsmonitor_daemon_state *state)
+{
+	SetEvent(state->health_data->hHandles[HEALTH_SHUTDOWN]);
+}
diff --git a/compat/fsmonitor/fsm-health.h b/compat/fsmonitor/fsm-health.h
new file mode 100644
index 00000000000..45547ba9380
--- /dev/null
+++ b/compat/fsmonitor/fsm-health.h
@@ -0,0 +1,47 @@
+#ifndef FSM_HEALTH_H
+#define FSM_HEALTH_H
+
+/* This needs to be implemented by each backend */
+
+#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
+
+struct fsmonitor_daemon_state;
+
+/*
+ * Initialize platform-specific data for the fsmonitor health thread.
+ * This will be called from the main thread PRIOR to staring the
+ * thread.
+ *
+ * Returns 0 if successful.
+ * Returns -1 otherwise.
+ */
+int fsm_health__ctor(struct fsmonitor_daemon_state *state);
+
+/*
+ * Cleanup platform-specific data for the health thread.
+ * This will be called from the main thread AFTER joining the thread.
+ */
+void fsm_health__dtor(struct fsmonitor_daemon_state *state);
+
+/*
+ * The main body of the platform-specific event loop to monitor the
+ * health of the daemon process.  This will run in the health thread.
+ *
+ * The health thread should call `ipc_server_stop_async()` if it needs
+ * to cause a shutdown.  (It should NOT do so if it receives a shutdown
+ * shutdown signal.)
+ *
+ * It should set `state->health_error_code` to -1 if the daemon should exit
+ * with an error.
+ */
+void fsm_health__loop(struct fsmonitor_daemon_state *state);
+
+/*
+ * Gently request that the health thread shutdown.
+ * It does not wait for it to stop.  The caller should do a JOIN
+ * to wait for it.
+ */
+void fsm_health__stop_async(struct fsmonitor_daemon_state *state);
+
+#endif /* HAVE_FSMONITOR_DAEMON_BACKEND */
+#endif /* FSM_HEALTH_H */
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index fc70dd2fc1d..80704406895 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -289,12 +289,14 @@ if(SUPPORTS_SIMPLE_IPC)
 	if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
 		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-win32.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-win32.c)
 
 		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-win32.c)
 	elseif(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
 		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-darwin.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-darwin.c)
 
 		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-darwin.c)
diff --git a/fsmonitor--daemon.h b/fsmonitor--daemon.h
index f7de7882517..716e0e4d28d 100644
--- a/fsmonitor--daemon.h
+++ b/fsmonitor--daemon.h
@@ -34,9 +34,11 @@ void fsmonitor_batch__free_list(struct fsmonitor_batch *batch);
 void fsmonitor_batch__add_path(struct fsmonitor_batch *batch, const char *path);
 
 struct fsm_listen_data; /* opaque platform-specific data for listener thread */
+struct fsm_health_data; /* opaque platform-specific data for health thread */
 
 struct fsmonitor_daemon_state {
 	pthread_t listener_thread;
+	pthread_t health_thread;
 	pthread_mutex_t main_lock;
 
 	struct strbuf path_worktree_watch;
@@ -51,7 +53,9 @@ struct fsmonitor_daemon_state {
 	struct hashmap cookies;
 
 	int listen_error_code;
+	int health_error_code;
 	struct fsm_listen_data *listen_data;
+	struct fsm_health_data *health_data;
 
 	struct ipc_server_data *ipc_server_data;
 	struct strbuf path_ipc;
-- 
gitgitgadget

