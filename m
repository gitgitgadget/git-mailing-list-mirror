Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D47C1B0D9
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B52E23A1D
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbgLHAFn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727744AbgLHAFm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 19:05:42 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F13C0611CA
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 16:04:50 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id b18so14338255ots.0
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 16:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bsuIqyXlLj77HI6Jh/NOCqFh+idsp+iFSjpkcZnqfL8=;
        b=aQM4hreS6KtUL1R136w+xwOYm2V2sqqwsv2J/erkj887bXhFXcv3Gx+yU1WvhiWT6X
         uRdF2h3iz9rN7VTZFQOV297YD2YuilW//+/vyqVgtXPHOumQevv2zhg1wHJKzKDI4P37
         ySrk+di+BKJ03hBoYr/dsiI8r8haOn2aZ8+c1S9kPfB1krcqCZpvC6w/skbYIIPoJQT3
         C8jNm2YQkfZzVwp1h3GH9dsb3Dcy5GOITqAdP5FA0sN+Rg6Jqr6aSXF3jmChjzFlWOSE
         MtPAIvIl4wIaGkY8CamG/En/CX00NtlV7HCOKL7sblwSNdSiMsXn9NwDPx1nieRk58bA
         aOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bsuIqyXlLj77HI6Jh/NOCqFh+idsp+iFSjpkcZnqfL8=;
        b=hQhPp4zDdIdn53OD4mt1zsjiMztHvbjktta4ZdDdxgAaaIJb72CpofOa1f4uS1S4CT
         c0KrclMUUDYfI9wNDeo111mElm7nKpcbmvGUnd9pyqfeoSnNgkW/embjig9bhT/vwYq2
         klfTe1JjZwXTIaj1sU9O9ld0QBr75+xTsaEbvhExTwBtZdk7pnq+PdGmI0b88LfYNvPH
         Hn/Ap1m0kXWJAQHJynFd7gK0KUnQLln+C7u/Fdj+xopmD/IsVewPOC0W8iGT60jwTKbd
         4PG/p7K0Yy/Hn5P/dSlPFXVon/FMv65ijWz5CWVuAM3B5eiaDPakz2EDIa7JQ3M2C2+s
         6aGg==
X-Gm-Message-State: AOAM532m4MzvOU4fQ9T7sA0GIRHIJeI6AmWg1zU98YAeXCsSbIfk8K2f
        QcAokxZ2h4Ie+6Gwy+bgJSwgTBpgD0qJ9ShB
X-Google-Smtp-Source: ABdhPJxfJgOKA7lgXWXOsB1ehCDGtRvcG+wL3MMoe3quKW3Kkeeq8NxK1HzSopN7ftMDs7DFCEtnaw==
X-Received: by 2002:a9d:1725:: with SMTP id i37mr14866583ota.258.1607385889890;
        Mon, 07 Dec 2020 16:04:49 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id s189sm3318435oia.7.2020.12.07.16.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 16:04:49 -0800 (PST)
Date:   Mon, 7 Dec 2020 19:04:47 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jonathantanmy@google.com, dstolee@microsoft.com,
        gitster@pobox.com
Subject: [PATCH v3 08/24] ewah: implement bitmap_or()
Message-ID: <34137a7f35835c923fe9db39049a124a41ca0839.1607385833.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1607385833.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1607385833.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

We have a function to bitwise-OR an ewah into an uncompressed bitmap,
but not to OR two uncompressed bitmaps. Let's add it.

Interestingly, we have a public header declaration going back to
e1273106f6 (ewah: compressed bitmap implementation, 2013-11-14), but the
function was never implemented. That was all OK since there were no
users of 'bitmap_or()', but a first caller will be added in a couple of
patches.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ewah/bitmap.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index 6f9e5c529b..0a3502603f 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -122,6 +122,15 @@ void bitmap_and_not(struct bitmap *self, struct bitmap *other)
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
2.29.2.533.g07db1f5344

