Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD85E79DC
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 04:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712897058; cv=none; b=arrSAanrhk3nIxEbE5EBq545ikY4YsP/MGj7ZdDN/wR2ZPCWDMDSkXwFjvnAgbyNxUKB5VNdW91DneRxBJFSiI1XqhtcBR+Zk/ktAinF1FwjkurEzt0g3JOqDQt2Udi4lEhEwx+NgKNWhbgDBTVS0o6bsTLZa8rPEIC4mqkDMX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712897058; c=relaxed/simple;
	bh=mB8bRW1DwUVksyvLaoxZ3hHFGrhOayMCXJCeRpbyDCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYki4SzXpmaT0k/d/dlVNo7f1jGfchmnpdv8/3OXD1AySrlfCjib85458QjS0J0e2gEjRWAiRvORAuq02UraKFUC5y1bpBB1Up3xAcNMe0r1HH0Trg4m3f0/RaLrkkvorfuyg/4rD5e0Roisdyols29bvB7Ksf6NHo+gJvwYSpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Yqrr4KpK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lJ6ysOhN; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Yqrr4KpK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lJ6ysOhN"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id C119313802C7;
	Fri, 12 Apr 2024 00:44:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 12 Apr 2024 00:44:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712897055; x=1712983455; bh=+NI+xjsE6z
	BNNMO4GEDFkhk63uWNpUIlEEB2b+S4goU=; b=Yqrr4KpKMjpXILqmzekYjChbS2
	H04nJO0nE3T8p9J+4EvEiQNAX6emJqxD4F2IoRnHqPugfRsDGptOiyH3f9yaElpI
	hrzz2FblUGLw35wYUYqaL/u31pfrJWiFhFsy9e9ioMo7EsRCkgn5KYygUqE9Yf5L
	b1zXnhHbdd3AJKXxXQEBoq/3hh36ViroemEnxFbqGjd09951twyzsMwSLvbVDj3O
	li5ewRVGNYg1/1Ub28ERyp7IwxEinpA2puPabXR5yMOFs9vU526wRg5Ef8bOjgR1
	6WPlioCGMvJSpQ5BSM3i2Ko5C/+N3ESjR7r7ZbuAWCc3D3zpX7tn6IL8bJmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712897055; x=1712983455; bh=+NI+xjsE6zBNNMO4GEDFkhk63uWN
	pUIlEEB2b+S4goU=; b=lJ6ysOhN7IAjYc7VADIJXRvmIKoUYTcN9y+aN9cGkeAT
	ARRm2ge/4D0m7ZMzW5J1JwIcgBbBLWsemuHr1rYldk6QQeWtoufnCBxhSi/OJq6y
	d/CWoAcHgKinkvB8+pcqiw8KrXRJTmFcUf2F3CC+Zni993G+f1OIpsztVS94srJ8
	W+td9CM7HmgDna6IzROSYmsyQIU1E7vtwOffLv4wZzMp6juBJPF0WyHLli0RFa+D
	y8GF2RyrxAPaEii0GADyLHhjjWRJq6A1Kb5MTs3EZW6NEa/Cy8+9GaIPK63TknOI
	wvMOjcIpxuqGGBa9Ok0IzUzF+7sehWAEdjGVFhDrdg==
X-ME-Sender: <xms:H7wYZv1xXwkOkv6OyhwrH-7OJbjN5NAspgXowayIT2Ircyqxt1fXwg>
    <xme:H7wYZuHyPoEU0A1dv50rmIxZFywglP4-utVN10wgx0HH1febxeDBY0ryBOVWnNLwG
    YAyGPdgdLyJH6jl1A>
X-ME-Received: <xmr:H7wYZv7nz5K75-A2nnAF6A0OKRN03JTbA8gbna51NBTgTtJi6CVm6jN0DnJ6PQWFgcGgasXRbq-0uHkklUgVvklqKA9MBWwSvL7mW6vhXkG8F2L_DHE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeitddghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepjefffedvgfelhfejkeefteffhfejudfhhfdvtdevjedvhefgvdduhfdugeegkefg
    necuffhomhgrihhnpehpvghrfhhorhgtvgdrtghomhdpghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimh
X-ME-Proxy: <xmx:H7wYZk1n_7M6MTxuP6Jc16NxVk5pTsf8n6NEgksvpEmkxP0wDSfcZA>
    <xmx:H7wYZiHuzVf7jlx8iF8V02gJntqYBg_6XULaIOcoFDChWJ5iOVo6eQ>
    <xmx:H7wYZl-m8gshY8U3CDnOWv7ayM_RFTpjA7jBcq98pfrqzrgso4G_qg>
    <xmx:H7wYZvnB-0v1szhiutVE5Av4PgvOJpKhNy6ZL0Szwa_c_51XpTVKqw>
    <xmx:H7wYZl33Pq_4TpgVfxi444t8PCUMy9FMv5YDetu_GcUinadqgZeXOX-d>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Apr 2024 00:44:14 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 40208adb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 12 Apr 2024 04:44:00 +0000 (UTC)
Date: Fri, 12 Apr 2024 06:44:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 04/13] ci: drop duplicate package installation for
 "linux-gcc-default"
Message-ID: <8e58ce38d9a8a9465d172d3ef091a7a7cdde3393.1712896869.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712896868.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nkLpvfycj7nOkaXw"
Content-Disposition: inline
In-Reply-To: <cover.1712896868.git.ps@pks.im>


--nkLpvfycj7nOkaXw
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


--nkLpvfycj7nOkaXw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYYvBsACgkQVbJhu7ck
PpT28A//S4X9/X6LPXOG3FItC25NFlRVnrTNOvyElXcnMq7VtDpNG7sRMLCAMJHH
6P4W1FGloq5GKZQoDXOGkCGlMsf1QKS+MPufszSynQdRFhKpl1jKOqYaZXiiTjKz
POlRmQtowrTH6Oc8PxG7QpwoUzvUyg1YWC+YipxPL3Trb1W5tDEiAYdw8rh3Ik1z
AgHCwRKBXnS4ul5CrmFi5QnWV0F2rbgfDmnPLH3icq/AHEWB48fMDRbz5YfTGxVQ
/V+FB4mGvtNf869rPmcas/Q8ARbuQcFJ53dQQ7fYeK7XBs665h9xDKARuvdThiVb
Ya0Abx/454Pyz/NZIsiXyS7zZqyGL6v/y9xfj6FY7dpetlrWThL+I/gJAG+iG3Uq
D3zcbzqg8OYJkKiLWib71YzOxmHY/trA6mlEV3ljiArLca83RxumDMkTkF7hZxQ7
In3E2TKM9qc/j0XfSN5dWTeW/M2IXtYjKAE5A08ZNBCpfszgfX2KW1k+JHtglKQd
SEs42KzuDKnh/hCe3v021Wq4PH7CQ1oXcQYGv4VaO36y9aA6FSdt3eob7hCqbjld
cCG5IBQTPR9DdqLtBRWoOObjS7PIkt4M/SSLfXklY4jN7q1rmOChEenWMjDAKWot
fNp5FKyhdZbC4pQufOxqznzw49M5mnfTrSk84Xw0l9Z6y0RUCqQ=
=AJTd
-----END PGP SIGNATURE-----

--nkLpvfycj7nOkaXw--
