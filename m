Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78121C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 09:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60825610CC
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 09:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbhHBJib (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 05:38:31 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:36345 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233135AbhHBJi2 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 2 Aug 2021 05:38:28 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id B8C983200805;
        Mon,  2 Aug 2021 05:38:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 02 Aug 2021 05:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=8GkTOAFn0SSq2MO4SLk6jkCnKOb
        FfR3Cb3wCmTUljaU=; b=pxv8c/+eIyAkakuqMk/IDVSh0eXKuMeIXMwv+CmJqqH
        LzaQhx3jfUlDeLLXt59tErp2+Q8Sc0euc4CN4Hxs8hJsSyiH8qlC3yrXnT96GxRf
        K7n1LZiOnLJ3CBq+/KTqS3AGsLxDhmTjI9sPUwGUX1WWq3rLD0aY1SIMd3VYg9bz
        ZhcdmVmJ+0V63Tch/bOYZDvD34rQEbWTpe490DYeqwbFwniGnWdNbek2IPY2sAUv
        mFA2n1Wvl9syyQ09UMu+SvZ/At9zdLqHMJURlurLjCq2La6d9nWFkCSydRe9NAB6
        kK5mHWokNxuEMlY1k/z2mXvfnZHNrySDcqaAmNg609A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=8GkTOA
        Fn0SSq2MO4SLk6jkCnKObFfR3Cb3wCmTUljaU=; b=d0WFCts3OKreVcQ2FF9R+z
        JfY3c43829CKv7sjEnYgxeDZXnRlRSpUSuClFpAyXh3/PItfU6PSysk5a2IlgZWi
        6f7vsGhDu/yNAgRb0fx93jzzNqgm4pWI00Rb/ShR3pj9DO2Rixb8gbmzyd6gTo+h
        XECz28QF6ArWhZYq8Y1SuF6NwZ90RGVX9Xjf2TrN89H+Pkp8O5o9RVltrkU//FTs
        mBxr9u6lrrpFNgVa8ZhFjOZOL9RZRLZnRm+K7iLDsxwnHR/QxKMVKK0DddUvnc7/
        tteD7zqAJaoc7StRoAD/NO40vLJQuiGAcyNJoNJ6CwE3P1SCbC7w78km7fQH9A2A
        ==
X-ME-Sender: <xms:Cr0HYTc3j3B6ALpyITJ0RBy6LLM-NdOQdOq2LFEJEtsoMIl3ECIevQ>
    <xme:Cr0HYZMIQHmH_PTOMEZm8lsv9MoLMjUbjSYUH34wKCuXN78-l-jjmYc4crv1Gkxcq
    ZBptpnb_kT9DH0S4A>
X-ME-Received: <xmr:Cr0HYcgQ3IDIthiEKUUN5OOY9fZeDwi7lRsLd5jLeBXDujVBJw4qikpZW5uDMl9TMcAIDyrhn5oTS4P7vqRah3gwmwgFWzhWegNu7nhPCrNKq51Dk7zrug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddriedvgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    ephefgjeeuveejteduhefgffefffdvjeefjeeivdekfffgkeeugfehveetueefleeknecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:Cr0HYU9BCsIqHqT_JVbty7NKDplw7RIYwfqXnQ75v9PTUwGCNcFRcQ>
    <xmx:Cr0HYfuMIsgdO-gXgTslsXd45UuiYRz61RW1m5k_VtHrNre7vRbPvw>
    <xmx:Cr0HYTElqmPIH1hL7G6_mxh6zW6dFjrqFKjChUdyKIgGcips1ConbQ>
    <xmx:Cr0HYTjYJAN40D4xPx6BaQXGguGPgb_Y-tAEi1jcAwqO3PGtjJQdxA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Aug 2021 05:38:16 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 8c652bc7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 2 Aug 2021 09:38:16 +0000 (UTC)
Date:   Mon, 2 Aug 2021 11:38:15 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 4/4] revision: avoid hitting packfiles when commits are in
 commit-graph
Message-ID: <f6fc2a5e6d94befa915fb59b6296ce3153820c13.1627896460.git.ps@pks.im>
References: <cover.1624858240.git.ps@pks.im>
 <cover.1627896460.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NaVD7Y3ZRQ9ikafg"
Content-Disposition: inline
In-Reply-To: <cover.1627896460.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--NaVD7Y3ZRQ9ikafg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When queueing references in git-rev-list(1), we try to either reuse an
already parsed object or alternatively we load the object header from
disk in order to determine its type. This is inefficient for commits
though in cases where we have a commit graph available: instead of
hitting the real object on disk to determine its type, we may instead
search the object graph for the object ID. In case it's found, we can
directly fill in the commit object, otherwise we can still hit the disk
to determine the object's type.

Expose a new function `find_object_in_graph()`, which fills in an object
of unknown type in case we find its object ID in the graph. This
provides a big performance win in cases where there is a commit-graph
available in the repository in case we load lots of references. The
following has been executed in a real-world repository with about 2.2
million refs:

    Benchmark #1: HEAD~: rev-list --unsorted-input --objects --quiet --not =
--all --not $newrev
      Time (mean =C2=B1 =CF=83):      4.465 s =C2=B1  0.037 s    [User: 4.1=
44 s, System: 0.320 s]
      Range (min =E2=80=A6 max):    4.411 s =E2=80=A6  4.514 s    10 runs

    Benchmark #2: HEAD: rev-list --unsorted-input --objects --quiet --not -=
