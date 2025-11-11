Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CEF22068A
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 23:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762902514; cv=none; b=DzGUkG1L1c05HJgj22DuKoRXSotRGeNo7dacDTJBsCdNW/H+Wzitej6wC7sZ2T9xlC0Q+mJfJuL9ckQ0p+wpnhAnQqVr4kYcWWasug8+pM57BX4EjGDiL7jDW4G+qlUbRy0uUEs54aDF7FACpqE32gKZ/5enNOhs+ULjbD673TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762902514; c=relaxed/simple;
	bh=ukZdwwg6b4oTtQMRt/HtsfhlbhZaVYFJSweINcIBuJo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FtfmV+UqRpBg4Z4aFDVDyXAvTyJRgKb2DnHU2IVjGgmbJirXXh3KTjnrTJDPS1Fdm4S+NUVxluICrlXmxTrywTNy9eZKYTRaaEUlBBTAAS7ZRuHawIQCzpDUk1idbTcoLzGLDW3mmkQI91P6XFO1wmVD9q1nIqWxsHj6U6YpfFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BFIsFA9J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kq25ZD1d; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BFIsFA9J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kq25ZD1d"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E091A7A00F4;
	Tue, 11 Nov 2025 18:08:30 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 11 Nov 2025 18:08:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762902510; x=1762988910; bh=uMM2ofIiyo
	qcGNrDJjR7A0bno3dUlPKE3o/h9C2RsaU=; b=BFIsFA9J7wHECPn6h221G3qwJa
	85oAFi3zHA0LkYQyOoOGQwWkiiC6LNfR5vvZXeHmym968zjiQI7F+b0Cu4EaNTet
	ozvdD1t6q8NKubCd33LWZBmLJ9U8Vwuk/4xw3YcPsrpgLcdXv+5CdSOeWlXOJzho
	5FnneWI7M9ozzpgQpakUKdM2mBK/Hx6S5qbHDm/y6Jup05FRdDX5+osgLHKE1BW0
	5iwhFyCLNwjBmfmQBEJbew0t2PojIm8BHF05KUDmZ4yXzIkBGt3AcZnlYJA9SYE3
	UkmyymnK4jIZHiQR4fEoD1gpM7bb5uX0EM1diHuFa033P7vStKEFLqwRI12g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762902510; x=1762988910; bh=uMM2ofIiyoqcGNrDJjR7A0bno3dUlPKE3o/
	h9C2RsaU=; b=Kq25ZD1ddpmFVeUiprFpwfvUaha1EPU5DpGwoTdh4NNsEVgfWS1
	2T6eeCo/0f6uCrik1aYNfdWJRviHheNnIC2Kajcn62f0n0DKzmga1JnFvg+xVbD2
	0/u4kmSzGFHcp48Pim2/fCOuPNEnOyt4xpP8Qo6aL2Pue1jSBGRUAXCWayGCOigu
	rz4qMO+xvTqlceKy7Bev65d+6NrvQaAHADPSD0x7SAjJF5E9UkAIF5ar73xaOIaj
	sj3oHQcZRQ6JdaxITa8AM6fINgQgpUB1KAJGZI4s6pEj15zm/Y8HlJIkLI0f5kwm
	A342DsjlT7m4RRtVAZ/RUlBPiIxar+GCcKg==
X-ME-Sender: <xms:7sETaVGPaTIRhhWjSQi9YMG58qtt_ZzNZuastkc0_t5AyvZy7TxhMQ>
    <xme:7sETaZbGyTiHa4NAvzZza_NYIUZ-ncuG6z-ThcwgLrEqOR2Fy9Zz5v3dMgSpc-WC1
    tdV8FDVtKGwcH1lTQn6OdDzheoZYH8uIk-lSPQ0d7gV2jClXlEfuw>
