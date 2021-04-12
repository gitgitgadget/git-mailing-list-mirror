Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DE6C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 13:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC5DA61288
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 13:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241999AbhDLNiO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 09:38:14 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:53171 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238495AbhDLNiO (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Apr 2021 09:38:14 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id CD2541681;
        Mon, 12 Apr 2021 09:37:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 12 Apr 2021 09:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=vy7YMdPGC8CN57IrKcdSgw31SeG
        K9niymFaU1RPC5XU=; b=ka1bzhi4iL+N1lzHZ32o1mRV+D3wINTRnjb4NQziOUw
        RC5G46lLugd2bLbQl4Mjp0/M/92qPGVYwomfWwwuSp40jVI82QzsXvgO/zkN+GEH
        HQmho31geMTy6AmUdLElo6XMDYbLmSIzc5ZTPLJwGP6sp8PcMfLGN/Zin26ogPZw
        R7b6jzmlCUoT+YGKn7hFPmQzBYGrlMYQdZsC/nm4CLjUa30jnlPVgUcVCpWxyY9Y
        wexo+vH57d52zbrtHw3557WXL7iR4FP+byC1Y9P3rwGDU6IGCLbNqi3tWi3NjswE
        SbEooVbElwuI1H+gfFeqeuFCchtJM0y9IBMeQOBir8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=vy7YMd
        PGC8CN57IrKcdSgw31SeGK9niymFaU1RPC5XU=; b=k8mCAkoTmUwlAMRnXAlMmz
        riHi7DmoPwQPbNph+XMDuCFbUPdsU41FAQltKYd+T+4zQGRq72COfGtDe9fAkIS2
        xRtvefSphKxxCpovTpr7K9Gofj09Ve3FOsCDDWKaYzWx0gtQ6Rm0WKZJdU0ZA3vg
        jLo4dX+o0wPzFvzX0LP2YcI7WqX8qw0+hd4N3Ww52gy7CpHvjj4m8KvHjNgdG6D4
        hPVhejaZU7tB9C52pas2bAN+PCuowG8FkyhbJpDSie3oYjs9Q8yh36LWCYQOOaFN
        V++PalpZHEyao2KVhqRjnvvkvMXiy4U3Z1Sj43pA3r051rwo/YBnfI0dXZVhSipw
        ==
X-ME-Sender: <xms:M010YGIwVNWPIvoVfVK4Hhp9OL08x90og6Ts8tqG4gTCOCsh0MTjuA>
    <xme:M010YOLBnla1WGofskKAyJMpoyXb02MVDOnTD7RJ9DYtDAKWXcXwpEe0WW9Pl6Zme
    vM251VyHWToBXNy3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekjedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpefgfeejuefgheegueeljeffteefuedthfdvvedugfevvdffleduueeiiefgvedtheen
    ucffohhmrghinhepphgvnhguihhnghdrnhhrnecukfhppeejkedrheehrdefhedrfedtne
    cuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehp
    khhsrdhimh
X-ME-Proxy: <xmx:M010YGvxgTNnn6cwU17H-OSoWQE8B4sUwmHGPdXoCjk7qstRHv-Bdg>
    <xmx:M010YLZYwUq5n8ljYcrlroWqhqUY9GB8UBEmpNjbCpBF3XqslKEgQg>
    <xmx:M010YNYNEmL1i5E3QUFsazBUEXdQKZa1R8GTL-0ghZsWJq6jY1VB0Q>
    <xmx:M010YMm_pIHfN8kkCFkEf72_IVgHagutof_9Kcp0EL5KARNTNjeSfg>
Received: from vm-mail.pks.im (dynamic-078-055-035-030.78.55.pool.telefonica.de [78.55.35.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9F23C24005A;
        Mon, 12 Apr 2021 09:37:54 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 93775e50 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 12 Apr 2021 13:37:54 +0000 (UTC)
Date:   Mon, 12 Apr 2021 15:37:53 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v4 8/8] rev-list: allow filtering of provided items
Message-ID: <c779d222cf68bf1d6cd7973c8cbe75db3dbc9d26.1618234575.git.ps@pks.im>
References: <cover.1617967252.git.ps@pks.im>
 <cover.1618234575.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="INsDHvrF8j8EliMy"
Content-Disposition: inline
In-Reply-To: <cover.1618234575.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--INsDHvrF8j8EliMy
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

Improve this by introducing a new `--filter-provided-objects` option
to the git-rev-parse(1) command. If given, then all user-provided
references will be subject to filtering.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/rev-list-options.txt  |  5 ++++
 builtin/pack-objects.c              |  2 +-
 builtin/rev-list.c                  | 36 +++++++++++++++++++++--------
 pack-bitmap.c                       |  6 +++--
 pack-bitmap.h                       |  3 ++-
 reachable.c                         |  2 +-
 t/t6112-rev-list-filters-objects.sh | 28 ++++++++++++++++++++++
 t/t6113-rev-list-bitmap-filters.sh  | 36 +++++++++++++++++++++++++++++
 8 files changed, 104 insertions(+), 14 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-op=
tions.txt
index 3afa8fffbd..5bf2a85f69 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -933,6 +933,11 @@ equivalent.
 --no-filter::
 	Turn off any previous `--filter=3D` argument.
=20
+--filter-provided-objects::
+	Filter the list of explicitly provided objects, which would otherwise
+	always be printed even if they did not match any of the filters. Only
+	useful with `--filter=3D`.
+
 --filter-print-omitted::
 	Only useful with `--filter=3D`; prints a list of the objects omitted
 	by the filter.  Object IDs are prefixed with a ``~'' character.
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 525c2d8552..2f2026dc87 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3516,7 +3516,7 @@ static int pack_options_allow_reuse(void)
=20
 static int get_object_list_from_bitmap(struct rev_info *revs)
 {
-	if (!(bitmap_git =3D prepare_bitmap_walk(revs, &filter_options)))
+	if (!(bitmap_git =3D prepare_bitmap_walk(revs, &filter_options, 0)))
 		return -1;
=20
 	if (pack_options_allow_reuse() &&
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index b4d8ea0a35..7677b1af5a 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -398,7 +398,8 @@ static inline int parse_missing_action_value(const char=
 *value)
 }
=20
 static int try_bitmap_count(struct rev_info *revs,
-			    struct list_objects_filter_options *filter)
+			    struct list_objects_filter_options *filter,
+			    int filter_provided_objects)
 {
 	uint32_t commit_count =3D 0,
 		 tag_count =3D 0,
@@ -433,7 +434,7 @@ static int try_bitmap_count(struct rev_info *revs,
 	 */
 	max_count =3D revs->max_count;
=20
-	bitmap_git =3D prepare_bitmap_walk(revs, filter);
+	bitmap_git =3D prepare_bitmap_walk(revs, filter, filter_provided_objects);
 	if (!bitmap_git)
 		return -1;
=20
@@ -450,7 +451,8 @@ static int try_bitmap_count(struct rev_info *revs,
 }
=20
 static int try_bitmap_traversal(struct rev_info *revs,
-				struct list_objects_filter_options *filter)
+				struct list_objects_filter_options *filter,
+				int filter_provided_objects)
 {
 	struct bitmap_index *bitmap_git;
=20
@@ -461,7 +463,7 @@ static int try_bitmap_traversal(struct rev_info *revs,
 	if (revs->max_count >=3D 0)
 		return -1;
=20
-	bitmap_git =3D prepare_bitmap_walk(revs, filter);
+	bitmap_git =3D prepare_bitmap_walk(revs, filter, filter_provided_objects);
 	if (!bitmap_git)
 		return -1;
=20
@@ -471,14 +473,15 @@ static int try_bitmap_traversal(struct rev_info *revs,
 }
=20
 static int try_bitmap_disk_usage(struct rev_info *revs,
-				 struct list_objects_filter_options *filter)
+				 struct list_objects_filter_options *filter,
+				 int filter_provided_objects)
 {
 	struct bitmap_index *bitmap_git;
=20
 	if (!show_disk_usage)
 		return -1;
=20
-	bitmap_git =3D prepare_bitmap_walk(revs, filter);
+	bitmap_git =3D prepare_bitmap_walk(revs, filter, filter_provided_objects);
 	if (!bitmap_git)
 		return -1;
=20
@@ -499,6 +502,7 @@ int cmd_rev_list(int argc, const char **argv, const cha=
r *prefix)
 	int bisect_show_vars =3D 0;
 	int bisect_find_all =3D 0;
 	int use_bitmap_index =3D 0;
+	int filter_provided_objects =3D 0;
 	const char *show_progress =3D NULL;
=20
 	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
@@ -599,6 +603,10 @@ int cmd_rev_list(int argc, const char **argv, const ch=
ar *prefix)
 			list_objects_filter_set_no_filter(&filter_options);
 			continue;
 		}
+		if (!strcmp(arg, "--filter-provided-objects")) {
+			filter_provided_objects =3D 1;
+			continue;
+		}
 		if (!strcmp(arg, "--filter-print-omitted")) {
 			arg_print_omitted =3D 1;
 			continue;
@@ -665,11 +673,11 @@ int cmd_rev_list(int argc, const char **argv, const c=
har *prefix)
 		progress =3D start_delayed_progress(show_progress, 0);
=20
 	if (use_bitmap_index) {
-		if (!try_bitmap_count(&revs, &filter_options))
+		if (!try_bitmap_count(&revs, &filter_options, filter_provided_objects))
 			return 0;
-		if (!try_bitmap_disk_usage(&revs, &filter_options))
+		if (!try_bitmap_disk_usage(&revs, &filter_options, filter_provided_objec=
ts))
 			return 0;
-		if (!try_bitmap_traversal(&revs, &filter_options))
+		if (!try_bitmap_traversal(&revs, &filter_options, filter_provided_object=
s))
 			return 0;
 	}
=20
@@ -694,6 +702,16 @@ int cmd_rev_list(int argc, const char **argv, const ch=
ar *prefix)
 			return show_bisect_vars(&info, reaches, all);
 	}
=20
+	if (filter_provided_objects) {
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
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 7ce3ede7e4..6b790a834b 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -986,7 +986,8 @@ static int can_filter_bitmap(struct list_objects_filter=
_options *filter)
 }
=20
 struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
-					 struct list_objects_filter_options *filter)
+					 struct list_objects_filter_options *filter,
+					 int filter_provided_objects)
 {
 	unsigned int i;
=20
@@ -1081,7 +1082,8 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_i=
nfo *revs,
 	if (haves_bitmap)
 		bitmap_and_not(wants_bitmap, haves_bitmap);
=20
-	filter_bitmap(bitmap_git, wants, wants_bitmap, filter);
+	filter_bitmap(bitmap_git, (filter && filter_provided_objects) ? NULL : wa=
nts,
+		      wants_bitmap, filter);
=20
 	bitmap_git->result =3D wants_bitmap;
 	bitmap_git->haves =3D haves_bitmap;
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 36d99930d8..bb45217d3b 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -50,7 +50,8 @@ void traverse_bitmap_commit_list(struct bitmap_index *,
 				 show_reachable_fn show_reachable);
 void test_bitmap_walk(struct rev_info *revs);
 struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
-					 struct list_objects_filter_options *filter);
+					 struct list_objects_filter_options *filter,
+					 int filter_provided_objects);
 int reuse_partial_packfile_from_bitmap(struct bitmap_index *,
 				       struct packed_git **packfile,
 				       uint32_t *entries,
diff --git a/reachable.c b/reachable.c
index 77a60c70a5..fc833cae43 100644
--- a/reachable.c
+++ b/reachable.c
@@ -223,7 +223,7 @@ void mark_reachable_objects(struct rev_info *revs, int =
mark_reflog,
 	cp.progress =3D progress;
 	cp.count =3D 0;
=20
-	bitmap_git =3D prepare_bitmap_walk(revs, NULL);
+	bitmap_git =3D prepare_bitmap_walk(revs, NULL, 0);
 	if (bitmap_git) {
 		traverse_bitmap_commit_list(bitmap_git, revs, mark_object_seen);
 		free_bitmap_index(bitmap_git);
diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters=
-objects.sh
index c79ec04060..de751b65b4 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -207,6 +207,34 @@ test_expect_success 'verify object:type=3Dtag prints t=
ag' '
 	test_cmp expected actual
 '
=20
+test_expect_success 'verify object:type=3Dblob prints only blob with --fil=
ter-provided-objects' '
+	printf "%s blob\n" $(git -C object-type rev-parse HEAD:blob) >expected &&
+	git -C object-type rev-list --objects \
+		--filter=3Dobject:type=3Dblob --filter-provided-objects HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'verify object:type=3Dtree prints only tree with --fil=
ter-provided-objects' '
+	printf "%s \n" $(git -C object-type rev-parse HEAD^{tree}) >expected &&
+	git -C object-type rev-list --objects \
+		--filter=3Dobject:type=3Dtree HEAD --filter-provided-objects >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'verify object:type=3Dcommit prints only commit with -=
-filter-provided-objects' '
+	git -C object-type rev-parse HEAD >expected &&
+	git -C object-type rev-list --objects \
+		--filter=3Dobject:type=3Dcommit --filter-provided-objects HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'verify object:type=3Dtag prints only tag with --filte=
r-provided-objects' '
+	printf "%s tag\n" $(git -C object-type rev-parse tag) >expected &&
+	git -C object-type rev-list --objects \
+		--filter=3Dobject:type=3Dtag --filter-provided-objects tag >actual &&
+	test_cmp expected actual
+'
+
 # Test sparse:path=3D<path> filter.
 # !!!!
 # NOTE: sparse:path filter support has been dropped for security reasons,
diff --git a/t/t6113-rev-list-bitmap-filters.sh b/t/t6113-rev-list-bitmap-f=
ilters.sh
index cb9db7df6f..4d8e09167e 100755
--- a/t/t6113-rev-list-bitmap-filters.sh
+++ b/t/t6113-rev-list-bitmap-filters.sh
@@ -98,6 +98,28 @@ test_expect_success 'object:type filter' '
 	test_bitmap_traversal expect actual
 '
=20
+test_expect_success 'object:type filter with --filter-provided-objects' '
+	git rev-list --objects --filter-provided-objects --filter=3Dobject:type=
=3Dtag tag >expect &&
+	git rev-list --use-bitmap-index \
+		     --objects --filter-provided-objects --filter=3Dobject:type=3Dtag ta=
g >actual &&
+	test_cmp expect actual &&
+
+	git rev-list --objects --filter-provided-objects --filter=3Dobject:type=
=3Dcommit tag >expect &&
+	git rev-list --use-bitmap-index \
+		     --objects --filter-provided-objects --filter=3Dobject:type=3Dcommit=
 tag >actual &&
+	test_bitmap_traversal expect actual &&
+
+	git rev-list --objects --filter-provided-objects --filter=3Dobject:type=
=3Dtree tag >expect &&
+	git rev-list --use-bitmap-index \
+		     --objects --filter-provided-objects --filter=3Dobject:type=3Dtree t=
ag >actual &&
+	test_bitmap_traversal expect actual &&
+
+	git rev-list --objects --filter-provided-objects --filter=3Dobject:type=
=3Dblob tag >expect &&
+	git rev-list --use-bitmap-index \
+		     --objects --filter-provided-objects --filter=3Dobject:type=3Dblob t=
ag >actual &&
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
+test_expect_success 'combine filter with --filter-provided-objects' '
+	git rev-list --objects --filter-provided-objects --filter=3Dblob:limit=3D=
1000 --filter=3Dobject:type=3Dblob tag >expect &&
+	git rev-list --use-bitmap-index \
+		     --objects --filter-provided-objects --filter=3Dblob:limit=3D1000 --=
filter=3Dobject:type=3Dblob tag >actual &&
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
2.31.1


--INsDHvrF8j8EliMy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmB0TTAACgkQVbJhu7ck
PpT8oBAAkLaLHzW6xivIYwkMPtRPU8jyVpiNB+XFKMvImu5t9DQg3RGzR48sJVMR
PPpjM1oeA0R1yNQ2RfYiowqDL8RzJKwngZjOs9BnHIvxeF9McJZ7VxP5tnrR9+QX
29GFpK/vqCBJkCu/z+i1IodCnI8/QonGqzQCNsBR9ZzoP8KSuDkDwFx+eVCYb8Di
YrB+5fGe2LSZdfF5TZ7XeRH0e+iXMHAdYRduDCk7FSbc5ztQsDJy1Tw+0wVpr0oh
GUxcx+oeLDpJrcLXke1gCxEm4v45vGazv8SS/069kd2HR6IMDL6SRQguDMRez+c/
YegsWRgfp5MK0pSxsW++boZ5NOa0Uo5MB1Wh2gFEUl563Pfpcs1fRT9oP0Y2bTK7
h03Mw8x5Yn+V7l98sye2EWARs3lpAh7SzoKICc47ooOqs1ttCHCKXpvs6yO0t7jo
y2EoEsxcPnP2IxaAngOLoSgEjJDsoML4lqIDvlE05jLknby7d+Tqamlo97XFmM38
ZETN470e+BaGqMXboTdO5yv5sig3KGFmq9NMbiqw8AogJv6xD8AiqdIWGw5Smo7t
mFJQJ8g+EB8kdC2rI2stdlZYkeJMRPV6Ka23ZtTzCoKX5WeQ+IC7+X2tI3ezG+sS
uUFjgZ1DbZbh9zBVz0w4qJuneFVzSusZMaZbUgRAFx0werFctNU=
=N2SP
-----END PGP SIGNATURE-----

--INsDHvrF8j8EliMy--
