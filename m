Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0679F1DFE22
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 11:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757331582; cv=none; b=ec/kQT8xQiez1zsciEMvKMndvsk0dBB1bxUMbDVl9rfGAufGb95fGeaWcqwPG7URHCeyeqJze6PencB8WUuygsLKrIvrwZxeBtDVBTc4oFrZJYQasHjT1hsAEBGqo09jmnxhu+tqBrgyoBOIIPVIPQlqzkecm5TGn1ToNqCce3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757331582; c=relaxed/simple;
	bh=/d2D6mG9tT+twdTuKTn5nAuYInNIanCyynYY+ovcY/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVHsFRWnGAucwI0v4STuyCpcOrotUKK8CcfNSshNEzITwkd3IkU2MLbY+5d1Q2ZDdSLPuTEPA7kxsYqF5BSVN9T1lPe2Q1TJAQ/kWmg/qIsw86p7gwqrbsZnoaVJ4ZFoD3h0uN2Djh6bqnGnSuEDZi2LJRdlHT3m2RwJnXYZK2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MptsaP8f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EOG0zmnh; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MptsaP8f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EOG0zmnh"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C70B37A011C;
	Mon,  8 Sep 2025 07:39:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 08 Sep 2025 07:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757331578; x=1757417978; bh=QAIN8I5oI2
	wb9fj9ZtbKZO71hU5mIx1hja7AsbSI2xw=; b=MptsaP8fpaY0WgkQxLAGP9ogNg
	ViJb31yxGx2rURp18c1DjYvBYxHPwjwZI+P4scDks9z06FCbDrzrcSWr31ldQlXM
	Wj+4kepbrp5FGbS65TEcJJ4KLvAa0Zy7pQr7BcUSwyhDisfOmOUplX4lO7RjOvs2
	po2xmR+iKU7ch2yH/eLgdLus66jlvn30chpVoxVZrIyZE0G06gfCGLq6s+mSVb8t
	HcLlnBnQ3r6Bx72viINZThnnf6rdVOU0w2uF5Zi78HIC5xEa99sNbWsRCDwZW3qV
	x/6DlEJgSwG9ZUBCA0fvfvjmjKOqo+EToRdGkOxHw5548yNJpIN80jT7d9mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757331578; x=1757417978; bh=QAIN8I5oI2wb9fj9ZtbKZO71hU5mIx1hja7
	AsbSI2xw=; b=EOG0zmnhpv6Y1VfmjF0NvUf4WR4pVb9K6P1KaZf/ZDkuYk6dBaD
	Skb7emyiqe5el7keOMBAI6jjiVpd5RpXKa0ZxNav1MCdicq4nhutm1SCy9da1fBn
	TH0i88EzA7EJuQ3j2fCkGbpccHLYkuOdkbrq8PfVEyzq7152rWw8/yRBVzq+Zj3Y
	/OR9JgdlyFZSJTDcurKt7qsdHOvAfvDjvel+tO8imfB7x4xHV6LKXxLiZXhwx/GB
	yfG5Zn3HDLKNEf6sujVoSjW0wKn9mAcKoOE17lauGm9YEewfR6gwHNYmFeoJ8KTg
	XXcZzpY1vBbTSYAZBjUnan2etA27IuG87PA==
X-ME-Sender: <xms:ecC-aFMXnvFPglrtL51SeYuEnE-91nwV-WvmHoF9ofzZoU_eErxf4g>
    <xme:ecC-aIERhKYE-egw4YOAdxi7yP2QyBJHSPu245xCTOdEJ_MojEbz96v-ZoXre_vrn
    OVcb2TaMCBCK6KTdQ>
X-ME-Received: <xmr:ecC-aLtuFhZ4_3aty8lNUERx7vE40EkkzoIY-3g431nrwu3-LPZFOwFg-_EPtQ4Kd2dPIegY7SgCfUu4TKyZSL_4Npz1uQjS_xk-DxvrNHhMlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheptggssedvheeisghithdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghi
    lhdrtghomhdprhgtphhtthhopegtohhllhhinhdrfhhunhhkudesghhmrghilhdrtghomh
    dprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepjhhohhgr
    nhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepvghstghhfi
    grrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepshgrmhesghgvnhhtohhordho
    rhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrd
    hnvght
