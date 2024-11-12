Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF0C203708
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 15:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731426988; cv=none; b=CAPYwrP+odMwWenINiN1Ahn9OoNZay8ZqETmjPOsQAn1dqJjwaYpdKQBE//dAOcCE8bqWVQ0FqdmZWMgKB3y73IF1fcspoK7B561SkiUQIEApHtqb6GbX4TAP5GZhUxK8lq/uFYsfRMHIGvdbYSB9qUr4PfAGwZ2KVVU7XC8e9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731426988; c=relaxed/simple;
	bh=H8jjSfVmW/T9Jnjvot6tADATCXhr5A1Bm11Y5fSbnBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOd2BQMWlxmcAE7x9iDh52cTlkDll5n+ASpaFdI+I6une9ooXbKoDq7p77z5bEkb56/7DSwh5JNjxcJ4rypHLcx0A+Phb681+1g03U6YRnyehx03G9GVcKcT2+rRkttnLS3/kbH79jr5XwSKmqtpwpkHpGX4IkTUohMEMBFEk7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W1bEh0dB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SHaUxrrc; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W1bEh0dB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SHaUxrrc"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BB01F2540106;
	Tue, 12 Nov 2024 10:56:23 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 12 Nov 2024 10:56:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731426983; x=1731513383; bh=P2vw16kgly
	ODiPtxpjpLyRt6WoWlpyKDLFm5ar4X6q4=; b=W1bEh0dBsJ9ppMPJY8kJ8ZtQih
	bvln8/UWQev7jBi9XbSOChLf38WPw/lRS9lpUFRLr2x77iFV9F1mi4+E1BKZBW5J
	rc+WvWvDjwfY2zjJtmFnt7c2ACm/MywE0ej01kom6aTWGeQCAsDP9bgtA3ZefNxk
	RlTnWbdh48wI8tBZtg4pC4PrJsBzus4jPaYSREk4piYf8BjhJinqRfIglGl/FsKu
	DWrFO60Dx8+GOnBDLokXjOmGWaPi5RkP73jePSVJJeeKCMJNKDprw8AckEx2KmCZ
	2ydqIPSydyHEFezQn+OCcd2J4czwyn9uNhu84rlKKc/VlG/OqzqtY0rQfTkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731426983; x=1731513383; bh=P2vw16kglyODiPtxpjpLyRt6WoWlpyKDLFm
	5ar4X6q4=; b=SHaUxrrcnmjfOcaRdZZ3pMDYE5k2YJsBY1tSGcqCq7LLmVPKqAL
	h8B2H8tnVHNyU1Xo/7R1TSoyFpkCuQZhRno/W3YrLIxzUikHOz6RbN0SIVRwG47n
	SUTQL3vIUpjYGHd3f1qItRyi1N+vXuVSDnF0o6Y+ezIWFTk6w4UtTitelozGpE+/
	HnEMcVUyxPAUIA3IGkwSQRY3WCtoZ1mIPOljh9se9mw/3okX4sEgJVr3oAu78sQ7
	E2MrUZBK08e9XZwpm9qJ07cUr/+q189lteXsrg7n29KKzgqyfad8Wd3w6nI1cgL6
	bDVoWhE+xtUj7feFKbKFP03aVHbyEJhssEA==
X-ME-Sender: <xms:pnozZ2QCsYxqH4TrdbzeK-R28nKFTOgaJdB9X_OJi410HI25A_2r-A>
    <xme:pnozZ7z4qSNYZHLMtaz1vD9wmzWWTvFczzCRJoghkaAUjJKJbu3uJhbIrdbwJxlNg
    crECoOLUx4JlufbTQ>
