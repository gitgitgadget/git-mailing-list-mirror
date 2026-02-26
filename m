Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268C1316905
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 22:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772145231; cv=none; b=AbYvg/dyRPi2IKG3b6rEQGal97t8hJjg5ZXUGQq8c78BJ5MgjSUwCBjcQxeyMPC9pvef7t73TdYNW3ofvQwSM5vRLeDYGgpDfvnqUIH+bey4PnO9AB4KfZbWUzEp5lTIXuzU5dAuf/UCwGJf1vzHqBhj9URwu1aC+waDl7pSP9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772145231; c=relaxed/simple;
	bh=yBIHSFufdhFas+kAVdB7c65wpnJ92Qe/b74i7kFsG8k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qeDcMfncNFMCy+72KeIGOH47WwccvmOIuwDqFzjLP9EljwEc1GTw3Jet77pET0cbNirUvirX2pHVOV1BECCFtZPEA4ijUdm4uKIIW93ASI3SvheKdHmbf1S3ymxXYTI/y5GMxqdWDkgW6HnqJ30lHioK6Cn3mOPhaANQ7rfbYeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wv7PCnxz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Imd3GUcE; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wv7PCnxz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Imd3GUcE"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 43D791D00045;
	Thu, 26 Feb 2026 17:33:49 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Thu, 26 Feb 2026 17:33:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772145229; x=1772231629; bh=fhzPe+E8kT
	yvzIqf7/W9KeyU992HU84cXMTri72QY3I=; b=wv7PCnxz0DsrOLqrTWRvfZfP1N
	AdAXHTnDpKJ1IBBi6GRXD28XRDOng9SOhPGIElsK5RKi3HpSMxzFNcCrdyEZM5yQ
	zClOY8j8lmgEZ3PECgx24WjMWJhD92oOYPejnLpS7qrVzi4lJJl8drS7VJL2L60b
	uCNMw3rhxuihMI5NHyAbTG9NpSfEYZAez76DE3OnQgvLEJvx3JgMpNyzvY5r9unl
	gPxbOwLV9+Euk6+F/RS6o9OdJdaktj+bC2ym8tkOQBuwMwPd5YNAI20LZ5XxO5WC
	VIhUZ4Zw/ARADphNMBAC2AiyWUVlpowo2MJJgEuyFysdRp8GtX0iK7eXTnXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772145229; x=1772231629; bh=fhzPe+E8kTyvzIqf7/W9KeyU992HU84cXMT
	ri72QY3I=; b=Imd3GUcE3ScROmG/JmEbq+/0gTTKHsHQg/7snz1rP+e2FsVfFik
	rboKZNZP9/6PvIi6MHQ5eDHRW11zqNfrzyH6S9voQGZgOO2CoHDE0u4ImjO8c8g3
	AbAlY3m9h7+weI2EnqYx98XaBmfCuZXmz+1jdbJcW4OGNbh1P71kYUyV/n4DSru7
	k1XqEvM6xSWASYopROdGHgEPXh+34m70yayoXpb0N/o2pycy97j6mFnCfxrgKvqN
	HzAdSpyYCnTkBhTlAcUDOf51N6+UzofBmyA7u11MOZUTDmwazmhQD6wtYu5eF35V
	xscC9pQYVt+aQ37aMqpNNCWE60aQbKVILgA==
X-ME-Sender: <xms:TcqgaU9MEQa-C5Q0fIqzj5ZvNep1KOI9tvASLwlB5EdtllrZWMcjgA>
    <xme:TcqgafRXdC1_QwhL9PelLI5xezkoiz_qhjXYfCuopLn72kk2IOSy1fbecp_jwlMdW
    XhrceXjiOI4NRjZvmkl_Ka1pkyXg0poaZ13xdY-cQm4-3loy6Js4A>
