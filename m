Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88A02E3E9
	for <git@vger.kernel.org>; Thu,  2 May 2024 08:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714637858; cv=none; b=Lyis5tpbSL2MRBCAAWgtErzIP5XlUe+ZmE2CTZQSk0ZR8yPFc8vSUUJlrG1PRf2CbwIZQekc1x0HyHfn06vQlbNYuJHi9hYqk04269/f2cYW66NG0AV2eBfQWL9b/77im92DeFxfX9nomFlrNn5zpalm2Z1qibVk+bNjvOgKlCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714637858; c=relaxed/simple;
	bh=l/TkPV5aZKja7LGwU4b3Mdc7EGWEG4tVqG80o4y3MbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBWSUyan+Oy/2/iK7QI5QoYCI02yFq+ntKftEKgkTuw/sGjjTImqs2HBu1NS6a6JfQB4Mgf6vkNp846Adw12qtq7n0a5LcYnaKouuTfas+w03Xi6srAarQdN5pRs2Ff+cJpFLUj/L370e/czMkfTMmBh7ARvULhAyG2057vgU3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WBD3oIUT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fIgiAcro; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WBD3oIUT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fIgiAcro"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B8D051140112;
	Thu,  2 May 2024 04:17:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 02 May 2024 04:17:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714637855; x=1714724255; bh=cev4B/NJ23
	DjTS5ifC3cZMkwuMmEkHFCAUrqCQ6XhOs=; b=WBD3oIUT0tBP4LZwUKDFurehDH
	rjvcMKSfrN6sHdZUPbafnMlAi/3oOKcXfHGhZlGZRreU4sfnZ8kT5BMafkmsFhoV
	xcr7FlP+UgffVJicOMXNUTkdw0brwnK1PW0EU+IbGEhSLrvLmZj5So8I84y+QNQ7
	4nvcYxX6H6593s1HfqVlwn90Cg7GatWcXYhYMw2u9YlWVi8z0slx+RQwgq/mhKg9
	jYRVnk92v6Tg+TY+jnyy7FRYsy4hfMbJ/KphkLa6UIM3CBuBIhfUSAZaEcF6noKl
	zniOAVm6j6m4K9JIDtjldGjVq51IftqMyZeTIZpDTQZXm1i8OvUxsGIKfNQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714637855; x=1714724255; bh=cev4B/NJ23DjTS5ifC3cZMkwuMmE
	kHFCAUrqCQ6XhOs=; b=fIgiAcroaTbFZPpLA36sBI7aIqqYWNzvFO1bZY2fGsfy
	nhcKHvRfM9ns6KlvJ4VK7Cu7MJhzZmsdoUxvLRwb4VLxIOSWq10ZE4+RI/hVlhWp
	Iovher5qJkCrCteKpXbr0kZNxLr8JcyVDixf4Xsh1WukA00F0+pZevGYlx1awx2c
	o1B50oWgeNFF9bI0yTKf9JfJmp9UHEIIIEDZHS3ukKEyTmt8NQE9WH4U5vmc/kcG
	eq6pHZ5i4HhNsdiOna77PvhtmdZV9RohyAfV83yaVAmHe4g12wRd1rkX3zZjdscY
	vwyxTFIZWrncESY+0aSu6hQnPFfIVgGZVLwppPhVag==
X-ME-Sender: <xms:H0wzZgQ57-dML1L5q2FkFZmjn74P4bdVFyHqHbL92lSJiJG_wXYS6g>
    <xme:H0wzZtz6uv2H5GSWGnjj_FEbqioq0152UL8wD3P3p2j3CfObh5s9vqrkuqOdsTxGf
    a6GbRPUopRhY4FPBQ>
X-ME-Received: <xmr:H0wzZt3PLgjClInoCcnWLWiT2BvPuXpB2VSYs-kgh0oZFDazg9mR7vGtqtAQmgo8AcQNatTcrpLpKupnHWPr82BQOJknss_qUdZNOeonUPrSIlE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddukedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:H0wzZkB7ThVVSkRY2VoYykv8QVzX35khMRJsE_n_p_4cKgz6uMzlRg>
    <xmx:H0wzZpi-afAARIz1CJuyLIY3liz7rcZg9hXGg5NOz_16BvSEtqungg>
    <xmx:H0wzZgpTSWM0d5oX9Vq5zGgIoXZ-ewvKl0bmJRKI9jSzlubgl5WN4g>
    <xmx:H0wzZsjoqNLMrm5hJu-l7D_2hz1S3Dz5oRM_HiS_X2K3bO6tEYtOsw>
    <xmx:H0wzZhj0iACFq1qGJmj71zmuXm1TFNRV9GW9qR-veG74L05bxBTgw0Jn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 May 2024 04:17:34 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 85c6cb00 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 May 2024 08:17:08 +0000 (UTC)
