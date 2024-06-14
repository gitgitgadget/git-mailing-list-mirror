Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01811487ED
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 06:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718347819; cv=none; b=jfKy5JFk5tp4MB1iNI7tgWyMvoNx3wBniwWhnG76Vn1aciiExRlttuaq/EP2tUoHIX4ghMwTwCKG5UZkxy6EVxt7o3yv6uzp7XqS3iRT440ZHUxCHYzOQBdSUp7mQeByQhCaVhUkX3IlPiWWUCIBoigMeIj/7t/XxGVmEnx2O94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718347819; c=relaxed/simple;
	bh=k15ZaAVOf2jZfwtgz/+53adUBAZ6pzQ6wbR+xIgkHFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEgtmRaqB1V1eCudbsJ6GY8tPoGskXTkk4XagNe1o3IGi16UsxU7900IHw+348jbXOvAhNnh71yeohp7penJNeYirlRM64xWvaN8GlNuVShQzjebtnY8KE+P/nrSXAqSGPOj5vXCe8UjqHMVcY5uFI5j2aSGRXMGk1l0CCOd6wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dz3ezpEb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ns+gIl4p; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dz3ezpEb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ns+gIl4p"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id AE15613803F8;
	Fri, 14 Jun 2024 02:50:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 14 Jun 2024 02:50:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718347816; x=1718434216; bh=Uk0hsnscOj
	I+rHHVyUqduP/MtWsMUEJZExxK5mAecoY=; b=dz3ezpEbP19Wm5a5k7uHp0JS0z
	1N+XgKT/s5W35vSGJ/iy3w9GMuBK0LUJFID+sYamjwzKyTMi51IuMeDSif6sfYe6
	6JRuzQYSZpQDZiyfF2uqT37FFS6WVSBdfx2eqSUvgS2dQWJc6MDOucx+5tkiq3zc
	Bf00z5GW2W0i5l1YDJQjo4hdregV7LJOpAMuwHpd4ORwWzn6QY2zXuiweGfMMLje
	Kmmi0GxwpxRhmA7NfBKO6QTQaep80YOEXAcyf+ootlOBOfZFaQaImZJfd0bhIHHF
	9NlyXL7EOAWIruXh4sEAPs0Ma+kBm8hGec6BOq3bGDVGpQx+qIoTgpBb+OAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718347816; x=1718434216; bh=Uk0hsnscOjI+rHHVyUqduP/MtWsM
	UEJZExxK5mAecoY=; b=Ns+gIl4pIxDWua0LWrxAcWOhWShGz7fK2fV4yG35lv4S
	8Wq/Z1oyOdVYUm+Zf7ebXg/An55Cwp/vifiqdMS6cSzhODidFVZriSUchN7AOHLB
	iF7+W1MIGrgLs99wzUbKmvnM4QNanxbbRCA88llKG+BdY5Bwz+iYWYVt6gbNeGnw
	u0SCx2fvxLh4bfCGW9cl1HhnkpL54wY5xADjR0XK4kolOEnQsyAjZ57g9+cwweVK
	50Rij/pdX/6BJFLCYp/0gqfkJcDsTKdlvAHKS682lyfbL3kTOppm1zRdEyGUpJIF
	5tBClMHvZYE5FwRY+p8oe4gyZfm3WVEEvm2pDADDyQ==
X-ME-Sender: <xms:KOhrZusXga-Dm3sjl_05o7lU2qk6ixE7rZbntWo-6SQyT8trqHO5PA>
    <xme:KOhrZjdtDtQG8J_6_vlPyBadoHb7sAQzk_5qcbKxwvOBPoNVudKjDx1mXmIVx9341
    uQ9wIRj97jYWtDq4A>
