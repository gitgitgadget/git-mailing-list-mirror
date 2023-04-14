Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66714C77B71
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 06:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjDNGC0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 02:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjDNGCO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 02:02:14 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16F03A9C
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 23:02:11 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 4C0565C016A;
        Fri, 14 Apr 2023 02:02:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 14 Apr 2023 02:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681452131; x=1681538531; bh=2a
        jvvg3axUM6PiCVzv1qyoBbbCadM6AlLRfNrLGarWY=; b=deC7x0l0PF8KaRb9+i
        91RnxuZkFAU7HjaQIDDXnujtwzxULu3aRJr5VZ3VefPPh+Y7VSkA4CCAQvBdYy9c
        Jc9+E9RCXXiYsGnOsGPgl54aUXBe8cdUkkXf5iwSpxZCtXVh/g3inASU+uI+l0i1
        rggQ0rXmgHYkR1d3sO2xudvK9i/GCUsTxqB6OzvGDxteiqJcyPUJIxytCOAIBEti
        lSL8u7lb4YHLtEyTbnmWsdA2ovx/278YN6DivZAXTKF2eWl3vyUiyeFMhkexjBbi
        pk+DH+dVlet38eco5yMqwBit+s71/0XXbFUxzff/wIqu5O7FtRemJb+4etAnO0u3
        u4eQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681452131; x=1681538531; bh=2ajvvg3axUM6P
        iCVzv1qyoBbbCadM6AlLRfNrLGarWY=; b=H0fajee3sjZWzU6wx+Ykmr0Ybuyrf
        8af0rkSKhA9IMUG/3iXcW0ecMana1aJsKCHcS5/uuUfDsK49Gbd54hsiXNyqoU8s
        f9yDfIT/7L/r1c1zcEK+K0glNmi6IwKaFLRLKnyJTTLZ5fYKcCDCzMarDwVypAKg
        z9//nibaNhveF91qvRR33TuKxHYAWupkS1H4TVv7vdLGb9DeQ4SzjUFDr1Ch6lfy
        WOxKZMJKAYywn7hlrxEkTcq1+kM39+d/UjLSdKVEjTR4bdfD8ll9ThfKx82ciVXY
        0WFVzLjubz2sStznHte6h9C6HGN36e5UqYLNGhuiUcJ3pkaoEStP7kjwg==
X-ME-Sender: <xms:Y-w4ZC2maaaP_ccfMSAwhj7PNcjOx6obJ0EGon2-A0LoewwzufZDcQ>
    <xme:Y-w4ZFFLukXyJWRCXt6Y9OSEPnG5RWmvwynKn-Gcvwtn0YtM6eZEMSnHYsirWsW9n
    rvovpkcY0eIG8iDhg>
X-ME-Received: <xmr:Y-w4ZK4vCbSK6Xdmhn5S0tKMDl-uEX8BTIlr95X8SAfJUe3_jhr6LydRC-06EnAQevzwhgadBbW_AJro89aIwO_9aS_YnH31_A_9WIhc99wb9w8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekledguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgepudenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Y-w4ZD0NCwZYgIQNPAItvLObqP-afvaKY4P2pqEAbo6A5g0vxNhntw>
    <xmx:Y-w4ZFE1Gdcp4UQ0UnHFcaKVx4q1MZrFbVn1_XZxEbqPkbKqg3IZRQ>
    <xmx:Y-w4ZM8VNSHJlxBPHP_5gr3U10LnTsdcefLEiJqPsTqf4wgn-2g0xQ>
    <xmx:Y-w4ZFDG9t39tEA_V2q96iqp_hMzBApiunJP_StRtd6fiuWVDHDGGQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Apr 2023 02:02:09 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id c0d9202a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 14 Apr 2023 06:02:07 +0000 (UTC)
Date:   Fri, 14 Apr 2023 08:02:08 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, peff@peff.net,
        dstolee@microsoft.com, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 09/10] repack: honor `-l` when calculating pack geometry
