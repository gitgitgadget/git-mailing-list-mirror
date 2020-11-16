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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BCEC4742C
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 11:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54EEB22245
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 11:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYjfJuZz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbgKPKXU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 05:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729015AbgKPKXT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 05:23:19 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC249C0613CF
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 02:23:18 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id h2so23224413wmm.0
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 02:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tVoypWL/ZqKV0FHBZEGAHK+0wCgGjtBLlOB5vMSR38A=;
        b=ZYjfJuZzL3xi+X2TmnaR3vhocBmH8r1sMdBMjLkE/dRP5UstmA3coO+9YrMiNMm3eI
         7cT1lRMsXlj/IbVkNirXygqLSIeuCCUAnoghk8Eq2cxT3MVx+e/RkDqOEPmZ/bX4xKCQ
         BjUhz4CG+rAoX0nCVw7OfJuPeZ8OYUUJ1Cq0EUlVZePGIibrowKWAB5UHcM4UIIRbShh
         m6QVYBalJcrCo91hLqPctOj8p6ucBGsJ6BBPqOvolVaUrCjz/5jnvet+B4OH3klc/vis
         WIWN3pa58n+sp8czsq8hQ3hCCy3l6abmHfxcXTuuGIO/fqXZ5+SxZYtJBjHPb7dD89vO
         4gnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tVoypWL/ZqKV0FHBZEGAHK+0wCgGjtBLlOB5vMSR38A=;
        b=BYbdTICwu65wn5qVENVMJXfvexcMjGeDR1IfTu2H/RfgvhnYEP7oV00YUTGltoYpBN
         O0Bdv/hdm+2bUHjkJvgpQ/dzqwCO5xqqc5/QTO1vZJq57jP3PDzD1HOv9bx7cDXUmt6W
         tgFKihHg+wt0VtuML+m0IdaKHUr35/rsyJ/Y2IupNWMnF9AzqZxxXe81ERmZwnv7ML1/
         iHvE3DQ899Wu004TCcPa61oX5iHUymwus64C6H89PRzsCoR/tu4DrDo3aEbb6Rd3qfo1
         LJrPAavnZ8EskwzcEudwQHUo1/8GVd9qcaOK2Q1FJ5MukFSgg4kBRtiqh2QruPigCBH+
         LSNA==
X-Gm-Message-State: AOAM530Q76giV1lxfbTpunq/IvnNBBPAfihz118fYvBxb4f05yzdcpUj
        WXzk1EjbCbgnSZ0tRcBdLQqyFXs1urY=
X-Google-Smtp-Source: ABdhPJwqk7121zvPqgl3Xnu9AOrEFioy9oioE1cqZATduoiW1dDUNjRoJAx9dqSXbHuaemXx8UF1gA==
X-Received: by 2002:a05:600c:4101:: with SMTP id j1mr14371311wmi.35.1605522197263;
        Mon, 16 Nov 2020 02:23:17 -0800 (PST)
Received: from ylate.lan (atoulouse-654-1-426-233.w2-6.abo.wanadoo.fr. [2.6.209.233])
        by smtp.googlemail.com with ESMTPSA id f5sm22884520wrg.32.2020.11.16.02.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 02:23:16 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v5 09/12] merge: use the "resolve" strategy without forking
Date:   Mon, 16 Nov 2020 11:21:55 +0100
Message-Id: <20201116102158.8365-10-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201116102158.8365-1-alban.gruin@gmail.com>
References: <20201113110428.21265-1-alban.gruin@gmail.com>
 <20201116102158.8365-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This teaches `git merge' to invoke the "resolve" strategy with a
function call instead of forking.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/merge.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/merge.c b/builtin/merge.c
index 9d5359edc2..3b35aa320c 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -41,6 +41,7 @@
 #include "commit-reach.h"
 #include "wt-status.h"
 #include "commit-graph.h"
+#include "merge-strategies.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -740,6 +741,9 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 				       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 			die(_("unable to write %s"), get_index_file());
 		return clean ? 0 : 1;
+	} else if (!strcmp(strategy, "resolve")) {
+		return merge_strategies_resolve(the_repository, common,
+						head_arg, remoteheads);
 	} else {
 		return try_merge_command(the_repository,
 					 strategy, xopts_nr, xopts,
-- 
2.20.1

