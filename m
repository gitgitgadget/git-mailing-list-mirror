Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F24AC433FE
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 11:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235590AbhLGLKB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 06:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235584AbhLGLKA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 06:10:00 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD0CC061748
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 03:06:30 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id u17so21343532wrt.3
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 03:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r8968T3naNuQ5j9UoZ5NsXC+Nitrdb9t+7Ha30Hni7M=;
        b=bcGxYM/HrjB/W7sa3KVoHCuNyFTsnHDf1baiFztTfToOzO0aiX/gpbmA80qxV4kz/u
         d4NSA42+Z0fkbMnpE4hbkUvYd32bpS1M4jZj43WNpjyzPQs+JCHlPrQV1n9wCrxejODL
         IhTf917nyt1sATLMkhj1C8a4RxmyffTObParKfshIn2Ko1k2H8fEYwEkc+5lMgQSM7VL
         /XfcBTrK3b14Tv1kCdxrdhYiM9QrZyyFMOFv0Vrt+H6FXbHPd7HfiOGjCiscVWA6e40O
         hNOKXdD4bp9rQa4macooiBcRRm+S5N4/OCXaBc6aGlLIK1WApKdchOp2+XuYFtW5PLVZ
         eW6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r8968T3naNuQ5j9UoZ5NsXC+Nitrdb9t+7Ha30Hni7M=;
        b=6L1g4J9QTcPvHPxqVo67QOvmVGtracBfCqiOB2fYsG8U/5spmQCV+HyEX2shc+Nj9n
         mPn3YZLpuOaKVKalN3/i1SGpVHvGTDZBM/3YFSHrBTA2F0YsJ6mRn1nB1r4K3zR/WZpw
         GinfYmSMwj95Ax1GSDW4+QZqBmxbsdnZ+0MaKIjUIWJ3h0evCSvStKOQLlgooneZV8Y9
         RnCqZx1OBMtNHENbxEH3CLw/YoP5/KYiP4MNdDnKQGBwE91JfQDd0VkacMx6l9h1KN2B
         NcbR5b3Od3rIfYoVcLq7ZS7Vhj56FuUVIOOva92c6LiCLRANyJXn6AsXPv2fXgeD12X8
         pCxw==
X-Gm-Message-State: AOAM532ua4oG9bv78moBnx7w7RYiOP0dha3hGWH0ApxuzWQonom1wJat
        Nn+DN03I9MI9eQhHVIPVle7cH10++y1iiQ==
X-Google-Smtp-Source: ABdhPJy+S5CB62ITkzIL5qOP25uDAFUjbUPY3elC2IyboT2eJIfUw8n2BBBHhD4G8nC6JaSqE6EH2w==
X-Received: by 2002:a5d:6508:: with SMTP id x8mr48631858wru.388.1638875188638;
        Tue, 07 Dec 2021 03:06:28 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r17sm2629587wmq.11.2021.12.07.03.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 03:06:28 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/4] strbuf.h: use BUG(...) not die("BUG: ...")
Date:   Tue,  7 Dec 2021 12:05:52 +0100
Message-Id: <patch-v2-2.4-6740c5d0da8-20211207T110440Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.898.g5a552c2e5f0
In-Reply-To: <cover-v2-0.4-00000000000-20211207T110440Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20211206T162442Z-avarab@gmail.com> <cover-v2-0.4-00000000000-20211207T110440Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 7141efab248 (strbuf: clarify assertion in strbuf_setlen(),
2011-04-27) this 'die("BUG: "' invocation was added with the rationale
that strbuf.c had existing users doing the same, but those users were
later changed to use BUG() in 033abf97fcb (Replace all die("BUG: ...")
calls by BUG() ones, 2018-05-02). Let's do the same here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 strbuf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/strbuf.h b/strbuf.h
index 96512f85b31..76965a17d44 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -160,7 +160,7 @@ void strbuf_grow(struct strbuf *sb, size_t amount);
 static inline void strbuf_setlen(struct strbuf *sb, size_t len)
 {
 	if (len > (sb->alloc ? sb->alloc - 1 : 0))
-		die("BUG: strbuf_setlen() beyond buffer");
+		BUG("strbuf_setlen() beyond buffer");
 	sb->len = len;
 	if (sb->buf != strbuf_slopbuf)
 		sb->buf[len] = '\0';
-- 
2.34.1.898.g5a552c2e5f0

