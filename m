Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED33DC433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF0EB6108B
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238893AbhDSLri (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 07:47:38 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:34057 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238853AbhDSLr1 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Apr 2021 07:47:27 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 3863DB06;
        Mon, 19 Apr 2021 07:46:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 19 Apr 2021 07:46:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=R266wXLwAjRjLm20wd/Q33iCQA0
        eNuZQRbNZzhoZCdk=; b=xuU9A4nHCc4kCKIJNGewEVy3f69/rZBVv4LJdY7sqzA
        Hkrogvhc6/Nw3yYpm5+dR7wOD3CnaNtjRzFtUgDgeQLuvhqg4F+beSsgbpubE9m4
        0xRi61xzehvDF+Sv/66gkQwDgZ7c1sDxFVnulB30TydbAxHTwQ/xvOzFJmjcuI59
        CnhPdW4ouosBcuoemPC23Af1/lHqyHOauTFFPPDCxb/cGu4OkGzabhVi7ElbuBYZ
        IjW9O9/Hacau1ZGnVi1rpM1spihJKBM0hKoFGOUIZFNmusHtAImDdIE+2ntWA2Xh
        Mu6M2zWwB7sJkF5RkjerJVYcAkHHW1Uh33swsStq5bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=R266wX
        LwAjRjLm20wd/Q33iCQA0eNuZQRbNZzhoZCdk=; b=sk+Rf68ip5jIc3vJC4cTWg
        IpFmawcNabISvksXMg+nFzTIEsfoB/WUi17/V6EudgHGE+IV9DIdNF2GLz8BZQd0
        0JBZE89tgC6OH/SHqD2oUfhw2oq8/cvUg1UBOIDUTHAo5ZRmDKJAVW6Fc97b810B
        9ruJlRbUAa48EDu87arzInYbW1zb5VAGtX191MGoztjI4IbL42fyK6HHhQ9muVHr
        d6KDR9Xf/5KMKbY5JJvUdAgHKlWcP2+aq2qX77jvr4vXcfb3INgAMEN9Tx4R9nLH
        98WH/lLPgvqLKUvWdE175KDrKk3s6vblqCpL07nRmAFpZaFInefDyEzS1EW1l0+w
        ==
X-ME-Sender: <xms:sG19YDybAOldoYvIeROnPUORdC4XJ0qf2U0b7fZfzZT6xaFG-w_mrg>
    <xme:sG19YLQcACxv9e4bOwA5znXAIlWFp8FhVkMRbN2iDUCiyYvS2lcqnr4VzzF5lbRVx
    VB4RT11Ovdz6m_MGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddtgedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeejrdduledurdeikedrkedtnecuvehluhhsthgvrhfuihiivgepgeenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:sG19YNVIJlskI6pMuiaO0hpk-3FPqVJSyCCUb6icOnip5yJyzLp3-g>
    <xmx:sG19YNjM-1O1N_YlvbfIgKeLCUvQjeQvPwcFXBQRkDF3vEgQipBzhA>
    <xmx:sG19YFAMpF-zu_d2NCRW6FtFptBfmkBJ4_JVWESAWJ_lE3q2JS0NgA>
    <xmx:sG19YA9wG-yMMbkPH6TunGtjLGI7hcQOMnAXPxeVFf_B6K4hvKSxvw>
Received: from vm-mail.pks.im (x4dbf4450.dyn.telefonica.de [77.191.68.80])
        by mail.messagingengine.com (Postfix) with ESMTPA id C7D731080064;
        Mon, 19 Apr 2021 07:46:55 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id dd629e51 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 19 Apr 2021 11:46:55 +0000 (UTC)
Date:   Mon, 19 Apr 2021 13:46:53 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v5 5/8] list-objects: implement object type filter
Message-ID: <f462745290b4c8afe34a199aea07965092d156be.1618832437.git.ps@pks.im>
References: <cover.1618234575.git.ps@pks.im>
 <cover.1618832437.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yH6RtBx3Sj7lxeOd"
