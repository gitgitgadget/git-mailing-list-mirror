Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E9EC4332E
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 13:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3F2364EEB
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 13:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhCONO5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 09:14:57 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:37161 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229746AbhCONOs (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Mar 2021 09:14:48 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 68AB15C0099;
        Mon, 15 Mar 2021 09:14:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 15 Mar 2021 09:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=KGl2MQyrZ179/4MwwiHddwZ3eDl
        k4JtYeNlXls/gb7w=; b=il4c0AviapILfMyACW2QJ2eoEU7dsHIfRRzFYPk1UCJ
        LyrieOSoSD7daH5jVaFe92c9NyvAathgxT7j+MyYoxM3J9Abi5ndhtcB6d+KIUIx
        HwG50trAf2jMpNUtMsxzD2MLUWWr1YGtVQhaRzYcNhgRLXOgnPlKjnToZkPUvjk8
        EtxHIr0MmMEh5fJvxsL5x8kjH5z6N9aUMIFaWH2C7uCcbJF3YdCc88CqlGOV2rOE
        TooIOk1mSLOAgyTOOXNAO3837qG2VtJMKgsuuDWDijRLEvZNnYTZQNCDkWWhnhR0
        ZBSCyey8B4qTcxbxOHSv6hxcjZ5iZpz5VHfzV5PQ1ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=KGl2MQ
        yrZ179/4MwwiHddwZ3eDlk4JtYeNlXls/gb7w=; b=nSXFhSJ9jJ0KX6PzJ+XL81
        Ri7XPaeyV6O0aGOIy3SySlZ7echVoxUZLKdvYKwXlNTKTyaaEP2XHbnJaPojllue
        ekZHfXhUYTJULxBwvK5RU7TQV6nFPvMSq+e4MEtRXDDY2dHFOlA7w0gpBQ+SplZk
        6Wh3Df80HUemBXTsa3YIXyqxX2lTfmYI7f4q9zgHJCccqlP4HiwbjlgxD7R/tivc
        TOVgwUeoKivKpdJpSW0U/Kf1AKoanstjd1CSyHaFJL0J3tvt1/WojkSHh8kE7S+I
        hw9NdBlme71DKvIQbp3iidLogROMCfef37sUAgtRaqhVuyKr/4Hahn1TtaHS0lVg
        ==
X-ME-Sender: <xms:yF1PYG4u6yHoUtBNdlTLtH9cz_llsio2HCqipAezgpceqZ87K9g79g>
    <xme:yF1PYHWQE6B01BPx1OQaerMJ91guTWkaziUO34COmbXVCItcxhihPK6PT-WNRsqoG
    o0qbdLGPeg7fHVIqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddvledggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepkeelrddugedrleeirddvgedunecuvehluhhsthgvrhfuihiivgepgeenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:yF1PYC2od5IhUYPm7uxjajevD4WEfhCWbwqY8rxpsH_T4vMzTBBWXg>
    <xmx:yF1PYM2MUdbGOE9TYO3ioSHmq8sYp0henkHeI7s3p4YDY62im296Pw>
    <xmx:yF1PYN-cloKniNO89B2rOLeP55vSdZAAq8FWmXRnuAO2Z2bKgasyVw>
    <xmx:yF1PYE8M0MvQT8E93sV3ExgE4Q90Rh38eK1lEH1P5MA0awfGZksrMw>
Received: from vm-mail.pks.im (dynamic-089-014-096-241.89.14.pool.telefonica.de [89.14.96.241])
        by mail.messagingengine.com (Postfix) with ESMTPA id B4E921080066;
        Mon, 15 Mar 2021 09:14:47 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 782db972 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 15 Mar 2021 13:14:47 +0000 (UTC)
Date:   Mon, 15 Mar 2021 14:14:45 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 4/8] list-objects: support filtering by tag and commit
Message-ID: <5545c189c56cb44d0621fb24a531420c29de55d0.1615813673.git.ps@pks.im>
References: <cover.1614600555.git.ps@pks.im>
 <cover.1615813673.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YzLfVvcDHiXxAQVI"
Content-Disposition: inline
In-Reply-To: <cover.1615813673.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--YzLfVvcDHiXxAQVI
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
 list-objects.c        | 24 +++++++++++++++++++++---
 3 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/list-objects-filter.c b/list-objects-filter.c
index 4ec0041cfb..7def039435 100644
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
index 093adf85b1..3b63dfd4f2 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -218,8 +218,16 @@ static void process_tag(struct traversal_context *ctx,
 			struct strbuf *base,
 			const char *name)
 {
-	tag->object.flags |=3D SEEN;
-	ctx->show_object(&tag->object, name, ctx->show_data);
+	enum list_objects_filter_result r;
+
+	r =3D list_objects_filter__filter_object(ctx->revs->repo, LOFS_TAG,
+					       &tag->object, base->buf,
+					       &base->buf[base->len],
+					       ctx->filter);
+	if (r & LOFR_MARK_SEEN)
+		tag->object.flags |=3D SEEN;
+	if (r & LOFR_DO_SHOW)
+		ctx->show_object(&tag->object, name, ctx->show_data);
 }
=20
 static void mark_edge_parents_uninteresting(struct commit *commit,
@@ -369,6 +377,12 @@ static void do_traverse(struct traversal_context *ctx)
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
@@ -383,7 +397,11 @@ static void do_traverse(struct traversal_context *ctx)
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
2.30.2


--YzLfVvcDHiXxAQVI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmBPXcUACgkQVbJhu7ck
PpQZJw/5AcxUAGM4xr44TcRAPFRB/qsH87anqAAG6WrybygxI0THW8eAAgOL3m9C
YRAZrVrAQVBAYxSHehTO0pWTRtfxA+JISOFPUReGhUtIKGVLqYPnKIUy0kiYDb6X
hfSkIZFss9/U7VTynOKpvLTwNWLI0dD6kfJoA0ESSg8VtdVATfnrB1yVaIalQNSF
ASmtwrwQMrsFffvavj70pwxjAQoElnPXV5/z3Oy4SpiPVo74y9NLslailtveg2yy
i7wcv2CCPPQ6es12N0LclXY2wR6s293mZjovZtU7E93iGDSrAZQZvh0vmdPXWQHI
2/saGphBNLD1htSFeH+Wx6uihxX197c7fSbQY9rzF8XtFmgtPdjDJrV2NDe9tRzv
rg5cSwHKBt5zrnfCZ6IsGMGpqKive0jZFttrFMF4iKeauJB21dUbW8vMM5qqphrk
plGQRsGuc4rvmRZdF6XlqHa9Dv3Wr7YvsiD6BG0q1LFWSSwUIqk2Ga1ty8yScFoV
V8eH+Z5nVtpT7plCAwWsvOc2dEik4uD7q7GQvBy/JWZNjoJbqNlhvBFeJhizq63V
Lal+z7MOt2qz8kD8QvEgN4Rw8O3DIKACRKoFOKgznPT43+C19VIiQaWzsOW010Ee
sHzihGlmKYV7sPih9yurZi81UHbHDIuu5b2ExAWtfsH/EqnUX7Y=
=5HBn
-----END PGP SIGNATURE-----

--YzLfVvcDHiXxAQVI--
