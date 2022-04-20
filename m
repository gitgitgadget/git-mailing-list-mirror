Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEB3C433EF
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 20:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382198AbiDTUqy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 16:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382165AbiDTUq2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 16:46:28 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEB6340F6
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:43:40 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id p18so3863851wru.5
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jLD5/kKpi8DMO5qU1ej4+CHxgwvkoymtmnde3SN53k4=;
        b=iRIFIJlAdVwBUkc/hj/6Na3Yt7pLGuKarnjA2Vpcm4RCzB7kk5+62XtpYNsPQpzIyE
         beMVlcQuulTnKkSFMf7CXP+3wk29cI1CPWurMV0UplOM8WrQIfDNREcnC3OAV/paGeMZ
         Z7MoNkz+ORNz92DP2XQtH6bVfnNVvxZiLkxGC/aUO57xmCH8/IrRz+ffVjO+fZ9Xp6Zl
         2ACiRXY/ZowZXdFxlQuGLxpaYPcaJH2OiGmy47s9goscg45fKdMV6gCwsOcuniRvXT33
         ru9FRi7htAQH5qfT44h+Eax2NhBlyvXkAsOaSGhh6OzLhrR0uYTi9cboTRYaQownnOUM
         M51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jLD5/kKpi8DMO5qU1ej4+CHxgwvkoymtmnde3SN53k4=;
        b=M52V2QhTKFiy7J03Pmk3/Hi09thfe4lQmRLNocIcNUkG0Qq+nELwCSMpUo4nBk4E24
         MyAZZ1+2Fk4OrGRHwFV/inp3Rwa5hflXvwsrpDLOXF7pzO7P3V+5hkD+6tIixDxiVlXk
         mbvn2J43slYru26IGpPskaytFo6LQ7ltAfyasc7N5QfO97cZkwUK5IvGqYRj61XMvBoh
         eYGctPVKAPLHA7BaFKwyIqVWrZAq61dXSzAM6sLyjIanYxoj+dXIXP/6IOnlYNA1/R8M
         usLrGeS5I+iNd04frUhdHZ2lnU+k5cAOsQF/xJNHx48aNIyy0OFka0EyirI/zr81KYCx
         yYQA==
X-Gm-Message-State: AOAM532TDxkXQBaMkvC1Q+eLQnBX+buPb5lS2qKvY8HjPuu4Ql+Cb7of
        6hYM9uH3P4vbwLkRglHU7/jr6YM8SyM=
X-Google-Smtp-Source: ABdhPJwVfJvCRRy9T2ovMTVGpDKXeKktZR2RHqY92/gj1uRuKJM/H4eGK/I+DHY4PZMLIOaeoezUFg==
X-Received: by 2002:a5d:4563:0:b0:207:bc6f:e345 with SMTP id a3-20020a5d4563000000b00207bc6fe345mr16798068wrc.372.1650487419141;
        Wed, 20 Apr 2022 13:43:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n15-20020a5d6b8f000000b00207ab69284csm626268wrx.23.2022.04.20.13.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 13:43:38 -0700 (PDT)
Message-Id: <6552f51802ba383f4c82866ce20d989749d47be3.1650487399.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
References: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
        <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Apr 2022 20:43:04 +0000
Subject: [PATCH v5 14/28] fsmonitor--daemon: prepare for adding health thread
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

Refactor daemon thread startup to make it easier to start
a third thread class to monitor the health of the daemon.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fsmonitor--daemon.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 1b7c757f583..14cd2d5eb52 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1174,6 +1174,8 @@ static int fsmonitor_run_daemon_1(struct fsmonitor_daemon_state *state)
 		 */
 		.uds_disallow_chdir = 0
 	};
+	int listener_started = 0;
+	int err = 0;
 
 	/*
 	 * Start the IPC thread pool before the we've started the file
@@ -1194,15 +1196,20 @@ static int fsmonitor_run_daemon_1(struct fsmonitor_daemon_state *state)
 	if (pthread_create(&state->listener_thread, NULL,
 			   fsm_listen__thread_proc, state) < 0) {
 		ipc_server_stop_async(state->ipc_server_data);
-		ipc_server_await(state->ipc_server_data);
-
-		return error(_("could not start fsmonitor listener thread"));
+		err = error(_("could not start fsmonitor listener thread"));
+		goto cleanup;
 	}
+	listener_started = 1;
 
 	/*
 	 * The daemon is now fully functional in background threads.
+	 * Our primary thread should now just wait while the threads
+	 * do all the work.
+	 */
+cleanup:
+	/*
 	 * Wait for the IPC thread pool to shutdown (whether by client
-	 * request or from filesystem activity).
+	 * request, from filesystem activity, or an error).
 	 */
 	ipc_server_await(state->ipc_server_data);
 
@@ -1211,10 +1218,16 @@ static int fsmonitor_run_daemon_1(struct fsmonitor_daemon_state *state)
 	 * event from the IPC thread pool, but it doesn't hurt to tell
 	 * it again.  And wait for it to shutdown.
 	 */
-	fsm_listen__stop_async(state);
-	pthread_join(state->listener_thread, NULL);
+	if (listener_started) {
+		fsm_listen__stop_async(state);
+		pthread_join(state->listener_thread, NULL);
+	}
 
-	return state->error_code;
+	if (err)
+		return err;
+	if (state->error_code)
+		return state->error_code;
+	return 0;
 }
 
 static int fsmonitor_run_daemon(void)
-- 
gitgitgadget

