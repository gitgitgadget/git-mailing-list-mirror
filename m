Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC121C5D57
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 08:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766047825; cv=none; b=JbmeuD7RecKzB1YSRZ5KjVTsvJT/84M65OphpJ+EBM1q0qyBddZd+ToiQid5nyreN6HgQZij68zlQZxPMeHXeQ9VC5SixH4iNMTV8gFyJyr9BzcZITV/uqoTj28RzPvjIs6gZ8sGvvUSZfBiMPyTO+altAqabQ+LCJm+bLVWn+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766047825; c=relaxed/simple;
	bh=WstoFjctuwhdhytEmwd3ZYk/+j9BhvxC5eA5zz+TaRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9N8pcSrdZMpY4Se+9S9NGFGpvonhIEUj0h/orkW9fnXPK3HTz1TJ1IudfzXvMEAM1OyhU68FLnpEctXRFBL1bwx0IH2bg6An0r1Kr1P0wyW57YYT5mELZFUO75aH3zv+e+Diip70hQdEqQ8tQPwGYHVpHzArJybhAKuzaJ67TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aVNJPJ0T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KgH+LYS9; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aVNJPJ0T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KgH+LYS9"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id DC0A21D000B7;
	Thu, 18 Dec 2025 03:50:22 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 18 Dec 2025 03:50:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1766047822; x=1766134222; bh=+ZsaUs+hTy
	vz5OhGTZev7KHLciqfB//EyQ81qcHD99A=; b=aVNJPJ0T1TJjqqiz9120cJxcmZ
	Dl2binZG+BCpLnHh2Adnot0eUxbYnuFLh7wFJmGxZracoqmKxjHlp3VqxmY3KRA8
	bXHMBZmuvMjjJjZ+ZNQsfKI2RAd7veysBqgy2d7tS4b0F1UxdEW0vyhZo8LBRRw2
	jRgZgq5HpYTUqv8cZC53M0E7o8xofjvH7RdgGDpf140h1Y8IrBfdq7pC0ONXuBju
	6/nPmc44xYe24ACaae1L78MqhofF0eMPrgGYJzAjEHT0jrEivgyBBSejk9Wu1BfD
	yJIQ/svrGLhgnavJq8rnApdiLUiec3as5emWx2eQFcPwfKB1obQGf2ln7E3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766047822; x=1766134222; bh=+ZsaUs+hTyvz5OhGTZev7KHLciqfB//EyQ8
	1qcHD99A=; b=KgH+LYS90YXAcKFPATdPf9ZAnAlTp2g4Utg8cwVpTjXsnSnZ4sC
	FP5YqTGSyFYx0APJDQnTObrSp1GdmU4aooD15FCz75WnSkgYsD319jqVbHxEG723
	oIT8Hw78f9+pyzVT447cipfBqXWcfQqh7IFvansPxQrvPvcWwaXoD+pcKLaxLan1
	kBfLdEo7oFlb+zwzFZFQXk+0VHQJtAOJwMPbXXjPhO0dH/s/XwoNC3cP7jPJ10qw
	M5s65aLYYFEZEfYCkzPFVgKkGY8eI4iVn/MoG1g6ojOQgVIBm54kl2P/KmIONSTP
	eL+bbTfLWA1bJnizNSVJ4oD2ORG4iiUl2wA==
X-ME-Sender: <xms:TsBDaYUEIuNJLdnazk6n4osW0PcWZ4IU4WzoB7yjEJ-sFRq-W4QuOg>
    <xme:TsBDaUBi-Xc_drXGzArhE_3UHk9g-mGZXsWrxDYtshzVbZNAZVIKXY6_NDu2J-Zag
    Ph_Xyi2ZLq6jWESES1E-Laau7J0O4mVCuSKn_AsJDG55XxUXCoWjA>
