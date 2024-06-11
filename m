Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9F117B514
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 11:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718107077; cv=none; b=HHG/DloBoSTofSJRQQzF+n3B3PUoj5I8VSLECFugi6DRk05HVsmTNnq5L3e6QlY4P+TH5AcsLaXhUIuCOMtpGWx554NDNdWcFZdkS4mO1npva3IOyjiSMK+BZd8UrGsi4D6eiIOwYzpPuE3TGUYwhbckctwbNItrGAlIjchkGfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718107077; c=relaxed/simple;
	bh=hIQ68yPcmCVOS8O8kJrQhVzEi5mm3h7Qqnd0agIRVp0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpQDQoFZmaMWrpD9ohA+5HEBlpBjfA1Xs4uUUUNcTFmoksw7hhw5r0e+mHfSBngBGcGldFrQUq0FOatXwWJcorkbP/uPud651YasvpmrNS4WVB58qOiBGYR4sZnw1oc2onxwsx1M6jhMyrxftrsM69dUH+WTV2MUy25rmQ2Ntf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VKratZin; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=irzVIwgV; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VKratZin";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="irzVIwgV"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 8811C1800060
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 07:57:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 11 Jun 2024 07:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718107075; x=1718193475; bh=iZp6dvV947
	9+yeQp/Bo3rnJe/OU819RQgjsZEzRZtbI=; b=VKratZinge5A37B7KViPXfWhTv
	3QjufOtd330ZQuhLCSyqhJWgCC2SVlQHoywFPZEuGUsgF6U7mtatz3iLexgAkM8Z
	tSIlEjUzInme4BMQ8RGfVUFyHaZkp9C1e2ARJxaM+iXDnLGO5UyL+uRK/sCYh7oh
	plMw7JJv6JaUMuZxUF9fSK2JqdH3L/COpKF310ytOLPdLljMl77qQz2Awj1l1+Co
	sPqpsEDCcV5v2aGQwsioeY1o1Cko0Fd22g7RixUZmrV6guyCPcIV5rYXQZJ0gbTx
	iJDffivqyB9pnIn8abWsroFqpWtfSvFtN83ZW3Nun/y3eecyXUIo/v+usxnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718107075; x=1718193475; bh=iZp6dvV9479+yeQp/Bo3rnJe/OU8
	19RQgjsZEzRZtbI=; b=irzVIwgVtvAJxlC5TqPPJ+QYcyLnCJN1UloXm31XY3Sj
	58pCNUyA9gvnXLBnxUfREvTGiYnpZjRkwf7tXYMfJ5VQfbpDCzhz8KUV4f+Brubi
	JeUD17qRJX/S7XSiHgmVVibNjQtkd5qOCr70Uauw266qfbi963lwUpVk5aBD8Aja
	pO6b+AqFvQdN7dygImHGwnR/9l4/IAVo6AaI0GqsuqJ/E0wtC3Vyz8FAgTSLIZEz
	Hm5m9Wg2jhldSaqR9tmirB4B+j0YGnm7Y7SSanHLKShA83lXv6SqlOFGQAf+Pdx0
	FkOLDCbOX43Q+fbLkllMdDvKAlP16XP4MUuusa6Hlg==
X-ME-Sender: <xms:wjtoZtudzv3q2-mLhI9TKFHqRnL_r3uAUAmRP_wmAbgJP9DQw8WLkw>
    <xme:wjtoZmcUpmolNJ62zZ6lI0E7-ZC0LwACrzptGFgNlyRJ3eYce1gAQ6HXTA62aKlLo
    dVbDO6QVycbNR5POA>
X-ME-Received: <xmr:wjtoZgySX7f6kXGrD64RqA_ZxpAPzMARGJ-n81u-5wIn6KnbtzzGwXRZnY0QtKkAeqgEZPIHpoWo4Q-ccJIB4NkyPUBImRAgIp2aKfkKqFV7QCrctQus>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:wjtoZkNj20B4WrMX57YUYnWJql944SmZk_FbbwkB7WkAS835cAUcQQ>
    <xmx:wztoZt85n5C8boXiOy9yHl81fhIMsBlxQBxUa5ujdi9oeYC5kE7DiQ>
    <xmx:wztoZkWaRN6TLt_a_3r3NOV_t-9hI1aF5Imh-i_wvwCHuB1liC1Mpw>
    <xmx:wztoZuc-CcaI4FQAlhDkr-O0e45AAfxASqycJjobsRkUkEuqdLEoqQ>
    <xmx:wztoZvlz9K-EOKgDq0jc_vneEWm-LHLIGDrv_C-La0XeEyBC0GoQZTzG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 11 Jun 2024 07:57:54 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1a2345f9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 11 Jun 2024 11:57:45 +0000 (UTC)
Date: Tue, 11 Jun 2024 13:57:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 04/21] global: ensure that object IDs are always padded
Message-ID: <3ff28f313b2325cc6917d4c82a3064a94af6fd9d.1718106285.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="prRJD0qZLC79JfgT"
Content-Disposition: inline
In-Reply-To: <cover.1718106284.git.ps@pks.im>


