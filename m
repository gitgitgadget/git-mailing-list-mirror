Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F59C433FE
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiCYTaX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiCYTaK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:30:10 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D8C1DC98D
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:04:50 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id v130-20020a1cac88000000b00389d0a5c511so9510871wme.5
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8pCLbO4RGMt9FhNM1rARjgkn1qpV57NBDORbLzqjDVc=;
        b=WZjiHWbiP7Ct5fsqdFWscLCduan9E+R3Pb+KQPOVjIpDgVLuUKoXjEZzPaFdM0a9dL
         6YVisaYLMptPTUyMTmnxC97xU89oDhfnmsyhPATR56d1k9/hETT/i7wK3PpahQ1GgqNJ
         d80veZXYOsZGeRuxZAk7N4I1QcTTf0bgmTmU/cxiE5HP9gYL3vHEIX2vYp2oauEF5Itd
         3XO0R1VQgZ+tBKN3kReYJKliE54GAURxiK9fUj/X0uu5fCBLJ7jhphReDTAApfot22AI
         T19akO1/cytNtlAdEq/Y/cQk01z4jaIi3RNFUdsms0V5qHwZNTszKtX5eO0iyAKRRHB9
         WW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8pCLbO4RGMt9FhNM1rARjgkn1qpV57NBDORbLzqjDVc=;
        b=jj7MgjS3oJyL/AeLKVA1uzoPcqnQiWTs6uDq1lqyc22F47S/IRzlXnXt/qb0SA1E56
         h9VJlaBkdkorrmVzSCfYGKcbDI8rqg+ecRTQY9qbavaA1ota/mhSr095xQZHp6sP+Ddb
         Gi6mitKrrjRR9D0yVi8YIw4ol/i8qgGUCGsh+7bv0AxP1aCbYsaup+gwdMs9phHF3i8w
         pw1YHBt1OgoXOJ8RFhC1Qpm12oykNhZgL9RhwvOZGioHAG65kkU9RK+LyH63ypB3ErM7
         0Xb13+As/CLFZBBOPW+UR8pa26lfcg1bPmsRc1OG5/nPmdIgFgB1usBUWGbOWDZ+H3ju
         rZ8A==
X-Gm-Message-State: AOAM5328YD3xEeEfhksw5+MvkP0nuZ14IETDjVVBeRxRQUkHdwEuYCI0
        sdO1k4giXskL1nFcXftrQQ2ORh6tIgc=
X-Google-Smtp-Source: ABdhPJzEz107nKTkDp/MvNE5WrZN9OSAbT4xjwsaYjKz3dJQEkrzv5U9a6yV7tl1SdgTbd7VnygHbA==
X-Received: by 2002:a05:600c:1f11:b0:38c:6ce7:69c5 with SMTP id bd17-20020a05600c1f1100b0038c6ce769c5mr11334341wmb.64.1648231408369;
        Fri, 25 Mar 2022 11:03:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v188-20020a1cacc5000000b00384b71a50d5sm5048240wme.24.2022.03.25.11.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:03:27 -0700 (PDT)
Message-Id: <d62e338d00829bf3fe08e649ffa298c087a354a9.1648231393.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v9.git.1648231393.gitgitgadget@gmail.com>
References: <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
        <pull.1041.v9.git.1648231393.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Mar 2022 18:02:55 +0000
Subject: [PATCH v9 12/30] fsmonitor--daemon: add pathname classification
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
        Tao Klerks <tao@klerks.biz>, rsbecker@nexbridge.com,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach fsmonitor--daemon to classify relative and absolute
pathnames and decide how they should be handled.  This will
be used by the platform-specific backend to respond to each
filesystem event.

When we register for filesystem notifications on a directory,
we get events for everything (recursively) in the directory.
We want to report to clients changes to tracked and untracked
paths within the working directory proper.  We do not want to
report changes within the .git directory, for example.

This classification will be used in a later commit by the
different backends to classify paths as events are received.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fsmonitor--daemon.c | 81 ++++++++++++++++++++++++++++++++++
 fsmonitor--daemon.h         | 87 +++++++++++++++++++++++++++++++++++++
 2 files changed, 168 insertions(+)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 69dd39121a3..1ce00b7c150 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -134,6 +134,87 @@ static int handle_client(void *data,
 	return result;
 }
 
