Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA31C3C9EE7
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 07:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774598032; cv=none; b=gSjoxYjCzmDfO8fkU0/THYqcoSdoNzbyK3T0k1spNjhfLRU/Hc16PzXGgpy4ycafe2I02dFrCOkq4Nm3ya9VNo5oqA9Ey4qG06UrlQ+8L/3sKqxQF7+M1bx1rJ9vIgJcBCyvn13vuUG4kqLL6Bu1UkPp0xIuwjN9YPvkZ4xrrbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774598032; c=relaxed/simple;
	bh=X+mOrLY0aw8nsjAgSrmgFw9iFqXsVBmmZ1iS6ak7CvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpbKYbr89/l7Ar76jk6ESr/skkHnn692EH+/341ZLIL5ToBT3tZKgmoEEoyVWFh4ZQady55+dilGFs99/W+FHbLXDJwqulcS7IVmf6806AD1uDIrZRXNMLapkXK61FxNLGvS/d1CH0dmvU81Oi32lq7AGUKP5+qDkRXU4Smx5UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FSHI/71X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eE+QOy2p; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FSHI/71X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eE+QOy2p"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C3EF9140025D;
	Fri, 27 Mar 2026 03:53:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 27 Mar 2026 03:53:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774598025; x=1774684425; bh=BHA605WJ7X
	ceVwf5GnuOD8zDiUngn5ul7iLIFO+SUfA=; b=FSHI/71XMz1RJ5sE0/eYHnHgF3
	EpForcdgftkQ1/M6RobH5guiYub3wERQ+gVBYOm9F/MQ5s01vTwu7Ovqxv4pEm2V
	ZEQL7Jwc0SMHeBNOxw2IaRL0I6HkLkYET5peCuqXr+DeqUUouakbZhTrPLk1iJCb
	8RPz486QJidVo5tHl0WjwnpSIavg1MFjV7FolSxtceLkKvpcSmjaGwlzE/lxY1nT
	gPDQ4NogD2Bw6e/V0+rGHH4EcaaeSre5A/UWSivABHW5cRHF6zGiFg6v5/MPfktl
	s4NKw1VECcCo1pbhpDgihlyHzS1OzjvWQh77yh4d1vE2BvEhRFMcVUS1McmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774598025; x=1774684425; bh=BHA605WJ7XceVwf5GnuOD8zDiUngn5ul7iL
	IFO+SUfA=; b=eE+QOy2pllSn5RObbWlHtsAFtN4udYkUJTkg5iiRCSnO4NYJhRe
	cBAkBObbajJ74j1lLv3EaJkTzdxrY3QivhViUsNBHJFQ75huAJyEZdpy+V9+LQL6
	3KD9qxTNe3XoHy5+nUdGH4LUmKPvQesqju4b++lKwkU+uO1DMTdQLkZLVQRRHyZM
	G8slKMcXP/HZxviYYtF+Q11bpNqmo91KG4UKh9Eny7tcF5SlHwyXGhNtbh8GCBFD
	kjcT9VREk5Qpgco62gLmpDl4Yhl5oCRU6wx7uExhtiD1s+9SxYaSivbccfKJJz/o
	ZmLsZvnLMQuOP7LfP52ShRx336ZrEjUZqtQ==
X-ME-Sender: <xms:iTfGaZdcg_LOO6MR6u6tpS-OyMesvHTdobRjSbkQ0sdhLBtC1vZMfg>
    <xme:iTfGaeoNJEbr2k200jy78eBQ8Bvz9MRoZei0zB-Xyl5Rh4SOVKhDXHrmwmVIMnA3J
    xFmeLZdGacMAHzDIFH_ktZvfyIDizAL9qWgDwY5pM2wWgEXsds0_w>
X-ME-Received: <xmr:iTfGaf4wEDZvXV6KVWcFkZYD-54c93xEfMuEX1TOfgyEXTGej22hLrI2cEpTjEMXQTJWF-X9ug1MivsG7MJiAJoIffy2GhsKCZY5qJ1jLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdeljeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:iTfGacqT2-cuCzHggRdUyUIPMIetekhbFmWVYkSxc9C-P9YpWxGoDg>
    <xmx:iTfGaZjk3tNLkvXPd2X2GTP4M2U48VSOKfNiyzfPtoiP6ZMIKogp9g>
    <xmx:iTfGaeJl-Q1nDsBIbGeceTEgqiRonL7adVI-amHCqIXqgkFo79O47g>
    <xmx:iTfGaRB35FoYWXyajrkf7mJhPQbo_kxE2mpZqOzry8m-01VlVE7EZA>
    <xmx:iTfGaXa-nEBUNC7wxmy8GJkkwYAA5RssMnmXbnmboG-uUWqyFWDDIPtl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Mar 2026 03:53:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c6eff644 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Mar 2026 07:53:43 +0000 (UTC)
Date: Fri, 27 Mar 2026 08:53:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 01/11] test-lib: catch misspelt 'test_expect_successo'
Message-ID: <acY3haGPHPLSfalj@pks.im>
References: <20260325062114.2067946-1-gitster@pobox.com>
 <20260325062114.2067946-2-gitster@pobox.com>
 <20260326040828.GA686242@coredump.intra.peff.net>
 <xmqq8qbesm1r.fsf@gitster.g>
 <20260326172920.GA2447148@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326172920.GA2447148@coredump.intra.peff.net>

On Thu, Mar 26, 2026 at 01:29:20PM -0400, Jeff King wrote:
> On Thu, Mar 26, 2026 at 07:27:44AM -0700, Junio C Hamano wrote:
> 
> > >  test_expect_success !MINGW 'a constipated git dies with SIGPIPE' '
> > > -	OUT=$( ((large_git; echo $? 1>&3) | :) 3>&1 ) &&
> > > +	OUT=$( ((large_git || echo $? 1>&3) | :) 3>&1 ) &&
> > >  	test_match_signal 13 "$OUT"
> > >  '
> > >  
> > >
> > > That neglects to echo $? when large_git surprisingly succeeds, but that
> > > would mean $OUT is empty, which would cause the test to (correctly)
> > > fail. I kind of hate it, though.
> > 
> > Would
> > 
> > 	OUT=$( ((large_git && echo 0 || echo $? 1>&3) | :) 3>&1 )
> > 
> > do a bit better?
> 
> Yeah, that is better (though in practice the same for our purposes in
> this particular test).
> 
> > We can keep fixing things one by one as we find these little
> > glitches and gochas, of it may be a whack-a-mole exercise that
> > eventually will turn out to be futile.  I dunno.
> 
> Yeah, after getting the tests passing locally I pushed to CI and saw a
> ton of failures. I think one is just:

I think the exercise is still worth it -t most of the changes are
trivial, and it does help to make our tests a bit more robust.

Let me know in case you get worn out by this though and then I'm happy
to take over. I like to have a numb task every now and then where I
don't have to think much, and this here very much is such a task :)

Patrick
