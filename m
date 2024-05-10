Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6889C16191E
	for <git@vger.kernel.org>; Fri, 10 May 2024 08:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715330927; cv=none; b=jyAjBEhfv7oCSaPoPyziNYJhVaxT5rYlmQMuwN3poX/QlZiOPC/l2tro58Ij1L5Mi2HtM9o1S/ybWDz0vj8PPHr6LxX7ItpAaWcREc66glZjFLbDuXsDDf74QX4vzA/41c0LA/WQNxoQLIm1LTciDFHRWfK11bJ2OVmQO+Cpj1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715330927; c=relaxed/simple;
	bh=K+gBb6aC/dX8HpJfKUbrOWEv/HzbSGMPsvlYa0EPLG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krwAorbUF8emq2aWrMQhtgA8JDMMwBLUfq2mbE3EXicgWUfXB7lRnw6/nd/k7MDZc0C7vcxt+5cCQfWjoWqVIYnFObFZ2hGagngI60Ipg/J8Yucqd6d3cy+c62NjyK0mv8X0LlT1U+Umr0HACqOlIaW+8h6gQfT0tX0vM2rqoGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HErebf7s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ijSto615; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HErebf7s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ijSto615"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 0CBDB18000FA;
	Fri, 10 May 2024 04:48:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 10 May 2024 04:48:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715330924; x=1715417324; bh=HXMXZr7fLZ
	voBMzl7VitVkDovqhk7hf+UBqIRyukYxA=; b=HErebf7sf5fSGM7TUxvaYhCklD
	9u71Gmpce9yiWKeuvkSIah4Zkm0ZOi5Y9ypt6+mHIyb95Nul9sbVib1XZO23O0NS
	QKZgEOou64lf+Os7zV2Kl4tUgV7cj8WD1yLIEOKZkiuMn3OdTGwWBT6oimgO1TC2
	C2Ex3PrzfIk54SKLRRZ1Fu6w9N4zoe9fM9QOxdDGy2Axj6ZZZFfw9Rb8inT0RRVz
	kzzMks1e3Gg7JlYYwZVXdTWAAAS3OzsnZIkf6P9cHnPautFIQWvyhvdZCsRwuX9D
	RdYyq/vUCo7p0T6d4iRL9X+YwkHE8YVNPLturAkvytfyADEDEbUdGP3B+8VA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715330924; x=1715417324; bh=HXMXZr7fLZvoBMzl7VitVkDovqhk
	7hf+UBqIRyukYxA=; b=ijSto615Vv+VR5GEZiPiiIdTn436YKY5Pgbjyu9pdG69
	uWIjEXAtJrOrJsWG7GFi/nKyr/x4KejHT9Ma+V1R31ZHMpc1G0BJSKXXJCjUoVg/
	IASfpskhQWoxyuP26WK7uGAwm7PQAXZmThjPi0BXoIAMcuTGhvKqODswEDFN1N90
	10dxvmu1lDX8MYYXedJEX5GxK/BAM21fZWHS4mpCpQMAHjgdzX7EmmUAozunr2hZ
	5uGxFuXfDbokmza4MniX0YVv/djvML32Die+l68ilcaSjZk2v28fQ58HXarpkEfe
	Bp6XOhhLNXDkmMU+bbWmt/CsWwp2+HL4tq8O4lXxiQ==
X-ME-Sender: <xms:bN89ZmLirovZvmetaqev71rEr_BOmymn2Gaz9tpSvYwzgBLXwur3EA>
    <xme:bN89ZuKLKI8qPzGSoO1V3HeOn_Zvm7MczYUSxBkgrvuSc72mmCIF8f7RZDuUyI-Tv
    sdjcWeiquAUsmk-Ew>
