Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335FDC4167B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0431C207B0
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730607AbgLHWEH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 17:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730592AbgLHWEE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 17:04:04 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1166FC061793
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 14:03:18 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id p126so190047oif.7
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 14:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7VnFwsY7xM/vegQ12SEFiiCQRRPhzMko6e1us1C3KBY=;
        b=T+S0awvBUMN3Hk/YnRIoGx2jSQ+7a+JaeNr6DKlAiQ+aweMRtQPnIAKZzNmMesUGgg
         a7I4A5JNCb4Jh2tmvEPea3rjx4WGohQxnZp+SA2FqFwtintuYwavi0184yGIzuzntzAm
         CHo8mlbTstajiu7wKuUz1lTcviqBqFRwYIpMR6JzkAq+F87uffKUDkrUlJI0ggeW7Otv
         lRJBKD30NSseRYb0hQ7TqvutR6eovNCb40HL04DnE6FWfEZM0LE20HmpVvnDRrz2SqLY
         u2ilfiUh6Ozft9AhcXn6CYlLKIeHlp152zZYu5mzjGm53/7WqnRxJDMLRRy/W/B0Coah
         poxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7VnFwsY7xM/vegQ12SEFiiCQRRPhzMko6e1us1C3KBY=;
        b=ZKl1bd1uj236BnxNHTpedO0WE2SGLIX2pIuWRx9nJRbmIKBLsrjN/qZpcSCQPxngZg
         nZv+EmaU3F0NHdkTnnRYMW2PgogN793oYwGfz7Hil7DX4C6Sr/n7NlFxYLTcgVixr6sw
         b0ErMt5mBkMMYfK6chXtd1Rkfijmbzh/g4t2ncrojAxlzGp0xQuJw+4/yKm/cZz+lJ9N
         Sre6U8vTOWKXOSOXdJvgDrLFeO+vplp+E6AfGya/VfuY7hPGAjHDwZks+jfd2pzgYLrd
         JWQNUu5dUwMYt3BpZL+Mgvyfs07bzR81RUvGqXP4Nf09LWqMiIGakfY4DaycOTIjoCAr
         kHfg==
X-Gm-Message-State: AOAM53061erTw+EZMkmLCHkfrQxGjutSMEv+Fg6jYIvX6yn8S2fIc571
        nDZFN2TSx+adxzNmhaRjV3sIyhxQl+ONQBUJ
X-Google-Smtp-Source: ABdhPJzL/MYrD7Zr5tqIW0b+P14ZRez0oUBe9b53jcF/+DxnuiGTX73sXYO8GNXzcINNJv1ska60nQ==
X-Received: by 2002:aca:eccb:: with SMTP id k194mr4478603oih.112.1607464997205;
        Tue, 08 Dec 2020 14:03:17 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id b82sm11649oif.49.2020.12.08.14.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 14:03:16 -0800 (PST)
Date:   Tue, 8 Dec 2020 17:03:14 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jonathantanmy@google.com, dstolee@microsoft.com,
        gitster@pobox.com
Subject: [PATCH v4 01/24] ewah/ewah_bitmap.c: avoid open-coding ALLOC_GROW()
Message-ID: <e72f85f82ff66d5b8904e36e9571db1a0d52455c.1607464775.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1607464775.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1607464775.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'ewah/ewah_bitmap.c:buffer_grow()' is responsible for growing the buffer
used to store the bits of an EWAH bitmap. It is essentially doing the
same task as the 'ALLOC_GROW()' macro, so use that instead.

This simplifies the callers of 'buffer_grow()', who no longer have to
ask for a specific size, but rather specify how much of the buffer they
need. They also no longer need to guard 'buffer_grow()' behind an if
statement, since 'ALLOC_GROW()' (and, by extension, 'buffer_grow()') is
a noop if the buffer is already large enough.

But, the most significant change is that this fixes a bug when calling
buffer_grow() with both 'alloc_size' and 'new_size' set to 1. In this
case, truncating integer math will leave the new size set to 1, causing
the buffer to never grow.

Instead, let alloc_nr() handle this, which asks for '(new_size + 16) * 3
/ 2' instead of 'new_size * 3 / 2'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ewah/ewah_bitmap.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
index d59b1afe3d..2a8c7c5c33 100644
--- a/ewah/ewah_bitmap.c
+++ b/ewah/ewah_bitmap.c
@@ -19,6 +19,7 @@
 #include "git-compat-util.h"
 #include "ewok.h"
 #include "ewok_rlw.h"
+#include "cache.h"
 
 static inline size_t min_size(size_t a, size_t b)
 {
@@ -33,20 +34,13 @@ static inline size_t max_size(size_t a, size_t b)
 static inline void buffer_grow(struct ewah_bitmap *self, size_t new_size)
 {
 	size_t rlw_offset = (uint8_t *)self->rlw - (uint8_t *)self->buffer;
-
-	if (self->alloc_size >= new_size)
-		return;
-
-	self->alloc_size = new_size;
-	REALLOC_ARRAY(self->buffer, self->alloc_size);
+	ALLOC_GROW(self->buffer, new_size, self->alloc_size);
 	self->rlw = self->buffer + (rlw_offset / sizeof(eword_t));
 }
 
 static inline void buffer_push(struct ewah_bitmap *self, eword_t value)
 {
-	if (self->buffer_size + 1 >= self->alloc_size)
-		buffer_grow(self, self->buffer_size * 3 / 2);
-
+	buffer_grow(self, self->buffer_size + 1);
 	self->buffer[self->buffer_size++] = value;
 }
 
@@ -137,8 +131,7 @@ void ewah_add_dirty_words(
 
 		rlw_set_literal_words(self->rlw, literals + can_add);
 
-		if (self->buffer_size + can_add >= self->alloc_size)
-			buffer_grow(self, (self->buffer_size + can_add) * 3 / 2);
+		buffer_grow(self, self->buffer_size + can_add);
 
 		if (negate) {
 			size_t i;
-- 
2.29.2.533.g07db1f5344

