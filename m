Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E1420B1F5
	for <git@vger.kernel.org>; Wed,  7 May 2025 06:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746599284; cv=none; b=C+ZGBtqzmMo9VIhJlR7D+e9W03LRiL9EnyXTYLVgqel5pq99AhbBP0ZvKMK8ktD5I57ZG263ORn0K56z5bWWhdBW1dBlXKobSrJxWCnmGPk7vUaTgTfioVW5a86OtkI5Sdf8Z0XihRuGlsq8bJ55+GvFYcJuBJc95S3OuMfLe4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746599284; c=relaxed/simple;
	bh=GyLEK0U9gRiOfW6Qp27FIhDp4xPv1ml74v7Ac7hISUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukYjYVjSYDj58wJcfY31NAL8cbTpPg2jxSgtSAWfvIM/ScZxr1M/ElLFPwUf2/98AjYb3m5SZ05i6xyWHH/7xVYoe0lErahe388AVWnyp9cyJu00JuHQN3/cV68+K67Vh6Moa6B0ylgWHENvdMIEeGWGrAyJ2kOd8uNNbyoi1Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=z4ZfQtJa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WF/CH0ji; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="z4ZfQtJa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WF/CH0ji"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EA9A625400F8;
	Wed,  7 May 2025 02:28:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 07 May 2025 02:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746599281;
	 x=1746685681; bh=NbRCvdSQNMQrxuxHsxMENqOt0FVz7wlO88R7yCCpEQw=; b=
	z4ZfQtJa5yflBg2t/0A5WHgBsyd6zD4EIg9B1bvz64cTDZGL6gl4j/4GnqIRq/jJ
	flMnKcLLPRAQ5MfvuuZBUWUaFdWdebEig1ql/NUZyu2iqeESnQjwHmchD+UzcniH
	EHAQhIWrfvVYFcST3XMSWKFjWgdizkGvnoNP2gGJSt7uyxUt55jiI3W7OlaULHUy
	S6T1sT9n15U+h5ZmB8Kk5X8EzOTksUK/W5NxCyyNGIeuS/Plge4QteNtqqEr38vl
	1Md00GLh4sB0LKc4VmLb/VAkiChD/139alALYsfG8dV95NJKqjl/6rRXA4z3nyMd
	PCkqZ3JvL25QMTbcU84RFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746599281; x=
	1746685681; bh=NbRCvdSQNMQrxuxHsxMENqOt0FVz7wlO88R7yCCpEQw=; b=W
	F/CH0jiqeliSxZ06x1QqRkgef0KO4dgOIV1hMpbon6gJ++u3w/AebaYn/xyOoGA3
	oRs0IRP4hr8BgtvY77dCc0k1sWskpbIJY2XFhWJ9/E/Bv/yOVe+NpdK7CuTfCrjQ
	gZRfWm1+ZTmmitIITDDXQ8BcVBmsOoCGJIDw1+C58EuD7wfB/m03Yk6B9HLjXjix
	ceXyh5IXN/FYD9GvrFDtKPSiJw4jFJgU/9kZrDLBEvPkIRMhfYCH3ls5jURu6oQ3
	gcS9z8KpHRCY5rmwNmKRHDafCbvJAHYJjBKkTfofceUxuwz9nIa2oAVkjjO56deJ
	V7c9dK/n2Sk24eJKciN+A==
X-ME-Sender: <xms:cf0aaIOc-PzLswx1C6kX-7tZUhvpM0FxxF0TcezdL4hPOABrvAiuvg>
    <xme:cf0aaO9xMj0j_z7Lpi28U5mMIuVC4HT81oWtHpS53IXKiFUuke-qBsS_i-IuE9Z2p
    4ryjX76TkZfLAqsAw>
