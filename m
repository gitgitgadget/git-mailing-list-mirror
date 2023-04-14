Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E0EC77B6E
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 06:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjDNGBf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 02:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDNGBe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 02:01:34 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951921BC5
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 23:01:33 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 057595C018B;
        Fri, 14 Apr 2023 02:01:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 14 Apr 2023 02:01:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681452092; x=1681538492; bh=aC
        X2is+CXwznjAr9+mabqsMwaocaTyLIXf6fsXK+0jQ=; b=Fy4sDjdpA1n6rt1/lo
        B6lCX5HYpsmQF3D6eSLwb1AjnTCfUZkikPyP1pvhDgJF1XitxlqDasDTG2Kk0EGo
        GssNijMpcsFN9gaxuPQj2bWneYwJR4Uu2nT3gx11DWzecqooEUf2R00W4Lx7FkW9
        WpH5zowqWGK1mBTVhIFlEyHpQWh8rs7E/6CsqhRvzNS56fyVhHl0ODfChHJmpgg/
        UVXV6O9DiBKkrmtwYwRQs0FIa/AQJVtcWHOxuoL++g7EQnuuJ48cz31ohgYIE1C1
        dyebZapOaaUvnmyfU1RYL/uzCY+d5NxBPqGO2neuCO2YWg+SHsDNL2szT6WHsbNY
        2uxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681452092; x=1681538492; bh=aCX2is+CXwznj
        Ar9+mabqsMwaocaTyLIXf6fsXK+0jQ=; b=M15WL2zmHHObJJ3ywfzYomzt/cy+c
        VRjY2Lcyqi1DnPwjivPOmKj8OWsDxhR3UxUaUw1g5apAc0LNI4UA1Jb1BCvpxrRa
        BLXzLe1lJsGFNBh8Rg/3abKXCUw9Yeb35GKJCPJ36zsVXD1YQRp+CGQRbZRLZta8
        EA3w9o8IRkDpJOKBVwma/zxwCMlN7pGxQqofvCV3Otwzb71Lt/GxmJ1jv399tH6t
        OuZxmPBQ/hNiZsdQ958ap5NRO2w+wChaCNIzKR4t6ePwqwuLAKnnhWbB29iPgH08
        HBBUWy/tmQT9p/cNBF9mUfDs1N7nFOgcaTy+NU3M7j9M811STmDk0OKQg==
X-ME-Sender: <xms:POw4ZELdSMtD_MoOX2AMVoDy3nzaPhXkPDyTIRInvITiOXCspjLnKw>
    <xme:POw4ZEKdnYFFqvaL8wO8grY1rY-Sz-mKLhYMsHqrvyHKNrk5kPMt_YtIBMBwPOncT
    Ew3qGVk38n1_SxFfg>
X-ME-Received: <xmr:POw4ZEuZnfclQunI06TcI9XRexicfDGTm6sDztK5q0x2EgFTZ9bhTREjMoyBXlx0nJI1eBzYym2_bjTzYtnRH_OtzRlkzDumdV88PqNShYC6cLY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekledguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:POw4ZBYT26Xr3-kRSoYFjYi9O8UyqojfdzBC6AsN3-5Yauz382_ImQ>
    <xmx:POw4ZLao-Fm3tYNCqEQCFcFg_qboFotBLhgAmWNvPKHB2PoQ0OPhsw>
    <xmx:POw4ZND1IZNrrfHDBIZ0WZdanrE-93tURYpmq3EXCtfACW5XO2OO2g>
    <xmx:POw4ZHFFxauqy6AA0iE_TNAKbOECJlfB8wbfnFlNkwqZf90z1_tzNQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Apr 2023 02:01:31 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id fdb57acf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 14 Apr 2023 06:01:27 +0000 (UTC)
Date:   Fri, 14 Apr 2023 08:01:27 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, peff@peff.net,
        dstolee@microsoft.com, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 00/10] repack: fix geometric repacking with gitalternates
Message-ID: <cover.1681452028.git.ps@pks.im>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gQIEov0tz53DwwSb"
Content-Disposition: inline
In-Reply-To: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--gQIEov0tz53DwwSb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the fourth version of my patch series to fix geometric repacking
with repositories connected to an alternate object database.

