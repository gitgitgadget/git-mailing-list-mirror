Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F273563FD
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 13:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768222998; cv=none; b=g/s/vL2IKYijRMA70ZSieMWJ26m6GTQvVbrfh3wuo6RYio0gtOcDePjuAmyKWn3kEWhKcQSZTW5oQ4d3lGqi9o+tlcCwoceOIlsNqoFla4Fh+KfSL0UwPQXAxrOghLgpTZ//MBkCczMls1eI0hQrW2w+wtDnxsmFCHMRqMtGdew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768222998; c=relaxed/simple;
	bh=VD7e8k6dxq6pNen0MZeL67Rlt47see7QvkLnB99slJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7jr199c34Rz2z+j/i834xSzvo4sT3FQ47rATzVAlHPpyGLeDFKUI8h1HDOU9A568dCARXWiCeaDhAfuKHPpNa+/G2Y+dADkdH4DJv5q5aygQK/ZtRiohVMigg2/Cme+CRMp6ss9soP/tYs525n+Jib3pYapT1Pl15yhn/zhxwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LKro3xpo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p7lzpRuC; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LKro3xpo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p7lzpRuC"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2AC3C14000CB;
	Mon, 12 Jan 2026 08:03:16 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 12 Jan 2026 08:03:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768222996;
	 x=1768309396; bh=YIESdKNB04Wv+lccMNbFDmR0VU8E1NYeJvBVp/GRJH8=; b=
	LKro3xpoWASVz3oMvVBXfse9jBsB0JBS8gwYck+QoPFNIXwdCJza7pJ5kjZjuGDE
	Ytw+r39o6J2bxlAo06qXkSwww25QDCV/sRjLRpmQjX/F5efCTt+Y+GrSp0PlHK1u
	JUdBd+r0KtKxUPF9nB8HFncYivXSgz324SOlQWXdu2fXS/FIZ2CIPFU0HHU8gUE2
	G3oDM9mGq+xVHbyXH5GLfzG7gPWaEeGAuH4bTT5LOOsWlzavN6Sw0dWCFz8fyAoH
	k+EUx7DzlyCpGn449N+dQKJuLz0ogiNy5uPdB8cUU8B0m3G9McgqEzoblbHcH3OX
	lvNYzw6mx6uqbhtEhGY0lA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768222996; x=
	1768309396; bh=YIESdKNB04Wv+lccMNbFDmR0VU8E1NYeJvBVp/GRJH8=; b=p
	7lzpRuCCP7VO+dKx7kYeV2FnvgczmJ+W55PMVX1frYIefIQTKbRvGIbECxl52YTF
	jYEFuzv1yaiS8ej72GKin4B/CdTRGehpaSakPryoNHPk+UFFPF4mPM4T/MpBcX3V
	We2NwaYRRfWdIAhab/LeEA3UhNPdImX33F6eHT+/dOBVA0Pbx140eVs8jPvGTxIF
	NgSt+tJUU8+RJGeB7oXKLKgk75E11hHpxdkG3Bf5VuIbQPG286Uokk+suGOgIBkV
	FVMAXboQi9d3/wovb7dvoztmq6U/NqHGkYNt3D/6z0bhjuV5PDE7OkL11Ozv1607
	Hl8h1qI5WpIP5WGGIHFQg==
X-ME-Sender: <xms:E_FkaaDwiQN0oDvNj_qb-2uxbt2Ny0PNpB3XRd1z5mYQHUtOZsMX2Q>
    <xme:E_FkaY5tvMvs5_9-3OiD0lm6UUG5MGAUULfsx_fBfzVCd0KueeRI6VjgbyuQXBcz7
    3K89p6p4QFgKxqI6XtPej1iNXRySGc-XSHDOOQQY1FQeEfSBKuYuA>
