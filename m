Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6425437F01B
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 09:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782812701; cv=none; b=qXk+Pwl70rZvRTPz+/tnqUsFMDkukk1gb/IWZaevT/+vH1JOWG2niWcStIzts5aEpoaN5uhnfoMVqv194HtpF61CX5gntCvFOHuWcPiIilE1Yb33AcbjGFf+B6ChWjl0wJ7rsWPu20eUYHbZJI1m2FMITZHwlY1PCFzhV9ypG2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782812701; c=relaxed/simple;
	bh=QnoY1Z2w+vCcOD4W1JUALvOd1QFAQSXCzMaGDDJYEJs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ojJLQguoISJfzOheCcx8ici9QdzXyKz0qvLRxf4pQR0hffZMoPQKgGSg41vAbHpmMt9CIACr0KoummWKUwRe5cTapqXaGar/0e+GXySLGTJyRimTAkQ/8maDWVGh9X2w9OJfYzRAsd4hA7QA8SUFcLHY7Rs9tzqdGa6UYfQw3ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=N238OTAE; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="N238OTAE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1782812692; x=1783417492;
	i=johannes.schindelin@gmx.de;
	bh=CUJmr9YBP6sc1Gpbrwg+DR1osF9rY3ilmCVtRCJkBxU=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=N238OTAEppGapWx2LSf/6/YMv5L9FgyPhSv3eRznj6GqMV4XSSRN5pmVFjLLs2Rt
	 MNThWN9tZ9q9cIHHsDjkGU1IqPdJH14sa0B06aMT8o2Et6fjFFISbkAFwsaR4NGWT
	 IstuZdqPOzYbYr/9StRkxxoxqtKVM2BdoOVMo+Cj+vCVJvEBNCr7gKbFgD1I23dO3
	 a7yI5cemcUWreEnbvEMWUog0S24CtSmC+IFv7RhDTHu8uioA2y6BJ+fXDzsvOG6La
	 W0/5s33NOG7wiDJoLx4kodJPkOdHSSqqEXqoKuAsI/PaMi8anyOBgCkAGik0mKJjX
	 oHQg1/oNXgu6+volTA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N17YY-1x6Wbe1wja-00zddW; Tue, 30
 Jun 2026 11:44:52 +0200
Date: Tue, 30 Jun 2026 11:44:47 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org, 
    Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 3/3] replay: offer an option to linearize the commit
 topology
In-Reply-To: <akInDBlyWbbRFcLH@pks.im>
Message-ID: <9e7d14c4-82f0-2b89-b07b-f219119a199b@gmx.de>
References: <20260622-toon-git-replay-drop-merges-v4-0-ff257f534319@iotcl.com> <20260622-toon-git-replay-drop-merges-v4-3-ff257f534319@iotcl.com> <ajk-a4a3KSJ2u7Ju@pks.im> <87qzltyiao.fsf@emacs.iotcl.com> <akInDBlyWbbRFcLH@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:gttqc+XCkdMhwOwpvvR0RkAQUHCpiUQhSefhhh+W8V926vFy9w3
 UHjt4+yH2ZHrJ/+JJHYRuihPESjpQ4P/utrQGkLn4R7Zpb28v3in9V83sA6Ee+rZm6BLJXb
 u73czRmmu/LTBAlzxdWyVFG1hOCXLsYurVlpkwfhrN+/WN7UHk7vfpJiJth+48kYSOTi4VT
 sriFs1uIjcbqLNJvlzbDw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bq5RMOq57xc=;Zp9ekiVvR9s7JoecF3sGBgfJjtR
 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
Content-Transfer-Encoding: quoted-printable

Hi Patrick & Toon,

On Tue, 30 Jun 2026, Patrick Steinhardt wrote:

