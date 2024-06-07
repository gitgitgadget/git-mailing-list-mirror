Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FF3152E0C
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 06:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717742316; cv=none; b=ZuelsE9mfiw6fGHCDFgOT7WszPiuRNmvoyILCCPztXmnn0+XU8ejepFOtghuQO9sivnN4d645A1KB+8h2B8l4+utxLm2Hamp3qoQ5KLou5JzRx6/XpC2cKN2OJV5dKbCSfIEuA8x0kZOa/xseFbQxV69LynufwjbcoLhM67l4Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717742316; c=relaxed/simple;
	bh=swl6o2tRtYtuMzzytIeiViCtQvh8hgSr1m5O1t2HIZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILSu45cUNvu+rGY1dBHFM1Y65sutV8/Jcm9D+lPq8jn39Dg43y0IbPSX4DhOxUrHQWeiXT2nhRuUvO31kMpgn/6twE0sA/98kpvq9HvfyAhJmxSTP5xMTYBW/SCVahLMqFmqAtkbfkGip8WffYkEd6R85DsFaY3oC00sT+LU9qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H2B1qgdJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NUY2OLKU; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H2B1qgdJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NUY2OLKU"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 12E9313801DD;
	Fri,  7 Jun 2024 02:38:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 07 Jun 2024 02:38:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717742314; x=1717828714; bh=i2d/xelFhk
	YrpX4d52AeypNRWJUPztXWdOlQbjIm6fo=; b=H2B1qgdJIeCxiHEQcn2IHY9fSj
	qBzpYS0tLkbuc9bn8nohTQceZq2Ghw7KbXHqB636e15h7bcoERQ2/Qq/S9RtnXsv
	FF3FR/GrL1DR1rjIRE9VeB4wilvNwHFCtt4dsA3bkTanyi5aK8jqS7Y/9ej/udGi
	4br6LBEGyfDuc58Pn30yyISogzsdGzK2hOZpNG/2Y1tAmWCRa1/6Lzc8KlSm7tWz
	lmi6g72MZJom07YlI8MRavPXmbDKYw7nWdqJxXFTDmUhli6pHrFv0GyAquOeQ7t7
	WXlc7GY9YsyW8jLPXNTMkIKSHQmJepqT3OQxagq1+dNav5e+fTzz6xDNBT6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717742314; x=1717828714; bh=i2d/xelFhkYrpX4d52AeypNRWJUP
	ztXWdOlQbjIm6fo=; b=NUY2OLKUEKthnwNjQU2O2DdckUsmJPj72kF3GWaa5LTF
	v7VXuE/RuvFndmsVxEZyMFncFJW8+RYMVeTxb6lX+wfyRHNJCIxO0r+FHVNAhDzz
	ysv7Cr4uOJ4jHbVr9pEkIlfTngmJyf5wlwfyqYgoeUqaVzbpMAIa639DH5aZlfk5
	QioKZYTgT0IO/rlG3EssS+H++HLButRafiyxZMXb8uzDlT1ix5fnwDux6f659tIb
	j69Hzq/ZJ772QVW+T2ldw/gzlO9Mq+VE/i7mvidnBY2HxX/0GaXxeIap0TXDmojE
	hHlAoAzcfz8vvsuw1ep9yj+tF+P9Xz1LisLpERPbdg==
X-ME-Sender: <xms:6apiZvCDofoTYnaH64kxJJp4v615-5d0va3zCdcwGOuJgQ0M6bPwJw>
    <xme:6apiZljphNyYLVroEzQ5xonn5Ysq74zSUgxxrIdSnG_JncC5EOc94xmRPp82H0u9v
    Rul2Cs-CB3YoSWVUw>
X-ME-Received: <xmr:6apiZqnCvLKaX6ivkrtWwwBT6rNJhH1zYre_J4kDeLbf9LVqXWm09KFAKUm6QZb6dz2L7DjXiZqM8zwI2DPSqUy0hTOTxLBzgPxJm2HIc3DeTUBS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelledguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:6apiZhwk8vdhUScFLL3ABfMR6F-Am58H2_gitS22pNYFHvFe8MuGQQ>
    <xmx:6apiZkRMnuxDow9NlnlSjDPXjcnNVkLuVbK9cSE71-itJawSK3BI_g>
    <xmx:6apiZkYtgr_5WHYrPVx8sU22YCUOdq0MFsirc68VfI83hdwzVlLe3w>
    <xmx:6apiZlS8P2Kjabml1lHldbk0u7RUxnEImM0EHOIsuSlY6Ww3kvuqMg>
    <xmx:6qpiZqMBRfndYVMfgNxgnvpmdqolcVbYl9D0IYIILPnltcjdcpJrNgjG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jun 2024 02:38:32 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a3eddf77 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Jun 2024 06:38:31 +0000 (UTC)
