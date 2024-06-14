Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F6B1482FC
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 06:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718347858; cv=none; b=Ip40IXtXVQdFIebAfIAgiJmuxGv+kdIPIEZJ6Gd76d6RWcKSiTDZd366M+v9gA8U2msa2X9Z1ilF4DDsXFq2sq/pMauVOEbYi9JBIRBGa4GUY6tKOzVvna8uonS3Rdkz/Oq7StHV8bnaCqwqXhXzUSHAEbrB0LYcnNSOOUV8qh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718347858; c=relaxed/simple;
	bh=PVO0TnOGaVazeCMWb1C26mDiFir7oGsDBZ7uxGeK7UU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1N6ISipx/41ZPj+uT4rLmUfn6CTN3COjWz06VN8SWHm1CtMUD7kQ3WvHs3v3k8o1MO9y9lWYGhEDIXt4C7NU/pfrbuKeHDeg2DrQKfMSBDGeJpoc+QGQDyxnlmaZIzUkVS5pFMtaaDthOGW0x1JJseg7KxhmxcWyfWiPBm/8ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=a7V+uLBr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gW0FDDgM; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a7V+uLBr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gW0FDDgM"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 98AEE13803EE;
	Fri, 14 Jun 2024 02:50:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 14 Jun 2024 02:50:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718347855; x=1718434255; bh=b0HGaxwC4i
	T9oKbyJ3iKvKMX3/BLE2IlewV6I+tlMPg=; b=a7V+uLBrfX0TtUju371ppKOssY
	xMkB5nd8RuyXwm7NpTfFe+MYgxmqnV5dYC2QhdW/taygFlb3SGxHJNr1a3QTm1ye
	m7tlFja6cdWJHdeFXfYPYi5ZggSD/yG48Umxv5bq6xK4lXR+K0c2jGZjieS+BBi0
	7NnD7XQdmDl98RN6zfGtOoXT0S8xgJhehu25gwnTkF1nIjfk4M/+8QvxFUEKt9Zn
	Jb+WRjsFsKeNn0nXBjL5cHakkNn3LVcGVc+ztyYzLOtM+6vqMbacZWvj86us9HQX
	nDz6v+HN/b2WVNtTFBhEF3Wejmy7Q2IbbVUBo5K36TD/l5V/DNyB6yKzp5PQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718347855; x=1718434255; bh=b0HGaxwC4iT9oKbyJ3iKvKMX3/BL
	E2IlewV6I+tlMPg=; b=gW0FDDgMfRLsg/LkE7FrEGjRv6w85glvN0A/pOehanL/
	gLg2XegYQtso8m/2tu56YkXJs1Zgy8in0M0/mkwTPYs4Y03eizH5+1hD0tdT+l/x
	u4K3n9ak2Rt03peSyCYCM6iwCDJLPZ37xvpJ87QkuQ+GsJdrybf0KPCm/WrowMR4
	EqW2tIM9tX6g69qmfz3rji0395mr05DBJ7ANDRBQK0UR3VUKVnGp4PwSHQjEnmIx
	bofSH6GHv+05jqrYmEUdzmcaxzSdbiwjH+24i6kUjmLNM9w+jBK4ELMCfwMtkHG+
	oEL8w+biOtY0YnurxZV6sRji1QyMpLGxCg2/MTf44w==
X-ME-Sender: <xms:T-hrZh1IXuiKMFmUDx93nrMPBdPjCcNPAoubIqkoexsiaBpUzzP1_w>
    <xme:T-hrZoHeoI3yxA4NKgFF9hS8rdev8_gRUi_6iTCxVqSF76Dg-FLoszkT2MhQe0xJq
    izn8gun0b06WmEn4g>
