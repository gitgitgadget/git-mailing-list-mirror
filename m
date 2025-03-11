Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A394222F169
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 20:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741724005; cv=none; b=uBfmxN/REvsaWhdkHinn0JC0F3XESDBdTFX11KQDw60Ywynmxel3GYeBbEkZcl0FUFGjef4KmRMYEI8q8N7Byu+9ISKlzsKdOvlqQwSY5q0Zco2zGLDUaQG2ZMRf8ZpVUZSlnCHxSAyCU7ocIGJ+zUEd8I52wnrH7mK0cnLMqBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741724005; c=relaxed/simple;
	bh=Q31fNJX9Gyf25CEnMfDyqt/gu7vHyVdgL8T2LKZv2mY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WOUemIElR9/J14KzN7rdPMwMRucW1w71ib4bj0kea6NykNq3PHEAaR4SAF5pwhZaIaT+mWdvxUbWSMzMkpfR8l0ELwifZzvH2kp7GVv/lXLlHF232Vex5RqcjqjhyD0QzBgIeYeC+co3XvVaEjpbAZSonu5DaMiAq/t8mazoxlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=C401TTqv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oL58jnwB; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="C401TTqv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oL58jnwB"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id BBE5E1382DC3;
	Tue, 11 Mar 2025 16:13:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 11 Mar 2025 16:13:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741724002; x=1741810402; bh=k1iCUWIn0i
	61AXTRDMrFOOc4jF+121HnSxEKEdm0LPQ=; b=C401TTqvexGMke0sc/EzYSKLQn
	Rlf2eIrIU5tKAs5gigSASNYfnNbZfpaBBlWxxvV0boOdX73p7MY8F059Zzq6cUcL
	7FImJ5dG0lQvLi3uOQ0nyVeXrSGsQZj/OunE/BH4xnO12QYaqBPFbLX1Z0AGwtll
	hj+q8ia1iyPYpmi/iG6PWRYqt7YmstQrG+aBuOmaHR8kWz6n0HYE6cJp1tpf/JlC
	J1w9VDtRI+AMlqIx4sFdL0hU/EG8Fsa+SgW7gCe+/ytYxmmJ1lwohcYuQgBWUAD9
	cj8UeZd7RYjy8Sft7INSbEzt1sjWSYALb17WxVtd525MKOV/U6h+tLIwPylA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741724002; x=1741810402; bh=k1iCUWIn0i61AXTRDMrFOOc4jF+121HnSxE
	KEdm0LPQ=; b=oL58jnwBbuqM1tFxsYAMAcUdx3TiZpfV7gigZdCmpqgaj58Pc3k
	dLRVdbv/EEkKOSxbSHDu59cNObruQty/IIb3CTwkWBDMJ7lR+89fPiNHa70fQAWN
	Cv18beXd10qCanTy8tPrEI5V9mPWzjaqYhxDFLTDI0vIhVOIhRohYZXYyky3hKK/
	6niXk5auQp0yguXEJ+RWYxTwtk+/oKI7JIjPdIRLeG9Q14UwoPQPZ2Wiu6hINF7M
	LB4yE2O1Y1al+eKV/idDMErEgEDz2Ac0GtPCIHQgW25iAMGutSKMk8zc/CmcyTD+
	EFw8vf5G5OIttkQFxnxUnk6PgR+OZZPHEjA==
X-ME-Sender: <xms:YpnQZ3seRrsAczN-9d6aHSU6xU6Oo9mqUovcjvoB2GsWtXYMLDWepQ>
    <xme:YpnQZ4eYl8cmEqMVBRnpL5yrygrjb4pSCZN5V2zfLGIe2cgL8QC4bR1t2zAuXoC4r
    YsZn24-px8tFUmy3g>
X-ME-Received: <xmr:YpnQZ6yTadS0SZzzm_Mss7djWd-JaT7OL1-azni9qfQ39_FNviqjxUCT1vaKfkcRqCOIquuV8x2Zi8bZve4y4n7zfwvl5yao0s-E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdefudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehnvgifrhgvnh
    esghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:YpnQZ2PUE9vbVeicVsLHj1dcVijQRhmM4tgVvl3ZAnav48MoaX_XFQ>
    <xmx:YpnQZ38kyvnu53m81etCfiQnCRqHA8uJBV0XSE8_6QdYZuAiZgZK5g>
    <xmx:YpnQZ2VA1j_ttQNhTgjlJZ3cE6PuXM0SV0ViP1u4zFt7IrSVvFu1lg>
    <xmx:YpnQZ4e6zRGiRWpNX2FZ4TLWbRexQjEFCCzqTXj_fGhyMro1x9HQyg>
    <xmx:YpnQZ3wYNLT_Dylie5TD57bbw-iKsQ8qjvpcNFYEdW99GyM3DY67bPM->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Mar 2025 16:13:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 0/6] pack-objects: freshen objects with multi-cruft
 packs
In-Reply-To: <cover.1741648467.git.me@ttaylorr.com> (Taylor Blau's message of
	"Mon, 10 Mar 2025 20:21:35 -0400")
References: <cover.1740680964.git.me@ttaylorr.com>
	<cover.1741648467.git.me@ttaylorr.com>
Date: Tue, 11 Mar 2025 13:13:20 -0700
Message-ID: <xmqqr0332un3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> Here is a slightly larger reroll of my series to fix object freshening
> when using multi-cruft packs that I have been meaning to send for a
> couple of days.
>
> I realized after sending the last round that not only was the first
> commit from v1 flawed (for the reasons Patrick identified) but that
> there is currently no way to grow a new cruft pack past the configured
> limit.
>
> Independent of this series suppose for example that we have two 100 MiB
> packs, and the threshold is 200 MiB. We should able to in theory combine
> those packs together. But we can't! The largest pack we'll make is
> 199MiB (and change), since builtin/pack-objects.c::write_one() will
> refuse to write any object which would bust the limit given by
> --max-pack-size.

I am not sure why that is a problem.  If we have many loose objects
and the threshold is set at 200, wouldn't we also give up at 199
plus a change when packing these loose objects into a pack?  If the
last object that makes us bust the threshold is unusually large, say
50, we may give up at 150 plus a bit, unless we go back to the queue
and pick smaller objects among the remaining ones to fill the
remaining 50 minus a bit, and because we do not do that to enforce
max-pack-size, I am not sure how "give up just before the threshold"
is too bad and needs to be replaced with "give up just after".

Or is the problem that the threshold is applied differently based on
where the objects come from?  E.g., packing many loose objects would
stop just after, but repacking from cruft would stop just before, or
something?  If the problem is that we are inconsistent, then I would
understand that it may be good to make things consistent.

> This series resurrects the first patch from v1 after introducing a
> behavior change for 'git pack-objects --cruft --max-pack-size'. When
> given with '--cruft', '--max-pack-size' now allows pack-objects to grow
> a pack *just* past the given limit by at most one object.

And what happens when the last object appended is very large, like
70?  Would we end up with 270 when the threshold says 200?

I still am not getting what you are trying to explain in the above
two paragraphs, but in general, "give up just before" would be a
better choice than "give up just after", exactly because the threshold
we are letting the user to give is the maximum.



