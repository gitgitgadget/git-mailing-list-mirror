Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6370937A
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 14:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DBAC9
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 07:14:42 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qrIw5-0005Dv-7I; Fri, 13 Oct 2023 16:14:41 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qrIw4-001PrP-PD; Fri, 13 Oct 2023 16:14:40 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qrIw4-00FcmU-G8; Fri, 13 Oct 2023 16:14:40 +0200
Date: Fri, 13 Oct 2023 16:14:37 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: git@vger.kernel.org
Cc: entwicklung@pengutronix.de,
	Michael Strawbridge <michael.strawbridge@amd.com>,
	Luben Tuikov <luben.tuikov@amd.com>
Subject: Regression: git send-email fails with "Use of uninitialized value
 $address" + "unable to extract a valid address"
Message-ID: <20231013141437.ywrhw65xdapmev7d@pengutronix.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rx4qpsdosh5urepu"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--rx4qpsdosh5urepu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

	$ git send-email --to 'A B <a@b.org>, C D <c@d.org>' lala.patch
	Use of uninitialized value $address in sprintf at /usr/lib/git-core/git-se=
nd-email line 1172.
	error: unable to extract a valid address from:

This happens for me with git 2.42.0 and also on master (59167d7d09fd, "The =
seventeenth batch").

Bisection points at

	a8022c5f7b67 ("send-email: expose header information to git-send-email's s=
endemail-validate hook")

I didn't try to understand that change and fix the problem.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rx4qpsdosh5urepu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUpUMwACgkQj4D7WH0S
/k6KJwf/fMgPKjkpLbnWUS90oM4FWglQR7C3/qwNM/sitjILzCFnqWdWzAICNSjC
jZVLveUrFQamFP14aJjztUknqDQfHDJsFClblywTxIlOu0/9UI0wAN2xc6uweTlw
aKCR19Etij4HXj6mRhtFlVIqPo1wgVmRwle0IVz50NkkqPQ+dE3c3B29+nqKGaII
/AyVhFbRcaSEcaHAzzeozuyf/b9/nM48q+tK2HIGWA2Dnze6SGhgTMMSAHzNbyVL
ddWujcGv5EWa5FFz9+lf/NRZQMiCDLA5KZ6CTXvG8siknonbnCCK/T3dCc3dJ8WP
VyzvFAWATtCrL9kTJEsa5Hh7nVgIvg==
=XVth
-----END PGP SIGNATURE-----

--rx4qpsdosh5urepu--
