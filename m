Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931391803A
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 15:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722958660; cv=none; b=MK8bAInHBjAg0C0ytkZOMPVKOFKeUGM82xjoDvBdntzaG+/U8/UqqgxPEWCJL6Q/FN2TQg52p1d6k7TNagAS6OAqrdq7Luqhn7yx+4iKF6VWiMsP568mKqYir8Tk0SymurnxkzV6bj2g+SsEGwdugVbJp0q5DqEHQg7MQgWCOLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722958660; c=relaxed/simple;
	bh=Sm902H3OkCI6WvXQvFzvxjLaTw6RNy5olb6it/shaYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcfPDl5CjtuOrEtGCFeA6vAmplxwBO9ZgbnfPXnGWib3bkBTjxH8469rZFGBchgNJouG5wQ2VLlFQBT2BfWgha2fgspoQzmGaGZNwjPgvJwZ+OFNIvKIN33TMHa1kF9mZCHHnvnY8mQZul/F7CuuF48vacU+MWsSoLoky0SbjkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=EXXBqBBx; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="EXXBqBBx"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e08724b2a08so721031276.1
        for <git@vger.kernel.org>; Tue, 06 Aug 2024 08:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722958658; x=1723563458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jOQTdvBUzMX58Rlmb47zlKgb68JW4baJQmHV56iFGO8=;
        b=EXXBqBBxmkK0UnU+FWuUfbCPeBBXb9yOW2KakeEC5HSR849NJPVPCp34LVWBhkmSxK
         /1TwmHdOLn5w4GVdAeXTUDutzzBKTccYxfuU2es0td9Mo/dpkJ+j80Lyx346qbcsx/nV
         EU4xQ/Igg79y8JzFghlIsTu7EN8HKwMMGICQP4JW2EWo3wzBjiYr8bMyinHERY6RO10D
         gPfpztGOixzwzInqdxoqoZ4Tr3iyp5q6J6nL/K+84D6Yim10MmlVcJ1wteLdniD3qtag
         jYqqDZvwMilYcU8iJmpUDkGa5kIK6Qs+hVilJq9Ju3oaCGsnzZr1gvoIBFLGyelSPNsd
         7t8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722958658; x=1723563458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOQTdvBUzMX58Rlmb47zlKgb68JW4baJQmHV56iFGO8=;
        b=Kin+FGFeVJsVav9tdi1X2dJAZNdipGJF/b376m4pYKB9ALO3da8B21xjZood/+IR9s
         C1aTB8J1NaHa6jaBDK/YfWbRcVY/trybQW5mbu1EwVRRDJJxRJgpxBibfRNSV8ObOlmu
         c1es9dD1KixKcsfIYuUjBYgs3ENca4sGD3hCTOdf7soyV40uhWNeCdlawTIueWheIq/g
         WK62/y82UwDg8E33dCMwIpIq/fHFD9p4VYy2v0Nk4wcs9gdhAttPMB5Z3dLPjh3jmjSx
         6D78kLtYvImgGR9FViQvKONPz0yGF8NOTTUrS+XLh1DJAv4eKyqV8z80ALF+fEFhrNFF
         3UGQ==
X-Gm-Message-State: AOJu0YyVBZnNfoog5n0LYjpT4p7pQgyLQlx20Y1s/6EL2BPOy6/uCbR+
	0hak8OF6Ugialh4R3CZ0YDyfQW/PwBGF6nKyyXWC5lg5RqUAVVJgQeHGrxwg2+PDzGHXS5pNkIf
	W
X-Google-Smtp-Source: AGHT+IEv9jJxnc3Xpfxuz7TP32sCS/YhmSGUdljJDhweOby6hY4K5dzesAHTL6Qef5IN6Y61R+8eng==
X-Received: by 2002:a05:6902:1507:b0:e0b:cc1d:3731 with SMTP id 3f1490d57ef6-e0bde2d1938mr19123098276.2.1722958658378;
        Tue, 06 Aug 2024 08:37:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0be559f00fsm1838522276.57.2024.08.06.08.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 08:37:38 -0700 (PDT)
Date: Tue, 6 Aug 2024 11:37:36 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 09/19] midx: teach `nth_midxed_offset()` about incremental
 MIDXs
Message-ID: <761c7c59ba1a245732d86a4e1d6c24baf742a1cb.1722958596.git.me@ttaylorr.com>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1722958595.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1722958595.git.me@ttaylorr.com>

In a similar fashion as in previous commits, teach the function
`nth_midxed_offset()` about incremental MIDXs.

The given object `pos` is used to find the containing MIDX, and
translated back into a MIDX-local position by assigning the return value
of `midx_for_object()` to it.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/midx.c b/midx.c
index 83857cbd1e..346e58dec7 100644
--- a/midx.c
+++ b/midx.c
@@ -369,6 +369,8 @@ off_t nth_midxed_offset(struct multi_pack_index *m, uint32_t pos)
 	const unsigned char *offset_data;
 	uint32_t offset32;
 
+	pos = midx_for_object(&m, pos);
+
 	offset_data = m->chunk_object_offsets + (off_t)pos * MIDX_CHUNK_OFFSET_WIDTH;
 	offset32 = get_be32(offset_data + sizeof(uint32_t));
 
-- 
2.46.0.46.g406f326d27.dirty

