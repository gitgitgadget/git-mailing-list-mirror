Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37A3143C72
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 09:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712826614; cv=none; b=t50oTCXxC2Hw3IIZjG4QFe0ViZCD2j0ujLGoKHBL0s/aASiztdGkJrCMzoRRs008JIjv0s1WxqiLUsUyS8Qjo/uru5yEjw99FUoGYZBQOdJ1XMQXJuHUCzw3BYwk9sQejZERramL4NXe7MY+NWAebzY+GVZlUNQ9jf6LkVcGx/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712826614; c=relaxed/simple;
	bh=5Li7yGeyUFRozVwQV+D6DmVeWxrgmsIAVKyUwbu1Cxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/h03SjImT0p1EOazQzPJ/yh1L4as8ZgDFCREnk2fLl84m5z3q58cu/US/YwmRAeEDox4RTQU6ynE074g5nvwO4OYGIBd7zUxV8LP+vOCRQcaKcb1wiCYG8nA2SEP2dOp+RTpkboT5wWpNwzYRieWs8arZOIDR79AMxmvgaho5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B19tnaxW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gYs/lBSl; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B19tnaxW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gYs/lBSl"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id DAF631140152;
	Thu, 11 Apr 2024 05:10:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 11 Apr 2024 05:10:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712826611; x=1712913011; bh=u5XHrr+xQG
	y2YT8G+mZspVrzX7g3Olq3Rtby0F+pRfw=; b=B19tnaxWkLMlQVRqh6QEP+fV24
	rUs7NUtLY+vIyspT7GkOxqUoG24CMrWFtysP/B7KBi+tJo7AzJXJzCqeOGGLcxVx
	n/z9PPJ3s7Jlm7t39zqAjqUlPo6UKT0j80GlxlYv6V40HeNa0m+XIxh7rJtzAajW
	upeAr3n+DB3yipi/2OGKK9hbYxiFlnDTNDRo/fKCq8ATnGWL9scrwqCV1IMfjekw
	SlTeb1+50D7ZHwraGy3UBobV++0O+Z+2YA8TzC+q2LkBHXI4pxcGS2+uIWlHA2L0
	/OcM2DSC9AyhObVS5ZdiskI/8PiL1o1kKSpRGxvl+Ub0kz7xR5RduGl4ef4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712826611; x=1712913011; bh=u5XHrr+xQGy2YT8G+mZspVrzX7g3
	Olq3Rtby0F+pRfw=; b=gYs/lBSlfFbGFNCUPJuj7QMaFSbjJ8A0iaKas5moOoaz
	pOngGwvWEFfhO9eDIZsRmDzxSrYfyAT3BLhv6SRaH5C1mBUSQlyF0hc+E1YZZ/Ma
	GjiC3U/II6fm9es6iUL3NaMAs35gY3J96aMj143RmLdQ1WW6ufVGQ9fOrtBv4leD
	eTkUWsyEL4dI07wrm1Mzhv38mfwNsuhnFIcEjSTb5WEU2QqFaZ/daE3Czz4Epccr
	ZAMQTO9nMKH4/3g0chLl5tUET3pZ0aWCOpewyGJIdVfjw3kheRS9SzGiOqkjkzs4
	NJmyBH8PS1Pvdd5loK0BYjkprH/6rCeRUV7x6O+xOw==
X-ME-Sender: <xms:86gXZlq7VTqmtKOEg5kQ_yzI3OURLPEcu1tiFjH-0N4gA_ecxSN-dg>
    <xme:86gXZnq9wechpgb6f0fc8yxYSOIA90YcVY6W_qlBetAInEmsaml1sgONnqIgiUAKN
    yXLhvc9ApVdyZBrrA>
X-ME-Received: <xmr:86gXZiOhkS2bm518_s5ETdlsz0i_HD1tLtieQDXoKxcfaT_XsEsJfR1CCpMiAvRJoE94z3o1VQOgvm8_Q4lnrEGLeV64u6TGOqGS-p4xytlu5JEU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehkedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:86gXZg567mitsRc6k6iZQgBBBWF7ypi0Z-P53FlN7UtnLz7btcDa3g>
    <xmx:86gXZk5QXtRcLbgPKwWSCFIHpgzCFL9Iqqi8Xsl_OVoJFr5K56a6Jw>
    <xmx:86gXZojhHFVYf49Zc4wHa8m0UcYWIhXE0s5eMoIBuTXPNmqHXgeoVA>
    <xmx:86gXZm7I6XvMB9ocL8cFTlr32eVKMWgoBEN4vYRs8HKhOhRY1iOUcw>
    <xmx:86gXZjaaXekJSGWPPy-9K_l-vtDq6DfzEIImjU4plph44H_JJNC4OpIR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Apr 2024 05:10:10 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ca4f3fef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Apr 2024 09:09:58 +0000 (UTC)
