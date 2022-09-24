Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E1DC6FA82
	for <git@archiver.kernel.org>; Sat, 24 Sep 2022 19:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbiIXTql (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Sep 2022 15:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbiIXTqc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Sep 2022 15:46:32 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C1446631
        for <git@vger.kernel.org>; Sat, 24 Sep 2022 12:46:31 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id iv17so2114168wmb.4
        for <git@vger.kernel.org>; Sat, 24 Sep 2022 12:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=Sn7vsF8saTSOV85OIZnrqZlKAyOg5t4JuZwq78TkGgc=;
        b=Wc/CStXHQ8Ba5jPUGIzeFgZh80WlG4NpWKq1p/oFgQtrB2LoUoIP5nt7P5Gi6xXLkc
         a1z6+CrwA7rdvpeIzfB9RCvtiqxp+Vda42JdieJ5YpUgyaGKPVEsFZdbJ62HbwefuFVZ
         vCSMWxtGYAxb+WDvgUHgcDlb3P1Fhj2Cwtkao10dmbBWv52uKs2fFuXVCphv1j4c62Dt
         IOhdqF9j4GFe06j7llwoqvZgne/r1q6Ync3MnFRaXfx8YUvrSkv+VWnftnv2QKvzlblN
         F/OsY79JUhr9idN6twClyZxW4YKdE23+u5NfsT/BSrp7ImXXSLrqCn5QRynW0O2hHkCQ
         noLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Sn7vsF8saTSOV85OIZnrqZlKAyOg5t4JuZwq78TkGgc=;
        b=BNbc8p4y6DEZaiwG5/z+lRTNbnitsOIufySfTq+Z+wDhyphuzbn7YH9kOx7XKx52YY
         LtqQg9RZIBCdwAvsxxED4M/i2/goxrJ92x9wUPz23csnqePyLPZHG9/PTH273s2CQIfL
         LZQkNwBqvVglgI5Sm6kbhMgDkLBeNsUeK5SEQq9o0v/PF4Qc4twjgRviZUrWuLo1Qi1E
         1Gz1cQ/Pujys7Tar4hx9rV2rpUV9Mq+gY92MY88C+rIL6R7sNfKDZCtQoRkLnEUF+gZO
         F8jGylQZCILJgBox1PXGU8Qpx2PdrujJ2vGIxpfFdSQ7hDfMj0ieCXI5mzqIaDgLb05g
         j4Yw==
X-Gm-Message-State: ACrzQf3HUCn+z6j+PK+S5y6J8Z8NJf4VrOM3yzr0w7QtVD/E1APZ6cAf
        E/XggQ4J6d/IORCCeHy60zKaioMu+x4=
X-Google-Smtp-Source: AMsMyM6kJp3mklw0L0+l49S3DAKzeW4/kfhJr+MFkkQpo+KutPPmrhEmA6TmwXvret0J801MDP5Pqg==
X-Received: by 2002:a05:600c:510e:b0:3b5:1ab:fa5 with SMTP id o14-20020a05600c510e00b003b501ab0fa5mr9703770wms.204.1664048789436;
        Sat, 24 Sep 2022 12:46:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i10-20020a05600c050a00b003b4a68645e9sm5968281wmc.34.2022.09.24.12.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 12:46:28 -0700 (PDT)
Message-Id: <e9921550a671cf3bf12180373fba7f51c4fe7460.1664048782.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v12.git.1664048782.gitgitgadget@gmail.com>
References: <pull.1326.v11.git.1663798722.gitgitgadget@gmail.com>
        <pull.1326.v12.git.1664048782.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 24 Sep 2022 19:46:19 +0000
Subject: [PATCH v12 3/6] fsmonitor: avoid socket location check if using hook
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta <edecosta@mathworks.com>,
        Eric DeCosta <edecosta@mathworks.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric DeCosta <edecosta@mathworks.com>

If monitoring is done via fsmonitor hook rather than IPC there is no
need to check if the location of the Unix Domain socket (UDS) file is
on a remote filesystem.

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
 compat/fsmonitor/fsm-settings-darwin.c | 10 ++++++----
 compat/fsmonitor/fsm-settings-win32.c  |  2 +-
 fsmonitor-settings.c                   |  8 ++++----
 fsmonitor-settings.h                   |  2 +-
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/compat/fsmonitor/fsm-settings-darwin.c b/compat/fsmonitor/fsm-settings-darwin.c
index 681d8bf963e..40da2d3b533 100644
--- a/compat/fsmonitor/fsm-settings-darwin.c
+++ b/compat/fsmonitor/fsm-settings-darwin.c
@@ -49,13 +49,15 @@ static enum fsmonitor_reason check_uds_volume(struct repository *r)
 	return FSMONITOR_REASON_OK;
 }
 
