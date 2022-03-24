Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6D4C433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 16:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351900AbiCXQxv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352224AbiCXQxT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 12:53:19 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11559F386
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:51:46 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h4so7461091wrc.13
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Mv6D24bMSysj3hV8m09u6C4BPD9U2eW4vus0bJo6UBo=;
        b=B2TO6Kr1IjAKWf/eg0JICbo9LaSLsY6tf2azsoBuA6dZMqQAnYpUUt2L9OvHAlo8/A
         qVtIfvZbaggDtLElPMwjAMoO+QGM4QJwUjLEepxYiU8F2kXmQF51TLFJw/o+XxbhR3DO
         bjQEseWvX7OSaYf8NwJxApL+ZyE7yp+6Kl5HKYuHzbwmEKd08fqN/Awu0YKqQ9fx3/XY
         Cptr1MNBV4YngneM2DCPdAaHDpIUGrPTCinquxkqR2fsgI4yc0tS1eFKCFlJllvGzZ4D
         xYmyzU+oDVCxNjZ3ikRV0CTG2Xb7vLJCD++TwW9IXYZZ6be9WPushRxps4yIp1emYxYj
         HHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Mv6D24bMSysj3hV8m09u6C4BPD9U2eW4vus0bJo6UBo=;
        b=te+MKn6nkqyGBFwud+Pwk8BYgqNJhzkQNHmcUJVqm95YWV43CH1CW+5SHZv3cz8U1m
         W/pQvlJzi7zxcIeCpqxjmEQqg9IHr65DYj+6PjB1X5yBSZZ20vsu86yO5gyz2GBsufJQ
         uLRsDPrYVR3NGdNX7C4sSJm0xxbMYVR6+inKPb67SP5vwsarbmrTKTaMTHUI39LYUtZA
         ntYAgCdpys8REJYo7QIH3ihjHs6n9imBEBD/gAYZJpHh+fJcEA0TYfF7hrHPR5aiBH0g
         CBOlFlIzDsKKKCCLLxhLXLzzquViGXdW6p1BU/KhutFkyj5M6aOS3BwZWiKj6iA7W7HF
         nNYA==
X-Gm-Message-State: AOAM533eePEbAr/1VCUtTUQ8gafof04jsQfSOcZwaNEUkTDeSYSCaMZl
        Zom1aZ3r2r/UJoAJwnTzUFMFHC1Ur8Y=
X-Google-Smtp-Source: ABdhPJzbDWjVcNaWFkQC84QpiqExlBWceeNc9yXtGAxraV2qJxlokyrUHIFuaimo2gEtNL2ZCuQnZg==
X-Received: by 2002:a5d:4c82:0:b0:204:d78:7635 with SMTP id z2-20020a5d4c82000000b002040d787635mr5489349wrs.318.1648140705073;
        Thu, 24 Mar 2022 09:51:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u7-20020a5d6da7000000b00203d9d1875bsm3679902wrs.73.2022.03.24.09.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:51:44 -0700 (PDT)
Message-Id: <d9b91a998ce0802b4f81dddcafb1f91e4746d028.1648140680.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
References: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
        <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 16:51:10 +0000
Subject: [PATCH v4 17/27] fsm-health-win32: add polling framework to monitor
 daemon health
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

Extend the Windows version of the "health" thread to periodically
inspect the system and shutdown if warranted.

This commit updates the thread's wait loop to use a timeout and
defines a (currently empty) table of functions to poll the system.

A later commit will add functions to the table to actually
inspect the system.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/fsmonitor/fsm-health-win32.c | 65 ++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/compat/fsmonitor/fsm-health-win32.c b/compat/fsmonitor/fsm-health-win32.c
index 94b1d020f25..24fc612bf02 100644
--- a/compat/fsmonitor/fsm-health-win32.c
+++ b/compat/fsmonitor/fsm-health-win32.c
@@ -4,6 +4,24 @@
 #include "fsm-health.h"
 #include "fsmonitor--daemon.h"
 
+/*
+ * Every minute wake up and test our health.
+ */
+#define WAIT_FREQ_MS (60 * 1000)
+
+/*
+ * State machine states for each of the interval functions
+ * used for polling our health.
+ */
+enum interval_fn_ctx {
+	CTX_INIT = 0,
+	CTX_TERM,
+	CTX_TIMER
+};
+
+typedef int (interval_fn)(struct fsmonitor_daemon_state *state,
+			  enum interval_fn_ctx ctx);
+
 struct fsm_health_data
 {
 	HANDLE hEventShutdown;
@@ -42,18 +60,61 @@ void fsm_health__dtor(struct fsmonitor_daemon_state *state)
 	FREE_AND_NULL(state->health_data);
 }
 
+/*
+ * A table of the polling functions.
+ */
+static interval_fn *table[] = {
+	NULL, /* must be last */
+};
+
+/*
+ * Call all of the polling functions in the table.
+ * Shortcut and return first error.
+ *
+ * Return 0 if all succeeded.
+ */
+static int call_all(struct fsmonitor_daemon_state *state,
+		    enum interval_fn_ctx ctx)
+{
+	int k;
+
+	for (k = 0; table[k]; k++) {
+		int r = table[k](state, ctx);
+		if (r)
+			return r;
+	}
+
+	return 0;
+}
+
 void fsm_health__loop(struct fsmonitor_daemon_state *state)
 {
 	struct fsm_health_data *data = state->health_data;
+	int r;
+
+	r = call_all(state, CTX_INIT);
+	if (r < 0)
+		goto force_error_stop;
+	if (r > 0)
+		goto force_shutdown;
 
 	for (;;) {
 		DWORD dwWait = WaitForMultipleObjects(data->nr_handles,
 						      data->hHandles,
-						      FALSE, INFINITE);
+						      FALSE, WAIT_FREQ_MS);
 
 		if (dwWait == WAIT_OBJECT_0 + HEALTH_SHUTDOWN)
 			goto clean_shutdown;
 
+		if (dwWait == WAIT_TIMEOUT) {
+			r = call_all(state, CTX_TIMER);
+			if (r < 0)
+				goto force_error_stop;
+			if (r > 0)
+				goto force_shutdown;
+			continue;
+		}
+
 		error(_("health thread wait failed [GLE %ld]"),
 		      GetLastError());
 		goto force_error_stop;
@@ -61,8 +122,10 @@ void fsm_health__loop(struct fsmonitor_daemon_state *state)
 
 force_error_stop:
 	state->health_error_code = -1;
+force_shutdown:
 	ipc_server_stop_async(state->ipc_server_data);
 clean_shutdown:
+	call_all(state, CTX_TERM);
 	return;
 }
 
-- 
gitgitgadget

