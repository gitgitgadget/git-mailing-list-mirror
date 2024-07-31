Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C931B373C
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 14:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722435299; cv=none; b=VOeHVctMIRfEm0UvymrARh22C2WtvL6/9K/Ngu2kytAmGvj0d/17S8lu2X9hrjJSIbLxXp8v9sTjhTnyWhFmmC53Ndk4cXz1Re3MF7jaeJY9UefwrrrdqUx3+DbFCSyklD2pjs0yO7YatIjev4n+2oJygCn7nj/y2OFP8i5HjdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722435299; c=relaxed/simple;
	bh=YQX8HG6eLH4jQmBe+dnf7jOy3WIuyzRmlc6qxJn6e/s=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5ySlJudxAjcIOxGgWr2LNfd65c8JBeAiEhxd6+FQC6W7oVSRVuIDVf9s2zHRFB1lWzC+tay+aSQWH3D40AOJN/nnoghXXCyyh7Iv1wohs/q3kbEUbfL/cm3UFlglxmsNaRFoBAIO+DN4daPXHdBgm3g1Z2O1WZJp4+kyIdUSnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=foswGz8u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nyXUqc0C; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="foswGz8u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nyXUqc0C"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3FA2211405BB
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 10:14:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 31 Jul 2024 10:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722435296; x=1722521696; bh=4M7FHH6ltT
	7+ZHSCbp21PRyg4mjAmIlgQr0pLWvpOUc=; b=foswGz8uhpgEfp0vAAmuSaDpsv
	FNnDztVr0RdoIlq9r8jUlIk6hbiWi+uIpAQwXvk9+DflWdobyOJDTxPfzNiZqu31
	z4sB9YkNPe2570jEENeIds6lCzsQ2ISUI7S9SQbyMwHpsUr0BNKKTOBFZ87F8vQn
	ok/3KjK2eWHrqB1foQfvJwZBZdgM+5gS8rCeqzHsl/0yuDCo5xDgm1dGlPwWjWlB
	2DkY3RVOlgWr8r6X7KvmpuC2U0I2lk/BV3/umvOzJv3PQCUcFed4gX6P/8q7OfFf
	54iOAhCx0T1CFPRhbjye5WLan7LFAk1kbVHpUBrlGwyKsK1D2pH5L4XZTglg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722435296; x=1722521696; bh=4M7FHH6ltT7+ZHSCbp21PRyg4mjA
	mIlgQr0pLWvpOUc=; b=nyXUqc0CPu8PU5Bqp1fXmW+EYL7ZXzJzMWQ2AsXvzWwE
	qZS7MODlYxLlMeCg+ywxDsIybmbP5qTb89eLESK2DN9Fo2G4owZkzhpRoBwqUkQC
	R9iucuHgNWF6B+c7R0KdO3EZUaKqD/957+9gYa6AL21Cbe49zLAhFtpnorWhlhSX
	20iXMPvmIBaRIfZLe+6WaC9eGOLnE94URj/gSkwrIm1jmQd1c4vs+/EcSq+qKPDR
	DCTJELiYTiIv8X1u54bHitEfrpl1zUwrhQUKZQRkQyefsGrVdVajYorRVu5BNOhH
	v0VDm5yBWSNyr5ecui6ULw3rGUj9fcX+HvsnImFJzw==
X-ME-Sender: <xms:4EaqZoxmaCFbt9R2xTTa9jYGkDxTeeavGcI1IT9KANw357KbmHnD6w>
    <xme:4EaqZsSNmz6YyLnmIOWuQjHrirEh3ofqGy_7l5FfSL8ZM80l4Lgqn_TGdvU5thJgk
    uqVxbQ4rq1jJGh13g>
