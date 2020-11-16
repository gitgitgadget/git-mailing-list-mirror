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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB90FC4742C
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 11:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BBA1221F8
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 11:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bc2z/mWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbgKPKXV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 05:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729015AbgKPKXV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 05:23:21 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2D9C0613CF
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 02:23:20 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 19so23201281wmf.1
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 02:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RUfvN0pl5K/WuXCV4D53cIPGvmeqL7bcfgCSQ17fPJA=;
        b=Bc2z/mWpQgJo5lBlZSdRblZPTedDK6eM56aTBqJe+iEwU6+s681zg2DBuThxuMR+dg
         SUFcnB8RoKOoYO897IS1ADlMEJa+Q2Vtlm2ND+FTi750lJ9HIt4rxyO3PAix55P7gNMN
         lArgIeaMMHMPep8kb5N6IGOaVo1zvhydRVTXaC/3iHVsFS00BzwYfu9uiwvlJgMdLxgD
         Jmx/sX66LYMqjYXw+4jsw5wmHNHOyASm081k8JR/r0W2z53vp0pD2bo10f+plh2nLPtV
         OWdHIiFEkaE+uzx25vswP/L9cwXoZjENLLmPxqkp1xi6el0sq6imF8Xsu6kmX2H3LjaG
         566A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RUfvN0pl5K/WuXCV4D53cIPGvmeqL7bcfgCSQ17fPJA=;
        b=jXHrJhnyawYe3iDtnrSmginoMWEmqarfpYuPIJZq3aWdA4I5+7YX0Saoz05rH8o5Ol
         NlWE0Eh/YqGSQz8/vOFgi69C5bRIWa7jg5XKJNbx4Lajy/qv+ss95tWEuPVS8Ime7L0U
         r8IkU0sZc7m1TI6H5JdzySro6kKxYE4ACslaSWiWbGb0bTUXcLD1EzekCeeNVCwB897P
         RSPc2kZdL+ae8cfvULf/+Voj0PtelzuYQS/Tl1rKUwGydqh6KSZC4fL0OenpOaZ10+Or
         4Tj/+XfQBogp+Rroe6HxST+uUnL08uMcBJcCKY8OtKzSKLbbQ8NPUe+78hJntLMPkjTw
         091w==
X-Gm-Message-State: AOAM533m5MKMIt5xm9nPL6mPb6eztTX0vv7puOsnWyTxz1Tc7IeZq6MA
        W0hcvvZvXinfV3Pqg2ikEdpXFaSE81s=
X-Google-Smtp-Source: ABdhPJyWwCPDbcP62b3nNZlNEwUrAeNmVAfwkyZpSyhOLgdMdu+agbb6GFs/4GIoo0j3ijWgytcarg==
X-Received: by 2002:a1c:20d0:: with SMTP id g199mr15684455wmg.68.1605522199500;
        Mon, 16 Nov 2020 02:23:19 -0800 (PST)
Received: from ylate.lan (atoulouse-654-1-426-233.w2-6.abo.wanadoo.fr. [2.6.209.233])
        by smtp.googlemail.com with ESMTPSA id f5sm22884520wrg.32.2020.11.16.02.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 02:23:19 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v5 11/12] sequencer: use the "resolve" strategy without forking
Date:   Mon, 16 Nov 2020 11:21:57 +0100
Message-Id: <20201116102158.8365-12-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201116102158.8365-1-alban.gruin@gmail.com>
References: <20201113110428.21265-1-alban.gruin@gmail.com>
 <20201116102158.8365-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This teaches the sequencer to invoke the "resolve" strategy with a
function call instead of forking.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index e8676e965f..ff411d54af 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -33,6 +33,7 @@
 #include "commit-reach.h"
 #include "rebase-interactive.h"
 #include "reset.h"
+#include "merge-strategies.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -2000,9 +2001,15 @@ static int do_pick_commit(struct repository *r,
 
 		commit_list_insert(base, &common);
 		commit_list_insert(next, &remotes);
-		res |= try_merge_command(r, opts->strategy,
-					 opts->xopts_nr, (const char **)opts->xopts,
-					common, oid_to_hex(&head), remotes);
+
+		if (!strcmp(opts->strategy, "resolve")) {
+			repo_read_index(r);
+			res |= merge_strategies_resolve(r, common, oid_to_hex(&head), remotes);
+		} else
+			res |= try_merge_command(r, opts->strategy,
+						 opts->xopts_nr, (const char **)opts->xopts,
+						 common, oid_to_hex(&head), remotes);
+
 		free_commit_list(common);
 		free_commit_list(remotes);
 	}
-- 
2.20.1

