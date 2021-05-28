Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60959C4708C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 21:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27077613D1
	for <git@archiver.kernel.org>; Fri, 28 May 2021 21:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbhE1VmD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 17:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhE1VmC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 17:42:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C42C061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 14:40:27 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lmkDR-0004CK-B4; Fri, 28 May 2021 23:40:25 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lmkDQ-0002V4-MT; Fri, 28 May 2021 23:40:24 +0200
Date:   Fri, 28 May 2021 23:40:24 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, entwicklung@pengutronix.de
Subject: Re: time needed to rebase shortend by using --onto?
Message-ID: <20210528214024.vw4huojcklrm6d27@pengutronix.de>
References: <20210526100932.2hw4rbazgvd6mzff@pengutronix.de>
 <CABPp-BGBY9kwqRQ+soa8=W2F+=8eQRYS3vWS_7UCC0K0qNTW1g@mail.gmail.com>
 <20210527215947.g2mnds6zj5uv5mjq@pengutronix.de>
 <CABPp-BEVME5Gx=F4HWHBb_0wn6XJF==DzVLo2i1xj63BB+_jtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zp7uth5rv2diqnru"
Content-Disposition: inline
In-Reply-To: <CABPp-BEVME5Gx=F4HWHBb_0wn6XJF==DzVLo2i1xj63BB+_jtw@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--zp7uth5rv2diqnru
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Elijah,

On Thu, May 27, 2021 at 04:08:32PM -0700, Elijah Newren wrote:
> On Thu, May 27, 2021 at 2:59 PM Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Wed, May 26, 2021 at 07:38:08AM -0700, Elijah Newren wrote:
> > > On Wed, May 26, 2021 at 3:13 AM Uwe Kleine-K=F6nig
> > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > I have a kernel topic branch containing 4 patches on top of Linux v=
5.4.
> > > > (I didn't speak to the affected customer, so I cannot easily share =
the
> > > > patch stack. If need be I can probably anonymize it or ask if I can
> > > > publish the patches.)
> > > >
> > > > It rebases clean on v5.10:
> > > >
> > > >         $ time git rebase v5.10
> > > >         Performing inexact rename detection: 100% (36806539/3680653=
9), done.
> > > >         Performing inexact rename detection: 100% (36806539/3680653=
9), done.
> > > >         Performing inexact rename detection: 100% (36806539/3680653=
9), done.
> > > >         Performing inexact rename detection: 100% (36806539/3680653=
9), done.
> > > >         Successfully rebased and updated detached HEAD.
> > > >
> > > >         real    3m47.841s
> > > >         user    1m25.706s
> > > >         sys     0m11.181s
> > > >
> > > > If I start with the same rev checked out and explicitly specify the
> > > > merge base, the rebase process is considerably faster:
> > > >
> > > >         $ time git rebase --onto v5.10 v5.4
> > > >         Performing inexact rename detection: 100% (36806539/3680653=
9), done.
> > > >         Performing inexact rename detection: 100% (36806539/3680653=
9), done.
> > > >         Performing inexact rename detection: 100% (36806539/3680653=
9), done.
> > > >         Performing inexact rename detection: 100% (36806539/3680653=
9), done.
> > > >         Successfully rebased and updated detached HEAD.
> > > >
> > > >         real    1m20.588s
> > > >         user    1m12.645s
> > > >         sys     0m6.733s
>=20
> Note: In your original report you had rename detection and it clearly
> took a significant amount of time...

FTR: My impression is that the repo I used for the first report is slow
in general. Also git log sometimes takes a considerable time to start
emitting output.

