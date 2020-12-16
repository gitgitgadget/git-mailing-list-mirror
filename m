Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32136C2BBCA
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 07:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E28BF23356
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 07:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbgLPHxh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 02:53:37 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:42627 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725803AbgLPHxg (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 16 Dec 2020 02:53:36 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 52B015C00E4;
        Wed, 16 Dec 2020 02:52:45 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 16 Dec 2020 02:52:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=Bme5/R4hzV6zPrUuvBl8sUPu9k6
        f5L82JFcrX5VlM5o=; b=MYoy4VgLNq4iBNk8M2KSU5Idb93KpfExJScW17mHwJV
        ChQVE1e/vwWZBwAlimln64ezGxxSNY117nfan1L4O5x/v1sBWM8Rz2tcrrj4CR49
        o8j1kDdjXVdo/C0h2lt9yRjC6rK0S1kUwp3Vy2sEg/raYy/FTjYJugGqX/g1nPOL
        P8g+px5vMckoKHm7ZCzIQLLiqtLMClQVZZSn6yxlQvUUSrPyzb4FiAEIx7d3lD0I
        MaTTocvqVC1NHBvucldvdp4aDVTYWvnPsx6f384eywTZZsPbvefbdvHIKbSUZMsi
        ym0YZwhsox6k2sXQqq0SqoFXILYYhy7aWiQ3kseSVqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Bme5/R
        4hzV6zPrUuvBl8sUPu9k6f5L82JFcrX5VlM5o=; b=BLYsF43L22HlySscU6k5gZ
        foY3EXg8bJtHb6HABjQvqQQFtsc2IoYvUrEHitWD82tuBlNtQ4SY/FeGD55PEXpI
        ZmdqG4Tbk0XzFAkYiQPnaXaCO9QtS8Eo12NwHL5I2gw/6MxZO64T74+IeGdKVH/R
        4otEtR6pLrV20w330qdP9yRb4T9mt3RCgLqA9KNYo7+GkDFFQbP876Bq3QWFC1uK
        VxIhF3KS7INl7Bgiz51dPn7mzhZ/wypn14BKKaRPATMult5txNAFLbF2MCxQX1eI
        WZyDx00/v/7e6sCSDhjQ52uAp/l0DB3fTX2CEplN5Ce7qVbaVohBzbJlJ+UjHEmg
        ==
X-ME-Sender: <xms:zLzZX5IFUrMuSpPl5KiNc-6gd6Bb8SC62-5_W5YWdwl3pXE9vgdM0A>
    <xme:zLzZX1KnexElP-Ejvfr6pGFVxKTvULq_wcE-bOti8_0ia_gnqY2PaGm-ZTZbu3lKN
    SdLrvXiM-7o9gKHbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeluddgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnheptdffjeeiudduleehvdfgteeifeelheejtedvteduiedttedvtdffffefhfdvgffg
    necukfhppeejkedrheehrddugedrudejheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:zLzZXxtC8tyBecuE3X1qRmlpIB_vS5OCw6uDe9wQeWjnk1BJBzCpFg>
    <xmx:zLzZX6bTUVrV3iVXgB7kFa8WHIl40ezasFGg6nUCpa6cjR_uPrQGrw>
    <xmx:zLzZXwYGSkYpMufwJfmXZERxerIj1A-VAZJy9jpEs-VRK7ZZ0cOw-A>
    <xmx:zbzZX4Ey8lCB00ONu_uky4INfrXd2dMJuR6Rud9a3kPoAN0ZoCe0zw>
Received: from vm-mail.pks.im (dynamic-078-055-014-175.78.55.pool.telefonica.de [78.55.14.175])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6B3591080057;
        Wed, 16 Dec 2020 02:52:43 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 63d1d551 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 16 Dec 2020 07:52:39 +0000 (UTC)
Date:   Wed, 16 Dec 2020 08:52:38 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v5 0/8] config: allow specifying config entries via env
Message-ID: <cover.1608104755.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IUDJ8tWZicdpCRSa"
Content-Disposition: inline
In-Reply-To: <cover.1606214397.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--IUDJ8tWZicdpCRSa
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the fifth version of my patch series which aims to implement a
way to pass config entries via the environment while avoiding any
requirements to perform shell quoting on the user's side.

