Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7202E3E9
	for <git@vger.kernel.org>; Thu,  2 May 2024 08:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714637853; cv=none; b=kSZQ3+MsI+48FRlc2FXQzkDnfLOLeoQx7sg9Ue9MbWpkYrMb80L9FDihYmghpVIyjdNG3XcAcgaPm9kn0yhxf3c1UmezDRWfwTZ4MAEziWjqYrAL6Q8dhFrfrvpzKHa+1AWuGlOxi9S6seApay/LFFtmMvK3yU4xNA+kU2BZsS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714637853; c=relaxed/simple;
	bh=mgxoTfQm3uwga8G7FEzpicj8iUmpCfLlVgLaXHSJ6Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifo2d1o13DyEAQ9sYppZvsP034QNB5hLKzYbWbXHmi4KUV4OLgzu3yM4/d5+r4Nz7VFd82hxGr+wYomERuwnQjqODxy1Yn3/q2ZwTqSyHCgeVR+8PgKROGRbf8hMaMrX9da6uQ8c0VThsWU/3p5NVnVtiIJD2CE9CCZDkTpYeZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=onXOY2SN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QNGNeFtH; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="onXOY2SN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QNGNeFtH"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2C06513805A3;
	Thu,  2 May 2024 04:17:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 02 May 2024 04:17:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714637851; x=1714724251; bh=+X2gC9Z3xy
	pKpkOEw05EIW/b/AJZ5G2ZSOb1uWdHJPs=; b=onXOY2SNfw7gvit7PR4IW/E57z
	MvjvkckTwZht1DdsO91lFlisCxW344pFj5b66sb0LmiUL41u70XA+8tUBeTV2u1W
	VIXXIrUyOfyjZkUXJheQcRmJV3QjzaCGrqloq0HKiQSasI9aO07IhYxIrIy/YpVV
	SR8359zb1tMlEv1IeMt4Uc90BbwtbXwdus0LEmEjFawRvensk0hhRGhk28pYhDVw
	+wkm3J8YhRfCACDH0EwvC1fKDWn3rrEK+uKqp5D5qwWhTGuOxqbRjvHeV8QYcpdR
	a9TTsPWl4iSor3ox0gASTFWanls32+bq1Lak9ZOQzrh3vEflkMhuLCF+29bA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714637851; x=1714724251; bh=+X2gC9Z3xypKpkOEw05EIW/b/AJZ
	5G2ZSOb1uWdHJPs=; b=QNGNeFtHVVChNQYJS1I3D4yU5yXbQOBOLw7tw4ph/jHA
	UxF6F/0hUqw2fkFgl389aKexj/V16Cg2f1hODnYfUMg1iKl4Xoigi3E/KgtxAhXB
	4xDFejkbEAXKObJytk3B16UQInjXRpDzqOFelF/htqajy4LdS1L5IbrdF7WGlRF+
	0G9Ey4rhHcz5pMpZHeLnR/ksRdabiTZZrmFDcO6ft27BXxTqSKMu1VpTr0xBltDW
	1kuNw/wu02pQJrjYDmWKxYfhdtuNJhXrwxSZ2d+rHkuZ90KG999P8P+FrpdrPx2l
	8oHMAaqGYO7vy1utbWK51uE/rxl9rh+FCkUIeokDRQ==
X-ME-Sender: <xms:G0wzZiZgsRTWs8SE7h7Zka9zkQ5mHrGOfmA-xJkNXA9d1bTeI3rDqQ>
    <xme:G0wzZlYw5gqc6b-7ZV3FcruRv-r0TWWhNQazjZ83kvaZNu4Q7buGHNv--bOxRm3VF
    MzcC7FUkpdxsE9b-w>
X-ME-Received: <xmr:G0wzZs8wGI6EAAP7JwiIvvSy2XEkJ42neOLP6J6WMPWKIFoznsX3eHFaOLcPnY7uY0Ut0Q67t_Jc7RTw17yrBrUDwrVmoqmdPCIEscjqVdmoV1E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddukedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:G0wzZkou3gGRmDh4fpPl77G5FENlTZhTNJ93ubIP4E48yXnQhm5RYQ>
    <xmx:G0wzZtr1q30lNhyqIEO-kKlywzSHhEl2hRZGqtQLXqWIIqUelUDOdg>
    <xmx:G0wzZiQm-DIOMapakMFhh8FLhMdBjXQUOX11Pnpla2HIPyRSyzn-gg>
    <xmx:G0wzZtomunkYZIym0zue4CzNnKVVQqLvE5zExd-BLNcvSt4C6_OHhw>
    <xmx:G0wzZhJ8NKoGTZlTWBj33k_4QK3dqrMG-h7n1XBQg_IaHTUr4ZkeD3nj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 May 2024 04:17:29 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 11c55b75 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 May 2024 08:17:04 +0000 (UTC)
