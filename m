Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E67139FEF
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 05:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717651763; cv=none; b=tINq9FNd8PSiQfbcuPq5Xu2XjDjVCeGy5yCnfPKzf30E/VeJvTzWIgtoeafgBeYqyco1Hg0GGesyvlQB6jJuG3reEZ0TpFvOQNMtcKCyxaxoWjo4EGYvFqGiZLp+XDER6v5bMhbYt0a1PZLcbiiGpid9EbZ6qNC72gWJQHDA/uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717651763; c=relaxed/simple;
	bh=+541hOD0PpjWPWOp+/tlFdKd5rrJ4pkL20JN6vdUhqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blHymrkvLSDh2/5CgY7loIOnf0HJSSMHy9gKDfnrw58I/HwRgOZTx7oKP0jnrD5uNUwn7d/3RwKe3D6DTmWSeT+o4hFE6RkHJWA0us+88apHbJdcASLUxl5o8nEbGsX9gd0G8QhC3hcDhNbYGBxWWEiOCJg0Ko2zmF1ae0QvD2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X7ZBnSy3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=azaCatxY; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X7ZBnSy3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="azaCatxY"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id DF5BE180019A;
	Thu,  6 Jun 2024 01:29:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 06 Jun 2024 01:29:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717651760; x=1717738160; bh=7OXMiN6uPD
	IA2p9Ka0BkFmIPIbeyBY0irdGZXib6i5Y=; b=X7ZBnSy3pwkXU75X241b1jfmqd
	5G4kRCbgdXg0ntQC/0SsnSBfAxY0D0+AOfDRAsBzFNfOBQB/rB8qXn35QbYPJeo6
	3j9ggAiPKFtg36QSaz/N0I/wok0INvSnTHVhflgOEYDBQi3L4K2SyFbGdokEP2e7
	iT2f+DvwjKqG5KlIfdRE9XHVd0AXpapDD+wbwPXTRulpOgfMBh6KGvHjrZe3siMI
	N+92WHTSYcRxecyrUFXJ4hyyypA89DjHQyVU/yDkQieKuY4+3imK4yIaXB0n6t3d
	9AVEnSucbShMhtJgRoVhTvKijNQ+TcEJRK88bnrtSUnsLP0PTOsHS2ZeXrFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717651760; x=1717738160; bh=7OXMiN6uPDIA2p9Ka0BkFmIPIbey
	BY0irdGZXib6i5Y=; b=azaCatxYuahED4b60noCvQQEe9RKVSNb7nQMWwQXrVv8
	dPbs2cK99a3upeCWSU7zzzZHqrnNiyfzrzffPUTmHeR3EY74dmaH1Q0AkWI2KHP9
	HwVH9PglPPtFpFN8JCpZVtjt33eAwPP59IRa7RZemX1PrUnMRPcuHY5uFnavlyJI
	KC+Z3AmuixTN7zXXPdUHgt3TuMHzjnuPqPC5IqigVpg1mOaTLSrC90+pIremJqOL
	F0339vypt1B/P7kjKHRgIr/OGncQlOC57EaQvgNGVc9i59KoYCOWwCO1yETFpL60
	AU3qNL7RC3F7WPIfpGHVE/xUhNmywlo67In1LFSUNA==
X-ME-Sender: <xms:MElhZto4bAJWFS7cTiSuYTHgjHVA_0lwrwGsztL_hPJUCSBco77Z6g>
    <xme:MElhZvosFgAj5xZ2LFVQ0_mnIXjjh19ntdNlg-Y0TOLtzVz3pUi6TQg3fxPOOe6LM
    Dc7Z5a0fFTAGHG4fw>
X-ME-Received: <xmr:MElhZqMasi-5lsQKUz8t9YbyRziGwrfD03QmzjVCmuuYqfG7s2d3cxpSsh1npcYnz40IgcU9uaAAWqIT4MFXk_bdeCRqSGAeVgJgjwLcRRTJaXBT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeljedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:MElhZo4163_t3AAaAZDm_wbD5UZ4Ziotgb-OiBB4fPG15Y1yPNU_0g>
    <xmx:MElhZs4lb4iZqJuEHJMGRVtfV7vNpiDQZ_urj17OrjJ763KnFtXR6A>
    <xmx:MElhZgjJGPKYue-2tfBAMejISfcO8xbEu8pJOdpZmo4VLOdhITiUbg>
    <xmx:MElhZu5ZKA909jeMZGzF-gjV8mX08qCvGqdPFdjqu112O41l6SAlYw>
    <xmx:MElhZrbprEWEbL8a9KolRvyOk7dl53lfEdBVXy2f-XQoR0s8CJHv9LaF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 01:29:18 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id bdda3277 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 05:28:48 +0000 (UTC)
Date: Thu, 6 Jun 2024 07:29:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v5 05/12] refs/files: refactor
 `add_pseudoref_and_head_entries()`
Message-ID: <29147da2b9c3e67d1fa780d25f81ad6cae8b1b77.1717649802.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1717649802.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ibqQRM8UBeG10snb"
Content-Disposition: inline
In-Reply-To: <cover.1717649802.git.ps@pks.im>


--ibqQRM8UBeG10snb
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
2.45.2.409.g7b0defb391.dirty


--ibqQRM8UBeG10snb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhSSsACgkQVbJhu7ck
PpSebQ//bx6QsPeibd1SuFgI+Oc4VRv36YQfFfzi/2qioLAPkqMy0VRFzB9oFIpP
Ea3hLKhl4FxoD9MQ7LVBXthGzLGT3tIPhN5FXT5ksxWqb4rFQIlcDdabL+D37vub
NgG0iLedbdKx67c0b4QrZlJV2YOUT0c1sIJNiuCxzZOGFrgGFpl+nnxGbGtqReNP
IhxyHfV301mE/aGd+Z/4oCjXN58qaFFD9wIOYOKevNBgMSlsVaMUbwrvWrGEAmiu
0oPwZUyUEbVc5269B9cjMrBg8iMXGcTzzJEFgqQSKBaOCfiYjcThvyv+WqddVzWM
7Mo1az6pvAjry6xk2WPYQoklTiL9EaYhogGuJt6DnUQMspz5VtfWem5ImhJ6TobD
g/rar5xGcDzQZrn+NVAWinBJHgvCeltPCoPwo3SKyLnQalBvfQreKw77ohr3xzd4
qZj8ITcT6cChXqvzmxg/BBbADRre49N9oiPY4k4UlE35CizoGjAlj+FMZ1BSrPNt
bwBR16rnKrfe2uPvXJaVq3cHpisga5s0YanM7HmgwhdbaWKpdLcnBPb8DUL15ZKI
XhfKT1pasALSdhTK8AjVLyCrNqOE38fF2AB8oUZikT/g3nN3xL02w2hvOhJfOY35
1rrudHOkVnl3Ml6eOJnEFFdXFxNBuPFE/5fGPryf0hx2BwncZoc=
=FLBV
-----END PGP SIGNATURE-----

--ibqQRM8UBeG10snb--
