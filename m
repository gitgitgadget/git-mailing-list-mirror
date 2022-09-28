Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFC3C32771
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 20:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbiI1UMb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 16:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbiI1UMV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 16:12:21 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428DBA2873
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 13:12:20 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id n10so21398945wrw.12
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 13:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=dGPBcKUgeUZ0B0/7zoDbOtB89jBJhmHgJI4xQ6b+zEk=;
        b=ohJP4mxdmhN4rM3SbM8LX8WAalnru1r0fX8+WD+FOc8jcvKMIhYX/B8Xugg1sGYVA2
         T7003Rn9JCqtNDrjdLo2aKyLD58BN1/fxzcl9iXkB2f5Udd4mmrUq+injsHSVpELuUtu
         V6CKNi0j9ZSe/aUCPB92pj5eFBSoTJnMTY1SdLZK7+QMB1zYGDSrTnm0/F2OlNFeA/wb
         jemu4Eh0MXp2ziijdN7a5M+8W9rxI6QZVl7Sh5FZM3LM01dnHfh7YlWaCvVOL7N6ByNJ
         WwaTUoqEpQdS9xFlIHPYwgUUtmoMF3h1rdYaNiev4AOy2uGza6pNoGpizrUDqQjGuwGK
         Ivkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=dGPBcKUgeUZ0B0/7zoDbOtB89jBJhmHgJI4xQ6b+zEk=;
        b=6iQ77uoMtLjpVliyoiGlkAqLIAsDHGswOThf9L45xgVoRz8TxdVlMRgFF+wHTVQbye
         +hw1vDxiF3X0ae/XstS1rA3GNP1Evxv8Bgmfb3X0ZhA7tyX85jMOTXiOAkJVDS9r53/+
         JavcBBC88e8F3AmtNQ1bJ6mXuyudYtAJ7zDuxrqLluRFEaQHxVGdA6GLyYsOydf9oKkr
         wXKGLvue3jLveWzkOTf2SFO14lLh3Ug4NeDPiYFKrO0JDiCspiSCja2biAoA7CewOM/K
         Extw/HBiYve486hEvx+uVwsa1TxC2VtTxtiojz9z7plzT304N0rVes/PcPMEJPtZYkBb
         ZvIA==
X-Gm-Message-State: ACrzQf0zL28NgXkJDSo2NskNI2MG8pxM4L0MBxeyfLISl+YWoIlaRV0o
        fXhIp1dALsK0ACgzLCCxKyreUOJpL1U=
X-Google-Smtp-Source: AMsMyM67+vdx8AwWsvZM4x8Ds+6QzxbbedC/2aTAdIL2z0VjbN1E9s2hBK4jRKLp3BsZ+mH8bBP0wQ==
X-Received: by 2002:a5d:6481:0:b0:228:dc1f:4f95 with SMTP id o1-20020a5d6481000000b00228dc1f4f95mr22108140wri.298.1664395938622;
        Wed, 28 Sep 2022 13:12:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f10-20020adff58a000000b002285f73f11dsm5895693wro.81.2022.09.28.13.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 13:12:18 -0700 (PDT)
Message-Id: <d906debba5e22d4cef0bc9d63d049ced24710882.1664395931.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v14.git.1664395931.gitgitgadget@gmail.com>
References: <pull.1326.v13.git.1664312253.gitgitgadget@gmail.com>
        <pull.1326.v14.git.1664395931.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 28 Sep 2022 20:12:10 +0000
Subject: [PATCH v14 5/6] fsmonitor: check for compatability before
 communicating with fsmonitor
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

If fsmonitor is not in a compatible state, warn with an appropriate message.

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
 compat/fsmonitor/fsm-settings-darwin.c |  2 +-
 fsmonitor-settings.c                   | 10 +++++++---
 fsmonitor-settings.h                   |  2 +-
 fsmonitor.c                            |  7 +++++++
 4 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/compat/fsmonitor/fsm-settings-darwin.c b/compat/fsmonitor/fsm-settings-darwin.c
