Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD75D4CB23
	for <git@vger.kernel.org>; Wed, 15 May 2024 06:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755849; cv=none; b=jca8aa7NaPgTXebrtejrxWsGsUvVEbOnUqQfBR8G73wJG6+QNaEzX6HFN/mlMxlw6V2H3yM7CHstCa9xnzblWiiWRaiZq7oY102DaJwpADyROxnSYlm9ap4DYZkmskrvuB/HKs2AQGxL/WNpoR6hWc7JvPrCgkx3aFfKEay5bfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755849; c=relaxed/simple;
	bh=uAEIzNM+CJKn1CM8iZpeOsebNeZdn1IsA7uWuHkJ5as=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mInPVo71u7iiRmXrorOCQ4VqCTNyylKVjT9+ZNZ+md+6BNgQWf7F/TZGo3n5mve/LyeQZ72U2I7ZS3gqeaFgWfIV0WvPKOCuHC8wq6FVJqYf1DUdnHhRxhu7keZdacQwOF23lgh7mA/sVTi2tO/Nf/fu0+BFsBPA2zyeOuJiqqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QlZ5scC/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cebuGEJg; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QlZ5scC/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cebuGEJg"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id D9AAF1381431;
	Wed, 15 May 2024 02:50:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 15 May 2024 02:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715755846; x=1715842246; bh=96fuiI+SL1
	VOIdnM3OGx20M0WxP7zwxc+S1iSP/hcoY=; b=QlZ5scC/UyJ27gfoohvM6BbC0F
	TNIN/sprgFiKyosmqfyyMRN7NUNMqyGa3lKqGzEpH6kCNbNGRXvN16FtiL5V6JwY
	KAwuyrIc14o3tmMDfZnujupKf9g+ND5uGsVfjl0rWdgZfQclIG8B+GTSuulplIuw
	Sy+s800fuKR0fWnqoyUR+W50OO0jtrPawyRARt6EUfUuR9vNBt93wW/A3WiegcoZ
	SpFfbPmAIXCAm+Zlybsbw1R73/5oGjYODFaT+8j2hfm6DrYwD1LD03MGMhFCG0JH
	lN4RC+2TOFYW7Lr0NugWRhkJZPK5pVZ4oIPuIaDb18k5ed1R5ivTlUyLbqwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715755846; x=1715842246; bh=96fuiI+SL1VOIdnM3OGx20M0WxP7
	zwxc+S1iSP/hcoY=; b=cebuGEJgBDkajcGzvCE51knGi8ipYzQoltc6+NYSsvnr
	SwvNXEoZ/ie4LK2sVUjF5ReEZBdSGgvAk0Xm6ux9CHVRPsJAZ9e49Py49z0wji7H
	A4zj7Pxh4F39aTa8Ut6uJwqAvsYpG+oq3bWLrBZGKI7XCiOqA8jGFxgkDALvXOvR
	/+Q0oVUAFLLlfSETzrd0m+gl1rsu/c1edg8Wb5KM7OlmpPHJ5ouw15mkxqKR4LZc
	FXYSrTUEqmBvgK1ZPSLXGBNSaQUd74nOvhpSjh88n64MdX/rUz7TxG9f09Eog8xx
	5r/mYnmzWW51meos+UQflCJBxn5qykYKmzdAWVBPQw==
X-ME-Sender: <xms:RltEZlBUy1dNUwByWRkF_lcPwSu2WPPTHX4CRJ2PJBuyyD2Hxn1tqg>
    <xme:RltEZjjiCHGX9fvzE7Phk7x08VlVNai1k3PEcixubZlBuy_H1_o5kb6j7RD-RgPHi
    3i3ahMUwGetZncfwQ>
