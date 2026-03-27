Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37B63932DA
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 21:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774645792; cv=none; b=tzRvH0Tq0FV0GC1yzlhcbvlBU/NolcBRvUT+sJAEV3NK/+KP02xYXrF0gRetsvSeYM2XvAyHSfCsPAs4+o4gx3PVLmpMn7qFxf3u5oKCMei5n5Btig5C245AKW7In8R0GdA8lbtzMLU1qTdMk9QunOnVKC9LtC3cUARCkp1fqJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774645792; c=relaxed/simple;
	bh=FBuP9tTTQL4pPEMBk7imcAji8osceoyCiqNfZivODMg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K7F8pRATr9G3Vvk6sq80ngOKpW4DyurFEMMjx+mRuhtOEbXBFF77WkEn66tQ60OyVgZuWF91eVECS50KPbou/6+tmW2MbgpnlOV4pJxngyaoIC94uWclXbq45tZlHH+ROkMf51TI0oOltmpAXbk7YENO2Ae/ogaRX54h8G3FVPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=a859UR2L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=saz6sjhw; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="a859UR2L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="saz6sjhw"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 684B41D001C9;
	Fri, 27 Mar 2026 17:09:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Fri, 27 Mar 2026 17:09:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774645789; x=1774732189; bh=msW8B1u9UA
	WKM3+APLQ0h/hP9/Y7XELExVRLg3SUKXE=; b=a859UR2Lg/clIgK+CTdRMS2gWG
	ZA1IbrKQJ237E+CSK/BMDvL8M/JROC/b+Kq9GyGibc4OS+4QP/eSOci0lvMQH1ZY
	ewAX5c5HnNwRucE+gDicUxRh/PrtDc5N8rAa0SF2p+KWupkn+51snCVTyeQngmKr
	SJfj2TEmoeN6sRgMNh74mKyx8uRcds6A2cduBHmcgw+ejgxse3obfHSC52VDbV4r
	57ahuIVnFif5QyZjuBak533xvp9czsHJ2SsJu5jPGcokxemfc7eHqcLZdqBRzSx0
	dqnfqQPq6qdLTs9eCG2Rw9aFn8s2wLPlEWopXdh9eaDEOkxqOO7aVYRwkmUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774645789; x=1774732189; bh=msW8B1u9UAWKM3+APLQ0h/hP9/Y7XELExVR
	Lg3SUKXE=; b=saz6sjhwrPIWPPpXcE6Xjc7W//BGa5jeq6dAuvX+x5Oi1AKjz4h
	oLndyNd7Am4Llvnq4c3BEWA5ZoerLMZpDtamSlAPj3t289E1vwV2r8iDn87iZJ03
	3BRFp3IIS4KFloLXX7bgI0hWYFS+8Wj6rdGNv9y2C5Rah48zVd7EXkVfxaj8DADj
	9w8a77f+G6fICb+vwqVL8G21QS6mUoDlPIwY5yd2YR0kIyJxkXMuTiaLpKy2pVif
	zLCmDZGHP9+cS9Ap/4IMC3+4iKMJY0mZ/K95wxdBdNli2F32IU5BBLbCvj2ffnfu
	I5FLBkbaQcp8RycRc7TVybkTSicb2GeJklw==
X-ME-Sender: <xms:HfLGaSZRbGtad1P8kLKD3Ed6LE6N6E7oBUeC4t5mSt84ASRU_zePaw>
    <xme:HfLGaX-RwgObkrvf8_q8MihUx0XMrFoukSKOVaU-epE9q5QQXydcNBw9wxAxKjQDg
    Tg3S08VAcqX08TSBZ7f9_dQTyHsfQRmn5lQSQTPHALZHagDvCIv0w>
X-ME-Received: <xmr:HfLGaQniwTJkvqlOrm-tJ0QZqffmr655_GOwx-IOmlhJsjpoi59CfCg0V275KQoKr6BmjutHVfNeJs-GViGUCy2yYB65qN71YQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffedufedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    peihtghhihhnrdhgihhtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehlrdhsrdhrseifvggs
    rdguvgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepsggvnh
    drkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgiivghkihgvlhhnvgif
    rhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:HfLGaUwJegmWTDPzP-9l_tXQNpVXicTGPZMeJ0ZsbU8B70gRPBLkJw>
    <xmx:HfLGaS5t4KhjAgmMhNnCX8aZguOgEbR6igYvwAAjg_rzQ3suuEWrtw>
    <xmx:HfLGacWGryVeYHEUh8xVGkQfL_mHmXaGQgNyWWz4cmnbEgZihf09Dg>
    <xmx:HfLGaSJcdJtSp9M_n9qo5Woah6hDZ1ZuCVJTI2AJqI4HyZ79hso66w>
    <xmx:HfLGaQcWHY-h5ZuLf34-cZcvJYq-NRALB6D6MIW6LsaX7iaz4S9FO1Dx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Mar 2026 17:09:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Yee Cheng Chin <ychin.git@gmail.com>,  Phillip
 Wood <phillip.wood123@gmail.com>,  =?utf-8?Q?Ren=C3=A9?= Scharfe
 <l.s.r@web.de>,  Jeff King
 <peff@peff.net>,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Ezekiel Newren
 <ezekielnewren@gmail.com>