index 40da2d3b533..44233125df8 100644
--- a/compat/fsmonitor/fsm-settings-darwin.c
+++ b/compat/fsmonitor/fsm-settings-darwin.c
@@ -38,7 +38,7 @@ static enum fsmonitor_reason check_uds_volume(struct repository *r)
 	strbuf_release(&path);
 
 	if (fs.is_remote)
-		return FSMONITOR_REASON_REMOTE;
+		return FSMONITOR_REASON_NOSOCKETS;
 
 	if (!strcmp(fs.typename, "msdos")) /* aka FAT32 */
 		return FSMONITOR_REASON_NOSOCKETS;
diff --git a/fsmonitor-settings.c b/fsmonitor-settings.c
index 531a1b6f956..ee63a97dc51 100644
--- a/fsmonitor-settings.c
+++ b/fsmonitor-settings.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "config.h"
 #include "repository.h"
+#include "fsmonitor-ipc.h"
 #include "fsmonitor-settings.h"
 #include "fsmonitor-path-utils.h"
 
@@ -242,10 +243,11 @@ enum fsmonitor_reason fsm_settings__get_reason(struct repository *r)
 	return r->settings.fsmonitor->reason;
 }
 
-char *fsm_settings__get_incompatible_msg(const struct repository *r,
+char *fsm_settings__get_incompatible_msg(struct repository *r,
 					 enum fsmonitor_reason reason)
 {
 	struct strbuf msg = STRBUF_INIT;
+	const char *socket_dir;
 
 	switch (reason) {
 	case FSMONITOR_REASON_UNTESTED:
@@ -281,9 +283,11 @@ char *fsm_settings__get_incompatible_msg(const struct repository *r,
 		goto done;
 
 	case FSMONITOR_REASON_NOSOCKETS:
+		socket_dir = dirname((char *)fsmonitor_ipc__get_path(r));
 		strbuf_addf(&msg,
-			    _("repository '%s' is incompatible with fsmonitor due to lack of Unix sockets"),
-			    r->worktree);
+			    _("socket directory '%s' is incompatible with fsmonitor due"
+			      " to lack of Unix sockets support"),
+			    socket_dir);
 		goto done;
 	}
 
diff --git a/fsmonitor-settings.h b/fsmonitor-settings.h
index 0721617b95a..ab02e3995ee 100644
--- a/fsmonitor-settings.h
+++ b/fsmonitor-settings.h
@@ -33,7 +33,7 @@ enum fsmonitor_mode fsm_settings__get_mode(struct repository *r);
 const char *fsm_settings__get_hook_path(struct repository *r);
 
 enum fsmonitor_reason fsm_settings__get_reason(struct repository *r);
-char *fsm_settings__get_incompatible_msg(const struct repository *r,
+char *fsm_settings__get_incompatible_msg(struct repository *r,
 					 enum fsmonitor_reason reason);
 
 struct fsmonitor_settings;
diff --git a/fsmonitor.c b/fsmonitor.c
index 57d6a483bee..540736b39fd 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -295,6 +295,7 @@ static int fsmonitor_force_update_threshold = 100;
 
 void refresh_fsmonitor(struct index_state *istate)
 {
+	static int warn_once = 0;
 	struct strbuf query_result = STRBUF_INIT;
 	int query_success = 0, hook_version = -1;
 	size_t bol = 0; /* beginning of line */
@@ -305,6 +306,12 @@ void refresh_fsmonitor(struct index_state *istate)
 	int is_trivial = 0;
 	struct repository *r = istate->repo ? istate->repo : the_repository;
 	enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
+	enum fsmonitor_reason reason = fsm_settings__get_reason(r);
+
+	if (!warn_once && reason > FSMONITOR_REASON_OK) {
+		warn_once = 1;
+		warning("%s", fsm_settings__get_incompatible_msg(r, reason));
+	}
 
 	if (fsm_mode <= FSMONITOR_MODE_DISABLED ||
 	    istate->fsmonitor_has_run_once)
-- 
gitgitgadget

