Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A60C433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 11:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DE7B610A7
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 11:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbhDIL2o (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 07:28:44 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:60141 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233747AbhDIL2l (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 9 Apr 2021 07:28:41 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 514AF5C0037;
        Fri,  9 Apr 2021 07:28:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 09 Apr 2021 07:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=EHDIHRhopAsgVBFyC4Fl6hSKF8/
        RqVzcpWs2ki5tH0Y=; b=I16hgE3WbGm7Xk/wpoI4UUGDpT1229r08mL2TyEEmEe
        jOgULrG5+iXmX6XfajkrGxr5N9A+T66XggA1AoIdGMBqYlUCiWb13Fy0w2Ia+N9K
        4/KeiwZSu1T4v0X1QnzTngJp0AoVhpX3A1/P7LwvhNYlRNSWrARm1IYNivcCQ57l
        SKzynlQIMuifhOOA04GKqYIBGVEKz90xg5QLdYmzSO/HGHSxmbXEfnEOpwlOzNLK
        deBzDsNQPEh8GwLkz2JIWQsOYRQPLv2WDRDXL7HNpHrwux2oy+Pqz7fAfJPJUbFr
        7b/ektZ8rkSDNy9SK9buc3QH45C4sJP1r6RGQHHbs9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=EHDIHR
        hopAsgVBFyC4Fl6hSKF8/RqVzcpWs2ki5tH0Y=; b=CbvXAPS1SzEsXfGnvBvjQh
        xpEbkb9OVHTVoIyThLwqHSpC8Op8ujLzUz0cOhN72+1z7qyv/Sn4f7/O/mYWzPW0
        ZS0hjNASfghwFWiJvYmr3v3Ddeukc6pOqfPYwUsmxe8nnqlXdXyuEzy2akNTEfYB
        i1zOnNCe+Y50cIXiqURUfAFowMs2xSf2F1rXbXqgaK2rMZ9ioVRIfanjuSqmIDdp
        SK/L7ZL655+CNXRybLSW/6R2lrUuM8Wmw8Mtk+ajCiuDCNx4de56MjSO5VfNcgZE
        u+oawR8KJeq8AQOMXcrc3HVhGMfr6WUAhcpRIZt9pdgi2lCzM4pvrn+UtjevRdCw
        ==
X-ME-Sender: <xms:XDpwYIIxMqlO13C6-1XF3pMTTiUWqqRiR9nFvakiUHVKUczAIkLU3A>
    <xme:XDpwYIL8p8r-DeTVT0654DWNZrxCNnY-nVFAo7iKdQ1UQ6P6sh-qicyLMtEmV3VwQ
    e8M-s7ZtYjI2lkRQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekuddggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpefgfeejuefgheegueeljeffteefuedthfdvvedugfevvdffleduueeiiefgvedtheen
    ucffohhmrghinhepphgvnhguihhnghdrnhhrnecukfhppeejjedrudeluddrkedrudeile
    enucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshes
    phhkshdrihhm
X-ME-Proxy: <xmx:XDpwYIunm7HPn1Z0UJgHekWux3bmTc3xLnWzQY_TZMbqwcMo_KECpQ>
    <xmx:XDpwYFak1LpiLZJsbUU6mxFiZrFxxajTKbI55oFwp3Bmd7WEtGuhdw>
    <xmx:XDpwYPYAu-f4DGMhQLBumXQ0TU7XuhLuiuDKP5BkHNXQXAAuVCvRQA>
    <xmx:XDpwYGykP21eOu5yWAgQ6JEsG3-6x4wpMSKSCkMLToLAk96YpTyeeA>
Received: from vm-mail.pks.im (x4dbf08a9.dyn.telefonica.de [77.191.8.169])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8AD7E240067;
        Fri,  9 Apr 2021 07:28:27 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id f6696864 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 9 Apr 2021 11:28:26 +0000 (UTC)
Date:   Fri, 9 Apr 2021 13:28:25 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 8/8] rev-list: allow filtering of provided items
Message-ID: <796606f32b3ffc286a3157312d00ee0ee3e5600c.1617967252.git.ps@pks.im>
References: <cover.1615813673.git.ps@pks.im>
 <cover.1617967252.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qCeSP4cqGIzkLbua"
Content-Disposition: inline
In-Reply-To: <cover.1617967252.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--qCeSP4cqGIzkLbua
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
index 3afa8fffbd..7fa18fc6e6 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -933,6 +933,11 @@ equivalent.
 --no-filter::
 	Turn off any previous `--filter=3D` argument.
=20
+--filter-provided-revisions::
+	Filter the list of explicitly provided revisions, which would otherwise
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
index b4d8ea0a35..13f0ff3f8d 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -398,7 +398,8 @@ static inline int parse_missing_action_value(const char=
 *value)
 }
