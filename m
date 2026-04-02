Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8B12D47F1
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 16:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775145912; cv=none; b=WgY7AB3oEdiSUdPqBu7BWqcOIN4FF2qmUSaQwUjaxLTd6KIy9JzQsEK7u8eILoNHxugRVULasq9hBUfUU1cqbborcUaBlQL+tXBd7dd7K05GnMloAJRGWkSYGtBtq8q5Ptqjs1x6T1/xrWYTPBl4xBbgFC46IWABDn+wjum8zM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775145912; c=relaxed/simple;
	bh=4/TN/NCTiqQuDcNnJj/e7qrxY/nQQnQgLZC35vm5OoE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c3JPyAvLCqO5ZJvHuf6ogGwWUaDoQpFtiuUiGe5rOaBhyHeaKmIC+dd1VbhpsUrS5XBRDOH9mRa0HeVwMtI79D33spOqCzgkBQr6Bb939OcyWLEIuKP1LpzDyEd6pBazrdiBdEu4//OA0N8+uH3hGDYZvNWLGMubHdzUAthCoYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JePX+YXx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LMi0LFhg; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JePX+YXx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LMi0LFhg"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9E60A7A0139;
	Thu,  2 Apr 2026 12:05:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 02 Apr 2026 12:05:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775145910; x=1775232310; bh=ulMkpKBwwJ
	7mmLZbrVKp2RMkLVWscfKNyPrpEGHt0rY=; b=JePX+YXxFSMx056CtHlcjsM9xg
	QLzNpmOrcpSrdH8EgGuw+oW6fm7UQ6psX0jhLs0SGAcACucW+Cjal7O99y6Knvj5
	AXsqZG/kN7AqkfkDkQ8rTuEN38dMTx8lJ/TO+I2tIHTR4WCR4dYztsBDFnIQupXs
	++Edp8xwwScflxkywmgK1XIH+ZcWVj6YKsPPhlGRd0i3wgXjXrj3ZXKBn8qAHA0Y
	4a5slL7MHmihXMepBVlknpQ2HkwXqbU987KV53N//IqPLYjxvBI6Pj778s5vsE7S
	ExTPv+08agd8CCYrQJ3/e5MGFZBttIf91ElsbfDfNVsOLh8Omwfy3b/MiufA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775145910; x=1775232310; bh=ulMkpKBwwJ7mmLZbrVKp2RMkLVWscfKNyPr
	pEGHt0rY=; b=LMi0LFhgYsF7QvUaREUNEGqnbdnkb4AgzXTrg/lzhXZ5wMqVEj4
	Qa7fBKdFdStUIKRiAV4Hk8Ei5QJa1GE0T6SHN4L9FZzT39e3tiuhi5NrumD6j3Q1
	4Q1UheoVdP1lcitZwxTV5ySf7/JGC/dMUazi0lORr7F/KX1zeAF8Rj7XIL6WwU7h
	DwFCL9BWSMNAJm+vCZnGu3+JuPH54omqTvlZYrgrs+b+ZB69R9ia0+YpH76hehFx
	4el2JwaU81CFgSN9qW2ViQujA9ieGkbh8PHBRAPKh+1zf7Uvne8f02OwUfsaZAwe
	KmAcaPYXsnSKHOhJSJhWR7GBPkNQY1rXiyg==
X-ME-Sender: <xms:tpPOabVxBYDRXRs91dqMHkOTQkXqFrOMNDQjeNHDYMH4wj_X97BRGA>
    <xme:tpPOaeIVQJ37hq1Oc0c4W3a41VhL9XQe1Ci0VfvqNXKx1IfP8-GeMz8LkT_PkQFb_
    w-dRXH-L8fya4qKFv0nNjxR67hhoNVB62KyUmxmoqwhZUVJ39cuLfg>
X-ME-Received: <xmr:tpPOaT9raonpL2mzKnda8Xx2rQph7iisX7SOKMMYoKGeHFvK45FUovs3LcsL18FA-ybrjxB-Vb5FRFU9CrEZmtnJObM1H8-TrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeigeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epvhhikhhinhhgthgtgeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:tpPOaZJ5_0tQOpAR1DdOV976PHNYagNgNLLMTW4g4ZR-qdsZBokzrQ>
    <xmx:tpPOaQk9LuAIi2enA2LRJl_iGwyIWWFvk0mNwjSB7yUykr1z24ewpA>
    <xmx:tpPOaVMmvZjghQNcI9dS_AvIAlznYmjk9K48jn7_1UaqEYf0fDb3aQ>
    <xmx:tpPOae3JqGL383r3JJ6TJTQHtofKRPUaz5TP3x5q7Z-Y7h1ThBFdhA>
    <xmx:tpPOacl9GXC6HdBReswYQ1Kqo14TXyNjn5WWO81ZPqmJdwYonjT0oiAC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 12:05:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Trieu Huynh <vikingtc4@gmail.com>,  git@vger.kernel.org
Subject: Re: [GSoC PATCH] backfill: auto-detect sparse-checkout from config
In-Reply-To: <b7164e46-0521-4c0c-984e-35fc1891e4bd@gmail.com> (Derrick
	Stolee's message of "Thu, 2 Apr 2026 10:24:45 -0400")
References: <20260331112516.772635-1-vikingtc4@gmail.com>
	<xmqqo6k40wbl.fsf@gitster.g>
	<buisigjsw3zrcy6bqaic2zefypq37kimju32eufquppsvkgkvx@cqd3cwj6an6t>
	<b7164e46-0521-4c0c-984e-35fc1891e4bd@gmail.com>
Date: Thu, 02 Apr 2026 09:05:08 -0700
Message-ID: <xmqqh5pts5zf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> On 4/1/26 3:31 PM, Trieu Huynh wrote:
>> On Tue, Mar 31, 2026 at 09:59:10AM -0700, Junio C Hamano wrote:
> ...
>>> I am a bit confused by this change.  What's the difference between
>>> using -1 (which you picked) and 1 as the initial value for this
>>> member?  From the proposed log message, I would have expected a new
>>> code that says "ah, we notice, from this member being -1, that the
>>> user did not specify --no-sparse or --sparse, so let's figure out if
>>> our working tree is sparsely checked out ourselves and set it either
>>> to 0 or to 1", but there is nothing like that in the code.
>> ...
>> IMHO, this change set the default value to -1, then it can fallback to
>> repo's config value if user has no-op passing (default to 0 (full
>> backfill if user doesnt intent to config previously either).
>>> Derrick, what do you think?
>
> Indeed, I thought this was how it already worked, as 85127bcdea
> (backfill: assume --sparse when sparse-checkout is enabled,
> 2025-02-03) (introduced in [1]) should have covered.

Ah, OK, in other words, the code to use how the repository is
configured when the user does not override from the command line was
already there; it was just the way the code checked if the user gave
something from the command line was wrong (i.e., initialized to 0,
pretending that '--no-foo" was given even when there isn't), and
that is why we do not see "ok, there is nothing on the command line,
so let's check the repository" _added_ by the patch---because it has
always been there.  Makes sense.

> The code and commit message do a good job of identifying this bug
> and difference in behavior. The only suggestion I have is to update
> the commit message to point to my original commit that failed to
> implement this behavior in the expected way.

Sounds sensible and makes sense.

Thanks, both.  Let's see a (hopefully small and final) reroll.

