Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6855A259C89
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 07:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744617310; cv=none; b=htvaZ7IUpFcmkh7ufDOBgJgYp19U+Sln4nqLXJd8CWM1CQ2tfZxHxUAwceC8J3ywgEShuh7gtZTihyvaqiaKmg+Xw+RZeRsMAy4fCHWdQTNxKpOGqsYhOqxlISvwZMAd/xNgLuEjvAOwAhyC2AilSsPO/QvYYlg7TTifN0RsUqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744617310; c=relaxed/simple;
	bh=XtCFrMShArwgb8/sv9p6wmgZ8FRpWJJZo3JUTRu72R8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LV52UkM37nfeFvdvhTEs+r8mV8eIMdKzI1FXa6GDZMRBcuFQclqnneJTY40J9iEbvhdNdI6GEkEbu/kcNvKR7WOC3C8lcXFmi+5HRTQGXLiS+k2uULrKOW5cmPUdfmuvtR8Orf1cPpOi3RVjuI1IYJdOcNxG/YHCgTP8imI45pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Zgf3iulq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IEotkNhk; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Zgf3iulq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IEotkNhk"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 57F7125401F3;
	Mon, 14 Apr 2025 03:55:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 14 Apr 2025 03:55:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744617307; x=1744703707; bh=v6Nf9UTMVO
	a7GJ1G6cgRRV6yne3EAzUV+3lHDLjnkzY=; b=Zgf3iulq6nrJnFJKzKyYmtO3Dz
	//tmEfcj/Avk/YeHN3RORWdebqsFdYCfDEJjgeeb2627skcUjiMyHLGRNCukAEpd
	PVdMne/cKbHzEkLVfR2KGK8CxOG7f004O9geMlOQ8vRUBHXCwuYdH6RiFhMEBRwi
	x0qGJHTP1YqLN6FR8xX/5js1YIOtNhFpHIZQZ/KFm6R1jSU4hd/obUFYglW0upir
	Dp440viy7ME+vTLjY7Vq0L/yYAyYi3WAEO1OqoV0teT6+YofhxuhDIHHpnwbyZkU
	dZ4kXqkkwm1YSj0MPT5vvJmhXngYCUOWklGbtnlEQGLREyOSNvU/rPPAB2Lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744617307; x=1744703707; bh=v6Nf9UTMVOa7GJ1G6cgRRV6yne3EAzUV+3l
	HDLjnkzY=; b=IEotkNhkdHJbTXqc370ucNmBKta+JTZWyBGYVb77KG5DnNUZzRL
	eAQEhdC5Lbez8bhH+k/HoM7LzKZQv9cyW0HNlTHsIH1GwD2x1nrMF0q2578lhI7V
	ZKCpPN7E+/6mQNYwisAm+/P9UW4IREEuETtifh3YA8qwd+vp4PLLLq7WnUQG25HV
	MpMJsYhOuw0l2BDMR2CFuD3mkzKa5VipAtRDctRIDnmgYYOiqbCNj6/60MlJPYoq
	Nx9Q7ubGoR6BXsH8vKK+Bi00OuUMQ+um71xX6SShHvsvlTuPU9XmGtDynh/Hyh33
	bcX1MCUQ6D9wUbm1BV4rCsQhBsYAunGeb0g==
X-ME-Sender: <xms:W7_8Zz56aDOMGZi-RMoH2U5JCM3LyyJf8yGN4fUpj6aW_RHV_RqM-w>
    <xme:W7_8Z47cbX5Sz-L7Vl3iPtdCe2ub6GMAhNn3rCAylMP8dNbrYRzviU2-cMPnTD7uw
    pYq78G-dAO5_M_OiQ>
X-ME-Received: <xmr:W7_8Z6fUNvca9vPWyaRQ9ymoZQK8y9DOlHoIond5JDASbkRRu6XIVYPjtA7DDMw5UpZwrZtIN73fIg9hp6nqWh07uto3IFJAzrJQ8dKkjXjU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvddttddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesughinhifohhoughivgdrohhrghdprh
    gtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:W7_8Z0IBPqZF95AUaCElUb6quQuV6nA6xg_aaOCaqeE7NjO12rvv4g>
    <xmx:W7_8Z3KZox5g_n8mN0ACdnhCEO7_lL70FK7LQErY6uDfgPUa5URlcg>
    <xmx:W7_8Z9xdg9lLjwiIqo4l-ypf4NkbWxWurXchEm1Eys7lixkhKnChAg>
    <xmx:W7_8ZzIwsGQHSZu8N4USc4cIGcPkfIlJkqyIHl_B88f0HF8fDN6trA>
    <xmx:W7_8Z1BTeRV-DefFGySeHHaqKO8NMk-w5VyHU_99LwJ5bKAcmTNmzOwt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Apr 2025 03:55:06 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4f220473 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Apr 2025 07:55:06 +0000 (UTC)
Date: Mon, 14 Apr 2025 09:55:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Adam Dinwoodie <git@dinwoodie.org>
Subject: Re: [PATCH v2 09/13] config.mak.uname: add clock_gettime() to the
 cygwin build
Message-ID: <Z_y_WbTyOXmR7ObU@pks.im>
References: <1c04882b-e518-4272-bd18-ab918774e424@ramsayjones.plus.com>
 <cover.1743859985.git.ramsay@ramsayjones.plus.com>
 <3bd6e40cd23b07b86b5db146a00bfa01458f2e04.1743859985.git.ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bd6e40cd23b07b86b5db146a00bfa01458f2e04.1743859985.git.ramsay@ramsayjones.plus.com>

On Sun, Apr 06, 2025 at 08:38:35PM +0100, Ramsay Jones wrote:
> diff --git a/config.mak.uname b/config.mak.uname
> index 1b3ba8a341..942550fb9e 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -251,6 +251,8 @@ ifeq ($(uname_O),Cygwin)
>          endif
>  	HAVE_DEV_TTY = YesPlease
>  	HAVE_GETDELIM = YesPlease
> +	HAVE_CLOCK_GETTIME=YesPlease
> +	HAVE_CLOCK_MONOTONIC=YesPlease

Nit: let's also have spaces around the assignment operator.

>  	HAVE_ALLOCA_H = YesPlease
>  	NEEDS_LIBICONV = YesPlease
>  	NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes

Patrick
