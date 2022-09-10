Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65688C6FA83
	for <git@archiver.kernel.org>; Sat, 10 Sep 2022 20:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiIJUCg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Sep 2022 16:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiIJUCQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Sep 2022 16:02:16 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D675476ED
        for <git@vger.kernel.org>; Sat, 10 Sep 2022 13:00:39 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k9so8871079wri.0
        for <git@vger.kernel.org>; Sat, 10 Sep 2022 13:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=oFZbG9WkdiUYulw81PCz1BIFi8UiLOlwTp2wvCZ4/po=;
        b=d3ayhQNAGc2iC/LpiV/I1Fcughsj/C9FA/NupCoMwxI8g9Y1+ml5UzQ/QFCyUEATSW
         7FT3V+st98N3rXrfoNMUcslnSe8682lD8DUANbYzFwnPtJEO5HgXNsjZTc+dO+Wkpl0n
         lFhwGTmaXJDjmLDUi3AE3vDFqjZ3SVbmIbb5BNCUBBxwHK5doi1XElviX9WWGkIKwmll
         YD+9hh2AhBFf6oc2kc19d3PpWkKA71VuYR4ZXzIls3S5FJvz01TVByJkzwi1ectUPD0N
         80qr/EdYtSbe/7kWM3EaHtrGuVkG6n5aCQIbIOfYOzqr+WxahssGXvR2iLuYoF+2cliJ
         5JBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=oFZbG9WkdiUYulw81PCz1BIFi8UiLOlwTp2wvCZ4/po=;
        b=ZEnPWW4ON1fM0Rck3j64MBhovKe8fjUreo3z+ksgoAMfCPzTQc9Q6PTmMoeFSa15pG
         d1z+6JAJa3OPINzSUpXx3tTmw1QiRD94f74z4gspMjRYI+YAKTP9O34NaGFKe0fGrZyr
         eLR6D3FNDvpda2vKVPK4OlU5G8Ehps+vLLgpxSEq3f3MV8BB4ymQLe5u3+hKDlHj6YX6
         uIEk3I9jj8BP4wCNnZaWC9Oy5pdNlUPpAkPF27RgX1ZhISxSA3+iHMrgap/iNwp8Uux7
         BDB/pXyTDqLxyhrXN0DsmMjutj0Aw1g9o2ycszIAdLtTCZrrq8oJr3Fe2jtFxpOBMRLL
         8PCQ==
X-Gm-Message-State: ACgBeo3I5G6pU8XfuKgiXIVaq6TqOqQoHQzP5vwgoihrSaXpsJ46z2vG
        QMhVRvyIikcBT8ikmGq2BrUQ2hVLEMo=
X-Google-Smtp-Source: AA6agR5SuJg/fdhJYC1OIOsJ+tFzVjiJwlW7CG8i2jD7HDSm5W7ezFa0v2xjDL77W+1X2eYePWrmOw==
X-Received: by 2002:a05:6000:2cd:b0:22a:4831:dfd with SMTP id o13-20020a05600002cd00b0022a48310dfdmr2160392wry.706.1662840037278;
        Sat, 10 Sep 2022 13:00:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v8-20020a05600c12c800b003a844885f88sm4275091wmd.22.2022.09.10.13.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Sep 2022 13:00:36 -0700 (PDT)
Message-Id: <ff54b6e0bb5347a0401a184a93e25c2550291de7.1662840031.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v5.git.1662840031.gitgitgadget@gmail.com>
References: <pull.1326.v4.git.1661962145.gitgitgadget@gmail.com>
        <pull.1326.v5.git.1662840031.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 10 Sep 2022 20:00:30 +0000
Subject: [PATCH v5 3/4] fsmonitor: avoid socket location check if using hook
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
index dba3ced6bb7..3463c71763e 100644
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

