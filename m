Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E871369BE
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 06:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718259218; cv=none; b=LGiFx2NgYkFQ3G/p2gLO86Eq+wm/zBy6oBeCzqmg33fPFH2BVvTFjTXtusKinK8abN6x8jrO4PeyqA9RVnoQ9S1N9+8El8SuAM4cHCQkL7/Ww0VaO4H1ys3UkP34Lz5FpxVOdCyJ5wuGqX8sW+aVtCDrZcXz8LGtQj5w6pD3Vio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718259218; c=relaxed/simple;
	bh=gmjrTKODKgFSlaOg3U61HIb54wbqXtMyxBenra34IA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2ghD/d7JojfjJP0NrWwd+veSBFoybQEXxjaBaPE3LrdtegAkejplikZ7j2Kau+IADpJGfkzPvuRif5YGGDz2leVI0mXo6MhhSxG09q+mdAvhY8DSTElD9nbYEf3puQON/QZaPi+LB+nt73zZ+Tg6xMXo3yyZgQdWdmUlGBw+As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lSIZ3u35; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CUpcnsuw; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lSIZ3u35";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CUpcnsuw"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 4BED0180006A;
	Thu, 13 Jun 2024 02:13:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 13 Jun 2024 02:13:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718259214; x=1718345614; bh=V4g1hbV5vu
	92ypHm+hAzHs7I21lnwRzsS6Bns4wDuJE=; b=lSIZ3u35PXonVA16bJxP05bihT
	KDM2qgcW5rw8C8f2h6p3ymK5TtgqMuBzF0skaJcDwTv09Ptexi/oW/acWlwtYDcf
	dSdqTQGikmEqW1SE7pSDZshHuCGiLRDfJ2v1q6xBikjMvPgkPIMXdM/BFavZpOtK
	yO8eHLMh/QKmi9/UXHK5SWECN2GmAbImXhiVpLA4takRZBhAFmJkv6Utvw5BBl4H
	HXot/K0C1tQpu3QSYUFNi8lC0VFy75/jzVymaVXUZWdlXF/I8jUuGXWtcYBfGR9z
	I1XU/aVfjHNtWzswe1cVRIzeVaD8Ir1i++2LeFtXNu9k0L26gvfnxG+86wkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718259214; x=1718345614; bh=V4g1hbV5vu92ypHm+hAzHs7I21ln
	wRzsS6Bns4wDuJE=; b=CUpcnsuwKCgyAsulbn+N/DuvZN/lt3j6dMtAGO4JwDL5
	QAghEkgNQxmRzZOzi+baHFNhlPENh24FrVkF+bFKL1alhmQRTjc5fI0KZrvofF0x
	TrCFbiY9WlYDSOLueTLmJ/FAeLuY2NudRS/1+ulk9/ntKk3yIQlYSqBLWlUlKVrT
	ipLPaK+z3sGgCHy7tyJQaM3rqJ0Ab9eyVtwvnA168szLXKpEIYp77bmBVOcwgvYL
	+EAHP6HvwIxUxXILW4Wl9GdvXUSkeW3Kw9Apx3+jADrfw2WoJZlhQ8bHcP797G0U
	aWegKtvmgb4xiQX6YVxWniwatKXyR6no/rhxNcBoug==
X-ME-Sender: <xms:Do5qZhm_pWwP1jUjkg4qvWYUtVKdPgIXorQmtKcPaItBj4M2Nor3fw>
    <xme:Do5qZs3vRE141nuRoS8PcT5l5KTHWu9TOh4tSYgZsJKIvJ3TziuiGUyFSvp8rN65a
    _90Z1PnPvsbNWwypA>
