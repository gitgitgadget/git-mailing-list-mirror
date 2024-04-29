Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC4367A14
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 13:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714398101; cv=none; b=l4bqtadmxWtNbBQH3MlDOmyrJqIXAsy0dEef8p6fH+92kuCZc42W+C2yMYUM7ZMEtobmH2GztYk/fqdgnp8fn3ga/q41hRsii6joqY2AObmL+CkcztFFzwcixXIBX+iAdBTDo/J9SqAAA6YgS37a5wemPq12I+vjx2Gfhvmxbb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714398101; c=relaxed/simple;
	bh=tW8gO2xX/cOdjm1EiDubYZOnPSViyK5JPbXV5r2yPXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlbBuarJnbLmYhChMmVz0KZwyA98AYO/oM8LTyx/CnNfDthv6gJslHTen3P15u6fanQhjpXZky2IqiWF9Ovt8ViBkEk3bPShewr09mh41k7vcI/d3y2Vk6xJDlh5inA9u69j7q5ihMadM1Y4QhvVrq5qvAxAZbOdOrfdQ0VAZ98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oTv+KG6P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GilmCGit; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oTv+KG6P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GilmCGit"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 17E631C00170;
	Mon, 29 Apr 2024 09:41:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 29 Apr 2024 09:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714398096; x=1714484496; bh=49ecpl2HkP
	XvokZqyVxbjPyBwt7BOfkksyq/g1SNEMo=; b=oTv+KG6PEVmaibsaepeXG4Bu8h
	ebaZdDiC2P5vmGAz99Vto3WFfcP6fKhoIZC9b2Hd5hJPmvmiLqkNrro4nATG6MVF
	5MQOHJtGtM+gV+kO298GSdVwU4sZfcYImaRyqD8c3HgEjfYr7QWFXkqzYCNbXtBL
	uuEkpDK7QQcN8PbSv6Po8be3CgHstw6mM2N/ibEOipKpbY6DV/+E6R7Iub/oLFDo
	1kjKuPtNAg1RnKkpnHGnhTKort4BRvtDLxdxqXtU5FfbdwEg9oKY/8fRPFv8t9/n
	tYy5Igk7+FVMCHKSNnYTdsGUAgM2pFbQtdXJU8cUbCXFxlk8ObllTIgVilxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714398096; x=1714484496; bh=49ecpl2HkPXvokZqyVxbjPyBwt7B
	Ofkksyq/g1SNEMo=; b=GilmCGitbz02Vkezjg8fUo6HGFSD93omtmr+8FZT69MU
	ZWo7sQMVgnvIk5jbN05Y+yxfoIq84G2H9mU6NgEiKnNX5WY3vPp2LwmoKEGaauYg
	8zAd3er6oyr896RTHCyHGDHHCAM4kED/1/XTkOdKg4rYXo41W1zpLNa76l9QwDtE
	pODgDytF3XAgSrjOpnU/nvlVJLRQ3PaadYGlQQmAp+pClXtMZ1s56sMiBK820Ov3
	FHNi0nQgGPs6kFRU3hz6ZNOOqN0FwMqqToY4lfmPGIrjfSAweaoDpeDu1pRgS9UD
	niwtuD2yLR6xlSA5f1HZeHEadxj6scPxf7KsF6/j0Q==
X-ME-Sender: <xms:kKMvZsUGDM93VPHZmkvxxyIHiil4WZ95hckDWMJ0v-EKw7iSEEr_WQ>
    <xme:kKMvZgn8xVEjtv7KeYbNZQlS0kgAf4tPa4tYPMX4IB-Z2rPNvI5zja59zWgL4rMxr
    OewzijpbXMXDWMaOg>
X-ME-Received: <xmr:kKMvZga-aM8wIuEWWLOp3qxXAxx3HUwj0ez-6FajgeQYQnrgaMjy0y-LjYDwaZLCRdNk0oq2m0JYBO_VEOEcwZ5-mCPzfFAW-0AYa6jTQtIoZMZ1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduuddgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:kKMvZrW4vRB0Lz8hOu9qpAVSOW0lJugZgJnzwEh6CLNvHc9yUq6zGA>
    <xmx:kKMvZmkH2g2osY2jsdVICC1AEZUXEWFcCZJgbB9Gz7M5nrhL8a8FWQ>
    <xmx:kKMvZgcaMCy8G8sZEsRFCODkTZTt9B0iVhlbcNWDe-Qtn7F9AlnW6w>
    <xmx:kKMvZoHw7orS9ievJKEMdeu5hbh1XoR9QKeW4qKBwgkT7yO6qaJUeA>
    <xmx:kKMvZogZCZTndLWLG01VDDy_T-bkKvAwuVBxCLJUwMxk1-R8dlQi11e3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 09:41:35 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1ea35f53 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Apr 2024 13:41:15 +0000 (UTC)
