Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79962F7471
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 09:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761559036; cv=none; b=tNiLjck2YCWD3PWHKY5sxDIQd9/HTMoCa2Y84EozRBwiE2BRz7DRtPASf2FTVl3N0qpy2bS0TDr0+NhKhfIX0vBK/sF9hfkBwQ5JWDjp0no14TuRmnYb/8dUpzLM5hBPV0QDz+C+2yHfXllsJ+ubohOmfWNXQIZ5M81P0enmWR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761559036; c=relaxed/simple;
	bh=1GNknekJ00ZLzAJZh+no8qOmxmIry4BRz5+lt71xkXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7Lx5LU1O84hrIIk6xorfV5FeNaToPlqh6+C4nRBpd5yfK6cDFXZ4RkEJVwLdiBtZqS+Y1yZuFs5vYcg38lxWrBmp7BaEBzrGeHEfSopgqt/zPbR0l7ZYEUly8eli0Q1g1k70CQG9tcxnPLPQyoHSBSsgDUhICizV//zKAHsSns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZQ0Av9uM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jRatHaFi; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZQ0Av9uM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jRatHaFi"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BBA6914002F2;
	Mon, 27 Oct 2025 05:57:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 27 Oct 2025 05:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761559033; x=1761645433; bh=hI1IU66TDv
	1XBsikLlVAWaHD2x2irlySjxZdLvqRRIs=; b=ZQ0Av9uMqc3dSeujn1O49fgZTb
	0rWPfOVM7Wom+pGCTh7J5hYAr9LImZdTTRy2uNfKI/6Cxcc5ZmcAdT82WV1w9FOJ
	kG1Wk/UkEgXTsB1BwLEWASTlr2VJ4SbL+VScajXxprLHjplyXI9lae44ROApmuSF
	+nASM6ebNqIFIWPoKAqYx0hZKe5U1ZOb5WXd3/4UTLqo6RjSKJFdb7tHE77QrCvW
	6ZwXHMmRO8AAFNySh3iDZtRAxWcYbWRZR+Fd1dxF5SMAfJObKgFpvZi87toar9xa
	Z9urw2j8LBQHQcBeGS/S9CcK3X8blQkH1Ws8nmXZ7jNZEJfN7WHZ3vyNvLdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761559033; x=1761645433; bh=hI1IU66TDv1XBsikLlVAWaHD2x2irlySjxZ
	dLvqRRIs=; b=jRatHaFiz5YoW7qpaRjQZgCrZzdTUk81D3EGtkgyNMMXgN2eR3H
	PGjmIS8ofog/efHDYd0EOZeh4ZPCrdQVgDwqG4lQVmU7Y7zClevkOakjmUvmVCPz
	4hUIdV8cAoZsBabWV194JNm/nwZK/ytPIt2wWkmYIWSBQZcFIxt7kEpSkcwGkLGg
	PcmOblTRLg3GTfKs4Y6KX+cUVDuM+yCVqrNBOjI+URIJo9oSpDcUkUOVvPqOko39
	vYh9QsdVeSx+mVzelmuKO+V4mz/Vnhct4urvfAbhBECBaYEUd9l+g/0ZQHynC0NJ
	FETOiIUWXe2gjFlXonulMrNcIVVGQzE1s1A==
X-ME-Sender: <xms:-UH_aMg-IlNt-jx1hmyN00cCrhWUQNUGXxo2Sck3Ig6vGVUgqDUdpw>
    <xme:-UH_aHlLEK1QDaf0PN92u7zYEgnkE4VZLKlPkaJOyDrHAFZ5Lw7UUlCY6MWqpEjX3
    t0fYvFavcjhgvMbx5TlPEW3EhFlzLKW8UDFR-OuXMOFb4P6nggBVlQ>
