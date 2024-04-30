Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9879013FD8D
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 12:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714480023; cv=none; b=SNX39n9DOAWvzlIEiD7K1sNp7ETv7lzHfZe42qzyJ7ah3A6rJSSd1IxH4XbDfaQrNHV6C5dHGYr67NQwssibeMf26D0p+T39rVA/NgpAU8SBalBX92V5643TmE3f7PlxLzUy/eBPxU8VU/Y9nmr/VtfZracqqZuDJUWYSl48+vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714480023; c=relaxed/simple;
	bh=HeQuzra9/wyVxp3JvU3uSHxemgTkLJDhGIU4o6dMp+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNceHeoCsZXLNNzwGDmMnMktGb4WNDX/PTfNPTPi5TPSSYBZhzAtOKNbxv9yb2ldPp1zQITjnwcGwlw500i/6AJaUIcwMWmMc1+PZUP7bLEAv3VOc6wsVvr+eIkJCVJ4c8SH5wkx/ZIwrGqgfLZHbMI7eGI1FY61LRCGGqbE44w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iOvEQC6w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S8lcRdYV; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iOvEQC6w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S8lcRdYV"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id A671E1800177;
	Tue, 30 Apr 2024 08:27:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 30 Apr 2024 08:27:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714480020; x=1714566420; bh=iFKZJRYlJd
	0SC1C7mgl7V3fgC+TkIwn8/0y7yz6JYmY=; b=iOvEQC6wsGR0iFnhkvJZ27g/G1
	REuxKMj0DmxtEo5bfBqaRWKslsPS3W+anQtiRVSv2XkhIA7qTmQZhDLxLpTKlibc
	lynFI+iqV5HcyFVt20fJdW0fvSYdGCp7tcjeFfxTNYI3LBbErJ0kN/A2VMWllP8k
	8Mxb/xbuiM2hQlmmHaxqStN47Ek7gDVlN+RGMorruQDB1Ys+70uUg5nMuWLlF5a9
	+T7+mnTei3bR679DGunRq8ytDTWv/4rr3kISVi6N7ubpjfOAKbUy0UnqxMsOLikh
	gIgmytfqFAK+6EqWgr+FT9RGovrFspRh7DAXy5Ci/NZXlDJV17zYPSb2aTTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714480020; x=1714566420; bh=iFKZJRYlJd0SC1C7mgl7V3fgC+Tk
	Iwn8/0y7yz6JYmY=; b=S8lcRdYVkcCQDzo+a9MQEkQcQwQEMxxA2T4qmD7FKWBz
	nBzl4r0udNjQTNo9km5WZIUQMOgyoisfoeFitBZf/76CP3ag9GrbGROZJRAtSl1N
	Tph958hX9T+i/7GZ+NdDC4fhwafegFZlW28Qq+1hCeC6tABSPZ9zhC26ahm8F6fU
	c4N9GQBT3bjdyWy8ObDswXDAmD42Xg3A4zrcf1Y6eSIEqPCqLRHVezHNTTI/Kt9n
	V7PI9Hdq6kKFc8Cl1VAof/c9fUNTXXLwbiWyes4SjKMHthQsLek05Pn5HMaqgCM9
	DGRXxaqYPB/MmILCMWzlYgGh9nz/T44wPRUS0LRJRA==
X-ME-Sender: <xms:lOMwZmRgnZ0ICrxV_xwQ47fuHiRd1iS37wptePrpgCW7M40WhN-efg>
    <xme:lOMwZrz-wVwNVtxa4hiL6Kh0LvRgl83oH_bleGfUGiWn54M876MyPf1PVwxejKuRx
    0vPjD4n4X4EoB3YiQ>
X-ME-Received: <xmr:lOMwZj22Jp6_e82NR8URt3PXa2R0I5kz9ay-H86xgmug87YmxAeQ1LmvDGo1sG_7gz6psK05bSGVfPnMVaJQSTN4GhcAvd0E59H1JNtp79a4Sqplvbbp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddufedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:lOMwZiDSVUlIypC9JdFyDtk6__tasUaHRxUoxtFHrhd2oTnU5yO0OQ>
    <xmx:lOMwZvj7FgZwdjLmAAnfpM5F5lhouD-Sb9ARdYVjbvHUtc6p8jBP2g>
    <xmx:lOMwZuq0sBdUQf804UQ7Aun6kKyCzhY1clC-Egz4kiwYCt4uMYSuiQ>
    <xmx:lOMwZijVHP_Knk_B2_ieVue425Zaf-QwFVv-S4q5Se8_iDvQ5zF5ww>
    <xmx:lOMwZqWmcxgBNA0MoIoTn28hdiIsmwymkoDcM8jjh3FFXxYosub-mKVt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Apr 2024 08:26:58 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 39f90c34 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Apr 2024 12:26:37 +0000 (UTC)
Date: Tue, 30 Apr 2024 14:26:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 08/10] refs: pseudorefs are no refs
Message-ID: <bc82d7ae65bb38017834121bf1fe86a3656e4c58.1714479928.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1714479928.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b+/LyyPunjUsJoAL"
Content-Disposition: inline
In-Reply-To: <cover.1714479928.git.ps@pks.im>


--b+/LyyPunjUsJoAL
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
index ca9844bc3e..dec9dbdc2d 100644
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
@@ -875,7 +906,8 @@ int is_root_ref(struct ref_store *refs, const char *ref=
name)
 	unsigned int flags;
 	size_t i;
=20
-	if (!is_root_ref_syntax(refname))
+	if (!is_root_ref_syntax(refname) ||
+	    is_pseudo_ref(refname))
 		return 0;
 	if (is_headref(refs, refname))
 		return 1;
@@ -1900,37 +1932,6 @@ static int refs_read_special_head(struct ref_store *=
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


--b+/LyyPunjUsJoAL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYw45AACgkQVbJhu7ck
PpQkYg/+OA+oclmi6X9Dpv4B4vOLlB8bey+8GqWAwAPaiv/S96tnxDv+4P5N/KUW
GTTfb9u+pkp3irWB6sOEKRAA+MipRM3ZTvyyaDs8Yv2fZRfLCASGv1cViz8NRwVb
Fnx2P6C+e58eI6wF75SZgLRyu+mrUvjSsb6jMPYgMeg/ccmRnRRNHtqv8jYBVhtC
bqHwDQo/dFi328L3XSoWYe3WErxverIfEz4AjmCg4a4EF+g0mBU4cbtMzjuLq0RY
ENaELhqVxsKObVuS3/vg0igo+MfLVDXIht9VoEmxAZRjc7ED8xNJldGrVdN5A22k
uXqC5jWbiU4JvznHXxWSVuYEidVlZJGoF7fKcZH3HFAvWuKQMwgL/3DIiPY7Jy5v
Ey7y5L/g6XafiHksOPeQobozSm3hlTvPo/Jf4WQcRHmBwYSMPHNtX13nXkhg0aOo
HRhUiAd6jTpa4re8gjIR3eG5AsGMYhxVzz1kCgG6KId+4cssxc3vpUkYhQMXn3+0
tKrPBURRitvXiYgGuFwZDV9fCd8qusySMx7i50/xCUnTmQA+L+Y5Uy+bQLj7QNr2
17oY+Ye5cWvGwEK0jUuJhVK16PWfn4SZmvSXzVOkv8sWVTSjaMc44htNme0kxr0c
8NwXi2f5cd6gov1Rb1y68PTiuJOsDL0br8/kulRM9RZHVqSMbpc=
=pEpk
-----END PGP SIGNATURE-----

--b+/LyyPunjUsJoAL--
