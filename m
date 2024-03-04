Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634DE38FAA
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 10:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709549373; cv=none; b=S9RSkW+y4wR+iBafAkKHucNAf112SZY1dhfZOoYghP1GvBEb0LBwroS1v+HTwIbJSoJJzsRHcr3/CMwFVByDL6mMcLH+82wHSY72erjmTpkI9q3tdZ8NN1MdDJMQkTXd/67gIcakdFUyuG4dDTSWMYwbGXfE6eq5SfARhubOkg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709549373; c=relaxed/simple;
	bh=1xWx98DOZNzmPJxc/anYx3e0Xx/QBpAokO5y/l60nyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNBH6LPntKQHPx07NKut69rQPn+rw2qYsxdXJbGwjSpFjZriI8clvbcLtEPNIqhwrm6novCS5nBcStY9trUh1JNLmICDbBmXbJWw0OQMQzA/OBuCMunyHB2yEkyPNy9YjbNbkLo1bphWMDJG+QHUZBh/hfsiBQK4NtZIkJ5aOGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=g9rzTjaX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VXqICoZ+; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="g9rzTjaX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VXqICoZ+"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 5FA57320034E;
	Mon,  4 Mar 2024 05:49:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 04 Mar 2024 05:49:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709549369; x=1709635769; bh=j0DSDwRLVh
	8OJ3fvTmyfGX8V7IS5UirKp92QD60b0aA=; b=g9rzTjaXfka9CZKh5/sQkmWWZN
	MtgbtIe2/MWiRmEI57RNI5MTwEe2gUQayazYCp/+EHTTWzSuuNn1O6WhCTM8QuJi
	smljKPggnZkRhk/3Eg+iyzTSP7+EHWWbEyLDzlWjZoqc7JHpjch3lKojCxLcgNna
	qKHwtpNq61IRKSWjvJRcFodGlsazJOyTwJJdWQXiQIr121tVNdwzRnX+AxjrExnn
	QHKbJVDiH9rtYWiVE7F0iM3dj6+IkUQxBcMam1B6iVrJdUDppDyKsDXSNla/fnY9
	SP/VpH3FVyXtZKvXmcmpB9O1b3Vo363y5jhDw0HznnClIsM/LcZudWFZcqrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709549369; x=1709635769; bh=j0DSDwRLVh8OJ3fvTmyfGX8V7IS5
	UirKp92QD60b0aA=; b=VXqICoZ+isvq3h97rcbrVyCTpUe7RUAtfCz91N21tW36
	0QgvJmXjv8oECgSbEB+4rH9d7kdqte6U4nQSJNFVzJZJvEQQkpxZpKmRX+qUBXiV
	xFOEMbyxUM9/lkhpnbxC9H8J3l8wuy64FHO/o/w/VzgOliFtjpxFr3iz02ZHWcRT
	hACvK29FfFrRvsZFG2wwgDym8JzPVlE1WAURcHQ6s5sQBdUzxopGomHT9D4/VOAt
	xOTJzPWeWXH0GivBMiwIUP7RBMETJRDowRSVgzcleB7N2Yye44AsPewkbOeOKfmG
	IYEGG0oqgW9rBMq6uXI+dvezMEz4/GODKp5VWw80Uw==
X-ME-Sender: <xms:OaflZaHiaOhwU4UIoTt_laIMRuOa2231ledn3ErYKJWp0J4LEHmYXA>
    <xme:OaflZbVApwJJsKoZ1ct2grnY9A2n5O7yoZDCEMrms7V5VXdbPDexKRdcPYh-W2nGQ
    ycEqR2jlLnGKiS33w>
X-ME-Received: <xmr:OaflZUKDlfmZzW16LHNq22E5KnDq99KT1fdc2hFbXUwKTmI8i8dEDYcWqjaXRHh7A6MlnOa8_tLgCpZsBO8uas3X931EPv-4uPl3sYN5RCwhWD8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejgddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedtuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:OaflZUGbURqGjYyQqEusjHKlIf17eYcLl9D-sq6CYKjN3pkHBJ7gsQ>
    <xmx:OaflZQVFa0BuOxsy9YQSo6YeXNiirb8s82rlb1H3vP6R4beayQW_Rw>
    <xmx:OaflZXN9MUWGjkRWz4EyDJWa1FL4dvf3QXG4raCJf2bVzeSoml8SDA>
    <xmx:OaflZdgNNr8KNqgUqluKsCw5ufgbiJzHk0z2jq1SEERD8ouNXDE3rQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 05:49:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 54e3ee79 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 Mar 2024 10:45:03 +0000 (UTC)
