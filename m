Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DF9248886
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 16:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770393922; cv=none; b=JkdnEX5It4BKw+Nast1ip17+Gxu8taVLfEUjNIVOft9xBzuQAOCeDLj7gCINKEXWkc9t64Yms8A0u1fwWqrD63y43X+M6QnuLat4qP4iascc9eSaSR70dibdXvNlkjaKzj3jpx1Q6VUfsbcO+KIVdYVexZeOeO3FHHkdGfCi7Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770393922; c=relaxed/simple;
	bh=luuMFOQCLL8Lw0VdXvn9FPAg9JDtaaEUT+NXPhUHr2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCyE+SwXMPM6EO613EsjYOwpIfPKbNT60zwbdEnYOWFJLmlTes1Cbrz0mJyoaSQsqRvXvG6EOrjpomPjT8WsW62BbxGNVboeqjkZLwwd9me8U7tp1J3XzrYFARDn6j5IPRW8ZsFzxhINWBmhcFemNwpXAvfaWobT5VYzh1o+AdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ROSUPneJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d+xRr6Bm; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ROSUPneJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d+xRr6Bm"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 571357A00AB;
	Fri,  6 Feb 2026 11:05:21 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 06 Feb 2026 11:05:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770393921; x=1770480321; bh=RRrqkhVNdd
	vmg8PJ1Q1mVjHNe/YhqE6l4+CkXhSX+HE=; b=ROSUPneJnAvl2miuyZg4x3T+KC
	X4RRqn4leX0c1KOf7jdD6bgaiNN4AVqJdPTvaMjC+0WtzfoMmGu46K+52hlFqCfA
	FoYtmJOE70P3oV3veLJsWT2v/tzaM1NI9TJUa2OAGeIxEflTHeB+WASU8RGzyevY
	LclD0w1/ifL8gDS681hJzw36GPiqDtnfpw8jj3eNDvZuZPHT/Su5T+8gODxV7kFE
	lsouHAd8Y/7tA7gfFkgaCgR1OikmluhTMBQsyV1TGjssPseCaXGM0KQonaZRdMRv
	yS22KndC4Y9bqg5+F+ScN0RGJr/bDuoUpGl83/K9uOX0aKspgmn+BsZcCQLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770393921; x=1770480321; bh=RRrqkhVNddvmg8PJ1Q1mVjHNe/YhqE6l4+C
	kXhSX+HE=; b=d+xRr6Bm9v75dendNk1WE7iPLTRX4tT5iFmmmap9+7RK0eaXNXP
	Q48QKUe8Ty9gzv8bZH55dnhBtMKTzA2dYbajlrIE/3L0NkZbMQeANQKOFvRFi8XN
	bnoAdMPXVtUwu/xtkTrRaGBQNtQl1CRMqq5mBY+mq8SKHNLvHhInoazdGt/+/N1T
	hLusSBhh4JXusNA23POfED4N4ozLQvNwKgDWAA/yPVyDdOBmcmBdSnLj/2BurWfj
	u+k/T+oszWcfruTY+yM5MCaD4m6UG9NohYeatFskZa8UrigsP7xraRdkAcH7Vdft
	Iqz4X/QUtZsIX83weODD+BuW8v6/xy6frLw==
X-ME-Sender: <xms:QRGGaeEPhO7Wo4FIYptV3btOjIcqvf4E22aP_aUOV3wwd_FZf49A3g>
    <xme:QRGGaWWpGVnD6C0XfwbMIPg7xlzuBqbivkKbJwpht1GGzD-VFfgVPJNZcnXk_qYAj
    fS7ZZ-FDv1Ywc6p0teRqO06JT6_xwid05uN1Uy_5FJvgQSvBOsi9P8>
X-ME-Received: <xmr:QRGGadLrIyt8shaaAwyCtlbC-N_5VVRTTfaWSS616qDtm5-zBIBmXB3dCxAB1Kt1PBwPD-q4X1aUZa6QuDDEeBgxXoklkKjce3OaLa9ZfiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeekiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthihqshhimh
    honhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmh
    grihhlrdgtohhm
X-ME-Proxy: <xmx:QRGGaW8i4v4Qhw5_2i-blJ1eBMaqgtJS2Fmwa19tqyOb9GxILT_fJQ>
    <xmx:QRGGaQKZzV6JJzOWml_I2WSjAJhoGpNQdARzE0LBXhQqw8MR23vg5A>
    <xmx:QRGGabk_cC2vEIRG2qpo09nWpIcvGavaTYn52cxq23JlFPBBjnztEg>
    <xmx:QRGGaUNrgubAN4jeha-GhmmE9I_U3mMkttUrTdtF13PqmCP0bByATA>
    <xmx:QRGGaYpMY67r0ZXTc_5JHZIgZMtRbormXoOi5vn53U-KOZmFI5uqUzYv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 11:05:20 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a792f21a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Feb 2026 16:05:18 +0000 (UTC)
Date: Fri, 6 Feb 2026 17:05:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Simon Cheng <cyqsimon@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 1/2] checkout: pass program-readable token to unified
 "main"
Message-ID: <aYYROwDxrHU-H3n_@pks.im>
References: <20260127192936.904719-1-gitster@pobox.com>
 <20260129190616.645471-1-gitster@pobox.com>
 <20260129190616.645471-2-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129190616.645471-2-gitster@pobox.com>

On Thu, Jan 29, 2026 at 11:06:15AM -0800, Junio C Hamano wrote:
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index f9453473fe..4f189fde48 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
[snip]
> +	switch (which_command) {
> +	case CHECKOUT_CHECKOUT:
> +		usagestr = checkout_usage;
> +		break;
> +	case CHECKOUT_SWITCH:
> +		usagestr = switch_branch_usage;
> +		break;
> +	case CHECKOUT_RESTORE:
> +		usagestr = restore_usage;
> +		break;
> +	default:
> +		BUG("No such checkout variant %d", which_command);
> +	}

Tiniest nit, really not worth addressing on its own: BUG messages
typically start with a lower-case letter.

Other than that I like that we have less global constants with this
change.

Patrick
