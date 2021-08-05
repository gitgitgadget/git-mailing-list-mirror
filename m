Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F75C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 11:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADDED61102
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 11:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241010AbhHELZ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 07:25:58 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:41861 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241003AbhHELZ6 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 5 Aug 2021 07:25:58 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 25AC95C0057;
        Thu,  5 Aug 2021 07:25:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 05 Aug 2021 07:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=m1wieKDI9SUKAVqVuZgCY//laQW
        8dsM1fv4J2VSA/UY=; b=U1FO/1VyesJ+LrdQ1Btuaf+ETQPJf6kPXvDND7C5W1v
        oFalaSmazrv3VWElYHiT0rEaC4uFaHRMoJUU7zHTIfBNi7bHENDx56JU5VTPwkvd
        SEv8u/RaIAoFNNHxyF3uCxDzfcVE8GM9QQ2Iafr+MNfFbMbd0SRVjqPypx04L7bE
        HPBhNI5oRz0xbxdI/Nh8vdmdDnlociAmBo/NwoKyS/Hw46L9JbSgQAOw2S+rC32D
        K7puzSKfibneowDFc73emsWLQ096dbhhB209l7mW7ELay1q3c7Qiaoypqp9otjib
        griCPRNBVJnlX2aFZf1X2IxcEGUyiwkolqGdiXeeDLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=m1wieK
        DI9SUKAVqVuZgCY//laQW8dsM1fv4J2VSA/UY=; b=kMDXNsWXsg1hEuKLEcnRCh
        RQ33PjsLvOMOqkGCxdRojTaXmVruyR8mszoVfmOl491yCNaAA+gMsBkkD8hwRTZ1
        G4vIHQxG0el32CNu1qITdsFYqzC6q38wgBmQLDP9wVvIOesZ+T4DS6WIWI6L81U/
        0Zoap2XDl+5a+vopSTHLKMB0586/cr3yNPNEJyWrVa/UNs1WiC8TqxiLUrmJxDxA
        +wKN4PbuZuZhvBSL6NndJ4k2/99pmmZN6jCiOQCzMKqyBi8kjajUZ3FPLAbqj3yV
        /dU1E9JHH2ZVJ7JnHoid342eKGGHo6nTAgk+Iz+Un63wWPsZ62pGJwELpfOl8GFw
        ==
X-ME-Sender: <xms:t8oLYRlt82kWHQZIAO6j3s-V3tgXOojQnMsUKX2Wys_E2gcal148-w>
    <xme:t8oLYc0FrFmz73IJ5FqgXDKtU_gagWVQKOZCzVpG9H2M7ACqgom6_urQHV7f9Jr3s
    hlR-h48EupisRB9Xw>
X-ME-Received: <xmr:t8oLYXr-0NHmg7w6MHYE6HDcGR0KgZw_MsM4akCugj54u4qZgo73k3Uq_iKGSNvQQE_HOKBYmI4tXIsptO1_XShUAAl_k86BVSbwZu9_Z-trxmLQkKCwMHo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieelgdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:t8oLYRli-cPJnbc2ec1zL3h-vkd229625BMFZTmIVeao7PgbakwWZg>
    <xmx:t8oLYf3-oNiBo8GNPXkQTyAIMihgCYvtv7hc5lmW1JPs1kRP68sbJg>
    <xmx:t8oLYQt8xtk3or8qgcoRqX0BLTiUEZwJTBPamnJ_JFMzR2ztw9xJuw>
    <xmx:uMoLYZpKakhMnNUfz4dmXVRQschHJs9omGCT4T2fSCw_bTO7BEWzxA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Aug 2021 07:25:42 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 9bf19aa9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 5 Aug 2021 11:25:42 +0000 (UTC)
Date:   Thu, 5 Aug 2021 13:25:41 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v4 5/6] commit-graph: split out function to search commit
 position
Message-ID: <e33cd51ebf9751a156198ff489304c897923b64c.1628162156.git.ps@pks.im>
References: <cover.1624858240.git.ps@pks.im>
 <cover.1628162156.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9cuZXpie3t8T+fYL"
Content-Disposition: inline
In-Reply-To: <cover.1628162156.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--9cuZXpie3t8T+fYL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The function `find_commit_in_graph()` assumes that the caller has passed
an object which was already determined to be a commit given that it will
access the commit's graph position, which is stored in a commit slab. In
a subsequent patch, we want to search for an object ID though without
knowing whether it is a commit or not, which is not currently possible.

Split out the logic to search the commit graph for a given object ID to
prepare for this change. This commit also renames the function to
`find_commit_pos_in_graph()`, which more accurately reflects what this
function does. Furthermore, in order to allow for the searched object ID
to be const, we need to adjust `bsearch_graph()`'s signature to accept a
constant object ID as input, too.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit-graph.c | 55 +++++++++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 25 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 3860a0d847..8c4c7262c8 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -723,7 +723,7 @@ void close_commit_graph(struct raw_object_store *o)
 	o->commit_graph =3D NULL;
 }
