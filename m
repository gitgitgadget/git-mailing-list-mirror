Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2957517984
	for <git@vger.kernel.org>; Thu,  2 May 2024 08:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714637863; cv=none; b=N79cNWy5TutF2sBaSCs7kz0gY9aLEEbCuPKzl0lFvxfhhW1dpyGrVkjoTIHYNokhgwo/BITfROHN/BKIGBhqOQ6QRxZQNk0wm+ouaIGlwIsZDPQ5//XHGQAuBmi+Ki+wUMdE4RfWrMahjOI/ZOmz+2jLKPPyYcQT25X0efKhkSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714637863; c=relaxed/simple;
	bh=p6I93s65eUTSA9lEi1hWEwCemUu/VeoLAcHgnUWegCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJBdHwo+EsTyviz3Jwq+WaCxY9IFyq4mFQSOCzH1zKaFGVc8u/CY8iBRtoI6AjJpJB3nInHqRw6PKpEh8SPHgllj+bkAPwAJmlnfFhIYUoU4QatL5bgK9lkndCWteGKMJVIgt5H9i02s7WGCiysjairkGSIpTdNtDTbNQGSMlFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V8nZvjJw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PiM3y9yx; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V8nZvjJw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PiM3y9yx"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 62218114011E;
	Thu,  2 May 2024 04:17:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 02 May 2024 04:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714637861; x=1714724261; bh=bBOqlcLJty
	soYVrJa+NhEqgYyOkOa9QMiapxPVAJRxo=; b=V8nZvjJwi1n5YEh/2tOSScQX17
	jrtWHYS5JzjQIBpzY4UI4e73WsmKmBGx4xuCeQBOPDg9mNKF7IjkCijCpEpmegJd
	7EUfkuTRz5GBQIzbXkJ5y3QGoZdrli71S9PQ1Bm5ZjfRrpke0aAZQ+wt44I6Ug6U
	VeJKedRnAsXEFGOHCEqYcStlEvo2ipIMeheh2fYq9B+ud9KxIlCvywTXDhsUM/xg
	1gm0KDL0Pzu6iHY8iJLjoJ9EGKoT4np5fSuScd66rnKEn//5//pH2q4Sr9DaCzr9
	uD/elBSoiiTGYfz7KiOcKmt/s8sIXqt6+OQLL6xMMJirs1IFiSEOY4hxnrfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714637861; x=1714724261; bh=bBOqlcLJtysoYVrJa+NhEqgYyOkO
	a9QMiapxPVAJRxo=; b=PiM3y9yxyXBLgB5m2E4wpIKr6QeRaQRXHRQ50ZzEueH8
	Q1bQFkDp+sS243AxpcbsDb28CPfXix1q5TLZ/Ik06D/xcfbOEvnUoNBkmUyxN44X
	W1MyoHAaf0LKEwaG3aF74CqNGTeyQweyt0PItIabIc8S6augyk9y2T1v3rydHsn+
	5DolkmESVVUyrHI0vpnRh6t0JTQdz95Magm6VUJsZ6qILftei3hBiItaDPNWGT7E
	o/32SrGLa1/GXuImdqMBIOCU3q7PWKJJRaGoiDd92x9ZWtXugaVLRSrMjk0l3z9A
	ZwZez1/uArevpKWxaL7a9meN26TvO1+7tYnnvmJKdA==
X-ME-Sender: <xms:JUwzZvPhdnxUcPASBiuQLtt-jyDxZkNeEZ9KzLKNGNBNMlORPc8lZA>
    <xme:JUwzZp-imBv2gGC1MUWw02VSs3mW8okCy8VAf0Wpsac1Q4av2jokUkaaXsPjSs9nM
    2JmIEREtPvs1VCNPw>
X-ME-Received: <xmr:JUwzZuRvDKZSBcEwz3FZQmg4HTVFdSq3CoC7CoFOCg9LvebjsplrGZiFCER7UdL3BjSh-RuWWiteGM-WMw-WQdGSmrtHhCAG_OAuSEeaEu0YI8Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddukedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:JUwzZjvo5QIuhr0JcToVAAFT_cWTSiqNCfJQMBn9lxfHXJxvlduFAw>
    <xmx:JUwzZnenMEfOExsxkJqPbNOINR3FvnjmRJEdK39Goq7ugop1GWkfrA>
    <xmx:JUwzZv3TxhrMJtUkLc__RV9FyCadMXRFwAqqnsq3LXE08sxZqN_f-w>
    <xmx:JUwzZj8i904WHuwgCxa47XnyJrInBJLnjTX8E-Q48vmUXyt4IzLKCQ>
    <xmx:JUwzZpsSfHWdLC1j2Ia5h8x-68Jt5-1oot1ZKwFnPThdEUt_xjTkWWX2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 May 2024 04:17:39 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 10c29cc6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 May 2024 08:17:14 +0000 (UTC)
Date: Thu, 2 May 2024 10:17:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v3 06/10] refs: classify HEAD as a root ref
Message-ID: <c196fe3c45eced5aeaee3afb59d42ba3d16ff9d9.1714637671.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1714637671.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ox6s7T9iBfqOXl9i"
Content-Disposition: inline
In-Reply-To: <cover.1714637671.git.ps@pks.im>


