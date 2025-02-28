Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6385325D218
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 10:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736904; cv=none; b=rDrff0dQK9XQMY40l5nt5G4ui9vjeF0SH4tM6wdeQsU9jW3IrrbXRW5iD+BCXYcg03iY5DNJgM8ErKDnyLl/B+ioqPcfOvkup9cfr5VOQ/J9O1452apchAk9RC0HE8SwsOhh3EBcDQw39fvsgEH2dtWKCeoiX/Q6HM9HVHaGzbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736904; c=relaxed/simple;
	bh=EIV/e3ZdZ9wW2HA9XzlyYSYRp+Oa8r659u+inSC3qOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZfRkLHWEs/04KROZG4hXGGroVN93Z/Gpr/2XvrSN9gTRbCl4QGCM1/IQzLb8MhMcaOXGi5DiTAGchnH7Cu+e4pOHwvXN6jUQlm6YWLgL7tT/+tc2T0Yz1GDgGJ7oNAjsHYh+5/6UUz2RpRKTCgVmvqGyXxoRMcVgCi2aGVf+ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SrFq/kEN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xLQ4YMmW; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SrFq/kEN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xLQ4YMmW"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7441F11402A2;
	Fri, 28 Feb 2025 05:01:41 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 28 Feb 2025 05:01:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740736901; x=1740823301; bh=nh0C+s3469
	QyIwttMisMMrSDEjusCJLwhsXBeYmM3QU=; b=SrFq/kEN6s9KLIwAPUF9BoDxZ1
	bw3+b3uFiUiT8FaxJ+rx9nhIzyGS2lEEFK3GAFwK+OVgxe1yj8Q1M0JjoKxAAG9Y
	mCkvfVOmGflbnyvhSoIWKvcTc0iuD9IEp5cI9s5HbCkScV34RbtbBFfomnjWJlxV
	viYfCgniBkEbduGTOo2YvBi+ZJeUqNhigMtHSmHSwh3QQO5Rw92JgOZggN0/f5Hk
	JMLFXeM4x9tIfoG+4ECtGh4eUdj6px7eFPwrqzCwuMsXhCksqE9tN42/a+63I85+
	6uyiLqU5ZpcLZrhxO9JTKI4N5gVLGol+fH8mz+lQE0uGEtClZ2aau5mR5R6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740736901; x=1740823301; bh=nh0C+s3469QyIwttMisMMrSDEjusCJLwhsX
	BeYmM3QU=; b=xLQ4YMmW+UmA3vBoX8ltVMoYPHAlVI+F5dftoIkToZqkXrH12xu
	h0m/lc6bGwPOdYACNceOU+MgQziVEfUNx7SaHv0r0HmBM+IW0rJ8FJN4iMhKxNKv
	OVNOmRBGPURKtyQA6VsLMtxSyF1IiF3xk/JeavBVuYUR1Diov2kRqZTy0g/ngdtn
	VwAQcru+blP4vTrS9XNTF6ZBbuA5+qPimTr3jKsYETT96X2/7xubFcfpLe+MilZe
	LscclKSGDS1VRLnUZSlbPNm1r9KWI1ELZbzI9TGtqu+DBw7H8QpEFydVghGG3FOK
	orT8xlBJRuhxMGeZ4cXl/yGglwNDzMjUvkw==
X-ME-Sender: <xms:hYnBZ0RD-JlWGaj4xFwnnSuQjp8maBCcz8bsRp2Kh5AiVL7J4ZDDvA>
    <xme:hYnBZxzYyd2u9dNv2BUHYJcrnGbbZAStvkGoA0VNc4Xyr5FosEwgpsZ8_o0NkVCPv
    sF8zUpnRprUNGmZ4Q>
X-ME-Received: <xmr:hYnBZx2ESkAcRC06Q2oYJI1_DMU5dCYMeOliTedPrmqeA30EgFBNXBfqM1v7_O5EqnWF9BuNXpj4UZw2n3T6tFsnOGS6p-ASQJ99V-mz4AcYuzXe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:hYnBZ4C6C4gSPTf6YtIbBwnZ1PskIaH20dOUMXN9HYwP1nKWopXa5Q>
    <xmx:hYnBZ9gs0aC8oATpYCjksg67V3yR7nQ_B8UV4bDBga2Xwtn0NVp4xQ>
    <xmx:hYnBZ0rEYI8P1hOBofTvbCd8infcmTVZa4Rs6CcCOCibSUfaEjpvPA>
    <xmx:hYnBZwihY4-OtKyg1KSHYdkjPiONqz6gkahy6UwR3R-0RGKFORbD4Q>
    <xmx:hYnBZ7YjXlcf71EVYMKTxYIRnTPIgMshq7fRte6d2_9kpb4JQoDG2p5u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 05:01:40 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b93c4182 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Feb 2025 10:01:40 +0000 (UTC)
Date: Fri, 28 Feb 2025 11:01:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 13/13] midx: implement writing incremental MIDX bitmaps
Message-ID: <Z8GJg8TMeE8YLrqA@pks.im>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1732054032.git.me@ttaylorr.com>
 <77ddd1170f9178849b5dbfd9cd16a14ae96cfa87.1732054032.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77ddd1170f9178849b5dbfd9cd16a14ae96cfa87.1732054032.git.me@ttaylorr.com>

On Tue, Nov 19, 2024 at 05:07:56PM -0500, Taylor Blau wrote:
> diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
> index 49758e2525f..1fbebe84479 100644
> --- a/pack-bitmap-write.c
> +++ b/pack-bitmap-write.c
> @@ -25,6 +25,8 @@
>  #include "alloc.h"
>  #include "refs.h"
>  #include "strmap.h"
> +#include "midx.h"
> +#include "pack-revindex.h"

Nit: let's keep the headers sorted alphabetically.

> @@ -206,19 +215,37 @@ void bitmap_writer_push_commit(struct bitmap_writer *writer,
>  static uint32_t find_object_pos(struct bitmap_writer *writer,
>  				const struct object_id *oid, int *found)
>  {
> -	struct object_entry *entry = packlist_find(writer->to_pack, oid);
> +	struct object_entry *entry;
> +
> +	entry = packlist_find(writer->to_pack, oid);
> +	if (entry) {
> +		uint32_t base_objects = 0;
> +		if (writer->midx)
> +			base_objects = writer->midx->num_objects +
> +				writer->midx->num_objects_in_base;
> +
> +		if (found)
> +			*found = 1;
> +		return oe_in_pack_pos(writer->to_pack, entry) + base_objects;
> +	} else if (writer->midx) {
> +		uint32_t at, pos;
> +
> +		if (!bsearch_midx(oid, writer->midx, &at))
> +			goto missing;
> +		if (midx_to_pack_pos(writer->midx, at, &pos) < 0)
> +			goto missing;
>  
> -	if (!entry) {
>  		if (found)
> -			*found = 0;
> -		warning("Failed to write bitmap index. Packfile doesn't have full closure "
> -			"(object %s is missing)", oid_to_hex(oid));
> -		return 0;
> +			*found = 1;
> +		return pos;
>  	}
>  
> +missing:
>  	if (found)
> -		*found = 1;
> -	return oe_in_pack_pos(writer->to_pack, entry);
> +		*found = 0;
> +	warning("Failed to write bitmap index. Packfile doesn't have full closure "
> +		"(object %s is missing)", oid_to_hex(oid));

Is this warning still accurate? I assume that in the MIDX case we don't
have to have full closure in a single packfile, as that would otherwise
make the whole thing rather moot.

Patrick
