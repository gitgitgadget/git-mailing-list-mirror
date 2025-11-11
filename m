Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD79299AB5
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 22:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762901595; cv=none; b=BZoXMeArlyNSpR9cJTCbhJb5Bwtlk6COL0xL/U1jbKGmVY6gxBm5nhuW/HY25L7FhTVSTfelD8HNkpEFnqwgxXPqmv6BlYYiCpvnRAZwF59ZeEPMs8oPYtD23QjHTTayOOEGUvCnHmr4I73oHj7YYbyyWCPk0YkqbsZECO0+rJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762901595; c=relaxed/simple;
	bh=lRSAZu7Rll5QFyU8BY6l6ZAfpitXGXjBJNR6w3ptdVo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oYGRCxhmtOF5ohQSwOzhBFNnKkNFMvf7LH6KCpuxhMPEKtrHGaZ3131cZtevUCJSNfz+sc4CyFOZXxairVuy8QN85K5rBMnK5Sdm+TdX3St69BfM341O94+5BceNRbGaKUzYUQbGCU70LwohvUISWN1nIgjWtwyaQhF1FTxxVwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L2v1sa6r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xXewEFYw; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L2v1sa6r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xXewEFYw"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ED10C7A001D;
	Tue, 11 Nov 2025 17:53:11 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 11 Nov 2025 17:53:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762901591; x=1762987991; bh=ZWabtNJgkN
	9zSZG1VqEnb/ks+yx5SRtVdUo2SM7s5vM=; b=L2v1sa6rRxLThVeKtAAyi42bZN
	m6wHoIHbMR7+w4nf7FmH3R6S6R9bvpFFsu0XgIIinNYt9v+ycE7ruIakjF50eYZn
	4CYYcvwijtUzmrDBHSu1W9eFEDE/FA4iej6PAWu4BZGaqfHUT7ZbKUFESHf2coSQ
	FrgUW1bT/59lyHO/95tKFkGz0W97+POnAiQC/WIRndCZjKxu/FkGVTeoRiwezD3j
	muK7qmXe3im35Ef46iLdWwpI7ISxHwJEhiLWg0Mtj0jTAMss1sJPrKZdrKm7Sa5q
	XSDVc4ITMPDAmryz/CmQP9FTfNpxd3akxsF+3bZEKWjYNYKkSEmdXaNwV/zA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762901591; x=1762987991; bh=ZWabtNJgkN9zSZG1VqEnb/ks+yx5SRtVdUo
	2SM7s5vM=; b=xXewEFYwXotMJaqBDRvI2bpjZlCpr/d0xXmy1dtdXIym93/FdQ2
	e+wW6qCVc4Bm4wj1cvVPntGWRtx+FeprUk26Jh/8vE+/WPQfb9zVvVPpCxp8UgoQ
	4iHgkegF2EoZQ7V8fdGgdqW7wHubzSzVVAF/nvvAM0i/GwtGilmO2P1pz2uhoL/x
	nr/eqgykCl/XX9XOaDSeL6Bfiaf6xWBuBiiVMabkaI+85oxFMUlSghurin1K48cf
	UaVQ7ftmJvwsZeRibX8PI7Q2+DyEosIYF5LQM92zqGAh4ofMwyNrfObAevMDHAfI
	CEa0bhi+4PHq0YIV80VXTzoORamL6G9QotA==
X-ME-Sender: <xms:V74TaU_MkOYLmZ0zI7vLcUpNlu7sLzHXbwYTcZIDP4c6Dhe3nL8pAQ>
    <xme:V74TabzycqxhOcCas_oeZ4zS0JeLLynZzvSYOc2S2Vv13YYX_3FI-e9Shk91Fx4HI
    ZC_7_3iCKsY_m5uj8Si7lVOSUUR7iAoTOTVbCh5cpIztUpsZ_Frjg>
X-ME-Received: <xmr:V74TaQMA4xO5jWo5LDkn4Dr7i-sk92A9rQz_1-VioyuVp1O9HDjMV1rOGGERToXb2dM-68Ms-bXBnOt8j3ogh0BxPC3YEot79SLn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddvgeefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:V74TaQ_RVntcfNC1CFx4io4mIxTdByZt6tQykqyJfTHC04LhM2pMTA>
    <xmx:V74Tad4L3WeGmhB0c__Vb_oBXy533DEZJCmt4BUzYBsSqF34L7E8Uw>
    <xmx:V74TaW5_Jye7ltWbBXHaZwepGMCIsKGauvBeXnxCYGbqyB-VDppCwg>
    <xmx:V74TaWpmeYjYzBmY2tN_-p5QXdkVxSg2NVCtzrdww-aJ45lsfjmm0g>
    <xmx:V74TaWe13_iTOFfCHLke0uxtP8WaL38sLiJlKmanHj2ZgIrnyncuX9cK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 17:53:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Patrick Steinhardt <ps@pks.im>,
  Phillip Wood <phillip.wood123@gmail.com>,  Chris Torek
 <chris.torek@gmail.com>,  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v3 03/10] xdiff: make xrecord_t.ptr a uint8_t instead of
 char
