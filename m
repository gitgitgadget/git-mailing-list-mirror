Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9469FC433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 13:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B2016128C
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 13:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241983AbhDLNh4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 09:37:56 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:49315 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241957AbhDLNh4 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Apr 2021 09:37:56 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id E321812AB;
        Mon, 12 Apr 2021 09:37:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 12 Apr 2021 09:37:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=ZE5wN4DRpMTdyalxf8j2MdLRigI
        zrYChMs0BTznzP68=; b=dyVzsHHqDtFnYAky7moRUgDBdrM9zxfto0PrBGMw+iC
        imMisr8LPKUHyXFNcFBBVOO7tLtY0CRwmnJyDdqNBCSDtChQOXGGa0cshz/YHC/W
        Eri4CLSxBZARfGr1TNz2Uw8krArnKg4nBfbmmTlDZMkpiW4FEhc6hyvmRNY45Sgq
        aN6hc38+7707PVlCGA5Epp2YmTlL4cYBTGflIb8wUvdzwubF/bPUCjXAK9yS3LRm
        3cbTNEuaH5kvoFArGjdmWlFDuPq3Z/ls8IuyrSdEXXEubrXzJ5wr+/AwTPWzhzLV
        t2UpOr21f6QzIQIHokpSLP20ngqmX1XBnrOzwnsXY3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=ZE5wN4
        DRpMTdyalxf8j2MdLRigIzrYChMs0BTznzP68=; b=u/CTJcbKiPq+Us8Lf0SooU
        nIoEckXr1/b5zOTfC3X6GTwMsxHfm1tN0gjT1GpoRZZphXUqN1uikQKNlAsR9VcN
        jcu63ML59SlkOdsKVS+E6P6sYp/L8bcmCXs0yLWkdfbu7C/5cD2KZKptH5GpO7Kq
        UcYFk1QDlNlHSS9s0h16a68u8yGqYCgRq28AQZ/2Ec8WgxYM6AEhBGga5PLRH+k7
        IQIhK4qAi+IvwbUjGmpIvS/QtLwAWknOYXPK2Vazq1RMUBgpFLLUeASl8wSb06b9
        ZiHbh5yRszvExVAXO6bx0KM2U8MeZpYnhB+U3ieG8j3jfYe7/j066AR6LjgMJuHA
        ==
X-ME-Sender: <xms:IU10YICafNqH523wS6-_kX2giMcDR5uojf8OqOgEOZxXaQ1Gvx3YZg>
    <xme:IU10YLSXUs4_rl7F4WzpGUN5h9oiOfsqI04T2RjHKnOUizGoV9GhEZL4J8Ve8UiZI
    Hcmv0dkDLkm7zEhbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekjedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeekrdehhedrfeehrdeftdenucevlhhushhtvghrufhiiigvpeefnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:IU10YHtulo5Yc9vWDdwJ0AGJYoMm_TpUpeXbsiRHKLzWJ5_6yQnGUg>
    <xmx:IU10YP0CvG51ehC5tyvl6tbWRPyht_-xjs_jEp5u7rAVWwaysXpHGA>
    <xmx:IU10YAWYxjZiBZeEVnlbGC-l-Uf1xtush9zEHWn-2lSaFoMBNrHC6Q>
    <xmx:IU10YG2x1KYQ2vZ9DLmkQj3Q0LOno1ZDEKmaQzGA-BXLBbzmWQ6mpg>