+#define FSMONITOR_COOKIE_PREFIX ".fsmonitor-daemon-"
+
+enum fsmonitor_path_type fsmonitor_classify_path_workdir_relative(
+	const char *rel)
+{
+	if (fspathncmp(rel, ".git", 4))
+		return IS_WORKDIR_PATH;
+	rel += 4;
+
+	if (!*rel)
+		return IS_DOT_GIT;
+	if (*rel != '/')
+		return IS_WORKDIR_PATH; /* e.g. .gitignore */
+	rel++;
+
+	if (!fspathncmp(rel, FSMONITOR_COOKIE_PREFIX,
+			strlen(FSMONITOR_COOKIE_PREFIX)))
+		return IS_INSIDE_DOT_GIT_WITH_COOKIE_PREFIX;
+
+	return IS_INSIDE_DOT_GIT;
+}
+
+enum fsmonitor_path_type fsmonitor_classify_path_gitdir_relative(
+	const char *rel)
+{
+	if (!fspathncmp(rel, FSMONITOR_COOKIE_PREFIX,
+			strlen(FSMONITOR_COOKIE_PREFIX)))
+		return IS_INSIDE_GITDIR_WITH_COOKIE_PREFIX;
+
+	return IS_INSIDE_GITDIR;
+}
+
+static enum fsmonitor_path_type try_classify_workdir_abs_path(
+	struct fsmonitor_daemon_state *state,
+	const char *path)
+{
+	const char *rel;
+
+	if (fspathncmp(path, state->path_worktree_watch.buf,
+		       state->path_worktree_watch.len))
+		return IS_OUTSIDE_CONE;
+
+	rel = path + state->path_worktree_watch.len;
+
+	if (!*rel)
+		return IS_WORKDIR_PATH; /* it is the root dir exactly */
+	if (*rel != '/')
+		return IS_OUTSIDE_CONE;
+	rel++;
+
+	return fsmonitor_classify_path_workdir_relative(rel);
+}
+
+enum fsmonitor_path_type fsmonitor_classify_path_absolute(
+	struct fsmonitor_daemon_state *state,
+	const char *path)
+{
+	const char *rel;
+	enum fsmonitor_path_type t;
+
+	t = try_classify_workdir_abs_path(state, path);
+	if (state->nr_paths_watching == 1)
+		return t;
+	if (t != IS_OUTSIDE_CONE)
+		return t;
+
+	if (fspathncmp(path, state->path_gitdir_watch.buf,
+		       state->path_gitdir_watch.len))
+		return IS_OUTSIDE_CONE;
+
+	rel = path + state->path_gitdir_watch.len;
+
+	if (!*rel)
+		return IS_GITDIR; /* it is the <gitdir> exactly */
+	if (*rel != '/')
+		return IS_OUTSIDE_CONE;
+	rel++;
+
+	return fsmonitor_classify_path_gitdir_relative(rel);
+}
+
 static void *fsm_listen__thread_proc(void *_state)
 {
 	struct fsmonitor_daemon_state *state = _state;
diff --git a/fsmonitor--daemon.h b/fsmonitor--daemon.h
index 3009c1a83de..8c3a71a48bd 100644
--- a/fsmonitor--daemon.h
+++ b/fsmonitor--daemon.h
@@ -30,5 +30,92 @@ struct fsmonitor_daemon_state {
 	struct ipc_server_data *ipc_server_data;
 };
 
+/*
+ * Pathname classifications.
+ *
+ * The daemon classifies the pathnames that it receives from file
+ * system notification events into the following categories and uses
+ * that to decide whether clients are told about them.  (And to watch
+ * for file system synchronization events.)
+ *
+ * The daemon only collects and reports on the set of modified paths
+ * within the working directory (proper).
+ *
+ * The client should only care about paths within the working
+ * directory proper (inside the working directory and not ".git" nor
+ * inside of ".git/").  That is, the client has read the index and is
+ * asking for a list of any paths in the working directory that have
+ * been modified since the last token.  The client does not care about
+ * file system changes within the ".git/" directory (such as new loose
+ * objects or packfiles).  So the client will only receive paths that
+ * are classified as IS_WORKDIR_PATH.
+ *
+ * Note that ".git" is usually a directory and is therefore inside
+ * the cone of the FS watch that we have on the working directory root,
+ * so we will also get FS events for disk activity on and within ".git/"
+ * that we need to respond to or filter from the client.
+ *
+ * But Git also allows ".git" to be a *file* that points to a GITDIR
+ * outside of the working directory.  When this happens, we need to
+ * create FS watches on both the working directory root *and* on the
+ * (external) GITDIR root.  (The latter is required because we put
+ * cookie files inside it and use them to sync with the FS event
+ * stream.)
+ *
+ * Note that in the context of this discussion, I'm using "GITDIR"
+ * to only mean an external GITDIR referenced by a ".git" file.
+ *
+ * The platform FS event backends will receive watch-specific
+ * relative paths (except for those OS's that always emit absolute
+ * paths).  We use the following enum and routines to classify each
+ * path so that we know how to handle it.  There is a slight asymmetry
+ * here because ".git/" is inside the working directory and the
+ * (external) GITDIR is not, and therefore how we handle events may
+ * vary slightly, so I have different enums for "IS...DOT_GIT..." and
+ * "IS...GITDIR...".
+ *
+ * The daemon uses the IS_DOT_GIT and IS_GITDIR internally to mean the
+ * exact ".git" file/directory or GITDIR directory.  If the daemon
+ * receives a delete event for either of these paths, it will
+ * automatically shutdown, for example.
+ *
+ * Note that the daemon DOES NOT explicitly watch nor special case the
+ * index.  The daemon does not read the index nor have any internal
+ * index-relative state, so there are no "IS...INDEX..." enum values.
+ */
+enum fsmonitor_path_type {
+	IS_WORKDIR_PATH = 0,
+
+	IS_DOT_GIT,
+	IS_INSIDE_DOT_GIT,
+	IS_INSIDE_DOT_GIT_WITH_COOKIE_PREFIX,
+
+	IS_GITDIR,
+	IS_INSIDE_GITDIR,
+	IS_INSIDE_GITDIR_WITH_COOKIE_PREFIX,
+
+	IS_OUTSIDE_CONE,
+};
+
+/*
+ * Classify a pathname relative to the root of the working directory.
+ */
+enum fsmonitor_path_type fsmonitor_classify_path_workdir_relative(
+	const char *relative_path);
+
+/*
+ * Classify a pathname relative to a <gitdir> that is external to the
+ * worktree directory.
+ */
+enum fsmonitor_path_type fsmonitor_classify_path_gitdir_relative(
+	const char *relative_path);
+
+/*
+ * Classify an absolute pathname received from a filesystem event.
+ */
+enum fsmonitor_path_type fsmonitor_classify_path_absolute(
+	struct fsmonitor_daemon_state *state,
+	const char *path);
+
 #endif /* HAVE_FSMONITOR_DAEMON_BACKEND */
 #endif /* FSMONITOR_DAEMON_H */
-- 
gitgitgadget