=20
-static int bsearch_graph(struct commit_graph *g, struct object_id *oid, ui=
nt32_t *pos)
+static int bsearch_graph(struct commit_graph *g, const struct object_id *o=
id, uint32_t *pos)
 {
 	return bsearch_hash(oid->hash, g->chunk_oid_fanout,
 			    g->chunk_oid_lookup, g->hash_len, pos);
@@ -864,25 +864,30 @@ static int fill_commit_in_graph(struct repository *r,
 	return 1;
 }
=20
-static int find_commit_in_graph(struct commit *item, struct commit_graph *=
g, uint32_t *pos)
+static int search_commit_pos_in_graph(const struct object_id *id, struct c=
ommit_graph *g, uint32_t *pos)
+{
+	struct commit_graph *cur_g =3D g;
+	uint32_t lex_index;
+
+	while (cur_g && !bsearch_graph(cur_g, id, &lex_index))
+		cur_g =3D cur_g->base_graph;
+
+	if (cur_g) {
+		*pos =3D lex_index + cur_g->num_commits_in_base;
+		return 1;
+	}
+
+	return 0;
+}
+
+static int find_commit_pos_in_graph(struct commit *item, struct commit_gra=
ph *g, uint32_t *pos)
 {
 	uint32_t graph_pos =3D commit_graph_position(item);
 	if (graph_pos !=3D COMMIT_NOT_FROM_GRAPH) {
 		*pos =3D graph_pos;
 		return 1;
 	} else {
-		struct commit_graph *cur_g =3D g;
-		uint32_t lex_index;
-
-		while (cur_g && !bsearch_graph(cur_g, &(item->object.oid), &lex_index))
-			cur_g =3D cur_g->base_graph;
-
-		if (cur_g) {
-			*pos =3D lex_index + cur_g->num_commits_in_base;
-			return 1;
-		}
-
-		return 0;
+		return search_commit_pos_in_graph(&item->object.oid, g, pos);
 	}
 }
=20
@@ -895,7 +900,7 @@ static int parse_commit_in_graph_one(struct repository =
*r,
 	if (item->object.parsed)
 		return 1;
=20
-	if (find_commit_in_graph(item, g, &pos))
+	if (find_commit_pos_in_graph(item, g, &pos))
 		return fill_commit_in_graph(r, item, g, pos);
=20
 	return 0;
@@ -921,7 +926,7 @@ void load_commit_graph_info(struct repository *r, struc=
t commit *item)
 	uint32_t pos;
 	if (!prepare_commit_graph(r))
 		return;
-	if (find_commit_in_graph(item, r->objects->commit_graph, &pos))
+	if (find_commit_pos_in_graph(item, r->objects->commit_graph, &pos))
 		fill_commit_graph_info(item, r->objects->commit_graph, pos);
 }
=20
@@ -1091,9 +1096,9 @@ static int write_graph_chunk_data(struct hashfile *f,
 				edge_value +=3D ctx->new_num_commits_in_base;
 			else if (ctx->new_base_graph) {
 				uint32_t pos;
-				if (find_commit_in_graph(parent->item,
-							 ctx->new_base_graph,
-							 &pos))
+				if (find_commit_pos_in_graph(parent->item,
+							     ctx->new_base_graph,
+							     &pos))
 					edge_value =3D pos;
 			}
=20
@@ -1122,9 +1127,9 @@ static int write_graph_chunk_data(struct hashfile *f,
 				edge_value +=3D ctx->new_num_commits_in_base;
 			else if (ctx->new_base_graph) {
 				uint32_t pos;
-				if (find_commit_in_graph(parent->item,
-							 ctx->new_base_graph,
-							 &pos))
+				if (find_commit_pos_in_graph(parent->item,
+							     ctx->new_base_graph,
+							     &pos))
 					edge_value =3D pos;
 			}
=20
@@ -1235,9 +1240,9 @@ static int write_graph_chunk_extra_edges(struct hashf=
ile *f,
 				edge_value +=3D ctx->new_num_commits_in_base;
 			else if (ctx->new_base_graph) {
 				uint32_t pos;
-				if (find_commit_in_graph(parent->item,
-							 ctx->new_base_graph,
-							 &pos))
+				if (find_commit_pos_in_graph(parent->item,
+							     ctx->new_base_graph,
+							     &pos))
 					edge_value =3D pos;
 			}
=20
--=20
2.32.0


--9cuZXpie3t8T+fYL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmELyrQACgkQVbJhu7ck
PpSXLRAAqSuRcpDwYd1FrBLpc/neulBnhzApxXFPEGPBtWB5iuh5cN8jv96b++yz
rgSO7jOt0kSHJz2e5y6If2//yRdDGUFirgEV6H4rRynLOUtTEXaLvnJJlGZ0pn7A
2HZIG8dfl4/1aAGseppGHFbJjRwkEl67S3RCA5XEN6n4Mrf9tacqUO3BvK/NSozg
B0B2Y/o5kQja6w8bCgtAFoVaJZxhAbGUWvNlCTRR0xMbz5jHhm8hCkBS0E2C3bxN
81niqmFkNKsvPI8r5HoJlsc171ZxtnUbPaNDtYyQNOku252qo5CHcfE26iJlDEqi
m6mh+jdb4WKpv2NFojkZSzDQ9TJl4u3v/aZPvHkCdNJwu15Xn/k17YcXrYZauobt
jgKtzTNmbB7ZzlQo0TkbA3Vn1WIq+iCe3mM3Li/jVmIpoOMVEVwNQ/gP62LOjoDQ
yxXbGocGF8u5vFT7Bu2if7FrXCKFVu62AkqtCcfMpjev5DlMUZGlMC2pjZ2XFQ5U
6EelZ6SRjShwtha1GoVoSgzyPUeFtc6VzZj/474EELK9dnE8M1OmMa4ZZLAO1+uP
m7TbyFcNLs3HgSpuuO6PTQ1u3jfDgXS9Yu940WPlLbGaeHen86daoz+Yb7RzUS56
W7PzFheCpH2X+aV/PvgAq48gOpgAffEc4Ka5Bt10QUx0Dc0nwuY=
=8h2a
-----END PGP SIGNATURE-----

--9cuZXpie3t8T+fYL--
