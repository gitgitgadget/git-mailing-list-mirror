Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78315C77B61
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 11:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjDMLRb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 07:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjDMLRJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 07:17:09 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D797D83
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 04:16:50 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 9CD0C5C00B3;
        Thu, 13 Apr 2023 07:16:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 13 Apr 2023 07:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681384609; x=1681471009; bh=dW
        TeKZX6b1nxaCGNtlKWBn4EL7y6fkExTN2HM7HHgzA=; b=fIcR348dMoeedfJGRZ
        iK94sYO2o0cNGP2t6y5go2Avlw7msBEvZfs+HEN9aOdZdulVHly6cg9ehnmpA0aq
        9/zBfdcNj06OmY5KLyqlKdXaIhN8h4ICRQ1+HI23WE5Vk9V2rlvjKlatQRuv1DAY
        /BFL4NucFmVIB/a3xbhpNITCT8ZiFqMSQpY5GrTJAG8wUa4N2PlRSYov6RwL47Re
        qkF/tRf5rMm8nL53WfF/dfCAYqtsq/VevKzjb8arfdbqyEtZx/oTsfADi8W5WzZa
        4mhFrPU8OL28DJQZBUm3CH9enje0pVClIjGWReUUuJrIelphX6HkWh6NWImm76z0
        M2cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681384609; x=1681471009; bh=dWTeKZX6b1nxa
        CGNtlKWBn4EL7y6fkExTN2HM7HHgzA=; b=UbUdPISzq+B5yaU6CzsCFxoV53RcV
        7v2tz4khrZjfvMjadB+ZW8EckKlzL2Ymx/FRgm0yzjj9MrOLVWUPkJuck30eu/Qd
        v9IPSD0mX8Cp/3OwyqH8ROP7kb72yJlule/IvVhtjK+NfIz3rYutxpPoGWMHrMGg
        SPvX+/V7bpabJM44bp0uWq6zbIiqAkLfxLdp6Em8gQAMQt/TzN0QCAvwS7ORRueg
        1wnJGX42UBL0gsXY7yw9Ag7kV3C31J/cN3NhZRwvoL0lBWlimORoU2mAWVQ3tP11
        BIJqUTaHC8uTHvBOlu8+VrKByCDvoke9fIGApO5OWwrwIEkWlR/3r3nMg==
X-ME-Sender: <xms:oeQ3ZKF72zZG--kiWJH5VwSnhD2h7veKtrXjB2Fbt55RAK8psrqgGA>
    <xme:oeQ3ZLVl6GpK84J1uqY6iuhc2Dy0XSXC34f2MErGGwqqYbMkofUHsok8FdK9QPX0g
    sWya7DJYlXnWHJyfA>
X-ME-Received: <xmr:oeQ3ZEJEkACbyg_6rvYK-NYFWzCMcpHklLbHlioa8vuwxz-5jT1xqKqycL90uY1AYNFoi5x9O4WpxMQdG6tU5Q4bu13OymOyb1EeP5wLgzRsN_4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekkedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedvnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:oeQ3ZEHIe0gAzyH8ElKn-jlfBbZDyJqOGUryk0Hh65UpgegJ-Hv3IA>
    <xmx:oeQ3ZAVuzkh-CO9tdZ7_ByerKX-bJrbzdNSX9XK-MsG2JWtFYcG9AQ>
    <xmx:oeQ3ZHPyP7qPzuqd_tEwPqZDBVXnLzGprrR4h6kcLa23b1Dd4zyrpQ>
    <xmx:oeQ3ZNhWdVc2HFyWdeVLhVGZYya65-KSNYIXFNI-2_mTcn1tIglTOA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Apr 2023 07:16:48 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 238be82d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 13 Apr 2023 11:16:25 +0000 (UTC)
Date:   Thu, 13 Apr 2023 13:16:46 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, peff@peff.net, dstolee@microsoft.com
Subject: [PATCH v3 10/10] repack: disable writing bitmaps when doing a local
 repack
Message-ID: <bb0ee0eb3c72c0e9f4306c9072b9dd104af965cd.1681384405.git.ps@pks.im>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <cover.1681384405.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rrOumJOzg78EXfDk"
Content-Disposition: inline
In-Reply-To: <cover.1681384405.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--rrOumJOzg78EXfDk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In order to write a bitmap, we need to have full coverage of all objects
that are about to be packed. In the traditional non-multi-pack-index
world this meant we need to do a full repack of all objects into a
single packfile. But in the new multi-pack-index world we can get away
with writing bitmaps when we have multiple packfiles as long as the
multi-pack-index covers all objects.

