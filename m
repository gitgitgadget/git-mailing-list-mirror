Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744EF51A743
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 11:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792065059; cv=none; b=PYrc0Ukl9BzH6pehFNVhGs6iynkY66NRvWSkXF+NOUoun7UrdQJq1eJBp9otVkzCXRwnf2L2ritOcQ5t3CWR4NaEFIKFaCn2DYV8VRyI+y3FVhsgqzKSLYkmAIM2H5K3zMD+uQpvPkxXY5zai2JZfSEDOFM841nzds/lnknZX1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792065059; c=relaxed/simple;
	bh=/Ezmy0HMF1Xd87GnUC4Y+z6a1/m54SVCdr39lysYfzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R43MPgK+j6FHCGG+vp4BJAsBW1ZUfI5NVYQXrLEj8S73zfL0FxODrm1fPJTjUzM2krnSYTCCyZtd2pGrpvoZCXcf/obLA3aAUqJ5vG1RiYznAcnMN6QHj30QHMEUjP7VkQOoNmR9HTPnLuCZQkjj0N+6IvXSMpqDW7hv3OXzBPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HkB33N1d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u4+SjFyu; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HkB33N1d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u4+SjFyu"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 925111D00199
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 07:50:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 15 Oct 2026 07:50:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792065055; x=1792151455; bh=ZQurJu1ma1
	HOgUHJjo5NfASaHELzvlRXxQbyy5PLBq8=; b=HkB33N1dApYfscSHf0wN/vEdmY
	rJuj4qKNqENsjnT0ujRXVmc1nC56XczEe8Pz+TPI+6Cqtv1Vh7JLhqIRAzQrU13N
	1xH9zPZcTIuj/5IZ4ir00g8ghW81m8GyrtH54l8kyTtmhFlLmd6al7pE/xzYMxzv
	M/W6IYarBrfRvtuOFKfDP+FWUnFdhOHfxiVFUnThiLpzo+gSI0rXs879eRVj9Yee
	Xq4M526pSKpqPNj1BE5Wz6rScaXfwGA6mu+U3xyN21plY0Opq8hx+Hu3ses8rNXz
	nWmlOSs6uygOQWNQEe9xXaFuMQ4e73osQCrRfA/YJb3Uz0nYxmyMXX3Drzcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792065055; x=1792151455; bh=ZQurJu1ma1HOgUHJjo5NfASaHELzvlRXxQb
	yy5PLBq8=; b=u4+SjFyuPhHTo9O9+MO/mBY8CTx2t2WaYVj+5ObpIYMYn3PA33a
	7wS2Uovo/auw58Ax1mZhvP1U7IwukJzZ/87qhISM8kNiAC4Dg+qa19rx7EJqLEHe
	BzrhwimZ9pfIgHw+XzyoSpudfQW053vnnfB8aX1pj85bQ0czIf0YNHyclst992My
	dWnIlvMHaNXMlnm0aQxhR0HfZZ8xweZfHrjpPlFVb60fGrFsJpoi5szuum0jskAR
	gDZiv/z7oqkiACM1wRxs2DT1KXo34pIqxFhK1sQbT4/0IrUsnI+B+3EfG++R988p
	6bxr6owXlun2ONqVx3501vxM68aKCfevH4A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792065055; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Yk2c/1tYh0HjnP/cRrObnvsCfU7iMNPcpmLSQ/jBNkd/pAF
	d9gAb3Y/aOIEEmQM7iEZLmfqXP+OwqanOmk9G1VhU+BViDkmnzThyWyHDRryr/lJ
	37qQJYub208fRNbmH0Fj3xJC86o2wPfoUHrioozpUnryPXEBc5wnpLR/K5RElMGU
	SGPaHt8jjTUqyKdj1RZkq11cPeSQ/0jM+hTGmjIzUyU7328WqNAOi9G4QEGjY6jN
	xOSbCWt29cxPzjOpagB9QeTSedg/UTyZ8hk3/fJ6j8QyIpVtl1vUSgtoXav+/Y6i
	3gg0nanUOyb9AnZlQZ9+blHGyKi98snFMmD4Z0g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:wKqxSxftz+n8awZJPvI4wZqOesdMNjNdCMuaqUKzXRU=:/Ezmy0HMF1Xd87GnUC4Y+z6a1/m54SVCdr39lysYfzY=;
