Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512B0C6FA82
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 22:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiIUWS4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 18:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbiIUWSv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 18:18:51 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C67A7A92
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 15:18:49 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id s14so10475674wro.0
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 15:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=Sn7vsF8saTSOV85OIZnrqZlKAyOg5t4JuZwq78TkGgc=;
        b=o6SK1y+cVxHGQiobBE6YkjkG8gu9EdCiDgAUGR047CO1+YexrHSnYANzdMglS8RWEm
         z41QSKX6NaAto/QtqfXdqAbERJsw/3EPCDqfU2HvZWW86ZmQ5Akad3rvOGnqafFfKxVi
         rWSuPHWc3Q2K4ZQNsyaUTrzoYTTOwQK2AATK1VA03Kk5YwqP1hyVJAPGsGuoY0NimkHj
         yDl6yudbzEDm6juBc+O6XcviayaKXLZmN4tr3xF7VeCiJol+/g/YpKOQAYwfKj3X5Rx0
         EPe1DpXcP6enQ7CJJTVYkSIDX8df7AMR8uy4cSJpBcRc0JQc+5RaE68+QteXaV1W+3Wv
         kxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Sn7vsF8saTSOV85OIZnrqZlKAyOg5t4JuZwq78TkGgc=;
        b=X0hO2oBQOcfWaUKx56wrde5+XHsiZP+mubgJHHP2lQwOFQZgtUSBCD9wD1LSjRCv7A
         c7YgxrgKYgzW+psADah5Gb9fsoVkK+6UCg2MdtYUFUNzSXguA7hIiXwtzRKaPiweUiF+
         cLWF7cemPtEfqzPfXUL7dCQc5Ezc/DdRM+6SiKWKmk5bc17ZNAfT2WXsln5nWflkyMey
         qANXmkhs+g5ze2KiAUnKOq6PJ/ceYwaiinX5/T2ncB6yP+EZny6MmgeenaJQXtDoKmUC
         WEEXVZIBAAZguU8IdKvnC9oQr/agkYDDR7CxYWjLR4AsLR2QLDzQCNCpCXG2qwvWgGgn
         e47Q==
X-Gm-Message-State: ACrzQf0I3861mWeO0abrhPZqdH+U/UwiQW7wgOBWxYfp1ysmBY7xK3Nn
        Lit0WcLUtQUd4CYVSjjdIJN9Nb5jwME=
X-Google-Smtp-Source: AMsMyM7SExgw9c+rNEf88saABZYH+LCQdaQFuCS1oRZCcNYORvM98Zaky2nu5zCNgqRhTQcry4Fa5A==
X-Received: by 2002:adf:f68a:0:b0:22a:ea5c:893f with SMTP id v10-20020adff68a000000b0022aea5c893fmr155411wrp.671.1663798728095;
        Wed, 21 Sep 2022 15:18:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h4-20020a05600c350400b003a3170a7af9sm5280477wmq.4.2022.09.21.15.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 15:18:46 -0700 (PDT)
Message-Id: <86c15299ae8094d077ff97ea79d6e54451ee071d.1663798722.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v11.git.1663798722.gitgitgadget@gmail.com>
References: <pull.1326.v10.git.1663705986.gitgitgadget@gmail.com>
        <pull.1326.v11.git.1663798722.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Sep 2022 22:18:39 +0000
Subject: [PATCH v11 3/6] fsmonitor: avoid socket location check if using hook
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

