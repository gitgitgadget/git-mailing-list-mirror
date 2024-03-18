Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD4C364B4
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 10:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710759156; cv=none; b=KsSCgtZCMlZQp3rK0fFqO31KfXvs8K/A31wNyfoIHW78h8QGNQ+ZCyj4m8mSwaZflGclSo3+JdsLfPVcj7Ru3LOyyXlqC6DnnE5Dsm71RMOxLQkleckYWe8gW8ElBq6mDmiIfRX8xRhmFDa1k+oYTaqd/wCz/NxzLE/zemDJFcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710759156; c=relaxed/simple;
	bh=vIzB8nBpZdgXFDDHwimpH5wfNZmSsXKsQTtLu2t6D3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPya7Un8yOViQah56Xwac0iAj6VPucsp4Ea+en027Bz4u+bdDDLhxGYm83mcWTfc7zVIQ1YNn++yIHZGLFyJAaM47evSg8BkDdVfMqvG7u21+ief0IZQ4yWAXUPcZSqg8irdU+VuuMvXM4XBWRMRxHbNrw+UFP2k8bmM0otkB18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OP4OrpT+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rTNW/833; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OP4OrpT+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rTNW/833"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6937A13800C8;
	Mon, 18 Mar 2024 06:52:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 18 Mar 2024 06:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1710759154; x=1710845554; bh=MtnxE3Mru5
	u8JNu8QY8OPDHc3GxnOXSJ8MA8LrgteNA=; b=OP4OrpT+pyytvFwsPDDSFGehNm
	4fIP5Jt3te79Yn1VADwY8r45YWEvZcU3h0Et42Bwdcq/Ny0ESilKG/poYEne54QS
	VIHBPyIloTrlJRjyRBnjX0UCNr2Szl8rEovaXBOFtUp7zDBUzV0S85XG/97KaHLt
	Rw11wMfKtTtWUzO5JnAii19qqZ6szJRobloG0PGXKf/kskyyY9MZNY+PfW1SjtIH
	0Z0dEG40GT/CboZjsjXMZslIUbHcOm9KhjoHeLJfv6RfTBtob6sXLABkuHCIUNAA
	2O5hxioTK6IBnT536LdlxyVwb6EVIjOQDoVwFK19LCgKGoe9jdEsKsmLVylQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1710759154; x=1710845554; bh=MtnxE3Mru5u8JNu8QY8OPDHc3Gxn
	OXSJ8MA8LrgteNA=; b=rTNW/833bqXMxuyXmCJOjm064gblw8DSKo0DMr6ju5PP
	yGeOE87hNMwbA2uja2j9bF0pw37LIuaQCdrJcm1RxMSghIxMOUrE5sn0oE+srOOd
	kd2KQgTmu8Tytb/okZBTFD6HnihGGU4jJImJH4bcfs7Lxn3yXroppGVWDz+3LyeM
	83MIREZexPlx/JFoCdHdJBMsWnhikZSlOWmJKw+WDdcqGWzpAqBSP9XGkH24mpJf
	eeMwyfxl6yYhPY1U1K9qlcnFDOxHDua2PMzFQTabQxSUsVS2UrvtiBkqa5wiZUUM
	oL2/SjMSwxgZWLjwYFHYJJUj/fvUYcY92OfZe/FH7g==
X-ME-Sender: <xms:8hz4ZfjgGhRiLKwOdG906pjaMyC9W4ieef3w3EpDvJWbdUKAU4j1tQ>
    <xme:8hz4ZcC1JnKRZ8Z4Fv5nkaHuCFEo74tliW0ltXgkIOmIta-YEXRcPDtk-ZOapygpm
    tEqutNE6WBnT0QU8g>
X-ME-Received: <xmr:8hz4ZfE6Jma5yNpho6WNWVXKfMUOVn8T52mYZuoel_OSJ0_hA06klcoauhgnQ_i4e6V6nO7umdGpmDf19_cGHvB0kF2638PuKS9GK8zDc0486g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeejgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:8hz4ZcQKS3A6LjSn34iIBT3VIk1BXTakhJbInbs8gS0UhpQOMLEHmg>
    <xmx:8hz4Zcxxk1zPsuQDy55d4UDsqt2plS2XZ8_sO_Sa7iwdVUkHShgKsg>
    <xmx:8hz4ZS5Y-zPFKg-agKDi_TeKzYWUqZOWHEP2oqn_8cDWoJUUZBVBZQ>
    <xmx:8hz4ZRxxQ5SzfFnUyhTSc9C9rpPSldWccOGhO9Yw61ZEwsB7bgn9QQ>
    <xmx:8hz4ZY9VeQV-suKKzDhflkChS17RSC0deQgixpFYB8csb2u9tIrnPQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Mar 2024 06:52:33 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0ba850c7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Mar 2024 10:47:42 +0000 (UTC)
Date: Mon, 18 Mar 2024 11:52:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 02/15] reftable/error: discern locked/outdated errors
Message-ID: <e837703ca1955fc2cafb49ccede12e926150a70c.1710706118.git.ps@pks.im>
References: <cover.1710706118.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="44OyvSMBCLIrr91x"
Content-Disposition: inline
In-Reply-To: <cover.1710706118.git.ps@pks.im>


--44OyvSMBCLIrr91x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We currently throw two different errors into a similar-but-different
error code:

  - Errors when trying to lock the reftable stack.

  - Errors when trying to write to the reftable stack which has been
    modified concurrently.

This results in unclear error handling and user-visible error messages.

