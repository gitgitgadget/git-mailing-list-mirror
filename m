Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB62F199FB0
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 10:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759832851; cv=none; b=quxK8rYrDc48D+JsmqZJ4oZlvefr2bZ1Du4hnfW9bfR+FjH3tbEyhCHpYO8v3kEahC9biVyV1PiZDtADAi20lBxzETrfnb60auXvfvHqUM+/3K5X5sHmPmuIgo6upLcJ91ZSbkOyR+Uo+yRYK7lsayQ4ScOeV0AF6ZFGOMmyd3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759832851; c=relaxed/simple;
	bh=hjq1slg5WW8Tl+g3joOnYZ2Y/7XfN8bqiw3+W1GGpAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRNhSkIb0iJDbqiAz0lLISzB/msm62UEpnpI4NfU/MVTrhFk8qwR5OrSKBhEZhpJ08ceHTXIsBHF8MUZR6l1MU4T680x8EyeH9oT5LZpa7RBENYzAioBVJnxKEJRVolZLQX2tnFzdg7obLrxgX1XP5MuuIs91mPQ47Akyu2RVlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=d2WAfAuh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xJZLRi64; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="d2WAfAuh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xJZLRi64"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CCFE07A01D9;
	Tue,  7 Oct 2025 06:27:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 07 Oct 2025 06:27:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759832848;
	 x=1759919248; bh=A/elassd4cSsHvO/bc+v3ULSeKNW37W9mJTvqHv7b0o=; b=
	d2WAfAuhZFg5O5lKUj0+HHdLZw9QgjAbODh1Hgr6fcfYrSKAT496H8gvOxj3Rdnz
	zWkSWE/sm5lTjUf7WfvDeqCNvrAwbpQvHGJA1ZOv9ttblhzqFGvarFVqVyWdZnw1
	TMreGEqmnCC3XNn+MCFQ5avf3ZSm/f5qy3aqpBEIMR+AiwfyutcqvkE0/MzN3bzS
	iMpuJrDlc5usLye5qPI4Pl62WTsWXb3blQYmNAndhSJ+JpJxtWyc8HFVCHxr96e5
	DORNmal2/LSQ+yeYcRpbZGRgW/mWbJoXCRKuBii8JY5jmEWlYDCLV8rSq6e2+OGS
	EoJ2WpecnaB6oAXpacv5yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759832848; x=
	1759919248; bh=A/elassd4cSsHvO/bc+v3ULSeKNW37W9mJTvqHv7b0o=; b=x
	JZLRi6472uCtyAfaNBZA4kvWUK8rxesIri1qi1n0D6pebpmpgZZii8Ocy1Azc634
	0BVPr23NBc41HeGf8uVuXlu6VNxt1P2GQFOwkrVlb7JoYn/czioWmj3GtH3zkC8J
	te30YBjCHfxA+U/z/BxxX++DTnFzGIQFRLR5Wu5feV4Nw3xrU+EWT86Ug0ehtAUX
	Q02FJqqmN4iKhB7wms6T8m4eyx7jwvHE3uOL67poxXGfVFV3T7O4fQ9Wh4ACnkxE
	5BCbmuXzQe2v5aVB6fWIEEoybY/LOeU8eZEwnEQvk9aBpRQrPg+RNzeSyin7wi2h
	RCJEZBWg5Sp6rR8r0A6ww==
X-ME-Sender: <xms:EOvkaCCxN_Tn9nnUNemW3Y_4adYpE_colN1XpACo7yBgTvAzZye8mg>
    <xme:EOvkaDYRhilyisOx5O8RxvLJUGiOaxA-Gzf5kg999emwvpFJOpSlgk_4Njl6Q_Qk3
    H7RwRF3b4hKgSExgt_5eFzXy8W7PoJJs9xpPLly1rG-nMFB6d8C>
