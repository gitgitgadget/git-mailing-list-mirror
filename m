Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF01C2B9F4
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 05:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E0C661A1D
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 05:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbhF1Ffy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 01:35:54 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45259 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232123AbhF1Ffo (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 28 Jun 2021 01:35:44 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 3AC745C009A;
        Mon, 28 Jun 2021 01:33:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 28 Jun 2021 01:33:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=dyDH9Mp1qN04zjse7YSeWzQOTAM
        NNWPJMNZ/eUDr3pU=; b=g8lNQsLf1rX2cZz3mlCmxn265VVkP8zJ/ubs6PuLcqv
        z/HN+Gau3ZBbArFv4bKjQNjuZQdwDPrj7Z8PhJBsABXrEhfsMPHaiJBtlVP7QCBp
        d/2lqWaamAH22N0UUhCPQ4iDs6kH0W4e257T5Hy7f3F7kWpeqRELcj3PzZ/s+3dG
        ddvGw8nDdDjvKWyW5Ct1DiI8ktHOM1C+HlytOU1pr1GDGAaj/TboktEf0tTUPZcO
        fSNcsmXAurA2HfB5FbDSWuh+0CojG9qxfpqY3kgvobiDSys0caryWirUO/l4QsyQ
        i4VUT3icT8j8pNqoexBKXmfMDr7m9uMm4r8nuUDTqpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=dyDH9M
        p1qN04zjse7YSeWzQOTAMNNWPJMNZ/eUDr3pU=; b=Ue9AJwIDvoX40c5ysnZ8aa
        NEhwBDRdVBf2vq9G7vX6RdAj+CAC5Qs7hu0m5uqZ7jMu8YFn4/pDLJWgecY9ECc7
        e8mYEsCbz3KgkQfHqdY8fa6FD99iH7b49O3B+FrTTyZ7rALqNDmirEFHmbtjsdg4
        WbGTklbqZitHOghfn3hzxPRtCQvpApEfVURKWA6+xrLiMnZxRGMi1NpVL7DGhWqQ
        ftwuExMS/iI6QA1E069NgfDh2OoYDAO3OTyLmGRfYQ294BC+ieVAtHJ2tdc4Cl83
        5KVNxdvQ/vSGk4mvDQbIqVvQAr8cdm1JSBSsJBiK6asaefQ1fCkHQy3JXgEFl8Zw
        ==
X-ME-Sender: <xms:H1_ZYFPq1SP-ebRv3Z-grAtd8x1T2iKJ8wTBIdA8dWXE1zgea9bJ0g>
    <xme:H1_ZYH9zFbmCTwmpJFZioWpxNmfXjemeh--SceY1NWfxa1VyBPMrlwLaWRuTCiUfw
    pDdn0s7xnp_AW1tLA>
X-ME-Received: <xmr:H1_ZYESfWqZusQTva-ftKZThP_FSoIyyhJFI0RBSU7_-WMwLsiNTfVkdVEQCbeTXlHcR-K9W2FJZuTLhnY129jO3qtQxLC66k2RDsDHpl_hrpyQlvu5bsO0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeehfedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:H1_ZYBtUQE-vNdZutKpPfQgusxUZ705poOj3Xp9fSo7EipB0KgFdDA>
    <xmx:H1_ZYNfVG7lp7YsCUnjwhPdluF36ran8SPat0xd_QbqZz-vAW54oZA>
    <xmx:H1_ZYN3SE-hIC1-kTyCEu5tJpxDQ3F1qi_q3vPWTy5nh3ziIj8lZqw>
    <xmx:H1_ZYGF6JbcE9WyR_Y0NO8aSdmVeuVbJ81wvjgjFpbebwEhdkeqxMQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jun 2021 01:33:18 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 6a6fec77 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 28 Jun 2021 05:33:16 +0000 (UTC)
Date:   Mon, 28 Jun 2021 07:33:15 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/3] connected: implement connectivity check using bitmaps
Message-ID: <7687dedd4722c39b5ecef2c2165147c25d16b8d9.1624858240.git.ps@pks.im>
References: <cover.1624858240.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sMpAWHIRdsq6JklT"
Content-Disposition: inline
In-Reply-To: <cover.1624858240.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--sMpAWHIRdsq6JklT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The connectivity checks are currently implemented via git-rev-list(1):
we simply ignore any objects which are reachable from preexisting refs
via `--not --all`, and pass all new refs which are to be checked via its
stdin. While this works well enough for repositories which do not have a
lot of references, it's clear that `--not --all` will linearly scale
with the number of refs which do exist: for each reference, we'll walk
through its commit as well as its five parent commits (defined via
`SLOP`). Given that many major hosting sites which use a pull/merge
request workflow keep refs to the request's HEAD, this effectively means
that `--not --all` will do a nearly complete graph walk.

