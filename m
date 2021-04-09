Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41115C433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 11:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F30D761108
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 11:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbhDIL2F (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 07:28:05 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:39037 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231599AbhDIL2E (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 9 Apr 2021 07:28:04 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 90FD25C0065;
        Fri,  9 Apr 2021 07:27:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 09 Apr 2021 07:27:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=Q/OV3vZqKgz6igScokYCvDvtkBj
        xkcSN8ETYDJXYUrY=; b=M1vznuetVRXhtm4VS9DrG3WDEGzTi6giRLiQUE+u3Up
        fTQBzgeQ3dw0kKIrcKBWmNxYo384WvrAJcCuklLe9/q6HSoBlVAjiWzImAgSfuky
        /vqTcZdBKwWphQXu9KE3jljw7F3Z4tuhZyYSq4Vdh7u7JpcoKnxSv8o1daxezzRq
        04RCdLHHl4m76WvkhRmqVtoRuYDlKkt9auMCK5MB4zXUH9IuBP20xS7zyYLTqFPM
        UnZO/8UPHFNPBiQ8kR2FupJvH8tKiVXq489UzalnyXDsfKl5CS2kXzotax+a87ur
        gyT5qOtJlz8puNMB2ki6aU95Rx26G0JRYeWvxepp0Qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Q/OV3v
        ZqKgz6igScokYCvDvtkBjxkcSN8ETYDJXYUrY=; b=CS1+Fv8U5qznM+WtIsAjv/
        1Fh7zjfb0Fcbct5Hp38u7rcxH2bORt45Vx/3XkWLUsan8uiyHIwA7swF26aj96qG
        998bRiWlXncqcN8ajJgh/Dp1bK7tYGyIL5WPEUCyJo3LIrp8+plKMn4YCyMERePi
        KfSocse8JwRccAz8A2ikS7D1BBgGHhxMmR7hhH1uMTbMZGwP1S6jnK9KzqaJr982
        4SQ2OhYpdsctZQoAW+OzGt/7TL1y014bqr1fpZrXShXIp5RQK38UTo4yJFmM0JGl
        MEMlPaTi+aWMmRKU0yW3/f3mfEDfVpCjSmgEU1UrcG2lnRzyPFV1JOukU4gqDGWw
        ==
X-ME-Sender: <xms:NzpwYOukuF8qw8MCHvFF09ggQSIbwkKdnHvoqdu-3M0DNg4AWtTqGw>
    <xme:NzpwYDd2Y8DGwwGa1RK2NqMIwa-GOpRENl4PTG3QQNcO8FSByMvWfWeQUPSbGVY7i
    u6ZQzzbN4dgsfcaWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekuddggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpefgfeejuefgheegueeljeffteefuedthfdvvedugfevvdffleduueeiiefgvedtheen
    ucffohhmrghinhepphgvnhguihhnghdrnhhrnecukfhppeejjedrudeluddrkedrudeile
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshes
    phhkshdrihhm
X-ME-Proxy: <xmx:NzpwYJwXo-rerxlU9W8wMy-XibBvRbFZNGmwOmJbndMrh22Ygd0bRQ>
    <xmx:NzpwYJOhWr8CQAdafh7vJrlnTWxBPLbsQrKvktAbH_KTsitdYHcTjQ>
    <xmx:NzpwYO-hiJCXt3Q3hYzQaLj3ag7gbGPDQBQA4RLl7CUVCj6DPEiqMQ>
    <xmx:NzpwYEksn7cjlAZrFD67p3ly1SWZJwfVL_SlGRc6y2aw4ED1a81-EA>
Received: from vm-mail.pks.im (x4dbf08a9.dyn.telefonica.de [77.191.8.169])
        by mail.messagingengine.com (Postfix) with ESMTPA id 70660240054;
        Fri,  9 Apr 2021 07:27:50 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id af402f4a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 9 Apr 2021 11:27:48 +0000 (UTC)
Date:   Fri, 9 Apr 2021 13:27:47 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 0/8] rev-parse: implement object type filter
Message-ID: <cover.1617967252.git.ps@pks.im>
References: <cover.1615813673.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TixaLX1st/vby2Y5"
Content-Disposition: inline
In-Reply-To: <cover.1615813673.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--TixaLX1st/vby2Y5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the third version of my patch series which implements a new
`object:type` filter for git-rev-parse(1) and git-upload-pack(1) and
extends support for bitmap indices to work with combined filters.

This mostly addresses Peff's comments. Thanks for your feedback!

    - Removed the `base` parameter from `process_tag()`.

    - The object type filter doesn't assume ordering for the object type
      enum anymore.

    - Combined filters in the bitmap path now verify that
      `filter_bitmap` does not return any errors.

    - Renamed "--filter-provided" to "--filter-provided-revisions" and
      added documentation for it.

    - Refactored the code to not munge the `filter_provided` field in
      the filter options struct, but instead carry it in rev-list.c.

Please see the attached range-diff for more details.

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
 list-objects.c                      |  29 ++++++-
 pack-bitmap.c                       |  76 +++++++++++++++---
 pack-bitmap.h                       |   3 +-
 reachable.c                         |   2 +-
 revision.c                          |   4 +-
 revision.h                          |   3 -
 t/t6112-rev-list-filters-objects.sh |  76 ++++++++++++++++++
 t/t6113-rev-list-bitmap-filters.sh  |  68 +++++++++++++++-
 16 files changed, 416 insertions(+), 34 deletions(-)

Range-diff against v2:
1:  270ff80dac =3D 1:  f80b9570d4 uploadpack.txt: document implication of `=
uploadpackfilter.allow`
2:  ddbec75986 =3D 2:  46c1952405 revision: mark commit parents as NOT_USER=
_GIVEN
3:  d8da0b24f4 ! 3:  3d792f6339 list-objects: move tag processing into its =
own function
    @@ list-objects.c: static void process_tree(struct traversal_context *c=
tx,
     =20
     +static void process_tag(struct traversal_context *ctx,
     +			struct tag *tag,
    -+			struct strbuf *base,
     +			const char *name)
     +{
     +	tag->object.flags |=3D SEEN;
    @@ list-objects.c: static void traverse_trees_and_blobs(struct traversa=
l_context *c
      		if (obj->type =3D=3D OBJ_TAG) {
     -			obj->flags |=3D SEEN;
     -			ctx->show_object(obj, name, ctx->show_data);
    -+			process_tag(ctx, (struct tag *)obj, base, name);
    ++			process_tag(ctx, (struct tag *)obj, name);
      			continue;
      		}
      		if (!path)
4:  5545c189c5 ! 4:  80193d6ba3 list-objects: support filtering by tag and =
commit
    @@ list-objects-filter.h: enum list_objects_filter_result {
    =20
      ## list-objects.c ##
     @@ list-objects.c: static void process_tag(struct traversal_context *c=
tx,
    - 			struct strbuf *base,
    + 			struct tag *tag,
      			const char *name)
      {
     -	tag->object.flags |=3D SEEN;
    @@ list-objects.c: static void process_tag(struct traversal_context *ct=
x,
     +	enum list_objects_filter_result r;
     +
     +	r =3D list_objects_filter__filter_object(ctx->revs->repo, LOFS_TAG,
    -+					       &tag->object, base->buf,
    -+					       &base->buf[base->len],
    -+					       ctx->filter);
    ++					       &tag->object, "", 0, ctx->filter);
     +	if (r & LOFR_MARK_SEEN)
     +		tag->object.flags |=3D SEEN;
     +	if (r & LOFR_DO_SHOW)
5:  acf01472af =3D 5:  e2a14abf92 list-objects: implement object type filter
6:  8073ab665b ! 6:  46d4450d38 pack-bitmap: implement object type filter
    @@ pack-bitmap.c: static void filter_bitmap_tree_depth(struct bitmap_in=
dex *bitmap_
     +				      struct bitmap *to_filter,
     +				      enum object_type object_type)
     +{
    -+	enum object_type t;
    -+
     +	if (object_type < OBJ_COMMIT || object_type > OBJ_TAG)
     +		BUG("filter_bitmap_object_type given invalid object");
     +
    -+	for (t =3D OBJ_COMMIT; t <=3D OBJ_TAG; t++) {
    -+		if (t =3D=3D object_type)
    -+			continue;
    -+		filter_bitmap_exclude_type(bitmap_git, tip_objects, to_filter, t);
    -+	}
    ++	if (object_type !=3D OBJ_TAG)
    ++		filter_bitmap_exclude_type(bitmap_git, tip_objects, to_filter, OBJ_=
TAG);
    ++	if (object_type !=3D OBJ_COMMIT)
    ++		filter_bitmap_exclude_type(bitmap_git, tip_objects, to_filter, OBJ_=
COMMIT);
    ++	if (object_type !=3D OBJ_TREE)
    ++		filter_bitmap_exclude_type(bitmap_git, tip_objects, to_filter, OBJ_=
TREE);
    ++	if (object_type !=3D OBJ_BLOB)
    ++		filter_bitmap_exclude_type(bitmap_git, tip_objects, to_filter, OBJ_=
BLOB);
     +}
     +
      static int filter_bitmap(struct bitmap_index *bitmap_git,
7:  fac3477d97 ! 7:  06a376399b pack-bitmap: implement combined filter
    @@ Commit message
    =20
      ## pack-bitmap.c ##
     @@ pack-bitmap.c: static void filter_bitmap_object_type(struct bitmap_=
index *bitmap_git,
    - 	}
    + 		filter_bitmap_exclude_type(bitmap_git, tip_objects, to_filter, OBJ_=
BLOB);
      }
     =20
     +static int filter_supported(struct list_objects_filter_options *filte=
r)
    @@ pack-bitmap.c: static int filter_bitmap(struct bitmap_index *bitmap_=
git,
     +	if (filter->choice =3D=3D LOFC_COMBINE) {
     +		int i;
     +		for (i =3D 0; i < filter->sub_nr; i++) {
    -+			filter_bitmap(bitmap_git, tip_objects, to_filter,
    -+				      &filter->sub[i]);
    ++			if (filter_bitmap(bitmap_git, tip_objects, to_filter,
    ++					  &filter->sub[i]) < 0)
    ++				return -1;
     +		}
     +		return 0;
     +	}
8:  0e26fee8b3 ! 8:  796606f32b rev-list: allow filtering of provided items
    @@ Commit message
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
    + ## Documentation/rev-list-options.txt ##
    +@@ Documentation/rev-list-options.txt: equivalent.
    + --no-filter::
    + 	Turn off any previous `--filter=3D` argument.
    +=20
    ++--filter-provided-revisions::
    ++	Filter the list of explicitly provided revisions, which would otherw=
ise
    ++	always be printed even if they did not match any of the filters. Only
    ++	useful with `--filter=3D`.
    ++
    + --filter-print-omitted::
    + 	Only useful with `--filter=3D`; prints a list of the objects omitted
    + 	by the filter.  Object IDs are prefixed with a ``~'' character.
    +
    + ## builtin/pack-objects.c ##
    +@@ builtin/pack-objects.c: static int pack_options_allow_reuse(void)
    +=20
    + static int get_object_list_from_bitmap(struct rev_info *revs)
    + {
    +-	if (!(bitmap_git =3D prepare_bitmap_walk(revs, &filter_options)))
    ++	if (!(bitmap_git =3D prepare_bitmap_walk(revs, &filter_options, 0)))
    + 		return -1;
    +=20
    + 	if (pack_options_allow_reuse() &&
    +
      ## builtin/rev-list.c ##
    +@@ builtin/rev-list.c: static inline int parse_missing_action_value(co=
nst char *value)
    + }
    +=20
    + static int try_bitmap_count(struct rev_info *revs,
    +-			    struct list_objects_filter_options *filter)
    ++			    struct list_objects_filter_options *filter,
    ++			    int filter_provided_revs)
    + {
    + 	uint32_t commit_count =3D 0,
    + 		 tag_count =3D 0,
    +@@ builtin/rev-list.c: static int try_bitmap_count(struct rev_info *re=
vs,
    + 	 */
    + 	max_count =3D revs->max_count;
    +=20
    +-	bitmap_git =3D prepare_bitmap_walk(revs, filter);
    ++	bitmap_git =3D prepare_bitmap_walk(revs, filter, filter_provided_rev=
s);
    + 	if (!bitmap_git)
    + 		return -1;
    +=20
    +@@ builtin/rev-list.c: static int try_bitmap_count(struct rev_info *re=
vs,
    + }
    +=20
    + static int try_bitmap_traversal(struct rev_info *revs,
    +-				struct list_objects_filter_options *filter)
    ++				struct list_objects_filter_options *filter,
    ++				int filter_provided_revs)
    + {
    + 	struct bitmap_index *bitmap_git;
    +=20
    +@@ builtin/rev-list.c: static int try_bitmap_traversal(struct rev_info=
 *revs,
    + 	if (revs->max_count >=3D 0)
    + 		return -1;
    +=20
    +-	bitmap_git =3D prepare_bitmap_walk(revs, filter);
    ++	bitmap_git =3D prepare_bitmap_walk(revs, filter, filter_provided_rev=
s);
    + 	if (!bitmap_git)
    + 		return -1;
    +=20
    +@@ builtin/rev-list.c: static int try_bitmap_traversal(struct rev_info=
 *revs,
    + }
    +=20
    + static int try_bitmap_disk_usage(struct rev_info *revs,
    +-				 struct list_objects_filter_options *filter)
    ++				 struct list_objects_filter_options *filter,
    ++				 int filter_provided_revs)
    + {
    + 	struct bitmap_index *bitmap_git;
    +=20
    + 	if (!show_disk_usage)
    + 		return -1;
    +=20
    +-	bitmap_git =3D prepare_bitmap_walk(revs, filter);
    ++	bitmap_git =3D prepare_bitmap_walk(revs, filter, filter_provided_rev=
s);
    + 	if (!bitmap_git)
    + 		return -1;
    +=20
    +@@ builtin/rev-list.c: int cmd_rev_list(int argc, const char **argv, c=
onst char *prefix)
    + 	int bisect_show_vars =3D 0;
    + 	int bisect_find_all =3D 0;
    + 	int use_bitmap_index =3D 0;
    ++	int filter_provided_revs =3D 0;
    + 	const char *show_progress =3D NULL;
    +=20
    + 	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
     @@ builtin/rev-list.c: int cmd_rev_list(int argc, const char **argv, c=
onst char *prefix)
      			list_objects_filter_set_no_filter(&filter_options);
      			continue;
      		}
    -+		if (!strcmp(arg, "--filter-provided")) {
    -+			filter_options.filter_wants =3D 1;
    ++		if (!strcmp(arg, "--filter-provided-revisions")) {
    ++			filter_provided_revs =3D 1;
     +			continue;
     +		}
      		if (!strcmp(arg, "--filter-print-omitted")) {
      			arg_print_omitted =3D 1;
      			continue;
    +@@ builtin/rev-list.c: int cmd_rev_list(int argc, const char **argv, c=
onst char *prefix)
    + 		progress =3D start_delayed_progress(show_progress, 0);
    +=20
    + 	if (use_bitmap_index) {
    +-		if (!try_bitmap_count(&revs, &filter_options))
    ++		if (!try_bitmap_count(&revs, &filter_options, filter_provided_revs))
    + 			return 0;
    +-		if (!try_bitmap_disk_usage(&revs, &filter_options))
    ++		if (!try_bitmap_disk_usage(&revs, &filter_options, filter_provided_=
revs))
    + 			return 0;
    +-		if (!try_bitmap_traversal(&revs, &filter_options))
    ++		if (!try_bitmap_traversal(&revs, &filter_options, filter_provided_r=
evs))
    + 			return 0;
    + 	}
    +=20
     @@ builtin/rev-list.c: int cmd_rev_list(int argc, const char **argv, c=
onst char *prefix)
      			return show_bisect_vars(&info, reaches, all);
      	}
     =20
    -+	if (filter_options.filter_wants) {
    ++	if (filter_provided_revs) {
     +		struct commit_list *c;
     +		for (i =3D 0; i < revs.pending.nr; i++) {
     +			struct object_array_entry *pending =3D revs.pending.objects + i;
    @@ builtin/rev-list.c: int cmd_rev_list(int argc, const char **argv, co=
nst char *pr
      		oidset_init(&omitted_objects, DEFAULT_OIDSET_SIZE);
      	if (arg_missing_action =3D=3D MA_PRINT)
    =20
    - ## list-objects-filter-options.c ##
    -@@ list-objects-filter-options.c: static void transform_to_combine_typ=
e(
    - 		memset(filter_options, 0, sizeof(*filter_options));
    - 		filter_options->sub =3D sub_array;
    - 		filter_options->sub_alloc =3D initial_sub_alloc;
    -+		filter_options->filter_wants =3D sub_array[0].filter_wants;
    - 	}
    - 	filter_options->sub_nr =3D 1;
    - 	filter_options->choice =3D LOFC_COMBINE;
    -@@ list-objects-filter-options.c: void parse_list_objects_filter(
    - 		parse_error =3D gently_parse_list_objects_filter(
    - 			&filter_options->sub[filter_options->sub_nr - 1], arg,
    - 			&errbuf);
    -+		if (!parse_error)
    -+			filter_options->sub[filter_options->sub_nr - 1].filter_wants =3D
    -+				filter_options->filter_wants;
    - 	}
    - 	if (parse_error)
    - 		die("%s", errbuf.buf);
    -
    - ## list-objects-filter-options.h ##
    -@@ list-objects-filter-options.h: struct list_objects_filter_options {
    - 	 */
    - 	enum list_objects_filter_choice choice;
    -=20
    -+	/*
    -+	 * "--filter-provided" was given by the user, instructing us to also
    -+	 * filter all explicitly provided objects.
    -+	 */
    -+	unsigned int filter_wants : 1;
    -+
    - 	/*
    - 	 * Choice is LOFC_DISABLED because "--no-filter" was requested.
    - 	 */
    -
      ## pack-bitmap.c ##
    +@@ pack-bitmap.c: static int can_filter_bitmap(struct list_objects_fil=
ter_options *filter)
    + }
    +=20
    + struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
    +-					 struct list_objects_filter_options *filter)
    ++					 struct list_objects_filter_options *filter,
    ++					 int filter_provided_revs)
    + {
    + 	unsigned int i;
    +=20
     @@ pack-bitmap.c: struct bitmap_index *prepare_bitmap_walk(struct rev_=
info *revs,
      	if (haves_bitmap)
      		bitmap_and_not(wants_bitmap, haves_bitmap);
     =20
     -	filter_bitmap(bitmap_git, wants, wants_bitmap, filter);
    -+	filter_bitmap(bitmap_git, (filter && filter->filter_wants) ? NULL : =
wants,
    ++	filter_bitmap(bitmap_git, (filter && filter_provided_revs) ? NULL : =
wants,
     +		      wants_bitmap, filter);
     =20
      	bitmap_git->result =3D wants_bitmap;
      	bitmap_git->haves =3D haves_bitmap;
    =20
    + ## pack-bitmap.h ##
    +@@ pack-bitmap.h: void traverse_bitmap_commit_list(struct bitmap_index=
 *,
    + 				 show_reachable_fn show_reachable);
    + void test_bitmap_walk(struct rev_info *revs);
    + struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
    +-					 struct list_objects_filter_options *filter);
    ++					 struct list_objects_filter_options *filter,
    ++					 int filter_provided_revs);
    + int reuse_partial_packfile_from_bitmap(struct bitmap_index *,
    + 				       struct packed_git **packfile,
    + 				       uint32_t *entries,
    +
    + ## reachable.c ##
    +@@ reachable.c: void mark_reachable_objects(struct rev_info *revs, int=
 mark_reflog,
    + 	cp.progress =3D progress;
    + 	cp.count =3D 0;
    +=20
    +-	bitmap_git =3D prepare_bitmap_walk(revs, NULL);
    ++	bitmap_git =3D prepare_bitmap_walk(revs, NULL, 0);
    + 	if (bitmap_git) {
    + 		traverse_bitmap_commit_list(bitmap_git, revs, mark_object_seen);
    + 		free_bitmap_index(bitmap_git);
    +
      ## t/t6112-rev-list-filters-objects.sh ##
     @@ t/t6112-rev-list-filters-objects.sh: test_expect_success 'verify ob=
ject:type=3Dtag prints tag' '
      	test_cmp expected actual
--=20
2.31.1


--TixaLX1st/vby2Y5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmBwOjIACgkQVbJhu7ck
PpSx5Q//SN9jy7/3UK11/hCQM/IOam+jhCf+g85bA1u28o+vYdM4sTdoE1YUff6K
+P7frFS+B6mR7ivfw0F28rPoi4jgBVANV6uCRTwnzxqEAX4QZx0wfQNaC3hlHnYB
hMB0XnOoGJ0Uc7/5DFJ+0f6jHw5+e87UedK2DB6lB/lFUXI7RmXasc9dG2VG7WL/
uONZzqlMbetVV6ux+M+HuwFsR1n9o4j5sPIJnQgdsh0wTdL0f+A3ZIs0CGArcwen
RjN6D7FosRwEffQ4FGWa5z3YGM7wCZo+5eZ+okPRdr42wIuRRqJMEu72P/s7X9+Z
vD+49raAwZPjKFL4O4ZFTuwCPep1+9ZPRnsW8HdS8I9+4segsgysS/y8LitXwnGw
Ek7yN5xR8sbwPuyA4ldUwfgqy8WrnJXPUEmbOln5uYxIyiG4jqiwZKt/oc4TB2Ym
WODsI6rJJG0qtmfykItGJY/iFu4ecdKpYa7/DFisbqifsoo+iHyL5OX40t0yuBZg
LWgErD2m7iLl5FVEjmXD/Tp1IgBKaSqkav/KXbkU9HAyTDkk0fk9FB5cefPZmwR8
tr1SRM3CgXk5ZF3gre3kVI5MCPK/GsdE3x1gbJav83xZROq4+e4LjMQCTPjpW7Hw
k7rmWoWYsWi6rUBu5E1x9AkM1go6BG4Zh48iY/wPwIs6eVXInGQ=
=fFHH
-----END PGP SIGNATURE-----

--TixaLX1st/vby2Y5--