Changes in this version include:

    - I've adopted Jeff's patches to make GIT_CONFIG_PARAMETERS more
      robust by using quoting for both key and value of the config
      entry. This allows to store entries which for example have an
      equals sign in their key.

    - I've replaced the documentation of `git --config-env` by =C6var's,
      which was much better.

    - I've amended the documentation of GIT_CONFIG_COUNT to document the
      intended usecase.

The series is structured as following:

    - Patch 1 is a while-at-it patch for the `--super-prefix` usage
      string which was missing in `git --help`.

    - Patch 2 implements `git --config-env`.

    - Patch 3-6 implement robust handling of GIT_CONFIG_PARAMETERS.

    - Patch 7-8 implement GIT_CONFIG_COUNT handling.

As before, if the GIT_CONFIG_COUNT code is unwanted, please feel free to
cut off after the 6th patch.

Patrick

Jeff King (3):
  quote: make sq_dequote_step() a public function
  config: store "git -c" variables using more robust format
  config: parse more robust format in GIT_CONFIG_PARAMETERS

Patrick Steinhardt (5):
  git: add `--super-prefix` to usage string
  config: add new way to pass config via `--config-env`
  config: extract function to parse config pairs
  environment: make `getenv_safe()` a public function
  config: allow specifying config entries via envvar pairs

 Documentation/git-config.txt |  16 +++
 Documentation/git.txt        |  23 +++-
 cache.h                      |   1 +
 config.c                     | 205 ++++++++++++++++++++++++++++----
 config.h                     |   1 +
 environment.c                |   8 +-
 environment.h                |  12 ++
 git.c                        |   3 +
 quote.c                      |  15 ++-
 quote.h                      |  18 ++-
 t/t1300-config.sh            | 220 ++++++++++++++++++++++++++++++++++-
 11 files changed, 483 insertions(+), 39 deletions(-)
 create mode 100644 environment.h

--=20
2.29.2


--IUDJ8tWZicdpCRSa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/ZvMUACgkQVbJhu7ck
PpQeDRAAkjniWiFMxb8xNLQ8KYhbOUspf/zv9k6bMEnHx5IgRMFpnMbGaBpGJ2yb
MXEudQEGEI0Wd7aBjK6ghRIA8f/x13Xd5VznWKlwza31fMvtQI55qreAl7wi/5Al
PCquXVv6pFZZ5AR3dUGbwPZo4rL+Wy3kVBTSiifwjdudf1TgNA54cEbEXDFU4u3s
+/YBqUBWUvtvAwtbxNMhd5t0Nem00B7gG5ghpfwAQy1IpXpGGskLMHvxuaoyZO8p
dD5B5xf0yDMa0pF8ZQ5aXdzyJNxJdIZax/pzNdswlOplddccsNcqb0a1Qc6jrcNK
VmTRPWZgz9fxr5yEtW2j6aPiDGZwuozgbSBZGB+2hjC0/oGR3rIP5VHQ+p6fCdMe
t9DFP3kVaXP/2hXREllqzSyFD83paIgXaeIvACLcrZXLOJMyVBdzu5fERio1ibdf
zOEYy2gZznTnsnaT3GfrMKPzlR9HnzUp3Xdta7xtUur2GO2U2pb7FF0FSZ6TklkV
RCudoFHv0/lJjySD/jtH26pXivUolkW8MRbZcIZnmUjz4qxIS02vb6MO/pjsb57S
LMe3yqHtInu+irGS274pKujpk3I8DxQ/J6hu97StHg/h7Rc/LylmwKXVtwoiWPAn
t2JazaHCHf+btrjaqKrvILE5BsJcRfgzUcEvduIeOzVwVT4zttA=
=p06v
-----END PGP SIGNATURE-----

--IUDJ8tWZicdpCRSa--
