Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8545C77B71
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 06:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjDNGCO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 02:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDNGCD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 02:02:03 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D0659C9
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 23:02:02 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 2CAE15C0150;
        Fri, 14 Apr 2023 02:02:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 14 Apr 2023 02:02:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681452122; x=1681538522; bh=2+
        Z//fni4z4zAKjmn/l+zlBBaMvmCnevOWQin3uqTfA=; b=oOnATzeBjZ1ReFOJn0
        dDbf7neVJhKqXdoJWEMp5HucaMA1/6ur3L9CLadA6UIhEw1m2dBKwC4aOaGtP2nV
        V01mWIR7Qv0bbQ9Di1qCITX0n6m4VY/W0eEzYOVVNW48XDXHi3u9CS7DofAXhC6S
        IzLThzaBIHbFAEsCbUBvWj7g6iS3r8IBXmeAeGKfXEZ4n8kt/MmauDcrRDlA6Syv
        8O3vPPE7B/gF8MXJ/tgA4cGAeg4xgYar4xfJzfasoLQeHRq8EHGO0Q2uYsbsSNNp
        scLROrtHEH7658nG5iEek9TV3oNcwW93bpY8K7tKWKDeY91oZFHRXktDiKdQrI+5
        b3JQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681452122; x=1681538522; bh=2+Z//fni4z4zA
        Kjmn/l+zlBBaMvmCnevOWQin3uqTfA=; b=JXIy542iYaGAJ3cGAa8gXrcrf2Z1q
        7pEa0x8Use720xOLrajPMD8HnMw/ILQKEfIGNF/TMOdtJkwmHsERwHqxkJ2luE00
        7QE1s9khKGO+EUHw3bfrQDCFwqoYfgECw+etCv0u8DkjmIhE8jlzQaxNp2ed4Vvu
        WpA/HWZwdpchuJG9oVGkXI2H2nBWVKvqajkBQkNiNr0qX9cF3caCzllKqjRvee6t
        WncVDYp/0H3H+KiGK/0xhtMSh1tu92M7Hpcvlfp8ALMkNzyCWxsZxbQg4kfu4RLC
        gjGb0/huEp0Y2Fcs/euxTUJVZlQS8v44wVTeVaaugRZrQsL1VSsKncwIg==
X-ME-Sender: <xms:Wew4ZFjcJFkLVmjZYm9FnG0RQoURT9Uj1ao0k7_DshSTSdF8q-gxQw>
    <xme:Wew4ZKD9vstNfj1qP785YxjOv3DMt-SPcgrxM7HPy3A8TWJ9Zt1N-hGOOpZgtmXgD
    upvQKd4CESD5CvmTA>
X-ME-Received: <xmr:Wew4ZFEVEN-d5A41fFVieLZADRumWotfOO8lVa3Pgljvp3Om5aKX8DJqUkn-9eb0oxafmeADBz0OwASzEWD0EBTAOlnZq0wCh9fOXWTYo5SnzGk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekledguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Wuw4ZKRFj5ZgXrGGBMgcMKi5_6tDuZAPkB6wsHtgcOpmLVwQBDkpMQ>
    <xmx:Wuw4ZCzDBXurDddBznmRwH896snCgaVVvHYxfyMkyIsRzWOfQGgubg>
    <xmx:Wuw4ZA4-RCRk9Bp3zn5lMIdOATVtJGyBSDOA-m8W1EqP2No5Stis3A>
    <xmx:Wuw4ZG8XBZ-MZ5NkKpFeJ_JcTxvbmFR_8rxay1gPOB5ZgR99jdUMFQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Apr 2023 02:02:00 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 39d867ff (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 14 Apr 2023 06:01:59 +0000 (UTC)
Date:   Fri, 14 Apr 2023 08:01:59 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, peff@peff.net,
        dstolee@microsoft.com, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 07/10] pack-objects: extend test coverage of
 `--stdin-packs` with alternates
