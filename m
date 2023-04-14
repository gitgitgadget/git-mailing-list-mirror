Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2102C77B6E
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 06:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjDNGCg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 02:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjDNGCU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 02:02:20 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A764A7280
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 23:02:16 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 139885C0081;
        Fri, 14 Apr 2023 02:02:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 14 Apr 2023 02:02:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681452136; x=1681538536; bh=kH
        OKqgdY2hE104jAjOsiBFBZJWthZ4gSIb3fJvYFTEw=; b=KItNWVP84SL4wFdgot
        isCwZi2lNqfycQxS8ekIdehfvM+JaZqR5VQEN6Re74sL+mb+GP1OxNFFG9LiUJHo
        lEbnP+dpBhbY568R5WQD5UKUlQvRqWJ2h4xTyUe2dpyQdLwEuS3uu3pnTbtDgEdP
        belHA5hRDiiwk7VAvwu14MUBcne/wmVmMPePJbo3oVurhB0D2uf4zvS4WOrgztWr
        RuHzC0pl8zoNNYvHiB70sCbpexx07rR9w5KwaP2/4YpIGur42RNYX/UOeBQRaP3p
        LQN/e460i8/Ssmi+3MsX4F/w279Yu4kJak5spnL7Gks1kNnq4ykGSq7O2EaJ2Opy
        YOkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681452136; x=1681538536; bh=kHOKqgdY2hE10
        4jAjOsiBFBZJWthZ4gSIb3fJvYFTEw=; b=N5jiMf/C9XVmwASYUyNThvNkSdSQw
        UiBIr0+DXbeo9ZfQgpg59T/Z475IhTWj0i6YvIRaBJAWMD35FfiFvrelCHZgaxrN
        Q07yYXEp6c1BWZpmCpK2JAMiok4+l+YvvASKzM0JAufNy7NB0g1mmHu16ONNc5s6
        E0jAC9sZYPIiFeNoSTetLGExS27+qOSgMlbJQw9nMfG7DgCC63DcbBLZXOZe1Dgc
        T2l4KmaDQxCMo8ajVOO4SmC8kytpHt4GZ5TgQst14W0tDQEmExCBh3+eyxvEOTHA
        kDpFBmrvlW6QmtpGBmAgYmr2DS7ifWSmhXFHU9WUBypkhbA8Yd1tABvZg==
X-ME-Sender: <xms:Z-w4ZO6-XtGZdHpjhEeQA9pqWkHdj5qdnqPk7ZcJTfA5k18uDeUUyw>
    <xme:Z-w4ZH47P_QK1T0_F7NLdSq75gBMWsqRdpurhG7gKP45c0JjK-rmTZXPFjjNzDsMO
    _6o2fYBdB0_kxraUw>
X-ME-Received: <xmr:Z-w4ZNfg5-FOe2Hdb4ea-sN2-TnfleqsIScKt7u098l-bY9irL8LAnhCsVAi-nwpWT9TwhevCRBfiWUtuCsYGcE6rD3N2aJ8NVsSlo7RLT_Z8mY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekledguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgepvdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Z-w4ZLJR04BWJ7fS2nd5-ou8xZUOIoKQHh8aO00BH8NyTUTQWPlysg>
    <xmx:Z-w4ZCJ5u51SmajsaNI8uyQGrguhU5Y59ZPgICGx355YoBw1PMFyDQ>
    <xmx:Z-w4ZMy75T__Yw9bqQjzAak6lbv2axXLJGZHasefJj4ab_d3RMbs0A>
    <xmx:aOw4ZO1OZap-d_vD1hrdiMdgqCUc_I4nS6Ap9cwU7sTlIo8_ypPhwg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Apr 2023 02:02:14 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id f03c67c6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 14 Apr 2023 06:02:12 +0000 (UTC)
Date:   Fri, 14 Apr 2023 08:02:12 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, peff@peff.net,
        dstolee@microsoft.com, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 10/10] repack: disable writing bitmaps when doing a local
 repack
