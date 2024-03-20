Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29B686131
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 22:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710972312; cv=none; b=iU/lP5qzaZmr05fhSkXgmB6XITJ8FHZ6n41qtTMzSks1a+cwLbmQWP3x/3PSZDBnI9auGJtTaVPzI2xl7zztL/iPfbTYryvvjzi31+HZdDiRjPpFU5lfVZhALYgvwq4PVz+OAorhQ3WvQUTgakSWX0r41bME5rDaFxsRhBahoNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710972312; c=relaxed/simple;
	bh=0IpM2t38P1YeJBWTuYK6bgLOvacT3tqmVF+1vFnsFT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=knnjwaoi7HuO3Zy1zcmIdsMc2czBaJrBZ6g9fb11TMkBWKjV5/vEbEzxXm3xC8QYZLjeSJP62rnHwhJ1rhrIW9A2SRQbB6lUlO9KeAVEzM+KEh6MlZDJyMs37kYcLVQZQi6NqkmtWQRhB2jAWE/+0Ncsl/u8GjCGM5RpdDhfeM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=nEGEwaDI; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="nEGEwaDI"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-429de32dad9so2159261cf.2
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 15:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1710972309; x=1711577109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cJM5xCxTM7Nb1bLkpH/0xSc8bYxvez5lLB3JsXCjZ4Q=;
        b=nEGEwaDI0Brg1Ixv6LBYKsR6fYPdWqcp6JpEfN3eMfKdXWig+ybBhxMCiLu3uoeK6V
         tYAR7Y5Ws4fYZzyMBKOMMaoVVYwgNp4uDTqaAs1GroUjZ18w7uvSDTE0LiJE+V/sd9f1
         xwFkM5DoT7GOX3bTHPKj5tfZ/2aUKuqXXSLjUP5LM/QhbAZkP5ovfKHr+kQU3KMJn7Mg
         p86Q/9ssQBmc2FpfzQ9Ri+kNlEYH2qVx7Y0aFLn3HeW6NkCdUjRyQInwV7xZLlIzJmUX
         BsIRofijRb9lTuJ9l+LGS6fAznzyO5VrGFl7MaNO63I3PNKM/aDtlSNHF8xdowWA2m+O
         aqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710972309; x=1711577109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJM5xCxTM7Nb1bLkpH/0xSc8bYxvez5lLB3JsXCjZ4Q=;
        b=tdDc0f3FStSg2QZaQGyqAvbV9+ttCjc8veboB9Mt4v+EmudgkqueE3leb7A45gYWJ4
         Yrb85nj2363LKVFW0AxUThxmDDrNMdOowlr9FVJtr1oLjMj57AiQvKcgMEwQN0itfjz8
         RqYC1I9/QE+0hN89A/dBPFkGwBYtjbZ2yG9gAHXzMmuLIhNh65UkwkxOmBM46CzQRxxx
         PZkeRCNduwuerCz2Xr2xpvmV89ARZhu9NGJM5Y3lbP6fAPQ8QBb0fz+Ww2tO1IissB8u
         H1bJFv7BP+ygpY6VPqNymUFdefMBpFXIo76aVGqwUx5Juoa6qZ3iFUbKmYY6+i2ge0+V
         RFhQ==
X-Gm-Message-State: AOJu0YxCRdc2QySY/qtCIY/v+h/CbHC0uVLDFCrbNqpwdTsL51lChM1v
	6Lx2YNtBTiLZQwqiYyUDKvyl9q7/qK/4sdKoqstgOydXAz3GgmdI4ChXqwWG7SgoTQnO0vBk9wu
	r5v0=
