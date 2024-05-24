Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327462B9BE
	for <git@vger.kernel.org>; Fri, 24 May 2024 10:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716545695; cv=none; b=AETdkyXHEjmuKDPc/FrCWbZbq9/dcBQettfMT4+JNuaOldOm8WrZJpN4/8dSukbSYUiJXflvlQJiHjGMeVBzI/26IuId+L79FxT1h2S1YUXLArvfnwuJ1d4zqYSfmaVIpscouLnFnpYNRuuEmhJbXRAiCWHbsQT8zYTh7Tyd48I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716545695; c=relaxed/simple;
	bh=tDOZyRYvdcJCFh8SyUw1CEzx3n8K+Ts1aOxCPYmhav8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKkJ8w7CbocWfcqccrawmHdwh2XInwO+6GzYDwi//tF/3yudM1RWKl1pHC+nudsKlxk89CeL8pMzDA3RZOB7t6qzygLfjNH2L2ZXJ3U1R0oVMXPCS9BBtL3pZC3hDB2D9D6m7SEQ7aXgX7Vy2baL5WIXcDW+v0YX3emHR7NlUcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZT5L6UCU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gvnZb22d; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZT5L6UCU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gvnZb22d"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 4EFE311400AD;
	Fri, 24 May 2024 06:14:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 24 May 2024 06:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716545693; x=1716632093; bh=vlonvWyQiC
	/Iua5t31YFed3cdn/ibG0IclVmQOLlYAg=; b=ZT5L6UCUiIkN2VDdzGpC79Tcfw
	/LqIZvuDJtD2u2IMPFBWeotWaQCfM51cit+Qe1bZKxMzdI/Xet4i1ONojCOGffAQ
	PX760H6BhSNbRrkhVUvyQqa1CCIYE723/w3VcZ4nednXI4Vc/1m0cYKktVfVx2Yo
	LLDvlgIZXAM6mBOo4M+AY5dDmNMe4o/tr4Q8onFPLigTAVB4Oqz8a2oXP/a7/okR
	WkYNtzUCwnghNtT1KQsjmgPYnvJ4h9mopSuuwmVHkLkqHc+rH26dxyBIKNiRp6a+
	UX1kICWLmYucgM2wAcukmcOEsyzXwy3K6LwGo4RKP5Mmev90348WzMwQRuFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716545693; x=1716632093; bh=vlonvWyQiC/Iua5t31YFed3cdn/i
	bG0IclVmQOLlYAg=; b=gvnZb22dlXIqvgEkww+RrWH0vX0oaUO81P7GABjlQ/Sn
	TsXRpYlFGoqqhyKZJWiOkWP9vvEi7HCX5R2SV0GLLFol+wnN2wqvs0wcIIn441Qk
	ZvTK2GmeiwuLAMOblaqwB5IF+bjtvNnSM8F+E03Tmdg+qTvrADp3FRl0KDzbtlm2
	KG0smnM3702HavvmTsY0BGywfLRTdyUWCpBZF/0teTHZA6Eg7F3mM/HJmoptl7Ea
	twVtGLQiJwk1hoDajPmgd4QjM5iXnc3rHOCcpcwyv1IRmWeKJsI2q67rjd1ASJzt
	aJyoC4T8y8mBI/r5fFdSjR1h0UGFAVqnHfI8xrC4Cw==
X-ME-Sender: <xms:nWhQZoboPrgNvHWFDBqt0A8_qgt7xvHLO5jjb-cgYd1uaSejf5P5Pw>
    <xme:nWhQZjaBL8_vyg8iaYcf5LhYMvmNIwE1ORWOU91rEhWAl7p0Vx8kpE8blrG1Mg6qj
    4Nv3fYEaf8KtUcLWw>
X-ME-Received: <xmr:nWhQZi_geM5G509zZMTpvmMPzeiICKHjkwkhtQHsvfGd2J7HwMhT3aV6tqIK3VN7H9OH9rcgm13OjHHtVS8zUdePwlrDH_zV1BHAlmaV5nNqlk4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeikedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:nWhQZioaGTV3ANiQYZjrh8B9GIdBDZITRzVmxFA_ytSeCSO71oq8bg>
    <xmx:nWhQZjqkLfCwjGlZmNHyHHv-UYrkzDJWjlHIEB41HiOHNy0WxkV06Q>
    <xmx:nWhQZgSlWXexWCsy-1DyoxJyBHfcl7bnW-qcvQjltLlPqLrb4KvaZQ>
    <xmx:nWhQZjpsumUePTlXGOWqOy2VADba0-Xvyl4pW7OeBDzrQCV-TB1VgA>
    <xmx:nWhQZiUnSEv82jqW1zpTZRabOGptuBwFrEkrJSesDiN53CqR8NzvOSj7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 06:14:52 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a3d1f12a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 May 2024 10:14:48 +0000 (UTC)
