Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA3DC2B9F4
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 05:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC6176199B
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 05:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbhF1Ffj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 01:35:39 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:50685 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232124AbhF1Fff (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 28 Jun 2021 01:35:35 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 80FA75C0126;
        Mon, 28 Jun 2021 01:33:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 28 Jun 2021 01:33:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=Yg+Y2IwpLqve9DrlP+sDQQouuLL
        S7Bm+AM2yW7+D4rA=; b=UgJJ6eBMTydp43GfP4VRaQqAhkuUFo3wuCCpFgzPMgT
        e2uY6vyPHvVlZ5hwgsy7vdStqWwyZeonax/D/TE0/d769xPTvAuEiM2lbXyuUZg4
        ZxxQlpkpEqwuhM8aeqMUnTDV9RZD7Hut1PpYaZpF0iW8JMrGatMEUILHe9NWiZVf
        cgJO/oP7vFeMerrTTD1//FOD/M/Fg8MRN7+ki3+gHIK3t9YSEJxKNfhi4oftM/0z
        0aeV9YwKLHXIo21oAzZiUdMaBLCya30dEndkhHYYe4V6Uv+LU95GqeUkBNqDM3fY
        HMJiR3swlwbdA93T52pf2QLg+8cHv7guS6idmUJRQEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Yg+Y2I
        wpLqve9DrlP+sDQQouuLLS7Bm+AM2yW7+D4rA=; b=hTDfqSkGMSKj1gZ6uI25QH
        It9PFtwgc7MCcYzCuEcjajU1K2OiuirGhSKt9yVerI46olVVXJ4c2UGxL9lnfD7D
        P9J/7VnYwam256iP0x1mKYtx3YElb1KWBVlBtQXvjAhPzu1vbjcJzHuuvh8IK92t
        FCwnH80858+kV14M2fS+BgHI1dFjj0QstY9aHqhcQKx6Z5Ai7pmaby/gswC/Tu+g
        Lwf4VpdlW8ITl/8zobQHIlGK2zyW5dcrPO4qoJW4KCRx4kTijBZIWFxEueo5zMQ7
        SKALuvBVFyJfc9gVlCuB0RsCdZtjg2C/ViMRYUEZtOypqlTxWGcbB21A1ZwsmTyA
        ==
X-ME-Sender: <xms:Fl_ZYFCseDKYWCyTSEWLrWZWj4HI5XIPbLOn3bWTnDlOoUIZk-5eUQ>
    <xme:Fl_ZYDha52n2Dk7fNodGhRp7pf1K6egjosbpp6xpYJLGNU7_erJwj7XwH4X_iYhtx
    9hApYaQtatscy0IBQ>
X-ME-Received: <xmr:Fl_ZYAkSkKW8FahKDTgVRKmGYj_h35nk115HrVQF1pRVaBj8p8KJAuwuKiy4zuBCFFYfbh1TlsCKaVCpjWpT1Szpd2MIHl25WVWXDqhIibuPPKgSIlMzUoI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeehfedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:Fl_ZYPwvu6GlQs_ld4Pt2I4lTStXlkGUIT3k7NPYy6kMESt4ivcrDw>
    <xmx:Fl_ZYKSaYwoqpAUo_1VbU8D94XW-66srewBtgoBFyTggP1NjVlguDg>
    <xmx:Fl_ZYCbMbjGTHzMvXACLEQnQnMNAd0xH6auMM7BWuTYvtqCye9KjLg>
    <xmx:Fl_ZYHJgiKQvsl2RXIhCXR-KbQbd40eOyf4T08h5ySuLdEFUfliPbA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jun 2021 01:33:08 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id e8e9907d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 28 Jun 2021 05:33:08 +0000 (UTC)
Date:   Mon, 28 Jun 2021 07:33:07 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/3] p5400: add perf tests for git-receive-pack(1)
Message-ID: <2f6c4e3d102e71104d7d00c78631b149b880609a.1624858240.git.ps@pks.im>
References: <cover.1624858240.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0KrmYKynENU2bVfC"
Content-Disposition: inline
In-Reply-To: <cover.1624858240.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--0KrmYKynENU2bVfC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We'll the connectivity check logic for git-receive-pack(1) in the
following commits to make it perform better. As a preparatory step, add
some benchmarks such that we can measure these changes.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/perf/p5400-receive-pack.sh | 97 ++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100755 t/perf/p5400-receive-pack.sh

