Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E8236828A
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 17:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769104694; cv=none; b=CeEg12bMadHb5n3faIkBoFDBNSF2AnUHwO59HDuezESFiHAb8twJJ8FTrG+RmTfAYhUFu8RLVuFybKe9AA8/O7ufqbe2pRzldQwLh3mgjfOl3GS+srDcWgkw1hCkOAjItdDnyl5ymyol+KcLS/n7pJ0E0120ZVg6D9rDDYUhA7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769104694; c=relaxed/simple;
	bh=shAZ4qHCo+nAnG8ZDWx+fgANBp2mejnl2obKFPoJ6AU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OQ4CMROqDDs2YWsoM2SQ3snIXP7wlwce+BHdVfEy6bqPxDFg8J6MWdyaYFqRTtbQjGDOxTZZXyTltlDDhweOBWOuYItRWZ5avGQXAv/QeUtSttL6oTTH/TMjsMmooXCq84x6lI+WMPep0RmRROJnoBmAw1k4hkrEQgMSeSoltB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gDFwVcRa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mv9Q+Bi4; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gDFwVcRa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mv9Q+Bi4"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 58F55EC009E;
	Thu, 22 Jan 2026 12:58:04 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 22 Jan 2026 12:58:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769104684; x=1769191084; bh=1KO8wTXwgD
	rlLWy41uxLwUDpt1hn+YHPrK5bO14zMWc=; b=gDFwVcRaQf8KoskqRsrH9fs9uH
	zdCwMNBd1pgb9OQyaJhAoF4XkfNOpXb4w5G+x+QZUAqAlDYAhWpRA9KeSg+6sq6/
	NKnjpzZe3D3EPuSk5HgrfCnQpSyqbZme9EeNb7Z1Smn+yydobwCr+jlDEwL/dffv
	Rfj7cSmNm6/Dt9MZEvftDpenek9aFEcU1/nAFvDk7o9dmIHQ99wixQ5BVjEVNfIq
	0JWrcsvh7BJljkAT7fr9CdTqnq3zRcWt7IJuyx/I7Z/q3+4j9zZyRuC9aF/bmdxJ
	P9sAa9xZOVRoAuY+saM+uNxTRKmCI742ovvEVMDXZAb69GU7W0OR1Cx/d3tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769104684; x=1769191084; bh=1KO8wTXwgDrlLWy41uxLwUDpt1hn+YHPrK5
	bO14zMWc=; b=Mv9Q+Bi4HWWFDPaRxAtdmaDqERpIhZClO4LI5siouVR4gmkydhX
	4rLHJkJfbINiS/Im0yUlvWYxURndK/DWqVcyO10GrqNO4q6yaIbR2wOp/Yl05U3Q
	x1efVJK8bSv7Bh+RVFSdKFAA00dmtNp41ewF9KnRIn4wvB295YM/oF++ehjEXKpm
	JaHZ3ZILpGOs0RgKj6JyHq1ZrREIZNFnEAqYPx3z4HnqzOvzyk0nWSvi4/M7w+9H
	ALstRVRvtx3evHFgvb+BD6LDRUEDVNcuZ3RHfu5u2szVYA8SbsXv0zRV8NPba0PN
	wOxH+fILozCfrcDjvHM9Br2nD+2Z/fo2c2w==
X-ME-Sender: <xms:LGVyaUxGR8-aMGiECOL0iXzCSVyTLKxwifxr8AV1TAWreeU0gSXLfg>
    <xme:LGVyaU0dXXgNsEnHoeTUjB0Unp9HMbHvO_OXIX52haB1DmK6MrAhJOdBzgRNHznqx
    7YaarE6aJuo2bUCz_KA62fsScCm-nkFrBWFD2qow3sNgkA8HD8_YVg>
X-ME-Received: <xmr:LGVyaazgmiRTN574N2CkOn_CFFHc8UfQyn9q2Em_edQD_z3dlZDWowwIvU2_OTX8pWARU2R3dkQBFz3-IfvQFSJotSilhuhf0fukJdY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeikedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjh
    hohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepshgr
    nhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepph
    hssehpkhhsrdhimhdprhgtphhtthhopehophhohhhorhgvlhesrhgvughhrghtrdgtohhm
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtghhith
    hgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrg
    hilhdrtghomhdprhgtphhtthhopehstghhfigrsgeslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:LGVyaZUy0TIerLVi_3LdaSz2s14BHnvAWzn7b9_3hbKdqrHZZAAplg>
    <xmx:LGVyaW8__smYMkHJhGDDLDuTST36Q3Hgn31Er3REij5D9l76sudbsA>
    <xmx:LGVyacszlQM8UlE-UkSsywXQbe8rozh7qA8j05MnsOToJ6fvuPUjcw>
    <xmx:LGVyaW3Y8-8kDMV5eY20mWiZNSluravRJ812p2WwDkwXSVmSfC1EKA>
    <xmx:LGVyaQekRFMIDglbPapKFOtVKRIWcK2r00EF1cH6dNBw4ltxMaOUsXIM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jan 2026 12:58:03 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Patrick Steinhardt
 <ps@pks.im>,  Ondrej Pohorelsky <opohorel@redhat.com>,  Jeff King
 <peff@peff.net>,  Johannes Schindelin via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Phillip Wood
 <phillip.wood123@gmail.com>,  Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v2 4/4] sideband: add options to allow more control
 sequences to be passed through
