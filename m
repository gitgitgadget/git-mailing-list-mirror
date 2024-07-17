Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E038318A954
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 21:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721250728; cv=none; b=T21GgEszuJ8One8jAgKmcKpmJgpQ8TNSEVmtPvQx1Aw23u82zdZj8b8pkQ2QpsbUD03W2Blafm+j0bowrfYjxJnyquok5HOntCqjfr+hEAbaJniUD5zwx+Mr8Kj8Oc7hw/od62YuzI8AUVM2ykTBmC1TvlCoGdDPdB3M9kMLJ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721250728; c=relaxed/simple;
	bh=Isoh02kTDUBRIwHH6++Z7mL1+1LN7zMmYKYVOZk5s94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KArKMm5sXPO4McB0wdczuF5HTkwyUxooA0uGOvPaYz2kaEnlSMVEpKOmlEPohAvwGPIIx7q3xcu3AmfTL7zFpONLAmogZGws2d3FU52ZFwkXlUlMZ8eWu5uaZlWFEjXmky3oXBrzBWo+pZt+wedaUN5Uwa8o2qEc8+M0RNUHa7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=jqkdhx0J; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="jqkdhx0J"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-65f880c56b1so660517b3.3
        for <git@vger.kernel.org>; Wed, 17 Jul 2024 14:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1721250726; x=1721855526; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kz/8b+wuhxyJnYviG8OTEvKWV/IrYoPoFuxkdnrTjI0=;
        b=jqkdhx0JH9hczkhwaTIkNhifoSSPlxuCRiTSV3cX7SRENnNL9gcVfw6RWejATyhtyX
         ulHILzOtrwFWEHkv+x9hslu8dMn17N0cQjLe5LYaLeEilp+fcpYgxpv5P3YI2KIbWsYs
         tQ51yAY99Sge5j37TQVAiKAqv/pBj0pqHLfXOzH1l6PRv+49QkkkQgDdp1CXROiaeMc0
         sb1M3Ad0T8LlAFPl0zraCD5//Z+YfeNrQIHCG3Ewntf5XYjEhLKuxjJv/rjOtuY7Qugz
         BQMBqty0dM0PPEEbeDJA2i21PIfMbAk9s1bwbLd/foJJaWMI34Y68X755RKGMrM1zT8Z
         4e/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721250726; x=1721855526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kz/8b+wuhxyJnYviG8OTEvKWV/IrYoPoFuxkdnrTjI0=;
        b=w/Sff5DSjJnjAV4CCMVJuLJ+4ZbzVQ3e7aGHctOEvROUlDYsFNTS3rigXLyHem7Qmy
         tvsKtwP+y0KBsebMJIupsXBXQy2WsHMX7GD0zI81rQhqplewBX7FgGkZNGAGBJbolK9v
         VeIPNbIbA978Z6YY3+i1FYHD4VAdOFNI1cdiDH02mXMO4lhKxhHb5mMEqQr2iRazvHQ0
         ZDsLL6TWKzjXrpO25CDLJH1KK3xS4O3pdIgI3mAR5+ckk+LxklFgZ3LGY9SuVuCXgjPR
         5CJJPFqrwBT8ZkqUqi6RRTWlVRztbpEqj04u9MVBAP01JlQkz7EP3laaDzxi/hhCSqYX
         MagQ==
X-Gm-Message-State: AOJu0Yxr31px290qB8k0ZiMJG0HLXlHPCQ5JEpGrjkYLuuh6rOXbIvHy
	+N/KHcznQwkFpy+x0GBiquF7bc1sSxG1GzcQsdlN7nQLUUJfyO04NsjcaChgJG7043kqApKMco/
	Z
X-Google-Smtp-Source: AGHT+IH4ftP/IYjMb3vn2qs7pLIqwXMIc9fdeRv9WsAxGsFuTFBG1VFP5SilEpRHU7UhGuomrQNnEQ==
X-Received: by 2002:a0d:da07:0:b0:64b:630f:9f85 with SMTP id 00721157ae682-664fe45113fmr32414117b3.12.1721250725741;
        Wed, 17 Jul 2024 14:12:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-66601fb47cfsm784267b3.32.2024.07.17.14.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 14:12:05 -0700 (PDT)
