Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7448E257AEC
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 11:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946766; cv=none; b=VVO7QQJpi6YMorN08CKOBm18EOuxQU+kbiVIMtFajso6KQXmn1Rz0QMnjZG6/lG1PiqjRYATIzTaenm8TrmJipKibiw6OyQvNlXvT/G2PlRk9Ho5QWhep4xN6JMgykScDFMDmplV+L6Gc12jzbWQ8GBNlB6qiLAajpzfN4sMD9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946766; c=relaxed/simple;
	bh=vZG/fwXLsq2SFBcDRQnzTJZ5KZ+L7JiIRaZaIHX14fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wq1iZtb52XNm6atVOfrm85Pjpqy0IFRH5opuCyvbeJF+2JzX7J3TUCgsu4T30iDWdZpacggV/3YccKjXbYatdxkHJl6L0tatfBfAOzYX3/qxfWTn8cDp6s8R1nA9sKrh8Jcdxc1S7F/LljQAzLOAZiWgQBdzE2JSYG6PWS0wCbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bLk2Rbx1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WX+VFMAI; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bLk2Rbx1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WX+VFMAI"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 6ABFB1D00168;
	Wed, 12 Nov 2025 06:25:59 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 12 Nov 2025 06:25:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1762946759; x=1763033159; bh=1ciIKhuvgP
	QLkFOHxTVk1ApPamesNMLbVEArUsoGlT0=; b=bLk2Rbx1EABHrs6FjjchO8HbeQ
	MVpgGeE3PthE8rw+aUgGvM+g+hcc/STHGTsLpy8Lt+pehvcZNkWPx1kZmFCFX3nD
	EykK+jRpAo+WEIo5+zJ8PV3xRvJ2ruJrU/MPaj0NdRfHb02xi7sB5Ry1k5P1pSvQ
	Ey8PVcDfhLT1ZRcK2uxMox72QLr1/xpUEc8w3C4+bnzZE7WVzhBrPnz5a5E8sd0l
	2JeryTizTPDagJDgB+SQZGOSPCdiXUFQh89qls4DTg1qglp4pQbflftbipYVu6qM
	4zPsf5d9LK857MFVCXfAurKCXcAr5gOa4Tx+URN5CUAWi7SpuEnn9DE+EO7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762946759; x=1763033159; bh=1ciIKhuvgPQLkFOHxTVk1ApPamesNMLbVEA
	rUsoGlT0=; b=WX+VFMAIPQTTIay1V4NxGt5L0VwOJv1CvEOAMCD1h06/zCCKp3k
	6lcFvK9ASzG4kRM/o5jmkUmEmCNQBZJhs41lUBnNh3R0cRGwyUw2Wb71ibZrYiZw
	OEQP9kRjvZFFU+hfyGkQHo8bDEvXjTmXI/4TYLxpJ5sZdVX4KAnPD+pRaJK355B0
	6+ezJ6kWSdApg9hv6qoGg3DVoakYbpdf1Mf10c5a7hjy8cBgg6e21rmoVtLXbvk1
	HFvb/njl2pUqKZ3iJPh+NJGAdei5Xa9p0kNA0cnhroI/+RFc0qDViNbbfxYa6Y0q
	gUbeGd5F+RkL5rCj0o8bLUgJJJEn9ro1LJA==
X-ME-Sender: <xms:xm4UaY0PxYdAEjUmNwxNa_uLGamww9JQGgwX4k6iSLjwcM6MpAjuqA>
    <xme:xm4UaaENC9r1K0xEmDq3r3pIFh6sF0Yu9QRStf99JgazzaHqBACslUpD3mWBE0yeX
    Pn4oJYKLrYTlAVVNOeVg5DfOmllaSiAcKc558-Ivo7HoatctIZ5kQ>
X-ME-Received: <xmr:xm4UaV6BSWEAuM0hBVG10EqlaN6WWfh-KdrL1WddDK_TXL-EIfq0BqBaPJf7_dWPWfMGGOuRaeEuv4hWvRfWHsaoklm9oeYyZwCNVI6JivA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdefleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdortd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeejtddtgeffkedujeejgeduhefghedtgfdtie
    duleeulefgueetheeludegueeuveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegtmhhlihhsthhssehsvghnthdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:xm4UaQuXTha1J1lMyC_4_HwTVJYnupOLgaJ0xRpbycsJgEURCzKvpQ>
    <xmx:x24UaW5nj5ArlkkQbekp1D1P9R4cyROSDbdm0l7wEdtBT5Lf-yUplg>
    <xmx:x24UabUr-m8Yl5dIn33ONNELKqBQiZHe-wsdGbGACoitJhYJfNp7Sg>
    <xmx:x24UaY9NkDnrU_AUdfga8ezotdt9xsYhDWFP1HII7vqwaYVYhAQdCw>
    <xmx:x24UaRbJOk7HtkPQRSLso7JARow5tMJ_orEo8V_lp7i_wukv6Uvnhzep>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 06:25:58 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 08abe324 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 12 Nov 2025 11:25:56 +0000 (UTC)
Date: Wed, 12 Nov 2025 12:25:49 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, correctmost <cmlists@sent.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 2/9] pack-bitmap: handle name-hash lookups in incremental
 bitmaps
Message-ID: <aRRuvQmlDMBiZolK@pks.im>
References: <20251112075522.GA978866@coredump.intra.peff.net>
 <20251112080151.GB979063@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112080151.GB979063@coredump.intra.peff.net>

On Wed, Nov 12, 2025 at 03:01:51AM -0500, Jeff King wrote:
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 291e1a9cf4..710b86a451 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -213,6 +213,26 @@ static uint32_t bitmap_num_objects(struct bitmap_index *index)
>  	return index->pack->num_objects;
>  }
>  
> +static uint32_t bitmap_name_hash(struct bitmap_index *index, uint32_t pos)
> +{
> +	if (bitmap_is_midx(index)) {
> +		while (index && pos < index->midx->num_objects_in_base)
> +			index = index->base;

So we first find the MIDX that is supposed to contain the position.

> +		if (!index)
> +			BUG("NULL base bitmap for object position: %"PRIu32, pos);
> +
> +		pos -= index->midx->num_objects_in_base;

We then subtract the number of objects from all of our predeceding
layers from the position. This should result in the position relative to
the current layer.

> +		if (pos >= index->midx->num_objects)
> +			BUG("out-of-bounds midx bitmap object at %"PRIu32, pos);
> +	}
> +
> +	if (!index->hashes)
> +		return 0;
> +
> +	return get_be32(index->hashes + pos);

And we then return the value at that given position. Makes sense to me.

Patrick
