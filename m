Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A1FA31
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 21:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749243943; cv=none; b=XUenNncC7WDVUT8TFavJrLpwj6AYgxfKoJSb4hxPzYxbLRVi877y6Mijgx0iJA/Oi85n9/txU8dlH0ZbzIEcoaOFvGp7SxihhvDLVR4lNFu+G3u0N7rlhdFt3vLCYGvEbtFOL4OPctW0pMHWvzOr+AAVVXfdy69WTMsOHXrlH1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749243943; c=relaxed/simple;
	bh=Odz7QZt8VP6ECdJHDxrnvGQFP04S6i8GrP7OhgpmWyo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iOgp4mlZ+Qg+VXea6Zu2Nkk7LaGLPoAwHsJnZjbjR08Pa/98r6c91+TCeQNsh8PShi/zYErMpKniuq+sGlUCyk6apZIlgZDhZ5YDyasA0j2uo0xYbRVESPYU4SEbXQKwRaDUFSu9eNOsoxa8Wwh09+s+qCSuRDbFmcTyxyJjWKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WMu1zh6D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C+zNYF21; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WMu1zh6D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C+zNYF21"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 53247114012B;
	Fri,  6 Jun 2025 17:05:39 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 06 Jun 2025 17:05:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749243939; x=1749330339; bh=VPci9D5KCG
	v3XjeklbImRK/qdTYCkHJs+AIkLD9mc0Q=; b=WMu1zh6DcJQqIK/hSUY+8vE/lR
	6iNdaKTWkHmTMyW0A7dpjpw8RjHHHZFwfTsypBgoSVHgnsmEMDijKzcHRTyavhf4
	cDinluqnHtdxgWWq5PoYl1dEoAPove0mRcnF5J2rjC6tauGntJmooriuOJU0O90y
	L1lgt3TLmgE+qNiAWmJZskov23/TakgC3FmZa+JYalKA4wGRGtw2HRCx9TF08P2U
	YsozhMOorJ1w9AbJrrt7mq0d5Ji5ZTFoE8WsC8PanN6utQAm53ZlB3NVWLsQRpG5
	lbaf2as3gwr2Sw1lJjaioRc2Y0Gt4GUJsHJGhLucbeqD54GEXT8/YgVy+nnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749243939; x=1749330339; bh=VPci9D5KCGv3XjeklbImRK/qdTYCkHJs+AI
	kLD9mc0Q=; b=C+zNYF21F1jXJKqssuYdGvalz8bbUWuJa8DfcnTs/aitVCHttaY
	i1jXCDL9tq3GjeJCBnbVLuHap0CGSadBx6KhFkrE85lJoVinPIhfc6xataIO6KuD
	oKhGfrVEpTgwCbafLTU0vbXQLtzXFOjDIff/2cVQtWGO37HsNZhVJ7XZAPA0Lze+
	dbK+04aQGtxjmPs4rWxYkopr+uTVluZfQAvO4hFp1wO6pgI8whKDFWJnTP6UOa2N
	PaIevrn2wLYkVW13y388exMjHXZlOCkukhP0ztI57J3jH5RQo9/V8wjjU8aJSfKp
	7434NZyYzLc0PGM36JcOMFXPQdzEJYREJ0g==
X-ME-Sender: <xms:IlhDaI10X4VTog_F8sKRPi5EG8k1YP2L0ovD12CMGvCSDBYNe_z9DA>
    <xme:IlhDaDFqTYyEbulKEPg5pUlNgRp0kySpx2NSYnKKti7zsYlNsu4PBH6TNtKMUnzPN
    VsWVCIEcykLZrmweg>
X-ME-Received: <xmr:IlhDaA6V6qQubyDNz2wzqheFhDf24emiP95_i25Kw6CJhEphOcJCUQfahsmVh3w00fBQOseDdJ9GtjOAQhBubv32C2oTTAWwLpyy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdehiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgvsggrshhtihgrnh
    essghrvggrkhhpohhinhhtrdgttgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:IlhDaB13l8t70ppwpZ2X7xrCzoJjZ6o1Cszuk1RfZq69lcClG52Q_g>
    <xmx:I1hDaLGJgfUJglkxc6HfEO9BbwfhKnto1Kqu8BBjkuBf9KZEYla7vg>
    <xmx:I1hDaK9C79fIBcMrplJGmBZ90jVTUOG9s6atTQW9W_vR7ErSc5bBWg>
    <xmx:I1hDaAkwupT9wlvd9KnaAUq-EIesrdsBH7hFV-Z-nx-cTecaJ7eZVw>
    <xmx:I1hDaPVyiyVKgZ9MCZFr08EXmHICvbrr92EGWb34iC3zD5n6-hPGzLAJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Jun 2025 17:05:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] bswap.h: Move the overwriting of the ntohl*/ htonl*
 macros.
