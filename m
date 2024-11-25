Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9816218D64B
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 08:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732524989; cv=none; b=L8Aaf198mwK2B34wjBKLvig87ghqjXSd4iTkkgNLnLj+5K6XO2KXriC251mNMr0ZYEy2ZS80AdA0B6fwWvniQcmtu2lggnYpbTyxo0e4zyK+kd7MgbQygeTdaAcW8b25sKyghpTKzgoxIRQ8ZZn4NLheNVHylyU4qxi9TMdrglc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732524989; c=relaxed/simple;
	bh=/U5/V5yvhUEDGezqY/gtShi5v3xBysnOhV64+06UUms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvqTu8C70v460zY6NdECIeK09Of+wxtXdAtDOMneAC+/borzfi59osZV31Jl6p3Zh2AyVqF65yR6xPYTgA7IP7Ba39/y444jNth9Hb3GX01YtbKGY1IeZrd6/YRWJi++vhkc9HpusiCOEYF5HeBfnaGQVsZ5dcqdjJSg7l2P4KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=syxgv7nH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OoFmK9bf; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="syxgv7nH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OoFmK9bf"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 5C84911400CA;
	Mon, 25 Nov 2024 03:56:25 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 25 Nov 2024 03:56:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1732524985; x=1732611385; bh=WF3f7dc5KM
	zWpjilRInfAWU++VUW0ILpCmc/4zlrq/M=; b=syxgv7nHWdcQl8Lf/gDDTQ2n8Q
	ely7R6XaXc/mIrKGZISL48FatwkK4yi9YVgqHsRLI6kH7HkgNZimiayXG+ZuQkZh
	BMJDjwkIlnsOaJQIQuXYkzSYQ5ix0J83DLs0hbncLNwtsrGkam0EnVWLbBwKhox0
	qCOJktBYUwBP0LO3dDLEAXhvQVZj3enOAJqJxpk6Oc9RmIOtt3McjptgD5IZV7g5
	pokvRpsHaj868ZOaGA9KP5hGwaq3t2oJRBAt4OdNGnhiYFXw4Cxm+0jkjszd+fL4
	tOD+Egdpo+iPZV0ffeCreNWuKH6Mw1F+A/8AplGwskw09mgyEN98U7tEvtzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732524985; x=1732611385; bh=WF3f7dc5KMzWpjilRInfAWU++VUW0ILpCmc
	/4zlrq/M=; b=OoFmK9bfuHGsSYX2ms5Facf7Bp7qNRzGB6wcEC0wmBk7fHpi+kn
	a/VL+a8t4OPCMS13TxkvBferu6LcUfoykGfN5ymy932DXhR2JIm3T38JzG/McFhV
	inUwnr0ZxqrCthyTefhgit/pvSjsoYuPOF5krE+yDYlqUlNBHnI71vUiHIsedh2m
	TcS/5/5kHcXd6ZAxvi/RFGU8E/P6HZ4mm9ZTPnMUGEUJ/jHHffKkobmwKOnPYiaw
	HajnSxLOiWxELv8xsFjsGMwqZ5swCkVeOPyZBB2HvPids1AyLeVGfXn4ncGPlNYT
	qxClAqaY7yZ8ev5u9N9bE/5dyojYdyyg5qg==
X-ME-Sender: <xms:uDtEZ4ICV0s_yc6Cr1ZK7IZScDdyVAQTQOlXA16jRRA40dLoZGo-fA>
    <xme:uDtEZ4L5GpRF-XAyeBNi5mWqrQJts9FCtq2mGNEN1gLACX-PN_U1nDnqpQroluT9O
    qvr0kxcwVP9O1hjaQ>
