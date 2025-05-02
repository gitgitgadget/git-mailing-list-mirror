Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04531C9DE5
	for <git@vger.kernel.org>; Fri,  2 May 2025 09:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746179090; cv=none; b=q9rxLeN8aFsJJ727lXkK4Fil0tcyDf8DgPlZaQxC+0zcO7Gv8gFdvwu/4lMd5cLbcB9dP26j+p9oncr2zLV/5OV8rO+wemM8GPexZ3Q11JLL8BBgMEhBUm4fzIBHHaxKvUUKUN+PWTeUWul/QOfJNdy20piuLAUzkuc6O1m0tE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746179090; c=relaxed/simple;
	bh=qV1w3tfgTjXtCyfJwKeiX3iY3lPDqbW9aTQZz8lNuaM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=P9zqW/rzdA+91+Xx2ziZlqFGYkTDEuIkK7e/jySbPPdpTMQNlMA+KHBJpihWqo7SkleZ2nYhJ4VSlO5my2MHzQdL6H2mzl3pwW3sgvruwQQtmCc52IuU746M/QCkPiy4hWBob14b5SLmwkFkePeA8zgunsblr2vYARPLaWgzSbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=DI4FgjyO; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="DI4FgjyO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1746179077; x=1746783877;
	i=johannes.schindelin@gmx.de;
	bh=ktnN4mFo+WdFrZjbtNYRi7RRqt31SwCE13eUyLnmN8M=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DI4FgjyOmtF22VuizAA78S/w+D5KCp4gh2WjXJRqtk5z4jp98wZGWJW1t3B2ekE8
	 0+gcdiGa9fC5aFKHes3A2L3lIjlogYQe1pZKBOH3ERl9epVlnlv7e7EABWMFGkR6p
	 oa/fePYRInqFPwgbJsCeaBfRC50kkN+Q1njyhAfVMYr1Y5sK2I22FtjKYLfPPmfWQ
	 ErRwZgt5XiN4NRMHvWEiGqB6IZ2vQPmrsvo7UTNJUfWELsm5tpfmx1Hw2qQyOZYZi
	 shi2WQhDYZ1wPoYfdWhDcHJNb0j+t5Ea/yOXH46KGyE+77sOZb0ZEGWEO9s9Dxb8L
	 5qJz8wIDBzJpNaBZRw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.212.47]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6sit-1v7rnG1hcd-00x92T; Fri, 02
 May 2025 11:44:37 +0200
Date: Fri, 2 May 2025 11:44:36 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
    Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH 2/2] builtin/mv: convert assert(3p) into `BUG()`
In-Reply-To: <aBR86Ct8mMUN_tzk@pks.im>
Message-ID: <38cc3249-3de2-5ed0-7ca8-bad6d4a5bea8@gmx.de>
References: <20250430-pks-mv-parent-child-conflict-v1-0-11a87c55ffb9@pks.im> <20250430-pks-mv-parent-child-conflict-v1-2-11a87c55ffb9@pks.im> <xmqqr0191oaz.fsf@gitster.g> <xmqqecx9z1n6.fsf@gitster.g> <aBR86Ct8mMUN_tzk@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Ai0drQ1Lo86hi7eYZ7tBSPrp53887kzRmtuQs0vBWELtM/x3Zww
 sYQnVbfqSJ43Sh+RBUdS4V2znFC3LDPNZOQNlsJKS+sn1CxAnYzjB+wUjqxsy4Wqtbmqlg+
 OfYzQOd3CzGwABumJD/KD0LcSwHYsVPjj21ki1Tz55Ns2aISVrtlHadRx9NULlSuAuC1ZnH
 51lG1hbaUQ1W3M4/3C36A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hBN4ISh4ngw=;RVBuE60U/BOGoX+T2F8Nnx9N0OT
 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
 hJNJyQEWe8UOU=
Content-Transfer-Encoding: quoted-printable

Hi Patrick & Junio,

On Fri, 2 May 2025, Patrick Steinhardt wrote:

> On Wed, Apr 30, 2025 at 04:10:37PM -0700, Junio C Hamano wrote:
> > Junio C Hamano <gitster@pobox.com> writes:
> >=20
> > > Patrick Steinhardt <ps@pks.im> writes:
> > >
> > >> The use of asserts is discouraged in our codebase because they lead=
 to
