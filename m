Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06C8C47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 21:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D387613D1
	for <git@archiver.kernel.org>; Thu, 27 May 2021 21:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbhE0WB1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 18:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbhE0WB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 18:01:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A2CC061574
        for <git@vger.kernel.org>; Thu, 27 May 2021 14:59:52 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lmO2e-0000hS-EY; Thu, 27 May 2021 23:59:48 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lmO2e-0007dA-5B; Thu, 27 May 2021 23:59:48 +0200
Date:   Thu, 27 May 2021 23:59:47 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, entwicklung@pengutronix.de
Subject: Re: time needed to rebase shortend by using --onto?
Message-ID: <20210527215947.g2mnds6zj5uv5mjq@pengutronix.de>
References: <20210526100932.2hw4rbazgvd6mzff@pengutronix.de>
 <CABPp-BGBY9kwqRQ+soa8=W2F+=8eQRYS3vWS_7UCC0K0qNTW1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tq2eeo4n4jljzdmu"
Content-Disposition: inline
In-Reply-To: <CABPp-BGBY9kwqRQ+soa8=W2F+=8eQRYS3vWS_7UCC0K0qNTW1g@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--tq2eeo4n4jljzdmu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, May 26, 2021 at 07:38:08AM -0700, Elijah Newren wrote:
> On Wed, May 26, 2021 at 3:13 AM Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > I have a kernel topic branch containing 4 patches on top of Linux v5.4.
> > (I didn't speak to the affected customer, so I cannot easily share the
> > patch stack. If need be I can probably anonymize it or ask if I can
> > publish the patches.)
> >
> > It rebases clean on v5.10:
> >
> >         $ time git rebase v5.10
> >         Performing inexact rename detection: 100% (36806539/36806539), =
done.
> >         Performing inexact rename detection: 100% (36806539/36806539), =
done.
> >         Performing inexact rename detection: 100% (36806539/36806539), =
done.
> >         Performing inexact rename detection: 100% (36806539/36806539), =
done.
> >         Successfully rebased and updated detached HEAD.
> >
> >         real    3m47.841s
> >         user    1m25.706s
> >         sys     0m11.181s
> >
> > If I start with the same rev checked out and explicitly specify the
> > merge base, the rebase process is considerably faster:
> >
> >         $ time git rebase --onto v5.10 v5.4
> >         Performing inexact rename detection: 100% (36806539/36806539), =
done.
> >         Performing inexact rename detection: 100% (36806539/36806539), =
done.
> >         Performing inexact rename detection: 100% (36806539/36806539), =
done.
> >         Performing inexact rename detection: 100% (36806539/36806539), =
done.
> >         Successfully rebased and updated detached HEAD.
> >
> >         real    1m20.588s
> >         user    1m12.645s
> >         sys     0m6.733s
> >
> > Is there some relevant complexity in the first invocation I'm not seeing
> > that explains it takes more than the double time? I would have expected
> > that
> >
> >         git rebase v5.10
> >
> > does the same as:
> >
> >         git rebase --onto v5.10 $(git merge-base HEAD v5.10)
> >
> > . (FTR:
> >
> >         $ time git merge-base HEAD v5.10
> >         219d54332a09e8d8741c1e1982f5eae56099de85
> >
> >         real    0m0.158s
> >         user    0m0.105s
> >         sys     0m0.052s
> >
> > , 219d5433 is v5.4 as expected.
>=20
> That does seem surprising, though if an automatic gc completed between
> the two commands that could certainly explain it.  If that theory is
> correct, it would suggest that it'd be difficult for you to reproduce;

This reproduces just fine. The repository is quite big and it is slow at
times. With the same tree on a different machine, the rebase is quicker,
but the factor 2 between the two different commands is visible there,
too:

uwe@taurus:~/gsrc/linux$ git checkout bc2e99c9c9e0d29494b1739624554e4f5f979=
d32
HEAD is now at bc2e99c9c9e0 [...]

uwe@taurus:~/gsrc/linux$ time git rebase v5.10
warning: inexact rename detection was skipped due to too many files.
warning: you may want to set your merge.renamelimit variable to at least 86=
04 and retry the command.
warning: inexact rename detection was skipped due to too many files.
warning: you may want to set your merge.renamelimit variable to at least 86=
04 and retry the command.
warning: inexact rename detection was skipped due to too many files.
warning: you may want to set your merge.renamelimit variable to at least 86=
04 and retry the command.
warning: inexact rename detection was skipped due to too many files.
warning: you may want to set your merge.renamelimit variable to at least 86=
04 and retry the command.
Successfully rebased and updated detached HEAD.

real	0m20.737s
user	0m14.188s
sys	0m3.767s

uwe@taurus:~/gsrc/linux$ git checkout bc2e99c9c9e0d29494b1739624554e4f5f979=
d32
HEAD is now at bc2e99c9c9e0 [...]

uwe@taurus:~/gsrc/linux$ time git rebase --onto v5.10 v5.4
warning: inexact rename detection was skipped due to too many files.
warning: you may want to set your merge.renamelimit variable to at least 86=
04 and retry the command.
warning: inexact rename detection was skipped due to too many files.
warning: you may want to set your merge.renamelimit variable to at least 86=
04 and retry the command.
warning: inexact rename detection was skipped due to too many files.
warning: you may want to set your merge.renamelimit variable to at least 86=
04 and retry the command.
warning: inexact rename detection was skipped due to too many files.
warning: you may want to set your merge.renamelimit variable to at least 86=
04 and retry the command.
Successfully rebased and updated detached HEAD.

real	0m12.129s
user	0m7.196s
sys	0m3.141s

(This is with a slightly newer git: 2.30.2-1 from Debian)

Then I repeated the test with git 2.32.0-rc1 (wgit is just calling
bin-wrappers/git in my git working copy):

uwe@taurus:~/gsrc/linux$ wgit version
git version 2.32.0.rc1

uwe@taurus:~/gsrc/linux$ wgit checkout bc2e99c9c9e0d29494b1739624554e4f5f97=
9d32
HEAD is now at bc2e99c9c9e0 [...]

uwe@taurus:~/gsrc/linux$ time wgit rebase v5.10
warning: inexact rename detection was skipped due to too many files.
warning: you may want to set your merge.renamelimit variable to at least 80=
24 and retry the command.
warning: inexact rename detection was skipped due to too many files.
warning: you may want to set your merge.renamelimit variable to at least 80=
24 and retry the command.
warning: inexact rename detection was skipped due to too many files.
warning: you may want to set your merge.renamelimit variable to at least 80=
24 and retry the command.
warning: inexact rename detection was skipped due to too many files.
warning: you may want to set your merge.renamelimit variable to at least 80=
24 and retry the command.
Successfully rebased and updated detached HEAD.

real	0m19.438s
user	0m13.629s
sys	0m3.299s

uwe@taurus:~/gsrc/linux$ wgit checkout bc2e99c9c9e0d29494b1739624554e4f5f97=
9d32
HEAD is now at bc2e99c9c9e0 [...]

uwe@taurus:~/gsrc/linux$ time wgit rebase --onto v5.10 v5.4
warning: inexact rename detection was skipped due to too many files.
warning: you may want to set your merge.renamelimit variable to at least 80=
24 and retry the command.
warning: inexact rename detection was skipped due to too many files.
warning: you may want to set your merge.renamelimit variable to at least 80=
24 and retry the command.
warning: inexact rename detection was skipped due to too many files.
warning: you may want to set your merge.renamelimit variable to at least 80=
24 and retry the command.
warning: inexact rename detection was skipped due to too many files.
warning: you may want to set your merge.renamelimit variable to at least 80=
24 and retry the command.
Successfully rebased and updated detached HEAD.

real	0m13.848s
user	0m8.315s
sys	0m3.182s

So the surprise persists.

> running again with either command would give you something closer to
> the lower time both times.  Is that the case?  (Also, what's the
> output of "git count-objects -v"?)

After the above commands I have:

	count: 3203
	size: 17664
	in-pack: 4763753
	packs: 11
	size-pack: 1273957
	prune-packable: 19
	garbage: 0
	size-garbage: 0
	alternate: /home/uwe/var/gitstore/linux.git/objects

(On the repository I did this initially I have:

	warning: garbage found: .git/objects/pack/pack-864148a84c0524073ed8c8aa1a7=
6155d5c677879.pack.temp
	warning: garbage found: /ptx/src/git/linux.git/objects/pack/tmp_pack_X9gHnq
	count: 2652
	size: 14640
	in-pack: 2117015
	packs: 8
	size-pack: 574167
	prune-packable: 856
	garbage: 2
	size-garbage: 1114236
	alternate: /ptx/src/git/linux.git/objects

(Is the garbage a reason this is so slow? Can I just remove the two
files pointed out?)

> I'd love to try this with git-2.32.0-rc1 (or even my not-yet-upstream
> patches that optimize even further) with adding "--strategy=3Dort" to
> your rebase command to see how much of a timing difference it makes.
> Any chance the patches could either be published, or you could retry
> with git-2.32.0-rc1 and add the --strategy=3Dort command line option to
> your rebase command(s)?

With --strategy=3Dort added I have:

uwe@taurus:~/gsrc/linux$ time wgit rebase --strategy=3Dort v5.10
Successfully rebased and updated detached HEAD.

real	0m19.202s
user	0m12.724s
sys	0m2.961s

[...]

uwe@taurus:~/gsrc/linux$ time wgit rebase --strategy=3Dort --onto v5.10 v5.4
Successfully rebased and updated detached HEAD.

real	0m12.395s
user	0m6.638s
sys	0m3.284s

So the warnings about inexact rename detection don't appear and it's a
bit faster, but I still see the timing difference between these two
commands.

I assume you are still interested in seeing this branch? I think
anonymising it shouldn't be so hard, the patches are not so big. I'll
modify the branch to make it shareable and assuming the problem still
reproduces with it will share it with you.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--tq2eeo4n4jljzdmu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCwFlAACgkQwfwUeK3K
7AnkUAf/eZyIeGi4dOrCPuANaTP0p5c/RiH4iYZIRmerk3WQvYsa+nJ4+qaVCNaX
ZOwAW/CxOElYsTJLgFrar3Mkwrf5nuepI0eNpZuBBkD7UkKU7D04sOV2FJoIdnGB
g8EijJs9cF3D8pWQb/fOGLng0Jx1sQkbYB4oGU6sNLZAqoSRYh0qTUTya4yZ/7xa
XKbn9klrkniUrqq2LWLjO98PBVdpx1DR01xK8+9yY1hSQloQzX3hEUuncmFGIqbX
LzHe8XHFQc8emrB+nDUYXLR30KVu1LlyoFf00qqEVGoohOJfgdHFG0AP9oJyr91w
P0Btz4ZX933EHaZmU/KUOerAQ4Pbwg==
=0w9+
-----END PGP SIGNATURE-----

--tq2eeo4n4jljzdmu--
