Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5613312C49C
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 09:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727862430; cv=none; b=vFDCBgVe8cqOQg87GPQ+wbHuoC3geMgRK8L1+vp2cm4OjGJK+KzaMrh0GnZPEdpYpuKQMUtRIjitT4ImRIAvWE94Ge3Qrhdx9uZV7yXL4e4ZgsU2NuLdvyLzFu7bjwJrq00/c/01sYYFVNqU16I54s5EGe7cQ1wsghO/7UUT39c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727862430; c=relaxed/simple;
	bh=YF8LqIHJAR1NXX7M2X+xEvOg/yv/eZy9tMmjeO2JiYc=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=sAXPgDM67XsLBnEVeuXfR5cSsDwikCSCv1V/O66TfnU8WHhcgrSZVKcwV7FBnuvGFazpmfeKLzb9QsarLtu+eznUumOIOTuZUXLx/F5IKCGDBxTTJ9NXTkpvHwJpvrNYQewJTyRKFPKn8RIFrQClWNh5TEuZHDNSaNnpUrm5YTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nehRQ2sr; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nehRQ2sr"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8d2b4a5bf1so880749566b.2
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 02:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727862426; x=1728467226; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VXlLC0sRm5kTH3gEik+grfLQKlwkKC2L6+TzNeeHU0E=;
        b=nehRQ2sr8Ep7WbxLA2K7nIwWsBATAgi+VIerpYuYUFIWVvCwUt8CN6Gxqu9MRYiu6j
         Eehn1dwSP8lvtKRn1Jd3M0/26UT9ohD1bRJy6noYATALEdk94A8uMHtrCSx5xY8LIo4t
         R5tO2RTv9zgkvRIrSeHujDr4EfC/+Nr49MqgeLJMEqtkwm0mOP/tMeENNQINfK/IX0Ca
         /3LdXfemEEc3I5gnhR38iGuMWz27sXA7tCnCQ4qOzV7B/ASqBrO6tTPYOocXjZDg012s
         zs/anSWJuO61ZXB6lll3p32eCUzRB/ohniWAtHaJ7ehHK8B00KiGpQ8zFjwiRoAf/rE3
         KKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727862426; x=1728467226;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VXlLC0sRm5kTH3gEik+grfLQKlwkKC2L6+TzNeeHU0E=;
        b=ON+Z16tifFf+B8ZHD+vLe7a201q2v+Sv95vJhl/duimTFqr8xlIcUJREtREhIchJph
         752UhnORTxSY5ClpVk8+z2HbX1o6tdoKRM3ogDebuNp1P6Us4c2HCrYX8Nd11jpAsXX3
         f5e4nQhMlxmJ+P4sxF2kh+OvInyumM7fMazUVBdbqAFkBlGhMqRaNTxf+Y0qNCQXSPVL
         t84Kj0D1bu0DkrEPkhMjNJB5VIC8bs3g5on+Xd2bYu0w4axqQCXEw754tvuNSV1bzTVX
         eG26uudWggxLHVcpJ3H2g41+cKxgvaXMg8vj94wAdgzSl4ZC5W7xxeX1N/vX3Gs8eAgf
         jACQ==
X-Gm-Message-State: AOJu0YzxLnSYkp6o8szW1s/XiflUr9IxGmPiqbK/s6olu33npBTSIdra
	qFqBqsQpLaEdw0fOF6VrNi0he6GQ0gFMzKGSLnjXa9jgfmn6V3RxiVKZ7Q==
X-Google-Smtp-Source: AGHT+IGQDoXPaNlhVKFCMP+5vMN+rt2JaW/ECDJwbvOptiInV+gvDLa4Hlos3IxM8I4xB3CVyMc1Hg==
X-Received: by 2002:a17:907:9304:b0:a77:f2c5:84a9 with SMTP id a640c23a62f3a-a98f821de96mr289219566b.18.1727862426001;
        Wed, 02 Oct 2024 02:47:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c29844a1sm855596166b.172.2024.10.02.02.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 02:47:05 -0700 (PDT)
Message-Id: <pull.1804.git.1727862424713.gitgitgadget@gmail.com>
From: "Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 02 Oct 2024 09:47:04 +0000
Subject: [PATCH] fsmonitor: fix hangs by delayed fs event listening
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
    Koji Nakamaru <koji.nakamaru@gree.net>,
    Koji Nakamaru <koji.nakamaru@gree.net>

From: Koji Nakamaru <koji.nakamaru@gree.net>

The thread serving the client (ipc-thread) calls
with_lock__wait_for_cookie() in which a cookie file is
created. with_lock__wait_for_cookie() then waits for the event caused by
the cookie file from the thread for fs events (fsevent-thread).

However, in high load situations, the fsevent-thread may start actual fs
event listening (triggered by FSEventStreamStart() for Darwin, for
example) *after* the cookie file is created. In this case, the
fsevent-thread cannot detect the cookie file and
with_lock__wait_for_cookie() waits forever, so that the whole daemon
hangs [1].

Extend listen_error_code to express that actual fs event listening
starts. listen_error_code is accessed in a thread-safe manner by
utilizing a dedicated mutex.

