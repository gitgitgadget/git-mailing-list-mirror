Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56FCC001DE
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 21:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjHJVS0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 17:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjHJVSO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 17:18:14 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679832112
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 14:18:11 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe4ad22eb0so12095545e9.3
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 14:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691702290; x=1692307090;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAdMcJmsl1UanPeZ7HNoKYmoBWhQMLXpHLt9O3kOd1A=;
        b=eJf1TsXLcynC7W0NZStrLiRSluTR8V+1TcjRO12WQAvgJPVDpVFjYwgFGXdNq3CsxV
         c59t3R/Ih6rRi0JvPSPviaBHmw9/cwiRYp4D8mZM6kf43fHFhQQ+PAnRPZ8BuRYXtM2g
         nUR4MEl7a7k9tdGNJmGhWe+o8nTYlPs5+lhZ9sMsbq4ZszwB3Q68yAVK8nRdPEWk+XtZ
         +8e1ee+Rlsyx4cbCU6wsMq7h4Ri3ua0ll84JAYYncGkLUJnRJqvWv0J05MkopIh4TdEC
         i2PwMvBXoh6VU1tuF7jJ64jQTPi3928yKDDzpIxCvWvTiHDQ7GAjC+Ifxect1WdY5AQw
         e8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691702290; x=1692307090;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAdMcJmsl1UanPeZ7HNoKYmoBWhQMLXpHLt9O3kOd1A=;
        b=lktczzLCdXOUHMVUr1nQrGcdrMV/09kYnQv/KUwO/CUFHYaIEVaNAcnJEVYsCK5h+f
         Kv+ydEycRw/dzVGhrFw4LRiD+8ZWDFdzgkvBdGABjP0UwAzZfOlOeShJPZjOSmAO58is
         YCaBCUZ0NDckMv23k8MjTS0Xl9U1JwrrX+cSTHUJQRU6EESRDJ0Dy6QlyRXbc33zNS3N
         9xcOsCN6ckeJ9GuckiXQ/DPSsSwuA38tL/Bb/J3Vd5dOskCCskcZxH5Lvb0EIEN+PyVJ
         A3Xr+Zvzg2IbG60qTb9JK++F1tXklzLawa/dIFTsDfSRJHfGooGzZKbcPDGmZZjugjI6
         mPBw==
X-Gm-Message-State: AOJu0YwqIUOGNyEymqIea2yldmDY4iHtfSqPU82+MsZIi4aOdVwRF4sl
        NdsYDq4BsDtfNHhCVUDtQE7hcpijcXE=
X-Google-Smtp-Source: AGHT+IEgN+dk+jaMI9ntm16jry9kX9BmoMgQJvP3WwAXvRXJqHW9GsK4BZ9HYoGj+srphF2D6qRrbA==
X-Received: by 2002:a7b:ca4f:0:b0:3fe:1af6:6542 with SMTP id m15-20020a7bca4f000000b003fe1af66542mr36270wml.33.1691702289522;
        Thu, 10 Aug 2023 14:18:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h14-20020a05600c260e00b003fa8dbb7b5dsm3224243wma.25.2023.08.10.14.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 14:18:09 -0700 (PDT)
Message-ID: <5cfff52da8ff586248ba394248e7b086ed792549.1691702283.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1564.v2.git.1691702283.gitgitgadget@gmail.com>
References: <pull.1564.git.1691210737.gitgitgadget@gmail.com>
        <pull.1564.v2.git.1691702283.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Aug 2023 21:17:58 +0000
Subject: [PATCH v2 08/13] trailer --only-input: prefer "configuration
 variables" over "rules"
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

Use the phrase "configuration variables" instead of "rules" because

(1) we already say "configuration variables" in multiple
    places in the docs (where the word "rules" is only used for describing
    "--only-input" behavior and for an unrelated case of mentioning how
    the trailers do not follow "rules for RFC 822 headers"), and

(2) this phrase is more specific than just "rules".

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/git-interpret-trailers.txt | 4 ++--
 builtin/interpret-trailers.c             | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index b5284c3d33f..0eea937c30e 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -149,8 +149,8 @@ OPTIONS
 
 --only-input::
 	Output only trailers that exist in the input; do not add any
-	from the command-line or by following configured `trailer.*`
-	rules.
+	from the command-line or by applying `trailer.*` configuration
+	variables.
 
 --unfold::
 	Remove any whitespace-continuation in trailers, so that each
diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 5f3e1a38eee..f70c5df8d4b 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -105,7 +105,7 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 			     N_("action if trailer is missing"), option_parse_if_missing),
 
 		OPT_BOOL(0, "only-trailers", &opts.only_trailers, N_("output only the trailers")),
-		OPT_BOOL(0, "only-input", &opts.only_input, N_("do not apply config rules")),
+		OPT_BOOL(0, "only-input", &opts.only_input, N_("do not apply trailer.* configuration variables")),
 		OPT_BOOL(0, "unfold", &opts.unfold, N_("join whitespace-continued values")),
 		OPT_CALLBACK_F(0, "parse", &opts, NULL, N_("alias for --only-trailers --only-input --unfold"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG, parse_opt_parse),
-- 
gitgitgadget

