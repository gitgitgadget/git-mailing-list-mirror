Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8292C683
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 04:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712897089; cv=none; b=VdfcRnxX2bH3+XE6JcetTB1tRenFJa9ztH+xFsuPFxkv9ci6sWvS7VXMd3QS1dv2V9tJhIfMx1MBYEGhZVkXWJWhAmYgvG70CQyjPIeUk4Jp+YUDj11D+SV1jSPt8NTejXsiPetl03TKuBmzJdGNDBHz4NjsrD+/cO7uIDr9rX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712897089; c=relaxed/simple;
	bh=DljDrVpUABrOe0yHe5XQ0SL53isAlI0KmK6mdOlG4bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQfBbCUi3fcgLXjulEdhJy1H3BYkYYm+46v4Gw7SN7JQwG9z96eAS/iPCGDu6vcARpuAS24c+GT8Qlg89ofl5Xeq94qybHqZNLSCzpzw+L/QajtYXytoTMmraKX6m0L0LqogQH2OsGG+JLNG8N+32IHhU0n4gwjgOga98+pdDa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lo1kiRt6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vX08ddSy; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lo1kiRt6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vX08ddSy"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 9728713802F7;
	Fri, 12 Apr 2024 00:44:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 12 Apr 2024 00:44:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712897087; x=1712983487; bh=KrPyBTVgUa
	a4ZoqE4P4uAbirfV+Dfim8WzSQGlhvITo=; b=lo1kiRt6848+9vCB8Zb4loy9u7
	xLRKgL0+blSK7fc2DNl/qocjzc/wJjz6hi1FHMMlLLF2PnC3QcD4T03jK8QCBshE
	m2C2D/KjSFsMV+1KHLM74Ywc+KcV9ZCPq4k7NyHB7saE5o4Jm7Kouq9786oCzPoG
	sgj0pJbHJ+8uWyFLRhjVdd19HOM2aliTl/Mc0L9cTlO5C8jOiqyxWWm/fcLLLdZK
	I+bEf8V/dJuTtX8tbQ4Dn4v5Vpg6cA1C1N98LLwS5VrITq4UmW4FL2aWeGSIOQ9G
	dT/mPbGFuY/TznIiuo/f/3D2/T8fAljTzfvNSzsRXa7XWYVDhz5NZvuyFGHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712897087; x=1712983487; bh=KrPyBTVgUaa4ZoqE4P4uAbirfV+D
	fim8WzSQGlhvITo=; b=vX08ddSylxPDrd9G20AbamQWtNk6ecELFNwG+zsWvxAZ
	IZRo53CCvo6wLmuKajAqy2GCamNC7PMBUD2m7ZXw+VQToflbQQ0Ab2M8qUUsIW1a
	ee3DSDJaLUJe03RQ//NaIHO5Zc0siUdZHf+470wlTCE4hTGSSrXhQK71Xfw5w7Qs
	oNkbu9kpiDLv4+3hw9C4gpVtKCnytsYZFO3Vo/m40Qg8QGtdFjgv+navX/4b5zUe
	g6V8RsmgfWudeDfVINbNcrT3pPR0wuFeHmmE2Fu56HYU6GmkuKAUtklhKqGd8gQr
	OUpXAkswtlyu2A4V5c2e98rE53GZfnqjIBZr+iXB7w==
X-ME-Sender: <xms:P7wYZjyBQxdkJeaK5bzK09Bw0UFgIY_Ys-QPjhtcNVUzoSntcodA6A>
    <xme:P7wYZrQKIAFLpg-TSnK2ECh-Wep6BHZqTK5DuYIVl8godULVSea8Oj4Axb14tlSRv
    LeSiLSP1TxzChERHw>
