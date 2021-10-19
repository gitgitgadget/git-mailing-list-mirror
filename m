Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22241C433EF
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 23:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03C936115A
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 23:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhJSXXt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 19:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbhJSXXp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 19:23:45 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563D2C061749
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 16:21:32 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n7-20020a05600c4f8700b00323023159e1so6302249wmq.2
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 16:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8kL7PtacOTfwnoQCo71fbueR0ZNSSCue3uDQCrOUMQc=;
        b=JoTH7wkG8WHvlBtUGncB143hAvhpw/x3LuDlkSTsa2DA5Wwl892WUrWanKMpGS4kTE
         cdkWPKR8dNpNeCYNOO2MZakSVokBKIArFImoxm6w+abaIDva7Lx2VCZDuFqSqMuDeQE0
         5aPEz+BLFneY//+yU6s1eD7ggR0ZaQrhfpKa1KQM6vh3395XJHmUMqpoQurnF0w6miHZ
         u3Sz837DOv3H27noeRRZ/er8zHcrQxjtDo8OVFgyYBZx1FawbpQHbPOTZBBGnwIKLBbJ
         9WXpEHBosEug0D4SdzjFowytDln/uQ5Wr9mBYMGhni8tX6grt6hD+0BFqjKol0mHwLTZ
         8vVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8kL7PtacOTfwnoQCo71fbueR0ZNSSCue3uDQCrOUMQc=;
        b=TxhGT3prxhx9lSHgNJDlL7RaOUrlNPyn4YqVAeEgYBaRKjjO4ymBoGpXM9zCCozyrY
         syvPIP5+1F1L0bUgDzn4aYLXiCX23AmwbN0DTDOhX19DWE13Dyvk/d6wxjKqO604DEOi
         IXqwSCF9sh+MfXfgZyv2NZnECcasKhWoT3s+iTHXRXjnFFjNTTX69EJuUIs5M5ibGWtV
         10dnd86nCjjnPg7Rypv2Y6nX+ep59MTU504ndQxvmBBmQv2hR/gnKIRAasvvw6hGgcaf
         5v9yYvsbZbD2lHBJNIh1ejeaEaCv3hKAYgxEKPo+a0E4qgzatDnZk2/FLgNWbJOb6a+9
         mi1A==
X-Gm-Message-State: AOAM533oBsTE6bvi7vyq3ncrjZdmYgK9e+KM1GNhERY2cMBICIQdp6a9
        LSivCWwxFp9260jjA8FC7sKShNSGR+XiJw==
X-Google-Smtp-Source: ABdhPJwtu9PKnb5SFeaeMqkNednZ78L9cneY0liaIY7kpArZeBRAbp80XB+GNUW9X0caAj62JyJI7Q==
X-Received: by 2002:a05:600c:4e94:: with SMTP id f20mr9606535wmq.52.1634685690597;
        Tue, 19 Oct 2021 16:21:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g25sm304644wrc.88.2021.10.19.16.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 16:21:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 03/13] rebase: convert pre-rebase to use hook.h
Date:   Wed, 20 Oct 2021 01:20:41 +0200
Message-Id: <patch-v3-03.13-cbbfd77a4f6-20211019T231647Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com>
References: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com> <cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Move the pre-rebase hook away from run-command.h to and over to the
new hook.h library.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/rebase.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 34b4744e5f3..758b5dfabe2 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -28,6 +28,7 @@
 #include "sequencer.h"
 #include "rebase-interactive.h"
 #include "reset.h"
+#include "hook.h"
 
 #define DEFAULT_REFLOG_ACTION "rebase"
 
@@ -1017,6 +1018,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	int reschedule_failed_exec = -1;
 	int allow_preemptive_ff = 1;
 	int preserve_merges_selected = 0;
+	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
@@ -1711,9 +1713,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	}
 
 	/* If a hook exists, give it a chance to interrupt*/
+	strvec_push(&hook_opt.args, options.upstream_arg);
+	if (argc)
+		strvec_push(&hook_opt.args, argv[0]);
 	if (!ok_to_skip_pre_rebase &&
-	    run_hook_le(NULL, "pre-rebase", options.upstream_arg,
-			argc ? argv[0] : NULL, NULL))
+	    run_hooks_oneshot("pre-rebase", &hook_opt))
 		die(_("The pre-rebase hook refused to rebase."));
 
 	if (options.flags & REBASE_DIFFSTAT) {
-- 
2.33.1.1338.g20da966911a

