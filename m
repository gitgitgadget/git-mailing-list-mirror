Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754ADC04A94
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 21:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjHJVSV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 17:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjHJVSO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 17:18:14 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886362D51
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 14:18:10 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fe4ad22e36so12359715e9.2
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 14:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691702289; x=1692307089;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPRWwjPrGNVx8kgHHVI8q2B/5Y5q8gUqpmGu9/jJZ7U=;
        b=JkgjrbOKAt1bVRa4zGOORLikY/w1OgqZLTGmVQmu4D52sI7TV+JJ7bbM4X07IKzGKo
         fxfI7OrV4OACDdYlOtbkeHvfR/lT/iVFzhON+HoH9bVvOwd+wdcGPL3nqpi22c7riX9z
         qfzJV0R+xNoAQHQaIt17DXuhY04TofsjyX4NR+NNKjGYPaitVWlgAnQhR8avhMX1GAIF
         sE+ShHs3llvs9MeTc9p0fqW/s9i1dVKO3Isv9xE1OfGtU1RqxzWBbcHQFdfTxl6VU4xn
         jN7aTDJEaKNlAKcPmV9840fNfksCOmu2PtFMCisfhBiOd+JMafcISHeRIKKOaCCQq9sc
         Pm2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691702289; x=1692307089;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uPRWwjPrGNVx8kgHHVI8q2B/5Y5q8gUqpmGu9/jJZ7U=;
        b=OZdiYRJL+OkfHlW+iNBQsSh9cN+GcB9A+X2tXhcH2xUqo5/rZMk8jbnke6Am8KygAN
         cVQX/sqHUwDjP1TjmrjHdGc01syahrx5iPlHFbc+04sCyB5LYYlHCh6jqH5Vnb3xtqK1
         TvCQjyd+gm6733CdgbroPz6Q51L2eU12WQE79bFD2QDuz1w33xsOPDXuT+K1nufrxNfN
         UqBGeTXxtxdaHmfzo/SEgzIloYDTLGGIP+6ZH4NCsVmIHPxep0mVOzdYHheWhkWkE501
         RVcWzCrqzeLtgpHPlYbAik2BC/XLMA4TV+zsv8QoGLgLjrdlUyiBiZUt5zpiVjpO9JU4
         BTNA==
X-Gm-Message-State: AOJu0YwvymCq6GdTk6JJxkMVzuILFkzCGf/q3ZRNXyS85EAobj33JyAk
        mQySl9qW0ifBgLSzJ3XlHnfxrg+rUIc=
X-Google-Smtp-Source: AGHT+IFVC/MtfLqjLS7CWTGtFZZxjG2QB/8mOYW2MtbC+mdvr3ragRzdsYdQ8UbYBwJuraIJ1UlB7A==
X-Received: by 2002:a05:600c:ac4:b0:3f5:146a:c79d with SMTP id c4-20020a05600c0ac400b003f5146ac79dmr64149wmr.15.1691702288888;
        Thu, 10 Aug 2023 14:18:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v14-20020a1cf70e000000b003fe24441e23sm3198277wmh.24.2023.08.10.14.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 14:18:08 -0700 (PDT)
Message-ID: <d1780a0127a749902d60249b531869ee9cd1a5f6.1691702283.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1564.v2.git.1691702283.gitgitgadget@gmail.com>
References: <pull.1564.git.1691210737.gitgitgadget@gmail.com>
        <pull.1564.v2.git.1691702283.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Aug 2023 21:17:57 +0000
Subject: [PATCH v2 07/13] trailer --parse help: expose aliased options
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