X-ME-Received: <xmr:pnozZz0oiDGQ-H9aChj9l_9VWTEMbi8e2LRUzjbqpqefZDLQyxRtYDZxWxPZt5Y3BaT3dFp4I7nmF53mZVhBw35RIz3SIUxdCYTERlfx1iWjB4s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggdejlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeejudehgfevjeehfeeugedvgeekgeeugedvgeeutdefledv
    vdfgieelvdfgjeejffenucffohhmrghinhepmhhuohhnrdgsuhhilhgupdhsrhdrhhhtne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehp
    khhsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehmvgesthhtrgih
    lhhorhhrrdgtohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrd
    hplhhushdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpd
    hrtghpthhtohepuggrvhhvihgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhs
    hhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:pnozZyBcP65MPU08aq0HCUo2XDZOHKUFW8RyqUJ5QWfxFvUhhzZgkg>
    <xmx:pnozZ_i9ggdL7so5VAUGhc4AymiUVzFaqSgv2hIBkTg5JuTqJAO9Pw>
    <xmx:pnozZ-pO3lpCowOgKnYhK1OwV1RcB1igUZX6HBnqjGOhsJ4wlfmapg>
    <xmx:pnozZyhn44kUjGEfCuPoqdxwNF2C_VBdlPBpj6LJySSlyWNLSql5rA>
    <xmx:p3ozZwWaNfePQjjZJ8CzNa7sVNbfGN_MRZRP2tcmPfVqgsb6R0K5jF_T>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 10:56:21 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 44d147c3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 12 Nov 2024 15:55:40 +0000 (UTC)
Date: Tue, 12 Nov 2024 16:56:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: David Aguilar <davvid@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [RFC PATCH v4 00/19] Modernize the build system
Message-ID: <ZzN6kM7Ee-JZjam2@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729771605.git.ps@pks.im>
 <Zxv4osnjmuiGzy94@nand.local>
 <Zyi7PA2m2YX9MpBu@pks.im>
 <ZyjlvNJ4peffmGZ1@nand.local>
 <Zy9ckDezMSKVA5Qi@gmail.com>
 <ZzHeMjqUjzWpdX-Y@pks.im>
 <89a2621f-2c30-473b-9a0c-48135244f33a@gentoo.org>
 <ZzMyf2GOtmpMhKNH@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzMyf2GOtmpMhKNH@pks.im>

On Tue, Nov 12, 2024 at 11:48:31AM +0100, Patrick Steinhardt wrote:
> On Mon, Nov 11, 2024 at 04:48:14PM -0500, Eli Schwartz wrote:
> > On 11/11/24 5:36 AM, Patrick Steinhardt wrote:
> > > On Sat, Nov 09, 2024 at 04:58:56AM -0800, David Aguilar wrote:
> > >> The one thing that no one has mentioned is dependencies.
> > >>
> > >> CMake has less dependencies. Python is arguably a liability in the build
> > >> system arena, and Meson requires it.
> > > 
> > > Eli has menitoned [muon](https://muon.build/), which is a drop-in
> > > replacement for Meson written in plain C99. I don't know whether it is
> > > currently able to compile the Git project, but if this is going to be a
> > > concern for people I can try to make sure that it does.
> > 
> > I was wondering whether I should say something, because I don't really
> > feel the criticism was on-target to begin with. But...
> > 
> > I am delighted to be able to confirm, that muon works quite well here.
> > 
> > It did require two small tweaks for not yet implemented features in
> > muon, that meson had and which this patch series depends on:
> > 
> > the iconv special dependency, which I provided a patch for:
> > 
> > https://git.sr.ht/~lattis/muon/commit/75d33f6b6d482344d969e4ad6ce1527353f91cce
> > 
> > using fallback from gnu99 to c11 for the sake of MSVC, which I reported
> > and got the muon developer to implement:
> > 
> > https://git.sr.ht/~lattis/muon/commit/a70e9687f3bfb8b9c21baf9acdfe84f97a42b11f
> > 
> > 
> > (Note the commit author dates by the way. I had the same general thought
> > about whether muon could satisfy git users such as, frankly, ones more
> > interesting to me than "python has too many dependencies". Such as
> > perhaps HPE NonStop users, and I tried muon out a month ago. Yes -- even
> > though I am a *meson* maintainer, I consider this a useful alternative
> > to have. Meson's FAQ includes discussion about whether it makes sense to
> > require Python, and notes that we specifically avoided providing any
> > "provide your own python extensions" functionality because it would
> > prevent being able to ever rewrite in another not-python language. We
> > also document muon as an alternative in our FAQ.)
> > 
> > 
> > With these two small changes, muon compiles git successfully, and passes
> > all tests but one:
> 
> Thanks, I'll have a look at the test failure.

I couldn't reproduce the test failures on my system reliably. I did
notice that some of the tests are quite flaky, and that seems mostly to
be attributed to file descriptor exhaustion. These problems go away when
running `muon test -j1`.

So maybe there is an issue to how file descriptor are allocated? That's
just a guess though.

Patrick
