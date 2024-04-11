Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B42B142642
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 09:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712826661; cv=none; b=F8tTvo04OmmfOhOXMthrNhPFM6QB6j4n2Jw8EJaB+ID8BmUeE/lx/wL2nqAxE0ACnkfDHXr3DblfqGkvREqbBm7yazxo4xNSwm5FYhIC/QQLepgSlo1avJTMWAVpGT4zR5DLjrYnV1dqIjC6b9aAzEzj2p1Q8oyFc/QuVXUuNuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712826661; c=relaxed/simple;
	bh=JE9ozeDEYqIUn2wB0SBRnXMiAYeu6gv3ILaB00aA4jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOEi7CUWqLevc6tJE/K4WWG3wU3nI094lzxVvYVxDgmCqvedlGu3EbnItZYfkyxY7x1UNpwxS39AMSAVaV5bqtbOowEYym/DAIu9MEFtBtRVVa+SJnGL/guD6E8VQnPGZSDt/qQMFJLJpOFLdQUqLWpklOS1vrDFyzOza/2quYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=l8DZitej; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ADaxLXsa; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l8DZitej";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ADaxLXsa"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2D31A1140177;
	Thu, 11 Apr 2024 05:10:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 11 Apr 2024 05:10:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712826659; x=1712913059; bh=mFiOi/9RE2
	f+hS8raagOqiNSDlcylZ/bhaQgwEQsLm8=; b=l8DZiteju2PBGelmCSEYtIpRBY
	9fi+nPEOk0QXBMg0MNjXp+lRbTQYX16C9T/U8t0HV5maKYIhjVLc8IU3Prib12F3
	+EwCMmnDPtVr1YxfmTUyZdsF9Sdt8wn8omSuPCt6aOkCTblannOS7rhG6bVbxM0x
	/sj+BsPw8DU7/xEdvTMEPf0ZujMcv/IIgr8W3WXkwn6rrSlE/XEdbNom+KcFozFd
	7gja3bbyadrHtiuprkeq47ZFITtN63okch1wR0F0KV9AEUPGUdGsl4ekD88A6/y3
	M6+UtHEVhTcLACvfS0bmrAqhGmI0bQgYDN3NCW87JbES3pHY3O9EvbDWnisA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712826659; x=1712913059; bh=mFiOi/9RE2f+hS8raagOqiNSDlcy
	lZ/bhaQgwEQsLm8=; b=ADaxLXsa4uENk4JP1eGFDMtzFO0fF3wgORFqnJ/MrvxR
	PJNL5rS5Olzw2LN4R+v3E94+p3jBKILxMzEJ1SGGfvSkMm72u+y085xpbtrGrvFB
	LVNfXVmwhmXgdl6vnOTPTPGKOMvO8mmeDFdp0hXk2bV1TErZJzNnvjMlSmLfFB1M
	dx6i0DNKNanJjOPhzS3wEmnb4shEM+Hg7KtMjVvAa6OI12ioHr4xPorTeZjW3hxv
	EEtQPwnkAnxGBbYAtnXW0Kg96orVYU4Gtsk54Cm4IYRgEZumo6rZ/K7d3E4kDjwk
	cV/ujupE/I9q1UgQqAhy3kumXommohNf289kt6L0sQ==
X-ME-Sender: <xms:IqkXZqUqBHYtXnU14InKay8hyj3frGC8VzqYqhqoNL9jYYsYRlxmqw>
    <xme:IqkXZmmCKKygCpHdb62ES8J7_wA6gSDRsfOzoGTSwfx42C87XrF5ArfrPvx1wX3ge
    YF_zM9dUz68L9Ng5w>
X-ME-Received: <xmr:IqkXZuY0lvAhoGfaHbWvSipUBGc19DXmNDFqOLD7mzJNJzOJ6JrLzVxeV5QC7J2uPrsXcYyXGhphqTPSstiCi8dVDmCkXkKPIaWcKOjmOPJ0_AFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehkedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhephefgvdeuhfduudffuedufffgffehgedugeeivddvjeeugfejudeikedvgffgteei
    necuffhomhgrihhnpehpvghrfhhorhgtvgdrtghomhdpghhithhhuhgsrdgtohhmpdgvtg
    hlihhpshgvrdhorhhgpddvtddvfeduuddvledugeehtddqrhdrshhhnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:IqkXZhWWZuD71JAXKKx46q9kFlaf-b9wwrc78gplqilwEqFvmtdxFw>
    <xmx:IqkXZkmJJIRmeU-nu963bthsMSKUVYPrc82KaE5wayL_WdG-EEriXA>
    <xmx:IqkXZmemGHVeenRYZ-D4L30fAVuHLhOziWRQ9TsgrH405scYpUtYcQ>
    <xmx:IqkXZmH1kCww_itXZj4CY1pFzl6CfkEDWgLbm57_Tf62VH890Nyi5g>
    <xmx:I6kXZuV4S3ElcOQBPBjl5C4W3TOih0TuclFqr9hq0j4q2NIDp4i6Itpx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Apr 2024 05:10:57 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6ba03b42 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Apr 2024 09:10:45 +0000 (UTC)
Date: Thu, 11 Apr 2024 11:10:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 10/13] ci: install JGit dependency
Message-ID: <b835ff8b78e74ac7ff5ffd69aa0ba65576f76331.1712825204.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712825204.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hJDk1UItZ7AwMw8p"
Content-Disposition: inline
In-Reply-To: <cover.1712825204.git.ps@pks.im>


--hJDk1UItZ7AwMw8p
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


--hJDk1UItZ7AwMw8p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYXqR0ACgkQVbJhu7ck
PpS1Jg/8DGdFMPGAOAEdweyKKwvJWmWFqGNKKLVmYWC3N8pRKbnEVFTlInQnofMc
oHTNyZD6drOt54sFTDYA2tnt1bNAh3crxlZeLyU3oYNB/G0s+kYyAiqxg/V2rLT/
RfjEPzwLAcLKZULB2iJMWSL3jfIT7FHYoMyI3LAv05r7S0UZ5N4xUBr00eqgrL0n
cyYw8ETyJgKkLST2T6haoozs5SAQl27fRre4A4RwWNvl2/yjqMEo0tqsAbO3CNDn
inc3OtI3mCsskT4TrgduvSPD2tSTxb6MjQVe+yLIZ0ZbSSXLrgzOpiOq9X07iTa7
djgKfK9DstjkUzTmBzguYbURmHBcGH1RnaoZlSGhrarwhanmzsGR/TrTMt7vdxej
pf638k3hWw3JSYHdWgFtL9+D5KqthzLdjJU5jVVeaaMK7ZQzyUP4ifVnrA+znqDE
XidiZMCJxLYnmQzKqjYy125pbTTc98UW6XYL4vM8mNEY1j/ksRRz69GvHWM9dF0E
Wts2i2gDyFYQI0h1md5M7d/n6RkJs9NKtjCnvQrihCT2/s6bdUibGod74LKsyTmy
UTzE7GoOwBsAXOf/gXueEjVLkDxJLgtx1D1YjyOUF+CKZZK5H2cIZJR0lZCrdZOA
GtHpgunrBcj/uL6gtnr/VzKsFRloAvZbaLO9Liq/M0rG5AL7sog=
=u2I+
-----END PGP SIGNATURE-----

--hJDk1UItZ7AwMw8p--
