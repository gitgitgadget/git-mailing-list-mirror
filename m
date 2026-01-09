Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665652ECD39
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 07:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767944067; cv=none; b=PZSTuSEJ3Z9ZrJRSB43RFljsTpLAxO8nc5j+ZiaYw8N9ZU49PtzMmf2Z5ockOEEmAd/2Ea2GEwjfk61Qs6n1YfR9pCatXskEX8KX3EWT4DdgMIejtJ2VCt8y75kV3lvxuaVDKFTG8YBUfoq+WkUiRAUlY/ctjqjutUJt+fmd5qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767944067; c=relaxed/simple;
	bh=oamm1OzAq8Wx99LUh3FG0vvnKaLAZOeRE684eyEZ7Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwTkp8jCd8CB7SvIgZQXBtnWLPiqfhnv9eAZw1mGJu3ckquxRZPy/ZFt/wxfrG2IKlHvKImKRcvexN++75ctCb2q+0dwdtKr5s8UU8/bXm95SKxQfIkARB40OXzwXRvJ7t8UzGrhfiUW6LSKTgM3d0tzCSvqUtzZ/0B3UDcsDjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Qru6+whE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=x3oOCK72; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Qru6+whE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x3oOCK72"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A38601400166;
	Fri,  9 Jan 2026 02:34:24 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 09 Jan 2026 02:34:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767944064;
	 x=1768030464; bh=tWBv9EHiw7uLs5Tfsyq93agofXGAs5bzPBQmU8keyoE=; b=
	Qru6+whElCGuUizisEmCR05Ri/FKZr19OcRljWubwTlAwkhJWoa1mMhVhYoAvArD
	AEpRhbMbarYIzwUCZI1IaBHodLjeeXzP+IXzvTFhU2fNEy1xiiG/YkIcrrHJqWrT
	tHzi2grFpVhm19nPWwK3LvWtVxPj6PCdwt5AwGeJLDyuQQ4ZSG1v4Y7PNaNQdVcb
	T2qjqyP5R9TdlGQjimpHYedwA8hXAtw7gIaZfb8idVshqUCnyUjNc3JsZcdIjTAE
	s8iANjsTXHPBDhrPm0YL2GdSdXDqGcNCvJUxFryW66uJst8sKZvNDo34zf2pFIrn
	0FRHFe4yln7eE77yRuancg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767944064; x=
	1768030464; bh=tWBv9EHiw7uLs5Tfsyq93agofXGAs5bzPBQmU8keyoE=; b=x
	3oOCK72gRTsS93XrwU6PxY3t3A+py6o7coUT1EFykCK+u7gjbkOD+qFDYpDLU3C4
	hPfYlf2M3KGj+T+pa08A7D4FYpAIm6wFQDypRScwrVO97TNDkfaF68rQApll9fi5
	DM8Vx4Kq61mmtrqMiKU8olduMvvE/yKXVYmzhVhGy2j/V4qAKXLK3ayG200Y2a7p
	uzdPK6wjQcv+uCjUN3H0oS8DdARfWjW/5qlR8aujqz/PPHvgE3D87JqrUi5lXKT2
	L8nbROrICX4n7+YKeVpd1kck3yvVgVkIKm2XF4s8Q2t2Y346KlECCyKO/Mvrzxph
	TEtyOpTGGMtbluFMG1j2g==
X-ME-Sender: <xms:f69gafdw_tdthC7WWQmZR5W58Xp4gsyfZOkWOvNmO6lWdLkaSosiUg>
    <xme:f69gaRBuuaODP2CMALy5YyDn79ovnTSfQaU7T4llDDejho8F09g0nO3rv9EfOZpNP
    QMa628b0sYMwOPvb4bMMJCRNj3wcUbn-C7Feoy32OaV7SXNROpLNA>
