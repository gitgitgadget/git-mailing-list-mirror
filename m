Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EED13AF2
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 21:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768426091; cv=none; b=JQecg6/Z4MArSOgeY4DzesZ3wQncYpWzuFpNE8wxHuOu6p/9Ft9SbIe+4k/Ct+xp/AMbjfCgqLzxrVs86ZMdbPvy9CRx044NfBa2NtOlREAixq5hKTdknsJ0toxrBBd4PnWdbu8j18Hkax/W8eTEc9LwOAHLsc89YtLt66Kn46E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768426091; c=relaxed/simple;
	bh=GIWe+sJocyZpSGAxx7lIQMfjLmI5F95Ou809mUu0VFA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eB/pIXztZrJKOWg2jlFzbRPCVNUvLajv6n/9anaZ2HboV5vdlIvVpPjA+mWTDl/FHhPaOSkPpBKbwPS+KdULfqE7a2xZs5jLKZqwSx/y6Qx8qIRypmV9T6IeC/VpSvllbVA/eeQAEP0ErluMTXF0MGOU/LXXHUva0dCPHdBAHyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=f2Hgb5Nv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gh/GqeSt; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="f2Hgb5Nv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gh/GqeSt"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7710B7A0099;
	Wed, 14 Jan 2026 16:28:09 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 14 Jan 2026 16:28:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768426089; x=1768512489; bh=YfGbkxEbPM
	rMD00B4VJNhOoZFh1YP4BB3RbQpEcFDeM=; b=f2Hgb5NvPg+xo6wFTMQi1e2TrK
	Sbk9lhVkRqzfaaYXQZFdxje0FXWNkUvoZVepEnSpu5NzwYW1x1miY7Y0WK/b2mB7
	1yqXPlzTRX0vTY/f4yGNgpGp6Afue4clBpz7Y4LeEUnXvAIukrbcKWeoJ2y2zttz
	6glocVWlJR0hMeaRz54oyUh4V044NrYY66gij6paYifYKr0+YYBH2SV+VrwzRA+1
	rIMLIlnxCjCf9TrS2yHA+kGeZIDKHPip2HmYyggfh36x3cf5HZ/snCfn1u97Pt4C
	YEhDRjuFBAm4CToeA8L4hav7/kMJPHh/BvakhOhkh50B20SlCoVw06p1S3Hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768426089; x=1768512489; bh=YfGbkxEbPMrMD00B4VJNhOoZFh1YP4BB3Rb
	QpEcFDeM=; b=Gh/GqeSt4ZJ1/r6nz2Qc0/ecfcRxLlgbjg/mBHqYPWwcEPq7jig
	1r9t9UAKGQ3Id39QICTXgdGb0t199qxMGUNBMCIx3gWtwX85bN0OTsBMsNu43m4/
	9/ysA9qcDgnnFuxWvOq2JyAiuPzA1aQEXomxgGcGE1ACoQrO9IsJZUv3KG7uKSvk
	otNQdR/9UkGLECzZnTtObYWJXHGhyN1Nb++NU8Dg4j6nc+aSA/5uJna3bwRutkF4
	YDRiMbcP47+o0D/P6dvR4lKpJIErDIG5TvMjeFUYpDrHo4oSxRHCVgXOAHkixuw5
	VGdeNBvZy6f7d5B55K9A0zuaBZVxG0gb7kQ==
X-ME-Sender: <xms:aApoaURZzu6xyH0MGBCXT4gKDvbhlaf630lCaqTsPfKAYLgghkYYKw>
    <xme:aApoaVdbMEzkBlsvswxUyCiKv792mCiJXviD4ltNzV3OnSsdsveQioPzp_PTLEbGQ
    MRCA0VW3GK_IcfVaMuKoLfqJ22AYqYVS6L1iQpF3j_DaaxGay0Xbg>
X-ME-Received: <xmr:aApoabpontH8_4VgBx329o-SGNGl8Do3hxyvF4zGI09FCCEKqHt1oPsOJ4mnfSjYzzEERndmTMESh-R2Z3lpq_h7B8AIN9mNb7twiQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdegvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:aApoae8i703jL3eGWMTFYu8FCNNt8n1w-DXzhuLSvd5EbAm3NCVK5A>
    <xmx:aApoafdo_uQ1wb8jvSyKSeq8GkbFbcByOp0Il1mVA7RY7C6znyL6HA>
    <xmx:aApoaQK6hJcVkv1clrdM-pnDTEtQq5pL0eR0REXUEJGuUZz5O7HJmQ>
    <xmx:aApoaXh1gQbfmfuXrRGZRzB7GQNtSEPsCpUa7-zfUP_EIgquwccwHQ>
    <xmx:aQpoae1H2kMUGGGwbpRITy2BB9NFxIX5GL61yqjEXBdSJBHWwwv-9ot0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Jan 2026 16:28:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 10/18] midx: do not require packs to be sorted in
 lexicographic order