X-ME-Received: <xmr:-UH_aHutaFzQUb0rVbaHXRDjvPQCrMVvHe8sUUhBpnDPsVCS6WoVu25_-r1FHSlTaZ38idIii47OgRq9gR24PVnGOD_CwXawupyVth7Pmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheejieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpd
    hrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopegsvghnrd
    hknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehsohhrghgrnhhovhesghhm
    rghilhdrtghomhdprhgtphhtthhopehmrghrthhinhhvohhniiesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:-UH_aNYUXwl2aSQ-B_ds1RWd5NCLK22nuUM93t7ljmUVP5a99DuVTw>
    <xmx:-UH_aPBS_LR-IRqU0D62gmGgNkyWdlewjErQz3VfoqEedWvNxeouIw>
    <xmx:-UH_aF-m1GgmSbKC-of37JzkDlLY0-TiJru_zEieJeO1tWpiLkjkaQ>
    <xmx:-UH_aLQsnzqzC_wJo2P0gNbknmwuoRDBaJMbiw4tmjtUyg0DcjgMgA>
    <xmx:-UH_aK_HXHLhbGAhIpGwj1zKiyN2N49_kqmUrXExtcnB7DU08BBniGHN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 05:57:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2523bd15 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 27 Oct 2025 09:57:10 +0000 (UTC)
Date: Mon, 27 Oct 2025 10:57:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Elijah Newren <newren@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v5 05/12] builtin: add new "history" command
Message-ID: <aP9B8yd0JJL9nue8@pks.im>
References: <20251021-b4-pks-history-builtin-v5-0-78d23f578fe6@pks.im>
 <20251021-b4-pks-history-builtin-v5-5-78d23f578fe6@pks.im>
 <xmqqikg8t0rl.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqikg8t0rl.fsf@gitster.g>

On Tue, Oct 21, 2025 at 02:15:10PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
> > new file mode 100644
> > index 00000000000..57560525a70
> > --- /dev/null
> > +++ b/Documentation/git-history.adoc
> > @@ -0,0 +1,45 @@
> > +git-history(1)
> > +==============
> > +
> > +NAME
> > +----
> > +git-history - EXPERIMENTAL: Rewrite history of the current branch
> >
> >
> > +SYNOPSIS
> > +--------
> > +[synopsis]
> > +git history [<options>]
> > +
> > +DESCRIPTION
> > +-----------
> 
> We would want to make sure that all experimental things identify
> themselves in a similar way.
> 
> The way how replay identifies itself as experimental, which this
> patch is modeled after, is somewhat different from what is done by
> backfill, for-each-repo, last-modified, and sparse-checkout
> commands.

I guess the only thing that's different with git-replay(1) is that we
also have the `(EXPERIMENTAL!)` tag in the synopsis. No other man page
does that as far as I can see.

But yeah, I agree that things should be consistent here. I think the
most sensible thing to do is to:

  - Have the "EXPERIMENTAL:" tag in the NAME section.

  - Have "THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE." in the
    DESCRIPTION section, ideally after the first summarizing sentence.

> > +Rewrite history by rearranging or modifying specific commits in the
> > +history.
> > +
> > +This command is similar to linkgit:git-rebase[1] and uses the same
> > +underlying machinery. You should use rebases if you want to reapply a range of
> > +commits onto a different base, or interactive rebases if you want to edit a
> > +range of commits.
> > +
> > +Note that this command does not (yet) work with histories that contain
> > +merges. You should use linkgit:git-rebase[1] with the `--rebase-merges`
> > +flag instead.
> > +
> > +THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
> > +
> > +COMMANDS
> > +--------
> > +
> > +This command requires a subcommand. Several subcommands are available to
> > +rewrite history in different ways:
> 
> Looking at "refs", "repo" and "sparse-checkout", none of them say
> "requires a subcommand", even though they do.  It would probably be
> obvious from the syntax, so drop the first sentence, perhaps?
> 
> And "subcommand" -> "command" to match the section title.

Makes sense.

Thanks!

Patrick
