Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B741F4A2617
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 06:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792047462; cv=none; b=S3w2N26hCIG/QMkWknOZoHgRwhm+h0RapHlEueD8nFkOHgHDGJfeSMz9OvX2Un/vslhUVWVQ1YLmgcTKcFxzhLyfwOF1+y9A7NCLPruJkzwmFlFqJ++nX4iYDNeV+7UouzruqA2AyDUCUm8+2ZWTPz5S8X4bGS+EgWn5j1pEw/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792047462; c=relaxed/simple;
	bh=R+0GK7TKnwm5QJs7vKaOspHxyXY8m7yTOsUUSpbkVpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TzjsuLjv44SPc4HZIKMfvdSIDghlKGkeR0rBN03oi3cwfMkgX+db7+yiszCQDihsEmPebZ+qza/WklHe57+Wxf4NE1L4QnSvKcxPA5IqbPHop2PERQhB8ZF0QCl3UaEE+7TUwWTZjr87l2XrhydGaGDKccTSUYMszr+rB1O1aI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Q8aJQ/g1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I7C0mVgy; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Q8aJQ/g1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I7C0mVgy"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 01D6A1D000FE
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 02:57:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 15 Oct 2026 02:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792047454;
	 x=1792133854; bh=D0YKT16gBACNrffq5OoIFx/5eeIrBSpPom+i/MVDFDE=; b=
	Q8aJQ/g12RKAtPBPcG/kEbDPaRpn/z37ZLftlMexvDCwus6fISvddHvEtdEGvarg
	ofmp+yyGP22qkHEQxXQXIFK1sarvZ5b8yQuRY4ti8D0XTXgEOFLaMxG94Twj6l6x
	PaXZ1Dgkgolqh9vVbsM1o9v4DTclHCFNUzxurCnlRD2o0CQDhprE7iClU3W6Ykzn
	G0xsIioa4poBN9VZfNcpDMDnGrY/VxiUjfx5L7nRIUcRY3i8RkBz5wv/+b7uonrh
	lqcLIXJiezMb0as6gQyeyaj5g5paqiiKNP68oa5co/XZkAh/3xPtMo1dWuK0hK+Q
	iiLpMv2zcNvTucbYirzjJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792047454; x=
	1792133854; bh=D0YKT16gBACNrffq5OoIFx/5eeIrBSpPom+i/MVDFDE=; b=I
	7C0mVgy84PKZlQSMdTRtq5MkkQM3kLEkVGsodi7ta3OEystSZlTuVPC5cpUObwsE
	B7MnmfJr2r9Pn6bMRuJtMrua5W0+vXk4Kgu8Q/PXHlQEpGG7uD4d+Bd2jRPGbczh
	rRGiyJmengbDRxwVcnEQJyk2MPeFddVzLO3uRAw+k7yIvaO573iP3OXlUiuKYwaQ
	/UAsq4C83qvNKED7nI1PUBPwo+0SMKk0b7eNo7Fwza9HJ3jfqfl78vWBY7eJ3yE9
	/ooBDsjNdY+ENsKU0I5QXoXHgFKwaug4GRPGM1B+ZpuElHeVome3rclQcHOvir5I
	7DlY1WvG18f+BWywInVZA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792047454; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:i8AK+bdB5nV6vEZ1ZCW3qKFban35COLODTbtDOUjCTVI1aY
	hUJiQYUfjtAupw04hnmw4YhfFHoCwK1A7c3d757/Oadq+JY1U+TIg35/O4eD53wa
	jbCuPl7tINl4kdaw6aBDY6WYMirPyCNPJryTrYpDt55ZXq4zX8o09jzDqJG0W+E+
	PR5XbJniqsSFEr09dWVXkRvnyCUkt0sAxPPWzigAuAvwn0ygRd9WsbpZZEZJ6Ifb
	chhsNdLD0Cj9MuO/kgaNRLkbUZIeJC4bD8dnIQtBopwEaQOhlbk36k5JaMK9ytDs
	StDOR6m2qARXBvOu76bn3cozujoA/t9b9XwrtMQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:zM6wdL70tfUjuO+GretM/D+fseuChuyqrTz2hOzzThw=:R+0GK7TKnwm5QJs7vKaOspHxyXY8m7yTOsUUSpbkVpk=;
X-ME-Sender: <xms:XnnQaqDeuKuLTrhh6Hj-8PecqPd2O_zUFnivdEH41Vl9kohgkliEKw>
    <xme:XnnQaoPLqygxf1UzZyoYTy-f3VMgMnNFJ273mwXGl0BQwttVsdU_ZaNhcBFKW0Bn2
    81rFj00MMWaBzWXzBAIm7h8Mfhogav2nKJ2NWXo5EMUHf-HFQ7k1zg>