X-ME-Received: <xmr:Tcqgadp_nBWqGn7VU9Ypi7YGvP89HFSB-MULZw-u9LLlaWML1jF4vqMazypCspI3eV6BIuYrOQkGn1dpxMkopTaNicTFLJ9Grw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeejfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegouf
    hushhpvggtthffohhmrghinhculdegledmnecujfgurhephffvvefujghffffkfgggtges
    thdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsth
    gvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepgeeuheelveevleffkeeg
    hedvhfevfeekuddujeehheegkeetueetueefgfduheefnecuffhomhgrihhnpehgihhthh
    husgdrihhonecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepvhgrlhhushhouhhtrhhikhesghhmrghilhdrtg
    homhdprhgtphhtthhopegrhihurdgthhgrnhguvghkrghrsehgmhgrihhlrdgtohhmpdhr
    tghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhht
    ohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeekse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepshhiugguhhgrrhhthhgrshhthhgrnhgrfedu
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:TcqgaUkBBcUzMZj2OoWwb5tN7o-Jl7ppjBOE9ebb4OM08YtoGOL9rg>
    <xmx:TcqgaedRFWHVAtTgKYIuYp9xVfjlP_eCAnMZkBvD_qtjhzWUbDvwuQ>
    <xmx:TcqgaYofP2KwUjaDC1tvZHd8aBMF0SgqvB04E9lSsASRaRH6ljiGVQ>
    <xmx:TcqgaQNmdRNM2rirBJf08E_Nd2t6hfcJNyirryjzzdal4GDlfGT_9g>
    <xmx:TcqgaeYcBRLyM_gfCCJhz6QmC7XbSd-Hj0m6mcpDACly6DAL3eSmMKJU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 17:33:48 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: SoutrikDas <valusoutrik@gmail.com>,  ayu.chandekar@gmail.com,
  christian.couder@gmail.com,  git@vger.kernel.org,  jltobler@gmail.com,
  karthik.188@gmail.com,  siddharthasthana31@gmail.com
Subject: Re: [GSOC RFC PATCH] builtin/repo: add path.in-worktree field
In-Reply-To: <BEE3B56B-F8E0-43B5-95EA-8506A84CB2EA@gmail.com> (Lucas Seiki
	Oshiro's message of "Thu, 26 Feb 2026 18:26:41 -0300")
References: <05C28DD8-251A-4990-BBB2-26C144CAD982@gmail.com>
	<20260226201643.5152-1-valusoutrik@gmail.com>
	<BEE3B56B-F8E0-43B5-95EA-8506A84CB2EA@gmail.com>
Date: Thu, 26 Feb 2026 14:33:47 -0800
Message-ID: <xmqqtsv3uoc4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> A
> microproject is something simpler than that. See the microprojects
> page [1] for suggestions. They are more straightforward things that
> have more chances of being accepted quickly. And since having an accepted
> microproject is a mandatory step, you'll probably want it to be merged
> as soon as possible.

Microproject is to serve as a practice session for a new contributor
to go through the patch submission + getting reviewed + sending
polished version cycle.  It does not have to result in a merge to
the project, but it is essential to get reviewed and respond to
reviews.  How well you work with reviewers is the focus of the
observation, and how complex the problem you tackle is is of much
lessor importance.

> I think that this seems to be easy to do, but the reviewing process
> may take some time, so it would be better if you stick to a
> one of the selected microprojects [1].
>
> [1] https://git.github.io/SoC-2024-Microprojects/

Is https://git.github.io/SoC-2026-Microprojects/ the latest?  The
above URL points at one a few years old.

Anyway, this list however might want a bit of updating.

 * I personally feel that "run_command*() to internal call" is way
   too involved for a microproject.  All the low-hanging frutis have
   already been picked in this area, I think.  That is why this does
   not appear in the list of microproject ideas in more recent
   years.

 * People seem to be finding more instances of "test -X" to replace
   with test_path_is_* helpers, so that would be fine to keep for
   now.

 * Ditto for "do not place git upstream of a pipe".

 * "Do not use signed int for collection of flag bits" may have
   outlived its usefulness, as it seems we are pushing more and more
   uses of enum for collection of flag bits.

