Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF87537168
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 10:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709549349; cv=none; b=T5Z762YpUnYVEJOHYZQA134LgTuTZUr5AdXhv7ek2SLcgwoPE5o3it8teYKigKrJe6oqtD9pjtpCl41izTvrXwzj8Xx3tCnG5cMBkCq5BoWQufcLhMdgxSWDBM3BtKK6nmS97Us8JW9t38IvzMvPhJ0cJKqZUOnW7sJ+89hIops=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709549349; c=relaxed/simple;
	bh=w2DTV972ahOSJpinc5cfiFuyXQD22YGlKTjoOSE0yko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6tW6XrdrEXL9bV1yZvJirGXrQU68bXXC4ssXlpKaWd51Pa4kpyB7iVtULFwP6WK6/81+hDURt9l3eYm9g/rUxQAT8Mx3nmWB5WKSSQJYxrbGGQgoTDC84TMhXG0VSP6X9GqXqLHY1adDU7SE+Qn339UsmHIgmD6hH7gI7VHvCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OEbfF549; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TLm9Myde; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OEbfF549";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TLm9Myde"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 9C8FC18000A9;
	Mon,  4 Mar 2024 05:49:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 04 Mar 2024 05:49:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709549346; x=1709635746; bh=XliPYTK0RB
	f8NUWc6N7GoRYBP1y0xRXLd0RGjrIYWro=; b=OEbfF549TnTZd2UzSyiBztSt9R
	stPpFPUvh10a+O+ftODhoBWv7ZGENWeNQIMO1h1r5iSLgO52QvTBTdO3ZMHHz1AE
	+3Tx1lsnXE7dI0bYCQHC5sVeHvBuvlFR/4vygAeu31E3bPYPpLHxF4Jv9kHENiTO
	Jl/WJOSvqf0/0aiCBfa1KpXZTnxqRti+knq75RhWd/HjGbYRS2fcA2PxbYg5wUwZ
	2KkTPkGtUIjYXauodGPASKT6PCvJuE1XZ3m/IEV6Zq+YDVq1ppa9IeTyhEy8BoMz
	4lb+Jn34c/5u0kBA6agou46geSAbIEPg2gXHMA1tW1cBWA2LciuaOiTBVpaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709549346; x=1709635746; bh=XliPYTK0RBf8NUWc6N7GoRYBP1y0
	xRXLd0RGjrIYWro=; b=TLm9MydedhS7QRH4mFX8OF6C9ooMtgsyv+Hol2wStoPI
	F6Sy6DMOFAYPtC566g2+PYwQVXE57spvn0iReQC4Og33H/FBEZbXNINzBU19T4J5
	F4tVYhD5nQ5Lo5HLqM8VHHTAbKDbnAHZuklpPQOARTtbgCG2MarUx7O4Y6nmxoKd
	/begxIKJmYvzejcJoH4eL/pK1rk6yJFhdqaFYvpIjcdPNlmM73S9rv8bPrGJVydh
	EMVJwZNvAeEt110vsj/k5jkAf3fHcqO9sP+FeW3g5Ui0uh3ccUweXtxcLaCMkFZY
	V7lDV1Wt3VSqj4L+JZzsDoPyd3CCGPDqJyv3+qprlw==
X-ME-Sender: <xms:IaflZSeC4SBMVwd4zhMHNpmdIhboLZF_D0u7dQSOqNaEtMuT-i98zw>
    <xme:IaflZcOQ3bBC9l2EVRV7HFrZaUYRxyFBzw0eNx9oTm0zBoitdQ9cQK0thQhvmVqOf
    7_exVLNWVEFiy6NWA>
X-ME-Received: <xmr:IaflZTgtiuNnSuTcEvyUsOpg4y1JH3PwdL6CCWsactiR3nRTf5c3-U5FuwSUQpM-iNdq0Cp1tLf57-L6967X7E6P1Cn1n3LZqQOUGPZvp4RHnc8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejgddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedtuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:IqflZf_8-IrCAa7Rrz6sm8CRtvfxn7qKRUq5mzQ6nqYEyaz50bHk0A>
    <xmx:IqflZeuWqHgqGLWnh6BGPog1CTymln8szyj12SpGRJc1kF-CsBMVlw>
    <xmx:IqflZWEA6kIXkqBWqMvBn1zuNO_J56NpoT8oLsLgN4bp1SRjkqlAGw>
    <xmx:IqflZSKxEylNHIPN5zpv7EupOGQjerRoIX01g7KbZJBM-jLBQi48p7GGX9c>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 05:49:05 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id af12d105 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 Mar 2024 10:44:40 +0000 (UTC)
Date: Mon, 4 Mar 2024 11:49:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, James Liu <james@jamesliu.io>
Subject: [PATCH v3 05/13] reftable/merged: remove unnecessary null check for
 subiters
Message-ID: <b4130061591e71117a47f7d505e0f6f9e0b57df5.1709548907.git.ps@pks.im>
References: <cover.1707895758.git.ps@pks.im>
 <cover.1709548907.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CqAUBkS3kqdwqZ7O"
Content-Disposition: inline
In-Reply-To: <cover.1709548907.git.ps@pks.im>


--CqAUBkS3kqdwqZ7O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Whenever we advance a subiter we first call `iterator_is_null()`. This
is not needed though because we only ever advance subiters which have
entries in the priority queue, and we do not end entries to the priority
queue when the subiter has been exhausted.

