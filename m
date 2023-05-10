Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17431C77B7D
	for <git@archiver.kernel.org>; Wed, 10 May 2023 12:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237039AbjEJMeS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 08:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236872AbjEJMeO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 08:34:14 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479FB49F7
        for <git@vger.kernel.org>; Wed, 10 May 2023 05:34:12 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 0BE8F3200923;
        Wed, 10 May 2023 08:34:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 10 May 2023 08:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683722050; x=1683808450; bh=Y/
        nTWdHaeOZn32LkJID0vMBG4wBA9Dw8lYxaivc2sIc=; b=cnN2hNxPt/+fV+X9M7
        jKxFfQ/DpmsW1SZvahJBOi0qX0LQBY/UQd3D97LGkG/jCUvY5ARn601OMbNLFJoy
        drUjS3R8Mb7+7Ofg0l4KgWJXcqVbV+2Tx6K1XtXPUd7fmGvf6aWHs08XzCx0cvaD
        kCLlneH5W6tzgSLjZUd8jRn1veW+QyYMq7ePe7hS6aVSZIZGKWdy9R6g8EOHD8ri
        JoCAY7bgv3/E7BsLUUJ7iLW7icuaDO1ccmSVKmOhGSau00cWevUj0jMJTrV3p+rv
        u4xmW1MA+hxYk8Xsm7b0uzcS2zW06dzTCYCYVj/ucFOY5luFdOOKrxh5o3ZNdfW1
        i3hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683722050; x=1683808450; bh=Y/nTWdHaeOZn3
        2LkJID0vMBG4wBA9Dw8lYxaivc2sIc=; b=WanYK1AnYSQderUr4Egl0IfDXZmbR
        eFel8rawQk1hBZUZl7oPW7wc2EvBZwQkANuH9RalIEHzKCvfppOSIrvw3ANoZag2
        pRGYcV7QnfBhw2oNprlOnjNpGdvk0wtMnjZXCQoXqHevA76QhfI/0/SDwqYs6C/9
        BTbFFOUUV0pU6J5sCs4oGsbbETYar+O+i6QHfHNuIsZd5oSG5gpLNPniE1IRzySk
        gdiWHBERib6h7YGWWz2S5Gs8SFdK4wFCz8pyypIY0A9yIbgpaWTbJkMNh/M2SekL
        qAX4+DlIj1lOpvFMtII0Da9e9TmVT+uR5fU5OSEst6ZlEqKIzFmdVljAw==
X-ME-Sender: <xms:Qo9bZFo_opBkl862pPg3pud-k59RtJoghCJsE3aF8RvkkbDA1tsxoA>
    <xme:Qo9bZHrx7RR4AP8bRGHMIVt-fZpSWfsXnsB5R453hdC7CjZmT7OKWlkfXK8fgJaFD
    slN1YxQLtNDf8q2ng>
X-ME-Received: <xmr:Qo9bZCPFGxB9kVd-tO_22eHoJk4bQfoUGMAglehkYkmW16IsJuFk90m6Yz2emVaroBIg2AnzgDb2bJeGWDmVcNxSffDsFy7P5OaEvc1MRmuO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegiedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Qo9bZA7OFyp6dAybZ6vMF2LjAFKIwz_y4QEpfr3ANlm9jH-N7x-skw>
    <xmx:Qo9bZE4Ub6REGlmx55kFGeZo9idcN9F4SoLnTfKXxVgwUdLOzds3zw>
    <xmx:Qo9bZIhVWKwCIZNS0lUnEw59SROjFFgybUhyvan5Nhk_WX3g6M-JgQ>
    <xmx:Qo9bZP2aJ0X6Jafcqdw8bJBzXXo1lf7cbzEluCfPWkW5YnsRPYmQ1A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 May 2023 08:34:09 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id a5d53335 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 10 May 2023 12:33:59 +0000 (UTC)
Date:   Wed, 10 May 2023 14:34:07 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v5 2/9] fetch: split out tests for output format
Message-ID: <e459d8a1ec22f901e6c069d668981b1a1a0a0473.1683721293.git.ps@pks.im>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1683721293.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rWfLwrHb8+U+1R5y"
Content-Disposition: inline
In-Reply-To: <cover.1683721293.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--rWfLwrHb8+U+1R5y
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


--rWfLwrHb8+U+1R5y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRbjz4ACgkQVbJhu7ck
PpSUdQ/+K6GqAMd+ZPPA7CEYBG4QaIuCl4toqp1sOy0MJQfej+PafPT3R0bil+v1
dJgQN/xwQSESmWTi8UWIHRWTZ7JZE/9ltk2fDsYH3mTqxoToND1phzOXUnxdA1aO
oinZxAsw/cdT2kX1hxHbJUp/lKY4wv6nZoV9fc4e1X5tdyMAGVPYUZrtw7dnNbs3
/rsZ7o+CPfpKYBCQoE05UeDRqt3MgynElduraus/VaoRttUsty7t+DUYMhWFuzgu
sIJrK16B8MbEZ0CJP8RqvQewoLmaEAnF9xKOAclcl9PC3GxJMjrDR8qKdXvtkE3c
Y2Keeezo2OH+Rgv8w/zcRB+AFQBybx4J20g08zoGEUMEK+X6ZTr7jepHZtYgFhSE
gUaEWlGZ2T+Q8xxG0VZsPRgYTjg5mmW9oAy2fFi0/8A2AkaebTx3isa3aKnFrm+0
+QRMIioq2qiOLhb/BqTb9lCTVSmZOGDXvkuzhZusrXn0qH+TiSAwJdaMSbMjtHwe
AU46O83nm6dJheaGHTNyQGIXK6jweNv6JB+DQqHgzmqvlLmJet5MfDi9EivHO5v0
8PMtN+lVEyQq/ZNv/EU9K60Z/ebcQHirJcHMQCxSPEOIJXFRH3Gj99lUXpYptAFw
5tf2UWM7UMT+pBIUxfzDpKfVMh9b1zIJOjY8c6wEAG/TfCl/Uv0=
=L/ls
-----END PGP SIGNATURE-----

--rWfLwrHb8+U+1R5y--