[1]: https://lore.kernel.org/git/20241002062539.GA2863841@coredump.intra.peff.net/

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Koji Nakamaru <koji.nakamaru@gree.net>
---
    fsmonitor: fix hangs by delayed fs event listening

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1804%2FKojiNakamaru%2Ffix%2Ffsmonitor-deadlock-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1804/KojiNakamaru/fix/fsmonitor-deadlock-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1804

 builtin/fsmonitor--daemon.c          | 21 +++++++++++++++++++++
 compat/fsmonitor/fsm-listen-darwin.c |  5 +++--
 compat/fsmonitor/fsm-listen-win32.c  |  5 ++---
 fsmonitor--daemon.h                  |  4 ++++
 4 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index dce8a3b2482..ccff2cb8bed 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -172,6 +172,9 @@ static enum fsmonitor_cookie_item_result with_lock__wait_for_cookie(
 	trace_printf_key(&trace_fsmonitor, "cookie-wait: '%s' '%s'",
 			 cookie->name, cookie_pathname.buf);
 
+	while (fsmonitor_get_listen_error_code(state) == 0)
+		sleep_millisec(50);
+
 	/*
 	 * Create the cookie file on disk and then wait for a notification
 	 * that the listener thread has seen it.
@@ -606,6 +609,23 @@ void fsmonitor_force_resync(struct fsmonitor_daemon_state *state)
 	pthread_mutex_unlock(&state->main_lock);
 }
 
+int fsmonitor_get_listen_error_code(struct fsmonitor_daemon_state *state)
+{
+	int error_code;
+
+	pthread_mutex_lock(&state->listen_lock);
+	error_code = state->listen_error_code;
+	pthread_mutex_unlock(&state->listen_lock);
+	return error_code;
+}
+
+void fsmonitor_set_listen_error_code(struct fsmonitor_daemon_state *state, int error_code)
+{
+	pthread_mutex_lock(&state->listen_lock);
+	state->listen_error_code = error_code;
+	pthread_mutex_unlock(&state->listen_lock);
+}
+
 /*
  * Format an opaque token string to send to the client.
  */
@@ -1285,6 +1305,7 @@ static int fsmonitor_run_daemon(void)
 	hashmap_init(&state.cookies, cookies_cmp, NULL, 0);
 	pthread_mutex_init(&state.main_lock, NULL);
 	pthread_cond_init(&state.cookies_cond, NULL);
+	pthread_mutex_init(&state.listen_lock, NULL);
 	state.listen_error_code = 0;
 	state.health_error_code = 0;
 	state.current_token_data = fsmonitor_new_token_data();
diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index 2fc67442eb5..92373ce247f 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -515,6 +515,7 @@ void fsm_listen__loop(struct fsmonitor_daemon_state *state)
 		goto force_error_stop_without_loop;
 	}
 	data->stream_started = 1;
+	fsmonitor_set_listen_error_code(state, 1);
 
 	pthread_mutex_lock(&data->dq_lock);
 	pthread_cond_wait(&data->dq_finished, &data->dq_lock);
@@ -522,7 +523,7 @@ void fsm_listen__loop(struct fsmonitor_daemon_state *state)
 
 	switch (data->shutdown_style) {
 	case FORCE_ERROR_STOP:
-		state->listen_error_code = -1;
+		fsmonitor_set_listen_error_code(state, -1);
 		/* fall thru */
 	case FORCE_SHUTDOWN:
 		ipc_server_stop_async(state->ipc_server_data);
@@ -534,7 +535,7 @@ void fsm_listen__loop(struct fsmonitor_daemon_state *state)
 	return;
 
 force_error_stop_without_loop:
-	state->listen_error_code = -1;
+	fsmonitor_set_listen_error_code(state, -1);
 	ipc_server_stop_async(state->ipc_server_data);
 	return;
 }
diff --git a/compat/fsmonitor/fsm-listen-win32.c b/compat/fsmonitor/fsm-listen-win32.c
index 5a21dade7b8..609efd1d6a8 100644
--- a/compat/fsmonitor/fsm-listen-win32.c
+++ b/compat/fsmonitor/fsm-listen-win32.c
@@ -732,14 +732,13 @@ void fsm_listen__loop(struct fsmonitor_daemon_state *state)
 	DWORD dwWait;
 	int result;
 
-	state->listen_error_code = 0;
-
 	if (start_rdcw_watch(data->watch_worktree) == -1)
 		goto force_error_stop;
 
 	if (data->watch_gitdir &&
 	    start_rdcw_watch(data->watch_gitdir) == -1)
 		goto force_error_stop;
+	fsmonitor_set_listen_error_code(state, 1);
 
 	for (;;) {
 		dwWait = WaitForMultipleObjects(data->nr_listener_handles,
@@ -797,7 +796,7 @@ void fsm_listen__loop(struct fsmonitor_daemon_state *state)
 	}
 
 force_error_stop:
-	state->listen_error_code = -1;
+	fsmonitor_set_listen_error_code(state, -1);
 
 force_shutdown:
 	/*
diff --git a/fsmonitor--daemon.h b/fsmonitor--daemon.h
index 5cbbec8d940..77efc59b7bb 100644
--- a/fsmonitor--daemon.h
+++ b/fsmonitor--daemon.h
@@ -51,6 +51,7 @@ struct fsmonitor_daemon_state {
 	int cookie_seq;
 	struct hashmap cookies;
 
+	pthread_mutex_t listen_lock;
 	int listen_error_code;
 	int health_error_code;
 	struct fsm_listen_data *listen_data;
@@ -167,5 +168,8 @@ void fsmonitor_publish(struct fsmonitor_daemon_state *state,
  */
 void fsmonitor_force_resync(struct fsmonitor_daemon_state *state);
 
+int fsmonitor_get_listen_error_code(struct fsmonitor_daemon_state *state);
+void fsmonitor_set_listen_error_code(struct fsmonitor_daemon_state *state, int error_code);
+
 #endif /* HAVE_FSMONITOR_DAEMON_BACKEND */
 #endif /* FSMONITOR_DAEMON_H */

base-commit: e9356ba3ea2a6754281ff7697b3e5a1697b21e24
-- 
gitgitgadget
