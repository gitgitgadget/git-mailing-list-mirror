Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F647082C
	for <git@vger.kernel.org>; Sun, 27 Oct 2024 10:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730026316; cv=none; b=mQB0SqPNLs/LXiIfK7KAe4TYoyok/Obrk7PySlRjbF4kdoxWRyaedjbDT7KajR0n1MqYVrQshnYx9OlmEg+RsNSITSPrBeeka5qGS1ARi5FkKqGPMCGtafMSVG7UYKZW+R8cfR0sCdgvt/oxrKddW/B2CnyOPMV6eAD7eHIpU9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730026316; c=relaxed/simple;
	bh=+WlR3HFUGE/0bGmQrvznNMiOaM+Vx6/0QuHnpGY5cqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUM8rzHfV+laxfzQVg48EInupNjMYC3a5ZuzlCiBOVn4SU2c9uQrFB765nBjXChhF76Sc8X6j/zfOOcL+ixt+vUh8USf5W5awXwYdjth1HKQ/Nw9vZzjP5Y/paGLsb2kqvENukjQLjJGpdrVkisEqgxEt4thpE30Nt41/zPTyBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=1PNiVgSB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F9J6L+2i; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="1PNiVgSB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F9J6L+2i"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 1A5A61140093;
	Sun, 27 Oct 2024 06:51:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sun, 27 Oct 2024 06:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730026311; x=1730112711; bh=6ubPFhAtSq
	fNnAfpfAki3INFvTKjD+h0owxgCkET8r4=; b=1PNiVgSBCfO3CppQbLQLS+G4Ht
	Aa/5MJ6rY2QeF0W3sdtqjjC9vmyp66dafwUllwsLCHtABjVzF4l92Y3vW7GZzoqi
	AuVN2S3c99X0DRHwsuBWkAf5xaD2OcKhisDsq7xCiG70aRDw9BZRBGQglS/rTMbn
	yPgicN35UQfebjoTkNaPFqrUvP0PsgQayEEsNbmKKdmAGX5m/asn9J5IJPGdjaJU
	edD84tf+r2/rdPT5vC3bbXwCkgS4z93nbDITCw9niIslVHG4kMj8cEd0GUN2Kt74
	bFKa2OMUPO1KvyLUZi3z3QVR/o4BEXWtVnGgpmHCZfUwxZdXWybBZFe6XX0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1730026311; x=1730112711; bh=6ubPFhAtSqfNnAfpfAki3INFvTKj
	D+h0owxgCkET8r4=; b=F9J6L+2iJ0pQ6xlgOelXnNiC2Pq0hmB6yQJu8uObDr7k
	rJxD7DKxrWYW8wlMvTLPPDlRCZ2irJdXZREuBYBu/9HFM9rTe3wbZ4pOJt/ezi8x
	S4IZt7XqYjlD4I64svR5GCeUMqkD94svVesC0NuxUDaD6t0D+7XQnM0hLTbDcV4H
	rbL9g90ZzyBAg+ED4lyroX+HXhZsticZQAl65UvuT0SjG7e/Jo46BVn2epGec8/0
	MrMtN8Q7n4m2svUlMLeSqjrkUMKVJKMUesXFp0EHoqPzXeKHLg+OebmEWILSVD6D
	dRx73ckeZzWzzNYSucKjETN6jDzGrFZs8hLk7ZSdBQ==
X-ME-Sender: <xms:RxseZ-kJZCIEWKZwLWfgDjvbP6JqriC6tAGeAYRnPoxdvAWyVlhkdA>
    <xme:RxseZ12qQf7oVxNHWx1GfAmgJWF_lhmrn7YLppU6TV94fSuBZmCCOnjC0YEv2JanD
    pDR-20aSTLXCsB-GA>
X-ME-Received: <xmr:RxseZ8pvIez4tIiXZlWQiafP0A0TW_UipuPm-3768oHDObcjVumfN_BZU5DOHdzLTGMhzlzVsoU45vcXsPdA75C04T3gEsVN0QI3Wcgs-n-fTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejiedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepjeevudeggfffffeigeethffgieekveeffeehvedvgeei
    teegueejleeihfeitdeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphh
    hilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhufhhorhhijhhileekse
    hgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:RxseZymBxxNsEtRKfaugC3Qk8aByl20Hc3Aapbp3Iku3TdH4mpKfzw>
    <xmx:RxseZ82YDIbszW2f88VBsMTJIsFKemyS7scK-NPGIv_JN_bxhkEU2A>
    <xmx:RxseZ5vZh4gzBE3pTN2vVyNpxu0eTL9kQUUI48K4iuO-bUcwdQVCcQ>
    <xmx:RxseZ4V62qbNzMmO3NKBZZn8hx0whC2JXE3pWcYt9I_bMAq8yjStaw>
    <xmx:RxseZ5y3uZfz1fGcBAu23OdtBoE7PWMDmMYXDK3T_mQXAI5tbhTRWV0a>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Oct 2024 06:51:50 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 15636555 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 27 Oct 2024 10:51:43 +0000 (UTC)
Date: Sun, 27 Oct 2024 11:50:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Seyi Chamber <kuforiji98@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [Outreachy] Final Application Timeline
Message-ID: <Zx4bEOGr8Hy-ZfX2@pks.im>
References: <CAGedMteoVFfZy1jtHMPJvByzfq9unomcA7qkCNKx9R6_ZQ6=Cw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGedMteoVFfZy1jtHMPJvByzfq9unomcA7qkCNKx9R6_ZQ6=Cw@mail.gmail.com>

On Sat, Oct 26, 2024 at 03:50:11PM +0100, Seyi Chamber wrote:
> Dear Mentors,

Hi,

> It's almost the deadline to create a final application for the Git
> community, it's a little unclear how I should create a timeline for the
> project *Convert unit tests to use the clar testing framework*.

you may have a look at the recent thread in [1] to get some more input
on that.

> Does a timeline of the first 8 weeks spent working on converting the unit
> test framework to use the clar framework and the remaining 4 weeks
> spent on *implementing
> additional asserting functions for Git-specific types *and using *clar
> upstream to improve shortcomings discovered during the integration of Git
> with the clar* tasks sound good?

What I'd specifically like to see is how exactly you want to work on
things. So it's not only "I will convert X", but a couple more items:

  - Are there things you need to learn? When do you plan to get familiar
    with the codebase and how do you tackle that problem?

  - How do you plan to approach the topic? Do you want to convert
    everything in one go and then send over a huge topic or rather want
    to work on it incrementally? You can also take as inspiration the
    last GSoC students that converted our unit tests from the test
    helpers to our own unit testing framework.

  - Do you plan to work with clar upstream in case you feel like there
    are missing features? It might make sense to have a look at it early
    in the cycle so that you know what to expect and what you may want
    to implement there.

  - Plan sufficient time for review cycles. The Git project is not
    exactly the fastest-moving project, so you need to plan time
    accordingly.

Overall I don't expect a hugely detailed plan that knows ahead of time
how long you'll work on each of these items. I just want to see whether
you've got an idea for how to approach the project and how to work with
the Git community.

Let me know in case you've got further questions!

Patrick

[1]: https://lore.kernel.org/git/CAPSxiM-kf8U=vzp5MoD3tUuOtnNjcCgPhLdriyeQo5CGf=EhyQ@mail.gmail.com/