Message-ID: <f9d490f5b8bb41b93543bff46ea3d446fa07c2ee.1681452028.git.ps@pks.im>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <cover.1681452028.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o5XVuSuIkqVSt9b+"
Content-Disposition: inline
In-Reply-To: <cover.1681452028.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--o5XVuSuIkqVSt9b+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We don't have any tests that verify that git-pack-objects(1) works with
`--stdin-packs` when combined with alternate object directories. Add
some to make sure that the basic functionality works as expected.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5331-pack-objects-stdin.sh | 48 +++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/t/t5331-pack-objects-stdin.sh b/t/t5331-pack-objects-stdin.sh
index 3ef736ec05..acab31667a 100755
--- a/t/t5331-pack-objects-stdin.sh
+++ b/t/t5331-pack-objects-stdin.sh
@@ -189,4 +189,52 @@ test_expect_success 'pack-objects --stdin with same pa=
ckfile excluded and includ
 	)
 '
=20
+test_expect_success 'pack-objects --stdin with packfiles from alternate ob=
ject database' '
+	test_when_finished "rm -fr shared member" &&
+
+	# Set up a shared repository with a single packfile.
+	git init shared &&
+	test_commit -C shared "shared-objects" &&
+	git -C shared repack -ad &&
+	basename shared/.git/objects/pack/pack-*.pack >packfile &&
+
+	# Set up a repository that is connected to the shared repository. This
+	# repository has no objects on its own, but we still expect to be able
+	# to pack objects from its alternate.
+	git clone --shared shared member &&
+	git -C member pack-objects --stdin-packs generated-pack <packfile &&
+	test_cmp shared/.git/objects/pack/pack-*.pack member/generated-pack-*.pack
+'
+
+test_expect_success 'pack-objects --stdin with packfiles from main and alt=
ernate object database' '
+	test_when_finished "rm -fr shared member" &&
+
+	# Set up a shared repository with a single packfile.
+	git init shared &&
+	test_commit -C shared "shared-commit" &&
+	git -C shared repack -ad &&
+
+	# Set up a repository that is connected to the shared repository. This
+	# repository has a second packfile so that we can verify that it is
+	# possible to write packs that include packfiles from different object
+	# databases.
+	git clone --shared shared member &&
+	test_commit -C member "local-commit" &&
+	git -C member repack -dl &&
+
+	{
+		basename shared/.git/objects/pack/pack-*.pack &&
+		basename member/.git/objects/pack/pack-*.pack
+	} >packfiles &&
+
+	{
+		packed_objects shared/.git/objects/pack/pack-*.idx &&
+		packed_objects member/.git/objects/pack/pack-*.idx
+	} | sort >expected-objects &&
+
+	git -C member pack-objects --stdin-packs generated-pack <packfiles &&
+	packed_objects member/generated-pack-*.idx >actual-objects &&
+	test_cmp expected-objects actual-objects
+'
+
 test_done
--=20
2.40.0


--o5XVuSuIkqVSt9b+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ47FYACgkQVbJhu7ck
PpTGfA/8CtQXggKDoHHgWQA/IEjAyzZhsUYjyhCCraxVjuP5af5X5BPiCPa/Wer6
fPORqYCkdj4BoRq/8oS+51QV06OXKWlbDJsEgwUhxSwY5OmXC3CEJmne4cwKhlPW
37lA89Eo31MQNY1AIV6rBbfbgNNoPAcPpY0Aed15NYdlJSIE8aJOlQgJYniII7Sv
FXHDacQUVFeWXmzDNVZq1xpQ9YwVb+SGCxKdrGNnz2cB5Bq/8xQ7F80+AaF+zVa+
9msq60WmTrh4HhyvjdksSp0TgknNXiLSJIFLJI4CjfR44K+eJ0REw5RWxKGMDa0h
wkX8BcqaaA3bogyIJ2BnGapJbcmX6Fe7/1V+APVDO8+a9H1dK2Lf5z/ZOLrYgdQF
ehcQNzCMZMtam193IIBE4euDOfDWP5GvV9u4SLZjVRHuSuMeIH9FSRAO86yW2wyR
R4fdAkBUoC70XrfaQr4LKWkaVE4bei9OAVU+SdbXMBBhTVLCZZfBJPoueXiFr6Qx
eiUZj6ELm8bQPlCbDrzNmRVup+U8uxeNKkkFbIuPmNtSBg6Ds12XZQvCyfrQU8Qf
ESI38rOEsQD9/797pMaa0nEctlovJyNhmKL21PUq5eqIv67xhnOFFAvTylXuRW5j
s+ZOqEdQSQ7U0ZSkqlplLrBQXjkbBOv9fRnJUzLfabcUXWaou9g=
=TVnY
-----END PGP SIGNATURE-----

--o5XVuSuIkqVSt9b+--
