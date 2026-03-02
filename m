Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F194941324C
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 16:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772467818; cv=none; b=B3Zt7+3WrqsA6pLuJtr+xarDJPXPGeH3VRqH6nLGUtggaW52kiPqt+UH8xaM8E3o68RSVM8KEgxtjnoqmYyc/DNf19pBy5waoNZK7bavzZG0jPc+IjrSq7mU5KTER6VAR9MXg3Dmw1YuSsLj6cUqbz33RVb4wOAylrzMjPU+D+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772467818; c=relaxed/simple;
	bh=jKMCcbPf+ZnYcPAUvGVCiegb2J1txfwMBfGGSYfT+14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCBQhAAvgTeeoIxvqkbty5LSnqMxzXHsWtp0TuFK4U0E1pXFEpxLjfR8PSt3dqK1ul1wnTER1pNJALhjMpXEaTmuNkHyF3oI8ECnKAaQ5W29CI4GVPNKH68DbO2MGashVlcsrcwGNcpDH57sZz7ED2BbiXitisRct5knky8cMe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+rTbPpc; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+rTbPpc"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48336a6e932so29157865e9.3
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 08:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772467815; x=1773072615; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L45csCIdgk+pONsGWqywJCvf1w9HGgY8wwhSLSgRFv8=;
        b=f+rTbPpc5tYVv+C+GAXejW2r6WVA6VAoBjTFxOnJ5i2MbQ6c7quylsoyey0gd05lOJ
         5rwG436WM3VdLOgQUIS4z1O5pJWi/A67QjsjaZFzIysfNw2P6kFFOqGnuSCkUEs8B0vH
         sKWKb7bVBpTYfqFxD62yXvjc0JnTCLTUZyys8wgRm3Y63RTPmqAIXLmQ/8WBa0Y/H/wq
         zCys3964tkBN8hLArph7BlJZZj0qYjYUUERGeNKjb/nU83FDYdOnCdAH89jh9i8+R5qu
         +83AydmVIeTJ+1jSY133IBZAxIHOANpQotj6bJaduadfCJR0X13iGCOgthOpK0xbI+7o
         rv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772467815; x=1773072615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L45csCIdgk+pONsGWqywJCvf1w9HGgY8wwhSLSgRFv8=;
        b=LIHlg1zniwqfO45IVLzNTX+8v8UjDvDpVomPiFFN8pzCdVkKnHKcwLOU+EJxsgUdzf
         1pvjE39X4T0lGPKNLQWokQkd1jmzZNOxqNwLTZaxBYCYdzeb0cqDKXK7ttRbnz+7GG8/
         5fpv+cVrdDnS4K2yE1YP1zxPTyuxMe9mwQEftAQk1wwyf3S2CdgizG0KbW52N3G9NFrt
         +Lcs5i+45da5Rxl0QcIIXF5ncVRILHUi6touBRfz6I82hJfCavyL3Y/BsXpOE3mLcnYx
         /J4mcYN8Ew0lJA3fNSbl9kcvvJQM3udUiEFZBqWTbsfMTdU/l0kHOVZSi3Fudjg/Shri
         ooJg==
X-Gm-Message-State: AOJu0Yw/HqFInTFWykn3s+kwuVmvX/wm7xWhDO/aVaQOpnTDSXft9Uwe
	1JaTAjVwkzhalnK5yv4VyPxGq7OTAeW5xXraewyVP2GnGjJMLHq56W5lRZDryw==
X-Gm-Gg: ATEYQzwjyXn2agIjO6V9SF+xVrpQaGHSsdpaExa1ysUbx8O1O2d3n4+wLNBYsJ3YU40
	J62KJGu2PEORLYO1BptO3n1L2JeHdg3V7gPLX4VhUyimoxg+zF6/yKhYVnoLVx9AxM6yorXy9Vv
	JaEJrUKXEiR3Aifoq3rbOEISFo5jBbBtI0SPEgBd9T5AdWJN/y/dfcY8YPz/P2Es9TCuVyF5oP4
	vK2qFUPkasA980ZidLZ/DBlo2vdxZvsAsdEwyi7eg+BWs4Mgjz4mlcsEbdvgbaf4yx/14wgJMRH
	MRGeI/ItXvnTbPNFnG7FQvU2dhh6MWlnCHIyeRqVC1Bn9gRVM8OCI7my1AyItckr2Z8UybilKzz
	h0e0mhNEB4OqU0TQrDbfzS8RmHtcdDlU7d/YpBiqsjGmgf3AmAgB+D4pUZwETkajQ+hzyklfwSE
	eTv1sXtHAv1zq/CWImTtte+SKVgUcsWO8+K1M=
X-Received: by 2002:a05:600c:8106:b0:483:badb:618e with SMTP id 5b1f17b1804b1-483c9b9e39dmr207994525e9.8.1772467814884;
        Mon, 02 Mar 2026 08:10:14 -0800 (PST)
Received: from lorenzo-VM ([84.33.161.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd750607sm417618875e9.10.2026.03.02.08.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 08:10:14 -0800 (PST)
Date: Mon, 2 Mar 2026 17:10:12 +0100
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [GSoC PATCH 1/3] doc: gitprotocol-pack: fix pronoun-antecedent
 agreement
Message-ID: <0d679e5eb514f33aed92f7fba4843efc53e6c461.1772467050.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1772467050.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1772467050.git.lorenzo.pegorari2002@gmail.com>

Fix "pronoun-antecedent agreement" errors.

Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
---
 Documentation/gitprotocol-pack.adoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitprotocol-pack.adoc b/Documentation/gitprotocol-pack.adoc
index 837b691c89..9952fac188 100644
--- a/Documentation/gitprotocol-pack.adoc
+++ b/Documentation/gitprotocol-pack.adoc
@@ -65,7 +65,7 @@ Extra Parameters
 ----------------
 
 The protocol provides a mechanism in which clients can send additional
-information in its first message to the server. These are called "Extra
+information in their first message to the server. These are called "Extra
 Parameters", and are supported by the Git, SSH, and HTTP protocols.
 
 Each Extra Parameter takes the form of `<key>=<value>` or `<key>`.
@@ -277,7 +277,7 @@ out of what the server said it could do with the first 'want' line.
   filter-request    =  PKT-LINE("filter" SP filter-spec)
 ----
 
-Clients MUST send all the obj-ids it wants from the reference
+Clients MUST send all the obj-ids they want from the reference
 discovery phase as 'want' lines. Clients MUST send at least one
 'want' command in the request body. Clients MUST NOT mention an
 obj-id in a 'want' command which did not appear in the response
-- 
2.43.0

