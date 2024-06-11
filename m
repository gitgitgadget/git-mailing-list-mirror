Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2B217838A
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 11:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718107064; cv=none; b=aGQ0C6y9/3e/Y/omJRgQ4yu4VPIhwkUZGomqwu16tyn4cVO7QkoHvsVydnO5uuT2e0jqTDTOCL71Mb0MYZ+Xifpc1JTPPoJLddanqOVIOhNSkcd2pMLMKXsekqf4VS7TR37mlk2rK6bCQVQ6jMv3vy4gt67kXs+/OVBnhSEJZqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718107064; c=relaxed/simple;
	bh=xzelzkNOAQtUCn3ScuEMyHiWatZfQSRCqLTdiLcYSF8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJqIqrGtGKZ2i28SlLFlduPYiXLzV/bx5TB9LYgEIdAFRVCqckS0GVxLm3FnmOIqOl9TtWqn5qGIaG8XiLdSIRQ5GuMB0VFqgHhjzlthwdC0ARfsNHw6KcyuWMVKqAtFnSJBmE+WHMv6wAViMUPLj7GH6EcFWjXO6GGG80N1feQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BY0waqki; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JW3GVpEJ; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BY0waqki";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JW3GVpEJ"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id E27C11C0007B
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 07:57:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 11 Jun 2024 07:57:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718107061; x=1718193461; bh=xNTt+73iGr
	dL7JdQhBdxPuYaA6K4SHl0/AWGHpuc55Q=; b=BY0waqki/HJpcO5OJHLscUk2P6
	6L++/8Vju2DhTatoMKdCHkRLv7Qm7s82mzgRXfpX1BI57mLT/DvqX9OZyZT9GgDx
	LNOtjdV0vk5gFgrK534+sQXDPi9q1ryX92T02rpJ9PQl29FU28wbW3wutqY6igUD
	owiKhUzS+fHYUzJbhQ51Yqtt5NL65tanxoxIf+snV71X4g+Gav6fLfgq96mqby/f
	GRxGWXmbCoZKkHGTU0RsgbQgOahSkelZw+i1Sh47dhL9uhe6QK25ER+qW+T3xtZi
	dG8Vhs8Mdt3qO3Ycj4PIf5rb9rRUBCX3mN6Tru3sDEDcMm25VmLKnrSiwkPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718107061; x=1718193461; bh=xNTt+73iGrdL7JdQhBdxPuYaA6K4
	SHl0/AWGHpuc55Q=; b=JW3GVpEJJ97eZwQ/dmkNNOjoQN0kN2//XOk2bOzeBhq8
	44quEDzkORGeSufLVp/jjsljCopnYKNYGzyj7dACrl7YXL/3wnEAc62qfUxff7av
	kiRD3/RjzctyVB9kzoTaRzDceea83WNG4oHMM1YztNoEqyM8h1kTJPTCqFdUMc1V
	v7DTr5qiOxAFFq//LoEYntZBl+Tol3bg17DCGE9Xcq4h8Lq3sUgHm9/esLXcAQ6T
	luzEdGVVbwy+LT+w2GFwscdIUXYoFhZNpj13C/p5PEF0q2qn393BEyTVXju4PFbB
	LhLf8SQZemmWNEgYBRfZ38qaLmi5Epwvgbx1Bp930A==
X-ME-Sender: <xms:tTtoZtljk4eiVBR4W3SayyXqpOiow3LCX0Iv_GU4nem7D5tIn_2Inw>
    <xme:tTtoZo2VeKcelJRMsav7sQpniQy1rna8lxihJKJsBPWYAL4NzLI7yjnHp_01KxUt-
    f0EKbiIv0q7M_tu2g>
X-ME-Received: <xmr:tTtoZjqzEMDorlsyaH-6eI6Xpr0YNzmarVofYESX4JF7TSCfjfX8NdM3Mzrz4aMSQ4mFezA9IbpBPYNzNEDBTGqlIiuX6seuHvBT7KjcWWH74S7z-WTT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:tTtoZtnXfZLinja3TuaNZp8dMkm-JilPdYYc3j5-j7XRY8Y5aow_fw>
    <xmx:tTtoZr2h0dVFleOmRghRZI3zUTZ0-Uqt_Lc21MZ0Jdijdszq60hl8w>
    <xmx:tTtoZstHtOL-DWB7MxF-x_BGRpoAXcfa6cIR8FHugtZYAHLVb-eBTw>
    <xmx:tTtoZvWEBCs8XPv88vZdRwpEW1c4fPIFRISghdYVjyXu0slxuJBFPQ>
    <xmx:tTtoZk-l_B-Rr_8ndVxJplN8ke1EKg_5mZIvLeozgfsj63huQV11v7tN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 11 Jun 2024 07:57:40 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d101ce72 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 11 Jun 2024 11:57:31 +0000 (UTC)
