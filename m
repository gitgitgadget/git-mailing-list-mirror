Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6143B25CC75
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 10:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736876; cv=none; b=s+atLMe4FDtTksPymH0MxybWnS6cmSEyZ+TLdgyH5TazBQ/3erhoTh7dzACkmh8T346p3bzgCuEUQmmSk/qJBIAv3UHPQop8y4KLWAs4d6W/AdLh6wBUx41KVN8JFlV1D8rBln427Qea5PwqiEp/BTJfuQtyZghl+wWAUKeITJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736876; c=relaxed/simple;
	bh=/qXamN+nCTeOrWg5IlIHecxoFXEvdclulpPL6MWBKmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKCvdMFjqDlzVifTVigopjx4LAqb+/39510rkeq6YfrFEupFPvlpcxIwv56BUUyf80T/wJ0I+AoCiM59d40nSntdRJGDMRRjc/rKOKYp2295eUBjwnE860olmDOltQhWNELI9cw3UiMm0DME2iYoHJ4M8kPLEvl53GBtZ/ITchQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fmLCMiyf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=28sB5oh5; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fmLCMiyf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="28sB5oh5"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 31167138016A;
	Fri, 28 Feb 2025 05:01:13 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 28 Feb 2025 05:01:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740736873; x=1740823273; bh=NjpNZef1v5
	TK6KeTU0+4cLgCaoC4CcG1W3Wm85pO3Po=; b=fmLCMiyfBsvMiND9j67yKmHaJV
	cMczYRBFANiDXa90ztUJXH6Ncj/PkYsvIw0VXVx/hqLR0XR2Fal6W0XuOgoOirQM
	6smfUEsfVTmEjVN43/oimNrUYuXo7Ff/x4B9vXondwqhpx3Yy6ErMurYJH+wuyG7
	+XpMiK2R8E7wckjvApfbELr+gfxwduEU33N0HNc+Ct9h6/M+wy7U21Q9v0sopX4W
	0eMWiHzgd8nCgbe97uU+vs9+ZBpDvTEwCm7QE5tNzhMnvmDQg+fTOmZAZOkoeTVl
	yMo86SpxA24uFq3fCukg1giecycPq3VwqueXXjOQH2jCeXPTkUEjYpf1jxRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740736873; x=1740823273; bh=NjpNZef1v5TK6KeTU0+4cLgCaoC4CcG1W3W
	m85pO3Po=; b=28sB5oh5So79WBNcC7Jwc+O7BWw3ZpmWzXkx+X4uNIVlR7bQ5XM
	tOiDoA0+PkeBvmQsIwo2RbDfaw3AGtt8mzeiB4OaPifA/3+gpJzUtSoyI5DtR5F6
	IYc+oCFvI0EeM6kMMWBQEAkFVoALpqP+zhZrjVfrhSRy6lLU9LoKKqf+TPori2QN
	qO29AL5PRyIjgd73+OSByGPgh8I0kxfY5tgpZRsXFezXYjs5TPsb4uQnI+i150DY
	knc1RkjHXeCZjNIJoPM6oqgly0wW4uWfdFRvEOF81ghPH+FjoyOnjLQpCoCVFRrn
	y734HnSp9WCPVVECcaPZTmdGJipN60CUe3w==
X-ME-Sender: <xms:aInBZwPFZ90W6___rUJ0Ht8XbYej0H2Eh6unI-HgJQ3gfIyq-KozIA>
    <xme:aInBZ2-w6QBHGjfv4-hTDLd4V0oHgikJ55OMAIu_YgeAq7zun-33jUNiu_Cl2RRrc
    xg9uqg4wNeTXPioEw>
X-ME-Received: <xmr:aInBZ3QxuDeFMS0qaN3mglGGhZa4ov_cpxEaH8zjIfVEU1AvDV12G1FT-88mAdrsFLJrSTaVA5B1DYqLx54yFTNWdVebhO1SRqAXVYFye0Cyj7-F>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhm
    rghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:aInBZ4uyrqm7bJI5qaVc8Umfw5-tu3Sm7mWt5kU6QoMSj9IWZUDkEg>
    <xmx:aInBZ4erMpIAolf8QZHoEw0LmK0YEGsIcsFk3D3Q_LKYPA-HLD9HuQ>
    <xmx:aInBZ83uCHn-ZsDZTx6V1RNuoBmIzWhyxdnJdRuFJHaO_V9PyAcTGw>
    <xmx:aInBZ89s8-wovDjGrknyHLANdxzMglbk6oUvpSa4OnuOtSIUItndHA>
    <xmx:aYnBZ9GNgNtMm2F7ofv012NGjM9J3qQ94xP4XM1RpE0AISJIQDSGligp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 05:01:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 07e8bc71 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Feb 2025 10:01:09 +0000 (UTC)
