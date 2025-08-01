Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55211B95B
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 08:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754038063; cv=none; b=ofR0CaHJz4dD64FkN8HXQ/nsH+KMDMrnKtYaTCQXAstaDkwHUyv1NUrZ7S3vOCRIzWG/krdmObmTy9uUOG0bFJLtDoQIl82nTlOV2n4sByOaTSxG6YXILzkOuVXyzmw4l2sfxjHOk2B2bFTI+mi/g4xd75EZp1PhiiVLof9qSAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754038063; c=relaxed/simple;
	bh=l85wLZT9oOL5/QzjRsfSPM0az15vUBfJ7wlXWULFCgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHCKIdRVLki3M/QMJ6VZWCMKptTbNf2vi5R2cjohkTifV1HHDYGmKdSPWCt1bMbMuENwLUSewJHCT8LW/M1gdMA4MoglHRFBU5U29/tDAzblcB/PGAoF1BV/u2J/b8cZeCgF+TznEdaroi38jM3aKapmx+XTtgLdTXZSWzbbff0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CYg33Dtx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f/TG5NpM; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CYg33Dtx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f/TG5NpM"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D2AC414001A2;
	Fri,  1 Aug 2025 04:47:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 01 Aug 2025 04:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754038060; x=1754124460; bh=FUXK94rWyd
	CssUmFvbPKeAjai5XqiLrfE9Qa7Hsq1bY=; b=CYg33Dtxe81H4p1XabjQc8IC7l
	WXLdytN5mWgTwaq4/i5F2X0rnaNzSFSh/5INTajIjZa/iRilkAzf9JkpP0cmilM4
	T+rpFK/Uj0EcSzV27WMJBrcZwMaCHR4AKTrmM8CUXLnDNjmHRd5zD22C/fjjGJit
	fbx/xNeZmRZuO22AeNsy5f0SawTfHj6edM9pT4ccn99faGqYiQLro0CnvzlGMK0e
	vqeVPLofwlp35AWkBa0F0NY8dgLv7tAtkjHdzPjft24F33pMOqjH1KMFlsdHbbWk
	FBKIHeJyQRH4m5jsxfp64kDFiCbvz3WVJdpd7+P0UYKlZTfFNSFNpafYj8NQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754038060; x=1754124460; bh=FUXK94rWydCssUmFvbPKeAjai5XqiLrfE9Q
	a7Hsq1bY=; b=f/TG5NpMXv3DvrJDmd2vPknHHB3EoOvituok4r64vXcVJ5rUGR4
	5NsJGWOOIPQUQZ9rrhG3A/ajRU9BmMNkAiZSgI0hsQWtBKTF21oxMl+SvRPzoHqt
	1Yr77zqfGVyybLKgEu6PDu3/6U1B+cqmg55XjqXZ1tMnj+KZCKdUQwsDR5LSj9zA
	x8T9lRlqwV9TzB0sPNfvLX1KhBoonw+WDSwnWE/sjn168TM5KtOqSG3Tw4mpLvUT
	9TVX+0phz/IZ/awzOLcIHTg2RMsRLL2d9MTtlbP8f2Qd9NOYn9SWViEtc8ZqAtMn
	R3BK4UFhjr/7+aPOnp8sPCfjomLVKna8SEg==
X-ME-Sender: <xms:LH-MaGwlX7dhD5DHAhpGjusQPCCvrsgMWw9vvSUiCgv_AnMU_S-wsw>
    <xme:LH-MaCft-urFnppGj4PAsHT0o1DzbL-eaMwPFokVTz2-7eeGaOdy6TZ4ly5vepsFZ
    qAd4Rlp7oF4N7QrYA>
X-ME-Received: <xmr:LH-MaKJMthc4LMqI4Hd_yJqAYEAQ1a-lHxepTifNVrR3y6Y6hza3xf0QmcWaJOp4S7Iz0uYgk4RjXtL_RAI_Z_WuFoHi7gkqd1pCBGetVLkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdefvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:LH-MaLGqluwWuTKDdp1Jz-exfRDe0pB-sPbx04BMGBAHtZsW6SxxYQ>
    <xmx:LH-MaMqeRZCFkI4K4HKVP_lYHl9Q481ucPsU4mviy98XcPr26-DN3Q>
    <xmx:LH-MaMTKGmT-bhYOXaHGJ0AvIxqcZukB_ziAWjtv9y-w37azS-KfMw>
    <xmx:LH-MaBNlFkjhTaJ_rvOnpN-ci51m2Sex7MkkSs9s8-mwn_Y9JqZv2Q>
    <xmx:LH-MaBVHi8DaicwFf01p8jwLCK2yhNPk5amrmX3xAl9Y95Z3iHqMJoZt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Aug 2025 04:47:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2ae97874 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 1 Aug 2025 08:47:39 +0000 (UTC)
Date: Fri, 1 Aug 2025 10:47:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 6/7] string-list: optionally omit empty string pieces
 in string_list_split*()
Message-ID: <aIx_KAhKhGedQ0mV@pks.im>
References: <20250731063949.1601669-1-gitster@pobox.com>
 <20250731224607.3942417-1-gitster@pobox.com>
 <20250731224607.3942417-7-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731224607.3942417-7-gitster@pobox.com>

On Thu, Jul 31, 2025 at 03:46:05PM -0700, Junio C Hamano wrote:
> Teach the unified split_string() machinery a new flag bit,
> STRING_LIST_SPLIT_NONEMPTY, to cause empty split pieces omitted from

s/omitted/to be &/

> the resulting string list.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  string-list.c                |  3 +++
>  string-list.h                |  3 +++
>  t/unit-tests/u-string-list.c | 15 +++++++++++++++
>  3 files changed, 21 insertions(+)
> 
> diff --git a/string-list.c b/string-list.c
> index 86a309f8fb..343cf1ca90 100644
> --- a/string-list.c
> +++ b/string-list.c
> @@ -294,6 +294,9 @@ static int append_one(struct string_list *list,
>  				break;
>  	}
>  
> +	if ((flags & STRING_LIST_SPLIT_NONEMPTY) && (end <= p))
> +		return 0;

Okay, this is where the return value of `append_one()` starts to make
sense.

The condition for `end <= p` is probably overly defensive, as it
shouldn't ever happen that `end < p`. We could make that a `BUG()`, but
I'm not sure that's really worth it.

Patrick
