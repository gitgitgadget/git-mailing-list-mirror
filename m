Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A900C433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 11:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFCBE610F7
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 11:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbhDIL2X (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 07:28:23 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:45531 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233603AbhDIL2W (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 9 Apr 2021 07:28:22 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 9DE4F5C004A;
        Fri,  9 Apr 2021 07:28:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 09 Apr 2021 07:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=5ZWe+vwa0vFxasYpYbMMxErvrte
        lhGpg0TXOI5MnJZE=; b=E+qF+5kTq0R6oaWyHjvVQ7G0+2TcDyHJANUlw3/tDVI
        4LExR0D+tkmKYly8XNu+Wqj056GJMHrqvApDQhbQpwSbUsT2MrK+QkXpAR7we+Hi
        pEgOlewFLVGTMCwIgteI2pZ3BgNbMNrwBdtsiX+HLpmXVSRj9xIqakJGIOnPjiP7
        1mvrnx90egsm2jKcOTeWeZC6ftDWzf6LmJm5RDtaX+WfK17fXgQp7VodYz40x8iO
        0lIiuQn9MWX/rCJQVKo9w2LzUUUD6W6lDqJTQaQUFURjp0f1829qqCXOCMVFo9ZL
        WZMY34LjESZQDXCT/RSbHPyWN6elRg/LVV5eoNh0r1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=5ZWe+v
        wa0vFxasYpYbMMxErvrtelhGpg0TXOI5MnJZE=; b=hV73CZFc482QQ42poPZokL
        Pj/ytBFa2zpDcpjVVsYUvXd5Gf07NbzMKTjzvRKKqlH2+OzNx+0BXNMJWhhyFpKK
        qw+CycbUV0hex9HIbT/u09DqdzxblXUjIciTHy2SYoDYCXRrapEKmmX7EX9YH9h2
        ZVnDBKtDttxWgWXr+LetpWZteuomyFg4LBO++kc6A+9jsUYyUq14tzAjQCl5RBJa
        sFaslN6CA3psWzlJmmn6gpN4bKfyvRR2mJeUcp4WthxZc1FyIu7y5UF2eVA+e6Mi
        twEp9+9TqPZMv5OY90goPQHnQGMlQMS1AgmXMBAAK54OBNnU6L5XqUuyhhm5PJEg
        ==
X-ME-Sender: <xms:STpwYGpSx4xP17FXDiK-NBGMZpflt35GcXthrovMtpgL1UFrTjwkRA>
    <xme:STpwYEnUFlOndzeZJdyC4rRFIbxj11g9eON_EX3wPz_n4Fm3XyLP5sHCr_bLHxsMl
    NJqyyepmxQa8u-uRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekuddggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeejrdduledurdekrdduieelnecuvehluhhsthgvrhfuihiivgepudenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:STpwYIHu4oUlct75WTMcgcxsdJaTpL_y_ZYgQ--Ww5HpyhhIH6liWg>
    <xmx:STpwYNpffmKX97ncJkLCJUfZxpgaVrIahpMlX_DO0P3tJ-mtqFwNzA>
    <xmx:STpwYE614_HcmNsWDA0FHkXCynWmmNCgVpPRHjAM_TXvAdsZ8FShxg>
    <xmx:STpwYNXy_Pc6H8wLnGRt489F__pRfvDgAiqBpi5INPcfsni1ryPHJQ>
Received: from vm-mail.pks.im (x4dbf08a9.dyn.telefonica.de [77.191.8.169])
        by mail.messagingengine.com (Postfix) with ESMTPA id DC5BE240067;
        Fri,  9 Apr 2021 07:28:08 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id a089389a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 9 Apr 2021 11:28:08 +0000 (UTC)
Date:   Fri, 9 Apr 2021 13:28:07 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 4/8] list-objects: support filtering by tag and commit
Message-ID: <80193d6ba38254aab3dd2cda39cabf12986fd939.1617967252.git.ps@pks.im>
References: <cover.1615813673.git.ps@pks.im>
 <cover.1617967252.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZucuBepRsLXXjP3K"
Content-Disposition: inline
In-Reply-To: <cover.1617967252.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ZucuBepRsLXXjP3K
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
 list-objects.c        | 22 +++++++++++++++++++---
 3 files changed, 61 insertions(+), 3 deletions(-)

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
index a5a60301cb..0c524a81ac 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -217,8 +217,14 @@ static void process_tag(struct traversal_context *ctx,
 			struct tag *tag,
 			const char *name)
 {
-	tag->object.flags |=3D SEEN;
-	ctx->show_object(&tag->object, name, ctx->show_data);
+	enum list_objects_filter_result r;
+
+	r =3D list_objects_filter__filter_object(ctx->revs->repo, LOFS_TAG,
+					       &tag->object, "", 0, ctx->filter);
+	if (r & LOFR_MARK_SEEN)
+		tag->object.flags |=3D SEEN;
+	if (r & LOFR_DO_SHOW)
+		ctx->show_object(&tag->object, name, ctx->show_data);
 }
=20
 static void mark_edge_parents_uninteresting(struct commit *commit,
@@ -368,6 +374,12 @@ static void do_traverse(struct traversal_context *ctx)
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
@@ -382,7 +394,11 @@ static void do_traverse(struct traversal_context *ctx)
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


--ZucuBepRsLXXjP3K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmBwOkYACgkQVbJhu7ck
PpS+Vg//YS1iucv6PMdgkgD2yjssA5nHKpTTUviqejNeCDdRL67AMiTWzVscItC+
lQLjkZleWrdNRG25IxhkJvU8NL9FITkVIIeGDUBIK5i/1vEeM923APDizp00AV4m
3f12qpkKyn9PpfK9dHFCWMiGi0evD8H5idTJOJStreymfrQCXvvsj11IVPP9YJZV
6ZO2Rn5Idsqq9JTznQ8AZu3zi8CIpgb5rl3yk1Mu2O3vcL3siOTFMlgJae0DTRcQ
6gyGl6i+TFRo0dO1d+ZrLlmFv7vmLT7PC4jyA5yZtdJPfVNhywbuc2SLXD7hIn6E
3zY5/MqEQJYuHG+4Bju0Fdz9RaBKGvHn3+nLUB/JrTxND0IyfCboU8f9fua8u5+k
XiyQY/6DEeWx67I9l+82mvf77/MUK86nMq7nYacNeC9zYc/E9jzNqZrJZlicQq0h
KcotUyYsD48/2ZUELGfTRoQwPi6dwwMiD592XnTNrh23ekGVTHG4v4sF1cNmPAS6
eRflz1V7b6SpdlAz8dbe9x+03qnmPAioZUJktmekXmYeaN2ozogUSKmXkPGDZg3M
mvrvfBCLNRxpXr4p2Ket353z7N7ZgP5v1aSvdA5EQIgH/damzqR+ph7xLsNOmzcj
5/6LXLI7UfHXlRCc9CLMyEDLJCD/OuxVWVqbtyVQze0sMJ9/NXY=
=Y9L6
-----END PGP SIGNATURE-----

--ZucuBepRsLXXjP3K--