X-ME-Received: <xmr:P7wYZtWekjHqwanE9WcDkPNRzISETSvP_1qpFd9wAkrxKedNK61jLKzEpmnn2BNj9wBIZYwBQTD_YxqUgViWBkUtEqTXD3gJDa9-V8cZt0gIRg8z8og>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeitddghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhephefgvdeuhfduudffuedufffgffehgedugeeivddvjeeugfejudeikedvgffgteei
    necuffhomhgrihhnpehpvghrfhhorhgtvgdrtghomhdpghhithhhuhgsrdgtohhmpdgvtg
    hlihhpshgvrdhorhhgpddvtddvfeduuddvledugeehtddqrhdrshhhnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:P7wYZthqYD1c9pdRhMeTWY3jeLzSO2Y_Jps3yVFPsVp5YvUqfcvSug>
    <xmx:P7wYZlBSb81xHnxiy_zuMkpcnuXpNT6Oowav_NX-YO41d5CGMKOuHg>
    <xmx:P7wYZmKIAD-lyC1MSSsKMmH0tcPsEqRKmRJknN6AacQhpM4jiHHIUA>
    <xmx:P7wYZkCvt3Z41vzXN4KGVMZ0DrEdYGJBdtCFdatXAbp58s4S_DaYKQ>
    <xmx:P7wYZvCpMdVOBf3NvZoQf7oFSsbcojNY5hVvkuwq3RpT1Sqh9aEmT8Og>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Apr 2024 00:44:46 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 545b68bd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 12 Apr 2024 04:44:32 +0000 (UTC)
Date: Fri, 12 Apr 2024 06:44:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 10/13] ci: install JGit dependency
Message-ID: <77f6d6ecaac037ad03b8e93ea392e0270bad9e45.1712896869.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712896868.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bVSIqIcLX6auh3Lv"
Content-Disposition: inline
In-Reply-To: <cover.1712896868.git.ps@pks.im>


--bVSIqIcLX6auh3Lv
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
index 0b9bb686d8..c196e56762 100755
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
@@ -53,6 +54,9 @@ ubuntu-*)
 	tar -xzf "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" \
 		-C "$CUSTOM_PATH" --strip-components=3D1 "git-lfs-$LINUX_GIT_LFS_VERSION=
/git-lfs"
 	rm "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
+
+	wget --quiet "$JGITWHENCE" --output-document=3D"$CUSTOM_PATH/jgit"
+	chmod a+x "$CUSTOM_PATH/jgit"
 	;;
 ubuntu32-*)
 	sudo linux32 --32bit i386 sh -c '
@@ -113,6 +117,7 @@ then
 else
 	echo >&2 "WARNING: perforce wasn't installed, see above for clues why"
 fi
+
 if type git-lfs >/dev/null 2>&1
 then
 	echo "$(tput setaf 6)Git-LFS Version$(tput sgr0)"
@@ -121,4 +126,12 @@ else
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


--bVSIqIcLX6auh3Lv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYYvDoACgkQVbJhu7ck
PpRxsg/9FEFq0W37y9DWq4vckqSyDTJ0M2Vy6E2dj6/Jn7GfBgllvKbAIy7/0se4
cOaqUykdzAK7OOqxrjs/Iy8h9Cf4BM69YUoey04yOPOg8LDkuOJH+mhILYnn0ZLC
5K5WCHBo79pPiBC04+YlQGJanN1tQJGHI4jMX82tCWkhc8tqeLQO6mRVMSQBtwR+
FrU42Z/zyxDTwocmswzCMGd4wCZgzzHNCsAystmTmrVv0Q1bHRdMmxQtR1k94xFH
DAbpuufF1WbN/TvgFKEPYhvgENWbH18qgwNHbFMvDmnt+aQp5BAfnhy4NmVjM72g
lDp2XDDOb8kTKOJlYp4ybAtblXwQ8p4puSFdcLzqWO/96D8hgNOSel0YMh6uC876
87lrUF8HbINMy3L1JLKldSmxo6mYVFdOKsEI1OT+jmw0KXg0/ABL4rpW7jFct54o
rCAEdlcjRsPQ1zV7bIkdN55KtHWS5D//417dbvG/gKPy4X3JZIyg2XzQ/8lZeU0R
cMWRAzLsm4Dwz4xRX1LAD8ayLd36rNDvKPRoexFC57ck1LfOHahveOyfo/shHKDE
k+AQNAm1IsH8vHcyWehJ2zDWW5NtNHOx3dSDhSZJVx94uffMVIxg+mfG8GaMEBWt
eKRP1O5fz8/JMmG47PSxu/H1rx241F2vehemXjiI785Cxl5uFvE=
=1r0j
-----END PGP SIGNATURE-----

--bVSIqIcLX6auh3Lv--