Date: Thu, 2 May 2024 10:17:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v3 04/10] refs: rename `is_pseudoref()` to `is_root_ref()`
Message-ID: <0a116f9d11413e0f16d60d963d5b41b8fc6b7420.1714637671.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1714637671.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+tGF3MNEhi3v+8s5"
Content-Disposition: inline
In-Reply-To: <cover.1714637671.git.ps@pks.im>


--+tGF3MNEhi3v+8s5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Rename `is_pseudoref()` to `is_root_ref()` to adapt to the newly defined
terminology in our gitglossary(7).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ref-filter.c            |  2 +-
 refs.c                  | 14 +++++++-------
 refs.h                  | 28 +++++++++++++++++++++++++++-
 refs/files-backend.c    |  2 +-
 refs/reftable-backend.c |  2 +-
 5 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 59ad6f54dd..361beb6619 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2756,7 +2756,7 @@ static int ref_kind_from_refname(const char *refname)
 			return ref_kind[i].kind;
 	}
=20
-	if (is_pseudoref(get_main_ref_store(the_repository), refname))
+	if (is_root_ref(get_main_ref_store(the_repository), refname))
 		return FILTER_REFS_PSEUDOREFS;
=20
 	return FILTER_REFS_OTHERS;
diff --git a/refs.c b/refs.c
index 55d2e0b2cb..0a4acde3ca 100644
--- a/refs.c
+++ b/refs.c
@@ -844,7 +844,7 @@ int is_per_worktree_ref(const char *refname)
 	       starts_with(refname, "refs/rewritten/");
 }
=20
-static int is_pseudoref_syntax(const char *refname)
+static int is_root_ref_syntax(const char *refname)
 {
 	const char *c;
=20
@@ -860,9 +860,9 @@ static int is_pseudoref_syntax(const char *refname)
 	return 1;
 }