Subject: Re: [PATCH v3 4/6] xdiff/xdl_cleanup_records: make limits more clear
In-Reply-To: <86dd98db9b93651b21adaa41ccd44917910fedcc.1774639433.git.gitgitgadget@gmail.com>
	(Ezekiel Newren via GitGitGadget's message of "Fri, 27 Mar 2026
	19:23:51 +0000")
References: <pull.2156.v2.git.git.1774473065.gitgitgadget@gmail.com>
	<pull.2156.v3.git.git.1774639433.gitgitgadget@gmail.com>
	<86dd98db9b93651b21adaa41ccd44917910fedcc.1774639433.git.gitgitgadget@gmail.com>
Date: Fri, 27 Mar 2026 14:09:47 -0700
Message-ID: <xmqqy0jdhtd0.fsf@gitster.g>
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
> Make the handling of per-file limits and the minimal-case clearer.
>   * Use explicit per-file limit variables (mlim1, mlim2) and initialize
>     them.
>   * The additional condition `!need_min` is redudant now, remove it.
> Best viewed with --color-words.
>
> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---
>  xdiff/xprepare.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)

t4071 and t8015 do not like this step, even though they are happy
with 1-3/6 applied.


> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
> index 386668a92d..2cf1f8d1a8 100644
> --- a/xdiff/xprepare.c
> +++ b/xdiff/xprepare.c
> @@ -268,7 +268,7 @@ static bool xdl_clean_mmatch(uint8_t const *action, ptrdiff_t i, ptrdiff_t s, pt
>   * might be potentially discarded if they appear in a run of discardable.
>   */
>  static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2) {
> -	ptrdiff_t i, nm, mlim;
> +	ptrdiff_t i, nm, mlim1, mlim2;
>  	xdlclass_t *rcrec;
>  	uint8_t *action1 = NULL, *action2 = NULL;
>  	bool need_min = !!(cf->flags & XDF_NEED_MINIMAL);
> @@ -287,25 +287,30 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>  		goto cleanup;
>  	}
>  
> +	if (need_min) {
> +		/* i.e. infinity */
> +		mlim1 = SIZE_MAX;
> +		mlim2 = SIZE_MAX;
> +	} else {
> +		mlim1 = XDL_MIN(xdl_bogosqrt(xdf1->nrec), XDL_MAX_EQLIMIT);
> +		mlim2 = XDL_MIN(xdl_bogosqrt(xdf2->nrec), XDL_MAX_EQLIMIT);
> +	}
> +
>  	/*
>  	 * Initialize temporary arrays with DISCARD, KEEP, or INVESTIGATE.
>  	 */
> -	if ((mlim = (long)xdl_bogosqrt((uint64_t)xdf1->nrec)) > XDL_MAX_EQLIMIT)
> -		mlim = XDL_MAX_EQLIMIT;
>  	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
>  		size_t mph1 = xdf1->recs[i].minimal_perfect_hash;
>  		rcrec = cf->rcrecs[mph1];
>  		nm = rcrec ? rcrec->len2 : 0;
> -		action1[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
> +		action1[i] = (nm == 0) ? DISCARD: nm >= mlim1 ? INVESTIGATE: KEEP;
>  	}
>  
> -	if ((mlim = (long)xdl_bogosqrt((uint64_t)xdf2->nrec)) > XDL_MAX_EQLIMIT)
> -		mlim = XDL_MAX_EQLIMIT;
>  	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
>  		size_t mph2 = xdf2->recs[i].minimal_perfect_hash;
>  		rcrec = cf->rcrecs[mph2];
>  		nm = rcrec ? rcrec->len1 : 0;
> -		action2[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
> +		action2[i] = (nm == 0) ? DISCARD: nm >= mlim2 ? INVESTIGATE: KEEP;
>  	}
>  
>  	/*