X-ME-Received: <xmr:Do5qZnqgKKTYD2q3F2uMOHS4iRDbeRA9JtpeCkQ08mQ_81q-MIjOkK0KaL5TwnWUT9erJYRIAKYV9IjsQF8DcB4TeO3lgeXLlv1ntY53Lb8NFDmkPiM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduiedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Do5qZhlc1WbALXOaOooSF1wNkS3Ng-OkMU3alvGlvSA7i_NKjX3v0g>
    <xmx:Do5qZv1w5kpneLBExXx29risDolVPRgktIQW6AvUB80SwmGe8efF5g>
    <xmx:Do5qZgsGxP3WpE4lK6CYqGJNnaI2RTf0MNJkO-iumueG8Ay4bqFp-Q>
    <xmx:Do5qZjUGpriBRmrxDFuo6EKQ-NPoJQIFfHSjuLTVmhc-4FlgLgrPcg>
    <xmx:Do5qZgwCRRBvjsnv6Hq_Kmx75r8dlWdrXVUIMrN5erIuTqFnXOsDrPJv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 02:13:33 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 171c6745 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Jun 2024 06:13:20 +0000 (UTC)
Date: Thu, 13 Jun 2024 08:13:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 02/20] hash: require hash algorithm in `hasheq()`,
 `hashcmp()` and `hashclr()`
Message-ID: <aa468c3d88eb673343b934d3c8e7fe991d15ba2f.1718259125.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
 <cover.1718259125.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iC1ZFNsSGezsDCpH"
Content-Disposition: inline
In-Reply-To: <cover.1718259125.git.ps@pks.im>


--iC1ZFNsSGezsDCpH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Many of our hash functions have two variants, one receiving a `struct
git_hash_algo` and one that derives it via `the_repository`. Adapt all
of those functions to always require the hash algorithm as input and
drop the variants that do not accept one.

As those functions are now independent of `the_repository`, we can move
them from "hash.h" to "hash-ll.h".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/index-pack.c     |  6 +++---
 builtin/pack-redundant.c |  8 +++++---
 builtin/unpack-objects.c |  3 ++-
 commit-graph.c           |  3 ++-
 csum-file.c              |  6 +++---
 hash-ll.h                | 15 +++++++++++++--
 hash-lookup.c            |  3 ++-
 hash.h                   | 24 ++----------------------
 http-walker.c            |  2 +-
 match-trees.c            |  2 +-
 notes.c                  |  2 +-
 pack-bitmap-write.c      |  4 ++--
 pack-bitmap.c            |  3 ++-
 pack-check.c             |  5 +++--
 pack-write.c             |  3 ++-
 packfile.c               |  8 ++++----
 read-cache.c             |  8 ++++----
 17 files changed, 52 insertions(+), 53 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 856428fef9..ea727fba16 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1204,7 +1204,7 @@ static void parse_pack_objects(unsigned char *hash)
 	the_hash_algo->init_fn(&tmp_ctx);
 	the_hash_algo->clone_fn(&tmp_ctx, &input_ctx);
 	the_hash_algo->final_fn(hash, &tmp_ctx);
-	if (!hasheq(fill(the_hash_algo->rawsz), hash))
+	if (!hasheq(fill(the_hash_algo->rawsz), hash, the_repository->hash_algo))
 		die(_("pack is corrupted (SHA1 mismatch)"));
 	use(the_hash_algo->rawsz);