X-ME-Received: <xmr:TsBDaZxd8mpe_JKSXLsdyKJfEsDHee8-3Q5T0GebArXDHofg56LA_HqlrlRCemKGVO150ADgZ1rqX0tPGbSFZSmOd5-fUW_ti3PN0qnEpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeggeellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ejtddtgeffkedujeejgeduhefghedtgfdtieduleeulefgueetheeludegueeuveenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghplhgrthhtnh
    gvrhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:TsBDaRCH5sW-BHR9ObsEOlqjK-rbO5X8_1bDbHg9hKCv0S2C28-94Q>
    <xmx:TsBDaWZdoS1210xSwImmycT6Hr-V8orUBT9jMQ2JWX_pOPxbauuiew>
    <xmx:TsBDaZjpNwC6rmpgArxPcoeFaSVX3UeVTNb4DZ6bRu8VpMcQYMRiQg>
    <xmx:TsBDaY4PoOmnCq7wADH-G7sRZEIxhNRSE91mYXg7MTlYbWq10_mW9g>
    <xmx:TsBDaQrAH4AJ9HTQaRkN2d3GTKM6JnWEbDEOumDXOTzg8MZnkz8ng0ws>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 03:50:21 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cc8a93db (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Dec 2025 08:50:20 +0000 (UTC)
Date: Thu, 18 Dec 2025 09:50:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Aaron Plattner <aplattner@nvidia.com>
Subject: Re: [PATCH] odb: do not use "blank" substitute for NULL
Message-ID: <aUPASOMyxIJjYwTj@pks.im>
References: <xmqqpl8cxy0j.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpl8cxy0j.fsf@gitster.g>

On Thu, Dec 18, 2025 at 12:35:40PM +0900, Junio C Hamano wrote:
> diff --git a/object-file.c b/object-file.c
> index 12177a7dd7..e0cce3a62a 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -426,7 +426,7 @@ int odb_source_loose_read_object_info(struct odb_source *source,
>  	unsigned long size_scratch;
>  	enum object_type type_scratch;
>  
> -	if (oi->delta_base_oid)
> +	if (oi && oi->delta_base_oid)
>  		oidclr(oi->delta_base_oid, source->odb->repo->hash_algo);
>  
>  	/*
> @@ -437,13 +437,13 @@ int odb_source_loose_read_object_info(struct odb_source *source,
>  	 * return value implicitly indicates whether the
>  	 * object even exists.
>  	 */
> -	if (!oi->typep && !oi->sizep && !oi->contentp) {
> +	if (!oi || (!oi->typep && !oi->sizep && !oi->contentp)) {
>  		struct stat st;
> -		if (!oi->disk_sizep && (flags & OBJECT_INFO_QUICK))
> +		if ((!oi || !oi->disk_sizep) && (flags & OBJECT_INFO_QUICK))
>  			return quick_has_loose(source->loose, oid) ? 0 : -1;
>  		if (stat_loose_object(source->loose, oid, &st, &path) < 0)
>  			return -1;
> -		if (oi->disk_sizep)
> +		if (oi && oi->disk_sizep)
>  			*oi->disk_sizep = st.st_size;
>  		return 0;
>  	}

Okay, here we know to exit early in case `oi == NULL`. So any subsequent
code can assume that `oi` is non-NULL. Good.

> diff --git a/odb.c b/odb.c
> index f4cbee4b04..85dc21b104 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -664,34 +664,31 @@ static int do_oid_object_info_extended(struct object_database *odb,
>  				       const struct object_id *oid,
>  				       struct object_info *oi, unsigned flags)
>  {
> -	static struct object_info blank_oi = OBJECT_INFO_INIT;
>  	const struct cached_object *co;
>  	const struct object_id *real = oid;
>  	int already_retried = 0;
>  
> -
>  	if (flags & OBJECT_INFO_LOOKUP_REPLACE)
>  		real = lookup_replace_object(odb->repo, oid);
>  
>  	if (is_null_oid(real))
>  		return -1;
>  
> -	if (!oi)
> -		oi = &blank_oi;
> -
>  	co = find_cached_object(odb, real);
>  	if (co) {
> -		if (oi->typep)
> -			*(oi->typep) = co->type;
> -		if (oi->sizep)
> -			*(oi->sizep) = co->size;
> -		if (oi->disk_sizep)
> -			*(oi->disk_sizep) = 0;
> -		if (oi->delta_base_oid)
> -			oidclr(oi->delta_base_oid, odb->repo->hash_algo);
> -		if (oi->contentp)
> -			*oi->contentp = xmemdupz(co->buf, co->size);
> -		oi->whence = OI_CACHED;
> +		if (oi) {
> +			if (oi->typep)
> +				*(oi->typep) = co->type;
> +			if (oi->sizep)
> +				*(oi->sizep) = co->size;
> +			if (oi->disk_sizep)
> +				*(oi->disk_sizep) = 0;
> +			if (oi->delta_base_oid)
> +				oidclr(oi->delta_base_oid, odb->repo->hash_algo);
> +			if (oi->contentp)
> +				*oi->contentp = xmemdupz(co->buf, co->size);
> +			oi->whence = OI_CACHED;
> +		}
>  		return 0;
>  	}

Looks reasonable. We pass down `oi` to both the loose backend and the
packfile store, but you teach both of them to handle this alright.

> diff --git a/packfile.c b/packfile.c
> index 7a16aaa90d..2aa6135c3a 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -2106,7 +2105,7 @@ int packfile_store_read_object_info(struct packfile_store *store,
>  	 * We know that the caller doesn't actually need the
>  	 * information below, so return early.
>  	 */
> -	if (oi == &blank_oi)
> +	if (!oi)
>  		return 0;

And this here is fixing the actual performance regression.

All of this looks as expected to me, so let's merge this patch down
fastish. I'll rebase my bigger patch series at [1] on top of your patch.

Thanks!

Patrick

[1]: <20251218-b4-pks-odb-read-object-info-improvements-v1-0-81c8368492be@pks.im>
