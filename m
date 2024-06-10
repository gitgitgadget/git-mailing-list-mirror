Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A411BF2A
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 06:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718001506; cv=none; b=FpGOj09T0py5HFeUGpUoQKS24PiBc0pSfl03IwohohdB2c4FDiuVyl6MP8KWzjG6QlVf5XPlHFy9MnowjkNAL0OlhBu8sj9H2jjKuFURR/nMKPRMTIWNtFiL3SkbYGYn+qJNpisQHe/Ojlb89HKyrpsJUs6nLYTk7x4Bjz3aabo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718001506; c=relaxed/simple;
	bh=6cabXsBiCkss4J8sFa1tzpTNkbqUMiUcS9pQRnHGG4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWjPoFhesVyT4B90C2nMtxI7BvMk1EsEbN7cv3j6SunSYh8J7QzD/lfmY57U2X5nN8y3mC+L3+gc4NGCKvSXcjnsWlq6LhnR09Ef9bM/XrU2k6Q4ik93RjygMy8n+Evrzpi35hKwg31exCAHzCg6faci9NEIhZDho841RNO0tqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=n5MHIoTc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S+3203Ud; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="n5MHIoTc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S+3203Ud"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 625481800199;
	Mon, 10 Jun 2024 02:38:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 10 Jun 2024 02:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718001504; x=1718087904; bh=6cabXsBiCk
	ss4J8sFa1tzpTNkbqUMiUcS9pQRnHGG4Q=; b=n5MHIoTcg779oZ/DBZGsvh2Jkf
	C5MO3JYJmyLpGFUIEaC4Y2A/scq8m8xsJn5uUwLFnbz7FPKmYX5MKg25fSt55J7M
	iSl+EODuS/50I1L97sY1GS4nrMKrNqYzfINI3NeIN3FRWv9ayGxJVYohFMgeNo1V
	i0axx159VDP0txqbdYSSdfojVwJNr7atscVnRpcQEUED4ksCvrz/8NwTLVCGmahY
	Q3jivOxFOIe47WgcbEefqG/NICNofmP09KCwQ+sJqRBYa10Y9QlLqoUT0gGgyEhR
	2N0oaEoOzDjpyHMOY7/K0ephNOWVbe99hVztwkljoKEuh+h0joxlSAZmU7Pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718001504; x=1718087904; bh=6cabXsBiCkss4J8sFa1tzpTNkbqU
	MiUcS9pQRnHGG4Q=; b=S+3203UdDlSXbOiKZUcBYfv24FY+WbRx0aOk+ayNGiS5
	Ny7k63IoOhb8+GfSjDL1MG4tbX0orZC+3aXKtUNYn5egn9Y2F9Fz9aVMUPE174+3
	8BHNiPutYB0IJPkHd1QsUeikKzN8ywo1yTqKx/iluBKpL7M0TVULNol9+ipfb9jh
	/iXd921XEX+XRt8UZL6x6kqFk8++uxfqwD6QJzX29uKcjE23ve3DGR/VYU/0znim
	fdDDoth/dt73aWjraJz+qjhPUC4qNRi7yvJeHTK0NlxZnsqcc3ENVikUVa1x59Kn
	GjdRsF+h1Dz2mepV8EQsOOQ2+G7V6Jvlb/1yJyM6Rw==
X-ME-Sender: <xms:X59mZpKPEngYJv8iv8yS7PQb5BP1CCP469-mALo_yhoRXWdPTf61MA>
    <xme:X59mZlJpcgsA74vvGuLDqR_f7dyTY12Edw6IuTxoknzUZQbYhT5GlmYvAPF3-ytGA
    1pKUgzwKiOR9h54tg>
X-ME-Received: <xmr:X59mZhvcTtUoUkl0ceUhGUY_pZ66OBfgBWQb5maMHZxfgVTRLLDYWVabcg-YUoKJzsTBaPLAlllHcdUBb_Fk3-_e4_Hh1wNippkKmojry_ghDVf2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtledgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:X59mZqZlG0QzPHI6jvXC6IRo1Rvqj_inGhCVT2EE6C7Nyj-pzscyUg>
    <xmx:X59mZgYwSYKL7CdNUQC3ja2kXfNzdLLKPvSIS9hmL0luorBftLncZg>
    <xmx:X59mZuByvTR7nYGlO8NTE-_0rrzc0nVa20uQGShJQRbgwNUn30lQZA>
    <xmx:X59mZua6_EJxS7PM7j7_WW7dLmLuol9JWy_71Ha2kL4jmsJnVV6CHQ>
    <xmx:YJ9mZoFUzRa-Da3t0jh8Y96W8fGkTGDcDOmvUZEaBFqokMVUYxewnMDE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Jun 2024 02:38:23 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a2c494c9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Jun 2024 06:38:15 +0000 (UTC)
