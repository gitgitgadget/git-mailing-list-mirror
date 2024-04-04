Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82101272D3
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 13:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712237123; cv=none; b=CXAGZmpn+e5yeln7/lH2xs3/NUkLQj1tala8ImD0mO28febOmgYyevilgEhd6fvfiImquSOc1k0kMC/GmpXOr0zkxKcua12W13Lw29s/BDvgy6nZeTS7hyNlpY3B0hKwBtniidVDNn2Bb0vXbRNuTgBUN0Xdy9QRwlLylgtPo8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712237123; c=relaxed/simple;
	bh=Kg5+Axdhzr93z20NUB7lvUIUGQGi2cQDtiCe3JE8UOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXEpqc3yDisD/H+eEH0me1ivDjCJXR2jo2piE4WH1Bo8uMm61EP4sLX7EQgPakM4uWmGe/UxbtYqejG3ZqrXjGM715TpeDo80t7Nc5DS16PPL3EckoM0a72Brz05p14DoX4CHNdzaxPn5P7iEKLKTPH8ejYrSSbQJjHwfLBf28A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XZKrTz2K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uiB1kTFA; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XZKrTz2K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uiB1kTFA"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id BE37C1380148;
	Thu,  4 Apr 2024 09:25:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 04 Apr 2024 09:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712237120; x=1712323520; bh=LpXPoOqbqJ
	BpkGRfVJ4i5Ua2ymUF8aErm1nVYP6wL2s=; b=XZKrTz2KsozPZ8n9ntDbgp+AkN
	zhMtUZl1RdiIY+GDcoR6b8BKO58Phb6SzMowIwOsxpzS5HWdUTUBHyTfCtDqYr5A
	KJA5fYNVPvYlk6vPaoctyzkAsPiolOjqo9swOYX7UbN4118dsuCxBxbLtyd1W85/
	Qf8PohMr6eH2Fr4l4zQjj2jz9SqRm5Xmo5HvFkjctVPaoSDpDy46cPJ0i2ww7Nju
	ZPljeB277NaxH+mCg1Sq6Z4hsG1kUjhF3tvjrO4yF3NZGaNG5XQrnGM7HcqM+GLz
	4Gg9bxOJkVNBRQIjS8VcxS4iFOa+yPsdCcidicAnt4XyTALw5iLOpSIeLsFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712237120; x=1712323520; bh=LpXPoOqbqJBpkGRfVJ4i5Ua2ymUF
	8aErm1nVYP6wL2s=; b=uiB1kTFAOoanz6x6boMPKpMFshrbwvtRim0UOSya0B+o
	HvP2RBGH6nVuLlz/GwG7BRGXCynYb2XMIQcLyICweOpUSJGLU2NMt6uvd/EU5Qjt
	EK+uTIq9jfe58RHRbVMMTRojPT2RZx+mMwuFk3EXBOW+b3TewL+FJAht9CjIBoUd
	jXZhX792F0yUZ2MWLfUyEUDnPxqNZsubMtPYUMW5pkXOlWl5PD786fvVgsYEOi7J
	9YUjhd3CoZsWdI7qX3N0O9bDAXlMrw/kHhkVfCmW/ZFj4n2LNaLby86E9uEFCRjw
	TEk84wZr0isGcPg2VwJ4txelA0azquJEFqIppXoyoQ==
X-ME-Sender: <xms:QKoOZutQTf6pL2xwAn05VeqTeo2UELGUcDGDnbdPiAESwe6Vld1Tuw>
    <xme:QKoOZjeyOGhsIKoeFhZk25cRF8EoXjpDqaGCg0gG0nFO88BB_Qq0AuViK8e0C3YzU
    sdrItBDiNnQw6i35Q>
X-ME-Received: <xmr:QKoOZpyjVUS3SCESUUmjFL9WNcsOnX2lGShViTiMGxRjf49DRibY3GVmQC16izUC3zs6Wrxu7WcKOUm41Fwx2P0sAjAzD1oM6hG9IhFQMW83eIh4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefkedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepjefffedvgfelhfejkeefteffhfejudfhhfdvtdevjedvhefgvdduhfdugeegkefg
    necuffhomhgrihhnpehpvghrfhhorhgtvgdrtghomhdpghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimh
X-ME-Proxy: <xmx:QKoOZpM9KGpbw9l2xysIcOj1PuZXXgZR_P_YHf6YflQtb2VnW8bJ4w>
    <xmx:QKoOZu8NPNQ04avZnsXM7Z8LAhVNYAJ_HvNKp14RuVHKTtuK_Fuohw>
    <xmx:QKoOZhVFUe3_zvu08lqKfnYJoYPUGaVY1Kr8us28AzrvPHAp5VlxNA>
    <xmx:QKoOZnfZpGeso-STrTtPX4YYdDF55f-F0ZamQG1gMAt065b8X6bwbg>
    <xmx:QKoOZuzGLKLu4g2y2XgSF7qoH4YDt86Oj92YvwzlLTVgPz4VSEcuEnrv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Apr 2024 09:25:19 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a3e2a529 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Apr 2024 13:25:16 +0000 (UTC)