Message-ID: <c512b58ae02832b1962ab165065fa20b7ca9c790.1681452028.git.ps@pks.im>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <cover.1681452028.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2XT9E+Si+pBwja90"
Content-Disposition: inline
In-Reply-To: <cover.1681452028.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--2XT9E+Si+pBwja90
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When the user passes `-l` to git-repack(1), then they essentially ask us
to only repack objects part of the local object database while ignoring
any packfiles part of an alternate object database. And we in fact honor
this bit when doing a geometric repack as the resulting packfile will
only ever contain local objects.

What we're missing though is that we don't take locality of packfiles
into account when computing whether the geometric sequence is intact or
not. So even though we would only ever roll up local packfiles anyway,
we could end up trying to repack because of non-local packfiles. This
does not make much sense, and in the worst case it can cause us to try
and do the geometric repack over and over again because we're never able
to restore the geometric sequence.

Fix this bug by honoring whether the user has passed `-l`. If so, we
skip adding any non-local packfiles to the pack geometry.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/repack.c            | 13 +++++++--
 t/t7703-repack-geometric.sh | 57 +++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 80fc860613..5768aeb1f3 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -323,7 +323,8 @@ static int geometry_cmp(const void *va, const void *vb)
 }
=20
 static void init_pack_geometry(struct pack_geometry **geometry_p,
-			       struct string_list *existing_kept_packs)
+			       struct string_list *existing_kept_packs,
+			       const struct pack_objects_args *args)
 {
 	struct packed_git *p;
 	struct pack_geometry *geometry;
@@ -333,6 +334,14 @@ static void init_pack_geometry(struct pack_geometry **=
geometry_p,
 	geometry =3D *geometry_p;
=20
 	for (p =3D get_all_packs(the_repository); p; p =3D p->next) {
+		if (args->local && !p->pack_local)
+			/*
+			 * When asked to only repack local packfiles we skip
+			 * over any packfiles that are borrowed from alternate
+			 * object directories.
+			 */
+			continue;
+
 		if (!pack_kept_objects) {
 			/*
 			 * Any pack that has its pack_keep bit set will appear
@@ -900,7 +909,7 @@ int cmd_repack(int argc, const char **argv, const char =
*prefix)
 	if (geometric_factor) {
 		if (pack_everything)
 			die(_("options '%s' and '%s' cannot be used together"), "--geometric", =
"-A/-a");
-		init_pack_geometry(&geometry, &existing_kept_packs);
+		init_pack_geometry(&geometry, &existing_kept_packs, &po_args);
 		split_pack_geometry(geometry, geometric_factor);
 	}
=20
diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
index a358dfb7bd..be8fe78448 100755
--- a/t/t7703-repack-geometric.sh
+++ b/t/t7703-repack-geometric.sh
@@ -10,6 +10,12 @@ objdir=3D.git/objects
 packdir=3D$objdir/pack
 midx=3D$objdir/pack/multi-pack-index
=20
+packed_objects () {
+	git show-index <"$1" >tmp-object-list &&
+	cut -d' ' -f2 tmp-object-list | sort &&
+	rm tmp-object-list
+ }
+
 test_expect_success '--geometric with no packs' '
 	git init geometric &&
 	test_when_finished "rm -fr geometric" &&
@@ -361,4 +367,55 @@ test_expect_success '--geometric with same pack in mai=
n and alternate ODB' '
 	test_cmp expected-files actual-files
 '
=20
+test_expect_success '--geometric -l with non-intact geometric sequence acr=
oss ODBs' '
+	test_when_finished "rm -fr shared member" &&
+
+	git init shared &&
+	test_commit_bulk -C shared --start=3D1 1 &&
+
+	git clone --shared shared member &&
+	test_commit_bulk -C member --start=3D2 1 &&
+
+	# Verify that our assumptions actually hold: both generated packfiles
+	# should have three objects and should be non-equal.
+	packed_objects shared/.git/objects/pack/pack-*.idx >shared-objects &&
+	packed_objects member/.git/objects/pack/pack-*.idx >member-objects &&
+	test_line_count =3D 3 shared-objects &&
+	test_line_count =3D 3 member-objects &&
+	! test_cmp shared-objects member-objects &&
+
+	# Perform the geometric repack. With `-l`, we should only see the local
+	# packfile and thus arrive at the conclusion that the geometric
+	# sequence is intact. We thus expect no changes.
+	#
+	# Note that we are tweaking mtimes of the packfiles so that we can
+	# verify they did not change. This is done in order to detect the case
+	# where we do repack objects, but the resulting packfile is the same.
+	test-tool chmtime --verbose =3D0 member/.git/objects/pack/* >expected-mem=
ber-packs &&
+	git -C member repack --geometric=3D2 -l -d &&
+	test-tool chmtime --verbose member/.git/objects/pack/* >actual-member-pac=
ks &&
+	test_cmp expected-member-packs actual-member-packs &&
+
+	{
+		packed_objects shared/.git/objects/pack/pack-*.idx &&
+		packed_objects member/.git/objects/pack/pack-*.idx
+	} | sort >expected-objects &&
+
+	# On the other hand, when doing a non-local geometric repack we should
+	# see both packfiles and thus repack them. We expect that the shared
+	# object database was not changed.
+	test-tool chmtime --verbose =3D0 shared/.git/objects/pack/* >expected-sha=
red-packs &&
+	git -C member repack --geometric=3D2 -d &&
+	test-tool chmtime --verbose shared/.git/objects/pack/* >actual-shared-pac=
ks &&
+	test_cmp expected-shared-packs actual-shared-packs &&
+
+	# Furthermore, we expect that the member repository now has a single
+	# packfile that contains the combined shared and non-shared objects.
+	ls member/.git/objects/pack/pack-*.idx >actual &&
+	test_line_count =3D 1 actual &&
+	packed_objects member/.git/objects/pack/pack-*.idx >actual-objects &&
+	test_line_count =3D 6 actual-objects &&
+	test_cmp expected-objects actual-objects
+'
+
 test_done
--=20
2.40.0


--2XT9E+Si+pBwja90
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ47F8ACgkQVbJhu7ck
PpQo8A//TB7Etr6iDut+B+EOvVAJpizpiCrylcqykYlxTOCFsajXr6OAqjwUPPhy
8bHgnnTDxw5Amy3g7Je6RX5PVu3YOm7PPl6gmNMOPNyrc6on8LCGI4Wd/TnjUYPI
zL5WVED11pghm/RCS0bkm5vA0YTZ5htX4e3n3zSXqEiiveVdp3HwAlwKBGUT/Sz0
qsjOdru0q9nEH8amSitrKF8hLnjgTEH7/ObjosH1B8JJnFl4Hrv/XvtbHYm1g1K5
2sK0NTWDzDzzWFPzvkMpy8uIZB7aO1rdI/aoTCJdTPJFZ6PwbjsI2f3+0EGQ23pu
wqkKBpDUGMXdDOaSIzMTXmw+ZJW3/GylW+NCefffcNpg2XUm1KZntHab8GAxqvFC
KiRMDQBU2KM03z+Q22hIhdN0imbTwe8dUNfwngZ9+2NO1avR0nD+ggE/2ytUP4mD
SjgmcQWXdqmBABIGNSLGkhTTO12RRr4xYNAGGqx9i4t6IYKP+GeQDR4GuYb7mN3K
Ns1utifkZkK8VfjKQOHThq7nPH2DVGUlAfENdGGkdzUHNh6U5fkFCJzCOnlc97YK
wPWTSAyieayRVZ28Jp2vjh1kR2fJxirTYqkaVLBAaarBrbpvzEuh46sRdaJHJzsW
wEtGJ4s7mxUbQrhN6rT84oXhmhLNpDBpFrcqYD/OUMFX8F+gj/0=
=w2xb
-----END PGP SIGNATURE-----

--2XT9E+Si+pBwja90--
