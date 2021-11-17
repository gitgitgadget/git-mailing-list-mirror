Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F53C433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 09:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3600D6137E
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 09:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbhKQJg7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 04:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234380AbhKQJg6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 04:36:58 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AE7C061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 01:33:59 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id r9-20020a7bc089000000b00332f4abf43fso3391534wmh.0
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 01:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rdZ+Hyhdeez5sYovoNl4c+4e/sjVspsttzqtSN0P6X8=;
        b=KBXnbFppNQU8nSiij6uTcHf+CPHtP5CH7XW9DrNmRtzj8dqB1E5Gdd6dT9JsQ0LXGJ
         psQXWc7SjmTEg6S53FIKUZKqU2UmJPhNmbupTXuc6inYlAnA7iMgmQxpER/uVK1VOQmF
         q96MjMQmktKxlKc9eYEPst+/afYrSM1On5nP7JOgxzi7oIy11fgLTaxwdlYa1Su9G79T
         IF5c4F0FrjUV/wmIhbcBPYqVfxPeAhtvc3FhTqONI9jHL2Up0CZOrpolnMWaxXlDQbPi
         75wMY6JXYZr+Iu3CPFd4EbCZdEZD1jYqwh4nGlmIuXFWILsd0v/8AfCXQ+1ABRGKnOk3
         cyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rdZ+Hyhdeez5sYovoNl4c+4e/sjVspsttzqtSN0P6X8=;
        b=KYOB1abYqO11ZgK2wuKdPu4wHzYVGKRt7ZrlvdsyiS89cBtpJKjaknRj5N3HqyZ4Op
         UHzhKNAuZlqN1lTolJkoLHns/NwbRdjS8HqmscCiS1WraYRl9b3VXAynYW/6VCZ0ETlW
         1u1G43RYxn+qEeZvYlwukWpmTXwyfPg5eA0k2EDd+BmJNXGMcF668fHemVnn1r1xTawC
         /uVuBWcibBjo9eVIJPEJ0TWCVtJ5FOHt4+sUnmBhM5+SwVeydWfv6XRdPdMz6tmabXQs
         VkIBHPpclttWIM5RE+v6BoIoY7P5n1sBzmmidyN1VPQiyoVDhorLrjjUakZI59A01Ggd
         jMKQ==
X-Gm-Message-State: AOAM532XUXODDe2L8CSVE2s1QcK3ckmT7QBLY5O2crrPnKqq0piBw1FW
        GENWuoECegCrEv6B/aAeVzNzAi79dSs=
X-Google-Smtp-Source: ABdhPJwCVL6mxg/J8JPRkJuWFUlz5SlbQZ5bivYiUx6ZsrB8F1VeiKxTwgWF272QdPJ9k5br3Ma/oA==
X-Received: by 2002:a1c:4d15:: with SMTP id o21mr77394236wmh.171.1637141638219;
        Wed, 17 Nov 2021 01:33:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f15sm6398979wmg.30.2021.11.17.01.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 01:33:57 -0800 (PST)
Message-Id: <9f1b3dd6d0b2d3f22fe960b0c3aaa3d888d26c88.1637141636.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v5.git.1637141636.gitgitgadget@gmail.com>
References: <pull.1076.v4.git.1637039888.gitgitgadget@gmail.com>
        <pull.1076.v5.git.1637141636.gitgitgadget@gmail.com>
From:   "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Nov 2021 09:33:55 +0000
Subject: [PATCH v5 1/2] doc: git-format-patch: describe the option --always
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Aleen =?UTF-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>, Aleen <aleen42@vip.qq.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Aleen <aleen42@vip.qq.com>

Signed-off-by: Aleen <aleen42@vip.qq.com>
---
 Documentation/git-format-patch.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 113eabc107c..be797d7a28f 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -18,7 +18,7 @@ SYNOPSIS
 		   [-n | --numbered | -N | --no-numbered]
 		   [--start-number <n>] [--numbered-files]
 		   [--in-reply-to=<message id>] [--suffix=.<sfx>]
-		   [--ignore-if-in-upstream]
+		   [--ignore-if-in-upstream] [--always]
 		   [--cover-from-description=<mode>]
 		   [--rfc] [--subject-prefix=<subject prefix>]
 		   [(--reroll-count|-v) <n>]
@@ -192,6 +192,10 @@ will want to ensure that threading is disabled for `git send-email`.
 	patches being generated, and any patch that matches is
 	ignored.
 
+--always::
+	Include patches for commits that do not introduce any change,
+	which are omitted by default.
+
 --cover-from-description=<mode>::
 	Controls which parts of the cover letter will be automatically
 	populated using the branch's description.
-- 
gitgitgadget