X-ME-Received: <xmr:bN89ZmvzqEn-WfyffNJeaHIg9nM4D5vtJkONnjSdEFJmsrmmvU7VSW2TWFytLDydnuth_pYCYXGOBeQFEh7dP1adqjDiUJsLUAaoAkrXPeUqpkkZnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:bN89ZrYyKZ3_qEZ8hEAUDBlSMWXvDruSOKhFM7t_gBpcM0W3gSn9kg>
    <xmx:bN89ZtbfJb7Q2T0D2TCwxpWOStRnrNrYLFE11JrQ1Oyv3JtEzxfYfA>
    <xmx:bN89ZnAuaWtfd81VqqLrGSymjC1PCg1hQhbJpCnxzxiTPyfH-rgyng>
    <xmx:bN89Zjb3Xp3ciC0afmGXmKLQFTs1Hvyio45f9Mth2l5wqCcKzWH6Hg>
    <xmx:bN89ZrOM96lRV-fhhEmR-nbPqDQT7_bRjlJ75fZXuf8W298hZiX5aCE4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 May 2024 04:48:42 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 2abf18e6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 May 2024 08:48:30 +0000 (UTC)
Date: Fri, 10 May 2024 10:48:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <avila.jn@gmail.com>
Subject: [PATCH v4 08/10] refs: pseudorefs are no refs
Message-ID: <19af8c754c5d88cfdf6c86d5a8136a97e6094185.1715330206.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1715330206.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8W0N2cjzmcdMwNr4"
Content-Disposition: inline
In-Reply-To: <cover.1715330206.git.ps@pks.im>


--8W0N2cjzmcdMwNr4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `is_root_ref()` function will happily clarify a pseudoref as a root
ref, even though pseudorefs are no refs. Next to being wrong, it also
leads to inconsistent behaviour across ref backends: while the "files"
backend accidentally knows to parse those pseudorefs and thus yields
them to the caller, the "reftable" backend won't ever see the pseudoref
at all because they are never stored in the "reftable" backend.

