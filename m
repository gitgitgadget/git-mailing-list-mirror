Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687D53164C7
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 07:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792395057; cv=none; b=a5YzS+ENL2rgoUvNgWNslCBzuUHllyz3e0AxjDIefW/BDAhXamDXIILiIYryHIwL0tMBRg89HEf8JY6o0oEfsvuSL9boMa2lH1sui2FVcXQY57WmodRrITrtU7v3kJZmVjtaq69XCs7BbFGzaPWut/2s5rUQOy8vbkiTVnfZ3Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792395057; c=relaxed/simple;
	bh=lPsypmkrYehj1b6oBTRsXJk9WXJ+f0XqHa9f55wFWoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUGNSfvkbDgiLh52bAv4aBlgI5GeOe6TPd7egjvrgerL7hR0LXrQjUXPsKquqaWnZxJFiXnuQa3Tvtut3KASO2J5ze1lpd2sCLGuSF14GHznI3/+42lJmE89kGCCkKi6XBpws1kWTKETlHKeu3p/UjK8MlWME2HTIRUDkGKNuQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DAQQOyZV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d051xrYy; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DAQQOyZV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d051xrYy"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 9EF3B1D000BE
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 03:30:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 19 Oct 2026 03:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792395055; x=1792481455; bh=WC/hYsMl2d
	OlwXgvn3hn5JifTkOcxNFsJ6nH477zr2M=; b=DAQQOyZV5tyEJRdCp/DnAIjbLI
	+5lSDOF6d7Z8udTTYbTWXq1+pgsVgqhY5rK5qZShMyJV+Etl2047pQaxchNVhz3m
	E90WSFMYLsAEDWecyjSbmkCZhu/vICQNMX0W7DShov0XPH13wR7VBrmULQXH+hmR
	a1beU6eE7kvVdhMEECyzvfxBjJHigWSiwi4mNy8X1W9c9LeaK32s7HnZPyPy/FRa
	JLBS9+NQ5WXXyea9xN9SCxKOfWg20upXOqjonf4153lPihvp4QH979xyiYmQjnPA
	MrD2o+XW0gMZeHdALLF65npHS7E25jYuxPTdo3fpIbof9zChJOia4Rk4T+zA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792395055; x=1792481455; bh=WC/hYsMl2dOlwXgvn3hn5JifTkOcxNFsJ6n
	H477zr2M=; b=d051xrYyMFJN3fIzVpxjXVziB+56pTLg9ybwG0LNldKWFmI55IV
	DHpJIx65LVRJQQksy+ecB9avv7tgn7VimFTQGirvOUmtuXXcBOBpRtPo5OjLSEnR
	ZXqSQdFNjsRQlAagnCP17OdrM2uICcEZu3wrik2O6C0/M0/ptSNSIFN5m2uKoaT1
	b8T6TkkOAV7/meSWoU66Rm8LDvuhSq/EAKqc/4SY9YeB1vGwpCQRCTMbt5fKbd8c
	5ZmokM3SIyY31mZCMIZoPtT7DirU3klH0Y9L5eyl1ojarAr93OLhmgcJJs0mRs3S
	I1qkIkgdKRTSz5aNiMGFVJ2IysheO+TFemA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792395055; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:KXioW7bFJRt6dfet81qxUWvThLTzDGCQb6bZpuQnGo6fKvt
	qxzL1X1XoDWETFcVreHJ5m7mHAvL9vYDjEKEl9oTctOER5+5zSSkCxNkmWqt9cP0
	QQWsY6lprNuf8RUJTgplJJNV2hhR+f+qFPL4YXxnSnKDd6kbKgBbHk8gdrGZ8CcR
	6/UPtS7o+SsEDQP3pyUaQsqxU34wEQi9cbWFOyUOJlpeXazu9yt9TyQ5eQwawzsW
	VaXgtPEIsh5l2zG7Uf+aIGfBzGGVcl50F0a2Ck+k1iovtcWkG3N0ptrqJME7ov+U
	3h6wcDW978oeapKLnJCv6MgYJhcS5YZnXAw3jLQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:8WXz2k/yT3yyCqoTHPgKTVmCDDd2EgtXfYTRZ8tczdk=:lPsypmkrYehj1b6oBTRsXJk9WXJ+f0XqHa9f55wFWoo=;
