Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988F160DD0
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 11:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709723856; cv=none; b=KeYAZbajydQ/wx2J9cWJOwAj4ynz5QzF82e9HUR6Sg1e3mktHjGZzTBmJl768T5P05T5X0vJNzegoUA9UadMQUTLQwZTpgDBhGaEFwtr4EFIVq7Tz/J7AsuO7+8iLqECPRyNrL8HtCW4E8NSlCWFV+rmBTf/mJSs3YfQDRLUAsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709723856; c=relaxed/simple;
	bh=K7AcrfsVOdYlwV++p5en0awEbpH8wMVLu+w9obgIRaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KM8KpL8HaHG0qq0YWxRddXyx5SiiqUyTqDA4e8AHrbCSq7DFU4gzEIIbt+osjY8pcqlptY4Qboom1HWTd25JXUM+1iGuXbw4Ta1HfWgYCYPsaN3nv7dflRpyzRzfKVvdyuSOV9lkNUnbZujLFX/tlzO0Joam2r/lqVGfrwzUMow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XfiVvqnL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FLxfTLol; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XfiVvqnL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FLxfTLol"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 7448811400BA;
	Wed,  6 Mar 2024 06:17:33 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 06 Mar 2024 06:17:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709723853; x=1709810253; bh=y5/2Jsu3BD
	9BoBpx6P3mks2vHymrPN/5D7te07JiJTI=; b=XfiVvqnL9O95Fo6DCbHypZYR4d
	7+7owiverYYNmYS3thV5pLrJBtfqVY16YjGjQIfOfRlFsmZ4lWsHzfsA8kyo68tT
	C/rSzFirWdk0sloqPaCpQ/NFjLEcr1l9SMFvbG6UFy8ZU5RALhTV7xGa/reCwCYu
	1eMIL+xbuqrArE42+aupfiOR212c1k4+L/jGZ+NPaeDQAzHEOKysylef93aRbyet
	UZvKdYMspJBhHq4aBOKdidwQEAr4yIa/xT75kel4+Ifd4XfEXvW3+jJENJzH/olM
	xJHNVqklRYml7Vhqpl5JpCw5J62MseXUkrKde53tlfWJDlaSplLOhswi5yyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709723853; x=1709810253; bh=y5/2Jsu3BD9BoBpx6P3mks2vHymr
	PN/5D7te07JiJTI=; b=FLxfTLolwCe7EjvYPko5cPAJS+faoc7xPNlYmULHANmj
	iswD/++I9ZWBhLIDGzxfCMQ/JjAdgYrasxIIRs7rXP4ngJbJTs7U3Ru/i2Msov1j
	zg0vK24xn12EN6kroQIouA4vgpYi1x2jP2HCYUkXD8a5HDRTn72ng+B7SM18oxpr
	qcgIJckOJrGjGNrR2ymOPiJuA94hpkx7Q49nYUBl1fY4xvIgp4YzzRoQJQc4j84+
	Cqqy1SoFte6ThG3tX5OFepqVH3EydE8Ir1Jmi9FBh+UDi8anHC3Qd0HYz6E0Chax
	A+Gq0SlX8wivV7YWIxGJ4fGPV/G6D/z/MoFcGTRSKQ==
X-ME-Sender: <xms:zVDoZW1fZJ6A_V6XhOjSCoILRtIAb_EH2nvaMR8t84CARAfjCxlmNA>
    <xme:zVDoZZGr6mRrK9tvHGLJvsZMvmqQ_N5-ErVcgIKE7QBDNaDA95Z9jLKF98meH4MJQ
    Y1gErlBpdbdPzHvJw>
X-ME-Received: <xmr:zVDoZe6qG63SurS_q7fenJ5eN1jY2-LoheOFnGwSGzOgViu7e7XcaPJLM9jvgntNTModvu5Fg8ta5KVmLpy2E7j8pEjO0KURRw1pRqPpG4RSpmAlKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedugddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:zVDoZX0HpcykgBKG19P8F1zYgvj_NhM6mHBuXorq_JcejqbX7JjOig>
    <xmx:zVDoZZFCfvBHUCsYCxzLAO3ke9toWCZChVfLPA-r1VoBcq1j9psLGw>
    <xmx:zVDoZQ86I3KEnUX-h9p7Qx0o8dh9Tz4TcJTnaQqHf57YsP4IxWxw-w>
    <xmx:zVDoZZAybTI06mqGjketf6MaDafcyudq1WDaDb5wYASEXdvIvFZFFA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Mar 2024 06:17:32 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8e3b210e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 6 Mar 2024 11:12:59 +0000 (UTC)
Date: Wed, 6 Mar 2024 12:17:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH] t0610: remove unused variable assignment
Message-ID: <755ea17d3d88462e8c0a9a8338a0c82ad6506338.1709723814.git.ps@pks.im>
References: <ZecFXXqUdGEQ3YhC@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xh/s3Zuay0ZPKWTi"
Content-Disposition: inline
In-Reply-To: <ZecFXXqUdGEQ3YhC@tanuki>


--xh/s3Zuay0ZPKWTi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In b0f6b6b523 (refs/reftable: don't fail empty transactions in repo
without HEAD, 2024-02-27), we have added a new test to t0610. This test
contains a useless assignment to a variable that is never actually used.
Remove it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0610-reftable-basics.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index c5f4d23433..686781192e 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -332,7 +332,6 @@ test_expect_success 'ref transaction: empty transaction=
 in empty repo' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	test_commit -C repo --no-tag A &&
-	COMMIT=3D$(git -C repo rev-parse HEAD) &&
 	git -C repo update-ref -d refs/heads/main &&
 	test-tool -C repo ref-store main delete-refs REF_NO_DEREF msg HEAD &&
 	git -C repo update-ref --stdin <<-EOF
--=20
2.44.0


--xh/s3Zuay0ZPKWTi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXoUMYACgkQVbJhu7ck
PpQgAA//be32OiFKKEtKBxwwKzpVFwFxQ59muBiyqNU89vq0lhaebGi97zbl5FIs
6S5MrCPtlihUb5k+GASsAqXlzXfAC5VD/FgzPEFX4+kD9EhkMpNCVLsp3yLT5GUa
WsX6f4+n4S2UPo8HbZFcT8YNyugIl3b2avRu2/zUltReCQ9SSXpr61NO8ZlvYeDv
zfGLu+rZl13tnGQanx8rohNGpMDJeY5s7Ko8ZhjFdudheNtml8kjC1bikH4pE/Gm
25j3yFRGpVDhDn7ZXd4UGpy4KCeTfy8rILQB0EmPjdoLeo7dU8g9Md/wSxK0pRPI
V+ylbMEdOfgjU8AecpZG5HyHErBD4vpTl9c2UobdyGo6lJ3sd5BqoiHfaXYWDahy
J1Vpvmoi9RMTHEl579gPX31CatFAOL6esDNGjisEar2CPFKjKLlpnPbFelWA1//Q
ozTQ562Cqa25KGFKa2t4ZFVlc/fhp2XavEVyTI+yARoln9eu5Dk32xh4SjylCgyL
apHDM+nSkjsYAsVB2uJgboc+m5ZTBR+7zWSJezwlYcC8RMiamVPQRwnJ0N2xBmRd
s23MMeGBXv130JdRG+XwiDA+zXKctKP/MpDFIZ1g43tSnXmwnVhJEdzADvLUcyAW
JGvQr2kVygYULF5jLxQ6EI7U5Jq4Ex5xCwvsfzkERDy6/3flmZs=
=CaDO
-----END PGP SIGNATURE-----

--xh/s3Zuay0ZPKWTi--