Date: Wed, 17 Jul 2024 17:12:04 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 03/19] midx: teach `nth_midxed_pack_int_id()` about
 incremental MIDXs
Message-ID: <f449a72877de97d89e31a56724b4f65be2f33f20.1721250704.git.me@ttaylorr.com>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1721250704.git.me@ttaylorr.com>

The function `nth_midxed_pack_int_id()` takes in a object position in
MIDX lexicographic order and returns an identifier of the pack from
which that object was selected in the MIDX.

Currently, the given object position is an index into the lexicographic
order of objects in a single MIDX. Change this position to instead refer
into the concatenated lexicographic order of all MIDXs in a MIDX chain.

This has two visible effects within the implementation of
`prepare_midx_pack()`:

  - First, the given position is now an index into the concatenated
    lexicographic order of all MIDXs in the order in which they appear
    in the MIDX chain.

  - Second the pack ID returned from this function is now also in the
    concatenated order of packs among all layers of the MIDX chain in
    the same order that they appear in the MIDX chain.

To do this, introduce the first of two general purpose helpers, this one
being `midx_for_object()`. `midx_for_object()` takes a double pointer to
a `struct multi_pack_index` as well as an object `pos` in terms of the
entire MIDX chain[^1].

The function chases down the '->base_midx' field until it finds the MIDX
layer within the chain that contains the given object. It then:

  - modifies the double pointer to point to the containing MIDX, instead
    of the tip of the chain, and

  - returns the MIDX-local position[^2] at which the given object can be
    found.

Use this function within `nth_midxed_pack_int_id()` so that the `pos` it
expects is now relative to the entire MIDX chain, and that it returns
the appropriate pack position for that object.

[^1]: As a reminder, this means that the object is identified among the
  objects contained in all layers of the incremental MIDX chain, not any
  particular layer. For example, consider MIDX chain with two individual
  MIDXs, one with 4 objects and another with 3 objects. If the MIDX with
  4 objects appears earlier in the chain, then asking for pack "6" would
  return the second object in the MIDX with 3 objects.

[^2]: Building on the previous example, asking for object 6 in a MIDX
  chain with (4, 3) objects, respectively, this would set the double
  pointer to point at the MIDX containing three objects, and would
  return an index to the second object within that MIDX.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/midx.c b/midx.c
index 3992b05465..39d358da20 100644
--- a/midx.c
+++ b/midx.c
@@ -242,6 +242,23 @@ void close_midx(struct multi_pack_index *m)
 	free(m);
 }
 
+static uint32_t midx_for_object(struct multi_pack_index **_m, uint32_t pos)
+{
+	struct multi_pack_index *m = *_m;
+	while (m && pos < m->num_objects_in_base)
+		m = m->base_midx;
+
+	if (!m)
+		BUG("NULL multi-pack-index for object position: %"PRIu32, pos);
+
+	if (pos >= m->num_objects + m->num_objects_in_base)
+		die(_("invalid MIDX object position, MIDX is likely corrupt"));
+
+	*_m = m;
+
+	return pos - m->num_objects_in_base;
+}
+
 int prepare_midx_pack(struct repository *r, struct multi_pack_index *m, uint32_t pack_int_id)
 {
 	struct strbuf pack_name = STRBUF_INIT;
@@ -334,8 +351,10 @@ off_t nth_midxed_offset(struct multi_pack_index *m, uint32_t pos)
 
 uint32_t nth_midxed_pack_int_id(struct multi_pack_index *m, uint32_t pos)
 {
-	return get_be32(m->chunk_object_offsets +
-			(off_t)pos * MIDX_CHUNK_OFFSET_WIDTH);
+	pos = midx_for_object(&m, pos);
+
+	return m->num_packs_in_base + get_be32(m->chunk_object_offsets +
+					       (off_t)pos * MIDX_CHUNK_OFFSET_WIDTH);
 }
 
 int fill_midx_entry(struct repository *r,
-- 
2.46.0.rc0.94.g9b2aff57b3

