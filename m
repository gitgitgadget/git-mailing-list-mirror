Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371E3C7EE22
	for <git@archiver.kernel.org>; Tue,  9 May 2023 13:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbjEINCO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 09:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235101AbjEINCJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 09:02:09 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E5D10F6
        for <git@vger.kernel.org>; Tue,  9 May 2023 06:02:07 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 0981F5C0136;
        Tue,  9 May 2023 09:02:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 09 May 2023 09:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683637326; x=1683723726; bh=RO
        hERntylu2qiCzcHn0i+i5RbRQYKg4fYwpD6OJksxI=; b=p5WbFTYuPPYnC4XKZE
        /yk4eK7jlphSEdbgziK+yQCsPTsX1GcJQwMl73JpjM7Gh0QFH1QTiudyozugL/zG
        8Gsv5qleG6oSRx63V22z9jZNFDWUNHD2D92v+Hqp1rz0aAFa3fmlfjgH/kkOziR7
        8tibp2lKd2frOCzEuI3UcTVJuFn0Oq+8H7vJQzZ88qJIQLQ/HI/npOywPFLaoJ4R
        ucG14bR6D6DS9opM/d2FJvxX2SYwDGUWfrBwLeH0RPrD2JHeTUI5by/7y4k8AMCD
        BbLbNJ941QXD+jR6pFgi2uDpkt8g3lZu3B89pDPoMudr5iZxvt7c4Fe85bxACt0i
        atDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683637326; x=1683723726; bh=ROhERntylu2qi
        CzcHn0i+i5RbRQYKg4fYwpD6OJksxI=; b=kgHD6hJ6vD1ZG8PCYz5yLNQ6tVAVd
        +wNh/sD8j3GNS2FiteQM3HA8vEfvTl9Kn4O/PGoge/JItdE1UKq942ziB+0OG8WW
        oQeP/OON0z/VAViiyselrQBwNcZwkVuYRzHbTl1ILk/6cCvWTBEuHHbYGvOTE2li
        CcUmLA+n9K5N7csgvpfeIYW+wmU5jvEO4ay/iURXDaia9xoQAuUKnuBqqaOlRQD8
        F1HyWK9s67HBJ8wiVXyPiWH1Y8cDF0AlhTsSp+AGAuLZgJNfX6Kjetrl8kmIH8Kb
        ZSGZxD0BWdK8XJpz8XvkBqV4UyIZZ+5ICq8ZnJmvf8FOHltDKfvGlvkjw==
X-ME-Sender: <xms:TkRaZBPK1Jgn91c6dRIKOWJ1MN5upixm155Bwy0JzZ77GthunWKNnw>
    <xme:TkRaZD84oUuXOR_AbdzhDlZKCVb6a6zanT7mBBx_IHkfUz97Ozeu2ruUS-EGhRfkH
    EDCfTKmy66ZtIXbTQ>
X-ME-Received: <xmr:TkRaZATloX9tWTwHpLSeE2KaZR0ng6UejqiUPtZekIPnxcYjT6nK6MTU7GOAtcKZmgYJ-l6SKSBLJSKTFHRDx0SCiogC10qstvJzGpSuUbU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegtddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:TkRaZNuGQ6iZnFgUzdvt8ZgaBiD4Xisf1OPHZZm2sXHIW6UbfNJSEg>
    <xmx:TkRaZJfxEMhWETlnyIdfASELnSvMa-2IWI8-DfSaqfhG5lkQQevobw>
    <xmx:TkRaZJ0jX5KUrhD-qpDSKEOrGpZ0wead4cwmV0AMDHSBxdPZ0W2bOQ>
    <xmx:TkRaZA6F8sggUw-8nPgNeArqIXP5OJFidMBXcWwjmeOk28xps0PM7w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 May 2023 09:02:04 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id e864769e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 9 May 2023 13:01:57 +0000 (UTC)
Date:   Tue, 9 May 2023 15:02:02 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v4 1/8] fetch: fix `--no-recurse-submodules` with
 multi-remote fetches
