Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFA81F193C
	for <git@vger.kernel.org>; Sat, 21 Dec 2024 10:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734777819; cv=none; b=Ww1KeIIGOr/cKX2Z8PtsR0MlL6s6KNYaII5EfHZbz93YsF0EX9DfKWWhE84QL0T7OgzQ1aSf+dBcjwgSCfLF6LB7jlPqWVZpz8Nacz9Ywt5NNf4svQ0Bhp1aIAUeUVDYkO3bMDBHjJKtMVnu8lZvlxHUrWZrMZ/I4/R6U89g5lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734777819; c=relaxed/simple;
	bh=flfVssxVcu0p8xUkckpyfcCcn7fjr4I282glykHaQIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6PkNO5eWMZdshQjLm43ipDb7r761YeyrvviDAbU0Dtfa3e3z9VMhxOcvu63h3JXpXcHAooYEHJ+tWXUfcb/yILKBxwCaV04OVgbewFrdj/b2Y5J52wBlNu8Q++AOe9UHkv2kjb6RegYT5pivp0jxh+dprg7gIdZO/lqHjTNyWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fqPCzoja; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QgrBo3Eu; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fqPCzoja";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QgrBo3Eu"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 4A2821380208;
	Sat, 21 Dec 2024 05:43:36 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sat, 21 Dec 2024 05:43:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1734777816;
	 x=1734864216; bh=Iviw5omwsVmDCFvS0gjTljYPgaUBJOCPBDzHa3M9vhA=; b=
	fqPCzojajFeSFAsij9PyP3jHnIcUICFsC2Un9L/nPUCUZ3NLtPxuqNipiHPVGilu
	xAhpiwSYrQt15w/+SoHKFDp+QvoVYFNPStpb5sBCK0+2Si6TdTP1tPabMHWnmkuj
	ALbLhAcXHDTi8inQMoajdvHhBHXE9XvIgRlJdR7sqKCfGbpLELlwy62OHm77vIh3
	c5ojAJksIKRY0TUHuKHgQP1or4ykDY59ICzP2TNXRzBi5PbpPnxelqpWjUkRZ3yQ
	PdvHr5DiHXNcLq3I6iu8TkvCXlx2OjKE7CFxXHTng+UKDoRz30VjDtMkMcdaXRU4
	Ez9qfWY44XfVFA0/0a1+dQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1734777816; x=
	1734864216; bh=Iviw5omwsVmDCFvS0gjTljYPgaUBJOCPBDzHa3M9vhA=; b=Q
	grBo3Euo5xRR1mT3tFnQ36tdgImIR1p2fkEtJdzHNsIHEJFLmffhsHqtIvnRSGu7
	ijyJMufhURDVl2nm6O+VazWmooZPRVJBgfbs3hVvIwkgfv4QA3RCRA0wEQWe0VPS
	lKpokCmrgiaimQ1h6pgtbDbaS7t6WRMGiyN87VNTdfWhaYsLjI37jLFHC3he+yUg
	LSnKQf1uxlfrQDd1dk4hiblp0LQlINpytRGZGpqJD1PrGroagUcpbKxcIiSceZmV
	yWHUiR74h8EI2RXKF+vmBbr4LIi+r6Ok8BYRUumcX2nqtM2igIlZb08vTImgi0aI
	ySfHhkivS0Suus2fdtTPQ==
X-ME-Sender: <xms:2JtmZ-2wgeyAXJYDorW3b-wNtkxy-xUMYXp_sZtJ1XWyM1On49M4Hg>
    <xme:2JtmZxFfnyANMx1B1N_A88fAtrgygqE_8scvaoaIYx5NkhI9C6AeV--OqOtL1h_a9
    fiVDjO7QR8-YvRbwQ>
