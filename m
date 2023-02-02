Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7545FC61DA4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 19:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbjBBTQz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 14:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjBBTQw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 14:16:52 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C20B5D92F
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 11:16:51 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id l8so2216028wms.3
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 11:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJCC2hjyXVuLvNg97Op0ONNYi6GGBMZRreMEUVTuBQg=;
        b=afAPdFbgpcwx3X8ZWiGCJzBwYv0ZEr5MW+gIQ7gkvnDFJytr52i7W3oee5pVBXJl1W
         70Fkcb8+1mc+5yaSxbXwUoMJxiLDAKFqoTayTvGIureYQpXkVhf6YS6B8Zy29aIPSVkQ
         7MeZzSqfuGE+lGyfBgPvTnfOqEZeWrtMV0pcFAIepkI5h51LLS+s4KSiZsyJJ34Z2xq2
         ruLCyiZFx7cRKNLHOcZ6GvAxVxl/DoYnxASvMj+h7PLl2A4Ljr6p7phG6tjGbT4f/UCE
         L8jnBPWmeJVzb2BNArFb/tIPwj6P+iqH/oAvr69W7MAcmk0FMimYRph2Pwc5nOQd+MGU
         mi8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yJCC2hjyXVuLvNg97Op0ONNYi6GGBMZRreMEUVTuBQg=;
        b=wBMd63T2w4+Pdtv0/yhKEpoCwt9Vo5OZ7Ye/CGGZqN8/n4h3SSriIykc/TSlYhSjTU
         dDZ1cphwBs49SkprHAjmbMDsqnT6kkRNwZK/91LEGA84aXCVHX2Z9PuNBKBXPP6U0n6g
         rU80OsHPNAvsWe2cEIi4lBHeg0LTpN6u0nv2VLS9Dq0QziGFhtjn+FeJ6c+7PkDh8tMN
         23YhMlAIrx/aQRwo6Lf7OTf1qjOkjPpfMo+jp+gGWhQJmNk8zukNvn4kzFpvFoX1YyAB
         yd+K09Cb1I7H8qTtkflfj9qVcPyEiIYBH0P0KLzfuxxnF9UTm97BF+WLDpuO/tIbXRNE
         BkPA==
X-Gm-Message-State: AO0yUKVqNyXzySfTCORCHFHhBhHf9XbY15MSAU4T6FJdVyhSd89cimn4
        eyoIoQ58Z930yA8TXMZceHc6S2IoN3w=
X-Google-Smtp-Source: AK7set8ZAbE4UZ8ijtPlfN3Deug6+7QqEEueXajb9eI7NSlalMn33YCcd35DWrKTX47dznKAIF/NlA==
X-Received: by 2002:a05:600c:5389:b0:3df:9858:c038 with SMTP id hg9-20020a05600c538900b003df9858c038mr2669898wmb.13.1675365409465;
        Thu, 02 Feb 2023 11:16:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a6-20020a05600c068600b003dc3d9fb09asm473961wmn.47.2023.02.02.11.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 11:16:49 -0800 (PST)
Message-Id: <6b0bf073cf0e06e4cfe51f4c10f632344c163921.1675365406.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1449.git.git.1675365406.gitgitgadget@gmail.com>
References: <pull.1449.git.git.1675365406.gitgitgadget@gmail.com>
From:   "Robert Estelle via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 02 Feb 2023 19:16:45 +0000
Subject: [PATCH 2/3] blame: document --color-{lines,by-age} config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Robert Estelle <robert.estelle@gmail.com>,
        Robert Estelle <robertestelle@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Robert Estelle <robertestelle@gmail.com>

These flags correspond to specific values of the `blame.coloring` config
option. This adds a small note mentioning this correspondence.

Signed-off-by: Robert Estelle <robertestelle@gmail.com>
---
 Documentation/blame-options.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 9a663535f44..170016c941e 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -141,11 +141,15 @@ take effect.
 	the same commit as the preceding line. This makes it easier to distinguish
 	code blocks introduced by different commits. The color defaults to cyan and
 	can be adjusted using the `color.blame.repeatedLines` config option.
+	It corresponds to the value `repeatedLines` in the `blame.coloring`
+	configuration setting in linkgit:git-config[1] .
 
 --color-by-age::
 	Color line annotations depending on the age of the line in the default format.
 	The `color.blame.highlightRecent` config option controls what color is used for
 	each range of age.
+	It corresponds to the value `highlightRecent` in the `blame.coloring`
+	configuration setting in linkgit:git-config[1] .
 
 -h::
 	Show help message.
-- 
gitgitgadget

