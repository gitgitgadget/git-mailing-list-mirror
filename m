Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22517140384
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 12:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714480004; cv=none; b=K9sx4gs4u37JNDTPpeVhdS/fb+a8ptSZIXu5rmDS+W24V97785TmuG0y5OQ9evA/e2c1OqPdlU7Bh0SzVUw0MMq99HYE4gKU/h6c5NbWTuNg2zX50fY6ZXxH4+7iHDKfAmj8eDbtYo+7o07mwYQLLDDTvC++QYcVmnrkKUgj8uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714480004; c=relaxed/simple;
	bh=c7my6STImmCz3Z6OrhTRzog29N8MWHfwtpYKn6yQ+1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kinrSw2igiZAoIEnIfY3ssGiIWz37JNRTORIgiuOGVfola6KABbcEJh527G4CthJfDkFh7zRTzYZJBZG66wCylzaLJ4VVIlw6NUB6hyBy+y/N62zM/OeDXEhjkuitnkIHQpwBpT8PD1PDdDBdgzYl241J/nNY0KZIIRNltRyH9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cNe0Jvra; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ccUyfkbT; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cNe0Jvra";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ccUyfkbT"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 2C7C61800155;
	Tue, 30 Apr 2024 08:26:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 30 Apr 2024 08:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714480001; x=1714566401; bh=AlDZiXDqf0
	SLqKnRRmAFET28o311Na2gbPl/xepIjw8=; b=cNe0Jvraph9SaeUsIjJe/d/YrM
	QqC2fUdIbn4qEe4leeWTKF/GQNxgzTwd+MPd2V5iiIhRc/ZR+JDRgug3RbCwQMpk
	TuMvaOx/MQ6hJBJQN/u8jmxKe4XCv2nlOhadZ1kla/rW5y6EcVsP9oy0NT+p7aKS
	UGcnAj9wczwWuvenFkf/LsOokJe9IpOALeDRDgMXJs8zQfw/mHBSFvimToICFN64
	wd+PTrdMqCkucdVsVsDELOEEoY7ZRpnEMVy8uO6olthvP4p8JJV/VevlJaOFv+6a
	hJ5Erkmp8DWcbd9ed3tpj4MlgrhPE5XheN/S1bDhu1orQbeHXz0s0ZlHSsbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714480001; x=1714566401; bh=AlDZiXDqf0SLqKnRRmAFET28o311
	Na2gbPl/xepIjw8=; b=ccUyfkbT58wwR4DWV0goX9g2Z368NE6HxpeRb7olGRK6
	4nAJSuJU3kVa3x7KQwDZw8lj6ITyvejc7n619HNdOi4MHZyg8dH85yEkDIQidOBx
	TE5OXwKSaef86tn5h/C1q4DgawlqECN0jf1eiqMN2So7KBpbbj6EHfApuevPfWbp
	uHM/dRXZFOTRQbgEnJWBisJfUQs0io8ZHv100cJ/ENEmHTor1inbzVSjNv7ftFPo
	JQhKjGe5hZqoRsDMF8AhJn4yWOGn0CWSGZk+yxjr+tXL7CvgEEXSJ9YuRD4OHcAg
	nr5P6ii21VNVtQI33G2bymUpsxIlVRZzVeUiQdgfGA==
X-ME-Sender: <xms:geMwZkSsaHi0cClFi2TplqTaSvq5o7qQm6iX6fK0ygoTsi7Fy2VZvQ>
    <xme:geMwZhyN_F03Lcfv9MWZGhtTCwdxKlfxaHFXrLyq3CN2LoQ7S3h9HcMYWHYkMoCma
    jDZnm0VGIGMIu7NDA>
X-ME-Received: <xmr:geMwZh2Vf0DrbNKJoBxidpJT-_o8EvqDnGC5-q_wZiNe6Mdcleqrih1IlrAM3Op_TFO__Ifvthhs-jlqxAZI_4i3PQ-j18KDsrDQElc7HytEaA54NtbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddufedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:geMwZoD36ffYALAd6u9InH1KkeiuVwbbjIIJo4g3826QRsw42WwWVQ>
    <xmx:geMwZtglPykE9XrwyXbH-cdExE7GlgmC9KsoFbxPJgFxffvEH1KIjQ>
    <xmx:geMwZkrJ6f_TQ757MB-gP_rqgxwxZbxRrV2nHTTXAbvjGOu6H9E3QA>
    <xmx:geMwZgjCODB65FNBeEXqLerRxo7V-5725gOhMP7i7LJ-9WDqIabndQ>
    <xmx:geMwZoWqKZ5efcvmm8sERnXqpLJmPVDinl1OIvlfT9GaMR0YphpxUnkh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Apr 2024 08:26:40 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f7e8de9c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Apr 2024 12:26:18 +0000 (UTC)
Date: Tue, 30 Apr 2024 14:26:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 04/10] refs: rename `is_pseudoref()` to `is_root_ref()`
Message-ID: <3d7ea704177c84e5afeceea5848f5606f11e99f4.1714479928.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1714479928.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="K60W/KbtIC1h7ozo"
Content-Disposition: inline
In-Reply-To: <cover.1714479928.git.ps@pks.im>


--K60W/KbtIC1h7ozo
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


--K60W/KbtIC1h7ozo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYw43wACgkQVbJhu7ck
PpRRnw//RzONmvB4PQs768ZGekglSS3qsw9JTqjM56EMqeX/DWGL5OR+62bG3LQn
u1pzv5KhX6FTNA6sA2XSEMu6Ne6D9aEMvJf0gRxHPhbGUXCSzew+omljTxpekVaT
spPlRr5mhT9/+0kubCYDNNf2QNIAERM6+q5I3FMKyknZvQbpqkYirWlQtos74qc3
VnwiMv6AqXPY3kdEd6/SNhK+58Oi3a3wrhW9dBvlRiKHIDqaFGBeK60xXK8up4LF
Tmewlr9M7GKF+1i1DFwDD0hHHXFb1/K8BcklKLUy0Lm4qt9nKRSg9H6K58F3i2n6
+6fqoRllUSSkZC//IBbeuWyK33bZiOqUBV8vt6DgygcuOISp1HX6K7RzCMpWcVkd
p4MOIl4LydOaEQ2CjRuBzhMERkHEM235ziqsaaeE9tBiEk/snxzoC5Wjnu9fLkEt
X5/4grkmeOSM7MJ/9Z9Y/ynWMXWhLeE4GnoIHndGQn0EZZTvWpKHex9gN2RkryPM
CHJUBQhkeXBRU3YaDkJ7IzI2E3rykU/S6SyVFSMQ1O5BlMFj81gjz1PRt7gQQPD6
eWS9b73QB9+ccHKW3C6hGPWd/jb2pVvqjkNZgqm3bVlS3MhshkDF90iDTlEiB9Lw
4y8q9PkKU6YMKnZP+0ho54NWTRa4hvfomJUh00bKaMA7Lu08Oc0=
=3ZUi
-----END PGP SIGNATURE-----

--K60W/KbtIC1h7ozo--