X-ME-Received: <xmr:f69gaT52523AxSTmJE0VtriI_63PpLoNp5fp4HTPaAJvYHDkVCD10HwbUDkXu02p1BXLGtnKg6Vt3ICdMUB-biuLuTIUARNgFrFFxsEe4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtoh
    hmpdhrtghpthhtohepshhorhhgrghnohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    phhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegsvg
    hnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrthhinhhvohhn
    iiesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    shiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:f69gaadJn7d6-d-55iOmYikYfon3u_cnJKX7zqViwiLDscHavHO8TA>
    <xmx:f69gaZv8fEnPu27CltxU8EhsHheHh8Jiaq-MtcLqygIDuP4XyMDmGw>
    <xmx:f69gaamhDQkytTs6DLTCHSfgBIN53SfUyHL2vhjApA3VKkEij5K9ZA>
    <xmx:f69gacS4cHkAwgPP3aYonuR7Vn0vMFhv_yr-6AX3HhuqjeRZNKNh5g>
    <xmx:gK9gaUf_31KrZii7-4VXwCcBBm9TlfmOSrT3zIPCO9uEO211Lz_sZs-0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 02:34:22 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 98b08fec (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 07:34:20 +0000 (UTC)
Date: Fri, 9 Jan 2026 08:34:12 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Elijah Newren <newren@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Matthias Beyer <mail@beyermatthias.de>
Subject: Re: [PATCH v8 0/7] Introduce git-history(1) command for easy history
 editing
Message-ID: <aWCvdHGDzZC5OLFU@pks.im>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <20260107-b4-pks-history-builtin-v8-0-18e9779e3a26@pks.im>
 <CALnO6CDhDFtz5WY2pd8as5nH-URxzfNUfkouQ2Cf6USuRRTrKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CDhDFtz5WY2pd8as5nH-URxzfNUfkouQ2Cf6USuRRTrKw@mail.gmail.com>

On Wed, Jan 07, 2026 at 12:39:47PM -0500, D. Ben Knoble wrote:
> On Wed, Jan 7, 2026 at 5:10 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > Hi,
> >
> > over recent months I've been playing around with Jujutsu quite
> > frequently. While I still prefer using Git, there's been a couple
> > features in it that I really like and that I'd like to have in Git, as
> > well.
> 
> > - I've dropped the patches introducing `git history split` and will
> >   send this as a follow-up patch series once this once has been
> >   merged. This was done to focus attention on the underlying mechanics
> >   as much as possible (and to keep my own sanity with the frequent
> >   revamps).
> 
> Sane, if sad for my custom build which has enjoyed having "git history" commands
> available :) I can wait for other patches, or try to contribute some, though.
> 
> [reads further]
> 
> Oh, it's just split that drops; we still have reword, etc. Cool!

We only have "reword" for now. In any case, I'll definitely upstream
more subcommands once the initial version has landed. Probably the
complete set of commands I was proposing initially: "drop", "split" and
"reorder". Afterwards I'd also like to have a look at "absorb", but I'll
also gladly accept any help.

> > Range-diff versus v7:
> >
> >  -:  ---------- >  1:  53a845e874 builtin/replay: extract core logic to replay revisions
> >  -:  ---------- >  2:  3ff1c0bacf builtin/replay: move core logic into "libgit.a"
> >  -:  ---------- >  3:  598df4e186 replay: small set of cleanups
> >  -:  ---------- >  4:  fd6a0ec5b8 replay: yield the object ID of the final rewritten commit
> >  1:  0e2d8db69f =  5:  04b832320f wt-status: provide function to expose status for trees
> >  2:  087c563575 <  -:  ---------- replay: extract logic to pick commits
> >  3:  4ab2a6f807 <  -:  ---------- replay: stop using `the_repository`
> >  4:  d2138e95d4 !  6:  e223659b86 builtin: add new "history" command
> >     @@ Commit message
> >
> >          While these operations are all doable, it often feels needlessly kludgey
> >          to do so by doing an interactive rebase, using the editor to say what
> >     -    one wants, and then perform the actions. Furthermore, some operations
> >     -    like splitting up a commit into two are way more involved than that and
> >     +    one wants, and then perform the actions. Also, some operations like
> >     +    splitting up a commit into two are way more involved than that and
> >          require a whole series of commands.
> >
> >     -    Add a new "history" command to plug this gap. This command will have
> >     +    Another problem that rebases have is that dependent branches are not
> >     +    being updated. The use of stacked branches has grown quite common with
> 
> "[D]ependent branches are not being updated" reads weirdly to me.
> "Rebases also do not update dependent branches" perhaps?
> 
> >     +    competiting version control systems like Jujutsu though, so it clearly
> 
> "competing" ;)

Fixed both, thanks!

Patrick
