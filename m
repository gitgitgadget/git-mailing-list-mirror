Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C817AC433DB
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 12:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8356264E31
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 12:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbhCAMVj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 07:21:39 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:57343 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233936AbhCAMVh (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 1 Mar 2021 07:21:37 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 78B39A2F;
        Mon,  1 Mar 2021 07:20:51 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 01 Mar 2021 07:20:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=uob51lyiCMA77JZKxCB6d2K3z7R
        +M/p+bItjFkKGC5U=; b=q3aybrmJpCCpcOb+kQHMg8YSR/vSPQVFoZVk3g4kZYL
        xZM0U4ae88c64zJdAWClg+AkO58ts2Z/e2lPIwdRXizlmnr3/fctC+yw2i3lHI9h
        +IkRhnC6ykY8w5VjIFOI1Dftbozrl1dEYV1Khug/xE1LzcgdhUFJFlvjoWa3VOCY
        m1Yua7pYiK7dwASimMaH67qSp1VUa/GcbJ/HMhVvCYbS80S8G8A3KXuhWO0BTpuj
        jTzfiHhGGRWh1e7iHX/9lmEiFGeb0DL8VMMm/l7iZt+5Lu4S+FkdbekcDSZZK+XT
        yPAgMpLqY/qgVue4DrFXoBgvx3Ga5lzz5oDCcQJ+tEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=uob51l
        yiCMA77JZKxCB6d2K3z7R+M/p+bItjFkKGC5U=; b=AAHtI1x/nTu2Dl4F+TIGr4
        shA/vz+DUzV6J5Ok0JNjBD0/7UmgND/hPTHPf6KX/LaL8qE9axzozPzXnDCVkDLW
        1M0m3dy7KpYID62L1wTN6L41ivgZnNRfFvvEKI3jMok3Mqbvd68/qXfzZLl2u6tH
        7OQE0bk5Gn2WWj2XHh4yQi3QtJswI0iUejjzagdzxZiuVuiZX6J/QAne/USM4mCE
        RvKhvaZO5YCxMpphYDBuLlKKvLsA7mq7RjtXtpCPNSrbjwsliEQ62J7aOEiJgFxK
        nnnZWVsGBMhqw5AKqw1ML7WzDBuDLtE6mAx5nCC7gbTDczYCIYZiRDNTzOZMoBXw
        ==
X-ME-Sender: <xms:I9w8YFeqIUTUkPaRIXU5_1HuyXWu8YULr64A-SsAaIZ25dqbNcZ_Ew>
    <xme:I9w8YDIyCSSaDTMAfpsRcFXxOUxF0OGeVL6SpuV_TyGvvpooWezVTrPcYL_D0lbuR
    287zS65k4pBiztfCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrleekgdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    kfhppeejjedrudeluddrvdejrddufedvnecuvehluhhsthgvrhfuihiivgepvdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:I9w8YLZAQN5wMSUwe5hgnAhhf8_rB6QmfbJ0OeGMbUi83t1fYz9nRw>
    <xmx:I9w8YGv-8Zh9P5Ae1x2u9RksVWL2WEYV8LfErA_MN2V9cLakCTZS1Q>
    <xmx:I9w8YAt_QO1wualqRLVQJi2dOAvDpykNel9J1TS40FophsBwYJkWUA>
    <xmx:I9w8YEWkO4zmzItHPtblDWa3QUBLo34tkgNMrixEtO4IxVTzCu0jaw>
Received: from vm-mail.pks.im (x4dbf1b84.dyn.telefonica.de [77.191.27.132])
        by mail.messagingengine.com (Postfix) with ESMTPA id A8A92240057;
        Mon,  1 Mar 2021 07:20:50 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 99bbda6b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 1 Mar 2021 12:20:49 +0000 (UTC)
Date:   Mon, 1 Mar 2021 13:20:47 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 4/7] list-objects: implement object type filter
Message-ID: <01b9fdbb9c0ca8d70281422a13f7f4df85ffed90.1614600555.git.ps@pks.im>
References: <cover.1614600555.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/XGNxH5iUKQW0qjQ"
Content-Disposition: inline
In-Reply-To: <cover.1614600555.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--/XGNxH5iUKQW0qjQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While it already is possible to filter objects by some criteria in
git-rev-list(1), it is not yet possible to filter out only a specific
type of objects. This makes some filters less useful. The `blob:limit`
filter for example filters blobs such that only those which are smaller
than the given limit are returned. But it is unfit to ask only for these
smallish blobs, given that git-rev-list(1) will continue to print tags,
commits and trees.

Now that we have the infrastructure in place to also filter tags and
commits, we can improve this situation by implementing a new filter
which selects objects based on their type. Above query can thus
trivially be implemented with the following command:

    $ git rev-list --objects --filter=3Dobject:type=3Dblob \
        --filter=3Dblob:limit=3D200

Furthermore, this filter allows to optimize for certain other cases: if
for example only tags or commits have been selected, there is no need to
walk down trees.

