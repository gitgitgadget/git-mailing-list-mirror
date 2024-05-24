Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A7F85274
	for <git@vger.kernel.org>; Fri, 24 May 2024 10:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716545062; cv=none; b=M+5rNOd+yfOCGq6AfRStA+yyzfO/aWWMNAy9oQau7fks/YnpPZ3Xu7fllrghRUrTVqnX1+wU9YTp87BbDstF8siPcV3a3oBer8eoAdYvAGr185Cw8uAmqSd7hbF3IgLdad7OIKfCNqATJiunoPI5mpkgptZ6kLWeelJvsS2s71Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716545062; c=relaxed/simple;
	bh=6NN/5sqqJCaUJ5NYKe0hO7V2OuYRt2/lsEVw2VMWsRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0EJBPKyvn/CZDI8dtNZnIyC++tBBfNgU+TjqswgqCLh1hJJnrFfoZ6qCn8wIDxlumclJKEoRRRqNiIcFaJskw2qYp+91bryfwIfiBycy3CmXeWyxUFhv+KhIT3bVgvbFqwWyL7f9hWVOQYTFEcYG6JHprOEPSOiJtIkV5BDqmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gpGFzA9v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ekxs52sR; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gpGFzA9v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ekxs52sR"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 39B751380116;
	Fri, 24 May 2024 06:04:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 24 May 2024 06:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716545060; x=1716631460; bh=L88m676nG7
	OzRf/jgEWItXpaVXv2F+zaiMni+8tt36Y=; b=gpGFzA9vv4Qg6ZU33jzbFfCRrS
	kpK/JfddhpM5aTizr1firj1JZ8OscN4tAobjO6ZVlWQ7OF3ItfoLfu48OfuN57IF
	q5ZyIAvDcH298ytscURA8cf4AmLVhD3OYJdZmNxtfpC8+aB3qraYfiUzeRqv3KB8
	LthqhE8L8AWv98vCB3+laa1pMeKHEkMt7QQoqdsHAPe2c2qAqtaus4YylwnnkeLd
	Ge+JwSr0C7Dk5tTZjQhZSZQJPg7HYG56mYnFu6AcGrp6erZ86ImQdMn3dI9InmvO
	5gRhGKvbS/HWlYSB098C/RqjKpKSfYlX32DnUfTJ1D0fAERNagcbySBgLZiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716545060; x=1716631460; bh=L88m676nG7OzRf/jgEWItXpaVXv2
	F+zaiMni+8tt36Y=; b=Ekxs52sRpH7pp2BAIVPoRBJtlpOP9sCT6biK6BXQoCt+
	/je1cjY7OuV5SKKakSSepq8+n1rUo/iWBEJFEv/kVyu4w62E8S7YWILc6YhNvQzN
	E56e+dlA2ScAn8dnH7JyGwqvsmXqV55G7VQ5/70pavrYsD7W+HOkhLKzAOdaxmbT
	7plUSvlJvVecooU4uETImJZCgezhtjOqS2TXL4hn+Ul2jWMVmqorEsVJ9+nQPabL
	21yGUkgfQSO37WLAscED0RXyqF+38TFhR/nJXYJdPX5flxJObT6QWkEE8nsg41DV
	+pBd+SBQZ2bf8uJWhZ9h6X8TDaQstSTNwEqrCcTd+Q==
X-ME-Sender: <xms:JGZQZjYxBs1vDP7D1bmdzDkoCOzxH7zI-DqBGkjf9S0Qa90B5-Amkw>
    <xme:JGZQZiaUl1UenF9bfK0o-XguOevVfxVe4C1rGZhccU6JxV8zgOR-lA4WUXT2V91TO
    WJmxruxI6UNOOrpHA>
