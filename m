Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DE191F462
	for <e@80x24.org>; Fri, 14 Jun 2019 10:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfFNKBL (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 06:01:11 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38692 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfFNKBK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 06:01:10 -0400
Received: by mail-wm1-f68.google.com with SMTP id s15so1679298wmj.3
        for <git@vger.kernel.org>; Fri, 14 Jun 2019 03:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6y4/B3GCSlzLW+19ZLqqCtsXWf3XzHTGJZ2CxN8hHSo=;
        b=Dxv6MTu6jMP+07kB2Ie6xQbx544OAjNga/hK7mrXbjTr1zRci/0zufRoMDjj3BcU/t
         hqAWAZq2ceg6O+3lkCfLa1oWHDm5Oy8OSikAgy2r0wrgSRJsNanfS4q+MC4cpSE1V1nv
         FnkrIduZrl+m+Qy+6GBkwBUgAg55/3fcedmC++2+31Z0uuZbstiNmOaboant3iRTksuU
         tKOCt0CATJsM/ugZI9/HSgiUfRJTd5mgPZq/S8zE9pparN+uspNzwjG0uG9EEcewDtDE
         OAgk3TXO+reQ6wmiXdzOMZFjBKe/6e6iOeZvqYEfLsnwp2flBbHRuIln43JMIYRULyfQ
         CKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6y4/B3GCSlzLW+19ZLqqCtsXWf3XzHTGJZ2CxN8hHSo=;
        b=AfI/vI/w3g1/V1fdZDZe1NSvS9x0FhkbInDRLUC46LUiR/wTtaEWOeS9dEFXPRxlww
         ZZcgffPcThsniYpunC5nPCT6cUdrEew03dCRbkqC0B17YRhVhH0vPJU5wBDdOw1iXSZK
         3B0YZmbbWsEE6ix4SHoTPzy9klADtgP0gu10dD0Y1XZaOlV9PeCDt+Kb+/d0A2q0HnCg
         x++Lq9Sf/7gU5ah6W/fzQpsYCJ3in+EVPrVMJYmPej3MM5idc63y3095OYli+DfbUdkD
         wOcEK717z/mjlD8Hp7zi3KrRxCJ5zN0yFph0rtovK3t78Rra9WH0zFXtNvhklGSNMg+H
         v2Pg==
X-Gm-Message-State: APjAAAU8f2GqxOQJNXjsa+G49gJha8NCHIl4lm1H+tRTLunVWr0f5zTV
        ooFmUVQCywY/lX/G0FxpkM5OVpee
X-Google-Smtp-Source: APXvYqzFYTwMOxbRoZzn1Ineoy1eWhn4cBbmXMO4hc+1RqqY5K+Kuncs+WQFAlBKcgace3YTFoJVIw==
X-Received: by 2002:a1c:2d8b:: with SMTP id t133mr7236337wmt.57.1560506468294;
        Fri, 14 Jun 2019 03:01:08 -0700 (PDT)
Received: from localhost.localdomain (x4db35d93.dyn.telefonica.de. [77.179.93.147])
        by smtp.gmail.com with ESMTPSA id d3sm1986988wrs.8.2019.06.14.03.01.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Jun 2019 03:01:07 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v1 4/4] compat/obstack: fix some sparse warnings
Date:   Fri, 14 Jun 2019 12:00:59 +0200
Message-Id: <20190614100059.13540-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.22.0.589.g5bd7971b91
In-Reply-To: <20190614100059.13540-1-szeder.dev@gmail.com>
References: <20190614095308.GG31952@szeder.dev>
 <20190614100059.13540-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'compat/obstack.c' occasionally assigns/compares a plain 0 to a
pointer, which triggers sparse warnings.  Use NULL instead.

This is basically a cherry-pick of 3254310863 (obstack.c: Fix some
sparse warnings, 2011-09-11) on top of the just updated code from
upstream.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 compat/obstack.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/compat/obstack.c b/compat/obstack.c
index 6ef8cecb8a..5fff087cd3 100644
--- a/compat/obstack.c
+++ b/compat/obstack.c
@@ -135,7 +135,7 @@ _obstack_begin_worker (struct obstack *h,
   h->next_free = h->object_base = __PTR_ALIGN ((char *) chunk, chunk->contents,
                                                alignment - 1);
   h->chunk_limit = chunk->limit = (char *) chunk + h->chunk_size;
-  chunk->prev = 0;
+  chunk->prev = NULL;
   /* The initial chunk now contains no empty object.  */
   h->maybe_empty_object = 0;
   h->alloc_failed = 0;
@@ -178,7 +178,7 @@ void
 _obstack_newchunk (struct obstack *h, _OBSTACK_SIZE_T length)
 {
   struct _obstack_chunk *old_chunk = h->chunk;
-  struct _obstack_chunk *new_chunk = 0;
+  struct _obstack_chunk *new_chunk = NULL;
   size_t obj_size = h->next_free - h->object_base;
   char *object_base;
 
@@ -243,12 +243,12 @@ _obstack_allocated_p (struct obstack *h, void *obj)
   /* We use >= rather than > since the object cannot be exactly at
      the beginning of the chunk but might be an empty object exactly
      at the end of an adjacent chunk.  */
-  while (lp != 0 && ((void *) lp >= obj || (void *) (lp)->limit < obj))
+  while (lp != NULL && ((void *) lp >= obj || (void *) (lp)->limit < obj))
     {
       plp = lp->prev;
       lp = plp;
     }
-  return lp != 0;
+  return lp != NULL;
 }
 
 /* Free objects in obstack H, including OBJ and everything allocate
@@ -264,7 +264,7 @@ _obstack_free (struct obstack *h, void *obj)
   /* We use >= because there cannot be an object at the beginning of a chunk.
      But there can be an empty object at that address
      at the end of another chunk.  */
-  while (lp != 0 && ((void *) lp >= obj || (void *) (lp)->limit < obj))
+  while (lp != NULL && ((void *) lp >= obj || (void *) (lp)->limit < obj))
     {
       plp = lp->prev;
       call_freefun (h, lp);
@@ -279,7 +279,7 @@ _obstack_free (struct obstack *h, void *obj)
       h->chunk_limit = lp->limit;
       h->chunk = lp;
     }
-  else if (obj != 0)
+  else if (obj != NULL)
     /* obj is not in any of the chunks! */
     abort ();
 }
@@ -290,7 +290,7 @@ _obstack_memory_used (struct obstack *h)
   struct _obstack_chunk *lp;
   _OBSTACK_SIZE_T nbytes = 0;
 
-  for (lp = h->chunk; lp != 0; lp = lp->prev)
+  for (lp = h->chunk; lp != NULL; lp = lp->prev)
     {
       nbytes += lp->limit - (char *) lp;
     }
-- 
2.22.0.589.g5bd7971b91