X-ME-Received: <xmr:T-hrZh77ssmaNxZZjGcadIl_kS5FrmV5nlG-cMJC-zxFSh82EQjAkE2OtEx3-KK6pnx1Yl7aeBwtVvMEtv0QBUALkJ0j89mRcX-e_PgcVC9nUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedukedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpeehnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:T-hrZu1LXXdmsgUUF3fIHvTHpv5AE9VK5IFH93nA2ufwlHtdvuOgEA>
    <xmx:T-hrZkEGsGWOIC76TIDiIihlkGJ5WUuIoa0FFHKNkbHcx8jC9q0Arg>
    <xmx:T-hrZv-rYxTWGNj-AAQOJGbR-58XrQ9AJqumqL-UY0fI4_t_E-Us6w>
    <xmx:T-hrZhnnqF5bKP5bMugSUV21sG6E8tJnvqRxZnTdH1sVZtofrVKGuw>
    <xmx:T-hrZpOJ-xOrGoLcTbTRJ2eUySNWxYRvqbjdsTxdr9gC9-ZEdB_vrZ1b>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jun 2024 02:50:54 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1143f585 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 14 Jun 2024 06:50:39 +0000 (UTC)
Date: Fri, 14 Jun 2024 08:50:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 15/20] replace-object: use hash algorithm from passed-in
 repository
Message-ID: <e1f4bffea1fde0f34d800d40508a246c5462e41e.1718347699.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
 <cover.1718347699.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ylLM7DvJ8JrfXRHs"
Content-Disposition: inline
In-Reply-To: <cover.1718347699.git.ps@pks.im>


--ylLM7DvJ8JrfXRHs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `register_replace_ref()`, we pass in a repository but then use
`get_oid_hex()` to parse passed-in object IDs, which implicitly uses
`the_repository`. Fix this by using the hash algorithm from the
passed-in repository instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 replace-object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/replace-object.c b/replace-object.c
index 73f5acbcd9..59252d565e 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -20,7 +20,7 @@ static int register_replace_ref(const char *refname,
 	const char *hash =3D slash ? slash + 1 : refname;
 	struct replace_object *repl_obj =3D xmalloc(sizeof(*repl_obj));
=20
-	if (get_oid_hex(hash, &repl_obj->original.oid)) {
+	if (get_oid_hex_algop(hash, &repl_obj->original.oid, r->hash_algo)) {
 		free(repl_obj);
 		warning(_("bad replace ref name: %s"), refname);
 		return 0;
--=20
2.45.2.457.g8d94cfb545.dirty


--ylLM7DvJ8JrfXRHs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZr6EoACgkQVbJhu7ck
PpSukg/7BCqZG5cEoYGKeyRs7GJRi5UwoBKRUD+ARS3j6pId7F6rkO7CcIwfwg9j
i6NQZFvdG+G0v/fAfBgWJ1Sl2b6bNpzryRNwsMO/0xxhag+VQUO4wSmZ4bumhYIz
jKn4tC0uzAorUcrZSC1b1CUUCsq9I7OHy/G3HTFh3QmrOv/En6yI5QOyAhXBalXe
1BXg+cS1rUA3joW1A/GwuGZm6YtR6fnLzvX3xwUWv+5JiVGMNxxCcULPD4S9emRq
9HRHtvNMFs1ELXe+08y4AKsEU9Lx1WxGmaJFJKA/UO77yDkeAurd3li18fOnoc0c
d43ac+26/WC+sm9e4wSR/Wk2uC8mE6dEieiJBc5Zji+/8jw53DQfbuS3EgghkcRe
cef8CpqRU6INqGsyNtNc6qUUFpNukEm/UNTE3idXz9oUGX3ujSfy0zHIX6YWWUsy
6fJbuGWl8WdxfKY2UNUWafQpjiCIChR8OafcYlQf9t2JFNPq6dgtOkre1HaifZcU
i8mIVKnB1kwN0uPFBelKaZFEpb/4XOmtPk1dmDEK3RQHbNz+5Bh+ytvNLYoYoS89
Pa43T28BOWXPSRa5MfRWqVOM3HKtfRpGBlYVIqsbmlm3QX3oj0Iyfwcm2PhiJMZI
NOlqYrS6LPd6/r52cg4LlHyFV8Asu2YRDg6nHWxYH5drN1gV1Zc=
=5G0g
-----END PGP SIGNATURE-----

--ylLM7DvJ8JrfXRHs--
