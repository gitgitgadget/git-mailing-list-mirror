Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBB4C77B7C
	for <git@archiver.kernel.org>; Tue,  9 May 2023 13:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbjEINCQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 09:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235178AbjEINCM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 09:02:12 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD69D2689
        for <git@vger.kernel.org>; Tue,  9 May 2023 06:02:10 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 296FC5C005B;
        Tue,  9 May 2023 09:02:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 09 May 2023 09:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683637330; x=1683723730; bh=rt
        wucl0BzqisQn99HEwUvsA9BjAS2EBSOTf2CYC97RM=; b=LhttZLr+Y3vPlNK7Nn
        aZdvaf873UuTV9w2vR2GWme0Ar8uuJzS4BlCXZ0CJp6nf753EFLvpVPKr1+jtrnc
        gZe1J9faZ61v2nFEEDYCojqu9T2P3IXEYfapsLTBxhg5rkNOwjBXurV9IS/LUYdd
        nKWXWyEM7tj6eQ1g46XE2Rd+ajnGHxQHcfWVPWVCExzhk4aztaDp0ZJoBRlN9py+
        3ej69d1hxRFluFl18bl62DpDFStOeUVy156WHc7AfnM5TbjO/6UMwvqHkp1Wi+Wd
        yl3CAcMeze0zpssZ6sb+8OQFGJqLGYFc4MC2y524B+hmEc3P53QRwXlpfihX3VJ/
        rJJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683637330; x=1683723730; bh=rtwucl0BzqisQ
        n99HEwUvsA9BjAS2EBSOTf2CYC97RM=; b=aR8Prky1kFBFarmjmkDYHztatswqE
        cC4SgAd2w5mOLb97oyECRqMM2PE/gc6uFwGxHmSESH5amtuz8A2m5YYN07P95IzV
        CchByv7HX9s8kN4nCIYUqz4p1+DNj8w5labAssgknZpoK/kQQAljSS5l1PGOytmc
        svr5lLmCLgp0vLceWLZQl5a6IlVt//ViQ8wQXBikgz209dvEqrpTr1z8Z42O3xkK
        P8FH4B51us7k5fR7FZs0/QaAFsfiiRByX3T5Bo50Ygt11Z4sQUpyvDKv1DvvVTtS
        R8uBmitkHZXBy8ZZ9dqK611eP41pcyOvhsPPGoSLJwIqiahPYNn7t3bbA==
X-ME-Sender: <xms:UURaZFY6iMXdPiMPk1QpBl9pZxh9SHZI_hqcfl3ztK68q6gzLk0qoA>
    <xme:UURaZMY2qCL6sOqstST4Mg2Dw8vdiEFFIZLZnn4VX3-pgIKORXJ7OzDJ1O8CIej1B
    5xsWF2W5R3XkjTe6w>
X-ME-Received: <xmr:UURaZH-OvQye-k2iiLJ0Xzu5bSUmhd32BvWlWJIxZs2oRtESxIJhbDtns63Pg2YQioLE-isD-Rf5FSPaLoGN8iRAN0M6ewNzV556UJKOy_Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegtddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:UURaZDoys36PT-M_jvXcCvVIbv55g5GSGLCy-iuSbvqwa_YHNaenvQ>
    <xmx:UURaZApDKMe9TqdfTpY7fQl6ZPO4OCzBnhuetkqr7QP4s-up5xkHXQ>
    <xmx:UURaZJQjfvIPgQA8kqmnFEt6lXs4sUOBlbp9J4zgEwXMPrt_KCtr0w>
    <xmx:UkRaZJnl2T9NXUAHZP8OXW8w0uPLLjnCWqhurxJFFfVFaLnmvdz_xw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 May 2023 09:02:08 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 8fc2aa73 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 9 May 2023 13:02:01 +0000 (UTC)
Date:   Tue, 9 May 2023 15:02:06 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v4 2/8] fetch: split out tests for output format
Message-ID: <33112dc51a666f70cab808ec21ab692497b37618.1683636885.git.ps@pks.im>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1683636885.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RATGEKSdBxwuh1Wz"
Content-Disposition: inline
In-Reply-To: <cover.1683636885.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--RATGEKSdBxwuh1Wz
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


--RATGEKSdBxwuh1Wz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRaRE4ACgkQVbJhu7ck
PpSBoA/+KXHNCpVHKl5lU1B76tiOYifNHCw6hv5FG1lOUXJllRDiZdLATl4itDZU
4jWEH1hsd9VbG0plrTMbfz38KvEDNsZMOO+7o3zkKTnfY0TCjCoiBPA209yJ7C3X
UqkbBylJnEZWfvvo6H2wmylePmHABe7NTKVxwXH79vge/yCQmHNqWXHOCeaEvaKT
AyiXXAsXzCTYVUXbaBy/Nw6xGekGhkbCF+6YEuYcWmx2rOIaYmZr1gvoDr6ZqnOc
9HddoG46g83x/DdNeGaO6UJJ1kXW6uXh3DhjVdYdOKXiff/MzrIuoXkG4oVkN1vy
vt0gZYw2esuO0ZsRUD/dexcc66lf4YDm7W2C9KOD56cVX2gC1o8JhqH09HAALM2o
Rvwcme3+GWdnIu+LcMVfSZwF+k3v0H/bGL+LQFE6wDaeDSnAlTOwweIY2cXNbysT
OCjW1TCtvzWZPPVqzmsOWBlXhGnzMZtieFBbhojhc0nYCoGTIayrvFkXOAEVRy9h
AaABZUMR2I5AmzMP20b00PuYk2VqxkFjjCuzxcPfEZio8Qbrmk7ZEUiDanH37Pwl
dDzJcrWwVN72wHVf0i8negjodbMcyzQi6tx4E42DnXUiqpUrmgrF4Wb3sI7pADl8
oCnxpAelue36/a/KacKvfgG4vEvQ8e3EJLhmQWpUqyv3QjiosHw=
=tgLy
-----END PGP SIGNATURE-----

--RATGEKSdBxwuh1Wz--
