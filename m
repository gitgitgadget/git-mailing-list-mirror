Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFED3EB8FB1
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 22:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241332AbjIGWU1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 18:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238954AbjIGWUW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 18:20:22 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F371BD5
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 15:20:17 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-401bbfc05fcso16260075e9.3
        for <git@vger.kernel.org>; Thu, 07 Sep 2023 15:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694125216; x=1694730016; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IyCvYTpWmrnQsJJcADomOscmglATYsrcsKtWx4utdxM=;
        b=Jv5xs57B+xhzzuXmyl/hOlDwdhyb8Cg6DD/0Vyy+1bkDdT/uFn6R9NHOb9T98cIybi
         61JM7WwbDWqkT0NiUgvCPF66XFvyA7zMIful61lW5xc0z/4jhwlEnad/cfXAcgzF+yM1
         0mk/JO2VNNJZtW4RrDaMFoy92wBpMTf3Mb1MCF2tLrRYJXG4jl2rLVif8ud1BqIponB0
         fHLxNKkQHrt5ex1FoXq20tyPS50JaK3lMMJrR4zEWNR8l+8w8F+402y7eA6AS//qpg0q
         gOW2VO9Sbu6/IAejKcpN87rK8jMPmpf75kRMRYygogpkHILqJs6SQyTHHDYUreBSnNQy
         QKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694125216; x=1694730016;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IyCvYTpWmrnQsJJcADomOscmglATYsrcsKtWx4utdxM=;
        b=xEJm/CgVvKUfTLWMNmwyw197a0O8zIR8Mc0RLZ58x3IwHdrBfuZOnQWIdQIK9HUjV3
         U3huraaLkvZ5aFRKCqraZzB/TaB77HzPAy0KOdklOjRVfjBH9HHAMZD4+lnyNdksY3O+
         5ch2UjPAJYuQ/9q+vljo/aXi/gnckNZoLaSjdqcnJoMxwe2fcb4l1lg1DbqJHImX/9Tm
         bON3ZYzijRTmt0Z2ixSEkc+QyGfeh/u3hP6JIAwtbBShLRUB2pZN0Xm+jnUKOEsvnPa/
         ZisyC9ueCnIE4N8uakGrZU9jKxa+nacLBoFL7VQfmtdLfz64jCUI60XB6lX9B+K7CL32
         iSHA==
X-Gm-Message-State: AOJu0Yy4K6OL7+Dp2USqEsLb4o3mKsBqZcuWObSx3Eq0YCtLkClw+dBu
        fPyL6ZwVmn9aiEixoh0HpOBWg8e4YbY=
X-Google-Smtp-Source: AGHT+IECtbXzo3zsX93qwvh5MGe2f0gqYf6f5t0ieMbcqk6w3fLXyFeCXbTrnuct6sBPDHaALFTpFw==
X-Received: by 2002:a1c:7719:0:b0:400:2dc5:2006 with SMTP id t25-20020a1c7719000000b004002dc52006mr649947wmi.36.1694125215961;
        Thu, 07 Sep 2023 15:20:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v8-20020a05600c214800b003fee65091fdsm3625121wml.40.2023.09.07.15.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 15:20:15 -0700 (PDT)
Message-ID: <3e58b6f5ea264a2c42ffbd008405b46626e0f864.1694125210.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1564.v3.git.1694125209.gitgitgadget@gmail.com>
References: <pull.1564.v2.git.1691702283.gitgitgadget@gmail.com>
        <pull.1564.v3.git.1694125209.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Sep 2023 22:20:02 +0000
Subject: [PATCH v3 06/13] trailer --no-divider help: describe usual "---"
 meaning
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Linus Arver <linusa@google.com>,
        Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

It's unclear what treating something "specially" means.

Signed-off-by: Linus Arver <linusa@google.com>
---
 builtin/interpret-trailers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index cf4f703c4e2..a7623dbfb2e 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -109,7 +109,7 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "unfold", &opts.unfold, N_("join whitespace-continued values")),
 		OPT_CALLBACK_F(0, "parse", &opts, NULL, N_("set parsing options"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG, parse_opt_parse),
-		OPT_BOOL(0, "no-divider", &opts.no_divider, N_("do not treat --- specially")),
+		OPT_BOOL(0, "no-divider", &opts.no_divider, N_("do not treat \"---\" as the end of input")),
 		OPT_CALLBACK(0, "trailer", &trailers, N_("trailer"),
 				N_("trailer(s) to add"), option_parse_trailer),
 		OPT_END()
-- 
gitgitgadget