In-Reply-To: <72bcd4ed6c7f685f58bb3b905fe553173abe1845.1768420450.git.me@ttaylorr.com>
	(Taylor Blau's message of "Wed, 14 Jan 2026 14:54:45 -0500")
References: <cover.1765053054.git.me@ttaylorr.com>
	<cover.1768420450.git.me@ttaylorr.com>
	<72bcd4ed6c7f685f58bb3b905fe553173abe1845.1768420450.git.me@ttaylorr.com>
Date: Wed, 14 Jan 2026 13:28:07 -0800
Message-ID: <xmqqtswnevfc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> @@ -374,7 +374,7 @@ HEADER:
>  	    The signature is: {'M', 'I', 'D', 'X'}
>  
>  	1-byte version number:
> -	    Git only writes or recognizes version 1.
> +	    Git only writes version 2, but recognizes versions 1 and 2.

We only write version 2, then ...

> diff --git a/midx-write.c b/midx-write.c
> index 8a54644e427..5c8700065a1 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -36,10 +36,13 @@ extern int cmp_idx_or_pack_name(const char *idx_or_pack_name,
>  
>  static size_t write_midx_header(const struct git_hash_algo *hash_algo,
>  				struct hashfile *f, unsigned char num_chunks,
> -				uint32_t num_packs)
> +				uint32_t num_packs, int version)
>  {
> +	if (version != MIDX_VERSION_V1 && version != MIDX_VERSION_V2)
> +		BUG("unexpected MIDX version: %d", version);
> +

... do we need to add version parameter to this function?  Unless
the writer that calls this helper function demotes version to 1 when
it realizes that the pack files we write midx for happens to be
sorted, in which case it may need to call this function with version
set to 1, I do not quite see why we need it.

>  	hashwrite_be32(f, MIDX_SIGNATURE);
> -	hashwrite_u8(f, MIDX_VERSION);
> +	hashwrite_u8(f, version);
>  	hashwrite_u8(f, oid_version(hash_algo));
>  	hashwrite_u8(f, num_chunks);
>  	hashwrite_u8(f, 0); /* unused */
> @@ -105,6 +108,8 @@ struct write_midx_context {
>  
>  	uint32_t preferred_pack_idx;
>  
> +	int version; /* must be MIDX_VERSION_V1 or _V2 */
> +

Ditto.  When we are writing it out, shouldn't this always be 2
anyway?

> @@ -410,7 +415,9 @@ static int write_midx_pack_names(struct hashfile *f, void *data)
>  		if (ctx->info[i].expired)
>  			continue;
>  
> -		if (i && strcmp(ctx->info[i].pack_name, ctx->info[i - 1].pack_name) <= 0)
> +		if (ctx->version == MIDX_VERSION_V1 &&
> +		    i && strcmp(ctx->info[i].pack_name,
> +				ctx->info[i - 1].pack_name) <= 0)
>  			BUG("incorrect pack-file order: %s before %s",
>  			    ctx->info[i - 1].pack_name,
>  			    ctx->info[i].pack_name);

Ditto.

> @@ -1025,6 +1032,12 @@ static bool midx_needs_update(struct multi_pack_index *midx, struct write_midx_c
>  	if (!midx_checksum_valid(midx))
>  		goto out;
>  
> +	/*
> +	 * If the version differs, we need to update.
> +	 */
> +	if (midx->version != ctx->version)
> +		goto out;
> +

OK.

> @@ -1100,6 +1113,7 @@ static int write_midx_internal(struct write_midx_opts *opts)
>  	struct tempfile *incr;
>  	struct write_midx_context ctx = {
>  		.preferred_pack_idx = NO_PREFERRED_PACK,
> +		.version = MIDX_VERSION_V2,
>  	 };
>  	struct multi_pack_index *midx_to_free = NULL;
>  	int bitmapped_packs_concat_len = 0;
> @@ -1114,6 +1128,10 @@ static int write_midx_internal(struct write_midx_opts *opts)
>  	ctx.repo = r;
>  	ctx.source = opts->source;
>  
> +	repo_config_get_int(ctx.repo, "midx.version", &ctx.version);
> +	if (ctx.version != MIDX_VERSION_V1 && ctx.version != MIDX_VERSION_V2)
> +		die(_("unknown MIDX version: %d"), ctx.version);
> +

Ditto.

> @@ -1445,7 +1463,7 @@ static int write_midx_internal(struct write_midx_opts *opts)
>  	}
>  
>  	write_midx_header(r->hash_algo, f, get_num_chunks(cf),
> -			  ctx.nr - dropped_packs);
> +			  ctx.nr - dropped_packs, ctx.version);
>  	write_chunkfile(cf, &ctx);
>  
>  	finalize_hashfile(f, midx_hash, FSYNC_COMPONENT_PACK_METADATA,

Ditto.

> diff --git a/midx.h b/midx.h
> index a39bcc9d03f..aa99a6cb215 100644
> --- a/midx.h
> +++ b/midx.h
> @@ -11,7 +11,8 @@ struct git_hash_algo;
>  struct odb_source;
>  
>  #define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
> -#define MIDX_VERSION 1
> +#define MIDX_VERSION_V1 1
> +#define MIDX_VERSION_V2 2
>  #define MIDX_BYTE_FILE_VERSION 4
>  #define MIDX_BYTE_HASH_VERSION 5
>  #define MIDX_BYTE_NUM_CHUNKS 6
> @@ -71,6 +72,7 @@ struct multi_pack_index {
>  	uint32_t num_packs_in_base;
>  
>  	const char **pack_names;
> +	size_t *pack_names_sorted;
>  	struct packed_git **packs;
>  };

This does make sense.  The code paths that reads existing on-disk
files must notice when they are dealing with v1 format and need to
act differently.

Thanks.
