Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C508C4361B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5E3323A04
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbgLHAFy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbgLHAFw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 19:05:52 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A1FC0617B0
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 16:05:12 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id i6so8220948otr.2
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 16:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9mqvfpcaLJPH1p9MC9DOD+j9GQThZNPIDACNQV59NaA=;
        b=MIkJpbvKwY82mNrxHOKYopIy6iBYJJXya5nvsYzxEIQFT3aFw9QOKEyP+8UH17awos
         a/BjQQEW4NPv1lsomSpTgRVDIzW2wx6fDfNlxlRIjg1Iw6MXh80QpNzNAw0WCjuC6y+8
         HGq2JKhNIddukOQ+9PhqzExtMLWiTP3WMSqmjBY1thi/LjNGI1UJncws85lF/Nq9Ix+t
         FioEBqjSYnNZLBfbruD2wN0oDHmMsJL5IjgFcp4FL0DLUyrxm3WSI9t/agJg1+ayZpOC
         flH9TD7eqtF2UyNKYaMz+sh2+CZiXpGxsGsbidivhc81F5tMqtu7h6Pke0lwheKYCWJo
         s77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9mqvfpcaLJPH1p9MC9DOD+j9GQThZNPIDACNQV59NaA=;
        b=Szsc2W9c7gTfrdKwJwhMyFWZ7WBRTnyPGbiCSiIzouO0F3N3jfLTuHrbHNe2oLGly0
         xQdEGytAb6jRppQYl/h6q37w3Xrxq56uRsfsESOqqbxOga5Pla8FSl51Qr/aF2ncQm6r
         c27NBknAMAfH6dUn6pJXoj2Q+6Fi0lkEC5HIe2h4r0fkulUtfTcPsvKnUJ5dOatxS9oS
         90DASrYk2OUQ2RnqgKUJgmqKb7Q6+r1f4vZsZXlZiBUglHoaP9blISOsivoDzasEsa3N
         nnKJ5ik8bkGcTCWYJFv/1QP75MVBXSf2DYvBIe0Thu0/YbFMxNbWaJI+VD89O8WWnhKf
         3zsw==
X-Gm-Message-State: AOAM5306MNT4ucg0Tz7eMHsK8LKu2ZCudEiexGh/d6dJpy2zUH14R43Y
        HiOUrK92/zH/OblM5LhBKt2ZF6Yy8IZvedY/
X-Google-Smtp-Source: ABdhPJwiKDU8uZ1cQQjgLvXKzBeL6QKaQ4iTX05+b7ZoXHDQtcFDkcFAiVfr/J2jxdUZU7kMdoaQWw==
X-Received: by 2002:a9d:3a76:: with SMTP id j109mr14830084otc.186.1607385911898;
        Mon, 07 Dec 2020 16:05:11 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id 43sm3005709otf.28.2020.12.07.16.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 16:05:11 -0800 (PST)
Date:   Mon, 7 Dec 2020 19:05:09 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jonathantanmy@google.com, dstolee@microsoft.com,
        gitster@pobox.com
Subject: [PATCH v3 13/24] bitmap: implement bitmap_is_subset()
Message-ID: <0d5213ba44351df71d4f1405683c3d0729031f14.1607385833.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1607385833.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1607385833.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The bitmap_is_subset() function checks if the 'self' bitmap contains any
bitmaps that are not on in the 'other' bitmap. Up until this patch, it
had a declaration, but no implementation or callers. A subsequent patch
will want this function, so implement it here.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ewah/bitmap.c | 21 +++++++++++++++++++++
 ewah/ewok.h   |  2 +-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index b5f6376282..0d31cdc866 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -195,6 +195,27 @@ int bitmap_equals(struct bitmap *self, struct bitmap *other)
 	return 1;
 }
 
+int bitmap_is_subset(struct bitmap *self, struct bitmap *other)
+{
+	size_t common_size, i;
+
+	if (self->word_alloc < other->word_alloc)
+		common_size = self->word_alloc;
+	else {
+		common_size = other->word_alloc;
+		for (i = common_size; i < self->word_alloc; i++) {
+			if (self->words[i])
+				return 1;
+		}
+	}
+
+	for (i = 0; i < common_size; i++) {
+		if (self->words[i] & ~other->words[i])
+			return 1;
+	}
+	return 0;
+}
+
 void bitmap_reset(struct bitmap *bitmap)
 {
 	memset(bitmap->words, 0x0, bitmap->word_alloc * sizeof(eword_t));
diff --git a/ewah/ewok.h b/ewah/ewok.h
index 1fc555e672..66920965da 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -180,7 +180,7 @@ int bitmap_get(struct bitmap *self, size_t pos);
 void bitmap_reset(struct bitmap *self);
 void bitmap_free(struct bitmap *self);
 int bitmap_equals(struct bitmap *self, struct bitmap *other);
-int bitmap_is_subset(struct bitmap *self, struct bitmap *super);
+int bitmap_is_subset(struct bitmap *self, struct bitmap *other);
 
 struct ewah_bitmap * bitmap_to_ewah(struct bitmap *bitmap);
 struct bitmap *ewah_to_bitmap(struct ewah_bitmap *ewah);
-- 
2.29.2.533.g07db1f5344