=20
@@ -1307,11 +1307,11 @@ static void conclude_pack(int fix_thin_pack, const =
char *curr_pack, unsigned cha
 		stop_progress_msg(&progress, msg.buf);
 		strbuf_release(&msg);
 		finalize_hashfile(f, tail_hash, FSYNC_COMPONENT_PACK, 0);
-		hashcpy(read_hash, pack_hash);
+		hashcpy(read_hash, pack_hash, the_repository->hash_algo);
 		fixup_pack_header_footer(output_fd, pack_hash,
 					 curr_pack, nr_objects,
 					 read_hash, consumed_bytes-the_hash_algo->rawsz);
-		if (!hasheq(read_hash, tail_hash))
+		if (!hasheq(read_hash, tail_hash, the_repository->hash_algo))
 			die(_("Unexpected tail checksum for %s "
 			      "(disk corruption?)"), curr_pack);
 	}
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 4c735ba069..103c11b9d3 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -155,7 +155,7 @@ static inline struct llist_item * llist_sorted_remove(s=
truct llist *list, const
 	l =3D (hint =3D=3D NULL) ? list->front : hint;
 	prev =3D NULL;
 	while (l) {
-		const int cmp =3D hashcmp(l->oid.hash, oid);
+		const int cmp =3D hashcmp(l->oid.hash, oid, the_repository->hash_algo);
 		if (cmp > 0) /* not in list, since sorted */
 			return prev;
 		if (!cmp) { /* found */
@@ -258,7 +258,8 @@ static void cmp_two_packs(struct pack_list *p1, struct =
pack_list *p2)
 	while (p1_off < p1->pack->num_objects * p1_step &&
 	       p2_off < p2->pack->num_objects * p2_step)
 	{
-		const int cmp =3D hashcmp(p1_base + p1_off, p2_base + p2_off);
+		const int cmp =3D hashcmp(p1_base + p1_off, p2_base + p2_off,
+					the_repository->hash_algo);
 		/* cmp ~ p1 - p2 */
 		if (cmp =3D=3D 0) {
 			p1_hint =3D llist_sorted_remove(p1->unique_objects,
@@ -296,7 +297,8 @@ static size_t sizeof_union(struct packed_git *p1, struc=
t packed_git *p2)
 	while (p1_off < p1->num_objects * p1_step &&
 	       p2_off < p2->num_objects * p2_step)
 	{
-		int cmp =3D hashcmp(p1_base + p1_off, p2_base + p2_off);
+		int cmp =3D hashcmp(p1_base + p1_off, p2_base + p2_off,
+				  the_repository->hash_algo);
 		/* cmp ~ p1 - p2 */
 		if (cmp =3D=3D 0) {
 			ret++;
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index f1c85a00ae..0855572c27 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -674,7 +674,8 @@ int cmd_unpack_objects(int argc, const char **argv, con=
st char *prefix UNUSED)
 		if (fsck_finish(&fsck_options))
 			die(_("fsck error in pack objects"));
 	}
-	if (!hasheq(fill(the_hash_algo->rawsz), oid.hash))
+	if (!hasheq(fill(the_hash_algo->rawsz), oid.hash,
+		    the_repository->hash_algo))
 		die("final sha1 did not match");
 	use(the_hash_algo->rawsz);
=20
diff --git a/commit-graph.c b/commit-graph.c
index e5dd3553df..3429156b28 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -565,7 +565,8 @@ static int add_graph_to_chain(struct commit_graph *g,
=20
 		if (!cur_g ||
 		    !oideq(&oids[n], &cur_g->oid) ||
-		    !hasheq(oids[n].hash, g->chunk_base_graphs + st_mult(g->hash_len, n)=
)) {
+		    !hasheq(oids[n].hash, g->chunk_base_graphs + st_mult(g->hash_len, n),
+			    the_repository->hash_algo)) {
 			warning(_("commit-graph chain does not match"));
 			return 0;
 		}
diff --git a/csum-file.c b/csum-file.c
index 870748e016..f4be0804b7 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -68,12 +68,12 @@ int finalize_hashfile(struct hashfile *f, unsigned char=
 *result,
 	hashflush(f);
=20
 	if (f->skip_hash)
-		hashclr(f->buffer);
+		hashclr(f->buffer, the_repository->hash_algo);
 	else
 		the_hash_algo->final_fn(f->buffer, &f->ctx);
=20
 	if (result)
-		hashcpy(result, f->buffer);
+		hashcpy(result, f->buffer, the_repository->hash_algo);
 	if (flags & CSUM_HASH_IN_STREAM)
 		flush(f, f->buffer, the_hash_algo->rawsz);
 	if (flags & CSUM_FSYNC)
@@ -237,5 +237,5 @@ int hashfile_checksum_valid(const unsigned char *data, =
size_t total_len)
 	the_hash_algo->update_fn(&ctx, data, data_len);
 	the_hash_algo->final_fn(got, &ctx);
=20
-	return hasheq(got, data + data_len);
+	return hasheq(got, data + data_len, the_repository->hash_algo);
 }
diff --git a/hash-ll.h b/hash-ll.h
index 2cfde63ae1..fabdd8ecc7 100644
--- a/hash-ll.h
+++ b/hash-ll.h
@@ -245,7 +245,7 @@ static inline int hash_algo_by_ptr(const struct git_has=
h_algo *p)
=20
 const struct object_id *null_oid(void);
=20
-static inline int hashcmp_algop(const unsigned char *sha1, const unsigned =
char *sha2, const struct git_hash_algo *algop)
+static inline int hashcmp(const unsigned char *sha1, const unsigned char *=
sha2, const struct git_hash_algo *algop)
 {
 	/*
 	 * Teach the compiler that there are only two possibilities of hash size
@@ -256,7 +256,7 @@ static inline int hashcmp_algop(const unsigned char *sh=
a1, const unsigned char *
 	return memcmp(sha1, sha2, GIT_SHA1_RAWSZ);
 }
=20
-static inline int hasheq_algop(const unsigned char *sha1, const unsigned c=
har *sha2, const struct git_hash_algo *algop)
+static inline int hasheq(const unsigned char *sha1, const unsigned char *s=
ha2, const struct git_hash_algo *algop)
 {
 	/*
 	 * We write this here instead of deferring to hashcmp so that the
@@ -267,6 +267,17 @@ static inline int hasheq_algop(const unsigned char *sh=
a1, const unsigned char *s
 	return !memcmp(sha1, sha2, GIT_SHA1_RAWSZ);
 }
=20
+static inline void hashcpy(unsigned char *sha_dst, const unsigned char *sh=
a_src,
+			   const struct git_hash_algo *algop)
+{
+	memcpy(sha_dst, sha_src, algop->rawsz);
+}
+
+static inline void hashclr(unsigned char *hash, const struct git_hash_algo=
 *algop)
+{
+	memset(hash, 0, algop->rawsz);
+}
+
 static inline void oidcpy(struct object_id *dst, const struct object_id *s=
rc)
 {
 	memcpy(dst->hash, src->hash, GIT_MAX_RAWSZ);
diff --git a/hash-lookup.c b/hash-lookup.c
index 9f0f95e2b9..9aa6b82eb7 100644
--- a/hash-lookup.c
+++ b/hash-lookup.c
@@ -112,7 +112,8 @@ int bsearch_hash(const unsigned char *hash, const uint3=
2_t *fanout_nbo,
=20
 	while (lo < hi) {
 		unsigned mi =3D lo + (hi - lo) / 2;
-		int cmp =3D hashcmp(table + mi * stride, hash);
+		int cmp =3D hashcmp(table + mi * stride, hash,
+				  the_repository->hash_algo);
=20
 		if (!cmp) {
 			if (result)
diff --git a/hash.h b/hash.h
index a1161e1b22..714938e2eb 100644
--- a/hash.h
+++ b/hash.h
@@ -6,11 +6,6 @@
=20
 #define the_hash_algo the_repository->hash_algo
=20
-static inline int hashcmp(const unsigned char *sha1, const unsigned char *=
sha2)
-{
-	return hashcmp_algop(sha1, sha2, the_hash_algo);
-}
-
 static inline int oidcmp(const struct object_id *oid1, const struct object=
_id *oid2)
 {
 	const struct git_hash_algo *algop;
@@ -18,12 +13,7 @@ static inline int oidcmp(const struct object_id *oid1, c=
onst struct object_id *o
 		algop =3D the_hash_algo;
 	else
 		algop =3D &hash_algos[oid1->algo];
-	return hashcmp_algop(oid1->hash, oid2->hash, algop);
-}
-
-static inline int hasheq(const unsigned char *sha1, const unsigned char *s=
ha2)
-{
-	return hasheq_algop(sha1, sha2, the_hash_algo);
+	return hashcmp(oid1->hash, oid2->hash, algop);
 }
=20
 static inline int oideq(const struct object_id *oid1, const struct object_=
id *oid2)
@@ -33,7 +23,7 @@ static inline int oideq(const struct object_id *oid1, con=
st struct object_id *oi
 		algop =3D the_hash_algo;
 	else
 		algop =3D &hash_algos[oid1->algo];
-	return hasheq_algop(oid1->hash, oid2->hash, algop);
+	return hasheq(oid1->hash, oid2->hash, algop);
 }
=20
 static inline int is_null_oid(const struct object_id *oid)
@@ -41,11 +31,6 @@ static inline int is_null_oid(const struct object_id *oi=
d)
 	return oideq(oid, null_oid());
 }
=20
-static inline void hashcpy(unsigned char *sha_dst, const unsigned char *sh=
a_src)
-{
-	memcpy(sha_dst, sha_src, the_hash_algo->rawsz);
-}
-
 /* Like oidcpy() but zero-pads the unused bytes in dst's hash array. */
 static inline void oidcpy_with_padding(struct object_id *dst,
 				       const struct object_id *src)
@@ -62,11 +47,6 @@ static inline void oidcpy_with_padding(struct object_id =
*dst,
 	dst->algo =3D src->algo;
 }
=20
-static inline void hashclr(unsigned char *hash)
-{
-	memset(hash, 0, the_hash_algo->rawsz);
-}
-
 static inline void oidclr(struct object_id *oid)
 {
 	memset(oid->hash, 0, GIT_MAX_RAWSZ);
diff --git a/http-walker.c b/http-walker.c
index b395ef1327..cf7f8c82bc 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -485,7 +485,7 @@ static int fetch_object(struct walker *walker, unsigned=
 char *hash)
=20
 	list_for_each(pos, head) {
 		obj_req =3D list_entry(pos, struct object_request, node);
-		if (hasheq(obj_req->oid.hash, hash))
+		if (hasheq(obj_req->oid.hash, hash, the_repository->hash_algo))
 			break;
 	}
 	if (!obj_req)
diff --git a/match-trees.c b/match-trees.c
index 3412b6a140..849b391d3d 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -237,7 +237,7 @@ static int splice_tree(const struct object_id *oid1, co=
nst char *prefix,
 	} else {
 		rewrite_with =3D oid2;
 	}
-	hashcpy(rewrite_here, rewrite_with->hash);
+	hashcpy(rewrite_here, rewrite_with->hash, the_repository->hash_algo);
 	status =3D write_object_file(buf, sz, OBJ_TREE, result);
 	free(buf);
 	return status;
diff --git a/notes.c b/notes.c
index 53ca25c814..5296fd863f 100644
--- a/notes.c
+++ b/notes.c
@@ -149,7 +149,7 @@ static struct leaf_node *note_tree_find(struct notes_tr=
ee *t,
 	void **p =3D note_tree_search(t, &tree, &n, key_sha1);
 	if (GET_PTR_TYPE(*p) =3D=3D PTR_TYPE_NOTE) {
 		struct leaf_node *l =3D (struct leaf_node *) CLR_PTR_TYPE(*p);
-		if (hasheq(key_sha1, l->key_oid.hash))
+		if (hasheq(key_sha1, l->key_oid.hash, the_repository->hash_algo))
 			return l;
 	}
 	return NULL;
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 6cae670412..59d2e3a387 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -790,7 +790,7 @@ static void write_hash_cache(struct hashfile *f,
 void bitmap_writer_set_checksum(struct bitmap_writer *writer,
 				const unsigned char *sha1)
 {
-	hashcpy(writer->pack_checksum, sha1);
+	hashcpy(writer->pack_checksum, sha1, the_repository->hash_algo);
 }
=20
 void bitmap_writer_finish(struct bitmap_writer *writer,
@@ -816,7 +816,7 @@ void bitmap_writer_finish(struct bitmap_writer *writer,
 	header.version =3D htons(default_version);
 	header.options =3D htons(flags | options);
 	header.entry_count =3D htonl(writer->selected_nr);
-	hashcpy(header.checksum, writer->pack_checksum);
+	hashcpy(header.checksum, writer->pack_checksum, the_repository->hash_algo=
);
=20
 	hashwrite(f, &header, sizeof(header) - GIT_MAX_RAWSZ + the_hash_algo->raw=
sz);
 	dump_bitmap(f, writer->commits);
diff --git a/pack-bitmap.c b/pack-bitmap.c
index fe8e8a51d3..184d28f05c 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -367,7 +367,8 @@ static int open_midx_bitmap_1(struct bitmap_index *bitm=
ap_git,
 	if (load_bitmap_header(bitmap_git) < 0)
 		goto cleanup;
=20
-	if (!hasheq(get_midx_checksum(bitmap_git->midx), bitmap_git->checksum)) {
+	if (!hasheq(get_midx_checksum(bitmap_git->midx), bitmap_git->checksum,
+		    the_repository->hash_algo)) {
 		error(_("checksum doesn't match in MIDX and bitmap"));
 		goto cleanup;
 	}
diff --git a/pack-check.c b/pack-check.c
index 25104d5b14..288f5a3479 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -78,10 +78,11 @@ static int verify_packfile(struct repository *r,
 	} while (offset < pack_sig_ofs);
 	r->hash_algo->final_fn(hash, &ctx);
 	pack_sig =3D use_pack(p, w_curs, pack_sig_ofs, NULL);
-	if (!hasheq(hash, pack_sig))
+	if (!hasheq(hash, pack_sig, r->hash_algo))
 		err =3D error("%s pack checksum mismatch",
 			    p->pack_name);
-	if (!hasheq(index_base + index_size - r->hash_algo->hexsz, pack_sig))
+	if (!hasheq(index_base + index_size - r->hash_algo->hexsz, pack_sig,
+		    r->hash_algo))
 		err =3D error("%s pack checksum does not match its index",
 			    p->pack_name);
 	unuse_pack(w_curs);
diff --git a/pack-write.c b/pack-write.c
index 80ecfa544c..eef625fa5b 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -428,7 +428,8 @@ void fixup_pack_header_footer(int pack_fd,
 		if (partial_pack_offset =3D=3D 0) {
 			unsigned char hash[GIT_MAX_RAWSZ];
 			the_hash_algo->final_fn(hash, &old_hash_ctx);
-			if (!hasheq(hash, partial_pack_hash))
+			if (!hasheq(hash, partial_pack_hash,
+				    the_repository->hash_algo))
 				die("Unexpected checksum for %s "
 				    "(disk corruption?)", pack_name);
 			/*
diff --git a/packfile.c b/packfile.c
index d4df7fdeea..9156e9122c 100644
--- a/packfile.c
+++ b/packfile.c
@@ -242,7 +242,7 @@ struct packed_git *parse_pack_index(unsigned char *sha1=
, const char *idx_path)
 	struct packed_git *p =3D alloc_packed_git(alloc);
=20
 	memcpy(p->pack_name, path, alloc); /* includes NUL */
-	hashcpy(p->hash, sha1);
+	hashcpy(p->hash, sha1, the_repository->hash_algo);
 	if (check_packed_git_idx(idx_path, p)) {
 		free(p);
 		return NULL;
@@ -596,7 +596,7 @@ static int open_packed_git_1(struct packed_git *p)
 	if (read_result !=3D hashsz)
 		return error("packfile %s signature is unavailable", p->pack_name);
 	idx_hash =3D ((unsigned char *)p->index_data) + p->index_size - hashsz * =
2;
-	if (!hasheq(hash, idx_hash))
+	if (!hasheq(hash, idx_hash, the_repository->hash_algo))
 		return error("packfile %s does not match index", p->pack_name);
 	return 0;
 }
@@ -751,7 +751,7 @@ struct packed_git *add_packed_git(const char *path, siz=
e_t path_len, int local)
 	p->mtime =3D st.st_mtime;
 	if (path_len < the_hash_algo->hexsz ||
 	    get_hash_hex(path + path_len - the_hash_algo->hexsz, p->hash))
-		hashclr(p->hash);
+		hashclr(p->hash, the_repository->hash_algo);
 	return p;
 }
=20
@@ -1971,7 +1971,7 @@ off_t find_pack_entry_one(const unsigned char *sha1,
 			return 0;
 	}
=20
-	hashcpy(oid.hash, sha1);
+	hashcpy(oid.hash, sha1, the_repository->hash_algo);
 	if (bsearch_pack(&oid, p, &result))
 		return nth_packed_object_offset(p, result);
 	return 0;
diff --git a/read-cache.c b/read-cache.c
index 10e002ce6d..2642ac9558 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1735,7 +1735,7 @@ static int verify_hdr(const struct cache_header *hdr,=
 unsigned long size)
 	the_hash_algo->init_fn(&c);
 	the_hash_algo->update_fn(&c, hdr, size - the_hash_algo->rawsz);
 	the_hash_algo->final_fn(hash, &c);
-	if (!hasheq(hash, start))
+	if (!hasheq(hash, start, the_repository->hash_algo))
 		return error(_("bad index file sha1 signature"));
 	return 0;
 }
@@ -2641,7 +2641,7 @@ static void copy_cache_entry_to_ondisk(struct ondisk_=
cache_entry *ondisk,
 	ondisk->uid  =3D htonl(ce->ce_stat_data.sd_uid);
 	ondisk->gid  =3D htonl(ce->ce_stat_data.sd_gid);
 	ondisk->size =3D htonl(ce->ce_stat_data.sd_size);
-	hashcpy(ondisk->data, ce->oid.hash);
+	hashcpy(ondisk->data, ce->oid.hash, the_repository->hash_algo);
=20
 	flags =3D ce->ce_flags & ~CE_NAMEMASK;
 	flags |=3D (ce_namelen(ce) >=3D CE_NAMEMASK ? CE_NAMEMASK : ce_namelen(ce=
));
@@ -2730,7 +2730,7 @@ static int verify_index_from(const struct index_state=
 *istate, const char *path)
 	if (n !=3D the_hash_algo->rawsz)
 		goto out;
=20
-	if (!hasheq(istate->oid.hash, hash))
+	if (!hasheq(istate->oid.hash, hash, the_repository->hash_algo))
 		goto out;
=20
 	close(fd);
@@ -3603,7 +3603,7 @@ static size_t read_eoie_extension(const char *mmap, s=
ize_t mmap_size)
 		src_offset +=3D extsize;
 	}
 	the_hash_algo->final_fn(hash, &c);
-	if (!hasheq(hash, (const unsigned char *)index))
+	if (!hasheq(hash, (const unsigned char *)index, the_repository->hash_algo=
))
 		return 0;
=20
 	/* Validate that the extension offsets returned us back to the eoie exten=
sion. */
--=20
2.45.2.457.g8d94cfb545.dirty


--iC1ZFNsSGezsDCpH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZqjgoACgkQVbJhu7ck
PpQOIQ/+NffvfRu+DMEr7JMOVOT3DOtme0a+qbKRzFC4TD5p0v5ECM9UL4x1u7TJ
rzaBu49sU38uQio1VnQRqdLPWLmZgUmZ9chs3gZQAWs13xjbFNzGl2Ve2bV4LM7N
j3crnTxdK+2hzmz/1hUJbEFp2dfMvSWqrkxmB+Gq3DR5oHR6mkwf7ZQt5XjMm7KJ
Xt1CtziEoSY8nAtFIEY8vrAig+LnV9dcMFk5bGY3nblBCvdvt3EeVuzwtsV8Da8d
k7z/nYdZ+jW/cdeARk+RUPm9k+QDupWceDLeRyczymNyHWMAfFDdthjPV9scsH49
vG74BSapF6YY+iztQR9bh18fSgOl2oAqsqq3zHEXzmdtyEGJWT/VfisCIhY26Dvy
LRRXakf05LejqvmLRkPaOypvU0K7BHaEoiq0g7MncMvMJCTvGOpfsrD/WiziyFAr
KBTUqtsP7TiyqQLWN+35902Yy/u0QOswejk5Sp63JyRtDWvbzEUvcfd9ZFfFbn+U
IMUAhMgKa6mqItv+p0ha5B2+cvfSO8GDbmd7yhB5D9wC/NVF9VpzT7fSTmyOAu69
9BaYwzYxYEDw38jOf3hQ9JJ3duAe/HnWsoPIps0wpMxRf07DwaLmG2evEjCReTs1
4+5ZguztqOjHN5UoRQZbuU9iNFo1c2hslhaVb4s1bfjpmogGF+Y=
=A1je
-----END PGP SIGNATURE-----

--iC1ZFNsSGezsDCpH--