This is not always the case though. When asked to perform a repack of
local objects, only, then we cannot guarantee to have full coverage of
all objects regardless of whether we do a full repack or a repack with a
multi-pack-index. The end result is that writing the bitmap will fail in
both worlds:

    $ git multi-pack-index write --stdin-packs --bitmap <packfiles
    warning: Failed to write bitmap index. Packfile doesn't have full closu=
re (object 1529341d78cf45377407369acb0f4ff2b5cdae42 is missing)
    error: could not write multi-pack bitmap

Now there are two different ways to fix this. The first one would be to
amend git-multi-pack-index(1) to disable writing bitmaps when we notice
that we don't have full object coverage.

    - We don't have enough information in git-multi-pack-index(1) in
      order to tell whether the local repository _should_ have full
      coverage. Because even when connected to an alternate object
      directory, it may be the case that we still have all objects
      around in the main object database.

    - git-multi-pack-index(1) is quite a low-level tool. Automatically
      disabling functionality that it was asked to provide does not feel
      like the right thing to do.

We can easily fix it at a higher level in git-repack(1) though. When
asked to only include local objects via `-l` and when connected to an
alternate object directory then we will override the user's ask and
disable writing bitmaps with a warning. This is similar to what we do in
git-pack-objects(1), where we also disable writing bitmaps in case we
omit an object from the pack.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/repack.c            | 12 ++++++++++++
 object-file.c               |  6 ++++++
 object-store.h              |  1 +
 t/t7700-repack.sh           | 17 +++++++++++++++++
 t/t7703-repack-geometric.sh | 27 +++++++++++++++++++++++++++
 5 files changed, 63 insertions(+)

diff --git a/builtin/repack.c b/builtin/repack.c
index 5768aeb1f3..e2abcea2ee 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -887,6 +887,18 @@ int cmd_repack(int argc, const char **argv, const char=
 *prefix)
 	if (write_bitmaps && !(pack_everything & ALL_INTO_ONE) && !write_midx)
 		die(_(incremental_bitmap_conflict_error));
