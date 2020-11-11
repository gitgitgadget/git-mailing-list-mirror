Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C421C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11E2A2087D
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="CGBs3pBT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgKKTnH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 14:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbgKKTnH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 14:43:07 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5971EC0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 11:43:07 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id g19so1529608qvy.2
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 11:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sE5cm27BQBCiqVlBL8nTP7rYpEYlk03VQA5EA27Rtqc=;
        b=CGBs3pBTP+aMRwCd+O8j/p/yNCldMmPc2rIeLq9BV+Vj+YADIIf5/rIEm8F1NeGgPe
         rlZzNG2CE4KN4xywgL537bnMF1xx4t9wk1QK/0v7t7ZSsWKTYhW9WjEXnwNJjnl3Ko7U
         8sw2hrNWBnyhUezqKp+eOXp8Cpv2GC5hcvLTpkoUK3B23gndN8U0Qov08RYx343YazA6
         me+8W9cBZaBajt3FIKyTLtR7ECWHb6CgdPT2RoGkybr+vLvHpr5p/mlwzdtGPgcMm/s0
         bETQGvxpnpLgbVlZqd3GBGu3DMY8YT/ZSqIRV+oExu08lXfVaERGexBenuJCQvmWdkEb
         2/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sE5cm27BQBCiqVlBL8nTP7rYpEYlk03VQA5EA27Rtqc=;
        b=piLVxKFiPe45fJOE+bNdMzaTF5X46Dd4yJCWrzK5GLmX1blQ7S2QE1gsc9jnln3shO
         ruw2D9NSfFcRPPGPh9yLU/xfi78fCwqTML1pmmf5uVutNOJhbtEc1i7YFQIgC9lraTof
         QiWgJlsuK6h7RRLiD+mCVK4M/6/C/Zo968poiA8TgicSCOFZUZYplvBIwp1TODy6zipa
         1Pyxo5IXlVMkj5FZnBCwvWxL1+zwslX2NuGt/tE46LRqbTZnfcrzU32kEi6wh217rpV0
         EJc1MlCZSxaBTfHCrFke/RE0BduFvIJOXKbV58G3cJ/KcIUxXMpbHlK9OOOazcgKOHmG
         yTRA==
X-Gm-Message-State: AOAM530BvaHfU7NcWwUlDYpsvYgav2M5H9HrLS4Ai1VW1nQMSHRyfemG
        yxZXeTPjyzgT+XoosvajYk+2X6YE/B+0KBkQ
X-Google-Smtp-Source: ABdhPJzbMKMvBJECrJ1xY4OE+oMngLM8tZ74EQcLTOHmF0lCu3bqFH2QuCMAsoHY4G46jV/HL0+4Rw==
X-Received: by 2002:a0c:e443:: with SMTP id d3mr15685381qvm.18.1605123786373;
        Wed, 11 Nov 2020 11:43:06 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7ccc:9a51:1ad:2057])
        by smtp.gmail.com with ESMTPSA id t20sm3162276qtt.70.2020.11.11.11.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 11:43:05 -0800 (PST)
Date:   Wed, 11 Nov 2020 14:43:03 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: [PATCH 08/23] ewah: implement bitmap_or()
Message-ID: <dce9b6da0ad38da0a92b39d780d7b56f83d52950.1605123652.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1605123652.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

We have a function to bitwise-OR an ewah into an uncompressed bitmap,
but not to OR two uncompressed bitmaps. Let's add it.

Interestingly, we have a public header declaration going back to
e1273106f6 (ewah: compressed bitmap implementation, 2013-11-14), but the
function was never implemented.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ewah/bitmap.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index 43a59d7fed..c3f8e7242b 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -127,6 +127,15 @@ void bitmap_and_not(struct bitmap *self, struct bitmap *other)
 		self->words[i] &= ~other->words[i];
 }
 
+void bitmap_or(struct bitmap *self, const struct bitmap *other)
+{
+	size_t i;
+
+	bitmap_grow(self, other->word_alloc);
+	for (i = 0; i < other->word_alloc; i++)
+		self->words[i] |= other->words[i];
+}
+
 void bitmap_or_ewah(struct bitmap *self, struct ewah_bitmap *other)
 {
 	size_t original_size = self->word_alloc;
-- 
2.29.2.156.gc03786897f

