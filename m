Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D481A0711
	for <git@vger.kernel.org>; Mon,  5 May 2025 06:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746427178; cv=none; b=FGvTm8fud15Jg/aud6wfA8Sg0kX6k7YtHAecfkmjO1UQPlWo4RCYCsStnFrPb78y/Hz7tmK7WiOfSMmJHIQe1ZymDrBzewwOJzSf4Ddic2v4zr/RYW5h8wyZy5IgZ8rt90pba4VosBW1buan2xj0MuKwcmLCeqDWv1shPDleQdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746427178; c=relaxed/simple;
	bh=heXZNgoxRfCaYHYqDCpLY5YVNN92nj5/wZcZJ9T/4Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uY9Jz/p5pu6umrlWEik1g+xuwkAeo5CuErIoMsybmtImWceSf2wEnRHlSaqb7ElfdSwZobiEvFu+QCyeBIN/1Q69zcJqM+M6jRbC6TgGLovKnbfox8tzXfMtju8cwwl8ljaF6TYIJGVQsjCvGJR9TPvhyvBnySwFCuO7wHdI6iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kKDyVl+O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MCkAPRcF; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kKDyVl+O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MCkAPRcF"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6491C25401BA;
	Mon,  5 May 2025 02:39:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 05 May 2025 02:39:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746427175; x=1746513575; bh=T24FipdKe2
	3yXObqkvb8TryyCiRwRaFb/4wpPNTc2ww=; b=kKDyVl+OeWe2xYLOV9/6RtGCna
	iDpw35jVl/xo5zbI7m2fNMoQ1oXneQZBgPTdSnUobWHzdnTglxHwGGjxdL7uf2tY
	7TxN6Y4UKNj8oWnx/DYEKBuFT9y53zP+1TG0OH8JZpSUQTrLC3cE5L46gqIMHZA8
	7ZB019mwJpaNWWzfAa7P4fmylG5mcSYoYUWvhBNbGGmJRI8Jv4mM4iE94aA9jNYI
	gjYy0jYUaRKiDB5WZNWA1/dmdfrIJc3iMi1Zwft1ytcjc717JBx/QG4ahjCyOXEm
	DnWq0LLzZ7y+T3PbX7h3K/3fLt6tBtSkzei27UJNuU11RmqOfnbicimVTzzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746427175; x=1746513575; bh=T24FipdKe23yXObqkvb8TryyCiRwRaFb/4w
	pPNTc2ww=; b=MCkAPRcFOiH7aJpzAWLcY/xiWEBWvS41Ja9YxSdfEQ1SiyudK5e
	ooPIo7IV1oxMfR9rL1/uU4sla0u9o5f/avPdgs5IHFrr/MmUAR8l8N9f9XuNs3ld
	GjEvZdhokF1uhP0Ov7qxpyIPm5SAe9Rqriazv7oL57jFGKxGGl5FDFkphtaKlkOZ
	tczfQgZWjGWnVcFRJQUr3iuPplfWypVyXWjEimj3HVTxomZwORyhiRNtJFogrZvP
	MeD3QOMEtZg95qlOuUGrmfItMPkyMtMxV+KK81ExXDKN7WUue/P7ulduzxYjjb6h
	90mN3G60XIxXnYfML5x06GLM/TyxS3IDaew==
X-ME-Sender: <xms:Jl0YaDrZWxXI7bv9oMl0yh42ssfMRhkRnVli8oDlBSskm1ULyt3Q_A>
    <xme:Jl0YaNq1s3JTmvKelGOUCruuYpAkdxIIXiDYDhoN5m_Tdcallj1wOFUH3OgmW1-Q8
    hOn7mpcpVprON8fiw>
