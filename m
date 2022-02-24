Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4837C433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 16:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiBXQ3g (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 11:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiBXQ3e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 11:29:34 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F0819D778
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 08:29:03 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id o62-20020a1ca541000000b00380e3cc26b7so158050wme.0
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 08:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Q8KwvvLn5Fwe2a+xZSA9NI2g+O55WvPuhu6jSMVgKY4=;
        b=ck44peAwdGHoW6A09bT/iS16pPvf8FoxS2/TqGXSS5riuO/kgwBlAquNiPGOaGpb42
         YHrAiv4JGJ6ldc96s1wKjO/oTyggnAZTt+IcuHrOR903UT6amO4m84yoGHrHK5XtS5VO
         smR8C83cYgjh37DUuQtAt2+daXFRtNVdA9D0YjQwRAvME8SdC5asrCK8eIFE/YVBmG7F
         g93QC0YKxNxKQ9gzA70XkF4982j+kkDVZ8VtQ2e383t9m4ppUhqWd4yd1VdYT5TEdlSc
         MgqFFmARHggKL1wkj76dt2s+KQ3KkS765pSl9pweMnVVwzXw7VK5dQOoxTqlFBglMlqz
         /4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Q8KwvvLn5Fwe2a+xZSA9NI2g+O55WvPuhu6jSMVgKY4=;
        b=ijmqtgam6xLn5UvlMahhJaXBDxOdKKwL6XfVnrU2UGrSyDhUzUb+WI0so1uMV/QYdN
         9jBjMkm9AiDEBM0Md+Wz2NsgD6kSWEZ+pZPnXnMhFvE16LBNjHCl8dPhlDqO4vbY3Ndg
         lMilSmFTlpzxUdHTDFDc97gwb0jETxMsGhYA15EzHdFVBo9GZSG+t3rwj+i9Yxazz7fX
         bC35BWzG9e/BEnJ90TR9G6lcLIpZoDDhCwL3LVWL6yzBbZDLRf5zSDZ+mnIbEY1H3oFQ
         /qHWrvZ6xn7na1GUTVn003CW1H+u5PEBIfoyn6dz4g5tV0sH4YQtH586knHgF8VZNLul
         07EQ==
X-Gm-Message-State: AOAM533P90mbOOy1ciRr9CuKpfgXcNanHI9/uqsHLukQvuiGLdDv1xT1
        voPN9nTZKg6BqdSGDrmTtH81VFAiVyI=
X-Google-Smtp-Source: ABdhPJyrwMgZrTgG3n8u2z2O187KaEavFEC2fiUKTTJAkGEXwZzGUn+JQY2xYiH/MiERM2dS9+hyjw==
X-Received: by 2002:a05:600c:42c4:b0:380:da32:26e3 with SMTP id j4-20020a05600c42c400b00380da3226e3mr3031390wme.142.1645719221156;
        Thu, 24 Feb 2022 08:13:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f10-20020a05600c154a00b0037bbbc15ca7sm5589853wmg.36.2022.02.24.08.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:13:40 -0800 (PST)
Message-Id: <d146d8aaaafee91de2e7c50b3a598a470319b541.1645719218.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1138.v2.git.1645719218.gitgitgadget@gmail.com>
References: <pull.1138.git.1643730593.gitgitgadget@gmail.com>
        <pull.1138.v2.git.1645719218.gitgitgadget@gmail.com>
From:   "Robert Coup via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Feb 2022 16:13:31 +0000
Subject: [PATCH v2 1/8] fetch-negotiator: add specific noop initializor
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Robert Coup <robert@coup.net.nz>,
        Robert Coup <robert@coup.net.nz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Robert Coup <robert@coup.net.nz>

Add a specific initializor for the noop fetch negotiator. This is
introduced to support allowing partial clones to skip commit negotiation
when fetching to repair or apply a modified filter.

Signed-off-by: Robert Coup <robert@coup.net.nz>
---
 fetch-negotiator.c | 5 +++++
 fetch-negotiator.h | 8 ++++++++
 2 files changed, 13 insertions(+)

diff --git a/fetch-negotiator.c b/fetch-negotiator.c
index 874797d767b..be383367f55 100644
--- a/fetch-negotiator.c
+++ b/fetch-negotiator.c
@@ -23,3 +23,8 @@ void fetch_negotiator_init(struct repository *r,
 		return;
 	}
 }
+
+void fetch_negotiator_init_noop(struct fetch_negotiator *negotiator)
+{
+	noop_negotiator_init(negotiator);
+}
diff --git a/fetch-negotiator.h b/fetch-negotiator.h
index ea78868504b..e348905a1f0 100644
--- a/fetch-negotiator.h
+++ b/fetch-negotiator.h
@@ -53,7 +53,15 @@ struct fetch_negotiator {
 	void *data;
 };
 
+/*
+ * Initialize a negotiator based on the repository settings.
+ */
 void fetch_negotiator_init(struct repository *r,
 			   struct fetch_negotiator *negotiator);
 
+/*
+ * Initialize a noop negotiator.
+ */
+void fetch_negotiator_init_noop(struct fetch_negotiator *negotiator);
+
 #endif
-- 
gitgitgadget

