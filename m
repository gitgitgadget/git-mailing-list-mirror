Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCB6C77B7C
	for <git@archiver.kernel.org>; Tue,  9 May 2023 13:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235313AbjEINCU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 09:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235178AbjEINCR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 09:02:17 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973D33A99
        for <git@vger.kernel.org>; Tue,  9 May 2023 06:02:15 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 108015C0158;
        Tue,  9 May 2023 09:02:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 09 May 2023 09:02:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683637334; x=1683723734; bh=P5
        5KNQ7Wrb/Ngep+pffdFMKc0iTsF9dr+qcC0U6JShA=; b=YSCxXXX3dQgfV0X4YT
        2m1INJarZC52KZdDxCoI8kQMybw8CNnqdbGWPIGX/FATkDLUOE37W1eNOkcTJy2U
        UPQa2AzgS1npY8dn5Rta/3KV4J9cmUtVV65JJW5gX4FKP1KZcm/h+3oYzDVDE4h2
        suIazRhyLcGsUerxMxvVU6cc4FZ6X758fcEYPmLlzmVo0aAIc1fI5YC4dpChJpdZ
        B+c5LK3OKZs0YJAhJ8DmhUWztcv9CCpZ5rzFTUkvPZnHJLYo12OvPAZ1mq6r6jzn
        q7SZIqmqPo0LXmx0IOAulqJLZ9T8GVVyn37QdJ/zrer9dyDFXZ6bjgHFAGh8QVWI
        G9MQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683637334; x=1683723734; bh=P55KNQ7Wrb/Ng
        ep+pffdFMKc0iTsF9dr+qcC0U6JShA=; b=P2g3XdmPEdCjUjIpdm80LnlHzdCzm
        U5cvsP0ei3R0vEtmTYl+A13qlnVCZztoLVWBcZPn8Hj+JBhK62u8EnX2fFQvl8Zl
        NLiI+Mx8Zgvx0mPSK/ZcPtD+LPQJj2s3nVFl1bl80l1XX+cTIweob9UovymdiqZS
        Q5GA7KAGjdI9BuQrtdxn1X2OkxHvrWc0cAbGfs/1AOuQKZVhbai0bjv8rbtwDiyQ
        Pufc8a4n4rZeMNyvZwtby5x/fyTnKlRv/aNQ2r1OkYxaeFIqdrDO9B3rE5hv6tur
        d361jlEr5dvANI84z6uZN3YUlHkSk8Y+vbZssV+lc4whH0NF3DtP2W2qw==
X-ME-Sender: <xms:VkRaZL3PxUiafmuXRk-qpoydJrJYh9FyRl_ZwhUL0hd6i2KObKls8w>
    <xme:VkRaZKFdD2W_YFkVERM1I377S-WtB3QMINtweMjhAdYB86mc85d6EQ_zn7W6spzF0
    xokFi8TPYB-NpLBag>
X-ME-Received: <xmr:VkRaZL7bdbsYMl6dXFbAgfaYN5caenaoadvbCIe8vxBLSZgpqDcvyrFxOfsuuRw3X6zHTKQVog3jdsOnPMBlpjtBoOhxGeLrDrK4kf8-H3U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegtddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:VkRaZA2wplBoGb2zQA2HvuWcEVSjZGvA_ZODx7uEA2UG5o0WUIMPTQ>
    <xmx:VkRaZOFnZOcxEzhRI5SowhyP-HdE45WIkZ548-wH5m-b77aJSLerSg>
    <xmx:VkRaZB_9Zh01Mb9aNO_g8jpuSkvAbjev-9J4XZks1R-JW25ommEnMQ>
    <xmx:VkRaZKjeqx0OjrgHvuwk7rhiutgIz-3zZqdCPMKi3nTxGFIUiDnKPg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 May 2023 09:02:13 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 48eb30ed (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 9 May 2023 13:02:06 +0000 (UTC)
Date:   Tue, 9 May 2023 15:02:11 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v4 3/8] fetch: add a test to exercise invalid output formats
Message-ID: <006ea93afbef8742a823a9444d2b71785a9b4ec3.1683636885.git.ps@pks.im>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1683636885.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gmAcASkIeSBrESZq"
Content-Disposition: inline
In-Reply-To: <cover.1683636885.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--gmAcASkIeSBrESZq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add a testcase that exercises the logic when an invalid output format is
passed via the `fetch.output` configuration.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5574-fetch-output.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/t/t5574-fetch-output.sh b/t/t5574-fetch-output.sh
index f91b654d38..a09750d225 100755
--- a/t/t5574-fetch-output.sh
+++ b/t/t5574-fetch-output.sh
@@ -7,6 +7,25 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
 . ./test-lib.sh
=20
+test_expect_success 'fetch with invalid output format configuration' '
+	test_when_finished "rm -rf clone" &&
+	git clone . clone &&
+
+	test_must_fail git -C clone -c fetch.output=3D fetch origin >actual.out 2=
>actual.err &&
+	cat >expect <<-EOF &&
+	fatal: invalid value for ${SQ}fetch.output${SQ}: ${SQ}${SQ}
+	EOF
+	test_must_be_empty actual.out &&
+	test_cmp expect actual.err &&
+
+	test_must_fail git -C clone -c fetch.output=3Dgarbage fetch origin >actua=
l.out 2>actual.err &&
+	cat >expect <<-EOF &&
+	fatal: invalid value for ${SQ}fetch.output${SQ}: ${SQ}garbage${SQ}
+	EOF
+	test_must_be_empty actual.out &&
+	test_cmp expect actual.err
+'
+
 test_expect_success 'fetch aligned output' '
 	git clone . full-output &&
 	test_commit looooooooooooong-tag &&
--=20
2.40.1


--gmAcASkIeSBrESZq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRaRFIACgkQVbJhu7ck
PpReqRAAlCNRNWKRvdglWgmikEO1u5QLfVntrt8qD5myfol3v2RXlgqjGP2SDywA
ZQM7V8U1aavRNrRwFa8grWIUPeT3v+VIGv61JN2ryTqVsUofdi+SAJsHdqD7Wq20
YtUNtgWSEJIvDnzZXy5bFT5tgu247BGVAaUdR2WDYpTi18p2nhBwaXpum++0gZXB
rxrxB49n3Rwy54S0sOMj/ESX/mUXGV0j53SgeQ6X51z4J4ILNfdjYl3mOUryCPpa
miCWj9pJ4qKN/m4tB6q/Vit4VhJJnv8VHnCf7k8a2VDQhV5Igu8lxi09n86TsC05
NFDcRSg3oFybHAPZP87IQog2n5HleoGZUaUQyqdJSu8/3gSI0/2YYlOmrMMDnhFx
fsAFmEwuYkfXoZ+RVLZrov8LkRS+fRLP9HNMBnebYT9wqzEGCBdqOj481NPOC7fh
l0HE1PvFJv7lyVfE5XG3cEWRMVa7ZDb3UHSMrbKJwTDIlUg51wlo5E3yUMr1ZbU+
KGS0JU1yWLCfZFssB8E0TNURjbOp3YCPJEahwo/NxL1owRpbw44pQb91KrErNBxE
hqUX7tdhju2j6X1797Ne7AO+H2G1tCu/yoSY2t3BkbrtGAagH9F5Uhfh9FrX4DCu
LPS+G/xgMSqx0R3I1in+p9fKhh4vbHkq5CJtbhl65iUPIUxWAGM=
=sb5Y
-----END PGP SIGNATURE-----

--gmAcASkIeSBrESZq--
