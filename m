Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDB315A490
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 17:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712078703; cv=none; b=dkWXkWtIBTVfXf8YPD4eToPoGRqTd4q7JzieRxCN6oCKC9P6jGz/HscUFpMQUiIehhvW9EzuM8ZbwGoaCO0/J5x30UYfJPJBdrXN+ujv0MKS6opsBWGpKq5VEZpZzRFl7R27eTl4itHJ6HzArpVVSVsNoitaKxesFNSIj+g0Lok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712078703; c=relaxed/simple;
	bh=L0Ooahn24qRgmke3x24cQ7gKXm99Gg5RrSaYFSddWgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmt4LzyLSnRuPZ6e/BdV4Y4KOo0T1ivQlyoyloKbQtZXDl8WNQ/6MPa0zXS/Ox9CN0hTC3U+dStV8qgnP1GAd/7ZffmwX2aY9uhKvNlvPOkDSonGpT5vX1+xXsK8y0dgV++1cNSffbnSBY9QtcuhESKHphSrG/YnqrBVNvZLO8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Thws7rMI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ow71kjvF; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Thws7rMI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ow71kjvF"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 23E5E1C00082;
	Tue,  2 Apr 2024 13:25:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 02 Apr 2024 13:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712078700; x=1712165100; bh=4l780Fj1tW
	toWc5SttetCfM0k5q6C9whrYdd52mhBvc=; b=Thws7rMI4K7Uqjf7GiS8GR/e82
	XSm3zOySX2czPbJ0nxSWioXRyBglQmpFo9yuv/As/L9L2u4/NFy+2cWpfUKWQ2JB
	b5W4jykwU/CXhC4EZ9qIl8i9aQM6K94HTfUiAI19pkWPjawYYcWeMt4b60j4+qLY
	bRm2V9JXfz9WgwnjomRNtEgrcwad0w6SDJRMYwpVZB3ft394A/lDa9Kw3TM8ENCz
	yTUBMp4Be/feCp2mGWEM/dcOHKS+zVofzKZJUMzsJ7OK+U7XDMHC5bwORKHhWtzn
	fieEaUMYnvC9LyuFFDD5l9pDsXCRXAR8teI0p6oZSW9Dt+6IukQHrg9+merg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712078700; x=1712165100; bh=4l780Fj1tWtoWc5SttetCfM0k5q6
	C9whrYdd52mhBvc=; b=Ow71kjvFXzPBdvySMohKzMfrWUcxt04Hx5h5CDTuwieW
	M2Cex0T7FK9x3XYI6HTs2LTFhUoayH/90xhp7H7P9F6XD/CWbczN9KwQjokd0erR
	YWIe8P3T/Oiu46RyYD8ZKrWcy/5nEe9lFD3HyCWyoHpYzu9HNTZpXSAjBINLsjiV
	Crmn8qsB2fdhXeG/z98lendQIaW/QVccFkaN5OIliJ7nSTe0NTzDYd9SvTaeZbrT
	luaFTcQtLa2T4eaQNKgo/ijKr1LVwUv3I1F+hCHbg1Fuw1zWaYgp2Wg6XHcW3UWC
	IKEW5uL2K5H3wtTgiOztmkU0Qq9xsuIYPCj20+OWeA==
X-ME-Sender: <xms:bD8MZonfoKh0qF7Nq34-G6fy0Uqmha8oq2DNMelGoCbqZUene_-E-w>
    <xme:bD8MZn1fln19WXY_0XuXEOnbYIifxy0gpeEtq_zRHTIOlws2rMbWj29fGAYe7tOre
    oZJkSgO0ZAauxTteQ>
X-ME-Received: <xmr:bD8MZmpObffFwIvD6TRoNhQm4uWdJ2uwzYVSNOAi92MUKEgPmD3QsioNahZrtXwhTerpEf1ro6vb6sW_-Lz0O9H7YqSPY36_xfCDK2mNiGNc_8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:bD8MZkkLmQhZHLBSkjDP5bhcl32-FE61y5m1v5UbK1OuG6zT9v7E_Q>
    <xmx:bD8MZm0o3Rp8IHkhxpSjcJ6pY0ZdyXlKdnrrf-zxHYOcDCNBXdIgWw>
    <xmx:bD8MZrvA3m0gvPrbp1l_sbA7JpeAfRKRhGIM5_UwZrQzLexAUmPL1A>
    <xmx:bD8MZiWjATL0Fa7OQ2NBfqHCog1ofv8oJCaH0WZ8TuTm4Oc29qnocQ>
    <xmx:bD8MZrxiGmmswfsk4rCkrwY-rnm7c6ZXHxUaKQeLze7DYum4YcdlxkbH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 13:24:59 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3ab0864e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Apr 2024 17:24:50 +0000 (UTC)
Date: Tue, 2 Apr 2024 19:24:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 5/7] reftable/block: fix error handling when searching
 restart points
Message-ID: <8d8abfd2907e9e128fc7fa4a462be18312f105bc.1712078263.git.ps@pks.im>
References: <cover.1711109214.git.ps@pks.im>
 <cover.1712078263.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qTlBaCqlZbwvMNJC"