=20
 static int try_bitmap_count(struct rev_info *revs,
-			    struct list_objects_filter_options *filter)
+			    struct list_objects_filter_options *filter,
+			    int filter_provided_revs)
 {
 	uint32_t commit_count =3D 0,
 		 tag_count =3D 0,
@@ -433,7 +434,7 @@ static int try_bitmap_count(struct rev_info *revs,
 	 */
 	max_count =3D revs->max_count;
=20
-	bitmap_git =3D prepare_bitmap_walk(revs, filter);
+	bitmap_git =3D prepare_bitmap_walk(revs, filter, filter_provided_revs);
 	if (!bitmap_git)
 		return -1;
=20
@@ -450,7 +451,8 @@ static int try_bitmap_count(struct rev_info *revs,
 }
=20
 static int try_bitmap_traversal(struct rev_info *revs,
-				struct list_objects_filter_options *filter)
+				struct list_objects_filter_options *filter,
+				int filter_provided_revs)
 {
 	struct bitmap_index *bitmap_git;
=20
@@ -461,7 +463,7 @@ static int try_bitmap_traversal(struct rev_info *revs,
 	if (revs->max_count >=3D 0)
 		return -1;
=20
-	bitmap_git =3D prepare_bitmap_walk(revs, filter);
+	bitmap_git =3D prepare_bitmap_walk(revs, filter, filter_provided_revs);
 	if (!bitmap_git)
 		return -1;
=20
@@ -471,14 +473,15 @@ static int try_bitmap_traversal(struct rev_info *revs,
 }
=20
 static int try_bitmap_disk_usage(struct rev_info *revs,
-				 struct list_objects_filter_options *filter)
+				 struct list_objects_filter_options *filter,
+				 int filter_provided_revs)
 {
 	struct bitmap_index *bitmap_git;
=20
 	if (!show_disk_usage)
 		return -1;
=20
-	bitmap_git =3D prepare_bitmap_walk(revs, filter);
+	bitmap_git =3D prepare_bitmap_walk(revs, filter, filter_provided_revs);
 	if (!bitmap_git)
 		return -1;
=20
@@ -499,6 +502,7 @@ int cmd_rev_list(int argc, const char **argv, const cha=
r *prefix)
 	int bisect_show_vars =3D 0;
 	int bisect_find_all =3D 0;
 	int use_bitmap_index =3D 0;
+	int filter_provided_revs =3D 0;
 	const char *show_progress =3D NULL;
=20
 	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
@@ -599,6 +603,10 @@ int cmd_rev_list(int argc, const char **argv, const ch=
ar *prefix)
 			list_objects_filter_set_no_filter(&filter_options);
 			continue;
 		}
+		if (!strcmp(arg, "--filter-provided-revisions")) {
+			filter_provided_revs =3D 1;
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
+		if (!try_bitmap_count(&revs, &filter_options, filter_provided_revs))
 			return 0;
-		if (!try_bitmap_disk_usage(&revs, &filter_options))
+		if (!try_bitmap_disk_usage(&revs, &filter_options, filter_provided_revs))
 			return 0;
-		if (!try_bitmap_traversal(&revs, &filter_options))
+		if (!try_bitmap_traversal(&revs, &filter_options, filter_provided_revs))
 			return 0;
 	}
=20
@@ -694,6 +702,16 @@ int cmd_rev_list(int argc, const char **argv, const ch=
ar *prefix)
 			return show_bisect_vars(&info, reaches, all);
 	}
=20
+	if (filter_provided_revs) {
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
index 4385f15828..0576a19a28 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1009,7 +1009,8 @@ static int can_filter_bitmap(struct list_objects_filt=
er_options *filter)
 }
=20
 struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
-					 struct list_objects_filter_options *filter)
+					 struct list_objects_filter_options *filter,
+					 int filter_provided_revs)
 {
 	unsigned int i;
=20
@@ -1104,7 +1105,8 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_i=
nfo *revs,
 	if (haves_bitmap)
 		bitmap_and_not(wants_bitmap, haves_bitmap);
=20
-	filter_bitmap(bitmap_git, wants, wants_bitmap, filter);
+	filter_bitmap(bitmap_git, (filter && filter_provided_revs) ? NULL : wants,
+		      wants_bitmap, filter);
=20
 	bitmap_git->result =3D wants_bitmap;
 	bitmap_git->haves =3D haves_bitmap;
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 36d99930d8..5d8ae3b590 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -50,7 +50,8 @@ void traverse_bitmap_commit_list(struct bitmap_index *,
 				 show_reachable_fn show_reachable);
 void test_bitmap_walk(struct rev_info *revs);
 struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
-					 struct list_objects_filter_options *filter);
+					 struct list_objects_filter_options *filter,
+					 int filter_provided_revs);
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
2.31.1


--qCeSP4cqGIzkLbua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmBwOlgACgkQVbJhu7ck
PpQttQ//Ydd59xH1H37xKTWew7rYhZwMwIu5NZ7S9vexunXSxiQ13I3o1BhPSbDr
rtdU8/2fq+wDCa0uD1QQQ5Bm/+J6SrX5QnxrVYPX1pueypSH8/Dy2GQxj5+KW7ej
sjIk5DY0c9w2HE7m9did5xlEH2WczfmdpNi+AQpmn8DbdW8oKv+1nOBp+x5QcCAP
LPfxxN2dXOmXSMOkfnmXPMAheAi6AKBlyfsN3UZxQQ13dYH6+cgJ4LdLx/K6nxTz
OuZ+mWvKn8hwm6XXzr3/3jsgM2L/1fXYuS2stoLatkI6HwmajUsgQbfdzzckStc+
cBwOFZku4jBz0+dlL97kESFvLzDn8ZfVMjQHuxrWrGa7GhbO1Hpa8T5QPH351X0C
aKzoXMD5m+vWhVt0Vo0zOL42vhAvM2EPDD5ditfezkWye2w+xcZek85NTGBYlEnX
Nz+OdLg9vOervUcxsAZp9TfTJmARp4DU00r1HFVR7HNrDKBV8o8HThyYEyY2fSjl
6O64voD9zJxHZxA1YMFL7FQTIS3M4xHaYrcNUgIvUcaAhm6SyfzQ6K7ydNqgNPii
VhYMTLZq/qHtxju0ByxChKUEJxcYxznYNNwn+wh+U+dn0BAbJGbJcxaRQHH3h1QY
hrlzUxuPmzrFL1Df0WQqaYx1v0vRbvYstiRXKTPJKM9NknxPuxs=
=ReDT
-----END PGP SIGNATURE-----

--qCeSP4cqGIzkLbua--
