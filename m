Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9806BC43619
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 13:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5159A64F0C
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 13:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhCONPc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 09:15:32 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:50723 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230142AbhCONPH (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Mar 2021 09:15:07 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 7BB335C00AD;
        Mon, 15 Mar 2021 09:15:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 15 Mar 2021 09:15:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=DR61WtGk8bsm/kzRdxcNYB6QvQI
        qcUutzgQmPh1sYbA=; b=Gzo8S7RYB0xIAAt0knrezIxVCHEqAenH67mNipy3KLC
        McPoycCnvEIgrlgJzPqFJdtHptD6Cb06k9pVckS+oruPKUY6ZfJQ3G5B+otxk6Hx
        rWjG4iGTkNLuBQ8ztz/iZ1poPGYneUj/LujOeOG15sYGg/eQ788HTbWQvll6z35j
        NCF6Ua8a5BA2iue8whl/adm3TzNm9TNWCgGiBXbIX8hl4UOnwYJ7rZ9IJg+Zqf2U
        RKmef2v9NEUREVLU4ZRLu7VXxe1K8WrgznN+IrNQsqk5wWCrrIk5hUXJ9XcPH4KB
        uI9tDMFrp+nZwZFoKXke1y5plqqI9vSsbBJtNgGzwdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=DR61Wt
        Gk8bsm/kzRdxcNYB6QvQIqcUutzgQmPh1sYbA=; b=mvIjtUeEejIydV6DY5Yrb8
        fzDIyNDpK9Zq7VPPmLrbbgFecByjOT9y/+4j/hgMQdAVPB4w3wILTpsKMAiAEZt7
        sE2IAsZmU98S2ZeTAYuapdIaXqG8cF2ZS9Ssza236ZHGJdKzR6e0O80emBtMDet3
        O1m72G+5ypzVkX6tNhQOiJ+kP6QIBRKHyrGxTngreGlZM/hrDZomY18BfKnqfWex
        q/0vTIFOErXz0SMgDweclCMQWWClcmjBUZOKRlPFfAysG7wgqhsE0hc0lwNXSNcr
        RoOxcWIySH+AQKaJt38nyuCcx89EDZsApK17bbyZ5/tOpd7B4qMB+J683nPW7ibg
        ==
X-ME-Sender: <xms:211PYKq64a0v13MH74vFMucu18eeddD06gCPTOiGzeD2HSrX6fIJ2A>
    <xme:211PYPr2t7q8BaXOfxiY6scQih3UTrkt2f25HP3w0wHJ9XVCCoLEm1bNFxtFG6nAO
    Jd_ikCD3EdTOjGzxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddvledggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpefgfeejuefgheegueeljeffteefuedthfdvvedugfevvdffleduueeiiefgvedtheen
    ucffohhmrghinhepphgvnhguihhnghdrnhhrnecukfhppeekledrudegrdeliedrvdegud
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshes
    phhkshdrihhm
X-ME-Proxy: <xmx:211PYEPSmrAWWsqNsqZjQxJBU866T1YMhmZ3oGf5lEGCmjpFo6JR0w>
    <xmx:211PYIzGtxOlqgTLg-_hUOwNopL84IBITNsbLmcapDYpm5hrh1HDcA>
    <xmx:211PYFuH8p9U35o0yrJl5Om2dFn8qWWfswh0n66xGd3nscTvJ85eog>
    <xmx:211PYHOMQ7Ecy_gTzN9yjebKnAgmJKhKcdabmcltYcxFQS5GMqHdqw>
Received: from vm-mail.pks.im (dynamic-089-014-096-241.89.14.pool.telefonica.de [89.14.96.241])
        by mail.messagingengine.com (Postfix) with ESMTPA id 76CE7108006C;
        Mon, 15 Mar 2021 09:15:06 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 4c037072 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 15 Mar 2021 13:15:06 +0000 (UTC)
Date:   Mon, 15 Mar 2021 14:15:05 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 8/8] rev-list: allow filtering of provided items
Message-ID: <0e26fee8b31e46e87fb9fa1ac599506502a9d622.1615813673.git.ps@pks.im>
References: <cover.1614600555.git.ps@pks.im>
 <cover.1615813673.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IVOvDxKEvpsO+iRr"
Content-Disposition: inline
In-Reply-To: <cover.1615813673.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--IVOvDxKEvpsO+iRr
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
 builtin/rev-list.c                  | 14 +++++++++++
 list-objects-filter-options.c       |  4 ++++
 list-objects-filter-options.h       |  6 +++++
 pack-bitmap.c                       |  3 ++-
 t/t6112-rev-list-filters-objects.sh | 28 ++++++++++++++++++++++
 t/t6113-rev-list-bitmap-filters.sh  | 36 +++++++++++++++++++++++++++++
 6 files changed, 90 insertions(+), 1 deletion(-)

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
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index bb6f6577d5..2877aa9e96 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -242,6 +242,7 @@ static void transform_to_combine_type(
 		memset(filter_options, 0, sizeof(*filter_options));
 		filter_options->sub =3D sub_array;
 		filter_options->sub_alloc =3D initial_sub_alloc;
+		filter_options->filter_wants =3D sub_array[0].filter_wants;
 	}
 	filter_options->sub_nr =3D 1;
 	filter_options->choice =3D LOFC_COMBINE;
