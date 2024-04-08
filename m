Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E569925777
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 06:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712558817; cv=none; b=tu4Ifk6daV5ScAlfCmmkrbzgFPxtngEC+bOnFdmaP0wTsjIf5jMpw1fvKhFvvetF0HzkoYa5FrTfqEWMuEAlJDwrqwvqpIE+F6j+V9psX5KWvAmxckukEJIqIFTQsMRlWBchMAhM/oQ6914QFbzI9ZGn2GVR4WzwHhxi12BFvTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712558817; c=relaxed/simple;
	bh=86WuSIssM6M5d3MGB2m6CxP6jowRS2rFzt+yXGL6sCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2tIDVSj3RHdFNc5HtorXVKl9gT31K0/AXbNd/2V4/DsFtYU/INrDsrEnJyDby3TEjoJL+h4OkEGkNrjR50xNhBBbCopk1Do7jukZg/kn5aABp6p9BqeWZCPa0+rwR2JAlkjKDE0gfw3hApA6Kycmj96SBsNmkC+hry+W5KGmfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X3LijpiU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XHU4+GKn; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X3LijpiU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XHU4+GKn"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id D876713800A2;
	Mon,  8 Apr 2024 02:46:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 08 Apr 2024 02:46:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712558814; x=1712645214; bh=PlZ5HVSDv1
	dOlxpDgeGaLBp1pAFdUJQSDS0aA058yaw=; b=X3LijpiU+p9plTxjNfH0dYwXr9
	63Mra40Jpt4OfLecT/HwmAEcYGjiRc8AX6si76L1HDPr37vELTA2AFkIWhW+2sKs
	myH1umC+H6GF0RP4k4PKXxbPWpctXaoGgAcFT4dKikrLKr93Nm8PED6tSm2ngpj3
	9b45i6sGnyXP/H8gcHHRd7A2v9GtjVUkK903sNA5W5wgOOFT91tT29SJy/yvguNb
	sb8ETFQL4R5E446FnvjKFESMQJMplhDRP/VjHKEXH+/56CfdxS/2HeFXXaCnIupb
	pvEvPbKFoNstAGUvCgCwc306udqu0Late0OzJlWKt7nPHc1+zkrYRjRVTwZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712558814; x=1712645214; bh=PlZ5HVSDv1dOlxpDgeGaLBp1pAFd
	UJQSDS0aA058yaw=; b=XHU4+GKnf0s/KaFIkIO5Y/zL8XtANbanXX8tHF8BqdD5
	wutPWPVnG0qz5Jd4kZrRzo7FMj/9LAnyOesrNLtjCbztUD3IMoav03oTGZBMzecq
	HKsc+ZQ9IweaZ5Vnc5BUUgqN1H8/GNlRPkKvSl9hlUVk2yrvTVnbQYyQseAr/gIr
	oPLnY8Vyu3C4113llZ0lfVgfZ7+GFsmIRowkgWlYXZfbudjmk0b1SatPq1SYFQov
	ErkQoVFgVccqPNyU90S26gcJEYhNtYg8MOsdIwoL75b5+JRXmuTK0qVtwoVb6hCE
	22xD3x0Dp3UoymhESYzmW9MwChE1n8kd3gVZqLDM4g==
X-ME-Sender: <xms:3pITZqj6cazTeJHrGN8Ya7RhQ4v1w6IIvgWvQ8d_BtbvA-ezk0x38A>
    <xme:3pITZrDFkN5SoBnsBkNh_3CXnfCGCpu4Te_6f7g1HR9n47BtN01rDS5zzMamyQwh5
    xGoKoGZLwbkHc3_lA>
X-ME-Received: <xmr:3pITZiGk4KpK53NnKs6-QU4xS1CplwovjZ-MBowfiQNa_Cqysq7xuESRJJjY66fiAXBDs-c2oV2uiTVuTmX42ObhPfvELu3WrWWuhgSnOWayrP6lZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeghedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeehgfdvuefhudduffeuudffgfffheegudegiedvvdejuefgjeduieekvdfggfet
    ieenucffohhmrghinhepphgvrhhfohhrtggvrdgtohhmpdhgihhthhhusgdrtghomhdpvg
    gtlhhiphhsvgdrohhrghdpvddtvdefudduvdeludeghedtqdhrrdhshhenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:3pITZjT0asZZ4N9E9CeEt_V2Z6nBKZHm6dKdKApH1GyzIH6y7heQCw>
    <xmx:3pITZnx2JAckpFiRXxFyfemZcGk1RgtTmPxygi5KokBCmvdMcE9aNQ>
    <xmx:3pITZh53MBCljQ7dkPMUmWD5Y3LDNGWjCb3k20p1HAwa9lz7KZQslw>
    <xmx:3pITZkw97bXB_lOl2wya6ckYyLdaU3EbNS3s-F2plLgm2KRPCa4jwQ>
    <xmx:3pITZipv2qUVvo3S_rsEPnaP6i4mx2ATmyqg8RkL9uvEztnRCD8WAhmY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 02:46:53 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e1c30530 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 06:46:47 +0000 (UTC)
Date: Mon, 8 Apr 2024 08:46:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 09/12] ci: install JGit dependency
Message-ID: <29ceb623b9ec6a1d5b289c5d777f1e81adb4d0ad.1712555682.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712555682.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1fsFyaI59aSDv+FR"
Content-Disposition: inline
In-Reply-To: <cover.1712555682.git.ps@pks.im>


--1fsFyaI59aSDv+FR
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


--1fsFyaI59aSDv+FR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYTktkACgkQVbJhu7ck
PpR6IQ/8CVtpYr3JAFZ8wlQUNAhQPi4J5TUg9/e1zy5N4dHQDSZzyaYZtqMtSKby
nqCCoM8I33p0a/cLpG2sXqziDcpCcugRsINd9DMaSpZ/5Dn2wTkCBalusKmcj9eu
M0nRahC1i0I1O0hX1I8lCfWzzWBUdf7WK6vuvAPv1ymfBrKgOZQMiCRyFLoV3uTB
1JTa6HuNfy0N/ITSTbLnQisHyAoSvz0IKX4B8W8WRLmTpK0CpL8sYbfMiVqMrArJ
+o0uRGtvx9UonZKJsTTTR9mGG+RDSyTHkts7mNnbrtMa2jOHvvpdDZQAQIr0CIyQ
OOrnJ2NJRKHYRZsOCL0VhP9r5f4qhiiOlGxH2Oqec9wn9RZAa58l3fXs3q2cNlFs
ip9fIgQz1KfRCm0yb7fHrxhYvCbBvSN+eRexRN7l/zWMJQCEAUcx44e+iwZIt955
RweLUHtBDkA2idLhuBE37I7LSPjoGhK2kx4fKvhtMmELW1VZR+v6mKkfvS4WmQWv
BWCiuRNkPCSxaC4V8oo+u62oneILz2vNhp7s9GGel4TsRyS1wyTbAo5/nsZ0CgVZ
orc0VsFH2HMoIfSRMP+2uWlGl9OPoSRjKoKR9VMkEQC8AKnb5fNw14ZkUTSLQNAJ
WGosF3RwUSmsSQtjIZO499sfIAOzeztPVowjWKzEb2XeahSdIGo=
=IZl8
-----END PGP SIGNATURE-----

--1fsFyaI59aSDv+FR--
