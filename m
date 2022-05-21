Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B243EC433EF
	for <git@archiver.kernel.org>; Sat, 21 May 2022 14:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355356AbiEUOta (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 10:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355309AbiEUOtS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 10:49:18 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A87C6CA90
        for <git@vger.kernel.org>; Sat, 21 May 2022 07:49:17 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id k26so5917227wms.1
        for <git@vger.kernel.org>; Sat, 21 May 2022 07:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=m8p1uOker6ZHhkQ0KrCQd/v90ZOXrFXuyLcdcKVGstA=;
        b=GDfeoLhnj944BWJr8ROHHf+azKQRhCjSxz5KlHIe5b9B+xySAbUuJWS2IiQsjneDT8
         z3nFgKwcGqI2vixV4/zXRykJaLRpDJwyudlvy0fS/kF3ZxCIkC8n3c7cI9h0tfokTlxP
         yqKfMJF19szkV6R56IjZ/RguB4k2oW0ViawyzOkzUq6vKb5VuebpeAtzVXAnmRMwussx
         hnLXZAYA6hTPlZr5j+zpHzAe9lwjZAtrhUI90muzRBGaGt+Ia//hP6nZgfu7D1QPprnk
         uAIXNykoSjXYjl7+fMpYzISUL8HeR3yHP9Era9BZtjJekMbNSiF3g/eu+bpuuvSiMGzn
         cNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=m8p1uOker6ZHhkQ0KrCQd/v90ZOXrFXuyLcdcKVGstA=;
        b=z1QB3SfotYssYlKd+ylgAwTqt+c1QrG8WUaQ7aSYusYwfoh078ya6TTdY2CHvnhmJz
         BGe3kgz1JXRrzomRdKCtjX4Jzw4p9J7HGGvDOfYnbljrkABv/0+cp2Re15LSIpdOQSeU
         ohjxRdFjMs4kDhK4os5S9/TvBTqeyYUsgKpHA+tB8hzsMMfEatkQcB5NZA+EVYBNI/be
         bpvo0znkOxaGR0ItJ5onh90V9MdXdPlphNGmm/SyD1qFHeI+0LuFQK9odzdaLSM60etF
         1Iq1dyYYUNFlLVgfha9rCtdV4pGvt+tVrKTg4E0CqEvf1s4qc1YS7OwoLMDIjy6GMLxZ
         jEdA==
X-Gm-Message-State: AOAM532g1K6CqHRROzQdyXOQs91NehxgEvpOdkddCdygehJaO1oA1Co0
        hrFAi/C1lt1WhwONvMm++c4jTkzG9Ys=
X-Google-Smtp-Source: ABdhPJzkT5OkFwFFcUrgDVX2zsEyBFNnHWveoxywEitfcSflybiCrwPDNJ4lbw+U/McGMz8TxJAFJw==
X-Received: by 2002:a7b:c841:0:b0:394:890e:9195 with SMTP id c1-20020a7bc841000000b00394890e9195mr13312737wml.59.1653144555701;
        Sat, 21 May 2022 07:49:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 186-20020a1c02c3000000b003973e27b789sm2834068wmc.27.2022.05.21.07.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 07:49:15 -0700 (PDT)
Message-Id: <04ba0950b858e0c5b2549d8be52c89f12d579e92.1653144546.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
References: <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
        <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 May 2022 14:48:57 +0000
Subject: [PATCH v3 06/15] bisect--helper: using `--bisect-state` without an
 argument is a bug
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
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `bisect--helper` command is not expected to be used directly by the
user. Therefore, it is a bug if it receives no argument to the
`--bisect-state` command mode, not a user error. Which means that we
need to call `BUG()` instead of `die()`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 8f4dab48379..343aedbc545 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -899,7 +899,7 @@ static enum bisect_error bisect_state(struct bisect_terms *terms, const char **a
 	struct oid_array revs = OID_ARRAY_INIT;
 
 	if (!argc)
-		return error(_("Please call `--bisect-state` with at least one argument"));
+		BUG("bisect_state() called without argument");
 
 	if (bisect_autostart(terms))
 		return BISECT_FAILED;
-- 
gitgitgadget

