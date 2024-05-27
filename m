Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C764D152DF2
	for <git@vger.kernel.org>; Mon, 27 May 2024 11:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716810354; cv=none; b=bNUMcPlLmVCVYBavnMUchiTFtr5Y/Krplpraa6loBbT9sb5M5Z1yr+kTTa27iLs4iyRKrwr9HGSABEzL6r+vUGpvNZ60fk0jJhmrHMZIyjQfQBHv5FT+7Y2mtozTELKcVIhR9Wm+b2CMyvvcCyxKWatBbunrs32cAko7l5h+eUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716810354; c=relaxed/simple;
	bh=NNVgIlaTST+UkIXQH0002/VI4UYuLq9kSHdTlcUx3NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0rrRyYBiOpPwj1ydt6v782NwZC+4M24T94M8E0RVxJCbM5LSmecM1vT+Dwy7qRKz5+HZ9S2bcFJGaYws+GYzd176sJ5WIqDPjm8ybXFGAiuTFkh3/rU7mW/pquOsOma40wCutX0e85T/5gv6He9/CPu6jwZj5kD0CWtQ5T6f6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZZS8F+WL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VRqVDjPX; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZZS8F+WL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VRqVDjPX"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 9483D18000F6;
	Mon, 27 May 2024 07:45:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 27 May 2024 07:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716810351; x=1716896751; bh=ZuvaJ3U/gN
	BRlJZnLvJoFFhifyWy73rkfSO4FRfJBGo=; b=ZZS8F+WL33xtCacRos9XHC6uEU
	F5hX+OKa6Q5YHIN/bmXqhyxFfA5FdCcbivf4fdsnFdcCPko4NuIzP9zVpEG/B5BT
	EyynD99UOayqkteoPNkyBpI3LCCngmywn5RnSHXc/49Pgd+3C4yJ9Krp6mOpkCzV
	+bCMy5QpWfykaO8MpSVA1viqxjZZUle6frZOprOPdaUDvxVXFe+qxNYdWv5t0Du1
	TbUj3ZBpqxiB9TK8/POr69G+AEyAW49tZSvmk7B0lgG5TegpSadsgmrzQTkPP0gk
	2xsMjB/X4w+uSfGknimDXIWc6bWol8mmqVFBpdt+pdVAMdEef+dDL90RYhnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716810351; x=1716896751; bh=ZuvaJ3U/gNBRlJZnLvJoFFhifyWy
	73rkfSO4FRfJBGo=; b=VRqVDjPXl6yldbYm7Hr3k5brJlx0UmH/6i053v/bR4zs
	+5tLuXh5ZMG4ry+pO84V3PjmQzkxYUcuu6I549zU77e48z9eeg7nK1I22zdmSIK1
	oAXs6iifHBnxYIIiNJ+bIq/ECaY+ewYVvWbQ9HF89REFUWPm260vQBpgncTdOOMc
	zSXv3wp2gNJc9g0PUtkGhe4at6IpjmoybUp+Di0u7aS1pRHr8qrsRYL3+cueYpaF
	7pJFwXRpOkNUQKZLJIylQZGXW/N1iu1us7muftQ+sNLIabmhOB3N+E8x6LZmRJPU
	uVQ0DkaHfycjiXwxjANkiNheQTSGpga4XMtavryoxg==
X-ME-Sender: <xms:b3JUZky1yN01VI92CwYFUoaCTaPg0azw-dRy0BIwmzXn26JkGjL8Iw>
    <xme:b3JUZoSVXRMj90mV7V3jVhATVWbyr-yDtL5sgxSoDNJd8Z4QpCRAwhYaijby0G_bd
    iz4FNBUKTzzoXu-HQ>
X-ME-Received: <xmr:b3JUZmWZPZiJ4t7yAcMxGJcpK2FCaCBCT2Ywi_ciLrjDyx0bJ3GaVi-j31HYsmHmgsatwfiGQXzoYNqrCoJTYYprdEkpa_yooMi8cyEyVQPrtAj023o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejgedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:b3JUZih6Cm5AFMNNMo09c9jP-IKYUCtbBmgoYsGTk1w12FbdzoXzRA>
    <xmx:b3JUZmC3Wc1xYxA_E9waaG44l6piRjJ0eWoepU4lAAmcKmX4fiHlUw>
    <xmx:b3JUZjLwWddROepNCDqpmUJLy8DtKdNm_5kkI4HmrvU0CXLMX6wHjQ>
    <xmx:b3JUZtDCzbvbpnOBcjyRN2rFLGCT2f1Pxqyye06UX51o0tnz0db41g>
    <xmx:b3JUZt5SmQUxgUFR76Kjs8rVg9TnaAnveZNx21VOOW2ZIJuUZNO3kFjx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 May 2024 07:45:49 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 53ebab43 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 May 2024 11:45:39 +0000 (UTC)