=20
-int is_pseudoref(struct ref_store *refs, const char *refname)
+int is_root_ref(struct ref_store *refs, const char *refname)
 {
-	static const char *const irregular_pseudorefs[] =3D {
+	static const char *const irregular_root_refs[] =3D {
 		"AUTO_MERGE",
 		"BISECT_EXPECTED_REV",
 		"NOTES_MERGE_PARTIAL",
@@ -872,7 +872,7 @@ int is_pseudoref(struct ref_store *refs, const char *re=
fname)
 	struct object_id oid;
 	size_t i;
=20
-	if (!is_pseudoref_syntax(refname))
+	if (!is_root_ref_syntax(refname))
 		return 0;
=20
 	if (ends_with(refname, "_HEAD")) {
@@ -882,8 +882,8 @@ int is_pseudoref(struct ref_store *refs, const char *re=
fname)
 		return !is_null_oid(&oid);
 	}
=20
-	for (i =3D 0; i < ARRAY_SIZE(irregular_pseudorefs); i++)
-		if (!strcmp(refname, irregular_pseudorefs[i])) {
+	for (i =3D 0; i < ARRAY_SIZE(irregular_root_refs); i++)
+		if (!strcmp(refname, irregular_root_refs[i])) {
 			refs_resolve_ref_unsafe(refs, refname,
 						RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
 						&oid, NULL);
@@ -902,7 +902,7 @@ int is_headref(struct ref_store *refs, const char *refn=
ame)
 }
=20
 static int is_current_worktree_ref(const char *ref) {
-	return is_pseudoref_syntax(ref) || is_per_worktree_ref(ref);
+	return is_root_ref_syntax(ref) || is_per_worktree_ref(ref);
 }
=20
 enum ref_worktree_type parse_worktree_ref(const char *maybe_worktree_ref,
diff --git a/refs.h b/refs.h
index d278775e08..d0374c3275 100644
--- a/refs.h
+++ b/refs.h
@@ -1051,7 +1051,33 @@ extern struct ref_namespace_info ref_namespace[NAMES=
PACE__COUNT];
  */
 void update_ref_namespace(enum ref_namespace namespace, char *ref);
=20
-int is_pseudoref(struct ref_store *refs, const char *refname);
+/*
+ * Check whether the reference is an existing root reference.
+ *
+ * A root ref is a reference that lives in the root of the reference hiera=
rchy.
+ * These references must conform to special syntax:
+ *
+ *   - Their name must be all-uppercase or underscores ("_").
+ *
+ *   - Their name must end with "_HEAD".
+ *
+ *   - Their name may not contain a slash.
+ *
+ * There is a special set of irregular root refs that exist due to historic
+ * reasons, only. This list shall not be expanded in the future:
+ *
+ *   - AUTO_MERGE
+ *
+ *   - BISECT_EXPECTED_REV
+ *
+ *   - NOTES_MERGE_PARTIAL
+ *
+ *   - NOTES_MERGE_REF
+ *
+ *   - MERGE_AUTOSTASH
+ */
+int is_root_ref(struct ref_store *refs, const char *refname);
+
 int is_headref(struct ref_store *refs, const char *refname);
=20
 #endif /* REFS_H */
diff --git a/refs/files-backend.c b/refs/files-backend.c
index a098d14ea0..0fcb601444 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -351,7 +351,7 @@ static void add_pseudoref_and_head_entries(struct ref_s=
tore *ref_store,
 		strbuf_addstr(&refname, de->d_name);
=20
 		dtype =3D get_dtype(de, &path, 1);
-		if (dtype =3D=3D DT_REG && (is_pseudoref(ref_store, de->d_name) ||
+		if (dtype =3D=3D DT_REG && (is_root_ref(ref_store, de->d_name) ||
 								is_headref(ref_store, de->d_name)))
 			loose_fill_ref_dir_regular_file(refs, refname.buf, dir);
=20
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 1cda48c504..5a5e64fe69 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -356,7 +356,7 @@ static int reftable_ref_iterator_advance(struct ref_ite=
rator *ref_iterator)
 		 */
 		if (!starts_with(iter->ref.refname, "refs/") &&
 		    !(iter->flags & DO_FOR_EACH_INCLUDE_ROOT_REFS &&
-		     (is_pseudoref(&iter->refs->base, iter->ref.refname) ||
+		     (is_root_ref(&iter->refs->base, iter->ref.refname) ||
 		      is_headref(&iter->refs->base, iter->ref.refname)))) {
 			continue;
 		}
--=20
2.45.0


--+tGF3MNEhi3v+8s5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYzTBYACgkQVbJhu7ck
PpSGAA/7BK/woGuewhIujbRvl2jRX9uWM6IG35xXM/OLFSGyussMIGOgL5kowetr
KTWMwLUC+srBlgl0N5N9CfstigbDaF9gOjVOyazbSD78SxEqfWEaHyt9+0PMbLMM
u2fVQF65w4EoOaDzRY7onUnH4274r3svFaBdL3okePvINyQJUGj09pT9EiB0RW9R
vJCW8lHq/cYzd1GvVumhr4yrK6s3raB6xipbgT5rtcUCDE5Sfxzs50Z6GG9WyuBP
vLp6ULGAf5J6MfIy/FAR7D5OYMONdiSsK3XT4CI5mrSFB5MtlyVRoXjYLCt9lJrE
nQRf4OTiVwbl1x7OAggOXlxOHbaPZVtWq7D8yNuY+h6thuFiZBDEYfrt3mDgRNYJ
lGz/5TnL01lp2WL9U/fofOXrRJ1h8o1hBWjct2oCWnwcijKw6+U2JTCPttTuJ0f/
USTDEELY6s6Bhw1HOFDvg5T87jUj1BgqKt/uuDHRjza6sIAGGnY/+2AobXQCU4Ij
PgCi4XO1pWPZpkUfPZq0qBZc0JDlvmL4rztaqIOphPnDZlB2Da3pphC09tAmDkHl
QqrgJTgWkLH/28WwU2ZxJ0zO4jRHzw+SSo9aoXB3VXLP632wCC0VtQcOUMdS/Rbq
c6gxP/YZmlwN8VFz2R5r0yVZxRTHRvGRPKRagV5NbujAJ+AlPHg=
=xZMf
-----END PGP SIGNATURE-----

--+tGF3MNEhi3v+8s5--
