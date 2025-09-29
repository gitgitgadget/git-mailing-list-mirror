Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE5321CC51
	for <git@vger.kernel.org>; Mon, 29 Sep 2025 23:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759188089; cv=none; b=WEOM127Mg04xtnQtTbfwGIzWlGzAxqegCdASdGOkL4shl0TsCmYu7XtclKd5+WqTjIyw4ROyAdUvLiaXMZQ4do0Xvif6znmYr+bcbcn8STOLnvjsmRHS065qR6ml0pr+rEpMFRTJ8vE8vr4almH/m7t0pvJ/Ylqic7mowHXEq30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759188089; c=relaxed/simple;
	bh=cOnxRkrKEYNeK2QE2cQSbXuXiCwmfgXSZQ6AV8ioa+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4hF4lsRv1MY/Ei9sFf+v5uosChTmfzW3/UrTenSDJdClKpeg1HiS1afe3zk0xGpsj6W3fkoJaQetWxQA46p/Q1llpJZTftP+bvqEmzkJn4hnD2Ig430Nfh45qC35F3ytSqfEEU0e27sYKE10WaGG9CKKI9mV47kMRyY+Z+W8X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HL1F1mwd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B3EFiGcE; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HL1F1mwd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B3EFiGcE"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 20C4CEC0185;
	Mon, 29 Sep 2025 19:21:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 29 Sep 2025 19:21:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759188087; x=1759274487; bh=9asWQSvBkq
	rVVvfkysje0uJrfkS70KHPvwCUVPYEoA4=; b=HL1F1mwd2a//0SJtVoZFcNN9XD
	r+/VJTXpiCYxk8RCKby3I6BsufafNRErfwS8cbg5+llDTla9K0/L3O8sgUS0WC5n
	KUZyHpHt0cMyqhNcF5t4ZsYm4Tc2LXja9v0NEnBEdMvaEuhJZz/25Q5seTzhZefL
	mPZEubjVqquL3Ali40vTmcZ/RoCEzRpm14TYg7qVzgPJL7FHay09kZnMQFzbltc4
	4ClZCVvdgk/1tpRyUgMj0lGtdXijXiZS6pIwJHuMCFU+7XOhx8K/zf8liIGjm/mz
	XIUeqVgxqotpp7EzPnsOMUbSSTLzeFAi2cMH4qDwcJvHcs9iyD3P1C0NR9jQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759188087; x=1759274487; bh=9asWQSvBkqrVVvfkysje0uJrfkS70KHPvwC
	UVPYEoA4=; b=B3EFiGcEjlGJdZiiJHPD/pefm7tMtbdN1namwiMl64Bz9OyD86Q
	q+g/MAAHcC4IoNiIC0Af1S1mW3XYLOGtD0XpoE7mZcnR1aWhIhDXTJIXM8dnWNL0
	uxvXeWA86mNNdaDX+PfpcimMmtEC+RQ1n4GhMX5LvnrkQSYMqYRbJyaeAoMcdnDT
	/IPN589ooQPJajNeUAbw/WgMI03iA4lu+7Ml8A6Ue6Q+/5kJJo64YLfmvp4OZsJ5
	QbK8Z//9Y7mqMPboObDK2JWkZajKdLem5jiA0hdhc3L/8sKKRKLim6fQrGA6Vnz5
	rplOaI0BhC7P9oAiU5feYm27yEf1tHtBgjA==
X-ME-Sender: <xms:dhTbaCT-TE4BwckXOm0FsVL08TVbIwOV89nYR3UFDqCHhb_4Uzv4Lw>
    <xme:dhTbaLfOvfvQG3iAkF1QEgzDN6Y3CKVIRrgbq4PKVtaOWIbGoOOAANVV3RGHxnsHH
    K3KJScjTKqEWBO0W18miILi4kd2M3xVygJpLBPbfJ7JjERNsCz7>
X-ME-Received: <xmr:dhTbaJrIAEM31j60zou4yQoIInf56v7RSyIjKvMoxG6yp-NEsfPbxXtRvRQApivVRX3EGjtSW5sbzfeov5WvoVFTm58AERPlukWqNxllVQM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejleefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ejtddtgeffkedujeejgeduhefghedtgfdtieduleeulefgueetheeludegueeuveenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhr
    tghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfh
    hfsehpvghffhdrnhgvthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:dhTbaE81dZlyOuMxntTIFXtBUeS93jJ4_0YtO9YQiyEPjI3wCkNowA>
    <xmx:dhTbaNd7FrIuWcLugZrKsfh9kx4dTzzL-R1AGiSfGYIAUZlq6DyyZg>
    <xmx:dhTbaGIDOjIASw4IHTUDxBmUTwOoPjdxaswlfv1EcrlRqiS2zdbARg>
    <xmx:dhTbaFjzHapuYaejdYBChXeyTMNZiuF9dNOV9Z80N7wRMbx66StknQ>
    <xmx:dxTbaLuj-NEJwmaRkqkf77K0TTSpayHEwHoShQWdw2P3S4j4GycS3ObK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Sep 2025 19:21:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b0c676f8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 29 Sep 2025 23:21:25 +0000 (UTC)
Date: Tue, 30 Sep 2025 01:21:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 10/49] builtin/repack.c: avoid using `hash_to_hex()` in
 pack geometry
Message-ID: <aNsUcqHqvylWbZCA@pks.im>
References: <cover.1759097191.git.me@ttaylorr.com>
 <de4886466cab65dc72c5f800d680a610dcb0563c.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de4886466cab65dc72c5f800d680a610dcb0563c.1759097191.git.me@ttaylorr.com>

On Sun, Sep 28, 2025 at 06:07:49PM -0400, Taylor Blau wrote:
> In previous commits, we started passing either repository or
> git_hash_algo pointers around to various spots within builtin/repack.c
> to reduce our dependency on the_repository in the hope of undef'ing
> USE_THE_REPOSITORY_VARIABLE.
> 
> This commit takes us as far as we can (easily) go in that direction by
> removing the only use of a convenience function that only exists when
> USE_THE_REPOSITORY_VARIABLE is defined.
> 
> Unfortunately, the only other such function is "is_bare_repository()",
> which is less than straightforward to convert into, say,
> "repo_is_bare()", the latter of the two accepting a repository pointer.

Yeah, this function has been annoying me for quite a while already. It's
definitely non-trivial to convert, so punting it into the future makes
sense to me.

Patrick
