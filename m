Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8C115574E
	for <git@vger.kernel.org>; Mon,  5 May 2025 06:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746425340; cv=none; b=kA6zyIpU1EXKusdx7bJWDbKs/RWO9nXjrsoWTqL5EnSaqeu1rsjJeEygyeuHL5eB93JiJyoBSSe5x/wol00zFRCNJ7BJ5yQUWwwurtPRUf/OahGzYRTYmdtCP8U6bHOICAR+rDXvMThFuONCLyj22fsQrmJH4PtShUeok5/P27g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746425340; c=relaxed/simple;
	bh=dgfymXHEAReHZiD9UOcCNE5XS19PEBCXpHIF7iF/suo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WS1g9pPzO/fJ9lebDLwzxOwETFcdq1mRZ+4QlqmeVT5++Thm5Ry53t0R8YSF7j2dCfgPGPHtccZ6Nhe4HxCWKD/W0d3Fvo9Zja9HOxnR7xjIJf7fzA6X2y7jV2wdxPd8FmwgRgrQCcnKfJbHWNqtX1RU7xWg1/S4o3x2oNGtD0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vYc/zQhn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IHBYcgC8; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vYc/zQhn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IHBYcgC8"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id DC3511140189;
	Mon,  5 May 2025 02:08:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 05 May 2025 02:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746425336; x=1746511736; bh=qzYfwr2al0
	6aJwR8gT5Blm/KieK4wwz7rlo/Wo7kDcY=; b=vYc/zQhnz2qd2OKrnkvh/Zvd8u
	qMDfCd2N9y6ET/NmSnFifoz2IJiZhrmyzShIIs1ZFVSYzbtACCcPSwFogWLJgUwA
	wEcrDcxOy8dRsZaHnuXWbZlhA8TtCAn02qtEfpFJbbRO/ZXePLPMw4NCkgnu6+Y1
	cyKdzjE53JZGfLQjv9KbMLbz7Azs6zb1f20HO+m4psZxyvu8/ptwEFk+EyVo3PlQ
	6Ti/8VxYy4xo24z4X95e9Vy3Nr+ddN4r8bQIPz1sCZhV5pS6wGm7jn/UwiNsIklK
	8hLOUzTv20mn1PzfjeUm/O/OtICFziF0IBtiMl/cDYzghhhEIpD/FQn3OuIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746425336; x=1746511736; bh=qzYfwr2al06aJwR8gT5Blm/KieK4wwz7rlo
	/Wo7kDcY=; b=IHBYcgC8Wh/1Ccn6BQKAg9xlB9U8RMEVPOHjmddLgQIqP9YP337
	9GtxnaPt8uwra8QWltlaDS3T9ceWwA09ANdQNnhaiO5tbr8d0sHk2DhgHlGHQy2g
	gvmMheAajs6gHZVPoWfbfqCC3bK+jjzTG1sl+k2g7e2lSE+XvEboyTBLMOVSR+yr
	I+G9F/4un/nHTlm/xFuOrE99rXEBM53e8VZZICkHTGPbxGp42MB41F+ySHcZeNzo
	WQH1J7R9X7UzgktTPqYS5ets5FfHmNCUPF/mswnkpFsnf5hVJY4fvBAfG+SI+YjZ
	aJtIm1eCzHENAwUoBRX7dQ/SbpYLp+QXfmw==
X-ME-Sender: <xms:-FUYaLSIOjRnMU1yptgJLYBbmTr45twQpm6yZ3_AeNzYyXbNwUz7dA>
    <xme:-FUYaMwIpDmlPrr27NTGPJu1uNJI3dh_syH4qzAJ1gCoe6mumxUbxKMC99H14u186
    ff8zfedKMIE1_XqdQ>
X-ME-Received: <xmr:-FUYaA1fL-ZhHqJppV35ITlC5x9C03Hn8AsbTv4shmYjHpCEJd8jwCGNwYhIMZHTMqghyoppdHfOdEnWSeuhJRA80VBYz541Pzngn0GIlUz6Pw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedtfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhsrdhrvghpohhrth
    esghhmgidrnhgvthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:-FUYaLCScLyh-8AlFKxnUL3lRAKFrMt2kg5n-_2Gjr8CiitVMBwYGw>
    <xmx:-FUYaEhZPHZKo-g0eHU1iBABE9Rfpw5IZ7d671JVfUW7r39VOPPcow>
    <xmx:-FUYaPpPL885aoSjxeYCdZlKGRFyurPnq2054MuwsZkPsjdTxmqPuA>
    <xmx:-FUYaPg6FbKOJpUZ5DDrMZ8ckRZPoLF8oXTo03RdyJpCRv65AvNwGQ>
    <xmx:-FUYaExYhw2mDFHdQQC99eytjV6XO3h0n2b3MLz79wpHgxZj0SZobKQI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 02:08:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 72357001 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 5 May 2025 06:08:54 +0000 (UTC)
Date: Mon, 5 May 2025 08:08:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Peter Seiderer <ps.report@gmx.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 0/2] meson: prefer '/bin/sh' over PATH lookup
Message-ID: <aBhV9SNm5G-g-sRh@pks.im>
References: <20250424-pks-meson-posix-shell-v1-0-45e06ee4b6ad@pks.im>
 <20250425-pks-meson-posix-shell-v3-0-01607a2e9334@pks.im>
 <xmqqjz6yu30o.fsf@gitster.g>
 <c5486e20-dbae-4ec2-bc19-d5dc537a8399@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5486e20-dbae-4ec2-bc19-d5dc537a8399@gentoo.org>

On Fri, May 02, 2025 at 06:37:45PM -0400, Eli Schwartz wrote:
> On 5/2/25 5:16 PM, Junio C Hamano wrote:
> > So the discussion seems to have died out.  Have we decided that
> > unlike Makefile-based approach, it is too cumbersome to teach the
> > Meson based approach to allow user-specified commands that have
> > different basename to stand in for the command we expect in the
> > build based on Meson [*], and what the v3 iteration of this series
> > does is a good place to stop?
> 
> 
> I don't have any objections to teaching git's own meson.build to do
> this, and I don't think it would be particularly cumbersome. But as I'm
> not the person who would use it, really, I was hoping others would state
> their preferences.

It wouldn't be hard to do indeed. But I think that the proposed patch
should be good enough for now as it does what we want in basically every
usecase I can think of, and it does allow the user to tweak as required.

So I'd propose to go with the proposed pragmatic approach and then
iterate in the future if we ever see that it continues to be a problem.

> One possibility would be if meson itself was adapted to support setting
> simple "machine description" settings via the command line. I seem to
> recall someone had proposed at one point on the meson ticket tracker, to
> support e.g.
> 
> ```
> meson setup -Dbinaries.cc=gcc -Dbinaries.sh=/bin/dash
> ```
> but I cannot recall what came of the discussion. I'll try to find the
> relevant ticket after the weekend (going offline right around now).

That would be nice to have indeed.

Thanks!

Patrick
