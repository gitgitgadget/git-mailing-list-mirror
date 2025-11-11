Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DACC17555
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 06:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762844094; cv=none; b=FhhqOSVFERfO9o6+poS8YNWQp1oWtk+NMsDaVTJfoBYmskp9hXe7Qy5f7LbZ6EMGpq/nbtWldP7anFo4RGA82CYnyvJZFj5FCmKUNz0cAa83hqkquo1ivfT5r0co2L6VjkYUgcoVCnhHXmTtKMWubLZlVCTuysCU9foMINI3hY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762844094; c=relaxed/simple;
	bh=EM61IeWx82Qnuzdyzzgxs0EPnA8q9TijcBfCfUIPJeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXuI7ewusQEK3/6vKMveFvChYQkttY9X2TjPlXg/QbUFmQscblNjllO3u4HIfMxNk40SHYHm2S7zCeO9n2wNfnKHx+w67hymNDehPthL3UGDjO+eutv4rLFELFEaPXx5Mj3Yu1dTIyziYGOsHQkzocCvMMYdV7HZCCTEmbjmcH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nXmICWwx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mwly+3Ce; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nXmICWwx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mwly+3Ce"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 30A40EC0183;
	Tue, 11 Nov 2025 01:54:50 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 11 Nov 2025 01:54:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1762844090; x=1762930490; bh=4R1l0lOXL3
	1tiKzY6aalQ6U/+h346AhoO36/A3cLCMc=; b=nXmICWwxQcHhH32hExZnbNOQbu
	wGThPoOMxvE7S5N6VLYMck2mT4sd7MS6nneoRiJgdg1ONVno8tziLKrR+7z4niOP
	hEUt6B020l0TTP3hKK4FapsLilN4eEFvL+hPUKr/zUpqUaU/9iHsLob6DY/+lWnp
	yLTNKm71Goq4LepDQ4i5A9VWS++Y8Nfezvmr91KjaboVt+jSM0DR44IVEShAdPQT
	21VZwPmgf7ACODi9bawtrwLMKyeQ5civFJEm1HfGFN7VzD81nB121fjdZCaPQFgG
	Gh3rfkSv4sJo2na3AoDt0LxfaZqqT1RNWIY4Tz9PILjrHdDqkW0pU5d7CsKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762844090; x=1762930490; bh=4R1l0lOXL31tiKzY6aalQ6U/+h346AhoO36
	/A3cLCMc=; b=mwly+3CeuMesb2L/kKQbfrdNKSW3UmNxeYsre167Jz7d08D7uaC
	l0OYFdELDnoZfeVP+1hHjBT9GH4dZB8ypGXn7RTu58gTLJ16YTMXvEh7hb6nhjZq
	6yarfE44xQ0Y302/6p+Tw6k1wiCrw0Qv9SVlzASNkCdrW3ZwWqSHT2jVlgmLPin4
	+/s8BpTVWgodGwf9yVAwcT0RvqzJZKW+ZHm5jVJGCSW4Oa4rzEYu29q7DdbHsICc
	k1pRlyBlca/lbakCI9JMWubtYhjrcEoqoh9lW1lCiT6DQnH2kBhL7bfwsexcpbS2
	KIS4Q4fZMcFLd0mT8NlKphvY6DpTNrOMvxg==
X-ME-Sender: <xms:ud0SadHM1wy6jblYtlMeOtHboOIFJ1RUv5HVHA96Z1saAdlHIkCT7A>
    <xme:ud0SaTBpQfez7d6F955aR8lE0DgZQv8cySvotKiGuDo2jUBt1rsaRm5CnW876KcID
    u0yJG5Yty_PYz-9b3K93wwul2w4GWhzlHX_l4DosV2WoisgWlnG>
X-ME-Received: <xmr:ud0SadW9T-s1vqIWpC4POa2PwGHFNyfWV3W4kIiUTpzYtVAp8WbyLBed7aWTySYjYWmumDAVtL0YimVM2tpryJnLzMjJtjiSqfgc32iFYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddtheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprggulhhtvghrnhgrthhivhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfh
    hfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghi
    lhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrsh
    htvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehphhhilh
    hlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukh
