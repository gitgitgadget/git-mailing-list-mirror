Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE51177104
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 06:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717655431; cv=none; b=qJ2XU3jKeExqJ8I7Xn48jt9lbmH8Ho/W/o260ebDCK5YwjzsJfJeYJgcMCVOmWVWjS1NGXqc7362uCbLWM1Jt1lqzJ/dOQe8vKpVoHoblnjIMH2oBcqDOd3+qJAyy5kC/OKY+o2wBzb1dlmREAICK9tlI6nUBOsrJbEXEJeXGS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717655431; c=relaxed/simple;
	bh=RD1Uk+ovYau83QM/JLCqvToxyiU1MdFfm3DQlFW8NE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ec7GXZg9PNbAK5qjPOnxlpzqMFft8SQ4N+OUHTOx2SvoozG/GzwDo7BG6QZvubcfPrhXGn3NtvCughvRGBjCmNWFr3/A82ABVHt1CWjw7BHZIv1wOVWiht5tznBFygmitCqKlwLt3y3OEzEQNJzxT4O4kdnrktpPpL9JXZv4lkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=d84BZt0l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BgqPAhVZ; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="d84BZt0l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BgqPAhVZ"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id F1F4013800FF;
	Thu,  6 Jun 2024 02:30:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 06 Jun 2024 02:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717655428; x=1717741828; bh=22wBAmn/Pj
	RvBkqJhwenbmlKBj84cPARjSOWao6xp48=; b=d84BZt0lBENjZYnIskKTqgaY5W
	Ov3e1YGYJnPmSkwYVekIk8+m6ajtVWNCc/GuKaGHpe39PkGgaI6QusPEWj0A/4FL
	cDJSG6Cd+Qu4PVmqPuotxSphnSwmYRBREQ1hXJqrD/X4sngxcRFgk0t4HAwkUbRV
	7UaSr5TuiqKnB0+1CwIdUVvxfIBuXKZgcLO0NMeyCE6StoaIg1EkPnZHBMqk4SS0
	t1CZgkM/hikr3l0m1UpEfcddsBdyAX7C4wihOpiRfuW104BLh7JoGr3I54yi6wir
	/TOycWGZkpFpJe8yBMAYild9AYgqjIAkoFcQBCIJ0BbGXuXYqfVLo/sx14sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717655428; x=1717741828; bh=22wBAmn/PjRvBkqJhwenbmlKBj84
	cPARjSOWao6xp48=; b=BgqPAhVZ8eeDiQISr1rbWOhMOjAcfAI+gi/Wdf2nxFtt
	7hWzrrhB4JnXCrZosnd5IUPAabHwAi/v97WC7JaFH1GsP5i5yzc4Lu6cS2+7iCNa
	MaxYs5bh6SYDaH2fS0fKPb8CnEVSZgtk1J19txgxeJwocOeM88VwwY/dZFkP7On/
	uzJt+AoNPu2mM8G+XLdP/DA4m2OFhoOoe/SxG+sYkMXn5vLYRGiRSKMRAwuGv6eh
	+KetSeliGgZqfyh/M/j2aBDKrcc9k9WoexcHUfLE4aUS2xglGaFTbeTmbN3LxbBB
	VUEc3QQtgUP8JHzLIJ0gLv3Nr98+g6qKymihn8isVg==
X-ME-Sender: <xms:hFdhZlncdL7EaTAwi5zGvzvXIhC2WOzCC1BBxSfDgbAISz-y3kbOoA>
    <xme:hFdhZg3ku61mi9lgx7BYDCkQdblHeVmqAyb9vgr1ubcgSefSOgf7C4FSAeUww6b52
    gt6YUE4MdhuiHuGyg>
