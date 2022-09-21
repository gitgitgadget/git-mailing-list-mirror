Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CC3C6FA82
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 22:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbiIUWTL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 18:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiIUWTI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 18:19:08 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AAFA830B
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 15:18:52 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id h130-20020a1c2188000000b003b4cadadce7so159785wmh.3
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 15:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=brrCKhLKTOytyAJN5XbPqM+am5Fv8WUOa6E2Iustbho=;
        b=AiSx3tNnoepo54B0BAdxufmg7V65Cu/pHRVS13j8IbXWoQqXcAhioL4qdLaDy+i04W
         5QMdQ4S97E93uvpNb4DbYDHOqUk8f9nRjINNJBZzBmaeY8fpnwNJSOgbhj6XNNnP/yAE
         1qgtlzezlBnFx7OJTLrXYxX78obuReFu51llze0/3u54XusTeG5ULRDxGEIM/YVfxcvP
         bBBJnMEMXtWKLLZSpweNCu5YtdfwO3tGKfx7bMXmqVfKGexwpDCK5ZSw022z3YvliPgB
         eBndRG+zSA7VmSqCR0V9en19idZVVp9h0I/ZvHE8wPJKoGNGK/Pzp181KlURxmpiI9ye
         ySkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=brrCKhLKTOytyAJN5XbPqM+am5Fv8WUOa6E2Iustbho=;
        b=wLK7Wi1pbOcoifB7g9huTq8jq3fOHxhOfIuKgg2bD1P2F0PI5WnQaH2vev8Q45YgOD
         LlHH/ujTDJDpCQzye0I3jgWmwmrg4MV/XOG9bBPDr1gXphYcB8YnOWysSzQ5oyuMzDgX
         2RLjxk5Hn9Hyvs6Ahuu01uC2GJupzLpmtSLVfdTbwt/kQ6SA8Do36gnu+cwPZrln/cWP
         PdfprHHLTQOIBMHwWFO4d76qegRelTs0JIKpSYU/I3rWqAcNfA606SuhjpWiGDceIdDa
         0hvl/le+YaDj1N9jfpyQOB+iQ3NvlxArd7XsxCcTr7MQm4VFwvLpgBYkx7FMealRbj74
         XnaQ==
X-Gm-Message-State: ACrzQf23a9FjZzz1k75E21h+c20sfsYhl9ImZhq01PkElm142GuRe2Y6
        6jt7O/U2eo6MtHunMRbQKzStEDXpxZQ=
X-Google-Smtp-Source: AMsMyM6Y4Qm4FcsqNhjghBWpF0a3gnPmplut2MG+vMVR+V1FYCExlilgjVIB/RFQ02uvkghuQQAYiQ==
X-Received: by 2002:a05:600c:310b:b0:3b4:c1ce:cd83 with SMTP id g11-20020a05600c310b00b003b4c1cecd83mr7141315wmo.91.1663798730354;
        Wed, 21 Sep 2022 15:18:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j3-20020a05600c300300b003b4868eb6bbsm4545781wmh.23.2022.09.21.15.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 15:18:49 -0700 (PDT)
Message-Id: <e0fe05dabef92535ab42437d3a04025c5a1cc464.1663798722.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v11.git.1663798722.gitgitgadget@gmail.com>
References: <pull.1326.v10.git.1663705986.gitgitgadget@gmail.com>
        <pull.1326.v11.git.1663798722.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Sep 2022 22:18:41 +0000
Subject: [PATCH v11 5/6] fsmonitor: check for compatability before
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
 fsmonitor.c                            |  4 ++++
 4 files changed, 13 insertions(+), 5 deletions(-)

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
index 57d6a483bee..1a86b9789a9 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -305,6 +305,10 @@ void refresh_fsmonitor(struct index_state *istate)
 	int is_trivial = 0;
 	struct repository *r = istate->repo ? istate->repo : the_repository;
 	enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
+	enum fsmonitor_reason reason = fsm_settings__get_reason(r);
+
+	if (reason > FSMONITOR_REASON_OK)
+		warning("%s", fsm_settings__get_incompatible_msg(r, reason));
 
 	if (fsm_mode <= FSMONITOR_MODE_DISABLED ||
 	    istate->fsmonitor_has_run_once)
-- 
gitgitgadget