> > >> different behaviour depending on how Git is built. When being unsur=
e
> > >> enough whether a condition always holds so that one adds the assert=
,
> > >> then the assert should probably trigger regardless of how Git is be=
ing
> > >> built.
> > >
> > > Nicely put.  Yes, this is another reason why we frown on the use of
> > > assert(), in addition to the reason why why Elijah's series that
> > > ends with 5633aa3a (treewide: replace assert() with ASSERT() in
> > > special cases, 2025-03-19) was written.
> > >
> > >> Drop the call to assert(3p) in git-mv(1) and instead use `BUG()`.
> > >
> > > Being explicit about what we are unsure about is always good.  It
> > > would hopefully entice those who want to get their hands dirty to
> > > see if they can "prove" that BUG() would never happen, which would
> > > be a great outcome ;-).
> >=20
> > By the way, with this in place, and without Dscho's "assert() makes
> > Win+Meson test job get stuck, so let's make assert() a no-op" patch,
> > the CI seems to be fine.
> >=20
> >     https://github.com/git/git/actions/runs/14765572702
> >=20
> > Triggering assert() and BUG() are something we would always want to
> > notice.  They should never trigger in production and it is an event
> > to call for fixing the underlying cause that made the condition
> > trigger if it is shown to end-users.  Dscho's patch protects us from
> > addition of a new test that triggers an assert().  We won't see such
> > a test get stuck forever on Windows, but by turning such an assert()
> > into a no-op, we would waste electricity for running CI only to miss
> > the triggering assert(), which does not sound like a good use of our
> > resources.
>=20
> It makes me wonder whether we should forbid `assert()` altogether and
> use `BUG()` everywhere, similar to the recent discussion with Elijah. We
> do have >600 callsites of `assert()` though, so we would have to
> introduce a macro that doesn't require us to provide a reasoning for
> now. E.g.
>=20
>     #define BUG_UNLESS(condition) if (!(condition)) BUG(##condition)
>=20
> or something like this.
>=20
> And once we've done such a conversion we could add `assert()` to our
> deny list of functions (wherever it was, I forgot).
>=20
> > So I am inclined to drop Dscho's "build in release mode" patch when
> > we merge this series down to 'next'.  Being able to notice a
> > breakage (which triggers a real assert(), whether it is due to
> > broken code, or due to a broken test that documents a broken code
> > path---which should be rewritten to use "if (condition) BUG()"),
> > even if it needs to be done by noticing a test that gets stuck,
> > would be much better than missing such a breakage at all, and that
> > is the primary reasoning behind my suggesting to do so.  I would not
> > be surprised if I am missing a good reason or two to make build
> > tested in CI ignore asserts, so let's hear from others.
> >=20
> > Opinions?
>=20
> As far as I understand there is no need for this patch anymore.

I see a need for this patch, still, and it is not a mere "opinion".

The fact of the matter is that the Visual C-built CI (first the Azure
Pipeline, then GitHub Actions) have built the artifacts in release mode
since forever. And the Meson addition simply made a mistake by _not
specifying_ release mode (and hence defaulting to debug mode).

This makes a difference because in `compat/mingw.c`, there is this
(https://github.com/git/git/blob/v2.49.0/compat/mingw.c#L3247-L3255):

	#ifdef _MSC_VER
	#ifdef _DEBUG
		_CrtSetReportMode(_CRT_ASSERT, _CRTDBG_MODE_DEBUG);
	#endif
	[...]
	#endif

This means that each and every `assert()`, whether that be in Git's source
code, or in any dependency of Git (which the Git project does not
control!), is handled with this modal dialog.

It was an oversight in the win+Meson patches not to use release mode, and
the patch I proposed fixes this bug.

In the alternative, you could also just drop the entire win+Meson stuff,
of which I would be actually quite in favor: No Visual Studio user will be
happy with Meson, therefore it would be the kind thing to drop all
pretense, officially, that Git cares about Visual Studio users.

The easier and quicker solution, though, (which would maintain a modicum
of Visual Studio support) would be to un-drop the fix proposed in
https://lore.kernel.org/git/pull.1908.git.1745593515875.gitgitgadget@gmail=
.com/

Ciao,
Johannes
