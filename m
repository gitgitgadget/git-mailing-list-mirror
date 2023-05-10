Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C003C77B7D
	for <git@archiver.kernel.org>; Wed, 10 May 2023 12:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236931AbjEJMe1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 08:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237037AbjEJMeR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 08:34:17 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F0D8A7D
        for <git@vger.kernel.org>; Wed, 10 May 2023 05:34:15 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id A32053200918;
        Wed, 10 May 2023 08:34:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 10 May 2023 08:34:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683722054; x=1683808454; bh=LG
        o9vVT1L7kR3aHZ6e9SNBL392g2PWuQlN2grdCeRnc=; b=aRVS+S5PKXAQE2+2l8
        dGo7o55d44IYT/rbpO3etQEX0NgVJV20hLTatw/KZv6ilSnZCjRvEo75TudYvhjD
        QzyEK47RwPEnN0vkwxrfINRgqKT4DT5DMXLzETeCr/59e9o61uAXCykQL9/DV2IB
        F26zn30GDvtKwwSd1KpstGJUFAE+S0IDj0zbxbGHj6lZrOqpJ91y/6S+Zk30NxtP
        kYYhxRiuFhbpqTPmM7QrtdQLspsfE3+iU69Q9RY8l6OAOfSM4avvmNUb7IGO4hxZ
        a5sibI8YLPz5b8CSazEu9mG08COkAdGZR3sux3bog/12BS2serZN4dmlmsoFbdEg
        J9lQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683722054; x=1683808454; bh=LGo9vVT1L7kR3
        aHZ6e9SNBL392g2PWuQlN2grdCeRnc=; b=csnQWbnin0yKGANCL50rseB4BO3TF
        4Aa/cwAOep7CXCIqeURptY5Ucw4+9oppbtRSFyAr1uzaYnvcS/LgEMEu9cAGqeej
        mFcXOyvySh1vVgBaq84czxzNDGQNbJCejpWSOKmXFhAfz3/b3bP5xL3Vw2Gcqoq8
        mQnBUyChOLT2tA6VGaVxDNf9wm/gmHKjFSiE7FtfYVUtvqVyl7Io78GJ97yxa/B+
        TD5tHkNU+Y55zA1wPwANPJ0UjumJrqmpude4UyM7TOXwhFAECzwmOyOMrC0N4VOO
        gXPZmV+cRA92M9j78Y9OPpAccODXAufKUkjavOMUcGlpcYm7B/LdB98eg==
X-ME-Sender: <xms:Ro9bZDZPa51cLB_KnMIGck97DIL_-ShiYuwsSll2fZVJV4V9xO4Dcw>
    <xme:Ro9bZCZamZEZiGLtaeP8SO6aeqIErBh1X35ukVBAryTFkfyQivACQlC_we8vJ535t
    URdzVsTo8gvhdqpYQ>
X-ME-Received: <xmr:Ro9bZF_esctHeg60Htz1rV2SMWEGKO5aai-UNYoLn4Tf6fjfcjV1f6SSYD1_FeJ2MzKm-fQyWa0IoaE2b0pgrRtdcFSU6VXnN6CkmD3VDxKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegiedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Ro9bZJp0_C4wMuvhkBA5R3SLgBJmKM1BWWrY5-mrjhn2IW-sSlTSDw>
    <xmx:Ro9bZOrFexga0qQDX0BpMsfkbs06YUSHD-8V34xc-ZmotUuYjh-Alg>
    <xmx:Ro9bZPQcIoFvNg1RJDCnBKh5hUz6HZEHOFFZFj9cugQTvbzjSBtqtA>
    <xmx:Ro9bZHkvg8bVnJoUWn5IOOR_MRJ3sEQaWIxSKXFlYN9wMB8ZbJ00iw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 May 2023 08:34:12 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id b49b9302 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 10 May 2023 12:34:03 +0000 (UTC)
