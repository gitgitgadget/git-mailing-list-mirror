Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60285EC875F
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 22:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237501AbjIGWUU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 18:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234773AbjIGWUS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 18:20:18 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1806E1BC6
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 15:20:15 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-401bbfc05fcso16259535e9.3
        for <git@vger.kernel.org>; Thu, 07 Sep 2023 15:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694125213; x=1694730013; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5C2RUivRPkhjM3FHZHrxtCNM82473MLJmyqe8BS37I=;
        b=HRQ5n78JbO6+3uZwgM2iWgCvTDQ+5+h7NIkQ/UEbB6u/hl0HAfV5er4j94lnB0YpGt
         ZISsyLir4nrCO7gf54vL4eSilQ1cXlA9nR4wm8OBMWOHg8BVZq5XrwyxgOSdzO0ql3vD
         dZCowuHYRv6ho/+2KCHqRgMyYbhgti+6RvFII5hNzZynMNJMlWkycFltPY+t3k02f2Qe
         AtCExQfcFT1cyQzZ6huf7G8rIYnMLXHdx6HIC72i8pPAk6Pln5R2Vtf8eB+HJzeiz6ce
         vtkVAICMks8biV0nmpvypFX+7r5B1SWvdfauii9HBu7oif76/XeaFx3p+Z/COiSmNXCi
         Qrjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694125213; x=1694730013;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5C2RUivRPkhjM3FHZHrxtCNM82473MLJmyqe8BS37I=;
        b=CCCzXdS0NWmTSI9P95ZU5CfmWMKcEmZ7YO2mj1BugK9mbtsSe8pu7HpABxXgreS6fU
         GEenKtGpKPNivL3Pe971tZvA2eoo80pzNfMSL4w1BgYnrPtiF/uqsyrhZLwNxl2YVVYD
         Lz3NNYG7xYyvEjfILDsF1GUQAiA5GjzQNYG2Dr2Pl+g1aLFQ6ui89RRfghu4kiDuQMOd
         jt2AKoL6X3AyfhXhtfEVP6IpRAATbZ+4QD9AH68LDSSS2TPk6sxqpMyz12I36p0Qua/G
         3FtHDdfqSUmQKBbXTEZeuMe1YrO1StHqpBOi9eY7sxbSf4zKu3Wx94T8Emlmpx0NjgTP
         XGfQ==
X-Gm-Message-State: AOJu0YxdxfMVPtYiJdxOCtzB6SM/0aQOiMmfTFtfy1QZEO63QaH92N5t
        NouvzlLFe7aeAmr+Z3+u0+jSMbRzcFs=
X-Google-Smtp-Source: AGHT+IGRfSJnRUqmM6F4iP7xG7ToPoUynEDMmKSzebxNQ+O6UMdj0g43qIvnomjGcuSzmpO1hIb63w==
X-Received: by 2002:adf:de02:0:b0:317:727f:3bc7 with SMTP id b2-20020adfde02000000b00317727f3bc7mr462198wrm.17.1694125213312;
        Thu, 07 Sep 2023 15:20:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a10-20020a5d508a000000b00319756d5b80sm451225wrt.29.2023.09.07.15.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 15:20:12 -0700 (PDT)
Message-ID: <f680e76de847cf88fc4e4d63844829c6b344a697.1694125210.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1564.v3.git.1694125209.gitgitgadget@gmail.com>
References: <pull.1564.v2.git.1691702283.gitgitgadget@gmail.com>
        <pull.1564.v3.git.1694125209.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Sep 2023 22:19:58 +0000
Subject: [PATCH v3 02/13] trailer test description: this tests --where=after,
 not --where=before
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

Signed-off-by: Linus Arver <linusa@google.com>
---
 t/t7513-interpret-trailers.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 5b31896070a..ed0fc04bd95 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -792,7 +792,7 @@ test_expect_success 'overriding configuration with "--where after"' '
 	test_cmp expected actual
 '
 
-test_expect_success 'using "where = before" with "--no-where"' '
+test_expect_success 'using "--where after" with "--no-where"' '
 	test_config trailer.ack.key "Acked-by= " &&
 	test_config trailer.ack.where "before" &&
 	test_config trailer.bug.key "Bug #" &&
-- 
gitgitgadget

