Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470F7423A99
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 07:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768981172; cv=none; b=fGfP/62wuSJ03XYSKpApYITerLfT7G21YbFciCN10KGfnBWQeUd8AL79zc8hVs06uR77rP2rzZy6Bgqs6JmNnqUKTDxDWhwii61Qp73Vpzx4AWpQvf0IWK2sMbMKGMe6zxoz962o4zWWDq7JagsF4s6jkjIpNCo6nKz1BnplMOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768981172; c=relaxed/simple;
	bh=381X6wKHVE0MTVeqNye12SGquziceJS4/zHJ7JpGIj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDx4+aYjXqc82w+xNkdsVHLU0IyKYgzT/62MssIDyXQH1wlr18UqkNCsWpXefvys6+L0nvYydX1Zp8Uci0h06K9WzBvcORZaJWanKn2of4UsoufYZ/XFswlwlx2zr361tAQWPteFogn2aptLmxqzOTRXVbztfPJyB1HDZoNb3oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fWmyXBqt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zl11GZVm; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fWmyXBqt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zl11GZVm"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CED427A00C4;
	Wed, 21 Jan 2026 02:39:28 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 21 Jan 2026 02:39:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768981168; x=1769067568; bh=dBLy5seWSe
	rT0BRl1lbyo9k8XuZy01ecOcxRtF/sYSo=; b=fWmyXBqtBCm4GfqxceMnCkjtXm
	JAdj5B4BMBmOCbzRsaCGQ8R9ei5P5X/ZP83puQN4Gs7DHwSGAgpX2jRRJ6IjhBXa
	0EhSebaHGzZ0vMRHxw+vk2+V2wfJZHBtIoJ3E5IvgASBX1VXwrR6aNmpo6aNbDl5
	sb6MeeibEYcOZLFfXkvGCDkoIUVMszGtShPUoUdK8wVvwbxrRAO493f9MCrXTKqD
	GiHtA8OGaqNzlskTthb4XSqSscgVcVagkEmWinBTupJNrvS1oFjq4Uu4Orhh23KS
	/znkDdsN+0h+pO9Ok0A04MRtj2fDhdKMXuRwADdWtJEDZ/zacfuclkAZu+eA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768981168; x=1769067568; bh=dBLy5seWSerT0BRl1lbyo9k8XuZy01ecOcx
	RtF/sYSo=; b=zl11GZVm1GfvGS1447d9Jgp74Nt3l2/lrzwj9cbv7AhhVI1MjHB
	k7fjBIlufaCI7c2AVuqFtyd5S9pEj2qjAQKPYlRSGgJUdMJvjgN9E8WJmYqPjBQx
	f85UzkJiZ6oFq4aqhtyFTdTXEAaEzPhvL+itRNs7SKaNR9Tabq2U/v0BPvYduTAe
	NxY47OkwwyKwpAgYevKS0Tey6/L2nCIglcJV8xAPdrEHkEi6YG1qrHs7estDg3nl
	USc/zHSBI27zl3iHI5ONqhQC9izf05Zw+CMJ8uF0AtLNAc+Q3Ep4bfQv8i/NE/cB
	f14/EouedN7YEPCoBP5Wuu6hUyqZfTmEJ9A==
X-ME-Sender: <xms:sIJwaTvfoQxCGNxLAN700f5w85je3F61VboCInTKc9nPYDE11i9wbA>
    <xme:sIJwaXDukvYK8Kn6d7C3o3fZCgDoWB0Z7cSfZIBZbAQwSa9-vnRj2JJB1ty3kzn6J
    CObVnyBygKMwzcLKeZFOQkA2X06ZKuILeFXsX0A65bhZhzdC957AQ>
