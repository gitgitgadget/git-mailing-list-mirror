Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08486EC875E
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 22:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241650AbjIGWUh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 18:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240775AbjIGWUW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 18:20:22 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B651BDC
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 15:20:18 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31c3726cc45so1432268f8f.0
        for <git@vger.kernel.org>; Thu, 07 Sep 2023 15:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694125217; x=1694730017; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPRWwjPrGNVx8kgHHVI8q2B/5Y5q8gUqpmGu9/jJZ7U=;
        b=ZbgL9qhDRSF2Fe/A6I+4Vzv8Ur6NONdol7A4D4XziDek0AkYLnrrTiiaQYgrU6nbHK
         8JOjwupwFt8Y5xKLyKYDYhFp7tf2wS3+qcS+6h+s8/bqPb+zflWL+HOWB5pO/DiPyDxt
         h87dTwtRvBFJl46TxhINeiJHfTwqdcm5ZqKSqyt51JGWGk6s442BDxQSD/9K++u+06gC
         osi40SnNIIS2/AEr4QHTp16JjTii/bUi6U7ce6CDp0F9o/iHjWpJOgALdfje52WqD0FJ
         /hw2u80JhImUeMDYVj8eA6TMJxnmFy6QOPsjFQICIm94HKb/s1Xqjh3Tjc4fqdtCA+zn
         /YKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694125217; x=1694730017;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uPRWwjPrGNVx8kgHHVI8q2B/5Y5q8gUqpmGu9/jJZ7U=;
        b=MWSZb/4btoY5aFcFi6QswiBJkD+SI725mJfTKLvbii5GxEBM/JhKYZqfXSmR3k9cAc
         Na/DSyf8/gidKmm77y8NSndRXL1bm44T5cjTTald4V+U+qP8L7gl4Q9W5p008liJ1Y/y
         JnotW92lC5+wd9hqG/K/EFZBNGZLwi9KvQ41R/ouidmonOeWwRLWZ0RN+MGUbTnXw0of
         ZgVi5eDlw6elzPcmtFXK5PE+IL7C0MgymmDHJXCtVZO97RreADGpQ1N8P52rTeX2Bz8R
         syn8+34ULkBKhVuyfubOsd5ORXCaLuELyFyDwkgNpP66cYZ3vNbjFEJQ/zkvTPbpbP5s
         uCOg==
X-Gm-Message-State: AOJu0Yy9Rg0ZHeEZR8I/26d1dG86/FwKFUkXNYzTi2TWRqZ71xFxRq8z
        ZqJP903CXRbRlcN5ypvvdzCffSHjJYo=
X-Google-Smtp-Source: AGHT+IGGBTd9t37Dvl7h2ZTtTj7ScZkC/+eBaaupCqi1pnl/IO6xXCSa4Gfx1wI3RZpeMLOKCeDRsQ==
X-Received: by 2002:a5d:4e47:0:b0:313:f45f:74a1 with SMTP id r7-20020a5d4e47000000b00313f45f74a1mr490144wrt.51.1694125216619;
        Thu, 07 Sep 2023 15:20:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a12-20020a5d456c000000b00317afc7949csm438853wrc.50.2023.09.07.15.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 15:20:16 -0700 (PDT)
Message-ID: <d1780a0127a749902d60249b531869ee9cd1a5f6.1694125210.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1564.v3.git.1694125209.gitgitgadget@gmail.com>
References: <pull.1564.v2.git.1691702283.gitgitgadget@gmail.com>
        <pull.1564.v3.git.1694125209.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Sep 2023 22:20:03 +0000
Subject: [PATCH v3 07/13] trailer --parse help: expose aliased options
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

The existing description "set parsing options" is vague, because
arguably _all_ of the options for interpret-trailers have to do with
parsing to some degree.

Explain what this flag does to match what is in the docs, namely how
it is an alias for "--only-trailers --only-input --unfold".

Signed-off-by: Linus Arver <linusa@google.com>
---
 builtin/interpret-trailers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index a7623dbfb2e..5f3e1a38eee 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -107,7 +107,7 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "only-trailers", &opts.only_trailers, N_("output only the trailers")),
 		OPT_BOOL(0, "only-input", &opts.only_input, N_("do not apply config rules")),
 		OPT_BOOL(0, "unfold", &opts.unfold, N_("join whitespace-continued values")),
-		OPT_CALLBACK_F(0, "parse", &opts, NULL, N_("set parsing options"),
+		OPT_CALLBACK_F(0, "parse", &opts, NULL, N_("alias for --only-trailers --only-input --unfold"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG, parse_opt_parse),
 		OPT_BOOL(0, "no-divider", &opts.no_divider, N_("do not treat \"---\" as the end of input")),
 		OPT_CALLBACK(0, "trailer", &trailers, N_("trailer"),
-- 
gitgitgadget

