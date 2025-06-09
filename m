Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84B521D3E1
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 18:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749494518; cv=none; b=aucCogWkr5Ygeg2DIC/tl3hsMHw6IHllPvHX7EaggubomKMjPQRomIkcsr1VL4PrYNR7sqh57pFZBmEQDR4IxX3zn1PT7Uv345h3fNIMyCxQ6Cd3AmPTK44ZjD2wb2fiKVXOG8L0AJaYNHlh95i2cIsucgyHTvRjDaNfTVUJveg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749494518; c=relaxed/simple;
	bh=JavXUxSFqib+JZCelyjlNv8bFfiOcrkxO2wCjTBFkcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYMU0UDNWP+TIyPJjBOn5rzCctVeiqz/gopea0nsIrXq9+hwig1OUPghdxOPPLf3PoBM22Ke6j1ZvT0OiD6VtvulQ/07xANGMyfywQLAncc51neVEYJjH0VfZgZjNgz907SjNLoOVY+/VAKINkEnNacn+46zCzYE2xQYq7m5bfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gVbjy+cL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MxevZ7MC; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gVbjy+cL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MxevZ7MC"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id AFD3D13804DE;
	Mon,  9 Jun 2025 14:41:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 09 Jun 2025 14:41:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1749494514; x=1749580914; bh=FuvcmuUEu9
	KOiJ51ZGsDR/fXUDeNDQZM3WSulc6KFIA=; b=gVbjy+cLO7qRqtdvM8Gw+TjDV3
	TW1LON7zbr+LQrwQiVwpyHI/BR6Rfqy+D8M1/ABisgGloaIvyojvGKwR/f4f/VpE
	g0lKlkpZbG9UuqhOHSN7+PAwAnzPrNoCQmx0iSDXbrfCyz97OCVvRfqGJfbpQIYn
	Y0aqjPfLBwP+w5+mG686vn36q4D3NXGs3hx2lUGdjh3VDMv9x6B8LexY9CDJNsYD
	RoxDusf1jfYqc3Dd/obTu3GynAI/4viGXOV9S92BFKx+ox7DNoj0lCm6Q9hhI5bp
	Ags5A9gGAFJV+BPKT5vuH7Io61h56X8PyZPqygV6CoYHVUzs+BS7XtxCs6qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749494514; x=1749580914; bh=FuvcmuUEu9KOiJ51ZGsDR/fXUDeNDQZM3WS
	ulc6KFIA=; b=MxevZ7MCc04Zkh68rHE2UCTkmOzu6L3Xd/OoMnp4mxsFe0jz7Xl
	lqyVPC5ou0jW7TO4Z/BuWgG9Lv6hY3E7qAvTLMDEqejbZ3ve/UMWFIslsOCijPX7
	1uwNmN8eYQohhmLwHTb7AyMKZUToBhwtsmAEdGomsyEeqx1Dp7KFV/OT5RCu4/My
	mIQCcFmFqJTLvqckFtTTlS9GKL49etmLsmmcSM090esYjplLeAqd/8PzeWIK5LPf
	UAJCiQpmFGDIiugKGYVL3xIbyKx/zbktCoqxuOwTYM6PnKLVN00YuUspSih62jOU
	zHr9wG0tkry6kkdc90RyT7sN0qE0nBTS7HA==
X-ME-Sender: <xms:8ipHaLpBPhCPwKf1CRgPIfTR2kS3kxInvxo4Jr7OMF_RFjIiSsAyWQ>
    <xme:8ipHaFo0_QSAUjNGDqDcjDRidshi72mUQaGmHtc0CKZxqNfO68_7H6zJjL27LSDr_
    oP1K7UIqjz-ek01Ew>
X-ME-Received: <xmr:8ipHaIN-MOMs4YuDR_MQDVZaLoTUmavOBFPNpAeh7NpqUKplSByTJUgz1Nq9_8RYVT7AuEsiQaDgKls7laF3vdk0MNduJlCKBri3TzBmnLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdelieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:8ipHaO779sxuuu-yMbzt_qm7GONWgMeuQ8w68xfV2BxUXHs5nc61Ow>
    <xmx:8ipHaK7cLAu4KGL5un6J_amdLwKRuwkJ5XOzmFrJGBvPJD4nNmutYg>
    <xmx:8ipHaGjmrOXWKStlHECzXn29gjQesuMeDQcMonoaKFlAHrvWWLqvMQ>
    <xmx:8ipHaM4bHSz5nK-zvHDXjBG3uNaEvaZrrdEzd8i_Rz7U-z1XGUAJyw>
    <xmx:8ipHaIErfb4x9kcRsikrWhOHyJaYkPFcK94ti5azjgFZHwCpZlv23i9v>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Jun 2025 14:41:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 32b99107 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 9 Jun 2025 18:41:51 +0000 (UTC)
Date: Mon, 9 Jun 2025 20:41:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [RFC PATCH] test-lib: add missing prerequisites for Darwin
Message-ID: <aEcq7sbPx57r-qKK@pks.im>
References: <33de9e5d-24c8-47cf-b858-6d55d26803b0@ramsayjones.plus.com>
 <xmqq8qm0srh3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8qm0srh3.fsf@gitster.g>

On Mon, Jun 09, 2025 at 11:24:40AM -0700, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
> > commit d3d8c601fd ("t7815: fix unexpectedly passing test on macOS",
> > 2025-06-02) added a MACOS prerequisite by adding a 'Darwin' case
> > label to the 'OS-specific' case statement. However, this commit
> > forgot to set several prerequisites which appear in the 'default'
> > case label, in addition to the new MACOS prerequisite. This causes
> > several tests, which macOS should pass, being skipped.
> >
> > In order to run all applicable tests on macOS, add the missing
> > prerequisites to the 'Darwin' case.
> >
> > Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> > ---
> >
> > Hi Junio, Patrick,
> >
> > I was looking at something else when I noticed this ... but I can't test
> > this, since I don't have access to a macOS system (indeed I can't confirm
> > that is actually a problem, but lots of tests should be being skipped! ;) ).
> >
> > I initially deleted the 'Darwin' case and set the MACOS prerequisite after
> > the case statement - which may be a better solution. dunno.
> >
> > I marked this RFC because I can't test this. Hint, Hint ...
> >
> > Note, commit d3d8c601fd is only in next. If this is not going to be
> > part of the release, then this (or something similar) could be squashed
> > into it when the next branch is re-wound.
> >
> > Thanks.
> 
> I do not have access to a macOS system either, but the change in
> this patch seems like a very safe and sane thing to do; it will
> bring us back to the state before that problematic commit with
> respect to these three prerequisites.
> 
> Let me queue it on top of ps/meson-tap-parse topic.

Yup, that change looks reasonable to me, as well. I cannot test it right
now though as I'm on vacation until the end of June, so I ain't got
access to any macOS devices right now.

Patrick
