Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CFE520A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 04:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbeLNEMB (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 23:12:01 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:55110 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbeLNEMB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 23:12:01 -0500
Received: from pomiot (d202-252.icpnet.pl [109.173.202.252])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mgorny)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 5C333335C67;
        Fri, 14 Dec 2018 04:11:58 +0000 (UTC)
Message-ID: <1544760713.970.1.camel@gentoo.org>
Subject: Re: [PATCH 0/4] Expose gpgsig in pretty-print
From:   =?UTF-8?Q?Micha=C5=82_G=C3=B3rny?= <mgorny@gentoo.org>
To:     John Passaro <john.a.passaro@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, alex.crezoff@gmail.com, peff@peff.net
Date:   Fri, 14 Dec 2018 05:11:53 +0100
In-Reply-To: <20181213212256.48122-1-john.a.passaro@gmail.com>
References: <20181213212256.48122-1-john.a.passaro@gmail.com>
Organization: Gentoo
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-MQ/0maWiSdtsZgIfWTKT"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--=-MQ/0maWiSdtsZgIfWTKT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2018-12-13 at 16:22 -0500, John Passaro wrote:
> Currently, users who do not have GPG installed have no way to discern
> signed from unsigned commits without examining raw commit data. I
> propose two new pretty-print placeholders to expose this information:
>=20
> %GR: full ("R"aw) contents of gpgsig header
> %G+: Y/N if the commit has nonempty gpgsig header or not
>=20
> The second is of course much more likely to be used, but having exposed
> the one, exposing the other too adds almost no complexity.
>=20
> I'm open to suggestion on the names of these placeholders.
>=20
> This commit is based on master but e5a329a279 ("run-command: report exec
> failure" 2018-12-11) is required for the tests to pass.
>=20
> One note is that this change touches areas of the pretty-format
> documentation that are radically revamped in aw/pretty-trailers: see
> 42617752d4 ("doc: group pretty-format.txt placeholders descriptions"
> 2018-12-08). I have another version of this branch based on that branch
> as well, so you can use that in case conflicts with aw/pretty-trailers
> arise.
>=20
> See:
> - https://github.com/jpassaro/git/tree/jp/pretty-expose-gpgsig
> - https://github.com/jpassaro/git/tree/jp/pretty-expose-gpgsig--based-on-=
aw-pretty-trailers
>=20
> John Passaro (4):
>   pretty: expose raw commit signature
>   t/t7510-signed-commit.sh: test new placeholders
>   doc, tests: pretty behavior when gpg missing
>   docs/pretty-formats: add explanation + copy edits
>=20
>  Documentation/pretty-formats.txt |  21 ++++--
>  pretty.c                         |  36 ++++++++-
>  t/t7510-signed-commit.sh         | 125 +++++++++++++++++++++++++++++--
>  3 files changed, 167 insertions(+), 15 deletions(-)
>=20
>=20
> base-commit: 5d826e972970a784bd7a7bdf587512510097b8c7
> prerequisite-patch-id: aedfe228fd293714d9cd0392ac22ff1cba7365db

Just a suggestion: since the raw signature is not very useful without
the commit data to check it against, and the commit data is non-trivial
to construct (requires mangling raw data anyway), maybe you could either
add another placeholder to get the data for signature verification, or
(alternatively or simultaneously) add a placeholder that prints both
data and signature in the OpenPGP message format (i.e. something you can
pass straight to 'gpg --verify').

--=20
Best regards,
Micha=C5=82 G=C3=B3rny

--=-MQ/0maWiSdtsZgIfWTKT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQKTBAABCgB9FiEEXr8g+Zb7PCLMb8pAur8dX/jIEQoFAlwTLYpfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDVF
QkYyMEY5OTZGQjNDMjJDQzZGQ0E0MEJBQkYxRDVGRjhDODExMEEACgkQur8dX/jI
EQp2ihAAjE5kFVZ36Dr219RD+/38O0z4Ebgg9UMH5HXmWbjsEAG8jzIjHK1nT9XN
Drf+u/+0IxdQAHCXxlkBa5TzBcN80pJ4I/GMomoIjAcWB4gLRl2F2KiT2VU00i50
GBRQM9Y24BAky2MnwknWdK5cR+NUvMqFHmWRkJmWiELmO1mhgT6UUZN30Xxn2eoj
xmR2mpyKy7A6Zdk1t80nYKnorRrG2akE+fNOEhu6wSmgO6eJaTMON/3tWCvElu++
CGnwZXxv38qDFAfEdAXDzkaCI98EGOGN6XW5GuzEutt9HQwHeoftaOOkc1uDGPej
HuhqF4rvoJszNmL0uduv5PqCCUgR5q6uIeaOBzn3UURdm7N9gzCrYNN25K3cffPB
RQc/7mHFTEm8E+Y8fjCxLZIrsoVSu/inMTw2aGz/WSZlv2n6DFerHdEjwJ2Imxfg
FygRz4kCRhZ2tBgJp/HXJr34QEUFcjqKadCE2Q/6HCsh0gBnyqmXehJOYENpnu1a
0I2StdIBAQAn59IbVkLAHd5His139JWqH7eacqQzAXQTRH9N8V+UQdwxgAM2PPta
aE0kS7Zxvnf0JiFBXagjixOSrgwc0nWd5JojLxeMnQjk2mS66f1omWTapCbffZ1p
+b8xFn3waiOBxcKKtEbyIoVVsY0uAeh92Ctz4wX1lJ7MyCQzIRo=
=1Oqr
-----END PGP SIGNATURE-----

--=-MQ/0maWiSdtsZgIfWTKT--

