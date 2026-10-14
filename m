Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114F04A3D5D
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 08:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791966656; cv=none; b=l1tYquS4v7m6QK1Eu9pgI6yQRdPM+Ro8e1aujwg2lfGTdY6yEAycYirW6dCUbKmMhzzIp9xY1RErWDhgoPcgY2XCBP3Uw5RGzisJMTvEfORoS/ruS7rMq3G2N3gAs6ih+6CUBKKoDv48zg3/kjJhGF7pAxibeK4YMFqP6AAwba0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791966656; c=relaxed/simple;
	bh=R+0GK7TKnwm5QJs7vKaOspHxyXY8m7yTOsUUSpbkVpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rFGIaX9BNB4N1YpBxdrNVJeMvMho7/9p7Q6RjURbWhlq2i6P6MZsXf67aESyuGN5VTzt/F4FFfOO/E2xVqofN60GU9cVelJ7OdLtantGdkpL10/oTZ0VA6XEXDjlw6X8VjCzMqLdHOlJxbm9xvkP+Z81JtbH4OCaIg1uKL0GCl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SIVhvOmH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DUKdXGQU; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SIVhvOmH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DUKdXGQU"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 40C4C1400144
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 04:30:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 14 Oct 2026 04:30:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791966654;
	 x=1792053054; bh=D0YKT16gBACNrffq5OoIFx/5eeIrBSpPom+i/MVDFDE=; b=
	SIVhvOmHan7JsdKr8yZ7EnRegTtmf0edGA7J01J9RChsy1aWNEvD0rxaC833ix98
	lEN/NzWwQmUC0HEyTIZwEf4reEEEaiZsT8j8WCCt0Nf+UYSqNxugJUh8OKFmG0j0
	r7Lo5H2KnROq7LoR5t+cbmo5gJodIBO40MLO7GiA1AldorybcV8ppAFo9Q2fKqDP
	8BLZPtofL7JGCaAtILDWZdryMMja4d+fFmFfZuZo2NS2htvdAZOSz2y8uwrx1nUX
	TKBL1nQtwkpbocgaPCBWU8JftIBG44rq1ruaJ2zV4ezO6NDq1BrgMcFizcyh92YH
	ViXvX7Vmbv4TPsg3VbOmOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791966654; x=
	1792053054; bh=D0YKT16gBACNrffq5OoIFx/5eeIrBSpPom+i/MVDFDE=; b=D
	UKdXGQUTDU6yKbPZFCeffZkK055RUgpc+08LNepCn8w5xYJlVu/jwOh1DJasSu6o
	oYDDmcLLDCOh2g2iea8E2jAyU0B7lt5rfGo/zcRsHnqv4rxif83+2R9k5BU1bs59
	kN3JMrPzJSRYBPUzRtSAmBsf9yBvvnn3u7yYcIp5QiP8QW/JvKK6l4J4Q1IcdBlu
	ymY6IcLn5BVztct/UmKswJ15aLV0cwLp9p0NqAQer4CkwyUQ0BWgicab4ZVkKfyZ
	8agIUp2+LN5akUX6WgrEhUvqDPRlsxb0yfVmgXTctX2EHi2jQjDE3S63JK8sCdO+
	uPaVtLTx0SvrbuSl036rA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791966654; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:LHUu+TU9VCEfqOuh45bTt21BRp6QTtgKGHaTcaWbvKNdXnz
	whkOekVqxgUdqRbC9EWCcH30az6INcHBpvclMWuqqxWqpgJa3md3fjHVlnA3gNxk
	geQi+YNCbFtCGlcmUrR3tTNtHQAdzTff0B3tHmk0jWbIka4478xXL95wyK1f0Zgx
	khBTEVP0AvnRg3grIPkM/rthqsRcVeQRakB/8vy+0e4NSxyFZlQc1d6O2SNo28i7
	ziB7TdnR2iU0jDlstaig3JdoMa2kuAqCrQqP+al1VqqFc8vGa12lYXz6QrKhKbB4
	x8d4+8g2Pa9GfIhdSxGTxkHZy97EOwhVQ7RBiiw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:J4HFVJok9SC31EW0KKKB62C+NU3vdsj1KmD6Om9/H8w=:R+0GK7TKnwm5QJs7vKaOspHxyXY8m7yTOsUUSpbkVpk=;