--Ox6s7T9iBfqOXl9i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Root refs are those refs that live in the root of the ref hierarchy.
Our old and venerable "HEAD" reference falls into this category, but we
don't yet classify it as such in `is_root_ref()`.

Adapt the function to also treat "HEAD" as a root ref. This change is
safe to do for all current callers:

- `ref_kind_from_refname()` already handles "HEAD" explicitly before
  calling `is_root_ref()`.

- The "files" and "reftable" backends explicitly called both
  `is_root_ref()` and `is_headref()`.

This change should thus essentially be a no-op.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c                  | 2 ++
 refs.h                  | 6 +++++-
 refs/files-backend.c    | 3 +--
 refs/reftable-backend.c | 3 +--
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 6266f77474..5b89e83ad7 100644
--- a/refs.c
+++ b/refs.c
@@ -874,6 +874,8 @@ int is_root_ref(struct ref_store *refs, const char *ref=
name)
=20
 	if (!is_root_ref_syntax(refname))
 		return 0;
+	if (is_headref(refs, refname))
+		return 1;
=20
 	if (ends_with(refname, "_HEAD")) {
 		refs_resolve_ref_unsafe(refs, refname,
diff --git a/refs.h b/refs.h
index d0374c3275..4ac454b0c3 100644
--- a/refs.h
+++ b/refs.h
@@ -1059,7 +1059,8 @@ void update_ref_namespace(enum ref_namespace namespac=
e, char *ref);
  *
  *   - Their name must be all-uppercase or underscores ("_").
  *
- *   - Their name must end with "_HEAD".
+ *   - Their name must end with "_HEAD". As a special rule, "HEAD" is a ro=
ot
+ *     ref, as well.
  *
  *   - Their name may not contain a slash.
  *
@@ -1078,6 +1079,9 @@ void update_ref_namespace(enum ref_namespace namespac=
e, char *ref);
  */
 int is_root_ref(struct ref_store *refs, const char *refname);
=20
+/*
+ * Check whether the reference is "HEAD" and whether it exists.
+ */
 int is_headref(struct ref_store *refs, const char *refname);
=20
 #endif /* REFS_H */
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0fcb601444..ea927c516d 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -351,8 +351,7 @@ static void add_pseudoref_and_head_entries(struct ref_s=
tore *ref_store,
 		strbuf_addstr(&refname, de->d_name);
=20
 		dtype =3D get_dtype(de, &path, 1);
-		if (dtype =3D=3D DT_REG && (is_root_ref(ref_store, de->d_name) ||
-								is_headref(ref_store, de->d_name)))
+		if (dtype =3D=3D DT_REG && is_root_ref(ref_store, de->d_name))
 			loose_fill_ref_dir_regular_file(refs, refname.buf, dir);
=20
 		strbuf_setlen(&refname, dirnamelen);
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 5a5e64fe69..41555fcf64 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -356,8 +356,7 @@ static int reftable_ref_iterator_advance(struct ref_ite=
rator *ref_iterator)
 		 */
 		if (!starts_with(iter->ref.refname, "refs/") &&
 		    !(iter->flags & DO_FOR_EACH_INCLUDE_ROOT_REFS &&
-		     (is_root_ref(&iter->refs->base, iter->ref.refname) ||
-		      is_headref(&iter->refs->base, iter->ref.refname)))) {
+		      is_root_ref(&iter->refs->base, iter->ref.refname))) {
 			continue;
 		}
=20
--=20
2.45.0


--Ox6s7T9iBfqOXl9i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYzTCAACgkQVbJhu7ck
PpSnpRAAopITS1W6Wg59UxqURA7m7t7tE6aLldjs5KPZIhRK1cDhQIhN9RywrakY
ouGpzYXmg5gKdo9hbUm1vN4sNoE7C6WyhpNSUELeNWiPLsc8dGSWK0GX8z0v5x5I
DUb20uv4utLlksd4ISZtFOmfV3Q94Fo9kdkHiiAwx0F5bGf7ydxxPlj2xVstUhnq
VlaExhHe1nHU/mWWX4x4CEmMbMHxA0t57yC3nzvj6JOPalqEzPqeNxBKqIvuDocq
3ymfhB/+ottqrVW6eSk1F/TmQR9XR89u1VajaCtXdaxouqsLhC8Wizsf7XFDRc9P
72+epgo0IQeCSNACChHQ8Zshs4II+ZZXBIWOIRx5cIfVXSCXvUgq5pAzAxWbyBbL
3h24th4whDZw0BsSoob7rmcwVGgiXl1GQ1PAUpnYKnHB9MU/8SOpz8vb8FuHmZqS
E6NoGTXX5eWrRD2YXqlsLSEWAT+KIR1LRqeHZp4tw7qMqivdk7uS2KR5lrcNlRUx
1DL7bfs6Q5zQP7T5H+W/yFD3Oq/IsvJEXTPF7oEAysLy1Q/woXDs6CRqJouggU+Z
sznxyqM6qqRR+g7Nk93CvaMCABjOYndjoJOkU/hUqWiWQc6lT+PLpSHL7nKyp3EN
AdJ+aTzEoVt5498Jxd3vdlp4Ja5x6iOfFpwSKNeaQLTAXZq9A7k=
=2sy6
-----END PGP SIGNATURE-----

--Ox6s7T9iBfqOXl9i--