The new filter is not yet supported in bitmaps. This is going to be
implemented in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/rev-list-options.txt  |  3 ++
 list-objects-filter-options.c       | 14 ++++++
 list-objects-filter-options.h       |  2 +
 list-objects-filter.c               | 76 +++++++++++++++++++++++++++++
 t/t6112-rev-list-filters-objects.sh | 48 ++++++++++++++++++
 5 files changed, 143 insertions(+)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-op=
tions.txt
index b1c8f86c6e..3afa8fffbd 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -892,6 +892,9 @@ or units.  n may be zero.  The suffixes k, m, and g can=
 be used to name
 units in KiB, MiB, or GiB.  For example, 'blob:limit=3D1k' is the same
 as 'blob:limit=3D1024'.
 +
+The form '--filter=3Dobject:type=3D(tag|commit|tree|blob)' omits all objec=
ts
+which are not of the requested type.
++
 The form '--filter=3Dsparse:oid=3D<blob-ish>' uses a sparse-checkout
 specification contained in the blob (or blob-expression) '<blob-ish>'
 to omit blobs that would not be not required for a sparse checkout on
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index d2d1c81caf..bb6f6577d5 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -29,6 +29,8 @@ const char *list_object_filter_config_name(enum list_obje=
cts_filter_choice c)
 		return "tree";
 	case LOFC_SPARSE_OID:
 		return "sparse:oid";
+	case LOFC_OBJECT_TYPE:
+		return "object:type";
 	case LOFC_COMBINE:
 		return "combine";
 	case LOFC__COUNT:
@@ -97,6 +99,18 @@ static int gently_parse_list_objects_filter(
 		}
 		return 1;
