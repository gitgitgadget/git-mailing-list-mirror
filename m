Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09260C77B71
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 06:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjDNGBt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 02:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjDNGBo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 02:01:44 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6F44200
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 23:01:40 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 72DDB5C015E;
        Fri, 14 Apr 2023 02:01:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 14 Apr 2023 02:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681452099; x=1681538499; bh=UH
        wMkoVNu2mPzX4R7olEGUoM63W0CtyNI3UbXl+95/E=; b=Fikx30idCWbhQPA45w
        OFBb23q/+y0ac5bWRteITCNBax9HExuSm7GgVfB275PAHyZ6E4a5gwADSsZJT0oG
        IT9bNzH0Rgz6bSF+SF3Tuzra1MR7KTszhcPOfjaVDkz04LR/7Oml+ZwAVEDE/Ytq
        psh/RDA8e3OwY/GRwUE3Uw1GZXwKk1tLC1lTaPcMYVORZnxTKQvZDyRl83n0Xp/Q
        PFTCP6zB0b7mMpqZwNK5x4xxO9bZdvw+d7rC6qAlQhnwszrsAASBzTQEWjDTJN5F
        RmZNZiI0kZsx7MB/JHNQX594pxbAyUNxzJxAjMtW8J6hTOW8pDO70mKAxcVxpZ34
        x0Mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681452099; x=1681538499; bh=UHwMkoVNu2mPz
        X4R7olEGUoM63W0CtyNI3UbXl+95/E=; b=DgVLmOeN2oD2sq99NZYDrRMgO4HhX
        +oQm+65/vKLSZan4BMajdD4aKZVyGPOhFB6LnKhI5lO4f7hmyEIx8EnamB04xM9q
        XEyOWfLArPEHTPuXqoaDSL9y8aYIF/E1DsLs0Hb68S1nmOQaWG2r939cE/1rx/mM
        Yj2NnCBBZ04yPUW0sD61knUqw29/is2GkQySgwWLg3cbcsoJVis4U1sCIHrVGbLw
        0Ft1xWyQagdOp6i0VlNJSFOjcV735iTuU9szGF21A7UJbbTXM9wIGzIVgeFuHfFB
        LvFXShwfNgVNME/+oNz1MGq5kA3P+Gx3q7ZXNRsza4tEFsKFiMQtMDZmA==
X-ME-Sender: <xms:Q-w4ZI0Aqsja5IsVFy9REO4oIRwm90cvawHYHaxjqeJy2quAfH61Kg>
    <xme:Q-w4ZDEG0zyfZwoOHwk_fb4bt2A6crdmNqcLB4UuWO7iqIV2Ep6Pko_mJ5Yc4jgjt
    ShpqJZLTQIYkPWn5A>
X-ME-Received: <xmr:Q-w4ZA4B9qftkb3AQQ7QdIIUM-F47vx6qWgqJCgbSfc0G3MPJpqAvJdvMbq5OIZGaloKX9ihp4LISh_JgrIDteHB4DIyMplrwn9xASrQm44o2nQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekledguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Q-w4ZB1zfOoIwpUYAliu9JuTcwHy_nC2JjPEYASIqjeGvqu1XiJ7zw>
    <xmx:Q-w4ZLHVaCf2ucMXzdyS-D--Gi2T9mzJbyGmIl6TGNcKWwYnqWI04g>
    <xmx:Q-w4ZK-esvWHVgncd5qiUZcCPdj_ZXIGSXoLtuS86fuuJSiM04eqLA>
    <xmx:Q-w4ZDCLiCLPE2D8LXUBOjQZq3_Co_RVG7AYDY1EUxdX9Bs_so73wA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Apr 2023 02:01:37 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 04db8293 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 14 Apr 2023 06:01:35 +0000 (UTC)
Date:   Fri, 14 Apr 2023 08:01:36 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, peff@peff.net,
        dstolee@microsoft.com, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 02/10] repack: fix trying to use preferred pack in
 alternates
Message-ID: <36c3eb65ca1590d0c77dff3e49d6d6f1515d1bc5.1681452028.git.ps@pks.im>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <cover.1681452028.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OnbliH3uH+c1jZ+v"
Content-Disposition: inline
In-Reply-To: <cover.1681452028.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--OnbliH3uH+c1jZ+v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When doing a geometric repack with multi-pack-indices, then we ask
git-multi-pack-index(1) to use the largest packfile as the preferred
pack. It can happen though that the largest packfile is not part of the
main object database, but instead part of an alternate object database.
The result is that git-multi-pack-index(1) will not be able to find the
preferred pack and print a warning. It then falls back to use the first
packfile that the multi-pack-index shall reference.

Fix this bug by only considering packfiles as preferred pack that are
local. This is the right thing to do given that a multi-pack-index
should never reference packfiles borrowed from an alternate.

While at it, rename the function `get_largest_active_packfile()` to
`get_preferred_pack()` to better document its intent.

Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/repack.c            | 26 +++++++++++++++++++++-----
 t/t7703-repack-geometric.sh | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 87f73c8923..687419776d 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -446,8 +446,10 @@ static void split_pack_geometry(struct pack_geometry *=
geometry, int factor)
 	geometry->split =3D split;
 }
