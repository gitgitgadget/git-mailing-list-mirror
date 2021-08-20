Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F261C4320A
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 10:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 080D0610FA
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 10:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238169AbhHTKJS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 06:09:18 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:45171 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232572AbhHTKJN (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 20 Aug 2021 06:09:13 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 009335C0191;
        Fri, 20 Aug 2021 06:08:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 20 Aug 2021 06:08:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:mime-version:content-type; s=fm1;
         bh=A5m0byyjozCclq7+iklUtNZ5MJEzjB2953ohNHh4Lfc=; b=GzCXnnBelsVO
        PEa8SB7zjLxxGN1kMmgt19OybgGfJvlVN77icabAR89I8y+m1BF60Thp3CSl9ERp
        me8OlDQK0GY/tKN2e5bz82dhWonNjDtwpuv0ezUUNaUxffmCI4lEVUD26pyEJLfA
        gWlVlAA1eZ6Bf+OSjbv1mZ9VQbS392+Ad2TjFrVg7+EFUE1G5AH0pafIiEpS+aqs
        k94OW/3cDbSa3TfIGtB+j3wx6HksEcAyuRulhDKL8A9Z/Qif3d1yn/GWY0QHiXQA
        61P8A1eEX24L+HfsQbPUkyvHWp0ce74BKIPznh9Hexj1UJsBk+NGmbS0mpkeLRFn
        fpZKop7Kmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=A5m0byyjozCclq7+iklUtNZ5MJEzj
        B2953ohNHh4Lfc=; b=ftVLy3ZvzYfVTF+GuiS7WuYnyI1bgSJNVWoTS2tMfjlWl
        mPyPCM5UDBcI7qRnidH/JmC9WJGLesgU1yMFQXJL2yy5nUfug/hTBO6gj51mxGoj
        vm54Jami+2boR5UB8cJR+uWQ5CVhZLfbWYaawqG19bKM5zU9pgVEZTraxiNo9ybe
        pDGCAfAClQ0xu+N6Ir6AqLkQjD5c71HhZ30BOwYw6+acDWhWrbwEBX33lU+T47yV
        g0VqfnGunlsV0SXyfHMHVXo2uegGwRPVrkOaVZjZRxk56eXNr9pA7/wyfzMCg4A/
        G1djOsI8lWB/fIi049BrBBZcZPPmp4xWSTvUDvEvA==
X-ME-Sender: <xms:In8fYZ966O6rApFJDvclrGdH8uZ1PAlpofFEZWwGqJlY3FVkSw0yCQ>
    <xme:In8fYdsrscscVz8JRnZuEnNZdgs3WjNdNFUHwLo7FOFApH1LTN8TmzwRtLclYvq9M
    F9iyIqS4xKr7Z8h-Q>
X-ME-Received: <xmr:In8fYXDGGjdJvawCBV6UJuMp871MfwutyHWMYBoNvIZpM2RNqkEXjzd2VM0-TbUV7fQwTB5NxNQQB1zEf02jwBKRDYCNtjZfzbA7PoY3XUPjH9yNv95iqx8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleelgddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfggtggusehgtderredttd
    dvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeevheduffduteetgfdvffegieeljeelfeetgfdtvd
    duueduteetgfeivdehudelgeenucffohhmrghinhepphhkshdrihhmnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:In8fYdeJ0th_HUGQ-WKzmKZHvSj_fKRnPV0mAd4O4Hl8046nhc4Ivw>
    <xmx:In8fYeOe8zlpI94KUoRYSJtpLuhUmzSQjgUTSIP1ux5LuRtaVJDgdA>
    <xmx:In8fYfk0pWER9isuptbogDtUvQs0wJpTtMCSycvRVRivinUl84vRvg>
    <xmx:In8fYXaFsHiksxayZ1LnNMBfl0xSDsVHQJ_2JOortLWO-L_K0VrndQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Aug 2021 06:08:33 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id b493f66e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 20 Aug 2021 10:08:25 +0000 (UTC)
Date:   Fri, 20 Aug 2021 12:08:24 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/6] Speed up mirror-fetches with many refs
Message-ID: <cover.1629452412.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ye9SX6VEUZAjJc6v"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ye9SX6VEUZAjJc6v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I've taken another look at fetches in the context of repos with a huge
amount of refs. This time around, I've taken a look at mirror fetches:
in our notorious repo with 2.3M refs, these mirror fetches can take up
to several minutes of time even if there are no changes at all.

