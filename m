Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524411272D3
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 13:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712237145; cv=none; b=Y7rxvkfCv05qOB1Q5lozYlGuIippOSwhUUixh4M9ZyRhAYFYRb9ng+cIE3b9LChCQd6cPlEa11PK7+2r0s/+eBnF2f4cAoNBSdiTwG9+/L7G2eJreQuF+kfILxcnWtlaMuPjLlXsV0DNoJ1HoNK+lhi/LMnM8Os+hCfJXYDnt9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712237145; c=relaxed/simple;
	bh=9Qq4YFDE5S0UalniQB/cI7C8kpCWiLqi3MOsE2ClFjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzrxTfYa308iSBdyggVnEtL4synlNUpDUt5367uqOAwc0MsV6YnfapvYYmUAtk9ugFiAfENTK7LKxttqoJNBjQTPBRnRfzRuAWoK6S7+QISCSvhjV+6a9w9V6WVAfXYqF1kqyXXcR/a1jzW/BhXiKKzh4cCJTrjf1Z1AXUBI+mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KdeC2k4d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I+QCnqYZ; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KdeC2k4d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I+QCnqYZ"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 81D1C1140127;
	Thu,  4 Apr 2024 09:25:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 04 Apr 2024 09:25:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712237143; x=1712323543; bh=kQzd4l67RE
	S9bBBtaKYQiJmUw3wcCTLjmrVOGVA9hbw=; b=KdeC2k4djDjfUZDoax31cbAz/P
	p4Wa3WT4qHFQ/r5Yv4g3MlvyEJcVUOmgYHmzjuJb5k/w1m8Ffs16429N5n1hsimD
	IbBXTExFHhX1qe85kob+Lsl0GfZiBB6DcxDtH8nOgZRxY2u5NC3kuDf/fvyamAd3
	0Bcqk3v+s4G4oa+7aiwOdoGFPP0iCsnKaJ+Wl5gvBBdorOzxde3K3j7q+Ioeyhac
	fkKu/ubwVFAwbu6ISmwK5IzNf5nu9shjL8wmESsSd1T1jLJDjXzEmVFNtTSpp9Jt
	j+5hj3sXInKGVPdUwZvcwI/aTqH5jxH252A5//FRrdAPzSDtciqu0tBD3Jow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712237143; x=1712323543; bh=kQzd4l67RES9bBBtaKYQiJmUw3wc
	CTLjmrVOGVA9hbw=; b=I+QCnqYZlq6LRIt+uAb05nwoeJGvcA5gH2kZ8b8wgEGF
	/wzduOhZM+5CsecomlHQZjeiR4QdjzvYIeFK8YtLnHBe1BdWwkWwnX4s6G8cebe5
	NEAI2ZhGPTsyM55/D6VDE79eog+w4DRBN3QcX2H4C03QUeGcPz69pj9mKSX6kIOA
	3DdCBdub1KmSjJ+M7qgG0Vgfk4TG5cvTU/zImulIZXMf/QY2BJ/2hcvASvctQIba
	meqd8lmYV7dDAOznc5WOHrGavNLSDrkLsheLn3CvZqMCIDWzoI38vftS7dFFdtPE
	5nIKSojZ8+0Hs8dxkXTFP+3QJ5qTBuVAeDxo2eZzsg==
X-ME-Sender: <xms:V6oOZolPsZy3JnWSeVgn9vvYRkW0A8xWX7J8tg3lFKmSw_E57M9XdQ>
    <xme:V6oOZn0PNm3PYWS0s2SyA_o4Y0CmZ_yCejOIxpvspLfmGgCj3EwwCYVo3LO4tMHi0
    9qyxYVQ3A5pSaSabA>
X-ME-Received: <xmr:V6oOZmo-i7Zu3GxqISLfPrI8lRhjlOwCJ0Peot7lVKJ2Wo1B2SxCeB9wxuF9IDHZwhF0DlDppcUh2PLt79Ps19vuN-Yio70CdI8rB951LE-y37rH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefkedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhephefgvdeuhfduudffuedufffgffehgedugeeivddvjeeugfejudeikedvgffgteei
    necuffhomhgrihhnpehpvghrfhhorhgtvgdrtghomhdpghhithhhuhgsrdgtohhmpdgvtg
    hlihhpshgvrdhorhhgpddvtddvfeduuddvledugeehtddqrhdrshhhnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:V6oOZkk7-I3NOB3K8xDMdUQqvLx7LPXYUmKI72IgmXqjzrrftIamRQ>
    <xmx:V6oOZm2YhKlByUaXLOw7mqWS1laHvkGZfMwveibhYBm0INdlIWLwgQ>
    <xmx:V6oOZrtwydk9ex6ULpNwXzqprlMdgkXep2miC1ElfLc5t32seWozOw>
    <xmx:V6oOZiWTDj_tKvUVv3q5iXou8g2Bep_zsPo7uhp3CRWYFeRZiYhNqw>
    <xmx:V6oOZgqpJUF_5LF-lAZvET9h8C_5OTKTlYVuNFZfj0orjC3entZHuTnx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Apr 2024 09:25:42 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 22e63603 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Apr 2024 13:25:38 +0000 (UTC)