Date:   Wed, 10 May 2023 14:34:11 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v5 3/9] fetch: add a test to exercise invalid output formats
Message-ID: <d503c425fe0298b2c8539834f2e3852dea096803.1683721293.git.ps@pks.im>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1683721293.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5iCvEcT2hQNQlYyc"
Content-Disposition: inline
In-Reply-To: <cover.1683721293.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5iCvEcT2hQNQlYyc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add a testcase that exercises the logic when an invalid output format is
passed via the `fetch.output` configuration.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5574-fetch-output.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/t/t5574-fetch-output.sh b/t/t5574-fetch-output.sh
index f91b654d38..8a344e6790 100755
--- a/t/t5574-fetch-output.sh
+++ b/t/t5574-fetch-output.sh
@@ -7,6 +7,30 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
 . ./test-lib.sh
=20
+test_expect_success 'fetch with invalid output format configuration' '
+	test_when_finished "rm -rf clone" &&
+	git clone . clone &&
+
+	test_must_fail git -C clone -c fetch.output fetch origin 2>actual.err &&
+	cat >expect <<-EOF &&
+	error: missing value for ${SQ}fetch.output${SQ}
+	fatal: unable to parse ${SQ}fetch.output${SQ} from command-line config
+	EOF
+	test_cmp expect actual.err &&
+
+	test_must_fail git -C clone -c fetch.output=3D fetch origin 2>actual.err =
&&
+	cat >expect <<-EOF &&
+	fatal: invalid value for ${SQ}fetch.output${SQ}: ${SQ}${SQ}
+	EOF
+	test_cmp expect actual.err &&
+
+	test_must_fail git -C clone -c fetch.output=3Dgarbage fetch origin 2>actu=
al.err &&
+	cat >expect <<-EOF &&
+	fatal: invalid value for ${SQ}fetch.output${SQ}: ${SQ}garbage${SQ}
+	EOF
+	test_cmp expect actual.err
+'
+
 test_expect_success 'fetch aligned output' '
 	git clone . full-output &&
 	test_commit looooooooooooong-tag &&
--=20
2.40.1


--5iCvEcT2hQNQlYyc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRbj0IACgkQVbJhu7ck
PpS8jw/+J4zNcdEZzn5b1lKtOdquOc+xzjq2NcUYY1oR4VR+tEcd/iX5ELUMqkBd
HoePEm5T8ZXoPC8/kIsOyhjRIpNvS8z9ocH1iyRR2ceW2Rrfaqe+NRFWqZo8oFMa
Ys5Ank5AxIQFF2GOX2LXbM9s62Zn8u8ZHi3mJrh3tqqj3hrYsCVR+zHneidC8UpV
ByDDuKid+3TvCtZXkSoMdIfxoiF3qxgkmkLDrqtZsN8swXRHP0UPHIXA8JPSOZB7
ajamUAQw48W0iKHq1xy5CF/rAo7WXnldoh6+VCFb7381UOn1HM82vzf2m/NHiHXb
i1NH1vNi45Fm/+JtuiJKI738YmszEAKrPBnoDu1HSbKCiARKFvpormfI0RrwzCg4
vTVXkX5XA6Ll1lTfJrWjJot5AN5uFrDRuW7nSLP6fJ8e1TGrMAXNGKJ0yRMRtPzC
AemsyAlzb35Q4I77ZLDSgEylwS40JqXWDMlhdeGDM4CYlvISPqLQNzB9eC1QS0MI
c16jOcQy0Jm9lK31hed9Zb4EmNghOA3w98XazaAOX2B89m0xg72yVt0ZGtNnOAWf
/Z1EOYxfXKr4QhkyYLkMbPwohKVxO1y3WEaRVo3hRrvGzft0H2vECHBe5DKlYvbb
WqeULat3NO0azrTZ2Pvpz3BiLqOEHapJKN+/xDkl4Xs2UGSZPF4=
=Kgmf
-----END PGP SIGNATURE-----

--5iCvEcT2hQNQlYyc--
