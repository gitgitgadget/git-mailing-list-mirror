Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF29C433F5
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 20:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382196AbiDTUqw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 16:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382160AbiDTUq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 16:46:26 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1C140E7E
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:43:39 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t6so427592wra.4
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7rcq2e2OM4nGjZ+ZqucdxU8VZqK8SlixUVA4duCOPBc=;
        b=JA4+HxvbB5JqAHpBHe0fEEk3UuoMmVUp9fSjGD4AdxwoELXQno1X1qyzYvUq+S07Qq
         O0k07tuPHk1P/PyktlhPINVaGw9V49AFBfeSH1hB+2I8RZpBHMLKii2raUOhb2dGgUDd
         DSY2bq99OfVeBoeUO16rsvyvMXFncFHmx0qg5EQFl0Q7vHT3GFooiykIqyd+PLQPVkWr
         ZqBgEAUkPSWf3eZk008m7cuZ/jplwLHSAQmGjAl1sRx+eXrQmYTuH+EdK+o3sMgX2sDi
         SdPWy9yz84q4oY6ak9dfgAwfpg/bvXUeCkupnv6NKT1b+r++PlgixcnJRT29RZsIXZZE
         Ev8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7rcq2e2OM4nGjZ+ZqucdxU8VZqK8SlixUVA4duCOPBc=;
        b=Xis+jbMqtS69xSY5ZGHf2sWS0lymRXtTQBzi1E9Y76Be1m3A3k8ax13VslyhprSmzZ
         k5Tl0oJRrkGbSR+E82raNQnFYoODr7Zymy+4uunk6t7O6tnOmOaYxL7vGqgrwhiWteWQ
         HsA3YIIEYGmDTZr8SQfqgobDmRrDdn3qttdmk8lkuLrbICfIgqROqHx627mxOl7mbG3x
         8jpuUsAX8+F9yUcQ3Y5gP5y7gzUHu38JLzBD4ZcbpgktIDEPIAwRSXeueshot8oFBr29
         KWEQUnfTooUCFgTtc2tHh/TSMjKWmbql2qo6RCEK/Gd2aqTmgeND0yZpCx2S2bAVKsQc
         8rtg==
X-Gm-Message-State: AOAM531q0W0v/KnFUdp+2TtIfAsfMHr9AFdUEYufqR7rWRYr0Y4sY2vE
        fElGsIwM62y7eNTBplwv93r66dvJBbY=
X-Google-Smtp-Source: ABdhPJy4ALMvzgTvKpdj5Rd4GKaWu40euYsFyC5JRkC+X62uuJ3Mh95EVZmDQxc5E3YD67DtBP2v6Q==
X-Received: by 2002:a5d:510a:0:b0:209:16c7:d8 with SMTP id s10-20020a5d510a000000b0020916c700d8mr16814444wrt.684.1650487417711;
        Wed, 20 Apr 2022 13:43:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o13-20020a05600c4fcd00b00392951086efsm343242wmq.34.2022.04.20.13.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 13:43:37 -0700 (PDT)
Message-Id: <00fab626663292f8c82233a3a72b4f9e885de17b.1650487399.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
References: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
        <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Apr 2022 20:43:03 +0000
Subject: [PATCH v5 13/28] fsmonitor--daemon: cd out of worktree root
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
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach the fsmonitor--daemon to CD outside of the worktree
before starting up.

The common Git startup mechanism causes the CWD of the daemon process
to be in the root of the worktree.  On Windows, this causes the daemon
process to hold a locked handle on the CWD and prevents other
processes from moving or deleting the worktree while the daemon is
running.

