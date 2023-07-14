Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DD7EB64DC
	for <git@archiver.kernel.org>; Fri, 14 Jul 2023 06:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235015AbjGNGB6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jul 2023 02:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234775AbjGNGBn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2023 02:01:43 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836F32D43
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 23:01:42 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbc5d5746cso14183425e9.2
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 23:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689314501; x=1691906501;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbgEM1HQh+zxc0NneZWWB9vEKt28mfOkzWftFKcSRCg=;
        b=YyCzzsfuaNQng95+LskkSrluycAfe3jE+/nDdT3k0Nu7SGJeq/eUz8HZpJkd5Eiu6k
         AtBklGqz6AYr7jSoTrzd1vb8yFid3e2FXY0Ap4sydgLotIJM8feQJ9TSdto0HEQKOuA6
         6VL/5cBPJI/WdNiRxNDPqc1hJ63G8yy/kMC2hRslfCy67a/nDiQHbjL4A/ONwm+R71L4
         qvw/cpOKDMXZZJUFb1KnSDzstpgk3r7o0z/VDlaNbEEkISL+0T4aAtBjLQWFUcyu7pbs
         PoExHYncQ5fnoaisiobgkdNeuKQaBZw/rjlN4HeIwCzCl8O2MtQA2tB0tFdjvhj36mBW
         dwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689314501; x=1691906501;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IbgEM1HQh+zxc0NneZWWB9vEKt28mfOkzWftFKcSRCg=;
        b=TFT/spgd61awizTIsF6lJVgUwCPTUarRmUjdh4xfYwFjn24HJDS+EsD0R9D21ov1WS
         APEczQhkc096J9as3Wbjd/glZgeyhJ/xzZybQo3yz/fAOpA9MrN83KaCivWQgeaNAIKC
         b6VyqF8GUTdUL6Hty0c9oC6fvzeLOEHur2ipvOiKXP0e2kzYGed8oxRUrPUJEwafhb8D
         QUifFTSMLfF1BKeb8nB2u1hJC5rt14IGMcbptQ8kZF8B9StNTql0woO9dcFmPNYNCj8M
         D772gOmiiDmLmX7SPCymUlZDdLd/zIE02t7FE72TN5HCvYZaOgG04bRGeNfWRxJ/JpqT
         UQDA==
X-Gm-Message-State: ABy/qLbnO4IqBryIFxyIn/RcIWMMF2gUT1P/D2H4mZwFkqAwkgDdCN4t
        Gtn7UMs8aDlEqkAYJZ4XlkVsszyA3QM=
X-Google-Smtp-Source: APBJJlHZZTZGjgxSKUqSMxc53sBemQ3/X1+yg6P7ik5gdfS535NIRA4x1FMGrIzhTGHvWOj4sw7k4g==
X-Received: by 2002:a05:600c:b57:b0:3f9:b17a:cb61 with SMTP id k23-20020a05600c0b5700b003f9b17acb61mr3236353wmr.13.1689314500843;
        Thu, 13 Jul 2023 23:01:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b16-20020a5d5510000000b0031417b0d338sm9840861wrv.87.2023.07.13.23.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 23:01:40 -0700 (PDT)
Message-ID: <f8f96a79b92b050ce3938905ce8a19fddf9cc025.1689314493.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1556.v2.git.1689314493.gitgitgadget@gmail.com>
References: <pull.1556.git.1688778359.gitgitgadget@gmail.com>
        <pull.1556.v2.git.1689314493.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Jul 2023 06:01:32 +0000
Subject: [PATCH v2 4/5] SubmittingPatches: emphasize need to communicate
 non-default starting points
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Linus Arver <linusa@google.com>, Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

The phrase

    and unless it targets the `master` branch (which is the default),
    mark your patches as such.

is tightly packed with several things happening in just two lines of
text. It also feels like it is not that important because of the terse
treatment. This is a problem because (1) it has the potential to confuse
new contributors, and (2) it may be glossed over for those skimming the
docs.

Emphasize and elaborate on this guidance by promoting it to its own
separate paragraph.

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/SubmittingPatches | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index f1d1446764b..40467372c0d 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -318,9 +318,12 @@ or include any extra files which do not relate to what your patch
 is trying to achieve. Make sure to review
 your patch after generating it, to ensure accuracy.  Before
 sending out, please make sure it cleanly applies to the starting point you
-have chosen in the "Choose a starting point" section,
-and unless it targets the `master` branch (which is the default),
-mark your patches as such.
+have chosen in the "Choose a starting point" section.
+
+NOTE: From the perspective of those reviewing your patch, the `master`
+branch is the default expected starting point.  So if you have chosen a
+different starting point, please communicate this choice in your cover
+letter.
 
 
 [[send-patches]]
-- 
gitgitgadget

