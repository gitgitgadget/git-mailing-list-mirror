Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7041F94D
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 17:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737048697; cv=none; b=ipIoUOgj9T1q+gnz9uFWrgcZMgap9joxob6+eQJx9fQEnJH9vKAHI/gAB1Gl0o2CRG2Wo9AC8+dxd581p637QG3oCuL7RHPSfo5We/aSYSQkNQKFJ7s+DDduhnkpfGikDNZMLxUPc29itJrgwybOCcES4EV39ZfJ1dFhv0L0mbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737048697; c=relaxed/simple;
	bh=VlCLY1/Q+ChL3phZBgOe5Qji5ElY9rUb23il86BEjE0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QPpV0d2ke8s75Q0T/2c+5Xz5Tm3l4sFvLnCBrPGwy3lThhs/TBsOiGYPDVrRxs7se+3Dq+kN4Zd65OmKlJwzmF/oLwNvJUWiqfmbeOIowyN4xuOc/0mn7XAOYcFoIzgg7alpFOEkoshKNX2uddITTQ2lAOI9R3rEa8NFhkZ9Nik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=0D0KWTOW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kLgZ73X8; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="0D0KWTOW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kLgZ73X8"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 440B6114006F;
	Thu, 16 Jan 2025 12:31:35 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Thu, 16 Jan 2025 12:31:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737048695; x=1737135095; bh=xooxCkzBCI
	dmTYennPy6pZqx4j8f++K6aT378lq4mA0=; b=0D0KWTOW7Xtl5WcmkxKyyEEh1V
	sXjwFIksik91wnOoi4+aEEXCe/tFKQVzSlfuVBfKKM83NYPGjdbZsv09JEgkt2oz
	lVPpPzjOHiGN/fbpCGkjscrKT3iWlIBPawilxrUaRln11HHLUOH/nC771Rlidd5P
	eI9nnGkDddBEgpqGDjoK4dWqdZHAki1UlU+qXrPloWlqp7AS+fvjHCdcrdS1jiL3
	P15vzTjDfs0tddYrcgjyDb/Edw6vbAX2mV18ryFT0zg8c7dzV8wZHGvidSFUFACu
	XLZZEdWDHJ0SobhT4NanrQSlJbhYG/RnxYxOs5aKvv8UvNPAFMGBFo73RqUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737048695; x=1737135095; bh=xooxCkzBCIdmTYennPy6pZqx4j8f++K6aT3
	78lq4mA0=; b=kLgZ73X8Mx7Pk1D7fbm6mUbWub1J5CmxGWsBKxHaw/G+Tf6sPmE
	r9GaFT3xXn7WQYUnlh8XoGdzidzVz7C9GCHZ/0IEwheG9COm5EHhIJBPtkaoBJal
	FPcrnR7lu9w/7cgI5fATsSJV+VdjPLoHruj2rDEypWj6zyEA4sYCEYUTZOVHEp8U
	F0bZsJcjw0U10vyGvTAV2qvVq4SPkBCAcZVS3F9q6X+6lN+uhb+Sd2yv3OxD5bMg
	+XjNUCnBS5Fr5LDb+J1/RIJD/JCgUvLiOjEIyqCPPd33BW0oVUQSoMdcvmvC9sNr
	edqaxnexULnSsZV7Fli8SNgarCZl40rolmQ==
X-ME-Sender: <xms:d0KJZ6_3lGlNmrOnun6qN3VTwk5rov8PL_onGcEPogOIJNdI-U_4dg>
    <xme:d0KJZ6vLPir2gIkQpK_2S2fQqMgD3IzVNl3u_0auLu-1q8_i8e71G-hdJcunVWebN
    L_x6tMJGl1ONghsKQ>
X-ME-Received: <xmr:d0KJZwCyvGpE9mfZE_hQj5MngBLETB77fRAbdTUseST182bUxhohd5TsNkY1n0CiuUFXURwBOCauxj2gs3HrnyQW5I65CfsLvMnp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgepudenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehrohhs
    shdrghholhgusggvrhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:d0KJZyc2J1chYbE80V3F75sLD0DDdFlP7lnfSIdTQsdrAUwcHqiNYA>
    <xmx:d0KJZ_PckFCCtykCJhX5-122b-bvkk297EPgeLe13Q3-IWQU7iVeQA>
    <xmx:d0KJZ8kBG18xgq55lk54S7qBwz0QA6ROIq9ktKNeRixHen7S76pefg>
    <xmx:d0KJZxvqAyi-xCQza-fvDOuNmXUHvJQAXMwGFFqnUOPinSg9EY3rKQ>
    <xmx:d0KJZ7Cme3_CGDY22FXgIudeO7GKY1IG85H2g9TS-SVIT7x-7QdYZ1Z0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 12:31:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Ross Goldberg
 <ross.goldberg@gmail.com>,
  git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] ref-filter: share bases and is_base_tips between
 formatting and sorting
In-Reply-To: <20250116102154.GA724126@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 16 Jan 2025 05:21:54 -0500")
References: <CAAEcvMovcZucuq4H70ouQzKS=_wHnBi1DqJ-4MMFVXX9XLEciw@mail.gmail.com>
	<6b824f05-6f16-4cd9-85b7-3b8b236158b4@web.de>
	<20250113051700.GA767856@coredump.intra.peff.net>
	<57066d48-ce68-42ec-8e94-4ef6c1eba920@web.de>
	<20250116095128.GA144555@coredump.intra.peff.net>
	<20250116100637.GB144555@coredump.intra.peff.net>
	<20250116102154.GA724126@coredump.intra.peff.net>
Date: Thu, 16 Jan 2025 09:31:33 -0800
Message-ID: <xmqqr052sm16.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Thu, Jan 16, 2025 at 05:06:37AM -0500, Jeff King wrote:
>
>> On Thu, Jan 16, 2025 at 04:51:28AM -0500, Jeff King wrote:
>> 
>> > Yet another option in the near term might be storing these ahead-behind
>> > bits in the individual atoms. Since the point is to do a single
>> > traversal, we'd have to marshal them into a unified data structure at
>> > some point. But we already do that! In filter_ahead_behind() we convert
>> > the string list into an array (and ironically do not even look at the
>> > strings, only their "util" fields).
>> > 
>> > So something like this (only lightly tested) seems to work:
>> 
>> I compiled it without DEVELOPER=1, so I missed a few unused parameters.
>> We'd want this on top:
>
> And one final thought on this approach: if we do want to do it, perhaps
> it would make sense to build on top of the patch you sent. I think yours
> fixes the bug in a more direct and obvious way, and then my approach
> would merely be internal reorganization on top.
>
> At any rate, here is the is_base conversion for posterity.

Looking good.  Thanks.