X-ME-Proxy: <xmx:ud0SaXqRKt6FgV8Il7RwVHTFNBI3Jrs3Z2SS8tMYX5Vw4eqtLm8RXA>
    <xmx:ud0SaZToJTPofuPOJwtEXLwZpdBjUzzhYJG3OP9tn5lhqSAT47EmYQ>
    <xmx:ud0SaR368SRF1Qs5hhZ7c3H0Gx181gSww6FdwGLMKQ2NDKmV1okFAw>
    <xmx:ud0SaVBKBm5ZZ2oT5o1TgR3BYXpSgcQKuq677vclRoGdvIE8Dck70w>
    <xmx:ut0SaQe-KCScC1QvT-ufcUtJ7FHpuByar3rrq21IktETW6N2OxOxlihr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 01:54:48 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3020d8e3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 11 Nov 2025 06:54:45 +0000 (UTC)
Date: Tue, 11 Nov 2025 07:54:42 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	phillip.wood@dunelm.org.uk,
	ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH] commit: add --committer option
Message-ID: <aRLdsu-MUgPPdIgX@pks.im>
References: <pull.1997.git.1762683774166.gitgitgadget@gmail.com>
 <6be20c41-15a0-4732-bd12-4927a59a9f59@gmail.com>
 <aRIoleD6nP-kA4Xn@fruit.crustytoothpaste.net>
 <20251110201136.GB127132@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110201136.GB127132@coredump.intra.peff.net>

On Mon, Nov 10, 2025 at 03:11:36PM -0500, Jeff King wrote:
> On Mon, Nov 10, 2025 at 06:01:57PM +0000, brian m. carlson wrote:
> 
> > On 2025-11-10 at 16:50:04, Phillip Wood wrote:
> > > On 09/11/2025 10:22, ZheNing Hu via GitGitGadget wrote:
> > > > From: ZheNing Hu <adlternative@gmail.com>
> > > > 
> > > >      This patch introduces the --committer option to git-commit, providing:
> > > >       1. Consistency with the existing --author option
> > > >       2. A more convenient alternative to environment variables
> > > >       3. Better support for automated workflows and scripts
> > > >       4. Improved user experience when managing multiple identities
> > > 
> > > What's the use case for the same person committing under different
> > > identities? We already have a config mechanism to set different identities
> > > for different repositories but I'm struggling to see why someone would want
> > > to create commits under multiple identities in a single repository. For
> > > scripts it easy enough to set the relevant environment variables if a tool
> > > wants to create commits under its own identity.
> > 
> > Someone who works on the same project under both their personal and
> > corporate identities.  For instance, me working on the Git project.
> > 
> > Some open source projects also require a CLA and you have to use a
> > particular address to match the one that's listed on the CLA.  For
> > example, Google requires an address with a Google account, so in the
> > hypothetical state where I was going to contribute to one of their
> > projects, I'd need to use a different committer identity with my Gmail
> > address.
> > 
> > I've also kept business logs in Git when I had a small business and I
> > might well need to log approving a profit distribution (with my
> > corporate address) and log accepting a profit distribution (with my
> > personal address).  Those would need separate digital signatures from my
> > two different email addresses.
> 
> Is a "--committer" option the best solution there, though? I'd think
> you'd want to set user.* in the repo-level .git/config (or using a
> dir-specific include) would be less error-prone.
> 
> That doesn't help for using two identities for the same repo, but in my
> experience it is easier to use two separate repositories for that to
> match the organization of the work (even if you may sometimes fetch
> between them).
> 
> I'm not totally opposed to the new flag, and in general I'd defer to
> people who say they find a new feature useful. I'm just having a hard
> time imagining a scenario where it's the best option.

The reason why I find it useful is mostly scripted uses. Sure, you can
already set environment variables there. But from my experience,
environment variables tend to be a significantly worse API compared to
command line options:

  - They are harder to discover in the manual page.

  - You don't have any "guarantees" that Git actually interprets them,
    as there won't be an error if you mistype the name.

  - Cause and effect may be detached with environment variables, but
    with command line options that's never the case.

So I myself would prefer using "--committer" over its accompanying
environment variable any point in time when I have a scripted use case
for it.

Patrick