-enum fsmonitor_reason fsm_os__incompatible(struct repository *r)
+enum fsmonitor_reason fsm_os__incompatible(struct repository *r, int ipc)
 {
 	enum fsmonitor_reason reason;
 
-	reason = check_uds_volume(r);
-	if (reason != FSMONITOR_REASON_OK)
-		return reason;
+	if (ipc) {
+		reason = check_uds_volume(r);
+		if (reason != FSMONITOR_REASON_OK)
+			return reason;
+	}
 
 	return FSMONITOR_REASON_OK;
 }
diff --git a/compat/fsmonitor/fsm-settings-win32.c b/compat/fsmonitor/fsm-settings-win32.c
index d88b06ae610..a8af31b71de 100644
--- a/compat/fsmonitor/fsm-settings-win32.c
+++ b/compat/fsmonitor/fsm-settings-win32.c
@@ -25,7 +25,7 @@ static enum fsmonitor_reason check_vfs4git(struct repository *r)
 	return FSMONITOR_REASON_OK;
 }
 
-enum fsmonitor_reason fsm_os__incompatible(struct repository *r)
+enum fsmonitor_reason fsm_os__incompatible(struct repository *r, int ipc)
 {
 	enum fsmonitor_reason reason;
 
diff --git a/fsmonitor-settings.c b/fsmonitor-settings.c
index d288cbad479..531a1b6f956 100644
--- a/fsmonitor-settings.c
+++ b/fsmonitor-settings.c
@@ -60,7 +60,7 @@ static enum fsmonitor_reason check_remote(struct repository *r)
 }
 #endif
 
-static enum fsmonitor_reason check_for_incompatible(struct repository *r)
+static enum fsmonitor_reason check_for_incompatible(struct repository *r, int ipc)
 {
 	if (!r->worktree) {
 		/*
@@ -77,7 +77,7 @@ static enum fsmonitor_reason check_for_incompatible(struct repository *r)
 		reason = check_remote(r);
 		if (reason != FSMONITOR_REASON_OK)
 			return reason;
-		reason = fsm_os__incompatible(r);
+		reason = fsm_os__incompatible(r, ipc);
 		if (reason != FSMONITOR_REASON_OK)
 			return reason;
 	}
@@ -162,7 +162,7 @@ const char *fsm_settings__get_hook_path(struct repository *r)
 
 void fsm_settings__set_ipc(struct repository *r)
 {
-	enum fsmonitor_reason reason = check_for_incompatible(r);
+	enum fsmonitor_reason reason = check_for_incompatible(r, 1);
 
 	if (reason != FSMONITOR_REASON_OK) {
 		fsm_settings__set_incompatible(r, reason);
@@ -185,7 +185,7 @@ void fsm_settings__set_ipc(struct repository *r)
 
 void fsm_settings__set_hook(struct repository *r, const char *path)
 {
-	enum fsmonitor_reason reason = check_for_incompatible(r);
+	enum fsmonitor_reason reason = check_for_incompatible(r, 0);
 
 	if (reason != FSMONITOR_REASON_OK) {
 		fsm_settings__set_incompatible(r, reason);
diff --git a/fsmonitor-settings.h b/fsmonitor-settings.h
index d9c2605197f..0721617b95a 100644
--- a/fsmonitor-settings.h
+++ b/fsmonitor-settings.h
@@ -48,7 +48,7 @@ struct fsmonitor_settings;
  * fsm_os__* routines should considered private to fsm_settings__
  * routines.
  */
-enum fsmonitor_reason fsm_os__incompatible(struct repository *r);
+enum fsmonitor_reason fsm_os__incompatible(struct repository *r, int ipc);
 #endif /* HAVE_FSMONITOR_OS_SETTINGS */
 
 #endif /* FSMONITOR_SETTINGS_H */
-- 
gitgitgadget