In-Reply-To: <20250606165718.HOiC2U4X@breakpoint.cc> (Sebastian Andrzej
	Siewior's message of "Fri, 6 Jun 2025 18:57:18 +0200")
References: <20250606165718.HOiC2U4X@breakpoint.cc>
Date: Fri, 06 Jun 2025 14:05:37 -0700
Message-ID: <xmqqplfg1sym.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sebastian Andrzej Siewior <sebastian@breakpoint.cc> writes:

> The top of that file contains optimized bswap32/64 only for a few little
> endian machines. Since the commit cited below there is one for every
> architecture supporting the __builtin_bswap* directives.
>
> Later in the file, the ntohl* macros are replaced with the bswap* macros
> should they be provided. Since they are now provided even on big endian
> machines they replace the nop with a swap.
>
> Move the ntohl*/ htonl* replacement once it is determined that it is a
> little architecture where the swap is performed.
>
> Fixes: 6547d1c9cbafa ("bswap.h: add support for built-in bswap functions")
> Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
> ---
>
> This builds on top of v2.50.0-rc1 on s390x and -rc0 and x86-64. The
> testsuite passes.

What's missing from the above proposed log message is what problem
this patch is trying to address.  "The testsuite passes" may refer
to the state with this patch, but the message does not talk about
the state without the patch.  We'd prefer to see the log message
begin more like so:

    Since 6547d1c9 (bswap.h: add support for built-in bswap
    functions, 2025-04-23) tweaked the way the bswap32/64 macros are
    defined, on platforms with __builtin_bswap32/64 supported, the
    bswap32/64 macros are defined even on big endian platforms.

    However this file assumes that bswap32/64 are defined ONLY on
    little endian machines and uses that assumption to redefine
    ntohl/ntohll macros.  The said commit broke t1234-be.sh test
    gets broken, among many others on s390x.

Especially pay close attention to how we name the commit in prose,
not as "the cited commit" (because we do not 'cite' them and frown
upon Fixes: trailer on this project).

Also, I do not know what tests were broken and on what platforms for
you that triggered you to do this patch, so take the second paragraph
above as all made up example that only illustrates the level of
detail expected in a proposed log message.

After the "observation of the current state of the problematic code"
is given, we'd describe the solution.

    Make sure that we detect byte order of the platform first and
    override ntohll only on little endian platfgorms with bswap64
    by moving things around.

or something, perhaps.



>  #endif

It is a bit hard to see as the original does not indent the
#directives consistently, but this "#endif" closes the
#if..#elif..#endif to define bswap32/bswap64 for some platforms.  We
are only inside the top-level "#ifdef COMPAT_BSWAP_H" at this point,
so ...

> -#if defined(bswap32)
> -
> -#undef ntohl
> -#undef htonl
> -#define ntohl(x) bswap32(x)
> -#define htonl(x) bswap32(x)
> -
> -#endif
> -
> -#if defined(bswap64)
> -
> -#undef ntohll
> -#undef htonll
> -#define ntohll(x) bswap64(x)
> -#define htonll(x) bswap64(x)
> -
> -#else

... we undefine these two macros for _everybody_ here.  Also let me
take a mental note that we only undef these 64-bit functions and
leave ntohl/htonl intact.

>  #undef ntohll
>  #undef htonll

This is related to the "oddity" I'll mention at the end.  

After this part, there is a #if..#elif..#endif cascade to ensure
GIT_BYTE_ORDER is defined, which is unchanged and not shown in the
context.

> @@ -151,10 +133,23 @@ static inline uint64_t git_bswap64(uint64_t x)
>  # define ntohll(n) (n)
>  # define htonll(n) (n)
>  #else
> -# define ntohll(n) default_bswap64(n)
> -# define htonll(n) default_bswap64(n)
> -#endif

"#if GIT_BYTE_ORDER == GIT_BIGENDIAN" is before the pre-context of
this hunk.  We are extending the else clause (i.e. little endian
support) with the following:

> +# if defined(bswap32)
> +#  undef ntohl
> +#  undef htonl
> +#  define ntohl(x) bswap32(x)
> +#  define htonl(x) bswap32(x)
> +# endif
> +
> +# if defined(bswap64)
> +#  undef ntohll
> +#  undef htonll
> +#  define ntohll(x) bswap64(x)
> +#  define htonll(x) bswap64(x)
> +# else
> +#  define ntohll(n) default_bswap64(n)
> +#  define htonll(n) default_bswap64(n)
> +# endif
>  #endif

I think the patch is an improvement from the current state, but the
resulting code is still somewhat odd in that ntohll() and htonll()
are overridden for everybody (even for big endian boxes we make sure
it is identity function), but we override ntohl() and htonl() only
on platforms where bswap32 is defined.

Thanks.