X-ME-Received: <xmr:2JtmZ24YUWzTAd8AnRKdQNjLAWjmiL_xWjEhzZnWGcLgSHrg-EnM4LuHVkLPPfTnz8gfSHM0uQSOdL7MhPbf_4kQob4NxLATFmQBv6yYD83aZ2Jb3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtgedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeetheffvddtleettdetueeukedugeettedutdegueeu
    keetheefueevvdeitddtveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhtihhnrdgrghhrvghnsehgmhgrihhlrd
    gtohhm
X-ME-Proxy: <xmx:2JtmZ_2mxShqG6N2BhQIjDmlSGl5lNl1XhdvmoXlHPTQqkxMJLqd5A>
    <xmx:2JtmZxEsr4OE5dCpJnoJ8Ssv93NCbgjtBk-I9ZJbDiMeccvNJ_SIxg>
    <xmx:2JtmZ4-lv1H4XuCbXxUieDhgWDhRXsmvP10RZShRKwjb-P-Q4kVsUw>
    <xmx:2JtmZ2mJyREPjOJ3jobQ1KdsjeqPmiJ8hFTOVe99fAnph3WhKw6Lvw>
    <xmx:2JtmZxCO2zWLczihX1toCF3F7iZuanzEjxNUOBB6D3rzLgh_nxcBKKx0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Dec 2024 05:43:35 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9b2aa1bd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 21 Dec 2024 10:41:39 +0000 (UTC)
Date: Sat, 21 Dec 2024 11:43:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 0/3] Asciidoctor fixes for 2.48.0
Message-ID: <Z2abxaGVzA5Kce-s@pks.im>
References: <cover.1734734612.git.martin.agren@gmail.com>
 <xmqqzfkpdaeq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqzfkpdaeq.fsf@gitster.g>

On Fri, Dec 20, 2024 at 06:42:21PM -0800, Junio C Hamano wrote:
> Martin Ågren <martin.agren@gmail.com> writes:
> 
> > The Asciidoctor build of the documentation regressed a bit with
> > a38edab7c8 (Makefile: generate doc versions via GIT-VERSION-GEN,
> > 2024-12-06).
> >
> > I think these issues and fixes are fairly orthogonal to the recent
> > discussions beginning at [1], with fixes being discussed beginning at
> > [2]. I've tested these here patches on top of that series' v1 [2]
> > rebased onto a38edab7c8, as well as on top of its recent v3 [3] as
> > applied on the indicated base-commit.
> >
> > With these patches, I can use
> >
> >   make USE_ASCIIDOCTOR=YesPlease doc
> >
> > and
> >
> >   ./doc-diff --asciidoctor <...> <...>
> >
> > with similar results as pre-a38edab7c8.
> >
> > On top of current master [4], these patches help, but for "doc-diff",
> > the GIT_VERSION injection is still broken (as expected, that's why
> > [1,2,3] exist). These here patches don't refer to doc-diff or those
> > other patches [2,3] and could go in independently or on top.
> >
> > These patches are based on [3] applied on its indicated base-commit.
> >
> > [1] https://lore.kernel.org/git/20241218113324.GA594795@coredump.intra.peff.net/
> >
> > [2] https://lore.kernel.org/git/20241219-b4-pks-git-version-via-environment-v1-0-9393af058240@pks.im/
> >
> > [3] https://lore.kernel.org/git/20241220-b4-pks-git-version-via-environment-v3-0-1fd79b52a5fb@pks.im/
> >
> > [4] v2.48.0-rc0-38-gff795a5c5e
> 
> Thanks.  [2][3] are something we have to have before we can tag 2.48
> to have a healthy build with the usual Makefile; so is a working
> Asciidoctor based documentation generation, so building your doc
> toolchain fixes on top of the fixes for 'GIT-VERSION-GEN' does not
> give us any practical problem.
> 
> Thanks for a fix.  Will queue.

Thanks indeed, the changes look good to me.

I guess my key learning is to do largish patch series like the build
refactorings in smaller increments next time. I considered doing it
several times while implementing the series, but shied away from it. I
guess it would have been easier for everyone involved and would have led
to fewer issues though if I did split it up.

So thanks to all the people that are helping out in this context!

Patrick
