Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8BB43AA2
	for <git@vger.kernel.org>; Wed, 15 May 2024 06:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755867; cv=none; b=i/ke/wsU8Qt9mS3vPsCpzBCBtYqyu9F3c93jkZbQhP4u90DrKOhk/BJ41D23H4fScDtDuqIfuAuR4ch2Io4jIfZG3SrEtKkyKTsMaDTqxEuuJ7aCWl+AzXYIsvPwGCDUuxU7HZ86QJqzLV2BgnAKFKJ5S+iPPXB23pAVphsbm2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755867; c=relaxed/simple;
	bh=7mP3HgpFX84d7LZirz1ZCAxaq4KFYGG8EL1WqctNPrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxExdFzpy6KdlDgWOg3U0/fy3XSb7EGQr9j8SFnEGAwxAP0dyXfVfcGq0fONyo56ELAEQa8NgThJVcFZij4xabw32PmTYqwDShtdRzvrAeiiflGCR3xfd5oDQ3pr2rIxfnETOMW2X701oS8oh74VsoK4EkffTWDYLCV9TjdZMq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Rg5KMvNQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bjN2zvdS; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Rg5KMvNQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bjN2zvdS"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8BA8A114017E;
	Wed, 15 May 2024 02:51:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 15 May 2024 02:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715755865; x=1715842265; bh=HZ1jZ16TfA
	Oda/sFVnEaQu5iF45jzBbUuFB1PhF99fo=; b=Rg5KMvNQjja8OjUi3DvP1gL16p
	HuTU8f6xEe3Pj+zKrAkKFpc2ZQSojiubLc62BMyTzPk4bVzkQ3wh6KbeInefPM4w
	z+gwrBOPA8q13bosAwYoO1u1g/qhjh4dIPnDvvBO+/vTjxKBgIADkcXE+Ty410u3
	jPxepjU4XaMBrPlK8XVAF/9Ck0cg/mB+trNsD/uk5LrV88mxFU3kS6kRNNyep36a
	jE6wGbZN0e4MGIG8W1tzbHSZV5I6GVsNAH2ybvwj0XDUKMsGRU/V568qdi4+oPv2
	KknMpneUIzKcC8awfVSgfsR9rrOCAtxDb0v+LsGK3YZM7LevNpGo89W8kSlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715755865; x=1715842265; bh=HZ1jZ16TfAOda/sFVnEaQu5iF45j
	zBbUuFB1PhF99fo=; b=bjN2zvdSX0Zu9KZb+G+WYAZbf+GxXV+5cv7lJYSBDvde
	Y4LHDDCMFz7NjVNwUq3JGUdGGMQ0IY14aQ6B1MSDfUNATLd2K1Iwm5C1rWIwR7eI
	84TvVKICEu0RDQUHeI0lD+wXkkeMko1Z+DFv8lpYSNdDNNBQ8AV8ETKVLibbC/po
	AiRf2Ed4BuFTjV8yugJDM/Ek+eQene7+aNTAKTZHFh0JvfxpK0AYNOmNChtnFOrG
	mGHZrqvaIBUMLC5l/GPdDi3UmzZpQQTTCuMYVsMU36zfKdV4Nwpsz5ToFzkgN0xn
	BxmfkkNdOP/loXaYtTmjJGzf5FH068Nj7cncFsuw4w==
X-ME-Sender: <xms:WVtEZpnZWeVx8VaXZRFAIcEln0dq1jnX0t1Uedn56gn0OL2V2r7cFg>
    <xme:WVtEZk04w-9SdA-tA5GTXqDb4sr4rVDqUG64tHJv1YF_MlBj7sFA2BvaIypz6O0zc
    AU0LAub24PjFHiPXA>