Date: Tue, 11 Jun 2024 13:57:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 01/21] hash: drop (mostly) unused
 `is_empty_{blob,tree}_sha1()` functions
Message-ID: <f839013744d2401ab1a3186876379e6354811c7c.1718106285.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DVrjbH4eAHg0mN9a"
Content-Disposition: inline
In-Reply-To: <cover.1718106284.git.ps@pks.im>


--DVrjbH4eAHg0mN9a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The functions `is_empty_{blob,tree}_sha1()` are mostly unused, except
for a single callsite in "read-cache.c". Most callsites have long since
been converted to use the equivalents that accept a `struct object_id`
instead of a string.

Adapt the remaining callsite and drop those functions.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 hash.h       | 10 ----------
 read-cache.c |  2 +-
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/hash.h b/hash.h
index e064807c17..a1161e1b22 100644
--- a/hash.h
+++ b/hash.h
@@ -84,21 +84,11 @@ static inline void oidread(struct object_id *oid, const=
 unsigned char *hash)
 	oidread_algop(oid, hash, the_hash_algo);
 }
=20
-static inline int is_empty_blob_sha1(const unsigned char *sha1)
-{
-	return hasheq(sha1, the_hash_algo->empty_blob->hash);
-}
-
 static inline int is_empty_blob_oid(const struct object_id *oid)
 {
 	return oideq(oid, the_hash_algo->empty_blob);
 }
=20
-static inline int is_empty_tree_sha1(const unsigned char *sha1)
-{
-	return hasheq(sha1, the_hash_algo->empty_tree->hash);
-}
-
 static inline int is_empty_tree_oid(const struct object_id *oid)
 {
 	return oideq(oid, the_hash_algo->empty_tree);
diff --git a/read-cache.c b/read-cache.c
index 447109aa76..10e002ce6d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -337,7 +337,7 @@ static int ce_match_stat_basic(const struct cache_entry=
 *ce, struct stat *st)
=20
 	/* Racily smudged entry? */
 	if (!ce->ce_stat_data.sd_size) {
-		if (!is_empty_blob_sha1(ce->oid.hash))
+		if (!is_empty_blob_oid(&ce->oid))
 			changed |=3D DATA_CHANGED;
 	}
=20
--=20
2.45.2.436.gcd77e87115.dirty


--DVrjbH4eAHg0mN9a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoO7EACgkQVbJhu7ck
PpSDRQ//eFtmj/3I4Z9UjF2H7BD7l64ayUXKEbO117KL0UGDP0r+T5NVaiakD3df
k8LeTb18AZiC5VAPSxf1aTI3CGo04rKyJSJxg6ePb4FHLltm+R9EgQaSsANJLfv5
rbO2bgMPk45aJUHsHFC2Wb0pnPeQ2xp6VRJiNkGlZ5a60v6CrFIshrae8IQS1tp7
nRwC8eLHO8aj4vpzqNkVHMtWzK0ImvapSIUO6IiysEFCLXaTiJvGa0zx8tND8MMw
YuzLQZlB4FrS6H5VyaYrtuO7N/rlZd7YW7H+jpirTxdtO/BKrmrtyRnsiHLo7wbq
BbpkOHWqqfDv2Q0W+VyUSAyr4ZV51WOkynEfKDmTuQ4bwNesRxiEXONxIAwYga+3
9CBnqqqgSnaEX0wwV3bS1HIEhp7mM4E7aX1C3AAvXWMgMGBpwi6aAkXS94ZXuuZk
v97j0jLl4oPU6ej0qMUH4slZjkGHe8c6ES9Zzzf0KLrV/q/YLp+FZw7tevZl2WEu
0mgWL9DnpRxGSBETvso0h80wtAY1/O3ytE95Xl92hUIJsWdsa5VxuuRZDE1qvOhG
/H4IWDFJnZ6kI2YAwFUn6gS8P6oyaaib/5Y4dtQEx519fXwCcjuuqVyC1fSZHPOg
+qoMzcUlNHvFJR/xoeImKnW/ZaXeBHxVSSGkpWy/3EIsOpDggWY=
=/sEk
-----END PGP SIGNATURE-----

--DVrjbH4eAHg0mN9a--
