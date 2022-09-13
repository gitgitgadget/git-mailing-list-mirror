Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFB0C54EE9
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 20:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiIMU2L (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Sep 2022 16:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiIMU1s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2022 16:27:48 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0F4659D6
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 13:27:46 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id az24-20020a05600c601800b003a842e4983cso10262913wmb.0
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 13:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=oFZbG9WkdiUYulw81PCz1BIFi8UiLOlwTp2wvCZ4/po=;
        b=YUBQNqsuFInA2zgdykswResN9cGHrTH48MIsrXfxYe9BFOxFUj35jn4Eu7WX0co2xX
         uSxeszblj4I5hTZUfI5vo+1IPy3wGs/z8LYn00xEb3dfieldCMM+mslZUNFnidnji0Wf
         AxXl1AcTgLNkcSdh5BEbgNJp9h9skKJYa5mepfepxmjoaCwLK2jjtfoS4piiosid08jR
         PVrGrlv0GKL/grDW5axHq4hLvl2M+oxzVUeTJWLPxHzGxD3x5XB/5WjZMIu5KgwDWsJs
         VLgUgQ2EXjVUo4VW8fHGQCG8vxXPHmosuvqfyG7AHjLN2RmcsFb8wnTptov4e0ETcXWy
         3YRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=oFZbG9WkdiUYulw81PCz1BIFi8UiLOlwTp2wvCZ4/po=;
        b=M0fhY/NicGub6N2va2XQ3EHN11WiIZbIH/39Wrn3KABjrYy8ePXB6k15XZ/PM4125u
         8W1qwt3i0mhJF94ijJejGeMMcvTsy8EhnaVolu5TVXkDfwTtrVlfmbnMXq84p3ZiyNze
         pWJJKy/KZIIeG6Hmeu1RFU83x2q3VM44QOXxf5MVNhV6kQfHod8hsAqDullMPHeTXr2u
         n4ieHXX29pKKNWq2RwisWRGUD2dMG5A0zjfHq9Tdu71ShVioCMt5wbEBieX6U2Ky8CB3
         GtYkk53K2Ij9LthkrlgAB0hu03Uoe/Sr7XJOLLDn4IeU1Z28VNx30PSTGwVsJMYNbs23
         7Vqg==
X-Gm-Message-State: ACgBeo1rgvpA0qE/24LeRlDHVIcU6VyEiJKAWD0unSKFyKQ04kjdD8ru
        jmTMPFJ+P/ue4JECyKDRki34sOqrd6M=
X-Google-Smtp-Source: AA6agR6eMD7opS0VERxSmlMHVq9pVNVcHMvobeif6r3SgSVXylt2an5qOw6GmYAKJhkyxNSQnHQiVw==
X-Received: by 2002:a05:600c:21c2:b0:3b4:7272:bfd3 with SMTP id x2-20020a05600c21c200b003b47272bfd3mr715673wmj.148.1663100864843;
        Tue, 13 Sep 2022 13:27:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o12-20020a5d4a8c000000b002285f73f11dsm14065072wrq.81.2022.09.13.13.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 13:27:44 -0700 (PDT)
Message-Id: <3428bcf8763b553b722699d4095cb30cbf9709b6.1663100859.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v6.git.1663100858.gitgitgadget@gmail.com>
References: <pull.1326.v5.git.1662840031.gitgitgadget@gmail.com>
        <pull.1326.v6.git.1663100858.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Sep 2022 20:27:36 +0000
Subject: [PATCH v6 4/6] fsmonitor: avoid socket location check if using hook
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