Content-Disposition: inline
In-Reply-To: <cover.1712078263.git.ps@pks.im>


--qTlBaCqlZbwvMNJC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When doing the binary search over restart points in a block we need to
decode the record keys. This decoding step can result in an error when
the block is corrupted, which we indicate to the caller of the binary
search by setting `args.error =3D 1`. But the only caller that exists
mishandles this because it in fact performs the error check before
calling `binsearch()`.

Fix this bug by checking for errors at the right point in time.
Furthermore, refactor `binsearch()` so that it aborts the search in case
the callback function returns a negative value so that we don't
needlessly continue to search the block.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics.c | 5 ++++-
 reftable/basics.h | 5 +++--
 reftable/block.c  | 9 ++++-----
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/reftable/basics.c b/reftable/basics.c
index 2c5f34b39e..fea711db7e 100644
--- a/reftable/basics.c
+++ b/reftable/basics.c
@@ -39,8 +39,11 @@ size_t binsearch(size_t sz, int (*f)(size_t k, void *arg=
s), void *args)
 	 */
 	while (hi - lo > 1) {
 		size_t mid =3D lo + (hi - lo) / 2;
+		int ret =3D f(mid, args);
+		if (ret < 0)
+			return sz;
=20
-		if (f(mid, args))
+		if (ret > 0)
 			hi =3D mid;
 		else
 			lo =3D mid;
diff --git a/reftable/basics.h b/reftable/basics.h
index 2672520e76..523ecd5307 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -22,8 +22,9 @@ uint32_t get_be24(uint8_t *in);
 void put_be16(uint8_t *out, uint16_t i);
=20
 /*
- * find smallest index i in [0, sz) at which f(i) is true, assuming
- * that f is ascending. Return sz if f(i) is false for all indices.
+ * find smallest index i in [0, sz) at which `f(i) > 0`, assuming that f is
+ * ascending. Return sz if `f(i) =3D=3D 0` for all indices. The search is =
aborted
+ * and `sz` is returned in case `f(i) < 0`.
  *
  * Contrary to bsearch(3), this returns something useful if the argument i=
s not
  * found.
diff --git a/reftable/block.c b/reftable/block.c
index 6cd4c053df..ca80a05e21 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -387,11 +387,6 @@ int block_reader_seek(struct block_reader *br, struct =
block_iter *it,
 	int err =3D 0;
 	size_t i;
=20
-	if (args.error) {
-		err =3D REFTABLE_FORMAT_ERROR;
-		goto done;
-	}
-
 	/*
 	 * Perform a binary search over the block's restart points, which
 	 * avoids doing a linear scan over the whole block. Like this, we
@@ -405,6 +400,10 @@ int block_reader_seek(struct block_reader *br, struct =
block_iter *it,
 	 * too many record.
 	 */
 	i =3D binsearch(br->restart_count, &restart_needle_less, &args);
+	if (args.error) {
+		err =3D REFTABLE_FORMAT_ERROR;
+		goto done;
+	}
=20
 	/*
 	 * Now there are multiple cases:
--=20
2.44.GIT


--qTlBaCqlZbwvMNJC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYMP2gACgkQVbJhu7ck
PpRDDA//cHzpFmYteMOOmIjDj2ofwYrO/0eF/sOoTsSfzG1QFqdKrQ8UxJTTAf6r
JaP0OlB/U8X0jAPr2fysRQfGSKOr7+i05O3TqY/mmfproEeEeph8SRmCNvLeO7gk
guGgdfaKa/lsFXJRx9qB7KBtcJURM2YDk6llep2BoXwYgHAJKGpDvlKKAossweFG
j9ebZV6qUpYbx2YY68t+VrTVX3c4XQDY2nOceOsHgiRciRhZCYP2M7kngLUwiAes
pOr1QhXW1Pa4Cnz9VHLgfCAfGf+hJSNqZpzvn4VxCcP1QSS+EeQ/kwzvY2rueIak
XBTBH5WvO/tuOEQw5o50bOR/7zAuarF4yxP1C1T7r2B6ZcPezUog6M34lJOv8naR
fL6vmg9hRDW8/jE8YuK09BcHtY+PTlIRg4TNyWJvUVAuSRLMCZmcpB0hBiZCWEjw
ls1KGV9IBZdCZEIqchRynYot7T9fUndm1genS4rfqtaLCcnvWKPo2R9d4wedxy/Z
9odtT3HvXZ7trbawnxlcwkdd7zfwoU82s4ckRIkGY3JLwU6HOW7ynZi+li8ZuO0q
zNsojFc+TZkZh3VeGvhLRtKuXsvgEhZOli5vWUJhJgPhOAiHcWMmOK0m8yqUDnQW
zYEpgnR+y7eI57ZPSzeruaxyDoSQZv/IbMFIM6MO9n4T7t4EUQ8=
=ny0u
-----END PGP SIGNATURE-----

--qTlBaCqlZbwvMNJC--
