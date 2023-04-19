Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FB3C77B73
	for <git@archiver.kernel.org>; Wed, 19 Apr 2023 12:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbjDSMcA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Apr 2023 08:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbjDSMbu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2023 08:31:50 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E24416B1F
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 05:31:32 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 88E63320005D;
        Wed, 19 Apr 2023 08:31:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 19 Apr 2023 08:31:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681907490; x=1681993890; bh=EX
        kqlSAoEwBzSYVd3Wt8Qnb1bZB5P9tjg2P/qfwr94I=; b=pdshrNWdzFlCKikE6O
        XXg51XHZB4/9UkXtlbKyFjYGiRW8pGz1yzIdHmKeRGhmYBUXkCwWOpk/rBywCdF4
        NvyjphL4ATK6wihwcpymGh4qTJq2qWgC5CjVg25XSFqce6fZ6Nt+WN5eH2pRdz8h
        fxtlR2ecUl7tjf52TH52gfFeRB3us1weTwkfG95LU19on8weFpvx4BKJiM+KJb1W
        /VnTyZ7BQ25blUsCeY3ZT06Ioh6O6hnGBtZtk4JVayBThJWS60pTwA8kjbaCB+fq
        lGrggXjLGSTrrrjNwxfz3epIeAEiZtWx7uHYJgLiOhpJVolVH0Y+ImWVoo27olyD
        t7Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681907490; x=1681993890; bh=EXkqlSAoEwBzS
        YVd3Wt8Qnb1bZB5P9tjg2P/qfwr94I=; b=LqzRqzrjft/5RuGCPQjxHcX8QKE63
        3RTwIMAf/8R7CzS7lNpHCipFmDe7mmn7Jcv1QlXJdzQjfhhTmCh4xiw0dobglAJq
        k3DV5dumVVWPBWzsY+svAFwmbzkL8atHaEbtydTSVy4u1KfyUVdG0h89MG1893rb
        8+pRIII6x//G15O57jOOOa/vZOjLgqyj4jZ2LYtmu4gXlT0cQHwqTHQqwq2XKVmA
        2Zu2VFQEauuMOzyEW0m44KZcLxyNwY02WS6RqZTUiuUjw/m/5PAXyYoBKvh8nvCq
        wmfMIWGjeECssAfaGWzCvfw/mTPv8c8zuZMSl23fL2QN9Rm4hWSQATq5g==
X-ME-Sender: <xms:It8_ZDNTTLBIU7BGVVPm2CGGZ8csZN918gWkxzUkSv6krVFo0gAsPw>
    <xme:It8_ZN9aOdiN-YrcjDhng0e2zPK_VLIpRAYdrHyzoiesMyyDa4cTPtP0XlOwU9j-F
    ZTGyYDo578OlHSEvQ>
X-ME-Received: <xmr:It8_ZCRjBLfra0FyHfMMuzsvDqoM4u5E1Tsag2LeZLigVXwe01h2HPhise6Jsc8OHe-MkLq39nYL9syDcLnydCN1H_mvHaaq4WNtpg7KvmEEVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedttddgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:It8_ZHv6A8AEGeu66p86PBqUTfV6tnr5BhL7Xwrx36yGCPeMmu8KCQ>
    <xmx:It8_ZLfsYyS_dZnhBxBrxzj9ywAl6D7JoPMKCBz0S-zRIXd0rgZMCg>
    <xmx:It8_ZD3Q0rCMWVZCx9mgd6WHQc-Hd0v5nqL9FcwS9GaQHY5L16k50w>
    <xmx:It8_ZLlApSnu-pL0Ohjhp6APq7avD20lhbvjINuIemspnsgAAM_9ZA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Apr 2023 08:31:29 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id bebc6d69 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 19 Apr 2023 12:31:16 +0000 (UTC)
Date:   Wed, 19 Apr 2023 14:31:26 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 1/8] fetch: split out tests for output format
Message-ID: <0d0d50d14c557f8313747e7d0e104c2c0819dab9.1681906948.git.ps@pks.im>
References: <cover.1681906948.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b8djZltEGWJk5YSv"
Content-Disposition: inline
In-Reply-To: <cover.1681906948.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--b8djZltEGWJk5YSv
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
2.40.0


--b8djZltEGWJk5YSv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ/3x4ACgkQVbJhu7ck
PpQa1g/7BKYaIm+hvsJZl7vMZqQOQzgt2p7do3s5WI+A+V9W0ahyw3iGZ6KjMUZj
B4PfHQ1I6RqkmoM3LvhWsaK8PAX/9lDr3b2q5VuBivy2pEVgMJDnlXwZwKKrE2II
xULIaB7SMUebX3ZldNYBF/Bg5xYxd0GuwxzS6X770qmQYQtMHwNcNkOXq5/hsCPF
VgUP2UqeMYMtMeyRt23t8NTxwZX1FjegbMn2TRt3cv8xw9j7kY1776HOrglXvJwj
ux6W3sTcbpdGi8Q5hf8Yj9lUM3eBFK2gEOCWzYQNiTxNgNFtjXpxFgBHqOZqaGfB
pKEbKCf2xQY0kTroTvAjtF2JbsRdQJrlODo8fRZkLkBEIMtPCIPmQ73PAYlpj3Ur
wUVddtx8cZnZRC4F8dwchPi00jEXxC7D3Nf1c/Jeg8laB2GX1yH9Ls0AytsYMtb0
UIaw18Gned2USNDojjIdjilBC3jsBbZ+ddFrfPxQUe69079c43rK7d9dz4iBR7nf
ItsmMtTe+/4LkZQev0X0Ovq6SFz9jRvVU+utBFM5ReHem6jMVPf/9d8X/3g4FURe
eubC8xI5fdeOkfYcvOZ+od+l1HYVT50DjXFcocEQ1PYKx/2wh7sytWkq39M7H03/
AUlR027SU98bjyzTTZYqnPzluqxix5+jjU3aRBMn5QLUGCp79So=
=clzP
-----END PGP SIGNATURE-----

--b8djZltEGWJk5YSv--