X-ME-Proxy: <xmx:ecC-aITHM3pn8Z3wWA9jI2wSUF17JKst90xp5gh7ybctcgZTLZ02XQ>
    <xmx:ecC-aFOvYw56IsgC43MWApUJjK1-38zXoZRp9l49pYdmFSSP2hHd7g>
    <xmx:ecC-aG49pd4QbsZDGJ0Q_3vwk041QSX8wh3L_Btxhc1qZEwAtY5biQ>
    <xmx:ecC-aAVvnnpALNa7mhSu-y5cxWIxrn8BmSR_PDfeP3VHTO2c3fVNhQ>
    <xmx:esC-aNyLJ5cQ8-WP5t52mnclZQHplXnehMQsMZzE1NKX5x3nVuaugaS6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 07:39:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e05604a6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 8 Sep 2025 11:39:34 +0000 (UTC)
Date: Mon, 8 Sep 2025 13:39:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ben Knoble <ben.knoble@gmail.com>, git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC 2/3] rust: implement a test balloon via the "varint"
 subsystem
Message-ID: <aL7Abgdbi0-aIm6Y@pks.im>
References: <20250904-b4-pks-rust-breaking-change-v1-2-3af1d25e0be9@pks.im>
 <8A7DBC60-286A-48FE-A3D3-CAFC11FD3AEA@gmail.com>
 <xmqq8qipzhg3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8qipzhg3.fsf@gitster.g>

On Sun, Sep 07, 2025 at 09:39:08PM -0700, Junio C Hamano wrote:
> This is a tangent, but as many people pointed out, calling this a
> test balloon is misreading.  This is quite different from what we
> traditionally called a test balloon, where 
> 
>  - we were already fairly sure that the construct is safe, but
>    wanted to be extra careful to smoke out anybody who has trouble
>    with it;
> 
>  - hence we use the construct in question in a place where nobody
>    can compile it out, hoping that anybody with a system incapable
>    of handling the construct in question would be broken badly,
>    reporting the breakage to us;
> 
>  - this is done with an understanding that even a single "the
>    compiler on this this platform with more than dozen thousands
>    users cannot groke it" would automatically stop us, causing us to
>    revert that test balloon code for _everybody_, refraining from
>    using that construct for _everybody_ until the situation changes.
> 
> This thing is different at all points.  We are not "fairlu sure that
> Rust is safe to use for everybody"  Far from it.  We are confident
> that requiring Rust would break known people.  We are doing this not
> because we intend to stop once we know of folks who would be broken.
> Far from it.

That's fair. I still think that this conversion is viable though. The
main intent here is to start building the infrastructure for Rust, which
may take a bit of iteration to fully get there. And the earlier we start
with the process the better, so I think we should go ahead with this
regardless.

From that perspective it still feels like a test balloon to me. The
intent here is less to figure out whether anything breaks. It's more
that we need to have some Rust code in central parts of Git to be able
to tell whether our Rust infra works in the first place. And it allows
downstream packagers to give it a try, as well, so that they can start
to report any issues with our infra before it becomes mandatory.

I don't mind much whether we want to call it a "test balloon" or not.
But giving it a name helps, and "test balloon" is the closest match and
I don't really have a better name. If somebody else does I'm happy to
adapt the wording though.

> It would really be nice to find a niche that can be a new optional
> feature that is not essential to the functioning of the system
> implemented in an already modularized part of the system (e.g., an
> optional merge strategy, diff algorithm, built-in textconv filter, a
> new ref backend, etc.).  Then we can introduce Rust, knowing that
> some Rust-challenged systems will not be able to use these optional
> features.  What Brian mentioned about two-hash interop feature,
> being only available on Rust-capable systems, could be such an
> optional feature, and if it can be done that way, that would be very
> welcome.  If we can have Rust goodness soon enough without making it
> mandatory in too short a timeframe, that would be ideal.

I feel like this is something we should _also_ do. But for now I'd like
to continue with "varint.rs": it's easy to convert, self-contained and
allows us to iterate on our tooling while we don't have a better
subsystem or feature to convert yet.

> I already said that I find 6 months advance notice to folks on
> Rust-challenged systems is way too short to be any good.  If the
> only reason we give advance notice is because we want to make an
> excuse of cutting them off sooner while being able to say that we
> gave them advance notice, that may be sufficient.  But if we truly
> want to help them by giving enough time to them so that they can
> help their platform themselves, by lobbying, fundraising, or
> otherwise campaigning to have usable Rust on their system, I really
> do not think it is sufficient.

Yeah, agreed, six months feels insufficient. My current timeline
suggests roughly a year before we make it mandatory with 3.0 with
various in-between steps that gradually ease into Rust to alert
packagers. Which still may not be sufficient, but it should hopefully
okayish if we also commit to 1.5 years of security fixes.

In any case, the exact timeline very much is an open discussion point.

Patrick
