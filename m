Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BD054FAF
	for <git@vger.kernel.org>; Tue, 28 May 2024 06:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716877909; cv=none; b=QgJMhXX31Ctf+Kr5uzw5ijTrV+AWIJsjJaTDH915bhBSxUxJEPByDnvOMmB8PEoYHxumfr1M9z3bt+2DTqFFMVONXu/X2o5pfynCLvq+0AerRq+7y2ND8z6Jcwim6TffTPcFyqR0/MLQYwSb2IpIhVCW0O5bWv88UOjEMyRM/C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716877909; c=relaxed/simple;
	bh=f72jjkM0VSaAUISQoj6EIPh0ksiR7hCg81keBWnYfPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgSUR4rHKIYqMQFbAYr5nv1uBXdqeRkiPMmAzJOjSHoX5i5w5zo5hrbf/dEI9zNkwZsYkTUxkMDKZi4On12pvs5ZH41N/OX7OiXoMCBkNkoPUeVAjWjuQ+ZBptIpjcKOvSf0wJXr1aKNtacKuwUZukpJgAfmElGYe9N1NFTMAx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nh8iuQ/h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=olxgs/nh; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nh8iuQ/h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="olxgs/nh"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 6DCBB11400F8;
	Tue, 28 May 2024 02:31:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 28 May 2024 02:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716877907; x=1716964307; bh=j7b/v601X6
	B9xpJrXaRk2E9HOyqch+xRrmvacmR+SgE=; b=nh8iuQ/hPYn+F5iuAFixNoLWGg
	dVoK93ifDDo+wy0+lsfne7GzO/s9t3Augrp0fA2Mhz9EEh35R5ENcQSHknPuu1kI
	tW5jeIE/IrY5rNYoRV/rUm4OZbLVeLPObM6Gtym/l6QbncZlqEzg/xxCNoSrY87G
	Foyp29y/gBpzB7lTtxadOIzMH/HS6saR/qd8o0UCBdjni1w3RzfjNX226SOHEi7C
	yM7jXnxbj94Q6yXjC3IZ92DTL/EmbfaFzBkPIKMOudHKssoNzT4irNjXM34dGrDl
	qC5OLAYakJCRBIxP14qoSKIZqios304B+BLkYxtZGhRgLQOkh889hgN/U44A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716877907; x=1716964307; bh=j7b/v601X6B9xpJrXaRk2E9HOyqc
	h+xRrmvacmR+SgE=; b=olxgs/nhd+xbRwUD5cClTOaMyHpKPFRbfRu2zp6KYs9f
	NXsS3yDC/gTqqFep7dgkc9E2JGgrBEQhmE8p5+RAmwYops6BQU4Vg+fqdm5ospKg
	r88ptW6qkbWJpckIxycnnQErjhoU3Fq9eF/cLdu18grZu0wgREvpq7E98GAoaJlD
	fMzgHnoesyOaYYlZp46TPag+hUVq1E+b5YQApJ9Cs6DPiQpFYZOOfpgDADXYmEBc
	6xOgFEg0r30Rx+BIea5N3KeXiUNxERwpI+jvJI014oQyw409OQ7tptw7GwM2dxYw
	2+NaRfGiVLhUEQdWL/j2cl/dmbhgKfTD5k2OzrHD+A==
X-ME-Sender: <xms:U3pVZkyitFVpS-5c20-jss04mzO1xqSIspwr_1fM8Ksaa-Bf-6Pj4g>
    <xme:U3pVZoR-v5Wsp6U-MaL5vxELjB0jjAtwXiKNYl4EbyQrTjhl1lKLMtz9X3neOC2Fo
    TSMU4WaKat2AAXPkw>
X-ME-Received: <xmr:U3pVZmXOQ992w7ULsatSSY-SMsIubktlgS2ucNAuMKmAu06MkLVy6Z6c6_1OL3Qj1S9Q0EMyoBdRIqn6AhLMdJvuOM8ThFxOuOiakfe7ABuqn1FI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejhedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:U3pVZigLTRthm9QuQ2akWhpAoswWUmaWa81Vl9QaOy7eRO8IlkiPVg>
    <xmx:U3pVZmB09wxeLz27fCedupZBVFVXCiwYHKJSENxrPmVM3bqCvHQwBg>
    <xmx:U3pVZjJpUeGW0CjQ4eWDdyeGCHG_JxmyR9w1-FSJ-9V7q95tJS2syw>
    <xmx:U3pVZtBH4twnmKv6r1xinhKBka-Au-5eyMcC8UBwm-W65IuiTCP9UA>
    <xmx:U3pVZt4TJ_0ZUnTTfyTszCGbd2-vjSV7OUtLxkUxJkRmPshPbo4GA3YU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 May 2024 02:31:46 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 8920d10d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 May 2024 06:31:34 +0000 (UTC)
Date: Tue, 28 May 2024 08:31:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 07/12] refs/files: fix NULL pointer deref when releasing
 ref store
Message-ID: <56baa798fbb2838227fbc08ed54f200e38545d28.1716877224.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1716877224.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1VjaBMG+zi5/Ajdl"
Content-Disposition: inline
In-Reply-To: <cover.1716877224.git.ps@pks.im>


--1VjaBMG+zi5/Ajdl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `free_ref_cache()` function is not `NULL` safe and will thus
segfault when being passed such a pointer. This can easily happen when
trying to release a partially initialized "files" ref store. Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/ref-cache.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index b6c53fc8ed..4ce519bbc8 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -71,6 +71,8 @@ static void free_ref_entry(struct ref_entry *entry)
=20
 void free_ref_cache(struct ref_cache *cache)
 {
+	if (!cache)
+		return;
 	free_ref_entry(cache->root);
 	free(cache);
 }
--=20
2.45.1.246.gb9cfe4845c.dirty


--1VjaBMG+zi5/Ajdl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZVek4ACgkQVbJhu7ck
PpTP5w//S46on6H3cDHmn7iBlYkBM93nUvEnfgbfmY9L7GzLevY1Uyop/tcDNlch
hcG9VTZjZPnRUmlBbwuVdq6thQriPkiWnHQt0DqMLuXMQQF+cjdXw/gcPT3WO7BX
TRFjWR1yqunEied0xD4OHq16cPq57Dn4LSo5JLx2oZ3Qlx7GMvSZUDWbQfj5m/SE
18lSEg0/M4IbuO4kAoyhJT9LSkVHuui6qB+K9Fq5dUBnnTufusl1uI1SBOgX+a5L
bXtr0xfWgnifAAE98HEwN8UMxCjDHHvDTEO4VG4xiNm16qoDAB4b7IHCr1dW+nx/
e46rbcbjLHam5wXuiKVYyNcnEQgaQp9iCfwjpuMzqLbfhlHlkM6EnN8XAnnuPINw
p1JgNHgoXyuduBH6rT+LBtfEtfvMLUPG3qS10gqugDDCH2dyjctQ0qJkq3xQA/ii
L2xk1NjS5eocQQPuqGwnBsx6VOm+o6NW2/etk+OdqjEoF2ZB1JGdCk0mkfLyLSDk
F2h5C/L7qQiaNPjVzMO6dL9AXxDKLnsjfOqTojcP3DWJLwzcjXUfUMTGcmhqELco
4VMdYDMy3vT9jHvcQfYXYjKSiWoE8q0+yfqdALzrPMAPLm7Qp6t924shBePYzZUV
ffDhOmXZD4+zMUfQRhuLJsLXS2R3AJ9/x8i5ggYLXjuo0xEmwuU=
=FDFm
-----END PGP SIGNATURE-----

--1VjaBMG+zi5/Ajdl--