X-ME-Sender: <xms:L8fVarlMqRX6fErPMARfyiEu2qUVmcUfevDFbqVIyMgxura1_fBHRw>
    <xme:L8fVamTYYS6t2yK5QfrzmBAi6r9Nqm2xT7m5XbFt-sSn0qyhO3X6rROCGRZtAwuJX
    wKN-d2Mx2rcEuMH59Z9IurId59YVUY0qqDrDqCS-_mTRk9GKxI2_pk>
X-ME-Received: <xmr:L8fVavACwRBl8t4z5v9dt49HutlQy9fxpw2Sl4C7ugsRrweHJSqZsA>
X-ME-Proxy-Cause: dmFkZTE8CQh/WlJC507uIIHkqNkpfca4U70xfxdVdP2t4ZSKaNO/OLeVmOb0kEpal6IQlv
    DYqI3bH/8v9GHSzVwk4EuuxzKn3+1P+rkK7R52qH58LdVq8BVd5xTO5eYMP70r4LWu4jXZ
    H4ie7DpkWkz3yYdSMROraNKQDr08hZ2iHtiI35KMALG8c40jRudtV+iT84IiUBlbrx8avp
    iqC+7DsTKTPGsvUaA3Z6IXC7Ynpno9fQPia7OS1HYbVKEjhFS4YC7e+Cw8K9KVsODZoNj+
    6n73kzlDnL86Tknk1JZVGJNloAfHb8RoNskDKySC/Q2+jzXCwcpt+HhHeN8YYBqQfqf3L0
    i6FIKTnJkRkDdytRJtxBBBUuYcftu+23la7zAlwfy5hfq2Lq0turvAGxx0rxA32ilFC9fy
    Q/gRe5k6cmoUd7liaFMkEWm8iD4GT3v5WcPy0yBE+lCCjZzTiQJh1fHsXfFW5taes2mMaM
    t6ehgqn04SfhgJB/eRdzPNFk9DCj9W9Nvpx+W0FpjJBmdlLw7thT47VvoCE4f3LhtnJnFW
    qVpTsdQsUp1MqTw+d23WEgMR/hIkCZ8T0RQq6ZyI3oNWi6U+AnTNJ8FhXTlSPby6ArkxlL
    cgR4wBk+O1W2rAaXms9aZqbedF0TwRXmmfd1kJsj8h3TpeAhHkdRkYutc1hQ
X-ME-Proxy: <xmx:L8fVatRj3Ehy_hDtl4EQrgJpWpG6TfcH6v_DIBUzT1uj-jtnyh-siw>
    <xmx:L8fVatp0WFFqRDggZVxNyMl6j2lPMNpWc_K0Q3M8lxTY_5EJ-HgZbg>
    <xmx:L8fVavwdL-tu5yui-SZhSn02Im0wPPpC4MMrP9k0NCjP9N0eQlGQlA>
    <xmx:L8fVaiI2IxKbvTpMC2Lb823dsVId4z-omsdqzYvT3sWH3qCbhaTxEg>
    <xmx:L8fVarhMv21DS2dVf7YKHOHh-2TDY25MnWpALtRXnUQHsEN8xh-sl7sM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 03:30:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8ec35a9b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Oct 2026 07:30:53 +0000 (UTC)
Date: Mon, 19 Oct 2026 09:30:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v3 4/4] connected: add incremental connectivity check via
 rev-list
Message-ID: <atXHKkGztmg8QFYt@pks.im>
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
 <pull.2211.v3.git.1791806877.gitgitgadget@gmail.com>
 <efaada0b6a8ffdb4d1c01d7f34a0d6596a99c149.1791806877.git.gitgitgadget@gmail.com>
 <atB48HLgZr3ssOfx@pks.im>
 <CAL71e4Meuv1KXTX9HeQzmyVdmtYDCrd4M6VNcRRt5HZ-DKzbQA@mail.gmail.com>
 <atC-GVBnQrfr3cQ0@pks.im>
 <CAL71e4NA3SH8V_haxJFeYCBmKk8+96j7ckxLDZA7+XMNcVfdKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL71e4NA3SH8V_haxJFeYCBmKk8+96j7ckxLDZA7+XMNcVfdKg@mail.gmail.com>