Fix this issue by filtering out pseudorefs in `is_root_ref()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c                         | 65 +++++++++++++++++-----------------
 t/t6302-for-each-ref-filter.sh | 17 +++++++++
 2 files changed, 50 insertions(+), 32 deletions(-)

diff --git a/refs.c b/refs.c
index 077ae5756a..f5e98e5b46 100644
--- a/refs.c
+++ b/refs.c
@@ -844,6 +844,37 @@ int is_per_worktree_ref(const char *refname)
 	       starts_with(refname, "refs/rewritten/");
 }
=20
+static int is_pseudo_ref(const char *refname)
+{
+	/*
+	 * Pseudorefs are refs that have different semantics compared to
+	 * "normal" refs. These refs can thus not be stored in the ref backend,
+	 * but must always be accessed via the filesystem. The following refs
+	 * are pseudorefs:
+	 *
+	 * - FETCH_HEAD may contain multiple object IDs, and each one of them
+	 *   carries additional metadata like where it came from.
+	 *
+	 * - MERGE_HEAD may contain multiple object IDs when merging multiple
+	 *   heads.
+	 *
+	 * Reading, writing or deleting references must consistently go either
+	 * through the filesystem (pseudorefs) or through the reference
+	 * backend (normal ones).
+	 */
+	static const char * const pseudo_refs[] =3D {
+		"FETCH_HEAD",
+		"MERGE_HEAD",
+	};
+	size_t i;
+
+	for (i =3D 0; i < ARRAY_SIZE(pseudo_refs); i++)
+		if (!strcmp(refname, pseudo_refs[i]))
+			return 1;
+
+	return 0;
+}
+
 static int is_root_ref_syntax(const char *refname)
 {
 	const char *c;
@@ -876,7 +907,8 @@ int is_root_ref(struct ref_store *refs, const char *ref=
name)
 	unsigned int flags;
 	size_t i;
=20
-	if (!is_root_ref_syntax(refname))
+	if (!is_root_ref_syntax(refname) ||
+	    is_pseudo_ref(refname))
 		return 0;
=20
 	/*
@@ -1878,37 +1910,6 @@ static int refs_read_special_head(struct ref_store *=
ref_store,
 	return result;
 }
=20
-static int is_pseudo_ref(const char *refname)
-{
-	/*
-	 * Pseudorefs are refs that have different semantics compared to
-	 * "normal" refs. These refs can thus not be stored in the ref backend,
-	 * but must always be accessed via the filesystem. The following refs
-	 * are pseudorefs:
-	 *
-	 * - FETCH_HEAD may contain multiple object IDs, and each one of them
-	 *   carries additional metadata like where it came from.
-	 *
-	 * - MERGE_HEAD may contain multiple object IDs when merging multiple
-	 *   heads.
-	 *
-	 * Reading, writing or deleting references must consistently go either
-	 * through the filesystem (pseudorefs) or through the reference
-	 * backend (normal ones).
-	 */
-	static const char * const pseudo_refs[] =3D {
-		"FETCH_HEAD",
-		"MERGE_HEAD",
-	};
-	size_t i;
-
-	for (i =3D 0; i < ARRAY_SIZE(pseudo_refs); i++)
-		if (!strcmp(refname, pseudo_refs[i]))
-			return 1;
-
-	return 0;
-}
-
 int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
 		      struct object_id *oid, struct strbuf *referent,
 		      unsigned int *type, int *failure_errno)
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 92ed8957c8..163c378cfd 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -52,6 +52,23 @@ test_expect_success '--include-root-refs pattern prints =
pseudorefs' '
 	test_cmp expect actual
 '
=20
+test_expect_success '--include-root-refs pattern does not print special re=
fs' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		git rev-parse HEAD >.git/MERGE_HEAD &&
+		git for-each-ref --format=3D"%(refname)" --include-root-refs >actual &&
+		cat >expect <<-EOF &&
+		HEAD
+		$(git symbolic-ref HEAD)
+		refs/tags/initial
+		EOF
+		test_cmp expect actual
+	)
+'
+
 test_expect_success '--include-root-refs with other patterns' '
 	cat >expect <<-\EOF &&
 	HEAD
--=20
2.45.0


--8W0N2cjzmcdMwNr4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY932cACgkQVbJhu7ck
PpSWDg/7BmDJvS3pGR/edAqJUzIhpXoi5NFXXaoVHlaBfRDjS5kgjvSQ8S5ayG77
m9h2nmx9MvbX5y2klg5me9SFZ9bKfOtUxMfdNRQ29Xn4UjOsDR5/WbKHVKGBeWUv
ijPW2TosbZfaeeZ2nmCXE/ULcuFtNEiqF6IiXQSL4OjB63Zi1lglRSLyEh8V/bRy
slprCn/kqg93/VGt64WhNZaJrhtub25DdIStVJQi1V9EN9RWy/xX1foDt0A2Wjnz
Bo7EM8+qoEQli8vnNzyrrghxmtp9ouVvl4pxXLsuTmdAr3nx1GUw+iWwm4K7jKgG
2ANGaOB5uC0+WWy8x2iEpNGJJYN3ASBsEN4h5/DvmiNBV7Gw8tNlCCB4C7+WqE+r
muIizzT3FH82RQl5g3HZRlgmS2zEg5y2VQujUTAyLxH078vKtA9X3r5N4PAmgBzF
WL9pzWckLcyFtBCq3PKof08aCh9dZRHWtd2y9IBFKqodCshHz8N/UiLu1jsjF+kN
JsC7A7igulrN7wSYDnjghtCe0hNK5oxcyWMd/vDJi42TIKVKdQnnl6gGkPxhoXdO
kBQNgCpd7XEALRsBJdIn/3AJLibt8Mw5gWyO5o2uJnP1qCYBOu6iviuoKpdk+NB7
5nkTEul6P/SF4uyWNtKAqDzmlgazXwvzNHvqf+Hc+6aXMN+KMV8=
=VTVp
-----END PGP SIGNATURE-----

--8W0N2cjzmcdMwNr4--
