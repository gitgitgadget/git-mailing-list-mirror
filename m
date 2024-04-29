Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F95A1779B1
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 20:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714423448; cv=none; b=Bb0oNjEfm4MAyLB8OlmOL7ei8KTgADQIx2qSGWbNiZMLQyJxIybyvIWza8Z2XMOU6q3dF3plRcdYl3bz8UlBOi3AKuzI7Tx6/HCHtfLJL5NyygVYBNriL3/HSkX/h+WvTEyXh3sKOfSJy0Vr8BCp1nOtUkj6vU4ifGTUjwodJAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714423448; c=relaxed/simple;
	bh=UmeTX517CZV/Dmxixbw0T6EgqFGIkyh+cH4s7AeqCWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwkwoRSlwXP14zVVM2soykuT3lkIj7HRLOvJ9FyI2T3bpe+PGkwjfM6TPfJISNPDpd8jQJY+VJ+p5Bzj4OHmZDspbd//op0dHbLufrHboyOfOMeJHDA3QzKDow9bTF1oxI7VPlJ5W8iu8LrrdIlqjLKlqVJaBaWACWJ/193UPfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=wKWAd7Ku; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="wKWAd7Ku"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-69b514d3cf4so53889956d6.0
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 13:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1714423446; x=1715028246; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UPapTvPHlFB8iWTIO6Q/BZ2fGUJm3bOyC6YN8/L0aeU=;
        b=wKWAd7KuUkZ2kcWLWqX5D4TOVgQa0IEhMtvGrJE954fYCe2iECJClAVbOVX/Uj+DsL
         ut6nl4vEzihYZcGqhz+mOpq57Y2Z8lDJHElKfIRcJ6MaHWNU5DmxEuSVcBTqhDghNgMK
         6uLChPxb/icCQl8p81xFTubDHkNDJEYzmrwmG8si1yF9pupmQuXKtCMYFmxcVDiTxceE
         YhQ7XYgz6eD7GmB2SeVKpGtQ7GCZmxcg9NSrS9L/F+uoRZzw8wkeOehWzbOJFn28f32E
         uYXyOclP77LMZcWhljJB2gabjKqN78yubfxVZmt3Tz5zasycYS3LG24sgF7EklWuY+XQ
         CNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714423446; x=1715028246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPapTvPHlFB8iWTIO6Q/BZ2fGUJm3bOyC6YN8/L0aeU=;
        b=O5CDAVyv7SzYi/a43DCt/Y9r0cIIJZjb8ijEdaITYBoSe5UrB1ZdRS4uQTzqCEw3GX
         792lqXbJI0I5YHjyR/ggTKw7LKxzTeYP4Jv+OXvLuGxMZONeqnhEhMmqt8iuUla4j3OH
         JjJWRsdXGA8wW845TXJkktEUTFYqqy5u6xAU5yuwoNhZrWPifcCeggA+tFpAHtmSC6Cb
         42N0NO6+txGvuMuHRnv5AG3S5J+xANiAnDfn9BK/agZKeh1UOIJBngfTaJxaMrDEup3+
         RIzWQyzFFAznHRZnjGG2bp2IZRZvmhLIZkH/KhHDgQE7eV3ZL35r/7Fc7irzm5zTnTX9
         fhYQ==
X-Gm-Message-State: AOJu0YxFUBNrGUS7EL4yDlFzPYmXgD4pCsxO9iitWrTa0Q9cw2wABGPX
	YuG1OUVrSUUYi1vYusraNrX8VfBVonESg4VEzNBwj2yP0lROX7rCeoEX8LzsUkrURALLKd7Cg6X
	AxEQ=
X-Google-Smtp-Source: AGHT+IFiygYslx6/MMQTJ9bQQ4iaPoAgt720ZJMZb1DKBtNnFMaVlql0Qmt7SXPraoSULdNeiAgZug==
X-Received: by 2002:a05:6214:27c8:b0:6a0:b9e7:dd4d with SMTP id ge8-20020a05621427c800b006a0b9e7dd4dmr10195396qvb.42.1714423445861;
        Mon, 29 Apr 2024 13:44:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y19-20020ad445b3000000b006a0cf22e54asm1233706qvu.41.2024.04.29.13.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 13:44:05 -0700 (PDT)
Date: Mon, 29 Apr 2024 16:44:03 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 16/23] ewah: implement `ewah_bitmap_popcount()`
Message-ID: <09650aa53e9207191e7607f9f7ec77e2e7bc796b.1714422410.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1714422410.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1714422410.git.me@ttaylorr.com>

Some of the pseudo-merge test helpers (which will be introduced in the
following commit) will want to indicate the total number of commits in
or objects reachable from a pseudo-merge.

Implement a popcount() function that operates on EWAH bitmaps to quickly
determine how many bits are set in each of the respective bitmaps.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ewah/bitmap.c | 14 ++++++++++++++
 ewah/ewok.h   |  1 +
 2 files changed, 15 insertions(+)

diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index d352fec54ce..dc2ca190f12 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -212,6 +212,20 @@ size_t bitmap_popcount(struct bitmap *self)
 	return count;
 }
 
+size_t ewah_bitmap_popcount(struct ewah_bitmap *self)
+{
+	struct ewah_iterator it;
+	eword_t word;
+	size_t count = 0;
+
+	ewah_iterator_init(&it, self);
+
+	while (ewah_iterator_next(&word, &it))
+		count += ewah_bit_popcount64(word);
+
+	return count;
+}
+
 int bitmap_is_empty(struct bitmap *self)
 {
 	size_t i;
diff --git a/ewah/ewok.h b/ewah/ewok.h
index 2b6c4ac499c..7074a6347b7 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -195,6 +195,7 @@ void bitmap_or_ewah(struct bitmap *self, struct ewah_bitmap *other);
 void bitmap_or(struct bitmap *self, const struct bitmap *other);
 
 size_t bitmap_popcount(struct bitmap *self);
+size_t ewah_bitmap_popcount(struct ewah_bitmap *self);
 int bitmap_is_empty(struct bitmap *self);
 
 #endif
-- 
2.45.0.23.gc6f94b99219

