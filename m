Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BE7C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 11:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 421CB6112D
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 11:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241016AbhHEL0D (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 07:26:03 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:45369 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240808AbhHEL0C (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 5 Aug 2021 07:26:02 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 90B7F5C008E;
        Thu,  5 Aug 2021 07:25:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 05 Aug 2021 07:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=mzvGiBrhHrgbfMgcKD5j1UozQZB
        duOVUts4/SP/2L9k=; b=L3k1l0XvLX+Pa9r9wAWKX7tSq0NvaEL5/OswEzZnTr5
        21GERK5koD1qP0in2OpMT5xXV69hm6k1yucxcRmuqiSlCesZjLSMpXvvyF7Zr/iA
        yG2avby/AVJhRpgSMoqmxzhATv3LaLoBv9CMRKNMXkPSEEkcw2+GtVg2YNpdUmZY
        831/jQ8X4kOOLZXQCJ1Y+YV/h0yd8B6RZoh62nRn+4napQT77E35vgOLixm2oya4
        Qda1zq8Vc/T4N14ta2ldDi4A18c6RlKv7s6T9DVrlwUW2vCWS/QzlnaNOAoJW0Rk
        DtidT2d8fGsy59FI5blvFR/6bxAl61y90tllA6eLvow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=mzvGiB
        rhHrgbfMgcKD5j1UozQZBduOVUts4/SP/2L9k=; b=J1zYDqBAt+4ngQmkswI9+E
        5ELsgK2fiWVtAQGxyQRd2mixu6wry+d3NVkMhSoltCcmO8y2B+m15+0Dg2Jt/I6K
        lclwtWd4SOWU1nvzHQM6wb4DUZuuzdXQzXgZWLp9wqkkkZ5bTmHMQHGMgcrfn3KE
        ttWvzqiwir/GD0e0CKC54c2wsPq9AD5O9lWUPXejUwq3s9v0kHHJ+vv5ku/NEmEL
        TSNeVggahlWIm+Jfq+XBd/tIrLYn/WfEUKc2YCjFMHh9vXFnY1e26S5TiJILM6vP
        UZDw8nH7p9AO+WIP7ZS2oSXWV3zXKzSE2AV1Dm+mAVFj1GbrxOVd/S5AgWePCsPQ
        ==
X-ME-Sender: <xms:vMoLYaTvtT-ksh2qkm-wNVjDcIJoiVEpaxoQrbFgdSVuZTmz4EZ7Uw>
    <xme:vMoLYfx86gCwObqMvs31tM90jjNAL3wWYy5c_t-nDjxvp3kE7e7ubdDXAYOz4urYU
    OwnDRxlU-N-jyAZVg>
X-ME-Received: <xmr:vMoLYX330cejiIgrmlVkZhiR6ppKD33zuNdjjiCTbu9X7p6Nyp4CK76JvUzgjP7c54nr-EJL5Xa2_CsH05fRyvlZ0wVwnJl-bvLU2J4tMNzVcpN7y2w_l6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieelgdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    ephefgjeeuveejteduhefgffefffdvjeefjeeivdekfffgkeeugfehveetueefleeknecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:vMoLYWAa4Irh8McytV8H97UnB0mUO-vhlR87ydSv496nB6QwQZavMQ>
    <xmx:vMoLYTg_4UV6u2Ur-eNkfY7STFwKyjuYrNsnG0QwLHV76AcoXYBP9A>
    <xmx:vMoLYSrXOnjus8Ob77aasKy75O96tMeMeXzmrsHMG-PbAlvLeIQURQ>
    <xmx:vMoLYeWFzlpW9sZecXbRAydL-BGbWnepzShMDPpqzs-c-qvD6Hy38A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Aug 2021 07:25:47 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 38af3e60 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 5 Aug 2021 11:25:46 +0000 (UTC)
Date:   Thu, 5 Aug 2021 13:25:45 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v4 6/6] revision: avoid hitting packfiles when commits are in
 commit-graph
Message-ID: <900c5a9c60282e0fb57840305cbab013ffa398f1.1628162156.git.ps@pks.im>
References: <cover.1624858240.git.ps@pks.im>
 <cover.1628162156.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RPTxo5rE6WScDIPy"
Content-Disposition: inline
In-Reply-To: <cover.1628162156.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--RPTxo5rE6WScDIPy
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

Expose a new function `parse_commit_in_graph_gently()`, which fills in
an object of unknown type in case we find its object ID in the graph.
This provides a big performance win in cases where there is a
commit-graph available in the repository in case we load lots of
references. The following has been executed in a real-world repository
with about 2.2 million refs:

    Benchmark #1: HEAD~: rev-list --unsorted-input --objects --quiet --not =
--all --not $newrev
      Time (mean =C2=B1 =CF=83):      4.508 s =C2=B1  0.039 s    [User: 4.1=
31 s, System: 0.377 s]
      Range (min =E2=80=A6 max):    4.455 s =E2=80=A6  4.576 s    10 runs

    Benchmark #2: HEAD: rev-list --unsorted-input --objects --quiet --not -=
-all --not $newrev
      Time (mean =C2=B1 =CF=83):      3.072 s =C2=B1  0.031 s    [User: 2.7=
07 s, System: 0.365 s]
      Range (min =E2=80=A6 max):    3.040 s =E2=80=A6  3.144 s    10 runs

    Summary
      'HEAD: rev-list --unsorted-input --objects --quiet --not --all --not =
$newrev' ran
        1.47 =C2=B1 0.02 times faster than 'HEAD~: rev-list --unsorted-inpu=
t --objects --quiet --not --all --not $newrev'

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit-graph.c | 26 ++++++++++++++++++++++++++
 commit-graph.h |  7 +++++++
 revision.c     | 17 +++++++++++++++--
 3 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 8c4c7262c8..cc7136243d 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -891,6 +891,32 @@ static int find_commit_pos_in_graph(struct commit *ite=
m, struct commit_graph *g,
 	}
 }