This commit implements an alternate strategy if the target repository
has bitmaps. Objects referenced by a bitmap are by definition always
fully connected, so they form a natural boundary between old revisions
and new revisions. With this alternate strategy, we walk all given new
object IDs. Whenever we hit any object which is covered by the bitmap,
we stop the walk.

The logic only kicks in in case we have a bitmap in the repository. If
not, we wouldn't be able to efficiently abort the walk because we cannot
easily tell whether an object already exists in the target repository
and, if it does, whether it's fully connected. As a result, we'd have to
perform a always do graph walk in this case. Naturally, we could do the
same thing the previous git-rev-list(1) implementation did in that case
and just use preexisting branch tips as boundaries. But for now, we just
keep the old implementation for simplicity's sake given that performance
characteristics are likely not significantly different.

An easier solution may have been to simply add `--use-bitmap-index` to
the git-rev-list(1) invocation, but benchmarks have shown that this is
not effective: performance characteristics remain the same except for
some cases where the bitmap walks performs much worse compared to the
non-bitmap walk

The following benchmarks have been performed in linux.git:

Test                                                  origin/master        =
   HEAD
---------------------------------------------------------------------------=
------------------------------
5400.4: empty receive-pack updated:new                176.02(387.28+175.12)=
   176.86(388.75+175.51) +0.5%
5400.7: clone receive-pack updated:new                0.10(0.09+0.01)      =
   0.08(0.06+0.03) -20.0%
5400.9: clone receive-pack updated:main               0.09(0.08+0.01)      =
   0.09(0.06+0.03) +0.0%
5400.11: clone receive-pack main~10:main              0.14(0.11+0.03)      =
   0.13(0.11+0.02) -7.1%
5400.13: clone receive-pack :main                     0.01(0.01+0.00)      =
   0.02(0.01+0.00) +100.0%
5400.16: clone_bitmap receive-pack updated:new        0.10(0.09+0.01)      =
   0.28(0.13+0.15) +180.0%
5400.18: clone_bitmap receive-pack updated:main       0.10(0.08+0.02)      =
   0.28(0.12+0.16) +180.0%
5400.20: clone_bitmap receive-pack main~10:main       0.13(0.11+0.02)      =
   0.26(0.12+0.14) +100.0%
5400.22: clone_bitmap receive-pack :main              0.01(0.01+0.00)      =
   0.01(0.01+0.00) +0.0%
5400.25: extrarefs receive-pack updated:new           32.14(20.76+11.59)   =
   32.35(20.52+12.03) +0.7%
5400.27: extrarefs receive-pack updated:main          32.08(20.54+11.75)   =
   32.10(20.78+11.53) +0.1%
5400.29: extrarefs receive-pack main~10:main          32.14(20.66+11.68)   =
   32.27(20.65+11.83) +0.4%
5400.31: extrarefs receive-pack :main                 7.09(3.56+3.53)      =
   7.10(3.70+3.40) +0.1%
5400.34: extrarefs_bitmap receive-pack updated:new    32.41(20.59+12.02)   =
   7.36(3.76+3.60) -77.3%
5400.36: extrarefs_bitmap receive-pack updated:main   32.26(20.53+11.95)   =
   7.34(3.56+3.78) -77.2%
5400.38: extrarefs_bitmap receive-pack main~10:main   32.44(20.77+11.90)   =
   7.40(3.70+3.70) -77.2%
5400.40: extrarefs_bitmap receive-pack :main          7.09(3.62+3.46)      =
   7.17(3.79+3.38) +1.1%

As expected, performance doesn't change in cases where we do not have a
bitmap available given that the old code path still kicks in. In case we
do have bitmaps, this is kind of a mixed bag: while git-receive-pack(1)
is slower in a "normal" clone of linux.git, it is significantly faster
for a clone with lots of references. The slowness can potentially be
explained by the overhead of loading the bitmap. On the other hand, the
new code is faster as expected in repos which have lots of references
given that we do not have to mark all negative references anymore.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 connected.c   | 136 ++++++++++++++++++++++++++++++++++++++++++++++++++
 pack-bitmap.c |   4 +-
 pack-bitmap.h |   2 +
 3 files changed, 140 insertions(+), 2 deletions(-)

