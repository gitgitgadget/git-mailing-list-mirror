Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD883C4361B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 652C823A1D
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgLHAFC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgLHAFC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 19:05:02 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53A3C061794
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 16:04:16 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id f132so3073124oib.12
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 16:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7VnFwsY7xM/vegQ12SEFiiCQRRPhzMko6e1us1C3KBY=;
        b=ABL9BeKYAHk+ThcnqfnAiQfwPEThnyKcMGQt09fQs9uxrlGayw2Vf4TYO6MZ/P2PqX
         zoRTTMt+04/6xIEtBTY2RlsmRrtEOpfSBxRwJ158XSDGAkSJzhGZxQtckh6zmxsoGr6Y
         Xv66lDHyuD2bLvKulMcrmCAk+EbHeJ+CHGnL9aBsz3cI8KJdWqyQSzTU7dQejWUKLaVK
         mGJHCITkynbAoRzNLIY0OrG/KFxR0/kS5z9rvntpKRrVNlf6pCmtRYzXCFo0KyxRjKcv
         C71UmWefbfZwMPRYge4HtqYUTFdAsM5WhXYSSI77N3ctB6r6lGUnZW/6nb2JYIU22pnd
         l2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7VnFwsY7xM/vegQ12SEFiiCQRRPhzMko6e1us1C3KBY=;
        b=UV9qtgbqb281Bazvecuw8fDV2ooz/Sr8K+fza4EQ88GqHUThs7bfYxxE5SB/uerXKa
         RF7Z97PWFgpq7fSdXn1/U6yiEsIyhPQsK05B+YnZRMr2raP/9ThVJi4yVUtCZ1y0zyj4
         rkK1376L4hUR0347bNETEkXvaB7QeXLbxrXYkAxqhsio/CPMg41fs05TrTnkF0o1d4Vj
         s5oQadPa67fkGcnXrtw0jWHiPGiYltCYYmx7HpgpXFO756OJxZnr33rBc2jPEf5jH/wg
         /gYqVSCMpjNYewVOAbQ5Q1CjtOCd2bkHP3mJhGNhd6KfLrsVUda7zPuvwnXkplgFNIZk
         Ll2w==
X-Gm-Message-State: AOAM5308qvYPgz2XqGkLSXB7C2rGQ4n9vlFXLj3aBqWZl7JwdXwPn3NU
        iZR7G7mQNcEfKuxHMzM9qtIyCeJ/vDfJHedO
X-Google-Smtp-Source: ABdhPJx5DPO6Z+bTUq9TG8lpPu5Do3RS1erfVRcPv5kEhvhZhJcANtvqhC8ETQzVqCcc0sRq9V6wug==
X-Received: by 2002:a05:6808:b26:: with SMTP id t6mr919099oij.169.1607385855822;
        Mon, 07 Dec 2020 16:04:15 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id g13sm2327221otl.47.2020.12.07.16.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 16:04:15 -0800 (PST)
Date:   Mon, 7 Dec 2020 19:04:12 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jonathantanmy@google.com, dstolee@microsoft.com,
        gitster@pobox.com
Subject: [PATCH v3 01/24] ewah/ewah_bitmap.c: avoid open-coding ALLOC_GROW()
Message-ID: <0b25ba4ca7133be1f7b763ba9c3d18dbdd03f37a.1607385833.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1607385833.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1607385833.git.me@ttaylorr.com>
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

