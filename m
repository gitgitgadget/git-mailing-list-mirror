Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7DEC433FE
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E63E560F23
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236835AbhJLNdH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 09:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236821AbhJLNdE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 09:33:04 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2AAC06174E
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:31:02 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g10so80377999edj.1
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hk7VAKpCJ9kv56DGsimnorPjq9Gc1UHu3Y22jaTXlI4=;
        b=Gu0lkqCxvpXY7gfLidVmi8XjmbCgWRlT8rmDFYBYzEJmCnGKnDgYAiuTekaAEf1HYo
         dqU7EVMC1LbNoZ7q1Iix6Jdo+8flQUas4L7y9SvgGD3+RwEWXXGR0C72T4q36/U+19HN
         Oweq+PbOFQBB3frKVy+SmCZmymb71laXxc7QsP4jUFnLC8TLtPJgSG9yTnMHWkP+3+Hn
         6k6dTvs1cnbmSygMSmLV/SOG95iS0hAIdkigJ2zawYVCnnq0pxUuqUHvQe0UpeKjl+Ax
         ZUnZs5ww9EOFMC4RIRCVgAFpZ6JlHoj6W7VAdiKcrvp6sO0uuyQ32QixLpiPpaXR6zWl
         G/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hk7VAKpCJ9kv56DGsimnorPjq9Gc1UHu3Y22jaTXlI4=;
        b=xeC1FjURidQpX+VfD+XbGvEyVP7uK7MoTju73q/i2IA1fkAr4iRuKFjF/HzaF42kca
         NsSFz237I3sBoQgYTdiVlgkEla+qZj785uagBs1IpY0zZck//AfFqRJi4KLOFF2WuSEc
         hSgAw2eUBtSFtzEG7vD6z4pgJv0YWLzU8suQTp3k7nPhwbJ/f2aobtGnZp1+srgUAuk6
         tMa2sitY5TCuPa9pSdq7El/JtMtM1LGCFjHJzZdJDGUau6+VH0w538rERca0Sfh8Qm9k
         QOL+Gz8XcDISmbhkpXp2rcr969ONz75CDLXghAv8KqFD4CCEG1jfUfC32EKS/tVvrcm3
         BAew==
X-Gm-Message-State: AOAM530Ssdgd6A2GeyUl0EDSGU6fAHTdo30qEl3BHVYYqCduYeJpyOKa
        nXjsby17q2M8lGlzSE/FaTGwdO0GUdQ47w==
X-Google-Smtp-Source: ABdhPJw/YGaW6TxmX77wDLw3CpZOfe+ct+fMO5/rrPPYpHIkZ7K4yh/YN55A4CMwbCgyfRENCo7hcg==
X-Received: by 2002:a05:6402:1d55:: with SMTP id dz21mr39085307edb.164.1634045458377;
        Tue, 12 Oct 2021 06:30:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bi23sm2016405ejb.122.2021.10.12.06.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 06:30:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Luke Diamand <luke@diamand.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 03/13] rebase: convert pre-rebase to use hook.h
Date:   Tue, 12 Oct 2021 15:30:28 +0200
Message-Id: <patch-03.13-ff306debcb8-20211012T131934Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1567.g7b23ce7ed9e
In-Reply-To: <cover-00.13-00000000000-20211012T131934Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20211012T131934Z-avarab@gmail.com>
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
index 8c6393f6d78..9a44939d662 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -28,6 +28,7 @@
 #include "sequencer.h"
 #include "rebase-interactive.h"
 #include "reset.h"
+#include "hook.h"
 
 #define DEFAULT_REFLOG_ACTION "rebase"
 
@@ -1305,6 +1306,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	char *squash_onto_name = NULL;
 	int reschedule_failed_exec = -1;
 	int allow_preemptive_ff = 1;
+	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
@@ -2021,9 +2023,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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
2.33.0.1567.g7b23ce7ed9e