diff --git a/connected.c b/connected.c
index b18299fdf0..474275a52f 100644
--- a/connected.c
+++ b/connected.c
@@ -6,6 +6,127 @@
 #include "transport.h"
 #include "packfile.h"
 #include "promisor-remote.h"
+#include "object.h"
+#include "tree-walk.h"
+#include "commit.h"
+#include "tag.h"
+#include "progress.h"
+#include "oidset.h"
+#include "pack-bitmap.h"
+
+#define QUEUED (1u<<0)
+
+static int queue_object(struct repository *repo,
+			struct bitmap_index *bitmap,
+			struct object_array *pending,
+			const struct object_id *oid)
+{
+	struct object *object;
+
+	/*
+	 * If the object ID is part of the bitmap, then we know that it must by
+	 * definition be reachable in the target repository and be fully
+	 * connected. We can thus skip checking the objects' referenced
+	 * objects.
+	 */
+	if (bitmap_position(bitmap, oid) >=3D 0)
+		return 0;
+
+	/* Otherwise the object is queued up for a connectivity check. */
+	object =3D parse_object(repo, oid);
+	if (!object) {
+		/* Promisor objects do not need to be traversed. */
+		if (is_promisor_object(oid))
+			return 0;
+		return -1;
+	}
+
+	/*
+	 * If the object has been queued before already, then we don't need to
+	 * do so again.
+	 */
+	if (object->flags & QUEUED)
+		return 0;
+	object->flags |=3D QUEUED;
+
+	/*
+	 * We do not need to queue up blobs given that they don't reference any
+	 * other objects anyway.
+	 */
+	if (object->type =3D=3D OBJ_BLOB)
+		return 0;
+
+	add_object_array(object, NULL, pending);
+
+	return 0;
+}
+
+static int check_object(
+	struct repository *repo,
+	struct bitmap_index *bitmap,
+	struct object_array *pending,
+	const struct object *object)
+{
+	int ret =3D 0;
+
+	if (object->type =3D=3D OBJ_TREE) {
+		struct tree *tree =3D (struct tree *)object;
+		struct tree_desc tree_desc;
+		struct name_entry entry;
+
+		if (init_tree_desc_gently(&tree_desc, tree->buffer, tree->size))
+			return error(_("cannot parse tree entry"));
+		while (tree_entry_gently(&tree_desc, &entry))
+			ret |=3D queue_object(repo, bitmap, pending, &entry.oid);
+
+		free_tree_buffer(tree);
+	} else if (object->type =3D=3D OBJ_COMMIT) {
+		struct commit *commit =3D (struct commit *) object;
+		struct commit_list *parents;
+
+		for (parents =3D commit->parents; parents; parents =3D parents->next)
+			ret |=3D queue_object(repo, bitmap, pending, &parents->item->object.oid=
);
+
+		free_commit_buffer(repo->parsed_objects, commit);
+	} else if (object->type =3D=3D OBJ_TAG) {
+		ret |=3D queue_object(repo, bitmap, pending, get_tagged_oid((struct tag =
*) object));
+	} else {
+		return error(_("unexpected object type"));
+	}
+
+	return ret;
+}
+
+/*
+ * If the target repository has a bitmap, then we treat all objects reacha=
ble
+ * via the bitmap as fully connected. Bitmapped objects thus serve as the
+ * boundary between old and new objects.
+ */
+static int check_connected_with_bitmap(struct repository *repo,
+				       struct bitmap_index *bitmap,
+				       oid_iterate_fn fn, void *cb_data,
+				       struct check_connected_options *opt)
+{
+	struct object_array pending =3D OBJECT_ARRAY_INIT;
+	struct progress *progress =3D NULL;
+	size_t checked_objects =3D 0;
+	struct object_id oid;
+	int ret =3D 0;
+
+	if (opt->progress)
+		progress =3D start_delayed_progress("Checking connectivity", 0);
+
+	while (!fn(cb_data, &oid))
+		ret |=3D queue_object(repo, bitmap, &pending, &oid);
+	while (pending.nr) {
+		ret |=3D check_object(repo, bitmap, &pending, object_array_pop(&pending)=
);
+		display_progress(progress, ++checked_objects);
+	}
+
+	stop_progress(&progress);
+	object_array_clear(&pending);
+	return ret;
+}
=20
 /*
  * If we feed all the commits we want to verify to this command
@@ -28,12 +149,27 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 	int err =3D 0;
 	struct packed_git *new_pack =3D NULL;
 	struct transport *transport;
+	struct bitmap_index *bitmap;
 	size_t base_len;
=20
 	if (!opt)
 		opt =3D &defaults;
 	transport =3D opt->transport;
=20
+	bitmap =3D prepare_bitmap_git(the_repository);
+	if (bitmap) {
+		/*
+		 * If we have a bitmap, then we can reuse the bitmap as
+		 * boundary between old and new objects.
+		 */
+		err =3D check_connected_with_bitmap(the_repository, bitmap,
+						  fn, cb_data, opt);
+		if (opt->err_fd)
+			close(opt->err_fd);
+		free_bitmap_index(bitmap);
+		return err;
+	}
+
 	if (fn(cb_data, &oid)) {
 		if (opt->err_fd)
 			close(opt->err_fd);
diff --git a/pack-bitmap.c b/pack-bitmap.c
index d90e1d9d8c..d88a882ee1 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -418,8 +418,8 @@ static inline int bitmap_position_packfile(struct bitma=
p_index *bitmap_git,
 	return pos;
 }
=20
-static int bitmap_position(struct bitmap_index *bitmap_git,
-			   const struct object_id *oid)
+int bitmap_position(struct bitmap_index *bitmap_git,
+		    const struct object_id *oid)
 {
 	int pos =3D bitmap_position_packfile(bitmap_git, oid);
 	return (pos >=3D 0) ? pos : bitmap_position_extended(bitmap_git, oid);
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 99d733eb26..7b4b386107 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -63,6 +63,8 @@ int rebuild_existing_bitmaps(struct bitmap_index *, struc=
t packing_data *mapping
 void free_bitmap_index(struct bitmap_index *);
 int bitmap_walk_contains(struct bitmap_index *,
 			 struct bitmap *bitmap, const struct object_id *oid);
+int bitmap_position(struct bitmap_index *bitmap_git,
+		    const struct object_id *oid);
=20
 /*
  * After a traversal has been performed by prepare_bitmap_walk(), this can=
 be
--=20
2.32.0


--sMpAWHIRdsq6JklT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmDZXxoACgkQVbJhu7ck
PpRDZg//cmNT68HFZzoOsInDIwPHqZUjqwW94HQDs9AVJ9ruAgPohHfTH2wcVQ5D
9loJXuraeK0+ArKOBKojW97HBx2pUIP+Se+absdw0uUlqyNqHGmfvio0LuaImEEK
qOSdtHW7g834Wo5gAs2czdbayPBWB1B2OZShvv5LGpcSxPKyJKz9pW9jKUyV6/ru
RJ6bHi4a+eCMXqSh9y44U1Y6xT1IvehM3QMLH/mE1t0Taxu8pq0Dj9YwJpNkKjjO
p1n840An2Mf4MvhGagtflvTxaBxtAc27l+8hLw+j5LMpPbNOmOGF1V3yZYd9lgkx
yvmcWpdPw1EWKbTvKlEsq1oMIG8cYCgBTf6wnPjBu5SL2CE7MwF7S2SKIsyLCHQj
nYwrV1cihl8+tpkuYU0zmE//h+cNMZrAXBAufT4BIiQCvrCbPgejvgapYJU5cJb2
si+DXPhojrKqVe3ERrHFrs/JTbawAsjFMsZOp8EIhKcIJznxM7MYsFJ96bjdoG5I
pgz51e3cnNt7jOU7F9Lmp+EIlrNdhf2Xof2X/OKBLl3M/mti9yZ1ffnpK645KZUU
CSz7ti9m12ixY/txqL04jbGUfTiJpp2TN/sAQQBuT+QS+kP0qCQzjN4DTtYGMyWS
hB8chgMH2EIWawvH5XyxNGEQ3Ygl8xFiRc0lfyoiRhSgxmTWhsI=
=9AfG
-----END PGP SIGNATURE-----

--sMpAWHIRdsq6JklT--
