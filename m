Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0BEC433DB
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 12:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 011F864E31
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 12:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbhCAMWg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 07:22:36 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:54029 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234008AbhCAMWX (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 1 Mar 2021 07:22:23 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id C315F4B3;
        Mon,  1 Mar 2021 07:21:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 01 Mar 2021 07:21:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=SKZPj2KYRaCJGec42kFa1UxQjVr
        pCwWrt3KpJPUrDkU=; b=PLhkOP6Um9/TZkQJoNqsQ0DhSjlG7RjJbjsgZa1n4Km
        kpn3fH7gbnTyP4yDJ748S0tErdzJkpPsY3nVS6dd9qUiI9PJGMX0lg4Jdy+JeLMy
        zCjbKdcLMMeGZvN/AoDyNPEjx9Du2Ozdj2xrFJjuT/SQzIStwya3cCPDe98+/vsZ
        bZYoI1HfyYmNXREnnsGDTytk61xzfSZke9v/IH+1Eu7Z8uP6ZT3QsN9DbrevUDwD
        GsfKYK5shuFBY6DBV6CDooPw8agRkkQb7N5BkXkbWgC1mengYw5gg+QToa+WcHln
        P1J3kBrh0tzb0UhIXm7h4/gdP9lAdNAylzJxC/mJ/rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=SKZPj2
        KYRaCJGec42kFa1UxQjVrpCwWrt3KpJPUrDkU=; b=n/OPAxx3Q9fPScLGU5VerW
        a0ovKl0+0k8E7HAD/J2uTzd+MHN4CjpJIF/ECO6rKV0Y90bMKi3AOMYQT5piN1bs
        3DAn9fPV6S8w8HuQakuS7pLN/sjX7pnlGywMYQURMuocCBz5Ax4bMuZdoUDdft46
        hetpDXrXOGTYK6XcMxhNNlOd4k2t+YfByms3/g9zrNVTv33Fjnt5f8d7PSJvLvlu
        ogG6LWgsGtW/mwAlc6GQILKhrIWo3U1K0hg8K931pc5wquDnZqmWKkhw3HOgF245
        xFsFLOYDgkh78CEExOyyoC8x0DKj1F/p06AbcLMorNf0KlFEvHVd8pIYH7fM9f7A
        ==
X-ME-Sender: <xms:MNw8YFzKARFDt9FWTS5951suqaVl0g63y7s9TZ3Fnc2JlPX3O86x_w>
    <xme:MNw8YP3eS5zh7yOmu9Z6qts96jwVY3X4KGq9tfjug-jJyplVl2sBiFz51w4YvdEgp
    4ml6g-bDUmwjkspiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrleekgdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epgfefjeeugfehgeeuleejffetfeeutdfhvdevudfgvedvffeludeuieeigfevtdehnecu
    ffhomhgrihhnpehpvghnughinhhgrdhnrhenucfkphepjeejrdduledurddvjedrudefvd
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshes
    phhkshdrihhm
X-ME-Proxy: <xmx:Mdw8YL5NAYfeMKCsc8VFyI3eHYViw9t8oq_f835LtJQsgnovZpVOUQ>
    <xmx:Mdw8YKUD0MMEIJ3QG8lDs_6IOZ00cSspbkFv10Bp_pSA8_PgGZd0hQ>
    <xmx:Mdw8YCAZigOHAJIQF5Zo7F4aNCAaWrSAHZb3sTr-Iz5POdp1AFkFDA>
    <xmx:Mdw8YCYii2rTA1bUD_bXSOqh3dEFAWlXGx81SMrUsqrlzo7RnISfbw>
Received: from vm-mail.pks.im (x4dbf1b84.dyn.telefonica.de [77.191.27.132])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8775C240068;
        Mon,  1 Mar 2021 07:21:04 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id b31f1fa8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 1 Mar 2021 12:21:03 +0000 (UTC)
Date:   Mon, 1 Mar 2021 13:21:01 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 7/7] rev-list: allow filtering of provided items
Message-ID: <b43bf401dfda53092a0d6f586c71747be966714a.1614600555.git.ps@pks.im>
References: <cover.1614600555.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+07vDt5GnWKhLg7O"
Content-Disposition: inline
In-Reply-To: <cover.1614600555.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--+07vDt5GnWKhLg7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When providing an object filter, it is currently impossible to also
filter provided items. E.g. when executing `git rev-list HEAD` , the
commit this reference points to will be treated as user-provided and is
thus excluded from the filtering mechanism. This makes it harder than
necessary to properly use the new `--filter=3Dobject:type` filter given
that even if the user wants to only see blobs, he'll still see commits
of provided references.

