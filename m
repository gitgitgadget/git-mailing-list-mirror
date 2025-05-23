Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3156221547
	for <git@vger.kernel.org>; Fri, 23 May 2025 16:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748019260; cv=none; b=BeatcCaPoJ/OygkLvB5RPHQeiI0XRWkjpAZVFeTSuPcAyeT6NNLfEAW571ZlVCgcon+D4VVGmiYXivC7lvhnCuWN3AZpfyrViNWY+0WtWXiiD1ae0/BDZ3y/4iIj7UTlPL7+Y+MGm6ShNTweUXWJ+phrpqPYgV6l13bMYmxB26Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748019260; c=relaxed/simple;
	bh=GlS6lvnZNCDowv9IY8jWSopmXfpILJGkjFQD5Ncw4vM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oXz7NqbrJYGkSASM7pxqVKUo53kgGLvWHVankqDZo4lByNPQzwZ9H1uJfSDnT4uAv9qv0vx7+EwsprBCwdqVgfSLUuN4PxhpHsyTkAvDt1ZEGFBo7Lny+Gyap8WJiJZ18CiFEzjFFs6zuJxPhRzDHofce2t34Odn/NvM6IlMkcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=D+lWrunH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z479TVLH; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="D+lWrunH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z479TVLH"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8457C25400DC;
	Fri, 23 May 2025 12:54:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 23 May 2025 12:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1748019256; x=1748105656; bh=EfnEEgwEFd
	4lShm9jIuwfVpw8k+yYeG7uKbJL0uG1bA=; b=D+lWrunHImbqrH5b7CDsTu7jCP
	38bChHIfJQhjdNSydP6CTRYd8K2yMuMfDZBET9mOY9Pe5m2vkH/v+lUNXWzL8oRT
	Y0bC6Wux3xJLLUH6N6SZ8a+sSAnbBdL9KKNp+6SVGzVx5c8u6d7O3oFnsj8dlQvm
	RCA69Yhr6fvj+HbWskmTahrKAWtu4L/NNE2TM2YgsNcgqIcFe7kPCnmp3HcAGY0n
	iEVm0PnirubgMOA9qwnKZLukMVXLnZjm2BoT/VqQ/XqpkoUuCHr5zibu6khyuynq
	dxWT4ihUP+OzzoVdQMmIm+eDF38Wf10LDqO3tPINS1OifAcpoCjbn5xIIFAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1748019256; x=1748105656; bh=EfnEEgwEFd4lShm9jIuwfVpw8k+yYeG7uKb
	JL0uG1bA=; b=Z479TVLHqDWYTAztAumSYbmssL1cBO/gaGgV4I8er+FR7czhiMz
	1kqvERgBwn3YZXQyd5Jq7Bp293KvBtj2NkpMMqOVbKZz2XpD47dIEFbIRkk3bJp/
	f/P/OuDSLb6mJlaBstYVsBH3ivFUT5f4fpSaArURQQT4naZWd8VdFVwem8ynzbAV
	I6q+AuUoYOyCjITAqoVpERrS0b5CC5Q+VqV5XiQ/zfqHSdDlj633KXPNO8LxIt+5
	kuYJhOud1xE1/5+r1qqY+AaEQcKfQ3J1tYFc5cGhXNO9Ms20WKgy76vZ6PAVsMiX
	g5cqoboZ4wIarbmOnh/JdurjzsTySb1wvkg==
X-ME-Sender: <xms:N6gwaPOsvhyWZqTwsEximYwwilhRKVGcOZgkfCSB4c2C8DRkw1PV5A>
    <xme:N6gwaJ8RjP6UHuLr5pP4AEkuP-t0SdAifpzQaXPGVGFi_V9nNDDxvYqKt5xuHGeia
    Kwzyuz_0MnOcZJj9w>
X-ME-Received: <xmr:N6gwaOSybFFPQWYr922RvX2b9oogRc0BBhQ9v6iG3ELOHY-ccRNskhjP4mjBXjz8A98RGhAeuYVQumojM1wCXFxvVChN5HgHBZbo7bw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdelfeekucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeeh
    ueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepphhssehpkhhsrdhimhdprhgtphhtthhopehfvghrnhgrnhguohhlihhmrggsuhhs
    ihhnvghsshesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidr
    ohhrghdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhope
    hpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:N6gwaDtvFDslOduom12Jv8BIdlALqZTDhzn5upo6Bygeuvl4SI_EIg>
    <xmx:N6gwaHciSnSyOzguX7i4zytBYEVcRohk2M0qjxn_x7OZXVozgK7cxA>
    <xmx:N6gwaP0yIpchJjAnQPMcKJ9ygnBK5ywTy3SD2wh40YUjkDd6PQoHHg>
    <xmx:N6gwaD-VOO1pyjhBRe9ZHdPQeSXQKeteMj3KMAbR0aY2plEgpTkiHQ>
    <xmx:OKgwaP8IrqMJCHtJLG9oTCt56OWpOJs9iYYsibLcoc8xMsfkYjsCXyNR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 May 2025 12:54:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Fernando Gouveia Lima <fernandolimabusiness@gmail.com>,
  git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>,
  stolee@gmail.com,  peff@peff.net
Subject: Re: [Newcomer PATCH] log-tree.c: Supress Wsign-compare-warning
In-Reply-To: <aDCQWr3MBX4L7sbA@pks.im> (Patrick Steinhardt's message of "Fri,
	23 May 2025 17:12:26 +0200")
References: <20250521202409.26879-1-fernandolimabusiness@gmail.com>
	<xmqqsekx8yef.fsf@gitster.g> <aDCQWr3MBX4L7sbA@pks.im>
Date: Fri, 23 May 2025 09:54:14 -0700
Message-ID: <xmqqy0unxo7d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I'm still not of the opinion that it is garbage. We have tons of
> locations where we mismatch integer types only because we never got a
> warning from the compiler, and these have caused multiple stack
> overflows in the past.

I know we spotted many possible overflows and wraparound in the
past, but -Wsign-compare being not about sizes but signedness, I'd
consider them more as happy accidents, rather than intended outcome.

If the code had 'a < (int)b' comparison where 'a' is 'int' and 'b'
is 'size_t' [*], the code would still be wrong, but the compiler
would not have said anything.

	[*] which is what a typical "I've suppressed the compiler
	warning that was annoying me" patch would do if the original
	were written 'a < b'.

'a -= b' can be equally bad depending on the value range of 'b', but
it is not about -Wsign-compare and would go unreported, right?

So I think noise from -Wsign-compare are certainly not "false
positives" (in the sense that the comparisons are between signed and
unsigned---the warning option is reporting what it was asked to
report), but are not-false-but-useless positives; what they try to
catch is somehow different from what they could catch to help us.
And that is why I have been skeptical.

> I do agree though this not a good project for newcomers, as fixing those
> bugs is quite intricate overall. So we should definitely remove this
> project from the microprojects page.

Yeah, that is something I am quite certain about.
