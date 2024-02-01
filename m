Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AB7158D81
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 07:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706772805; cv=none; b=Gtsmaw3cu01Fz9yrK8eizF729UDPcQ6tncYxxgo7+8HjRhTo+BTQd6rRqF39RrGvoTEbcw2xpek8w+Ct+28Y8a8JLaIIU9i2L6D0u+O3bwy1OPGqTka7k+vtGPOUjLJy+gOFjyyEQCJuSXHLBqoZwZeoYVNdpCzZBa3SRNS7tSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706772805; c=relaxed/simple;
	bh=d0ivr+yGCD+kEvcVYb7HVRYZlfabGqrez78Gz0ggHMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/veC6BJg+hqBOUEU3VrCQQhJ+CGQL/DFzOYyUG2OlphBQoW6YB38+aUGZVdKkZ8cOmg6+qARhh383cFrm8CqFzHJgBTKYOY8no+X5b6qtgdM+59FpiUUxxY7bkWMWj0NmoJhAbEX2fbgjnUKRD6+Arv4iPYSz6Cbh0q17i05SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Tc/rdq9a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rBnuiPGB; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Tc/rdq9a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rBnuiPGB"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 12A2F1800085;
	Thu,  1 Feb 2024 02:33:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 01 Feb 2024 02:33:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706772802; x=1706859202; bh=gau0Ngv/9d
	rp7CToT9JVGgDIK8w9nuUAmrETk0AwDEc=; b=Tc/rdq9aiFiOOGXcuPiGyH676e
	bgpZU8IvuDlKQxijjmp9sAhqE4xh2787hzu1eyIADjTsjIM5+ahvc0ICaS6ib3ST
	F1o+KMYkHcJgbiX56EYLTBhFOBRp8YHtE9Kbi8NP7U4k6yhjUmbX5kzzoI3JwTmL
	gdTZwbeSVGVJmcmfNBUcxA+uu6RcLSVFrkSaFyNHhCaxr2YNSx7QCC7aF/Kqyms1
	QhrSoF5qYV1OIY6sGqT4Hzzs+Fno+HpEJjrJQqvyXRGmvjAz+/vFO/4gRLms8tCK
	U0iQKV1E167uRTX9RyZLVKsZM0m7S6TGkBUa/GffeTeOrONkdwa7yIpBjNPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706772802; x=1706859202; bh=gau0Ngv/9drp7CToT9JVGgDIK8w9
	nuUAmrETk0AwDEc=; b=rBnuiPGB0ALAzEe5UvmcL21dqxum2+MFg6hZBt4AXNX1
	MN/MS3V0v79H5fIz/vUSrFS07f/lkIiwKNrx2YMar12JH/DbdULGKFjMEG1NQpFE
	DW3lYmPitAgcdJ2MxMvlE9x+xwFFMD8rKfqETHFczrzHbz5P/4g4vaOrd1wYgbkB
	F39B28lJE+XPRAAGlT507WOOD7Q2ng/ROJlNaj/8jvwEcnpG0zGuSkGCp0DlI5eD
	D5Qp7C0euzSe2IzeQoAaGAi+1PkquTbVf1JJlrjSFwCgos4U3kdygx+WJrQFpjlM
	DCCKSMIe6WyEueUEQXz5l6dlAF/Dw54qTUNhFW+OaA==
X-ME-Sender: <xms:Qkm7ZbAmNej7LjJZIBrCid23Nv3OW9GoaVb_dwfOCiHaToSDLnUMwg>
    <xme:Qkm7ZRi1mTGIW0BFIj-Rsbi-DjYVLFhodvXeo7LtS6RJULWi8mm2wuvbO8Yl7FzgX
    XXoHgRxG0c-ty9-lQ>
X-ME-Received: <xmr:Qkm7ZWkDpvAFM2kAhRKcPKyXSnauSvA1KPuA4cutPsg2XXqjOsEJ6l7tYlIk5sQmSZpyae9t6ySnxIrL4c2AHwvUWfGwJDw4VWx6eQWpEKHCfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedutddguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:Qkm7Zdw1bxXIuA_vZ04IZN9X3GpwzBX-Rl7R23t8adLnFB3kRansCw>
    <xmx:Qkm7ZQRb0bXSeLLXRBCmWCXAtukP0DrbaAJsT5KXXxdSri5RzZBxCA>
    <xmx:Qkm7ZQb1f2J2Kpu5H1kGsHhxr_pU6K7qyFFVIcb0I1Zf_t39vyZWew>
    <xmx:Qkm7ZWe1MzUW4-cdCKHmOsoZY0jJpJmnTUv6gUzO6wH--4_5pKNEGkWI0OA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Feb 2024 02:33:21 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e9b1e6f4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Feb 2024 07:29:58 +0000 (UTC)
Date: Thu, 1 Feb 2024 08:33:19 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 7/9] reftable/merged: refactor seeking of records
Message-ID: <80cf2fd272577b13f4fd23f009d22294629f5f3b.1706772591.git.ps@pks.im>
References: <cover.1706687982.git.ps@pks.im>
 <cover.1706772591.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hlgEA5wLT6/s6SI/"