Date: Mon, 29 Apr 2024 15:41:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 3/3] refs: fix segfault in `is_pseudoref()` when ref cannot
 be resolved
Message-ID: <88822afe950318c0312de5541a411942a163b139.1714398019.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DV2Sw1k2uI/XLuMh"
Content-Disposition: inline
In-Reply-To: <cover.1714398019.git.ps@pks.im>


--DV2Sw1k2uI/XLuMh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `is_pseudoref()` function has somewhat weird behaviour in that it
both checks whether a reference looks like a pseudoref, but also that
the reference actually resolves to an object ID.

In case a reference does not resolve though we can run into a segfault
because we never initialize the local `struct object_id` variable. Thus,
when `refs_resolve_ref_unsafe()` is unable to resolve the reference, the
variable will stay uninitialize. We then try to look up the hash algo
via the uninitialized value when calling `is_null_oid()`, which causes
us to segfault.

It is somewhat questionable in the first place that we declare a ref to
be a pseudorefe depending on whether it resolves to an object ID or not.
And to make things even worse, a symbolic ref is currently considered to
not be a pseudo ref either because of `RRESOLVE_REF_NO_RECURSE`, which
will cause us to not resolve them to an object ID. Last but not least,
it also is inconsistent with `is_headref()`, which only checks for the
reference to exist via `refs_ref_exists()`.

Refactor the code to do the same. While that still feels somewhat fishy,
it at least fixes the segfault for now. I have not been able to come up
with a reproducible test case that does not rely on other bugs and very
intricate state.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/refs.c b/refs.c
index 567c6fc6ff..b35485f150 100644
--- a/refs.c
+++ b/refs.c
@@ -900,7 +900,6 @@ int is_pseudoref(struct ref_store *refs, const char *re=
fname)
 		"NOTES_MERGE_REF",
 		"MERGE_AUTOSTASH",
 	};
-	struct object_id oid;
 	size_t i;
=20
 	if (!is_pseudoref_syntax(refname))
@@ -908,20 +907,12 @@ int is_pseudoref(struct ref_store *refs, const char *=
refname)
 	if (is_special_ref(refname))
 		return 0;
=20
-	if (ends_with(refname, "_HEAD")) {
-		refs_resolve_ref_unsafe(refs, refname,
-					RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
-					&oid, NULL);
-		return !is_null_oid(&oid);
-	}
+	if (ends_with(refname, "_HEAD"))
+		return refs_ref_exists(refs, refname);
=20
 	for (i =3D 0; i < ARRAY_SIZE(irregular_pseudorefs); i++)
-		if (!strcmp(refname, irregular_pseudorefs[i])) {
-			refs_resolve_ref_unsafe(refs, refname,
-						RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
-						&oid, NULL);
-			return !is_null_oid(&oid);
-		}
+		if (!strcmp(refname, irregular_pseudorefs[i]))
+			return refs_ref_exists(refs, refname);
=20
 	return 0;
 }
--=20
2.45.0-rc1


--DV2Sw1k2uI/XLuMh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYvo4wACgkQVbJhu7ck
PpRo9A//b1B8KxENG74EpufT1RQDkxuPjtlZZ2KVaNrMrglCYRoZaHwSdCk2Nri1
fZdl5q74fWuE69ykupXXAWiYMe5UnUdjpwQd3wRlKjFXuFatMWJo0KkHYrMq0zSo
fiJhUxqrrUTh3jEPi+s7IwnJphElZmmvgxpTVCEdjeHxP8ECbeIiww35cwCmT4cs
4olb6H7tF7PBUJNCeT5NSxoGPC4wEhy+3D3DZrcas8H/B9J1FTI65yKLZr/QHm01
i2zW/oxR54OrUSMvUwOVCBVhIWuKpTMW6hrKWocUCrpbw+NdCniG8dqDh4g5dxLn
lZRi6ExJ10+3z/nMwn71ZD6hvnsG/dVgntJbm4TksQiPPtP2gpaKbDTELw/NzB9d
6pWvkQ7vXJ0dXsIQI6XecICkn8CVJ3gZ9tFwA0B5VpjUIPgfBX49smbIInq9GV1C
eM4OciOHa5+JPpPAS2ixcFkVTYZSUZ5uqZDsZwotLNDndAqYSU3CqdhSCybQRl/2
aADvTyAPkXmxR07Maow+PLolYILSUw4Jr/ouG2ttbTo+1fgCILdbqLukfA+xSRWe
abumzyF60TQoAFihV6ybRM4y1UPlAvD3bF1Mlb24JWBTc/mfd0ycd3QtlX2G3/r7
3YRzXjzyEt6IKuRFvUBSKv+NDkwxDNRHk4W4JGQ0BGTqok+/CiA=
=Bjec
-----END PGP SIGNATURE-----

--DV2Sw1k2uI/XLuMh--