Date: Mon, 4 Mar 2024 11:49:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, James Liu <james@jamesliu.io>
Subject: [PATCH v3 10/13] reftable/record: reuse refname when copying
Message-ID: <eb600f3bf38857a2d08bfdad5f8c6a51be029c16.1709548907.git.ps@pks.im>
References: <cover.1707895758.git.ps@pks.im>
 <cover.1709548907.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EJ1hdwYTGJny+IQ9"
Content-Disposition: inline
In-Reply-To: <cover.1709548907.git.ps@pks.im>


--EJ1hdwYTGJny+IQ9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Do the same optimization as in the preceding commit, but this time for
`reftable_record_copy()`. While not as noticeable, it still results in a
small speedup when iterating over 1 million refs:

  Benchmark 1: show-ref: single matching ref (revision =3D HEAD~)
    Time (mean =C2=B1 =CF=83):     114.0 ms =C2=B1   3.8 ms    [User: 111.1=
 ms, System: 2.7 ms]
    Range (min =E2=80=A6 max):   110.9 ms =E2=80=A6 144.3 ms    1000 runs

  Benchmark 2: show-ref: single matching ref (revision =3D HEAD)
    Time (mean =C2=B1 =CF=83):     112.5 ms =C2=B1   3.7 ms    [User: 109.5=
 ms, System: 2.8 ms]
    Range (min =E2=80=A6 max):   109.2 ms =E2=80=A6 140.7 ms    1000 runs

  Summary
    show-ref: single matching ref (revision =3D HEAD) ran
      1.01 =C2=B1 0.05 times faster than show-ref: single matching ref (rev=
ision =3D HEAD~)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/record.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/reftable/record.c b/reftable/record.c
index 2b52e47c30..12a44f70e5 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -205,14 +205,26 @@ static void reftable_ref_record_copy_from(void *rec, =
const void *src_rec,
 {
 	struct reftable_ref_record *ref =3D rec;
 	const struct reftable_ref_record *src =3D src_rec;
+	char *refname =3D NULL;
+	size_t refname_cap =3D 0;
+
 	assert(hash_size > 0);
=20
-	/* This is simple and correct, but we could probably reuse the hash
-	 * fields. */
+	SWAP(refname, ref->refname);
+	SWAP(refname_cap, ref->refname_cap);
 	reftable_ref_record_release(ref);
+	SWAP(ref->refname, refname);
+	SWAP(ref->refname_cap, refname_cap);
+
 	if (src->refname) {
-		ref->refname =3D xstrdup(src->refname);
+		size_t refname_len =3D strlen(src->refname);
+
+		REFTABLE_ALLOC_GROW(ref->refname, refname_len + 1,
+				    ref->refname_cap);
+		memcpy(ref->refname, src->refname, refname_len);
+		ref->refname[refname_len] =3D 0;
 	}
+
 	ref->update_index =3D src->update_index;
 	ref->value_type =3D src->value_type;
 	switch (src->value_type) {
--=20
2.44.0


--EJ1hdwYTGJny+IQ9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXlpzUACgkQVbJhu7ck
PpTn1Q//YWLoQWP+La5qOInyG5DeR2eIpB+rdNNYXe/vAnl8LZpLHbO95EVaw6id
4viDGxzK0vAqjHJelFShfU6KXzlh1ChStxtIB96uISBc/90QW7dYOwwUVhkI214V
qU88RodCE/Zh8OTT1n2FPs7g0ar81lEUI3WNZ0MptJ5/Gd4WMHcM6SCbZBt3BN4b
BB0oHSM1/TjpWpokXUSxbYRDMEYtgWL5iOs0uQfRvJF2ryvVbX96lxbmtZyNu12Q
1d4YYgbqB2ryuNzjcpgpHA7V7zEfM0rNcOnjK/gOhB8d52fwqIYeFwmMNOBNziDI
rqoM7LM5K7b6+neT+6XyIWCI242ORQRyT4qXmu3qGqBIcn9UltN03XXjz8j3dOaJ
0615YfMZLlnB0KzrB68A8PP5tdNjLtiT8CZ+PQTCnFp/TgEGdxMzkkYctAMBaplH
C9Qk8EmgGYDUz+MI1HvD/7Rmz5MVwah01o9XqP1mPspOt1jvPNnXDnq13Nf2YwNL
P75HAXyQRN/VYE4AJantXiWtO9F+m0xQA0EuIa9tccjxYYdT8QGXpzMm3XG90Sqp
QDS85OnECrpR14hujV/yLt4sT2XcwpI3N+L+kvgNwz3qJYgC+7MXVNRH2EuT8uCD
15bct4/XwKji9qMG1xuG+4QQwb7HQCtmpaYBJ1N2iI0o7agupW8=
=4q9D
-----END PGP SIGNATURE-----

--EJ1hdwYTGJny+IQ9--