Content-Disposition: inline
In-Reply-To: <cover.1706772591.git.ps@pks.im>


--hlgEA5wLT6/s6SI/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The code to seek reftable records in the merged table code is quite hard
to read and does not conform to our coding style in multiple ways:

  - We have multiple exit paths where we release resources even though
    that is not really necessary.

  - We use a scoped error variable `e` which is hard to reason about.
    This variable is not required at all.

  - We allocate memory in the variable declarations, which is easy to
    miss.

Refactor the function so that it becomes more maintainable in the
future.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c | 54 ++++++++++++++++++-----------------------------
 1 file changed, 21 insertions(+), 33 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index e2c6253324..0abcda26e8 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -238,50 +238,38 @@ static int merged_table_seek_record(struct reftable_m=
erged_table *mt,
 				    struct reftable_iterator *it,
 				    struct reftable_record *rec)
 {
-	struct reftable_iterator *iters =3D reftable_calloc(
-		mt->stack_len, sizeof(*iters));
 	struct merged_iter merged =3D {
-		.stack =3D iters,
 		.typ =3D reftable_record_type(rec),
 		.hash_id =3D mt->hash_id,
 		.suppress_deletions =3D mt->suppress_deletions,
 		.key =3D STRBUF_INIT,
 		.entry_key =3D STRBUF_INIT,
 	};
-	int n =3D 0;
-	int err =3D 0;
-	int i =3D 0;
-	for (i =3D 0; i < mt->stack_len && err =3D=3D 0; i++) {
-		int e =3D reftable_table_seek_record(&mt->stack[i], &iters[n],
-						   rec);
-		if (e < 0) {
-			err =3D e;
-		}
-		if (e =3D=3D 0) {
-			n++;
-		}
-	}
-	if (err < 0) {
-		int i =3D 0;
-		for (i =3D 0; i < n; i++) {
-			reftable_iterator_destroy(&iters[i]);
-		}
-		reftable_free(iters);
-		return err;
+	struct merged_iter *p;
+	int err;
+
+	REFTABLE_CALLOC_ARRAY(merged.stack, mt->stack_len);
+	for (size_t i =3D 0; i < mt->stack_len; i++) {
+		err =3D reftable_table_seek_record(&mt->stack[i],
+						 &merged.stack[merged.stack_len], rec);
+		if (err < 0)
+			goto out;
+		if (!err)
+			merged.stack_len++;
 	}
=20
-	merged.stack_len =3D n;
 	err =3D merged_iter_init(&merged);
-	if (err < 0) {
+	if (err < 0)
+		goto out;
+
+	p =3D reftable_malloc(sizeof(struct merged_iter));
+	*p =3D merged;
+	iterator_from_merged_iter(it, p);
+
+out:
+	if (err < 0)
 		merged_iter_close(&merged);
-		return err;
-	} else {
-		struct merged_iter *p =3D
-			reftable_malloc(sizeof(struct merged_iter));
-		*p =3D merged;
-		iterator_from_merged_iter(it, p);
-	}
-	return 0;
+	return err;
 }
=20
 int reftable_merged_table_seek_ref(struct reftable_merged_table *mt,
--=20
2.43.GIT


--hlgEA5wLT6/s6SI/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW7ST4ACgkQVbJhu7ck
PpRtEw//QqmzGMRIZQl+J71Y/Znz2kXK1GiulXnEHk/sVLTfnWzQMkF/FcZdoLY1
a4xb+EOoPhSIdUzHNATEfWGOCt9F1R8vVQfnHFUaS6PJujAZbSLORMStn9vtSpB6
PuaMabSqx9ztvECqP7X9D3tDarxBvyLO7UXl86TrstNPYLOTRHpj+hJOqv+mjy4p
RY/Ycz1a4Vnw65Cpm/EmzNpYkCgR3E7iGHIwPWoI8jPzYQ6sSwbdj3CfBGBFOKQt
NMMzx8gJiHC4BqazqoE2Nrim7VYkMoGydV0egYEwmBiJ5URA3L5lvqZFrLyIEm5c
SF8O+ytCTizfXtVOx3bdyAiKxHesYUoS4FwRtLLwkmJCWEjGuse1OQtuPZE5uEOD
MZaNxgkafb9fPDcJ3eDQOM+9MZ9ljY/qZ5rbQgfXjb0tZxm/8fBJ9p4+CJK0JACq
40M2QrIoY2p67Y2j0DFq4byuxVlUfkY87oWLBk6PO/wKKLUcBhbRsSDdDj+H8J+8
l2TQ7PFv6nHRsBVd0vtfsFcm+/Tn3wZquJRbKwIMt4eBo74aypemkqoZPB22bXj6
uTJLFrTMgOKHO6+lpXISQ1yS/icaNRg6EvaCnoNtT7LI+kOjWm7uMERogYEFb6/Z
7MkVd5UCkvQRWKUqNLn4R9FFSJ6LECW4AIFOOW4Z5Q2B+H0nHGI=
=NBds
-----END PGP SIGNATURE-----

--hlgEA5wLT6/s6SI/--
