Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C231C77B73
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 11:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243669AbjD0LNR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 07:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243319AbjD0LNQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 07:13:16 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96064BB
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 04:13:12 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 0EBB65C01ED;
        Thu, 27 Apr 2023 07:13:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 27 Apr 2023 07:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1682593992; x=1682680392; bh=uh
        DuGh10NEiU9R4gNKeRZf63piqr/2JZ4nLpJDfrrGA=; b=oziDUXUDWb9EK9Z0Qw
        hGC8FS4KBdcY0AUlOpEX//oRcCX3OFh77gTeNkXVEzsASLHvHRST9uVMeXrhsQJ2
        wm0bjxikhsJbtc/27CzEP0gT4cu/cRK6rJoM+jQ/QKODT4xV6tzbyWMfCmI9zodL
        xvG4UXMT1XEoXzyUzJNURAcnsXhT4BWG4u2F4nMi/B5QDk4c6Eo+oY2nbTNUXyVa
        944CAaKhDomGK4mxCRErxIlUiyGIZs2ZjlLhd4vVXLMx5iXPiuG9NzvC4Cbb+qf/
        3m7CC52AwMSeoRC0lMk9gJkcvfJXfbbMJmHQj04O542maaLkESzXv6EyvJ9rhQkI
        dx1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682593992; x=1682680392; bh=uhDuGh10NEiU9
        R4gNKeRZf63piqr/2JZ4nLpJDfrrGA=; b=fdl1Nxe6aVY/WhKPF1BQwGEQxuBKD
        efbmYlx+JoIiM4KtdrtRMgRECIMCmaZ5G2hzgtEmHGMHf4v6inU+iiSo90IbAubr
        0cXIJ494PI/JhDBrWRNiodIglwQMNsqerzhoH1HI5L2hEiCHtGTH2AokYuzXf6qS
        6JRsSbOhVg2eDWp3dnWZiI3tJ0V08v+hR1yAAcClhYgW2REwuZoZHbNDjqfQgZht
        2wUvFf3asdu0myHeoJgPRkh8wkPn/kGbKnRPIo41HoXdg2beK5dD/Yd2GPWLIyEN
        TtubejBSBYPvGLBX47xPkSKc2siXffbHAGiriTWcfu1KahozCE9NHzbyQ==
X-ME-Sender: <xms:x1hKZAmAeNi5iQdxMs3wB_LHKhVL82YIf1Yj0Ez3DBdj0V0KQOneOA>
    <xme:x1hKZP21mIw9Sa56iJ45Zf-n0-mhrftpvBNGLK-I7jiRwuR2qjP34cUI4Qilnz8Sv
    f6UAbX-bedw0nBssA>
X-ME-Received: <xmr:x1hKZOoiIzPyau9XdYr7Ywmyy56EMt0CW3FqGXEkviYWYSYBrn_nVrmUyk5W1oaXJoOtb_ORrKFP0YWLXZ_1LKS5YMj8yTKx02Bv21081tfF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeduiedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:x1hKZMmF77cd3tDimCXHj1vj44Ws2epn63OvGjt7aiPSm_CtSM9Qlg>
    <xmx:x1hKZO1QvmIg46sn9vQLcLBK64iJmN-iwn-4jP-Nn3RMK_lLLty7qg>
    <xmx:x1hKZDv_H6mFGiU0lZowW9i0Z0hIgX6emk-DFSOcdL7Ee8febHkNUw>
    <xmx:yFhKZBQ-SgEsvzSQCfjT3Tlotefr3THNh-uSAJ8fPpI8iucl0Xr1lg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Apr 2023 07:13:10 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 4b733560 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 27 Apr 2023 11:12:41 +0000 (UTC)
Date:   Thu, 27 Apr 2023 13:13:08 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v2 1/8] fetch: split out tests for output format
Message-ID: <0d0d50d14c557f8313747e7d0e104c2c0819dab9.1682593865.git.ps@pks.im>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1682593865.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AdadrISFqw+DhcgO"
Content-Disposition: inline
In-Reply-To: <cover.1682593865.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--AdadrISFqw+DhcgO
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


--AdadrISFqw+DhcgO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRKWMMACgkQVbJhu7ck
PpSUpQ//SuLDhDSVurjiUCywlD2qXrfqln4kEgRjniE3rbKJsWkvNUv3flFpC9wD
k2qDrOzxJjyGn5AKSwbcKe1TSH4SQRvgibs2pmuv01pN+sA6u1hOk9puscpL5tbx
G1Dov37Grvwi5gqBRla9VFSpE0cHjFe0PSyi6F/tjt+za310Lv8/kurP4J4td3Pn
6sbbJOreMDx+X4A3ECiEw8yNDRW1poJ+sgIrRRUq7sAJdRP1JRa62QZR6g9T0QzI
1NbAGm4XdZCZJr+XtobX/8NK+Uktbh5F4s2F7MLIQXN0vybm4PlV/8ftxqtur8/8
mgyASt4aHAbnFHfhL8Xm0nNNcTupXywakwE2G+HGKSap1I6Hs4K76Vra0rHACTH3
n0zZFLzKqSflDAtceAjywJx57B9Kx4qqT/6EQSoOIRwUrBYb2rZv3HZk8JeOHAt+
r10te5aYkVrHmuHL1tj/ccoBbn85kmJp3+UQCBEhkZBUthRBkoVilBIlETHY8+62
04irq8A41v6obC14Ow3BE+vY7X2cnvPHycKFpaKJUYWG6m/UqjpW/WM/Wb5ONjTE
xzHHOnj+8JNfCyPae+OJEiB/uwPxzWfbw2j3EJwAmgzUXLLlu6j/uu16zKkxnP74
eihJKS11fJkW1N1KIuigdH4BC4DPSjBjjrM+ufJvejGFK9/Gip0=
=SNoB
-----END PGP SIGNATURE-----

--AdadrISFqw+DhcgO--