X-ME-Received: <xmr:E_Fkabd2Pl8q-QUOtm2douADnVY-uCKLwn2uwCtEBq95ZcYoJq5v3GMLnVriPv00522_TNyRveWbqoJbmxJGQXjF8hTBV41H8JXuacgEGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetheffvddtleettdetueeukedugeettedutdegueeukeetheefueevvdeitddtveen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    uddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrg
    hughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehsohhrghgrnhho
    vhesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomh
    dprhgtphhtthhopehmrghrthhinhhvohhniiesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshiivgguvghrrdguvg
    hvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfees
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepmhgrihhlsegsvgihvghrmhgrthhthhhirghsrdguvg
X-ME-Proxy: <xmx:E_FkaWuMfxWOqO-MO5A2brvuAsdM0jVGwNZv7NHflAVv8F7c6BrISw>
    <xmx:E_FkaTm9GSfumCWSvu_ghy33AHxgvTfH0rAxJhIE92eZA2RjmwaVCg>
    <xmx:E_FkaRTVG25Y22a-PjVUX67smzdpsjNvl2dIvSGsRUpE1JSMaXX_mQ>
    <xmx:E_FkaRIwJPzkGZyP9k6ko5E1vQQm1j60XgPrc4r4i6ekRkKGfnOAEw>
    <xmx:FPFkaY0UPa3ntrr3OVMkbTjiZbFtKk5miAJIAT6t0xtNO-YUkQTu5MCv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 08:03:14 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f853646e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 13:03:13 +0000 (UTC)
Date: Mon, 12 Jan 2026 14:03:10 +0100
From: Patrick Steinhardt <ps@pks.im>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Matthias Beyer <mail@beyermatthias.de>
Subject: Re: [PATCH v9 0/7] Introduce git-history(1) command for easy history
 editing
Message-ID: <aWTxDlV5alleJnSq@pks.im>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <20260109-b4-pks-history-builtin-v9-0-8766101814c6@pks.im>
 <CABPp-BEVZbN08zF2P0wNWuOZozc+tbWodfOjtiAkX+XhMiyC6w@mail.gmail.com>
 <aWKI2BxszQuo1mRn@szeder.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aWKI2BxszQuo1mRn@szeder.dev>

On Sat, Jan 10, 2026 at 06:14:00PM +0100, SZEDER Gábor wrote:
> On Fri, Jan 09, 2026 at 05:26:48PM -0800, Elijah Newren wrote:
> > On Fri, Jan 9, 2026 at 12:35 AM Patrick Steinhardt <ps@pks.im> wrote:
> > > Changes in v9:
> > >   - Rename `struct replay_ref_updates` to `struct replay_result` to make
> > >     its semantics less focussed on ref updates, only.
> > >   - Clarify and fix return codes of git-replay(1) so that we return 1 on
> > >     conflict, 128 on an error and 0 on success.
> > >   - The usual small improvements to commit messages.
> > >   - Link to v8: https://lore.kernel.org/r/20260107-b4-pks-history-builtin-v8-0-18e9779e3a26@pks.im
> > 
> > I read through this series in detail; it's forming into shape nicely.
> > I think there's still a number of small implementation things to fix
> > up (see my comments on the individual patches), but the design looks
> > good to me now.  I suspect we'll be ready to merge before long.
> 
> I don't think this should be merged until we have clear and feasible
> plans for future subcommands that will cause conflicts, to avoid
> painting ourselves into a corner, like when we couldn't change the not
> well thought out details of 'git switch/restore' anymore.

I agree that we need to think a bit about how we'll handle conflicts
eventually. But I don't agree that this means we cannot already merge
this series for subcommands that _cannot_ have conflicts as I don't
really see how design decisions around handling conflicts would have an
influence on subcommands that never have any conflicts in the first
place.

The intent of this command is that it should allow users to easily
handle certain common operations, without them having to worry about the
underpinnings. So even if we eventually figure out that the replay
subsystem is not a good fit for e.g. a potential `git history edit`
command I don't think that this means that the whole status quo of `git
history reword` would be impacted. And even if we eventuall _do_ decide
to switch back to for example the sequencer subsystem I wouldn't expect
that to impact the overall design of `git history reword` either.

So yes, I think we should have a discussion around how we can:

  - Handle conflicts in replay-based commands in general.

  - Support stacked branches workflows with conflicting commits.

From my point of view this leads into the direction of first-class
conflicts in Git, and I think Elijah also leans into that direction. But
it feels like a separate discussion to be had that is independent from
the current proposed subcommands.

Also, with the new semantics that we have aligned on with dependent
branches being rewritten I also think that we'll want to get the inital
infrastructure out there to facilitate user feedback. Such feedback can
also help us align on a better design for git-history(1) going forward.

Thanks!

Patrick
