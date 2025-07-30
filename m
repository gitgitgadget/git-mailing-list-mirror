Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C5C1E0B91
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 05:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753853618; cv=none; b=JbjPvk8VIU/LJmE/GtgDSn5z/ZAh9ih89jfg/bIN2tNl8Pm73nnFjpgCCD9gdNFYyAD2DwrC6MJ4acd9W9qGPQEg2W2p/Cj+AvdSeP8xBskm2MLD7a5FC11PrMhHzQ79PsGhX3HhdaqfxnAciIbB9MuMQzfT7TLNdXbOkhyTPE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753853618; c=relaxed/simple;
	bh=jrPpPZXAQyfG6r8Rd1zV8xUgCfA3HmMuovLKOgkX8lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=An9L4hH2mi6auZc3+Z42SvPc+AE7orILu56kGOvANA3lD7x0GL2l8wxPtNzFxw+0kXWrqW4la5EdGpbb96lE8WhSUIZRXcN9xwY/Q9hxnj5gUQj9cHpEbQFu6mm3md4coqdc+tU8DomFEKPAyUUMPx7cI5gzXvk6G5m2ci9gOo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LdLJD2bQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cBwu6ab+; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LdLJD2bQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cBwu6ab+"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A99EC7A238F;
	Wed, 30 Jul 2025 01:33:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 30 Jul 2025 01:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1753853614; x=1753940014; bh=rEI6mjDXpc
	925rSjxmK9f0D8z6iQSVIsnQICya+pWaI=; b=LdLJD2bQ7ROR26XatwyqC+nW/T
	GRpSqMnzBTKtFrKhXksjqHrYNjqbo/dF2ILkhB26++LpRI0R6p1d5ukAeqtRHTSa
	5xzBvO8bdg2hPOn24fVSF7NdMF22jQVaixUG6lnrDorJ3MvgwB7ZGfYGmcz97Jf9
	i/Qlzf1DF/cOzoO3/Z9FygoD+hVtSJsrhz+t9VDLulpwNnAz+1KLe6iAjBX6cbm8
	uwR14AJhrZ2bVIZytFuhad3oI906plXpYYVSJsvFj7tk0qcsV28b+bnn3Nvil7UR
	YbwMkedwTY3EzV0KorbbNwhNzGhkGQUWMGkkKNJVrAmKaxXuDM9Fw1uHewnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753853614; x=1753940014; bh=rEI6mjDXpc925rSjxmK9f0D8z6iQSVIsnQI
	Cya+pWaI=; b=cBwu6ab+0HvRogbv6yEiiZFxgMWDYKo4fmTLf7ydK8EyVTRyYLt
	gK6VvDJuT9xicWCzAN9O+EjooM/tjQ6k3bHgvuJltP71FpRIm4rLYFAFpM87m//x
	Fku/zKpJFCSrWVKqVyEvYgd2SV4Ch9HPLih1Qdz4l9vTrQSBRYhwhRnTljsjYVwk
	uXhx63ssjDu/aEOGVrYq7nOiXwGULac/kixJ6C/VUM77BH1rPFLJgp4GHRxtU3Jp
	JYDn7BtnEWsJ7jVaa7n5QRvBJ+mSW4k6PB//5iliVTZ5bjti+cP6Xr5SEKdKpFym
	snA1z2C2qU/3ShQ3w4yA9sC0GO8KK3SAzhw==
X-ME-Sender: <xms:ra6JaMHhLEOf2Rdp4CFIPCyod3jghInVALuqxVLk7E08lK2TlvRBcw>
    <xme:ra6JaCRDaPwL31nGJbH6KyYxlgfUS9owy-8wnHPYEHy54vRBywU4Qlb88AiO4mD3m
    g3nrVw1fkTwRZRz_A>
