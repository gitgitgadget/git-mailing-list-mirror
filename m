Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00FD61F403
	for <e@80x24.org>; Sat, 16 Jun 2018 05:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756809AbeFPFmp (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Jun 2018 01:42:45 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:40723 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756808AbeFPFmK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jun 2018 01:42:10 -0400
Received: by mail-lf0-f68.google.com with SMTP id q11-v6so17517371lfc.7
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 22:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z5kOgxAPU+IDWKbBuulBSuWl+oWCdkQ5oUPXQeLT4bM=;
        b=LsB6evESDNhe87S1xvz1LuWN3o9ojAgGfN0iO7RRbM4CiSF8kkZyB4Xj6c6HNIASss
         6W1AxvXp8hvrPzgJvCVSSmgWpcV2y9JFnUtbxzmYsXWWFZ8BerrT5pPF4ghPdjiVOQbN
         Gbu4ibd4HQZri5eECucWVHayky1oWVK1GEVZM8UmXaGai3H2DY+/zQbOnJqxjRwYn32E
         lHoFqyhWhfbm0Dnsc90WQubI7kp4j9/E/iWFcRFr4posXcDz3WeHb7jGA46AOfwpf/Mx
         /eskuq+EDKncVuCzmHciGYQwvD8ve68VVZ9YSUXTrurNy9aVlSKZNZuNQj2u1l95f7US
         0wQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z5kOgxAPU+IDWKbBuulBSuWl+oWCdkQ5oUPXQeLT4bM=;
        b=VRlW28pTFADQ3GiYU7WAmWXFZWsjf6ecxNJ1r1ovoWTjKPRd+MndN1xh3ktVHfWnmK
         OKea8cBoUIzUsbr5zpN/tcWRI2Ij+x94wzD4Fz4mSXMdgLMZgK7UTLp3b/GN0kMmzkP5
         nwwzv/AJE/00VwMEc00J1qqIclrYOwJQku+8giUagSgTR4FsKe2BYNzbpWPdhSt62rIR
         SMzt9xlXWTvCwhkVTryrqEQ0pHEep1HfD5JMwn+8speHZwqrEvqm4CqEO3xaBYs7KCb1
         PzinKT5lYRVogwzvT45+HmYjflB424YzhuKMlzSa0JLoHRYP0s9COk+lQWGrmr8oovj0
         89Zw==
X-Gm-Message-State: APt69E3LFTdOwUPL3guxNY3C5qy01wkvGjz7HuCDyXahiTM+KpIed8eo
        pa8f/qWTyNivTuxhg9dI+mgdgw==
X-Google-Smtp-Source: ADUXVKJ4fPzWx4t7qVrAFEnO2Pw85OoLnUf3v7o+hUdnhn2MTULDmzTjXjdCzNtXfLxRKM+CHl3ejQ==
X-Received: by 2002:a2e:889a:: with SMTP id k26-v6mr2962014lji.54.1529127728389;
        Fri, 15 Jun 2018 22:42:08 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g5-v6sm1745194lje.21.2018.06.15.22.42.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 22:42:07 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 07/15] entry.c: stop using index compat macros
Date:   Sat, 16 Jun 2018 07:41:49 +0200
Message-Id: <20180616054157.32433-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180616054157.32433-1-pclouds@gmail.com>
References: <20180616054157.32433-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 entry.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/entry.c b/entry.c
index 2101201a11..ec588289fb 100644
--- a/entry.c
+++ b/entry.c
@@ -421,7 +421,8 @@ int checkout_entry(struct cache_entry *ce,
 
 	if (!check_path(path.buf, path.len, &st, state->base_dir_len)) {
 		const struct submodule *sub;
-		unsigned changed = ce_match_stat(ce, &st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE);
+		unsigned changed = ie_match_stat(&the_index, ce, &st,
+						 CE_MATCH_IGNORE_VALID | CE_MATCH_IGNORE_SKIP_WORKTREE);
 		/*
 		 * Needs to be checked before !changed returns early,
 		 * as the possibly empty directory was not changed
-- 
2.18.0.rc0.333.g22e6ee6cdf

