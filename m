Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE26C77B71
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 10:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjDLKXY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 06:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjDLKXF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 06:23:05 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E096E87
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 03:23:00 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 43DB43200981;
        Wed, 12 Apr 2023 06:23:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 12 Apr 2023 06:23:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681294979; x=1681381379; bh=cL
        C7rR08BvrCD4BZ30X2sSsFUcBMmeOu+5gFUCuK0cs=; b=cAvpse6HS9kSVeRSRN
        3lTIG8Gckk/+/80ruVxxVGd5UtVqGJDJgUuOhDmG001aW7/U2Oz3I/f8k37IjoYt
        bFxvpEYY12v9tS9C6eU674InYTlTOJ6CGyiRcivDxBGiqK1RO/rEMbd20vL2wCrn
        FuQ6CP+i2MnZd/SPK4GTkU0FJ69aY6dg6YJcjyg4YAkUpxCteQ6NcbjsmRFUFrGk
        l4wahs0wm8UtVJCRNpnIonuSix66k1Zy0/SM1Tkip8eKN9mRUqoLHmMklKn+tjTU
        DMbQW5Xnj8XwGHsN7roywEAGKMqe93BfdDAOTB9fJItjvg8uf/3W5URRbdCPwhoD
        J0QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681294979; x=1681381379; bh=cLC7rR08BvrCD
        4BZ30X2sSsFUcBMmeOu+5gFUCuK0cs=; b=WvY3nKDagb/lBcrGqGdqLPiKjXh+K
        HV3tcJqAmQciTFwRYR0XiCvzTeSC3WJVLlQLjf6zED678ajeQMbUEr2IUPhoTkw+
        kVBOenIkPqGUPR60kq3BIrPTMsfJ/us2Xi9EUQuyy9caxOGOFAAJkpdONlbtWpVB
        gC7rl4cnOkzxAZOvmS/gncqm/DoDVRWV4b7bL6bwDOwGDIUjvx3oIGwY4O9hby5p
        FAEuK/ELQPG2DpPUecJaNZ9uvVnMl5d2auFBVMzre803R0bdhIIT6x29MhDxE6q5
        ckUo3bh92YtrBGz4rECkoW12x+Jf+2M5JpHJZS3KFkyML4uMBpec1uaPw==
X-ME-Sender: <xms:g4Y2ZFrRHbk-3YGenooLXC4kZm1YFUFTojXxCoCd8tul_SvPYhp6TA>
    <xme:g4Y2ZHobt-4bvdMG3mvRUz3R6nCi9e0W-QJhBFoRQ1mVmGBfuAjQAGq-xQc0a1-lk
    qO29J2ZewSQrI6P4A>
X-ME-Received: <xmr:g4Y2ZCOnfj4hJbi1ZKCcf-4fommC5prKusJzP3X5gpiB8fcWBcudldGOI7lwJj73zSRmNsubZHgFiEHFfLyaAUm48SLrEazgn3pjSoHkR0M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekiedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpeefnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:g4Y2ZA4IPhkek_oyg0k0a9HdxrGRW1RVzG79OgCxSdilZmSK-v36XQ>
    <xmx:g4Y2ZE7G0UczVuZVOjMsNpw0HGjpB0d5h_gw0mbzr76D2aqgUnSgVw>
    <xmx:g4Y2ZIgfSgFU9isvJ3Ip-FjRGl9xangmqz3-TpGF0DjvAp-qaUHwhw>
    <xmx:g4Y2ZEEPRmQAYBc0B0ZPOs8njLTEILc7V-NeB1PuC7-xbSKKC06Pyg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Apr 2023 06:22:58 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 31f0d03e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 12 Apr 2023 10:22:38 +0000 (UTC)
