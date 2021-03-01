Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F58C433E0
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 12:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B37C764D90
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 12:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbhCAMVe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 07:21:34 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:53279 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233936AbhCAMVd (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 1 Mar 2021 07:21:33 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 184E39F3;
        Mon,  1 Mar 2021 07:20:47 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 01 Mar 2021 07:20:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=DteBqglyH656CRYM6OxjEOoLal2
        XkoZqJrGdaKfGaqs=; b=DWQPle+KikdO5Usk+fDDBGqyAsLGvEXqK0uIry0HeKT
        oKIwgeEy20Gqa8GsqQ8CmwzHrrRJMol2sBOqc4Bu95NASCa4bsrnUPSzf73DVwFz
        fWJicXFzjhUHYS50PnyFkIwzBFEKisS5nSES+fRIYk3Bj3lixImJkRWuIJzNXb0c
        smBcRXW1C7/oUhC4n3acrAbb0YGgDx76QX1vfB6ZYUAOq6a8gB1f0ihCJrDH895s
        EYSY1fnjIXmJxiOdW9yOAMSIaJTnsXhtcHIl8MqQeQGXfXo6oQInhD88HFBSpe7u
        Ue1OgmysIZLp1aGjTrOc2rHztWP0aVdAvogfKsOx92A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=DteBqg
        lyH656CRYM6OxjEOoLal2XkoZqJrGdaKfGaqs=; b=MfGfGE9FXZqBJvu6ncbjHD
        VKcknPSv90DllG6XvlM5kmuM5p21VZLjOt68S12jh3a59Gh+XfjZPCeREf6mEh7N
        obfmXo9US0EYxhDgi7x7kP3MfQXdUSjbdTsvFeKoU31KYlvkEv7MJKXGGsrdFvfN
        ODSlxx4q1M2EkP7lbDmJqnpZXU3X/op/8KIj/eS94E/Y21KqOWjaCn4ZIp62/NYv
        IGlI1TviB0O3a2BhXlkQmxKz7RPXOGh6X5vHDLVOiqw3iIuk3qwmgoCKy26RQl2y
        RylI7uYVvNzP16bWKRwnwD8Pwrb6ftF6ziHjE8sIovpLN3FFettWosnsS1i57Wsg
        ==
X-ME-Sender: <xms:Htw8YGZ1jBJQFFQUF0_jcIJ4325CQ7bUv157zSCevk9AyOfAGPYxYQ>
    <xme:Htw8YNqVdGYLlVKoi7Mr7bAidjQrF1vYGmP0h9YHSKuyZt3dUmOh1fLZBiL0HXkRi
    iiGHTpWZjruMbOQnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrleekgdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    kfhppeejjedrudeluddrvdejrddufedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Htw8YL-W6FCNbIuOcIiHs1bF7vnf325msrdzcn9hKk6ZkestPYmzMA>
    <xmx:Htw8YM_SihNfT07lZBB3oPKw3M3gnMyywxvITNm_4jLzSlqkAQOnOg>
    <xmx:Htw8YKtb6bwqgI3-WKWRpwvCX9OHdxuwL5qiZ-Pdn0S4TFYw-136Pg>
    <xmx:Htw8YMf3_yVwa3hmBM9i9MLetitWsJPgv7y73jvZU8n2Jm6D_K8hWQ>
Received: from vm-mail.pks.im (x4dbf1b84.dyn.telefonica.de [77.191.27.132])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1226E24005C;
        Mon,  1 Mar 2021 07:20:45 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 0238c8cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 1 Mar 2021 12:20:45 +0000 (UTC)
Date:   Mon, 1 Mar 2021 13:20:42 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 3/7] list-objects: support filtering by tag and commit
Message-ID: <4aa13ee83fa81ef5cfe6da5810202400493a3008.1614600555.git.ps@pks.im>
References: <cover.1614600555.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KeYnpxFKeP+Vn1N9"
Content-Disposition: inline
In-Reply-To: <cover.1614600555.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--KeYnpxFKeP+Vn1N9
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
2.30.1


--KeYnpxFKeP+Vn1N9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmA83BkACgkQVbJhu7ck
PpQ9bBAArQJiN/H4RK1B0S34IP03fIX5RXc9uiFOwRD6R01FiNQNwjYmP2ZHv8nd
n4/U5ne/+iky515Gy1GCYxFI3RMiogYuxsKtrqVeqo/GaBLMrnvoZ6OJG7CPGk9F
3b6cPQRvtBuq7KUndSOBEg2Z04McX6VTnieqahjhz99njZLlSeZaLT34Avd86R7J
oIgDGK4vk4svucDSsswjkjb/F6fQEL4d39zD9vtp+X9Rzqiuw6llnbtRf5HnnAQC
hg3HfxgIxc1m/SabFAP0Fsqx+3UF13JjcihdpNC/BgYZC27FklHG4ZBxVclC4Dku
BR4Q4tXc5wSXd1fzxImHMW1EzAOx7wpM+q8rJcJhL4sLBUlShDIrM0urtd3gT5mC
GnG6BtGMNFbV7ZLYcRjSslHomeqxUKFEu8nbliSZ8AiO4HuMUEl5NAteOHV+qQAK
CtDsrKVvg1A0jFuHxoQhlVKUXPlzHOvsrx53gwxmE+tgNVcYOYIbBtaicl0z0Kjj
PDdIDd3j07irI199NnHRh6UTp5j/E9kb+1aLuEP36fLcL10h0Wtd+hYW317Vc+Vg
4cFgkAyO4ZeX35/HNK19O2lHJ+5GgB8Z6EPyXZGFsCMewH7tgqMgLER9cgGkNW93
l0pRqhdkjdYVKv6vsjCMhgvoSvBY7NMmYjzdH3MxcbBHk0MN7nY=
=vJ+T
-----END PGP SIGNATURE-----

--KeYnpxFKeP+Vn1N9--
