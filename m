Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADA5C77B78
	for <git@archiver.kernel.org>; Wed,  3 May 2023 11:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjECLef (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 07:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjECLe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 07:34:27 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AC35269
        for <git@vger.kernel.org>; Wed,  3 May 2023 04:34:26 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 193DB5C0099;
        Wed,  3 May 2023 07:34:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 03 May 2023 07:34:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683113666; x=1683200066; bh=u5
        fHQpF8SUyR2Nv09Hx7NPYoRBeGlju6Z+WL8YYDTKI=; b=X3+bgqKI0/8zp8Ff1X
        FBUpPnzK30dzkyEe7FwYdIyRIESZzoZVB9tTI8YaVt6ESOGGxiziPmzaRxT75pJn
        XnENQ8X/MFffho7E+smP8GyCdIhrVSxnIH0B7IC49ci6YvF+yx+T1aCs6JDpZGiA
        pB0in9fd3M3YUEeisWoI7WmrXtNNavz4KHOHhlPAhsoE0UdPlcDWfEoVBkCntCoy
        7GzJjixWU7QlA1t/ZjABzyxDuaFTg+7oU5e81hQxZytedBR74+oU2oIJ34yHqZSu
        x4sh660aUMOfZaVWwd1Jh+Lk5M6FD1cBx44o8B9GaFvk9EzD0lcw1Crh7zrtSR/9
        ed5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683113666; x=1683200066; bh=u5fHQpF8SUyR2
        Nv09Hx7NPYoRBeGlju6Z+WL8YYDTKI=; b=HwIm5Uq1y+Uki4RCgQ/FkQ8gT1+6t
        C8oT6LkgYiC75HrgO7nm0UXtbcJApdm/SCQ+RwamzymHDjMJgft19M5RylhwDCsk
        npQsDxW66ekgHe5y9n1XzcCX9/ChwllykcYtZ6tZJU1pb5ILVw0CoQyat8d+ihFz
        KHwWQyjkcr7cH+3dsCEGggZgJ7WJot05RI3CIrXzRXWRi/rk8Rd4AOG7z1+ckLrm
        Om05rqfLZqP8eJ1CW5JB7n9WY0+mn7DtjEObhKd6+46sFnvlPFJjUwR4scM6mmwM
        rWncI75BEgGJwobMu8Af+iCy2DQDlm9xKQNRGekcwG00Yx7c/K45m887Q==
X-ME-Sender: <xms:wUZSZHnXYHH7oThi3zdqWa4q4vpMM0KbuI4YDEUU5JM6dnNEU50_3Q>
    <xme:wUZSZK2QVCGfPQd2qz3rtW47FuASGdDeM1Cy2yp2opc4xdDG0EDYSOmigoT82V94R
    HBf-s-QyD2hoJc3MA>
X-ME-Received: <xmr:wUZSZNpf2YeuDrT79tAO064SU9J2FLpUElQiQ2niMqb-wdu1YX4mS2RpMhxDm-fzV_Ib8yLBHdlnwXLGe03kuLJyFqcc4gI9yxPJccTMBgJ->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvkedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:wUZSZPkXh9GhBh3ClM23sQzPfTzsW8PcmHSimI0jFsOONbTgRYXHxw>
    <xmx:wUZSZF2v3tktYYtU1y8Q04-sKbUJCmHKmR9R9YQBS6XFCDIKZc1dRA>
    <xmx:wUZSZOvUAKZgrCfa3Ey1Z4_XyqxPV-ZI7UL8ehkDQiw9VNI95pIolw>
    <xmx:wkZSZAToLh7oW8WYXB_tZ3HXK5E9jLfZBr__OkFjR2cvmb2lUsM0wA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 May 2023 07:34:24 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 2ad417ee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 3 May 2023 11:33:43 +0000 (UTC)
Date:   Wed, 3 May 2023 13:34:22 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v3 2/8] fetch: split out tests for output format
Message-ID: <6ebc7450bab51083ae225cad768a013e282749a2.1683113177.git.ps@pks.im>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1683113177.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="C+OcCVPmsE/vvM1O"
Content-Disposition: inline
In-Reply-To: <cover.1683113177.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--C+OcCVPmsE/vvM1O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We're about to introduce a new porcelain mode for the output of
git-fetch(1). As part of that we'll be introducing a set of new tests
that only relate to the output of this command.

Split out tests that exercise the output format of git-fetch(1) so that
it becomes easier to verify this functionality as a standalone unit. As
the tests assume that the default branch is called "main" we set up the
corresponding GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME environment variable
accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5510-fetch.sh        | 53 ----------------------------------
 t/t5574-fetch-output.sh | 63 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 53 deletions(-)
 create mode 100755 t/t5574-fetch-output.sh

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index dc44da9c79..4f289063ce 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1118,59 +1118,6 @@ test_expect_success 'fetching with auto-gc does not =
lock up' '
 	)
 '
