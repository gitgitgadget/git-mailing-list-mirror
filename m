Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CED28C5AC
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 08:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752135941; cv=none; b=JFwr+IdYp0DhR4PKjspEb4tSFnH2ckVbsDygJQS1xcbH4tJJOlVte9B+zk2xV2W0VzBDpKkTA2paP6HD554i62A8AB7rKkc4WFzEtcm+m9NfkRsWB6tdjxytjexK3DwPsi9xCmXn61sJZE4n2ynGFUm+kjb1Oi59AFdmVn+HiYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752135941; c=relaxed/simple;
	bh=jBJ5eB+SDu7GzLZN7BJnzNvoEivWAScea+jyCRUBrLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPIGAONXGTdO7fdv9YFpc+xabKMGyBbLRMGxVrm+riddq8LQJlvO2/UQiDX9V3eX+uvo8ZBNlcJcdcGrOLomRscY8GxlHPLY5+usaCz6NYeRCDVFRBZcuvBqHdBP3dLIYlOyKiLotNszE0Rf+m65MN0Iw3LrI7aIijKhF63HYqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=io1b1ADT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nAkg5Tpv; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="io1b1ADT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nAkg5Tpv"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 4F88DEC0267;
	Thu, 10 Jul 2025 04:25:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 10 Jul 2025 04:25:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752135938;
	 x=1752222338; bh=4SiqCFoSWDdcN5c/j2+vR4HiPvjILxvxHHdUZBIjRLY=; b=
	io1b1ADT609ozfNMYZb0o0g6m1DwBnE6n0mlyjsOqol7MskHyASUtYTMykAx8hjz
	LfhXUhFyLkgF5dRBZcd05t1WjLvg3pGfPyaBmqWfCtwKyTI8F6KvjEWsmAhZrscO
	D52huqUbqVokhu72GYHsHpNVf3aUccO3utRHU3XfgJtJtBxFm6dEiXsO8YwJIZu4
	pW8f7S2W9UvJi5JkdvW0R5CkbRwj1uV8AmEYbvBgmgBqsEANkoZZC0J9p2AY25VF
	Ii5UwlyHNp72wp3YvkFiDRwZM9ZVZpPMId829LDSDnRn/wBJm1+keVdjlpPwKMhd
	MXTQo+FR/1Xx4u2NEARBsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752135938; x=
	1752222338; bh=4SiqCFoSWDdcN5c/j2+vR4HiPvjILxvxHHdUZBIjRLY=; b=n
	Akg5TpvTceaGFlAVHv8AJ+Z5eqjMjSjquPWpWTA5Ond3+D0824e5JKW9hQhiRORG
	NpcVQ6YNSK/ahJXKVig7Dkq413wAJFC8sDieVmUvZlyFqqimt/TJUWoxfw7dsgPW
	+n8cw8g3PCSEfa71x7qNO7l6DZLfrqSLlta9lhJSUUXC8yUXTtFgFaNuwdDyvM3M
	A5eCH8O0pzcFVB1lXSEwXiWH4D3Lyq2e0fY/JWGidYFLg4d+oVSLBZZkL8CdzO32
	rYqC7geSyJpqv50EwIw2QuPIzcRjtlNeKQ5BA7dlH+wizkp5Zv34iCNn00/w06T8
	Frxve01FVGnb8GyiMIFtQ==
X-ME-Sender: <xms:AXlvaMdWd8xef1tjhYepXB5AudtwTGdY4hIFFZ5ezit_SvTbuIzSpQ>
    <xme:AXlvaLJ6x2tgoukv9s_3BGEXEtfi7Bc5TcPVm6v7TP14ZWu2nRZZwexHAi7EQkmll
    NQWjx5IIGmOsvwNag>
X-ME-Received: <xmr:AXlvaJJHLAms19s_usFZOP1CCzFz4wvXnu0yHiHZkuofyoD4Wvi8I9s5h25AQNgWz-jM2oSFHB--Tw4CP965S_uKsQFIbFh5RfGHRpvcNeUe7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefleeliecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnh
    drtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhs
    tghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:AXlvaKUz_m7gHbt6myDVwLWUJ3gzh0ktkhNR7c7FxinsXSCeq5UKjQ>
    <xmx:AXlvaCk5djdJuEf231cIH9dmg_QOcCFWjuHp-ywHnmA_rOkHoX1D1Q>
    <xmx:AXlvaAl9QJe9ICxT_9-xlq74G0cJQOpJfzBpR4N3HXlFtie_25Ivuw>
    <xmx:AXlvaCYzy5sB_cBVclsB2-9X9gr6KWzrM9ukEhbeRWL9JpntW14z8g>
    <xmx:AnlvaLcDmXTg72CEqwuiMFmeBSkVR9o6Pvlvealw-72aolaIeNa-DsNj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jul 2025 04:25:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b9c29c18 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 10 Jul 2025 08:25:34 +0000 (UTC)
Date: Thu, 10 Jul 2025 10:25:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4] fast-(import|export): improve on commit signature
 output format
Message-ID: <aG94-0A6Qz35ekFh@pks.im>
References: <20250618151821.528627-1-christian.couder@gmail.com>
 <20250619133630.727274-1-christian.couder@gmail.com>
 <xmqqbjpv1ucb.fsf@gitster.g>
 <CAP8UFD223ja7jKU+wb6TiGkc9frh5dt1rCJkOkk+O+J2MPokrw@mail.gmail.com>
 <xmqqwm8jxoj3.fsf@gitster.g>
 <aGy82TiRFcij5V_9@pks.im>
 <CAP8UFD1A+eV9hbmp4P3pC71+oSTrtLgxtWGyt++J8a+bk497qA@mail.gmail.com>
 <xmqqbjpuwsbm.fsf@gitster.g>
 <CAP8UFD1mgKT0AFuoYfisHMinP6KEDahcXCwiK6-wRFBKKymfsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD1mgKT0AFuoYfisHMinP6KEDahcXCwiK6-wRFBKKymfsQ@mail.gmail.com>