X-ME-Received: <xmr:uDtEZ4tg3wJqW0kS0kelhj0ZQLPXDXjYJrG7clBJodZ8NgR-6TBQuCZiELcKmONuuO1MFY7SCdWRhzCeXNT8VDsNGQtN2089WkcYQmLXrIW-Og>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepudefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhhn
    tggrihekieesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtoh
    huuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthes
    ghhmrghilhdrtghomhdprhgtphhtthhopehjohhnrghthhgrnhhtrghnmhihsehgohhogh
    hlvgdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohep
    jhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepmh
    gvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:uDtEZ1Zp4LiLYlSMIqmzDGjBna7TCW9mHr_2HXxw9Ro94-JGfEn5yA>
    <xmx:uDtEZ_bhu0G676eOGfrlMpT3UjEfW60Hwd0gch9Wyyy-V3MBn-Bw-Q>
    <xmx:uDtEZxDWsO34A8AZwOB6ViXe0SIFl6PL7gHddEE617F983jC-MwkPw>
    <xmx:uDtEZ1YW-73ZCmUaNRYxAI_LwQpQPP-l86eE0_jkERFX2WFS0fpWOA>
    <xmx:uTtEZ7rBcn3u4G9NiYaj_B7v3EC6cpbqhyF8i1ksO5KCgpR7hSYLMmo7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 03:56:22 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b79cbe26 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 08:55:20 +0000 (UTC)
Date: Mon, 25 Nov 2024 09:56:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, johncai86@gmail.com, newren@gmail.com,
	christian.couder@gmail.com, kristofferhaugsbakk@fastmail.com,
	jonathantanmy@google.com, karthik nayak <karthik.188@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 0/6] PATH WALK I: The path-walk API
Message-ID: <Z0Q7oGF6Q5U-f4VX@pks.im>
References: <pull.1818.git.1730356023.gitgitgadget@gmail.com>
 <pull.1818.v2.git.1731181272.gitgitgadget@gmail.com>
 <Zz+61fat+vGgb+xL@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zz+61fat+vGgb+xL@nand.local>

On Thu, Nov 21, 2024 at 05:57:25PM -0500, Taylor Blau wrote:
> On Sat, Nov 09, 2024 at 07:41:06PM +0000, Derrick Stolee via GitGitGadget wrote:
> > Derrick Stolee (6):
> >   path-walk: introduce an object walk by path
> >   test-lib-functions: add test_cmp_sorted
> >   t6601: add helper for testing path-walk API
> >   path-walk: allow consumer to specify object types
> >   path-walk: visit tags and cached objects
> >   path-walk: mark trees and blobs as UNINTERESTING
> 
> My apologies for taking so long to review this. Having rad through the
> patches in detail, a couple of thoughts:
> 
>   - First, I like the structure that you decided on for this series. It
>     nicely demonstrates a minimal caller for this new API instead of
>     implementing a bunch of untested code. I think that's a great way to
>     lay out things up until this point.
> 
>   - Second, I read through the existing API and only had minor comments.
>     I read through the implementation in detail and found it to match my
>     expectation of how each step should function.
> 
> So my take-away from spending a few hours with this series is that
> everything seems on track so far, and I think this is in a good spot to
> build on for more path-walk features.
> 
> That all said, I am still not totally sold on the idea that we need a
> separate path-based traversal given the significant benefits of the
> full-name hash approach that I reviewed earlier today.

The repo size reductions achieved via the path-walk API was only one of
the selling points of this series. And from my current understanding we
will likely not end up realizing those gains via path-walk, but rather
via the much simpler full-name hash algorithm indeed.

But there were two more selling points:

  - git-survey(1) as a native replacement for git-sizer(1). I think it
    is a great idea to have a native tool that allows us to gain deep
    insights into a repository so that we get better signals from our
    users in case they face problems with their repository. I'd love to
    have this tool as a baseline for an extensible format where we can
    eventually also start reporting the health state of refs as well as
    any auxiliary data structures.

  - git-backfill(1) as a helper to fetch blobs more efficiently from a
    promisor remote. This is a boon to have as well in our odyssey
    towards a better UI/UX with huge monorepos.

Both of these tools are quite exciting to me, and there is a need for
having such tools from my point of view.

The question of course is whether these tools require the path-walk API,
or whether they could be built on top of existing functionality. But if
there are good reasons why the existing functionality is insufficient
then I'd be all for having the path-walk API, even if it doesn't help us
with repo size reductions as we initially thought.

Patrick