Date:   Wed, 12 Apr 2023 12:22:56 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, peff@peff.net, dstolee@microsoft.com
Subject: [PATCH v2 7/8] repack: honor `-l` when calculating pack geometry
Message-ID: <608dde4ad52c28ef42845b6bfdcb168e252bd29b.1681294715.git.ps@pks.im>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <cover.1681294715.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BrvMiK5VlhVhNsKB"
Content-Disposition: inline
In-Reply-To: <cover.1681294715.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--BrvMiK5VlhVhNsKB
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
 builtin/repack.c            | 13 ++++++--
 t/t7703-repack-geometric.sh | 59 +++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 80d4e813c8..f57869f14a 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -325,7 +325,8 @@ static int geometry_cmp(const void *va, const void *vb)
 }
=20
 static void init_pack_geometry(struct pack_geometry **geometry_p,
-			       struct string_list *existing_kept_packs)
+			       struct string_list *existing_kept_packs,
+			       const struct pack_objects_args *args)
 {
 	struct packed_git *p;
 	struct pack_geometry *geometry;
@@ -335,6 +336,14 @@ static void init_pack_geometry(struct pack_geometry **=
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
@@ -897,7 +906,7 @@ int cmd_repack(int argc, const char **argv, const char =
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
index 0a2f2bd46c..96c8d4cdfa 100755
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
@@ -361,4 +367,57 @@ test_expect_success '--geometric with same pack in mai=
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
+	# Note that we are using stat(1) to verify idempotence to also verify
+	# that the mtime did not change. This is done in order to detect the
+	# case where we do repack objects, but the resulting packfile is the
+	# same.
+	stat member/.git/objects/pack/* >expected-member-packs &&
+	git -C member repack --geometric=3D2 -l -d &&
+	stat member/.git/objects/pack/* >actual-member-packs &&
+	test_cmp expected-member-packs actual-member-packs &&
+
+	(
+		packed_objects shared/.git/objects/pack/pack-*.idx &&
+		packed_objects member/.git/objects/pack/pack-*.idx
+	) | sort >expected-objects &&
+
+	# On the other hand, when doing a non-local geometric repack we should
+	# see both packfiles and thus repack them. We expect that the shared
+	# object database was not changed.
+	stat shared/.git/objects/pack/* >expected-shared-packs &&
+	git -C member repack --geometric=3D2 -d &&
+	stat shared/.git/objects/pack/* >actual-shared-packs &&
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


--BrvMiK5VlhVhNsKB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ2hn8ACgkQVbJhu7ck
PpQz8g//Z1l5w3PTXqWRyaZ6Mkl2AQXiFFwZIvjKmgsBZvLieQpBFrFLO9scf1MJ
crhrVA9dFqlBbw01z63KJsKEIhZOypTGUrgNWTfGM0mhzXuA97vau0WWU/yTY3rK
hlYfLnYrLZOY4b25luw1yxpdADvbPNvKcfN+qhJnFnoX4A7f8wTkZAG6E/h8LqOi
bZdl55wyyck7MTMKXv7rWK5TxWUsQauTX4yRNhYzzuDEowjWuLeqfFNgUFEvL0Iz
+Qv2TSp7c0+drTMV6UmoOEHxLnkkgLe8nHlhWUJYFI4Waefs8GxDbGrKd/ZgW+Ht
SJuuIo3rdd01SoGutHERwhWSZpdc3sfcOatRMF+e85j3oYQnT9buka254OldqnIT
ZCvmdXQZNwX+Rfiy9o9f9IVpwSzjR4QhQ/2982H4BuXfX3PzreFmzpQwLfc1kxIt
KHEXoAWt1VLkKmb7SklgbAi+8NMqTps/aPpKOwStJ6sOFN1G/QHdVry6h8De0O4c
4oQXWqq1gYEviS9fZXYW3P5Y/3XDu+HTYkv0dJHKgSQlFBnjKHt1rkd0jQCfXFe4
SvMMDZWi2k9KDDFMFZ7pzT/TI8mH4qsMhw+BcZB2Glz7y/6UCUaz7ehPtiHsqI3b
13EPnJUiHvB7ejKxvI2UJxvIWpWwtgCTUbjoITYaxJjHxl5WGn0=
=NvNh
-----END PGP SIGNATURE-----

--BrvMiK5VlhVhNsKB--
