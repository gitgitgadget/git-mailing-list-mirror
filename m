Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3D333D4E1
	for <git@vger.kernel.org>; Thu, 21 May 2026 07:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779349519; cv=none; b=gXcINygvqcWOEbVK3tf6D4uH7E9oC8BSu4V34YZS3J+p4sn/lWs0GIrRpEDQ7+L+H4TOnGKndVm5sPGGytnE6uayQKYNClFyrvO6t1oXZ9mxhfOG/fUt4HVTM0qGIyVD4VZyg0gbZgsdLxyaD/VRWT1vNtW46XvUYbcKVz04uA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779349519; c=relaxed/simple;
	bh=CeTY+dHap9Zka3zya6xOVjYNIJo72xqe3U5w0k35aIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xea+OZW7WGsBHVahiNu5+n43MpX25OrJu+wOFJBtR61hGIeVgyNBhN3Zo6vKFvM9qyyYx0XN7NjOwx5De4ErFSmrqIZ+FOB+pIuzfxIjAmiZtav/H3Zi7rMFpRUBBmrZaSvfCaEfZvoW8Dt3fbHrTkB2Kh26F14VeF43RMxEp6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bcehX9SY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bGNwsIr3; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bcehX9SY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bGNwsIr3"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DF90214000E6;
	Thu, 21 May 2026 03:45:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 21 May 2026 03:45:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1779349517; x=1779435917; bh=LQo09X9ATk
	flF49/wTo0cGl08pg9McW0HVBW6TfSLEA=; b=bcehX9SYfWLb/GtcQpQSYuDJTe
	4KV7mUtTgUYFelXCXZ3sd6UgmVrrx+CrV8S93y2cL6OBCZPzPc/8uubjq6hevz9m
	ZG7rJTxvEqqhXVVxP0B2TCH8VH19cs/0PEorLO1FINFNA1yg+g64ExA2xNVg6C8M
	uslGomVZRfQv1V9TYpIyZMNC9l+X9RtlU5Vb+G+5I4aLbCZhFHDmm7PRqS6zrCY6
	aiIUuSpDKfXuQr9092/+FnGMZF//q7PjSBsQggIghLCTDkHkFqnfFk+ltBIYJqGs
	AqeRqo/0gPaSsjKjvgN/Ua8cJEk8ZID+s2J0n8EKuX2jsXdZZ7EyPAcYxIFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779349517; x=1779435917; bh=LQo09X9ATkflF49/wTo0cGl08pg9McW0HVB
	W6TfSLEA=; b=bGNwsIr381vlL4hTavsOOazkPFSJgVUpuauk+zv2daQME1N5if7
	SQxT3HjJ8IHoVHK33hfER2tQ7jW6z1x7N1XIsjJ4qpZzZQ+Cw1MzxssBAJ/tQ0Np
	sVbbKniFDi20KSxkVt9aODW05Oq4ahMOxIKhs7BAUZO1MBU4aYYv0zr8H5GaPCEn
	60eD16Yx9+dgWCB1Ny/IbEl5L5P6Uw7WJFpwjM7GArwkcPcXhFH+7LNaTMje7uXc
	bjkH9Mj77UppQx78+BHmMMZP72qJ+jbkaVaHexwCvq80gxEGeOl6GFVuau1LmsBD
	iNMYWbtT6HTl5F1mTx9oQOVOoyWaCn/VQQw==
X-ME-Sender: <xms:DbgOau24hCpf4YrvPznqdW9RSFMzO8ObXu-sv1HMUA1MX0WBUHAFaA>
    <xme:DbgOajWv8VcSOi38K11C7_pOlURssYIkjP3Rk9-dy-yh5S0ItmQZnfZa1YcmnZj7x
    _n6zN0DzUXXap6WufhoSyFSU40DIuG9vxUpNfKMIz8foV1EAAk2Bw>
X-ME-Received: <xmr:DbgOapITcfs7XCQJxBYBDnlEJ1wRq0JW1qrx_g_zK6JHYVYN_AP6uhzGBdyJyzAH3H9QBPOsMBNdiTOhEryG92PivvpePt4UFZGsix7y2mE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeeileegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjeevudeggfffffeigeethffgieekveeffeehvedvgeeiteegueejleeihfeitdeunecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeej
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvggvsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepmhhikhgrtghhuhesghhmrghilhdrtghomhdprhgt
    phhtthhopegrtghtihhonhhmhihsthhiqhhuvgesghhmrghilhdrtghomhdprhgtphhtth
    hopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:DbgOal3vAdynIgyEzd3L0N2Zn6Tsf_WBOj78M9S0RP7_3LhZCIsjgg>
    <xmx:DbgOav5MUQH7OgCrm1vh0DcwBtFsY0j54OEKd_tVC2i4nD86ENUq1w>
    <xmx:DbgOau9bPys7UkYDjdmDwuBUqkjzji3oYjxYD0e5RGoTEbayLAOzzQ>
    <xmx:DbgOamU6wcy52O_LrS1QA95lEViOvMUhek689nhh-CAQexXmi-vP6A>
    <xmx:DbgOaisnDnM_z3UXjPRNRYmlkHjGKfMS9QydQzKmDEs_3wjZF_dPHLYc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 03:45:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7f7e8a45 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 21 May 2026 07:45:14 +0000 (UTC)
Date: Thu, 21 May 2026 09:45:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jean-Christophe Manciot <actionmystique@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>, Jeff King <peff@peff.net>,
	Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 0/2] builtin/maintenance: fix locking and respect
 "gc.auto"
Message-ID: <ag64B4w4vLiJTwdb@pks.im>
References: <20260511-pks-maintenance-fix-lock-with-detach-v1-0-ccd7d62c9a40@pks.im>
 <ag6ahXA104_70g3e@pks.im>
 <xmqq33zl2tok.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq33zl2tok.fsf@gitster.g>

On Thu, May 21, 2026 at 02:55:07PM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > On Mon, May 11, 2026 at 02:29:54PM +0200, Patrick Steinhardt wrote:
> >> this patch series addresses the issues reported in [1]. The series is
> >> built on top of Git 2.54.0.
> >
> > Junio: I saw that you are starting to prep for Git 2.54.1, and
> > a89346e34a (Start preparing for 2.54.1, 2026-05-21) explicitly mentions
> > a couple of additional topics that should land in that bugfix release.
> > This topic here isn't mentioned though, but I very much think that these
> > fixes should be included.
> 
> Sure.  As of https://lore.kernel.org/git/ag1MHje6-C6nmcO4@pks.im/ I
> think it can be merged to 'next', which will allow me to list it in
> there?

Yeah, both Taylor and Peff ACK'd this series, so I think it should be
ready to go.

> Are there other topics that should be fast-tracked?

None that I'm currently aware of. Thanks!

Patrick