This version only addresses some issues with the tests, the actual logic
remains untouched:

    - The test added in t7700-repack.sh that verifies that `--local`
      causes us to disable generation of the bitmap index was failing in
      the linux-TEST-vars CI job. This was because it sets
      GIT_TEST_MULTI_PACK_INDEX=3D1, which causes us to disable the bitmap
      logic in git-repack(1). I've fixed this failure by explicitly
      overriding the environment variable like other tests in the same
      file do.

    - I've converted path checks to use `test_path_is_missing` and
      `test_path_is_file` instead of `test ! -f` and `test -f`.

    - I've fixed a typo in t7703-repack-geometric.sh and shifted code
      around a bit to make the test more readable, following Derrick's
      suggestion.

Thanks!

Patrick

Patrick Steinhardt (10):
  midx: fix segfault with no packs and invalid preferred pack
  repack: fix trying to use preferred pack in alternates
  repack: fix generating multi-pack-index with only non-local packs
  pack-objects: split out `--stdin-packs` tests into separate file
  pack-objects: fix error when packing same pack twice
  pack-objects: fix error when same packfile is included and excluded
  pack-objects: extend test coverage of `--stdin-packs` with alternates
  t/helper: allow chmtime to print verbosely without modifying mtime
  repack: honor `-l` when calculating pack geometry
  repack: disable writing bitmaps when doing a local repack

 builtin/pack-objects.c        |  10 +-
 builtin/repack.c              |  62 ++++++++-
 midx.c                        |   6 +-
 object-file.c                 |   6 +
 object-store.h                |   1 +
 t/helper/test-chmtime.c       |   2 +-
 t/t5300-pack-object.sh        | 135 -------------------
 t/t5319-multi-pack-index.sh   |  12 ++
 t/t5331-pack-objects-stdin.sh | 240 ++++++++++++++++++++++++++++++++++
 t/t7700-repack.sh             |  17 +++
 t/t7703-repack-geometric.sh   | 164 +++++++++++++++++++++++
 11 files changed, 504 insertions(+), 151 deletions(-)
 create mode 100755 t/t5331-pack-objects-stdin.sh

