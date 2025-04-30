Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC0F1BD9F0
	for <git@vger.kernel.org>; Wed, 30 Apr 2025 23:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746054644; cv=none; b=mwgOOUgOZtALYd+WTXIKxCmzY9k7xJlrJH3HyO03M55zsXiImWIwTUJTu0W61BDjJZeavq955Q3ORII4hzs2A6wtjsvmD/EbhDympAfpqki6xh5cNL6yqjBYYumQ9dGBTd+qmIjp914+EiKrK4jSq+OksrP56qZviI9M666A1pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746054644; c=relaxed/simple;
	bh=P13jIGnRpsQCrTbbCqqdk8F+zoa0NIRK9mrziQ0iggc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uU8GzI5bsHF+l139fhjfpjXVoxmqEoJH+g3vj0CouUvZq4T4pGw8ZBq/UvEMitYqEo54F8ml65Mh2SS/9rnWZjnHP8MFa3NjNHeUJLmps33Eyd+vjwW7ri5iHCHEX0TY5Qo60HV9Y/OlalIwAC+uPnAVG1rsrYwacyiEldAXhuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WdQoes+L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gLPLd3ub; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WdQoes+L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gLPLd3ub"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 716DC2540249;
	Wed, 30 Apr 2025 19:10:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 30 Apr 2025 19:10:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746054639; x=1746141039; bh=olUtd3uu/F
	7M17R3waKP9dyC+3mf/Zkp8MkqPKsUzhg=; b=WdQoes+LkTb1rLcLN9jfcVPr7s
	NPd5tpws3ZyTwGPFKydSTq5cA8m8ZEcaSUDXObFoh+8O2sMYNWcjuAl/fRoULH7K
	qog3XP31V5perY59m5bGmxtjqyKzYw/0PW3p3AoBpQfX+pJd4dn1jJN6v6S6w//l
	WPb6ZGWegeX5g+NYCbB5sIneHKKrcevvV3bGT2+c+DmxU6sA9ezCjlW9mF5QAHAP
	1lu+YebZHut3uG0fZQRpvRlWRtS+JiAJeGuJW5fqZ0g8burYiZ8MmugQyWIsI9F4
	BLBeCVw34EMiSyCzo+9Yd7CUteU8JZiln9sECKDvv43MFGcXEOt/uFt4TqZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746054639; x=1746141039; bh=olUtd3uu/F7M17R3waKP9dyC+3mf/Zkp8Mk
	qPKsUzhg=; b=gLPLd3ubyzGjzGsjbl+4hFx7KsNLSAOl2hTtVyo0p80bQBbNuDd
	9nUjoF0l2aUr5hlA5ZHnRuCBsMl2Zvu7jl/bik5aEPN4lLb3ti8tCwHt574Ymnw6
	gH5I5L8qRctpPH+E1wTid6dT3CGct2q7/4mwdsA9Vi4v78BOjnAB7rU6JL5XLknF
	IhKxTjFWRAVcfLEQaxpi+bJcx1ITwkUkMzlR/IUbzys9eLOwbuuBSCKz7WLw1DdK
	Zxdk3HbGgjAEacxv5vOtt1kCFptsUYucor+uE+WEp7rr045LHHB+RXzwrqNMN/rB
	hAZp8drsx0SKz3vTTbRleywIGTHm3tfwLEg==
X-ME-Sender: <xms:760SaFNcJiwGhYonYr99WmDkZWkwlyhW0vvs16nxqftZ0EJSGFwmeg>
    <xme:760SaH_9waFTC-a3f2cSz099nkgeaBAdcSF6tvDeCDww7qzDajNfBdls_B7qEa7ha
    aHqkSxp4EJwCc4Fdg>
X-ME-Received: <xmr:760SaERhzfN7XH741MSc9ycuZ-vuYnkkeRFUw8NvnFGAqICQNhNt-h9iK0nBM0xTl4BnjEMGc07gLqbVyUBlYoDhDSCzG1Ln8S9E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieejleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepffeiteeujeevfeehuddvjeduffeijeeg
    fefhtddvkeefjeejhedtgeefgfeijedtnecuffhomhgrihhnpehgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehg
    mhigrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:760SaBvuaDvR8iKl3AYv0cgnNHBDCHRcqn2FOXhZ8EZnnwqUSQU11Q>
    <xmx:760SaNdnwbhNCH9AWaz4Udu4cbJj6kMJ-y4jvYbMv_pXZ97Y_3fk0w>
    <xmx:760SaN38vhpmB5PIdenEJCfJLUeWqP1vSFWGzMQbvg-56FnH8XXVCQ>
    <xmx:760SaJ_J2S7FofC3Wow0uIJv2Q6ynVOm4jSpWbeF0k9Hy0z0xndpYw>
    <xmx:760SaLtf4yRaEp6QxEQD3Uei0GDWi29rM9nTXi4GmnS-9WJkwHVFDxF->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Apr 2025 19:10:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] builtin/mv: convert assert(3p) into `BUG()`
In-Reply-To: <xmqqr0191oaz.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	30 Apr 2025 11:45:08 -0700")
References: <20250430-pks-mv-parent-child-conflict-v1-0-11a87c55ffb9@pks.im>
	<20250430-pks-mv-parent-child-conflict-v1-2-11a87c55ffb9@pks.im>
	<xmqqr0191oaz.fsf@gitster.g>
Date: Wed, 30 Apr 2025 16:10:37 -0700
Message-ID: <xmqqecx9z1n6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> The use of asserts is discouraged in our codebase because they lead to
>> different behaviour depending on how Git is built. When being unsure
>> enough whether a condition always holds so that one adds the assert,
>> then the assert should probably trigger regardless of how Git is being
>> built.
>
> Nicely put.  Yes, this is another reason why we frown on the use of
> assert(), in addition to the reason why why Elijah's series that
> ends with 5633aa3a (treewide: replace assert() with ASSERT() in
> special cases, 2025-03-19) was written.
>
>> Drop the call to assert(3p) in git-mv(1) and instead use `BUG()`.
>
> Being explicit about what we are unsure about is always good.  It
> would hopefully entice those who want to get their hands dirty to
> see if they can "prove" that BUG() would never happen, which would
> be a great outcome ;-).

By the way, with this in place, and without Dscho's "assert() makes
Win+Meson test job get stuck, so let's make assert() a no-op" patch,
the CI seems to be fine.

    https://github.com/git/git/actions/runs/14765572702

Triggering assert() and BUG() are something we would always want to
notice.  They should never trigger in production and it is an event
to call for fixing the underlying cause that made the condition
trigger if it is shown to end-users.  Dscho's patch protects us from
addition of a new test that triggers an assert().  We won't see such
a test get stuck forever on Windows, but by turning such an assert()
into a no-op, we would waste electricity for running CI only to miss
the triggering assert(), which does not sound like a good use of our
resources.

So I am inclined to drop Dscho's "build in release mode" patch when
we merge this series down to 'next'.  Being able to notice a
breakage (which triggers a real assert(), whether it is due to
broken code, or due to a broken test that documents a broken code
path---which should be rewritten to use "if (condition) BUG()"),
even if it needs to be done by noticing a test that gets stuck,
would be much better than missing such a breakage at all, and that
is the primary reasoning behind my suggesting to do so.  I would not
be surprised if I am missing a good reason or two to make build
tested in CI ignore asserts, so let's hear from others.

Opinions?

Thanks.