--prRJD0qZLC79JfgT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `oidcmp()` and `oideq()` functions only compare the prefix length as
specified by the given hash algorithm. This mandates that the object IDs
have a valid hash algorithm set, or otherwise we wouldn't be able to
figure out that prefix. As we do not have a hash algorithm in many
cases, for example when handling null object IDs, this assumption cannot
always be fulfilled. We thus have a fallback in place that instead uses
`the_repository` to derive the hash function. This implicit dependency
is hidden away from callers and can be quite surprising, especially in
contexts where there may be no repository.

In theory, we can adapt those functions to always memcmp(3P) the whole
length of their hash arrays. But there exist a couple of sites where we
populate `struct object_id`s such that only the prefix of its hash that
is actually used by the hash algorithm is populated. The remaining bytes
are left uninitialized. The fact that those bytes are uninitialized also
leads to warnings under Valgrind in some places where we copy those
bytes.

Refactor callsites where we populate object IDs to always initialize all
bytes. This also allows us to get rid of `oidcpy_with_padding()`, for
one because the input is now fully initialized, and because `oidcpy()`
will now always copy the whole hash array.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 hash-ll.h           |  2 ++
 hash.h              | 16 ----------------
 hex.c               |  6 +++++-
 http-push.c         |  1 +
 notes.c             |  2 ++
 object-file.c       |  2 ++
 oidtree.c           |  4 ++--
 parallel-checkout.c |  8 +-------
 8 files changed, 15 insertions(+), 26 deletions(-)

diff --git a/hash-ll.h b/hash-ll.h
index dbb96369fc..b72f84f4ae 100644
--- a/hash-ll.h
+++ b/hash-ll.h
@@ -288,6 +288,8 @@ static inline void oidread(struct object_id *oid, const=
 unsigned char *hash,
 			   const struct git_hash_algo *algop)
 {
 	memcpy(oid->hash, hash, algop->rawsz);
+	if (algop->rawsz < GIT_MAX_RAWSZ)
+		memset(oid->hash + algop->rawsz, 0, GIT_MAX_RAWSZ - algop->rawsz);
 	oid->algo =3D hash_algo_by_ptr(algop);
 }
=20
diff --git a/hash.h b/hash.h
index 43623a0c86..e43e3d8b5a 100644
--- a/hash.h
+++ b/hash.h
@@ -31,22 +31,6 @@ static inline int is_null_oid(const struct object_id *oi=
d)
 	return oideq(oid, null_oid());
 }
