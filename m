Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014A1224F6
	for <git@vger.kernel.org>; Thu,  2 May 2024 06:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714632748; cv=none; b=Ky1DwCo48aQQEXLJNo+Uk+fZh/QuCkZaEafthxgXzlUNaB+5cpRdYXVvk1kIaVjuTpCmTdMt/3r84M/tUMtzWdm9RcNF9Oa2jb3/hEtE4dAZsAF0vlPxZiGPhbhSDbHbdLmWXTRYkedpnIISGHWM7wABq4s0p2nIoY2EyGB+tdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714632748; c=relaxed/simple;
	bh=0ll4ABHhRHsV7uKDT0fXH8g157isfXUbjNGCuPqQJnc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttwNr9KCvSQyQTp65y/uYi2tv9BDFuTuyfV0E65NhQs36RVH3llLe9n5Xpejz7kY86f0re3QGhuxjMWr4MDQDN4NQAycjme6QnSWEG9jh/uvc8VX5zgVrepIKEU9y+egV0/TBxPFbsmrGE2hsvk/50cifltbWDYZUJeil7K2U1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Kw+QqnNK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YfrxstI9; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Kw+QqnNK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YfrxstI9"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2EFAC11400CA
	for <git@vger.kernel.org>; Thu,  2 May 2024 02:52:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 02 May 2024 02:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714632746; x=1714719146; bh=bAlinNZkch
	pStXNjco5GLy2cq4H6QDT9yTU/9ay7/mI=; b=Kw+QqnNKvf9UIKcCdFJIwd0AmY
	C9ibTSykw/PUh+2mc5nKJa/SW1hk3dCdnPZ6MHWm8GBYWkAC8LM8F+EURWsRJ3QY
	m2qncVRqoZCVeDuwIuGiHcqjoFCLZEmiVf1E8lBFaThi+wtPV/d6jgp/nVsRApVm
	TouVgoRkdT6OBmUjbpVav+GBaZMIRCi8xsoh1oepYHWQMjIzCSspzEuZfkW90Nqg
	HJNoaasCmJV6aZzclRxwHOivrKAYuLl+FkQUbqGKtvXquAOkKonXo5FIFRMd8KB3
	mygGMu2Jwq5NOXUo/5ooyWqqUzP+FRj8gxYc7Rs8dpC5rsUw2Jo1hhC1QvVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714632746; x=1714719146; bh=bAlinNZkchpStXNjco5GLy2cq4H6
	QDT9yTU/9ay7/mI=; b=YfrxstI94HLOBa0bx/mKJ1b11KVhFnxdUtWsY3MjHH6H
	UfNbBSJUJHWf5G8ajQPrmkS9JrB5K5wPnTVylPFw4f3smyJs5a9PEeRmHzE3Nuoa
	NfaIKF17+7ySrjZay3yAh8THX+pzOvTIxI8qkRVoZ9BcAq60stl1llUsvQGeVNNH
	yG18kiDw0gZvq3w0iON806kHKRnEsf6IKyRqvvbsPysron4SIXDco4W6AZqsiZYa
	5tU58dsrGQuwY3brTfqGal+Zg2ZWhDDDGkObYR02dUv9Sb+5tckHaKzzyLtIqLpd
	m3dJCwbUEIx4vyRbIlrHmygEEv8U/eIx5eiNA1O5uw==
X-ME-Sender: <xms:KjgzZv_yta4T3Rc45TgHtJsQIzg8yPxgEMgDV4c7w2ROiX8haZ9uNw>
    <xme:KjgzZrus00gfr8g3bxHvzV6aLJUPMd8XtqTDEJhLHz6mOVBfpx1xlB5qREBP6iLf-
    Hd-_7i52iuQwwWRlQ>
X-ME-Received: <xmr:KjgzZtDlFI0LXhME5uN0CM80o3-p6_9HDKJBQhwbQR0ksVNgV5_ji_IfOnxWzJO2eaokvi6JIXNlefr4oYRS5lCfsE3ROk3QD08mt9VNT2RwM3E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddujedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:KjgzZrclAlnPvoyp9xLT3eq8E-GXRHpAIDxNIvr8vVXLBOU6MffkRQ>
    <xmx:KjgzZkM9xIZzfyWDI5TaE2tZFYPfaF6mUDtJo4VJ4YN2mnuifU1xYg>
    <xmx:KjgzZtnjQsUAe5BGw98Y_-4bF3eXJt9TZ5SfdjvjGUEVrf0Q0txguw>
    <xmx:KjgzZuuK2cJdzNEU77yMPWeLVeSghak665JwvdZKXGN67em0cjC5eQ>
    <xmx:KjgzZu2QfQaW1SV8ScS6Q_zSsabpQqAfJ0bgr6K-PcKyaFkJ8hxwfA-o>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 2 May 2024 02:52:25 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0a6ea4cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 2 May 2024 06:51:59 +0000 (UTC)
