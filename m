Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE4E136E15
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 06:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718259226; cv=none; b=m7ZWd5vs9pSfFpbH7eWb3tJGloedHmudUjfK0lM4EN1zEkFWboXRRfOMcowvoTBVTodjGmaFqvutu3pbSgTN4+MtuoSgT2DmwIkmTPnQRrUjd3FXH12rchQJZixJKIKmfgIgPj9CIlhhg/zLJ2qf7ZHBF1KSt9DP5N/7u2ss3Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718259226; c=relaxed/simple;
	bh=VOhU519ExT0DiHoUxW7wOWNK0sqEntKzcCOi4wkT2D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwvOCIZOrmItCN1RXikiFUn64RDq1Is63Xo+5fuj+HKDx3i33iUHiycuOYSdRkvz1Jqxcwa1KaVyq275IuNlgGZ/4vlwJTyvy2Q4wFgCW4CW37MKDY23ARhr1B1Dto/3uuG91DtSrW8kYD+sCmCHSYhSjzw8cLAn08FOgtTu/Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nGU8bwAi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TNh0j4XU; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nGU8bwAi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TNh0j4XU"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 57F1B1C000D0;
	Thu, 13 Jun 2024 02:13:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 13 Jun 2024 02:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718259223; x=1718345623; bh=jttBxGIt5l
	X594QRFHtU9NJNXKpQpBNieUsbmUXMnak=; b=nGU8bwAiXaCLdoDsG9cVaTlNFO
	EHqA/xVfGKqpAP4Ozkb1FkJGtNDaS2bIt3hSv/xlqQGr1SMsUmDukPtZacCCjinF
	AcAJxcXqTLhj8ix43RmT67TO8tdYbL58taWZCvN1ct4ks//80xlmen9J31CVj278
	adK8ecSebzvc1UWxLtri4SzzcIgDhC6wq8aZV1L0lmpRccSmjV0J0/GfeUYVdlAl
	8Lz1II24xh/j27GHvhX9haByN548p/+Gtm2U0zR0FYP8D/3A7g54MnYsScR3SqFM
	J2WUbD4i1S9X3V6mn1yPLICEiMv1yirEVGIn8L+Tgiv6l/fXhwhbREPX+Yxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718259223; x=1718345623; bh=jttBxGIt5lX594QRFHtU9NJNXKpQ
	pBNieUsbmUXMnak=; b=TNh0j4XUZ0TLFgeNi6U1YemY3m0O+iUoK2d0XeaxhWtL
	SNDT6rX6TtD3EevdH1f8BHEPglTFHPD9IrU1YtWaZoHsVwyluy/nqsVKqJqf3a0O
	UlHv+ytwRHn/8u2Q/S/xTniXquLabwYVec2OlWz1jdHMMrHC8i7kiDSSwnsRRbbC
	fhcFB81WwitziOvaX627y/tpv91ma7pVQKYZVJXwfrur7KsdtgtWEgujAnJat2JV
	1SPOryJHRdaJWYYYpqbsVIFvSYaso97e5+V7/gu94P8vmCg2ENmPTvEuLrdvku3f
	gekHfBn2hk6GvHDLVBpQOIrOE2EreyruzXZrgFG9kA==
X-ME-Sender: <xms:F45qZmUtq0cZZx2M5F_gfrwR1UeNqPXrhcWOQC-s5wxG3hzED0C9rQ>
    <xme:F45qZikuvQULORK-88OKQLLoj9ITFO9kd2N4Q9BzOU34BDwIQvrBA1hBvcodWlhdm
    rNZIMPm_96QyNCQSQ>
X-ME-Received: <xmr:F45qZqbVMXwUh0_4EviBwKhB0XNJ8ZjMTt0YAD-nwtjhA9AZiujGAwcrbp4NDUps8b3ZsSDOrN1pQ3EVzYTkxaPaywc52LcSE3bJPv3Pdq1JhtpkMT8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduiedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:F45qZtWHFtXSGO6xuh6hIYvJIg_l1SrbHYePJEsNOwdf10xpwW6lJQ>
    <xmx:F45qZgn4QCNnKrUoiVcA_Qk1fIBkPjOjn51vtYd0h6w7UgdArC6Xqw>
    <xmx:F45qZidOtFgQprrUd8jBLIL_gB7-8Rw8stOYCayLfEGAZX3lTWUPog>
    <xmx:F45qZiHijRNq2m2QsA4TCytr5qJUTWkyQuuZXc9hfoL0x_Nj7ytCNg>
    <xmx:F45qZqixE9ax4mb-kFNu8WUZpP0B7idJd9inTEyvgaYwkl4EBjP1RUcb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 02:13:42 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id fa405a7c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Jun 2024 06:13:30 +0000 (UTC)
Date: Thu, 13 Jun 2024 08:13:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 04/20] global: ensure that object IDs are always padded
Message-ID: <fa263d6b0777ba8d157f7364507590c19069ed56.1718259125.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
 <cover.1718259125.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wvWqfqJBGniy1VM4"
Content-Disposition: inline
In-Reply-To: <cover.1718259125.git.ps@pks.im>


--wvWqfqJBGniy1VM4
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


--wvWqfqJBGniy1VM4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZqjhMACgkQVbJhu7ck
PpRt4g//R8uxk+Hrd7HVtCXZoCTUBajDJdMU7870jihna40eYdYwEL39nN7XhrLM
E8BVWINoVdOSnRZvWRRwStC5RgkL7FKmWDIQ5FZXg4P8olHv0WtHl4M3xlyJninA
iLRaCADAeF16ueccskxV5M5+cpmVTkpZs3cDuFqzVCCxpxvStxzNcCbbBK4qQouD
DAlCIZMkCK+ze+qtkKm0wlQi+0dbYAQtxa77P6nQSQsggf2/XZ0+gXtYInE/RR/O
86Btoy2aRPEzh7OfHz7EJdOlRyrbaKWtzV4joG0KKkAfSvC+pLwhmg6gmMR2T6xJ
FdYY58mZ4iWhrbMYfDcyPXByee5paL/f83ePMDJ2tTSf1v45zz/qGWOrTajrOgWG
F1eK6wO9NG+jJhExW9Kt4dbOjFi/wyQV5Wfh7iTNMwV06VX90HIiCKyshvojUAlL
2jY4rcDZRcqdA34NxkOT1B4VP07jvcnRbXUZspWXPS7DOlvy1GiXx/OZYmvRqm3P
AIVooJFuDzy36mfwCixQXdSwQdbml6d/LxLgaLh/mdxWT9BraNLFf5hsy91W6um0
TydYVj8iT4HfXz/mM02BikPP460JQBT7s4APpotGNDimkyiamGL7LoiLSsMoXELb
ewyYjDFl8N8I2gSw4tcD9wW6pFjlte0OE3ZrrghzEF3ZPB4Dv8Y=
=gLGL
-----END PGP SIGNATURE-----

--wvWqfqJBGniy1VM4--
