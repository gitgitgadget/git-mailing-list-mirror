Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA79C77B6C
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 11:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjDMLQ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 07:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjDMLQm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 07:16:42 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE7BA265
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 04:16:28 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id C67415C00B9;
        Thu, 13 Apr 2023 07:16:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 13 Apr 2023 07:16:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681384587; x=1681470987; bh=YD
        +uzFYy86g02M+Kx5Mt4oxEeBv89essUbFzbMywJUg=; b=rW02CeqR2AaygisN15
        WvvdqcgrXXhkOH+l7T9h22MaEro2z0TO+HkWg0zRLELKn1+tK1h+pkcYUHm0WvNw
        5BtgLHXueBdJ5sRQXLrtw2MJWRjWOYS5cvvRg/Gr0Eeh5axjhGh1peQmngO5Eb0U
        YMjKg2Y0kfgVvw5LJmHFPBFmffyK/7rlmxKNVNcYoyJ9p2ICC8yPJfnsuUJA/YBq
        Kt4rsSN1p6HsQKFXpaZ8sN8qdsgaauhrqTW4Q4McJ1RKkfSi3ZTvdMjL4e8inRHr
        DvW77mTFZoYPOIfH+OctjrrnE/fwDv9l+qQKqpRkSqmpVeg5kEr0H+gOw1hHrTFA
        fL4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681384587; x=1681470987; bh=YD+uzFYy86g02
        M+Kx5Mt4oxEeBv89essUbFzbMywJUg=; b=IMH/6rsl9hFSDLPe7SgbpNQ35Yy4U
        vYG9rXouhu7RVWXFCdRoflnV7U5q1Vj9B0r6HbeiswyjE23fpQ7hpCe6lO/X72uE
        5szsYe5yG2KHnCPA6u8aZxMMyymH0et05MLY8hcz2e/d/qxs+ypp7U8N1zP8RgoZ
        ZN9PmOeWJNpqhVuPxTXMbiugzHayEBiqV/JSLY50nCZxH2fkSVde3K6bNEFukarv
        eUWFC6J0RnV5JylqOWjbUcl6EiOMao+bj+kUjuE3X6I20HdMsNfZSq3YWHqccKjA
        LeO4nVYqSHc5dl+kDZGLzSmv+/ZBrPWOfO8mUEFCIDqiBArO7Hfeh5SrQ==
X-ME-Sender: <xms:i-Q3ZFARsUUiHX_dsDyQtR5y2eKwBJJ_djCIPFl4CSwcYto__0K9Aw>
    <xme:i-Q3ZDhbqF9UNnQfYYtwnM-viLulWpBL0acLupLVc-EQuAbEt3pyDLc3pCb2070Ik
    CKf1tEE6qJ3fWRHuw>
X-ME-Received: <xmr:i-Q3ZAl_o5uAJpBVKDRYAcgXQHns5ctpShc-M9DA5mPxgyD109ZUBy-YTu3FM_eLIJWZiDtIV2tC1wTqE9S0TiUjkJkxA51x0iw-qnDfXESYNpk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekkedgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:i-Q3ZPyY7ldZbVTVper6R2A27rD0at6edpznfo8OQpQb2DM7n7BgSQ>
    <xmx:i-Q3ZKRPnZq5_QJaKMOVb12f0QkIt_bz7A36mToIFGSI5mUcj2CY9w>
    <xmx:i-Q3ZCbdnk6LdsIpSQ7wiQLoVeN7wRFvgC-BbKhQcDzwVd6I_ZRFNg>
    <xmx:i-Q3ZFctPb6AghDqVUiWKunnM2wyJBggm0O5Ax1BxueikGqVUKpRCg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Apr 2023 07:16:26 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 3c5cc697 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 13 Apr 2023 11:16:03 +0000 (UTC)
Date:   Thu, 13 Apr 2023 13:16:24 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, peff@peff.net, dstolee@microsoft.com
Subject: [PATCH v3 05/10] pack-objects: fix error when packing same pack twice
Message-ID: <ac528514e7e609adc00f417b30593722ef73105a.1681384405.git.ps@pks.im>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <cover.1681384405.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YBl/DMWB+hC57SkP"
Content-Disposition: inline
In-Reply-To: <cover.1681384405.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--YBl/DMWB+hC57SkP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When passed the same packfile twice via `--stdin-packs` we return an
error that the packfile supposedly was not found. This is because when
reading packs into the list of included or excluded packfiles, we will
happily re-add packfiles even if they are part of the lists already. And
while the list can now contain duplicates, we will only set the `util`
pointer of the first list entry to the `packed_git` structure. We notice
that at a later point when checking that all list entries have their
`util` pointer set and die with an error.

While this is kind of a nonsensical request, this scenario can be hit
when doing geometric repacks. When a repository is connected to an
alternate object directory and both have the exact same packfile then
both would get added to the geometric sequence. And when we then decide
to perform the repack, we will invoke git-pack-objects(1) with the same
packfile twice.

