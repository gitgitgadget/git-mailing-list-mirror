Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AD2191F8C
	for <git@vger.kernel.org>; Wed, 11 Sep 2024 09:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047188; cv=none; b=tqui1HSCWfNPaCGThtypNXgRx1UfxuGkbztLqfRZKpxAdEcuqw1czRqWbZmE3KVjPYvhQreToVL8fmeI7j6z7PMixj8jOcO5yFCh7ReOTKAz1hBK2/t6M6i6ZYhGbgt1STp1cn2YmIDgZoem+XhyEPHrCkCPTT3EdzRz7mfWrVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047188; c=relaxed/simple;
	bh=oFFaxjPfwjHuechSJafDJZkMMfor+foJeq9reLbFiro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJFoZKdjF12ZTNuva53NYANhwSLI3e0UsUaVpkWO7TQp2Tqi3T3YAQ/nrGT8NoDi6mogPX/ojZQAFzNOLDr+szFxN9ieySIxxcV5OoX3pGZ5nnTVCAgtgH+oVNN9dqJmj2Oy+c4Zgp8/rKRzBR7KPPvsycDiEalF/eewbs+DhQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T4sFtGc0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HaZQIgUW; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T4sFtGc0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HaZQIgUW"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A297711402B5;
	Wed, 11 Sep 2024 05:33:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 11 Sep 2024 05:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726047184; x=1726133584; bh=C8pOoz1PfD
	c9pzgz2h7SXnFtHD6UoSGQGl3YfF5FUPo=; b=T4sFtGc0dMxdI48eLGK5FqcTt2
	bSqBX2xKKSZZGLW7qh9hoILx4jmYLRA0LMU5cL6SZ158xT8BBgVtD/tjPFdUtGco
	HB1gMr7IZrj1Ej5cB3niBoeKCvDzqJpO7atXKnPkqXpckopsO37TC9h7Pq7gRfhf
	GsVkyUfatYiWl1TFqlZNe2UmaPIXsbtoSEwrswV4xjLK3o8RsxkTi3BM04/oBHml
	l2J+1iirSPdDL7tniqbRy/gF3nn2Pc2VQs62j7YIML9fZl3yE6QvtdWaYfHABNU0
	YoJ0tZB3LR9oEtURlXr7fH1C0cbuinifAErf5y+Ku+8D9Egbouijc87UctfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726047184; x=1726133584; bh=C8pOoz1PfDc9pzgz2h7SXnFtHD6U
	oSGQGl3YfF5FUPo=; b=HaZQIgUWMBA73Svo5EgtoiCjhwaFlOcdVo7b+/s5MkCt
	pULQM+gWMDZkp5xNhWWepqJ8WV2zI1yWdSAFZcvV6LeV1WfGKHC8mHIWXWKYCNSr
	vwALRKtwfWs0M//BUrwtC8kd/WHh03LJX/Z3oCX5lFiokqfaSv4UySmDvpA1gXWm
	xwO+K57EKo8gptR1lTBdTQZ9Tun51t/LYNqODWGjvicpQ7qInD2vzTXHsgPqvxdD
	ZpZXoRBiEI4kRzLqawfKqz5C/1Sc9IHZe1R3tvLYuy1YXKy4bgG0h3L5LwYBnUZo
	1SYgT8HrEn8a0MCRkHiJhMK/ig5dj+X2xyiUm2qdIQ==
X-ME-Sender: <xms:z2PhZjjoGU-2u8aFyinApfyV3ItcsRzCuN6yLLcomjQICB2duPIzyw>
    <xme:z2PhZgBMQODM908kQ44y5CJ-P3DVUlG_VluXk_O7tToYgpVut6x1CoWs7IXpqs37-
    g_Cv-ZJ43BEuqwq4w>
X-ME-Received: <xmr:z2PhZjG0CEdDvfBiBgH7xRxqASAs_Rnd1NYmSBdPcCpYV4j9t1JRltjYzGeNuRScQwJWAS4kZPrjU3qu1unZag1WJFbsjSP3-V2EeGDenEJetY0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejuddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhephfeigfdvffdvtdeuhfelgfelhefgfeevueetffdugfeh
    tefgveelhfeuueevuedvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthh
    hrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehsfhgtohhnshgvrhhvrghntgihrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegrvhgrrhgrsgesghhmrghilhdrtghomhdp
    rhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepohhrghgrnh
    hiiigvrhhssehouhhtrhgvrggthhihrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdr
    fihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:z2PhZgQrqPANUZ5bL3AOvXbRsPAAVGPQGFCAfeMZucnfr-xk8ShGkA>
    <xmx:z2PhZgytM-oH7utKHTYyyElUEcsexpgXxQyZR_jn-ryhyuTIRxkPXw>
    <xmx:z2PhZm4ScJUZ_o923uKoYRFvphndYrX5dAs1V78PNrCMGd40q8Lz-w>
    <xmx:z2PhZlw-TCXMAW-dXerxWGROvuF56VBxK95UTfks3yXbUC1m5jQjOQ>
    <xmx:0GPhZvkKgVhMHJkEnOfPDcPkwz_u3hN2rW7I5tu55ivuvGkF09dk-zWO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Sep 2024 05:33:02 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6194ea90 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Sep 2024 09:32:53 +0000 (UTC)
Date: Wed, 11 Sep 2024 11:32:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>, Git at SFC <git@sfconservancy.org>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Tilda Udufo - Outreachy Organizer <organizers@outreachy.org>
Subject: Re: [ANNOUNCE] Outreachy mentor sign-up deadline is Wednesday
 September 11th at 4pm UTC
Message-ID: <ZuFju0xlybZ_6Ps5@pks.im>
References: <CAP8UFD10B4ROEjvP7MPygALuUFgyBQqZVhAjgSUris3cdiowsQ@mail.gmail.com>
 <Zt6pbMP3Rpjy-pC_@pks.im>
 <Zt6rC7TtUvxWGXN-@pks.im>
 <ecf84ea5-2f4a-4a80-b7d4-0198f2fd6ee8@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecf84ea5-2f4a-4a80-b7d4-0198f2fd6ee8@gmail.com>

On Tue, Sep 10, 2024 at 07:31:44PM +0100, phillip.wood123@gmail.com wrote:
> On 09/09/2024 09:00, Patrick Steinhardt wrote:
> > On Mon, Sep 09, 2024 at 09:53:20AM +0200, Patrick Steinhardt wrote:
> > > Thanks for organizing this! With the clar unit testing framework having
> > > landed I think it would be a nice project for Outreachy to convert (a
> > > subset of) our unit tests to that new framework.
> > > 
> > > There is still a bunch of work that I'm in the process of upstreaming
> > > [1][2][3][4] as well as a refactoring of the macros to make them
> > > typesafe that I'm currently preparing. But none of these changes should
> > > impact how the clar is used, so I would say that it is fine to queue up
> > > such a project.
> > > 
> > > Patrick
> > > 
> > > [1]: https://github.com/clar-test/clar/pull/99 (MinGW and HPE support, merged)
> > > [2]: https://github.com/clar-test/clar/pull/100 (CI support for Windows)
> > > [3]: https://github.com/clar-test/clar/pull/101 (out-of-memory handling)
> > > [4]: https://github.com/clar-test/clar/pull/102 (selftests)
> > 
> > I forgot to say: I'd be happy to mentor or co-mentor such a project.
> I'd be happy to co-mentor a project like that
> 
> Best Wishes
> 
> Phillip

Thanks. I've created the project and invited you as a co-mentor.

Patrick