Drop the check as well as the now-unused function. This results in a
surprisingly big speedup:

    Benchmark 1: show-ref: single matching ref (revision =3D HEAD~)
      Time (mean =C2=B1 =CF=83):     138.1 ms =C2=B1   4.4 ms    [User: 135=
=2E1 ms, System: 2.8 ms]
      Range (min =E2=80=A6 max):   133.4 ms =E2=80=A6 167.3 ms    1000 runs

    Benchmark 2: show-ref: single matching ref (revision =3D HEAD)
      Time (mean =C2=B1 =CF=83):     134.4 ms =C2=B1   4.2 ms    [User: 131=
=2E5 ms, System: 2.8 ms]
      Range (min =E2=80=A6 max):   130.0 ms =E2=80=A6 164.0 ms    1000 runs

    Summary
      show-ref: single matching ref (revision =3D HEAD) ran
        1.03 =C2=B1 0.05 times faster than show-ref: single matching ref (r=
evision =3D HEAD~)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/iter.c   |  5 -----
 reftable/iter.h   |  4 ----
 reftable/merged.c | 10 +---------
 3 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/reftable/iter.c b/reftable/iter.c
index 8b5ebf6183..7aa30c4a51 100644
--- a/reftable/iter.c
+++ b/reftable/iter.c
@@ -16,11 +16,6 @@ license that can be found in the LICENSE file or at
 #include "reader.h"
 #include "reftable-error.h"
=20
-int iterator_is_null(struct reftable_iterator *it)
-{
-	return !it->ops;
-}
-
 static void filtering_ref_iterator_close(void *iter_arg)
 {
 	struct filtering_ref_iterator *fri =3D iter_arg;
diff --git a/reftable/iter.h b/reftable/iter.h
index 47d67d84df..537431baba 100644
--- a/reftable/iter.h
+++ b/reftable/iter.h
@@ -16,10 +16,6 @@ license that can be found in the LICENSE file or at
 #include "reftable-iterator.h"
 #include "reftable-generic.h"
=20
-/* Returns true for a zeroed out iterator, such as the one returned from
- * iterator_destroy. */
-int iterator_is_null(struct reftable_iterator *it);
-
 /* iterator that produces only ref records that point to `oid` */
 struct filtering_ref_iterator {
 	int double_check;
diff --git a/reftable/merged.c b/reftable/merged.c
index ae74234472..29ad09f3d8 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -70,8 +70,7 @@ static void merged_iter_close(void *p)
 	reftable_free(mi->subiters);
 }
=20
-static int merged_iter_advance_nonnull_subiter(struct merged_iter *mi,
-					       size_t idx)
+static int merged_iter_advance_subiter(struct merged_iter *mi, size_t idx)
 {
 	struct pq_entry e =3D {
 		.index =3D idx,
@@ -92,13 +91,6 @@ static int merged_iter_advance_nonnull_subiter(struct me=
rged_iter *mi,
 	return 0;
 }
=20
-static int merged_iter_advance_subiter(struct merged_iter *mi, size_t idx)
-{
-	if (iterator_is_null(&mi->subiters[idx].iter))
-		return 0;
-	return merged_iter_advance_nonnull_subiter(mi, idx);
-}
-
 static int merged_iter_next_entry(struct merged_iter *mi,
 				  struct reftable_record *rec)
 {
--=20
2.44.0


--CqAUBkS3kqdwqZ7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXlpx8ACgkQVbJhu7ck
PpRfHw/+OWd3WLiH0BMF5/ZVYfkFxYYJGBB5/KcKvyRkvfwCJj+h6rH27KMiyY9I
ZVozV7pDkcVLoo/SDFe/dXxmnbfSL0DyZjQbNdaETnBd3BHzX8uv+HiVGaNWQToF
qjxht85L3E8LHBfDmCXorigsfuMYe6wsx3+oYfpHBfSpaSQ/sVmW0ir7O5r5cVqy
oYq122XbLecLXtfOu7NrMttRHMiTds0xI1lhnmiJknpVMvg2/s7U6mF3Qg7voek4
O9ufScyG6MpUkyzAiXlXXuOBEjB05zQ7/wP1j6qAwDnE2VDcjNDxOpIW3w6bwSwQ
UQ/DpZ/br0eNMlKKw4q4XcJuxFvcYpf0dgnNs0RucP0gYOPSH65nMuxVm2ZUP3JS
qLanSlxM53LBKWYxcGxTfnogoBikpSNgWUmoL6SEGwDrt29njlmbWOg9Yko/q/WX
AbKyvW+lUZxPqDUq+ymL2HVWZKkkxGN0SHtHoM/dZ+pw9y7My9SpbtPJZs0ITv9e
BAFB9GedpxMJCgpFcIDTUCqkqSLsvfRUdculHH+aOROT2W6pcjOQ3T6sURKV3ZAO
BaI/4apdSKi8L5IjQTuuX0M3WM0d57hnYyS5AULiZ3jkOlWpc19CpOLMEjW7D89R
LMRuD0QpCjcytMc/WT0sgUY2N4KdtjdTKoOmka9W4rk7meTVrtw=
=j96v
-----END PGP SIGNATURE-----

--CqAUBkS3kqdwqZ7O--
