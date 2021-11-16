Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C21EC433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 05:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE61960FBF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 05:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237565AbhKPF5D (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 00:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238276AbhKPF4U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 00:56:20 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A66C048F03
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 21:18:12 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id b184-20020a1c1bc1000000b0033140bf8dd5so1392205wmb.5
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 21:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rdZ+Hyhdeez5sYovoNl4c+4e/sjVspsttzqtSN0P6X8=;
        b=MPsNDNCotOE57ynHuxm9ZPb/UpILl+DDA01KpudEOfkf5DMWgMItlQsKPLo4/UzQad
         U9lfGKq626JjTJZpsd/WBn74oaK4+ow7kR0O0N8PkNqPpcFKaW69ZCSvg1nkKlAmJSNP
         InV1d6/JO0mhUWHpZtBVd/hDZdxTv7XgwoYedoF/FuoOb1flDrzqY8Y2qrEm+zX+W/w2
         bgIQ1e+cijL7vmma/j3ndHzgS04aUF/gxlV3iW4duzY8Pks34wEbx7MLSu/6OQ0NOQe4
         ZJPeL7taT8e0Mqjsypia069B66kXVH4zNBD8FUCGarKY6+PGaGZFv9nXSy8MfsAiisUR
         M0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rdZ+Hyhdeez5sYovoNl4c+4e/sjVspsttzqtSN0P6X8=;
        b=EPscUCYs256cI0NRbFlCzQs5HEznW+u1ePmHQxOHje3u4YGoFmgkT1UWg58y6MIcTK
         Y8ODZZ/anAYTYXXL+RW4LLxWDA1tm9OVUHJcIbArW2HRoVi8sNHE+etTH1/bb6RWQVH6
         ziuUUMREtRLK6Xw0YfXyQpQ9hys0BFsmazXOyM+8bP6Qyi3w9wxtLjAMcw9KqCmwo02l
         xkiC2g77GqOFauGLFB49bqRhYg9siYAVvD+h6SWpIPcVIf8a7grVS5DEMTmi1fmKpRHg
         vFRCi1oBG8StxHn/IzbVv4HJuy6XIlpoVPaRJ49sH3VFDhMswsoMTzGzrDpWhODLbLOx
         r2+A==
X-Gm-Message-State: AOAM5314c3ehIvieeEOmFYck9uVrxR1U/pu8FRxk7ZT4DuaEAG4RZU4d
        uj5ijvsZV7OscPxBIbzFchWy1S18VBw=
X-Google-Smtp-Source: ABdhPJwBJO84yeMGUgkPXf7GoJF9yBPRZfS26Tf+EpXsICxX3WUpUouFkwlr84/RI4SoFfSg8MMIiA==
X-Received: by 2002:a05:600c:500d:: with SMTP id n13mr35138055wmr.174.1637039890471;
        Mon, 15 Nov 2021 21:18:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u23sm17221645wru.21.2021.11.15.21.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 21:18:10 -0800 (PST)
Message-Id: <9f1b3dd6d0b2d3f22fe960b0c3aaa3d888d26c88.1637039888.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v4.git.1637039888.gitgitgadget@gmail.com>
References: <pull.1076.v3.git.1636972769.gitgitgadget@gmail.com>
        <pull.1076.v4.git.1637039888.gitgitgadget@gmail.com>
From:   "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Nov 2021 05:18:07 +0000
Subject: [PATCH v4 1/2] doc: git-format-patch: describe the option --always
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Aleen =?UTF-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
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