As it turns out, many of the issues are again caused by loading and
dereferencing refs. This patch series thus mostly focusses on optimizing
the patterns there, where the biggest win is to opportunistically load
refs via commit-graphs. The following numbers were all calculated for a
mirror-fetch of above 2.3M refs repo on the local disk:

    - Patch 1 speeds up the way we look up commits when appending to
      FETCH_HEAD via the commit-graph, resulting in a ~40% speedup.

    - Patch 2 optimizes the way we check for object existence for a 7%
      speedup.

    - Patch 3 is a cleanup patch which changes the iterator functions
      passed to our connectivity checks. I was hoping for a speedup
      given that we can now avoid copying objects (which could have an
      effect with 2.3M copied OIDs), but unfortunately it didn't. In any
      case, I still think that the end result is much cleaner.

    - Patch 4 optimizes git-fetch-pack(1) to use the commit-graph. This
      is a small win of about ~2%. It's debatable whether this patch is
      worth it.

    - Patch 5 is a preparatory commit which refactors `fetch_refs()` to
      be more readily extendable.

    - Patch 6 optimizes an edge case where we're doing two connectivity
      checks even if the first connectivity check noticed we already had
      all objects locally available, skipping the fetch. This brings a
      15% speedup.

In combination with my previous optimizations for git-fetch-pack(1) and
the connectivity check, this improves performance from 71s
(ps/fetch-pack-load-refs-optim), to 54s (ps/connectivity-optim) to 26s
(this series).

Note that this series depends on ps/connectivity-optim and thus only
applies on top of next.

Patrick

[1]: <08519b8ab6f395cffbcd5e530bfba6aaf64241a2.1628085347.git.ps@pks.im>


Patrick Steinhardt (6):
  fetch: speed up lookup of want refs via commit-graph
  fetch: avoid unpacking headers in object existence check
  connected: refactor iterator to return next object ID directly
  fetch-pack: optimize loading of refs via commit graph
  fetch: refactor fetch refs to be more extendable
  fetch: avoid second connectivity check if we already have all objects

 builtin/clone.c        |  8 ++--
 builtin/fetch.c        | 84 +++++++++++++++++++++++-------------------
 builtin/receive-pack.c | 17 ++++-----
 connected.c            | 15 ++++----
 connected.h            |  2 +-
 fetch-pack.c           | 14 ++++---
 6 files changed, 74 insertions(+), 66 deletions(-)

--=20
2.33.0


--ye9SX6VEUZAjJc6v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEffxcACgkQVbJhu7ck
PpTLkg//bqguNxmY1O+EBnJMTQ1DtAwDf9gFa/5h1pEGDtViE80f20haJ4Vsp7Vd
hUgBEb54mKzraLfESEk30XCWFeWst9lAePpsgHY2Z+Ft7fv8Tx3DF2iKX/IcB3qn
yxtT/KeblJPdmOjPpCc6G+vO+Y7AqpuE2Ujp7K7OQP4A1oCxz+b1Vyy6sbSE9zjU
LS0Uur0snNjO1H03Odc/niVzMbTCq0w+fhViwvzWz24ozX1cNOwI1orEbethrmfh
dSioV2GaWEEVWE+GyXrB1m5Zs23WvsFMZV730jzaNnIMumIKT56ds7EbM0d0mJ1j
QWWiPNFqlQcnx+AjRFwWHcIMsOwXyuRRaEutifvLfbqfVlq+SXaUpbbGBO/IKRKe
G3VGvw3PPblO6rpJZx6XtbaqyBgSLdm4N/UiuGSvxUZ94zyKq/r1ZdB3HnjAXjon
2kTQWKWxew52mi+Hbc3842SeHfQFfA4HfMqDF7ZOGTn+iIN2Bu5Z4GO91yVw7DX9
mS9ZjeBvFlTlwa6AmMR7pYLdJ/6ZV1K+FelnAqnHC+Xm7kuXfIEOwqPkTe3FLE+J
YgJj2Z+6cj/LE5XR2BwIFs/i2PsP7SFCT4ZhmUd/vfMWtdRvLSMuzvZnrGuFVH6K
ugvRMfN/Uxqkix/i54dYWk8oYggUaqGN7Sdy7YbzwBqBFyJN+PA=
=dLGD
-----END PGP SIGNATURE-----

--ye9SX6VEUZAjJc6v--
