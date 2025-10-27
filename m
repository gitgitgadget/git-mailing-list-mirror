Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9942857F1
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 09:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761559105; cv=none; b=HAcDCWeQ3LyZsn/7uThQCHLPlLgK7fBVWsmTgUxyWMBmF4VfWOufSUTDml4IV0o8u24hIGkxyh1Tn9Xag66UCEF889IqhT4HI3XCG2lN7pBedZeLKfJxQexd6esof9ftpC83U+FuJaIB1H1Kv5/o0uOm+pQ0XtplMl+cKRg0WGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761559105; c=relaxed/simple;
	bh=Unu/xB6PdtRhXEJYkJhNR77ugQJ6kvPldsvaFxVGhvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpJCKnQmDmC52Vtx+f+lf5s3QZLAwXmAlWdhPfslSHFscshcJU9AXyDiqoe07OBW6SXbRBeAJG3Eq6UJ+JSVdmeHi6gQJETdJAUse9JQyJiBsBEmY2HFamsTFF954jukEcGzHxq4IBBhnlP5a+0dvPns47hDYQc9tYrvuRodx+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bQQgkecj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oRo2ef1n; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bQQgkecj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oRo2ef1n"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 0F413EC012B;
	Mon, 27 Oct 2025 05:58:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 27 Oct 2025 05:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761559103;
	 x=1761645503; bh=Ll9footmTVnDfpFVv1Nezh89qeyq5SM1rC7Jxz1mX4s=; b=
	bQQgkecjcMrN9ZjrQkFhJvGfkdNMXfTl7jbrklObYXrF9eW86y3CJ2FgqDbK8rxN
	lXl+8iQHV2TS8JhPMndnCqghv8WZkLdMJAVGpSvpm2BJv9CsNVhIsmzk5ksHFLKD
	FJJifz5iGifGvBXTZ0SyUESY1xI8f2J+miA3WMn7+Szd6eJnXimxAuu1p7Tk6793
	W36za6Gaf8em9EnO0A83tIZciyJXxTczio00yKUXPjoe9mxOGm5Pskf++d9NdFyP
	p3Uc2izBXANMYLDKhI1Mq69M7MuBKl0NUC6fu3hQkU1SXCZbVDNjKvwH2hmoa2RG
	xZhGCvk3XHHHlAupafJXgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761559103; x=
	1761645503; bh=Ll9footmTVnDfpFVv1Nezh89qeyq5SM1rC7Jxz1mX4s=; b=o
	Ro2ef1n4yMFphcqRzeIeElugkmwbKC6bEa/1ESdF3TaK+u+n1OJzOKKmjVc8Aevt
	bGnETf+CUwg33r2epCB4SNK39fLpYJSuDQNsSJvOunGrGHBlFbdTgOGHPl4sJYbA
	aO3ZFR1tAGl7xB0GukL2OUcIgcIH8NcPuuigkxgSRDIJqVtA9dwOH7B/hsqdr5r+
	Vv5ckwZtmvWUHIcYRUBjqwlVX+2inMFUFsN0G8Kcz/6obNvSbbDbOtY1qzQCJzkS
	1+NYiDFqANHqO9AWOxnrozAWHLlAjY5atKrVPxZLaGAdgbDfx3W/xmwpj3uNU7bS
	h3faGSwXS9X5k8ue8Z12g==
X-ME-Sender: <xms:PkL_aAJIZ-LxxMIhh1TVJafIpwyD3-XXgFtLN3HkrHFaw2zouZrhvA>
    <xme:PkL_aNBJodX0-kzVqY4ssOa0cWs5Q9NdUY7Rf7hqjQ5BT4GS46bPJzWhhO9OIOsvY
    I4BqXGLtFKoSxd6bE8wtoPA8FLSozbmTS_4ugEG_z7KYiQeZNVeBQ>
X-ME-Received: <xmr:PkL_aAcDSlegi-ua6kJag4I9-JwiOK86i-C6JOvQFc8t62CnXhbNxz6aGLDTqQ9Jxm3kIo7ZnlnnZWt59jJ6DlU5raC7XEltPOoshcykVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheejieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvfihrvg
    hnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhorhhgrghnohhvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepkh
    grrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhho
    sghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrthhinhhvohhniiesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghp
    thhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtoh
    hm