X-ME-Received: <xmr:ra6JaBwM0LZby-MWhoLMLav6tg9iChDGUKVjCMn65tgD3QSxA1EQpDf7u7gXpoPqHDASAmusgnrzhsNCvCJMmqoOX7gHQLV_EshQxG9B>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeljedutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknh
    hosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopeht
    ohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:ra6JaGfehFvdHzfcbcADUsbUgjWFTdXze2zKTHWlABCilBIUHIJ3JA>
    <xmx:ra6JaMM5D5FkFXjEw9mRMFUkmqA1KkDGhLqU5uD_EchCeT09Al8aLg>
    <xmx:ra6JaJsa6E3zGWdwk7mkbQcMQTcgy5e1ftg4BraFfpWgTMIMiVdZhQ>
    <xmx:ra6JaFB2UterkDN3Hyg0JOOyoXlLmZ5SYiWzCUpRR1jN_pb_01KnIg>
    <xmx:rq6JaOmGbAKE9a7VTJB2qGJOZoX65tx1fMFT3AeQplTn9hDpCWvGzuvW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Jul 2025 01:33:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 199395b7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 30 Jul 2025 05:33:30 +0000 (UTC)
Date: Wed, 30 Jul 2025 07:33:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ben Knoble <ben.knoble@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v2 4/8] builtin/reflog: implement subcommand to write new
 entries
Message-ID: <aImup_QlY0tdBtJq@pks.im>
References: <6414dbfd-6f34-48d1-aa3f-3fe7998f80af@app.fastmail.com>
 <6E84D571-CC02-45E6-9E58-DD918B45998E@gmail.com>
 <aIhvcSHrRLG6wcMD@pks.im>
 <xmqqseifqbym.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqseifqbym.fsf@gitster.g>

On Tue, Jul 29, 2025 at 08:00:01AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > There's a big difference though: `git reflog drop` won't ever do
> > anything for a reflog that doesn't exist. Consequently, we know that our
> > DWIM mechanism can kick in and resolve the reference properly if such a
> > reflog exists.
> >
> > But for `git reflog write` that's not the case, as you can write a
> > reflog message for a yet-nonexistent reflog. The DWIM mechanism cannot
> > kick in here as there is no reflog. So what do we do in that case? We
> > could of course just pick the first DWIM rule, which would be that we
> > decide to write the reflog for "refs/heads/$REFNAME". But... I dunno,
> > that feels too magicky to m

Gah, another cut-off mail. This is driving me crazy. I have an idea what
the root cause could be that I've implemented yesterday an hour after
this mail. So fingers crossed this that this will stop now.

Anyway, remainder of this mail:

> Patrick Steinhardt <ps@pks.im> writes:
> > But... I dunno, that feels too magicky to me given that we are in
> > plumbing land.
> > 
> > So I think the next-best thing for now is to make input verification
> > stricter by dropping the `REFNAME_ALLOW_ONELEVEL` flag.

On Tue, Jul 29, 2025 at 08:00:01AM -0700, Junio C Hamano wrote:
> I concur.  Like update-ref, a command that would work on a name that
> does not yet exist, especially when it is a plumbing-ish low-level
> command, would be too confusing if it dwimmed based on what names
> exist already.
> 
> I wonder if it is feasible to correct the UI mistake of "git reflog"
> using the dwim-ref logic, and compensate it by teaching "git branch"
> and "git tag" options to drop reflog for the thing they act on.  At
> that level, there is nothing to dwim---"branch" is about branches
> that are either refs/heads/* or (when run with -r) refs/remotes/*.
> It's sort of like "for-each-ref" requiring the refname from the top,
> while "branch -l" and "branch -l -r" always limit themselves to the
> relevant hierarchy.
> 
> But it is probably not a good idea and is way too late.

Yeah, I agree that it's probably too late now to change it. Whether we
need to teach git-branch(1) or git-tag(1) to do so I'm not sure. It
feels quite unlikely to me that anyone really does this operation
frequently enough to care.

Patrick