=20
+int parse_commit_in_graph_gently(struct repository *repo, struct object *o=
bject)
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
+	if (!search_commit_pos_in_graph(&object->oid, repo->objects->commit_graph=
, &pos))
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
 static int parse_commit_in_graph_one(struct repository *r,
 				     struct commit_graph *g,
 				     struct commit *item)
diff --git a/commit-graph.h b/commit-graph.h
index 96c24fb577..e2e93b0ee1 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -40,6 +40,13 @@ int open_commit_graph(const char *graph_file, int *fd, s=
truct stat *st);
  */
 int parse_commit_in_graph(struct repository *r, struct commit *item);
=20
+/*
+ * Given an object of unknown type, try to fill in the object in case it i=
s a
+ * commit part of the commit-graph. Returns 0 if the object is a parsed co=
mmit
+ * or if it could be filled in via the commit graph, otherwise it returns =
-1.
+ */
+int parse_commit_in_graph_gently(struct repository *repo, struct object *o=
bject);
+
 /*
  * It is possible that we loaded commit contents from the commit buffer,
  * but we also want to ensure the commit-graph content is correctly
diff --git a/revision.c b/revision.c
index 25f4784fdd..318b43026e 100644
--- a/revision.c
+++ b/revision.c
@@ -362,8 +362,21 @@ static struct object *get_reference(struct rev_info *r=
evs, const char *name,
 	struct object *object =3D lookup_unknown_object(revs->repo, oid);
=20
 	if (object->type =3D=3D OBJ_NONE) {
-		int type =3D oid_object_info(revs->repo, oid, NULL);
-		if (type < 0 || !object_as_type(object, type, 1)) {
+		/*
+		 * It's likely that the reference points to a commit, so we
+		 * first try to look it up via the commit-graph. If successful,
+		 * then we know it's a commit and don't have to unpack the
+		 * object header. We still need to assert that the object
+		 * exists, but given that we don't request any info about the
+		 * object this is a lot faster than `oid_object_info()`.
+		 */
+		if (parse_commit_in_graph_gently(revs->repo, object) < 0) {
+			int type =3D oid_object_info(revs->repo, oid, NULL);
+			if (type < 0 || !object_as_type(object, type, 1)) {
+				object =3D NULL;
+				goto out;
+			}
+		} else if (!repo_has_object_file(revs->repo, oid)) {
 			object =3D NULL;
 			goto out;
 		}
--=20
2.32.0


--RPTxo5rE6WScDIPy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmELyrgACgkQVbJhu7ck
PpTivw//ayV4br212PKUWX9pzC6HjGRoJOSuo2cQDu/mPtooHUd8+9mQ5TjjYPPZ
GYm3aPaffbIteMBogtf3YCNx4U5Kixv7D2GdqwBEvAXq5LubfFKHcs6HNfMjk4os
Ys8TPcr9g8sy9KCsQiQJB69kLYe4HZye3MnbR+i/zjS36jLH5w2X3LftOjYsBzLa
iIlNhT2zwNfQ1OSNBWxe5hB6/Xl9UQQ2wTWVxTzTXhX+VJgM6ZOSzDTIbAlz1Z4a
vSUssuoo4yiUHkMBBYpkYrVEEfJjmF7+uuDNnvV1qXq80rtMXlzx5HAg4w6cSxXD
gjHC0HDFDsPv/fSiSGt08dEVXRfVxF318dmlLaVP4SrQlfVtgipGcUqrfTirmlJx
3AFPHawEnxOx2P/SVpH1YV5+mfEn5u35yAHM/0m2Gx181xVdc5CBmblUL/3SkCsQ
emeZZdPZeXg3C2e8iHMYQBfUC9IjuBnapd2iC6kmGAZvJzuteTH0RvtdYbdSBvTl
ktvq5JmgPztItAWLPYBc1joaVfy1GxKL8ezu5bZZEf44kov3uHV5HUx8Fa4UBrRz
fojLmw7l8CfWLkYgjC/R32sMw8yDWH2C1NafDT7xowIwXOrX7zGAzm6nqMr30VFe
n+8n6eHnfn4Gne/JM3lEmm/cQfIlR1WQV9tNph4e2VcBYgMMWy8=
=hhYg
-----END PGP SIGNATURE-----

--RPTxo5rE6WScDIPy--