Date: Thu, 4 Apr 2024 15:25:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	JGit Developers list <jgit-dev@eclipse.org>
Subject: [PATCH 09/12] ci: install JGit dependency
Message-ID: <1deded615eb7a26c3a4a47707dca6942a8a1732b.1712235356.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QtKb8SXucXn+Ovt/"
Content-Disposition: inline
In-Reply-To: <cover.1712235356.git.ps@pks.im>


--QtKb8SXucXn+Ovt/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We have some tests in t5310 that use JGit to verify that bitmaps can be
read both by Git and by JGit. We do not execute these tests in our CI
jobs though because we don't make JGit available there. Consequently,
the tests basically bitrot because almost nobody is ever going to have
JGit in their path.

Install JGit to plug this test gap.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/install-dependencies.sh | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 068c478025..3fefe134ea 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -9,6 +9,7 @@ begin_group "Install dependencies"
=20
 P4WHENCE=3Dhttps://cdist2.perforce.com/perforce/r21.2
 LFSWHENCE=3Dhttps://github.com/github/git-lfs/releases/download/v$LINUX_GI=
T_LFS_VERSION
+JGITWHENCE=3Dhttps://repo.eclipse.org/content/groups/releases//org/eclipse=
/jgit/org.eclipse.jgit.pgm/6.8.0.202311291450-r/org.eclipse.jgit.pgm-6.8.0.=
202311291450-r.sh
=20
 # Make sudo a no-op and execute the command directly when running as root.
 # While using sudo would be fine on most platforms when we are root alread=
y,
@@ -39,7 +40,7 @@ ubuntu-*)
 	sudo apt-get -q update
 	sudo apt-get -q -y install \
 		language-pack-is libsvn-perl apache2 cvs cvsps git gnupg subversion \
-		make libssl-dev libcurl4-openssl-dev libexpat-dev wget sudo \
+		make libssl-dev libcurl4-openssl-dev libexpat-dev wget sudo default-jre \
 		tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl=
 \
 		libemail-valid-perl libio-socket-ssl-perl libnet-smtp-ssl-perl libdbd-sq=
lite3-perl libcgi-pm-perl \
 		${CC_PACKAGE:-${CC:-gcc}} $PYTHON_PACKAGE
@@ -52,6 +53,9 @@ ubuntu-*)
 	wget --quiet "$LFSWHENCE/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.g=
z"
 	tar -xzf "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" -C "$CUSTOM_=
PATH" --strip-components=3D1 "git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs"
 	rm "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
+
+	wget --quiet "$JGITWHENCE" --output-document=3D"$CUSTOM_PATH/jgit"
+	chmod a+x "$CUSTOM_PATH/jgit"
 	;;
 ubuntu32-*)
 	sudo linux32 --32bit i386 sh -c '
@@ -112,6 +116,7 @@ then
 else
 	echo >&2 "WARNING: perforce wasn't installed, see above for clues why"
 fi
+
 if type git-lfs >/dev/null 2>&1
 then
 	echo "$(tput setaf 6)Git-LFS Version$(tput sgr0)"
@@ -120,4 +125,12 @@ else
 	echo >&2 "WARNING: git-lfs wasn't installed, see above for clues why"
 fi
=20
+if type jgit >/dev/null 2>&1
+then
+	echo "$(tput setaf 6)JGit Version$(tput sgr0)"
+	jgit version
+else
+	echo >&2 "WARNING: JGit wasn't installed, see above for clues why"
+fi
+
 end_group "Install dependencies"
--=20
2.44.GIT


--QtKb8SXucXn+Ovt/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYOqlMACgkQVbJhu7ck
PpQW9g/+O7x+vmNq2xx3q7DVVxwva22klU9J2nTMaWJLoTNKLdBZIseaULYw1jHU
7ANzqzFEpy/Gcat1qtr/YqNiDHnQ3ffE887LC+cQiHJs1w4W6ynPvduFkoB/oVZr
tOLsL5uYdeilYrg+Rg4gnaMoLG+0W7LG4xQayLojoLsQAaU8qvFJAb+tMox9iWax
HwZyddRMkiobOV14dPHeeYJ8BUFq4ViUo9k5/tpe4Y1X+5jRWxqbqqA/BNyabZ6t
CdRbYGwX6SrzXbgSBKq479chg3ni994cCKMM6CpbjITgCWX+vEBYlmFonzMb1kDW
PGkIifWuWlgbgG1j8XQRMyzYJVCn4E9ZjZR8RxphN/pr1IcI0SdH4+4zNxphL99N
4FSX/Oi5+LIwFfwbTO04Lv03xdT2R8T+XHMMY6fnwxWMn0pB+aPS/g+0GOG+GY0e
yK/o3J31t54wFug/7sK5w5KqD+HCd1CayJ+vLy9CfpNhpgS6L2RVF+RSlyO+F+Wx
bU83ioFpMx0HdLjI0dtmvZBZ0VwTA7USgHJrUwmE3N9qXIjY4sdMNY/jvqeKBcHx
CkxOMlUozA4h8Br//0NxS+l413Phk+fxqNb9ylniXAuHyGG7iUlXW5QfkXlrb3Me
AbZo3qtuNipyZmowb0mFRyCdNjAl4d4Bgyr5GLLYuU09PoitLp0=
=WzFt
-----END PGP SIGNATURE-----

--QtKb8SXucXn+Ovt/--
