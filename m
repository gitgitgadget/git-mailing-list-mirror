Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92ED5C07E9D
	for <git@archiver.kernel.org>; Sat, 24 Sep 2022 19:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbiIXTqo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Sep 2022 15:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbiIXTqi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Sep 2022 15:46:38 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C4F48C8A
        for <git@vger.kernel.org>; Sat, 24 Sep 2022 12:46:34 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id o20-20020a05600c4fd400b003b4a516c479so1628013wmq.1
        for <git@vger.kernel.org>; Sat, 24 Sep 2022 12:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=M58ovVH7qQmFE7/y6TsCYY0421wXbthVbFv0a0LHw/A=;
        b=PWIhDY3L2gLqPfb0G0ZVma2isxWrAXdXkazAAnfa1piOXVjd/uiGsJvSmC6nnxWiK4
         29a2OYkQw4ww5pIwLGXey+5NSJ4pLq7/hWh5EQiO/UOUBEwYI1WM6R9CkPL7rQ3fHkvV
         /cqD6jsZULExjnDCZp1I5BcwFg7NBQHlBsoSa56Hop6NpnEFDtKyUoQW49dFwA9UUjbs
         e31vKKCIpOKIUTihltIb1X77ORFUnS5EKf4/1yFA1E3TwgrdlrEgzzxaguuuype8Da9t
         gZJMyL7b+zpG/sSiUcpKwWIg0bBVqPFboFc1yW8my0D1g5dGTJ0/umrouVviUhjRfpaY
         FY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=M58ovVH7qQmFE7/y6TsCYY0421wXbthVbFv0a0LHw/A=;
        b=e4/6qdeTKxcnI8w924wk5dssqltVDoq5go8lV3pIzjl4cO+8mqr0RoEogE3S6ZpJR/
         7yBSiOWCiZL2qEWPD0u5K9daALUxzVx2Cr3oD4vDgYRwuMasm64pTY0FcgSRQ/n0J2ef
         NzF8BeYmeoTgIJBkRBWYyR17Kj6lN6hhd6X4Rz+XgdBq5h37sGVtZsSrdS4W9gtes6R2
         jd5nSV7VrWY01DNfxkHj4V4/frkNcKo1JYWwuCl8YnksEPyTM6hNm0t2K1pr3KdT6u61
         fGd+wTp+tIqvnl5qxhsKzeHngqmGV/EuIXS5UfG83y4dej5Nj0xNGWc/0azEuaOvKD/Q
         +w7w==
X-Gm-Message-State: ACrzQf2yKLAVQnIE9a8UV0xQi4Vs3dN1RIPZEL0+gI0h7ZzapcfoiGmT
        68MpjE8IywOKRQdSONVXw5jLx6S64mw=
X-Google-Smtp-Source: AMsMyM7CzznO2Pq7rpZwr0rkiETDURv1+xDag3ZkESiqM/xNA0v+A5mfxalueOj+oOrDmUdtpmaz6Q==
X-Received: by 2002:a7b:c392:0:b0:3b4:acef:3523 with SMTP id s18-20020a7bc392000000b003b4acef3523mr10199863wmj.37.1664048792985;
        Sat, 24 Sep 2022 12:46:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id cc16-20020a5d5c10000000b0021e4829d359sm10673277wrb.39.2022.09.24.12.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 12:46:31 -0700 (PDT)
Message-Id: <421d77775dc24e52ab26336a1a82ed0e7b15ff5a.1664048782.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v12.git.1664048782.gitgitgadget@gmail.com>
References: <pull.1326.v11.git.1663798722.gitgitgadget@gmail.com>
        <pull.1326.v12.git.1664048782.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 24 Sep 2022 19:46:21 +0000
Subject: [PATCH v12 5/6] fsmonitor: check for compatability before
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

If fsmonitor is not in a compatible state, die with an appropriate error
messge.

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
index 531a1b6f956..8592a4d9bad 100644
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
+				  " to lack of Unix sockets support"),
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

