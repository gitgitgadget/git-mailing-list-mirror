Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC3351F453
	for <e@80x24.org>; Sat,  3 Nov 2018 07:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbeKCRIW (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 13:08:22 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:42118 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbeKCRIW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 13:08:22 -0400
Received: from pomiot (d202-252.icpnet.pl [109.173.202.252])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mgorny)
        by smtp.gentoo.org (Postfix) with ESMTPSA id ADF26335C39;
        Sat,  3 Nov 2018 07:57:52 +0000 (UTC)
Message-ID: <1541231868.1028.2.camel@gentoo.org>
Subject: Re: Git Test Coverage Report (Friday, Nov 2)
From:   =?UTF-8?Q?Micha=C5=82_G=C3=B3rny?= <mgorny@gentoo.org>
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Date:   Sat, 03 Nov 2018 08:57:48 +0100
In-Reply-To: <xmqqva5en832.fsf@gitster-ct.c.googlers.com>
References: <784741be-6045-12bb-75b9-0df6f4c612b7@gmail.com>
         <xmqqva5en832.fsf@gitster-ct.c.googlers.com>
Organization: Gentoo
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-bpdXVZ1IX3CqPCr818xn"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--=-bpdXVZ1IX3CqPCr818xn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2018-11-03 at 12:38 +0900, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>=20
> > Uncovered code in 'next' not in 'master'
> > --------------------------------------------
> >=20
> > pretty.c
> > 4de9394dcb 1264) if (c->signature_check.primary_key_fingerprint)
> > 4de9394dcb 1265) strbuf_addstr(sb,
> > c->signature_check.primary_key_fingerprint);
> > 4de9394dcb 1266) break;
>=20
> Perhaps a patch along this line can be appended to the
> mg/gpg-fingerprint topic that ends at 4de9394d ("gpg-interface.c:
> obtain primary key fingerprint as well", 2018-10-22) to cover this
> entry in the report. =20
>=20
> I do not know how involved it would be to set up a new test case
> that demonstrates a case where %GF and %GP are different, but if it
> is very involved perhaps it is not worth adding such a case.

Well, I didn't add a test for %GP primarily because we didn't have a key
with different primary and subkey fingerprints.

As for how involved... we'd just have to use a key that has split
signing subkey.  Would it be fine to add the subkey to the existing key?
 It would imply updating keyids/fingerprints everywhere.

>=20
>  t/t7510-signed-commit.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
> index 19ccae2869..9ecafedcc4 100755
> --- a/t/t7510-signed-commit.sh
> +++ b/t/t7510-signed-commit.sh
> @@ -176,8 +176,9 @@ test_expect_success GPG 'show good signature with cus=
tom format' '
>  	13B6F51ECDDE430D
>  	C O Mitter <committer@example.com>
>  	73D758744BE721698EC54E8713B6F51ECDDE430D
> +	73D758744BE721698EC54E8713B6F51ECDDE430D
>  	EOF
> -	git log -1 --format=3D"%G?%n%GK%n%GS%n%GF" sixth-signed >actual &&
> +	git log -1 --format=3D"%G?%n%GK%n%GS%n%GF%n%GP" sixth-signed >actual &&
>  	test_cmp expect actual
>  '
> =20

--=20
Best regards,
Micha=C5=82 G=C3=B3rny

--=-bpdXVZ1IX3CqPCr818xn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQKTBAABCgB9FiEEXr8g+Zb7PCLMb8pAur8dX/jIEQoFAlvdVPxfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDVF
QkYyMEY5OTZGQjNDMjJDQzZGQ0E0MEJBQkYxRDVGRjhDODExMEEACgkQur8dX/jI
EQpjZBAA2aqzU1rrvFMWTHFEaLyMXEy6CdsrNyWfFEdDVNvDS/fZK/U4W0GFTzCU
qsHIRmFbrvkFN9F9veGdo73jhViwe6DhOUiHle7aDRDidWyx/DiFsj65PhrvYDXI
l5lHglbLs3dSjlspweyiTtjDJIBdOCD452SzmX+3QaUEO2Ay5NLSm9Z76cwGumnd
YpeCjcwqWgaUZ2d5u+ef1I7efLwfg7j1d07s1DkHuvaOMMY9ACo2i59tPBrMjs3/
gZDlPrLslO+yPf9z8Htbm50zm785m7n8ZJ65YVxfcf61yLnsmcwCRjv2aryMW7kT
+lQYZTUx4qyxJVIVZGYA+olvpA4lx6KyHSP6wmxksmJknkvfP1gBugPexFX7JIB6
o6ivs10YVb7VFzbcnCB3AlftAbIi9dWpUeCapNuCyL8qjWDj34nbR8zfNs8rxB68
1tafC1yOMMSM6EpvkM0OkbnkBdT/UX+YabbENydkX73KAFYParkn4dPHGdwIr/4+
QpYKK9q63yrnYT1PP/XpTS2KDOPw0xknkIPIdpj760YTWdToYwDa05/AxLcBj57W
vfB7mtsWmVfVa/jiQ/8BucnsU9ckARwPxuZNlzfY2OEk9Z6PJI83for2dUh50fcc
R4HBY1wh6Iw0UFTnDNvD6fQvRlGunwiKE1Jj0aId1gu3hi++xU0=
=kvRS
-----END PGP SIGNATURE-----

--=-bpdXVZ1IX3CqPCr818xn--

