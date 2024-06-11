Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DCD47F5D
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 17:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718126907; cv=none; b=RrCkSME9nGdxZS3MZNtQj1Aon0il09I9Vfv7ecRRUYZZ9tCA1XDYsQWpKV2RYZxsXimZFkJQHdolYWTgvwnYiaSP26WhCQ9V7pFijmNGjEKg+C0FS/Q3oTT7Q5yV1W810jW205lMmM1aDiWtpIQjiDHXBAjBxejZSXwGxn6Zw5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718126907; c=relaxed/simple;
	bh=XLmBgdYvzO2opiSP7Lfa58zo+DqYe9LA1lHWzLhzq4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpBxyWI1pjR8eLaiwsN8zIXpk1x4cKV3veHc0/Zd4RlccnbMayQpXyA1WlGFo3GkkOaECxp5G5HvFrV5Knc6kjkAnm9U+PEJ3BWvTujrYLuzKvOBtEiooyH3t3q0gNaWAEURxl9vd9a3FbI1t791uet34ReyUcqOsWRtkpNGnXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=j5fjTQOh; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="j5fjTQOh"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-24c9f297524so3319735fac.0
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 10:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1718126905; x=1718731705; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7xjSmD23sLlXv3mrqs0SrsHiTZego6HQFibXfnZ+W2Y=;
        b=j5fjTQOhlgA0qK43f8c31/qqtPsWsxhcJcnGMUSYZTDkdyzsAi9O9AWC1vr1iiYy5g
         IjW0xNzgZqzNIy+gFrxml1bw128No2q+yVJkytJSXVuyuuvJFzNeHT0QYfa0EcXwifqr
         Ow4wmpMHBeP7wRbQtjZ24tNviNkgvbsqW0fohQ4oIfZaqP8tXs3O01VI6ttAsCTCB4zz
         S3iNvInp7exPYwP5pq3kx4G4Ahu9TU3P9q9KJt+KEtkx395f6HabKDAKIiKP/VFTveEm
         H8aaJVXMJWuwSFXb1hT6ee1pOtoVCTjwr17uUp8YEqKIV30ZUPIVBVgIEaNNhMPmss9B
         QQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718126905; x=1718731705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xjSmD23sLlXv3mrqs0SrsHiTZego6HQFibXfnZ+W2Y=;
        b=WO48fSF04SZLXF7chEeQSclpjQHoar5NEH6CyRBjWYrdmJ7w+qpRnCYMo0prRHMYR8
         p9DrNvT9uUAhnhNzQyGdADV/9ld4zpIrBJMmbjOLCRlnTrTOt2BQ+PR+qUhDVNdjB43c
         FQ3DLMqx8GtzsoQbE13y8msaR4YX0PJkL7X1eyJ+UVIdoLFSUz7XAi8LkoUjhAXfldTd
         7lY2b0CEyVtni9b/+FFvpp4V0ESk0C5JqSgkA0WhMyb+dEliB3qPMHN5MAhs+xpWLkkr
         q8TG7HNu8TS/1aOHTPyC6eK7lTn6O70QkSz6qSvEJLfqd/Sj0hgU7tN1aiXOlkoVaqAc
         jKYg==
X-Gm-Message-State: AOJu0Yw21KslrmB+bZ4wP9vgl+aTphtVEsz/Jy65YF4hM1oa6jfG4i25
	hr+gjtGquTFbgCWAvVopHeE3sBs95/X+r+OebF+Z2dmNfhS6T+e8TFwC5cj/Ja8macM5rVyv+AQ
	Q/S0=
X-Google-Smtp-Source: AGHT+IHdXyb1ZgQgFMNcKd5+3YzFPnZNyj3yIcayFZMbs/dAlXud1gD34NodZfrE/DEPNCW0qPAc1A==
X-Received: by 2002:a05:6871:3313:b0:254:8666:34d9 with SMTP id 586e51a60fabf-25486663d0dmr12765818fac.16.1718126905454;
        Tue, 11 Jun 2024 10:28:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7955d6e91e2sm265589285a.27.2024.06.11.10.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 10:28:25 -0700 (PDT)
Date: Tue, 11 Jun 2024 13:28:24 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 3/3] pack-revindex.c: guard against out-of-bounds pack
 lookups
Message-ID: <06de4005f15a970628cef1aeb7f159ca05b8e34d.1718126886.git.me@ttaylorr.com>
References: <4aceb9233ed24fb1e1a324a77b665eea2cf22b39.1717946847.git.me@ttaylorr.com>
 <cover.1718126886.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1718126886.git.me@ttaylorr.com>

The function midx_key_to_pack_pos() is a helper function used by
midx_to_pack_pos() and midx_pair_to_pack_pos() to translate a (pack,
offset) tuple into a position into the MIDX pseudo-pack order.

Ensure that the pack ID given to midx_pair_to_pack_pos() is bounded by
the number of packs within the MIDX to prevent, for instance,
uninitialized memory from being used as a pack ID.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-revindex.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/pack-revindex.c b/pack-revindex.c
index fc63aa76a2..93ffca7731 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -527,6 +527,9 @@ static int midx_key_to_pack_pos(struct multi_pack_index *m,
 {
 	uint32_t *found;
 
+	if (key->pack >= m->num_packs)
+		BUG("MIDX pack lookup out of bounds (%"PRIu32" >= %"PRIu32")",
+		    key->pack, m->num_packs);
 	/*
 	 * The preferred pack sorts first, so determine its identifier by
 	 * looking at the first object in pseudo-pack order.
-- 
2.45.2.448.g06de4005f1