X-ME-Received: <xmr:RltEZgn6Bi-PGmtyK9tHr0ZAGJqGG9XZ-3tLHNB-G-wMDKF3EVHLu0Pg7kIZ9xvaUxNEv9DMn4MEqFYKzrKwp2RfOg0kUXWlWGI60brT2OgyPRiW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegjedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:RltEZvz3y93Z5EFe7zXxFZcWU8QbbAQsJ_Wz1MNf9I9eVssfjsB9cg>
    <xmx:RltEZqTCOBHc2wtVLVBn8DlTeG8BFGZN9DDVl0rsZg5Lwrzw6Oms-A>
    <xmx:RltEZibUIHz6XbrrXfN5NqbPhiqdp-ITMgDIBWP6VeCgiOUMGEdFsA>
    <xmx:RltEZrQJOlJ0f-ZihKXQj3_ik7idofOrF_WASlQHkhiFuF5J7TjcBw>
    <xmx:RltEZtF2fOKxILyeioRxfZJpJe67YhfimDCrV_Krne2C8N9tWhONbO6G>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 May 2024 02:50:45 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 2ec23542 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 May 2024 06:50:22 +0000 (UTC)
Date: Wed, 15 May 2024 08:50:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <avila.jn@gmail.com>
Subject: [PATCH v5 04/10] refs: rename `is_pseudoref()` to `is_root_ref()`
Message-ID: <33b221b248edbf18ee36a867e96a13d01e713846.1715755591.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1715755591.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LCPJNzM16Z3IhIb9"
Content-Disposition: inline
In-Reply-To: <cover.1715755591.git.ps@pks.im>


--LCPJNzM16Z3IhIb9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Rename `is_pseudoref()` to `is_root_ref()` to adapt to the newly defined
terminology in our gitglossary(7).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ref-filter.c            |  2 +-
 refs.c                  | 18 +++++++-----------
 refs.h                  | 28 +++++++++++++++++++++++++++-
 refs/files-backend.c    |  2 +-
 refs/reftable-backend.c |  2 +-
 5 files changed, 37 insertions(+), 15 deletions(-)

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
index 55d2e0b2cb..434c4da7ce 100644
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
@@ -853,16 +853,12 @@ static int is_pseudoref_syntax(const char *refname)
 			return 0;
 	}
=20
-	/*
-	 * HEAD is not a pseudoref, but it certainly uses the
-	 * pseudoref syntax.
-	 */
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
@@ -872,7 +868,7 @@ int is_pseudoref(struct ref_store *refs, const char *re=
fname)
 	struct object_id oid;
 	size_t i;
=20
-	if (!is_pseudoref_syntax(refname))
+	if (!is_root_ref_syntax(refname))
 		return 0;
=20
 	if (ends_with(refname, "_HEAD")) {
@@ -882,8 +878,8 @@ int is_pseudoref(struct ref_store *refs, const char *re=
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
@@ -902,7 +898,7 @@ int is_headref(struct ref_store *refs, const char *refn=
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
2.45.GIT


--LCPJNzM16Z3IhIb9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZEW0EACgkQVbJhu7ck
PpQeow/7BqUFPRmnuIDeWPfMsWMajPBPstz9K/Lt17WJ6nmVPMgBf/9EJRsmKaCA
893I+FZiXda2WGA/F86xEbpECHobnomXhOrp8ZKbrFDMFldon5XCY26QcB6+vLGM
kJqQq7YpuJvogOzlanWO7BmJjDHL5xkp1b/xEilyvR1Z5icA6Am7G29DT7MnbijC
lIy5H6s8C5ilI7aPFVVz1/S2/hr5BnXmEBWMnr+Odv68xxkKs2Tkgj/kbK7yZav3
9SukZzRDwlQycKJfVmuLVzdFjjgB71aBn9BdKzmVWk8O80mUvz9YP/ahZrekG4BA
/KQmxBaxbyTJRZ6DUaG+uenoTSqsbxTuAnHfk09GZBOEnm+LkJVEojJeNpSmLloA
21CTCZBByRDRxzXEbkwxwA9DivQxsLmtW58Jm6aeX85tnJAMJ4ukky++phoUx1iD
upTwmV6o2W2E458NJu02FqMTol2LEvV5vYTtcAwUr3+AoV498Lwgi6UyUuUmni9E
zHm+bhROCDv8pnrBtFiR6pqcq3avG2+mXxr2obDKGa8jBaSajr172WgTnRtt07Dk
dGLuQn4EyAQj0/fWTsnGCtFgLmjilXkohxHCZZ+PMGbEsWNhwJ01cF7YSd6Gzoqd
hBW5toGSV/YSjG/1Tj1QpMyg46FMqpsOSTGdnw53upgMzXN/3q0=
=zo4Y
-----END PGP SIGNATURE-----

--LCPJNzM16Z3IhIb9--