X-ME-Received: <xmr:JGZQZl-QDB8YrapIo0wckJa-J3NGe-dzveqG8a2yXtxXUycrbN6sSs1TuRe06FNGJWur82aQKgjJ8rX1QZN3783lU6kplHaqfCh1g6hakgJvfb0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeikedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:JGZQZpo-hkAT7PH2Q6X4hYRDE2BoDAcATyrduvgoeMKJwSh2k6fjKA>
    <xmx:JGZQZurHopPsBjAkoCGbW4tIgCrXG-tjXKEFh42EqkBwEaoXTFgheQ>
    <xmx:JGZQZvT2idQupKhwNoW7oMTUTpoO9GwVTK1Obsp3E7pgHHmfOMC5ww>
    <xmx:JGZQZmrvKiaaknS5MIUH2NjWv6KPsK0rVkgtkYItrJJS5Nr5eDYUSQ>
    <xmx:JGZQZhXHFjkO7WEW2-4cyRRsM4pO0u8OoIek43bAMRWBkzDEH4V64V-v>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 06:04:19 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 3977e334 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 May 2024 10:04:16 +0000 (UTC)
Date: Fri, 24 May 2024 12:04:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 14/21] builtin/credential: clear credential before exit
Message-ID: <f1a1c43e76b46b44d375c659f96d9e751ea6b625.1716541556.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716541556.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oU7ninnofwW0R8D1"
Content-Disposition: inline
In-Reply-To: <cover.1716541556.git.ps@pks.im>


--oU7ninnofwW0R8D1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We never release memory associated with `struct credential`. Fix this
and mark the corresponding test as leak free.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/credential.c   | 2 ++
 t/t0300-credentials.sh | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/builtin/credential.c b/builtin/credential.c
index 5100d441f2..b72e76dd9a 100644
--- a/builtin/credential.c
+++ b/builtin/credential.c
@@ -39,5 +39,7 @@ int cmd_credential(int argc, const char **argv, const cha=
r *prefix UNUSED)
 	} else {
 		usage(usage_msg);
 	}
+
+	credential_clear(&c);
 	return 0;
 }
diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index 432f029d48..6a76b7fdbd 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'basic credential helper tests'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-credential.sh
=20
--=20
2.45.1.216.g4365c6fcf9.dirty


--oU7ninnofwW0R8D1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZQZiAACgkQVbJhu7ck
PpREBQ//fiimO59RLxGdn823xZJ2QPJQvg4jWDiEidnEkFT7arUCMkyJjW2DqI6l
gN3mBMHc2HfEKA+pCqHwdh5TLu0cVkXs/eFe68lAVdDfkwOCaIagNSw2kRIum2wp
44au3l20Z2D4nk4GaAsvD2E3gmTiVkOOmYk/PWgNDlusC7n4WsVI2r6bQP8lNWJA
0nZdm93RMPjhN+1MW4uOLUd+x+DDndTlTkaTE23USpev5WT0sKpZEtXw7NVjJ2kL
ZpOVC31MrovW3Njq0T4xbsLGthmgFsWr1hRN+R617imLv5UFZJAiYgLQKk99g/Bc
2aFNu/dOLGvWCySOgDfe03H4ZRI3JtHnB+v/oYuYJoJEmHX3Xt9tF0Y9lt0raZX/
MlOVDN/9iVx9zHd/sWmPh0/wxBHcrAkmXsNR/EjZc9lqpUbTfwcIfUbzpzOb2GOP
aJuR164eVuMuwDGLtWva1RkvDFGHSBzAketNq1y1GIwDcnx0zEZ/xkgPrWbwOIHG
MJdat+DLzAnQgiTyxtxd5Hu2we9Ya4Gk2gnTvBqmKFFNNAXoE3iLnh7gtVsEd1mF
peOZIfXW6w4RFyB9txUZ7xrI/ZNKlWe0A7I/fNW4/8EFfP/eS8FKkz5xI3SZR9bU
nEHW2itQh7UIhg3u5kev9sCQ80bSd2JutuK8s34bQgODSbB5O6Y=
=je5K
-----END PGP SIGNATURE-----

--oU7ninnofwW0R8D1--