=20
+	if (write_bitmaps && po_args.local && has_alt_odb(the_repository)) {
+		/*
+		 * When asked to do a local repack, but we have
+		 * packfiles that are inherited from an alternate, then
+		 * we cannot guarantee that the multi-pack-index would
+		 * have full coverage of all objects. We thus disable
+		 * writing bitmaps in that case.
+		 */
+		warning(_("disabling bitmap writing, as some objects are not being packe=
d"));
+		write_bitmaps =3D 0;
+	}
+
 	if (write_midx && write_bitmaps) {
 		struct strbuf path =3D STRBUF_INIT;
=20
diff --git a/object-file.c b/object-file.c
index 8fab8dbe80..3ad11c683b 100644
--- a/object-file.c
+++ b/object-file.c
@@ -946,6 +946,12 @@ void prepare_alt_odb(struct repository *r)
 	r->objects->loaded_alternates =3D 1;
 }
=20
+int has_alt_odb(struct repository *r)
+{
+	prepare_alt_odb(r);
+	return !!r->objects->odb->next;
+}
+
 /* Returns 1 if we have successfully freshened the file, 0 otherwise. */
 static int freshen_file(const char *fn)
 {
diff --git a/object-store.h b/object-store.h
index 82201ec3e7..574f16140f 100644
--- a/object-store.h
+++ b/object-store.h
@@ -56,6 +56,7 @@ KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
 	struct object_directory *, 1, fspathhash, fspatheq)
=20
 void prepare_alt_odb(struct repository *r);
+int has_alt_odb(struct repository *r);
 char *compute_alternate_path(const char *path, struct strbuf *err);
 struct object_directory *find_odb(struct repository *r, const char *obj_di=
r);
 typedef int alt_odb_fn(struct object_directory *, void *);
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 4aabe98139..93c5763e7d 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -106,6 +106,23 @@ test_expect_success SYMLINKS '--local keeps packs when=
 alternate is objectdir '
 	test_cmp expect actual
 '
=20
+test_expect_success '--local disables writing bitmaps when connected to al=
ternate ODB' '
+	test_when_finished "rm -rf shared member" &&
+
+	git init shared &&
+	git clone --shared shared member &&
+	(
+		cd member &&
+		test_commit "object" &&
+		git repack -Adl --write-bitmap-index 2>err &&
+		cat >expect <<-EOF &&
+		warning: disabling bitmap writing, as some objects are not being packed
+		EOF
+		test_cmp expect err &&
+		test ! -f .git/objects/pack-*.bitmap
+	)
+'
+
 test_expect_success 'packed obs in alt ODB are repacked even when local re=
po is packless' '
 	mkdir alt_objects/pack &&
 	mv .git/objects/pack/* alt_objects/pack &&
diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
index c440956ad5..33d7977fca 100755
--- a/t/t7703-repack-geometric.sh
+++ b/t/t7703-repack-geometric.sh
@@ -419,4 +419,31 @@ test_expect_success '--geometric -l with non-intact ge=
ometric sequence across OD
 	test_cmp expected-objects actual-objects.sorted
 '
=20
+test_expect_success '--geometric -l disables writing bitmaps with non-loca=
l packfiles' '
+	test_when_finished "rm -fr shared member" &&
+
+	git init shared &&
+	test_commit_bulk -C shared --start=3D1 1 &&
+
+	git clone --shared shared member &&
+	test_commit_bulk -C member --start=3D2 1 &&
+
+	# When performing a geometric repack with `-l` while connecting to an
+	# alternate object database that has a packfile we do not have full
+	# coverage of objects. As a result, we expect that writing the bitmap
+	# will be disabled.
+	git -C member repack -l --geometric=3D2 --write-midx --write-bitmap-index=
 2>err &&
+	cat >expect <<-EOF &&
+	warning: disabling bitmap writing, as some objects are not being packed
+	EOF
+	test_cmp expect err &&
+	test ! -f member/.git/objects/pack/multi-pack-index-*.bitmap &&
+
+	# On the other hand, when we repack without `-l`, we should see that
+	# the bitmap gets created.
+	git -C member repack --geometric=3D2 --write-midx --write-bitmap-index 2>=
err &&
+	test_must_be_empty err &&
+	test -f member/.git/objects/pack/multi-pack-index-*.bitmap
+'
+
 test_done
--=20
2.40.0


--rrOumJOzg78EXfDk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ35J0ACgkQVbJhu7ck
PpSgaQ//W7eT+jp3T1xe+EaERkXZ+HCM49PipmGJVshgaSBGVSYIJoiAVi5SP5k+
wVvj+KZ4BuP2zJmihofmD+Yq6eZsxinQcmz2DQUSSD/6tu4xbhG4R1X4L3S6n0VN
HyW5kpk+SjCiXOJKZQSYKyAy4MBivBghpFAhxb7Fjfqjep0jCcom03IkxK2Jgp3A
dK0f2A/IdO/i9HvKPMjW/mBjQ6ZhINjOr8wh3enp3Ol1f+FAMtsk4xxEySI6wbFf
6mGk7Cr9I75vXs22sOH0UDqy+aR7y9Du7K0keZhD+Sx0sKickUZE2XKfaUUhNyAB
u8PZJMO/kUmB3e9mESPU3jNpXjsYQgcsUy32sVsKaPK/HT4zfGtlpetK23pkJXAW
nT668+v1bmIhDg5Frib1evFvs2N0MvKF7wWk4Wt9v0EUlT3T9V/LR20wLSfPsGHO
9ekCkr2dOlSM3FkUr2ITDBiimOkyeoIvw2HtTzLtpgbaNCsk7h/MFfuXIfCY8eso
7DqjCLhkyxAapMfkBP0QHfX0dVrMFpqjxgnxeF0GmO/uyoZMIecnNsIfCRpybiWt
cJ+BtwmMLjptuAkiS4z2TJlwMJ8T8uZZ6R4jyx/V/j6r4GTXT822vOUH95pvpBWs
Evm/LZVB3hwtwHMneN1mhUznx8Vj63GdQyk0k6uTb2Xp+SxFlWo=
=HCQW
-----END PGP SIGNATURE-----

--rrOumJOzg78EXfDk--
