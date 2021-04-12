Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C352BC433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 13:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DF376128B
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 13:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241989AbhDLNiA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 09:38:00 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:36981 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241957AbhDLNiA (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Apr 2021 09:38:00 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 4357216DD;
        Mon, 12 Apr 2021 09:37:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 12 Apr 2021 09:37:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=ukoXWfDNgrvQb0BJQeLOroSCrfV
        7T4aJta/6VjicEss=; b=CF1fluiKTbx8fTHuyyTdOIoyngW/aXFBKzjNpEOcMvU
        +Q1l36vmMa1OEwwoYgmGVPP4qk0BtjyjRESaPPTc9OYgYHqaM6ZtVC9FKsGuIv/P
        JiJgckrAOrvmqsO3rsps/MxCbzKskUzzZKOnjHHhDttfYTvVB6ZCdjg8eqbwc7bg
        p6dmZygwohCVffGIEq3ad6SxWIXQdQ952sriq7Dmk+RKY+BfDnz3fL6priG/a4ei
        y7pCaHYIUeu+23+ro+IMS1G/8YItCdBvqpVLI0r7TbJ2fwwkIzj8LUyng6UXToAo
        as176CRChiMeX7GvWEZ1vz3bRC6wryzHpb0+M5X0WYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=ukoXWf
        DNgrvQb0BJQeLOroSCrfV7T4aJta/6VjicEss=; b=nKiIB6DYRpPZydi0TQktoA
        rFg9n/vv20IAy6sfzZMqF8NEHSsILVy66vg/35cdzc6hPb/ZRqEIeO8SkgBVgk3l
        Xn7RRKKax//YRYh7qdulMcGvH0bU+css1NsxqLGb4SWkIR9ZvaCMltgfQPy+OGpl
        PnJAJdve4DWdHFZG8PeMafIeCMrnQM8rWND6jrTIb0h86AULDZ8NFkUCMSiliPYj
        aXjDL5Ceg0x0PjmAKy055MVtD7grJA0wxAnpw0yKahXYE2Vc1QhUFjS2j5YEu2JE
        lQ3Z5aMpX3CoBSKFeXxensCxAcqSPwqPbXnpQoCevbts9D1jVC0GtCpPD7eb3iwA
        ==
X-ME-Sender: <xms:JU10YC0Wccx1WEyWSrjYfHtH737IlVgEYvxJayK_ya66gNzUMpWl5g>
    <xme:JU10YL0vUqA7BuMq8hPjEwf9x1KVJjSAcrCrwsiC3YZufDSZNsZN9nIIiKJfnYGLR
    wW5whiAZv7K1-eXEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekjedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeekrdehhedrfeehrdeftdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:JU10YMoB0jTknVHcDl9JF1h6_cIADIChj7sdMvJQRoN0wM4EzUUQJw>
    <xmx:JU10YPgTXISGpGnc_1LDS_AD6bnX7ZDt_K7oPrip4FBGUFm0LywYkg>
    <xmx:JU10YA8GUpsLZ_WWzbBxEjoZfwzQpXOLRvh8oZ9BBBXmqkI4ZVAP_g>
    <xmx:JU10YOyZ3fcwI5HAf6cQ5yknvWdo-X5bjfw2n8NVc83dUSTJysY_Sw>
Received: from vm-mail.pks.im (dynamic-078-055-035-030.78.55.pool.telefonica.de [78.55.35.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id BB46924005A;
        Mon, 12 Apr 2021 09:37:40 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id aee93e16 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 12 Apr 2021 13:37:40 +0000 (UTC)
Date:   Mon, 12 Apr 2021 15:37:39 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v4 5/8] list-objects: implement object type filter
Message-ID: <d22a5fd37dd793c78b1ac17244601cadd1f7c0c9.1618234575.git.ps@pks.im>
References: <cover.1617967252.git.ps@pks.im>
 <cover.1618234575.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0Rb8elPtF/KsjjrL"
Content-Disposition: inline
In-Reply-To: <cover.1618234575.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--0Rb8elPtF/KsjjrL
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
 Documentation/config/uploadpack.txt |  6 +--
 Documentation/rev-list-options.txt  |  3 ++
 list-objects-filter-options.c       | 14 ++++++
 list-objects-filter-options.h       |  2 +
 list-objects-filter.c               | 76 +++++++++++++++++++++++++++++
 t/t6112-rev-list-filters-objects.sh | 48 ++++++++++++++++++
 6 files changed, 146 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/uploadpack.txt b/Documentation/config/upl=
oadpack.txt
index 6729a072ea..32fad5bbe8 100644
--- a/Documentation/config/uploadpack.txt
+++ b/Documentation/config/uploadpack.txt
@@ -66,9 +66,9 @@ uploadpackfilter.allow::
 uploadpackfilter.<filter>.allow::
 	Explicitly allow or ban the object filter corresponding to
 	`<filter>`, where `<filter>` may be one of: `blob:none`,
-	`blob:limit`, `tree`, `sparse:oid`, or `combine`. If using
-	combined filters, both `combine` and all of the nested filter
-	kinds must be allowed. Defaults to `uploadpackfilter.allow`.
+	`blob:limit`, `object:type`, `tree`, `sparse:oid`, or `combine`.
+	If using combined filters, both `combine` and all of the nested
+	filter kinds must be allowed. Defaults to `uploadpackfilter.allow`.
=20
 uploadpackfilter.tree.maxDepth::
 	Only allow `--filter=3Dtree:<n>` when `<n>` is no more than the value of
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
index 0ebfa52966..1c1ee3d1bb 100644
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
2.31.1


--0Rb8elPtF/KsjjrL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmB0TSIACgkQVbJhu7ck
PpRdsQ//ROycJYW4BibpSrLIZqJK5/EBqzgoh8WjjS2xA8DJF+zCJxRjuBLe+V2y
ysdVrdGhly0Hh/ePX6V9GoAL/+LI9sh7TkmpU/Ef5V30OlARqYpDQQIb6LCoEf0l
Gm/nTSWOdT3JoIWLTlS0EU0KzWrwhyC7zzfCHaZhCnKu2m7jdMkLXkZu+T782tsl
fw8kKjujFmiT3xBkV2I9nhfcRh5Of6kvM4tPN9kMxEAzzaMcmd+HfJT5f3gZpy7D
H0rwoc7ksHCmudPzUy4xHVdvv4ckb5bLAuHL/1QXAQKs4ZQlfVgpIGvTWm2ujFi/
yxQ3k6S53svH8ITetn8AIy5i3foUzNnqAy7+OUmuIuU8/X9AfZoJeuG4plYdTbFv
gDx+895FdX0ZFikUTGUKd4IPaUJujB+mzhrCbbD2cZUoPAIxe626SobCk++TGVMb
OabarvcR2BtlEIIW8pk6QsO6oWjWK3Tq4z2nz9zqSkMfFJ44WzS1S5yKwG1mvyfY
vVlsn5xFcEKrhgbzedjLQa721JGCm1bqKewjcAimZfDnUYa+g1g3wbZaputis6NG
2izZ5rPSsTxx4u+aqGho/rFyvlS/9HtttHzYmg57waf7CBplvNoWK3vSU5xPS4ZR
lPkyfBpFqbQCtoP9sb0cPAOWY5XBYkpF8pW0hIFN9ZdWdCfgJf4=
=x2cp
-----END PGP SIGNATURE-----

--0Rb8elPtF/KsjjrL--