=20
-static struct packed_git *get_largest_active_pack(struct pack_geometry *ge=
ometry)
+static struct packed_git *get_preferred_pack(struct pack_geometry *geometr=
y)
 {
+	uint32_t i;
+
 	if (!geometry) {
 		/*
 		 * No geometry means either an all-into-one repack (in which
@@ -462,7 +464,21 @@ static struct packed_git *get_largest_active_pack(stru=
ct pack_geometry *geometry
 	}
 	if (geometry->split =3D=3D geometry->pack_nr)
 		return NULL;
-	return geometry->pack[geometry->pack_nr - 1];
+
+	/*
+	 * The preferred pack is the largest pack above the split line. In
+	 * other words, it is the largest pack that does not get rolled up in
+	 * the geometric repack.
+	 */
+	for (i =3D geometry->pack_nr; i > geometry->split; i--)
+		/*
+		 * A pack that is not local would never be included in a
+		 * multi-pack index. We thus skip over any non-local packs.
+		 */
+		if (geometry->pack[i - 1]->pack_local)
+			return geometry->pack[i - 1];
+
+	return NULL;
 }
=20
 static void clear_pack_geometry(struct pack_geometry *geometry)
@@ -589,7 +605,7 @@ static int write_midx_included_packs(struct string_list=
 *include,
 {
 	struct child_process cmd =3D CHILD_PROCESS_INIT;
 	struct string_list_item *item;
-	struct packed_git *largest =3D get_largest_active_pack(geometry);
+	struct packed_git *preferred =3D get_preferred_pack(geometry);
 	FILE *in;
 	int ret;
=20
@@ -610,9 +626,9 @@ static int write_midx_included_packs(struct string_list=
 *include,
 	if (write_bitmaps)
 		strvec_push(&cmd.args, "--bitmap");
=20
-	if (largest)
+	if (preferred)
 		strvec_pushf(&cmd.args, "--preferred-pack=3D%s",
-			     pack_basename(largest));
+			     pack_basename(preferred));
=20
 	if (refs_snapshot)
 		strvec_pushf(&cmd.args, "--refs-snapshot=3D%s", refs_snapshot);
diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
index 8821fbd2dd..4abc7d4c55 100755
--- a/t/t7703-repack-geometric.sh
+++ b/t/t7703-repack-geometric.sh
@@ -281,4 +281,36 @@ test_expect_success '--geometric with pack.packSizeLim=
it' '
 	)
 '
=20
+test_expect_success '--geometric --write-midx with packfiles in main and a=
lternate ODB' '
+	test_when_finished "rm -fr shared member" &&
+
+	# Create a shared repository that will serve as the alternate object
+	# database for the member linked to it. It has got some objects on its
+	# own that are packed into a single packfile.
+	git init shared &&
+	test_commit -C shared common-object &&
+	git -C shared repack -ad &&
+
+	# We create member so that its alternates file points to the shared
+	# repository. We then create a commit in it so that git-repack(1) has
+	# something to repack.
+	# of the shared object database.
+	git clone --shared shared member &&
+	test_commit -C member unique-object &&
+	git -C member repack --geometric=3D2 --write-midx 2>err &&
+	test_must_be_empty err &&
+
+	# We should see that a new packfile was generated.
+	find shared/.git/objects/pack -type f -name "*.pack" >packs &&
+	test_line_count =3D 1 packs &&
+
+	# We should also see a multi-pack-index. This multi-pack-index should
+	# never refer to any packfiles in the alternate object database.
+	test_path_is_file member/.git/objects/pack/multi-pack-index &&
+	test-tool read-midx member/.git/objects >packs.midx &&
+	grep "^pack-.*\.idx$" packs.midx | sort >actual &&
+	basename member/.git/objects/pack/pack-*.idx >expect &&
+	test_cmp expect actual
+'
+
 test_done
--=20
2.40.0


--OnbliH3uH+c1jZ+v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ47D8ACgkQVbJhu7ck
PpQ5Nw/+J0rpqcHEXrX9hMEDToDnZdKN0eM6BVEry0vZOW64vJVoo1a9jjP/ljkM
KbxSWwZMcJOCuOhEp7WNx2QcM9GBCaQvWNL7UvPJstdqEdqLWmECmn6sPXxA/i/8
/BxWncAW1Mqab9JVaa1KyujhRO9fjkRPfL8UHGefVmN8Jkm6FZ+h/Mz0VUOTAGkN
c7selAVfNK9AN+QmmfSKE0i6xeNualR2XKQGhyRMvkcC4OK51KBBPcp50Y5APMRK
T0JVgo/biQyjeooc76x2isiiCG6RS8UTwvczC3SKL0zVs+z/z8mNOFBluSjElC2L
MHUvz7D6oJUj+acguavM8v0ra3XY6XkreNeCkgA54spttEM/sqm0ZMTcfQCjbZRW
TwOWuSaDNFO8JxVfj3LZ1dQbRnseGGtWEJh1oaYkzxUTMWkNm14/mXFkfRNeyYTt
VkPU1Cfv8O9knOftJMeEm1KE+MGUeTQ8KYd1ftzuCN0bWKJaDJKhxPK+7u51PykQ
9Ig3fbhC4H+MWefqvPlhSmWdyrXa1EByBlNi/fmiJZlVG7MAnYzTnullRWtwu7DB
/bo80+Z7vU/1Cz1vIM4XHkHWwcj6mrYaUabLyBvD/t7FWLJmjQ2DyiEv1tLDcinZ
svvebx5cX3AkR47RsJcB9gr1sFFPTzg6Lp4MKuCciCs6Zy2Uwec=
=5Oxy
-----END PGP SIGNATURE-----

--OnbliH3uH+c1jZ+v--
