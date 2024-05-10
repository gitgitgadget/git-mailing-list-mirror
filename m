Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF8715F40C
	for <git@vger.kernel.org>; Fri, 10 May 2024 08:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715330907; cv=none; b=EwuyboSh3RV9p2WKpE4BXcDZbOJpKRAcOGAmtryX8WAc4WJCFX1iZ7jYRhArR4Kuko3cP8mIstZe3aW/vDigPzICMeD/XWxhTFkw4nlpkLYe/mOYpjx2Un3CrYTYzUpMJFUrjekdMG+UuO16An0weg1KNa7ENKyOcpQxIyvvoFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715330907; c=relaxed/simple;
	bh=zLfFryk77Gf2iUsZD9yOjwEQqfvCqYIncfs6F7AyVvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icV3IvXGG5mM0Y1idXmvN1MmvmdrfZ6PlKbXM7siwz6Ox7bXGLfMPVqD7o30XXlVSdqKbby25dNerBrMarGecquICkTGLum/RzlDdBCA5JmfhNbrKI/rtasjhWfGvYZkeQZESk8yqV+UQYnbN0jLBg55wxpB7DbVsqTsrz1TZUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lz1pBkBM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RFhVLSKe; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lz1pBkBM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RFhVLSKe"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 299361C000F3;
	Fri, 10 May 2024 04:48:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 10 May 2024 04:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715330904; x=1715417304; bh=8YFPulj4zu
	wVQQMxOwsvE6ds5d493mJhxZlO4Wic6Ss=; b=lz1pBkBMJ6VZPDV2197F0OnPXd
	+mFKCxezoW0o8IqZ0qEp2Yyjvtb+gwQlbD6TVkDGjWPMkkZvttLzBADCa9ehXNzA
	rPDWIuiPKBEkSCiA10eJW4HaFHY6YGF/CYfP+mssquUJpbFN6WRYRgMzMWbp1V5l
	JeS/jeCvjRjAL+foxh7PqL7lZvLvT7klSoojvZPIc7GHCxg2IN+pTU1s9DV+VqBG
	h+Mhh3hqES2KCblu03mYh1OxN2yqMIXsL6y1ebikJv6uCUkstc37LYaBwFWzSjEE
	Mxkoy/R2u3KKgmKAUlhXIQPa+Zh3At/5QdXlAvcq+Z9z9tE1NHKgBsdG+S8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715330904; x=1715417304; bh=8YFPulj4zuwVQQMxOwsvE6ds5d49
	3mJhxZlO4Wic6Ss=; b=RFhVLSKe70CJEMitMNUiVBaIzEhkY3iT4DIVtNELY2+8
	ujxJTrEm2VdqUTG8oq9K5w/nt5N93W1pzuho1b+j7ItyuDIHPEs1U7Hd5Q9IsBKU
	WBruc5JXnN95yPFmkZWAvJq4s81vxqkGhueq2vlRQF0cV2Uz3+v7/5LWSOjaP7zS
	HvO/zO2ayOUrIpk8ZZulIKQuwS7n3OvYLj1UyRBCXT7Rbbl+teJe7ENsVf7FKI53
	iQdxGjf6AoeXjkmYZAso/T86/DLePKj6CqoLby62z4Ju5u+8QzIrYcP9l6i4nm/G
	yw9CdhYrypDUyis30lnjxCXFP2JNpGbk7KPt7hUmyA==
X-ME-Sender: <xms:WN89Zs1csF6pZX-LpvmsqL7gBJ6Ib8Y3uANPky_MHXqfAebJRM-J0Q>
    <xme:WN89ZnHNaV_UOR5TdipZcn33W-uxkcacxKXDOiA2jCtMn0RumCcPDrM88Qd_Z1CUp
    RgiQdKk2aeba1eLUw>
X-ME-Received: <xmr:WN89Zk5XLAiub9am9nv8Kggpok9Ia4N-aIvxrhdLeXKl4VWhGw-HAVQlm7U20o3FuUSxAMsoqp0s9hNq7AU0ngAdAk_feTpGArEDEvbAXLt6P4ZJIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:WN89Zl2sHLajDRZZsNT1AcNGjL76hVojJUMfGN0ZFaHSxQZsgFgZGw>
    <xmx:WN89ZvG1EBWV8ml7GHR3mwUogtAa-0YfQobtSoFybR5KGnRDLJXQcA>
    <xmx:WN89Zu-ZpjSoxGkKkKSxFPp7aC-A5soOu-nZJU7ZWqAafvMDfr5wig>
    <xmx:WN89ZknWLbYegyTUYtUUQK9UgL2DsFwd5lEnAzCrEXsmBs95KheBCQ>
    <xmx:WN89Zlav93KBIKwoqXDxXP42egd170h0_mMp1XPzx73zlLE4-B-PAU1h>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 May 2024 04:48:23 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 55853e25 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 May 2024 08:48:11 +0000 (UTC)
Date: Fri, 10 May 2024 10:48:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <avila.jn@gmail.com>
Subject: [PATCH v4 04/10] refs: rename `is_pseudoref()` to `is_root_ref()`
Message-ID: <ee2b090f75ebbca2bf6cb22500d2a3e23b8a7718.1715330206.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1715330206.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PAsS5P+KmOe/ezGg"
Content-Disposition: inline
In-Reply-To: <cover.1715330206.git.ps@pks.im>


--PAsS5P+KmOe/ezGg
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
index 010ef811b6..36ab3357a7 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -354,7 +354,7 @@ static int reftable_ref_iterator_advance(struct ref_ite=
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


--PAsS5P+KmOe/ezGg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY931QACgkQVbJhu7ck
PpShFQ//dlSrcsYIyVdZfRvnVnIJevDKw32BrIFOLVgRJ2FokEh2raC6lxPfJGc4
ksUBWjmqm7ehbh0slmYFekvGSN4eJx9sw2fWATqaDIo3z5IBfAdvARRxw3PxrjJz
ucXnAYqmthKE1i/sEWY4XVwEoldcsU9GZD0KIEXzwBNtK3NslYQ7DfhdA8nlIme4
WGpbF2Vd+HTDsgyGJ162gQdFe+ET+MgMq4FjkhcBpEDpxtzJFZjpg3L7nQrCnHkw
a0xYVeo+F2/ksp2n0prV+exjjzQPpfUsPtlH31bdmi2U/zgbw0uFdOXxo5Yng/mL
ADGbNd0Vi60RZT4u4aafqAajAOqBcejmuOFwch/fSbFNDpkRM60O6DZpvYygy3BP
INzqECW6bihgEPxtC71cGZ/yXAtLr+01ArDJJoJAHnDJtRmzD3dkFUf7Abvgp40N
VHZRp5eT4Z1k/rO2649nFDicFUm4zD7THSfgDKuir0wbXqEZai/W9s44egnwyNhL
tbZTlLEhUgNBoJJ3SrMIsG9dwYG2Aczx00VYjU5mnUyXzRTbV8Naj1ttDsCLy6JR
Lox5/f5Cwa9vjnaIlSbOMrvBVn6L+u7hLrQQl9dO7R/iLyMuqJOkp4iDmrhGVlPC
CyFPc//ijCA4lCtifuhvTIGOc1TTPQGAyveYVsC8PKwp7gMWBJQ=
=eGRi
-----END PGP SIGNATURE-----

--PAsS5P+KmOe/ezGg--
