Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED28C6FD18
	for <git@archiver.kernel.org>; Wed, 19 Apr 2023 12:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbjDSMcC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Apr 2023 08:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbjDSMbu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2023 08:31:50 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A8115A02
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 05:31:34 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 438CB320093C;
        Wed, 19 Apr 2023 08:31:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 19 Apr 2023 08:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681907493; x=1681993893; bh=f0
        lY46jX/9ioKReivKjVaIlQtLCXt+4Vs3frBIihva0=; b=NSFXdOrxAgjT8azQU3
        WSgN9BfKbzUZSxHinSFwzvjEGpUrvvlqo2AsndjuGGhogtEdPsig99V2BeewRjeo
        tuh2FWxme7V8+qTF7i4pyE4yhIQDNdjqK0xPftifEFVms+CkocMTPUTNa6b4C1/e
        dMlLw6WX4pZsn8Mnfcl7JfK8IIBD6EpXwHHayVGKxO3P/g4PtIcf/1YuWnzqIe1z
        RMHXr9Qfqt1PzzDfG6b2lSWlbNiLP6ZJsfc6WxjX8SP1tr8T1fl80v0U+DmmWOg8
        Lno50KrzwrsExZPsEozQ15eofHmaFq9fszi5nrH8W3cMVL9Rqvj2uvqeFruHL9Tq
        kmcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681907493; x=1681993893; bh=f0lY46jX/9ioK
        ReivKjVaIlQtLCXt+4Vs3frBIihva0=; b=MR3UbSz4NvUen836jTvtl2wFPHtqM
        LCHBUOK5RzX0qnb+N+OFWHP4QJt3QFURtqdFB9cBFFzse4Z4k2rkMYvf3eLrirbr
        18FK7qSP8lbH8FsGcUxCHLLvMwWE4jxoCROU5wFtlnLr0elYBOus5o0G7lpiEXsD
        Ig2Uvz6ogTqAPCRcSB6wZtQ/8ANUlTc0gTFO/F1AbKpj/p3qg+HPjwj1GbQgj6b4
        4nIomtBjQkKG3iVd7wVPepf4YyDCafW805/sKtYG/Dd5kd7enWEPnQDw/8lgiYmV
        fj0g7xOJoWPSYXPeF9To0tAt+0dr3K+59mcxtXmzXbIXsj+Axc+vwBrRQ==
X-ME-Sender: <xms:Jd8_ZG9GLZUmKoPizbw1cHH2wn0MBFDSh7yejVBH3xGdqIVC_thBrA>
    <xme:Jd8_ZGvT2Kk6f7F_uhfSjpD5EUdnhSvCyB_mzq-GwgigFTEUxClcnSO-gAXmwVq_5
    gShea_7yTJ8fGo_jA>
X-ME-Received: <xmr:Jd8_ZMB-SMdLYziDMkRpv1EM-ljUFEWrInBONsL-d7z7nJIPcf4KU5x9VMmsKStgQS4PPPz_PS8DSTBjOyDXRIBHVCP3hgEE_obrHS9QmWF_4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedttddgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Jd8_ZOfjoZne6DMJsgZbLk2Ph18jjeAGufbDWYFdGR1Y9V7mjKYlbA>
    <xmx:Jd8_ZLNX54MD5ukmayD8V9Q4eSjCFzl40EZcOq_yhd4EIyvO-BHUnQ>
    <xmx:Jd8_ZInFNZb-M5MNYmPd5g0CSq4MblZtslghKIWeHy_tBJYhMMZyCg>
    <xmx:Jd8_ZNWzHnGN2uu9AUTsDaBh4juNkIxJ-ZccZ2J8hdr5BFJBo7E9sQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Apr 2023 08:31:33 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id a6e6a129 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 19 Apr 2023 12:31:20 +0000 (UTC)
Date:   Wed, 19 Apr 2023 14:31:31 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 2/8] fetch: add a test to exercise invalid output formats
Message-ID: <29d2c58914b7270a4603cd65565c06ff74355e96.1681906948.git.ps@pks.im>
References: <cover.1681906948.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a8eGuKvTF9U4OsGn"
Content-Disposition: inline
In-Reply-To: <cover.1681906948.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--a8eGuKvTF9U4OsGn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add a testcase that exercises the logic when an invalid output format is
passed via the `fetch.output` configuration.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5574-fetch-output.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t5574-fetch-output.sh b/t/t5574-fetch-output.sh
index f91b654d38..0e45c27007 100755
--- a/t/t5574-fetch-output.sh
+++ b/t/t5574-fetch-output.sh
@@ -7,6 +7,23 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
 . ./test-lib.sh
=20
+test_expect_success 'fetch with invalid output format configuration' '
+	test_when_finished "rm -rf clone" &&
+	git clone . clone &&
+
+	test_must_fail git -C clone -c fetch.output=3D fetch origin >actual 2>&1 =
&&
+	cat >expect <<-EOF &&
+	fatal: invalid value for ${SQ}fetch.output${SQ}: ${SQ}${SQ}
+	EOF
+	test_cmp expect actual &&
+
+	test_must_fail git -C clone -c fetch.output=3Dgarbage fetch origin >actua=
l 2>&1 &&
+	cat >expect <<-EOF &&
+	fatal: invalid value for ${SQ}fetch.output${SQ}: ${SQ}garbage${SQ}
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'fetch aligned output' '
 	git clone . full-output &&
 	test_commit looooooooooooong-tag &&
--=20
2.40.0


--a8eGuKvTF9U4OsGn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ/3yIACgkQVbJhu7ck
PpRHeQ//UWEyKao0+G4XKBEZhub2VUNkXacZ/S8iCZ8D5QZQV4Z326s6e+SBm5bS
H/WCo7bQ1eVyixSXqQuRG5lQucq7n5lX4P+nzJQEgr7TVw1lIQjYnahqud2cReof
G7/hjicmF0oBvCTMCJgI5vFJdUl4te1AUzSCxz4Eqd5p3UUqWin6s4/uMbKJJRUC
hOsCD3ssOZB4qTU9DpYax9cim1sBsJVqOdAkIzIkorYwj0FviRs0bGQ0u3lGfeAT
gaM1GcDPLC+023cfFK2vyKAgrrOQK+h8meMtW5+XiHGy3Mxv+3dCiQkSf05FpLl7
zgSXRomUBPJas3j+2vA0w5/ErcGLfN740Yx//4rmBwmRAx7JB0x6yTXYhwhG1/l/
RHX7ENEBOgaDcFXvVjUc32XRM2UJ1nNWx3vKKSlStTkw9b/tLcLkBRcJtdZ6ofsF
nTpOmwHEJ1QX9uDhGUZUnMQfBxXMTaEEFD/q/WrxaLrC56hkJk0DgqUB+imsjaeo
j4g003NXMzoZEk2gGn7NNl9x9zzph/EUtxGc8QySFtj6OwerXJeSrh/RTT3hinu6
UZkvrEU7IW63gehZnW4qZrugPIAVzMiPD+Iv7MULcnpUBxDmwAPewFTebxYVm9u0
Cq1t8iOphRTVutJtUBgMq/khHTZgiWMkJh7IrywiEFf8z5jhYAA=
=bQmN
-----END PGP SIGNATURE-----

--a8eGuKvTF9U4OsGn--
