Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BF827380C
	for <git@vger.kernel.org>; Mon, 29 Sep 2025 23:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759188120; cv=none; b=Je5dE6gTOXSyigHnMGmqduMRjPEutvlYhhJz3m7+sTcK+we+xBi/8zwcgGFBUlZbTn2mX4aeG+3tpK3+3U4rIHuxHSFqK15er9GUBAwpAUgKNWlJzbxn0oZ6YC+bs9e1RUa2TuVw7K+ZUdK5QBVY2BxQLXQtTX8sSSjx4gIVtW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759188120; c=relaxed/simple;
	bh=vybG3QrQxCxpqU28X/YYLbRsdSSkhRlClFwKcKm5BbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/98gIIGRKWDiNTjt1osy4lak+Jpwo9IWP2ETRHQZ2fSyvu9fL9b+xL4ACl/fwmsG2uvD4xaeQtYmmu0yLVHdFHUZjPjzam0d43JWyzhVuf/p+pde53UdjyWWC2j0JJbIhNsralh6VWXV2MhZ0ruKSv/o7wKb3rZgg8OelEJicQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nOSbdhkF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lfGKWphO; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nOSbdhkF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lfGKWphO"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6D7BC1400043;
	Mon, 29 Sep 2025 19:21:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 29 Sep 2025 19:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759188118; x=1759274518; bh=vybG3QrQxC
	xpqU28X/YYLbRsdSSkhRlClFwKcKm5BbU=; b=nOSbdhkF3+/ESEiyCU0WZKlbYu
	swp7UVyAlMMeMc4RPrfYvH5jYW+mb41hEU8XtWAKHnS5LBfQIvFEbgOazCy1DOBq
	vEc4SD83SVbI79lxKIXKqJIcqccfg4OReIAPbsLOdSDNGXl0gOgKIF0tXT6Nx4u3
	o1KI7SP5Oj6UV+VCt+oYlACCjG+2tXJjSHWUE39wXlT2lU8Xb8EIWJ254cz/4drn
	Z+VC6h+vO55UmYnvO0Wi55W+PLPxyUYvxOjUpLEAgBomeBWEHlBn0BUyScxWKnf+
	HiPfVYXx65v5Skro+agLq/9uogO3C8qKSwtem317ZbydUXRvHVkjKjLUgibg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759188118; x=1759274518; bh=vybG3QrQxCxpqU28X/YYLbRsdSSkhRlClFw
	KcKm5BbU=; b=lfGKWphOPufwXwWUvNdC9Ngm7BphG+OJ4VIPYi5Dv2T+JjqW7mF
	7rI8EwcwD5KDHkdjLYuv22hh7wmu79U0okpMfXmgxFbKl6cGXt+E9O4ew+8gt/nt
	sTiUi3mjBsapuhEkM1XywT/CwcBzN15W4yQZSslJvgfgqUJuIpuFJIwwSRDkwboz
	1Ksrgoyuw3tL8XD4jN+8W2U6myXh23uz8eSWAwqGgE3j8VuLw+WpAhGsAtEhA4gi
	RaxY4AU6Jq26DKnbes1NEk69NVLNk/b1LRR+2cB29lzwDocQs599JbPp5UkXLlL2
	S5Iil37d6rFxnCWSH9NQP02TAHXuicLFugA==
X-ME-Sender: <xms:lhTbaI8dcN5nhAWUyLmHWyVY4j6QEv36URyj2aylmIw-ampi5Z3Izg>
    <xme:lhTbaEZRkKnW_LI3kg4Fm0w_L1PdMQgXC9b0vsMnlBvM4qpXOiZC3E7TENGcKfIhU
    CHE9L115SAPx0l9jEMDTqYc6S__-FYqv3lO8Y1zWzspMA7UviotN74>
X-ME-Received: <xmr:lhTbaH3ZwsSIgOhi46O9f3OA8a-_r0r7EK6wXjYB0ATdWKD2L3U974sF3kJZVYuivEQCHEoVJ02cZnUpI4v1d3z2rX3IyM6xzbI3v0HgeDY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejleeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:lhTbaPZXhp8lzZ7ulQbvbW_D9NHIzHrSd8hSK6JO4EwN189diKLQOA>
    <xmx:lhTbaPJGeHCDO02SzXH2p2TCj1I6wrrJoLjl8ndOCgnIMC7QfkMiUg>
    <xmx:lhTbaOG_O8UoJl_e29wRc0rVzAzAEGY_t3_21g9LTzQ0r0zZs5ITww>
    <xmx:lhTbaGtPSbg_c_KYbF-U7UDTx026yc2SY-0yVBLEnMvVUSAU6IaDjQ>
    <xmx:lhTbaNaUVflnjBaD4q83pdDHFGRlkLguH81zwk6GrXnWzrVJPyUfqFhl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Sep 2025 19:21:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ab60f2bf (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 29 Sep 2025 23:21:56 +0000 (UTC)
Date: Tue, 30 Sep 2025 01:21:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 22/49] builtin/repack.c: pass "packtmp" to
 `generated_pack_populate()`
Message-ID: <aNsUkenrDY8YHgBn@pks.im>
References: <cover.1759097191.git.me@ttaylorr.com>
 <ab0dc6668339f24787dc80d2dc05f0d31cfadae6.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab0dc6668339f24787dc80d2dc05f0d31cfadae6.1759097191.git.me@ttaylorr.com>

On Sun, Sep 28, 2025 at 06:08:35PM -0400, Taylor Blau wrote:
> In a similar spirit as previous commits, this function needs to know the
> temporary pack prefix, which it currently accesses through the static

s/accesses/accessed/

Patrick
