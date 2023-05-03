Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DACC77B75
	for <git@archiver.kernel.org>; Wed,  3 May 2023 11:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjECLeu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 07:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjECLeq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 07:34:46 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C182A59D4
        for <git@vger.kernel.org>; Wed,  3 May 2023 04:34:31 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 057975C021B;
        Wed,  3 May 2023 07:34:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 03 May 2023 07:34:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683113670; x=1683200070; bh=7Z
        XBB83o0TfAP4yrgKYQ0hnbs65qks5wwuWiVjo+kM8=; b=CsgZO5DQxOYa3rVHrh
        lhcpl6W4X43troMAOfs2lbb+rJiiSfJRlVdFZl2ucY1Mw3U4cFw0y8lwUlWyGoIk
        l2BCBjJVzrRlaAWRcUkVeduDaPG4fW4Mok55+DQtEBVeOiiS/V6XhVXuL2Aui0F3
        T2D2TWxTqh8XsNUldWidPVKTNS8ixpVvW3GzPeu7gCppEohCd+oWPj+MYgS/ds0T
        c48LAlx9xpYU6Ev3Q2G4kDf1gc9x3rpmaDMZTSOX9OlHiWH1EcAbYEUDU1UEV2h9
        5x32IBjDa5y0RIQVcWsggpSnrin7oo86Irdgyqb17kd8uoor5hemcXfaiQAuHK+I
        9P0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683113670; x=1683200070; bh=7ZXBB83o0TfAP
        4yrgKYQ0hnbs65qks5wwuWiVjo+kM8=; b=PJSaNFQGOKY2f3kNmB/p582VeA+BP
        9qjPgZJhTmnbNev7S32WeFAv4jZB+JBkkyraS0aQ+HzLFNZ6QVfH0mM+s1pXd5X5
        x2vhTYWgEbHp5rU/OKrP2VeL8OzN+ioKjB5AVORIlruVAhwpbsts5uzBafhaEW9k
        nPNDxFxzqegQBs9ZurzNnU5gW3IjtfNufDA+rMjnm3dXnRQH41PLV7I16Fy2o76Q
        c+MJRfp7vlwNBDw338tkNZmmHy5nOV3JLXIcvEtxygmPz7McNnVjxJruKyAsOBam
        I9KTiRnHkVeXlxLRuE/bOWnHi1gSIe5Ec7wCFYnouKpM7r7Mtp4bR9wTQ==
X-ME-Sender: <xms:xkZSZHA7LUQMFzW9vPJ1KGTNXBsjUheP6CUiPiDn4KM9EDI1qsvCtQ>
    <xme:xkZSZNgK392xm0PdcjpKhRf0CUFuqP2PVXskJ7afEHi1TMSU78EH5qoV32xIu-3sI
    yl-EitdCLMhhiY6OA>
X-ME-Received: <xmr:xkZSZCkGNiK4Ap0TWkIxHi5hKpr1zolksuPlCelJkCFcb7iWcguYZYsRcnVjF6mCFNL0En3RFkKFRY_Z83MSL6zXWUG8cFQyMMa4wNJZS26y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvkedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:xkZSZJzhOJsSETXNL_gnsjPFwN-7oXEurfXQ-IEOsxo8PgCLvHPlbg>
    <xmx:xkZSZMT7_bHJopmjf032MbrynOeHQ4L0LG4MmbqVdoVFWnBRHm3qhw>
    <xmx:xkZSZMbm7IoNoV1viVVzW9369_qALKuIMrwwPh8hqY3omQHav9WI2Q>
    <xmx:xkZSZCPtUppNEfzl2kcgysPqMyUh99oWOdWOC_Vpa6e2qD5zGaFMAQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 May 2023 07:34:29 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 518a0207 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 3 May 2023 11:33:48 +0000 (UTC)
Date:   Wed, 3 May 2023 13:34:27 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v3 3/8] fetch: add a test to exercise invalid output formats
Message-ID: <78479922ac38eeb6a74f721da73b5437f62ae464.1683113177.git.ps@pks.im>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1683113177.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1VsoLRLHUiVcr5p8"
Content-Disposition: inline
In-Reply-To: <cover.1683113177.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--1VsoLRLHUiVcr5p8
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


--1VsoLRLHUiVcr5p8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRSRsIACgkQVbJhu7ck
PpQptw/+PhejEFYWpDgNd2J376NFAtPxbiO+t81EIUCY2fO1+Uyp5eZCPzlEve4r
vtJTopabpZ7cJI1uoPW9aRANMSVmh71+7RBAws2tG2wsn3zRG/umZ0tSFiRsetrE
EeYKxdY7DN4EmgJ9wZmmZHskCGhKbB2K+SW6HI7My9FmMITGKcsIgfUsylIsKE9V
TeIi35Q/WyJakMnJx88erEWm3wEkB+LOP/AQFMBtSTc9NXVkX2GzsiCYcZcrSzWQ
VI70D+kK4UUnvG0cwimHwEnW6sHaRaRwig6o7g/jMCTLJRjVRInKJx0E8kNFqeNO
mZGKkyhJ8qHSHeZyBsTRkVw8GDbqA1MWNcj9hVGPpGyp7Rz1W+U6TeW4w7XsakNt
4GbGhPvDkAMZJMRVWICH2Io5m0zzl1wjU7SwDOh7fploO39Qiru+7aLZHlZPks07
c7qV8FuIs6+XPdtvW4S5dYVx6HNbfcZUrAIIxEy4FO3BO3BH/ekwIggyVmuIdN74
SjVLGok4iMUqhvnQ+DjYte9Bv3afI9lvTXTr8eybx+BIW9ebZ0rEv5poyrWRdxP7
KQizU8sgu6YFA9YKY+BNT0KpSBxJsnz/tWsDvJ7L1PcDxWr84VvDwhVrPBuzaZV0
CDKZawniuZphfNncQpLWkex3J+vP+NXYpEggJyFazRzCviGFpQc=
=mdFG
-----END PGP SIGNATURE-----

--1VsoLRLHUiVcr5p8--