X-ME-Proxy: <xmx:PkL_aM3DLwc506hdhUK1_NgYcRkJYHYwKsu0_GeHPNBb7Mi2pTLGaA>
    <xmx:PkL_aHhC3lFf3on0Y6xp5wgm3RzFK9FL4331YCMZ_7RuVZy_jS6gow>
    <xmx:PkL_aFkZAauOiIoGDW8-rRiA5nGuPKu_xPK41iqPsIm-_aFljY83ww>
    <xmx:PkL_aNanFdCYRf8gYiSCjreVU6lBTjq2saMkPpWiQKdTPrq5nT2pKQ>
    <xmx:P0L_aIvaoZq-lHBRTN6CFcoe3N1JrFZxyNN6TW3KpcEkzpmYG_JXiy2d>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 05:58:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 54703172 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 27 Oct 2025 09:58:20 +0000 (UTC)
Date: Mon, 27 Oct 2025 10:58:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 12/12] builtin/history: implement "split" subcommand
Message-ID: <aP9COS96zn3yCRlp@pks.im>
References: <20251001-b4-pks-history-builtin-v4-0-8e61ddb86317@pks.im>
 <20251001-b4-pks-history-builtin-v4-12-8e61ddb86317@pks.im>
 <CAOLa=ZTnsHxK2+rRsAErY_zc1Rg5WNrmcDBiPgDk38zb9TNfkQ@mail.gmail.com>
 <aPdyBpuLfuYOLe7q@pks.im>
 <CALnO6CAj2Jynun7Ns5222FFevqEF3O7ACVEU-GzT6DqUSxQNjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CAj2Jynun7Ns5222FFevqEF3O7ACVEU-GzT6DqUSxQNjw@mail.gmail.com>

On Tue, Oct 21, 2025 at 05:19:19PM -0400, D. Ben Knoble wrote:
> On Tue, Oct 21, 2025 at 7:44 AM Patrick Steinhardt <ps@pks.im> wrote:
> > On Tue, Oct 14, 2025 at 09:38:51AM -0400, Karthik Nayak wrote:
> > > Patrick Steinhardt <ps@pks.im> writes:
> > > > diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
> > > > index b55babe206..83d675afea 100644
> > > > --- a/Documentation/git-history.adoc
> > > > +++ b/Documentation/git-history.adoc
> > > > @@ -40,6 +41,26 @@ rewrite history in different ways:
> > > >     provided, then this command will spawn an editor with the current
> > > >     message of that commit.
> > > >
> > > > +`split [--message=<message>] <commit> [--] [<pathspec>...]`::
> > > > +   Interactively split up <commit> into two commits by choosing
> > > > +   hunks introduced by it that will be moved into the new split-out
> > > > +   commit. These hunks will then be written into a new commit that
> > > > +   becomes the parent of the previous commit. The original commit
> > > > +   stays intact, except that its parent will be the newly split-out
> > > > +   commit.
> > > >
> > >
> > > So in essence we do this:
> > >
> > >   Before split:
> > >   P1 ── C0 ── C1 ── ... ── CN
> > >         └─(target)         └─(HEAD)
> > >
> > >   After split:
> > >   P1 ── S0 ── C0' ── C1 ── ...... ── CN
> > >         │     └─(modified original)  └─(HEAD)
> > >         └─(split-out hunks)
> > >
> > > I do wonder if S0 should contain the existing message and the new
> > > message should go to C0'. So perhaps more like
> > >
> > >   After split:
> > >   P1 ── C0' ── S0 ── C1 ── ..... ── CN
> > >         │      └─(split-out hunks)  └─(HEAD)
> > >         └─(modified original)
> > >
> > > Mostly because when you say split, I would assume we keep the original
> > > as is and add on top of it. I don't really have a strong argument though
> > > :)
> >
> > Yeah, this has already caused some discussion beforehand. I guess you
> > can argue either way, and the suggestion from others was to simply allow
> > the user to edit both commit messages.
> >
> > I don't at all mind going into that direction, but I wonder how to call
> > the "--message" switch in that case. We could of course just call these
> > "--first-message" and "--second-message", but that feels somewhat
> > awkward.
> >
> > Also, I already have it in my mind that it would be cool to extend this
> > command so that you can split into arbitrary many commits. That is,
> > after you have split out the first commit we simply go back into
> > interactive mode to create a second commit tree. Rinse and repeat until
> > we have no chunks left anymore. But if we had such a mode though, then
> > numbered parameters don't make much sense anymore.
> >
> > An alternative could be to just accept multiple "-m" arguments, and we
> > then apply the messages to the respective commits? Dunno.
> 
> Or *gasp* not support "-m" at all, and require the user to put
> _something_ in an editor? 🤔

Let's do that for now and discuss in more detail in follow-up patch
series.

Thanks!

Patrick