> > > > Is there some relevant complexity in the first invocation I'm not s=
eeing
> > > > that explains it takes more than the double time? I would have expe=
cted
> > > > that
> > > >
> > > >         git rebase v5.10
> > > >
> > > > does the same as:
> > > >
> > > >         git rebase --onto v5.10 $(git merge-base HEAD v5.10)
> > > >
> > > > . (FTR:
> > > >
> > > >         $ time git merge-base HEAD v5.10
> > > >         219d54332a09e8d8741c1e1982f5eae56099de85
> > > >
> > > >         real    0m0.158s
> > > >         user    0m0.105s
> > > >         sys     0m0.052s
> > > >
> > > > , 219d5433 is v5.4 as expected.
> > >
> > > That does seem surprising, though if an automatic gc completed between
> > > the two commands that could certainly explain it.  If that theory is
> > > correct, it would suggest that it'd be difficult for you to reproduce;
> >
> > This reproduces just fine. The repository is quite big and it is slow at
> > times. With the same tree on a different machine, the rebase is quicker,
> > but the factor 2 between the two different commands is visible there,
> > too:
> >
> > uwe@taurus:~/gsrc/linux$ git checkout bc2e99c9c9e0d29494b1739624554e4f5=
f979d32
> > HEAD is now at bc2e99c9c9e0 [...]
> >
> > uwe@taurus:~/gsrc/linux$ time git rebase v5.10
> > warning: inexact rename detection was skipped due to too many files.
> > warning: you may want to set your merge.renamelimit variable to at leas=
t 8604 and retry the command.
> > warning: inexact rename detection was skipped due to too many files.
> > warning: you may want to set your merge.renamelimit variable to at leas=
t 8604 and retry the command.
> > warning: inexact rename detection was skipped due to too many files.
> > warning: you may want to set your merge.renamelimit variable to at leas=
t 8604 and retry the command.
> > warning: inexact rename detection was skipped due to too many files.
> > warning: you may want to set your merge.renamelimit variable to at leas=
t 8604 and retry the command.
> > Successfully rebased and updated detached HEAD.
> >
> > real    0m20.737s
> > user    0m14.188s
> > sys     0m3.767s
> >
> > uwe@taurus:~/gsrc/linux$ git checkout bc2e99c9c9e0d29494b1739624554e4f5=
f979d32
> > HEAD is now at bc2e99c9c9e0 [...]
> >
> > uwe@taurus:~/gsrc/linux$ time git rebase --onto v5.10 v5.4
> > warning: inexact rename detection was skipped due to too many files.
> > warning: you may want to set your merge.renamelimit variable to at leas=
t 8604 and retry the command.
> > warning: inexact rename detection was skipped due to too many files.
> > warning: you may want to set your merge.renamelimit variable to at leas=
t 8604 and retry the command.
> > warning: inexact rename detection was skipped due to too many files.
> > warning: you may want to set your merge.renamelimit variable to at leas=
t 8604 and retry the command.
> > warning: inexact rename detection was skipped due to too many files.
> > warning: you may want to set your merge.renamelimit variable to at leas=
t 8604 and retry the command.
> > Successfully rebased and updated detached HEAD.
> >
> > real    0m12.129s
> > user    0m7.196s
> > sys     0m3.141s
> >
> > (This is with a slightly newer git: 2.30.2-1 from Debian)
>=20
> And here, there was no rename detection so this isn't the same thing
> anymore.  You could try setting merge.renameLimit higher.

I learned a few things since my last mail, here comes an updated test
again on the machine and repo used for the initial report:

	ukl@dude.ptx:~/gsrc/linux$ wgit version
	git version 2.32.0.rc1

	ukl@dude.ptx:~/gsrc/linux$ cat rebasecheck=20
	#!/bin/bash

	set -e=20

	# do it once to heat the caches and ensure all objects are available alrea=
dy to have the next cycles identical.
	wgit checkout 0091ecb84cfdef0f4cb65810219f5ac9bb4341e5
	wgit rebase v5.10

	wgit checkout 0091ecb84cfdef0f4cb65810219f5ac9bb4341e5
	echo "rebase v5.10"
	time wgit rebase v5.10

	wgit checkout 0091ecb84cfdef0f4cb65810219f5ac9bb4341e5
	echo "rebase --onto v5.10 v5.4"
	time wgit rebase --onto v5.10 v5.4

I do the rebase now once before the timing for the reasons described in
the comment. The second identical command is quite a bit quicker. Also
now that the commands are scripted they are done in a smaller time frame
(which matters as the machine is used heavily among my colleagues and
me). I run the script a few times in a row, after all colleagues are in
their week-end:

	ukl@dude.ptx:~/gsrc/linux$ bash rebasecheck=20
	...
	rebase v5.10
	...
	real	1m13.579s
	user	1m2.919s
	sys	0m6.220s
	...
	rebase --onto v5.10 v5.4
	...
	real	1m2.852s
	user	0m53.780s
	sys	0m6.225s

	ukl@dude.ptx:~/gsrc/linux$ bash rebasecheck=20
	...
	rebase v5.10
	...
	real	1m10.816s
	user	1m3.344s
	sys	0m6.991s
	...
	rebase --onto v5.10 v5.4
	...
	real	0m59.695s
	user	0m53.510s
	sys	0m5.579s

	ukl@dude.ptx:~/gsrc/linux$ bash rebasecheck=20
	...
	rebase v5.10
	...
	real	1m9.688s
	user	1m3.346s
	sys	0m6.105s
	...
	rebase --onto v5.10 v5.4
	...
	real	0m59.981s
	user	0m52.931s
	sys	0m6.282s

So it's not a factor 2 any more, but still reproducibly quicker when
--onto is used.

> However, the 7-8 second difference (and the likely large differences
> between 5.4 and 5.10) do suggest that Junio's hunch that fork-point
> behavior being at play could be an issue in these two commands.
>=20
> > Then I repeated the test with git 2.32.0-rc1 (wgit is just calling
> > bin-wrappers/git in my git working copy):
> >
> > uwe@taurus:~/gsrc/linux$ wgit version
> > git version 2.32.0.rc1
> >
> > uwe@taurus:~/gsrc/linux$ wgit checkout bc2e99c9c9e0d29494b1739624554e4f=
5f979d32
> > HEAD is now at bc2e99c9c9e0 [...]
> >
> > uwe@taurus:~/gsrc/linux$ time wgit rebase v5.10
> > warning: inexact rename detection was skipped due to too many files.
> > warning: you may want to set your merge.renamelimit variable to at leas=
t 8024 and retry the command.
> > warning: inexact rename detection was skipped due to too many files.
> > warning: you may want to set your merge.renamelimit variable to at leas=
t 8024 and retry the command.
> > warning: inexact rename detection was skipped due to too many files.
> > warning: you may want to set your merge.renamelimit variable to at leas=
t 8024 and retry the command.
> > warning: inexact rename detection was skipped due to too many files.
> > warning: you may want to set your merge.renamelimit variable to at leas=
t 8024 and retry the command.
> > Successfully rebased and updated detached HEAD.
> >
> > real    0m19.438s
> > user    0m13.629s
> > sys     0m3.299s
> >
> > uwe@taurus:~/gsrc/linux$ wgit checkout bc2e99c9c9e0d29494b1739624554e4f=
5f979d32
> > HEAD is now at bc2e99c9c9e0 [...]
> >
> > uwe@taurus:~/gsrc/linux$ time wgit rebase --onto v5.10 v5.4
> > warning: inexact rename detection was skipped due to too many files.
> > warning: you may want to set your merge.renamelimit variable to at leas=
t 8024 and retry the command.
> > warning: inexact rename detection was skipped due to too many files.
> > warning: you may want to set your merge.renamelimit variable to at leas=
t 8024 and retry the command.
> > warning: inexact rename detection was skipped due to too many files.
> > warning: you may want to set your merge.renamelimit variable to at leas=
t 8024 and retry the command.
> > warning: inexact rename detection was skipped due to too many files.
> > warning: you may want to set your merge.renamelimit variable to at leas=
t 8024 and retry the command.
> > Successfully rebased and updated detached HEAD.
> >
> > real    0m13.848s
> > user    0m8.315s
> > sys     0m3.182s
> >
> > So the surprise persists.
>=20
> Yeah, with no rename detection, the newer git version isn't going to
> make a bit of difference.
>=20
> > > running again with either command would give you something closer to
> > > the lower time both times.  Is that the case?  (Also, what's the
> > > output of "git count-objects -v"?)
> >
> > After the above commands I have:
> >
> >         count: 3203
> >         size: 17664
> >         in-pack: 4763753
> >         packs: 11
> >         size-pack: 1273957
> >         prune-packable: 19
> >         garbage: 0
> >         size-garbage: 0
>=20
> So, not freshly packed, but not in need of an automatic gc either.
>=20
> >         alternate: /home/uwe/var/gitstore/linux.git/objects
>=20
> You've got an alternate?  How well packed is it?  (What does "git
> count-objects -v" in that other repo show?)
>=20
> >
> > (On the repository I did this initially I have:
> >
> >         warning: garbage found: .git/objects/pack/pack-864148a84c052407=
3ed8c8aa1a76155d5c677879.pack.temp
> >         warning: garbage found: /ptx/src/git/linux.git/objects/pack/tmp=
_pack_X9gHnq
> >         count: 2652
> >         size: 14640
> >         in-pack: 2117015
> >         packs: 8
> >         size-pack: 574167
> >         prune-packable: 856
> >         garbage: 2
> >         size-garbage: 1114236
> >         alternate: /ptx/src/git/linux.git/objects

In the alternate I have:

	ukl@dude.ptx:/ptx/src/git/linux.git/objects$ wgit count-objects -v
	warning: garbage found: /ptx/work/user/git/linux.git/objects/pack/tmp_pack=
_X9gHnq
	count: 5035
	size: 40720
	in-pack: 87083076
	packs: 1108
	size-pack: 51109693
	prune-packable: 3050
	garbage: 1
	size-garbage: 1112612

The alternate tracks

	git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
	git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
	git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

(only the tags for the two latter).

> > (Is the garbage a reason this is so slow? Can I just remove the two
> > files pointed out?)
>=20
> If there isn't some still-running git operation that is fetching and
> writing to these files, then yes they can be cleaned out.  I doubt
> they'd make too much of a difference, though.  I was more curious if
> you went from say 10000 loose objects to ~0, or from 50+ packs down to
> 1 between operations due to an automatic gc completing.
>=20
> > > I'd love to try this with git-2.32.0-rc1 (or even my not-yet-upstream
> > > patches that optimize even further) with adding "--strategy=3Dort" to
> > > your rebase command to see how much of a timing difference it makes.
> > > Any chance the patches could either be published, or you could retry
> > > with git-2.32.0-rc1 and add the --strategy=3Dort command line option =
to
> > > your rebase command(s)?
> >
> > With --strategy=3Dort added I have:
> >
> > uwe@taurus:~/gsrc/linux$ time wgit rebase --strategy=3Dort v5.10
> > Successfully rebased and updated detached HEAD.
> >
> > real    0m19.202s
> > user    0m12.724s
> > sys     0m2.961s
> >
> > [...]
> >
> > uwe@taurus:~/gsrc/linux$ time wgit rebase --strategy=3Dort --onto v5.10=
 v5.4
> > Successfully rebased and updated detached HEAD.
> >
> > real    0m12.395s
> > user    0m6.638s
> > sys     0m3.284s
> >
> > So the warnings about inexact rename detection don't appear and it's a
> > bit faster, but I still see the timing difference between these two
> > commands.
>=20
> Right, this says that --strategy=3Dort WITH rename detection is as fast
> as the default --strategy=3Drecursive WITHOUT rename detection.

I rerun the script with -sort added:

	ukl@dude.ptx:~/gsrc/linux$ bash rebasecheck
	...
	rebase v5.10
	...
	real	0m25.047s
	user	0m17.652s
	sys	0m5.802s
	...
	rebase --onto v5.10 v5.4
	...
	real	0m12.471s
	user	0m7.854s
	sys	0m4.413s

	ukl@dude.ptx:~/gsrc/linux$ bash rebasecheck
	...
	rebase v5.10
	...
	real	0m22.180s
	user	0m17.219s
	sys	0m4.701s
	...
	rebase --onto v5.10 v5.4
	...
	real	0m12.341s
	user	0m7.308s
	sys	0m4.632s

So -sort is quite a bit quicker, but the ~10s overhead when not using
--onto is visible there, too.
 =20
When looking at the timing of the output, the 10s time difference occur
before "Rebasing (1/4)" is emitted.

	wgit rebase -sort --onto v5.10 v5.10

behaves like

	wgit rebase -sort v5.10

and if I only rebase the first two patches (instead of four) it still
takes nearly the same time. Another test I did was:

	time wgit rebase -sort --onto v5.10 v5.7

	real	0m17.712s
	user	0m11.570s
	sys	0m5.396s

So there seems to be something before the actual rebase is done that
takes longer when HEAD..$base contains more objects.
Given that

	ukl@dude.ptx:~/gsrc/linux$ time wgit log --oneline --cherry v5.10...0091ec=
b84cfdef0f4cb65810219f5ac9bb4341e5
	+ 0091ecb84cfd (ptx/ukl/rebase-timing) nvmem: core: skip child nodes not m=
atching binding
	+ 38af1d38c542 spidev: add "hxxxxxxx,xxxxxx" compatible
	+ a7edcfb6a968 regmap: fix memory leak in regmap_debugfs_init()
	+ b1d90bc89408 pci: add quirk for txxxxx FPGA watchdog

	real	0m10.783s
	user	0m10.346s
	sys	0m0.436s

I guess this range is searched for commits that have the same patch id
as the patches to rebase?

> It's not a fair comparison (you'd need to set merge.renameLimit higher
> and re-run the cases where you had warnings), but is interesting
> nonetheless.  It basically suggests that rename detection comes for
> free with the ort strategy.

FTR: In the above repo I have:

	ukl@dude.ptx:~/gsrc/linux$ wgit config merge.renameLimit
	10000

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zp7uth5rv2diqnru
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCxY0QACgkQwfwUeK3K
7An+XQf/U9VvRs70ZCPlaQDWg36BFZJDmMN07S42BF69c+WbaHUhe6EHZEzSo9iI
VizxfE024cX06NEJM/A+cYJwSYwDFg5uPnVaeOi3aWzEyhCVtQTlfTxI6k7l15xP
e3zGkuNW0gYYQuww2nDzr/YUxGNyykHF8hYEgR7TbthVFpq1GROwDAQEn5iVVoUw
l93pGOdli8in6+nv4oNk7Rk6WSFiR+ymsGGj7KPqQ9NgpQzwI6mXQrhihf/ewzbq
4Xw5/lXsoTbEyrQPTPw4Qe7VNF3GiJGBmF1omKklPsbDfMS6N8+n/fmtAP4EY724
1Jp141UmPnKfxAb9KDyBgSYvXpTPnw==
=I/uN
-----END PGP SIGNATURE-----

--zp7uth5rv2diqnru--