> On Fri, Jun 26, 2026 at 07:36:31AM +0200, Toon Claes wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> >=20
> > > git-rebase(1) essentially knows about three different modes:
> > >
> > >   - "--no-rebase-merges", which is the default and maps to your
> > >     "--linearize".
> > >
> > >   - "--rebase-merges", which by default doesn't rebase cousins by us=
ing
> > >     "--ancestry-path" internally.
> > >
> > >   - "--rebase-merges=3Drebase-cousins", which doesn't pass the above
> > >     option.
> > >
> > > So it's not a simple boolean there, which makes me wonder whether we
> > > should mirror the same interface so that all of git-rebase(1)'s mode=
s
> > > can be represented, as well.
> >=20
> > That's a valid question, although I don't know a good answer to that.
> >=20
> > Basically you're asking for what the command line options will look
> > like? Allow me to think out loud.
> >=20
> > In this series I'm adding --linearize to git-replay(1). As mentioned, =
I
> > don't think it makes sense to add it to git-history(1) as well. Withou=
t
> > this option, the process aborts when it encounters a merge.
> >=20
> > Dscho sent a patch series to properly replay (2-way) merges. I think
> > this should become the default for both git-replay(1) and
> > git-history(1).
> >=20
> > But then, do we want to have an option that brings back the current
> > behavior of aborting at merges? Maybe with --no-merges?
>=20
> I think that would be a sensible option to have.

I also think that we'll need a way to abort at merges because linearizing
commits is a relatively common operation.

> > Then there's the option of rebasing cousins left. That's something tha=
t
> > isn't covered by Dscho's series yet. Maybe --replay-cousins?
> >=20
> > To reiterate what the final design could look like:
> >=20
> >  * <nothing>: replay merges preserving topology.
> >  * "--linearize": flattens merges (only git-replay(1)).
> >  * "--no-merges": dies when the process tries to replay a merge.
> >  * "--replay-cousins": does what --rebase-merges=3Drebase-cousins does=
.
>=20
> Right. And if we tried to be consistent with git-rebase(1), then this
> could be done as:
>=20
>   - "--rebase-merges" to replay merges preserving topology, which is the
>     default once we support replaying them.
>=20
>   - "--no-rebase-merges" to flatten commits.
>=20
>   - "--rebase-merges=3Dabort" to explicitly die when seeing merges.
>=20
>   - "--rebase-merges=3Drebase-cousins"

The `git rebase` options are unlikely to be a good precedent to follow.
Their history is full of usability warts, and in hindsight, I would really
have loved a more steady hand in developing and maintaining a good UX. The
fact alone that this is called `rebase` speaks volumes about how hostile
of a user experience this command surfaces.

In any case, these options should use the much more natural term "replay"
instead of "rebase".

But then: you said that `--no-rebase-merges` should flatten the commits?
That's not what this option name conveys to me; It would convey to me that
the operation would _abort_ on encountering merge commits.

In other words, I do think that the --linearize option is conceptually
quite distinct from the different modes in which merge commits could be
handled. As such, this option should probably not be conflated with
the various `--replay-merges=3D<mode>` modes.

> > Now, all these options are (I think) mutually exclusive, so we could
> > consider an option "--replay-merges=3D<mode>", but personally I find
> > "--<option>=3D<value>" arguments harder to use than specifying separat=
e
> > options.
> >=20
> > I think I'm avoiding your question, because the design of the command
> > line parameters doesn't need tot 1-on-1 correlate to the internal
> > datastructure. And I agree the mode isn't a boolean, but does that mea=
n
> > we want to use an enum internally? Well, I don't know. And I also don'=
t
> > think that matters right now. Code is easy to change, I think the
> > command line options should be designed with the future in mind, which=
 I
> > believe we do with "--linearize".
> >=20
> > Sorry for this long-winded rambling, but bottom line I think it's fine
> > to add --linearize and in the future add more options and see how the
> > code should evolve to support those.
>=20
> Hm, I dunno. You basically reasoned that we potentially want to have all
> of the same options that git-rebase(1)'s "--rebase-merges=3D" already
> supports. So that begs the question why we need to reinvent the wheel
> then and not just use the same syntax.

I would strongly caution against repeating the same UX mistakes as `git
rebase` has to live with.

The _functionality_, yes, I think that'd be good to have in `git replay`.
But we can surface that functionality in much better ways, with option
names that reflect the concepts much more intuitively.

Ciao,
Johannes

> Note that I'm not arguing that we should support all of these options
> now. I'm merely arguing that we should try to be consistent, unless
> there is a good argument not to do that. I'm fine with the interface if
> there indeed is a good argument, but if so we should document why we
> think that the current interface in git-rebase(1) is not a good fit for
> this command.
>=20
> Thanks!
>=20
> Patrick
>=20
>=20
