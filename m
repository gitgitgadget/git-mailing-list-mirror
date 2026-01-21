Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6076733FE0D
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 18:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769021253; cv=none; b=LalqqFBuoXaRyQ39Q7Rnws3FsGqj9GKoQqBoOfcgZAT/eXYKsKneh2/ZsqYua8Xs/l9kSao3SQmm8EK2cNmPPX9pF8xF3JIC4nwjiAqJ1E3CZjqTEHLq5AanSToIfL3aguAaps+tVmId8T/V3IYp7T1epiXjn92Hrwjwc2B2rl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769021253; c=relaxed/simple;
	bh=IS8wNjiT1VrWhyk+4aq3Ic5VkRVcjCWq4VY76ihoO3A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R9Mhvmezu5kqoZ7MnTebKynCQCNHtYfaxzIXVahUsg7XxtTYHIMGfv00C9+r/ap2aHxlAU0WaxWiRPAnCY5Wu5SdGyE04xJ/Y8AGuW/ewGRlCzoCU2gN1IgWlVujWkUCj0CpozpaKogj0p3mU+6DUxomEDRB8c/tZtmUx4M63h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XCXBHz7g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NVeLf+OA; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XCXBHz7g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NVeLf+OA"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 964521D00135;
	Wed, 21 Jan 2026 13:47:30 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 21 Jan 2026 13:47:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769021250; x=1769107650; bh=UZ+j5fnq+S
	A0USLSSVjHGUXnwvp47dcF+v9zjv4UC3k=; b=XCXBHz7g6qeytNrXDmHhF3wmyK
	fQauUBlRLrwRSm58PK6/23yVPuhfjCdZhjHBx8C6+xyuxqWthbtuV2uZaOmnvwoy
	0SU5hR9mIkZGLcj39IFMQ5rdNUXPL/KXjgl7vc/d0BbgxpgVZrwd0duBs6TUEIyb
	6fd5CaKOQgRe3n5+siX/FkClfy1Tb3PWPWuIIkKZiw9GsQJ9cW1EF2vwhp/0pDMy
	AfhrFxh8MzKSIy0PsLIoVst5wFhquatmTo6OvwMAtniXC0tJzep2glVSX9EMn5rZ
	TdbOaz4djZrEyi3CuSOKcP3C0zJdLJefS2rbllPTjf/N2vahGeu1TP9jvhAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769021250; x=1769107650; bh=UZ+j5fnq+SA0USLSSVjHGUXnwvp47dcF+v9
	zjv4UC3k=; b=NVeLf+OA/nPOFLpb804NYG3dsRsK9dig4TE8tfbuxZpYNSR2JvA
	c5tcm+aimbqm3gW3a2BmFTu0TRXSMS+cW1deTS6xe4aGEYPGUCUsoKg/NgwsUMg2
	x52XayxTP16NorVAsdXsnZaYU4u3T1OM8YPJCqybXmg+KtqPmSa5aqKmOYWGgQoJ
	j9NU5eHEfxrzlhC3xjtFZ1HAL+YyUFWyzOKP0D7gqJAhlcq5pZeaLl/XqFCmy2Wq
	od4Tcn5WmJVX1UHsOHH/5dor8CGo/hLlwtQiwceB+OLoLsaxkYvRQSpfdN4Mpa6J
	D1IDjBelGhIWfuF4whlV3EntH00vTsmvH/A==
X-ME-Sender: <xms:Qh9xaTyjSoky2jiLXGuxuxHjLbhwtkfaLjK3dvoRcGFh0CKtWqiWkQ>
    <xme:Qh9xaSJP7CF48W7AFsiBPpAE3xq-3GDPYxM5YV3UxjXUoqOpOWnnqERcInMYq8bSc
    del6muvprTKIrFV_s2e4vJWUuTOlD8v67TokLBkmKzY72ol2j1z>
X-ME-Received: <xmr:Qh9xaVrQINPNeB2MeHyt3O8LoxZRVjAB0F_qE__nz7bVOtBdN-FSn3Wv24wVSKQoPzwFHUXPR5cLpTQz2cTmpbxfePAfqKB9u6v_K9k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeegtdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohephhgrrhgrlhgunhhorhgughhrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehpvg
    hffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:Qh9xaZK8wgS5rKxBDtiStQ36TpG0c1A_YV0b46AyI-OxO0y0-TYG0A>
    <xmx:Qh9xaSQzA6Sk9g55jEYN1O3mbRG6oyMI0gaifsvg_goSDG2CckIVow>
    <xmx:Qh9xaQt4exZjXnbfm4aHyZeSfXEmRRAfFdYbfcLLktV3f0h9weFY9w>
    <xmx:Qh9xabZGyQohRCyEjFpBkHFeLx_a7BwWWRhh0_gmoEpzlzID39thnw>
    <xmx:Qh9xaVqxVn9IvXjDx3-CiqrPEI1S-7KdXKiY1ujhk4INQ8wjOl8JXa6s>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 13:47:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,  gitgitgadget@gmail.com,  peff@peff.net
Subject: Re: Memory leak
In-Reply-To: <xmqq7btcx8pc.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	20 Jan 2026 13:42:07 -0800")
References: <20260120094957.28855-1-haraldnordgren@gmail.com>
	<20260120132202.1655-1-haraldnordgren@gmail.com>
	<xmqq7btcx8pc.fsf@gitster.g>
Date: Wed, 21 Jan 2026 10:47:28 -0800
Message-ID: <xmqqh5seu7jz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Harald Nordgren <haraldnordgren@gmail.com> writes:
>
>> My bad, it does fix it! I think I applied your patch incorrectly the first
>> time around.
>
> I've queued your v26 on top of a merge of Peff's leakfix patches
> into 'master'.  It hopefully will appear in today's pushout.
>
> Thanks, both.

So are we all happy with v26 of the topic?