Content-Disposition: inline
In-Reply-To: <cover.1618832437.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--yH6RtBx3Sj7lxeOd
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
 list-objects-filter-options.c       | 15 ++++++
 list-objects-filter-options.h       |  3 ++
 list-objects-filter.c               | 76 +++++++++++++++++++++++++++++
 t/t6112-rev-list-filters-objects.sh | 44 +++++++++++++++++
 6 files changed, 144 insertions(+), 3 deletions(-)

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
index d2d1c81caf..96a605c8ad 100644
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
@@ -97,6 +99,19 @@ static int gently_parse_list_objects_filter(
 		}
 		return 1;
=20
+	} else if (skip_prefix(arg, "object:type=3D", &v0)) {
+		int type =3D type_from_string_gently(v0, strlen(v0), 1);
+		if (type < 0) {
+			strbuf_addf(errbuf, _("'%s' for 'object:type=3D<type>' is"
+					      "not a valid object type"), v0);
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
index 01767c3c96..da5b6737e2 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -1,6 +1,7 @@
 #ifndef LIST_OBJECTS_FILTER_OPTIONS_H
 #define LIST_OBJECTS_FILTER_OPTIONS_H
=20
+#include "cache.h"
 #include "parse-options.h"
 #include "string-list.h"
=20
@@ -13,6 +14,7 @@ enum list_objects_filter_choice {
 	LOFC_BLOB_LIMIT,
 	LOFC_TREE_DEPTH,
 	LOFC_SPARSE_OID,
+	LOFC_OBJECT_TYPE,
 	LOFC_COMBINE,
 	LOFC__COUNT /* must be last */
 };
@@ -54,6 +56,7 @@ struct list_objects_filter_options {
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
index 31457d13b9..c810a62807 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -159,6 +159,50 @@ test_expect_success 'verify blob:limit=3D1m' '
 	test_must_be_empty observed
 '
=20
+# Test object:type=3D<type> filter.
+
+test_expect_success 'setup object-type' '
+	test_create_repo object-type &&
+	test_commit --no-tag -C object-type message blob &&
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
+	git -C object-type rev-parse HEAD >expected &&
+	printf "%s blob\n" $(git -C object-type rev-parse HEAD:blob) >>expected &&
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


--yH6RtBx3Sj7lxeOd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmB9ba0ACgkQVbJhu7ck
PpSelRAApRDjoAXYwFSftmtqUfhy7TJF594nyo17wCtagZBTjdLRvJObUfxZOye3
jUH1VwEl2nVBUyTA1BswNs9dJh+XdGR8xc8uTKL+WJMzftEJXIsb8QZ85c/luB1u
mSRZ6rcCDeeaD0YLU3ZG+7rX55b7NQW3EkREFK95xYEFLSkzu5aHZ+sWPxS02aV7
2BJuO9TtOC9nv/Sv014lJgLsIrXwIL7bzd69YaAukBltPemtL79xvu3lhGQbFrq8
Hi6LNNRVwCQTie9o/qMlr8JDzdSdDBbPL1zJTWfUwoQINKWeU4y3lWpggLKgHC9W
0wJ5eF/QqD8tOAu/1HPjp4WUR98FPWYRSm33sYD2vi6X2zXFM7HUD1ZAVvz4V+vj
481hsDiFS/AcTv5G/wHR/ob2U8hKeQglB2co1WJYCa+NzidPfU4n7ShzS8vcPQK2
8QpM9iq1+H/mJuFKnNZzCU0QGRmQU2JikHrom61dPfvqX2PABQgihA6mZwb9jhYg
xciA9OvxxoZfEI3uMa0cO2RXiXqqypnK0i4j85W09SyO1gdQMQ6otpK3ubS7bUM3
U/EkWwGrI9HYw/dTXkGpUHS25/0ObbQp4yhWcPQCcyjgr9ocMbu69QYxcXkxSmfi
YXX/Q0bu8KWqYDMzrhSgvv6DzEXiGbnQDppZBPA+jbybZ0sfj6Q=
=aMb/
-----END PGP SIGNATURE-----

--yH6RtBx3Sj7lxeOd--
