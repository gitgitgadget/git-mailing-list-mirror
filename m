Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C9EC433F5
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 10:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A257610A7
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 10:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242732AbhIQKaP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 06:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242494AbhIQKaO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 06:30:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1268AC061574
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 03:28:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mRB6w-0000eA-R6; Fri, 17 Sep 2021 12:28:50 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mRB6v-0006sm-A5; Fri, 17 Sep 2021 12:28:49 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mRB6v-0005Sz-8h; Fri, 17 Sep 2021 12:28:49 +0200
Date:   Fri, 17 Sep 2021 12:28:49 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Git Users <git@vger.kernel.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        =?utf-8?B?QmrDtnJuIEzDpHNzaWc=?= <b.laessig@pengutronix.de>
Subject: Re: git repack -A -d doesn't remove objects found in alternates?
Message-ID: <20210917102849.h7vru7j7dseoilps@pengutronix.de>
References: <20210917085623.rjpmqqhb5xap26jd@pengutronix.de>
 <CAGyf7-E7PcRGiEd_U5bcw1na7H0LGDMw81s4SUDE=DH+4G3QYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="owa7f6pnie57ye5h"
Content-Disposition: inline
In-Reply-To: <CAGyf7-E7PcRGiEd_U5bcw1na7H0LGDMw81s4SUDE=DH+4G3QYA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--owa7f6pnie57ye5h
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 17, 2021 at 02:08:58AM -0700, Bryan Turner wrote:
> On Fri, Sep 17, 2021 at 1:56 AM Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > Hello,
> >
> > I wonder if I do something wrong, or if I just don't understand
> > something:
> >
> >         ukl@dude04:~/work$ git version
> >         git version 2.30.2
> >
> >         ukl@dude04:~/work$ git clone https://git.kernel.org/pub/scm/lin=
ux/kernel/git/torvalds/linux.git
> >         ...
> >         ukl@dude04:~/work$ cd linux/
> >         ukl@dude04:~/work/linux$ du -sh .git/objects
> >         2.6G    .git/objects
> >         ukl@dude04:~/work/linux$ echo "/ptx/work/user/git/linux.git/obj=
ects" > .git/objects/info/alternates
> >
> >         ukl@dude04:~/work/linux$ git repack -A -d
> >         ...
> >         ukl@dude04:~/work/linux$ du -sh .git/objects/
> >         2.6G    .git/objects/
> >
> > I would have expected a drastic size decrease from git repack after the
> > alternate is added.
>=20
> You're missing -l on your repack command. See git help pack-objects
> and look for --local. Without -l, repack includes copies of the
> objects you're borrowing, so your pack size doesn't change.
>=20
> Hope this helps!

It does. When adding -l the size reported by du goes down to 8K. Thanks
a lot.

While refering to other manpages is easy to maintain, it's hard to read
for a user.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--owa7f6pnie57ye5h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFEbd4ACgkQwfwUeK3K
7An1EAf+IWOsYXPbyxFhkHbhb+FdQGQKb1ufKvmhRO9KY300pWivnZQyyVZGGhjD
+EYwzb4Y5/iOQIHQOMuU2jbXrTvNTnwTTbfk6dU/rKv/gGgDchnwn4PwvC1uUWJ2
s3PZTylJJHJ/0JnxHOv8HiWeBTS5C/LArbN6NLk+Zsr2isMN3yUJH8HhcJHi/BLs
mXyHavndIRt461EyP3sMY1U9lRFDJ/OLb43HoBOvzO7q1CnJgD6L0NIkoPxhCKrk
1InVr2ElyqGUxevDCVNsuxXBxBIJKOqwYM+mZh/KLJaB1lHwkMCHSN+1TCx9eVNv
YV+kl534f/VnNnVQxhEfvHfOqg4Kbw==
=5WEo
-----END PGP SIGNATURE-----

--owa7f6pnie57ye5h--
