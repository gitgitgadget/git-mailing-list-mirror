Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768FE1D0F68
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 22:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732054044; cv=none; b=qcK54V4EtvBVH8wJEEy7xUrnqyLbX8lw8bzNswwHr3BLFaFz57R3pqH+gKCTLHJ0kFp3PLZ4G9YIDl59mvU4CSKRpZFFNKCeWEiel8CzbMRtpKGojk8USgubmSXIl0U5jPmmonsMikOOu/0sgq9nd0VxxhqiSegcJzEHce1fVqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732054044; c=relaxed/simple;
	bh=UEPOt8SI+fidERGPsEtZZPsGHiDlZF6K6CLJrhvoiDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PbI/wl5xUgEzcCWiRqZagPKrk7VwBcmzxZ2HqJ/+4/3A3jU/6cyYydsQED4Ro3Ckn4lz5b8OEABgchkykCChVoXCfgFbllptWzPuRTFPj/dO7bJyn7qYmAJtcGmzUBhe4j/EDRZPPkGjGpxbjiAR7vrQgsTIh0hhIVMizKYVSNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=vkN4kbis; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="vkN4kbis"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e388503c0d7so1417177276.0
        for <git@vger.kernel.org>; Tue, 19 Nov 2024 14:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732054041; x=1732658841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r9JR2dz5YDSDl9TuDi/yTY9jlMWySNJbK5ywQsdWG2s=;
        b=vkN4kbis40LBFmyWrdRoL4sNByVB+DXydiSWsG9jyNM/nquJWfwIM5sKiMKJHhFJf5
         eiAOkX/wCPJnqNlECmVrvKBz17N0nuEf47j8TjpmjIHknjG8amHMu3I2Lrw/XHkHicVA
         L8Nfe1OwadVmyXgaSD0RUojFgrGuNINOLnzIC/C/VXPe4eehE9Zpd6aAfFML45R0ppLo
         XC7UINyhOW1UxRrMbn6KC2x2s55IiC8y1cNPTOXl+Idyuvt0mFxwbCWAGSOrPagCHr4U
         ueGcCRYknOIZBNPx/uj0UAJSM+M77xSGrEY/8N7v+Uz0WsqTAQj2qG+EAfOFQ5VIulrQ
         fFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732054041; x=1732658841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9JR2dz5YDSDl9TuDi/yTY9jlMWySNJbK5ywQsdWG2s=;
        b=wFk2pGCnXObD67XrvnJNR8C/09JQMX1yO5BWpBV2wX2C+GurT0eg7KUrZ2FxlE9PwZ
         uoKXy1nSWevSCniAxs2W43I4k7nSpcN+5jYSDZbTsufb5PBxL1ss7/izYIn6W2jGikuI
         BvvgG2ZHPhU+e+SJZKAKULmXtiZ1r1pE+CNbS/asK6O/6cUxo+BIA/Wr3bCGxps6bhs2
         juV80omsQKdxEYtU7kZVoWzmsUlfFBoFF7JE9Zzx64v7aqMzwyhBeYKP5ZWE2LKatz5J
         NdqgG1A/ms+fJdHxcUry5+7zBo2p39Si+npUmDL4ROY5yNhVzIt17kl44vqH0tp6VJse
         XeWA==
X-Gm-Message-State: AOJu0Yw4KfsolnfkqtR5vYioW8mWLjsb8ptxnx+lDkaRudesWwCmUOU1
	oAZNB53dhVK45aX51xNXgqnsWNVZLkGFT7FJ1msY1OMW8/3ytP26azYXe9lbEMaI4VlMjjhlzH/
	eDbY=
X-Google-Smtp-Source: AGHT+IGBsEOatw/Q5owUkJ2P/ktANI8uPWpCGU/qNhK3o/chnbxwV+bKChQDewpMpQSIAXCiIboAeA==
X-Received: by 2002:a05:6902:3001:b0:e38:b2ce:992 with SMTP id 3f1490d57ef6-e38cb573f11mr358152276.21.1732054041157;
        Tue, 19 Nov 2024 14:07:21 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e387e763c98sm2725314276.28.2024.11.19.14.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 14:07:20 -0800 (PST)