Date: Mon, 10 Jun 2024 08:38:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 1/2] Makefile: add ability to append to CFLAGS and LDFLAGS
Message-ID: <8120ddaf0bdfd50e0fc4cf9a04f833102630b639.1718001244.git.ps@pks.im>
References: <cover.1717655210.git.ps@pks.im>
 <cover.1718001244.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p+saiy0+PcihdAqO"
Content-Disposition: inline
In-Reply-To: <cover.1718001244.git.ps@pks.im>


--p+saiy0+PcihdAqO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There are some usecases where we may want to append CFLAGS to the
default CFLAGS set by Git. This could for example be to enable or
disable specific compiler warnings or to change the optimization level
that code is compiled with. This cannot be done without overriding the
complete CFLAGS value though and thus requires the user to redeclare the
complete defaults used by Git.

Introduce a new variable `CFLAGS_APPEND` that gets appended to the
default value of `CFLAGS`. As compiler options are last-one-wins, this
fulfills both of the usecases mentioned above. It's also common practice
across many other projects to have such a variable.

While at it, also introduce a matching `LDFLAGS_APPEND` variable. While
there isn't really any need for this variable as there are no default
`LDFLAGS`, users may expect this variable to exist, as well.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 2f5f16847a..9cd3b252ff 100644
--- a/Makefile
+++ b/Makefile
@@ -1446,8 +1446,8 @@ ALL_COMMANDS_TO_INSTALL +=3D git-upload-archive$(X)
 ALL_COMMANDS_TO_INSTALL +=3D git-upload-pack$(X)
 endif
=20
-ALL_CFLAGS =3D $(DEVELOPER_CFLAGS) $(CPPFLAGS) $(CFLAGS)
-ALL_LDFLAGS =3D $(LDFLAGS)
+ALL_CFLAGS =3D $(DEVELOPER_CFLAGS) $(CPPFLAGS) $(CFLAGS) $(CFLAGS_APPEND)
+ALL_LDFLAGS =3D $(LDFLAGS) $(LDFLAGS_APPEND)
=20
 ifdef SANITIZE
 SANITIZERS :=3D $(foreach flag,$(subst $(comma),$(space),$(SANITIZE)),$(fl=
ag))
--=20
2.45.2.436.gcd77e87115.dirty


--p+saiy0+PcihdAqO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZmn1sACgkQVbJhu7ck
PpRy2hAAnvkT5ufYgwsRzdTa14BkzW1PfGJUZHMx12K3nIYk3LobajIccOfFa9uZ
0qkSSFYQM7yb3w5jbiJTjqpe/cWGpeZXcKdgQm4m1jzudXmT23ipFYLGkKTb3NDB
qzVfIH0W2yDrfLWx15T2wqA0ViRY1sfAK0utzUnJKOfG15uzh2QRuo4JpJ5g2zOp
oXEtkiV+y6t1pjBwtfk4v5l7uwNwokcGtsesfvDljWCXw1XO23GQpooR/y3PBoPh
0Sw4RO0lUZoIL4A2vUVDTHVcljT8acDgL61X5wxbnIroK3Q8DZ5lRECrdFZ8tPIk
Qx0WbX5QeHXega/h3LtOXlRvLfIJkIpDzK5p64thg91D4rd4avz18qGjExIu2gDf
7ryfFn+tzEJK4qXqahqmuPl07SNh7MI8szVSOWDxn5RnFZhWjjVRXC/vD1j6s3AE
9LTDJVifA6F/hLXM79J6IfzFqYDdgXlenq3TGHNjA6kuPfGuTOSOtnIDMzQ6/Ohk
j/w0bzuYo7h/+mDCkdmeZGJspHwskw2f3T9So4zda9lVh2zoYTcvHOJJ5kKXbobl
UD0OUI18dSGg75C9YNSUQwt2K9hb1YVy6kUCnT12vgCKIvLwbHfRlEAe/zIxkA9R
6r03EgH9Doj2pHNS51J/LLJsjT5UvBKl2J/RME7qV/qVg2n+Gaw=
=kZqd
-----END PGP SIGNATURE-----

--p+saiy0+PcihdAqO--
