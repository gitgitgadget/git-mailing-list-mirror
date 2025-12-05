Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B2331619B
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 12:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764937167; cv=none; b=EOQYVYfg7+U6HwT3pNxnRomD9Z2xjGmBzhuDnQaLI3Az2Sb+fOAXalzFcTEcwHisynmK656Yi0rINABQAJVhwjzKL0RalscV0Nim2yhaGMxaJovy/tzokKDH3ITNdGR1EDwR/UGtqn21LjriPXhxu9MhelqesKRCuZeWT6PRBcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764937167; c=relaxed/simple;
	bh=sjL/ErwkXuYef7wObGGr8il4DSRsvCG6Y85/2E6yKyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJlcwatS3hym1oWvEEfW6ZM8mMVZD2gaQ6q4J31vmeFqfIEj2jcUh2w1zyx6atikldVDbCQJ14zAr30XUYl7dEpHDk+HYKf2wDbkDDPVH772xb45c1WVdt3+K1yWm5O96Eek4CsJdJe3EvyX1vbKcWdK4pWeIaFlo3u6j8Iaflw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kzdGQJAe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FZVFrT4U; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kzdGQJAe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FZVFrT4U"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 89D1B14001EA;
	Fri,  5 Dec 2025 07:19:23 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 05 Dec 2025 07:19:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1764937163; x=1765023563; bh=sjL/ErwkXu
	Yef7wObGGr8il4DSRsvCG6Y85/2E6yKyU=; b=kzdGQJAe6m8JMXVOVxXdS2Hur/
	kAl3AmrAVVKCbJfI3Kc9a9ceUaE8aiUHj7v3Bpfvd0pDsb8AoPaGtV/+/ieVsJdc
	n2G5fnrgZ3pnYAVhzLQtG+3DCiRF4xMRqwxS4SY+pwoPXsqFOz6eiN31vgVZb3x3
	2G6AYfllLkIlibKDkopWPR0lADVirYqVKxugcH8chadLUPpNL/4jrxZZA6TW0RDM
	eVPid2hOpbW39FJZFO/bzCh9mtHlHdh1Afryes2PtIs3AZqXgy48nzo44wFIzPTY
	i+RFGUzCHyhYDhUX/ptlGl7RHPIHkH+GuMtheDd5THq81kYVXCSeW+xIBWIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764937163; x=1765023563; bh=sjL/ErwkXuYef7wObGGr8il4DSRsvCG6Y85
	/2E6yKyU=; b=FZVFrT4Uj2liyJueeZayDYfHMuwsM5RNXTaJZlsho3Zv0p+nEGG
	nOL4mZHnJorre0ebFwsvl615CuallipbhSKhoPTACK9xsdOupkb1IqTbLZmLB00O
	X3jdMl1e58LcWfCDXfR7wN/5yxuKb7e3b9QYH79xPuMUb3IajDFqGo+xAm++SAKI
	BhulmmFDos9y0eNvmAIlA+zyeVbjNsVxJh0OLDWiPvHVbABH75u32D49UnQc3lA3
	h3BluGwVyLcwnDYj0VIpjm2wciiTyw2db7On9JgZ6NPNj33z2yyJUWLs1+gGqnPs
	fJt+rouOsxpAB+f2q/Z19syyY4LKJOdSIlg==
X-ME-Sender: <xms:y80yaXr34w0-JTkzLJfXe6ifyIEoGfCALXBwzZ8Auu_SgvBB0dON4g>
    <xme:y80yaZ0LUm1K73cwn6raXNsl6ZuJF3_F8RSJ3IyWQa2iRY4i7em4_SCXONPfggKPs
    WvFwdrz6aUugkmEV3N8bBSVk3r6olC5uzgZjyW6S8mbMcNCMu_seQ>
X-ME-Received: <xmr:y80yafzBlKaeWgKxPJf6voCe-EnEbYPaDE3_H3kgERm-r168MHIg3d7ToH46CVGYzuiurH7k50V7hbL2azO0p-bHAeDxlU4EuMm6bkwB1_s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegvmhhilhihshhhrghffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsthgvrggumhhonhesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtoheprggrrhhonhesshgthhhrrggsrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruggrmhgriihiohesghhooh
    hglhgvrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghi
    lhdrtghomhdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhlrggsohhrrg
    drtghomh
X-ME-Proxy: <xmx:y80yaViGZ1KV6PCUWXE_FSyV7QaOOy89V6Kv9Gw13Urmm7Fe7ENBmA>
    <xmx:y80yaSqHNTn7q5odhhSB3N9u8lX0cAlK_3oU5FhldE-ZPJXTEbXRYA>
    <xmx:y80yacgb13Dfmtr7zgTaJqcTcJBKesnWUKC1090w6n8FopQ0qXMXAw>
    <xmx:y80yaUOftyp3tTax-G-ANGYdcuBM6wz_vw2cosQCkXiJnXicftYBIA>
    <xmx:y80yadRnXLk-SnLhRDTh45pbhJLNjymQK3FJ-2gv-Ge61L7kqqIeXvGT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Dec 2025 07:19:21 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 64ee3a28 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 5 Dec 2025 12:19:21 +0000 (UTC)
Date: Fri, 5 Dec 2025 13:19:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 7/7] meson/Makefile: allow setting submodule encoding
 at build time
Message-ID: <aTLNxlKh02T_1PYB@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251119211030.2008441-1-adrian.ratiu@collabora.com>
 <20251119211030.2008441-8-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119211030.2008441-8-adrian.ratiu@collabora.com>

On Wed, Nov 19, 2025 at 11:10:30PM +0200, Adrian Ratiu wrote:
> Some users find it difficult to distribute repo config changes for
> enabling extensions.submoduleEncoding, or to enable it by passing
> the config via cmdline, so we add a build-time option which can
> enable the extension for convenience.

Wouldn't it be more sensible to make this a runtime configuration key
that users can configure in their gitconfig?

Patrick