X-ME-Received: <xmr:Jl0YaAOiPvQAyXTo0iW5MSkWK5c2R4Ixav8fhe3iwZjrGo5rxE2hq3TwaEU8b1UKZ48YdI7UIKWMGEzglzknUcdvR1Ko5RgZmSwCLoSsVZih_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedtgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthi
    htohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhmpdhrtghpthhtoheptgholhhlihhnrdhfuhhnkhdusehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:J10YaG4Z4X3xFh_C8aZ3LlmK8L9eMcsm7jYNmiOG3KReZOyGUHRX1A>
    <xmx:J10YaC5sXOduOPmcN0kFgGXvGrmP4TLigcLyMZWqnNeh6cZEDocZxg>
    <xmx:J10YaOj_2aru-OdsJgS4-NwAqmgCYe7HWF8oS3pA-009O58NKoGeOw>
    <xmx:J10YaE73OSeqMIrVTpysOGf5VB4PAvYqJbg-UgbAoVZrSt2tPxw0sg>
    <xmx:J10YaKkLZkVayvLWfWgPv4kPG5jioyivyEZ3aOw8uYzTHLAUPfbSIexV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 02:39:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 673f624b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 5 May 2025 06:39:32 +0000 (UTC)
Date: Mon, 5 May 2025 08:39:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: shejialuo <shejialuo@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Collin Funk <collin.funk1@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] wrapper: Fix a errno discrepancy on NetBSD.
Message-ID: <aBhdH9jWpnpbkPHn@pks.im>
References: <20250502233403.289761-1-collin.funk1@gmail.com>
 <aBVp51yLwxBpRskt@tapette.crustytoothpaste.net>
 <20250503133158.GA4450@coredump.intra.peff.net>
 <aBYvMjtGjzEhKg4s@ArchLinux>
 <20250503154928.GA3412@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250503154928.GA3412@coredump.intra.peff.net>

On Sat, May 03, 2025 at 11:49:28AM -0400, Jeff King wrote:
> On Sat, May 03, 2025 at 10:58:58PM +0800, shejialuo wrote:
> 
> > > PS I notice that this same function reads the whole packed-refs file
> > >    into a strbuf. That may be a problem, as they can grow pretty big in
> > >    extreme cases (e.g., GitHub's fork networks easily got into the
> > >    gigabytes, as it was every ref of every fork). We usually mmap it.
> > >    Not related to this discussion, but just something I noticed while
> > >    reading the function.
> > 
> > Peff, thanks for notifying me. I want to know more background.
> > Initially, the reason why I don't use `mmap` is that when checking the
> > ref consistency, we usually don't need to share the "packed-refs"
> > content for multiple processes via `mmap`.
> 
> You're not sharing with other processes running fsck, but you'd be
> sharing the memory with all of the other processes using that
> packed-refs file for normal lookups.
> 
> But even if it's shared with nobody, reading it all into memory is
> strictly worse than just mmap (since the data is getting copied into the
> new allocation).
> 
> > I don't know how Github executes "git fsck" for the forked repositories.
> > Is there any regular tasks for "git fsck"? And would "packed-refs" file
> > be shared for all these repositories?
> 
> I don't know offhand how often GitHub runs fsck in an automated way
> these days. Or even how big packed-refs files get, for that matter.

They typically are at most a couple of megabytes, but there certainly
are outliers. For as at GitLab.com, the vast majority (>99%) of such
files is less than 50MB and typically even less than 5MB.

> The specific case I'm thinking of for GitHub is that each fork network
> has a master "network.git" repo that stores the objects for all of the
> forks (which point to it via their objects/info/alternates files).  That
> network.git repo doesn't technically need to have all of the refs all
> the time, but in practice it wants to know about them for reachability
> during repacking, etc.
> 
> So it has something like "refs/remotes/<fork_id>/heads/master", and so
> on, copying the whole refs/* namespace of each fork. If you look at,
> say, torvalds/linux, the refs data for a single fork is probably ~30k or
> so (based on looking at what's in a clone). And there are ~55k forks. So
> that's around 1.5G. Not a deal-breaker to allocate (keeping in mind they
> have pretty beefy systems), but enough that mmap is probably better.
> 
> I'm also sure that's not the worst case. It has a lot of forks but the
> ref namespace is not that huge compared to some other projects (and it's
> the product of the two that is the problem).

Yeah, the interesting case is always the outliers. One of the worst
offenders we have at GitLab.com is our own "gitlab-org/gitlab"
repository. This particular repository has a "packed-refs" file that is
around 2GB in size.

So I think refactoring this code to use `mmap()` would probably make
sense.

Patrick
