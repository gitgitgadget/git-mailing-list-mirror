Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBC7ECAAD2
	for <git@archiver.kernel.org>; Sat, 27 Aug 2022 12:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbiH0Moz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Aug 2022 08:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbiH0Mos (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2022 08:44:48 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E8132058
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 05:44:42 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id e20so4732537wri.13
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 05:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=SbKPM9JTUZha4nG2bHynsELou0YoJeQnyy3IQBLS1ek=;
        b=IlQTgsUHtuNBkbef5r8UVLxXjJkakq1i3rjaRgC8LbQS+zePSmnaWM884mTDMz3fce
         BcsDikhr7k2GikJtsICPIi2LB1HVHyT+FUItCOVKa+cf78Hxb3N+EkNTeISjyAiZshPN
         sDUdSG6rg+YN43NKy7FUU6mfyRgEzbHctU/3KWIxyH8iyks2J1k7zVtGGYPtqH8XL1Kl
         3UfgkoLDiuicPLxIAfoaZ3gUvEHcHsyKlK/5Bnae6bAwUEPs9heRoGOGiB/eCfRLsKnL
         StaEQ8sAXrm/iIIyp/h0hzpcAApnN3ikd7rftVDmdO8ckVMhss2F8l41+o7m+4kfeg7c
         x5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=SbKPM9JTUZha4nG2bHynsELou0YoJeQnyy3IQBLS1ek=;
        b=kKD5xwhztHILbFk9XnILaStDc7xK2UufDW0EtmI7itbWnqQXHP2cBWH4fa8BrfZS2G
         o4Ti12lwhNugAtgtFbzLMogAK2TL2d+aPRkRxRF8mzsnvyWBaP6GnT7+OABR8Ui+myO7
         63R/Hj5k6IKpPr3XEfmJosUCCLNnIya4OVlFTHBMu5gbcYj/9sWSpUG4GJ1/PE/xLqmk
         VD/++wBpPNpfdqZMyzMLo2arO2cI/usQ9N6yLVrwxPgf5FCkxxrq87yGqieI02Osv5d9
         roz245PzGWZTCCqK88YHWvhtbJZbwcVkUGtpmdSnROmmVHK9qVSZtMySYi3AxjdrxwRC
         iwew==
X-Gm-Message-State: ACgBeo0pgtWIFnUS7vBznI9ILVuiffu1N79jEdtSgDx+cgf+ROZpNfjR
        FVoBsI5h78X0P1rA4NmM1u6bn1/uiPY=
X-Google-Smtp-Source: AA6agR5Tsqy2YAdj1pEEmJEniS943GPGA4/OhydeTX/xLfQD9PkRfvaDw2TuAevLujx5Fn3cWvjLkg==
X-Received: by 2002:adf:f841:0:b0:225:8b4f:9a5c with SMTP id d1-20020adff841000000b002258b4f9a5cmr2058877wrq.667.1661604280386;
        Sat, 27 Aug 2022 05:44:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v18-20020a1cf712000000b003a5c7a942edsm2614999wmh.28.2022.08.27.05.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 05:44:39 -0700 (PDT)
Message-Id: <bc5efc8fbfeac20073498d21fc6276c5c1a3870f.1661604264.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
References: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
        <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 27 Aug 2022 12:44:18 +0000
Subject: [PATCH v5 10/16] bisect: avoid double-quoting when printing the
 failed command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We already quote the command via `sq_quote_argv()`, no need to enclose
the result in an extraneous pair of single-quotes.

Pointed out by Elijah Newren.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index a00167f1373..5cf688c0dac 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1390,7 +1390,7 @@ static int cmd_bisect_run(int argc, const char **argv, const char *prefix)
 
 		if (res < 0 || 128 <= res) {
 			error(_("bisect run failed: exit code %d from"
-				" '%s' is < 0 or >= 128"), res, command.buf);
+				" %s is < 0 or >= 128"), res, command.buf);
 			break;
 		}
 
-- 
gitgitgadget

