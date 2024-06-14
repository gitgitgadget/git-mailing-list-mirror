Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D601487EA
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 06:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718347805; cv=none; b=Nr37Z2OC18mWOmulNsY9eFjaW+9RfJLtOddDHuJdJciXNUlw2YKC0J4vVTTXKlsB3m6T8bLD9lb+A/CwkzlPFBoSO3oIH1ApHCEwueJazHY4z7wXh3O7V4zou34A6EmcLhz9C7zHN/zu3XBjz0tIWsEELYsBbiF71wuOw0TF6eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718347805; c=relaxed/simple;
	bh=jpdHT/r8GIC8F3dby8iphvEqEL1vTFOLPDStwFiX2X8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlY/cchbLMUtMO+iuSOiH+Mzq2L1gyKax1YO6C35SXjrEJBMC11PemuFPJpyaZKGHq9OELhhkXROglncN+1EjOu9Ju+T1QPC2BDmgtPoGH3+xr4XAg0hR7GrL5zFUbTPtIR9OJ9jWjd692SMqweHtX1RfdOEAOgFSH//KYcnbdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PcdT0e/p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XVZi9wO9; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PcdT0e/p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XVZi9wO9"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3A57613803F0;
	Fri, 14 Jun 2024 02:50:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 14 Jun 2024 02:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718347803; x=1718434203; bh=GeXffzxIge
	DqKmCI3TL1g9JdTnkDpJ2jPrMGKQ8qF6g=; b=PcdT0e/pQw/5UlpOErRTKBPyyA
	V+5DC77KUs5lbuL6HFF/MaxrHvtwbGIqnwoToo6QZwFTt5DaiYPrE4nC70lVahpk
	uBWqDxdEb5XT/bf/HDIxcJp6i+K/BdgWlW6PWbvH7iz8n6VEYQChzdWBmZn6ZkJ4
	Ibg6U2/9CLjpBmnfwL05FHzoCi22828iPR9Arpm5ZvbuySgcmsGAX8/XXfXqIbZb
	htLLnxE0bfRMj4bfegScDUWI+gHmJzKt2g6KX8JXQ4ZKMH/zlVT6r4eKaE7ZqX0A
	WyN5v6IzTvX8/fv7Xo6ZHLQHB9tjMrwe88Wj9QILO4ewTHXrJ3vXICDMipLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718347803; x=1718434203; bh=GeXffzxIgeDqKmCI3TL1g9JdTnkD
	pJ2jPrMGKQ8qF6g=; b=XVZi9wO9pyxauiSZhn7XfBmFZbkz0M6p1tvsvwn1MjzH
	befh0mUM7rcP7cl+XgFIJrnwl18Yth3NXhGKHIjQrL6xa+edhK/Kr504cey+edAL
	UXL6WrwY3cI2MSKdyFV24I+NSmWdBMgXFAdgxxrg4Xe86j7BbyF0A7sVchdr3RXW
	ReavmlTVVYYo3GMlHRekq34EzLKTVqoHdmBJzspSFkXW/lOD+n+GBhVM9WWxSZf+
	ZNTDm53E/bVfqD39OgyrsWBH3d8tTzM3FLUK3P11uWIVNBYfHRGznmZ2HEwm+lTh
	vA+OpYKK1sKuMzY3pR20S0FZUIa5fUIothU10HuXag==
X-ME-Sender: <xms:G-hrZi0-rnKDcDGMSMOz2lgY23fBWqGPr69BL0T-rDYKe_FgMvnvqQ>
    <xme:G-hrZlEDf_9scX8rFcCAl8D1FhoXETgLKk4i9hpqibytYX9m3DJPMJeEvK3-UoZ_X
    1Fk2jKIHmp1Lwg_CQ>
X-ME-Received: <xmr:G-hrZq6HGypm9OWqd-wRFLf6sONvQQPT37drjyZMPhuiWxwc1H71VB4ebOXIrwOKgv4qCkVbME7fe1xp3gBfTwH8kjAYMGSxocYnCpFnQWmCdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedukedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:G-hrZj2F6uYXuBGavNGi0bJ6EK_rDPL3GpObTVkEx_1IazbxLFkGOA>
    <xmx:G-hrZlFND_wnIV_tjcMJSJhur7X7FyJoOMq6X0b8lkEYZ9xkcsVItA>
    <xmx:G-hrZs9NjRc3nDNIDvkML9c8GA4zvkSVwR2LVo2-m0GT1ZLleuBNpA>
    <xmx:G-hrZqmsg6oOixr7FKtN52oR8FoPUoTlJ0xrFjIW_xUJaGTeo0hk4A>
    <xmx:G-hrZuOBFDa4cmm234KbvjJ_fe-HQIfNA1o0cu9MSQAS-tldVOyKAlvw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jun 2024 02:50:01 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6d77e03e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 14 Jun 2024 06:49:46 +0000 (UTC)
Date: Fri, 14 Jun 2024 08:49:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 04/20] global: ensure that object IDs are always padded
Message-ID: <3947c0c04dafa470facb7c9dd03133d69d09a161.1718347699.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
 <cover.1718347699.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v/J78HcwJmg+vtRa"
Content-Disposition: inline
In-Reply-To: <cover.1718347699.git.ps@pks.im>


--v/J78HcwJmg+vtRa
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
2.45.2.457.g8d94cfb545.dirty


--v/J78HcwJmg+vtRa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZr6BYACgkQVbJhu7ck
PpRSVA//ZWpvpC2TNXTZZ6WEpuAXnBB06t6GdLwe5zkUaC/hpH7A7hOxQimPBfSh
uUyMtJlfZUJwiPD/WIeNZxINDEEPbAnvD5ejAmzJPtiCdyO5JLiLYkyN5llLrgeD
2j4TR4/dj3ILpC/+MCeBdiP15O9FAvj8D/mbnSnYvjXAiScjAQ2pEhJy/28UdgFM
UtjJbRo+W2pHbBIZPYNN8unaBd7BiKp5k+V5tcyI3SWJWX77XxX6bekRVWiTsD1t
X/QpJ0C8Y46qPezAIhKwr+XQVg7nbiadZ7/XOkK/qKZFt2moQJcgae+PttKb9dnQ
rCpTosg3nK9egKJPwp5WpAMI/266MIkRGuv461e0xYaD63EZXIrZaDZShz3zZkcJ
SOlntyYirxD5r5Hw4d+f/Go5BmuUfbKH2QPwEF0A/UuR48OC40Jx/V/qgFCroyIL
8VfQ7WS92/i16QAbufUPPtmHaW8u6O5UIr5eJwxMthWhnRUwCVSHrwR/sWzQe5Eq
fmr5MlljsDFfoPmHRZxjuW0dV+IJu5cNV7mV3a4gyp0KiA+k8L359Zlhb2CKNKbv
FR9PlPlBfsGVtC0ClR4tumta6pxfwBW+wItTjZimz0DdWDl8wLqlG75A50M58FO5
NKPPkmMLit5QHcJ3NMx4B7s/VLrGELOHb7SIfvNq3v30bFv8Cek=
=A4id
-----END PGP SIGNATURE-----

--v/J78HcwJmg+vtRa--
