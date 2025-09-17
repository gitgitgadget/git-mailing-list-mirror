Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A594834BA42
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 16:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126335; cv=none; b=OL9VQ9P9at1X8IB9vOUUvKpsjlc22+WJxELTJy/hiR6ArVEOPqd5C2TuYg8O8AlISQFNiY7DXmKUIzVr+T36qSF+asriXUKDXAmm40y6/AbOWfz5tp7rQemUY8K5lXj3DNJ8H5hH9ZO/qr1ZSK4U8Wd+gOywhGouKdymLUadlQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126335; c=relaxed/simple;
	bh=XVBZ+OPFlLGRd5H98xwv9Z1zhT8KdnI+hBY8wQkw9X4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fRD14JYaj/aTDTISSeQOiSSHvGPtAZ9/dRE5iSdNpyRloMn3ZVTis9cGrWTWjzZdFiLU1e5+fmP3mN82gLTaLFBHTBqO1fW5EXqhB+cIVWiA8HjLDIRnPPcvyZC57iwyWgFIZBchbHtrLJt+nwvWnil7GJAFqc1NdvSb2g5jwNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=no0er2IQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KKOzyhqA; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="no0er2IQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KKOzyhqA"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BB51E140013D;
	Wed, 17 Sep 2025 12:25:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 17 Sep 2025 12:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1758126332;
	 x=1758212732; bh=2TnRFXHWOG4N6UjHoJSw4KgfIHTTeAUWzqqOnq2LCkA=; b=
	no0er2IQmXbDWx2URroLKu1dUxytQbAE93Qoa207f1kaFFIIFD49mZnXuGpjE2vV
	LL1MiNJeUlyGZPx1D2Cbh0dC6ekA4UqWWpx7gQfWmd1p34eYBIM9ZKFG/8oEMtku
	+z/qH+tu05V+EMfNHXEboDHAmFCPjBT7EeYx4chT4Pw5BBDxad2Iz7J/o7kBumrz
	SfabfbbXgEm3uC5UKlqVMv9LAQlCjRRcPhViv7eaxuVy9dhXP4YX27aMY6GzkG1A
	Tj4HFgOjGkcxCu2DAjXuKejKB6H1+slAsoOJp2DZQQPFzM18YBb7/CFbS1NbK7QH
	Kbe/EcL1mZmBCslFUztcqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758126332; x=
	1758212732; bh=2TnRFXHWOG4N6UjHoJSw4KgfIHTTeAUWzqqOnq2LCkA=; b=K
	KOzyhqAJycK0wh2siNE3/Io2IUUK2AB5guML+wltk9aJ20F8PTkphtPkaIVMuCpS
	TwZNcraYsB4knxrNvdgTIqSIz3ed+nFlpEnfKgRK4v2Y4mSPG3bTPFPClO+Dzfre
	KMFzEr2XqNVjjThveXd36a5kCgbVvZKb7HLdWE3SmZx8WOMTP9e+z2dqjX06qfmC
	iMfmX4JuafiGIOC9nfIFsgQRasZTj3t5+duSzobZpFG6f03bj21zhqLU07O4n1jk
	l308zlPQOT9UX6TOnQBODVJdOzVUIn97UfgNxUgWcdEgyw9ZYEa/blfyeywOLbPA
	H9UE35goncxobURstztAw==
X-ME-Sender: <xms:_ODKaGg1HkBF9Dzr9qY0KHhpkuAwwks82tmihGqF4E9Pkz2Dd9Sadg>
    <xme:_ODKaEkJ_MchHbm1s-ed52t0_v5CzzPWfK32_vNLVk5dwJtoFSONXk2xLNZ2uzK0s
    58gCmHfO7o7Wp6aFg>
X-ME-Received: <xmr:_ODKaEj4ogK1A0h4oeEAxRmxqurdWYybN7PaLcFYdpwXInICGAbieD1F0Oq3B0WAY8zTk9rpmnrBqQtdRnP_VjMr0jfzWmbAf8x_7Qg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegfeelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpd
    hrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehs
    uhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:_ODKaA07iSQxDhZohqGXU24I-6CAZSRCs5ZoujdSeuVza-YP38Dd9w>
    <xmx:_ODKaFIyxeFUEA5FrQv0mc-4o-5GKHpTbXZEiBfPGlxWgTJ43QKTSw>
    <xmx:_ODKaIx0nj85EtwY72ROadLIH5YufYs-pbwiB6osw6xb6MEnueJULQ>
    <xmx:_ODKaLViptqOZ_HjH5RK5ZE5nSDJ2mzmoJJDJiwNdNbhmLGQ2O9G8g>
    <xmx:_ODKaPyF1kBT5y1W6Ece52nAcNCk-Z50ZU4uBG0KqYY0AjNUUfJnCAeE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 12:25:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: "Jeff King" <peff@peff.net>,  "Kristoffer Haugsbakk"
 <kristofferhaugsbakk@fastmail.com>,  git@vger.kernel.org,  "Eric Sunshine"
 <sunshine@sunshineco.com>,  "Patrick Steinhardt" <ps@pks.im>
Subject: Re: [PATCH v5 0/8] you-still-use-that??: improve breaking changes
 troubleshooting
In-Reply-To: <8673bb92-6bc5-47b8-bef8-bd59669f095f@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Wed, 17 Sep 2025 17:41:18 +0200")
References: <cover.1757446619.git.code@khaugsbakk.name>
	<cover.1757879060.git.code@khaugsbakk.name>
	<xmqqy0qffrri.fsf@gitster.g>
	<e4fc3b83-15ca-4844-92c6-1f41169161ed@app.fastmail.com>
	<20250916232446.GA1189675@coredump.intra.peff.net>
	<8673bb92-6bc5-47b8-bef8-bd59669f095f@app.fastmail.com>
Date: Wed, 17 Sep 2025 09:25:31 -0700
Message-ID: <xmqqa52tdp1g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> Draft of the commit message:
>
> -----
>
> Makefile: don’t add whatchanged after it has been removed
>
> 07572f220a8 (whatchanged: remove when built with WITH_BREAKING_CHANGES,
> 2025-05-12) set up the removal of git-whatchanged(1) when
> `WITH_BREAKING_CHANGES` is active.  Part of that work was removing it
> from `commands` in `git.c`.  But the the Makefile still lists it as a
> builtin .  That leaves it in the limbo of being linked but not being
> callable; you get the generic error about not being able to call it as
> a *builtin*:
>
>     $ git whatchanged
>     fatal: cannot handle whatchanged as a builtin
>
> instead of the expected:
>
>     $ git whatchanged
>     git: 'whatchanged' is not a git command. See 'git --help'.

A change very well thought out.  Thanks for fixing my earlier
breakage.
