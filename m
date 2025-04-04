Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03C91D63E4
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 10:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743764388; cv=none; b=njYzFyptC+fyv/dJ/vfmcrdO616CvQGktwsGUyUg7c4TRmNaDVyUM9QIjdfTztibrwldC3EuaklJG8paRf7Wsmsyfe4zCgmP8wvvwMy1xzZH63mhFeZF4dGhUDgV8ldL1dAC54CHB6+/xFYSipvRBfBQO2ihaBmJnkKRPxwaexY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743764388; c=relaxed/simple;
	bh=BoUWIvPPrwwYLyyOWiyNm9zlorSbSERispM9fO4xVM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtSUAyvMTUjdSbgZFP5MpVz4hxIaDiO7koYQylnpqhgYIBr5Vk0jS1FjKJkLs8lZQYU0ABdsN69cstUNP0g2qab6plzALgyhdlfEZAfIn0CCImtAaEPeH2ITf2qUMqHiXZd8wzWKc3W4BR+TJ/1jN6CwKt0vnCzRpmOAykpuCJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DsND82LQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W0tMTHY3; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DsND82LQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W0tMTHY3"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 8E1121140160;
	Fri,  4 Apr 2025 06:59:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 04 Apr 2025 06:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743764385;
	 x=1743850785; bh=Ff8t51qMIvl3nU0EeV+dRb03MJLlBiQ1K+/wRSHQiW8=; b=
	DsND82LQPVXWgQGaoEbhLMyVGq+Mwmnd5qToXQ6TpDLvlPk8bSh+safMZ7ksjjpo
	uKb3PZhplKfym2DXQjh3JCz5TwALyqhkg3AsqcKek07nBwCAN9s62YdB2u3H2/i1
	NyMJiVVv8EXPujIHB36NeIWVQJCCvBeu10H9SrD3F50vCGgeQl9wBnr74D6npIJX
	3q2EcLG5qn4dtZvTQKmsx/i4e9hKCCla1cv3z1x6ygCUFrrgTZ4glhcXaOimB38p
	+AzDHhH2tZd02C8TvO6pYWByMMTgFEHg5HsAlw1pv8QLoCyr22QfaMkiVtSTyngV
	E2tfQElNIIR94/cmXZNrcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743764385; x=
	1743850785; bh=Ff8t51qMIvl3nU0EeV+dRb03MJLlBiQ1K+/wRSHQiW8=; b=W
	0tMTHY3s4erdnRs652RQNeLzf57vl8krSrqax9LJR1hsTCEnXLmtAesKqKlulhcY
	m6yaK2T6hPEoXgYKFBj6kXjeQsRvZNm/t6Lk615AfxMUCw70fb7F49Je23c1LAiO
	m6bGo+PXYkOZaOb4MQtNnA3fVjjOV+Cp/dxbZHSXsSo/P3WOmvSnotrHVynVXhEQ
	o3icefYT/9W3ntHF/1OklISa1oac2e2D8ANJjwhMyVCcVwQCUOedalPwI0ZRdTwH
	f1TieFN5Tn/0q2q4KK3p6p4WfuyLVQIW2hCRgZeMpFNyXj5Pe16vCvpWzhvBaYsN
	Rc+gNqErA4qAMj0Pl1PTQ==
X-ME-Sender: <xms:obvvZzGIWiRIpFGUKfI46N8ETxuV8Ab0JFdY_h3ns73qEnXIv5MzfQ>
    <xme:obvvZwUfCiR3oMMkMtEyPmecYmT5ukv0pA_p5KVbv4NFAaWfkshYJggU8ngX_n0MN
    3p3LM1FfhYuQz4I0w>
X-ME-Received: <xmr:obvvZ1ILKlZu9duzOsvYadWgk6xcvr9RhynNr9iMqymlqLqOE5cUzyfHVABzrLwCWlxHX4CtWqlAhARxD6WEqvPSCsbi-a9Qr_JQThFr6lzE3Zs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduleduvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedv
    veetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehnvgifrhgvnhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtph
    htthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhi
    shgtohholhesthhugihfrghmihhlhidrohhrgh
