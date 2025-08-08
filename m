Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2293320E002
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 05:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754631808; cv=none; b=lBtDOIlSmKTrz5QsL9XLZwOnZw/9t/N65u77C4qyRBDXPE1Z6GAu6Q4M5QyWAjSdnwo82mVkkU11sCiz+KCAcrmUwiOOrOREKA6r8Qe/bTXmOTUfFdrf+oaCPP/OTgaGPL8sQl2C93X7c5/Sp+tTyVbfaIEi54jQ0A9g7oJ3Vm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754631808; c=relaxed/simple;
	bh=ISizddMvzk1kAeJ7WhfIH1zjq34yaIOMG42HfBnz5rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWEZkuuNDLshpeiJz+O7fJkzEY3cPJltJRPQLwJ3Gi48I0RZcM0izS5BHN6dNhUnVJqDdIjFnj7M8b06mdw0ykWi3bsfGHi7fopsp1ICDK481pd8RPOQwYmbHppvPfMvDj7lcoyS8hADAZ9AvFQ+owIW+ilQVekG91X35p9X7b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H0AgUu88; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mdg6Sz2G; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H0AgUu88";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mdg6Sz2G"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id F030E1D00132;
	Fri,  8 Aug 2025 01:43:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 08 Aug 2025 01:43:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754631803; x=1754718203; bh=2CVo8dSu8d
	NsCQ7MYrqD2X9qoRFZM//px7m+T5OS2ZQ=; b=H0AgUu887/zIAF4f1AXa7nLFRV
	JGLYOyRKYHqw0Lg+CoYAsQw+OkfhMgoFlZcPuJFlih6xjBOmQPfmMNLvU8Cu0onY
	vMsC2BSMGQqKuIVxZ5zCBPh8i+2dLcZMVqU/JuUfTPGMPQMIvuM2m7I06qY8Lysl
	dZvf8CGpufbR3tQ2M90nh0+hbrBsIHdSAoVqv8ldrnBU5LHIh8DMMBgDiObgQeMZ
	J5pzLaJ24lA07FnQj9F0mRqrS+3fGT4Djouh5xDBUe3QGf6ngIzGrmFAqblnwct6
	mH+ANVBCGVgMiO+6QVWw2PNUx+g2fJU0crY1ICMdlUAlV2Oiy6p1W6ch1BLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754631803; x=1754718203; bh=2CVo8dSu8dNsCQ7MYrqD2X9qoRFZM//px7m
	+T5OS2ZQ=; b=mdg6Sz2GqM2frO23FMkRTvOdQ5AC5PkaoOEVg+jUPpnyQRyb6BF
	QrW7C8SczV0AWoE2W4oW72XvcXa9R2aYswiCf+sV942DOsgyHV47eZR1m/iIdJkT
	RawPcjBdC3i9gWOeciGvFFSUQHv6YZZw6bazL4nNKxp+f6XhA8VBbU8SJHWoUI6W
	2uwJ70KOzGpwV+QbGSlqbmM03L59uPPalwTHOwGaWCIn0TC3nwfiCHDQdzG4gQMT
	YOj+SQ5KkzPD4hpuP9AblHJ6a50I6VB5X+04+4kWzhHA0UI/s86EBF+MqFgZPB16
	WU+C0VUewMLInqcF4ymKoqFlms/sHb5KRqg==
X-ME-Sender: <xms:e46VaMJbUb2NqwliGS5Q5EQs56mxprb3dw-ypVcqhpfOTfbJxnX2BQ>
    <xme:e46VaPZlaruICJFG-8vhWwraYEOGPNkgbhRs3ho5oML9_BiWqiDHG_4Y1z8Coq5hq
    zK_kOseAmfCFORlZw>