Message-ID: <03503f9fc19523ce999f2baa20120c3f178f8d1a.1681452028.git.ps@pks.im>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <cover.1681452028.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v+DWpUryhFBHGYEV"
Content-Disposition: inline
In-Reply-To: <cover.1681452028.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--v+DWpUryhFBHGYEV
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
index 4aabe98139..faa739eeb9 100755
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
+		GIT_TEST_MULTI_PACK_INDEX=3D0 git repack -Adl --write-bitmap-index 2>err=
 &&
+		cat >expect <<-EOF &&
+		warning: disabling bitmap writing, as some objects are not being packed
+		EOF
+		test_cmp expect err &&
+		test_path_is_missing .git/objects/pack-*.bitmap
+	)
+'
+
 test_expect_success 'packed obs in alt ODB are repacked even when local re=
po is packless' '
 	mkdir alt_objects/pack &&
 	mv .git/objects/pack/* alt_objects/pack &&
diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
index be8fe78448..00f28fb558 100755
--- a/t/t7703-repack-geometric.sh
+++ b/t/t7703-repack-geometric.sh
@@ -418,4 +418,31 @@ test_expect_success '--geometric -l with non-intact ge=
ometric sequence across OD
 	test_cmp expected-objects actual-objects
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
+	# When performing a geometric repack with `-l` while connected to an
+	# alternate object database that has a packfile we do not have full
+	# coverage of objects. As a result, we expect that writing the bitmap
+	# will be disabled.
+	git -C member repack -l --geometric=3D2 --write-midx --write-bitmap-index=
 2>err &&
+	cat >expect <<-EOF &&
+	warning: disabling bitmap writing, as some objects are not being packed
+	EOF
+	test_cmp expect err &&
+	test_path_is_missing member/.git/objects/pack/multi-pack-index-*.bitmap &&
+
+	# On the other hand, when we repack without `-l`, we should see that
+	# the bitmap gets created.
+	git -C member repack --geometric=3D2 --write-midx --write-bitmap-index 2>=
err &&
+	test_must_be_empty err &&
+	test_path_is_file member/.git/objects/pack/multi-pack-index-*.bitmap
+'
+
 test_done
--=20
2.40.0


--v+DWpUryhFBHGYEV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ47GMACgkQVbJhu7ck
PpRNkxAAnvh3flH16toag/hU8eTK6kLw/Cq5uGZGG2cQjKLfZiD/jF0w77AEWR5z
D1rdmPF2fYxDDIy/wLTexGc4l39bHkIMheVn4Mw+RJ0d3HlO6wR+HSr3hjXFplS/
aNciqxCZCIBPispqmqvYlrnVm8MzTS01ldqyoCF1un8FfeZydiQSw4nLnyi07M9S
alqerP4tiZhnVrHm/bvNySP1UhgvrJUvVVMOAuT9IPnuNrtdLYWS4lqdIK7bc7RF
7DNnu7PqxdJ9bIQY0EQfWaXR2BGVCvnchrVFdPjsoQokC9KWAz/WLG0B3I/cBwFR
S2IihUBnC2kxRTdrKQ/mE4L3MUd8XABBMbuo9uWQb8Tv2xBHHUVCjaYAJ4CSARSg
uJwd/mkeFQESYP0HjhqWMk+Dhk2/UqXl6YSwL1tQrJK7w1tdfScp+N7yxEru3jT1
LMpr4ke+5qiS4epcrzp0Of2nY768TP8ks/HVOVL6DXIU5Tp6dL42n3exzOu7Y5dg
KiJoeTPIXcdAndx6J9u5T4xkIwymGiVI2dN9SxOd6X/dd5HNpvaugFMxfneueKNZ
fsdFM46dPZlZl8ezpInVKa4InENDyUMrVL9kKLA6MhLdR0V6ph1iJVhLVp7SZFdP
QrxRaEsrPnEM8lU7s03XZuh9wOChqpA25pLSomZcVIqKqKqZPuQ=
=qp2Y
-----END PGP SIGNATURE-----

--v+DWpUryhFBHGYEV--
