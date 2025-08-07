Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFC8269D16
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 15:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754581503; cv=none; b=Juu83pALlPIdCRLjccoY3Dqk+HsCJ1xZUGYyLSSsIewBnnc6JolIYupnxD7siESex4q/07wujXmnAaghsLiDqRuhGdwiIoPMRXU7VhldQajgE4v7x6AXO80wDWSEoB4kEVFZuO0ZsNSQda6y+IOBBIYEYB8eevDSOun3Hqp6L9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754581503; c=relaxed/simple;
	bh=HdgsXYnn+RRJOVM2MfdA4my8BFdb/kKXjEgzABIyer0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gEmL33uwN+FvaiV9OW37uAGJbYfXMRkSPrcsoul9tifPtB8IvprwoVWfO2oMkETKO5XgICPPSte4TKzAwfFsLv2zHMWCsnBqKxcF5fDxMP9+7DSQRETg48ajaxG7gtHW9gNr/W3JJw6XdPoBsxTdctl/aFgw1Ri5Mzkl+1R94kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=beLNkt9s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=erO5oC3Q; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="beLNkt9s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="erO5oC3Q"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 0E1861D001B0;
	Thu,  7 Aug 2025 11:45:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Thu, 07 Aug 2025 11:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754581499; x=1754667899; bh=bEEJW3iise
	0c9R+ALCNXDzC8jf/ALYDchjo7d9+r9B0=; b=beLNkt9sqh0e5G8zm2x3q4/YqA
	e+4MhdpfRNOj1WWj7DZduS2fJCKha3zCKxhcnOkjntK2H0nVeaJADzrZ6NwcUiio
	cj+jFaq3nEXPy0030Tho0V+3+1Z0sWAV/QDvWZNOyYPEU02aePYTO9pvs5WS5Xar
	ZCmJ+7Gt/z4eLOVyqkG6eURQLWHZ9OVQTkPQaSwa3W8/BzZE1DkL8e1i9mRsdCtP
	HBj2W8bGHVQIJHVweCj3fPCm43T0rM7DqbVZkKSTLWg4hXcXHFnwRRNBcRpyeHny
	X229HxenA/AqMrRuuU6l0hNGmceDx1b+MJDwRoBLzRpephuCm2r0aXtRHMCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754581499; x=1754667899; bh=bEEJW3iise0c9R+ALCNXDzC8jf/ALYDchjo
	7d9+r9B0=; b=erO5oC3QdVlH1Ait/h7StZWYeKJW+gOe1SCJp415KC1RMfb6a9S
	Havr1nS0yVMrYtI/t1/6VSb6nwlbP9oamn3r7Sf6TWgcDiDtc6QP0giQR0boazei
	82Sv047pEEgFknUgLTQvTPHP50PclYk5CkDyNitkGMZWC3UgboNkBhXNk8Ea7TkO
	5nQTs3lksTl4xs+oA9HyORxSjQkaPZdRP8ZXA7HFure0SjOuXyCPJFZqr16KaL8R
	NDGnFzH7PfW7h0pMqu/vgZvHUHADTsBe76NSDHB/qNQY7mpVzaQgBtGuzD6f7S75
	JiXEcemM5CE0N+ixWcCiP78ri/XcTnhUj9Q==
X-ME-Sender: <xms:-smUaKwVjbAZ3OLzYbVNjGAt_PQL_9owosg7rWUt96Nd0wMpqU3-IA>
    <xme:-smUaO4FaQe2AheHEIgHtzc9IP-wuCLww9fm-TMIiy__QFRZKj1y3O82I_JjL7OPx
    _Xjb_qb9573c3x2Rw>
X-ME-Received: <xmr:-smUaDwtWFWVUXxw-0-kNJaatbHWfRSNvHnEPJU5KyvULFszZJUWYlwlsalFlz32DkLf8VvwWIxliiiAChD_MVo8_RasyBFXv_EvmrU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddufedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoheplhhutg
    grshhsvghikhhiohhshhhirhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehoshifrghlugdrsghuugguvg
    hnhhgrghgvnhesghhmgidruggvpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhm
    rghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
    dprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdp
    rhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehjnh
    drrghvihhlrgesfhhrvggvrdhfrh
X-ME-Proxy: <xmx:-smUaKdFShobMgkddPfZH7P4pjZDFptRHu4F12ySOVw38IZo_z2yxQ>
    <xmx:-smUaAAdWbHodkD5jnVVigiWJuy3hNtVKDIwtbiJ0yr8v_31_oaneA>
    <xmx:-smUaG6SUBd5PG-MgCyuJKXmCH4FvElfBtx0d4b0hvS31MYMT6eNQg>
    <xmx:-smUaBdq8-SOi48T_CRadTnl_gJ6oBJyYXzn6JMp1nqZWoMykBQc5Q>
    <xmx:-8mUaFvWQyEQoYy4o_sJI26G27R3XpBuiz0mVkg484xdRQzBmLzW7DU_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 11:44:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,  git@vger.kernel.org,
  oswald.buddenhagen@gmx.de,  karthik.188@gmail.com,  ben.knoble@gmail.com,
  phillip.wood@dunelm.org.uk,  jltobler@gmail.com,  jn.avila@free.fr,
  sunshine@sunshineco.com
Subject: Re: [GSoC PATCH v8 5/5] repo: add the --format flag
In-Reply-To: <aJQ3tyC0e53iWtVE@pks.im> (Patrick Steinhardt's message of "Thu,
	7 Aug 2025 07:20:55 +0200")
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
	<20250806195537.93302-1-lucasseikioshiro@gmail.com>
	<20250806195537.93302-6-lucasseikioshiro@gmail.com>
	<aJQ3tyC0e53iWtVE@pks.im>
Date: Thu, 07 Aug 2025 08:44:57 -0700
Message-ID: <xmqqjz3frv9i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> +		default:
>> +			BUG("%d: not a valid output format", format);
>
> Nit: we typically say it the other way round.
>
> 	BUG("not a valid output format: %d", format);

It is in the coding guidelines

 - Say what the error is first ("cannot open '%s'", not "%s: cannot open").

but sometimes we forget.  Thanks for good eyes.