@@ -290,6 +291,9 @@ void parse_list_objects_filter(
 		parse_error =3D gently_parse_list_objects_filter(
 			&filter_options->sub[filter_options->sub_nr - 1], arg,
 			&errbuf);
+		if (!parse_error)
+			filter_options->sub[filter_options->sub_nr - 1].filter_wants =3D
+				filter_options->filter_wants;
 	}
 	if (parse_error)
 		die("%s", errbuf.buf);
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
index cb9db7df6f..9053ac5059 100755
--- a/t/t6113-rev-list-bitmap-filters.sh
+++ b/t/t6113-rev-list-bitmap-filters.sh
@@ -98,6 +98,28 @@ test_expect_success 'object:type filter' '
 	test_bitmap_traversal expect actual
 '
=20
+test_expect_success 'object:type filter with --filter-provided' '
+	git rev-list --objects --filter-provided --filter=3Dobject:type=3Dtag tag=
 >expect &&
+	git rev-list --use-bitmap-index \
+		     --objects --filter-provided --filter=3Dobject:type=3Dtag tag >actua=
l &&
+	test_cmp expect actual &&
+
+	git rev-list --objects --filter-provided --filter=3Dobject:type=3Dcommit =
tag >expect &&
+	git rev-list --use-bitmap-index \
+		     --objects --filter-provided --filter=3Dobject:type=3Dcommit tag >ac=
tual &&
+	test_bitmap_traversal expect actual &&
+
+	git rev-list --objects --filter-provided --filter=3Dobject:type=3Dtree ta=
g >expect &&
+	git rev-list --use-bitmap-index \
+		     --objects --filter-provided --filter=3Dobject:type=3Dtree tag >actu=
al &&
+	test_bitmap_traversal expect actual &&
+
+	git rev-list --objects --filter-provided --filter=3Dobject:type=3Dblob ta=
g >expect &&
+	git rev-list --use-bitmap-index \
+		     --objects --filter-provided --filter=3Dobject:type=3Dblob tag >actu=
al &&
+	test_bitmap_traversal expect actual
+'
+
 test_expect_success 'combine filter' '
 	git rev-list --objects --filter=3Dblob:limit=3D1000 --filter=3Dobject:typ=
e=3Dblob tag >expect &&
 	git rev-list --use-bitmap-index \
@@ -105,4 +127,18 @@ test_expect_success 'combine filter' '
 	test_bitmap_traversal expect actual
 '
=20
+test_expect_success 'combine filter with --filter-provided' '
+	git rev-list --objects --filter-provided --filter=3Dblob:limit=3D1000 --f=
ilter=3Dobject:type=3Dblob tag >expect &&
+	git rev-list --use-bitmap-index \
+		     --objects --filter-provided --filter=3Dblob:limit=3D1000 --filter=
=3Dobject:type=3Dblob tag >actual &&
+	test_bitmap_traversal expect actual &&
+
+	git cat-file --batch-check=3D"%(objecttype) %(objectsize)" <actual >objec=
ts &&
+	while read objecttype objectsize
+	do
+		test "$objecttype" =3D blob || return 1
+		test "$objectsize" -le 1000 || return 1
+	done <objects
+'
+
 test_done
--=20
2.30.2


--IVOvDxKEvpsO+iRr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmBPXdgACgkQVbJhu7ck
PpSemw/8DmHeLQeBUMNvWCXPnIPCGBx6nbbGQnDK54ir/8ilcFzF+K/ieXgXzKbt
g8B56T7+CiaBJ9DZLeroGOC4EsQYv46sA+nuZNLnklsO/SgXhNU0KEw7zD7sQQfr
u8HRRXbWWXfBZMidTJDEcJo7O6K6zJMsdjqsc6CeRqFi76aRJAoZ309NhNGu50hy
ScV8deb0lVXKK+mqOPrd8riVHXusiI7J7tq6LIcV9xgWsMPD6C48ZPpYY9uf8yp9
GIHEEbkLLBhW30A5/BjdlrlnMCzuuA6icsapAp00b0V3IjcIjRYe0OdANH0wzqzq
tV0e36qqp2Imixubv+Cc/CKBccCvyvnZycPSeMb41yYmUL3316t+Pd7TxkvL3j2K
idycyWSvab6oF4kkDQN9zRkesI/l9BgYt4D519i5bn0SWGvd16bTdzr0yTJ1sN5X
o3VZu/r9xvqhOPPjxFhYBXpZMEiS/lVXqRMtVZo0ZBQpgryvn0ZS/L1o5fEaV7/L
HXOE7YRqKq7l4zZJPOYz0FRCoZt1ItVH0dnPxgSs4JmlgShOHPR2FM0VHCIB8+D3
ZFo5yakoAYk9UEEtAIfMZjyaB9LuVe/XjyZ1u+U0ZKr2SvWUoJ/DYE7udlEA5j41
PCFOue0oAvqmSZdkHGIg35RXlgEfZhXoCZVLLEh5enSDtl1ubxg=
=FDYm
-----END PGP SIGNATURE-----

--IVOvDxKEvpsO+iRr--