Diff against v3:
diff --git a/t/t5331-pack-objects-stdin.sh b/t/t5331-pack-objects-stdin.sh
index 45e24fa94a..acab31667a 100755
--- a/t/t5331-pack-objects-stdin.sh
+++ b/t/t5331-pack-objects-stdin.sh
@@ -7,7 +7,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
-packed_objects() {
+packed_objects () {
 	git show-index <"$1" >tmp-object-list &&
 	cut -d' ' -f2 tmp-object-list | sort &&
 	rm tmp-object-list
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 93c5763e7d..faa739eeb9 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -114,12 +114,12 @@ test_expect_success '--local disables writing bitmaps=
 when connected to alternat
 	(
 		cd member &&
 		test_commit "object" &&
-		git repack -Adl --write-bitmap-index 2>err &&
+		GIT_TEST_MULTI_PACK_INDEX=3D0 git repack -Adl --write-bitmap-index 2>err=
 &&
 		cat >expect <<-EOF &&
 		warning: disabling bitmap writing, as some objects are not being packed
 		EOF
 		test_cmp expect err &&
-		test ! -f .git/objects/pack-*.bitmap
+		test_path_is_missing .git/objects/pack-*.bitmap
 	)
 '
=20
diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
index 33d7977fca..00f28fb558 100755
--- a/t/t7703-repack-geometric.sh
+++ b/t/t7703-repack-geometric.sh
@@ -10,9 +10,9 @@ objdir=3D.git/objects
 packdir=3D$objdir/pack
 midx=3D$objdir/pack/multi-pack-index
=20
-packed_objects() {
+packed_objects () {
 	git show-index <"$1" >tmp-object-list &&
-	cut -d' ' -f2 tmp-object-list &&
+	cut -d' ' -f2 tmp-object-list | sort &&
 	rm tmp-object-list
  }
=20
@@ -312,7 +312,7 @@ test_expect_success '--geometric --write-midx with pack=
files in main and alterna
=20
 	# We should also see a multi-pack-index. This multi-pack-index should
 	# never refer to any packfiles in the alternate object database.
-	test -f member/.git/objects/pack/multi-pack-index &&
+	test_path_is_file member/.git/objects/pack/multi-pack-index &&
 	test-tool read-midx member/.git/objects >packs.midx &&
 	grep "^pack-.*\.idx$" packs.midx | sort >actual &&
 	basename member/.git/objects/pack/pack-*.idx >expect &&
@@ -378,11 +378,11 @@ test_expect_success '--geometric -l with non-intact g=
eometric sequence across OD
=20
 	# Verify that our assumptions actually hold: both generated packfiles
 	# should have three objects and should be non-equal.
-	packed_objects shared/.git/objects/pack/pack-*.idx >packed-objects &&
-	test_line_count =3D 3 packed-objects &&
-	packed_objects member/.git/objects/pack/pack-*.idx >packed-objetcs &&
-	test_line_count =3D 3 packed-objects &&
-	test "$(basename member/.git/objects/pack/pack-*.pack)" !=3D "$(basename =
shared/.git/objects/pack/pack-*.pack)" &&
+	packed_objects shared/.git/objects/pack/pack-*.idx >shared-objects &&
+	packed_objects member/.git/objects/pack/pack-*.idx >member-objects &&
+	test_line_count =3D 3 shared-objects &&
+	test_line_count =3D 3 member-objects &&
+	! test_cmp shared-objects member-objects &&
=20
 	# Perform the geometric repack. With `-l`, we should only see the local
 	# packfile and thus arrive at the conclusion that the geometric
@@ -415,8 +415,7 @@ test_expect_success '--geometric -l with non-intact geo=
metric sequence across OD
 	test_line_count =3D 1 actual &&
 	packed_objects member/.git/objects/pack/pack-*.idx >actual-objects &&
 	test_line_count =3D 6 actual-objects &&
-	sort <actual-objects >actual-objects.sorted &&
-	test_cmp expected-objects actual-objects.sorted
+	test_cmp expected-objects actual-objects
 '
=20
 test_expect_success '--geometric -l disables writing bitmaps with non-loca=
l packfiles' '
@@ -428,7 +427,7 @@ test_expect_success '--geometric -l disables writing bi=
tmaps with non-local pack
 	git clone --shared shared member &&
 	test_commit_bulk -C member --start=3D2 1 &&
=20
-	# When performing a geometric repack with `-l` while connecting to an
+	# When performing a geometric repack with `-l` while connected to an
 	# alternate object database that has a packfile we do not have full
 	# coverage of objects. As a result, we expect that writing the bitmap
 	# will be disabled.
@@ -437,13 +436,13 @@ test_expect_success '--geometric -l disables writing =
bitmaps with non-local pack
 	warning: disabling bitmap writing, as some objects are not being packed
 	EOF
 	test_cmp expect err &&
-	test ! -f member/.git/objects/pack/multi-pack-index-*.bitmap &&
+	test_path_is_missing member/.git/objects/pack/multi-pack-index-*.bitmap &&
=20
 	# On the other hand, when we repack without `-l`, we should see that
 	# the bitmap gets created.
 	git -C member repack --geometric=3D2 --write-midx --write-bitmap-index 2>=
err &&
 	test_must_be_empty err &&
-	test -f member/.git/objects/pack/multi-pack-index-*.bitmap
+	test_path_is_file member/.git/objects/pack/multi-pack-index-*.bitmap
 '
=20
 test_done
--=20
2.40.0


--gQIEov0tz53DwwSb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ47DYACgkQVbJhu7ck
PpTx4xAApRGo5FHLDxMZB26O3x1MdIe4hsCUC1TOQBOSE6PtjB/FW+XZ7SM2gkcB
jO0dAhvr90KVUYMnLGRunrRttXhSCPjMT6ZNbNyDn4CopNuOH3gUtzvShr/3u1U0
VcRe7yYEpkh+Lg/fTYcg7+lBl+hHsQLsFwUpmmDU/lehC89Wi8vkYvbpgfrwxB9K
Jo2QzZdMiCGbfOufMiK+AxqzM5sS3JlfDQ08YRcS0rLw0D2GmyXcmhk5xVxXo/3u
1Gslvs5QbaKoZHqHRy/tp/79hhCH+7s4SkLoO+QVwo3/UNk2O6NH4YDt+1EL/N/P
auzQFHshxLJ2wZpQkSNKg43XnPgMFbXaupLD/dF4FJcREUrO/1LgSgqDohTQJGuf
pfFQScxkKj4DSiouz+6wHDZ5MkHlHpwq2cOoGeFUC8nZfoUsLe2DctyO0/WyH6AD
UmXqMMuCII7SF4yttPspTs3RCBFC7JTW6eAwNFxVSUfzDI6eBafNlYm6q3oNUA7V
NDTNL5KQj8jhK5LzCVtBRr4D1g5Y/p+Iz5RFbXPBBcQCf34thtntkXYA6qteFuay
82o6t3FGDZdts+8pn+H20wtllkeEtBW67HgxB0LT/ycKTpOBevxTcUx8fN+xEbDM
kAtfelzcqwuKpEP037O96XfOPq8OmTQeLKWdVDxTyD8YLMMsZ4w=
=fUcC
-----END PGP SIGNATURE-----

--gQIEov0tz53DwwSb--
