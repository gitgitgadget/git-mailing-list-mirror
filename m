Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800C5C49EAB
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 05:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62CE461C34
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 05:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbhF1Ffk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 01:35:40 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:47561 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232119AbhF1Fff (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 28 Jun 2021 01:35:35 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id CFD985C0121;
        Mon, 28 Jun 2021 01:33:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 28 Jun 2021 01:33:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:mime-version:content-type; s=fm1;
         bh=2+4zyck/6BxUYtmPAHdZlzB+YvSMYeHmlkmmDkLDpsQ=; b=aG5IZhQkA9bH
        uzKGA1GPH7vqqeIHg3FfDLJiyR7PiOOwNlrU+vholiw6cP735YcpcZKoWvc1X/Yz
        URBmYDFGFkVQQE78ZI0msyuWexZyNvrNAO18Hkx6wMQk0Ws4UckJ9/XOzwF45KsQ
        eQ1sSGOE/eVZWBj77cb9BXM+ihg9feLlXfArBa3rwtA6LhHOiNANpEPC5UDe8Xyg
        invLzduBTlMNoaxvBthSVNXzHjTA1gQOQFk1M6MokqDN17MWOvl1QtHmS/jOWRjf
        V+8iBrTZKCn043YnNb43A7CUp+bb5FQAUiv1z7qDZT/LrmLUoFEpNEKeLPVOsl1w
        xONkZJqlaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=2+4zyck/6BxUYtmPAHdZlzB+YvSMY
        eHmlkmmDkLDpsQ=; b=csNCRIal7o9MxKGbTZuRW1ZyijAxoZtToaqdVj2W3gQT8
        JvGq+s9J57PdQzaOipRFM1nCdZ7+Tjhx33DMxE+9gmJPf+o03GwEJpXkIlCvdLc+
        fMejufxQIRCbT+A9v90lbB+jousOjTpuBCoKRdk6HKKlWvISORX+vNsWLvg6ogim
        AHoXKh0iu04OSrF4JNO3eUeUgnpjxczrA5THS+eqAzCvzmQzACcBe8rvT9z/cX5J
        qjNNSZsV80eyYRj2FFaDoeHR6/TKc+A9yF3BLdSGeoOo79pp1diyDoFi3ocQOkbU
        i93d5CXCAb9J5JRY4uYL9Oi22MXY7MM8IRjYYi5Uw==
X-ME-Sender: <xms:FF_ZYDvtBOaQN-lHruzrKyEP72JD3dtQKGMzdBbXNJgumwAYZFO4HA>
    <xme:FF_ZYEcgloG03imL9HhjrKl5w-JiN4T1VUE12r5JZImQfOldLRUKS-LaehVlamB9C
    0k4WAGkPl2Cwsd3VA>
X-ME-Received: <xmr:FF_ZYGzgv1iBiTnEnIH81GIOVl5qtaDO6tV5PmLExwXVf6DI9jWBHJKSHEZx8wD1lQVMFKz4Rgb2AKI8HZbGB6QGzj60SCisEuEiHCgX1IsE5DPp-GAUN0c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeehfedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfggtggusehgtderredttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ejieefvdeuleffgfejudffvdeghfeigfejgfdvvdefudevffefveffhffgkeeiffenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhm
X-ME-Proxy: <xmx:FF_ZYCMCx_243mp1I31m4MM7pJQY6OZ7DxOnSmO36wJsZTUNFZCS_g>
    <xmx:FF_ZYD8fL2hrTjj-uoJdB-iyO9Pu6rgCMC0U3t10Tsh02t4X4q8yJg>
    <xmx:FF_ZYCWEHaPYUZkJaRQTvSny_P1OavAtjHuKC012wBAX0cCr1qCKvA>
    <xmx:FF_ZYOlJE17F1ZzM_0tyGuVArXNuBuKlpamBB_snsjY28mrYDq3KuA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jun 2021 01:33:07 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 48921823 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 28 Jun 2021 05:33:03 +0000 (UTC)
Date:   Mon, 28 Jun 2021 07:33:02 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/3] Speed up connectivity checks via bitmaps
Message-ID: <cover.1624858240.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qgHMaKSpRsIEefdn"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--qgHMaKSpRsIEefdn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is version 2 of my patch series which tries to speed up
connectivity checks in git-receive-pack(1).

