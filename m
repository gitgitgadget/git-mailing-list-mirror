Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5509C433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 12:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8EE960EE4
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 12:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239454AbhIPMTC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 08:19:02 -0400
Received: from mx1.emlix.com ([136.243.223.33]:36130 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239292AbhIPMTB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 08:19:01 -0400
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id D6DE25FCBE;
        Thu, 16 Sep 2021 14:17:39 +0200 (CEST)
From:   Rolf Eike Beer <eb@emlix.com>
To:     git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tobias Ulmer <tu@emlix.com>, Junio C Hamano <gitster@pobox.com>,
        linux-kernel@vger.kernel.org
Subject: Re: data loss when doing ls-remote and piped to command
Date:   Thu, 16 Sep 2021 14:17:34 +0200
Message-ID: <2677927.DK6gFqPMyL@devpool47>
Organization: emlix GmbH
In-Reply-To: <85a103f6-8b3c-2f21-cc0f-04f517c0c9a1@emlix.com>
References: <6786526.72e2EbofS7@devpool47> <2279155.Qy0YqsFniq@devpool47> <85a103f6-8b3c-2f21-cc0f-04f517c0c9a1@emlix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12378026.phU4iQ1bBB"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--nextPart12378026.phU4iQ1bBB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Rolf Eike Beer <eb@emlix.com>
To: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tobias Ulmer <tu@emlix.com>, Junio C Hamano <gitster@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: data loss when doing ls-remote and piped to command
Date: Thu, 16 Sep 2021 14:17:34 +0200
Message-ID: <2677927.DK6gFqPMyL@devpool47>
Organization: emlix GmbH
In-Reply-To: <85a103f6-8b3c-2f21-cc0f-04f517c0c9a1@emlix.com>
References: <6786526.72e2EbofS7@devpool47> <2279155.Qy0YqsFniq@devpool47> <85a103f6-8b3c-2f21-cc0f-04f517c0c9a1@emlix.com>

Am Donnerstag, 16. September 2021, 12:12:48 CEST schrieb Tobias Ulmer:
> On 16/09/2021 08:38, Rolf Eike Beer wrote:
> ...
>=20
> > The redirection seems to be an important part of it. I now did:
> >=20
> > git ... 2>&1 | sha256sum
>=20
> I've tried to reproduce this since yesterday, but couldn't until now:
>=20
> 2>&1 made all the difference, took less than a minute.
>=20
> Different repo, different machine, but also running Tumbleweed
> 5.14.1-1-default, git 2.33.0
>=20
> while [ "`git --git-dir=3D$PWD/in/linux/.git ls-remote origin 2>&1 | tee
> failed.out | sha1sum`" =3D "7fa299e589bacdc908395730beff542b0fc684eb  -"
> ]; do echo -n .; done
> ..........
>=20
> failed.out has multiple lines like this:
>=20
> --8<--
> 4e77f7f1261f65cff06918bc5e66d02a418fc842        refs/tags/v3.10.18^{}
> f7b8df0cc81cf82a4ac6834225bddbe46a340455a4a5d52f29d08d923ce8d232b0b497da6=
74d
> d2c refs/tags/v3.18
> b2776bf7149bddd1f4161f14f79520f17fc1d71d        refs/tags/v3.18^{}
> --8<--
>=20
>=20
> Running the same on Archlinux (5.13.13-arch1-1, 2.33.0) doesn't show the
> problem.
> This may well turn out not to be git, but a kernel issue.

Linus,

since you have been hacking around in pipe.c recently, I fear this isn't=20
entirely impossible. Have you any idea?

=46or easier reference, the complete thread is at:

https://public-inbox.org/git/85a103f6-8b3c-2f21-cc0f-04f517c0c9a1@emlix.com=
/T/

Eike
=2D-=20
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
=46on +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 G=C3=B6ttingen, Germany
Sitz der Gesellschaft: G=C3=B6ttingen, Amtsgericht G=C3=B6ttingen HR B 3160
Gesch=C3=A4ftsf=C3=BChrung: Heike Jordan, Dr. Uwe Kracke =E2=80=93 Ust-IdNr=
=2E: DE 205 198 055

emlix - smart embedded open source

--nextPart12378026.phU4iQ1bBB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCYUM13gAKCRCr5FH7Xu2t
/PY/BACW1YIg30z2/m2NdubwBSUVlUdE2VIdkZMYmiWnJe+i02b93UpekDrJ2FUS
8qyLgAbVA5gp7dVDcZx0nZ02ANf8iUkQeu7Q6UbKIENJwYCf/EIo6ii1E1sm+tru
+bIPOxOJhTONzIXFupI2hL+031XPPC7+TAUiibnYlo6PCHzgSg==
=dbOG
-----END PGP SIGNATURE-----

--nextPart12378026.phU4iQ1bBB--