X-ME-Received: <xmr:cf0aaPSUi6JD-da4uMPVLxSsFbZw7fPkjaQ2o-i4iV1TUO-juKQ2zLd6GdACRwtZG38mSZ7n7Twjk8rfP_XvQs62d-V4bD24F9r4vVKNtO6iUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeeiudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeefheffgeeflefgieduleehueeugfeifeevjeej
    veelheetvdegjefgkeeguefgtdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhmpdhrtghpthhtohepthhmiiesphhosghogidrtghomhdprhgtph
    htthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:cf0aaAsQFcuH8A26YVu1YHMNWLp84yOwvTb8hrYzZzvoOehrbmYDfw>
    <xmx:cf0aaAd7yfSpF4eMKgEywg2ouvVhgqjxT_RlIIUzFOdAcjlICPpOfg>
    <xmx:cf0aaE1IrDsPgG1RVOzgXb3px9jsxUyElbUjeT0IVkXPy6HH-y_bWg>
    <xmx:cf0aaE-I6RAqMM7eb9fZBaLXf9oVN1tCk8TcnRTL6LpQnTKmFUSESw>
    <xmx:cf0aaIDZcKnz2mJTovNAE4KSCUOdhOGw1rxncEOZ-C6RQP5CGq3VET7h>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 02:28:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id adfea2dc (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 7 May 2025 06:27:57 +0000 (UTC)
Date: Wed, 7 May 2025 08:27:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Todd Zullinger <tmz@pobox.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 00/10] Spring cleanup of "contrib/"
Message-ID: <aBr9bwNQ1J46NNXI@pks.im>
References: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im>
 <xmqqmsbph3lw.fsf@gitster.g>
 <CAPig+cT6XbdzeOFoeZUmX+ozPa2XNOv=H85xQhY4y8NYmJZ6-g@mail.gmail.com>
 <aBq4J6UTZVPF8rb4@teonanacatl.net>
 <CAPig+cRxDQBmPu_-ci5vEuwtsAHadfCiFOccdYseBSj2F52JGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cRxDQBmPu_-ci5vEuwtsAHadfCiFOccdYseBSj2F52JGw@mail.gmail.com>

On Tue, May 06, 2025 at 11:55:20PM -0400, Eric Sunshine wrote:
> On Tue, May 6, 2025 at 9:32 PM Todd Zullinger <tmz@pobox.com> wrote:
> > Eric Sunshine wrote:
> > > Although we periodically hear that someone uses it, git-contacts
> > > probably falls into the "tool has a clear alternative" category. In
> > > this case, git-related[*] is a separately-maintained more functional
> > > drop-in replacement which people could be using instead of
> > > git-contacts.
> > >
> > > [*]: https://github.com/felipec/git-related/blob/master/git-related
> >
> > It may be worth noting that git-contacts is suggested in
> > both MyFirstContribution.adoc and SubmittingPatches.
> 
> I think I knew but forgot about those mentions. Certainly useful
> information if Patrick decides to pursue retirement of git-contacts.

I thought about moving git-contacts out of "contrib/" into "tools/"
exactly because of that. Tooling related to working with Git itself
shouldn't live in "contrib/" in the first place, but really should have
its own home in the Git project.

> > It probably helps that since 824503ce88 (SubmittingPatches:
> > clarify 'git-contacts' location, 2024-04-18) there has been
> > a note stating this isn't "part of the core `git` binary and
> > must be called directly." That is relatively recent, though.
> 
> Out of curiosity, I Googled git-contacts but didn't find any
> meaningful hits. Pretty much the only pages found were renderings of
> Git's documentation (including SubmittingPatches and the man page for
> git-contacts itself), as well as the few patches to the Git mailing
> list which introduced or touched git-contacts over the years. I did
> not find any general discussion or recommendations to use
> git-contacts, so perhaps it indeed is not very much used.
> 
> > I added git-contacts to the Fedora git packaging shortly
> > after 92a5dbbc22 (SubmittingPatches: mention the git
> > contacts command, 2018-04-11), presuming some readers would
> > want to use it.  (I never want to penalize users who are
> > diligent enough to read SubmittingPatches. :)
> >
> > All that said, I don't have any strong opinion on whether it
> > is kept or removed, let alone when that might happen.  I
> > don't know that I've ever used it, other than for testing
> > that it worked while packaging it.
> 
> I've never used git-contacts either, despite the fact that I'm the one
> who ported Felipe's git-related from Ruby[1] to Perl[2] for inclusion
> in Git's "contrib" since the Ruby version had been rejected due to
> being written in a language not already employed elsewhere in the
> project. The Perl rewrite also included a number of useful
> enhancements which Felipe later incorporated into git-related after he
> published it as a standalone project. He has since extended it to
> include even more features, so it's functionally a superset of
> git-contacts.
> 
> By the way, Felipe also sent a patch series[3] eleven years ago with
> the same intention of Patrick's series under discussion. Felipe's
> series was never picked up but did undertake the retirement of
> git-contacts.

Thanks for the pointers.

Patrick
