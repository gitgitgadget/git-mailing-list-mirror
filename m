Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C63C56201
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 10:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1BC020872
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 10:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bR+1Y6/d";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GHTD3qb4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731827AbgKXKuz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 05:50:55 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:51351 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727781AbgKXKuz (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 24 Nov 2020 05:50:55 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id AD4AC1336;
        Tue, 24 Nov 2020 05:50:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 24 Nov 2020 05:50:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:mime-version:content-type; s=fm2;
         bh=TlinbC5Ay6gxVlwUFBZ415RaBthUz8+QguOqlcEAKAk=; b=bR+1Y6/dh7hs
        NvTWfT8MtCaTrHrdCcD7tVqr9wfwAyBK6vTdnDu77rVOPLnHHVQkschkfViezXc4
        4qaWNIyyzBjBCKLtgcITcybjuwRuI14fMWtehCYfV5r+Ym8bBUv0J6QHXLxj6b0+
        6PU8XVi7ZBvcocG/Q17gluoyKxrPe13E3aLvuiP+zbaBgnf5dqy4UYf7MkeOqDqy
        Ps87cz+eWaTvAcvGu3Nbh8c4GhhyFpi12toi3Sz2oNC1CY8ZLFZ1WN+LjRWIIrP+
        7urwIPdzarc2KjLD1vQDrHV6AOVSM2uj6qmdqtD3G3vy6PeOVP1uYaSR69Vm/HRt
        +2j1EqEGJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=TlinbC5Ay6gxVlwUFBZ415RaBthUz
        8+QguOqlcEAKAk=; b=GHTD3qb4WLAlm6Mu685Org78B0Dm2asjWITqblwRDqL6A
        n39e6IPxGSzDuWxAKKrJDRWdz3sBaUSudi/tCnmCU8jRfx3b6jASbh4AZnIMQRVk
        4kaLeW2twYarhP7PJHSm0a5L8lgcChwK3sFJjBo8V5M2HLajryJ2Ss6DSepk+jOJ
        qTJayWf04meFnAw444OzuMEgCYaXFeC3n94AseJMaNr5iWX2Z+XjOfjNhgO/AnDX
        Su93brzs92adnuhLr/nD1+lpXcEgGZsS4BJY+owq7zE3+OlyB4aMmjiGG0y1Y4Lq
        YK4wfojtWpNygXvlEDuisc2zqlERf6ffFpah/KPKQ==
X-ME-Sender: <xms:jOW8XwQQ2q62Q_1ZgJzM8CqcKDkc3unOgoC-gemkHX9YSgQSoc-wdQ>
    <xme:jOW8X9yF4uD20dSs9pxZ0Lor4JSiLG-rpW5uhHmTrh7apwXIFPhutAwxfR68N0D9Y
    xlBoZkllLrZ4BwwZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudegkedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfggtggusehgtderredttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ejieefvdeuleffgfejudffvdeghfeigfejgfdvvdefudevffefveffhffgkeeiffenucfk
    phepkeelrddugedrheegrdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:jOW8X93-5moHtFgP64VoXX173tvtEcyIgp_6VtZugoC2Xaazxvai7w>
    <xmx:jOW8X0B-9OuTjowvM6_tEPjkXEucEOjSy-JnzxMarJSy1ErR7HUMIg>
    <xmx:jOW8X5gFyz9gfLbGbNuj5jYePVYARpTbclA7zrZnlq1nEIZaGlfD_Q>
    <xmx:jeW8X-vqonZQQm2uMhNpZlvt3Qrn9nIMtYBiiUdoM6PC1fuJ5FAoBw>
Received: from vm-mail.pks.im (dynamic-089-014-054-008.89.14.pool.telefonica.de [89.14.54.8])
        by mail.messagingengine.com (Postfix) with ESMTPA id E437A3280063;
        Tue, 24 Nov 2020 05:50:51 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 8dfd4c9a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 24 Nov 2020 10:50:47 +0000 (UTC)
Date:   Tue, 24 Nov 2020 11:50:46 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v2 0/2] config: allow specifying config entries via envvar
 pairs
Message-ID: <cover.1606214397.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wJ5Zub1MMdLJgWrO"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--wJ5Zub1MMdLJgWrO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series which aims to implement a
way to pass config entries via the environment while avoiding any
requirements to perform shell quoting on the user's side.

There's been quite some feedback on the first version, which I tried to
include in this version. Changes include:

    - I reworked how git detects which variables it should process.
      Instead of iterating from GIT_CONFIG_KEY_0 to $n until we find the
      first gap, this now uses a third environment variable
      GIT_CONFIG_COUNT which specifies show many environment config
      pairs should be processed. I've added this variable to the local
      environment variables, so that it's properly unset when moving
      between repos and printed by `git rev-parse --local-env-vars`.

    - Missing GIT_CONFIG_VALUE_$n keys for a given key are now treated
      as an error. The same is true for any environment value which
      should exist based on the value of GIT_CONFIG_COUNT.

    - I've changed priorities. The envvars are treated as command-level
      and as such override all values configured in files. But any
      explicit `git -c key=3Dvalue` will now override these envvars.

    - I've improved test coverage to also nail down priorities.

Patrick

Patrick Steinhardt (2):
  config: extract function to parse config pairs
  config: allow specifying config entries via envvar pairs

 Documentation/git-config.txt |   9 +++
 cache.h                      |   1 +
 config.c                     |  96 +++++++++++++++++++++++++-------
 environment.c                |   1 +
 t/t1300-config.sh            | 105 ++++++++++++++++++++++++++++++++++-
 5 files changed, 190 insertions(+), 22 deletions(-)

--=20
2.29.2


--wJ5Zub1MMdLJgWrO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl+85YUACgkQVbJhu7ck
PpQ0bQ/5Aa+IwaIujGz6BkPp1oArU46jjdmrbR+7aiOaf8xD+Pp16j6AFc7obOUS
UPCwi7b01BB+T4Fl+LSeE671R1aCS0tXVEVbyiX1IRKZ6R8B6CBf3rdI7lHT1+Xi
qineGUvRiZTdoKwjdGt5Si1LbyZkibhjiwBg4bL5JgXy64Sf6YX4r8EoztV52/9X
RLQoeAsWTi1vFF+xJOmir3kmUteKWQca/eAZKmsBXG1T6r8JKlk7cDztuy+wiCdn
OOSPzAZKCxMrKq/7ML0f3Zb89/fR5uht0P4l1YZyrURzS1qhJMSraEMkHGV1nO3T
L3V/4Tj97wUJZcWYDOQozUH3jr71xJVU1OK0M0p5xeCkNR9ihk/2mQZHZlmAyfAz
pZsX+hHmN7JjU+PFwp//ETjKFh77b9SO8ua13sj50qS3MAKSi7YNQZPWEcZjPPnw
dEonQM2w3fRDhTaTjgJYu7H+KAtqiI8FShfsRTLpJhIOcSsk+HMhpaRbk2zz7WGZ
KyGg0mEXTzweTiYan1mVFTx8a4YH2K5Vp6c3jlXlJjJVMcqJHJVjEO4chDhSdEwv
W+ZPaJYSpxg1MoFo3GAFHaKhsTTtaFJ9YPV8G0p0GPd28c5lu9I6m+qrg0+F3HFx
XqW8QTHvnlHrSEr5PN0atSMz+TTagWLb00Plbd93844+HbWcaSs=
=VQql
-----END PGP SIGNATURE-----

--wJ5Zub1MMdLJgWrO--
