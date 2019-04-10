Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 191FF20248
	for <e@80x24.org>; Wed, 10 Apr 2019 06:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfDJGlK (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 02:41:10 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:47270 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfDJGlK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 02:41:10 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id 58E29340871
        for <git@vger.kernel.org>; Wed, 10 Apr 2019 06:41:09 +0000 (UTC)
Received: (qmail 28452 invoked by uid 10000); 10 Apr 2019 06:41:05 -0000
Date:   Wed, 10 Apr 2019 06:41:05 +0000
From:   "Robin H. Johnson" <robbat2@gentoo.org>
To:     Git Mailing List <git@vger.kernel.org>
Subject: regression AGAIN in output of git-pull --rebase
 --recurse-submodules=yes --quiet
Message-ID: <robbat2-20190410T062730-540884809Z@orbis-terrarum.net>
References: <robbat2-20180120T054223-685328376Z@orbis-terrarum.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HywJcj55HbA57jnN"
Content-Disposition: inline
In-Reply-To: <robbat2-20180120T054223-685328376Z@orbis-terrarum.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--HywJcj55HbA57jnN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

A year ago, I raised <robbat2-20190410T062730-540884809Z@orbis-terrarum.net=
> as an issue,
which lead to commit commit a56771a668dd4963675914bc5da0e1e015952dae.

The exact same workload somewhere between 2.18.0 and 2.19.0 has caused
the message to come back. I noticed it first in a 2.18.0->2.21.0
upgrade, and did a partial bisect based on tags to trace it to 2.19.0.

=3D=3D=3D
$ git submodule foreach --quiet git pull origin master --quiet >/dev/null
=46rom git://anongit.gentoo.org/data/gentoo-news
 * branch            master     -> FETCH_HEAD
=46rom git://anongit.gentoo.org/data/glep
 * branch            master     -> FETCH_HEAD
=3D=3D=3D

I suspect it was a result of:
ea27893a65cc41cad2710466aa6a58866ff22f1e Merge branch 'pc/submodule-helper-=
foreach'

But I haven't done a full bisect to prove it yet.

On Sat, Jan 20, 2018 at 05:57:29AM +0000, Robin H. Johnson wrote:
> Somewhere between 2.13.6 & 2.14.1 there's an output regression. I
> haven't done a bisect to trace it down further yet.
>=20
> Specifically, --rebase --recurse-submodules=3Dyes seems to cause --quiet
> to not be effective anymore.
>=20
> Full commandline:
> $ git pull --rebase --recurse-submodules --quiet
>=20
> In 2.13.6, there is no output, it's quiet as expect.
>=20
> In 2.14.1, you get:
> HEAD is up to date.
> Submodule path '_data/news': rebased into 'a50b763c338161b4621d23e9fa5cd6=
e11455d6ca'
> HEAD is up to date.
> Submodule path 'glep': rebased into 'e1f100ec3ba44ab1672d61cabf4690b355e4=
6158'
>=20
> Steps to reproduction:
> 1. git clone --recurse-submodules \
>  https://anongit.gentoo.org/git/sites/www.git
> 2. cd www
> 3. git submodule foreach --quiet git pull --quiet origin master
> 4. git pull --rebase --recurse-submodules=3Dyes --quiet
>=20
> Repeat step 4 for repeated bug output.
> If you drop the --rebase, then you need to re-run step 3 first.
>=20
> --=20
> Robin Hugh Johnson
> Gentoo Linux: Dev, Infra Lead, Foundation Treasurer
> E-Mail   : robbat2@gentoo.org
> GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
> GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136



--=20
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136

--HywJcj55HbA57jnN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iQKTBAABCgB9FiEEveu2pS8Vb98xaNkRGTlfI8WIJsQFAlytj/5fFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJE
RUJCNkE1MkYxNTZGREYzMTY4RDkxMTE5Mzk1RjIzQzU4ODI2QzQACgkQGTlfI8WI
JsSuJA//ebbKmSui7pY9sAnuQkdOlo+g1sekb5fIwXT+i+flZLIlLcGXU+upk4Gu
9KzevduLz4lDzd2NEtdrOZ87SxhR8EJT8NTCc5XcUx9fimBhK6tg8DvENDbUeUuT
yIzaWPl6TUcDRcyBgUdFfJu8LhDHQs84cu/LnnQkPzdZ3N2kfxf49ywEHiKPSWE3
tJS1aHdF2V+Ka0qEDfyb10cwnzQerhD7Xx6GVlNEC6sIuQXSBvL0LBhliNsENOQj
iOaFe+SptArqegVIs9BuqqN0AJsRj9JBu8dsb+aoqeA8SZoD2qV6LtqRuBYDpLkK
xtMDbLQcijd+p/vaYAhOyJlpTJyV/nbSgelPuRI9BsZ3TnwwoqgkPQlEXjFxw6+j
8C9X2BJ7HCSvXMvcWTrWlRQTmMe36AR93tOc2IwjEgAG0i/hF+N6U/vDSONQYzld
xKwIaL3PC1FXPa04eVsuL1iEjpIfUlVEYkRxkAZhqOBJMq/S4f14G03Bt/y9gvvA
Tbx4dZ10KorOE0wW9/1qyXOe7x0b7vYg/b/+oHaFngJfycR85scJZL8VpIiUYKxF
aaFvc1Hy/h5rQlmB67mLBNpKWIdjiM+FVhGDhLNO16K+oDyTVJDeiLLxYgJ7jNLx
a4KzRaJ0P8XXL92DgZ0+FtpBfop/8TNfMPVKhMejIviKBFvhG20=
=PVH6
-----END PGP SIGNATURE-----

--HywJcj55HbA57jnN--