X-ME-Received: <xmr:hFdhZrofQEE0JQ9EToYq5xMsof3lUvmH8LmQwWoZ5ljFuThgnheEtZ_b47X-o_1DDBfGv_S6kOLgc2877lnXKwriOrvht4EOpYEG_iFuUCgJ1b7k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeljedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:hFdhZlkKKjXw7i-mNNdTTnz1Gri5Svm889PV-LlbvV-Lhvpxzzlgtw>
    <xmx:hFdhZj0iglwWdTdeIAYGfp00cu9fn2CRMkjjGvn3R7SAXpGI6hGG7A>
    <xmx:hFdhZkv-TUUALneSpoN9qPFe13CanheZTIJOOdUsiInX-3r7pT36tw>
    <xmx:hFdhZnU5bn48-z-9_vGgsOs7KZEsvL36ofi3EngwzTInp4BK5V2rJw>
    <xmx:hFdhZkzCfZs8ldkvmCr3NLAIcn4HJBrxjtXwxxiWgCdwPMoLdBx3i3KU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 02:30:27 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0622e7a7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 06:29:57 +0000 (UTC)
Date: Thu, 6 Jun 2024 08:30:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] ci: fix check for Ubuntu 20.04
Message-ID: <f91004a4382c95b1b87bf3d1aafc018af2b7b92e.1717655210.git.ps@pks.im>
References: <cover.1717655210.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vffGxV1B5J6Pdnsg"
Content-Disposition: inline
In-Reply-To: <cover.1717655210.git.ps@pks.im>


--vffGxV1B5J6Pdnsg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In 5ca0c455f1 (ci: fix Python dependency on Ubuntu 24.04, 2024-05-06),
we made the use of Python 2 conditional on whether or not the CI job
runs Ubuntu 20.04. There was a brown-paper-bag-style bug though, where
the condition forgot to invoke the `test` builtin. The result of it is
that the check always fails, and thus all of our jobs run with Python 3
by accident.

Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 1f4059b1b8..814578ffc6 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -328,7 +328,7 @@ ubuntu-*)
 	# Python 2 is end of life, and Ubuntu 23.04 and newer don't actually
 	# have it anymore. We thus only test with Python 2 on older LTS
 	# releases.
-	if "$distro" =3D "ubuntu-20.04"
+	if test "$distro" =3D "ubuntu-20.04"
 	then
 		PYTHON_PACKAGE=3Dpython2
 	else
--=20
2.45.2.409.g7b0defb391.dirty


--vffGxV1B5J6Pdnsg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhV4AACgkQVbJhu7ck
PpQhow/+P6mHMDLrvJaSroid7aROmN43LKg6QBBFsVqw/x4lvprk0Rb+M+jKDgjX
M2Y0xXvmVHFpKIZ8Qy3waZEySrQsOH67K87QnIyxAoA3b5/S4Ha6wy6Hg9JzMtQX
KShVfSMAB3BeLRFXPNbMy4vOJlVmo5/P5sx2ohZ348bg2+DcFSpXj+HtzFB7nnQ6
cXj2hocJZjyxCg7Rcye6aG2c+WiFMd/RgtbjUj4lt0aDYEEW/qmVQYR5I5OeR8k8
UFIF4g5Zf5LdKiwEVHohUKRf+0EeaQNXIeotq19xwv3d/OdKVW1lvYRTegccr46F
Sbm/HbcOknkULU1ql4CcIUCgohlTgwUhto6L9QjblkA009bSBeJV7UySqoWAgZfi
s1NAN4Jko1pKwm1gpO2vWONwuvDiaEG5rp2iJZc05GfM1XJWcgzUOaXyYVFF0AAe
nh9aeMRZ70PqbXkCIDMlW6ugjOMIgLyNFVRHHiXKJIftr7hVDfcY1hcU2d1e+FDD
Y2pjDIGYGKqmcuX3RLiAZSeh71d++eAqcHtCl5doCPUmS3OjJAU05jHVyGYV7JKt
KxqGKgT9tOBMmcvOthYUFNEZRaOxjougjm3154ueoKLq5Fzfoon0Fl7V/vPG6iAu
R9MItrl16tJWrpnbsYnwjgnuZMjAxxZXmGPeRIWkbQufBLE2E1s=
=hTJm
-----END PGP SIGNATURE-----

--vffGxV1B5J6Pdnsg--