This version is a complete rewrite after my initial approach of using
the quarantine directory has been shot down due to changes in semantics.
This second version is thus an alternative approach using bitmaps. The
implementation is quite simple: if we have a bitmap, then we walk the
new tips until we hit a bitmapped object. Given that bitmapped objects
are by definition fully connected, we can then be sure that all pushed
tips are, too.

I'm not sure I'm happy with results in this series. While it does show a
speedup in the area I'm trying to optimize (repos with many refs), there
are two things which make me hesitant:

    - First, there seems to be significant overhead in loading the
      packfile. This is something Peff has already pointed out in=20
      <YMypONmXt142dhbb@coredump.intra.peff.net> [1].

    - In repos which have out-of-date bitmaps, we're potentially going
      to walk a lot more objects than we used to.

Taking these two issues together, this version is probably more of a
request for comments: do we want to make above tradeoffs? Are there
better alternatives? Any input is welcome.

Patrick

Patrick Steinhardt (3):
  p5400: add perf tests for git-receive-pack(1)
  receive-pack: skip connectivity checks on delete-only commands
  connected: implement connectivity check using bitmaps

 builtin/receive-pack.c       |  49 ++++++++-----
 connected.c                  | 136 +++++++++++++++++++++++++++++++++++
 pack-bitmap.c                |   4 +-
 pack-bitmap.h                |   2 +
 t/perf/p5400-receive-pack.sh |  97 +++++++++++++++++++++++++
 5 files changed, 267 insertions(+), 21 deletions(-)
 create mode 100755 t/perf/p5400-receive-pack.sh

--=20
2.32.0


--qgHMaKSpRsIEefdn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmDZXw0ACgkQVbJhu7ck
PpQRzxAAiGbejrjhOFVqhRGfKohofFyBBtHbEPUOAU35hHdterADjTpJA1Fq61Vz
JxWpGEsWX39uovC6XOdRTuywBI7MliiZmYK5rGPc79I+J7Fo5I97Xe96fGPq7cVu
7L3igwydeyaa6bXa9kgDrqNrAtaT0zy8jL9NjMPkn/NXnQvw8A5DnBlrWKEdUhnk
cwwgyEzekgwMWGMLsP4VdDp+1JlTT4k0PSsH+i1eoa8z7rk7NSJ6ZzYCZM6Tvfhk
T6kTRyuxdeY8h0H6fEju2F4H6nvmTxxqGtMk45RBK7oWQ+GTwEjsBaVbEJ0WCGLO
HEQncHUUeOth13p0XNCs5yqHC4mNLHSHaTJJSQm7jI4CDLVQwlHJPZhATjFnoqbc
JSCCAO4QznGA9K7MlNGzjN5gV3nGdS7FS8sYtSy4bmA+hz+P4mA1AuQqRlHqGOMV
o9xqTftrktBfRoEbQLyQJLtobqfC5/01XElRQPzMhoA0kx4Oz2kB8DHzKU/J6xNs
aPblN5J0Gddla1D42m32VxOUyoPnYU8763UH0w2yBm5qGv8DskwaEoleuMgxYtZg
AJieu398fEAvoo62wTe3mgy+q81ZnVFwAE07djEto19ln7Z9OPGuvar72MrQgQaW
Wo4H3h08jLHkdWMi/NZSGYmU1CwS0CBSUN+ev6CTdzkFG/zRCo0=
=rC/b
-----END PGP SIGNATURE-----

--qgHMaKSpRsIEefdn--