X-ME-Sender: <xms:H77QavBkF8MJrNY-uiKlMXa2WGeKEQeiiZ30KLINhbyfndnlhw2e9g>
    <xme:H77Qas-Rt_SLROQJOwYceAOo1GAP_msZw7tL_OjvgJkIjvhlVlhve-gUDJKUHd-sZ
    H0B83NX97gA9inBqNikX-vtVC4jD7XDKVi6M2M-zm4QlhNQH2uYs7A>
X-ME-Received: <xmr:H77Qan8Xe0CEx3xT8EL2DoR13g6E80vWEz-EfmmS_l8Vp3l4t7zw_nqh3i0qHz-jXPyRGOA>
X-ME-Proxy-Cause: dmFkZTF6mWP4Se9drzlYQbE07oLwgiDdMcAmqi1y2reZxydxYL7S3yVRb5jn0V/gqYjZzF
    RuVnPFkaXq8BO+bCQbXJUGf/S9P2gZ5xNAgHK2hJtL/7I/5iS72oiCyN8FFXvfGsmEXvKV
    dMkpzcPU4Hb8Qi/bNLDaFbugHX84TA5lllMIhRw9Jb3r6Lzy9u8/tbLGX5bYS96tte3e5M
    bkZyEKWAxFZOlDwvgUC35W9ImPiCbBR4+YKvqC8nBavqJlO+vdVJU9eAM0xK+jIKgZXW6W
    t+Ew9WoqkjqbX6Tf0UNMz9/PIEPtPFV5b07amgH97APXccGEEdOYppIfw4hoHljcA0cslR
    Vwjqg4zhKrdYDLI5pgGqp4VWY+CkQXjJ4GOzY2eq9F6j2vyXd+6565Jn8XNzd1lYtsVuSZ
    zQe4mLb5yc8xffkjS02D9Hihfd8sHueoGXbqTqWwNOAjgMrNjK8WT5O2whzlFM24HI6L+T
    6HBso7Q7jMeR6M7mtbEuHABzBPCCSEncW48VFYmLhOx4o/W/GdMRKIxp0Xv3A9ACZ9wslo
    hfS+kIHOCk9CTCY7py0vx5rLO9kAHgAHUGpPMw4JmFj7PAQQjN2M4bAQGJ+8/QMUaLpzVa
    SGfoWAwAo5H7ID5ItfIWtQ6czXwlrqeyVZtaGsxThRtY0a/C6XzUmHKPYK0A
X-ME-Proxy: <xmx:H77QareeY79CJA8hXoRZdp0ws_m9kP54KECWIp8cQVBola4Vp-3vqg>
    <xmx:H77QaoF5GGuIBIJw_U03zxIYSzcfFZqx2Tk547N_45gxhOKV0-DUmg>
    <xmx:H77QahcjE4IlNuAKC0TR7V7r0Sd39d0ZJF4BAyxOU6N2ZLMfVjC4Pw>
    <xmx:H77QaqGks0xfVHG-n2svU9ih5M0MRZH2Ge7COkmBqKqcttCIMoc_8Q>
    <xmx:H77QasPV1wyAQ8OE197ltz-nbghuGWTKja65-wcfOgA8LZo4SGsbA2nN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 07:50:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fe5f4fb6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Oct 2026 11:50:52 +0000 (UTC)
Date: Thu, 15 Oct 2026 13:50:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v3 4/4] connected: add incremental connectivity check via
 rev-list
Message-ID: <atC-GVBnQrfr3cQ0@pks.im>
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
 <pull.2211.v3.git.1791806877.gitgitgadget@gmail.com>
 <efaada0b6a8ffdb4d1c01d7f34a0d6596a99c149.1791806877.git.gitgitgadget@gmail.com>
 <atB48HLgZr3ssOfx@pks.im>
 <CAL71e4Meuv1KXTX9HeQzmyVdmtYDCrd4M6VNcRRt5HZ-DKzbQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL71e4Meuv1KXTX9HeQzmyVdmtYDCrd4M6VNcRRt5HZ-DKzbQA@mail.gmail.com>