CD to HOME before entering main event loops.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fsmonitor--daemon.c         | 32 +++++++++++++++++++++++++++--
 compat/fsmonitor/fsm-listen-win32.c | 22 ++++++++++++++------
 fsmonitor--daemon.h                 |  1 +
 3 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 50ae3cca575..1b7c757f583 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1181,11 +1181,11 @@ static int fsmonitor_run_daemon_1(struct fsmonitor_daemon_state *state)
 	 * before we need it.
 	 */
 	if (ipc_server_run_async(&state->ipc_server_data,
-				 fsmonitor_ipc__get_path(), &ipc_opts,
+				 state->path_ipc.buf, &ipc_opts,
 				 handle_client, state))
 		return error_errno(
 			_("could not start IPC thread pool on '%s'"),
-			fsmonitor_ipc__get_path());
+			state->path_ipc.buf);
 
 	/*
 	 * Start the fsmonitor listener thread to collect filesystem
@@ -1220,6 +1220,7 @@ static int fsmonitor_run_daemon_1(struct fsmonitor_daemon_state *state)
 static int fsmonitor_run_daemon(void)
 {
 	struct fsmonitor_daemon_state state;
+	const char *home;
 	int err;
 
 	memset(&state, 0, sizeof(state));
@@ -1289,6 +1290,15 @@ static int fsmonitor_run_daemon(void)
 
 	strbuf_addch(&state.path_cookie_prefix, '/');
 
+	/*
+	 * We create a named-pipe or unix domain socket inside of the
+	 * ".git" directory.  (Well, on Windows, we base our named
+	 * pipe in the NPFS on the absolute path of the git
+	 * directory.)
+	 */
+	strbuf_init(&state.path_ipc, 0);
+	strbuf_addstr(&state.path_ipc, absolute_path(fsmonitor_ipc__get_path()));
+
 	/*
 	 * Confirm that we can create platform-specific resources for the
 	 * filesystem listener before we bother starting all the threads.
@@ -1298,6 +1308,23 @@ static int fsmonitor_run_daemon(void)
 		goto done;
 	}
 
+	/*
+	 * CD out of the worktree root directory.
+	 *
+	 * The common Git startup mechanism causes our CWD to be the
+	 * root of the worktree.  On Windows, this causes our process
+	 * to hold a locked handle on the CWD.  This prevents the
+	 * worktree from being moved or deleted while the daemon is
+	 * running.
+	 *
+	 * We assume that our FS and IPC listener threads have either
+	 * opened all of the handles that they need or will do
+	 * everything using absolute paths.
+	 */
+	home = getenv("HOME");
+	if (home && *home && chdir(home))
+		die_errno(_("could not cd home '%s'"), home);
+
 	err = fsmonitor_run_daemon_1(&state);
 
 done:
@@ -1310,6 +1337,7 @@ done:
 	strbuf_release(&state.path_worktree_watch);
 	strbuf_release(&state.path_gitdir_watch);
 	strbuf_release(&state.path_cookie_prefix);
+	strbuf_release(&state.path_ipc);
 
 	return err;
 }
diff --git a/compat/fsmonitor/fsm-listen-win32.c b/compat/fsmonitor/fsm-listen-win32.c
index 3f1b68267bd..c43d92b9620 100644
--- a/compat/fsmonitor/fsm-listen-win32.c
+++ b/compat/fsmonitor/fsm-listen-win32.c
@@ -402,12 +402,22 @@ static int recv_rdcw_watch(struct one_watch *watch)
 	}
 
 	/*
-	 * NEEDSWORK: If an external <gitdir> is deleted, the above
-	 * returns an error.  I'm not sure that there's anything that
-	 * we can do here other than failing -- the <worktree>/.git
-	 * link file would be broken anyway.  We might try to check
-	 * for that and return a better error message, but I'm not
-	 * sure it is worth it.
+	 * GetOverlappedResult() fails if the watched directory is
+	 * deleted while we were waiting for an overlapped IO to
+	 * complete.  The documentation did not list specific errors,
+	 * but I observed ERROR_ACCESS_DENIED (0x05) errors during
+	 * testing.
+	 *
+	 * Note that we only get notificaiton events for events
+	 * *within* the directory, not *on* the directory itself.
+	 * (These might be properies of the parent directory, for
+	 * example).
+	 *
+	 * NEEDSWORK: We might try to check for the deleted directory
+	 * case and return a better error message, but I'm not sure it
+	 * is worth it.
+	 *
+	 * Shutdown if we get any error.
 	 */
 
 	error(_("GetOverlappedResult failed on '%s' [GLE %ld]"),
diff --git a/fsmonitor--daemon.h b/fsmonitor--daemon.h
index bd09fffc176..223c2131b58 100644
--- a/fsmonitor--daemon.h
+++ b/fsmonitor--daemon.h
@@ -54,6 +54,7 @@ struct fsmonitor_daemon_state {
 	struct fsmonitor_daemon_backend_data *backend_data;
 
 	struct ipc_server_data *ipc_server_data;
+	struct strbuf path_ipc;
 };
 
 /*
-- 
gitgitgadget