X-ME-Sender: <xms:vj3Pajk_BvWEO1l5_fq370HeGZS1uPWLSfYUYEVlVkS7_E59r0gzCg>
    <xme:vj3PatsHL8KFht18El11zxz5-F9VVBWkKm7K4QdIACG46WpxrkXIl_I036J4XMLzu
    MoRfPwsqOImV0xGRLr0vrS9ou_Mwb0ob__WtFXusBBJl1Szw-EZk_s>
X-ME-Received: <xmr:vj3Pah-tC7q1F7PPDFjgowooicQV1PSd-dYIJJ-bRu0KFz3ZsXC0jw>
X-ME-Proxy-Cause: dmFkZTEtIdS0SDrKqRBbGkMiBj7IYtYgkry3u6YGR8PVQtgXAUrOpE3LU3kbf8lnhzM4qe
    tDYxR/pkwWHOxWgysKl0tWoalBEtfNecBO6KOpS28KMaa+040r1EpxHZBZmQv5GL9sEG5o
    hyeINSTJ1UaptmD0zaHHuAY5E63Mh/DVOvgKPvqap2fxwOCmYQKSLm5PTkNU8tLSnysX8J
    gC6EPQbmnZB+smbTpcyqWIjRYXgPfG6KhVLdYxiYVwwtzPKhwCHiztOxg88hp9nGZZ74w4
    nWVRKOkdg5auz9tzk5CdYXOjnquk5c0DYbI9yo6WgnpCzTld/1+g9jKRcB7y0sxVoiirGW
    KyCC/lbYA8Bilcrk2YDuJHlj9ShBj4bttMOUJ7sT+SN6ZyvFD6u3eG2jVaGhSkcaGjlAed
    NWlzuZh1A6vNvDMV25/RRwmg8eF7PQ8+RZXQZbqXttq+0g8kWs/aMQR56D0oG6GiYp4eWg
    LQ08+qwkk/1JjZ7ofd+kF4Uxg+et/3uSl5JWbz6IWxelW2aSQPvSZAgFNBErtgBPvLoGc7
    64hJWJoY/HDZAzybABCSuiFPm3N2KPskIDpaQgCPXmkz/3pzXZmqzTTGY8hCXmaPrWvNL8
    YHV+Cd4rX3K6nTxvcQII85R8/y7CHta0XcPmlB8Qs53swvt0yjznIY7gp+xA
X-ME-Proxy: <xmx:vj3PanO6t7S1CM2WjkgF0l49hBhWcOwgnJl42fW7drcNtIry_Fc22A>
    <xmx:vj3PavFx19RJEDv27vwOnYAbFI1UkgOYN47-IgxXN-Waz5Yx3MlMkQ>
    <xmx:vj3PalRjQjw_kEadLlLzf9mO0JUzoYouK5L6YJ-PRF-nc_8NfX_A7g>
    <xmx:vj3PassKKw29rTybL5XQtsiIld1BXquHQQ7vryP-aW1TEwiz3LJIig>
    <xmx:vj3PapsVb-5KEHxbU4Re7aXMQVHXOHoC4MK1V6Dq-z0hIOMQefoMG0LT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 04:30:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 44856e7f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Oct 2026 08:30:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 14 Oct 2026 10:30:33 +0200
Subject: [PATCH v3 7/8] ci: drop now-dead Python 2 coverage
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-pks-ci-housekeeping-v3-7-04c24e1f480d@pks.im>
References: <20261014-pks-ci-housekeeping-v3-0-04c24e1f480d@pks.im>
In-Reply-To: <20261014-pks-ci-housekeeping-v3-0-04c24e1f480d@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Todd Zullinger <tmz@pobox.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
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

