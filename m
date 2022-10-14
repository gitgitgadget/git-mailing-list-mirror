Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B363AC433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 21:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiJNVqH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 17:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiJNVp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 17:45:56 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87CD6715F
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 14:45:54 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id bu30so9544070wrb.8
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 14:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGtbzq+IH2Ws4ChKWDCxefvQxY0NorgXVM+ffiB3Qi0=;
        b=F1az9wlsLSSnPp6N2T7Ijlv41Fxb9qOHwu33S3GqJWkVd5Xi7r7zO1p2OgjZbHn1Gs
         Vy1KQdovPKzelRFsIU89+x+Z/gXHSpAkuQSiGyTI1JvsPc9ykmBQkGwd1BSxCkn6xWn/
         GJeUfnsM3VojZPt4QManGxLh3FZyjcxDrM0aNc0jVBDPeizEYNPLD1xuNx1dYW86snYM
         6bByuA+Tjr0dAMSAkrXnXbFLRzPUY0uyMAm/qaLNivFkkjRPRZQTZ4N3nxYsTr3pWLm8
         RqJm8Pfu2Qxgss8/PIDarLJMFSUemBZdK6BuqJNcdFx/n5V2sLON0wYXC/auw0IsF9ar
         MLfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bGtbzq+IH2Ws4ChKWDCxefvQxY0NorgXVM+ffiB3Qi0=;
        b=QCovL6YTb+vMKLb4tsd7MjHKQIr7d2VS/Pj9z3qLaKw4erEs0qxk8Ko4NaZxjIdy0o
         moIlBpmDR6PtNJ89NEKhMi1MVvzfAuZwJu3O6AkK3r74rD4lY5QAwGGM0Wwu2GAdSDpG
         MbpPAJhyFAoqJCl5rMk3GbLwYgg78X4lLinm683e7eUQd7pDcTFU5uIJ1abEE4U8caWo
         1p7PiNzJz8FvKaJKAHZFEwJFibXJxi/gjJQdATBFQmalOLywZGQUgI2v4tIRY2INLjpU
         C9sNbTGCqBrzacJIWRV9fktVpiapm6T/A5+XaEG89aGhoB0ZvU8e5i51/WN2c+uYemym
         sPlw==
X-Gm-Message-State: ACrzQf1De8xBTiqFT18rqfVzLZmOe9pN60XOJgXdvRGYruoMHq/er/1P
        GTYWjBUiwadBh0yuAjluP8gZw5gneNw=
X-Google-Smtp-Source: AMsMyM7utUc366AOv+gpY7fm+LuYG5YyKUL+83YHd9xKb9RX21/FSCC3YKXy434u/oSGwYEk0U30OQ==
X-Received: by 2002:a5d:4a4e:0:b0:22e:64a6:7a52 with SMTP id v14-20020a5d4a4e000000b0022e64a67a52mr4625309wrs.333.1665783952253;
        Fri, 14 Oct 2022 14:45:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e38-20020a5d5966000000b002252884cc91sm2736985wri.43.2022.10.14.14.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 14:45:51 -0700 (PDT)
Message-Id: <ab1e0ab967cee0e903e1ca2ee9e349a5ad400603.1665783944.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com>
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
        <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Oct 2022 21:45:37 +0000
Subject: [PATCH v2 05/12] fsmonitor: check for compatability before
 communicating with fsmonitor
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric DeCosta <edecosta@mathworks.com>,
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