On Thu, Oct 15, 2026 at 11:51:46AM +0200, Kristofer Karlsson wrote:
> On Thu, 15 Oct 2026 at 08:55, Patrick Steinhardt <ps@pks.im> wrote:
> > On Mon, Oct 12, 2026 at 12:07:57PM +0000, Kristofer Karlsson via GitGitGadget wrote:
> > > From: Kristofer Karlsson <krka@spotify.com>
[snip]
> > > Scaling incoming commit count (200K files, 10 files/commit):
> > >
> > >     commits    full  incr.  full/incr
> > >           1    0.14s  0.01s   14.0x
> > >          10    0.15s  0.01s   15.0x
> > >         100    0.19s  0.05s    3.8x
> > >         500    0.32s  0.27s    1.2x
> > >        3000    1.23s  1.52s    0.8x
> > >        5000    1.88s  2.43s    0.8x
> > >       10000    3.72s  5.36s    0.7x
> > >
> > > With many commits the per-commit overhead of scanning both
> > > the new and parent root trees accumulates and incremental
> > > becomes slower.  Breakeven is between 500 and 3000 commits
> > > and the ratio stabilizes near 0.7x for this fixture.
> >
> > And worse the more commits we have. So the new mode is only really
> > applicable in scenarios where you know what your typical workload looks
> > like. The big question is of course whether we can have the best of both
> > worlds, where Git knows to switch between the two modes once it crosses
> > the threshold.
> 
> I think this is where it gets tricky to reason about.  The win
> from from larger trees pays off without bound -- the larger
> trees you have, the larger the win.
> 
> Scaling with commits on the other hand we have ceiling of how
> much it can regress.  I am thinking that could be reasonable
> that anyone who enables the config flag for this mode could
> simply accept that it would likely speed things up in most
> cases but in other cases they could see a ~1.5x regression.
> 
> I am hoping that this tradeoff would then be acceptable,
> otherwise we would indeed need to add some way of switching,
> though I don't think there's a single good indicator value
> for when it's better to switch.
> 
> I could add a new config flag like
> transfer.connectivityCheckIncrementalMaxCommits to control it
> perhaps.

Yeah, making this configurable may be reasonable. The way I understand
it, the new connectivity check is most likely to be usable for smaller,
incremental pushes. And based on the above table you have, we see that
up to 1k commits the new algorithm is faster. Sure, it's an artificial
benchmark, but maybe this is a good enough cutoff for now?

> > > diff --git a/Documentation/technical/connectivity-check.adoc b/Documentation/technical/connectivity-check.adoc
> > > index abef02debd..a1d2e9709c 100644
> > > --- a/Documentation/technical/connectivity-check.adoc
> > > +++ b/Documentation/technical/connectivity-check.adoc
[snip]
> > > +struct verify_state {
> > > +     kh_oid_tree_t *trees;
> > > +     struct oidset trusted_blobs;
> > > +     int trees_loaded;
> > > +     int blobs_checked;
> >
> > These probably should be `size_t`.
> 
> Sure, I can change that.  Or intmax_t since we'll need to cast
> to that later anyway for the trace2 output?

Hm, okay. Not a fan of using signed integers as counters, but so be it.

> > > +     if (type >= 0)
> > > +             die(_("object %s is a %s, not a %s"),
> > > +                 oid_to_hex(oid), type_name(type), "blob");
> >
> > I'd love not having all these calls to `die()`, as this logic is
> > essentially part of a library, and dying inside a library is a bad
> > smell. We do this everywhere else in Git, too, but we're slowly getting
> > rid of this as part of our libification efforts.
> 
> I think this would be a bigger refactor in general --
> the existing connectivity check also dies as the way to
> report problems.  This works since it's running as a subprocess.
> 
> If this is something we want to change, I think it would be
> good to do that refactoring separately and make the connectivity
> check subprocess only die() at the very edge, and making all of
> the internal library code support not dying.  My first prototype
> tried to do this but the amount of changes to internal code got
> out of hand, so this version was the simplest I could make it.
> 
> But I'm happy to take a step back and revisit that approach if
> this is a blocker.

I mostly aim at not making _new_ library code die anymore. In any case,
I don't think it's a blocker, but I nowadays consider this to be a code
smell.

It would be great if we eventually deny-listed `die()` completely for
anything compiled into libgit.a.

Patrick