Date: Thu, 4 Apr 2024 15:25:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	JGit Developers list <jgit-dev@eclipse.org>
Subject: [PATCH 04/12] ci: drop duplicate package installation for
 "linux-gcc-default"
Message-ID: <7cf253862540bdcbcf6928a9ad64dadddbc943ca.1712235356.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uUdhUFJHVRDUFupb"
Content-Disposition: inline
In-Reply-To: <cover.1712235356.git.ps@pks.im>


--uUdhUFJHVRDUFupb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The "linux-gcc-default" job installs common Ubuntu packages. This is
already done in the distro-specific switch, so we basically duplicate
the effort here.

Drop the duplicate package installations and inline the variable that
contains those common packages.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/install-dependencies.sh | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 7dfd3e50ed..fad53aac96 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -7,9 +7,6 @@
=20
 P4WHENCE=3Dhttps://cdist2.perforce.com/perforce/r21.2
 LFSWHENCE=3Dhttps://github.com/github/git-lfs/releases/download/v$LINUX_GI=
T_LFS_VERSION
-UBUNTU_COMMON_PKGS=3D"make libssl-dev libcurl4-openssl-dev libexpat-dev
- tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl
- libemail-valid-perl libio-socket-ssl-perl libnet-smtp-ssl-perl"
=20
 # Make sudo a no-op and execute the command directly when running as root.
 # While using sudo would be fine on most platforms when we are root alread=
y,
@@ -25,8 +22,13 @@ fi
 case "$distro" in
 ubuntu-*)
 	sudo apt-get -q update
-	sudo apt-get -q -y install language-pack-is libsvn-perl apache2 \
-		$UBUNTU_COMMON_PKGS $CC_PACKAGE $PYTHON_PACKAGE
+	sudo apt-get -q -y install \
+		language-pack-is libsvn-perl apache2 \
+		make libssl-dev libcurl4-openssl-dev libexpat-dev \
+		tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl=
 \
+		libemail-valid-perl libio-socket-ssl-perl libnet-smtp-ssl-perl \
+		$CC_PACKAGE $PYTHON_PACKAGE
+
 	mkdir --parents "$P4_PATH"
 	pushd "$P4_PATH"
 		wget --quiet "$P4WHENCE/bin.linux26x86_64/p4d"
@@ -34,6 +36,7 @@ ubuntu-*)
 		chmod u+x p4d
 		chmod u+x p4
 	popd
+
 	mkdir --parents "$GIT_LFS_PATH"
 	pushd "$GIT_LFS_PATH"
 		wget --quiet "$LFSWHENCE/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.=
gz"
@@ -83,10 +86,6 @@ Documentation)
 	test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||
 	sudo gem install --version 1.5.8 asciidoctor
 	;;
-linux-gcc-default)
-	sudo apt-get -q update
-	sudo apt-get -q -y install $UBUNTU_COMMON_PKGS
-	;;
 esac
=20
 if type p4d >/dev/null 2>&1 && type p4 >/dev/null 2>&1
--=20
2.44.GIT


--uUdhUFJHVRDUFupb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYOqjwACgkQVbJhu7ck
PpTTgQ/+JrA685SYo2UeRAWCVef5jGwaZ3RwrapKfh4WULd/5e24+xzaSJQ6VYOR
y1uzfJ4m82bwjFaJ+tICoIgUaRVcUKqhdaU0CwELx7q28qg9Pcw11o5cwe06y30u
DZ0somhCo+eTz1U530nZiJe/CEYh4m+rRdMHhwKvgB1g6vf42HdWtrnRyr1iuNVG
80eR37Dry9NLfJeQnZvvpRT9To170pHt5+5JZqojsYYyJKwwgOznKM48B2rj5fNu
DsVMJZrXdHbYCQNYkR95PPcsvERHGF014JlyNUZOMbu0TGzYoVrYwMZZjd3L14BO
Kvyi+uZss7iLjJhKrFbVPBcFusMG/bsp+5Mg6bbtn9MIyaguMxvosdp6C0pb7f9u
Vai7xE14p+R6/w/mFhtTPXfZ0SYgMVqu2U2eh39Dh6CLM9riza6nuZq5f+WrVaZv
XhLa9Zt1W3bpH3u1jYFPWVlh9R6c6EHqEqpzYlWxIhcG/mQ9PgG9Fo/ftnIcX3Ts
tESVCPJcAaG24bST89wV/w6/FQI1rM2Wi5VJ5BvYF/t+AO1CeZZ8bEbBthJp/QXt
sSMmnqlxlkLDtP8m6sT44+a1TZuOht0RDQw9teA+TEXjoeeoMfB/DwAkHWHcN9+y
2Ob8bzE5Y5n7i9yac7daw/VzR/KU2kgMiEq8wVbtStzcevqsgNo=
=T3aJ
-----END PGP SIGNATURE-----

--uUdhUFJHVRDUFupb--