In-Reply-To: <a51f9433-e82f-bc2c-5fc4-f8ae95a859f8@gmx.de> (Johannes
	Schindelin's message of "Thu, 22 Jan 2026 13:29:16 +0100 (CET)")
References: <fe109cd3319a5e3a1d1982a53963a601bb62b81f.1765981422.git.gitgitgadget@gmail.com>
	<aWD2x154F5f-c3pL@pks.im>
	<aWKLrIefrcSwReu2@fruit.crustytoothpaste.net>
	<20260115211448.GF1053259@coredump.intra.peff.net>
	<xmqqa4yeblsx.fsf@gitster.g>
	<c0af9072-cf21-a7e2-5b78-eb70217b462c@gmx.de>
	<aWnekt4ESo0bKpOT@pks.im>
	<CA+B51BEs7kuJ7s+K2vbZLSoaq3krGrqVncQAaTjSSNazFLY3tw@mail.gmail.com>
	<xmqq3445bn33.fsf@gitster.g> <aW3bSYCIPMhJT1mf@pks.im>
	<aW6tMtg0pEKq23TX@fruit.crustytoothpaste.net>
	<xmqqa4y81ag8.fsf@gitster.g>
	<a51f9433-e82f-bc2c-5fc4-f8ae95a859f8@gmx.de>
Date: Thu, 22 Jan 2026 09:58:02 -0800
Message-ID: <xmqqo6mlo7h1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I disagree with making sideband sanitization opt-in or weakening it based
> on a "trusted remote" heuristic. In this context, emitting untrusted bytes
> to a terminal without proper sanitization is a security-relevant bug;
> safe-by-default should be the baseline.
> ...
> If the goal is to mitigate terminal escape injection from
> remote-controlled output, then shipping it disabled by default does not
> mitigate the default case. Most users will not discover or enable a
> hardening knob until after an incident.

I think we already know we disagree on this point already.  I am
simply agreeing with what brian recommended, based on his findings
at GitHub hosted public projects [*], and what Ondrej says they have
been doing in Fedora, CentOS and RHEL [*].


> I don't think we can safely infer "trusted enough to write to my terminal"
> from "I fetch from there often".

It was mostly an attempt to offer an idea: "Even if we make it off
by default, we may want to protect the initial clone, and here is
one thing you could do...".  If it would not help in practice, I am
fine if we ditch it (meaning: default off everywhere, even for the
initial contact with an unknown repository).

> If the proposal is "full pass-through of all control characters is
> opt-in", or "full sanitizing of all control characters is opt-in", I
> whole-heartedly agree: That is already opt-in via setting
> `sideband.allowControlCharacters` to `false` or `true`, respectively.
>
> If the proposal is "keep the historical behavior (verbatim sideband
> payload, no sanitization) as the default, and make sanitization opt-in", I
> am firmly opposed: This makes the sideband payload remote-controlled; A
> security hardening that is off by default will not protect the default
> user population.
>
> Can you confirm which of these two meanings you intend when you say
> "opt-in" here? Once that's clarified, we can discuss whether the default
> should remain at "color-only" (today's default) with explicit opt-in for
> riskier sequences, or whether you're arguing for no filtering at all by
> default.

The latter.

I wouldn't be surprised if people, who usually do not participate in
the discussion around here, are highly inconvenienced when we
suddenly filter out IEC/ISO 2022:1994, for example.  Not that I
suspect that these character encodings are still popular in some
parts of the world, but that I fundamentally disagree with the
attitude "we explicitly allow colors to be passed so it is perfectly
fine if we filter everything else out".


[References]

* https://lore.kernel.org/git/aWKLrIefrcSwReu2@fruit.crustytoothpaste.net/
* https://lore.kernel.org/git/CA+B51BEs7kuJ7s+K2vbZLSoaq3krGrqVncQAaTjSSNazFLY3tw@mail.gmail.com/