Improve this by introducing a new `--filter-provided` option to the
git-rev-parse(1) command. If given, then all user-provided references
will be subject to filtering.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rev-list.c                  | 14 ++++++++++++++
 list-objects-filter-options.h       |  6 ++++++
 pack-bitmap.c                       |  3 ++-
 t/t6112-rev-list-filters-objects.sh | 28 ++++++++++++++++++++++++++++
 t/t6113-rev-list-bitmap-filters.sh  | 22 ++++++++++++++++++++++
 5 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index b4d8ea0a35..0f959b266d 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -599,6 +599,10 @@ int cmd_rev_list(int argc, const char **argv, const ch=
ar *prefix)
 			list_objects_filter_set_no_filter(&filter_options);
 			continue;
 		}
+		if (!strcmp(arg, "--filter-provided")) {
+			filter_options.filter_wants =3D 1;
+			continue;
+		}
 		if (!strcmp(arg, "--filter-print-omitted")) {
 			arg_print_omitted =3D 1;
 			continue;
@@ -694,6 +698,16 @@ int cmd_rev_list(int argc, const char **argv, const ch=
ar *prefix)
 			return show_bisect_vars(&info, reaches, all);
 	}
=20
+	if (filter_options.filter_wants) {
+		struct commit_list *c;
+		for (i =3D 0; i < revs.pending.nr; i++) {
+			struct object_array_entry *pending =3D revs.pending.objects + i;
+			pending->item->flags |=3D NOT_USER_GIVEN;
+		}
+		for (c =3D revs.commits; c; c =3D c->next)
+			c->item->object.flags |=3D NOT_USER_GIVEN;
+	}
+
 	if (arg_print_omitted)
 		oidset_init(&omitted_objects, DEFAULT_OIDSET_SIZE);
 	if (arg_missing_action =3D=3D MA_PRINT)
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index 4d0d0588cc..5e609e307a 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -42,6 +42,12 @@ struct list_objects_filter_options {
 	 */
 	enum list_objects_filter_choice choice;
=20
+	/*
+	 * "--filter-provided" was given by the user, instructing us to also
+	 * filter all explicitly provided objects.
+	 */
+	unsigned int filter_wants : 1;
+
 	/*
 	 * Choice is LOFC_DISABLED because "--no-filter" was requested.
 	 */
diff --git a/pack-bitmap.c b/pack-bitmap.c
index e33805e076..5ff800316b 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1101,7 +1101,8 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_i=
nfo *revs,
 	if (haves_bitmap)
 		bitmap_and_not(wants_bitmap, haves_bitmap);
=20
-	filter_bitmap(bitmap_git, wants, wants_bitmap, filter);
+	filter_bitmap(bitmap_git, (filter && filter->filter_wants) ? NULL : wants,
+		      wants_bitmap, filter);
=20
 	bitmap_git->result =3D wants_bitmap;
 	bitmap_git->haves =3D haves_bitmap;
diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters=
-objects.sh
index c79ec04060..47c558ab0e 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -207,6 +207,34 @@ test_expect_success 'verify object:type=3Dtag prints t=
ag' '
 	test_cmp expected actual
 '
=20
+test_expect_success 'verify object:type=3Dblob prints only blob with --fil=
ter-provided' '
+	printf "%s blob\n" $(git -C object-type rev-parse HEAD:blob) >expected &&
+	git -C object-type rev-list --objects \
+		--filter=3Dobject:type=3Dblob --filter-provided HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'verify object:type=3Dtree prints only tree with --fil=
ter-provided' '
+	printf "%s \n" $(git -C object-type rev-parse HEAD^{tree}) >expected &&
+	git -C object-type rev-list --objects \
+		--filter=3Dobject:type=3Dtree HEAD --filter-provided >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'verify object:type=3Dcommit prints only commit with -=
-filter-provided' '
+	git -C object-type rev-parse HEAD >expected &&
+	git -C object-type rev-list --objects \
+		--filter=3Dobject:type=3Dcommit --filter-provided HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'verify object:type=3Dtag prints only tag with --filte=
r-provided' '
+	printf "%s tag\n" $(git -C object-type rev-parse tag) >expected &&
+	git -C object-type rev-list --objects \
+		--filter=3Dobject:type=3Dtag --filter-provided tag >actual &&
+	test_cmp expected actual
+'
+
 # Test sparse:path=3D<path> filter.
 # !!!!
 # NOTE: sparse:path filter support has been dropped for security reasons,
diff --git a/t/t6113-rev-list-bitmap-filters.sh b/t/t6113-rev-list-bitmap-f=
ilters.sh
index cb9db7df6f..fe3df0ee14 100755
--- a/t/t6113-rev-list-bitmap-filters.sh
+++ b/t/t6113-rev-list-bitmap-filters.sh
@@ -98,6 +98,28 @@ test_expect_success 'object:type filter' '
 	test_bitmap_traversal expect actual
 '
=20
+test_expect_success 'object:type filter with --filter-provided' '
+	git rev-list --objects --filter=3Dobject:type=3Dtag --filter-provided tag=
 >expect &&
+	git rev-list --use-bitmap-index \
+		     --objects --filter=3Dobject:type=3Dtag --filter-provided tag >actua=
l &&
+	test_cmp expect actual &&
+
+	git rev-list --objects --filter=3Dobject:type=3Dcommit --filter-provided =
tag >expect &&
+	git rev-list --use-bitmap-index \
+		     --objects --filter=3Dobject:type=3Dcommit --filter-provided tag >ac=
tual &&
+	test_bitmap_traversal expect actual &&
+
+	git rev-list --objects --filter=3Dobject:type=3Dtree --filter-provided ta=
g >expect &&
+	git rev-list --use-bitmap-index \
+		     --objects --filter=3Dobject:type=3Dtree --filter-provided tag >actu=
al &&
+	test_bitmap_traversal expect actual &&
+
+	git rev-list --objects --filter=3Dobject:type=3Dblob --filter-provided ta=
g >expect &&
+	git rev-list --use-bitmap-index \
+		     --objects --filter=3Dobject:type=3Dblob --filter-provided tag >actu=
al &&
+	test_bitmap_traversal expect actual
+'
+
 test_expect_success 'combine filter' '
 	git rev-list --objects --filter=3Dblob:limit=3D1000 --filter=3Dobject:typ=
e=3Dblob tag >expect &&
 	git rev-list --use-bitmap-index \
--=20
2.30.1


--+07vDt5GnWKhLg7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmA83CwACgkQVbJhu7ck
PpTfBQ//VduZw+Y120tNmPEZyIf/g+OXEcsbDB5reGZI5LU+e/O2JDlDSaCZk0wr
vx+a81FDs2F9bhTHf1MlgDy7mY2e99NiYHJ+0q0bPYk02DCMkn/HKrBQBRdt5gnD
y0gd97dQvGNT/NJDHc7wHlvRpRVEGLoI+El4QiFillyMy9H1szOt06Pla39o3+Vt
jaweem7gBYtAhwuI/68uy/Of/lrrpfHWnQdg74clTOEjQbh/m0+fYmrjz4iTU2Uj
kr9t1wSvbNktXOfZh2OEzgYwibfAeDKBhlvLyEpKS6d9Ytd5H5HzhEn/A4Yaasp9
tIfgkuiat7cIZhk5WwwHQOS0F9GlQlkYkoeacPDWv2UXwJiNLAyI74h41SGRXqay
mqVKaeC47oP39p2FVNIB1wYn8jhmH6FIDZ8bXjl+5hH/mK5FilWV9q7sYOrBSWV7
vBbY91B7ZnMlbUfSEg9kjbcR7INqh3rTW3r8W12QDnjBLh/a8cQCFP7KDrp9xff6
6Rr5vUWYe+Du53BSkVqnvTEElbbhll7uNIBEOEs1QcKW/bOYLgu+Hbwx8yQXnVcM
pYAY8R5HzDUpaKPInSr/nH+5DD+1Nx01oRjOM23JSdYtQzoJkLps5w/P2OMapJgu
ySr9Jxe9OxJxkaHgiJXz1MsWK7oqZVumHMPlHIBnkmM0d1CwSzw=
=44gH
-----END PGP SIGNATURE-----

--+07vDt5GnWKhLg7O--
