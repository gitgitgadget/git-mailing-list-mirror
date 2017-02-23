Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D54F2022D
	for <e@80x24.org>; Thu, 23 Feb 2017 20:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751297AbdBWUsS (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 15:48:18 -0500
Received: from sunbase.org ([178.79.142.16]:58298 "EHLO sunbase.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751228AbdBWUsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 15:48:16 -0500
Received: from sunny by sunbase.org with local (Exim 4.84_2)
        (envelope-from <sunny@sunbase.org>)
        id 1ch0Ie-0003rE-Ro; Thu, 23 Feb 2017 20:47:40 +0000
Date:   Thu, 23 Feb 2017 21:47:40 +0100
From:   =?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jeff King <peff@peff.net>, Joey Hess <id@joeyh.name>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: SHA1 collisions found
Message-ID: <20170223204739.f6aqri3l2fydxe2b@sunbase.org>
Mail-Followup-To: =?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jeff King <peff@peff.net>, Joey Hess <id@joeyh.name>,
        Git Mailing List <git@vger.kernel.org>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
 <CAPc5daVZ79WWKSw76kxHgDra9a7fSR1AibZa_pvK9aUuuVawLQ@mail.gmail.com>
 <20170223173547.qljypk7sdqi37oha@kitenet.net>
 <CA+55aFzFEpi1crykZ33r9f7BsvLt_kiB-CHXOkuCAX=fd4BU-w@mail.gmail.com>
 <20170223182147.hbsyxsmyijgkqu75@kitenet.net>
 <CA+55aFxckeEW1ePcebrgG4iN4Lp62A2vU6tA=xnSDC_BnKQiCQ@mail.gmail.com>
 <20170223184637.xr74k42vc6y2pmse@sigill.intra.peff.net>
 <CA+55aFx=0EVfSG2iEKKa78g3hFN_yZ+L_FRm4R749nNAmTGO9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="os2ytfitvwy7hsm4"
Content-Disposition: inline
In-Reply-To: <CA+55aFx=0EVfSG2iEKKa78g3hFN_yZ+L_FRm4R749nNAmTGO9w@mail.gmail.com>
OpenPGP: id=94A506E5; url=http://www.sunbase.org/pubkey.asc
X-Request-PGP: http://www.sunbase.org/pubkey.asc
User-Agent: NeoMutt/20170206-255-40b62d (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--os2ytfitvwy7hsm4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2017-02-23 11:09:32, Linus Torvalds wrote:
> I'm aware of the fsck checks, but I have to admit I wasn't aware of=20
> 'transfer.fsckobjects'. I should turn that on myself.
>
> Or maybe git should just turn it on by default?

The problem with this is that there are many repos with errors out=20
there, for example coreutils.git and nasm.git, which complains about=20
"missingSpaceBeforeDate: invalid author/committer line - missing space=20
before date".

There are also lots of repositories bitten by the Github bug from back=20
in 2011 where they zero-padded the file modes, git clone aborts with=20
"zeroPaddedFilemode: contains zero-padded file modes".

Paranoid as I am, I'm using fetch.fsckObjects and receive.fsckObjects=20
set to "true", but that means I'm not able to clone repositories with=20
these kind of errors, have to use the alias

  fclone =3D clone -c "fetch.fsckObjects=3Dfalse"

So enabling them by default will create problems among users. Of course,=20
one solution would be to turn these kind of errors into warnings so the=20
clone isn't aborted.

Reagards,
=C3=98yvind

+-| =C3=98yvind A. Holm <sunny@sunbase.org> - N 60.37604=C2=B0 E 5.33339=C2=
=B0 |-+
| OpenPGP: 0xFB0CBEE894A506E5 - http://www.sunbase.org/pubkey.asc |
| Fingerprint: A006 05D6 E676 B319 55E2  E77E FB0C BEE8 94A5 06E5 |
+------------| c7e47a18-fa06-11e6-ad93-db5caa6d21d3 |-------------+

--os2ytfitvwy7hsm4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlivSmsACgkQ+wy+6JSlBuW+KgCbBe9TpS+9gccWF5Y0M36i5H42
RLkAn2mbA0BDUgMkRp2H+gcwn6Gtdv0u
=P6BO
-----END PGP SIGNATURE-----

--os2ytfitvwy7hsm4--