Fix this bug by removing any duplicates from both the included and
excluded packs.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c        |  2 ++
 t/t5331-pack-objects-stdin.sh | 27 +++++++++++++++++++++++++++
 t/t7703-repack-geometric.sh   | 25 +++++++++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 7e9e20172a..7d0e864c35 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3348,7 +3348,9 @@ static void read_packs_list_from_stdin(void)
 	}
=20
 	string_list_sort(&include_packs);
+	string_list_remove_duplicates(&include_packs, 0);
 	string_list_sort(&exclude_packs);
+	string_list_remove_duplicates(&exclude_packs, 0);
=20
 	for (p =3D get_all_packs(the_repository); p; p =3D p->next) {
 		const char *pack_name =3D pack_basename(p);
diff --git a/t/t5331-pack-objects-stdin.sh b/t/t5331-pack-objects-stdin.sh
index d5eece5899..def7640c91 100755
--- a/t/t5331-pack-objects-stdin.sh
+++ b/t/t5331-pack-objects-stdin.sh
@@ -7,6 +7,12 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
+packed_objects() {
+	git show-index <"$1" >tmp-object-list &&
+	cut -d' ' -f2 tmp-object-list | sort &&
+	rm tmp-object-list
+ }
+
 test_expect_success 'setup for --stdin-packs tests' '
 	git init stdin-packs &&
 	(
@@ -142,4 +148,25 @@ test_expect_success '--stdin-packs with broken links' '
 	)
 '
=20
+test_expect_success 'pack-objects --stdin with duplicate packfile' '
+	test_when_finished "rm -fr repo" &&
+
+	git init repo &&
+	(
+		cd repo &&
+		test_commit "commit" &&
+		git repack -ad &&
+
+		{
+			basename .git/objects/pack/pack-*.pack &&
+			basename .git/objects/pack/pack-*.pack
+		} >packfiles &&
+
+		git pack-objects --stdin-packs generated-pack <packfiles &&
+		packed_objects .git/objects/pack/pack-*.idx >expect &&
+		packed_objects generated-pack-*.idx >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
index 7027676977..d0823f2eb2 100755
--- a/t/t7703-repack-geometric.sh
+++ b/t/t7703-repack-geometric.sh
@@ -336,4 +336,29 @@ test_expect_success '--geometric --with-midx with no l=
ocal objects' '
 	test_dir_is_empty member/$packdir
 '
=20
+test_expect_success '--geometric with same pack in main and alternate ODB'=
 '
+	test_when_finished "rm -fr shared member" &&
+
+	# Create a repository with a single packfile that acts as alternate
+	# object database.
+	git init shared &&
+	test_commit -C shared "shared-objects" &&
+	git -C shared repack -ad &&
+
+	# We create the member repository as an exact copy so that it has the
+	# same packfile.
+	cp -r shared member &&
+	test-tool path-utils real_path shared/.git/objects >member/.git/objects/i=
nfo/alternates &&
+	find shared/.git/objects -type f >expected-files &&
+
+	# Verify that we can repack objects as expected without observing any
+	# error. Having the same packfile in both ODBs used to cause an error
+	# in git-pack-objects(1).
+	git -C member repack --geometric 2 2>err &&
+	test_must_be_empty err &&
+	# Nothing should have changed.
+	find shared/.git/objects -type f >actual-files &&
+	test_cmp expected-files actual-files
+'
+
 test_done
--=20
2.40.0


--YBl/DMWB+hC57SkP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ35IcACgkQVbJhu7ck
PpTutw/+IlpGruy2RRQYy0bX2oU8j7fumCO+F4OZZNDYmT9B4+QtpXl/m6EM6D8e
m/M+mbAlH58wVfVaOgxqpVATfmdine+45WNOGgMnSoVGgJBJ0OfERsduPWYbAjJc
8wem3QyItBfObs4IqEESL3fbamA/nUiZi2OSjBcHi9Op3TnYICChszc7g/u9GIUz
aFUv1g3ZnFF8NnPoXvD6qDrz76rA+NFKJ68J/Lta/qqD9IBAoyIOOTJ48Fdae7JH
W7ii8+kp0SPrzmTMA6bJGF5PJTMf6CgZw8yrg3s8Yrix+VX01iZMu1IsrXdoG9VD
dMBoZsB0kCif7bjYc617bApWqiAzIx3ZaOWpD+s4HMUovdcVlDbUCrnxIelQDIWx
f9mivdhaKS+/cS43cBUZH3wBZ5o4dgboqyTap2saez1VdiCirnyP6/b3LEglo9lv
ZhOAj0MDVbS1/24HDlQCHhjtVH9f39KllMswEPAslNTI2cMplf4t/lBTxduK+k26
RBtrMMa7sHwrO/wkcBZG1MfSaJ89Ad3fbbJwAJtwDZqE/M0tXLb+XgddIeud73qO
zdqSxQWrFtnroLoFfWhAyqn/Aag11xF1QKos9Ly/QFo09k7DgCRUDgELaouHuLGk
MwCyeq5UmU+K+YVrkRQtQWH+6B8IwpjmjGX/z3U/ApCd3LttWRU=
=WSRm
-----END PGP SIGNATURE-----

--YBl/DMWB+hC57SkP--
