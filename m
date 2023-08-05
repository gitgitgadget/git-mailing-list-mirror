Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21472C0015E
	for <git@archiver.kernel.org>; Sat,  5 Aug 2023 04:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjHEEpu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Aug 2023 00:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjHEEpp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Aug 2023 00:45:45 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DC44EDB
        for <git@vger.kernel.org>; Fri,  4 Aug 2023 21:45:43 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe426b86a8so18859165e9.3
        for <git@vger.kernel.org>; Fri, 04 Aug 2023 21:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691210742; x=1691815542;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IyCvYTpWmrnQsJJcADomOscmglATYsrcsKtWx4utdxM=;
        b=MjNLxfMSPicwk9nJYkVX7ZVJfYWwRkhRFxHsYISjUe0SqCQlUFswvfNilPyviqpU/y
         ZWTq4B72iRDzm1S2U1A2jUs0AXcRR9i6c+f2p3tPSQ5clM6/3EEkWgfS9ABxc0SygOdc
         wpxJ76i74zw0XSVvQyB26F+X21CZ72Ils796amivfMl7N/z0vz+wGCdC0PlWjoYJ8Rtx
         xQzWmAAInym33b/KAO+q1aV9QEB1Ae9E0ucaHu77nlN6xxDEoLqwWq55lU8BNZPAxRMq
         rkQYm7PGs4U2eDhPE+o5C8Bpl0gGCOyOXzCwFZ/BpehSMfFOL08lthcXRRulyXYjKmmv
         fWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691210742; x=1691815542;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IyCvYTpWmrnQsJJcADomOscmglATYsrcsKtWx4utdxM=;
        b=eORwrBIy33GDu7/ENVBfyzdw6pzxW6wZJw4Qa26ACzDrz7CGCmddxj2WzLQKue47pi
         5LTOR95JpVYjMuLEPI3fT4stHpfW2Mfblo+XZKHAxP4AEAF79D1kGrO43RcyTjhhk31c
         Uq5j9qU8vjSWGOYFhpri8PQjiuL1li6525GzTBllXdHJeGyroVwkOFXXJKJP6LaPoPuC
         hVecUq4QFJLQ29xp7l8zWopoegEEJ8DdM5xV08WWHw7NYQX5axIsj8PT1GZmGBfMkn4Q
         RQKpQs70ZJN6hE3PTWO9wWWE9HTCPwE6KTV+GSJQi8w6Lwa+R92bdl/H/k3sNQu8bCD0
         +IeA==
X-Gm-Message-State: AOJu0Ywg0fqZGGPflnblK28q6wvq8fTjmD17a63VpykBkIluczMIH08N
        FP6Vy/Ko6fD0ql94+RjmvVvJb+8cIxc=
X-Google-Smtp-Source: AGHT+IGgSi3+JaZ0t1zA1WnuYHGiLpQTXtTRePvL52SUmSZ6E2DLTO5PkH5TqsHfPV6Adl+ANAw57A==
X-Received: by 2002:a1c:7211:0:b0:3fe:19cf:93ca with SMTP id n17-20020a1c7211000000b003fe19cf93camr2922766wmc.8.1691210742033;
        Fri, 04 Aug 2023 21:45:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q7-20020a1cf307000000b003fa98908014sm8313623wmq.8.2023.08.04.21.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 21:45:41 -0700 (PDT)
Message-ID: <68bc89beb2a26e8ae0ae67d1489a06af9fc37fa0.1691210737.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1564.git.1691210737.gitgitgadget@gmail.com>
References: <pull.1564.git.1691210737.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 05 Aug 2023 04:45:37 +0000
Subject: [PATCH 5/5] trailer --no-divider help: describe usual "---" meaning
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Linus Arver <linusa@google.com>, Linus Arver <linusa@google.com>
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