On Wed, Jul 09, 2025 at 02:19:06AM +0200, Christian Couder wrote:
> On Tue, Jul 8, 2025 at 6:38 PM Junio C Hamano <gitster@pobox.com> wrote:
> > Christian Couder <christian.couder@gmail.com> writes:
> >
> > > Also if a contributor comes back with improved patches that try to
> > > follow closely what a reviewer suggested, then I think it can (and
> > > should) make a reviewer feel like they have really been heard better
> > > than just a hollow reply right away followed later by less well
> > > thought out patches.
> >
> > That is kind of "better late than never".  I would expect better
> > than that from more senior prominent contributors ;-)
> >
> > And I totally agree with you that reviews often deserve very well
> > reasoned responses, which take time to prepare; a response that
> > comes as spinal reflex without much thought is often not very
> > useful.
> >
> > It really depends on the definition of "fast" in "fast response".
> >
> > If we need a week to come up with a newer iteration,
> 
> The issue is that whatever the time we could set as a norm, like "a
> week" here or 2 or 3 days, or one month, or whatever, we actually
> don't know what happens in the life of contributors. Maybe some have
> health issues, maybe some work only a few days per week, maybe some
> oare working on their free time and don't have much free time, maybe
> they are asked to work a lot by their company on other internal urgent
> things, maybe they have to take care of dependent people in their
> family, etc... So setting any norm here that everyone should try to
> respect might just not work for some people.
> 
> For example there was a former Outreachy intern who continued working
> for about 2 years on their project after the internship was over. She
> was a young mother so didn't have much time to work on Git and would
> come back to the mailing list only every few months with new patches
> and replies to reviewers. What would we have gained exactly by
> imposing a norm on her?

There are always going to be exceptions, that is of course true. But I
also think that long-time contributors that are employed to work on Git
are somewhat special and don't (typically) fall into the mentioned
groups. From my perspective, it's especially this group of people that
should lead by example and encourage others to behave in a way that is
good for the overall Git community. And leading by example in this
context also means that they should encourage healthy discussions.

That of course doesn't mean that such people should always respond
within an hour, or even within a day. We all have to context switch, and
context switches are costly, so it's entirely reasonable to try and
minimize them. But outside of any special circumstances (vacations,
health or similar) I think it should be possible to engage in such
discussions within a small handful of days.

In any case, there of course is a distinction between people employed to
work on Git and those that do it in their own free time. The expectation
that is extended towards people who work on Git is way higher than the
expectation extended towards people who don't.

> > it would be
> > fair to expect that we can say something like "I agree, I'll fix",
> > "I am not convinced because ...", "I am skeptical but let me first
> > see how it pans out", etc. by day #2 or #3, wouldn't it?  Upon
> > recieving a response at the same time or soon after an updated
> > iteration was sent, especially when the response is "no, I do not
> > think so", what is the reviewer expected to do?  Saying "you may not
> > think so but here is another point that may make you reconsider"
> > would be too late, so it would actively discourage continued
> > discussion.
> >
> > > It doesn't mean that I think oldtimers should have some kind of
> > > privilege, and yeah they should also try to give a good example. But
> > > we should allow people to not always behave in a very formatted way.
> >
> > Old timers learn from experience how other old timers operate ;-)
> > and I have learned to ignore the usual signal when anticipating what
> > your next iteration may look like (in other words, interim responses
> > or lack thereof is usually a good signal for most developers, but
> > not for you---you tend to come back with your next iteration without
> > much interim interactions).  But other contributors shouldn't be
> > forced to. That is what we need some community norm for.
> >
> > >> On our team's handbook page [1] we have the following couple of bullet
> > >> points regarding how to respond to reviews:
> > >
> > > Yeah, I think they are likely to be good for newcomers.
> >
> > The handbook here is gitlab's team handbook, and it may not apply to
> > open source Git development community, but "this rule applies only
> > to newcomers, I am above that rule" is the same thing as saying
> > "oldtimers like me should have some kind of privilege".  I do not
> > know what to think about this and what you said above.
> 
> I think it's fair to say that oldtimers are less likely to disappear
> tomorrow or to not follow up on reviewer feedback. So arguments like
> "replying fast makes reviewers confident that they have been heard"
> are just less true for oldtimers than for newcomers.

I think these are two different things. It's probably true that you get
some privileges by being an old timer. But I think it's more in the
sense of "You get to tackle bigger things that may not be done in a
single patch series, and we trust you to not just disappear".

But with that privilege also comes responsibility. It's those old timers
that newcomers look to, so they need to lead by example.

> Another argument is that oldtimers are more likely to burn out or have
> mental health issues related to their Git work than newcomers. Adding
> a norm that would put pressure on them to work more, or at times they
> would prefer to do other things, significantly increases the burnout
> and mental health risks for them.
> 
> So putting pressure on oldtimers to follow a norm that is less
> relevant for them but puts them at greater risk is just a bad idea in
> my opinion.

This is of course something we must avoid. Nobody is being helped in
case people burn out. There needs to be a middle ground that works for
everyone.

Patrick