X-ME-Received: <xmr:7sETadUPKTBwaN9uyNzu4xHvPp2OuVuHI32ow-70cv_Nv6ks_1vC8uvjE_vyP1l5FeBuv9nBjI2uJCy29UQyWBjnxPWUlVekWMgj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddvgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprh
    gtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohgu
    uddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsrdhtohhrvghksehgmh
    grihhlrdgtohhmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:7sETaXk5-ig6b5q3Dq0wq2R_oPRkuuwjKAOOHDycnIvJgYfZbZOMsQ>
    <xmx:7sETaQC991NO5gZfUgFDVxatTRT5X0pS7GAbJCd3QSXf6R9Ha9rPtg>
    <xmx:7sETaeh2AXEx6Pz1HQJK2JCgmmUYIeG_Wthi1Q_fLtecYh2IhJ9eNw>
    <xmx:7sETaVxhF78iKOFM_KWwl1HEg4SuG-VvwNQ0La_vurBa5c36IzWLrw>
    <xmx:7sETadkSeOzRjNelWKKKZKELYD5K1r4zpxrniQhWcY06VrVMzKbAa8FC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 18:08:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Patrick Steinhardt <ps@pks.im>,
  Phillip Wood <phillip.wood123@gmail.com>,  Chris Torek
 <chris.torek@gmail.com>,  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v3 04/10] xdiff: use size_t for xrecord_t.size
