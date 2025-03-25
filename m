Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153771C245C
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 12:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742906576; cv=none; b=XI2ZIlLJbMdxhokTk+hwlS4nManFQEpdRoWXap0Dsy9hHU4emSNWhnBlBwYN6aRSpiBzPbBb7eIbY6nge26xYT85XmBmFPcy3IB2gSkPjLyOlD0aPz4u3fku3r9JulATlxAoDrt+LNi1VgYvIkTMp6NIK4RlB6tCT6SWsD+uvDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742906576; c=relaxed/simple;
	bh=ydGwZhJ3FBt/OTEzxnOWHndMf4q8971ehTeku327b5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbxfPk7AJejX830846P1BeqfOWNQGT98w7jpQh70dPebB3LsKHv0IsJMTdS6xP77f4ToASIdpzNSeoJd/IKO5V3ItZVC01UwaUKCS4zXzg6/ZTPa89oL7bpHRUec//jqtlj0dZ55qvorVJ9/SjauQ89rBPGax0V3wXBsp4wLUMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iFiqfCvm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sY8Gt2Cd; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iFiqfCvm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sY8Gt2Cd"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 34D39114006F;
	Tue, 25 Mar 2025 08:42:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 25 Mar 2025 08:42:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1742906573;
	 x=1742992973; bh=UI200iKB+KtlnpHexWfG8KaB0gtpBqf+yiPYpFZVHvY=; b=
	iFiqfCvmpMpLFXVarkLKmsHwcy7u31Egj7vqsHVjnyzaZ4bW1GBtw3L/Lp5n98d+
	jWA/hCeIEj5UNURxvh0FSUTJbNuGwsdMqkTfeGT7W/D51hMaX6MxMRVazsY3yMso
	xz9SZnqgI/TgXWZLdfRen4qPUzhMX2REMGhkGmGiTF9v+2Pbxk8lxmcQTEzO6YRS
	usWbqBieaMekX6jBt/fjrg5iKB6+R0XtrT10oyVC2QIgvXk1SzqJo+qMUu/JrsGY
	j3tWRsTrrEqnYgnqF8JSiSkymyYIrp5BoFZjMDER8D7N32USTOnRC3/yU4SLoFhZ
	4L0tfUDQbkJy0Ttph7bF5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742906573; x=
	1742992973; bh=UI200iKB+KtlnpHexWfG8KaB0gtpBqf+yiPYpFZVHvY=; b=s
	Y8Gt2CdN1QPl/bx5XZ0FhSFCInFTvTofRMz0hRsEN/8ZbVy1b+pl1iB0Nyrb/MoI
	hTj68qbjOL8rvrhRyyUmdn+NpIhhBb84z74S0jPUm9ptyuDkpUVnvaBBM/1uJJjV
	aJHBe5LO/mJ9Njo0jJvr4Hk8OQfF/yrMYFOJ4+ir5RSj9JLJbtgu/Hmn+9J3COnO
	KXT7yRPU2QCjV/3qg8YxDtG4cCTSaim5m7tNPiz6WTxndtgpl4zWcdCPodyOOdGw
	yhn6F50U15MaPTEXJrP0YiwQMwcQxcqJw5XQQLnlJ0cDehxrLFyzVGILY8FdexUR
	zBvOJg95BgGU+JTcZ/GGg==
X-ME-Sender: <xms:zKTiZ67PvclXBW44SxrF9v9DSR0R1ci6Zn4fRwWmFhcblp6G8b_TXg>
    <xme:zKTiZz7dxQ7poDU_llbIJ2yFKODc1krUqfCOX4ohfXzwe_Et8YcayXqd4iiGDh_5y
    jbd9xFCxODmTYUgFA>
X-ME-Received: <xmr:zKTiZ5c_jb9dI4WsSAbqXER3F3boEOeBreBTpZbXdkLnaDtYbs7Dh_5b8ikbKO1TB0UwxtSOLA6HXZB9shrBE_UujgJ5IzDfQqPhMh57s4ZoLQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedvieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedv
    veetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtg
    hordgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:zKTiZ3IpXUypGrmGz6c6VOu71YhSMdBx-j_FnRXC6DEoXqrDwgwANA>
    <xmx:zKTiZ-LVQoTu8C3iGlfqleC410xAWLXcUPpK0D6pE3PYCccECHMHgg>
    <xmx:zKTiZ4y53AVUdd2e4ON8NQxHyPFr2TYUMjiu40GTqZQG7ItLcax0xA>
    <xmx:zKTiZyJaXLUPJwoAoWq-znFw471p75qM3gdsCbAIBtypigy8yBiN0Q>
    <xmx:zaTiZ61EloMo6cjTDbWs-T3XSc5AGoIYFLha7PK553PJxWzBWIGsz9iJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 08:42:52 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9e1c23cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Mar 2025 12:42:50 +0000 (UTC)
Date: Tue, 25 Mar 2025 13:42:45 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 13/20] t: refactor tests depending on Perl for textconv
 scripts
Message-ID: <Z-KkxRcgTtLRd2W-@pks.im>
References: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>
 <20250320-b4-pks-t-perlless-v1-13-b1eefe27ac55@pks.im>
 <CAPig+cQdoZwY3u-xr49Jb8aaQmE69p4i4RUdy=cRv-V7VoWENg@mail.gmail.com>
 <Z-FUEhraLaDODbmO@pks.im>
 <CAPig+cSN5hU=XP1Gd8z=5XyvSEqJcTBiWhgyJxYNBPJWAi3yLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cSN5hU=XP1Gd8z=5XyvSEqJcTBiWhgyJxYNBPJWAi3yLw@mail.gmail.com>

On Mon, Mar 24, 2025 at 12:07:52PM -0400, Eric Sunshine wrote:
> On Mon, Mar 24, 2025 at 8:46 AM Patrick Steinhardt <ps@pks.im> wrote:
> > On Thu, Mar 20, 2025 at 03:37:08PM -0400, Eric Sunshine wrote:
> > > On Thu, Mar 20, 2025 at 5:37 AM Patrick Steinhardt <ps@pks.im> wrote:
> > > > -test_expect_success PERL_TEST_HELPERS 'rewrite diff respects textconv' '
> > > > +test_expect_success 'rewrite diff respects textconv' '
> > > >         git diff -B >diff &&
> > > > -       grep "dissimilarity index" diff &&
> > > > -       grep "^-61" diff &&
> > > > -       grep "^-0" diff
> > > > +       test_grep "dissimilarity index" diff &&
> > > > +       test_grep "^-3d 0a 00" diff &&
> > > > +       test_grep "^+3d 0a 01" diff
> > > >  '
> > >
> > > This change seems unrelated to the stated purpose (`textconv`) of this patch(?).
> >
> > Not quite. The test previously didn't run because it depends on the
> > Perl-based textconv script. Now that this textconv script was adapted
> > to use shell scripting instead it can run, but as explained in the
> > commit message the output of the textconv script changed. We don't
> > really care for the exact output at all, we only care that textconv did
> > its thing. But we do have to adapt the test accordingly.
> 
> Okay, I see that now that I have read your response and examined the
> change more closely. The unrelated `grep` to `test_grep` change
> visually overwhelms the diff, so much so that I overlooked the other
> smaller necessary changes. Perhaps it would make sense to mention the
> unrelated change in the commit message but is not itself worth a
> reroll.

I already tried to describe this in the commit message, but obviously I
seem to have failed :) I'll add another sentence to mention that tests
have to be adapted accordingly.

Patrick