Date: Fri, 28 Feb 2025 11:01:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 01/13] Documentation: describe incremental MIDX bitmaps
Message-ID: <Z8GJYMbXMZqI5fUL@pks.im>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1732054032.git.me@ttaylorr.com>
 <caed2c6ec3483f028f59777bba40480e2661ca80.1732054032.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caed2c6ec3483f028f59777bba40480e2661ca80.1732054032.git.me@ttaylorr.com>

On Tue, Nov 19, 2024 at 05:07:19PM -0500, Taylor Blau wrote:
> diff --git a/Documentation/technical/multi-pack-index.txt b/Documentation/technical/multi-pack-index.txt
> index cc063b30bea..a063262c360 100644
> --- a/Documentation/technical/multi-pack-index.txt
> +++ b/Documentation/technical/multi-pack-index.txt
> @@ -164,6 +164,70 @@ objects_nr($H2) + objects_nr($H1) + i
>  (in the C implementation, this is often computed as `i +
>  m->num_objects_in_base`).
>  
> +=== Pseudo-pack order for incremental MIDXs
> +
> +The original implementation of multi-pack reachability bitmaps defined
> +the pseudo-pack order in linkgit:gitformat-pack[5] (see the section
> +titled "multi-pack-index reverse indexes") roughly as follows:
> +
> +____
> +In short, a MIDX's pseudo-pack is the de-duplicated concatenation of
> +objects in packs stored by the MIDX, laid out in pack order, and the
> +packs arranged in MIDX order (with the preferred pack coming first).
> +____
> +
> +In the incremental MIDX design, we extend this definition to include
> +objects from multiple layers of the MIDX chain. The pseudo-pack order
> +for incremental MIDXs is determined by concatenating the pseudo-pack
> +ordering for each layer of the MIDX chain in order. Formally two objects
> +`o1` and `o2` are compared as follows:
> +
> +1. If `o1` appears in an earlier layer of the MIDX chain than `o2`, then
> +  `o1` is considered less than `o2`.

Just as a refresher for myself: what is the consequence of an object
`o1` sorting earlier than `o2`? In the case where those refer to
different objects it is only used to establish the pseudo-pack order so
that we know how to interpret the bitmaps. But in the case where those
two objects refer to the same underlying object, e.g. because the object
is contained in two packs, it also impacts which of both objects would
be preferred e.g. during a clone, right?

> +2. Otherwise, if `o1` and `o2` appear in the same MIDX layer, and that
> +  MIDX layer has no base, then If one of `pack(o1)` and `pack(o2)` is

s/If/if

> +  preferred and the other is not, then the preferred one sorts first. If
> +  there is a base layer (i.e. the MIDX layer is not the first layer in
> +  the chain), then if `pack(o1)` appears earlier in that MIDX layer's
> +  pack order, than `o1` is less than `o2`. Likewise if `pack(o2)`
> +  appears earlier, than the opposite is true.

Another question for my own understanding: why is it relevant whether we
have a base or not? I would have expected that the case where the
objects appear in two different layers is already covered by (1), so
from thereon we only need to care about two objects existing in the same
layer.

> +3. Otherwise, `o1` and `o2` appear in the same pack, and thus in the
> +  same MIDX layer. Sort `o1` and `o2` by their offset within their
> +  containing packfile.
> +
> +=== Reachability bitmaps and incremental MIDXs
> +
> +Each layer of an incremental MIDX chain may have its objects (and the
> +objects from any previous layer in the same MIDX chain) represented in
> +its own `*.bitmap` file.
> +
> +The structure of a `*.bitmap` file belonging to an incremental MIDX
> +chain is identical to that of a non-incremental MIDX bitmap, or a
> +classic single-pack bitmap. Since objects are added to the end of the
> +incremental MIDX's pseudo-pack order (see: above), it is possible to
> +extend a bitmap when appending to the end of a MIDX chain.
> +
> +(Note: it is possible likewise to compress a contiguous sequence of MIDX
> +incremental layers, and their `*.bitmap`(s) into a single layer and
> +`*.bitmap`, but this is not yet implemented.)

Fair. What do we currently do in this context? Do we just keep on
appending layer after layer?

Patrick
