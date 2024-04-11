Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E79144D31
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 09:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712826620; cv=none; b=RXd8i+zSY6oKLdBnugXQaOuQ4gJHECBUexNaxz1TRlWUCU05eThOWVaHGIptTm/WCS17ihL9B/Bg9WHO4+8VohvZtW81B4xlfpfY2vI6v6DIeOH0IEOuu5RivgINQkuOWZ24sUhd4tAWUoNZn3HO/tIMD2f13+kNkAox/f5ktS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712826620; c=relaxed/simple;
	bh=nseXqVENMM3XzCwMOSVcx0kVoNDTCBmsh+pvS+q9Sa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFyIIG3k8J1z0lqy9qmqvQ/Co09KK1LuXlP4neQp2D6VcfnsTxkrq3FOl3+P5AaJVpHF07aWQUqI95QuvtBxUSahN9PMCyxMf84ZLwlUfCERgMNaYhHge6ecy18XiRdBwF7gStwOfDxqVgn5kH97r/uHpf7GSouksed/ieJidnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Js2DX+Nf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V6obZONg; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Js2DX+Nf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V6obZONg"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 9EB581140179;
	Thu, 11 Apr 2024 05:10:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 11 Apr 2024 05:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712826617; x=1712913017; bh=W/z9YvNKef
	F1G0bbY4msHe69GC0GyoP3ZIwDYjjFLw0=; b=Js2DX+NfdLgjmYXhIBPknJgZ7k
	tXLIvrjR5AnoVscvDMOxXHFLfJyjxxApILk/vZ2CiQKbbxy84z5WUdcWtVaj98CT
	74D3fmmWeVGjgUi8ANJxSDpR8n34RGnLzenmwx0MyHAMR27PIwNFBk3OvLmxFtqQ
	+3GOzhjvGeZH8ePFRg7klpgI455umc/CFmkFMQJnoT8s2ddIa17K1XB0RD86le6G
	jQ63G/8SoC3D6/9hd/AFSrBOz/tEgPCj1VfhVfSCw3uF7z/hgPMVqgiZD2ZgfTH7
	IDIv02prOeFMnITUuReJBKxgyaEYBjRRkBlNd/9z5TWkh+s2BcJ2GS5ttO2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712826617; x=1712913017; bh=W/z9YvNKefF1G0bbY4msHe69GC0G
	yoP3ZIwDYjjFLw0=; b=V6obZONgQw2yTeTMj4f/suFM5hJfIhXnfzNlmOrfGS8t
	QkhTMLWCYQ88aFcbGfah6vuhAh1dqV2j0GoZdL3Xr7IJb+cEbu1n/fbza2oHDS/D
	Nx3v4b2xJOrq1Z29UA6fKZeWAM+/zbv05YxDpigb8Sca32aJm31Ft9EgnggXcrgX
	pRKAoNOWJ1XaVqFZgnM7yj1Fh+vpwnOLuDBhzUQ/Flne+MnDxt0PeuRh2qbK2iaD
	ytC0JV3youtlAW3WEpkT11X7YysQ24Mz1rVMYAEc2YJl2AKsZEIL5+eZNhT9fbz+
	IhyIhg5U0tBGX8NQQmpIDxTe4+fmsX31ggY1rnKeNg==
X-ME-Sender: <xms:-agXZgRRlwLeXsnzdHbox5kCbB5Hz85bCB-neP9YSywPo1o_UTal4w>
    <xme:-agXZtwy3XxOx9xnR-WScT601qwvVjOhn14x7jcwpY5GFNtUJ50LGkZb5WkFf2cPk
    PMxpGnnowkG18dhWg>
X-ME-Received: <xmr:-agXZt2nEIj-WrNx6aEN3YkmYEZdwao64T1cxh-thPNbD3SVbLyVVfBq-pr4tCRbP4PnoFS18mtth6hkw--xZJz1ECJlMaMR0KF6jGBwSanktdue>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehkedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepjefffedvgfelhfejkeefteffhfejudfhhfdvtdevjedvhefgvdduhfdugeegkefg
    necuffhomhgrihhnpehpvghrfhhorhgtvgdrtghomhdpghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimh
X-ME-Proxy: <xmx:-agXZkBzh5D9O-BJ73eMmHbCHWczf_b4t5HN-m3TJw_eveVoo4dDqA>
    <xmx:-agXZphWezayd2JlVL0T_3kPSPr48rp2FVfnBnxMipCqBTrnKluq5w>
    <xmx:-agXZgoLVydCX2VAFIrZi8TTmzV1Ng79uXToV-rFnsSdzFrwP7K77A>
    <xmx:-agXZshA0D_DtKjMC1E-tl4fIO8TaR8oHI27PHTJ2SePEvPvFt69Gg>
    <xmx:-agXZhgsqew0r5d7rgoCW6l9RiVTxytw2_rP1e4PXH_pb9bvUOBZHdX7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Apr 2024 05:10:16 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 9593c9fb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Apr 2024 09:10:03 +0000 (UTC)
Date: Thu, 11 Apr 2024 11:10:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 04/13] ci: drop duplicate package installation for
 "linux-gcc-default"
Message-ID: <803f5020e04da1ea84691a63e97afbc8b99bd3d4.1712825204.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712825204.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UyVQpbJc5lg0Fws1"
Content-Disposition: inline
In-Reply-To: <cover.1712825204.git.ps@pks.im>


--UyVQpbJc5lg0Fws1
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


--UyVQpbJc5lg0Fws1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYXqPQACgkQVbJhu7ck
PpSkMQ/9FYfIKKY7xddBzFsZ53RsnyQ12VJKIE4GzuM+07ofputTNz2B0GLANaXu
ziuuAIMWUFcp/iJf+/aiDSE361JjnxFA7ctaug7jn2b/I7gWBbm158C7woh+HCz4
ZedmlBslLoMyEKurex1JIbUkoWnslEzPZ9s/3txEuRvWGiyehKB3Yp0Um2Sufuq2
w9QPk6Kjq9wJvBu2mB83Ksclet4J165mnaQgicMtpVwr1tjGKvIyNOrvZQZZDldb
rmmRMtLcgN/AoqY7Qr5aIT+vWaDJgsLWDUn/J/yoLPUi9Ov61wIl1DQ99BO6Z+4L
jbPm1d1ABe5dPH5UvZkfUETiJNrdDFCiFlxg/It6gz5qEMoLU6zLPRXwYtoB6jWT
sXEC+fu9SzTMOmImWRLikFPvahtjgp3h+AkXZUCLD0gKjPRwDgYMEDnXnp3J+XVc
6XZo/I39wTKQ1UHbeqNnBctyj6fAXqsm4l/Zm3FhFGSvk1+zPt6PvZpCA+DctD69
vATwqYAfYkYrGBvwul5EQYurL0LxPlhRCdRn7DlzcHknFGbgDzUOB3qNGAcaEume
VaYUm2929N1Pz8S6u/ON/SabWCuGUFyHTMzNsX/GjAQTap8MAeQMrr6Spk5IIRQm
/efkjo885nt/JhVGxHuTr84BqBIRNEmUu4PTVPABzEvxqUAnC70=
=YJ89
-----END PGP SIGNATURE-----

--UyVQpbJc5lg0Fws1--