Date: Fri, 7 Jun 2024 08:38:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 12/27] object-file: mark cached object buffers as const
Message-ID: <bfd632fea7b60c379c7ab65628ee07b9c5341599.1717740366.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717740365.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="U4SJgD7NwttOwZvP"
Content-Disposition: inline
In-Reply-To: <cover.1717740365.git.ps@pks.im>


--U4SJgD7NwttOwZvP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The buffers of cached objects are never modified, but are still stored
as a non-constant pointer. This will cause a compiler warning once we
enable the `-Wwrite-strings` compiler warning as we assign an empty
constant string when initializing the static `empty_tree` cached object.

Convert the field to be constant. This requires us to shuffle around
the code a bit because we memcpy(3P) into the allocated buffer in
`pretend_object_file()`. This is easily fixed though by allocating the
buffer into a temporary variable first.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/object-file.c b/object-file.c
index 610b1f465c..08c00dcc02 100644
--- a/object-file.c
+++ b/object-file.c
@@ -277,7 +277,7 @@ int hash_algo_by_length(int len)
 static struct cached_object {
 	struct object_id oid;
 	enum object_type type;
-	void *buf;
+	const void *buf;
 	unsigned long size;
 } *cached_objects;
 static int cached_object_nr, cached_object_alloc;
@@ -1778,6 +1778,7 @@ int pretend_object_file(void *buf, unsigned long len,=
 enum object_type type,
 			struct object_id *oid)
 {
 	struct cached_object *co;
+	char *co_buf;
=20
 	hash_object_file(the_hash_algo, buf, len, type, oid);
 	if (repo_has_object_file_with_flags(the_repository, oid, OBJECT_INFO_QUIC=
K | OBJECT_INFO_SKIP_FETCH_OBJECT) ||
@@ -1787,8 +1788,9 @@ int pretend_object_file(void *buf, unsigned long len,=
 enum object_type type,
 	co =3D &cached_objects[cached_object_nr++];
 	co->size =3D len;
 	co->type =3D type;
-	co->buf =3D xmalloc(len);
-	memcpy(co->buf, buf, len);
+	co_buf =3D xmalloc(len);
+	memcpy(co_buf, buf, len);
+	co->buf =3D co_buf;
 	oidcpy(&co->oid, oid);
 	return 0;
 }
--=20
2.45.2.436.gcd77e87115.dirty


--U4SJgD7NwttOwZvP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZiquUACgkQVbJhu7ck
PpRp+RAAh+BW7zk36K3PAo6wM5xfeSY2pHrXuCyl1Zji10De8gGpKxu1/vlwzhgr
SvtxBa0z1Y5Lu/+qtzNrvzeASvmD1MJyNKNuqdUbmGOkmNmh6sFSviTvRr44tO2d
Ke3jq0L3eXzy4lSGtSSxk0omvycbhlZStuTiyDfuDnw+Rwu72j1nxqkjvZEVeWdy
eFch3+prNaqdeyp/8GZIXgN9+efLWplpglW5szxKp9YiY4/mmzdPcjyy5AW16vy6
ole1piX4ZWKyoNrToQJVqykVVc2e5fyRPk+kjAkox5Qami2tUwZrDKBdHc7pwFRb
QMTKxJRxoWo7HZn3jgW909y8lv0O8zSCjRVuztAKdpgr4m5FlYM4Z+KAqlgsdlaK
74x/IqNeYBXuqXVRX7oY9wQMj641aJKSEppn7bcTyILfVqqKsakoDrh+bDMBtrJv
20FaqjHbwZ0XErtD7zSsTOoOdI6FMuWW8PoW8nvXBm6Y5k9LKVrLUQQCrHvqB7Pe
gRhlfx67r7d5n6f9rHBje3Af/4MccXZtsK1AtdJRdzKdTnGyKErsFoYeJQmX9T1n
8vh+D/T/Hiqvm096+s7K6aybFHGAbnhGLiP8z6CxUGxP50JaLFXmmppKsl9HK3M0
fm5H1SacRiB0Y+fr+MHQ/qZHc6OfMK0FAtSNEY8MQQO4ZVLy5ww=
=vCjl
-----END PGP SIGNATURE-----

--U4SJgD7NwttOwZvP--