=20
+	} else if (skip_prefix(arg, "object:type=3D", &v0)) {
+		int type =3D type_from_string_gently(v0, -1, 1);
+		if (type < 0) {
+			strbuf_addstr(errbuf, _("expected 'object:type=3D<type>'"));
+			return 1;
+		}
+
+		filter_options->object_type =3D type;
+		filter_options->choice =3D LOFC_OBJECT_TYPE;
+
+		return 0;
+
 	} else if (skip_prefix(arg, "combine:", &v0)) {
 		return parse_combine_filter(filter_options, v0, errbuf);
=20
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index 01767c3c96..4d0d0588cc 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -13,6 +13,7 @@ enum list_objects_filter_choice {
 	LOFC_BLOB_LIMIT,
 	LOFC_TREE_DEPTH,
 	LOFC_SPARSE_OID,
+	LOFC_OBJECT_TYPE,
 	LOFC_COMBINE,
 	LOFC__COUNT /* must be last */
 };
@@ -54,6 +55,7 @@ struct list_objects_filter_options {
 	char *sparse_oid_name;
 	unsigned long blob_limit_value;
 	unsigned long tree_exclude_depth;
+	enum object_type object_type;
=20
 	/* LOFC_COMBINE values */
=20
diff --git a/list-objects-filter.c b/list-objects-filter.c
index 7def039435..650a7c2c80 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -545,6 +545,81 @@ static void filter_sparse_oid__init(
 	filter->free_fn =3D filter_sparse_free;
 }
=20
+/*
+ * A filter for list-objects to omit large blobs.
+ * And to OPTIONALLY collect a list of the omitted OIDs.
+ */
+struct filter_object_type_data {
+	enum object_type object_type;
+};
+
+static enum list_objects_filter_result filter_object_type(
+	struct repository *r,
+	enum list_objects_filter_situation filter_situation,
+	struct object *obj,
+	const char *pathname,
+	const char *filename,
+	struct oidset *omits,
+	void *filter_data_)
+{
+	struct filter_object_type_data *filter_data =3D filter_data_;
+
+	switch (filter_situation) {
+	default:
+		BUG("unknown filter_situation: %d", filter_situation);
+
+	case LOFS_TAG:
+		assert(obj->type =3D=3D OBJ_TAG);
+		if (filter_data->object_type =3D=3D OBJ_TAG)
+			return LOFR_MARK_SEEN | LOFR_DO_SHOW;
+		return LOFR_MARK_SEEN;
+
+	case LOFS_COMMIT:
+		assert(obj->type =3D=3D OBJ_COMMIT);
+		if (filter_data->object_type =3D=3D OBJ_COMMIT)
+			return LOFR_MARK_SEEN | LOFR_DO_SHOW;
+		return LOFR_MARK_SEEN;
+
+	case LOFS_BEGIN_TREE:
+		assert(obj->type =3D=3D OBJ_TREE);
+
+		/*
+		 * If we only want to show commits or tags, then there is no
+		 * need to walk down trees.
+		 */
+		if (filter_data->object_type =3D=3D OBJ_COMMIT ||
+		    filter_data->object_type =3D=3D OBJ_TAG)
+			return LOFR_SKIP_TREE;
+
+		if (filter_data->object_type =3D=3D OBJ_TREE)
+			return LOFR_MARK_SEEN | LOFR_DO_SHOW;
+
+		return LOFR_MARK_SEEN;
+
+	case LOFS_BLOB:
+		assert(obj->type =3D=3D OBJ_BLOB);
+
+		if (filter_data->object_type =3D=3D OBJ_BLOB)
+			return LOFR_MARK_SEEN | LOFR_DO_SHOW;
+		return LOFR_MARK_SEEN;
+
+	case LOFS_END_TREE:
+		return LOFR_ZERO;
+	}
+}
+
+static void filter_object_type__init(
+	struct list_objects_filter_options *filter_options,
+	struct filter *filter)
+{
+	struct filter_object_type_data *d =3D xcalloc(1, sizeof(*d));
+	d->object_type =3D filter_options->object_type;
+
+	filter->filter_data =3D d;
+	filter->filter_object_fn =3D filter_object_type;
+	filter->free_fn =3D free;
+}
+
 /* A filter which only shows objects shown by all sub-filters. */
 struct combine_filter_data {
 	struct subfilter *sub;
@@ -691,6 +766,7 @@ static filter_init_fn s_filters[] =3D {
 	filter_blobs_limit__init,
 	filter_trees_depth__init,
 	filter_sparse_oid__init,
+	filter_object_type__init,
 	filter_combine__init,
 };
=20
diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters=
-objects.sh
index 31457d13b9..c79ec04060 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -159,6 +159,54 @@ test_expect_success 'verify blob:limit=3D1m' '
 	test_must_be_empty observed
 '
=20
+# Test object:type=3D<type> filter.
+
+test_expect_success 'setup object-type' '
+	git init object-type &&
+	echo contents >object-type/blob &&
+	git -C object-type add blob &&
+	git -C object-type commit -m commit-message &&
+	git -C object-type tag tag -m tag-message
+'
+
+test_expect_success 'verify object:type=3D fails with invalid type' '
+	test_must_fail git -C object-type rev-list --objects --filter=3Dobject:ty=
pe=3D HEAD &&
+	test_must_fail git -C object-type rev-list --objects --filter=3Dobject:ty=
pe=3Dinvalid HEAD
+'
+
+test_expect_success 'verify object:type=3Dblob prints blob and commit' '
+	(
+		git -C object-type rev-parse HEAD &&
+		printf "%s blob\n" $(git -C object-type rev-parse HEAD:blob)
+	) >expected &&
+	git -C object-type rev-list --objects --filter=3Dobject:type=3Dblob HEAD =
>actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'verify object:type=3Dtree prints tree and commit' '
+	(
+		git -C object-type rev-parse HEAD &&
+		printf "%s \n" $(git -C object-type rev-parse HEAD^{tree})
+	) >expected &&
+	git -C object-type rev-list --objects --filter=3Dobject:type=3Dtree HEAD =
>actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'verify object:type=3Dcommit prints commit' '
+	git -C object-type rev-parse HEAD >expected &&
+	git -C object-type rev-list --objects --filter=3Dobject:type=3Dcommit HEA=
D >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'verify object:type=3Dtag prints tag' '
+	(
+		git -C object-type rev-parse HEAD &&
+		printf "%s tag\n" $(git -C object-type rev-parse tag)
+	) >expected &&
+	git -C object-type rev-list --objects --filter=3Dobject:type=3Dtag tag >a=
ctual &&
+	test_cmp expected actual
+'
+
 # Test sparse:path=3D<path> filter.
 # !!!!
 # NOTE: sparse:path filter support has been dropped for security reasons,
--=20
2.30.1


--/XGNxH5iUKQW0qjQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmA83B4ACgkQVbJhu7ck
PpSM/A//bdwZBhym91zcxNBZy5my6AjBPnAeBwF4YAQmPvFSFhU4pMOzyjT2WmY2
6lzIkyVHKCnj+Ir1wvTugw7Gz+QgCbXz7YckDOK/S70xdu0QNr5KcPjwRjt9xNEl
FVJckZvn0qwcRLMzKthStj9J8NmmsgrykoI6ELMdIsZ3JblV/1yD0gtlJhS2B10M
W/OL0oG006Z+qbXFijl/Pdv3/dIFIyknOVkfaFM4Sa8FwVFzIQk9xGe8otDBJxhk
spIlo2JEsqSBExYqCq7VNiFH4UZDgQzY0haeLRNxGtAPTLyYMOLFI55qgjEISyb1
ioPoNOcNhQRthB+5sf5k4qoHUlZh/9Noqi5P9OlFLH1Ds5vRjSZG1SWjvpCJxUEE
7DP/9EuM2sA5iQbY84Hzf/CH0Ox32Rh8XFXFiBhVYqr3NsjpvdHrdGjsQM/rIAal
H2P4Ml+BM+iRum8dt/n7kHrfpf/QyngY8ElsyzTBacKX4hhbcOk/qmOZDCSRlzgk
GsvJ98NLUlrim+mX8+uzOozWv8qt9Q7RlS2a1mq8Zz92foIsUxdGzTn5WFOX71Y9
Tqk5+VA32cH4oegLLg38YCYJ3bSuhBpSHlJoDZAh5qLz8N9vmwO9j0wMFiqFThHj
26gFKTzl1i4KpefV8P1aYrQVpLGZUKlxKPqTQ09cjW/lpzyiQMQ=
=tCOU
-----END PGP SIGNATURE-----

--/XGNxH5iUKQW0qjQ--