=20
-/* Like oidcpy() but zero-pads the unused bytes in dst's hash array. */
-static inline void oidcpy_with_padding(struct object_id *dst,
-				       const struct object_id *src)
-{
-	size_t hashsz;
-
-	if (!src->algo)
-		hashsz =3D the_hash_algo->rawsz;
-	else
-		hashsz =3D hash_algos[src->algo].rawsz;
-
-	memcpy(dst->hash, src->hash, hashsz);
-	memset(dst->hash + hashsz, 0, GIT_MAX_RAWSZ - hashsz);
-	dst->algo =3D src->algo;
-}
-
 static inline int is_empty_blob_oid(const struct object_id *oid)
 {
 	return oideq(oid, the_hash_algo->empty_blob);
diff --git a/hex.c b/hex.c
index d42262bdca..bc9e86a978 100644
--- a/hex.c
+++ b/hex.c
@@ -25,8 +25,12 @@ int get_oid_hex_algop(const char *hex, struct object_id =
*oid,
 		      const struct git_hash_algo *algop)
 {
 	int ret =3D get_hash_hex_algop(hex, oid->hash, algop);
-	if (!ret)
+	if (!ret) {
 		oid_set_algo(oid, algop);
+		if (algop->rawsz !=3D GIT_MAX_RAWSZ)
+			memset(oid->hash + algop->rawsz, 0,
+			       GIT_MAX_RAWSZ - algop->rawsz);
+	}
 	return ret;
 }
=20
diff --git a/http-push.c b/http-push.c
index 86de238b84..a97df4a1fb 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1016,6 +1016,7 @@ static void remote_ls(const char *path, int flags,
 /* extract hex from sharded "xx/x{38}" filename */
 static int get_oid_hex_from_objpath(const char *path, struct object_id *oi=
d)
 {
+	memset(oid->hash, 0, GIT_MAX_RAWSZ);
 	oid->algo =3D hash_algo_by_ptr(the_hash_algo);
=20
 	if (strlen(path) !=3D the_hash_algo->hexsz + 1)
diff --git a/notes.c b/notes.c
index 3a8da92fb9..afe2e2882e 100644
--- a/notes.c
+++ b/notes.c
@@ -427,6 +427,8 @@ static void load_subtree(struct notes_tree *t, struct l=
eaf_node *subtree,
 					 hashsz - prefix_len))
 				goto handle_non_note; /* entry.path is not a SHA1 */
=20
+			memset(object_oid.hash + hashsz, 0, GIT_MAX_RAWSZ - hashsz);
+
 			type =3D PTR_TYPE_NOTE;
 		} else if (path_len =3D=3D 2) {
 			/* This is potentially an internal node */
diff --git a/object-file.c b/object-file.c
index c161e3e2a5..bb97f8a809 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2743,6 +2743,8 @@ int for_each_file_in_obj_subdir(unsigned int subdir_n=
r,
 		    !hex_to_bytes(oid.hash + 1, de->d_name,
 				  the_hash_algo->rawsz - 1)) {
 			oid_set_algo(&oid, the_hash_algo);
+			memset(oid.hash + the_hash_algo->rawsz, 0,
+			       GIT_MAX_RAWSZ - the_hash_algo->rawsz);
 			if (obj_cb) {
 				r =3D obj_cb(&oid, path->buf, data);
 				if (r)
diff --git a/oidtree.c b/oidtree.c
index daef175dc7..92d03b52db 100644
--- a/oidtree.c
+++ b/oidtree.c
@@ -42,7 +42,7 @@ void oidtree_insert(struct oidtree *ot, const struct obje=
ct_id *oid)
 	 * Clear the padding and copy the result in separate steps to
 	 * respect the 4-byte alignment needed by struct object_id.
 	 */
-	oidcpy_with_padding(&k, oid);
+	oidcpy(&k, oid);
 	memcpy(on->k, &k, sizeof(k));
=20
 	/*
@@ -60,7 +60,7 @@ int oidtree_contains(struct oidtree *ot, const struct obj=
ect_id *oid)
 	struct object_id k;
 	size_t klen =3D sizeof(k);
=20
-	oidcpy_with_padding(&k, oid);
+	oidcpy(&k, oid);
=20
 	if (oid->algo =3D=3D GIT_HASH_UNKNOWN)
 		klen -=3D sizeof(oid->algo);
diff --git a/parallel-checkout.c b/parallel-checkout.c
index b5a714c711..08b960aac8 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -429,13 +429,7 @@ static void send_one_item(int fd, struct parallel_chec=
kout_item *pc_item)
 	fixed_portion->ident =3D pc_item->ca.ident;
 	fixed_portion->name_len =3D name_len;
 	fixed_portion->working_tree_encoding_len =3D working_tree_encoding_len;
-	/*
-	 * We pad the unused bytes in the hash array because, otherwise,
-	 * Valgrind would complain about passing uninitialized bytes to a
-	 * write() syscall. The warning doesn't represent any real risk here,
-	 * but it could hinder the detection of actual errors.
-	 */
-	oidcpy_with_padding(&fixed_portion->oid, &pc_item->ce->oid);
+	oidcpy(&fixed_portion->oid, &pc_item->ce->oid);
=20
 	variant =3D data + sizeof(*fixed_portion);
 	if (working_tree_encoding_len) {
--=20
2.45.2.436.gcd77e87115.dirty


--prRJD0qZLC79JfgT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoO74ACgkQVbJhu7ck
PpQdew/9Gvtn6LsKSGvmWvsOmpPgmoA7yc5bdP2TUJrz4JUQwFjpdifqoemRMaSw
ydXja88nM1UeS42VSwAgH8p3GhrAfPnRzTGFdIizi1+FaG88txtAC1duGy68ichn
IEO7K8Z7Sk8p2TGLZ1334DPCqgysdwG0v8KmgXv+Ll3I144cxoZH9LaRd7SL43IV
H0PLgkUYZeBKl51/oFjU8lTCT+rYLO+Td9tUxDTgUKR3gyNZGnXKe+DE0kxYdNyr
MK3F4OryD8Zrhal4VLp5V+sE66/xpQDD8lis/jT/sQMqFGrrIHabwX4dUyhvS1bP
Y6GsUBrUPAs6Gj6UGvZWBGF/muRUwREVkvZUlRn4yUG9RsREPf27Q7wuSx/BPGQx
85ECEQR+GciNlBDsE4DvmUsmpqYtWh7Kn+lKt9hcTukXOKRIBCbJp6gYQ3iyMp0z
631dUswFxzzceTslpbS7sZ5DKU2R+9pzSilv1rTCXAXOYt4CrRG/5GkWg1EmT0nO
3ThmKxhbySfb+wfwcxl6A23mIErFuIYlQO5vqkXN0jSIWwELoKOoeeiR8oQ2NGvl
oaZttms8lkLAV9RxbKUC9gIVX0D0EqIxsceqexBcu8GoLJPMHCcKmEoTkhpzzleb
5GwmUd8Oc79F0aJHBSuS4rQ/mzQ3PcNr8bbDMO58fUf4nsD9rPY=
=gnl6
-----END PGP SIGNATURE-----

--prRJD0qZLC79JfgT--