Date: Thu, 2 May 2024 10:17:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v3 05/10] refs: refname `is_special_ref()` to
 `is_pseudo_ref()`
Message-ID: <484a0856bc947c3b0b05bf1ad3a9379ba4feeff3.1714637671.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1714637671.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WbpLSUNJzluT0KVd"
Content-Disposition: inline
In-Reply-To: <cover.1714637671.git.ps@pks.im>


--WbpLSUNJzluT0KVd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Rename `is_special_ref()` to `is_pseudo_ref()` to adapt to the newly
defined terminology in our gitglossary(7). Note that in the preceding
commit we have just renamed `is_pseudoref()` to `is_root_ref()`, where
there may be confusion for in-flight patch series that add new calls to
`is_pseudoref()`. In order to intentionally break such patch series we
have thus picked `is_pseudo_ref()` instead of `is_pseudoref()` as the
new name.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index 0a4acde3ca..6266f77474 100644
--- a/refs.c
+++ b/refs.c
@@ -1876,13 +1876,13 @@ static int refs_read_special_head(struct ref_store =
*ref_store,
 	return result;
 }
=20
-static int is_special_ref(const char *refname)
+static int is_pseudo_ref(const char *refname)
 {
 	/*
-	 * Special references are refs that have different semantics compared
-	 * to "normal" refs. These refs can thus not be stored in the ref
-	 * backend, but must always be accessed via the filesystem. The
-	 * following refs are special:
+	 * Pseudorefs are refs that have different semantics compared to
+	 * "normal" refs. These refs can thus not be stored in the ref backend,
+	 * but must always be accessed via the filesystem. The following refs
+	 * are pseudorefs:
 	 *
 	 * - FETCH_HEAD may contain multiple object IDs, and each one of them
 	 *   carries additional metadata like where it came from.
@@ -1891,17 +1891,17 @@ static int is_special_ref(const char *refname)
 	 *   heads.
 	 *
 	 * Reading, writing or deleting references must consistently go either
-	 * through the filesystem (special refs) or through the reference
+	 * through the filesystem (pseudorefs) or through the reference
 	 * backend (normal ones).
 	 */
-	static const char * const special_refs[] =3D {
+	static const char * const pseudo_refs[] =3D {
 		"FETCH_HEAD",
 		"MERGE_HEAD",
 	};
 	size_t i;
=20
-	for (i =3D 0; i < ARRAY_SIZE(special_refs); i++)
-		if (!strcmp(refname, special_refs[i]))
+	for (i =3D 0; i < ARRAY_SIZE(pseudo_refs); i++)
+		if (!strcmp(refname, pseudo_refs[i]))
 			return 1;
=20
 	return 0;
@@ -1912,7 +1912,7 @@ int refs_read_raw_ref(struct ref_store *ref_store, co=
nst char *refname,
 		      unsigned int *type, int *failure_errno)
 {
 	assert(failure_errno);
-	if (is_special_ref(refname))
+	if (is_pseudo_ref(refname))
 		return refs_read_special_head(ref_store, refname, oid, referent,
 					      type, failure_errno);
=20
--=20
2.45.0


--WbpLSUNJzluT0KVd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYzTBsACgkQVbJhu7ck
PpRbPQ//RHAgxX2YXmAFsa6Py/DQq6nJf9u864SHmr4hOlUif/OJwX4McYjO+Jew
vh7AfDmhL2Tn7xiA+uQGfg/1qbeMkJyK5rMmpHxRuTfyqkAeBbd18RV34My+j3D6
6mzC/aChMGj2WZJXTHVktEQyIAyLXGuicgGwq7ENTPaZjrN9QX3jjGIyBgRIn16M
cs4+iWiVLJLATmjyuJkoNT189RUAlpT4TyYl3dHl+eVC8GLK2UxCTWXNMaYjmZu1
TJLQO2ClRrf6hZEBor4mzPG0AO/9I58BenSAB/TJTdQhGz9uAJqN3REcP1I2iOjQ
Qw66RRb+NwriHqPkKJ5KCWHYm2QkOx74NDvamKtGnnjWBy4WgnLokVONZmhLk/F5
VIM5Zsdxs38sHe4/sYyYgkNvZXYY3uZMi2oKA74eiSPaNqX37ZIgM8U4nfkkomS0
HtswVB3Ntajts0Si+lepVq/WlW001EnX5SvHR+SonbzREnfg0uO7uAHa025O7GRc
/UAiLtAeWGJb41r5ugRLMt5JRNV5/cx30yYmzDHtbSeqioq3SVfT8LeWakU0NLfm
eEoC0grxkdqMzpDdKvVBg8d3sChMIlKrpJioTrezZYQVHtb1CWm0UrjcsL7rUfn/
a1+NGVEeS+ILLXN6ULYvx3LefJe93PngZ6w8ntzYfKYDPDSWllk=
=38EM
-----END PGP SIGNATURE-----

--WbpLSUNJzluT0KVd--
