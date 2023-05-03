Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65591C7EE23
	for <git@archiver.kernel.org>; Wed,  3 May 2023 11:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjECLeZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 07:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjECLeY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 07:34:24 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E7049FF
        for <git@vger.kernel.org>; Wed,  3 May 2023 04:34:22 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 3DD8D5C0112;
        Wed,  3 May 2023 07:34:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 03 May 2023 07:34:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683113662; x=1683200062; bh=Id
        q28KO96fzGDjdAYh295dy2isAPObLh1weTI3FCaw4=; b=CAuCeHZJ7y1YRc5gnI
        bbH6h+FZ73tmlNhn8osfxlJYcjdi04AnwXcMj2m9JM3zIaGF6W/AyHYJShqgOLif
        cIqxza1E2RtyppOgdJltRnh1JYgPmY9uyvZWhysbpB81JiCJx4LvV8PhZ8OxmhY5
        6GJWNRehO2YerAOLS8t+IK3EZlZ26ofBrVhBzIcazOiUc5Eej2Z09fN4IZ5kKN1p
        hmawlqFAd+RHZBsHuui5IS2SoCmHLjETAcR4dCJjcaHtKRvXs4n0S5jdMQwLg5lL
        1GH8o4GR796EYEZiTtoba6A+rPLXQF3FpEwPPNr6VcjVvzL/Wesx8tg+U8W/KjeP
        9SYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683113662; x=1683200062; bh=Idq28KO96fzGD
        jdAYh295dy2isAPObLh1weTI3FCaw4=; b=OS5n5cA81icSa6p+RDlmr3KA1RrWQ
        ujGccxQ2J4gawo3zCeZDCcbUyQIrT0IvGT2vYKoWteyXmQIkoG2khA/5ZG/3qMEX
        lfEA97LWx54L0OCMwTN+WlTPimc3QUOCX9nrx4AfoikiV3gt/gG0A69xHBKsC8bI
        iGhy+ZkFWvHbzbjhXzVJZe965IoctMENoq5HaB5Ag5zgd86gHJAdSrUP6SiZhS3o
        LxcL8+zhRKrQ117umYefnRM2Rsap7ifIHDp2o6gpDagDQjgOcx7IZcjxrMp8sRVw
        M24Q6goA73YICcuyApaKNBLCvBUMm5o0+rzKPLczVah06lhlwCnChkWWQ==
X-ME-Sender: <xms:vkZSZEc5P7D_xiLhYO9DOnaxfrH_eAEZdaCQS99WFnB87OUo_BuA4g>
    <xme:vkZSZGNJy3-zuOQPOinXDvCvgft6im7ObOWM2lhgelJJ4qhWaMjJjSD1A5JMsSMc_
    Mho1q009J-PLCaX4g>
X-ME-Received: <xmr:vkZSZFiJIYbr_r-uhl-DbWf-MYtVb6AZbq3RWhZNcuMs0AnHFXvkajMRCgJStNI3SFpU4TIGUnNZzLA62bIr4ZsGENBHtf6AdfVffcdPbAU6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvkedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:vkZSZJ_2r2-yTMXGP1XIHE-govm8GIohrena-fiG4PLpsuhzv6O36Q>
    <xmx:vkZSZAugVh5f23FrJjN47yAXLrHAADb8v68QeQyiRrcIoPy5ySicmg>
    <xmx:vkZSZAGjtlPYbpKOwVtoCHD7bGKjbT0Hpgl91_UEX95Tv4OWecyHsw>
    <xmx:vkZSZCI5RQ_pn30PP3ThROSpEcyiggXjFN5C_9j7VK26DhNgh2AeMg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 May 2023 07:34:20 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 78ec18a6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 3 May 2023 11:33:39 +0000 (UTC)
Date:   Wed, 3 May 2023 13:34:18 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v3 1/8] fetch: fix `--no-recurse-submodules` with
 multi-remote fetches
Message-ID: <4b2b0cfe15ca6b3c9058bc9cb6944ba05d60a228.1683113177.git.ps@pks.im>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1683113177.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UL/FgxXln4iVhbB0"
Content-Disposition: inline
In-Reply-To: <cover.1683113177.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--UL/FgxXln4iVhbB0
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
 t/t5526-fetch-submodules.sh | 31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

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
index dcdbe26a08..162e5bac2f 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -1180,4 +1180,35 @@ test_expect_success 'fetch --all with --recurse-subm=
odules with multiple' '
 	test_line_count =3D 2 fetch-subs
 '
=20
+test_expect_success "fetch --all with --no-recurse-submodules only fetches=
 superproject" '
+	test_when_finished "git -C downstream remote remove second" &&
+
+	# We need to add a second remote, otherwise --all falls back to the
+	# normal fetch-one case.
+	git -C downstream remote add second .. &&
+	git -C downstream fetch --all &&
+
+	add_submodule_commits &&
+	add_superproject_commits &&
+	old_commit=3D$(git rev-parse --short HEAD~) &&
+	new_commit=3D$(git rev-parse --short HEAD) &&
+
+	git -C downstream fetch --all --no-recurse-submodules >actual.out 2>actua=
l.err &&
+
+	cat >expect.out <<-EOF &&
+	Fetching origin
+	Fetching second
+	EOF
+
+	cat >expect.err <<-EOF &&
+	From $(test-tool path-utils real_path .)/.
+	   $old_commit..$new_commit  super      -> origin/super
+	From ..
+	   $old_commit..$new_commit  super      -> second/super
+	EOF
+
+	test_cmp expect.out actual.out &&
+	test_cmp expect.err actual.err
+'
+
 test_done
--=20
2.40.1


--UL/FgxXln4iVhbB0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRSRrkACgkQVbJhu7ck
PpTbTQ/+IsoYxhiEjaaBFP0G4wrWuwyuL9BY0d5OxHTRbGJARlb7+ol5rCbjBmxu
Kt7aLnM5jwwTiygjr3GIAABXNoLW6h3FGoIBt5sIGa8pNFbVaEeKm+9ibqLNoUwO
/2oib3HaajDEN9ZBb0meOM++R4AUCo9SSVdPNPWuOXYnCkXjAIaDYDJAf8/SppVF
cEkTJAFsaYJk7yIccVIrqkVtEh1fz4El345KCDUdPE16C9q16h++5l63gos9xBDv
K0mMsuupVFizh8X0qts/HuVv0VFlhHFpFcx1u+9yV2V3gKINW4uQ6KpgUE+HVmEL
gCPkD0l03jsD4VT1fDhM8QO08vAMXFAGxQE7xV/HOQxd3fqIjkDs1HJX26ArBlMB
kcSncQ03OGeJQX+dhi0suSYjYzPLFUfbHG/6CGjeQwNng17jmF/7dNvNmjKRHU8+
Ds8p9whW3ofeujDsl/TfYHUDceRfM/zojNhLhLGz3APihhbt9PPp3Z/odjon3ugC
uwYw8D/qY4usxTaEDjIX4ov3p8TJJkSGijBERXo/S+u2qhQKdygcwBIsLRrIsBFh
1qC20JBYiFe4wbFhglQV5UFGmqRYluEg26QNi82osiPtUECCq1VysEprrfYtkwmz
u2wOHN7yZACkOtQpo/xDZb5TP//WFpx5IqshCznkZhgLoB8Y7nA=
=9M/y
-----END PGP SIGNATURE-----

--UL/FgxXln4iVhbB0--
