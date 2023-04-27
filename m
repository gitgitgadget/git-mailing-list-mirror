Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D298AC77B73
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 11:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243693AbjD0LN3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 07:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243051AbjD0LNR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 07:13:17 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B36D44B9
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 04:13:16 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 9A34F5C0232;
        Thu, 27 Apr 2023 07:13:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 27 Apr 2023 07:13:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1682593995; x=1682680395; bh=7q
        MNBqxjQ/PwtwPViD44HUP10UcferELzA/tDp9RlBM=; b=oH/kYynqXk/43f9H+b
        qaPT+cYpbd9FrSNkyYbCkclWEwciRQwlDcevrNK660cs1ziP6k4BFH1oXOQ/6TLE
        5Dk/kLxJbXkL2vRYUBWLcHViXmhay4yWPfBXz9QEHMLNagxPhEM4leR3MTACdHps
        PnMP7ZeM4PSNb7dCdnTopwfxaDS51ObWZSye+T8rE1htqNhSEX16JK2D5UhIC84K
        qlSS6Gg4auJdafh6LUhGJnPJMByfb9hYd3ThVfHZFDpOSjXdEt1MeTjgzIgDAIpg
        Xm+t38EKt7kY/Dt+BWhTLcQ/8MaqcGe/wfxMH4oF2etNdsF/pwjmxmWOIwT/Umrc
        g1Gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682593995; x=1682680395; bh=7qMNBqxjQ/Pwt
        wPViD44HUP10UcferELzA/tDp9RlBM=; b=SDUygrQndtN7D0m7fcNANDlypTWiC
        f/KwdQmB0n0sLidrDMcJkkXCLW0omUTJYBD4siwmZ1oK+FAYkucTa4mp7bZVX1bc
        cadTcLsevIHHwV/rvlPdKcLRB7LIlb+l91l2lsqgbSVw5PPLgKWHtV9CfEwhNJIM
        pX0QpAMHdjaA8pFhVnxl0ELHqQPbR3VUndizUO58fX8rUzQlrk6iqkfSA9+ZZ7aP
        piOKGBTtd7pHxhcy0IFNAm7BRos87ajdPEYgngBNlWALGXVoHOe9O2iIEQF4H2wt
        HSJ+EkVsNEnQzg5tZYrS18LDzbJTrGriCBpG78uw3oXlgb6aQptuAf0JQ==
X-ME-Sender: <xms:y1hKZOm1Lv9Sjb31iyuD2lvoh_bzF3kEKqvYFyChdnqcHBScwgzXGA>
    <xme:y1hKZF3mFKeqBLz6JQeqWhu_nrtubGtO2FLpoUY26skJnXHLPFikhEt4l2M_N7wdt
    vgZpcOE1c_E0W139w>
X-ME-Received: <xmr:y1hKZMr7-eXOs4-MNO3co-oTMAQZ4mzqlqlTFAWwvDOX-UN3CQgpIeEUt-KmfXcGFmbVlQBD41sETbf62dFScSmSudDx3dpfVzVIHTp3m60o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeduiedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:y1hKZCkdwxK7TXv-E0H3k8gHmPnAYfHC4INdmQoQnppLUmhk3FkIdQ>
    <xmx:y1hKZM0EVvV1Yz3z2Rpin2ao049dI9LYCC_BulLtL1f8FzDZuu-UxQ>
    <xmx:y1hKZJvV0nHtzU8jsDnku74URxipor2KEkl5MIDKZvzV9DM9kpeaow>
    <xmx:y1hKZPTAnz07ZMIRXUiAY93G2FyrDAT_fs28JBGrxKNsrAB0sHoJiQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Apr 2023 07:13:14 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 39666953 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 27 Apr 2023 11:12:45 +0000 (UTC)
Date:   Thu, 27 Apr 2023 13:13:12 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v2 2/8] fetch: add a test to exercise invalid output formats
Message-ID: <29d2c58914b7270a4603cd65565c06ff74355e96.1682593865.git.ps@pks.im>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1682593865.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9utcAtI6OAIy0rcM"
Content-Disposition: inline
In-Reply-To: <cover.1682593865.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--9utcAtI6OAIy0rcM
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
2.40.1


--9utcAtI6OAIy0rcM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRKWMcACgkQVbJhu7ck
PpStTg//bgegqxkJ4hICZC+Ogs3yz+5DGpMLK78QNyQ38i8+ggW9TL9pobv1hXqR
wmvC+BOZEc10GituFcgjO8gHgNXe6tRnxeuRWWaiW9qhZWwWzv+Y5MoOeV+vO/43
9R7uMh1m7NJxtMm2DxwjPK9JKHqn1zW8sfpnw1h2Y3uFhK078BhqN5WgXYkzOEyZ
385Kxm+X0mTW1I5/aKuvt9zYKQfM0fo3cVYy3HtPIJPpIqjxzBzAHYnQC4RPFf8l
xn05RkJHZatAivLXCMxofTXijELL/O+hLh5ovASgHEhkw5F42+3TT4ciXUS8apcH
9vS6jc5fhGLE4TKPtsYXJtOPr/Ll4pqPoAk5dyhCnoTp7M+zYRaz37SGIDEFyKFx
Fv9iFsnNdW6ZUHOX7OJWl7zAlL8H/c2WTubweQu7vb1VScs9M14Hv8ypFDngBYm7
c2NpxGT5vPbz2BHv3RT7fL+G/9Vq8l+ukVDDJHt8YYtB/yVXa8KED+Tmth2V9ONC
s7fIunNUs7cYQEaecNVYYUsYQ/xzEnsiH5lAfoGGHrCw4QqhvGG0tLJ39sPFWwUt
cFP3fwykUoPMemeUfVc8p/L54NRwhVZ+sMuqwDOCbKLZDt4ISKQ0pw1j898LUkLU
/P35GDpZwCGg/OSP9rrsujjeDZs8eqXb0WaXS9WWw7SQYAgFLIM=
=0YBE
-----END PGP SIGNATURE-----

--9utcAtI6OAIy0rcM--
