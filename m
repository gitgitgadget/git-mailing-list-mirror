Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612EAC001DE
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 21:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjHJVSU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 17:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjHJVSL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 17:18:11 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2662D48
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 14:18:09 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fe82a7873fso4549155e9.3
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 14:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691702288; x=1692307088;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IyCvYTpWmrnQsJJcADomOscmglATYsrcsKtWx4utdxM=;
        b=i/VDMOh3TsPv7xMcmsqpK/tKm1kcbV50XnF9gj3xbN6rGMOQStpRqZvriV9XICpKvL
         6hDbxkkqRjda0MjIhGM4hmw/aBr9VJHpQ4RpFd88FxnlM5Qvg6d+UHHe2sSnjZyLd4GQ
         dvxAb8BG4fmk+YqJo0bcpqxwCQN0iSHA6lGaKUhBcGlaz/sx6F8WuvcGSazcPwmeQIgG
         iQXT8waPCP3rkoK+RDM2TeBMFqufY+bYpTEouS6dsQGrGPMF0lf7xCLtSul0DAFmpGsj
         b8S9qIqXJnQxIDkyRNn3um2XYViGAgO5Blv7gdkqd/M/m0eS6qtaIF5rUO0WGe/Oumot
         9L6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691702288; x=1692307088;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IyCvYTpWmrnQsJJcADomOscmglATYsrcsKtWx4utdxM=;
        b=E47OpIwR3MoncA3D94FpQGZLL9LSJc070NmDOnB0ALusaH9j6zcwdLc9WAf/Hebn55
         2fRexYmV9pcGaodK1Arm4izglDUU9XfNb1LI1K+oVd8nnDlzf++q/ImIoO+0U3via7qB
         blSNX2g4KnJ6bkynvGsFlKdhjP/7CvDCLBg1Bggouhe2+uSfPvi11YnvJPZL91BG5amk
         URmi9b/ISPgaagH0FMfgGle212/eZw9MKB89oZhFzXmRjgQDb7LXa/90kQxbffAZjlRT
         z5PuwGRy0Yb7NMdnWzZ8Zl/MweShFxvjydK3AUNdzVLi8ytHgjz/x8jIE2cd8ET6NDHj
         L10A==
X-Gm-Message-State: AOJu0Yz/WzMaV52p9ju8wu4BQZUM3AZ/svA1QrsB+SMm4+7o0mzyWCuW
        cK5KmqY5acgt7T5t7ky2Nh/Fy+UvSL4=
X-Google-Smtp-Source: AGHT+IHjVRy2cSw9h1XDbiAdX6kMm5EKi/PjmQ9TUInDuj1mJcT4XsECvRC/14pNqE55BDHqBGZ+/w==
X-Received: by 2002:a7b:c8d2:0:b0:3fe:ad4:27b4 with SMTP id f18-20020a7bc8d2000000b003fe0ad427b4mr43903wml.27.1691702288261;
        Thu, 10 Aug 2023 14:18:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c205300b003fe17901fcdsm6083944wmg.32.2023.08.10.14.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 14:18:07 -0700 (PDT)
Message-ID: <3e58b6f5ea264a2c42ffbd008405b46626e0f864.1691702283.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1564.v2.git.1691702283.gitgitgadget@gmail.com>
References: <pull.1564.git.1691210737.gitgitgadget@gmail.com>
        <pull.1564.v2.git.1691702283.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Aug 2023 21:17:56 +0000
Subject: [PATCH v2 06/13] trailer --no-divider help: describe usual "---"
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

