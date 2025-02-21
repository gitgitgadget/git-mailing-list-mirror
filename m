Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729D31BC09A
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 21:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740173489; cv=none; b=DuJy7Lz5o8mIIfN1SB3Sd8PJ+uI6Qov/UGHg9aBTcWh4MJ1TTMw/qAL9CacJylsE7paD7HEq2kYVR9r6EqHuLYiqeXQp9t2IceHmaifJVPpBypxQcQ59wVhFgMnC2vQBLpn7UcfHiuUaAEo0iNZvcrSHNmc24tqk2ATVJktfzqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740173489; c=relaxed/simple;
	bh=cboQUSc9Le2mFu8mdsBbs/4+dsleavm1NkjtrRX4BcY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hp1sLT4f5pxborDCHTkFZOKEXt4w8a4KAUBtbwhbQ2ZcK0zAaC8r8cxWkl1Cds20yV/j5Mwt+sN2HTiDvrzmSYFir/WzHIcYM74Fq3+f6BKQz5PsfIl2P1HFoROgux13aob8WRyChcQOznllKNMFsH5rlWSsm0IDSpgsGei8Yh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=v4sTIk7V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=6ZA5ckTT; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="v4sTIk7V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="6ZA5ckTT"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 603A12540169;
	Fri, 21 Feb 2025 16:31:26 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-13.internal (MEProxy); Fri, 21 Feb 2025 16:31:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740173486; x=1740259886; bh=U9Q5GHQnPS
	MYq9z0gKLDSrfaZ4eS8udkBdUArDwDWAU=; b=v4sTIk7VGPqyANZvZ4giaSSP9Q
	5h9RRFjhnWfyL59rOr/bM5xTvOFYOiw5Ym70JXQTA+KCe3KHWdrMaJGIq0IIuL+G
	BgUkgVjaf8E/IUfczhW4eWlAhdYMVgY4H8scfXSOMWXF/d4EDxwm90GkI8bsNwlh
	KIw5KPB3ZRRokpG+Qk08f+VrckFl5n7gwCf32dy8S3bSLrwV1u583nhSFOT09IJV
	8anBqAVXtWb70rDBfLH4xB2gSIg9AtnHMisFE8B2r5NvD0ABcD8OKnnthe0uc8ep
	UCO7muKq95crT8u3uofaM1ODeo/fYSu748cNXRon2zuhWaJkSdP7CnXvNSVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740173486; x=1740259886; bh=U9Q5GHQnPSMYq9z0gKLDSrfaZ4eS8udkBdU
	ArDwDWAU=; b=6ZA5ckTTLXu4fu6o3nxU++ECaxQbtXWiWrDNARKDChduQQUwXag
	/4N2NcPPnDxRj2u5hAks6cx7HmZNBUbti/nEP2oglnhlQJK9Ipk5pVpMBt6eVaLN
	iccjp1tDv8UW7v1yd9Di3t/5R32Y7FylcnOHBiKBAV9qTGu8AbDFHuu7kWsFty1T
	gCBaj4/7TUySBNUvBLtjdeLXUSloYyWKbtNFG1JlOCZdN9vNIJ/Nhhuiwa99K5t9
	lg9ZMqaPA2JEAoKwe+q7sf+0m6pFlvZNCX9EU3S7iaU7nUhYwl/va46R7udqHdc4
	s4gzwvwdqVLBe7T6vj0w4l5g1ZpU7uouL6g==
X-ME-Sender: <xms:rfC4Z6YxpOHE_BmPcxM50Sv-A5mYPpkmMfQcTYKpnq6UWpSC4jcQuQ>
    <xme:rfC4Z9ZjgpggAue9Iq2EQehqO5G5qeOM9yJw4d0rmCrJ9yG6myHz1-opiqqrhbJM-
    _YGZkh4Utsu4vJCCg>
X-ME-Received: <xmr:rfC4Z08e36lbWa_XOFI2FRLtyNrzxsPqFHdJJGrHjfRWdT6Pzq-ruu7MO8L_6tRtigyu26B_6x83XANxDhgR9-ecOOmaGD6ad0diggo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejuddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrg
    gughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdroh
    hrghdruhhkpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:rfC4Z8pN8oBCQ-xuSOWMSqnPooOYGMj8LX-ufDnMxmP2dOJFEt7kbA>
    <xmx:rfC4Z1pfirdIzexTsUiI2SJt_2g8j7foe7VO887bm2CC6eTiwL2o6Q>
    <xmx:rfC4Z6QRdOtLORAsdluhuofDuVJHf6tLBc7nXUx479g6gex76exgyA>
    <xmx:rfC4Z1psEna3cF-RczFM6wwLlTUlrDAO-wCUNmP6D7t4HgsbJK_2BQ>
    <xmx:rvC4Z2lsn41L3sMRhiAsW9AV7ZGZICXTKFIdjfgQArwIAJCi-h7OEXxF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Feb 2025 16:31:25 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 1/2] add -p: mark split hunks as undecided
In-Reply-To: <43a0592a462cf68bcfdc54373da2319431c3c1ca.1740149837.git.gitgitgadget@gmail.com>
	(Phillip Wood via GitGitGadget's message of "Fri, 21 Feb 2025 14:57:16
	+0000")
References: <pull.1863.git.1740149837.gitgitgadget@gmail.com>
	<43a0592a462cf68bcfdc54373da2319431c3c1ca.1740149837.git.gitgitgadget@gmail.com>
Date: Fri, 21 Feb 2025 13:31:23 -0800
Message-ID: <xmqq34g79e8k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> When a hunk is split each of the new hunks inherits whether it is
> selected or not from the original hunk. This means that if a selected
> hunk is split all of the new hunks are selected and the user is not asked
> whether or not they want to select the new hunks. This is unfortunate as
> the user is presumably splitting the original hunk because they only
> want to select some sub-set of it. Fix this by marking all the new hunks
> as "undecided" so that we prompt the user to decide whether to select
> them or not.

Good.  I am very sure that the design of the current behaviour goes
back to the very original version of "add -p" with hunk splitting I
invented; I simply never considered a workflow where people may
first select and say "oops, let me take it back and redo it".  What
I am getting at is that I do not think the current behaviour is
something I designed it to be with too much thought, and debeting if
it makes sense or it would be better to force them to be undecided
is probably a good thing to do now.

Having said that, I have one small concern about forcing them to be
undecided.  This now allows it to

 1. Add the whole hunk 
 2. Go back (with K) to that already chosen hunk
 3. Split

and makes the resulting minihunks more obvious, as you do not have
to use the uppercase J/K to visit them.

But if one is very used to do this intentionally (as opposed to
"oops, let me take it back"), this would be a usability regression.
"Ah, here is a big hunk with 10 changes, most of which I like, but
one of the lines I do not want to include" in which case I may do
the "Add the hunk to grab 10 changes, visit that decided-to-be-used
hunk, split, and then visit the one minihunk that I want to eject
and say 'n'".  This makes the workflow simpler and more stupid by
requiring the 9 minihunks to be chosen individually after splitting.

So, I dunno.