X-ME-Received: <xmr:e46VaGLxep9UHyv5rUVCggvzQhdeM3thkF8pafmm-C1At4l8GS8InB3fnoVbF2i13r3zxfh5RNCt-0G_gAqViskb7zTCjQBvF-z43C2kHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdeftddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheplhhiuhdruggvnhhtohhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:e46VaFBO8EhPP3Rcqgd9D6rA9bu-Nop5L2PffeYLDZrpRhv3hmd2tA>
    <xmx:e46VaDq5_pC5ZgupPzQcv9tZep9lS33t9Uis60YiCgpGqMDcx9MuVg>
    <xmx:e46VaIgDKhJ17vCnqt6bdJYcFH6cLYE2jl9Qlqr9NgHP3HYR27GOEA>
    <xmx:e46VaIBxng-wGZMWDHPe3dnmBHyXPpfYo3rxhmzbKSqJMysV6tFD3Q>
    <xmx:e46VaACqJwewvDLbHdsuBp99FL1ML0zdfZUk4EUBJy4ZHPDDz0qeFHWp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Aug 2025 01:43:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7137d947 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 8 Aug 2025 05:43:20 +0000 (UTC)
Date: Fri, 8 Aug 2025 07:43:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Denton Liu <liu.denton@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/3] remote.c: convert if-else ladder to switch
Message-ID: <aJWOcDN2LZaMzaqH@pks.im>
References: <cover.1754455931.git.liu.denton@gmail.com>
 <cover.1754627874.git.liu.denton@gmail.com>
 <ee6d69bcafeda9d8a2cdfd1f8bb62c28c13941f9.1754627874.git.liu.denton@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee6d69bcafeda9d8a2cdfd1f8bb62c28c13941f9.1754627874.git.liu.denton@gmail.com>

On Thu, Aug 07, 2025 at 09:41:11PM -0700, Denton Liu wrote:
> diff --git a/remote.c b/remote.c
> index 88f991795b..61e2c9951a 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1171,7 +1171,6 @@ static void show_push_unqualified_ref_name_error(const char *dst_value,
>  						 const char *matched_src_name)
>  {
>  	struct object_id oid;
> -	enum object_type type;

> @@ -1196,28 +1195,33 @@ static void show_push_unqualified_ref_name_error(const char *dst_value,
>  		BUG("'%s' is not a valid object, "
>  		    "match_explicit_lhs() should catch this!",
>  		    matched_src_name);
> -	type = odb_read_object_info(the_repository->objects, &oid, NULL);
> -	if (type == OBJ_COMMIT) {
> +
> +	switch (odb_read_object_info(the_repository->objects, &oid, NULL)) {
> +	case OBJ_COMMIT:
>  		advise(_("The <src> part of the refspec is a commit object.\n"
>  			 "Did you mean to create a new branch by pushing to\n"
>  			 "'%s:refs/heads/%s'?"),
>  		       matched_src_name, dst_value);
> -	} else if (type == OBJ_TAG) {
> +		break;
> +	case OBJ_TAG:
>  		advise(_("The <src> part of the refspec is a tag object.\n"
>  			 "Did you mean to create a new tag by pushing to\n"
>  			 "'%s:refs/tags/%s'?"),
>  		       matched_src_name, dst_value);
> -	} else if (type == OBJ_TREE) {
> +		break;
> +	case OBJ_TREE:
>  		advise(_("The <src> part of the refspec is a tree object.\n"
>  			 "Did you mean to tag a new tree by pushing to\n"
>  			 "'%s:refs/tags/%s'?"),
>  		       matched_src_name, dst_value);
> -	} else if (type == OBJ_BLOB) {
> +		break;
> +	case OBJ_BLOB:
>  		advise(_("The <src> part of the refspec is a blob object.\n"
>  			 "Did you mean to tag a new blob by pushing to\n"
>  			 "'%s:refs/tags/%s'?"),
>  		       matched_src_name, dst_value);
> -	} else {
> +		break;
> +	default:
>  		BUG("'%s' should be commit/tag/tree/blob, is '%d'",
>  		    matched_src_name, type);

We can't remove the `type` variable in this patch already -- it's still
used by this call to `BUG()`. But we can drop the variable in the next
patch, where that call is converted to `advise()`.

So I'd recommend to either move this patch to after the next patch or to
keep the `type` variable here and remove it in the next patch.

Patrick
