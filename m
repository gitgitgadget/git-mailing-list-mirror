Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 404D5201B0
	for <e@80x24.org>; Sat, 25 Feb 2017 19:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751916AbdBYTMd (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 14:12:33 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:40944 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751885AbdBYTMc (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Feb 2017 14:12:32 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:f8da:200e:3546:3090])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 33226280AF;
        Sat, 25 Feb 2017 19:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1488049454;
        bh=eqgl8XjYQ5h1dQADZtPbiJRNTWPynjrS67nGkGB1tp0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fb+TD6yCDkxBmT3JrlonTW86dgAHyj8eTHCC2eLxoE1rJRktXhYVc7uG8ctDW9mx0
         GoaqAY0YJQz6rnXYzIGJkgd2elvYoWUe1A2zl6nZQ7Nd7kAsxUwP/gwiAiOOoDi96g
         lpAlO6pd6kKrU+pWq6z/hKHrcLX00KB6esjUUFQFHTdirkZsgbeosCF0FQ94mqPy+Y
         ANEd9fiAPcPWViyXH9yt1kRxOaYMp3mfEf8Y1ze+xscQH6fLOYBIZOuDInlbDzs5y0
         8b1Fl/SGcyCY5F6wLEVRP6srfJPAPAkaOgIOPi9hSQxlJCKLCUkWv7E2ap8Gg7FRHO
         5DJhGGWDBDBmkwYJLNl5Cgjm8fSMLtKFeWIqazodddZBVoJ8dHiUGDQjLPlngexUwb
         DMoRfP7OOSmG2AAUI/yc9X87sIGTq4UPClcERcp9PuT/rTFcmiprLJQY2yp15NZdPl
         DhSrR041ICkmaw8hfP6y+y5z1OGVvtI3M4xtltzG+55KOs8dGbH
Date:   Sat, 25 Feb 2017 19:04:10 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Joey Hess <id@joeyh.name>, Git Mailing List <git@vger.kernel.org>
Subject: Re: SHA1 collisions found
Message-ID: <20170225190410.anvb7ll7tlhwgm3t@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Duy Nguyen <pclouds@gmail.com>, Joey Hess <id@joeyh.name>,
        Git Mailing List <git@vger.kernel.org>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
 <CACsJy8AtQG8YXQ+YfSFifUxqtd==THj5weJK5jooyiRN0yamiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ea74hchs53s7rmne"
Content-Disposition: inline
In-Reply-To: <CACsJy8AtQG8YXQ+YfSFifUxqtd==THj5weJK5jooyiRN0yamiQ@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ea74hchs53s7rmne
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 24, 2017 at 04:42:38PM +0700, Duy Nguyen wrote:
> On Thu, Feb 23, 2017 at 11:43 PM, Joey Hess <id@joeyh.name> wrote:
> > IIRC someone has been working on parameterizing git's SHA1 assumptions
> > so a repository could eventually use a more secure hash. How far has
> > that gotten? There are still many "40" constants in git.git HEAD.
>=20
> Michael asked Brian (that "someone") the other day and he replied [1]
>=20
> >> I'm curious; what fraction of the overall convert-to-object_id campaign
> >> do you estimate is done so far? Are you getting close to the promised
> >> land yet?
> >
> > So I think that the current scope left is best estimated by the
> > following command:
> >
> >   git grep -P 'unsigned char\s+(\*|.*20)' | grep -v '^Documentation'
> >
> > So there are approximately 1200 call sites left, which is quite a bit of
> > work.  I estimate between the work I've done and other people's
> > refactoring work (such as the refs backend refactor), we're about 40%
> > done.

As a note, I've been working on this pretty much nonstop since the
collision announcement was made.  After another 27 commits, I've got it
down from 1244 to 1119.

I plan to send another series out sometime after the existing series has
hit next.  People who are interested can follow the object-id-part*
branches at https://github.com/bk2204/git.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--ea74hchs53s7rmne
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlix1SoACgkQv1NdgR9S
9otr+Q//eclE7cfAu816YliCf7dbqh6K0ae1s0ZjwzHs4ewlDvkwE9x6YRH0k0B/
rWBpJNG2imXqGww7ONQjqwVayQCOWtgsRfJSEDYg7owCKv4Dm4DZziEV75JwUX47
37vB+l3lEEPM4vBb+qkGfUkK0SyD6nUQO0IUEeYLK81Q1bqCs/Hu521wN0eua6yN
gxdd9Qq5eFruYrM+iiwAUOcqtZvsDKrtcIYysVYPUJvcbgDbZuW0RPOa6jU6SKzq
+g21aG4gNbEtzPNdq7TlQdLZzLKgoc7D6oHEsYx22bC/yCZCNg3N7/P9oOEGsaBA
QpvOCHmnQtSq6eX6oG4O3+Lq4/agkXL2zugrJT7hUfyIUcjgTC3jxtlT+z8NzQ/U
TfgjUYFmr3Jz/Wxu4YsPHuK8OLVkX+xEabAE6l21Ff28Ra9KgJBoU0Z0cpUEWj54
IHay/3mpieXFHnBo810n50Gdp84saIRxT779COgIeN3EU1b7JvuWXQoVUtW2xivk
FtS0OOelSMUO+9yHMXBd8pMdKjLr/bzMmLDmJ87CB3EAMX3O1l1TEQVC59L2L+sJ
9mOZhD0PKH65TwZdbWIP9zPQgy7UWjYBNHNmfQbswAQr8flN/KPzNmLC/mYm9/7W
9g6fFqPwHOg63vNoTAzJ26vLEnVGBxipNeolniHoqq73MRuwQs8=
=KjHD
-----END PGP SIGNATURE-----

--ea74hchs53s7rmne--
