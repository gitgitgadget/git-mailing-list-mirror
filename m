Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776823A1DD
	for <git@vger.kernel.org>; Thu,  2 May 2024 08:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714637873; cv=none; b=uaTcABHQXEyPUXrm7dv9fJlLQsa+8KHW4b/P1NIx9tLoaFlHhxtJDaLJ0rNsuaBQ2wwawYbg4rht4IgTIssJKLY8cKKSTbWcR1/QzZP66hqEU0apRtugrSMUmxVQWqKzAtBJmnPo/XATkjURhsybtCiNj7gb23uCUjs9a6sdY5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714637873; c=relaxed/simple;
	bh=S4O6Yay9cNqdXSoK7mfNo3oVlYGySVoSdlVaDEh8Blo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8PXWjoW0uzOmfbx8d6nWCKmNeBDH7HY8uYF6x/5UGQm+ynhsCWvbXP4s0qRr0yueFv2MWFYHdS4+vIf4mR9sFf2sbdYPWViNMEHTv+QSk8sL/wfq3WCdXcznOHVk39bk6Wu4PJrdm1UUuH0dXZtTcIwJ45uaoYyD7rLWBYQMU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Nxi/RT5G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hYIG/5kO; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Nxi/RT5G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hYIG/5kO"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 9725B138106C;
	Thu,  2 May 2024 04:17:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 02 May 2024 04:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714637870; x=1714724270; bh=YkYuKXRsbS
	XBO64kv5vbwSwe5izugFNKJfPphax26tM=; b=Nxi/RT5GnFSDJRIdfKWpswcJKB
	iqlocsr+WgR/OFP/yxa5k/xt/HMZJDlg3qjVkInid79/aPurCZAoamP+ZsMxIcVH
	Tvfi8C6kd3kFksfhDoi1SioIAI2N/MBWK+a1aE188KJiALKFPVA9bWA+hukkJmJ8
	P9xgP21RPsvswWQcyMB9tNdAmicxASKMII/V917IFtZHVOPq6ZeHbQ6jrR/Hntw9
	fzvE5P1AkrYZ4FLzVH26O7hRfvEvlV7SJpUvAVaSgOaz/GtFWwy6GmnL9IPAdp8B
	uCn+gwkinO3G+pWrPzyEiXDyg+sUj7pK/Pt7KwcqmON3KBkQ4fJHVR/pmkLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714637870; x=1714724270; bh=YkYuKXRsbSXBO64kv5vbwSwe5izu
	gFNKJfPphax26tM=; b=hYIG/5kOv6RtazqWQRZP4Z0KCRImsXlWc4YwdVrg8y7a
	COKVPjGSGmKBHEiQGgsU0j2bEU1cen7U0G+dVfRNrbuxBEF+jpRAfx/0fVG9cEQ2
	0qMVeEiN6hyNuS4+y5ZTMEgp2ZPaAPbbV4QZgTB1q6o4a9ZIywVwQ4+Uc64s7N37
	m/KrQx/0Kn3NIoO9woV+s7bQFlSYM5jo/bAveoIsfFldL/X3Z7Mu19Wc9pmyxQCc
	6ikH44fhikOlN0mUd57zdvgHz7HDBdKTO+W0iZotGbjqEs49GPT+u+n3IQJNCAUu
	1e4T3wdo67NfUfZdhCzVS88cS2l6fBH2boL6TSemWw==
X-ME-Sender: <xms:LkwzZlHkNzSGWo3KGXNW771kfEbRsWDS-NwQilUy2ViAka-lN0n_xg>
    <xme:LkwzZqUYj3NgW5YEPktti53Oz_TNAZn9s9WrROzxvF5cgsWopEIAkQcjI5f9bF_NL
    5Zr2-iZL0OaznkFUQ>
X-ME-Received: <xmr:LkwzZnIUjolF7kLRhYxvQBMArQoI-RsayjgMlEV2PbjA80lfVIfKJgFw7BVImZWKx9x9YBcG874xcWuAfxn1lMaFTg94H--fGXkaPJeg1mLzlH0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddukedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:LkwzZrGM2DHH2l_rgxTBOBHKM3Wz6ARN4LmKJUEgL1JvE-V9wWJQnQ>
    <xmx:LkwzZrWxCjVN8K55aOxRVNG_R_r3VbUf5aMxnramLoIQ-a-4TYMqTw>
    <xmx:LkwzZmPk-HqrYYkpW94AFYswotwJ1uOJdxoFEpGoffnGxZeDjBMEUg>
    <xmx:LkwzZq3BC9Ep0ow7AchCky1iTl1muZTfNhw-C6OMjkp2U5VSdRS7yw>
    <xmx:LkwzZiEWtHJr_V5XooMDJoTTIQsSvG5SBh0qdCP_4CiREUs-u5M5uPNQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 May 2024 04:17:49 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f77b849a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 May 2024 08:17:23 +0000 (UTC)
Date: Thu, 2 May 2024 10:17:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v3 08/10] refs: pseudorefs are no refs
Message-ID: <8bd52e536329bb3ad1e5dfc34b42de0902511275.1714637671.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1714637671.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cxEY2ScMT0nh0AU1"
Content-Disposition: inline
In-Reply-To: <cover.1714637671.git.ps@pks.im>


--cxEY2ScMT0nh0AU1
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


--cxEY2ScMT0nh0AU1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYzTCkACgkQVbJhu7ck
PpQ4TA//XPj4vAxXKbE1vYQAL4wPOutdhOt85ugGcE3j1uzSolTrcM42U5KZSF+a
qycGKf/adXRH/pwzaAs/fV1JFZ4eioAsUEoX5/VdLFl6z+DoAmeKL/A0zH/ggJJt
Y9YtvOxjTjjKfxL3OpBrbSsvrSeUtpOmDirXfC7N1FFvyfg55YFzNDlL2od8O03k
spjj1tpoMePe9WrCigOVDRZQECOzyYsnLfKj6vqvV129jNP1E5Hd2lMprIJ+0vNM
5xVGr2xpL6r4bIUTEycWe26DkaOy0yAiTgGc+HhsBwrAdOBd9FgzH9RnP0z2tAvp
37OiUMxmG7WsFt+8FQH5oU3iqldMkZ1cP6tlEmKPJM6sfXhpvcSP70OUxTH0R7x6
JC31/D8Ebt93uuQrNNYYc0mRSgLBPO+HXq2VDMAdTR8tfXbzxjsY/F8DIUkgHJbO
bpcKrjqlucUeG0DOp051G/hKK2TvZTNJZqRovO4GU7P1Nnn8PKlRnLZvyZwhzEqL
F0p4Q0mVng0iOQm9uo1MoIaTp3+q9ZbWBk7WUO7q0f0v9ekasVyfSActbJ9FoDFL
xNPBg0HBiQ7FUdCg1emqjnZKaXFEKtAx17YL5sQfkSf22l9iYie8dLeyYo4hRYXn
/LjhH8e7WOg0lFNMaAOpqbTfgSvpH9eGKr3nji3btpU3eOwQG9Q=
=TT8A
-----END PGP SIGNATURE-----

--cxEY2ScMT0nh0AU1--
