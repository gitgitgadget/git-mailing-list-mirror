Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65FA14831E
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 06:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718347791; cv=none; b=lka9j9rpTPYjmJ7ihe2pKgFBU2mlztzQNusKZ/1Td8BQA4GzIF37roZlC5hri0hYs2i8HgP0bXvNolZcmFsAQ3TxR3/Ee6UZqWkKi/R7JWOH2ifBTC0SMyWrH/xOMTJip6eu671/z1XJQ0h5yHMBEIM8tigQRDW3xBLuLhhfA+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718347791; c=relaxed/simple;
	bh=gAGQ+B646yHKM6z8VOCOEcKIdlWmgZMr2TNCCs/Pwt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghDh+GveXtKnJ856pRnZ2tJ7dHzEzOWamHUPqL4kNu+nKDouisJW3kUjdVHgCRb61JTqqMMSm/Io0mGUvS+oM6HLxVxaHfCVNEQ3G9YaLf6DEw20sDiY4IbY/QmOR2k5X0Phad7iyKfByXeADyc1hslMXeFpNiNPm+OOOf+iwW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jy7r1EFb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jpIMaPqc; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jy7r1EFb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jpIMaPqc"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id D8BFB13803FC;
	Fri, 14 Jun 2024 02:49:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 14 Jun 2024 02:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718347788; x=1718434188; bh=GQ0HMtpRm2
	IgVW6EyqACztL0uIep4G55n/w9MiCbsow=; b=jy7r1EFb1W0BDOIeSSBXclaqM9
	B18Bq90Tstk4tf+NztONZtQUC70Lir/VDAlILjYBcciw9uPUWX6diGbMxzu3LcMF
	+a2T2ioRWQXF5XDLMHLqe12pYf1/6SJU0todNgVaGg1FuOtJHfUwSknh4cy2eICD
	7V1ndUEBUP0bnzIUuZMV4Z0CxRt/it9gf9xO9UpFTlUmE5WEWSM1IxX3ju48Y7RM
	ddIIkHNLBGPuTBAqUvGIvs1o1fl9XHQ9Fs18duYRftPL7VDKjSnwBZOPCo+3EUI0
	F0tulcV3T5CuSnRY+LpivfRI7cgrL+FZgutEuPFzpRj8o8qcc03u9rFdRyCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718347788; x=1718434188; bh=GQ0HMtpRm2IgVW6EyqACztL0uIep
	4G55n/w9MiCbsow=; b=jpIMaPqcZ9ihVQl/lqN/f8NvdYCA0hfvfZvwJbxOOHwB
	ZSFtiUiFhyn6rsIWYhXKDb3Bu02NXz4YNlCaXzWf/RJlXAZH2rsiEMkR1m/IIbFJ
	TZak5DFwl7+rnKabUV/cOi8+Qc8z1pL4xpwePQ4Fh+Gk4OsBwYA1NsbHVCpbt58O
	StnWfBMzUsH5AOihpbvctVEgpgM/XZTVoRNK8sE5ZrJepQ54f5UXq9wBGek+jpHQ
	kMKSLfUj2SBNlNSORqnOIOzDhSYVkjpPQcWiheYGayZ3Eq2o56r6sZzRxQiN0diK
	yjEV8XiDS8wJ/I/iOFTQs5Ij/2XBbiZul5RPO1hqCA==
X-ME-Sender: <xms:DOhrZq5GmmiKIm8p7A_wYLp9iIVBRmAhgCQXQAhHiGU5DXRyL3m9Zg>
    <xme:DOhrZj6IjnmMyNytYqJxJYOnVjY8DftjmV6ZRbW11_Zzr7Pk-dU4V6v7UoSTJyQqN
    fA9CkIYCfU6rSnZVA>
X-ME-Received: <xmr:DOhrZpcOoCRTUq745PeLI8KXgZBlsTbUUaGVKBnVKiA57Y513aQBXOkFvICdvbaPwv1wmR2xl_8iZzZUCE1LQH1rrlr7TA-gJXTcjhZT26-erA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedukedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:DOhrZnJMWQ_PE5JkdQofRT6B1s-8L6K7f9EuQ_OdkYJCWsDLdjpN6g>
    <xmx:DOhrZuK8D1Vs3il3alFKbPa-414XVK-lOrj0nC_8ZWwRmB0sKvKs0Q>
    <xmx:DOhrZowUpfho0b4UMVn1RMyH9hJGG6hE5c3P00mQQSjGqRAPGsEmxQ>
    <xmx:DOhrZiIZbfrxEztsx6RLJ4BytHLwfPP2EJpq_uwCpi5RN0PJ6itisQ>
    <xmx:DOhrZgizuyDHm9d7KPrPMaERfUaLnOif4bF81etMcyNmUuFxLYKwhG5O>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jun 2024 02:49:47 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e31e8ce1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 14 Jun 2024 06:49:32 +0000 (UTC)
Date: Fri, 14 Jun 2024 08:49:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 01/20] hash: drop (mostly) unused
 `is_empty_{blob,tree}_sha1()` functions
Message-ID: <d2154e8c4517cbe7c981184f911bdfd06a593cee.1718347699.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
 <cover.1718347699.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wcpDRkHQ/Lnv5v6P"
Content-Disposition: inline
In-Reply-To: <cover.1718347699.git.ps@pks.im>


--wcpDRkHQ/Lnv5v6P
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
2.45.2.457.g8d94cfb545.dirty


--wcpDRkHQ/Lnv5v6P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZr6AgACgkQVbJhu7ck
PpRqWA/9FAvb4jaJ6KYgBr7fxD46BUBX4cPGfA3JXYrZQ6v6enoLszMW3oYrhWWg
KGNpr8IZbjt1FvjPB1URl+C1wkUJgYz5FEBKbpAFfGwQEnhOplQ3LnK2YH03Obbt
lm555fo+BjeeX1C7VoNSGvX9fApuvN4oWW57zZ+V8AAPlsi4g5TiOAt2U+kao2ox
m5t8SgwAXrNP9bQB8iYJt5+BVmh/ddfXZA1z/g/apKDG0i5obgMVGxiQ01xtAjEX
J++DUDl0JT0jrGCdt/XfwVpjAWq2CATaAsQPoWm9IekEZCDr0nAYhwzDpwB3tZFV
lz7vLxhNghP/MYoXv9LEbnQxavo+rChLdvUXniHhUHMDtJb0krU9r4XqrKJ61F9w
N05vYB5cKrP8L5z20m2KgsuOiGblwkm7vRnTH3YaVoGcQx59KZtoYguQG+r7UU2M
xHk/otULM5uvMqiTpolWZc9mr2OV3BRlwD/39wOBDOWsFiW1dF6q3UNnDOSWlkbg
TQuBA82IFYTbrLARBsfdAEY4k0nBy43FIkVrVV1zolH0QOY+3ER67d442zvG0C4N
z2rjShzz1gOUMmFRirrOIQV2nQgt3SnBhNY/HdbYD639eJEnTRp5qthSMdKvDIrJ
+UrVKzYrxLRd4Zkm/S8UczX8ZuSVx1KpnB7lafFBu09KWZ1zg6Y=
=IQu2
-----END PGP SIGNATURE-----

--wcpDRkHQ/Lnv5v6P--
