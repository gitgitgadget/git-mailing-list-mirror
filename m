Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0664140E34
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 12:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721996211; cv=none; b=oIvrrXpBB8VwgaRVUkybCz96AKXesDTbkyd0pXMvU4be8Ihe10feWM7an+F3CelLeZH5znu/6kY2vdJBT2I2XOmlTAV621p2zBL2fkJoBVHQKVCpYgoy37p9DvBUqvO6vyIFU/S2j61ORZREfokeBo04j9K+/LbdMhCdgnpBma4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721996211; c=relaxed/simple;
	bh=GSUGuR4biMcDrRRdCcZud78q1/tkig2F/k1lHDkN1Hc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQGlmkw1IIT4xjpHBccwLNeYNGzQBSkRKr8LyxsyHsuNmuQ28pd0S2Pxd8wBr3SyI+R+WhqgIlLns2KtocLZ1nUNWAuRbGR+y5cvINLDbwDBumuZoEcneU9s0chWRTlI3OS1vP+r79NLXKwmo1xrHmRkyOvO2VOE6Vy1n/rqfOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cjpSPIlT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Guf6PASS; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cjpSPIlT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Guf6PASS"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5B22E1380502
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 08:16:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 26 Jul 2024 08:16:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721996208; x=1722082608; bh=nXEeyZmaW1
	pOVsP5vw1xvpi4WPMR64kx+0BZA4V+zcU=; b=cjpSPIlTJDShl94OdMvfcM726M
	XCzRwfQ3vmh4tz8X+lb2VHVOVe78ZaWOUMpUPgC3wMprWk1CaZDmMxQAR84Cwtow
	IhltdTVPzcvtjRCOsuqDQ/fQptzze1yYhvi9UygTTWb1QqD6oKuq6GQPW27hcglM
	Vj3qgeEh8XJZgNsTEU7ExbmjM/Pr4V6HLywwDo7ilvQs8109TqOgZZXDz2mx6iB3
	9hOMOD3m/YwYjbR2F3FS8X7cSEOJjZIz0zmEc3Yd19LMdFogoXAYtbpkssUEzrUg
	g5k1nk9hwDyrMC8XifQnfxmSH/J99lm9tBskHjpn3J2cUl5GSDlySPA/EMjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721996208; x=1722082608; bh=nXEeyZmaW1pOVsP5vw1xvpi4WPMR
	64kx+0BZA4V+zcU=; b=Guf6PASSpZsqkFR/6hyqdIH7zjhCe/TXSuJIxebkGEN9
	UcZ8ErGLqY2w3jJ+FpxZHLamslbreVf11UgQvqdQTHUWSCRnCluNul0/r2IOhCbt
	0RBD7XjyWT41w31QxzWKO0dazwSHP+zl44UquqZbkiejK6UpLSPw76h1q7pKoFjP
	sDP1ppjaulxtUIEIjTezokIuOK1efAzBDtCrybFz4B5b0nh4XLdit+7OYaxpB6ur
	mWTh87pB+5TqEKvsmKZC2PSxTtHBFfdyPeVBUAmSfeZlZXBKMHlYrFXvT+akvMpk
	hc0BVI7FnlrtR4a6b9UzM+VzqzS841y/KqQXOP+a1g==
X-ME-Sender: <xms:sJOjZsAENmTvFCB5oxhwqbsnZi6TGPqdSiKDhR8pzCubtlKjvx-KNw>
    <xme:sJOjZuihOlznfKh28z5bEt3C8S-tj2zAPZQIMe8TVyN_3C6XGZ5SeaSniyjErTLVg
    D03tQ3Ap3P9Yxzctg>