=20
-test_expect_success 'fetch aligned output' '
-	git clone . full-output &&
-	test_commit looooooooooooong-tag &&
-	(
-		cd full-output &&
-		git -c fetch.output=3Dfull fetch origin >actual 2>&1 &&
-		grep -e "->" actual | cut -c 22- >../actual
-	) &&
-	cat >expect <<-\EOF &&
-	main                 -> origin/main
-	looooooooooooong-tag -> looooooooooooong-tag
-	EOF
-	test_cmp expect actual
-'
-
-test_expect_success 'fetch compact output' '
-	git clone . compact &&
-	test_commit extraaa &&
-	(
-		cd compact &&
-		git -c fetch.output=3Dcompact fetch origin >actual 2>&1 &&
-		grep -e "->" actual | cut -c 22- >../actual
-	) &&
-	cat >expect <<-\EOF &&
-	main       -> origin/*
-	extraaa    -> *
-	EOF
-	test_cmp expect actual
-'
-
-test_expect_success '--no-show-forced-updates' '
-	mkdir forced-updates &&
-	(
-		cd forced-updates &&
-		git init &&
-		test_commit 1 &&
-		test_commit 2
-	) &&
-	git clone forced-updates forced-update-clone &&
-	git clone forced-updates no-forced-update-clone &&
-	git -C forced-updates reset --hard HEAD~1 &&
-	(
-		cd forced-update-clone &&
-		git fetch --show-forced-updates origin 2>output &&
-		test_i18ngrep "(forced update)" output
-	) &&
-	(
-		cd no-forced-update-clone &&
-		git fetch --no-show-forced-updates origin 2>output &&
-		test_i18ngrep ! "(forced update)" output
-	)
-'
-
 for section in fetch transfer
 do
 	test_expect_success "$section.hideRefs affects connectivity check" '
diff --git a/t/t5574-fetch-output.sh b/t/t5574-fetch-output.sh
new file mode 100755
index 0000000000..f91b654d38
--- /dev/null
+++ b/t/t5574-fetch-output.sh
@@ -0,0 +1,63 @@
+#!/bin/sh
+
+test_description=3D'git fetch output format'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+test_expect_success 'fetch aligned output' '
+	git clone . full-output &&
+	test_commit looooooooooooong-tag &&
+	(
+		cd full-output &&
+		git -c fetch.output=3Dfull fetch origin >actual 2>&1 &&
+		grep -e "->" actual | cut -c 22- >../actual
+	) &&
+	cat >expect <<-\EOF &&
+	main                 -> origin/main
+	looooooooooooong-tag -> looooooooooooong-tag
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'fetch compact output' '
+	git clone . compact &&
+	test_commit extraaa &&
+	(
+		cd compact &&
+		git -c fetch.output=3Dcompact fetch origin >actual 2>&1 &&
+		grep -e "->" actual | cut -c 22- >../actual
+	) &&
+	cat >expect <<-\EOF &&
+	main       -> origin/*
+	extraaa    -> *
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--no-show-forced-updates' '
+	mkdir forced-updates &&
+	(
+		cd forced-updates &&
+		git init &&
+		test_commit 1 &&
+		test_commit 2
+	) &&
+	git clone forced-updates forced-update-clone &&
+	git clone forced-updates no-forced-update-clone &&
+	git -C forced-updates reset --hard HEAD~1 &&
+	(
+		cd forced-update-clone &&
+		git fetch --show-forced-updates origin 2>output &&
+		test_i18ngrep "(forced update)" output
+	) &&
+	(
+		cd no-forced-update-clone &&
+		git fetch --no-show-forced-updates origin 2>output &&
+		test_i18ngrep ! "(forced update)" output
+	)
+'
+
+test_done
--=20
2.40.1


--C+OcCVPmsE/vvM1O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRSRr0ACgkQVbJhu7ck
PpRpGQ/7BEhLN26o3BTVgtOYQjsM00/7/ug3CcJhu0CS/I0viFkKNO8/1zWGuFgR
rp12haTA+fQQ21yX7TWwsFzNAEIQ40kn9hPCld3WQloivEZK3yVnqmMRSGmNm5VU
mbPjK8M0wierOiVl4IoJD5sH3Z6I37ZZWgG3Mpt4NrydDoelJaJmFq03a2m/iv5B
8iif8tZDOAiI6D69Ahz1PSm958qJsHM4l0INlr7mK+LvKL8r6ItVIMphS74dMl4s
XLctF3DHzwpl/ipQg2V6MjnEnUcN6kXhmSfh/kXn/AcQ39Xso+lvQpMvxwHl5DlC
BIcN1LhtwVLhQdd3IpQME1vd2ZTZARdi367sUeSq9qS61gWkToRgLkoqYqPZm/BK
JUKE7sA50g5QYW1NF807M2Ale53LY8QuEiwXFoz7Ey5TcSVC97/kr/pBk05iNosu
Qi7Q5orvAGBnvxdYzQCzkMQeae/0MiFSkLpSq6RKckFzMXIbUmxCHEIfwFMMqyBs
dBew3UV8br4kHeKG599Qf2qFsqQKEo1eAujlBeXpGRKWDbAiG+rpWs5sy5aRHgD7
UizPyIIlp04/7ydLA4RlaKfSMhhiyiZe9Uo2TiZP+iQsDMBowUKMMhLwFngix17z
sAtd/qLMtMIDw/s3OTkx15TOpMqn1g96tVVWhWvWUTEomsL2zj0=
=dNaQ
-----END PGP SIGNATURE-----

--C+OcCVPmsE/vvM1O--