X-ME-Received: <xmr:XnnQanazhCk8ubH8F1ZCVooKvtEDTqpKrNioNxv7yZWasldq5lWSQICvRl2B7-uHkrWHRws>
X-ME-Proxy-Cause: dmFkZTEtUvAGxsLJTUwND9VYUlYlcfzw4leHbfFICa9Zbzi8Ve0xk99hOMrC8JWgyMNjpL
    d8OU2RGTcaPEzrBKb4q0VSV6wqeZkD07LkmT9JDuWFN84fpWt5K8Q+GRvd1lcDDbz/LoOV
    kwt6oy4K98UcTaAIFJE2C70gLxy6yrO6zgASwulP2/gUH3qV0wZ6mPTL8dHHme0JzPWTgK
    HUq21r/Zut+zgaXkWH60B3u6v4T/jnwvKyPxQ7Rlghx4TlScz7P3jdjipOCLu+qNDnQzX3
    18xZCH1OxjLia46gLGM0s2D2lumAHp9sZQUiVmTTqNhG04DcMBQQ8yDrd85c+15nCEhKlS
    YE0npMVEbtFRpH0sTRC9mSJCTO/XoOuVHZ0WQPNf4pymiXdHbwDdrS/9Ya2BxvcPQx4B6h
    648gt+IPfUNncYDqsDMWGBIKPN+MvfYq0SD8lVUetSfVjdkZqWzjj0h/Yr80KGfDDgwgbX
    PHS8ifDFEXolDzfcxmx450q3Qw61yI8qy8Gw8XVvZYJU0Lki2iL81NcGndubYSzS0S3zmJ
    2ewzsWTYTtlM3fqCdE0w2GqH9qP0AWhFr4kqEeheD9QjB14vP6Uu41U3sp2K7UyNAaWTgt
    5D+7PUDEDaKDKJw+QbM8j/8VwdBJ2fNl5B/QdjHoGn6u8NpvZoy6ezjXj/Vw
X-ME-Proxy: <xmx:XnnQavvccY8CWDzndO2k6B-fdNfOHIqLSAHGf0x7k8ODTTt4fptSIg>
    <xmx:XnnQahNo3ic-eTluNLxSVLJfSE_g2I0OHy0oXuzyVSppq0vDwtpyvQ>
    <xmx:XnnQau6A58UrVxVgniUQfZNqtIcprBfTrP45Zc8kLzjY2LEVgF7t7w>
    <xmx:XnnQavQv2I6W0L1V5i02xzCT9RroQkRW4WtRHNpJ6DDdINNrSPX-yw>
    <xmx:XnnQapz5RpPr-kcoIfIwR4qR9T2H5X8Bem6P6jVvILoW8wfEwXj_6DOh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 02:57:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 570e67a5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Oct 2026 06:57:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 15 Oct 2026 08:57:16 +0200
Subject: [PATCH v4 7/8] ci: drop now-dead Python 2 coverage
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-pks-ci-housekeeping-v4-7-c2c88f1b198e@pks.im>
References: <20261015-pks-ci-housekeeping-v4-0-c2c88f1b198e@pks.im>
In-Reply-To: <20261015-pks-ci-housekeeping-v4-0-c2c88f1b198e@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Todd Zullinger <tmz@pobox.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Mailer: b4 0.15.2

In the preceding commit we've dropped the last job that still used
Ubuntu 20.04. We still had some conditional logic for that specific
image that made us use Python 2 instead of Python 3, but this is dead
code now.

We could of course exercise Python 2 in any of our other CI jobs. But it
reached end of life in 2020 already, and none of the distros that we use
have it packaged anymore. Furthermore, it seems like the world has
finally adapted to Python 3. So it doesn't feel all that useful to still
exercise it.

Drop the logic and instead use Python 3 unconditionally.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/install-dependencies.sh |  2 +-
 ci/lib.sh                  | 11 +----------
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 8783b48951..4b1733ad15 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -61,7 +61,7 @@ ubuntu-*|i386/debian-*|debian-*)
 		tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl \
 		libemail-valid-perl libio-pty-perl libio-socket-ssl-perl libnet-smtp-ssl-perl libdbd-sqlite3-perl libcgi-pm-perl \
 		libsecret-1-dev libpcre2-dev meson ninja-build pkg-config cargo \
-		${CC_PACKAGE:-${CC:-gcc}} $PYTHON_PACKAGE
+		${CC_PACKAGE:-${CC:-gcc}} python3
 
 	# Starting with Ubuntu 25.10, sudo can now be provided via either
 	# sudo(1) or sudo-rs(1), with the latter being the default. The problem
diff --git a/ci/lib.sh b/ci/lib.sh
index d99e7b9da1..3ec10488d4 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -335,16 +335,7 @@ esac
 
 case "$distro" in
 ubuntu-*)
-	# Python 2 is end of life, and Ubuntu 23.04 and newer don't actually
-	# have it anymore. We thus only test with Python 2 on older LTS
-	# releases.
-	if test "$distro" = "ubuntu-20.04"
-	then
-		PYTHON_PACKAGE=python2
-	else
-		PYTHON_PACKAGE=python3
-	fi
-	MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/$PYTHON_PACKAGE"
+	MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python3"
 
 	export GIT_TEST_HTTPD=true
 

-- 
2.56.0.212.g129ede20d9.dirty