X-ME-Proxy: <xmx:obvvZxHqjUbeH4Ph71ZhWbR77lVzcO23q-n8wZlVv8A2YMtdAN393g>
    <xmx:obvvZ5Wzp0wF4ttlKfkZJ3VftY_ruEMpYlcuse42w2-N6R21dP9R_A>
    <xmx:obvvZ8PwAZPnsR0zsCldW05fFGN4dpJf5d4Ujh-H5sd7jQZnFixGjw>
    <xmx:obvvZ41GhNYay1ZEZ3ZF6uKtnBD9rlQVLqFMzieFz_FJdLug8M1HiQ>
    <xmx:obvvZ8qDXxT1WICDqb0Ih9x8V4cIOkKG2lQoIGrZ-xi8hkDm2JRg9Tix>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Apr 2025 06:59:43 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 199e0689 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Apr 2025 10:59:42 +0000 (UTC)
Date: Fri, 4 Apr 2025 12:59:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	shejialuo <shejialuo@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v6 14/16] refs/iterator: implement seeking for packed-ref
 iterators
Message-ID: <Z--7nfaKTpbBXbV9@pks.im>
References: <20250312-pks-update-ref-optimization-v6-0-f778e0414f55@pks.im>
 <20250312-pks-update-ref-optimization-v6-14-f778e0414f55@pks.im>
 <CABPp-BFBqC_t5QSexRQpYsqXBa11WK+OqGt167E=K=xod=buQw@mail.gmail.com>
 <Z--tomMthXftrdYA@pks.im>
 <Z--u2DlaPij_j7zX@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z--u2DlaPij_j7zX@pks.im>

On Fri, Apr 04, 2025 at 12:05:12PM +0200, Patrick Steinhardt wrote:
> On Fri, Apr 04, 2025 at 12:00:07PM +0200, Patrick Steinhardt wrote:
> > On Thu, Apr 03, 2025 at 12:56:39PM -0700, Elijah Newren wrote:
> > > On Wed, Mar 12, 2025 at 11:42 PM Patrick Steinhardt <ps@pks.im> wrote:
> > > >
> > > 
> > > > @@ -951,12 +954,41 @@ static int packed_ref_iterator_advance(struct ref_iterator *ref_iterator)
> > > >                                             &iter->oid, iter->flags))
> > > >                         continue;
> > > >
> > > > +               while (prefix && *prefix) {
> > > > +                       if (*refname < *prefix)
> > > > +                               BUG("packed-refs backend yielded reference preceding its prefix");
> > > 
> > > I just triggered this bug upon a "git pull" in an internal repository:
> > > 
> > > $ git pull
> > > remote: Enumerating objects: 161255, done.
> > > remote: Counting objects: 100% (55884/55884), done.
> > > remote: Compressing objects: 100% (5518/5518), done.
> > > remote: Total 161255 (delta 54253), reused 50509 (delta 50364),
> > > pack-reused 105371 (from 4)
> > > Receiving objects: 100% (161255/161255), 309.90 MiB | 16.87 MiB/s, done.
> > > Resolving deltas: 100% (118048/118048), completed with 13416 local objects.
> > > From github.com:github/github
> > >    97ab7ae3f3745..8fb2f9fa180ed  master
> > >                     -> origin/master
> > > [...snip many screenfuls of updates to origin remotes...]
> > > BUG: refs/packed-backend.c:984: packed-refs backend yielded reference
> > > preceding its prefix
> > > error: fetch died of signal 6
> > > 
> > > I made a backup of the repo with rsync.
> > 
> > Thanks, I can indeed reproduce the issue rather easily:
> > 
> > 	test_expect_success 'list refs with unicode characters' '
> > 		test_when_finished "rm -rf repo" &&
> > 		git init repo &&
> > 		(
> > 			cd repo &&
> > 			test_commit A &&
> > 			git update-ref refs/heads/ HEAD &&
> > 			git pack-refs --all &&
> > 			git for-each-ref refs/heads/z
> > 		)
> > 	'
> > 
> > I'll investigate.
> > 
> > Patrick
> 
> Okay, below patch should fix the issue. The problem is that the sorting
> we use for refnames is done via `cmp_packed_refname()`, which does the
> same cast. And because the uppermost bit is set for the emoji character
> this causes us to compare diferently in `packed_ref_iterator_advance()`
> and thus causes the bug.
> 
> Could you please test whether this works for you? Once confirmed I'll
> send a proper patch.

Sent via [1]. Let's continue with the discussion over there.

Patrick

[1]: <20250404-b4-pks-packed-backend-seek-with-utf8-v1-1-6ceb694e3bd7@pks.im>
