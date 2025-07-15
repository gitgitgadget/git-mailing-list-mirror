Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDEA2E370F
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 10:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752576626; cv=none; b=Hxq5CVAokj3Wsf0eIqloZQ4AFK4L0AmoMtzA1TjhBqfB1Xo2KxavyrKGe3xpt0MPwarVrmPRGnocaa/w3crzwf9r9uVyKLWl2E/y9UEV8Mmm3F3uz58oqcinzWhAVG8RXHddRegrMXQTGSEBUA1dDKrqO6MOwLDzw3+B9j+tJj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752576626; c=relaxed/simple;
	bh=cjCvOjDaBKCPRsfI7aGOY6lxIHn1Ybs+l7J4uZUrjFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcqA6gvRpKwN2nf3hIXjxyG5ZJ2eeTJW64wMwZs/fQ3TWKS6ly3pjYLaIM8w1s45AQB9FJtZ9xkqYFhg3KwZXm9pcDXIivikVMbzBUjpiwvrRqTxrJGgCRl+AXV/pnvPHpiHqIcdrpYJs/ITnGJgON4dqI1RqsEu2BtzFXS4vRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=i33s8N9U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YJkUQ8/I; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i33s8N9U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YJkUQ8/I"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4A2271400030;
	Tue, 15 Jul 2025 06:50:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 15 Jul 2025 06:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1752576624; x=1752663024; bh=1i2K2vS1ci
	AGV+w+biFZhWE+Oh8O3j6e7B4D5lfqhR0=; b=i33s8N9UJvjGAX3T8dpC56c6F6
	XA+0kGpshGGybcMUIKQ6PW75N92Fly+2M4WLGyuszhWuSXDlI94g/OrtHPLj6Tlh
	uM/ZulkOFiDxWcVY3Nm2YH4xLrUS0fyGa/Efejo4Sxe1OXv5lep6XcYk0TIljnag
	1sJ/6nm9m0mAmjdKEl28w7ayqVWqIM5yf1D1njyQnT+FTp974k4YG12nHzWF07IO
	dsn5Uw5AW38MUMRHG88myI+wkt4kyK4NgOYJT9KQ2FVwYXyUf3Aq1BHQTkmYHnhT
	vT7gvDcRp9fcpbIYusWjTqLQl4lfm7SRBcpeRgtGuMP7LK5lPo71rV6Qs7BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752576624; x=1752663024; bh=1i2K2vS1ciAGV+w+biFZhWE+Oh8O3j6e7B4
	D5lfqhR0=; b=YJkUQ8/ITGy8fLhKX2gzlJZHpnne+9fsOyo8Ldp+Y02x6nSSq1L
	tSevZoK22W5qbwLG938tW1xKqUWdkhF3xtAFCtmGLZ7B8vONIsyoDGUhvBIQ+ppo
	Gnk+l42iLoXcr3YHKTJyDaPrW8qcET50A1YJbAwWlW4BwRY9rHkEiQyyZzuxkZF7
	W/8A9hCEe/nj0T7oxLQgHFNobnQIDdplNN3CPmV+qfKVsIKYcbnA625wm/Y718xC
	4rR7yJIRi8eMzRwYQNFFPPJsisQAyQ31nXY18Oe3033p3Tit3JqVsIhdchcIlD6x
	oag4WIEQHD8b5FXNuRJvJNRX14GNEKRqSGw==
X-ME-Sender: <xms:cDJ2aAEljyvVh-Du8U1g3c-5d88_nMJMwnw4ViE4fwHRuvfoO_jvrg>
    <xme:cDJ2aJidZlZlPLtU3XCIU9RIOUK9eBQDkEtpfJFQB1D7NcBXV1fCNGDOF_jM4KQg_
    GdlzCD85KE4tOIwDw>
X-ME-Received: <xmr:cDJ2aL_yQTu3Zb8debbMuMX24wnZZiIm8dshNiKGxoYtyg-B5WDafGhkofxgb2l4kM5nU0EkC0on0HaGZhsmgqS_v5bj8l5VWYjWIXN-Jqqfjw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehgeeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:cDJ2aApzBs-BV0Jn5yihQ9-BpNxcGWz3l3XG6Bsu-1Ha4ok7Mi_EBg>
    <xmx:cDJ2aK_i6UevbS9FgaB8jagK8rwQWlqgZvvr3iXiEreLTGbsTgWRxA>
    <xmx:cDJ2aEVxJ1dr_wms_CC4TZWLFBYFeL5QTwIPQsbeGHXmp35uT3uReQ>
    <xmx:cDJ2aAAw_X5E36whwzprIBzRYk9Yr79CPQyuptbVGkR27AdUvlTDeg>
    <xmx:cDJ2aOVZ4kxtpaODhx8kFST9EHKqzjPFvFMVdYLnRhezrrZAlZ246pVj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 06:50:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f44097e6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 15 Jul 2025 10:50:23 +0000 (UTC)
Date: Tue, 15 Jul 2025 12:50:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 15/19] object-file: get rid of `the_repository` in
 `force_object_loose()`
Message-ID: <aHYya4PKoWT3-wPQ@pks.im>
References: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
 <20250709-pks-object-file-wo-the-repository-v1-15-62627b55707f@pks.im>
 <CAOLa=ZQ2msNYfURDXe1eNBtbFxDjmc4dJ-u1s0Fo-mqyjnnQHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQ2msNYfURDXe1eNBtbFxDjmc4dJ-u1s0Fo-mqyjnnQHA@mail.gmail.com>

On Fri, Jul 11, 2025 at 05:38:35AM -0500, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The function `force_object_loose()` forces an object to become a loose
> > object in case it only exists in its packed form. To do so it implicitly
> > relies on `the_repository`.
> >
> > Refactor the function by passing a `struct odb_source` as parameter.
> > While the check whether any such loose object exists already acts on the
> > whole object database, writing the loose object happens in one specific
> > source.
> >
> 
> Q: Since it exists in the packed form, won't the check always return
> true?

I'm not quite sure I understand the question. This function is about
_ensuring_ that the object exists in its loose format. So if it only
exists in a packfile, it will be written in its loose format. If it
already exists as a loose object, nothing happens.

Patrick
