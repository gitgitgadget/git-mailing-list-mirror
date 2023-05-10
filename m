Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0F4C77B7C
	for <git@archiver.kernel.org>; Wed, 10 May 2023 12:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236673AbjEJMeL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 08:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjEJMeK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 08:34:10 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215C15FCA
        for <git@vger.kernel.org>; Wed, 10 May 2023 05:34:09 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 465313200918;
        Wed, 10 May 2023 08:34:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 10 May 2023 08:34:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683722047; x=1683808447; bh=s9
        i+8tJEWLPvYCzjqsdGvO5pKetJqqKmSSkrV3pFZDE=; b=G0V/zmiOwh/DooCF9/
        SOgYj0aMmuL5L1xb3gPe8Y8dTqdIVeXBeqz1mq6Jxg+osKNoYjwAtpnGDq87zeMj
        0VlW/uJ47PEEZ9UBp1iHHNB7FnoIxGemWpPIWZzpTePMBm3S0LT/uk9YgbJtEQbI
        sXXXMqidNzsbiGlOKnqca/i0cHLlk0UXcEydW83v5qdK5GcIAR29dzmsfXcwoI3U
        xt4HXuSt3NbzDn4IN6gtDkDBxaB1by1f1kgl15NiHwEcgQtvCMlMi8YX2VEI8W2y
        P4IhzpytMehF8y97UIEcQeDf5tbhKWZdVCz5SSvSMj6UHCon80VgR/J8e8OnJF3Z
        5Fww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683722047; x=1683808447; bh=s9i+8tJEWLPvY
        CzjqsdGvO5pKetJqqKmSSkrV3pFZDE=; b=fCIItgaxp1XpLfwPFbcLA7d6YKG5j
        Ea9Iuj4wpfngZ/NDJthHxJV2dxIp23zLVBUXp0DskuFxFpytwPkEnpCR1NU2wl1P
        C87dA+wAEKQA3HruQ6mhO7Dyzpr8daPAZ+KX3w2/N597AXThAbHpU6HajYN4mKZ0
        K7sGqnDjA/sTyzdZ9mxgfzON9N3RTB/hINwPPKjxJIVMlYQFHwJrACAkME5fLIIm
        OSgZLCVayrsrbkDzTZ8TK3ra8urKCzu+ppyY0ArU421lXvqRmpAw5a2Du88cbVDF
        YEz8cFa8GqUG7kyTUVDXAzLUxEHUZYhoG80gMs3IC/id1SWUuDpoXqiKQ==
X-ME-Sender: <xms:P49bZK7KzIx8cf36e8UIGtlAECYCuRBPZSZ58NYmm4YGd5vkVS5Sog>
    <xme:P49bZD68qPWjQ3v82n8AizLDnVpaJGEKndIq3imfTNQl7aq86rell7fuHYvmUxBDN
    2efDaOH48MVtKZSKg>
X-ME-Received: <xmr:P49bZJcygHZlLkVxLAesZPFJyQbDPawhDCT_i5KteO6TjB_0ebJv7r--aMfSNqNUAOYav_I17S5uI3z1SJDmocqNlBE14EaVpZLJcaW27XaI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegiedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:P49bZHKgIHwV_Ak1WPF-J4tSnEMXEeeElBK48ntGxUQZh7SlNq_CCQ>
    <xmx:P49bZOKAZivuBm9S0qbM4f82zmYpNAHhPQ8L8brpxuzT1KPK42Zr4w>
    <xmx:P49bZIyIrt9MDlVbEZD__WQxNuLtWMC75DR045eSLWrObTCB3gnfxQ>
    <xmx:P49bZDHOrsjq0AV1t7IoWVkiGGj4OlAf9bBjPxMo1IX3uzW4gWE1NQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 May 2023 08:34:06 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id dd42e52d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 10 May 2023 12:33:55 +0000 (UTC)
Date:   Wed, 10 May 2023 14:34:02 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v5 1/9] fetch: fix `--no-recurse-submodules` with
 multi-remote fetches
Message-ID: <02ee4fab7e8b46bb04b1e7509bd752144ac77a12.1683721293.git.ps@pks.im>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1683721293.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a/BGXH+gM7cB/DJ5"
Content-Disposition: inline
In-Reply-To: <cover.1683721293.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--a/BGXH+gM7cB/DJ5
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
 t/t5526-fetch-submodules.sh | 13 +++++++++++++
 2 files changed, 15 insertions(+)

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
index dcdbe26a08..26e933f93a 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -1180,4 +1180,17 @@ test_expect_success 'fetch --all with --recurse-subm=
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
+		git fetch --all --no-recurse-submodules 2>../fetch-log
+	) &&
+	! grep "Fetching submodule" fetch-log
+'
+
 test_done
--=20
2.40.1


--a/BGXH+gM7cB/DJ5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRbjzoACgkQVbJhu7ck
PpTtsA//ZhKNU7PLPBpu2rc7QXByHQ8BaLG4VDDAofckG+I5adph1UnXpnfsiq1N
qd0vt53EJEcr1XiOkSNU9xzy3GWwDd1uC6mYcilMn4pXrAzVqIqvmJ/XOVs8TB1N
kyAk1jo+eJqLy5cRssiLFB3bZl39i/s9DbOXCDRPelQ+WILoG3W3K5xnR/gm4vN4
tLLatsycw6du+TK/+W3HRSURAuxqb8u9oP1/O7/BDb19ro4AU94s/e5d2uF4ZF7/
1U8FfJSdjHoHV4emdaQVpcNsdWMKMPo74BFhwfJBe7fU9ZxZnphZlgUAYjWjR3NN
KSYOR/vwkxu7wQZTQtTvsI523gkEZJDiIhXZ7Da4kr8n5WP5T2FUPntdQFZ1RUh2
JYXAOGpq5HFajfPeJ9pw1jrLl/UPH5N+sTjuO9L+JdXW+bwB4yq4A7Sa5ngLKLaO
54pcNE/j52cpjap8RflD2I84Z5D96EFZv4Fcwso4yKjK6qK4vGDfU599I4QVxWgz
BEb+HlcCkFofkvMHrk0ZSA8WWKS65cP7hcl9qkHxyze1+D9DcVS6aK3ka9IJnHLv
A0Yw8gFcF65xaKTxNwe+4CglN761vxjR3QUL3YLy1A5TcQTXHoqnmDGmY8aOwNUO
XxJXqqcvHPZeB5xIPOBOiVInAznVbX5ej99lC7eyes/KhaSnGQw=
=o29d
-----END PGP SIGNATURE-----

--a/BGXH+gM7cB/DJ5--
