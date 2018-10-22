Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD2051F453
	for <e@80x24.org>; Mon, 22 Oct 2018 05:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbeJVNxX (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 09:53:23 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44241 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbeJVNxX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 09:53:23 -0400
Received: by mail-pf1-f194.google.com with SMTP id r9-v6so19317413pff.11
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 22:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wQSghAW43n2kSUyJXLAX/nCRZmdm8YvOrQOt802OqMA=;
        b=by/uqDDqU63OfNaLKFm7LKIS79R8IaQ70e8koY/M03QgTozxy/UZoM6qSClqVreinf
         T28mnRju3ubQZXj1e5rfZ/LDlMj7LwXIFfJq6jpEueOFip+YzOIsb0kAf/vGoS3eyAtY
         S5dt3LPL66u501YDWMBk+qRVETNqHAU+SMaO3p2LRWAayCgprEtb3srZPFIkDyhkGseH
         bK4l3DjwSKSorASWFBLS4xKCveYNWC0zaqThs1nkE4rz5r6ds4n8kWf/dAESnCkOt3UP
         zNfPDoNi1ysVUoNQ2Cce8snvnRDrpGu/JVUWGJbIIFp0HlXsj/78Ixk6RTu1carlrxSr
         TRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wQSghAW43n2kSUyJXLAX/nCRZmdm8YvOrQOt802OqMA=;
        b=KI26H7YfGTNi0nDTfzVgD0fR7+bZwCQ6ynKB6gSir8CDswb2Qp2O78BjzNnL+NFlUR
         oVbQzWiRDfpKpGbdJMavIBLobKYpsKwHnSdFENWOjLDXta+ybAbcVlEz6i046SISpJyz
         KM9QUDB9UK5CEoj10gvCOc0u9mTTMLDeSRwf0/Ooz7cfgiztUV0G+PxvhfNCa4dID4+C
         WzRhAgUhXZlT6/bb+DMZF5kvROAH8bRIBndBEFmtEsHFSFG4fGGpnXPgAclTU8Fd6KlK
         aQinH7sCWxkKHUEcfk4+vcD20qXAzd+Jj/JaMHoiMNYcssw5XT7H66L6q5HrXIIPkBks
         f8nw==
X-Gm-Message-State: ABuFfoiC6l2rq1T7P2U/9ZG9v0c99Zx3QidqecImRaxLvf3UiMpkmcQe
        XHkfxsN68Co7mPTRdSucHcmjchMZ
X-Google-Smtp-Source: ACcGV61d/ynQOsq+x2NP7ZFXTFvOD24z3gDzbjGDGCPw2SfZxsc2lZSKnU6FDvfkuiGq0xKZW/KgWA==
X-Received: by 2002:a65:56cc:: with SMTP id w12-v6mr18489251pgs.224.1540186583731;
        Sun, 21 Oct 2018 22:36:23 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id n63-v6sm38004733pfn.9.2018.10.21.22.36.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 21 Oct 2018 22:36:23 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 1/3] sha256: avoid redefinition for MIN
Date:   Sun, 21 Oct 2018 22:36:03 -0700
Message-Id: <20181022053605.81048-2-carenas@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181022053605.81048-1-carenas@gmail.com>
References: <20181022053605.81048-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

it is already defined whenever "sys/param.h" is available

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 sha256/block/sha256.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sha256/block/sha256.c b/sha256/block/sha256.c
index 18350c161a..0d4939cc2c 100644
--- a/sha256/block/sha256.c
+++ b/sha256/block/sha256.c
@@ -130,7 +130,9 @@ static void blk_SHA256_Transform(blk_SHA256_CTX *ctx, const unsigned char *buf)
 	}
 }
 
+#ifndef MIN
 #define MIN(x, y) ((x) < (y) ? (x) : (y))
+#endif
 void blk_SHA256_Update(blk_SHA256_CTX *ctx, const void *data, size_t len)
 {
 	const unsigned char *in = data;
-- 
2.19.1

