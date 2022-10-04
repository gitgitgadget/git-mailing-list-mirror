Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B32C433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 17:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJDRco (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 13:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJDRcj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 13:32:39 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0406E12D19
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 10:32:38 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id bu30so2518402wrb.8
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 10:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=Wcm8qpzJovNixZr4FfekgJCx0i3cU8b+4aQdred0fgg=;
        b=ea/XVsuaAEPQO+zx2BbkG9h87HjinYaTKCIGkuXlW22TCoT7GsAjmskHGmX5qvR7tM
         SFrHZHdV1/rgdiT4DWdWnzUNaJ6Uf2PU1N+Z9JI1fmbJJnY6lvsYXmoUPev2As6pEn2z
         QpyqGcsfwNtqjwgQsFAb7kITCeZNmYW0YjfjgLiODMfkfJb6RWh1PaAFnQoJZVoEcC38
         bR1nHlnqjGr9q9gnj84PqwurrMdu8TtHCdtPOQ5xu1kkXiVntI0weBo9QgGQgqi4ih1q
         KCIWK9uA6VlIAEzCaoshe2P4ZxY1jADmH4Nx0THcvPqbZTKi9ILdtA2l7sbb4JPN/yl1
         2C5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Wcm8qpzJovNixZr4FfekgJCx0i3cU8b+4aQdred0fgg=;
        b=ac9niyfpHhxn+DDYafVevndI/eEdbF8Yw15dAE9RJIiztDvnKxGBaQzWY5j3ne6Ghx
         D+7tGA61i/4BScaDGVdivV4A55vFJzPdRFy7HO6PY/fI/LX4OI60EifjMQ7sP7EuYb0l
         QNC/Bvvv5927wdbaGlmyAFVmr7SAo8dZmrApIxIh4wn/WTCWvGQtpVT6ItjD1eeNXSMD
         kuIJ4JogUzuhk9rBJYzyA/ZEt+ygHWQnAsXKHSaUsuU2ymf+M4kyNFiBIDso2a6jgwvs
         O9dK3LyA9e6p1ZVGqiTQ1oxGJMGPaSsF+9tWq41tlJSCKS4wYsZ6JFPxDAZoyXZ/LgA9
         CHBw==
X-Gm-Message-State: ACrzQf3b/hVO6AZOs6qK3MnDoVlqAiGqEFtJeM/gQexzwuoBD+HE5ujz
        7Wqs4KUmE4NeqFZPl1pbppDL1TRDvOw=
X-Google-Smtp-Source: AMsMyM7AiVNVI1iNit6KLVP5jRg2+C3Id+uDDuGmtUqHxFyw+Q085Z52HsTIH390TtmSJHFzigZ5MQ==
X-Received: by 2002:adf:ce01:0:b0:22e:33d3:e736 with SMTP id p1-20020adfce01000000b0022e33d3e736mr9138713wrn.327.1664904756240;
        Tue, 04 Oct 2022 10:32:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v11-20020a05600c444b00b003a682354f63sm20967116wmn.11.2022.10.04.10.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 10:32:35 -0700 (PDT)
Message-Id: <c5e8b6cfe5da269d27d3f171ccedd119a6db4840.1664904752.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v15.git.1664904751.gitgitgadget@gmail.com>
References: <pull.1326.v14.git.1664395931.gitgitgadget@gmail.com>
        <pull.1326.v15.git.1664904751.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Oct 2022 17:32:28 +0000
Subject: [PATCH v15 3/6] fsmonitor: avoid socket location check if using hook
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
index 7241c4c22c9..6abbc7af3ab 100644
--- a/compat/fsmonitor/fsm-settings-darwin.c
+++ b/compat/fsmonitor/fsm-settings-darwin.c
@@ -48,13 +48,15 @@ static enum fsmonitor_reason check_uds_volume(struct repository *r)
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

