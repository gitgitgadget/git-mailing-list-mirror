Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB46C77B61
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 11:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjDMLR1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 07:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjDMLRF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 07:17:05 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938D69EC4
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 04:16:45 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 0A3255C0106;
        Thu, 13 Apr 2023 07:16:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 13 Apr 2023 07:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681384605; x=1681471005; bh=DA
        is+3XDiFN27zOmt3TK1xaki9YbfH4QNk9jA8rOj0k=; b=SLurKIAnCHLf8uY+fi
        z2x+V9GkSMRrB4y5HW+VVXIOOzE67zIuTdOOz6zl7WW0F066Z4J4eZcDxdMgV4Av
        m2a3XMej8czAhKssXT4Coppzh40BTRdA7JE1k+Ta2v+C8CZAhY0j2siHXt8sDHs7
        McTE89mUBRVsE4QRdqXSpqyR91H3071p1cK6ZrlueIRAqcmuOMMLEbeg5C/RC2fV
        MrMot81qpsB6IeMDCJ/zlIwwWZEkqTzW+2N7mZXRQBbH8NmcfaqoyF/6wvozH0sc
        qhzM+umh16RDJI69jTzuzppLPiEekUUBJQLuJPV3HhoAraf8gbEVD9dELkR2/KpP
        vJOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681384605; x=1681471005; bh=DAis+3XDiFN27
        zOmt3TK1xaki9YbfH4QNk9jA8rOj0k=; b=A/1wW/kuwLibBwyl+vHc0BtqxRozC
        0tKo/JPAH5nqJr4xYu7T2vHGalXj80AXG+UM3kRpKnwZDhSEjxaa8PvPFa4dUIMZ
        frem+C94FNKXXNHAhnfH8++KVvuf2o7k6nKkXMWhPKBWIpL3fGWleVgNhGr8kMMT
        1y45JcYHmtQ0y9eo09EM6LgYmmCCQKX22XeAC36JsLbOLANZOyT9vraGZY6JO1l1
        YWPzeOne/cpEF6c4hj7VrFqkaxTuhl3CFGiVBs9rUMT4z5jdAQlN4D4x9LG6Dyi0
        u44se2ph4OFOWTexI4aYpTWePjD9+rA8rGRdgrHr/nKYy6PDHpspRvtpQ==
X-ME-Sender: <xms:nOQ3ZKyqJ-P5ut7W5VzyFnfKeiRiiECLqon712frSHjWTCWf55Aoqg>
    <xme:nOQ3ZGRPwCEf7E7Hd0MXbzUUnazmaCIsMU2I3u2aCTw6iKgWxF3RM1528Im8mQzrm
    xd8E4WcJfvq0ty_Yg>
X-ME-Received: <xmr:nOQ3ZMX9xQXfdlq7ysLqJL6AS3BZRq4Z2FQiTe5LnrjPpe5lQiBCNS4h4tcVxJ1YLfua2SOP6OphTOWTrAd-jsrMCuDLrA9mTNWnWO6gpdD9Q8s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekkedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:nOQ3ZAh3y2P7SsEdeLi4IEi2mxRmG4z5eQCHhgoeeOiRCnG5wno9SA>
    <xmx:nOQ3ZMCiNjIscjFPB08VBwfLVSa7rvuA-Xu66ZEe8X_nLQO-vVcYRw>
    <xmx:nOQ3ZBJoYoGWbyGwgJlHQbdo0irvn18MFmpcj5EG-yOryzSbebPvVQ>
    <xmx:neQ3ZPNHq-qnhIe7FfOV6wfIUW1KmyLnzGUb2omTsVhuOAlLPA9dYA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Apr 2023 07:16:43 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 012e6f1b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 13 Apr 2023 11:16:21 +0000 (UTC)
Date:   Thu, 13 Apr 2023 13:16:42 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, peff@peff.net, dstolee@microsoft.com
Subject: [PATCH v3 09/10] repack: honor `-l` when calculating pack geometry
Message-ID: <285695deafa5a4a49f774dc484782dd8e4fd4997.1681384405.git.ps@pks.im>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <cover.1681384405.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="URkQtSitGnLT6j2A"
Content-Disposition: inline
In-Reply-To: <cover.1681384405.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--URkQtSitGnLT6j2A
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
 t/t7703-repack-geometric.sh | 58 +++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 2 deletions(-)

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
index d0823f2eb2..c440956ad5 100755
--- a/t/t7703-repack-geometric.sh
+++ b/t/t7703-repack-geometric.sh
@@ -10,6 +10,12 @@ objdir=3D.git/objects
 packdir=3D$objdir/pack
 midx=3D$objdir/pack/multi-pack-index
=20
+packed_objects() {
+	git show-index <"$1" >tmp-object-list &&
+	cut -d' ' -f2 tmp-object-list &&
+	rm tmp-object-list
+ }
+
 test_expect_success '--geometric with no packs' '
 	git init geometric &&
 	test_when_finished "rm -fr geometric" &&
@@ -361,4 +367,56 @@ test_expect_success '--geometric with same pack in mai=
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
+	packed_objects shared/.git/objects/pack/pack-*.idx >packed-objects &&
+	test_line_count =3D 3 packed-objects &&
+	packed_objects member/.git/objects/pack/pack-*.idx >packed-objetcs &&
+	test_line_count =3D 3 packed-objects &&
+	test "$(basename member/.git/objects/pack/pack-*.pack)" !=3D "$(basename =
shared/.git/objects/pack/pack-*.pack)" &&
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
+	sort <actual-objects >actual-objects.sorted &&
+	test_cmp expected-objects actual-objects.sorted
+'
+
 test_done
--=20
2.40.0


--URkQtSitGnLT6j2A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ35JkACgkQVbJhu7ck
PpRhgQ//XSNpYNnWvINm3Bu/+YZiUrnI4OTgNlEm7y5WryLTnzV5pVmLXPQ1XWko
HGowVaHcU6wBuuDfrvzSN8Kcfuam2VIuOAYPC8KwcfP1udWy3vK570Ouq/OzjtFp
qmNarPpTokPRJEuqb/y5pVrJ0XzVrX2IwDgnzOG/aQPiWwb8MlDr2FkGRp2UR3C7
omeEPlgeKs7HlUIcyk+dHDm/JjWRwUALTfbaPNrNZ88Aj09Di9YI+ycLeclxH7Jk
oz7x7B4jUBE7CU3v/72jOwNxPAU/fc+GNbv9zmKr9jqTdpl5D8uc4BG6xvQuJ48G
f4LCeXMOweLbLhyRuSv/cOSpDMBs3alMIofvbfQcqyon7r3IA3jvd3fBzgZOvMD/
biEkcvIMoJWWuuvY/iJd2o3dmmcXRa3BcjlnjInf1FO8f33xzBaVW32KcMgob1UC
mwaFAxPO5ilK84iW310DYzoop4uzXSAvxcJaj8ZJu2I6qk3kCE1qib22n043kJqY
GbtEICXb3l4yjwzac49y4TmlBV+pvGEqrgn/wil8HhnVYdarvrySKQqMARRtdDuT
s+sdiiihyfHl0qLQ3D7Kz4Nz8DFomvwdm6un5rnkNVxOXlbewPwn/QsLzJ1sW68B
jJ5a/7NW3SHIWw5mMo1pWCV0gLe0FLAoE2H+EyLYQK3uh5JMSQ0=
=Vo0w
-----END PGP SIGNATURE-----

--URkQtSitGnLT6j2A--