Received: from vm-mail.pks.im (dynamic-078-055-035-030.78.55.pool.telefonica.de [78.55.35.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id C5CC924005A;
        Mon, 12 Apr 2021 09:37:36 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id f41c2c57 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 12 Apr 2021 13:37:36 +0000 (UTC)
Date:   Mon, 12 Apr 2021 15:37:35 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v4 4/8] list-objects: support filtering by tag and commit
Message-ID: <674da0f9accf64c1d0506013cd216ba17849abc2.1618234575.git.ps@pks.im>
References: <cover.1617967252.git.ps@pks.im>
 <cover.1618234575.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wSAwg+ZaoSeYqt94"
Content-Disposition: inline
In-Reply-To: <cover.1618234575.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--wSAwg+ZaoSeYqt94
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Object filters currently only support filtering blobs or trees based on
some criteria. This commit lays the foundation to also allow filtering
of tags and commits.

No change in behaviour is expected from this commit given that there are
no filters yet for those object types.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 list-objects-filter.c | 40 ++++++++++++++++++++++++++++++++++++++++
 list-objects-filter.h |  2 ++
 list-objects.c        | 23 ++++++++++++++++++++---
 3 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/list-objects-filter.c b/list-objects-filter.c
index 39e2f15333..0ebfa52966 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -82,6 +82,16 @@ static enum list_objects_filter_result filter_blobs_none(
 	default:
 		BUG("unknown filter_situation: %d", filter_situation);
=20
+	case LOFS_TAG:
+		assert(obj->type =3D=3D OBJ_TAG);
+		/* always include all tag objects */
+		return LOFR_MARK_SEEN | LOFR_DO_SHOW;
+
+	case LOFS_COMMIT:
+		assert(obj->type =3D=3D OBJ_COMMIT);
+		/* always include all commit objects */
+		return LOFR_MARK_SEEN | LOFR_DO_SHOW;
+
 	case LOFS_BEGIN_TREE:
 		assert(obj->type =3D=3D OBJ_TREE);
 		/* always include all tree objects */
@@ -173,6 +183,16 @@ static enum list_objects_filter_result filter_trees_de=
pth(
 	default:
 		BUG("unknown filter_situation: %d", filter_situation);
=20
+	case LOFS_TAG:
+		assert(obj->type =3D=3D OBJ_TAG);
+		/* always include all tag objects */
+		return LOFR_MARK_SEEN | LOFR_DO_SHOW;
+
+	case LOFS_COMMIT:
+		assert(obj->type =3D=3D OBJ_COMMIT);
+		/* always include all commit objects */
+		return LOFR_MARK_SEEN | LOFR_DO_SHOW;
+
 	case LOFS_END_TREE:
 		assert(obj->type =3D=3D OBJ_TREE);
 		filter_data->current_depth--;
@@ -267,6 +287,16 @@ static enum list_objects_filter_result filter_blobs_li=
mit(
 	default:
 		BUG("unknown filter_situation: %d", filter_situation);
=20
+	case LOFS_TAG:
+		assert(obj->type =3D=3D OBJ_TAG);
+		/* always include all tag objects */
+		return LOFR_MARK_SEEN | LOFR_DO_SHOW;
+
+	case LOFS_COMMIT:
+		assert(obj->type =3D=3D OBJ_COMMIT);
+		/* always include all commit objects */
+		return LOFR_MARK_SEEN | LOFR_DO_SHOW;
+
 	case LOFS_BEGIN_TREE:
 		assert(obj->type =3D=3D OBJ_TREE);
 		/* always include all tree objects */
@@ -371,6 +401,16 @@ static enum list_objects_filter_result filter_sparse(
 	default:
 		BUG("unknown filter_situation: %d", filter_situation);
=20
+	case LOFS_TAG:
+		assert(obj->type =3D=3D OBJ_TAG);
+		/* always include all tag objects */
+		return LOFR_MARK_SEEN | LOFR_DO_SHOW;
+
+	case LOFS_COMMIT:
+		assert(obj->type =3D=3D OBJ_COMMIT);
+		/* always include all commit objects */
+		return LOFR_MARK_SEEN | LOFR_DO_SHOW;
+
 	case LOFS_BEGIN_TREE:
 		assert(obj->type =3D=3D OBJ_TREE);
 		dtype =3D DT_DIR;
diff --git a/list-objects-filter.h b/list-objects-filter.h
index cfd784e203..9e98814111 100644
--- a/list-objects-filter.h
+++ b/list-objects-filter.h
@@ -55,6 +55,8 @@ enum list_objects_filter_result {
 };
=20
 enum list_objects_filter_situation {
+	LOFS_COMMIT,
+	LOFS_TAG,
 	LOFS_BEGIN_TREE,
 	LOFS_END_TREE,
 	LOFS_BLOB
diff --git a/list-objects.c b/list-objects.c
index a5a60301cb..7f404677d5 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -217,8 +217,15 @@ static void process_tag(struct traversal_context *ctx,
 			struct tag *tag,
 			const char *name)
 {
-	tag->object.flags |=3D SEEN;
-	ctx->show_object(&tag->object, name, ctx->show_data);
+	enum list_objects_filter_result r;
+
+	r =3D list_objects_filter__filter_object(ctx->revs->repo, LOFS_TAG,
+					       &tag->object, NULL, NULL,
+					       ctx->filter);
+	if (r & LOFR_MARK_SEEN)
+		tag->object.flags |=3D SEEN;
+	if (r & LOFR_DO_SHOW)
+		ctx->show_object(&tag->object, name, ctx->show_data);
 }
=20
 static void mark_edge_parents_uninteresting(struct commit *commit,
@@ -368,6 +375,12 @@ static void do_traverse(struct traversal_context *ctx)
 	strbuf_init(&csp, PATH_MAX);
=20
 	while ((commit =3D get_revision(ctx->revs)) !=3D NULL) {
+		enum list_objects_filter_result r;
+
+		r =3D list_objects_filter__filter_object(ctx->revs->repo,
+				LOFS_COMMIT, &commit->object,
+				NULL, NULL, ctx->filter);
+
 		/*
 		 * an uninteresting boundary commit may not have its tree
 		 * parsed yet, but we are not going to show them anyway
@@ -382,7 +395,11 @@ static void do_traverse(struct traversal_context *ctx)
 			die(_("unable to load root tree for commit %s"),
 			      oid_to_hex(&commit->object.oid));
 		}
-		ctx->show_commit(commit, ctx->show_data);
+
+		if (r & LOFR_MARK_SEEN)
+			commit->object.flags |=3D SEEN;
+		if (r & LOFR_DO_SHOW)
+			ctx->show_commit(commit, ctx->show_data);
=20
 		if (ctx->revs->tree_blobs_in_commit_order)
 			/*
--=20
2.31.1


--wSAwg+ZaoSeYqt94
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmB0TR4ACgkQVbJhu7ck
PpTSZw//WJGVCvtnSHIXAMu64tSk5fer9siXHrLVsJBzKV1gnMeMBTHDVFahYmIX
GBUjG6IJTW2wpVHO6BcGW0H2j7CoYnI0LJ50YGg7zbxsJUjA8KK648dou765iWCd
lYYK8jD+VijlU7e89pOd8/e+zK2GjiwzVLWYFVEKSTeDvhuzocKy91g5C2qjajAm
sWZummzh/qdVDk2yq3ANESil2lZlXEmNTpuz/q/u2yK7f/HOOsUusX1WCcH2MXAm
HpCwq7KPzsxemVG2yXkoTo6SISQw8TqAS05PpToI392m+yyHFScVBecG7lIjke9X
btoNduLxx4/UQGBbx3l98JJulbZlGF0U/8tikGH6OTX+rpF7XGqJ+70dcwpGdmnu
wFkIrEYDceq53WzYLtQLTuglrNf895u2htk/EC7AwHa4AECJLCArfVhcQc6QPw/t
khlJI3kRTVfhcrrU8rxo7Yuc9BxGynemB7BblBZP9NRrX69acsHFS69/0e+bkP/f
YEa4jsbb7LKO+Wyq4nKQm1gFO/DS+lAXTR9lrQOzeMD156Y3uyvnLY2qta0qyQEW
F4yylvYG8KVU/gcQDudUYUBqqKMfiJhiKz8S58FEfm1yhI3RvAzQy+yu+RaVgG5i
7t+eksFkFWWuLSA9a8CsBaAa8Vt1oOYz5fLbQ3d7PojXf0H3Soo=
=Bf6C
-----END PGP SIGNATURE-----

--wSAwg+ZaoSeYqt94--