X-ME-Received: <xmr:KOhrZpxCWJiQPgCB0bYJDJg7LtIjQPIZRSFDHZEltmFaN31aPI9ChaQoOlrpsY-6LN16fZsWEIl5jU8dLGO7vGj4-tS1Tn9ShtDTcHPE4DhA7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedukedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:KOhrZpPwHx7KO5IhJ-4lNmghB-Ba0Nq9Y-MuXABUEgUz6oF8dndJuw>
    <xmx:KOhrZu9EhQNWMPacvnyZgY9YFoJ3uvN0rt5P2sJhokdu26TwIREqZQ>
    <xmx:KOhrZhWw54ppMy3gIGpmDh9FN-ShGWlha053ZXVBNsUW0h3CAhqG0w>
    <xmx:KOhrZndo0ki0UnWfVOdh_cVHeQ-jrqb45IKJXPfkR5H4gDvbWOyg1w>
    <xmx:KOhrZlntU3kizActuTCmqdV09gL9yrdQ5HKdrnAJJ3Mk4UUSDzLXNQu_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jun 2024 02:50:15 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0f9f7e55 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 14 Jun 2024 06:50:01 +0000 (UTC)
Date: Fri, 14 Jun 2024 08:50:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 07/20] hash: require hash algorithm in
 `is_empty_{blob,tree}_oid()`
Message-ID: <da48d5fdeaff49c702d016e3e1123eebf32c229e.1718347699.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
 <cover.1718347699.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5fMCzMp+NlJ1aDw1"
Content-Disposition: inline
In-Reply-To: <cover.1718347699.git.ps@pks.im>


--5fMCzMp+NlJ1aDw1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Both functions `is_empty_{blob,tree}_oid()` use `the_repository` to
derive the hash function that shall be used. Require callers to pass in
the hash algorithm to get rid of this implicit dependency.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fast-import.c |  4 +++-
 cache-tree.c          |  2 +-
 diffcore-rename.c     |  4 ++--
 hash-ll.h             | 12 ++++++++++++
 hash.h                | 10 ----------
 read-cache.c          |  2 +-
 6 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 12543488f3..d21c4053a7 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -2361,7 +2361,9 @@ static void file_change_m(const char *p, struct branc=
h *b)
 	parse_path_eol(&path, p, "path");
=20
 	/* Git does not track empty, non-toplevel directories. */
