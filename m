Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C579C433B4
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 12:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 165F8613FF
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 12:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237263AbhD2Myi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 08:54:38 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:37553 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237228AbhD2Myg (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 29 Apr 2021 08:54:36 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id C16671648;
        Thu, 29 Apr 2021 08:53:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 29 Apr 2021 08:53:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=f8o3CMju8jFEwXg87Nf5BQH3yB/
        L/FHcmPFpkr1vDtU=; b=CH+yY9vtqH2Pzj4yztMw5oTlGLYmFzB+eLJXjU/q7uf
        bea5uvj7k9swNAA2GcM8Q6DV6pCsZpp6QCnShjomVcPSB/rKeC/z0EcwCriueFf7
        Aw/JVVEVAZwMvKaL4ui5drZ1KqyD8/hQjt7IPocKJtxn0N3UQtfWY1Z+1yv/h1tp
        jufJSFdFYDyfaXuxjfGqIUfQVBE8RKLaXVEhYxdhyDGpYZvwZ4rietIHUHnVVKYl
        Mkb1q0L74E4ESbbR/QZ2eQgvx4lcUVeyfK0MrU0OOEnLog6g+l44ZVFvveDqNGzD
        taq3DLqGA1um5MrOTtactBouU1OZ9mcSEMMUM8IHWVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=f8o3CM
        ju8jFEwXg87Nf5BQH3yB/L/FHcmPFpkr1vDtU=; b=Kdc2mQZexyRD2o0o+mOUl7
        fELe2MkLanhTXysITv/vf5nGOBUaJ2LSSmrOYDI9QMhdZKRZu2u/U8EUbcFjqs1P
        hoPHqkCoTQCExVAAcjiY6OV4wEDJCw+Eu+/wZdmaI00AOmNGHpn+DpHQVpygzGBn
        Rxutfpxt8XZfePf/z7r3FQS9Sqddt/e5VaYxEzv+lQTLaxjLzvoFOmFrKXY9GMv8
        r0zuDcoLOIYL1DAbkyg1Kz8Wde42c0drE+LKIxCECsNLJ79w8CvA1KRar9K5+OHi
        GaE0uS7mr4t5p3nd8gtlQrggG5kIz/zkRqzZfOCT4vveMIEk++//oAnBCnEVssEQ
        ==
X-ME-Sender: <xms:W6yKYHc9-5Zz_SC954QWfNC72ZyZnSrQedTMOlqfmZpCh9Ylqg-8bw>
    <xme:W6yKYNMx3CVMp04wosXhgwUHEjafQVTUEbe0PI9_OwGfP50Puv5Eqr_x3lyZ4Vuo4
    GvAZ1BFhx2giUoR4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddvgedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtudenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnheptdffjeeiudduleehvdfgteeifeelheejte
    dvteduiedttedvtdffffefhfdvgffgnecukfhppeejkedrheehrdefgedrkeejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himh
X-ME-Proxy: <xmx:W6yKYAghadP7pmVdJYUg4oyVKbwuBsN5kIRLufwbTSM-FgsMtZXeMA>
    <xmx:W6yKYI-ssx-HZGhnVE056BkBIGvDPv8KI6A2UDuU_yJvCtr6K3fW3Q>
    <xmx:W6yKYDu3oD4f6mLMpYG8mdojUhmwwvmXOsqoTBSVZK6eJyvcDFoWAA>
    <xmx:W6yKYB1XhnKXwZqp3ZeHv3WATZsMw5wBq30y_CbvynGyHhHOi2yV2A>
Received: from vm-mail.pks.im (dynamic-078-055-034-087.78.55.pool.telefonica.de [78.55.34.87])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Thu, 29 Apr 2021 08:53:46 -0400 (EDT)
Received: from localhost (tanuki [10.192.0.23])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id f6aa43c3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 29 Apr 2021 12:53:40 +0000 (UTC)
Date:   Thu, 29 Apr 2021 14:55:25 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 0/2] git: support separate arg for `--config-env`'s value
Message-ID: <cover.1619700731.git.ps@pks.im>
References: <cover.1618847606.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1q7BxR2NxAQr15hN"
Content-Disposition: inline
In-Reply-To: <cover.1618847606.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--1q7BxR2NxAQr15hN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of this series fixing inconsistencies with
the `--config-env` parameter. It's only got a single change compared to
v1, which is to replace `test_i18ngrep` with `grep` as pointed out by
=C6var.

Patrick

Patrick Steinhardt (2):
  git.txt: fix synopsis of `--config-env` missing the equals sign
  git: support separate arg for `--config-env`'s value

 Documentation/git.txt |  2 +-
 git.c                 |  8 ++++++++
 t/t1300-config.sh     | 15 ++++++++++++++-
 3 files changed, 23 insertions(+), 2 deletions(-)

Range-diff against v1:
1:  08049f3b10 =3D 1:  08049f3b10 git.txt: fix synopsis of `--config-env` m=
issing the equals sign
2:  d52db89bc2 ! 2:  5264fb6fa7 git: support separate arg for `--config-env=
`'s value
    @@ t/t1300-config.sh: test_expect_success 'git --config-env=3Dkey=3Denv=
var support' '
     =20
     +test_expect_success 'git --config-env with missing value' '
     +	test_must_fail env ENVVAR=3Dvalue git --config-env 2>error &&
    -+	test_i18ngrep "no config key given for --config-env" error &&
    ++	grep "no config key given for --config-env" error &&
     +	test_must_fail env ENVVAR=3Dvalue git --config-env config core.name =
2>error &&
    -+	test_i18ngrep "invalid config format: config" error
    ++	grep "invalid config format: config" error
     +'
     +
      test_expect_success 'git --config-env fails with invalid parameters' '
--=20
2.31.1


--1q7BxR2NxAQr15hN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmCKrLwACgkQVbJhu7ck
PpQymBAAmgIYLny4nSPNTQhtfVlXUdXpvjRLrD47T0KhM8Ii9luzHcGUMVUlmsDW
fvLFnFormmWaOLW7XvU0HlnXMlWZ+B96mPshBQR1VxgtSao4N7rUKSV3Sm+babdD
8bdUjHX3+KY9Tp6Q8KI7MJsJZ33yclBgJKaYnmQrDRGzSfPmW+fuDovMb3k8dbry
Yogfs2qYRUAs+jY9fl8su26shR1yLmu1DTTfFlH4FsGtZvfud8/ChY8s3nxlooBU
MWW4m0yOrlwyKlmth7CdzxRQaqsZ9200AULrwuyqQyomziymPc6ix7qTXrTNE9Ab
745nhNCGxY0cttCaBovtn/+uwbq60Hr7Dkct++qX2fJI4VC5J3Tm7RQmHpj1ndt0
v5a2lIltMZmVD2T1SmwoVD/o5vJrSrg6Nkt1cxvuvo2IZGexYcyxyuIsqRoxY4DL
+SUQwnAL9AYn0OHYTmC2mpVM56rFNJFM+fGpYGkEWiyyobFiy1eDKgubgH7DAvou
Sn3Cd1tbPJcg1gIMsCdbuWEGhMost/puQAjg79HMmmFt/jw1FaOpGUwDs61OYW8Q
os/NEOyPLG4LNxMEQlAlp4K0bzClOrS6X7C5MeylLMNECgfAnvGiccJJTXvZJMiL
jQotavkp2mKNJm41GQI0+5ZTtrH5panQxB6FFqiu6cOtkLgjsSY=
=+56e
-----END PGP SIGNATURE-----

--1q7BxR2NxAQr15hN--
