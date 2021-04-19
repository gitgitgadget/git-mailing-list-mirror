Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79F9C433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E21D61090
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238784AbhDSLr0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 07:47:26 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:59027 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238861AbhDSLrX (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Apr 2021 07:47:23 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 16C83B01;
        Mon, 19 Apr 2021 07:46:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 19 Apr 2021 07:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=lDFhB8knGj7NUMQ1WyvQdPhHz2k
        XBXLsT+eQboid8WI=; b=cXzFBBQMQUFTe2RzvRSoHRMjEgdjd2tKZRYQA+VRNiZ
        exCjMan4rerMspceCzY3s1ue2Rejt8gzZRHQJHbz9IFzNZYMFWU/wde4ORzLTlos
        oIMHvZDxa+x5OnU3Iw38MEowRBJijfYFqSrONfNEoXOLi8f0tSI0VRPFaXuer34g
        8o1aDn4l5DH8xl8I6CH1L2JoO9mC3HEKuN7rSWmBtw+ssMXoDYDTUrRgxTQBJmFc
        Kp0dFyT1ktDKCD/99yUK3z5L5sYun+l9ZzSGXLl9BadGlwCx+ZVEDiV/ofPJ+D9x
        EeNxjfDFs2z5u7nRRBjTPoZ1eOVHELAvuE3jcLABYRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=lDFhB8
        knGj7NUMQ1WyvQdPhHz2kXBXLsT+eQboid8WI=; b=vM1owIpEBJ13du+4ugqBy6
        AOF70ohJrDp2qcY74O/8eU5NH67ZKOS1QY1kfwKfPG/LGrw4HT2DJRUPZ7lXIi9C
        dyrUTaD53IYi1sUEJarebBMhqANa3g0rDB046anxIARsF4+BoKIrwt6FX8XcXCZP
        WfPLMit1ykLsW61xkSFZBFb+4jlZUllI8g321aLUZxY6zX7H3VsN2oge6e81fj+T
        2AaXUMLx1EDEBk8zq84dRpp7BAF3mtb5Hs78n/8VYNgjfjfev2lb1D15FfhfTzvV
        8GsiuEdEcne0O6EYdfRF4n1sCCGGQ+UX37+Oz32u1z5oQvMEbbxijgNVhhgWQUFw
        ==
X-ME-Sender: <xms:rG19YAEUJGuxTUlelVt0JS7oF2KpefQ3rcZFHf4FBOrj2-OHtmV7HQ>
    <xme:rG19YJWGN5_jP1UiaRjC-BWx5YlJvA8-gAUVIG7G_Fw7UTNsPBlQxPgIHNFTvccMe
    LqNVyLVtthfIfLWdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddtgedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeejrdduledurdeikedrkedtnecuvehluhhsthgvrhfuihiivgepfeenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:rG19YKKDSuzD1JroYOzb5SDreNu6zPHUQDUHE2zLH4yycg5IRuYzlA>
    <xmx:rG19YCEEOai2CG_afhjD3bMe41Ro-gCSPtr3GJo4r5M_QqlCU5dUpQ>
    <xmx:rG19YGUsrILUs9slZjWn4p3jtu51QGEskpOQtdiq8MAtkOGavT-zAg>
    <xmx:rG19YExBqdikmKAT2TSM-L62Bx1sw9zkEsohDIwpKpGpgP36bGOeZA>
Received: from vm-mail.pks.im (x4dbf4450.dyn.telefonica.de [77.191.68.80])
        by mail.messagingengine.com (Postfix) with ESMTPA id AA35C1080063;
        Mon, 19 Apr 2021 07:46:51 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 85d40870 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 19 Apr 2021 11:46:50 +0000 (UTC)
Date:   Mon, 19 Apr 2021 13:46:49 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v5 4/8] list-objects: support filtering by tag and commit
Message-ID: <b5d6ab6b4ad9bf5bab4440977af5acb9f3e05a73.1618832437.git.ps@pks.im>
References: <cover.1618234575.git.ps@pks.im>
 <cover.1618832437.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JZfSAdS/dtdVKHgD"
Content-Disposition: inline
In-Reply-To: <cover.1618832437.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--JZfSAdS/dtdVKHgD
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


--JZfSAdS/dtdVKHgD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmB9bagACgkQVbJhu7ck
PpTb+RAAlUHzLScUZjcTufU5EyiEJ5Qkxic441ng5iCu8W6Qr2VEC0Je+7AGKJoI
0a5t2IL/WNlzQMB55pjemsTL5XS5DvN26HYHkRlkc70on/6sceDqXIo4au4tRsiP
j4uZwArrjy9/aj6W+6GbVLdKE097mM9UQ7HRCQrB61DnkYRwSjwDv2xS4LWh64pI
tI7OD5hDfOPWwodGDCV86iN7M6p538b9O/Z1cpWky3QsaH37tAtEVKMhRFCJWzUw
ctCsi7AanhdvGeawbzNLiUF/P66ahF7EM0yB14ZPwxc/aFjg4cvBXDBbV315O3da
BXMXoQpyXP4NDMN7f/ljmDZuYA38w+tScWu19scaWFco8AroToiNbJNplEUnBQKi
YhU6mC7+AEnyefY/uwzc1kWNnGStdiIoITmSFcoru3UHoZRt59Mx6FlbehBw9cSN
zAqFk5T1zzGmPjgZiyi0cM8rMzQWODDLq+b7rfmUecc+pkGU2DrWXTRYagcWxnih
jOsW6WAZISqIU6Wmq3KrJe06IM4+tIaJaiHxPIMMVoGHyi+bonYo9OgixLZij6hc
cyRgXXlME/s+zLhyJhO/G0p5x5eWa8CEtVeiv47hqm73+dnRmGjv2aWkqHu38Isp
zt4vaTchwtoAeVcaAmxwoAZlVu/MYkORfTHW+Xi2WI7dYdMWZ9w=
=fKwV
-----END PGP SIGNATURE-----

--JZfSAdS/dtdVKHgD--