Date: Mon, 27 May 2024 13:45:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 01/21] ci: add missing dependency for TTY prereq
Message-ID: <ded220a06bafc0ade5cea29e9809a0cc023cb08b.1716810168.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716810168.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wA2J7GVG8OT/TOOh"
Content-Disposition: inline
In-Reply-To: <cover.1716810168.git.ps@pks.im>


--wA2J7GVG8OT/TOOh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In "t/lib-terminal.sh", we declare a lazy prerequisite for tests that
require a TTY. The prerequisite uses a Perl script to figure out whether
we do have a usable TTY or not and thus implicitly depends on the PERL
prerequisite, as well. Furthermore though, the script requires another
dependency that is easy to miss, namely on the IO::Pty module. If that
module is not installed, then the script will exit early due to an
reason unrelated to missing TTYs.

This easily leads to missing test coverage. But most importantly, our CI
systems are missing this dependency and thus don't execute those tests
at all. Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/install-dependencies.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 2e7688ae8b..6ec0f85972 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -27,7 +27,7 @@ alpine-*)
 	apk add --update shadow sudo build-base curl-dev openssl-dev expat-dev ge=
ttext \
 		pcre2-dev python3 musl-libintl perl-utils ncurses \
 		apache2 apache2-http2 apache2-proxy apache2-ssl apache2-webdav apr-util-=
dbd_sqlite3 \
-		bash cvs gnupg perl-cgi perl-dbd-sqlite >/dev/null
+		bash cvs gnupg perl-cgi perl-dbd-sqlite perl-io-tty >/dev/null
 	;;
 fedora-*)
 	dnf -yq update >/dev/null &&
@@ -42,7 +42,7 @@ ubuntu-*)
 		language-pack-is libsvn-perl apache2 cvs cvsps git gnupg subversion \
 		make libssl-dev libcurl4-openssl-dev libexpat-dev wget sudo default-jre \
 		tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl=
 \
-		libemail-valid-perl libio-socket-ssl-perl libnet-smtp-ssl-perl libdbd-sq=
lite3-perl libcgi-pm-perl \
+		libemail-valid-perl libio-pty-perl libio-socket-ssl-perl libnet-smtp-ssl=
-perl libdbd-sqlite3-perl libcgi-pm-perl \
 		${CC_PACKAGE:-${CC:-gcc}} $PYTHON_PACKAGE
=20
 	mkdir --parents "$CUSTOM_PATH"
--=20
2.45.1.246.gb9cfe4845c.dirty


--wA2J7GVG8OT/TOOh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZUcmoACgkQVbJhu7ck
PpSRKRAAgcTawuTx+lOQ7il6zV+mwnI1fqHDPukNPkw5SHEXHF3A8/uCTJFhFHBm
o88+yL3CKaTwcomx+dpRLakRrIgZ1CYJ/93MkeFA0GmM1ecKtaunrda2YUk8Dg+A
Dj6fWTmL5Qcl/99JopxM43akVeJKYY9hh6V5qyahaT0UqG9Na8AOobQiBu4v/828
aIQdY/sDoxWKpgdq6IujCUbEFm8OSA5T4l7z5qQRtpMmvxgeMyIa1roRPpKgmw5v
fyaqZZN0xiKGaut1+ygf0uMvNg0bClqfl/8d0T+D0Dc7+uDh5Z3gXD29yRzMToBz
DNG7pfg+3zkyIjB3QKyPPm/O2GZYfFSSeTaqbSmHOS+Zogaw8z3khBnpjrVleRzu
tAK6P0V7yFP6eR/HrRu/wulP2q4LNtirKJ7NZOcHyOgbnrVKZu4jDPyz9fQ/PZpZ
h8fz/QLC8gy24tY4Hel6h7GlRmgJTyegHLzCLriT5IcEN50o0ZhWI97KD/zF7X/N
deqNCv/LrTuA+ETLV692lS3s7x5gJXbrtQqZC0RnzFG0PVjwY8m6bne5vH3jV5tl
b2JBbGBaD6g86DhgRo19+/arih/xOyiCKf644Kp+qH7FpP+MnG7zAqjXoiFs2g1o
2MXAI+GkgUhiOfKAChyn9FJHr7nPOdXwf3bvfX97sQCoYd+T718=
=9PzH
-----END PGP SIGNATURE-----

--wA2J7GVG8OT/TOOh--
