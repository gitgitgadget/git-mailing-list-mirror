Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C069C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 18:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237155AbiCASpb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 13:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237088AbiCASoz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 13:44:55 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132C665433
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 10:43:51 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id a13-20020a05600c348d00b0038188b8bbf6so1764657wmq.0
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 10:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mCf+Ca1Eq79Fi9zXUbnlpDuLKRfsCLBNqTWp408Mz/w=;
        b=HZo2FCXp5uvYmEbeRTk42A5Xb9BAsNAIEWJ9zQJRsW8Th84eCzaAQuGcOyoMECE2L9
         2w1iwyemBACstlhYLZh47blU+kkUJyPtsYHEmy9ZmZsbT94R4806Kmd2soBiv2XdPPQ+
         NVfUjDJhwy+c0e/syeF0jvfS68gQODWNYw9Zhb4X7OrNkHJy8YYr56QBPq3I3WbdB5yx
         VXBD1o+wd3YZ3WSELtcSO2epq1OlIg+uOVoHR1eY6OwlA98jMWFMWzZJ6QuqNmsoL6S6
         oT5TSK9vembatkkChZHjdvcLEgFd7/Ae9hprEX/tDtVK06PaCYtoqGTT6Rx8zZWVcxAy
         CIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mCf+Ca1Eq79Fi9zXUbnlpDuLKRfsCLBNqTWp408Mz/w=;
        b=UyYtz3/+c0HXs+X5nt/hV+QKtooufG/JyB2KNpccijUpSl58Etpo9owMG7m1ZBbuLi
         HDDAFC7fJ1EHOmpPR1VqfIBEqcxscA/Jn/HiSCC67jKztjVguA5TPPiHWq1Wc4YJERwa
         acBo3yWrYQ3rBJ98uuM1wDDs8gOQuIkjz5Zx5/p3hJqzdtq4xkmF0pA84EL6yn3t85f1
         CX3wByR0IhN23U9xlDJZWVaWG9Xas8UohCIoMdoYnlf4XrNNHEOYd6wXlknkgRd474/o
         OTm0G+rdb0VPNYLkF+C6YpXigGYEwD0cXl3rqBrt49tVFyuNqR3UDIYJO5xSvHu+7M2r
         qFtA==
X-Gm-Message-State: AOAM533nmRMuLuPy40GN3yKtbrOpO1bDeBGJ2Oqv76FcfuMO2J9J7wOL
        Q8uA+KVwwWtv0HTmRsETJFFO9I9Ug3Q=
X-Google-Smtp-Source: ABdhPJyUT5Uy6Z3yeZfZkDrSdg3zd8/a84RymEmIudDTgU/7YWkbMuFFQ7XxjCvYU/CnxNew6n3wBQ==
X-Received: by 2002:a05:600c:230a:b0:381:67e7:e207 with SMTP id 10-20020a05600c230a00b0038167e7e207mr8597180wmo.36.1646160229268;
        Tue, 01 Mar 2022 10:43:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m11-20020adff38b000000b001ef879a5930sm11058372wro.61.2022.03.01.10.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 10:43:48 -0800 (PST)
Message-Id: <aabfebd3a41208091d9738c60ffd27573f4faa28.1646160212.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
References: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
        <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 18:43:19 +0000
Subject: [PATCH v6 17/30] compat/fsmonitor/fsm-listen-darwin: implement
 FSEvent listener on MacOS
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

Implement file system event listener on MacOS using FSEvent,
CoreFoundation, and CoreServices.

Co-authored-by: Kevin Willford <Kevin.Willford@microsoft.com>
Co-authored-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 compat/fsmonitor/fsm-listen-darwin.c | 383 +++++++++++++++++++++++++++
 1 file changed, 383 insertions(+)

diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index f76341317dd..5c5de1ae702 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -97,20 +97,403 @@ void FSEventStreamRelease(FSEventStreamRef stream);
 #include "cache.h"
 #include "fsmonitor.h"
 #include "fsm-listen.h"
