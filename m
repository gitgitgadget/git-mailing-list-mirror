Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89839C433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 22:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350685AbiCHWR2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 17:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350683AbiCHWQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 17:16:58 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BCE57B0D
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 14:15:48 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id r81-20020a1c4454000000b00389d0a5c511so54243wma.5
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 14:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Mv6D24bMSysj3hV8m09u6C4BPD9U2eW4vus0bJo6UBo=;
        b=eIviaQSAxrTfIh3Aq5XMvNIDPt8STTcza4PYxm8fvT+Lw2PgzgOKh83XymuGrQ6i5M
         Lh1rXuyLIWX6BdD9YbvwTVjE+mXClZSC51VtIQT4ANV61VfZDiiN92la1Og/HFWerkGX
         SlMUbrJ+Jg2lRwvYxTCcdgYm7t5Yjx2KbylirbxXJTa8C29TJHqx87GW9PYjh/yoZM1g
         4tnTm/a5XhUYy8rSVyV7gzxDb7FBiy/TRZdOinMExA84zrDquuYjsTKyJU1WERH+9Rf9
         qEmTMWifvxHFi6bBsqwW/IAPFNCb6UNaM4QPseIJE0sSSLCySn8R61kcCpyosYPMyk4v
         1rUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Mv6D24bMSysj3hV8m09u6C4BPD9U2eW4vus0bJo6UBo=;
        b=1TBOy0iHREdjJYdE537PhmDBy1Zjx56EQXJK4zMKMdxUcG3181bypOU+QmA8EPRlQJ
         niSiqyPMj9ZlvMlvSuw5gXlzSOdCX1OUeAGBA2VP32Sff0bAO1xyBH3Z2QcIBWkynIZv
         pf/+CrsbCBgQgKVkzD0u1ObctfGRiWGuCCL+oq1QUF95rM2FGKHSR0dDAf/Ohp8X1Qw5
         Kyvfr7h8YlNo3mrsPFCE8TjjmguvMjUrELWJ/C9gPVOshC6mBc+uhbSdOzLxyveozGk+
         5MY3FR+/CMWvarAoMqkeM1/ogshD0I7yyPltF0L0by8E7GmRL4dItAONuIl5gNMDINt2
         Og3Q==
X-Gm-Message-State: AOAM532ZgXxfIIW7ZYG8FNadFQzyJfiQy9IeEO7fQqvLBaF0gxXYTPhV
        iVB1cnQQUMDFqwVZ17ljqVSRVsC2Ihk=
X-Google-Smtp-Source: ABdhPJxCmGCKOrM+g22P8TgXFu6pijG7EaKUfOvyS3aBVa5NyyrRQzzjPgkiLnf+zoM8VOSVBu8EUQ==
X-Received: by 2002:a1c:f003:0:b0:37b:d5fc:5c9e with SMTP id a3-20020a1cf003000000b0037bd5fc5c9emr1041878wmb.154.1646777747147;
        Tue, 08 Mar 2022 14:15:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bl20-20020adfe254000000b001f1fa450a3asm130829wrb.72.2022.03.08.14.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 14:15:46 -0800 (PST)
Message-Id: <bb72f911a05727e75f44e7a4517b34d474724bea.1646777727.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
        <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 22:15:16 +0000
Subject: [PATCH v2 16/27] fsm-health-win32: add polling framework to monitor
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