Create a new `REFTABLE_OUTDATED_ERROR` so that those error conditions
can be clearly told apart from each other. Adjust users of the old
`REFTABLE_LOCK_ERROR` to use the new error code as required.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/error.c          | 4 +++-
 reftable/reftable-error.h | 5 ++++-
 reftable/stack.c          | 6 +++---
 reftable/stack_test.c     | 2 +-
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/reftable/error.c b/reftable/error.c
index 0d1766735e..cfb7a0fda4 100644
--- a/reftable/error.c
+++ b/reftable/error.c
@@ -22,7 +22,7 @@ const char *reftable_error_str(int err)
 	case REFTABLE_NOT_EXIST_ERROR:
 		return "file does not exist";
 	case REFTABLE_LOCK_ERROR:
-		return "data is outdated";
+		return "data is locked";
 	case REFTABLE_API_ERROR:
 		return "misuse of the reftable API";
 	case REFTABLE_ZLIB_ERROR:
@@ -35,6 +35,8 @@ const char *reftable_error_str(int err)
 		return "invalid refname";
 	case REFTABLE_ENTRY_TOO_BIG_ERROR:
 		return "entry too large";
+	case REFTABLE_OUTDATED_ERROR:
+		return "data concurrently modified";
 	case -1:
 		return "general error";
 	default:
diff --git a/reftable/reftable-error.h b/reftable/reftable-error.h
index 4c457aaaf8..e9b07c9f36 100644
--- a/reftable/reftable-error.h
+++ b/reftable/reftable-error.h
@@ -25,7 +25,7 @@ enum reftable_error {
 	 */
 	REFTABLE_NOT_EXIST_ERROR =3D -4,
=20
-	/* Trying to write out-of-date data. */
+	/* Trying to access locked data. */
 	REFTABLE_LOCK_ERROR =3D -5,
=20
 	/* Misuse of the API:
@@ -57,6 +57,9 @@ enum reftable_error {
 	/* Entry does not fit. This can happen when writing outsize reflog
 	   messages. */
 	REFTABLE_ENTRY_TOO_BIG_ERROR =3D -11,
+
+	/* Trying to write out-of-date data. */
+	REFTABLE_OUTDATED_ERROR =3D -12,
 };
=20
 /* convert the numeric error code to a string. The string should not be
diff --git a/reftable/stack.c b/reftable/stack.c
index 92d9a7facb..eaa8bb9c99 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -529,9 +529,9 @@ int reftable_stack_add(struct reftable_stack *st,
 {
 	int err =3D stack_try_add(st, write, arg);
 	if (err < 0) {
-		if (err =3D=3D REFTABLE_LOCK_ERROR) {
+		if (err =3D=3D REFTABLE_OUTDATED_ERROR) {
 			/* Ignore error return, we want to propagate
-			   REFTABLE_LOCK_ERROR.
+			   REFTABLE_OUTDATED_ERROR.
 			*/
 			reftable_stack_reload(st);
 		}
@@ -591,7 +591,7 @@ static int reftable_stack_init_addition(struct reftable=
_addition *add,
 	if (err < 0)
 		goto done;
 	if (err > 0) {
-		err =3D REFTABLE_LOCK_ERROR;
+		err =3D REFTABLE_OUTDATED_ERROR;
 		goto done;
 	}
=20
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index 509f486623..b0c7041a4f 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -232,7 +232,7 @@ static void test_reftable_stack_uptodate(void)
 	EXPECT_ERR(err);
=20
 	err =3D reftable_stack_add(st2, &write_test_ref, &ref2);
-	EXPECT(err =3D=3D REFTABLE_LOCK_ERROR);
+	EXPECT(err =3D=3D REFTABLE_OUTDATED_ERROR);
=20
 	err =3D reftable_stack_reload(st2);
 	EXPECT_ERR(err);
--=20
2.44.0


--44OyvSMBCLIrr91x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX4HO4ACgkQVbJhu7ck
PpT3dA/8D/K3X1NHuJXftQsDkm7PrNkmYvMEHjvTeaOhPH0Uzwf4qAdAk2TOxIEl
POlEY/RJjw3wYmu/mBWy6q975Gq4hLXZVBGTkk4c0vX1DjiYiK8AkmYdQCAciMfV
x1zxQnYRGdVGYnEu5pQ5gHeEBX5yo8D/h8Fg7oYZL+tqYwI3va2TS2FNaDvZxE1a
OHZUmtu1LMDTxYbiZMmyas/IzJjpMjaTT2GTB50HQMyzWQ/25825tyAiDG0lTztE
/L1RHEMJJGUPjZj3chsA2FJuaMIjasfWWw67dsGnkwAumXZ9RP1RsKJQZJmIdJGG
SI8vO7KTi4KQRd1+lVrSrtjRcqMmcVpyC0TpKTCZTQF59hvGMZnpEEkbZW4ODpru
Rdlh2aswVN7/kkh3jpRqaeWsssTHRrgQp3j+D3rhBzl9+meyX6R54dRfE3Fid1o9
wFSWuiMWg2zw/8D63/dh/6nz9bCfl4FPB+X1ifBn8YRdzbrp78Sl5fAx3+RmWMfZ
D4OuswFFO3qg0Ypw39lhsW00WuDG4xhBa2ynDeoHGnrAo2H1/xAza4VNHqcHrtQK
Wna6SGzF0uXmOkqOxmBwCYDH+EVf4jz59M3AFj26oNVdFRujs8/rI8rAtieIWY06
DLDF5Rq5WB3XqMTkaOPxFrcSXVM7956u+hlBOsjDc/L9DDF6vj0=
=khDW
-----END PGP SIGNATURE-----

--44OyvSMBCLIrr91x--