X-ME-Received: <xmr:sJOjZvm3rVvJ0GptZ7hxFoGv4GnO3ab4c8hRhu99PactaTy1x6H40JIsnoWs-5ymt3Fr__Gl1aeF8KHz6Ob9tm4sx-Z9YFaiaaHmvOP1m-TOJvXy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieehgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:sJOjZix3sOhtRwbwAvAYkjlXTevlBMa8I-BLct5kcmnyzTW6kwiJiQ>
    <xmx:sJOjZhQKCN_rfcuNYIAAcPohSjdGIW8UsOuwXnliq9Lm7oiVI2MHMA>
    <xmx:sJOjZtbe0FKVI3-mDcDiJzfXMgvv1rPszFuT7NjcFfzySxCTeGUbvA>
    <xmx:sJOjZqS2CF_9KbhiI7i59uui4YiECzFA5A8M4DibMx84kitDVRhXjQ>
    <xmx:sJOjZgK8dkHI7KsVBwUzpPTlVsKlEP9gxsvka1RQLcFzefP7xHCOiTVx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 26 Jul 2024 08:16:47 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 809716d7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 26 Jul 2024 12:15:26 +0000 (UTC)
Date: Fri, 26 Jul 2024 14:16:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 12/23] builtin/rev-parse: fix memory leak with `--parseopt`
Message-ID: <e277222bd298560b0d7f10cb9b5d0eee5967ba87.1721995576.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9Pgo3LNy3teC7X6b"
Content-Disposition: inline
In-Reply-To: <cover.1721995576.git.ps@pks.im>


--9Pgo3LNy3teC7X6b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `--parseopt` mode allows shell scripts to have the same option
parsing mode as we have in C builtins. It soaks up a set of option
descriptions via stdin and massages them into proper `struct option`s
that we can then use to parse a set of arguments.

We only partially free those options when done though, creating a memory
leak. Interestingly, we only end up free'ing the first option's help,
which is of course wrong.

Fix this by freeing all option's help fields as well as their `argh`
fielids to plug this memory leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rev-parse.c           | 5 ++++-
 t/t1502-rev-parse-parseopt.sh | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 2e64f5bda7..5845d3f59b 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -553,7 +553,10 @@ static int cmd_parseopt(int argc, const char **argv, c=
onst char *prefix)
 	strbuf_release(&sb);
 	strvec_clear(&longnames);
 	strvec_clear(&usage);
-	free((char *) opts->help);
+	for (size_t i =3D 0; i < opts_nr; i++) {
+		free((char *) opts[i].help);
+		free((char *) opts[i].argh);
+	}
 	free(opts);
 	return 0;
 }
diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
index b754b9fd74..5eaa6428c4 100755
--- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'test git rev-parse --parseopt'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 check_invalid_long_option () {
--=20
2.46.0.rc1.dirty


--9Pgo3LNy3teC7X6b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmajk5oACgkQVbJhu7ck
PpQNqw/+J25lCE8yqosz/QRLzma6e1cQE/WLS0eUxuJ/JQhBIcMXX2d8Z00D7zTp
NcZEKHGrx+X18+RH6Nx6i5MdqzChLMdoL5gpT1h3cacmbJK66FL6q2+IosRmgLKB
JuJRTuhgKqrupWzJ5kDHHkhhjgrwhaip3k4Lx5AT1r1fJ1AMc66A6/XG6W6CdcI2
yXuOtLUfgkAPuM5gd/3UYKPC58MgG4uBiA6IIolWXk7g7PXJWax+ICz/pOMaO7/h
A7Hkfk2AP2WEu9uI0QnYJa0LnoUCPfiJomImf7Cv4H+H+9CWKWoPlex3UFhSjPrr
NdVFJFnN6WRtZMpQFmmkbMOOpyf4MkpUo4gmDArJgfVg6v6fAOwgBrNY09WqQeid
uHF5X5hMQTZ79NPK5CyP65gDQYQ8sFJzWcy9S9zYJfgWxxYOyluuuPCEbAh5zQHx
cyIC6rcnyFJ9cSFP6SecvuvRUJh2nBAuRTVvoGmleVr4JWgTXgGrMlcPoHGDS5YL
3brs8ljcL/j9QrWneYjTjkneIMGiJEjj/1lyxfxN5uEHM5HlK2F3+5rLoCgTho7v
0KpGSfYt6zoOZXpOrjlxoHmttN+rFkqhAdg74uYscMX2T3qXqZt8mlVHITV3pOsD
BFV4cqISdwowEr9/X4NHY4jE6PM3AM67K9tAFwh1CA11YWlwP2k=
=AiK7
-----END PGP SIGNATURE-----

--9Pgo3LNy3teC7X6b--