X-ME-Received: <xmr:WVtEZvp-EB8ARIQ8OiTJfpVD_BRwF5Qp2ZJoTZw-AreKOpW31MOIoAyotlYjY2xVWfJ3_l3BzIk-3KCIaCae4T_C6PqcvCuhhVYcVM1Kf2RBZUdH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegjedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:WVtEZpkYdiuqSsaRjVzkc9sRfgkZF64g-SHeyz8Omhpe9SxlgxvRKg>
    <xmx:WVtEZn2zsTLAjY1RmJ9LrHGPtl0KGWuOHo3WjNW7AamJiutB9Lhf3w>
    <xmx:WVtEZotWDpsP3cT54uuJNF-a_LIlQPsgsC460u_7dw5lSzIayztMaw>
    <xmx:WVtEZrVMnavR_K6OePFKIN0xO9728Qk5Qziou3HBu4bN5ohbLUaZ3A>
    <xmx:WVtEZgIaJYVCioscltbzwsaIF32OhyLnU2EpELSR2EDVezGvsWIoPcUE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 May 2024 02:51:03 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 82373e17 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 May 2024 06:50:41 +0000 (UTC)
Date: Wed, 15 May 2024 08:51:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <avila.jn@gmail.com>
Subject: [PATCH v5 08/10] refs: pseudorefs are no refs
Message-ID: <5709d7f780a990ef28bb1bd7de3d336ea994a8d5.1715755591.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1715755591.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0VtlGBOSUFB6x5XO"
Content-Disposition: inline
In-Reply-To: <cover.1715755591.git.ps@pks.im>


--0VtlGBOSUFB6x5XO
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
index 9fb1061d52..2074281a0e 100644
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
@@ -868,7 +899,8 @@ int is_root_ref(const char *refname)
 	};
 	size_t i;
=20
-	if (!is_root_ref_syntax(refname))
+	if (!is_root_ref_syntax(refname) ||
+	    is_pseudo_ref(refname))
 		return 0;
=20
 	if (ends_with(refname, "_HEAD"))
@@ -1856,37 +1888,6 @@ static int refs_read_special_head(struct ref_store *=
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
2.45.GIT


--0VtlGBOSUFB6x5XO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZEW1QACgkQVbJhu7ck
PpQ4WA/+J1UGJzDSwQkvq6OxenIK+HGLVty/PDhuhwCTLlPcRA/Q83OycIHGJB6G
8lHmh6TTVyryTw5yiU7sLioyBnY0/8mdeNkpzNiwnMQx2brZXTwZlu3JK8SoNkcL
NmKLnyuqWyYSBpXeioOQWI3BHZpBQhknXYYcqZ6WV8MUgd3YXJl4xK0oU/hFgrov
7sihjJHU3sIKlNrWc3/PJzyM1CzwMx0Ur3mCwEGnqw3UblYKu7ViGVFYK9+yMM/3
EmCGGMFWLRb6JYWiqgTMrAe+ykVEQTdm9WrTdC6lEA+6xu+TrxCHmXkW8hr1sEWg
eFhAb1xBXhGkSFt9FVHpHyst2rRSqmPFgMNnl8ISQf0Y1xG6zQFADYM2cGpzQSL2
AU4c72CAeAcPqyJ0X1XIbaxw7dx2+58DcEdk8t4yBcYJOUaJ5r44XJTRAD+l++Xn
KcrRLZxyZmmEN4xhRc7ewP9jRjQGZfyksvAY/dVl8M0eKGiUy9shUO8AwSYETrxL
MrBeyXAeM5KSF2GOUX0voFy6rqDsIby/dDRyhDgYiRVxGE0/B7R3jqRtDrg7OitR
rrTIeCOHJahUdlSOEp0AKxahV/Zb707tRuwBEUT3xzv/LjMYRTkykI0B205UCDGu
jVfXJote+sScgxzUxRFVNyGnSBgQRjg7CaLXHDxvrfW7DkARpGw=
=quLu
-----END PGP SIGNATURE-----

--0VtlGBOSUFB6x5XO--