Date: Fri, 24 May 2024 12:14:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/9] refs/files: refactor
 `add_pseudoref_and_head_entries()`
Message-ID: <71f31fe66ce8eb95fbbb8a646dad571ff57b8a72.1716545235.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1716545235.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pI714V6XsAfN3GLi"
Content-Disposition: inline
In-Reply-To: <cover.1716545235.git.ps@pks.im>


--pI714V6XsAfN3GLi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `add_pseudoref_and_head_entries()` function accepts both the ref
store as well as a directory name as input. This is unnecessary though
as the ref store already uniquely identifies the root directory of the
ref store anyway.

Furthermore, the function is misnamed now that we have clarified the
meaning of pseudorefs as it doesn't add pseudorefs, but root refs.
Rename it accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index bd0d63bcba..b4e5437ffe 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -324,16 +324,14 @@ static void loose_fill_ref_dir(struct ref_store *ref_=
store,
 }
=20
 /*
- * Add pseudorefs to the ref dir by parsing the directory for any files
- * which follow the pseudoref syntax.
+ * Add root refs to the ref dir by parsing the directory for any files whi=
ch
+ * follow the root ref syntax.
  */
-static void add_pseudoref_and_head_entries(struct ref_store *ref_store,
-					 struct ref_dir *dir,
-					 const char *dirname)
+static void add_root_refs(struct files_ref_store *refs,
+			  struct ref_dir *dir)
 {
-	struct files_ref_store *refs =3D
-		files_downcast(ref_store, REF_STORE_READ, "fill_ref_dir");
 	struct strbuf path =3D STRBUF_INIT, refname =3D STRBUF_INIT;
+	const char *dirname =3D refs->loose->root->name;
 	struct dirent *de;
 	size_t dirnamelen;
 	DIR *d;
@@ -388,8 +386,7 @@ static struct ref_cache *get_loose_ref_cache(struct fil=
es_ref_store *refs,
 		dir =3D get_ref_dir(refs->loose->root);
=20
 		if (flags & DO_FOR_EACH_INCLUDE_ROOT_REFS)
-			add_pseudoref_and_head_entries(dir->cache->ref_store, dir,
-						       refs->loose->root->name);
+			add_root_refs(refs, dir);
=20
 		/*
 		 * Add an incomplete entry for "refs/" (to be filled
--=20
2.45.1.216.g4365c6fcf9.dirty


--pI714V6XsAfN3GLi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZQaJgACgkQVbJhu7ck
PpRpqw//VnPWfp8G4WjWzHt8UB9ruRe8sBrnVqvhbrjt58D8tri+HY1O788zpFFB
ngfib4mGMQYoNg+NSZ8yXKQ+8hXkRIgzma8NiFLJ5rHPlWlLAkW77Q2qcQh1KQe+
wK7O5HX7HuoAhe89MDCrjKVLZxz7Fs1v1VD9FChisoomv7TIvvAdPjKFckn1v6v1
52utGMbqcVawIlNiwpnqTh1VeWSA9aoANS5QH61Brd1gvR9KtNqRcBogY7rhadoq
yb8WkWn13biuZj6V7HS/ACCoO5ip/aaFAGO4pgfg/LOivV/CIXwIhcCaLqVhK8TS
polbKJIkXi3iNmLpbUCE048LK7iAYjNVP9uRlIXR35ngyTCPQ9iBEcwlU+gNhV8q
cdg5Gu9M2npr8kOUmjy+Bvuq7tfg9lZ30+wYXswB3AFZiMqRtPuKMNlDNy/McYhG
azC7DDGPoQf6MQaqu5f7vEgv0sdIdAC5MymTyvgrH48C1n1uoI3MGpXRAQ9Q+EIs
miz773wEb1F0SfHSWsLIt4rIQEPIIZYluUce94qNsQ9UWjokn05HdUnlJJlXEmOa
WhLalKBmYqpd4m6rpOtwHzpx9NVyPQeWVtmEWEUJURmMKBp+oPwo4y6NFJJlMXwp
GXxn6EgkXMBD4ogH2gh58gNbTaEBLZ9XXHm5ixYFZoHAZehTwWk=
=1EME
-----END PGP SIGNATURE-----

--pI714V6XsAfN3GLi--