X-ME-Received: <xmr:4EaqZqXMqQlBuGU8zP4sVFWfi8whi7i6kUEsH7H766colnoDYYBSnacfjA0PImQ7u_f02lE1GBGBPHlwHYQVExv4mPGGOqdqQ9qc2Z_itLdgjeWK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeigdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:4EaqZmjMJ67P3-le0SG-Phktb4cj_Ab79jkjLDyxf1sDL4YSedfRSQ>
    <xmx:4EaqZqA8u8RszG2unNAjcHF8TMpDWf_fzm6myuhLgfNrUYIC6hruSQ>
    <xmx:4EaqZnIslyArjRH-OZcTY_wQhEVnbJ1IDEjtbiMoYutSZXfhuEDM7g>
    <xmx:4EaqZhDqAfrpL5NLr0j9yWk7-O8dkOL8KDelIjxVsLbPyJyzDhneHw>
    <xmx:4EaqZr78dGm9CykWt_E2A9eonja48ZYbO87wlSOZeyfRWAERDSUX1UiH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 31 Jul 2024 10:14:55 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id fbd72f7e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 31 Jul 2024 14:13:25 +0000 (UTC)
Date: Wed, 31 Jul 2024 16:14:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 1/8] reftable/stack: refactor function to gather table sizes
Message-ID: <5d99191f5c30927f01f9281dcccfa51a120fc698.1722435214.git.ps@pks.im>
References: <cover.1722435214.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="di+H4j2bOF9FvCiR"
Content-Disposition: inline
In-Reply-To: <cover.1722435214.git.ps@pks.im>


--di+H4j2bOF9FvCiR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Refactor the function that gathers table sizes to be more idiomatic. For
one, use `REFTABLE_CALLOC_ARRAY()` instead of `reftable_calloc()`.
Second, avoid using an integer to iterate through the tables in the
reftable stack given that `stack_len` itself is using a `size_t`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 737591125e..ba8234b486 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1305,14 +1305,15 @@ struct segment suggest_compaction_segment(uint64_t =
*sizes, size_t n,
=20
 static uint64_t *stack_table_sizes_for_compaction(struct reftable_stack *s=
t)
 {
-	uint64_t *sizes =3D
-		reftable_calloc(st->merged->stack_len, sizeof(*sizes));
 	int version =3D (st->opts.hash_id =3D=3D GIT_SHA1_FORMAT_ID) ? 1 : 2;
 	int overhead =3D header_size(version) - 1;
-	int i =3D 0;
-	for (i =3D 0; i < st->merged->stack_len; i++) {
+	uint64_t *sizes;
+
+	REFTABLE_CALLOC_ARRAY(sizes, st->merged->stack_len);
+
+	for (size_t i =3D 0; i < st->merged->stack_len; i++)
 		sizes[i] =3D st->readers[i]->size - overhead;
-	}
+
 	return sizes;
 }
=20
--=20
2.46.0.dirty


--di+H4j2bOF9FvCiR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaqRtwACgkQVbJhu7ck
PpRjCRAAgxGq+BCNPqz05wE9d3m9/PytWcvrLMOPG1tinJ4zHl6KEzH2l4PgdXKu
y8ycuALTPhEHF1RayE28gH/Lr0CQjOe9t0QAygdcvJGJSmkmU9D/9h5A7pvtFEur
lME34JxiLEI1Y8VpEmBx6Rn+za3eC96swIZ0GUr0Hx13rhmKP9hmp/PSAlYlxuq1
Z9ng/uPv2naL26A2uTyXJ5ukTRum5IlfdL2BUK0G9RITfP2JxwrfHhAUlH0IJ/v3
h3WognzFJmNohIFNVWJI/kzxCowcwu6OO8w8Tcs4LRVH5w632tmQmJxBEp2JegDl
Pwqpx0Ynok3uQt12awW+olaUfI0eZSJsVxA0qbpCcKzYHKGLQTycQZvhXh2C58iJ
1908JJebX1n8vxJMBRWlR0hTzdkSklK+DpGIikUpG6IQ52tTnI3orS6uduNE1bOE
FVtkZFq4d0VXQ92Qr5DakSlhtPxvXdBHJJrmC4b5Im/ZSMYUz1ff+1K0TJkQ/bCQ
iyEJp3I7NEEn07CwDZpbXePgjk4eOz6WVwi+qzClj7cMjxj2QkC/FzgaQdDPHY20
+77whGB46oXze4fGkX9kLX3VyYOzie6FZXSQVRL9oXGdt2XZiK+X5O2kbc6udcHz
MGfq92juHGungGyv2CnNBSDzn/h2Aj2ltz+t3ltpb8uABvHkx1A=
=YdDi
-----END PGP SIGNATURE-----

--di+H4j2bOF9FvCiR--