diff --git a/t/perf/p5400-receive-pack.sh b/t/perf/p5400-receive-pack.sh
new file mode 100755
index 0000000000..a945e014a3
--- /dev/null
+++ b/t/perf/p5400-receive-pack.sh
@@ -0,0 +1,97 @@
+#!/bin/sh
+
+test_description=3D"Tests performance of receive-pack"
+
+. ./perf-lib.sh
+
+test_perf_large_repo
+
+test_expect_success 'setup' '
+	# Create a main branch such that we do not have to rely on any specific
+	# branch to exist in the perf repository.
+	git switch --force-create main &&
+
+	# Set up a pre-receive hook such that no refs will ever be changed.
+	# This easily allows multiple perf runs, but still exercises
+	# server-side reference negotiation and checking for consistency.
+	mkdir hooks &&
+	write_script hooks/pre-receive <<-EOF &&
+		#!/bin/sh
+		echo "failed in pre-receive hook"
+		exit 1
+	EOF
+	cat >config <<-EOF &&
+		[core]
+			hooksPath=3D$(pwd)/hooks
+	EOF
+	GIT_CONFIG_GLOBAL=3D"$(pwd)/config" &&
+	export GIT_CONFIG_GLOBAL &&
+
+	git switch --create updated &&
+	test_commit --no-tag updated
+'
+
+setup_empty() {
+	git init --bare "$2"
+}
+
+setup_clone() {
+	git clone --bare --no-local --branch main "$1" "$2"
+}
+
+setup_clone_bitmap() {
+	git clone --bare --no-local --branch main "$1" "$2" &&
+	git -C "$2" repack -Adb
+}
+
+# Create a reference for each commit in the target repository with extra-r=
efs.
+# While this may be an atypical setup, biggish repositories easily end up =
with
+# hundreds of thousands of refs, and this is a good enough approximation.
+setup_extrarefs() {
+	git clone --bare --no-local --branch main "$1" "$2" &&
+	git -C "$2" log --all --format=3D"tformat:create refs/commit/%h %H" |
+		git -C "$2" update-ref --stdin
+}
+
+# Create a reference for each commit in the target repository with extra-r=
efs.
+# While this may be an atypical setup, biggish repositories easily end up =
with
+# hundreds of thousands of refs, and this is a good enough approximation.
+setup_extrarefs_bitmap() {
+	git clone --bare --no-local --branch main "$1" "$2" &&
+	git -C "$2" log --all --format=3D"tformat:create refs/commit/%h %H" |
+		git -C "$2" update-ref --stdin &&
+	git -C "$2" repack -Adb
+}
+
+for repo in empty clone clone_bitmap extrarefs extrarefs_bitmap
+do
+	test_expect_success "$repo setup" '
+		rm -rf target.git &&
+		setup_$repo "$(pwd)" target.git
+	'
+
+	# If the target repository is the empty one, then the only thing we can
+	# do is to create a new branch.
+	case "$repo" in
+	empty)
+		refspecs=3D"updated:new";;
+	*)
+		refspecs=3D"updated:new updated:main main~10:main :main";;
+	esac
+
+	for refspec in $refspecs
+	do
+		test_expect_success "$repo seed $refspec" "
+			test_must_fail git push --force target.git '$refspec' \
+				--receive-pack=3D'tee pack | git receive-pack' 2>err &&
+			grep 'failed in pre-receive hook' err
+		"
+
+		test_perf "$repo receive-pack $refspec" "
+			git receive-pack target.git <pack >negotiation &&
+			grep 'pre-receive hook declined' negotiation
+		"
+	done
+done
+
+test_done
--=20
2.32.0


--0KrmYKynENU2bVfC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmDZXxIACgkQVbJhu7ck
PpRC6A/9GLCKxAogngofIOOlTmw5N6cfuH5T9NkPB7Kv1zckWKfVeI3j4AkbDaO7
Q3Tkerx4ZIqnMAWXbCVarhytUMipma5a0+xGyUZdSsO2GrF6NKOF2nDahvtYJGQQ
22h40l1e2mQF/UPOa9D6J3yYac5fkcWEtbhsZu+PMht7F2kv+7kmHkEP935y0ivU
YpFWSLzFHD5Bw8Mb3HtQRmPJrhKK+B+qXt4d7OHb7VTXULAc2qStgIB8JQ/qFVRL
Lkw9SBMTHz2N9vYf+XVHrwezVp5hcweAVIZ+EID9m/RCyCP0ILB68uvXD/hgZg1a
pxVENLGbPYXCMXMYo8qBMsP02Dhug3WxZFIxTsDqJ1ESObF0VIeymUZkmBJUkM4v
JTcq6dmf4DO8qslWBBvh1X56pY1RcFW4WlwFB9v8MpKvKDGMQQ2NbZteOTKBLdzG
6yiVyeqMz+WfrqJ4sOvWEC0lIbLqpbjBq44ganvTK5OGWQ5NvMJS88ujNsZaYdVI
vlVngdNxa23EeJdeiPLG1J8Hw6mgZtxX0TCRyWGX6XrKGXlgb/nQN56d2ywtwIn0
8zorP9sLTelt3iIRnDeIpw2mcAqlHdp+H7rGW1KrdiMzY8yObcX87HyayCb9PVfB
Uz2Wjbd3SiUZitJLvU6C9rRPkaVwoI0T1o2gWQSxlAu7DfwKNQY=
=Tiw6
-----END PGP SIGNATURE-----

--0KrmYKynENU2bVfC--
