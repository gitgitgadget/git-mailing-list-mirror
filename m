Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21BAC433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 00:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbiEXAXb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 20:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbiEXAXR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 20:23:17 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D388FF88
        for <git@vger.kernel.org>; Mon, 23 May 2022 17:23:11 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id s28so23348629wrb.7
        for <git@vger.kernel.org>; Mon, 23 May 2022 17:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GSbQJfRRqim6nWjo1GXuQLxg0XtiVzvnROdzieiNBWY=;
        b=A/ZoI/fVICkwzElyBKh9+rAB9xvPo0IczwwJCDqqY34hQGqrQTDRpyLafLIIpFAqtl
         Pa4nefFQHMOwFRDJf8dT16Gk+QV7PTw1rBMNIrOhhxP6zUgM+lcm5PvcelIVAv8u5Ala
         pw4xHy3h1fx0zwRgYkjkjkVrIUvRo0NEg4Rgm3tOz0nGWSYI1pisMAYSSPKsvqzNGNSa
         FRHRfovGKBEk9jdVd1hqpT1qrp1Q/GzwdGRAqsABZPx7Ts4/rlNif1CXi3Y8Rxh7P0eu
         EKKOJv1E/H+7hAdcFdLZpNq+EyG1UacgtYmtpfEBGW+3nYPWMCXn8HovCxobEgl0bWVF
         gDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GSbQJfRRqim6nWjo1GXuQLxg0XtiVzvnROdzieiNBWY=;
        b=P7YXjFghzfYfqBv/20Kcf+b8bFofSOnfOqkbJ8QkLDqOJv4PaS+JyPQ/xxmeMp3PrA
         Tn53PvJGUmIQ/nC4dtCBlj7kdz37tbLBlhQy2WYzQ2SWusEteObODF9/BEC3xGc8JiRQ
         tiR5mhhV7KurhGJ9S7SpkTcltUKzX/9rad2Xp3Pj0F62HJZuxVkXhtQDh6NjTPgF1D+8
         5IHQx6no3ufwQ1IlaYM22OsoenZhEhvdCfkhrUxtWAbd8id3+jk7keZ3JYKrNvWbtGVu
         G+WJ3fDbGV4AW2xIwrSGxsgUUO4mK9hAUqqvEnwrV8MRWnpo2kLEDhHjePhlhBzWge1S
         izjg==
X-Gm-Message-State: AOAM53143weU2sgW+QFSW8TkzeyCV68ospNvhMRl6xtQbj+d38pNipvm
        m7ChpCa9Gn2QUMq0FYMZevJiZCEuX4M=
X-Google-Smtp-Source: ABdhPJx1jIpvb2j9BrLbs3Obsls9M2eRdNM8WdlCa7LbT5RaYn/XWOtPUw/All+Pi5a3hoEt67KKwQ==
X-Received: by 2002:adf:d1ef:0:b0:20e:79af:7701 with SMTP id g15-20020adfd1ef000000b0020e79af7701mr15729133wrd.486.1653351789621;
        Mon, 23 May 2022 17:23:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c8-20020a05600c0ac800b0039729309a84sm568687wmr.20.2022.05.23.17.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 17:23:09 -0700 (PDT)
Message-Id: <8963c6fa625bbaf5153990939ea06742304ddcd2.1653351786.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1238.git.1653351786.gitgitgadget@gmail.com>
References: <pull.1238.git.1653351786.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 May 2022 00:23:04 +0000
Subject: [PATCH 2/4] nedmalloc: avoid new compile error
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

GCC v12.x complains thusly:

compat/nedmalloc/nedmalloc.c: In function 'DestroyCaches':
compat/nedmalloc/nedmalloc.c:326:12: error: the comparison will always
                              evaluate as 'true' for the address of 'caches'
                              will never be NULL [-Werror=address]
  326 |         if(p->caches)
      |            ^
compat/nedmalloc/nedmalloc.c:196:22: note: 'caches' declared here
  196 |         threadcache *caches[THREADCACHEMAXCACHES];
      |                      ^~~~~~

... and it is correct, of course.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/nedmalloc/nedmalloc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/compat/nedmalloc/nedmalloc.c b/compat/nedmalloc/nedmalloc.c
index edb438a7776..2c0ace7075a 100644
--- a/compat/nedmalloc/nedmalloc.c
+++ b/compat/nedmalloc/nedmalloc.c
@@ -323,7 +323,6 @@ static NOINLINE void RemoveCacheEntries(nedpool *p, threadcache *tc, unsigned in
 }
 static void DestroyCaches(nedpool *p) THROWSPEC
 {
-	if(p->caches)
 	{
 		threadcache *tc;
 		int n;
-- 
gitgitgadget

