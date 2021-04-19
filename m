Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0850C433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 15:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89A2361285
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 15:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240360AbhDSPzv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 11:55:51 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:38741 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240142AbhDSPzu (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Apr 2021 11:55:50 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 657A510C9;
        Mon, 19 Apr 2021 11:55:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 19 Apr 2021 11:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:mime-version:content-type; s=fm3;
         bh=07k8d7eGrBrDwdaxlyKibCs2VHC5FCp3NWEMlOx+ZtA=; b=cLBDA/eBtJ5+
        uANsXpwg0TRBFnhVy4zK05OjbZ+m/lB1srKcga2Bjh9Ql/7QklHPqqBzfK6pffa0
        mrOxyUPXkZfn0T2sfbZiqTB9CdWE4PAHfWSQw0LdxyG2hOBPxqpoI4K/X8lkkEfC
        WFdknb/L0UtbnbgVVciu1pzMr8hRr8+EzesoM6DxM/iyN6puMc2POzWJhzvXv8CM
        Ogy1vWA56NRbdjiLKb/SaEBKKHsqPS6hvYjk6zeQYvJSV3IAlyfFQLHjsKxXlwOQ
        2XfjA/6ZIMq+NVERMTjGfAL60NadD+l7HOnn3LS70W/Lhh9BrbhuPgGFRWB/EsJi
        +7gyoPdCHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=07k8d7eGrBrDwdaxlyKibCs2VHC5F
        Cp3NWEMlOx+ZtA=; b=e1g6t6GR7qliqRcksuZApakrbzQ7KwIipCSpoU/yC/9Ks
        IoFe+A+cmL2sDAblfTBbr9SNjV8qLH4PhqMI2yP0hpvBWdSfy+rNfH064zcdm6FZ
        cYBQh3nNRD2uNaO+1dh9e22pBMt04BLh2YHHZZYFcdEEWv23W9ulu9AYjeas0D1Q
        JrlfYScvjAE+Xh8t/4njsnIZTiCldNYE36CeAUm2PJTVzsRVlBZ3ISEi7bbi5Ql9
        snmIm2eLyYiGAo5THBKYSQ7YDvS+nbG2/lq3S202TrE0WAUQtxdqPFH6wi6Mw6/H
        zODwGNVLp0sp/H6kM1JnzTC6Kjx5FoTr8NXKhvGzA==
X-ME-Sender: <xms:56d9YIsSr8e617xAizkGGqIUCpsdppLbPHYBN0aMtqf98fpy2yX71Q>
    <xme:56d9YJu8fJMZrJZDCkxYlQeuNcfkONQtoy-TDyw7kSg_V7T2ywwndwE5qQpBuo8mq
    UNDS3p3U_NoS5MzWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddtgedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtudenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepgeefkeeivdffudejjefgheegfefgleevueeige
    efjeetffdvhfduteeiueehheevnecukfhppeejjedrudeluddrieekrdektdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrih
    hm
X-ME-Proxy: <xmx:56d9YOx8HuiwJ94f1-SsUlttXg0HpbKIh7VpCggPcWn9LBCzBOazqw>
    <xmx:56d9YPhBxhk2YtoFB3_G0f_4qqL9UrYLkcReZUklylBjLNZyW_iMDQ>
    <xmx:56d9YCCG4tGoSQbUTHvrROMcP2iIZppFMsifOaLVRNzQhhanu47Fbw>
    <xmx:6Kd9YCfgSAVXcctNm1rBicT6BpY6kf5buFhwDhvmLDnGn_4EcnWfzg>
Received: from vm-mail.pks.im (x4dbf4450.dyn.telefonica.de [77.191.68.80])
        by mail.messagingengine.com (Postfix) with ESMTPA id ED817240054;
        Mon, 19 Apr 2021 11:55:18 -0400 (EDT)
Received: from localhost (tanuki [10.192.0.23])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 5564e2d1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 19 Apr 2021 15:55:17 +0000 (UTC)
Date:   Mon, 19 Apr 2021 17:56:45 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH 0/2] git: support separate arg for `--config-env`'s value
Message-ID: <cover.1618847606.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MMOkDoLVq/BeYq7N"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--MMOkDoLVq/BeYq7N
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

As pointed out by =C6var, the synopsis in the git(1) manpage was
misdocumenting the syntax of the `--config-env` option. This patch
series fixes it and also addresses the shortcoming that while most of
the other options support both `--git-dir=3Dfoo` and `--git-dir foo`,
`--config-env` only supported the former format.

I'm happy to drop the latter patch if it's generally seen as something
that's not needed, but =C6var and Peff got a point in that it feels
inconsistent with the other options.

Patrick

Patrick Steinhardt (2):
  git.txt: fix synopsis of `--config-env` missing the equals sign
  git: support separate arg for `--config-env`'s value

 Documentation/git.txt |  2 +-
 git.c                 |  8 ++++++++
 t/t1300-config.sh     | 15 ++++++++++++++-
 3 files changed, 23 insertions(+), 2 deletions(-)

--=20
2.31.1


--MMOkDoLVq/BeYq7N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmB9qDwACgkQVbJhu7ck
PpTloxAAhgLRX3/TcxyhE5UgKEf+y356EgKIVYCCwBTaoPhQ7aoATSob4m2mDjaV
ubbdEtbDFirWOOiXJqa61xo+yBuCGap8GAfU8JLmVepX7h1YbQECsWlE0q5ogDoo
17QsneHbFF7DwDuBFrK3P/GsIdbcP2Mg0ffxrlgXcRKtb1DS2yoyh3OUfLqVgh3n
YmpEbimPB+zUobaj09/hpFAcR1MLlcTFSixMeMUWmnaRChwtEx0N2uvt+Emswbbk
Lpi4c1I+1dTaEZIFGOu68O6rc02/56fbVEebc+NPrqXIEmx60VOr8l3rE3x+lTwZ
qcS3W4Cc8CmugoWCu8gMr4UUzeNp62OXXTLfIIap8OMSCqXSjV1S/PNRgqx87Wd0
n+lGfcmFu+qpRbhrVvDuHpqKTTsNtufO7bkSlNsHOYkqb9vwBmDm4Ty519AyJpX/
Jr1bLXeW6b+sV6ZfqTNxey5IoKKiZbRXeyZlDpVW5EESbh0Z/L1H+ToMF3YfXSmY
8HkgslrYOzdVAdVKxkOL2Gwelgcnt8XXykhyt2rAFOXI3fWm44/g8jbwB8qwa05j
2NMHhFm/ia78BL2aaF6ruaW+59vS2nQC6Wyx4Ed79jm9YGi0kwgoybTFCUiVC1k7
J+riH3AbIHp8d2dwcANp7gWdGKJ8skvzo5kEKuo9GmrnLYvj2HU=
=xCFE
-----END PGP SIGNATURE-----

--MMOkDoLVq/BeYq7N--
