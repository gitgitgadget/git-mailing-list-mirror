Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A67C433FE
	for <git@archiver.kernel.org>; Wed, 25 May 2022 15:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245011AbiEYPBv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 11:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245014AbiEYPB2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 11:01:28 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF35DAFB07
        for <git@vger.kernel.org>; Wed, 25 May 2022 08:01:22 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e28so29891036wra.10
        for <git@vger.kernel.org>; Wed, 25 May 2022 08:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Mv6D24bMSysj3hV8m09u6C4BPD9U2eW4vus0bJo6UBo=;
        b=dmKeQ0WOQSZ+p3/TvtWLN+y0SszKau9M4RSxVVMYhvPRfinuaYJVCuEbiSn2hS4YLO
         snBMhbycWwBVgfqJS0ZmLgDbSvut2cVPJT5OHyXuqUKEc6gW+3CKx7iqlemH/MzehxPC
         ERYSy23JtchwQI2kXyP3KxbTC0zh52zAuhPDkyPl4GomP5QEUFPfi2X6SMfZySL5bWFe
         V1Xn0ukkHL2ovRgVmqy/JNtN5uPzbbfazKcWhLOpIjNCJLpJt2erQi+hStT7a63+1QTq
         tvI53BFRfINXwWfEc1LauCXQ73y/6YyK3XcCd9GXZLLrL6Io9X1gboivDkc3lHZxovd3
         C/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Mv6D24bMSysj3hV8m09u6C4BPD9U2eW4vus0bJo6UBo=;
        b=Y2x/GQbPtfBuPFbS5a8KVqmFvJpdkL5NUG278qIC+AEB37EMOoUYFACIFmYAfmtmp/
         7mjZ+6pH14H0KhWv7gV8iNftMxYud7M1qfm8qc4w7FJmUiyANnmThgMTaYP4Hrmw2aRn
         O3Rp0NPeaUEcv4F2CTZt99oDAZxyLLbWNK7KxykJ1is4yE+pOUuHGrW00jiWl9E0XLOL
         Forr/3ddjhxTekiMJl62/0Nt+55OdRVlEBCnfVubI6SRUEqfWNhYHOLi2lQuglhv2PF7
         Bd8FPXA55bEBuw9VLUPqOFZww6vcBvRlumMzfUIty1mqF4/J0uX3d5YTDAyFrvm7u384
         baig==
X-Gm-Message-State: AOAM533hQVrPX8j5JXuRizRGKFdoAs3mNmbaAdpScueEpdnBenVzrL1t
        jPL24D3z2jA/3t3u/Ea0Qy7N7ancQ/A=
X-Google-Smtp-Source: ABdhPJxMyy2ir8RRudc/kCP2OOa/X0Fku0hSxUMm3AbZlhL66sDKUWsF2k2wPxYBLyqxHSzDUqq13g==
X-Received: by 2002:a5d:5888:0:b0:20d:270f:6b61 with SMTP id n8-20020a5d5888000000b0020d270f6b61mr26705808wrf.211.1653490880992;
        Wed, 25 May 2022 08:01:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l16-20020a5d5270000000b0020c5253d8d2sm2409543wrc.30.2022.05.25.08.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 08:01:19 -0700 (PDT)
Message-Id: <46a5ae2a6353e1da3c3ba84c9a2b5e03d6eeae44.1653490853.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
References: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
        <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 May 2022 15:00:39 +0000
Subject: [PATCH v8 17/30] fsm-health-win32: add polling framework to monitor
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
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>,
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

