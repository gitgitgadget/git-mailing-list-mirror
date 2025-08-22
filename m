Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7461DED5B
	for <git@vger.kernel.org>; Fri, 22 Aug 2025 20:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755894320; cv=none; b=E0dm1xz1CwlPCIukt6IR88G8bv9C/2LDGJQqGx4JIltGW3HPatUUIe+rAuunMgvXJIrCwkPmh9Cb8yIFaI4Z573IUKEfiZmWnobmvwbmbtrL54OB098W8mXWB6fWT+zhiNte+q68kK1zSII4hv0euns2g5PtG233gfpfv0YNPKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755894320; c=relaxed/simple;
	bh=fdDV6mY4q0a/Bnwl5faQ6rHFmdNjp2WxFRfB1LxwKVc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nWbojbxmJfjLFppCOlJREwiRk3NgMGSG+gPbMjQno6GKfX9qB4HUoq3VJj4LsXTKLZCbgG+bJYLaDGqOyYX+pTnedCZU2riURvRshlVGEh49NVxaq1/6N208u5+vXyYYeV1iVkD+NfeNpw6YOrersdgi9L9j7SwIFv902mrX33A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BQHn3haF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OMVajic8; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BQHn3haF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OMVajic8"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 247EA1D0015B;
	Fri, 22 Aug 2025 16:25:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 22 Aug 2025 16:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755894315; x=1755980715; bh=fdDV6mY4q0
	a/Bnwl5faQ6rHFmdNjp2WxFRfB1LxwKVc=; b=BQHn3haFBInkpNR4iG/CD8aXXJ
	dDqoBY2jC9UjLJTkbDsRZUIM6kPR5Q6zOR8S67tbUkzEWRyguds/tcSnelCPifZW
	s0RQJCs9/FqVgn+6MA2N/C3OJDCOe5mIifHyhCu4kd2ZilufZD110jt98jInt4/G
	iqXe3B0DCiZQH4r1Ejfz30RYvgvqbitRhJwMhMhrcj/sM+vMyPFQMqIinjDU45TY
	NaR3RC/qIuL4r5svECyqxBBgy5rkjvqgwDzRVJ+Zx+Ow8HULh9Jwob6YseX93zFZ
	Yo9z/olG7c6ThJIcZC9W6b7djRaXWquHK5OxvYkZlLKa8dZZ/fju26YvTk4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755894315; x=1755980715; bh=fdDV6mY4q0a/Bnwl5faQ6rHFmdNjp2WxFRf
	B1LxwKVc=; b=OMVajic8kaWEqjJZBev1Ienotuaa2aBDHSH/abBN/J8zCGho66m
	y46TS7s4C3pSjZlnLz6PnQNOLiMwhlVI8kS4BqAPw87wYXcbDz32egZf4qwWCkoS
	X26jTRFK3zIxqS++QHY7KHNmhiUdWG48jEAOgs5PslRJeCf1YSynPW9w8QmkxC9Q
	MWI2qdQzQ7MA9ydvnJ0xCaqV0aE5U8aQLqwTSGrnLlhay2/9qOGeNgwjx+Z3r/8f
	Ag5qZgIoFJenAtDzEta5Z0AekrAYcb0uqwcmi79ne20w2JUJyfczBUayX4B6dDd5
	hSL/XXHL4Xx1jzaeYU2l+v0pIuo1UXJIxLw==
X-ME-Sender: <xms:K9KoaEtVc06-jdr5aj5M_VomNDygDtjHxt8_4jH_946jAjPWF7Mfkg>
    <xme:K9KoaMDAyh5fUf2IipesVNfBpdCgdpnpBeMamGWS6vSruOdgnT67CXQ1Nmc8ED3oj
    TceXuQA4mGDTlHg0A>
X-ME-Received: <xmr:K9KoaMWfoE9jXyHn4atnx_NwuEMHdQPL9PgLjJX9_qkuDolPcmDnepHerBm7wpn3qaabfZy1e1g-Lg9L2x25Z1iWHxmj0nlA-KRuCO4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieegjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshes
    phhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:K9KoaKA6zAN_vHE5BUp9PVFTcO6c8v_oIqimtx00o3jG0TuL8hDfXA>
    <xmx:K9KoaP8DtzT1nxDKdoP1-azAZRTUVfo3-l6d2LbB3wpyDPQK-yrKtg>
    <xmx:K9KoaBHhgjhln4PNzsgi6VO-QOWEn8TPawxLn_D1zXAEz4bmJbscxg>
    <xmx:K9KoaNMAyPq-WN1VHqyvobqbCseqUbTHhQ5Jpw6FRqXU9vyFdn8ZwA>
    <xmx:K9KoaM9VJnCpHw8PWwM8x0ZPIwDgrNp2aAjRjSNeZdM5hVdxXxpAR4yS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Aug 2025 16:25:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v2 2/4] bulk-checkin: remove global transaction state
In-Reply-To: <njvcqkkcotesqznalieuwhzow7lxbejxlfw3knbhalmqjcb7cs@3vwea4r2zljl>
	(Justin Tobler's message of "Fri, 22 Aug 2025 13:07:37 -0500")
References: <20250820225531.1212935-1-jltobler@gmail.com>
	<20250821232249.319427-1-jltobler@gmail.com>
	<20250821232249.319427-3-jltobler@gmail.com>
	<xmqqv7mfxqg2.fsf@gitster.g>
	<njvcqkkcotesqznalieuwhzow7lxbejxlfw3knbhalmqjcb7cs@3vwea4r2zljl>
Date: Fri, 22 Aug 2025 13:25:14 -0700
Message-ID: <xmqqikifw1cl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> If it is preferable, I can combine these two patches together. I kept
> them separate as I thought it would better explain the steps, but maybe
> that isn't the best way to structure the patch as we are largely undoing
> the change in the next patch anyway.

This shouldn't make much difference, but I prefer the current
"awkared but done as two steps" arrangement slightly better.

> I'm hoping for an eventual state where the transactional interfaces,
> {begin,end}_odb_transaction(), are moved directly into odb.{h,c}.

Yes.

> The
> current implementation of transaction handling is specific to the
> current object database source. In a pluggable object database future
> where we could have different types of object database sources,
> transaction handling will likely have to implemented separately.

Yup.

> With this in mind, we could move the current transaction implementation
> into something like object-files.c. This is already where the vast
> majority of its call sites are and would enable us to further simply the
> interface we expose.

Great.
