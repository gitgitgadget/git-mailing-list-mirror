Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C9AC433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 13:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8BF661288
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 13:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239992AbhDLNhl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 09:37:41 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:37853 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238958AbhDLNhl (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Apr 2021 09:37:41 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id C71B616D8;
        Mon, 12 Apr 2021 09:37:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 12 Apr 2021 09:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=jLq4TtmvQdkJCpvhERvaCObJqNj
        0l1fcl6qlyPrKVxk=; b=uVHzxpssjENAxCcsYuer8SZ0+hWNOgiPNXU5OjaWwXG
        nojm/8wv9Hju5G9/XsPl64I4sOjDZwUmHqZ+Hgh4TP72FrQmnLO+RxyEGWCZDjDs
        mhz2OaLpMAh3Co6z0y7J0zxgq9FAMfnzfnx2Yya+nyG9DtjKIG2H6NvnaV6oUeyG
        7TXMoo7GxcIX2kn1vNP5LfMrWrqJN+0SiT0BCot0cJOpn7t0PLqEvI9xMHmXUvYy
        bCEvNxAXZ3B/h2zMXgYoy0qLiuLwXm87BqPDZDeAjcleOSpIWhDPQQNrezqkg9ju
        H3a5bo0fiqoNZ56//065hY4F3ArjBAFH5gqv+9vglOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=jLq4Tt
        mvQdkJCpvhERvaCObJqNj0l1fcl6qlyPrKVxk=; b=nCqAFWtQ90LQu1HbS+3h6/
        2uqSFZTdsjgYihQwzbZLY76XyAFlJQx3ekzTRDeLolTnjM3WbRHYb6XNF2zIgXcJ
        8UqM3obWWEVrd6/TMmrHesxEkeJh6zgn2dQ7tcw/SXby/iFuRmu83hKUzndzpKZP
        gPdnqYYMP3z1Dom/tGVXMEw1po8WW8nmvjFbScyHG53pCAhnD37avPJyxl+Ss0Jj
        MM80PN3kbwvlUyyxgb6fMJm+rI1YjwycLk3pwJvOp7eFTUFgfkzFrjXMtnbQ/h6C
        KPsf8ygQq/cLBD7Wsi7g6tVpzHUsg3CqXOw09RRieE+dL82vOOKhnx7mtMVpoodg
        ==
X-ME-Sender: <xms:EU10YIiBSnac42JSJ2_ggrulp09g5ch3imn7HYPXcdNYM-oXBA7lLg>
    <xme:EU10YBBzb-_vxt-_sgfk4V4DyYJ2VSeD-UiT76zKlDRCQwkBhKFDH3at64cNBA1dW
    sSD3NOoFzgY1NVBVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekjedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpefgfeejuefgheegueeljeffteefuedthfdvvedugfevvdffleduueeiiefgvedtheen
    ucffohhmrghinhepphgvnhguihhnghdrnhhrnecukfhppeejkedrheehrdefhedrfedtne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehp
    khhsrdhimh
X-ME-Proxy: <xmx:EU10YAG29P3XN132CSHpY7-iw_wNo8wd6kMJ9gFxC6ucd82zzMnIHQ>
    <xmx:EU10YJTQhejFJQO1cbW5cb65iKXJ4nkMBzvUk9vCdbXI6gw5VDPw-w>
    <xmx:EU10YFyLEhdbQ2ndeqmDmOzY-WEWBs151P2qaB5UOnXllucQbjnajA>
    <xmx:Ek10YA8oCYMfpRI8RAUbfzN2d_ESugyTtgUlnRYx5CxJX26iZ5Q6IA>
Received: from vm-mail.pks.im (dynamic-078-055-035-030.78.55.pool.telefonica.de [78.55.35.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id E6AA7240054;
        Mon, 12 Apr 2021 09:37:20 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id da15c7ce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 12 Apr 2021 13:37:15 +0000 (UTC)
Date:   Mon, 12 Apr 2021 15:37:14 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v4 0/8] rev-list: implement object type filter
Message-ID: <cover.1618234575.git.ps@pks.im>
References: <cover.1617967252.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bWh2YsKi8gW+N9Rb"
Content-Disposition: inline
In-Reply-To: <cover.1617967252.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--bWh2YsKi8gW+N9Rb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the fourth version of my patch series which implements a new
`object:type` filter for git-rev-list(1) and git-upload-pack(1) and
extends support for bitmap indices to work with combined filters.

Changes compared to v3:

    - Small style fix to not pass an empty string and `0`, but instead
      simply pass two `NULL` pointers to
      `list_objects_filter__filter_object, pointed out by Junio.

    - I've changed patch 7/8 as proposed by Peff: support of combined
      filters is now determined directly in `filter_bitmap()`, without
      having to mirror all filter types in the new `filter_supported()`
      function.

    - Renamed `--filter-provided-revisions` to
      `--filter-provided-objects` as proposed by Peff and addressed both
      commit message and tests as pointed out by Philip.

Thanks for all your feedback! As alawys, the range-diff is attached
below.

Patrick

Patrick Steinhardt (8):
  uploadpack.txt: document implication of `uploadpackfilter.allow`
  revision: mark commit parents as NOT_USER_GIVEN
  list-objects: move tag processing into its own function
  list-objects: support filtering by tag and commit
  list-objects: implement object type filter
  pack-bitmap: implement object type filter
  pack-bitmap: implement combined filter
  rev-list: allow filtering of provided items

 Documentation/config/uploadpack.txt |   9 ++-
 Documentation/rev-list-options.txt  |   8 ++
 builtin/pack-objects.c              |   2 +-
 builtin/rev-list.c                  |  36 ++++++---
 list-objects-filter-options.c       |  14 ++++
 list-objects-filter-options.h       |   2 +
 list-objects-filter.c               | 116 ++++++++++++++++++++++++++++
 list-objects-filter.h               |   2 +
 list-objects.c                      |  30 ++++++-
 pack-bitmap.c                       |  45 +++++++++--
 pack-bitmap.h                       |   3 +-
 reachable.c                         |   2 +-
 revision.c                          |   4 +-
 revision.h                          |   3 -
 t/t6112-rev-list-filters-objects.sh |  76 ++++++++++++++++++
 t/t6113-rev-list-bitmap-filters.sh  |  68 +++++++++++++++-
 16 files changed, 390 insertions(+), 30 deletions(-)

Range-diff against v3:
1:  f80b9570d4 =3D 1:  f80b9570d4 uploadpack.txt: document implication of `=
uploadpackfilter.allow`
2:  46c1952405 =3D 2:  46c1952405 revision: mark commit parents as NOT_USER=
_GIVEN
3:  3d792f6339 =3D 3:  3d792f6339 list-objects: move tag processing into it=
s own function
4:  80193d6ba3 ! 4:  674da0f9ac list-objects: support filtering by tag and =
commit
    @@ list-objects.c: static void process_tag(struct traversal_context *ct=
x,
     +	enum list_objects_filter_result r;
     +
     +	r =3D list_objects_filter__filter_object(ctx->revs->repo, LOFS_TAG,
    -+					       &tag->object, "", 0, ctx->filter);
    ++					       &tag->object, NULL, NULL,
    ++					       ctx->filter);
     +	if (r & LOFR_MARK_SEEN)
     +		tag->object.flags |=3D SEEN;
     +	if (r & LOFR_DO_SHOW)
5:  e2a14abf92 =3D 5:  d22a5fd37d list-objects: implement object type filter
6:  46d4450d38 =3D 6:  17c9f66bbc pack-bitmap: implement object type filter
7:  06a376399b ! 7:  759ac54bb2 pack-bitmap: implement combined filter
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## pack-bitmap.c ##
    -@@ pack-bitmap.c: static void filter_bitmap_object_type(struct bitmap_=
index *bitmap_git,
    - 		filter_bitmap_exclude_type(bitmap_git, tip_objects, to_filter, OBJ_=
BLOB);
    - }
    -=20
    -+static int filter_supported(struct list_objects_filter_options *filte=
r)
    -+{
    -+	int i;
    -+
    -+	switch (filter->choice) {
    -+	case LOFC_BLOB_NONE:
    -+	case LOFC_BLOB_LIMIT:
    -+	case LOFC_OBJECT_TYPE:
    -+		return 1;
    -+	case LOFC_TREE_DEPTH:
    -+		if (filter->tree_exclude_depth =3D=3D 0)
    -+			return 1;
    -+		return 0;
    -+	case LOFC_COMBINE:
    -+		for (i =3D 0; i < filter->sub_nr; i++)
    -+			if (!filter_supported(&filter->sub[i]))
    -+				return 0;
    -+		return 1;
    -+	default:
    -+		return 0;
    -+	}
    -+}
    -+
    - static int filter_bitmap(struct bitmap_index *bitmap_git,
    - 			 struct object_list *tip_objects,
    - 			 struct bitmap *to_filter,
    -@@ pack-bitmap.c: static int filter_bitmap(struct bitmap_index *bitmap=
_git,
    - {
    - 	if (!filter || filter->choice =3D=3D LOFC_DISABLED)
    - 		return 0;
    -+	if (!filter_supported(filter))
    -+		return -1;
    -=20
    - 	if (filter->choice =3D=3D LOFC_BLOB_NONE) {
    - 		if (bitmap_git)
     @@ pack-bitmap.c: static int filter_bitmap(struct bitmap_index *bitmap=
_git,
      		return 0;
      	}
     =20
    --	if (filter->choice =3D=3D LOFC_TREE_DEPTH &&
    --	    filter->tree_exclude_depth =3D=3D 0) {
    -+	if (filter->choice =3D=3D LOFC_TREE_DEPTH) {
    - 		if (bitmap_git)
    - 			filter_bitmap_tree_depth(bitmap_git, tip_objects,
    - 						 to_filter,
    -@@ pack-bitmap.c: static int filter_bitmap(struct bitmap_index *bitmap=
_git,
    - 		return 0;
    - 	}
    -=20
    --	/* filter choice not handled */
    --	return -1;
     +	if (filter->choice =3D=3D LOFC_COMBINE) {
     +		int i;
     +		for (i =3D 0; i < filter->sub_nr; i++) {
    @@ pack-bitmap.c: static int filter_bitmap(struct bitmap_index *bitmap_=
git,
     +		return 0;
     +	}
     +
    -+	BUG("unsupported filter choice");
    + 	/* filter choice not handled */
    + 	return -1;
      }
    -=20
    - static int can_filter_bitmap(struct list_objects_filter_options *filt=
er)
    =20
      ## t/t6113-rev-list-bitmap-filters.sh ##
     @@ t/t6113-rev-list-bitmap-filters.sh: test_expect_success 'object:typ=
e filter' '
8:  cf2297b413 ! 8:  c779d222cf rev-list: allow filtering of provided items
    @@ Commit message
         that even if the user wants to only see blobs, he'll still see com=
mits
         of provided references.
    =20
    -    Improve this by introducing a new `--filter-provided` option to the
    -    git-rev-parse(1) command. If given, then all user-provided referen=
ces
    -    will be subject to filtering.
    +    Improve this by introducing a new `--filter-provided-objects` opti=
on
    +    to the git-rev-parse(1) command. If given, then all user-provided
    +    references will be subject to filtering.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
    @@ Documentation/rev-list-options.txt: equivalent.
      --no-filter::
      	Turn off any previous `--filter=3D` argument.
     =20
    -+--filter-provided-revisions::
    -+	Filter the list of explicitly provided revisions, which would otherw=
ise
    ++--filter-provided-objects::
    ++	Filter the list of explicitly provided objects, which would otherwise
     +	always be printed even if they did not match any of the filters. Only
     +	useful with `--filter=3D`.
     +
    @@ builtin/rev-list.c: static inline int parse_missing_action_value(con=
st char *val
      static int try_bitmap_count(struct rev_info *revs,
     -			    struct list_objects_filter_options *filter)
     +			    struct list_objects_filter_options *filter,
    -+			    int filter_provided_revs)
    ++			    int filter_provided_objects)
      {
      	uint32_t commit_count =3D 0,
      		 tag_count =3D 0,
    @@ builtin/rev-list.c: static int try_bitmap_count(struct rev_info *rev=
s,
      	max_count =3D revs->max_count;
     =20
     -	bitmap_git =3D prepare_bitmap_walk(revs, filter);
    -+	bitmap_git =3D prepare_bitmap_walk(revs, filter, filter_provided_rev=
s);
    ++	bitmap_git =3D prepare_bitmap_walk(revs, filter, filter_provided_obj=
ects);
      	if (!bitmap_git)
      		return -1;
     =20
    @@ builtin/rev-list.c: static int try_bitmap_count(struct rev_info *rev=
s,
      static int try_bitmap_traversal(struct rev_info *revs,
     -				struct list_objects_filter_options *filter)
     +				struct list_objects_filter_options *filter,
    -+				int filter_provided_revs)
    ++				int filter_provided_objects)
      {
      	struct bitmap_index *bitmap_git;
     =20
    @@ builtin/rev-list.c: static int try_bitmap_traversal(struct rev_info =
*revs,
      		return -1;
     =20
     -	bitmap_git =3D prepare_bitmap_walk(revs, filter);
    -+	bitmap_git =3D prepare_bitmap_walk(revs, filter, filter_provided_rev=
s);
    ++	bitmap_git =3D prepare_bitmap_walk(revs, filter, filter_provided_obj=
ects);
      	if (!bitmap_git)
      		return -1;
     =20
    @@ builtin/rev-list.c: static int try_bitmap_traversal(struct rev_info =
*revs,
      static int try_bitmap_disk_usage(struct rev_info *revs,
     -				 struct list_objects_filter_options *filter)
     +				 struct list_objects_filter_options *filter,
    -+				 int filter_provided_revs)
    ++				 int filter_provided_objects)
      {
      	struct bitmap_index *bitmap_git;
     =20
    @@ builtin/rev-list.c: static int try_bitmap_traversal(struct rev_info =
*revs,
      		return -1;
     =20
     -	bitmap_git =3D prepare_bitmap_walk(revs, filter);
    -+	bitmap_git =3D prepare_bitmap_walk(revs, filter, filter_provided_rev=
s);
    ++	bitmap_git =3D prepare_bitmap_walk(revs, filter, filter_provided_obj=
ects);
      	if (!bitmap_git)
      		return -1;
     =20
    @@ builtin/rev-list.c: int cmd_rev_list(int argc, const char **argv, co=
nst char *pr
      	int bisect_show_vars =3D 0;
      	int bisect_find_all =3D 0;
      	int use_bitmap_index =3D 0;
    -+	int filter_provided_revs =3D 0;
    ++	int filter_provided_objects =3D 0;
      	const char *show_progress =3D NULL;
     =20
      	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
    @@ builtin/rev-list.c: int cmd_rev_list(int argc, const char **argv, co=
nst char *pr
      			list_objects_filter_set_no_filter(&filter_options);
      			continue;
      		}
    -+		if (!strcmp(arg, "--filter-provided-revisions")) {
    -+			filter_provided_revs =3D 1;
    ++		if (!strcmp(arg, "--filter-provided-objects")) {
    ++			filter_provided_objects =3D 1;
     +			continue;
     +		}
      		if (!strcmp(arg, "--filter-print-omitted")) {
    @@ builtin/rev-list.c: int cmd_rev_list(int argc, const char **argv, co=
nst char *pr
     =20
      	if (use_bitmap_index) {
     -		if (!try_bitmap_count(&revs, &filter_options))
    -+		if (!try_bitmap_count(&revs, &filter_options, filter_provided_revs))
    ++		if (!try_bitmap_count(&revs, &filter_options, filter_provided_objec=
ts))
      			return 0;
     -		if (!try_bitmap_disk_usage(&revs, &filter_options))
    -+		if (!try_bitmap_disk_usage(&revs, &filter_options, filter_provided_=
revs))
    ++		if (!try_bitmap_disk_usage(&revs, &filter_options, filter_provided_=
objects))
      			return 0;
     -		if (!try_bitmap_traversal(&revs, &filter_options))
    -+		if (!try_bitmap_traversal(&revs, &filter_options, filter_provided_r=
evs))
    ++		if (!try_bitmap_traversal(&revs, &filter_options, filter_provided_o=
bjects))
      			return 0;
      	}
     =20
    @@ builtin/rev-list.c: int cmd_rev_list(int argc, const char **argv, co=
nst char *pr
      			return show_bisect_vars(&info, reaches, all);
      	}
     =20
    -+	if (filter_provided_revs) {
    ++	if (filter_provided_objects) {
     +		struct commit_list *c;
     +		for (i =3D 0; i < revs.pending.nr; i++) {
     +			struct object_array_entry *pending =3D revs.pending.objects + i;
    @@ pack-bitmap.c: static int can_filter_bitmap(struct list_objects_filt=
er_options *
      struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
     -					 struct list_objects_filter_options *filter)
     +					 struct list_objects_filter_options *filter,
    -+					 int filter_provided_revs)
    ++					 int filter_provided_objects)
      {
      	unsigned int i;
     =20
    @@ pack-bitmap.c: struct bitmap_index *prepare_bitmap_walk(struct rev_i=
nfo *revs,
      		bitmap_and_not(wants_bitmap, haves_bitmap);
     =20
     -	filter_bitmap(bitmap_git, wants, wants_bitmap, filter);
    -+	filter_bitmap(bitmap_git, (filter && filter_provided_revs) ? NULL : =
wants,
    ++	filter_bitmap(bitmap_git, (filter && filter_provided_objects) ? NULL=
 : wants,
     +		      wants_bitmap, filter);
     =20
      	bitmap_git->result =3D wants_bitmap;
    @@ pack-bitmap.h: void traverse_bitmap_commit_list(struct bitmap_index =
*,
      struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
     -					 struct list_objects_filter_options *filter);
     +					 struct list_objects_filter_options *filter,
    -+					 int filter_provided_revs);
    ++					 int filter_provided_objects);
      int reuse_partial_packfile_from_bitmap(struct bitmap_index *,
      				       struct packed_git **packfile,
      				       uint32_t *entries,
    @@ t/t6112-rev-list-filters-objects.sh: test_expect_success 'verify obj=
ect:type=3Dtag
      	test_cmp expected actual
      '
     =20
    -+test_expect_success 'verify object:type=3Dblob prints only blob with =
--filter-provided-revisions' '
    ++test_expect_success 'verify object:type=3Dblob prints only blob with =
--filter-provided-objects' '
     +	printf "%s blob\n" $(git -C object-type rev-parse HEAD:blob) >expect=
ed &&
     +	git -C object-type rev-list --objects \
    -+		--filter=3Dobject:type=3Dblob --filter-provided-revisions HEAD >act=
ual &&
    ++		--filter=3Dobject:type=3Dblob --filter-provided-objects HEAD >actua=
l &&
     +	test_cmp expected actual
     +'
     +
    -+test_expect_success 'verify object:type=3Dtree prints only tree with =
--filter-provided-revisions' '
    ++test_expect_success 'verify object:type=3Dtree prints only tree with =
--filter-provided-objects' '
     +	printf "%s \n" $(git -C object-type rev-parse HEAD^{tree}) >expected=
 &&
     +	git -C object-type rev-list --objects \
    -+		--filter=3Dobject:type=3Dtree HEAD --filter-provided-revisions >act=
ual &&
    ++		--filter=3Dobject:type=3Dtree HEAD --filter-provided-objects >actua=
l &&
     +	test_cmp expected actual
     +'
     +
    -+test_expect_success 'verify object:type=3Dcommit prints only commit w=
ith --filter-provided-revisions' '
    ++test_expect_success 'verify object:type=3Dcommit prints only commit w=
ith --filter-provided-objects' '
     +	git -C object-type rev-parse HEAD >expected &&
     +	git -C object-type rev-list --objects \
    -+		--filter=3Dobject:type=3Dcommit --filter-provided-revisions HEAD >a=
ctual &&
    ++		--filter=3Dobject:type=3Dcommit --filter-provided-objects HEAD >act=
ual &&
     +	test_cmp expected actual
     +'
     +
    -+test_expect_success 'verify object:type=3Dtag prints only tag with --=
filter-provided-revisions' '
    ++test_expect_success 'verify object:type=3Dtag prints only tag with --=
filter-provided-objects' '
     +	printf "%s tag\n" $(git -C object-type rev-parse tag) >expected &&
     +	git -C object-type rev-list --objects \
    -+		--filter=3Dobject:type=3Dtag --filter-provided-revisions tag >actua=
l &&
    ++		--filter=3Dobject:type=3Dtag --filter-provided-objects tag >actual =
&&
     +	test_cmp expected actual
     +'
     +
    @@ t/t6113-rev-list-bitmap-filters.sh: test_expect_success 'object:type=
 filter' '
      	test_bitmap_traversal expect actual
      '
     =20
    -+test_expect_success 'object:type filter with --filter-provided-revisi=
ons' '
    -+	git rev-list --objects --filter-provided-revisions --filter=3Dobject=
:type=3Dtag tag >expect &&
    ++test_expect_success 'object:type filter with --filter-provided-object=
s' '
    ++	git rev-list --objects --filter-provided-objects --filter=3Dobject:t=
ype=3Dtag tag >expect &&
     +	git rev-list --use-bitmap-index \
    -+		     --objects --filter-provided-revisions --filter=3Dobject:type=
=3Dtag tag >actual &&
    ++		     --objects --filter-provided-objects --filter=3Dobject:type=3Dt=
ag tag >actual &&
     +	test_cmp expect actual &&
     +
    -+	git rev-list --objects --filter-provided-revisions --filter=3Dobject=
:type=3Dcommit tag >expect &&
    ++	git rev-list --objects --filter-provided-objects --filter=3Dobject:t=
ype=3Dcommit tag >expect &&
     +	git rev-list --use-bitmap-index \
    -+		     --objects --filter-provided-revisions --filter=3Dobject:type=
=3Dcommit tag >actual &&
    ++		     --objects --filter-provided-objects --filter=3Dobject:type=3Dc=
ommit tag >actual &&
     +	test_bitmap_traversal expect actual &&
     +
    -+	git rev-list --objects --filter-provided-revisions --filter=3Dobject=
:type=3Dtree tag >expect &&
    ++	git rev-list --objects --filter-provided-objects --filter=3Dobject:t=
ype=3Dtree tag >expect &&
     +	git rev-list --use-bitmap-index \
    -+		     --objects --filter-provided-revisions --filter=3Dobject:type=
=3Dtree tag >actual &&
    ++		     --objects --filter-provided-objects --filter=3Dobject:type=3Dt=
ree tag >actual &&
     +	test_bitmap_traversal expect actual &&
     +
    -+	git rev-list --objects --filter-provided-revisions --filter=3Dobject=
:type=3Dblob tag >expect &&
    ++	git rev-list --objects --filter-provided-objects --filter=3Dobject:t=
ype=3Dblob tag >expect &&
     +	git rev-list --use-bitmap-index \
    -+		     --objects --filter-provided-revisions --filter=3Dobject:type=
=3Dblob tag >actual &&
    ++		     --objects --filter-provided-objects --filter=3Dobject:type=3Db=
lob tag >actual &&
     +	test_bitmap_traversal expect actual
     +'
     +
    @@ t/t6113-rev-list-bitmap-filters.sh: test_expect_success 'combine fil=
ter' '
      	test_bitmap_traversal expect actual
      '
     =20
    -+test_expect_success 'combine filter with --filter-provided-revisions'=
 '
    -+	git rev-list --objects --filter-provided-revisions --filter=3Dblob:l=
imit=3D1000 --filter=3Dobject:type=3Dblob tag >expect &&
    ++test_expect_success 'combine filter with --filter-provided-objects' '
    ++	git rev-list --objects --filter-provided-objects --filter=3Dblob:lim=
it=3D1000 --filter=3Dobject:type=3Dblob tag >expect &&
     +	git rev-list --use-bitmap-index \
    -+		     --objects --filter-provided-revisions --filter=3Dblob:limit=3D=
1000 --filter=3Dobject:type=3Dblob tag >actual &&
    ++		     --objects --filter-provided-objects --filter=3Dblob:limit=3D10=
00 --filter=3Dobject:type=3Dblob tag >actual &&
     +	test_bitmap_traversal expect actual &&
     +
     +	git cat-file --batch-check=3D"%(objecttype) %(objectsize)" <actual >=
objects &&
--=20
2.31.1


--bWh2YsKi8gW+N9Rb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmB0TQkACgkQVbJhu7ck
PpTGTg/+LkkCOajNOUiyDTwTrPSyLw/iJgmE0uuxPN5R5YJ1z5GCGcbRhZ4H/Bir
n7f5v2LTlflJtE0SXINi3/2Wb332udSyLmvfD68b+VSvS4wEyr0vQ5/BPM2S+cIX
JV8bo+AOWs8NK0Yaq+Ee+OQ+bWsTSx7D8VrcgIdUG+dTEv5IexQV0WwDoilorNG1
D7j/mnbvLzgxtGZM2nhUia0qTvZ7ttAZfx3J0UNdw3GneXGXSINMuVlOfLQxJO/0
p4feXionei4olmjBU+dVFI+TrAnoPrHPSDWaRfc4YARb4V64/eIw92TWaJj1fRpM
8WffLW3pxndPouHoSvHU2KuZYP20F6Oth3BIp6ChGBbV/ytaeXiQCGuOhRyPcILT
OQXiLmI1bpn0AkMGoUpWv9ZFeFcU6dKd4TFXMhBu+H4PKPJ0ztSiy49eqhXYmqQ/
+L3n6/b3Y93ORaZWZMPLJYL6D8XfLm87kQjBZt0T8/PoGxkzx8NU9C7+ya6PFrIc
UmCG8nY8G51ZWt5YBGc7GEtMQypEis5TNvQCpAIvv3pNoUNLOqb08YErketewAtb
7UK+fpwe9h9KM4HoEfar0h/3MbK1mOb9KjP7LB+72vymlcwvGT6nOewYce6+EH5d
LWvnFqojnm911+de5Mw+JCl/jb5LAjd2VF+ffiIx+IMDkvj2HkQ=
=botP
-----END PGP SIGNATURE-----

--bWh2YsKi8gW+N9Rb--
