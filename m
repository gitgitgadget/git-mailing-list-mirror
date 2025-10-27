Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71FA1990D9
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 14:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575903; cv=none; b=HQahj5LDEViw3YlmHgZ+IT4PA3WwZZmNYYWAuSqOX0msRvczw7HnGJhtAlNHmSy2SOfM9P8ZMc15bzoU7R/Qq7OxfwPVTlnmYmtzfDllFaCf9meLmdWPp7F4ZwaZos24lNZPUyccAAYtOrp9KE7q73lTHb8khVGOExQyV+2z584=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575903; c=relaxed/simple;
	bh=4X0Yib3SZWieBniBJRuy0dk6v7AulH0+MPpoNufv/0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irRkCty4z+LIGBKa2SbyskZJIjXYP+lG6kmmkr+ys5nNloJceE5C9eEX8CdZb/DRbegAovhBUBqKEMbRLJ+ygrK9eA6StYwzMzYFppeRY6uWV+zSYX1SQjrV/7VWsQGqiy2w2boT8gDxOO3VddWHoAMh8vmL+rjfe9cWp+s0+7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PhqHxYRM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PmR762zM; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PhqHxYRM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PmR762zM"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id C5664EC0301;
	Mon, 27 Oct 2025 10:38:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 27 Oct 2025 10:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761575899; x=1761662299; bh=gpYSmamyMJ
	7RprNSzyzOvwgF6dDk5bG81cJEFCZz50k=; b=PhqHxYRM0zhmnfdohLYb9m52iK
	xKI3Gg3FSQDPl+gRDfNTUdHvyLy/enyYDm8YH3w97Biv2soIWg8n6zjwNFq84+He
	EUqVVuja3yE0+O/dh0h3kljXAmlEbjWggTfiB6ItNlkHp58hWqlw2rLZ4yP2CCxd
	YP+V95AhTaClZ/HqTMWWT7X+3e5e/ixZIWXLz4zw7lB1fV9xi8ZTbk0SoGmMSASy
	v2hdhZR4HDY/3Rh6q9teL1fQ6vQKN3GRC28Z5aiUnHy5bDRFAZzk933TL8qM+6fw
	PuduEoJXz9GUZ68M3lOnWM2SBftkUG/Lk4K8zLaZhXYzcw+l3h2LuhCkQUYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761575899; x=1761662299; bh=gpYSmamyMJ7RprNSzyzOvwgF6dDk5bG81cJ
	EFCZz50k=; b=PmR762zMkgU/FrtXx6tP5UGtte6z8M9L68gMxFD4ccqZCE9k4HU
	5EXT4sRFmpGD6lz1wL+pGDFNAm5ZegoBLYiJOdrhCZY8KdEUHcxOLn5n0Fni87nA
	k3iWWgSo2zz/O3jkYr9sUquYRPpV1zKabEocID1bLA7r4hATT7hZq8ARAfzH/J+B
	Vvw+SjLzAqNcANvfC/Bo0xZmxIVQciNBnMLa6pkBXxtP1A7ZErveVn2MaJpeS4f8
	Un0oWsr2+0BEhPXjWPUvngK6viqRilp0LMcYj+sQsbuzmHvYo4swCv3O+eponPHL
	CtnPOQEqGyx8H2YHDXG5dntNaOScZyx8QTw==
X-ME-Sender: <xms:24P_aNUxPN2d_fgNMwdHRYonWwU9ZVPn0INvykL1jtxgz-bhE1GaUg>
    <xme:24P_aFCNlJ9YzpUNzcpQPTtCGJM-GJZx_xUZRMPvvUEP3eMPAUaAVprcrHsbV7lqD
    vsoxiQi4ItZqHANqCd5IbRxWUYQl7fDqId-keLk_cej-sTTrqH19co>
X-ME-Received: <xmr:24P_aGwTdEN-jTfcDnc4OiVuVtmCg4MypZsAvVdVEUeNYqZgi6Sa7D89WGqliUKvRsSGXH-j0S79_-EyC7dH9dKWRU3OKuvQQ8egl5p-Jg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheekvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:24P_aKDQOXovKYIhpVDMgKXMiVwyjHHRB7aPAgw7xXvR2vnjjyGM3A>
    <xmx:24P_aLYP73n3A3RnF2duRmCUPhnClH1cOfsO_LXyaS-mvewzAsJxfw>
    <xmx:24P_aKi1QA0b5BdmFdJkQ5r3eUZGmOwZqH1F4sp4oq8I-rkmA6LpVQ>
    <xmx:24P_aF5SdVzHQ4juZ_Nqh8ayDsYH5ondhxJ7s_wHIrn3LR41xsl1qA>
    <xmx:24P_aJyPB2907jv_RVqY2A3PNIPZYJJ_Ee1Y8w1lRb8eAS-E0U3qxMMJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 10:38:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d9b39a8b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 27 Oct 2025 14:38:16 +0000 (UTC)
Date: Mon, 27 Oct 2025 15:38:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2025, #09; Sat, 25)
Message-ID: <aP-D16-TH_dWIFsX@pks.im>
References: <xmqqo6pun0ml.fsf@gitster.g>
 <aP8wEEZa6_DgdKwG@pks.im>
 <20251027143030.GC2758515@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027143030.GC2758515@coredump.intra.peff.net>

On Mon, Oct 27, 2025 at 10:30:30AM -0400, Jeff King wrote:
> On Mon, Oct 27, 2025 at 09:40:48AM +0100, Patrick Steinhardt wrote:
> 
> > > * ps/maintenance-geometric (2025-10-23) 11 commits
> > >  - builtin/maintenance: introduce "geometric" strategy
> > >  - builtin/maintenance: make "gc" strategy accessible
> > >  - builtin/maintenance: extend "maintenance.strategy" to manual maintenance
> > >  - builtin/maintenance: run maintenance tasks depending on type
> > >  - builtin/maintenance: improve readability of strategies
> > >  - builtin/maintenance: don't silently ignore invalid strategy
> > >  - builtin/maintenance: make the geometric factor configurable
> > >  - builtin/maintenance: introduce "geometric-repack" task
> > >  - builtin/gc: make `too_many_loose_objects()` reusable without GC config
> > >  - builtin/gc: remove global `repack` variable
> > >  - Merge branch 'tb/incremental-midx-part-3.1' into ps/maintenance-geometric
> > >  (this branch uses tb/incremental-midx-part-3.1.)
> > > 
> > >  "git maintenance" command learns the "geometric" strategy where it
> > >  avoids doing maintenance tasks that rebuilds everything from
> > >  scratch.
> > > 
> > >  Will merge to 'next'.
> > >  source: <20251024-pks-maintenance-geometric-strategy-v3-0-9b5b3bdb4387@pks.im>
> > 
> > Note that I've sent a minor reroll to address a CI flake that Peff
> > reported in [1]. I don't think that we need to fix regeneration of the
> > MIDX for now, as this is not a new problem. But it's something that we
> > may want to address in the future so that we don't regenerate the MIDX
> > in case we know it won't change anyway.
> 
> Ah, sorry, I hadn't seen your re-roll when I wrote my other response.
> What you wrote in v4 looks like a reasonable band-aid to me.

No need to be sorry :) I should've noted that I'm about to fix a minor
reroll.

Thanks!

Patrick