In-Reply-To: <83e7bf180a380a625c9dc324333ba4a46a4c17c1.1762890152.git.gitgitgadget@gmail.com>
	(Ezekiel Newren via GitGitGadget's message of "Tue, 11 Nov 2025
	19:42:25 +0000")
References: <pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
	<pull.2070.v3.git.git.1762890152.gitgitgadget@gmail.com>
	<83e7bf180a380a625c9dc324333ba4a46a4c17c1.1762890152.git.gitgitgadget@gmail.com>
Date: Tue, 11 Nov 2025 14:53:09 -0800
Message-ID: <xmqqbjl8uqp6.fsf@gitster.g>
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
> Make xrecord_t.ptr uint8_t because it's referring to bytes in memory.
>
> Every usage of this field was inspected and cast to char*, or similar,

"inspected and changed to cast to"?

> to avoid signedness warnings/errors from the compiler. Casting was used
> so that the whole of xdiff doesn't need to be refactored in order to
> change the type of this field.

> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---
>  xdiff/xdiffi.c    |  8 ++++----
>  xdiff/xemit.c     |  6 +++---
>  xdiff/xmerge.c    | 14 +++++++-------
>  xdiff/xpatience.c |  2 +-
>  xdiff/xprepare.c  |  6 +++---
>  xdiff/xtypes.h    |  2 +-
>  xdiff/xutils.c    |  4 ++--
>  7 files changed, 21 insertions(+), 21 deletions(-)
>
> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
> index 6f3998ee54..411a8aa69f 100644
> --- a/xdiff/xdiffi.c
> +++ b/xdiff/xdiffi.c
> @@ -407,7 +407,7 @@ static int get_indent(xrecord_t *rec)
>  	int ret = 0;
>  
>  	for (i = 0; i < rec->size; i++) {
> -		char c = rec->ptr[i];
> +		uint8_t c = rec->ptr[i];

rec->ptr[] is now an array of uint8_t, so this is not "inspected and
cast to".  It is unclear from limited context lines how 'c' is used
by the existing code, but one example here ...

>  		if (!XDL_ISSPACE(c))
>  			return ret;

... in the post context assumes that XDL_ISSPACE(), which was
designed to work with `char` (of implementation-defined signedness),
would safely accept an `unsigned char` (let's admit it; for all
practical purposes, uint8_t is equivalent to unsigned char while we
are looking at C code) so the updated code should work fine.

The definition of XDL_ISSPACE(c) indeed casts `c` to "unsigned char"
as the first thing it does, and other tests in this if/else if
cascade (hidden in the post context of this hunk) are equality
comparisons with ' ' and '\t', so this conversion is safe.

Either way would work so it is a minor point, but instead of
changing type of `c` to u8 than casting it to `char`, as the
proposed log message explained, i.e.,

		char c = (char)rec->ptr[i];

would have been much easier to reason about why this code after the
patch is still correct.

> @@ -382,10 +382,10 @@ static int xdl_refine_conflicts(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m,
>  		 * we have a very simple mmfile structure.
>  		 */
>  		t1.ptr = (char *)xe1->xdf2.recs[m->i1].ptr;
> -		t1.size = xe1->xdf2.recs[m->i1 + m->chg1 - 1].ptr
> +		t1.size = (char *)xe1->xdf2.recs[m->i1 + m->chg1 - 1].ptr
>  			+ xe1->xdf2.recs[m->i1 + m->chg1 - 1].size - t1.ptr;

The ptr member in the t1 and t2 struct is still of type (char *), so
the size computation is performed as ptrdiff between two (char *),
which makes sense.

> @@ -156,7 +156,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
>  			if (XDL_ALLOC_GROW(xdf->recs, xdf->nrec + 1, narec))
>  				goto abort;
>  			crec = &xdf->recs[xdf->nrec++];
> -			crec->ptr = prev;
> +			crec->ptr = (uint8_t const *)prev;
>  			crec->size = (long) (cur - prev);

Hmm, it is tempting to fix this while at it, but I guess the ".size"
member being "long" will be updated to use ptrdiff_t or something
more appropriate in a later step.

Looking sensible.
