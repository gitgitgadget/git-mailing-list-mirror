Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A60121F406
	for <e@80x24.org>; Thu, 10 May 2018 18:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757426AbeEJS1P (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 14:27:15 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51295 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757247AbeEJS1O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 14:27:14 -0400
Received: by mail-wm0-f68.google.com with SMTP id j4-v6so5364522wme.1
        for <git@vger.kernel.org>; Thu, 10 May 2018 11:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VK5JZcShs/1ULxsNnu6F6biIjKM5/lQQCtZB9/tX8t4=;
        b=OMwTw0DJRHVfRXEbeCRn7U5/7HFeQM2qWjx0lFBKghwoY0ugTP39/4OUNAoL/3bB6N
         c1Bd/mNPFjtJdNsWcnveMbEsAPuxIuJTsulX8HbIaUq5WsN6uENdRn0sSg5lAd6gNkwN
         7SfkCeAz0JLs03OJjNSMZGygwdKIbbOmWTKZ9ADiZbloMi8mlQzZoyhHaRW6Ut1TeG8J
         x7Dz+YglrFf+MLAeEElEmRCfo7JS9PYvoDWVpzr0ZZdQjfcb59sjMa/p/Z4cwegpj0Zc
         mFdSf1K9tvzUVHu+zbKVkw80ojD5MQDYh+Cuwp1W0PhaMpzBit6yxkxHPdnFPJHkrher
         bGhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VK5JZcShs/1ULxsNnu6F6biIjKM5/lQQCtZB9/tX8t4=;
        b=sRaViFafqiqQzUHgTYQmbU/sU2sGTPJHKHSiEoqRz4rrvjCKOxQPwE91cbIRVRBpnh
         F29X7TPQjBnK9CvhLyaOabXnppis9kReRO+/VlChGPu4SIRyisAV/dGVWHThlC/FPu5k
         uwY42wbo0ItrxBmVPbPoT1wiThedIjJPVXGBPpDuSQRakxL1whUtr8Zy7zGKyeP0xR9/
         FLgu1zlLg7QTQdfZhHQ3Is+HOrHV2emiDOy/8dqg/3CwrWA6aNGyeRqPZ0v4bo1jQGj8
         ynIVh1YRFq4nabYzuwkx+JgAcVQeF0VBe28RW2FdgQ+g4aVFL4f8w6yooAPK/JYQRwYH
         SpFQ==
X-Gm-Message-State: ALKqPweKpK3AGM/W0R6hQFyL/+RKebuMyr6RH9+LI+J24JIg80svvmmO
        BOmQzvuoxTrlLqeXrapeovpxVW0s
X-Google-Smtp-Source: AB8JxZoSeguYsay4D4QAtliItrYO+BvCIsv55V9vw5vgA9Dc7PTFrFxvcBW1+/nC5N/YMUkEEG1BBw==
X-Received: by 2002:a1c:2856:: with SMTP id o83-v6mr52862wmo.3.1525976833623;
        Thu, 10 May 2018 11:27:13 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8071:b6aa:7d00:bd4c:eff9:63bd:dfc9])
        by smtp.gmail.com with ESMTPSA id v12-v6sm1383306wrm.68.2018.05.10.11.27.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 May 2018 11:27:13 -0700 (PDT)
From:   Leif Middelschulte <leif.middelschulte@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.ath.cx,
        Leif Middelschulte <Leif.Middelschulte@gmail.com>
Subject: [PATCH 1/1] Warn about fast-forwarding of submodules during merge
Date:   Thu, 10 May 2018 20:26:57 +0200
Message-Id: <20180510182657.65095-2-leif.middelschulte@gmail.com>
X-Mailer: git-send-email 2.15.1 (Apple Git-101)
In-Reply-To: <20180510182657.65095-1-leif.middelschulte@gmail.com>
References: <20180510182657.65095-1-leif.middelschulte@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Leif Middelschulte <Leif.Middelschulte@gmail.com>

Warn the user about an automatically fast-forwarded submodule. The silent merge
behavior was introduced by commit 68d03e4a6e44 ("Implement automatic fast-forward
merge for submodules", 2010-07-07)).

Signed-off-by: Leif Middelschulte <Leif.Middelschulte@gmail.com>
---
 submodule.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/submodule.c b/submodule.c
index 74d35b257..0198a72e6 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1817,10 +1817,12 @@ int merge_submodule(struct object_id *result, const char *path,
 	/* Case #1: a is contained in b or vice versa */
 	if (in_merge_bases(commit_a, commit_b)) {
 		oidcpy(result, b);
+		warning("Fast-forwarding submodule %s", path);
 		return 1;
 	}
 	if (in_merge_bases(commit_b, commit_a)) {
 		oidcpy(result, a);
+		warning("Fast-forwarding submodule %s", path);
 		return 1;
 	}
 
-- 
2.15.1 (Apple Git-101)

