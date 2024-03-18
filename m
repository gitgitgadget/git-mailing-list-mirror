Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B503336AFE
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 10:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710759185; cv=none; b=stDoVH47izlfjwtMhKw5hvUS5+EiUrXWaA9D5wHGzVk08clPRFqHfhX0GrjuXrABpQU35cLCsfaH48ZvTbCyumK56n3vDgRbxCpYS0rt7D0RF6YP01uz55BBxUfHO6TrSkydz6pNfvmTIbXEfkfWfFJPwECsiQTOgXMtF7rEMoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710759185; c=relaxed/simple;
	bh=9SVKaQET/O+7k/zJCC7OARR5frvuYW2635WXGhc7nIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErnKGopBcWIsAx/tgSTDMNibIWYBTTXhhfjRF8UPJdvI/4i5gCoKab7KpY/WxB1B0ZOqLEpm7OQRGRLCDMYEptUHmwAy9vujqBOKbE7S48EImg49yYQc9hnSa0Iib7XEBF3p3tqh69q1HSEE7iCqGFj2PbwPMmNlcNodCEkm9Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PQzudulQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rFZIdCxs; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PQzudulQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rFZIdCxs"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id BA7B9114009B;
	Mon, 18 Mar 2024 06:53:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 18 Mar 2024 06:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1710759182; x=1710845582; bh=m9vT/HQUff
	7fvzAb6+bpQXMsus2+tEtV3WmVW+iQ7XU=; b=PQzudulQxE0dVMzSrHkT5qr4iU
	DomQPGfgNhgrHVUAOJMxFylSfbAyLgUFKNsgSNIvdPzoYK3C5G/2xhQBgF8YZDZI
	gJQyYdGJotM9Nyy57+tyULPqrYTNUr1yRxaz71gpF0rRSyDPvc1ziLoG6jIovoYq
	6+uijUJ8lbBVb+Wq3jMsjj73/46fLPUT83HVRrpmKG+9y1ctqkJSbB9ZSveCNyCq
	eJWT3PtAT9QaK2EJQxeuC55v0gTWZaeGUgsUr6LQ9aUSRI/lIJk6Ssn8JxvFjtox
	D6FkD36cfDqhwWYBuG+afNa7ZprG5KSp9QH8HILYQktC4yA9ee0ZHUmH1Svw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1710759182; x=1710845582; bh=m9vT/HQUff7fvzAb6+bpQXMsus2+
	tEtV3WmVW+iQ7XU=; b=rFZIdCxs/rmVLKoYZGJ8Z31MnJvrBCa1vfTzJWcxSYnI
	3lXG+MpXe+SaMufU0v5v06IGhnQ3MBaWyEeMz6f6MzqbYcpbKHbi5dvjilsEya2c
	EsBNPyyTFlO4D2MtjRHPjOxarYTEaBiNBCFcpPb2vYLf168y7UesBiZbXmZ8AgVB
	v2i86v/vM0p7C0tgIQGpcZnRvorBLYl1iWCQAR830e5eJakO4Og1k7v4I+tVMJCO
	c0BgGMoiAKyGUCkLDbvFsxfxDycaQtrahiNS5CtxtsSM/d6PNpMs/vDlZaXitYfY
	pF5T5CIKeWugyii9KcSmCOxD3Ir2JYdJWPQ0+XDXHg==
X-ME-Sender: <xms:Dh34ZXKF41sVPQdqqWSi7n7wyz0MepuKrJme9xO7fBRF6pubhCoB5A>
    <xme:Dh34ZbJZ0rJoo9A5d3vRo5xab0KcwQyrFTj2oZtgg8A2tvTRBi5yD0ZUByGU0O9Nt
    gc9OCaO6lKOsepxXA>
X-ME-Received: <xmr:Dh34Zft0niNgApgD-_eoV0Z3b0n2iwEJucmLtXRERHnfBAhyb0OItLrVpO40imrxzQ13dZKIUp3BgzAAkqiqw_J2VX78l42tSEFDIXfhKTSscg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeejgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:Dh34ZQa92E3VqfXYWyR03BUdj3p0XU5taTsvGX7aevLocZVDssg8xQ>
    <xmx:Dh34Zeaj55A_eOmR0jlNeUTNy5k7eSSL07TfyG2j6r_OzVDvkam5Cg>
    <xmx:Dh34ZUAJ0NyylMpl4NoVP61FH9BCfe6h9oO8M8ArudusvqVWP4j0Yw>
    <xmx:Dh34ZcYBgWZY6AewhZHo39l0QDPY8d52kaB_0IXgJs59ZS5WHth_nA>
    <xmx:Dh34ZeFWeKijNyGTHdL9_JUsQd56j8cVt4t-HGD4jj3HAxN2uU0i7g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Mar 2024 06:53:01 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 573be819 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Mar 2024 10:48:10 +0000 (UTC)
