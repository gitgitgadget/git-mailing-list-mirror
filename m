Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DC343AA2
	for <git@vger.kernel.org>; Wed, 15 May 2024 06:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755863; cv=none; b=O2Wf6J7cTWnoW0uf5sAVZIbScG/ouAfFA84/5JIfynl8rtbZifQDX0oArLNwX0kkgnF07+iBu0Olad71+/ZKksVyVRh/RjvbpR74lCaFBxKEg3fmvFYfcNKkvxxjD4oqLjqsx8SJLwl3OI0eea9KVc810xEvvL8hHTC/EDqT5tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755863; c=relaxed/simple;
	bh=vFMXqcxUMiLtjQd9gLzM2YquBGo9qfMmUD3uTr2qEwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLKtoI9bQ7U7Y1tkRWXEH2g9cABl7LdWTY+XmHGOcakwa/Rj1zToGpbTWk0ptI4FQm1nIxAldB8mYSwExyGUs9hMUBg7bkIHqVK0V9ZNK5v2TAZ+fNMbosLJK3Js5vkjND0/dg7uSSVNKNxqyVJbAMRXmim97rZaxhrQZG/8b6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RJcT6k9b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EXNOa/It; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RJcT6k9b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EXNOa/It"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id D467A1381184;
	Wed, 15 May 2024 02:51:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 15 May 2024 02:51:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715755860; x=1715842260; bh=/WJnePAzIK
	TsEBkLth0cvDssKG8XeXXG6FTDywnZ2E0=; b=RJcT6k9bLcRLtERvjl2gUDsX4F
	iDiNsGGXkT40adK6/7UIqFsdWvJC7LR8DZV9zSF7Bpa01EG1u8C38OsUJwADYYRP
	CFNw5cVUUWOCytdnvFPxvrUrr1AG8ztNcOoTARnvS5UIGAsck6OEVRWwvt/qhlKq
	TjW84KnFNP8QOnP94vu87nyaoeQ7ONhwXwiJhGKJfgRF484b1aCTOde6gyZsJNm3
	0wRbeSRM8nSp2QFeUjeiiupC/te6Pc3g2Bb+AtQV8dKdLhm0eyMpBtta8NEa2ojt
	VCdu3/YEIwZ+0ZVpOczvHe0ppmlzrXBITB9wZirfTeC8p/dPTajPdKcX5A8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715755860; x=1715842260; bh=/WJnePAzIKTsEBkLth0cvDssKG8X
	eXXG6FTDywnZ2E0=; b=EXNOa/ItIX0E8r0y4BNJSUWJBVFxbtyWq8Ko5Ly/treu
	rUcWDzxhs5t2TKlhReBz8WzXoPXmKsF2y4xiupV0GV0tc8X3UQBbJY40E+oiq6rc
	VW6PwYzvtuXMJUjd5SmFCB19mkYlhDD3nPMtkRoLB7H1dtfnwtFPRaZIAIZXUJhD
	/gh5PNam784YQrh+hnqWTWJE66FBFiRvwQt22l/CDotfOWSDstZ+2ADQ25H/QnKP
	zJMG9hQcmUukRUnjTEH+FVriS0p0w+hlfgNY9Iv7EtNhzjyrnKCLT/K9TldD6mRJ
	nqM2ccdvN6a+gSF5OJLbefNTYltbtLO61q8WiHRUdw==
X-ME-Sender: <xms:VFtEZrgY23yldWO4_gL4HYgEUM8r5F1ycMTYbPOheHec0vzVwq2uYA>
    <xme:VFtEZoDyFKNR6jvqOSPY5Y8e_AvJK-ft1FiC9NmhlVvSC4fooQwEDZF7Z2mAv6mIH
    rlH2X-PEjuj5aHynQ>
X-ME-Received: <xmr:VFtEZrGYKse6qbVgTGz0eJLKjk2-l63_sJuqZIADOXknzM-eEQ7atR_i9S3R-8knb8_O4_wni7bkFsLECZGtqvnOTveQ4TqeYolsR5fKcwaHCQXB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegjedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:VFtEZoR1YZicfJj-GsKi9W2jWWBI1ybiTmCzcaDS_zGp4BgsflCFyQ>
    <xmx:VFtEZoxlB3tIZMZpfweMF-HTBlFzp9cAZuv6v859DTrQkjvqCFlhdw>
    <xmx:VFtEZu6gWI3Iozu8OQP_8TS3E8wjL9jGrs7LEy5tbPdSsW_dFxNS2w>
    <xmx:VFtEZtzqVwH6u6F93eGKMD6FTVSCmVNY9NizKOhsIj57S_APhjFBjQ>
    <xmx:VFtEZnkP5a5VFxJuTxh8q4pT2NdDlLZ_icUPoPlXQYSJDcSQjQYo7edn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 May 2024 02:50:59 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c76796f7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 May 2024 06:50:36 +0000 (UTC)
Date: Wed, 15 May 2024 08:50:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <avila.jn@gmail.com>
Subject: [PATCH v5 07/10] refs: classify HEAD as a root ref
Message-ID: <b719fb7110249e88b80e0cd9943a2d864b18d0e0.1715755591.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1715755591.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HYy6HKL41j4oP1gU"
Content-Disposition: inline
In-Reply-To: <cover.1715755591.git.ps@pks.im>


--HYy6HKL41j4oP1gU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Root refs are those refs that live in the root of the ref hierarchy.
Our old and venerable "HEAD" reference falls into this category, but we
don't yet classify it as such in `is_root_ref()`.

Adapt the function to also treat "HEAD" as a root ref. This change is
safe to do for all current callers:

  - `ref_kind_from_refname()` already handles "HEAD" explicitly before
    calling `is_root_ref()`.

  - The "files" and "reftable" backends explicitly call both
    `is_root_ref()` and `is_headref()` together.

