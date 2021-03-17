Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354FCC43619
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 074D864F59
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbhCQU5N (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 16:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233528AbhCQU4z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 16:56:55 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59B8C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:56:54 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so2092472wmi.3
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e4q9Sln4qQ9lnCVQ077YND44pUDtXZTSOjP4tVtt7Lk=;
        b=g+0FHu6LeUzz+jdRwTsnz5BT8GprhlJJQDhLFSFB+58G6cehISSxY/kK/vrM3IAFX/
         3p2Q/LDyxrksvgOyi6f9wK6LM6PC9ZC11Blj6oCGws/i4M2Z7T2hEhz4rbYduei16q3R
         Iaan8D11FH+PGf+aEqB99+RfgJVEWaDioMr/V/oRVh3p8dbh3FrQkqzrcFzsKvBIM+pY
         2ulvFHkr58bktU7xNZ1ZCZluJTu7OAuem4J6C3jR/ooRWXNQwspQdzK+M9o76VVfkXVx
         7yw0R/tB65H7M3fIoE1DzviXgWl+r1KZ9UuAEM7iBxjvJEXc8mKiQx88DR4BfKIf78U+
         82hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e4q9Sln4qQ9lnCVQ077YND44pUDtXZTSOjP4tVtt7Lk=;
        b=kliyJ9sdyD54zXJqB0PrttJ/VOVHz6fkUvKHRFYMpsuvpvX+ks6Rrudebqn2MfbwaF
         ShmCR2mdOtvYSAi0ttjR7/Ak03lPENeNZ2a+hixLgjlZ+CukKk80ipP7B9sPTdlvG/i1
         LaHqyrSneuRnc6J12C1MnvKs9qc2c2vb3pLEJB3SpV6s175IN3divX5PoV1W/WMVDqJE
         22RPz+6eQtPysYEsnjr2/OLkz0jKyVFHPqKMcV+lREOci4qAa6b558bTUXnfXBWqFTy5
         nHSAXOTbEciavvuU50yAJrImgs+cqvlhiHhryZanrgaoV73LNPn0Q96B4V0+dvagPkzn
         qtMQ==
X-Gm-Message-State: AOAM5326fsuWg/qicz640I6fvvAFsNAIrAWaxZZ4UylHrO6l1RpBQf+5
        2sCtMlfTr7eLFba++YXNII7CZVWc4s0=
X-Google-Smtp-Source: ABdhPJx1W5fAiDhxBiiurp59rjd5bI/hNPZDyw4prJkTUS48c8qiwgg0rXWXxX9V2AVRArkD5JPm9g==
X-Received: by 2002:a1c:a958:: with SMTP id s85mr570544wme.138.1616014613435;
        Wed, 17 Mar 2021 13:56:53 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-299-135.w86-199.abo.wanadoo.fr. [86.199.82.135])
        by smtp.googlemail.com with ESMTPSA id g5sm158452wrq.30.2021.03.17.13.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 13:56:52 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v7 13/15] merge: use the "octopus" strategy without forking
Date:   Wed, 17 Mar 2021 21:49:37 +0100
Message-Id: <20210317204939.17890-14-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210317204939.17890-1-alban.gruin@gmail.com>
References: <20201124115315.13311-1-alban.gruin@gmail.com>
 <20210317204939.17890-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This teaches `git merge' to invoke the "octopus" strategy with a
function call instead of forking.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/merge.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/merge.c b/builtin/merge.c
index 87921497a2..79f1e8bdd1 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -759,6 +759,9 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 	} else if (!strcmp(strategy, "resolve")) {
 		return merge_strategies_resolve(the_repository, common,
 						head_arg, remoteheads);
+	} else if (!strcmp(strategy, "octopus")) {
+		return merge_strategies_octopus(the_repository, common,
+						head_arg, remoteheads);
 	} else {
 		return try_merge_command(the_repository,
 					 strategy, xopts_nr, xopts,
-- 
2.31.0