-all --not $newrev
      Time (mean =C2=B1 =CF=83):      2.886 s =C2=B1  0.032 s    [User: 2.5=
70 s, System: 0.316 s]
      Range (min =E2=80=A6 max):    2.826 s =E2=80=A6  2.933 s    10 runs

    Summary
      'HEAD: rev-list --unsorted-input --objects --quiet --not --all --not =
$newrev' ran
        1.55 =C2=B1 0.02 times faster than 'HEAD~: rev-list --unsorted-inpu=
t --objects --quiet --not --all --not $newrev'

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit-graph.c | 55 +++++++++++++++++++++++++++++++++++++++-----------
 commit-graph.h |  2 ++
 revision.c     | 10 +++++----
 3 files changed, 51 insertions(+), 16 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 3860a0d847..a81d5cebc0 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -864,6 +864,48 @@ static int fill_commit_in_graph(struct repository *r,
 	return 1;
 }
=20
+static int find_object_id_in_graph(const struct object_id *id, struct comm=
it_graph *g, uint32_t *pos)
+{
+	struct commit_graph *cur_g =3D g;
+	uint32_t lex_index;
+
+	while (cur_g && !bsearch_graph(cur_g, (struct object_id *)id, &lex_index))
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
+int find_object_in_graph(struct repository *repo, struct object *object)
+{
+	struct commit *commit;
+	uint32_t pos;
+
+	if (object->parsed) {
+		if (object->type !=3D OBJ_COMMIT)
+			return -1;
+		return 0;
+	}
+
+	if (!repo->objects->commit_graph)
+		return -1;
+
+	if (!find_object_id_in_graph(&object->oid, repo->objects->commit_graph, &=
pos))
+		return -1;
+
+	commit =3D object_as_type(object, OBJ_COMMIT, 1);
+	if (!commit)
+		return -1;
+	if (!fill_commit_in_graph(repo, commit, repo->objects->commit_graph, pos))
+		return -1;
+
+	return 0;
+}
+
 static int find_commit_in_graph(struct commit *item, struct commit_graph *=
g, uint32_t *pos)
 {
 	uint32_t graph_pos =3D commit_graph_position(item);
@@ -871,18 +913,7 @@ static int find_commit_in_graph(struct commit *item, s=
truct commit_graph *g, uin
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
+		return find_object_id_in_graph(&item->object.oid, g, pos);
 	}
 }
=20
diff --git a/commit-graph.h b/commit-graph.h
index 96c24fb577..f373fab4c0 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -139,6 +139,8 @@ int write_commit_graph(struct object_directory *odb,
 		       enum commit_graph_write_flags flags,
 		       const struct commit_graph_opts *opts);
=20
+int find_object_in_graph(struct repository *repo, struct object *object);
+
 #define COMMIT_GRAPH_VERIFY_SHALLOW	(1 << 0)
=20
 int verify_commit_graph(struct repository *r, struct commit_graph *g, int =
flags);
diff --git a/revision.c b/revision.c
index 671b6d6513..c3f9cf2998 100644
--- a/revision.c
+++ b/revision.c
@@ -362,10 +362,12 @@ static struct object *get_reference(struct rev_info *=
revs, const char *name,
 	struct object *object =3D lookup_unknown_object(revs->repo, oid);
=20
 	if (object->type =3D=3D OBJ_NONE) {
-		int type =3D oid_object_info(revs->repo, oid, NULL);
-		if (type < 0 || !object_as_type(object, type, 1)) {
-			object =3D NULL;
-			goto out;
+		if (find_object_in_graph(revs->repo, object) < 0) {
+			int type =3D oid_object_info(revs->repo, oid, NULL);
+			if (type < 0 || !object_as_type(object, type, 1)) {
+				object =3D NULL;
+				goto out;
+			}
 		}
 	}
=20
--=20
2.32.0


--NaVD7Y3ZRQ9ikafg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEHvQYACgkQVbJhu7ck
PpRRsQ/8CCFX/kO6T2qb2ge//Km4feW/3mLysr8FwwVvpkWlrvuvdFrFP5DrLjZC
yivQqS5Fx0S2j8Z4nxPqz2AhuZ/InUaSKiW/cOJ8vV4QlQFJ2y7PFSvwjPWPwonb
K4HpXeG9gJ0A+ILeyLKrG2ZZNqI6mH0Qq5QJmmK0o7/HwKZ8DdxClQLIq7BoXWAx
U+wFIEYeocGsdHMMGVqHxvi0dYRqS8jOacMEzDeUHOW3bVaZYDB1dDbhNLsMv46U
5qVtUaQ9Fd3XmHkMDts+LaiGtH2Y4MK6ibWVsKt9g+7Sj7FBFXP4EXkyPknDfBqS
vlwyEQrH0B1o47d+6+hTR5Nju0753KLgH/1iyvJuKtc3IhUnPQGtX3o2/gNQDUjT
euffeCGM4OT6GFF0UOMdU22ZNiNLFZZoqZce6lR29NiEbKK+yOm/b3T95pnxlSMV
zZK2aOhHOUk3w1CKv4ojNLJSgT1hi6jWRtxEzLjagru6SeKW55bCaTjuErGbdza7
LKNrkPSae6Vjuperba4Bg8t5bvytbtWvDSS9x1wwuXAMCbulYn2iCceUSEHn/AYb
MifRdJYIJs9cxKXlqfJLqdmzlyV+fL4GrfP3O7bd2+nCb9sV6urFwRlY90kXzNi0
4JN/zD40/Ya87K+7RxqsbOXJeSTvCq0Nyd+RIGM0LN+thGkf8Ao=
=o3b+
-----END PGP SIGNATURE-----

--NaVD7Y3ZRQ9ikafg--
