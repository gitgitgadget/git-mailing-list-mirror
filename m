Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520ADC77B70
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 06:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjDNGCF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 02:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjDNGB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 02:01:57 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F065B93
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 23:01:54 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 87D3C5C0150;
        Fri, 14 Apr 2023 02:01:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 14 Apr 2023 02:01:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681452113; x=1681538513; bh=HS
        MCxnMbLLXSWBQ7C6NuL3L0x69p9YT4KckBLzzMpsM=; b=KXbqWP9cKkkN1XDEUA
        t/iVHbCTn+AqTrY3uuruzJxyveRPBVRL9YOB4pl5Ec4wPfwp4KEFrke4P3B5wZKj
        9lo1JRCUkIvUTRmNJHngJk1GVLHeERNjB7M+gl+IpMBcovtVl3MlfRWD6P8WVI+L
        JJYDoxOVc4sH+9htF8R/n77E/8DvxP+NOF41RE3snCC3YSYwIksy4657Iue4QTOu
        S89sGSwIQVludNVGG2e4uboNmaH2CJ4zzGI1KQLlIPDM7tANbjL2JW1mF5iEcOju
        z3xX00lefGGDuPxSCdIFoO3gc7P9NF/HLhp6LJtqJOezcsiL4rrIXC+dsuCjP83S
        Avog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681452113; x=1681538513; bh=HSMCxnMbLLXSW
        BQ7C6NuL3L0x69p9YT4KckBLzzMpsM=; b=HeGpvjnz1RcEoBBJx6BFjQeUTBVMG
        aUoVkVBkUCTWu7PWOMBOp1IWXLVSr3pSHAxJ4juFtSWcA1BtGKoBqI65w8pcJOWi
        dqUMEPNI2frI2GU/0B7yb64MxWh+kxYt6aYfj4fpkiwaxGa+vtgkkq2QOW6Vkmfi
        Hxtp/YeVwOTs8yWwHUBpleib6tm7Z74/oR4HmbTnwOIH1Qjei3uxCznyi8oR3pUW
        tJoQNpfddAPwMy/kkyAN9gH0wIyEiUcWiztAV9ION5/Fq1SWfbUOzqQX2zR/KCnX
        SwVWM+UEuU4bOJcuqwdCMKYeLef8CQvNMrHGsk+ApMqX68f6r2BaEAU6Q==
X-ME-Sender: <xms:Uew4ZKLMdkm7MhhQfjW20FVfR6HLqC73x-ESXgQ78xwS69BJOInpcQ>
    <xme:Uew4ZCLJvGy7I8gv9FLBi9k9V8ugDa8rn8P5f7R3y6L3Gc6lIl8o8l-w0T6X67geQ
    5d2-7BTcbqE_W4Gtg>
X-ME-Received: <xmr:Uew4ZKuHzscUVhaZtijgndOMPiztAJp8hNi6vTBW-PpAhm1Ml22TcpbJZhC-uVjjhVfbuqlPo3qGV-sd8QooiESQBxdEVaz1W0Kmy0Gf6IC7RCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekledguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgepudenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Uew4ZPbRWkEAG8IBueiZIkItHTBpf01H7RAcQpCCc59RUFcGx7OeFw>
    <xmx:Uew4ZBYuWouOp2aUhKRQ2ndo2e8HYnXaDhj_96xWGicC86jw0DyWwQ>
    <xmx:Uew4ZLD_-2s9v49xpmky-dLFHFDUVI97stGaYpfO5uJkJFpYdsLkSw>
    <xmx:Uew4ZFGrYpnB1gfaB22pE3QqU6SCmOOqZDd5NDvtxdvdNjINtkpRCQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Apr 2023 02:01:52 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 051533b6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 14 Apr 2023 06:01:49 +0000 (UTC)
Date:   Fri, 14 Apr 2023 08:01:49 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, peff@peff.net,
        dstolee@microsoft.com, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 05/10] pack-objects: fix error when packing same pack twice
Message-ID: <7881828de7fa86a7d7e169b1ed67765334a814f4.1681452028.git.ps@pks.im>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <cover.1681452028.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qfKx8M5SJscFRd5R"
Content-Disposition: inline
In-Reply-To: <cover.1681452028.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--qfKx8M5SJscFRd5R
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
index d5eece5899..71c8a4a635 100755
--- a/t/t5331-pack-objects-stdin.sh
+++ b/t/t5331-pack-objects-stdin.sh
@@ -7,6 +7,12 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
+packed_objects () {
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
index 9dd002437f..a358dfb7bd 100755
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


--qfKx8M5SJscFRd5R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ47E0ACgkQVbJhu7ck
PpSKDg//T0n7vwGLvb/Jah2WtSTep8a/7770TJ8P0mgJR7Ky2b0O+AZ8Q0dmdMl4
+KtWUltG3nHLqZP4PXg8MDPmmwaHoRFqlrELzaNpPo1+iW4+J9WwJSgHMKxoe3Vk
qmboLETtjuuFnrk9fusDd2EbApzoiCreZV59yZlplihw6N4pn/173KoXRchORG6w
YxB1mW+95Y1bZEqvQA4RYnkYRmMrRwyLVA+OGw+iTIu7akk+8ZTBObsQn6FVsVgt
DFoCff7ZJ8L5F+FuiTIQeMDkRhiLBkDQmeMRjsRcLI/JraQQiL/WPpe7CjJ+Ejgh
5Epxiw7Vp37VsRZ8364STX3pX14kXLQK/SmUB9mP9yDJ7J/9yyAiRYaV2aN2qni6
Ye6+oLFmF6fjRAngoxWiN4ECkv6gPT9meIE7fKdOCm3FnDlnTL/4PUU+b9HH6llF
CVjg0ZyM+Rn0GexjA/kLIKWJKKsYljcy96VSOrs9mFL8kDvHP6VvCxzUaNEwOARP
x3J7D4pfE4YMfs5QzufBp4CmUFWC4J4eJ/xq2mMQ5i0PxtTEsKjBninUnjpuvLTi
lgCY66kkS8NdHojA4IpY6syYfjjZO9ngFENmNB9KDARhbmmkake29rRwyG+WOc+6
doTrUjBQXIxSF3L8UjoGDO5MPi4A5RvwRfXFDkq6Pcqkz5P66gQ=
=RkCb
-----END PGP SIGNATURE-----

--qfKx8M5SJscFRd5R--