Date: Mon, 18 Mar 2024 11:52:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 08/15] refs: remove `PACK_REFS_ALL` flag
Message-ID: <919abe8eb993dbfab36136c7d9a4fd5987270519.1710706118.git.ps@pks.im>
References: <cover.1710706118.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mI4kxrtiIeSIDME/"
Content-Disposition: inline
In-Reply-To: <cover.1710706118.git.ps@pks.im>


--mI4kxrtiIeSIDME/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The intent of the `PACK_REFS_ALL` flag is to ask the backend to compact
all refs instead of only a subset of them. Thus, this flag gets passed
down to `refs_pack_refs()` via `struct pack_refs_opts::flags`.

But starting with 4fe42f326e (pack-refs: teach pack-refs --include
option, 2023-05-12), the flag's semantics have changed. Instead of being
handled by the respective backends, this flag is now getting handled by
the callers of `refs_pack_refs()` which will add a single glob ("*") to
the list of refs-to-be-packed. Thus, the flag serves no purpose to the
ref backends anymore.

Remove the flag and replace it with a local variable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-refs.c | 5 +++--
 refs.h              | 2 --
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index bcf383cac9..97921beef2 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -21,9 +21,10 @@ int cmd_pack_refs(int argc, const char **argv, const cha=
r *prefix)
 						 .flags =3D flags };
 	static struct string_list option_excluded_refs =3D STRING_LIST_INIT_NODUP;
 	struct string_list_item *item;
+	int pack_all =3D 0;
=20
 	struct option opts[] =3D {
-		OPT_BIT(0, "all",   &pack_refs_opts.flags, N_("pack everything"), PACK_R=
EFS_ALL),
+		OPT_BOOL(0, "all",   &pack_all, N_("pack everything")),
 		OPT_BIT(0, "prune", &pack_refs_opts.flags, N_("prune loose refs (default=
)"), PACK_REFS_PRUNE),
 		OPT_STRING_LIST(0, "include", pack_refs_opts.includes, N_("pattern"),
 			N_("references to include")),
@@ -38,7 +39,7 @@ int cmd_pack_refs(int argc, const char **argv, const char=
 *prefix)
 	for_each_string_list_item(item, &option_excluded_refs)
 		add_ref_exclusion(pack_refs_opts.exclusions, item->string);
=20
-	if (pack_refs_opts.flags & PACK_REFS_ALL)
+	if (pack_all)
 		string_list_append(pack_refs_opts.includes, "*");
=20
 	if (!pack_refs_opts.includes->nr)
diff --git a/refs.h b/refs.h
index 139ce7113b..8c8994cb29 100644
--- a/refs.h
+++ b/refs.h
@@ -422,10 +422,8 @@ void warn_dangling_symrefs(FILE *fp, const char *msg_f=
mt,
 /*
  * Flags for controlling behaviour of pack_refs()
  * PACK_REFS_PRUNE: Prune loose refs after packing
- * PACK_REFS_ALL:   Pack _all_ refs, not just tags and already packed refs
  */
 #define PACK_REFS_PRUNE 0x0001
-#define PACK_REFS_ALL   0x0002
=20
 struct pack_refs_opts {
 	unsigned int flags;
--=20
2.44.0


--mI4kxrtiIeSIDME/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX4HQoACgkQVbJhu7ck
PpR08Q//bjYdJk+Zh8+gWLfXpkSLtGd3HCQle40usD41ANbhDkdMLGBZwawJTdTL
3t+9EbEy2YMJhsVr8sQOUfQmmA7NmdpNsHpa6t92DEFNhXqLs+qlgDyDAUnJbZWh
CSNWuemdgBeJ4efCCsrmMo+3p9QxqnoOHWNldDByNVdllPyYNwTa7ZsB2KvPcnDr
//j8HzSxs5lOKdvHzu3NEQD0+5nNAdg7CBi/GCEmbX2qqrXgIxLbOCZQ18jxU9Dy
RBEMQgxbMLchHIyjK4vUd2KKnDtjG5qzvEA1DFaQLugUGZl65mJtfDPdDesibCZs
3uBoW1EU1P2lQq8PsQCTj8a4Th+/0n/mPYxq5TfnWR8V5LOUzz38kP0tz2wmGB0I
lXu/LC4mlK5EuWg6psRUTo25Ss4ii/ABztNRp21siHH53Z6yXYE46TpATwwG+tkI
HWHIjZATvrzfVyZPqB3R3Sqi5PIXN5VfVpcAk2V9T0ZZH8bcKHTDC6rstFl1qVpO
xkeaEFDC0RGvY1kqSUst8eX81xnSIMHAwib2Ni2yk/UD2ontgYSB8wS3ubDFQKMT
CINzlh29+R0dYslgi8/x/F4Bx3oCASVCuYI93PUEDP3zeFarp5LllK+UFs6BKFhf
zhUbzXpwyf2vMj4yKR128okq76OlrVV2ZIl/dLvkbX5oNW9Eg5Y=
=6DQZ
-----END PGP SIGNATURE-----

--mI4kxrtiIeSIDME/--
