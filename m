Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFE8B1F453
	for <e@80x24.org>; Sun,  4 Nov 2018 16:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730641AbeKEBXJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Nov 2018 20:23:09 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:54448 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730522AbeKEBXJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Nov 2018 20:23:09 -0500
Received: from pomiot (d202-252.icpnet.pl [109.173.202.252])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mgorny)
        by smtp.gentoo.org (Postfix) with ESMTPSA id C5B1F335C58;
        Sun,  4 Nov 2018 16:07:39 +0000 (UTC)
Message-ID: <1541347654.22217.4.camel@gentoo.org>
Subject: Re: [PATCH 2/2] t/t7510-signed-commit.sh: add signing subkey to
 Eris Discordia key
From:   =?UTF-8?Q?Micha=C5=82_G=C3=B3rny?= <mgorny@gentoo.org>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
Date:   Sun, 04 Nov 2018 17:07:34 +0100
In-Reply-To: <20181104151013.GH731755@genre.crustytoothpaste.net>
References: <20181104094710.27859-1-mgorny@gentoo.org>
         <20181104094710.27859-2-mgorny@gentoo.org>
         <20181104151013.GH731755@genre.crustytoothpaste.net>
Organization: Gentoo
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-NtsoQ8/aqWueCycfAAFR"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--=-NtsoQ8/aqWueCycfAAFR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2018-11-04 at 15:10 +0000, brian m. carlson wrote:
> On Sun, Nov 04, 2018 at 10:47:10AM +0100, Micha=C5=82 G=C3=B3rny wrote:
> > diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
> > index e8377286d..86d3f93fa 100755
> > --- a/t/t7510-signed-commit.sh
> > +++ b/t/t7510-signed-commit.sh
> > @@ -197,9 +197,9 @@ test_expect_success GPG 'show bad signature with cu=
stom format' '
> >  test_expect_success GPG 'show untrusted signature with custom format' =
'
> >  	cat >expect <<-\EOF &&
> >  	U
> > -	61092E85B7227189
> > +	65A0EEA02E30CAD7
> >  	Eris Discordia <discord@example.net>
> > -	D4BE22311AD3131E5EDA29A461092E85B7227189
> > +	F8364A59E07FFE9F4D63005A65A0EEA02E30CAD7
> >  	D4BE22311AD3131E5EDA29A461092E85B7227189
> >  	EOF
> >  	git log -1 --format=3D"%G?%n%GK%n%GS%n%GF%n%GP" eighth-signed-alt >ac=
tual &&
> > @@ -209,7 +209,7 @@ test_expect_success GPG 'show untrusted signature w=
ith custom format' '
> >  test_expect_success GPG 'show unknown signature with custom format' '
> >  	cat >expect <<-\EOF &&
> >  	E
> > -	61092E85B7227189
> > +	65A0EEA02E30CAD7
>=20
> It's my understanding that GnuPG will use the most recent subkey
> suitable for a particular purpose, and I think the test relies on that
> behavior.  However, I'm not sure that's documented.  Do we want to rely
> on that behavior or be more explicit?  (This is a question, not an
> opinion.)

To be honest, I don't recall which suitable subkey is used.  However, it
definitely will prefer a subkey with signing capabilities over
the primary key if one is present, and this is well-known and expected
behavior.

In fact, if you have a key with two signing subkeys A and B and it
considers A better, then even if you explicitly pass keyid of B, it will
use A.  To force another subkey you have to append '!' to keyid.

Therefore, I think this is a behavior we can rely on.

--=20
Best regards,
Micha=C5=82 G=C3=B3rny

--=-NtsoQ8/aqWueCycfAAFR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQKTBAABCgB9FiEEXr8g+Zb7PCLMb8pAur8dX/jIEQoFAlvfGUdfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDVF
QkYyMEY5OTZGQjNDMjJDQzZGQ0E0MEJBQkYxRDVGRjhDODExMEEACgkQur8dX/jI
EQrahhAA7bUBjqITiupq6MUpSY/nM+rHhLZp8Dh1z8ReXbZa5hDNEbfTlC/uowbX
5Rjp9VpbR6PRwBl2YdYdhW+sWYYQg4T6SCltWmYvtWao5I/xxiDFWLmtnAGefmpP
utvSDeXdAnJaOxyE33Rwi5IuCIi8hv8Iv/pkhjDm6AW5ozYD4tTHHx1mUGAsPmve
qJTy8IpF2AepVtcNzy1DGM4eQMUqqX7f5f7zPVXpELAS4tb/HIarpRpuUWm4g1oP
fhSRP5xTQ5LUpQ6UF4G0et44eFWxZYmZJGngrUdhrx9e6s4iwN0Gu0EqDMcv5d87
D+VQ3mzCmn9Ipc2gRN4ztmjhd0V6vzkgm+x5PobTev2rb8NAaXu2J/Ll/C+vqfrX
9Q4IFDkw/+cEYmAd3vnncg33ZOpHaewMsWA7Fw9r7v5nn8BHoCeg3rwBoz+4UZO9
i88O4O5X12CcBmIODrNx9SCwcp1fGt2HZMt9DWItdlGRmPPZMrT5Nsc1+I4G0iRj
fXUW/t98GETk7gtmt/Ek51kMdQaJuGp4Jf8VXK9RIAnvBByt4p74oqZaYrGAg8la
IxEXifrC6V7qrt54CYecGuRHYX49gSdkmnHX60c+6vZ6QAes/U99+aqTi8up3deE
w+tQ33jTIgOfUv0++qw5NofRBxcVZOEs7RaHGQjOIWgU7+EdTYw=
=Tpmt
-----END PGP SIGNATURE-----

--=-NtsoQ8/aqWueCycfAAFR--

