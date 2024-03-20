Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC0685C51
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 22:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710972368; cv=none; b=i5pKZbYO/crforekZjoTIC5jyYCZYT0X2nMy98qihzH5sTAYJxO8mL6/MtoaLvgaqbPOzMPbH6t+vv6fg+WfNKX0H+Yci+8Sz/A3ElhiO+OVwJWgvzAahXV3YsVozUfqa9mg9dYhcikRBxd9nevse2bZdbIAyzqDVex19g6Mu6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710972368; c=relaxed/simple;
	bh=KKvLWU8FC1yfen69son4EmnxoeodpjekonGcyUOmpCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzV51do0i+2viDWE9JTE262hMiaUeWeWno7Xfj6UpNuaJIHGQLhSDw/mEZsQUGZnGiIP5342CVetDL+mTj04Nq+A6mabG2mX8OR5PYZcoluBgC0uxy8sj2j/JxbHW3IPwu7w0pPGPneuxzZ58Ce7A7fhqezSkc4loV+mMczy7vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=24DKaKw+; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="24DKaKw+"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e682dbd84bso180233a34.0
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 15:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1710972366; x=1711577166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CulxNu1SVN0LUBqrLvG0/ZAJrUkb6yN9SnGiMoaKZN4=;
        b=24DKaKw+t28v1xw+9ppE0t1aViC9JI6iat4qjyIDL/2+mi3O8aQn/JhuLXAzZNwfYX
         c6/9vpAzAh2HJarUdbzRwHOSTXhiBD/mh8nWfEljkiwKB8Dzv8oyfi759NPhgy/LYY6D
         Z4DaFzNOH1mo0blSAKKfaE9sOdHauC7uUggiem9/v/ao0Hn15qzOttEszXpfFmsieaBK
         ne47JduvC0HxUpRymbJ8QhCApZr71hX2qeSJ3LUTRkt8o/Nb86NhufI9T2EBzV0yNQcD
         9E6/R9SBhYSCycUaQ6BGKces0wzI/4u69DCFbsMa1SyuF+m7s7+PF5KOLOrfcmLaYuGh
         9gYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710972366; x=1711577166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CulxNu1SVN0LUBqrLvG0/ZAJrUkb6yN9SnGiMoaKZN4=;
        b=SUIXzY/cKZ3yodcx5nxIs52eInFn+Gh1+80cHiGC/mTi5GuMC4xaV9Va8Z0tRskVB/
         dZBJ4c+/wh0Z7AW5qLxb8IIvYgxj8ZYK8JAX7YL5S9/oZ08zcKu9zG9QcH1QM0ocAloS
         a7+6J5OsPNH0Pym34uZTMViVijiFGztUvbHVYFg8eEOODKma4J6JZQEe8aZx2bRhQiSB
         4AQCtOEXAmVRTbiIUFwo1T8Km6gZixlVk0smd6v3sqvun8rRtnksg9OrH3f+jLRgtzJt
         X852WsczNp4XT2hWCjYNhoQk6Qh8ez3oj2QP8x5CuUVh8hpfvZ2VMX/bN2p73Gkuqoco
         ScOg==
X-Gm-Message-State: AOJu0YzHfXuhbhRJ92s/sdnWlGELqfcVOhzkncdcDAhIsQUdr6wb6HKa
	UK3NyVkLx4ufLDOnQxJzahSLetsT5tv/B/jk/grke8ag6a7Qj3UJbaomPGt5i4zKsReXRdM7lYc
	FpCY=
X-Google-Smtp-Source: AGHT+IGWGduUvDp9nPoRV7q3q9e0FE+4+d9A4w1zO8UEj0OiGBDNNAKU5CBd5zhEXDRtbrBLAcmgyQ==
X-Received: by 2002:a05:6830:4787:b0:6e5:f65:8775 with SMTP id df7-20020a056830478700b006e50f658775mr20431708otb.24.1710972366059;
        Wed, 20 Mar 2024 15:06:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n21-20020a05620a223500b00789ed8823f5sm4597526qkh.0.2024.03.20.15.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 15:06:05 -0700 (PDT)
Date: Wed, 20 Mar 2024 18:06:04 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 22/24] ewah: `bitmap_equals_ewah()`
Message-ID: <1eb10c190ba1f045b3eab8c1975a77e6a046c8ee.1710972293.git.me@ttaylorr.com>
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

Prepare to reuse existing pseudo-merge bitmaps by implementing a
`bitmap_equals_ewah()` helper.

This helper will be used to see if a raw bitmap (containing the set of
parents for some pseudo-merge) is equal to any existing pseudo-merge's
commits bitmap (which are stored as EWAH-compressed bitmaps on disk).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ewah/bitmap.c | 19 +++++++++++++++++++
 ewah/ewok.h   |  1 +
 2 files changed, 20 insertions(+)

diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index a41fa152cbd..59dc77a08f6 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -261,6 +261,25 @@ int bitmap_equals(struct bitmap *self, struct bitmap *other)
 	return 1;
 }
 
+int bitmap_equals_ewah(struct bitmap *self, struct ewah_bitmap *other)
+{
+	struct ewah_iterator it;
+	eword_t word;
+	size_t i = 0;
+
+	ewah_iterator_init(&it, other);
+
+	while (ewah_iterator_next(&word, &it))
+		if (word != (i < self->word_alloc ? self->words[i++] : 0))
+			return 0;
+
+	for (; i < self->word_alloc; i++)
+		if (self->words[i])
+			return 0;
+
+	return 1;
+}
+
 int bitmap_is_subset(struct bitmap *self, struct bitmap *other)
 {
 	size_t common_size, i;
diff --git a/ewah/ewok.h b/ewah/ewok.h
index d7e9fb67715..0d49ec00618 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -179,6 +179,7 @@ void bitmap_unset(struct bitmap *self, size_t pos);
 int bitmap_get(struct bitmap *self, size_t pos);
 void bitmap_free(struct bitmap *self);
 int bitmap_equals(struct bitmap *self, struct bitmap *other);
+int bitmap_equals_ewah(struct bitmap *self, struct ewah_bitmap *other);
 int bitmap_is_subset(struct bitmap *self, struct bitmap *other);
 int ewah_bitmap_is_subset(struct ewah_bitmap *self, struct bitmap *other);
 
-- 
2.44.0.303.g1dc5e5b124c