X-ME-Received: <xmr:EOvkaN5qZnYzlrTBEs8NNNwgK-jT3X5kianNxUSLr5YHZXJ7gIZDFxPA9nvC5t12lEz2uEeTKZzaY_2sDp-oUGYDHQnXPu3_lH-VqexT-rM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhutggrrd
    hmihhlrghnvghsihhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomhdprhgtphhtthhopehmshhutghhrghnvghksehsuhhsvgdruggvpd
    hrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:EOvkaMYe6PtBKYk3qr3HligsdAIR1QDAfw4fcC99NZ2OaXAU2z4Agw>
    <xmx:EOvkaEi7GBWSDiECmxsCHCvpW5TZJ7NPz1TLvOXQlBn2CZlbo3rkxw>
    <xmx:EOvkaF_HJk66vSNzKfD2RLYd6Cc1Go9sekTudht3t0Z0RB9zO2fIUA>
    <xmx:EOvkaHqFb6G6fVZ6IYOHHkHLgkBtvYi4XOAJyZilypEJ1Jd2yv6uWg>
    <xmx:EOvkaFGoNOc9WsV_30gbl-ZxHAJCx-Zq_FwtM3SHNyWzCdrzUYQAFQr2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 06:27:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6c432de8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 7 Oct 2025 10:27:26 +0000 (UTC)
Date: Tue, 7 Oct 2025 12:27:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc: Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	Luca Milanesio <luca.milanesio@gmail.com>, git@vger.kernel.org
Subject: Re: When should we release Git 3.0?
Message-ID: <aOTrC8CRZm5hERgr@pks.im>
References: <aNxivuJEnSHbQNdr@fruit.crustytoothpaste.net>
 <E03F997F-1738-4CF6-B7D5-206183FA5BD1@gmail.com>
 <aN1RFvz7uGPnepxe@nand.local>
 <aN5-n_ArhQqaQZgt@pks.im>
 <xmqqfrc1xqsp.fsf@gitster.g>
 <aN6j7giOosGreKUW@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aN6j7giOosGreKUW@kitsune.suse.cz>

On Thu, Oct 02, 2025 at 06:10:22PM +0200, Michal Suchánek wrote:
> On Thu, Oct 02, 2025 at 08:32:38AM -0700, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> > 
> > > Once we have roadmaps, we should set a strict deadline that takes them
> > > into account. Any hosting provider or implementation of Git that doesn't
> > > provide a roadmap will not be taken into account in our planning.
> > 
> > Works fine as long as we assume everybody that matters will
> > eventually want to move away from SHA-1.
> > 
> >  - If a stakeholder gives a roadmap that has no SHA-256 in their
> >    future, in other words, if they are content to serve only the
> >    SHA-1 projects, what's the impact to them?  We are not dropping
> >    the support for SHA-1 in the sense that if you clone from an
> >    existing SHA-1 repository you'll get an SHA-1 repository and you
> >    can push and fetch between them just fine, so presumably that is
> >    fine as well.
> > 
> >  - If a stakeholder gives a roadmap with SHA-256 so far into the
> >    future that we cannot wait, what's the impact to them?  Their
> >    customers that want SHA-256 earlier than they can supply could
> >    move to other hosting or implementation, but not really.  Both
> 
> I suppose that's already the case to some extent. git does support
> sha256, some forges do as well, and some people want it to the point
> that they install such forge, and create the sha256 repositories
> although it is not the default.
> 
> There is some tradeoff here. When it's nice to have but not required
> people will use it when convenient. When it's really required people
> will use even an obscure implementation to get the requested feature.

True. In any case, I think that for now we should just wait how such
roadmaps would look like and then discuss based on the findings.

The question of course is how to get such roadmaps. The easiest way to
do it is probably to gather a list of known projects that would be
impacted and just shoot maintainers or representatives of those an
email? From the top of my head, that would include:

  - Implementations
      - libgit2
      - JGit
      - Gitoxide
      - go-git
  - Forges
      - GitHub
      - GitLab
      - Bitbucket
      - Forgejo
      - SourceHut

I probably missed some stakeholders here, so please help me fill in the
blanks.

> >    hosting providers and Git implementations have components that
> >    are move than Git that are hard to migrate, like issue trackers,
> >    CI services, workflow tools, etc., that make their customers
> >    captive audience [*].
> > 
> >  - If a stakeholder has a roadmap with SHA-256 in line with our
> >    timeframe, do we still need to assess the impact to them, or as
> >    long as we and they work hard to stick to the plan, we all will
> >    be happy?

Well, the impact in that case would be negligible, I assume, so everyone
woudl be happy. If plans change then we can of course also adapt our own
timeline a bit, at least as long as they would give us a notification
well ahead of the scheduled flag day.

Patrick