Date: Thu, 2 May 2024 08:52:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 11/11] refs/reftable: allow configuring geometric factor
Message-ID: <861f2e72d987d17b00d68cdaf400d743e2f8c118.1714630191.git.ps@pks.im>
References: <cover.1714630191.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="24E/UUoYPjrIo/ek"
Content-Disposition: inline
In-Reply-To: <cover.1714630191.git.ps@pks.im>


--24E/UUoYPjrIo/ek
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Allow configuring the geometric factor used by the auto-compaction
algorithm whenever a new table is appended to the stack of tables.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/reftable.txt | 10 ++++++++++
 refs/reftable-backend.c           |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/config/reftable.txt b/Documentation/config/refta=
ble.txt
index 6e4466f3c5..1c381dda04 100644
--- a/Documentation/config/reftable.txt
+++ b/Documentation/config/reftable.txt
@@ -37,3 +37,13 @@ reftable.indexObjects::
 	are a reverse mapping of object ID to the references pointing to them.
 +
 The default value is `true`.
+
+reftable.geometricFactor::
+	Whenever the reftable backend appends a new table to the table it
+	performs auto compaction to ensure that there is only a handful of
+	tables. The backend does this by ensuring that tables form a geometric
+	sequence regarding the respective sizes of each table.
++
+By default, the geometric sequence uses a factor of 2, meaning that for any
+table, the next-biggest table must at least be twice as big. A maximum fac=
tor
+of 256 is supported.
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 5298fcef6e..657d227c12 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -252,6 +252,11 @@ static int reftable_be_config(const char *var, const c=
har *value,
 	} else if (!strcmp(var, "reftable.indexobjects")) {
 		opts->skip_index_objects =3D !git_config_bool(var, value);
 		return 0;
+	} else if (!strcmp(var, "reftable.geometricfactor")) {
+		unsigned long factor =3D git_config_ulong(var, value, ctx->kvi);
+		if (factor > UINT8_MAX)
+			die("reftable geometric factor cannot exceed %u", (unsigned)UINT8_MAX);
+		opts->auto_compaction_factor =3D factor;
 	}
=20
 	return 0;
--=20
2.45.0


--24E/UUoYPjrIo/ek
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYzOCYACgkQVbJhu7ck
PpQEFg/9EVEQH71vmZBriRt0nXtXxtGuY1BB32U2yBr/ba1YPqcpIXTPcqc2rbk/
fgyXAbjK7VF+yfufnF+kkQOTnktRo6r9W6cvJzCplnysOSe+jKziipLkboLqMJYp
hapNFcgpsaeKa9VSAT1pcsIhu+0T7v2vjFp+MNk1Aw78Rj43mEtY5kY2eSQIwTlY
T6HLarHXgAcca0HsX/VWYmwnc0FIo/d2CKohsgmURozU3Gj+xm+yBUG5P38Ojvgg
qyN8SlBlsbRqH3MZ7wkFqyo+0OjHfzxVnlGID6qJ+bLj9wT+4U0h0blGzueSeJxl
1Ob/CWwQCW/bgTkLqJksApFBch61GQjnYM6otY0x1HDCl2bJt4ANzz4tzF62s4l9
zyGmFZs+wkNiH69LP6V8wkq5+VI3om6H99uzqx1dC938uDdSBmGKlqvsaA4b2nSV
2wkefq99iX3M9QU7/uPQJiNlRO38eeL0q/5jpgOO4O4oNuqFuFFNeLAIMak6pn4b
OpLPgU+ZzeYd6RXSmz/rnnB4UHnsWvPNiyF49kzysqq0cvE54tS8GlBpA5oPZDLd
GQoxCCsBSM72dc5ICa8Yjcf9uPmEDiUQT3Rd2MlcrQ7ov0Uw98bbqlwgiQMvm7WN
kijZsB1/fG4t2uLJekC7EtdGfaixYaGP6lp8rJ0TnrEgTENiZ4w=
=MuC1
-----END PGP SIGNATURE-----

--24E/UUoYPjrIo/ek--