Date: Tue, 19 Nov 2024 17:07:19 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 01/13] Documentation: describe incremental MIDX bitmaps
Message-ID: <caed2c6ec3483f028f59777bba40480e2661ca80.1732054032.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1732054032.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1732054032.git.me@ttaylorr.com>

Prepare to implement support for reachability bitmaps for the new
incremental multi-pack index (MIDX) feature over the following commits.

This commit begins by first describing the relevant format and usage
details for incremental MIDX bitmaps.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/technical/multi-pack-index.txt | 64 ++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/Documentation/technical/multi-pack-index.txt b/Documentation/technical/multi-pack-index.txt
index cc063b30bea..a063262c360 100644
--- a/Documentation/technical/multi-pack-index.txt
+++ b/Documentation/technical/multi-pack-index.txt
@@ -164,6 +164,70 @@ objects_nr($H2) + objects_nr($H1) + i
 (in the C implementation, this is often computed as `i +
 m->num_objects_in_base`).
 
+=== Pseudo-pack order for incremental MIDXs
+
+The original implementation of multi-pack reachability bitmaps defined
+the pseudo-pack order in linkgit:gitformat-pack[5] (see the section
+titled "multi-pack-index reverse indexes") roughly as follows:
+
+____
+In short, a MIDX's pseudo-pack is the de-duplicated concatenation of
+objects in packs stored by the MIDX, laid out in pack order, and the
+packs arranged in MIDX order (with the preferred pack coming first).
+____
+
+In the incremental MIDX design, we extend this definition to include
+objects from multiple layers of the MIDX chain. The pseudo-pack order
+for incremental MIDXs is determined by concatenating the pseudo-pack
+ordering for each layer of the MIDX chain in order. Formally two objects
+`o1` and `o2` are compared as follows:
+
+1. If `o1` appears in an earlier layer of the MIDX chain than `o2`, then
+  `o1` is considered less than `o2`.
+2. Otherwise, if `o1` and `o2` appear in the same MIDX layer, and that
+  MIDX layer has no base, then If one of `pack(o1)` and `pack(o2)` is
+  preferred and the other is not, then the preferred one sorts first. If
+  there is a base layer (i.e. the MIDX layer is not the first layer in
+  the chain), then if `pack(o1)` appears earlier in that MIDX layer's
+  pack order, than `o1` is less than `o2`. Likewise if `pack(o2)`
+  appears earlier, than the opposite is true.
+3. Otherwise, `o1` and `o2` appear in the same pack, and thus in the
+  same MIDX layer. Sort `o1` and `o2` by their offset within their
+  containing packfile.
+
+=== Reachability bitmaps and incremental MIDXs
+
+Each layer of an incremental MIDX chain may have its objects (and the
+objects from any previous layer in the same MIDX chain) represented in
+its own `*.bitmap` file.
+
+The structure of a `*.bitmap` file belonging to an incremental MIDX
+chain is identical to that of a non-incremental MIDX bitmap, or a
+classic single-pack bitmap. Since objects are added to the end of the
+incremental MIDX's pseudo-pack order (see: above), it is possible to
+extend a bitmap when appending to the end of a MIDX chain.
+
+(Note: it is possible likewise to compress a contiguous sequence of MIDX
+incremental layers, and their `*.bitmap`(s) into a single layer and
+`*.bitmap`, but this is not yet implemented.)
+
+The object positions used are global within the pseudo-pack order, so
+subsequent layers will have, for example, `m->num_objects_in_base`
+number of `0` bits in each of their four type bitmaps. This follows from
+the fact that we only write type bitmap entries for objects present in
+the layer immediately corresponding to the bitmap).
+
+Note also that only the bitmap pertaining to the most recent layer in an
+incremental MIDX chain is used to store reachability information about
+the interesting and uninteresting objects in a reachability query.
+Earlier bitmap layers are only used to look up commit and pseudo-merge
+bitmaps from that layer, as well as the type-level bitmaps for objects
+in that layer.
+
+To simplify the implementation, type-level bitmaps are iterated
+simultaneously, and their results are OR'd together to avoid recursively
+calling internal bitmap functions.
+
 Future Work
 -----------
 
-- 
2.47.0.301.g77ddd1170f9