Date: Thu, 11 Apr 2024 11:10:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 03/13] ci: skip sudo when we are already root
Message-ID: <cc0c29052f432bdb046b3193ffb04bb8c2f83f37.1712825204.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712825204.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SM9q86nlMrgzPH33"
Content-Disposition: inline
In-Reply-To: <cover.1712825204.git.ps@pks.im>


--SM9q86nlMrgzPH33
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Our "install-dependencies.sh" script is executed by non-dockerized jobs
to install dependencies. These jobs don't run with "root" permissions,
but with a separate user. Consequently, we need to use sudo(8) there to
elevate permissions when installing packages.

We're about to merge "install-docker-dependencies.sh" into that script
though, and our Docker containers do run as "root". Using sudo(8) is
thus unnecessary there, even though it would be harmless. On some images
like Alpine Linux though there is no sudo(8) available by default, which
would consequently break the build.

Adapt the script to make "sudo" a no-op when running as "root" user.
This allows us to easily reuse the script for our dockerized jobs.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/install-dependencies.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 7d247b5ef4..7dfd3e50ed 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -11,6 +11,17 @@ UBUNTU_COMMON_PKGS=3D"make libssl-dev libcurl4-openssl-d=
ev libexpat-dev
  tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl
  libemail-valid-perl libio-socket-ssl-perl libnet-smtp-ssl-perl"
=20
+# Make sudo a no-op and execute the command directly when running as root.
+# While using sudo would be fine on most platforms when we are root alread=
y,
+# some platforms like e.g. Alpine Linux do not have sudo available by defa=
ult
+# and would thus break.
+if test "$(id -u)" -eq 0
+then
+	sudo () {
+		"$@"
+	}
+fi
+
 case "$distro" in
 ubuntu-*)
 	sudo apt-get -q update
--=20
2.44.GIT


--SM9q86nlMrgzPH33
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYXqO4ACgkQVbJhu7ck
PpSqBg/9GhNtVU4v5UcIgNHFXDOFIPGFrGS+lCnrzItu/nsHZtPieM9+FGAR+FZa
hwgdgiqvkJurSd4C+OE25W4Y9B3J2hbU1lJadj5t5p8flUv/cDrqTSkvl/xfl7zV
e34k0BiRDBSHC/Hpqk0SxjRAio/UXuUWydcYmPFESwwVSK3MJSl//k5j1+Y0E//o
CkwWhvFoPrOK0b0sRdfTp98EaRbLUOA0GziUAJw6pdVW2SLxeiO8wwP2vDBTJMPZ
0diaxDx9cqd+mRAjZH9sCX8LZPcKUIOeyOEJo6+54kelUHpIc4lt4bB9CAZO9PCw
7c9+gGKUjdBcbVbkAaEZbMkzV4DqSBMql0OCQoRMwGFjK4AcqvuTWDGMzL7THjfs
4ZkPZBvZFI8gTGShctMafZvrqxJJThP3jHpaGL1pa3gYAoRr+P6A/qQWWjWu60eY
lSyyAOFPUZ9POdP4mg0BzJbvx4o03R5gLOU9TPZe1HhjSz6hcjTUyV5WGDPloaIz
kvf83GfYoiFCE8cfI6GQWDcSHBWMJ9v1R1NonXmVYeG/qu7WzRd4PFbOghn/ACpt
NzuF0nDHmIihrkzv22UbNkXBR9ATEHrPoe/ky7vbZl5FqotKIiCdzGAIWu2TBC6U
voiccdLKx7lj2hNVdHor+WcXi/F9XuCq4KjaxBZWjjEUevlP2RY=
=ISv9
-----END PGP SIGNATURE-----

--SM9q86nlMrgzPH33--