+#include "fsmonitor--daemon.h"
+
+struct fsmonitor_daemon_backend_data
+{
+	CFStringRef cfsr_worktree_path;
+	CFStringRef cfsr_gitdir_path;
+
+	CFArrayRef cfar_paths_to_watch;
+	int nr_paths_watching;
+
+	FSEventStreamRef stream;
+
+	CFRunLoopRef rl;
+
+	enum shutdown_style {
+		SHUTDOWN_EVENT = 0,
+		FORCE_SHUTDOWN,
+		FORCE_ERROR_STOP,
+	} shutdown_style;
+
+	unsigned int stream_scheduled:1;
+	unsigned int stream_started:1;
+};
+
+static void log_flags_set(const char *path, const FSEventStreamEventFlags flag)
+{
+	struct strbuf msg = STRBUF_INIT;
+
+	if (flag & kFSEventStreamEventFlagMustScanSubDirs)
+		strbuf_addstr(&msg, "MustScanSubDirs|");
+	if (flag & kFSEventStreamEventFlagUserDropped)
+		strbuf_addstr(&msg, "UserDropped|");
+	if (flag & kFSEventStreamEventFlagKernelDropped)
+		strbuf_addstr(&msg, "KernelDropped|");
+	if (flag & kFSEventStreamEventFlagEventIdsWrapped)
+		strbuf_addstr(&msg, "EventIdsWrapped|");
+	if (flag & kFSEventStreamEventFlagHistoryDone)
+		strbuf_addstr(&msg, "HistoryDone|");
+	if (flag & kFSEventStreamEventFlagRootChanged)
+		strbuf_addstr(&msg, "RootChanged|");
+	if (flag & kFSEventStreamEventFlagMount)
+		strbuf_addstr(&msg, "Mount|");
+	if (flag & kFSEventStreamEventFlagUnmount)
+		strbuf_addstr(&msg, "Unmount|");
+	if (flag & kFSEventStreamEventFlagItemChangeOwner)
+		strbuf_addstr(&msg, "ItemChangeOwner|");
+	if (flag & kFSEventStreamEventFlagItemCreated)
+		strbuf_addstr(&msg, "ItemCreated|");
+	if (flag & kFSEventStreamEventFlagItemFinderInfoMod)
+		strbuf_addstr(&msg, "ItemFinderInfoMod|");
+	if (flag & kFSEventStreamEventFlagItemInodeMetaMod)
+		strbuf_addstr(&msg, "ItemInodeMetaMod|");
+	if (flag & kFSEventStreamEventFlagItemIsDir)
+		strbuf_addstr(&msg, "ItemIsDir|");
+	if (flag & kFSEventStreamEventFlagItemIsFile)
+		strbuf_addstr(&msg, "ItemIsFile|");
+	if (flag & kFSEventStreamEventFlagItemIsHardlink)
+		strbuf_addstr(&msg, "ItemIsHardlink|");
+	if (flag & kFSEventStreamEventFlagItemIsLastHardlink)
+		strbuf_addstr(&msg, "ItemIsLastHardlink|");
+	if (flag & kFSEventStreamEventFlagItemIsSymlink)
+		strbuf_addstr(&msg, "ItemIsSymlink|");
+	if (flag & kFSEventStreamEventFlagItemModified)
+		strbuf_addstr(&msg, "ItemModified|");
+	if (flag & kFSEventStreamEventFlagItemRemoved)
+		strbuf_addstr(&msg, "ItemRemoved|");
+	if (flag & kFSEventStreamEventFlagItemRenamed)
+		strbuf_addstr(&msg, "ItemRenamed|");
+	if (flag & kFSEventStreamEventFlagItemXattrMod)
+		strbuf_addstr(&msg, "ItemXattrMod|");
+	if (flag & kFSEventStreamEventFlagOwnEvent)
+		strbuf_addstr(&msg, "OwnEvent|");
+	if (flag & kFSEventStreamEventFlagItemCloned)
+		strbuf_addstr(&msg, "ItemCloned|");
+
+	trace_printf_key(&trace_fsmonitor, "fsevent: '%s', flags=%u %s",
+			 path, flag, msg.buf);
+
+	strbuf_release(&msg);
+}
+
+static int ef_is_root_delete(const FSEventStreamEventFlags ef)
+{
+	return (ef & kFSEventStreamEventFlagItemIsDir &&
+		ef & kFSEventStreamEventFlagItemRemoved);
+}
+
+static int ef_is_root_renamed(const FSEventStreamEventFlags ef)
+{
+	return (ef & kFSEventStreamEventFlagItemIsDir &&
+		ef & kFSEventStreamEventFlagItemRenamed);
+}
+
+static int ef_is_dropped(const FSEventStreamEventFlags ef)
+{
+	return (ef & kFSEventStreamEventFlagMustScanSubDirs ||
+		ef & kFSEventStreamEventFlagKernelDropped ||
+		ef & kFSEventStreamEventFlagUserDropped);
+}
+
+static void fsevent_callback(ConstFSEventStreamRef streamRef,
+			     void *ctx,
+			     size_t num_of_events,
+			     void *event_paths,
+			     const FSEventStreamEventFlags event_flags[],
+			     const FSEventStreamEventId event_ids[])
+{
+	struct fsmonitor_daemon_state *state = ctx;
+	struct fsmonitor_daemon_backend_data *data = state->backend_data;
+	char **paths = (char **)event_paths;
+	struct fsmonitor_batch *batch = NULL;
+	struct string_list cookie_list = STRING_LIST_INIT_DUP;
+	const char *path_k;
+	const char *slash;
+	int k;
+	struct strbuf tmp = STRBUF_INIT;
+
+	/*
+	 * Build a list of all filesystem changes into a private/local
+	 * list and without holding any locks.
+	 */
+	for (k = 0; k < num_of_events; k++) {
+		/*
+		 * On Mac, we receive an array of absolute paths.
+		 */
+		path_k = paths[k];
+
+		/*
+		 * If you want to debug FSEvents, log them to GIT_TRACE_FSMONITOR.
+		 * Please don't log them to Trace2.
+		 *
+		 * trace_printf_key(&trace_fsmonitor, "Path: '%s'", path_k);
+		 */
+
+		/*
+		 * If event[k] is marked as dropped, we assume that we have
+		 * lost sync with the filesystem and should flush our cached
+		 * data.  We need to:
+		 *
+		 * [1] Abort/wake any client threads waiting for a cookie and
+		 *     flush the cached state data (the current token), and
+		 *     create a new token.
+		 *
+		 * [2] Discard the batch that we were locally building (since
+		 *     they are conceptually relative to the just flushed
+		 *     token).
+		 */
+		if (ef_is_dropped(event_flags[k])) {
+			if (trace_pass_fl(&trace_fsmonitor))
+				log_flags_set(path_k, event_flags[k]);
+
+			fsmonitor_force_resync(state);
+			fsmonitor_batch__free_list(batch);
+			string_list_clear(&cookie_list, 0);
+
+			/*
+			 * We assume that any events that we received
+			 * in this callback after this dropped event
+			 * may still be valid, so we continue rather
+			 * than break.  (And just in case there is a
+			 * delete of ".git" hiding in there.)
+			 */
+			continue;
+		}
+
+		switch (fsmonitor_classify_path_absolute(state, path_k)) {
+
+		case IS_INSIDE_DOT_GIT_WITH_COOKIE_PREFIX:
+		case IS_INSIDE_GITDIR_WITH_COOKIE_PREFIX:
+			/* special case cookie files within .git or gitdir */
+
+			/* Use just the filename of the cookie file. */
+			slash = find_last_dir_sep(path_k);
+			string_list_append(&cookie_list,
+					   slash ? slash + 1 : path_k);
+			break;
+
+		case IS_INSIDE_DOT_GIT:
+		case IS_INSIDE_GITDIR:
+			/* ignore all other paths inside of .git or gitdir */
+			break;
+
+		case IS_DOT_GIT:
+		case IS_GITDIR:
+			/*
+			 * If .git directory is deleted or renamed away,
+			 * we have to quit.
+			 */
+			if (ef_is_root_delete(event_flags[k])) {
+				trace_printf_key(&trace_fsmonitor,
+						 "event: gitdir removed");
+				goto force_shutdown;
+			}
+			if (ef_is_root_renamed(event_flags[k])) {
+				trace_printf_key(&trace_fsmonitor,
+						 "event: gitdir renamed");
+				goto force_shutdown;
+			}
+			break;
+
+		case IS_WORKDIR_PATH:
+			/* try to queue normal pathnames */
+
+			if (trace_pass_fl(&trace_fsmonitor))
+				log_flags_set(path_k, event_flags[k]);
+
+			/*
+			 * Because of the implicit "binning" (the
+			 * kernel calls us at a given frequency) and
+			 * de-duping (the kernel is free to combine
+			 * multiple events for a given pathname), an
+			 * individual fsevent could be marked as both
+			 * a file and directory.  Add it to the queue
+			 * with both spellings so that the client will
+			 * know how much to invalidate/refresh.
+			 */
+
+			if (event_flags[k] & kFSEventStreamEventFlagItemIsFile) {
+				const char *rel = path_k +
+					state->path_worktree_watch.len + 1;
+
+				if (!batch)
+					batch = fsmonitor_batch__new();
+				fsmonitor_batch__add_path(batch, rel);
+			}
+
+			if (event_flags[k] & kFSEventStreamEventFlagItemIsDir) {
+				const char *rel = path_k +
+					state->path_worktree_watch.len + 1;
+
+				strbuf_reset(&tmp);
+				strbuf_addstr(&tmp, rel);
+				strbuf_addch(&tmp, '/');
+
+				if (!batch)
+					batch = fsmonitor_batch__new();
+				fsmonitor_batch__add_path(batch, tmp.buf);
+			}
+
+			break;
+
+		case IS_OUTSIDE_CONE:
+		default:
+			trace_printf_key(&trace_fsmonitor,
+					 "ignoring '%s'", path_k);
+			break;
+		}
+	}
+
+	fsmonitor_publish(state, batch, &cookie_list);
+	string_list_clear(&cookie_list, 0);
+	strbuf_release(&tmp);
+	return;
+
+force_shutdown:
+	fsmonitor_batch__free_list(batch);
+	string_list_clear(&cookie_list, 0);
+
+	data->shutdown_style = FORCE_SHUTDOWN;
+	CFRunLoopStop(data->rl);
+	strbuf_release(&tmp);
+	return;
+}
+
+/*
+ * In the call to `FSEventStreamCreate()` to setup our watch, the
+ * `latency` argument determines the frequency of calls to our callback
+ * with new FS events.  Too slow and events get dropped; too fast and
+ * we burn CPU unnecessarily.  Since it is rather obscure, I don't
+ * think this needs to be a config setting.  I've done extensive
+ * testing on my systems and chosen the value below.  It gives good
+ * results and I've not seen any dropped events.
+ *
+ * With a latency of 0.1, I was seeing lots of dropped events during
+ * the "touch 100000" files test within t/perf/p7519, but with a
+ * latency of 0.001 I did not see any dropped events.  So I'm going
+ * to assume that this is the "correct" value.
+ *
+ * https://developer.apple.com/documentation/coreservices/1443980-fseventstreamcreate
+ */
 
 int fsm_listen__ctor(struct fsmonitor_daemon_state *state)
 {
+	FSEventStreamCreateFlags flags = kFSEventStreamCreateFlagNoDefer |
+		kFSEventStreamCreateFlagWatchRoot |
+		kFSEventStreamCreateFlagFileEvents;
+	FSEventStreamContext ctx = {
+		0,
+		state,
+		NULL,
+		NULL,
+		NULL
+	};
+	struct fsmonitor_daemon_backend_data *data;
+	const void *dir_array[2];
+
+	CALLOC_ARRAY(data, 1);
+	state->backend_data = data;
+
+	data->cfsr_worktree_path = CFStringCreateWithCString(
+		NULL, state->path_worktree_watch.buf, kCFStringEncodingUTF8);
+	dir_array[data->nr_paths_watching++] = data->cfsr_worktree_path;
+
+	if (state->nr_paths_watching > 1) {
+		data->cfsr_gitdir_path = CFStringCreateWithCString(
+			NULL, state->path_gitdir_watch.buf,
+			kCFStringEncodingUTF8);
+		dir_array[data->nr_paths_watching++] = data->cfsr_gitdir_path;
+	}
+
+	data->cfar_paths_to_watch = CFArrayCreate(NULL, dir_array,
+						  data->nr_paths_watching,
+						  NULL);
+	data->stream = FSEventStreamCreate(NULL, fsevent_callback, &ctx,
+					   data->cfar_paths_to_watch,
+					   kFSEventStreamEventIdSinceNow,
+					   0.001, flags);
+	if (data->stream == NULL)
+		goto failed;
+
+	/*
+	 * `data->rl` needs to be set inside the listener thread.
+	 */
+
+	return 0;
+
+failed:
+	error("Unable to create FSEventStream.");
+
+	FREE_AND_NULL(state->backend_data);
 	return -1;
 }
 
 void fsm_listen__dtor(struct fsmonitor_daemon_state *state)
 {
+	struct fsmonitor_daemon_backend_data *data;
+
+	if (!state || !state->backend_data)
+		return;
+
+	data = state->backend_data;
+
+	if (data->stream) {
+		if (data->stream_started)
+			FSEventStreamStop(data->stream);
+		if (data->stream_scheduled)
+			FSEventStreamInvalidate(data->stream);
+		FSEventStreamRelease(data->stream);
+	}
+
+	FREE_AND_NULL(state->backend_data);
 }
 
 void fsm_listen__stop_async(struct fsmonitor_daemon_state *state)
 {
+	struct fsmonitor_daemon_backend_data *data;
+
+	data = state->backend_data;
+	data->shutdown_style = SHUTDOWN_EVENT;
+
+	CFRunLoopStop(data->rl);
 }
 
 void fsm_listen__loop(struct fsmonitor_daemon_state *state)
 {
+	struct fsmonitor_daemon_backend_data *data;
+
+	data = state->backend_data;
+
+	data->rl = CFRunLoopGetCurrent();
+
+	FSEventStreamScheduleWithRunLoop(data->stream, data->rl, kCFRunLoopDefaultMode);
+	data->stream_scheduled = 1;
+
+	if (!FSEventStreamStart(data->stream)) {
+		error("Failed to start the FSEventStream");
+		goto force_error_stop_without_loop;
+	}
+	data->stream_started = 1;
+
+	CFRunLoopRun();
+
+	switch (data->shutdown_style) {
+	case FORCE_ERROR_STOP:
+		state->error_code = -1;
+		/* fall thru */
+	case FORCE_SHUTDOWN:
+		ipc_server_stop_async(state->ipc_server_data);
+		/* fall thru */
+	case SHUTDOWN_EVENT:
+	default:
+		break;
+	}
+	return;
+
+force_error_stop_without_loop:
+	state->error_code = -1;
+	ipc_server_stop_async(state->ipc_server_data);
+	return;
 }
-- 
gitgitgadget

