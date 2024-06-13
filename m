Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280001369BF
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 06:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718259241; cv=none; b=EeXtZa//qZFUwGfakKPS2YXtUOhMSV1hWK8ZxEtNB7AkL7H4fOKk2WBWA7/uatN/LnsjenCmvyxDRKURspJrIDiYUnp1UwtMD3SMg8KAnwb12rJ3G57FbNNPdinTJNyPVUJ7UM1ZvHI689t0EwLrT9uCU9JexbqoHC/OSrLneVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718259241; c=relaxed/simple;
	bh=o8Mqwp3diBsjjLtQ35VQOGJ34fDG/26B0aWfjagCjdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZUYLeJgA+yVN6HB90nLQ5Qog6dJA2tzCzA/QwvU3c2QYI+nxypcwhmdoAJE4IlX2cWqNAFSKLKVAlczM5rJ6ltOWrmB4AQx5Sku+J+V8+hR2S1GmpVvYSYFtw7H/pDlhZc4dOyuL1fkLGXsLthSCckJc6oaD/y0AHICHBr5klk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VFm4VSmp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wt7+WU8u; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VFm4VSmp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wt7+WU8u"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 4FF901C000A6;
	Thu, 13 Jun 2024 02:13:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 13 Jun 2024 02:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718259238; x=1718345638; bh=ljSdjOg+tz
	GZczfQY4qQo8+9mqoPukxJdxfmytwK7TE=; b=VFm4VSmp4xlLN93JPZo7c9lDbP
	/hyRGKTyGA8HG7qlaPdC3UqnfRyVdt+m3MmTnNWGfkbRQtx+G2s3ZGnbSip4GXwB
	RlfxwhFlCk/Ci2UGnAdBHQ291cJTpCbJVWlZPDl0aUGqqlYm7Pv3VwkHOPV4gtUp
	uYPEvCN4ZhzyG+EX2n8z2L5nQxhQLTX4kB8ZvoAZMFCbqge6GiUzf8fkTFgjelip
	UOZJEglPrXOnZZxTkLl5fVUEmtRxi24VYpiNM+rocDK2XTcTP9tmf9OGQ0YXQ0GS
	fEc9alACQTOhAOfIlm8+xCivqhUMW+Kat49XMFvZo0aSBRscnYUPnz7TFrVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718259238; x=1718345638; bh=ljSdjOg+tzGZczfQY4qQo8+9mqoP
	ukxJdxfmytwK7TE=; b=Wt7+WU8uVVaMC7mdMnG917od5MsdU5nsAxX/gJLorlYn
	vIXQGFqK9LJeR2TGiZptlCqKICmG1OCcctrel8T8nlpYsTBEuBEnngGRCJTCjKRX
	/qWUwlfBhuX/lq9sNRP8N0EUTi7wORvjdgKTIShsNjA4g33Deu59S6jHK0fqo7lp
	ASxxZwO8wfxab0bAtKOaJ+UYcg3+vHnc7xzdvNdWZozKQ/UKDrgAAkgFWApYeMOF
	V7/n0trO450tF+VTXl2Ab81vE9zwLTYsOfxDAFPd13E9BY6oA/ZS+feRIzbr1ljn
	AGVBO7eldkFPCdDRh64bfQCWJwXoMIgJsLnn0K+8cg==
X-ME-Sender: <xms:Jo5qZoFzdWgvw_QcKYt7AIMnBfsFAKL6bQQSy2D9gucXPp_hN6cQHw>
    <xme:Jo5qZhUwqqCwURekAGElbhj1jJcTNASaL8iFrtUpUa9FS8BW-DDB1MmMEZp5eIDHe
    xI9qK5yOycaz-8csg>
X-ME-Received: <xmr:Jo5qZiKvZdCvwBZDEGtqJaDbqz7OvmkU-SRek3nKrwyI_Z6ELHD0ljDv9y6EuOrwPGr5KB_oSWLv_iwKdjCc5xc7qc8fvWWUH-nuevC8pMKmjnm95k8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduiedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Jo5qZqGJ30pVKYQVQZI2ETq7md3lQPgvmjsCLGkHthLnzinW0LshXw>
    <xmx:Jo5qZuUDhHH1-LL9UQ5ms-zVoxcBfIEXNJfq2pWJ7-V3N_I5EYVn-w>
    <xmx:Jo5qZtMCuJ7hAXNzeY1y7UmUpGOhh_e_Z2NnzYEhPB_8v3NyXE8vvQ>
    <xmx:Jo5qZl1XBO57z3JB-zU07MjI1JK7sCujnQfQICf0VsnwP9zmvYY-wQ>
    <xmx:Jo5qZtTPoBrfKJ9ahB9PWebKL74ClDV4xBFr3KJT8fhiHv20KP6hVPuP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 02:13:57 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 11afb885 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Jun 2024 06:13:44 +0000 (UTC)
Date: Thu, 13 Jun 2024 08:13:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 07/20] hash: require hash algorithm in
 `is_empty_{blob,tree}_oid()`
Message-ID: <d26584dc8f6f7cca5d3173c80f694b2cb0491ba7.1718259125.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
 <cover.1718259125.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="A8Zqlq6am3JmxCdO"
Content-Disposition: inline
In-Reply-To: <cover.1718259125.git.ps@pks.im>


--A8Zqlq6am3JmxCdO
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


--A8Zqlq6am3JmxCdO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZqjiIACgkQVbJhu7ck
PpS/MhAAgX+AdcdvA+wDR9qcXPp6ctBX37zp7HOazqU2uRrkRyX8q31JgZHps3qq
nE5QtA32E70OjYtAYj4SLqoMkrLjpmBsBg2oqKpBpqw75SA7xlHOFkBYfiJ5Ghgi
l0NMA9yXmwDjAYEtGpGhMMUs78cpyjhrBMSWiwZjvR9AqpqWV+LyWkhlMpaQcmJI
iNhrL6NhjE/QdX3a/UBUvR8siuwvvuopVFn95Pyaur8hSzwq9sbuQW0Do0u1HE+U
W+eFFWzibnaVU49Mdu6wLwoeK76ND+u6jsNStMvRFLoHR6civJZm7l0Llnuwxrv0
E0FBCnzX/Gc+miYb8fu6acTBUP79uPbVQTcbx8Sk9eK5QJR8ua26jTck5dZsWNrH
f+6xffwcqi9yeJ8ySbgEE0ykFecJDdjtTZQGlkDrfYHXKLOVH3FvckEAyZvr1y/W
oSMK1DOVTM0MLChBCrOzGKu5fbKjR70pLkUsn2gV79g+VhTbLg1e46pzBIdoX2sg
M+f2Y9Vx7ukSXaZ+qHuIANQvUI/Ui33XHXqTGiEE4GeStu7hkxFmmlwDO+KEJh2C
WqIH4BhiH21/lswrYlnoj1kvZGx7ZayiQSWPH8P6yIgkaYaOyCmhE9UEZcPAg2ML
JYy3PaOXBCicTv6/v0A2KsayKat9RDbCib/fnKqq8Ho/k8Zr+r8=
=lWsY
-----END PGP SIGNATURE-----

--A8Zqlq6am3JmxCdO--
