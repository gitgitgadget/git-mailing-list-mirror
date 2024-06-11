Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D02517C7C1
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 11:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718107091; cv=none; b=XVF0yL/nsMgTuraUKt28UZeIOuAfwmO5ZNFgowd7wjY1L/ryvVGutixykMAp7CGJMwCfg7Vlr/cOQmk/qu+ZrMkB13h7ZTctHQ16kBM0QezlsgU2vkpjyil6TjWKy6RtcL3pB+yuPp4ivwXujLwUfd+Mo2Uzxfd1EDrvQh9vzTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718107091; c=relaxed/simple;
	bh=zSqiLGhOR1qC0SVRehwzqCtcZrNfOFDXllPls+X6ZHg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=seYsSWO2NRw/j+qSqxx8rp4ApUwqKbx1Ny09E0i7kf6OueyyK9C5EMAj308uUoKYRfmAF7OOYv5PaybSS8BwXncg7rOo1aClG2/RHY1rDgFsHzCfuZMBoaJab0FaZp5npoi4uD6KCbktrvGjZfonclZqOKXiyl0cHWEnftq8oVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AvVo1nkW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iTRpxwmm; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AvVo1nkW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iTRpxwmm"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id DCC281C000EC
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 07:58:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 11 Jun 2024 07:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718107088; x=1718193488; bh=HlLoMyX/5C
	byNypNumsAwqA9UA3HJB5u7TCn9xtfm/k=; b=AvVo1nkWCQJzGx/VMBDY2q13P7
	87Lr/IDmo81M94e5CuoQnwzv8Q4h15oGa1IGqMka98xB01XgdvsvGfTcFdxxZCeO
	3FzwHC43rdiiWCfCmLfCIOkSy6mySCN+SIE07EPF+sl88M0GJNmSk1DoY2+OpUQQ
	RbCMClQGEsnmQ8uWBLO0NbjmlPRmY/NncQieqTibqkquKuFEd+apAD9I6fT92oh2
	Emtj5nM2Ec7oJSyuUksE2mVxOK2ogHJO+Wd8+iAwopDVS8uXPCjzy9h1jXj0m5VN
	wWmfHZmlZ14EoZCHnPYpcdkr9bp+4bplDZ+k4FhmyeK0UwX8PfzoB61GJ6MA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718107088; x=1718193488; bh=HlLoMyX/5CbyNypNumsAwqA9UA3H
	JB5u7TCn9xtfm/k=; b=iTRpxwmmO2DO0n9hW+ArI2kaEKHb/Qj//G4fMLstwApI
	AzfXmBH7xBv1k+n8MbrcWyFKNsCXFBiZc/qM6mjhOG3HWbameRR1YCvlpvXDd2mU
	PgF50VLCACFcVqAW2vlgWW8RCdBUletxowQQIjEsqtFxDvkouqK4SastNiVWqhgq
	y7xpaXLY/cjbo4CvRxemZGXXRTLsKHp1o8GakFvLRWRFux2otf24uiNvgJPcbcPX
	9FIwi1nWBJnbcd5fNSnHS9NX5jXt5kOwSdkPKiADuXLekCoGWFe1wJfpS7nrZhQr
	EmSFo9zjkyAH6vPTGNxcB34GSzVk5pI5E5l/MPB1rw==
X-ME-Sender: <xms:0DtoZk8AWlLuDjxHzC0unAJATvs-yHU7YwTNT7s8uiyx6b-I6GF2zA>
    <xme:0DtoZss3Y_-K2exSAIPvGYDgBgAStDvDDqzuDR1cHCvVbyDAEid5JkKDLCmAoK-VZ
    eOJZKvdaRhZvyJprQ>
X-ME-Received: <xmr:0DtoZqB741FXoOSRFGRxSRpMj92EqtAYm-hJ9Sf_wozGtyNlPrdofEkL2-A85iErM8AEl87Vu0j1kY2gFBqPawfdm_NP8B6k3k0Mp5Ub4yO_R1PZaSq8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:0DtoZkfPUDs5TNLuSrYHkToQwlhSe9sQD4s315fsjtkRgPbt69yWFg>
    <xmx:0DtoZpPPWb_RLaRc44ecDsKhdRVBUGanwbTozSumWFoUd42c4sCh6w>
    <xmx:0DtoZukPJoAvUmldnZhvsbmfV1sxJTgp7jARYX6FBXjjhLmGiDFl4A>
    <xmx:0DtoZrut6e2Z_YslPAszzTW08Ghtm2xBEbY6wxD_E6OEhs_IetIQYQ>
    <xmx:0DtoZn3cwf-rYMlBINX9t77NJ3q3amNDOAPpEH03LZbvJB6Gh-Wb8F4C>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 11 Jun 2024 07:58:07 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 72cc5d6f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 11 Jun 2024 11:57:58 +0000 (UTC)
Date: Tue, 11 Jun 2024 13:58:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 07/21] hash: require hash algorithm in
 `is_empty_{blob,tree}_oid()`
Message-ID: <82a391acaced9182258933123ed27f17463aa0e2.1718106285.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Yd6j6+kpFZqd/Uyg"
Content-Disposition: inline
In-Reply-To: <cover.1718106284.git.ps@pks.im>


--Yd6j6+kpFZqd/Uyg
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
2.45.2.436.gcd77e87115.dirty


--Yd6j6+kpFZqd/Uyg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoO8wACgkQVbJhu7ck
PpR6GA/+JROxmHwmrAZXX3AsDDv75iNUPoI9roeO93/PWPaV5DOaTCrC7fkOr4aD
+/bhFmrU2ynNmyp+wkDlYUm529orLMnnQaq86EtYUadQbbmNPp7Rv4s84UMZ1YTy
7nyg0sh9STk9OpYf1PJei2Aju22edmkPyDFSLZ5Noj89fqnWRua0iIsVlio72Co4
g/xJ+6OlciswiR2fFKulKW/TT+ueeoGhnWD7qY6VN9RpHQuXoZbzMe0ikUVqGMzt
NpIS/YQux7jibPuL808AJ/X3sHA1mFJL6nAQzK+XsaEBjitTKJUZZtmC8mzlqbh9
a21PhGxFWoLPzyUTwhIBi2yC5NZLOnlEatL2wtQoZTjiC8e33lnOLwxE4yHYkroU
Klpjm/Ks3OQGWumvmYNMQ7KIpy0IdqNWlFujGSRnE5Q5wOanmZlbpG+mVZY+RWqq
vHMw3s61ZXkGhxsVhuxroDh/VJSTfni5OlYr7Y0TYq6FwDZ/c/LvFZYkR+ITTiqC
9sjUhtIKjmwQc+mDhfaOrJMsK8zuFBY32jnyBHauDh4F6l0WH7gN7lIS5ewYQ6TH
hvFlT6bF5Vqtv46QdvuXcVCQyx7nMxwR4J7QFRiDnmSmsjZhSFHzdubBDvmmhNBx
3l8SFQ8FGPIZsReo2EgoSltBmygSOgPITxZ7iy9Do1ZnDX75GuY=
=sVYZ
-----END PGP SIGNATURE-----

--Yd6j6+kpFZqd/Uyg--