In-Reply-To: <da2b80ea0be3470cbfe04ff4d39727e6d5921a9a.1762890152.git.gitgitgadget@gmail.com>
	(Ezekiel Newren via GitGitGadget's message of "Tue, 11 Nov 2025
	19:42:26 +0000")
References: <pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
	<pull.2070.v3.git.git.1762890152.gitgitgadget@gmail.com>
	<da2b80ea0be3470cbfe04ff4d39727e6d5921a9a.1762890152.git.gitgitgadget@gmail.com>
Date: Tue, 11 Nov 2025 15:08:29 -0800
Message-ID: <xmqq346kupzm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Ezekiel Newren <ezekielnewren@gmail.com>
>
> size_t is the appropriate type because size is describing the number of
> elements, bytes in this case, in memory.
>
> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---
>  xdiff/xdiffi.c   |  7 +++----
>  xdiff/xemit.c    |  8 ++++----
>  xdiff/xmerge.c   | 16 ++++++++--------
>  xdiff/xprepare.c |  6 +++---
>  xdiff/xtypes.h   |  2 +-
>  5 files changed, 19 insertions(+), 20 deletions(-)

This step looks mostly OK but it is messy in some places.

> diff --git a/xdiff/xemit.c b/xdiff/xemit.c
> index ead930088a..2f8007753c 100644
> --- a/xdiff/xemit.c
> +++ b/xdiff/xemit.c
> @@ -27,7 +27,7 @@ static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *
>  {
>  	xrecord_t *rec = &xdf->recs[ri];
>  
> -	if (xdl_emit_diffrec((char const *)rec->ptr, rec->size, pre, strlen(pre), ecb) < 0)
> +	if (xdl_emit_diffrec((char const *)rec->ptr, (long)rec->size, pre, strlen(pre), ecb) < 0)

On platforms where long is narrower than size_t, we'd tentatively
leave things broken until we update xdl_emit_diffrec() to take
size_t, as it would become too noisy to change it in the same patch,
I guess?

> @@ -113,8 +113,8 @@ static long match_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long ri,
>  	xrecord_t *rec = &xdf->recs[ri];
>  
>  	if (!xecfg->find_func)
> -		return def_ff((const char *)rec->ptr, rec->size, buf, sz);
> -	return xecfg->find_func((const char *)rec->ptr, rec->size, buf, sz, xecfg->find_func_priv);
> +		return def_ff((const char *)rec->ptr, (long)rec->size, buf, sz);
> +	return xecfg->find_func((const char *)rec->ptr, (long)rec->size, buf, sz, xecfg->find_func_priv);

Ditto.

> diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
> index 75cb3e76a2..0dd4558a32 100644
> --- a/xdiff/xmerge.c
> +++ b/xdiff/xmerge.c
> @@ -101,8 +101,8 @@ static int xdl_merge_cmp_lines(xdfenv_t *xe1, int i1, xdfenv_t *xe2, int i2,
>  	xrecord_t *rec2 = xe2->xdf2.recs + i2;
>  
>  	for (i = 0; i < line_count; i++) {
> -		int result = xdl_recmatch((const char *)rec1[i].ptr, rec1[i].size,
> -			(const char *)rec2[i].ptr, rec2[i].size, flags);
> +		int result = xdl_recmatch((const char *)rec1[i].ptr, (long)rec1[i].size,
> +			(const char *)rec2[i].ptr, (long)rec2[i].size, flags);

Ditto.

> @@ -119,11 +119,11 @@ static int xdl_recs_copy_0(int use_orig, xdfenv_t *xe, int i, int count, int nee
>  	if (count < 1)
>  		return 0;
>  
> -	for (i = 0; i < count; size += recs[i++].size)
> +	for (i = 0; i < count; size += (int)recs[i++].size)
>  		if (dest)
>  			memcpy(dest + size, recs[i].ptr, recs[i].size);
>  	if (add_nl) {
> -		i = recs[count - 1].size;
> +		i = (int)recs[count - 1].size;
>  		if (i == 0 || recs[count - 1].ptr[i - 1] != '\n') {
>  			if (needs_cr) {
>  				if (dest)

This is messier than I expected.  Before the precontext of this
hunk, "i" and "count" are both incoming parameters of type "int", so
the same "what if size_t is wider?" puzzlement applies here.  At
least, the reason why "i" and "count" is "int" is not because they
want to be able to express negative values, so it shouldn't involve
too much hassle if we later want to change them to size_t to lose
these casts.

> @@ -324,8 +324,8 @@ static int xdl_fill_merge_buffer(xdfenv_t *xe1, const char *name1,
>  
>  static int recmatch(xrecord_t *rec1, xrecord_t *rec2, unsigned long flags)
>  {
> -	return xdl_recmatch((const char *)rec1->ptr, rec1->size,
> -			    (const char *)rec2->ptr, rec2->size, flags);
> +	return xdl_recmatch((const char *)rec1->ptr, (long)rec1->size,
> +			    (const char *)rec2->ptr, (long)rec2->size, flags);
>  }

Same "long may not be wide enough, in which case we'd need further
fixes" applies here.

> @@ -441,7 +441,7 @@ static int lines_contain_alnum(xdfenv_t *xe, int i, int chg)
>  {
>  	for (; chg; chg--, i++)
>  		if (line_contains_alnum((const char *)xe->xdf2.recs[i].ptr,
> -				xe->xdf2.recs[i].size))
> +				(long)xe->xdf2.recs[i].size))
>  			return 1;
>  	return 0;
>  }

Ditto.

> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
> index 4c56467076..b3219aed3e 100644
> --- a/xdiff/xprepare.c
> +++ b/xdiff/xprepare.c
> @@ -99,8 +99,8 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
>  	hi = (long) XDL_HASHLONG(rec->ha, cf->hbits);
>  	for (rcrec = cf->rchash[hi]; rcrec; rcrec = rcrec->next)
>  		if (rcrec->rec.ha == rec->ha &&
> -				xdl_recmatch((const char *)rcrec->rec.ptr, rcrec->rec.size,
> -					(const char *)rec->ptr, rec->size, cf->flags))
> +				xdl_recmatch((const char *)rcrec->rec.ptr, (long)rcrec->rec.size,
> +					(const char *)rec->ptr, (long)rec->size, cf->flags))

Ditto.

> @@ -157,7 +157,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
>  				goto abort;
>  			crec = &xdf->recs[xdf->nrec++];
>  			crec->ptr = (uint8_t const *)prev;
> -			crec->size = (long) (cur - prev);
> +			crec->size = cur - prev;

Yay!

> diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
> index b1c520a378..88b1fe4649 100644
> --- a/xdiff/xtypes.h
> +++ b/xdiff/xtypes.h
> @@ -40,7 +40,7 @@ typedef struct s_chastore {
>  
>  typedef struct s_xrecord {
>  	uint8_t const *ptr;
> -	long size;
> +	size_t size;

Yay, too!

>  	unsigned long ha;
>  } xrecord_t;