On Fri, Oct 16, 2026 at 01:50:21PM +0200, Kristofer Karlsson wrote:
> On Thu, 15 Oct 2026 at 13:50, Patrick Steinhardt <ps@pks.im> wrote:
> > >
> > > I think this is where it gets tricky to reason about.  The win
> > > from from larger trees pays off without bound -- the larger
> > > trees you have, the larger the win.
> > >
> > > Scaling with commits on the other hand we have ceiling of how
> > > much it can regress.  I am thinking that could be reasonable
> > > that anyone who enables the config flag for this mode could
> > > simply accept that it would likely speed things up in most
> > > cases but in other cases they could see a ~1.5x regression.
> > >
> > > I am hoping that this tradeoff would then be acceptable,
> > > otherwise we would indeed need to add some way of switching,
> > > though I don't think there's a single good indicator value
> > > for when it's better to switch.
> > >
> > > I could add a new config flag like
> > > transfer.connectivityCheckIncrementalMaxCommits to control it
> > > perhaps.
> >
> > Yeah, making this configurable may be reasonable. The way I understand
> > it, the new connectivity check is most likely to be usable for smaller,
> > incremental pushes. And based on the above table you have, we see that
> > up to 1k commits the new algorithm is faster. Sure, it's an artificial
> > benchmark, but maybe this is a good enough cutoff for now?
> 
> I looked into this a bit more and I have two main notes:
> 
> First of all, I benchmarked multiple repos, both with small
> object trees (such as git.git), medium (linux.git) and some
> really big ones (proprietary).
> 
>     repo          files   commits   full    incr.  full/incr
>     internal A    552K       1000   1.69s   0.66s    2.6x
>     internal B    331K       1000   1.48s   0.57s    2.6x
>     linux          95K        609   0.34s   0.12s    2.8x
>     linux          95K      13965   1.86s   1.90s    1.0x
>     git.git        4.9K       356   0.09s   0.13s    0.7x
>     git.git        4.9K       976   0.23s   0.31s    0.7x
> 
> So for large and medium repos the cutoff of 1000 is
> conservative. Incremental mode is faster but the full mode
> is also good enough here.
> 
> For small repos like git, the incremental mode is slightly
> slower, but since the number of files is so small, both modes
> are still fast enough that it does not matter.
> 
> (I could not get an exact 1000 commit test synthetically by
> looking back in the history for all repos, since it depends
> a bit on the shape of the graph of commits.)
> 
> Thus, I think having a cutoff of 1000 is indeed a valid
> strategy here.

Yeah, thanks for evaluating this. Heuristics are of course going to go
off rails at times, but I agree that 1000 seems like a good enough first
iteration.

> Second of all (and with the previous in mind), I think I would
> want to change the configuration into three modes:
> 
>   - full (default): work as it does today.
>   - incremental:    only use the incremental mode
>   - auto:           decide on full or incremental depending
>                     number of commits to process.
> 
> This would make things safe to roll out and start gaining more
> real life confidence before potentially changing the default
> to auto instead.
> 
> We could also make the cutoff configurable, but I am not sure
> that is needed in practice.

Hmm. As the heuristic can easily go wrong I think it would be a good
idea to make it configurable. So I'd propose `auto[=<cutoff>]`. If left
out we default to 1000, otherwise we pick whatever the user has
specified.

[snip]
> > > > > +     if (type >= 0)
> > > > > +             die(_("object %s is a %s, not a %s"),
> > > > > +                 oid_to_hex(oid), type_name(type), "blob");
> > > >
> > > > I'd love not having all these calls to `die()`, as this logic is
> > > > essentially part of a library, and dying inside a library is a bad
> > > > smell. We do this everywhere else in Git, too, but we're slowly getting
> > > > rid of this as part of our libification efforts.
> > >
> > > I think this would be a bigger refactor in general --
> > > the existing connectivity check also dies as the way to
> > > report problems.  This works since it's running as a subprocess.
> > >
> > > If this is something we want to change, I think it would be
> > > good to do that refactoring separately and make the connectivity
> > > check subprocess only die() at the very edge, and making all of
> > > the internal library code support not dying.  My first prototype
> > > tried to do this but the amount of changes to internal code got
> > > out of hand, so this version was the simplest I could make it.
> > >
> > > But I'm happy to take a step back and revisit that approach if
> > > this is a blocker.
> >
> > I mostly aim at not making _new_ library code die anymore. In any case,
> > I don't think it's a blocker, but I nowadays consider this to be a code
> > smell.
> 
> I have spent some more time thinking about this and I have
> changed my mind -- I think I was too stuck in the idea of
> all-or-nothing here, but I agree I can make this work in a
> mixed way -- not introducing any new die() but accept the
> cases where it already dies.
> 
> I will include this in the reroll (likely next week, don't
> want to rush things).

Thanks, I appreciate it when folks take their time :)

Patrick