-	if (S_ISDIR(mode) && is_empty_tree_oid(&oid) && *path.buf) {
+	if (S_ISDIR(mode) &&
+	    is_empty_tree_oid(&oid, the_repository->hash_algo) &&
+	    *path.buf) {
 		tree_content_remove(&b->branch_tree, path.buf, NULL, 0);
 		return;
 	}
diff --git a/cache-tree.c b/cache-tree.c
index e4255c4d02..3290a1b8dd 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -422,7 +422,7 @@ static int update_one(struct cache_tree *it,
 		/*
 		 * "sub" can be an empty tree if all subentries are i-t-a.
 		 */
-		if (contains_ita && is_empty_tree_oid(oid))
+		if (contains_ita && is_empty_tree_oid(oid, the_repository->hash_algo))
 			continue;
=20
 		strbuf_grow(&buffer, entlen + 100);
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 5a6e2bcac7..5abb958651 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -1422,7 +1422,7 @@ void diffcore_rename_extended(struct diff_options *op=
tions,
 				 strcmp(options->single_follow, p->two->path))
 				continue; /* not interested */
 			else if (!options->flags.rename_empty &&
-				 is_empty_blob_oid(&p->two->oid))
+				 is_empty_blob_oid(&p->two->oid, the_repository->hash_algo))
 				continue;
 			else if (add_rename_dst(p) < 0) {
 				warning("skipping rename detection, detected"
@@ -1432,7 +1432,7 @@ void diffcore_rename_extended(struct diff_options *op=
tions,
 			}
 		}
 		else if (!options->flags.rename_empty &&
-			 is_empty_blob_oid(&p->one->oid))
+			 is_empty_blob_oid(&p->one->oid, the_repository->hash_algo))
 			continue;
 		else if (!DIFF_PAIR_UNMERGED(p) && !DIFF_FILE_VALID(p->two)) {
 			/*
diff --git a/hash-ll.h b/hash-ll.h
index faf6c292d2..1000a9af22 100644
--- a/hash-ll.h
+++ b/hash-ll.h
@@ -350,4 +350,16 @@ static inline int is_null_oid(const struct object_id *=
oid)
 const char *empty_tree_oid_hex(void);
 const char *empty_blob_oid_hex(void);
=20
+static inline int is_empty_blob_oid(const struct object_id *oid,
+				    const struct git_hash_algo *algop)
+{
+	return oideq(oid, algop->empty_blob);
+}
+
+static inline int is_empty_tree_oid(const struct object_id *oid,
+				    const struct git_hash_algo *algop)
+{
+	return oideq(oid, algop->empty_tree);
+}
+
 #endif
diff --git a/hash.h b/hash.h
index 84f2296cfb..39a0164be3 100644
--- a/hash.h
+++ b/hash.h
@@ -6,14 +6,4 @@
=20
 #define the_hash_algo the_repository->hash_algo
=20
-static inline int is_empty_blob_oid(const struct object_id *oid)
-{
-	return oideq(oid, the_hash_algo->empty_blob);
-}
-
-static inline int is_empty_tree_oid(const struct object_id *oid)
-{
-	return oideq(oid, the_hash_algo->empty_tree);
-}
-
 #endif
diff --git a/read-cache.c b/read-cache.c
index 836f1db721..085b22faf3 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -337,7 +337,7 @@ static int ce_match_stat_basic(const struct cache_entry=
 *ce, struct stat *st)
=20
 	/* Racily smudged entry? */
 	if (!ce->ce_stat_data.sd_size) {
-		if (!is_empty_blob_oid(&ce->oid))
+		if (!is_empty_blob_oid(&ce->oid, the_repository->hash_algo))
 			changed |=3D DATA_CHANGED;
 	}
=20
--=20
2.45.2.457.g8d94cfb545.dirty


--5fMCzMp+NlJ1aDw1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZr6CQACgkQVbJhu7ck
PpQ5Xg//T6j2xJTksMJQONL5fd4UkHqmc6XHyjqEhWc28yA6cCwzeZh9xFKZH1VR
ZDMpo0lPHVSqHkotnZuCLggLjknVTtFtmQKHo68NwE7B7aOZUf4tSd9Ed2PXWF2v
L2Mlz66dh91u2ZcPh+ZNfD2X5fwd8jGbdpZeeEFxDhdhVJakO8/xq4zPbcd2Hkff
+68cDQt+iIKg77Wv5X2Ak+6hOWrZaDHkmlWU5b91uS0hfKgY7P4+y+//OpXHgDdT
C7+yDYSbyN72V471tdZ54h/GXqajsp4M9EpTfhBSWNsU2OdPtrx2F/IV7scHTTSF
6ngaIzEwCFfSjI2by6bfXyIy0DBDD6vqF7hPdHKmXem1v1/Kl24RX8RHLCU6BZbp
GdKvZFhoxSR7vePt86b4KBeu77+QQnO2Nk2u3Dl4fPJI1r3RXCRUGgAll92K76RI
uPYRkCmlpOzKEp7XKCnOkxa7NmeCgek6ClqK1SZqhY9x9LZwdasmbQwUBoPQkupH
B73y5dXai/wRNi3ydfDU5HfMuDFRZGg35sSjdFpM6YZWX8wZLrZZnzMcn8nNSq44
AnbVVSpo5uXRBsYG7AHqpDt5RHTMOh+q4qD+VMi/u9D35kgDWEbafMxVv9B9mA37
yge1qu9B71oZedpwArlDINOknpI8tql2ArJwp0C6STe31R3e1Qs=
=WyZP
-----END PGP SIGNATURE-----

--5fMCzMp+NlJ1aDw1--