X-Google-Smtp-Source: AGHT+IEXESnRCmY+5dWCMABQ8kvlt2FW5R3CBsgsSVMNI+zsmNUmErjZHMyWdPCZ66Lx8uBd++7t3w==
X-Received: by 2002:a05:622a:1787:b0:431:2033:d4cc with SMTP id s7-20020a05622a178700b004312033d4ccmr326691qtk.21.1710972309345;
        Wed, 20 Mar 2024 15:05:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id cp3-20020a05622a420300b00430bf59ebccsm5447733qtb.11.2024.03.20.15.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 15:05:09 -0700 (PDT)
Date: Wed, 20 Mar 2024 18:05:08 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 03/24] ewah: implement `ewah_bitmap_is_subset()`
Message-ID: <1347571ef4ca6329de58394bfea71927c8e08151.1710972293.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1710972293.git.me@ttaylorr.com>

In order to know whether a given pseudo-merge (comprised of a "parents"
and "objects" bitmaps) is "satisfied" and can be OR'd into the bitmap
result, we need to be able to quickly determine whether the "parents"
bitmap is a subset of the current set of objects reachable on either
side of a traversal.

Implement a helper function to prepare for that, which determines
whether an EWAH bitmap (the parents bitmap from the pseudo-merge) is a
subset of a non-EWAH bitmap (in this case, the results bitmap from
either side of the traversal).

This function makes use of the EWAH iterator to avoid inflating any part
of the EWAH bitmap after we determine it is not a subset of the non-EWAH
bitmap. This "fail-fast" allows us to avoid a potentially large amount
of wasted effort.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ewah/bitmap.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 ewah/ewok.h   |  1 +
 2 files changed, 44 insertions(+)

diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index ac7e0af622a..5bdae3fb07b 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -138,6 +138,49 @@ void bitmap_or(struct bitmap *self, const struct bitmap *other)
 		self->words[i] |= other->words[i];
 }
 
+int ewah_bitmap_is_subset(struct ewah_bitmap *self, struct bitmap *other)
+{
+	struct ewah_iterator it;
+	eword_t word;
+	size_t i;
+
+	ewah_iterator_init(&it, self);
+
+	for (i = 0; i < other->word_alloc; i++) {
+		if (!ewah_iterator_next(&word, &it)) {
+			/*
+			 * If we reached the end of `self`, and haven't
+			 * rejected `self` as a possible subset of
+			 * `other` yet, then we are done and `self` is
+			 * indeed a subset of `other`.
+			 */
+			return 1;
+		}
+		if (word & ~other->words[i]) {
+			/*
+			 * Otherwise, compare the next two pairs of
+			 * words. If the word from `self` has bit(s) not
+			 * in the word from `other`, `self` is not a
+			 * proper subset of `other`.
+			 */
+			return 0;
+		}
+	}
+
+	/*
+	 * If we got to this point, there may be zero or more words
+	 * remaining in `self`, with no remaining words left in `other`.
+	 * If there are any bits set in the remaining word(s) in `self`,
+	 * then `self` is not a proper subset of `other`.
+	 */
+	while (ewah_iterator_next(&word, &it))
+		if (word)
+			return 0;
+
+	/* `self` is definitely a subset of `other` */
+	return 1;
+}
+
 void bitmap_or_ewah(struct bitmap *self, struct ewah_bitmap *other)
 {
 	size_t original_size = self->word_alloc;
diff --git a/ewah/ewok.h b/ewah/ewok.h
index c11d76c6f33..c334833b201 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -180,6 +180,7 @@ int bitmap_get(struct bitmap *self, size_t pos);
 void bitmap_free(struct bitmap *self);
 int bitmap_equals(struct bitmap *self, struct bitmap *other);
 int bitmap_is_subset(struct bitmap *self, struct bitmap *other);
+int ewah_bitmap_is_subset(struct ewah_bitmap *self, struct bitmap *other);
 
 struct ewah_bitmap * bitmap_to_ewah(struct bitmap *bitmap);
 struct bitmap *ewah_to_bitmap(struct ewah_bitmap *ewah);
-- 
2.44.0.303.g1dc5e5b124c