This also aligns behaviour or `is_root_ref()` and `is_headref()` such
that we stop checking for ref existence. This changes semantics for our
backends:

  - In the reftable backend we already know that the ref must exist
    because `is_headref()` is called as part of the ref iterator. The
    existence check is thus redundant, and the change is safe to do.

  - In the files backend we use it when populating root refs, where we
    would skip adding the "HEAD" file if it was not possible to resolve
    it. The new behaviour is to instead mark "HEAD" as broken, which
    will cause us to emit warnings in various places.

As there are no callers of `is_headref()` left afer the refactoring, we
can absorb it completely into `is_root_ref()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c                  | 9 +--------
 refs.h                  | 5 ++---
 refs/files-backend.c    | 3 +--
 refs/reftable-backend.c | 3 +--
 4 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/refs.c b/refs.c
index 4fec29e660..9fb1061d52 100644
--- a/refs.c
+++ b/refs.c
@@ -859,6 +859,7 @@ static int is_root_ref_syntax(const char *refname)
 int is_root_ref(const char *refname)
 {
 	static const char *const irregular_root_refs[] =3D {
+		"HEAD",
 		"AUTO_MERGE",
 		"BISECT_EXPECTED_REV",
 		"NOTES_MERGE_PARTIAL",
@@ -880,14 +881,6 @@ int is_root_ref(const char *refname)
 	return 0;
 }
=20
-int is_headref(struct ref_store *refs, const char *refname)
-{
-	if (!strcmp(refname, "HEAD"))
-		return refs_ref_exists(refs, refname);
-
-	return 0;
-}
-
 static int is_current_worktree_ref(const char *ref) {
 	return is_root_ref_syntax(ref) || is_per_worktree_ref(ref);
 }
diff --git a/refs.h b/refs.h
index 8a574a22c7..8489b45265 100644
--- a/refs.h
+++ b/refs.h
@@ -1060,7 +1060,8 @@ void update_ref_namespace(enum ref_namespace namespac=
e, char *ref);
  *
  *   - Their name must be all-uppercase or underscores ("_").
  *
- *   - Their name must end with "_HEAD".
+ *   - Their name must end with "_HEAD". As a special rule, "HEAD" is a ro=
ot
+ *     ref, as well.
  *
  *   - Their name may not contain a slash.
  *
@@ -1079,6 +1080,4 @@ void update_ref_namespace(enum ref_namespace namespac=
e, char *ref);
  */
 int is_root_ref(const char *refname);
=20
-int is_headref(struct ref_store *refs, const char *refname);
-
 #endif /* REFS_H */
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 06240ce327..6f9a631592 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -351,8 +351,7 @@ static void add_pseudoref_and_head_entries(struct ref_s=
tore *ref_store,
 		strbuf_addstr(&refname, de->d_name);
=20
 		dtype =3D get_dtype(de, &path, 1);
-		if (dtype =3D=3D DT_REG && (is_root_ref(de->d_name) ||
-					is_headref(ref_store, de->d_name)))
+		if (dtype =3D=3D DT_REG && is_root_ref(de->d_name))
 			loose_fill_ref_dir_regular_file(refs, refname.buf, dir);
=20
 		strbuf_setlen(&refname, dirnamelen);
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index bc927ef17b..821acd461a 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -354,8 +354,7 @@ static int reftable_ref_iterator_advance(struct ref_ite=
rator *ref_iterator)
 		 */
 		if (!starts_with(iter->ref.refname, "refs/") &&
 		    !(iter->flags & DO_FOR_EACH_INCLUDE_ROOT_REFS &&
-		     (is_root_ref(iter->ref.refname) ||
-		      is_headref(&iter->refs->base, iter->ref.refname)))) {
+		      is_root_ref(iter->ref.refname))) {
 			continue;
 		}
=20
--=20
2.45.GIT


--HYy6HKL41j4oP1gU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZEW08ACgkQVbJhu7ck
PpQ8mg//Rci91CpcDNHwNg/eF5NR73lukD2QCbXG9nJIpphM6dqH7zn+MaCvTkn2
+z0ecwODfp0RlcBfv+TSDwa3jvr9FTPLsWUqSCwzNAaiFFQzIq9x0xY8qxqjj1bh
Ym3MSqCUYAEa54AnkDLpn6s+PjJzDADWP4/aUPQvvelNwp4lRaTtZuUcn5Ter2Dl
UQRRHgolVYenFlBMSCVX/JNY4zVyKuzojPdMZv0xoF1iwO7YU55qcLsPtB+5OQnH
EAll14IzKfvT0z9w4/d/j1u/VyKxX3pr81Bh6uoXTnr9dxEmpbk9LIMiQ8xkVCcd
S+wbJjoKW6WAvzwzszxJLVJBRVep5xbKVgZl7HEhwQ3W4fU1NyNX0NcBSidauyZE
FZ1QJ5yRZkkXpScLzr7j8O0pQbUVCaX5Pv5HpzRwGDx9lj5mVN+JxGtU6BWNK90X
zALH5ADwxivsROc9x8CxfV9+U5ZN1e3Ke0P7lLSSt4GSu3JATOk8yiotb2XZvuRn
Cuqk3Xizd366DlRGTk+KmVuDAfLz3OL4uNfq93KMOtuT9Mb25ebZPPcN2SEWrSN9
hnoOhdYlUE03bbD19DtnFLSdMnM812RtGxewo6DhElEYVqJHVLEfv9mpx9AtJUcX
FmIv398bkctmkJopbob1YxoP7i6CaqqqvDeshCFNyXZ91y8RTpk=
=aV92
-----END PGP SIGNATURE-----

--HYy6HKL41j4oP1gU--