Message-ID: <d82b42ed345ac7b482bf5dd96456f131ecb8c746.1683636885.git.ps@pks.im>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1683636885.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mkXOwQmngDqBW+Eo"
Content-Disposition: inline
In-Reply-To: <cover.1683636885.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--mkXOwQmngDqBW+Eo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When running `git fetch --no-recurse-submodules`, the exectation is that
we don't fetch any submodules. And while this works for fetches of a
single remote, it doesn't when fetching multiple remotes at once. The
result is that we do recurse into submodules even though the user has
explicitly asked us not to.

This is because while we pass on `--recurse-submodules=3D{yes,on-demand}`
if specified by the user, we don't pass on `--no-recurse-submodules` to
the subprocess spawned to perform the submodule fetch.

Fix this by also forwarding this flag as expected.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c             |  2 ++
 t/t5526-fetch-submodules.sh | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index c310d89878..08d7fc7233 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1876,6 +1876,8 @@ static void add_options_to_argv(struct strvec *argv)
 		strvec_push(argv, "--keep");
 	if (recurse_submodules =3D=3D RECURSE_SUBMODULES_ON)
 		strvec_push(argv, "--recurse-submodules");
+	else if (recurse_submodules =3D=3D RECURSE_SUBMODULES_OFF)
+		strvec_push(argv, "--no-recurse-submodules");
 	else if (recurse_submodules =3D=3D RECURSE_SUBMODULES_ON_DEMAND)
 		strvec_push(argv, "--recurse-submodules=3Don-demand");
 	if (tags =3D=3D TAGS_SET)
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index dcdbe26a08..ba69cd583f 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -1180,4 +1180,23 @@ test_expect_success 'fetch --all with --recurse-subm=
odules with multiple' '
 	test_line_count =3D 2 fetch-subs
 '
=20
+test_expect_success "fetch --all with --no-recurse-submodules only fetches=
 superproject" '
+	test_when_finished "rm -rf src_clone" &&
+
+	git clone --recurse-submodules src src_clone &&
+	(
+		cd src_clone &&
+		git remote add secondary ../src &&
+		git config submodule.recurse true &&
+		git config fetch.parallel 0 &&
+		git fetch --all --no-recurse-submodules 2>../actual
+	) &&
+
+	cat >expect <<-EOF &&
+	From ../src
+	 * [new branch]      master     -> secondary/master
+	EOF
+	test_cmp expect actual
+'
+
 test_done
--=20
2.40.1


--mkXOwQmngDqBW+Eo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRaREkACgkQVbJhu7ck
PpQpJA/8Dku3QQ+s8LRoNeZsnYj5/UuNqth8Qn2t8ti1ZsxdlQVttqQt2eYEBTsN
qbxkilcVVjd8RRRnmywpkh4Mu7Me3BKlLJ2Zp8/mZfFlNGR+rW4y4iL8maeD0q/a
jU7NOV5hYlvRbtvwbSTW1JB+FfHZ2CKyfz5VLv7oIyVHwW53preX/oc6WNp7iJBP
PLKkB3o4FdmrZw54UPOTwqaS3CklhqbYFi7VufvtJ1enTSkjg3n9349DSFFccGig
YhYmK+9G1+TCvV3XjEW7KGMVN4FpZjbIQPssENtD4BfoKAaSQjYSe4hvmnZ8tJsq
D1bWabusEVg8n34bFJwcSaYmz7cNugHAGeD96+aFXPvDBGHx2vFUSN3tnLWAlPV1
DvaSIcpWjkOo3qGqGM0pDPvi6QjRIGkm8yUtORjciPlx8YMs3FO4hsnDO097FP0q
u3fodRh1thHJeUgtMNdskFqepgVunQ7y5W1nUy2ng0dddEdxFYvqpyZZqd5Bv7a9
foMqTt9qIiHRm9uWvBBANT1bczV5cDNwG2B/mYr8sQiuIGtNFildM7E9mmBIREmB
J13mAwolcRlBXcHJ713xCcdyAgXvg4dluxZIhTPnKI8GPUPZqCN7rJ6pWHeIwoTo
Rcw4oU3DkQ2kKyP/EsAGamCY8O1GDcaJnPFXT65o2VKkyGgiRBQ=
=1/mw
-----END PGP SIGNATURE-----

--mkXOwQmngDqBW+Eo--
