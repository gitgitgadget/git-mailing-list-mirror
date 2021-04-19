Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43BCC433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87C1261090
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbhDSLsu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 07:48:50 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:44791 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238897AbhDSLrk (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Apr 2021 07:47:40 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 92DF7B3E;
        Mon, 19 Apr 2021 07:47:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 19 Apr 2021 07:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=QDQqnEJRCUullGzgaqMtGjPc0tL
        bYM1jQACRjC1qdT8=; b=ckz3Ca0uHZfUHFNeKGCLt9oHsvL0GRAwHlxn6ccMYdK
        qOsVBNiJYAS6ot/qIZvmIxiNsB+VIyCFsEalrqeDUsOMUsulEyGwby7Ma8sLqvwG
        MqaCKyO1319qfyehTZ19TmppHiTDwl8ty07IhK3KiNsp0lB5zKjtPhccifYjHG+5
        XxLieiyiJMfehEK+9Teqpf4eMZv4N89wqdgF1nRARimjDWqjfAcf43SuwnCjqPUX
        uMSoZDyWe79qOJpVG8tPVfzCru01hU9Rw5NOK2FcFoGmk3okMkgoEYW0zO08hO7U
        TT9BBc0Jkl95sfcj/WFHcwNAVxmuhkwE324Nb2F2roA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=QDQqnE
        JRCUullGzgaqMtGjPc0tLbYM1jQACRjC1qdT8=; b=ceeoMwNSCXOoh/a6HLjjKL
        Z8AMGeQq1Gc+cjFnlntAfxVF9bP7SRqN/9RuD7lRmj/7E/3ymsrEfiaUbo1ueUiW
        9G4lpgCg9BsppUKToUYZOY8c1JAj/XNS1juCivqolBBvL3C6HJ17ujAbD6aJAugd
        CU+fplK6Ex7OaidD7ifEZnFm82Gap7tocJxnKgXyNe+XEwkXFN6I4PHtF2Bhp/EM
        AzxfOzEsyMs7eUFbtUXm9r1asKGuECV1AAyvhyjDQ8k1zBZuqY921Ok6FvVALlbq
        p3k7N11xNq152sqFAST9Jr2v26sjy6O/LzxHYM0fTy7Ff4rvhiddc8BIZqGlxGEQ
        ==
X-ME-Sender: <xms:vm19YA_nvvmxO54WpM4Wf4b2Ox6U0ERXspzfrEYZTRhz_k4lwxIYrA>
    <xme:vm19YIv3qSWnaGKPyeEa8eSfpSmv-sCXR25U_QKmKTbdTClC3JJARcR_X3KHF4QFZ
    t_V8LzPMhlFiv--ZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddtgedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpefgfeejuefgheegueeljeffteefuedthfdvvedugfevvdffleduueeiiefgvedtheen
    ucffohhmrghinhepphgvnhguihhnghdrnhhrnecukfhppeejjedrudeluddrieekrdektd
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshes
    phhkshdrihhm
X-ME-Proxy: <xmx:vm19YGCgSXNe8bCQE8lczrci4ER6vwBa7Ih80VjyuEE3Tv-Am90UHA>
    <xmx:vm19YAf10pnPsh7xILmdy7oRlitecxpCTQBgaFkD6Nn7SB-N0s_3jQ>
    <xmx:vm19YFNirjeHsi3xr5alXggeI2QRb_Zr3PL_7IIdLyJUX7_gEY3LAA>
    <xmx:vm19YKohaNAF9h8HhuH76TNfWkwHCuQGOX70_4vk8Rsq4R7KhErwYA>
Received: from vm-mail.pks.im (x4dbf4450.dyn.telefonica.de [77.191.68.80])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3200D108005B;
        Mon, 19 Apr 2021 07:47:09 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 02542775 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 19 Apr 2021 11:47:08 +0000 (UTC)
Date:   Mon, 19 Apr 2021 13:47:06 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v5 8/8] rev-list: allow filtering of provided items
Message-ID: <fce3551e48f2d66518ee9d3d878d393988393b35.1618832437.git.ps@pks.im>
References: <cover.1618234575.git.ps@pks.im>
 <cover.1618832437.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tQIMTgB5J5u+Muc6"
Content-Disposition: inline
In-Reply-To: <cover.1618832437.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--tQIMTgB5J5u+Muc6
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
index a1e33d7507..c89e996f0d 100644
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
index 53f35d41c6..6efea70ae7 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -987,7 +987,8 @@ static int can_filter_bitmap(struct list_objects_filter=
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
@@ -1082,7 +1083,8 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_i=
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
index 78f2b3ff79..99d733eb26 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -52,7 +52,8 @@ void traverse_bitmap_commit_list(struct bitmap_index *,
 void test_bitmap_walk(struct rev_info *revs);
 int test_bitmap_commits(struct repository *r);
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
index c810a62807..4ade105db3 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -203,6 +203,34 @@ test_expect_success 'verify object:type=3Dtag prints t=
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


--tQIMTgB5J5u+Muc6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmB9bboACgkQVbJhu7ck
PpRh0g//eUhkY2zXXUrA9oZsRpN35gW7/hUmHnV7pCTs1i0fR7jsyPX0Ef4MVe97
OqInrH4gmspjT0E/A/4PF7uOKs7uzE9JqkF3C2wixycmM28JfQ/0+LiVj/WxbKGs
pQvQGiWlUC/Pfrrwovoq0txI2Cv3XpIFcHwugNS697AQEZBFtWl5wZRyyYHQXZ+M
Oj7AqONxi1/NIYM9cL4paOl0QzOF87qB3Xi6+cNK+7HCaDKwYCCfWx3FyNRSCpf+
O2K+6Ua41n+JP584b+OIS9wueSD33plo678pGK9LQPcT/LmkRsXm4wEgo5neT0eV
4gkFjtNoCq6y3RvJZKjuAH6Sgi3tqM6lIhU9dZfiR1xqg69rkuAh3AjKDodZqP4s
LfM0D/s5K/PVelbASLoO7EAzXUr8NJd8ZKVHHlUkDrFj/zpRWdBof8GN1ZqcLAgm
xJHDcfxoErvMYcuD5oFDdELEQPrj9q+NyXkUSf5CxOgc3ImeJXZ2GjAowNpeAiZy
6+wUEtPby+WtcN3zml2bYnIaZ0LW5XLMfef8XHCRWcLv7qlBBpaZYR56579wXEdE
naA0FRrklVCtLU4CfqMrPMkCh0zzeOIT8dMm4p3SXcNTWesH8YcRKDkVawodiZqU
wZLgt03HFoXHXJ6PTnw7Mh8MlFANnQAOrCf57QXk63LcNaqNANk=
=Q0et
-----END PGP SIGNATURE-----

--tQIMTgB5J5u+Muc6--
