Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AF1C0502A
	for <git@archiver.kernel.org>; Sat, 27 Aug 2022 12:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbiH0Mom (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Aug 2022 08:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbiH0Moe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2022 08:44:34 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F1031370
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 05:44:33 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id k9so4792023wri.0
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 05:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=fputxYI2HUfkFVNx9yxXGsgXMgIUSaa9LOnIcfF5Q2c=;
        b=Fy7NAm+g/Ea5dp/QuWYHpsrgypRuRNA2SeqgNPReO40K40e1Ke89f0rdqXRNWDaqV2
         6rDbtYTjc9ueOEeWTG461drngLyS6IY0Jr0IvQ/18jJ1BxlSivuxaM1/slKEDIwD8ftK
         sAYyue1cebHqOrzcEGIc3WsQ+6LZ9+14N2GXIUz7HWuFXB5OwXUl2pUqcyaY7BNkaY3r
         QQclxCmpfEYxLI4Ugwhgc5cj3lK+zCHMQ4gcA3OavAqA5+PTfNQAAfX4B1SbNd/aqPdU
         GkH+dZAkOcdV9eZj8KwhAMp7uHIFezAgctl2c+GLtjHZRpTJa/3k9hJ/1tpWeQbRGLEm
         kcFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=fputxYI2HUfkFVNx9yxXGsgXMgIUSaa9LOnIcfF5Q2c=;
        b=V0R4XAgn0MKg7cwNrJvdl7+rnTbmzkjTDImjqAvJoA0RSmPUrzmAVKdBfDv2QGJ1r2
         yXL+ZcgJx1Qn949pre1ScO/PKKX0cah6oaYEXKZ0QDSjEz+eKuPIg0b5eJUHaSF8aiUr
         5bpmqCLi64KaJ7oH53S+6Bn58wyrvkWQ71Se251YkCX/M6QCTlZeoXCdwhmrhuG1UhH4
         PMHWCVIgYvgafYG1jy5j1hB1eNhi7iC7VmiRLMrfv/EZamPDLh+GKO24qHLOfpomhKwW
         5R/pcLGgV0nei/lpDGVUNMHj0LOerAY/JVxHPPf8EZ1eUg4/IPCWIVrQcapdCQzxP8W9
         xXiA==
X-Gm-Message-State: ACgBeo3Kruro/qlHxafYAPZUxCvIpajEvDynVXbxqQoB4x5KeRWvpUdD
        se99MWXvvXYzWoq4KOAH6Jq6xhkaIO8=
X-Google-Smtp-Source: AA6agR7f2EN34dJbRsA7IKho5jknjEI7pSy4qpgFuBNEydtOnWX3UnxHbkhVJN/noClxvuDhEpZnEA==
X-Received: by 2002:a5d:6245:0:b0:225:3e24:e5b1 with SMTP id m5-20020a5d6245000000b002253e24e5b1mr2161849wrv.698.1661604271336;
        Sat, 27 Aug 2022 05:44:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f28-20020a5d58fc000000b0021e4829d359sm2214403wrd.39.2022.08.27.05.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 05:44:30 -0700 (PDT)
Message-Id: <1a1649d9d0d5739f76db82fdafae7e88374bc8a6.1661604264.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
References: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
        <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 27 Aug 2022 12:44:11 +0000
Subject: [PATCH v5 03/16] bisect--helper: really retire `--bisect-autostart`
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

Since b0f6494f70f (bisect--helper: retire `--bisect-autostart`
subcommand, 2020-10-15), the `--bisect-autostart` option is no more. But
we kept the `enum` value of the command mode around. Let's drop it, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index bdf7ce18d7a..aa94c25ec73 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1282,7 +1282,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_RESET = 1,
 		BISECT_TERMS,
 		BISECT_START,
-		BISECT_AUTOSTART,
 		BISECT_NEXT,
 		BISECT_STATE,
 		BISECT_LOG,
-- 
gitgitgadget