X-ME-Received: <xmr:sIJwaab6JXUfq00cRVksZ2sFJGjMF4vKbAZwzuX01woYfSJbwcHUQDRbarQc7ukrmZcvafq45TqcjqWSZMouE7Pn5N6xsN1fDjnp0ehNOb8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedvjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvefhfeeftdetleeugfdtuefgtdekuefgleektdehgeeikeduudeuveeghedukeffnecu
    ffhomhgrihhnpehgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeel
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehophhohhhorhgvlhesrhgvughhrg
    htrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphht
    thhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtth
    hopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhgihhtghgrughgvght
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdr
    nhgvthdprhgtphhtthhopehstghhfigrsgeslhhinhhugidqmheikehkrdhorhhgpdhrtg
    hpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:sIJwaSWS8RJMumL9tzqH1MSqRNL4ps-uEZ-vpIQrsVytHPg4JV1T5w>
    <xmx:sIJwaZOnxGsjl5gJMTShlqB8s1G_lG5mCk28f2E_Wb9EoBFgTg2OeQ>
    <xmx:sIJwacYhb5jy4BRONyXE1fFRKVs1rA3Rlkc9tbf1fYZokM2Xo55FTw>
    <xmx:sIJwaY9BOF-zOgBh3lN-UaxfQInRbvUrEeEMNqtWb1L-HG_EXkrIBw>
    <xmx:sIJwaVWI2H8K6m4gDU0MUIhueIHdx9aLK7PQwTXq319IllGUEba7Nlp0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 02:39:26 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 80f539d9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Jan 2026 07:39:25 +0000 (UTC)
Date: Wed, 21 Jan 2026 08:39:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ondrej Pohorelsky <opohorel@redhat.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v2 4/4] sideband: add options to allow more control
 sequences to be passed through
Message-ID: <aXCCqvGBl24yVgI6@pks.im>
References: <aWKLrIefrcSwReu2@fruit.crustytoothpaste.net>
 <20260115211448.GF1053259@coredump.intra.peff.net>
 <xmqqa4yeblsx.fsf@gitster.g>
 <c0af9072-cf21-a7e2-5b78-eb70217b462c@gmx.de>
 <aWnekt4ESo0bKpOT@pks.im>
 <CA+B51BEs7kuJ7s+K2vbZLSoaq3krGrqVncQAaTjSSNazFLY3tw@mail.gmail.com>
 <xmqq3445bn33.fsf@gitster.g>
 <aW3bSYCIPMhJT1mf@pks.im>
 <aW6tMtg0pEKq23TX@fruit.crustytoothpaste.net>
 <xmqqa4y81ag8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa4y81ag8.fsf@gitster.g>

On Tue, Jan 20, 2026 at 09:05:27AM -0800, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
> > I'm not opposed to adding support for this as an opt-in feature for
> > those people that want it, though, and I think that's the right path for
> > including it.
> 
> Yup.  I am hoping that there are no folks who think that forcing
> this filtering on everybody is so important that it must not go in
> unless it is enabled by default.

If we cannot agree then I'd rather take the opt-in compared to having
nothing at all.

> I however wonder if we need two different levels defaults, depending
> on where the user is going, to make it less painful to configure
> things.  I would imagine the remotes one would interact with fall
> into two quite different categories.
> 
>  - The ones that you talk with every day, essential in your work,
>    would be something you would have to be able to trust and if
>    these trusted people want to give you a bit more colorful output
>    from their hooks, you shouldn't have to manually configure "I
>    accept colors from them", for example.
> 
>  - There are others that you will visit for the first time as you
>    try to discover new good things.  These you may want to be extra
>    cautious about than the familiar remotes in your everyday work.
> 
> Perhaps "git clone $URL" should filter the terminal output by
> default, but once inside the resulting repository, "git push" and
> "git pull" from the established remote that is used by default when
> you do not say whom to talk to, our default can be more lenient, or
> something?

I'm not sure this would help protect our users. If we had an adversarial
remote, then it could trivially work around the protection by acting
benevolent on clone, but malicious on subsequent fetches. So it doesn't
really seem to significantly reduce the attack surface, unless I miss
something.

I think that the other suggestion you made further up the thread would
make more sense in this context. If users can configure this similar to
how our "http.<url>.*" settings work then they can e.g.:

    $ git config set --global \
        sideband."https://gitlab.com".allowControlCharacters true

And from thereon they would always trust GitLab going forward. I guess
that most users would really only need to configure two or three such
domains.

NB: This ignores the fact that GitLab.com already behaves well with the
    proposed new default as we never send ANSI escape sequences other
    than color codes. So I assume most domains wouldn't need any
    configuration in the first place.

Thanks!

Patrick
