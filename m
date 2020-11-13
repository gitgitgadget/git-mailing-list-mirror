Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EFDC4742C
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 12:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A08422240
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 12:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oxrRUPvL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgKMMLL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 07:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgKMMLK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 07:11:10 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230AAC0617A7
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 04:11:00 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id h62so8248052wme.3
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 04:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3pdkU+TcWfmw3HAdbGVR8mr5o0BL0LqEIUu3y24P5vM=;
        b=oxrRUPvLPU7FQyJ+Af7JRguYXSj95T/9SuoQBZ8rdwBECeuqpWsTMF7hSDEYTdysMS
         BEMPvkGnqr3Bl64gaDyzu1nSwkfDMEyxeRhhMLbS1g4PuMWO+6ZhZB51AMbNlDLbmFmp
         /TVWsecRI5TAYYuCyQv+T3Jn0h5WJr6FuMdJlqOxKxe6+LaHCZIrqXXhaBPq2eXBCVP/
         /Vn4ke0T3YePX0glpf3QA71a1lmftJGY5155i783a3kp74uRSt6x51rg2sFq8bRhBEsZ
         rm6Y9b2MpiIAdyKBFOBBrVgTaL5joJgMaAOyiyNhHTZvs1TIOIgE2Ge7TURdZy99JwaS
         SU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3pdkU+TcWfmw3HAdbGVR8mr5o0BL0LqEIUu3y24P5vM=;
        b=eH0GqkMXe27Igr1TXufQV0st5aJPZkMhYdM504kcZZcJSom6T6+GtD6DtZOeCNF4wj
         6RNlifJuTUkJhb61GHRV8DMEvx7m2KAi4W/3++BWmq8o0cDlVJcL5uA/xYoREo53veII
         OH9V0rsnAQeaFg9RAyGTRvKariL9Id+Ijx9ms2d4JFglT0BbUzWM6ovJYeZlDEL86+IX
         AkedEyKLGS0rgAtWzaU3+qcoAZkhbbd26yNKUhACKBLle50VGlmkhcgfWVeRAPyxh79y
         YDGcM+VA2MoRcbZEYPXdBbJUfTzZvk2RRpvSWU32W7FUGgXhEShTXkHdiQLiHFBEhx0h
         XdnQ==
X-Gm-Message-State: AOAM533LlQVq5zNuAnIOmBHRpmFynlXlCGNtvK9yHaZ4szxg6jjf0/k/
        IDMdK+HbvCv91MDlRZJIk7F30rSvFDU=
X-Google-Smtp-Source: ABdhPJyogB+I2Mg6lZ1Gq2Ru0shKRuukd6Sc7ZtYC2qr8wjc+yYtgI9PHz/t76xa97oLMJGHJFdOCA==
X-Received: by 2002:a05:600c:2cb4:: with SMTP id h20mr2241277wmc.119.1605269458565;
        Fri, 13 Nov 2020 04:10:58 -0800 (PST)
Received: from ylate.lan (atoulouse-654-1-426-233.w2-6.abo.wanadoo.fr. [2.6.209.233])
        by smtp.googlemail.com with ESMTPSA id g138sm10083697wme.39.2020.11.13.04.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 04:10:57 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v4 09/12] merge: use the "resolve" strategy without forking
Date:   Fri, 13 Nov 2020 12:04:25 +0100
Message-Id: <20201113110428.21265-10-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201113110428.21265-1-alban.gruin@gmail.com>
References: <20201005122646.27994-1-alban.gruin@gmail.com>
 <20201113110428.21265-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This teaches `git merge' to invoke the "resolve" strategy with a
function call instead of forking.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/merge.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 9d5359edc2..ddfefd8ce3 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -41,6 +41,7 @@
 #include "commit-reach.h"
 #include "wt-status.h"
 #include "commit-graph.h"
+#include "merge-strategies.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -740,7 +741,10 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 				       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 			die(_("unable to write %s"), get_index_file());
 		return clean ? 0 : 1;
-	} else {
+	} else if (!strcmp(strategy, "resolve"))
+		return merge_strategies_resolve(the_repository, common,
+						head_arg, remoteheads);
+	else {
 		return try_merge_command(the_repository,
 					 strategy, xopts_nr, xopts,
 					 common, head_arg, remoteheads);
-- 
2.20.1

