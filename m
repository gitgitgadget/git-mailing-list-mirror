Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0E8C433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 17:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJDRc7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 13:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiJDRcl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 13:32:41 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D9810A8
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 10:32:39 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id r13so909768wrj.11
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 10:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=bGtbzq+IH2Ws4ChKWDCxefvQxY0NorgXVM+ffiB3Qi0=;
        b=he+S6y52fU0WjD5RTXnAS5HNKpu7nk6GB2WQi7xhXt7S8bIirM73GiXOinZ20JdhQB
         hXw1bedLSVD53V2GwWbszUAagMhMtkE9/SYHq9HEN0/eCmZtH3iwehABWJ1S9pJg2CWX
         qYyXgcLjtdPAGGR+XN1nYuIYvcg9MWm6GbGOnDKGetcaLpwFJ9QtZ8Lr6Mp27saW1mR/
         GEn7ADGFimOsTkeIulZBOLjokD4as14pUCC1gnTfiPUi9X4JK3l0fxGbZJCLva7NExvL
         1Lbj87HfoaePiUuk77aI4j5CfnHBO1CPqRz0fgRyJUVLfzl1FMTAsMAuFFJEk68ilqlK
         HY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=bGtbzq+IH2Ws4ChKWDCxefvQxY0NorgXVM+ffiB3Qi0=;
        b=KICCWMGzjoXlPYx06Hy40dXpmeN9s8NxQPhOnqRcyWlgOc8SOl785A8K3FsEgt9Ufl
         ZgEZj9AVAzI8j3NbD5sotEKFw+J5TiM2ydP5Y+IsqHs6o2fXtbQ1FHwf4wsycDsNVK7L
         +7bNIosQpzp1SEgDQrfm7E2F/h/kf4pTWw+liZwR78WFqrWREGZ9kvJ6ZBW87AJrPS9l
         u8x95tQl7CniQdKa3xtAXdfS0ZXjvIZ6qp2UrGLq1vxGVzjkWGr1/QMUMH7amNHyvYr+
         PFe4/GZpfbd8dp8/E3ah2oJO5rufxSGQiHK9HymiLC0QR3chVU/ouLRSrPvBWFMTW817
         I2RQ==
X-Gm-Message-State: ACrzQf0NxfG4w1gVISYv+Ou55RN4tkUtIfN1rbroEkeD3LnG4+LvbLPh
        8SprwcCOGauwK4ezbLsElTzmqtio0yg=
X-Google-Smtp-Source: AMsMyM752iG+LnNhaYNLsJ9K7p/+zi1t3mpJv6iYqIhwchD4+Wm/JNp8rn7FbA/DeqJmtfKTXACU2w==
X-Received: by 2002:adf:9cd0:0:b0:22a:7cea:d3c3 with SMTP id h16-20020adf9cd0000000b0022a7cead3c3mr18144499wre.196.1664904758034;
        Tue, 04 Oct 2022 10:32:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d5606000000b00228d52b935asm13491572wrv.71.2022.10.04.10.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 10:32:37 -0700 (PDT)
Message-Id: <fa974bfd5ef8f24d259ec31663ee18b65d96d83c.1664904752.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v15.git.1664904751.gitgitgadget@gmail.com>
References: <pull.1326.v14.git.1664395931.gitgitgadget@gmail.com>
        <pull.1326.v15.git.1664904751.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Oct 2022 17:32:30 +0000
Subject: [PATCH v15 5/6] fsmonitor: check for compatability before
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
 fsmonitor-settings.c | 10 +++++++---
 fsmonitor-settings.h |  2 +-
 fsmonitor.c          |  7 +++++++
 3 files changed, 15 insertions(+), 4 deletions(-)

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

