Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D60C4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 08:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29EEC61078
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 08:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbhHIIMY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 04:12:24 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:35813 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233838AbhHIIMW (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 9 Aug 2021 04:12:22 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 181595C010F;
        Mon,  9 Aug 2021 04:12:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 09 Aug 2021 04:12:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=GNeRGe6ucx+wG46QTC9nNs3OuB3
        eL34X/wneoBHxN9w=; b=UzpfSnOWz/+Yxb98gdigfNUkDFSLUg376jozAKo3CbG
        tlsao0eqDQakifljEzGqQjPc1wkS7R0Cl6Djk6MdvgSQMQER2S0cEOaVCyEf3tIG
        2PqfUH/d642ECw1WtSONcueW2Pw6qOAHiUHRfcZqcITygLXf2ERxKqNTHrkEASHv
        ispTq7Tg82IZUtS+ZXToue0Nk0Wd3cDHX4b5HasNFotHdbkLHkBkvdJgMCDysC5B
        IHdfnfu89hIlZOkYFzg97slkoZ8yu7rAKZFGcnMxxYB8Y19FCVcZ7V074djyBrq0
        wdmSnP9uqc5k+4iW1ud8/h+3ghnAVXDDfulyLGk492w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=GNeRGe
        6ucx+wG46QTC9nNs3OuB3eL34X/wneoBHxN9w=; b=BjRg6eNwME9MZjreEP5FJX
        bXGeML9v+Ho952E3cC486QYBPsE1vvzaVLFAmNYmxLuUDwTJb2VZA89fveSpFg0B
        qBdU0kzknCUjNbQ8o/r8lRtZMRvnwqBiRwh7LK3VqSlXC5UWIYsY2WoMDYJl4EQL
        LS/4s3LkiRp/3+09UoX9STyGieHl7OxUD6hrAf12ZrUBiYtZa8ftwaa5d001oMkM
        8NqnoLYEeZrXZvTC1mkgjPPUlRC2OYM0iIOGYdTiSbDDHVUouKh2Lr+nv9bnSIjF
        ao7yH/qsFEFTUyvXUhqvp1Dc0mPn8+mKjTG/EagsPF99rqV0SAfoWVX2Rt6Ij5QQ
        ==
X-ME-Sender: <xms:UeMQYSVZC3QuA6bzkay1y7TC2nR6Mr2G-UL3aHGlh9hxoBx7qbfbtA>
    <xme:UeMQYelO_iaiRaPm73oSsalzT1leUQNt6EARjulj9hU6K7Ie5U66ZDzoaCjt7Jcwo
    4qP_RvFvolZj7QEDw>
X-ME-Received: <xmr:UeMQYWZHWdn4OolC5aEhxrpOsAt9DDzglt-VQ_s1jk-o9X5puS-1dPdlyPlLaDfJVw04uDmX5s69ttKa-0P__2wP0qKwE469LXAJ7kGvCnV3w8JHnSVnqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjeejgddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:UuMQYZV2FEzi_UbitAMFbT_Rg5zxKR61j09PwQby9yadM81JMk2IQg>
    <xmx:UuMQYckf4Io1L4XeayQbUr-KPBHBy80ZgbuQipia3d94vJK8Lx1Rzg>
    <xmx:UuMQYee6Lppk_P6Qp28LTOtBnwj-QnsPOfVEy8SuU2CaZGYP4H5QIg>
    <xmx:UuMQYaZRxX12eVgq2VslZf38FwWtJyMaQU-9Aeeiwp45Gwqg81LXLQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Aug 2021 04:12:00 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 706df5ea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 9 Aug 2021 08:12:00 +0000 (UTC)
Date:   Mon, 9 Aug 2021 10:11:59 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v5 4/5] commit-graph: split out function to search commit
 position
Message-ID: <bc89325fdf170bde142745a10602207c0952d22a.1628496539.git.ps@pks.im>
References: <cover.1624858240.git.ps@pks.im>
 <cover.1628496538.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LRCUl7B3ZYD5tVzP"
Content-Disposition: inline
In-Reply-To: <cover.1628496538.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--LRCUl7B3ZYD5tVzP
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


--LRCUl7B3ZYD5tVzP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEQ404ACgkQVbJhu7ck
PpQu1g/+MGTB0J5O7oVXqt+sj3fnR02+lYSBn8P3/4SjY1Ic9TkNKctKWlexNk1R
fmkE3T3ddsDxRMOYBFyVz643hg6iBqHjx7FE+haS8DqJGp7lR97FXbU6wNvuxFSf
UK/8n/0qArstyb8nnfJzI0TzW5uncpsHWIZ6DUm0+FGWpUk8uczEN2w2gwwcCnYf
fRzTEtu7spPnuuMeU1OBHA1cwP6TknkXwVmQ5ZxVfBK/0p6G5DRKYrZSQdohjwIO
h2JJDrcSiWfRr37jXfpxSd61cx7UWM4bB6AQ/cteVrkKESbeO6n+mTL0a9wQnZj/
kZ4jwX/pFp64lLTjV/r57g9euQRpN0wj80YF+EmTFxivvkipXT77yZ0XJvKgYlQF
6YDZItmU5RYyugBrBEUJ5T9H6eVvq4PfHMB9ojw+8ueEUIX4rKayyEP4HFIJVhB9
5Q/CvpmYDqz8ffYAWP4EzsXAc1Z0QR+aAv/qR9D86R+e/FbsROAU9feSBDzETB08
qzbx/r+RzCbiwPZcUaLFAGiHvrUhZGak2/1i8iSVgRHDwZJEiF4Cpd5sO/bSPncX
hQRLFRCJ+D9exRYWgb2JiURWPKwV2F+cGpo8wPMM2MA8clCdXCGKYPhgB1keHET7
jw5PikcV7iM7G3L6ardyv0K2DcqrGajRfQ6E/bU4GDXHmdlDVQI=
=yv4n
-----END PGP SIGNATURE-----

--LRCUl7B3ZYD5tVzP--
