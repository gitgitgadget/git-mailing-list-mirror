Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E4023770
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 06:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712558794; cv=none; b=WXu24cd91vZGqget0VddFqsYKZ/wB4XMJK0fe4GtqbfFsqVuMh8UOzL1MkfbU7xNByHonmDQ18JUFdVFIAs8WGNRD2wvh5B5WlD/VwvSrDsoT2WgIFBw4nG55WkpaZHfAAXbQYAbkSksYcuWiSL3w9vh8m2PB6DH0Ro20+dfuuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712558794; c=relaxed/simple;
	bh=iwIQnd+ZQeYpyYhaGJrAx3jqwhl7nBK3ghUiYt5trbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvrdLwZDfMCzKbDMMJy+xUpiS/zrmY2YQbrquVdItrr12t6VYxkmzl+fJhKtDUVm8kfsKAwIZa3rHmAvTjay60TlKOjHumtsX8WYSZlKwCTQaF2LmfKQf99yEy5+iJU8o0qJmCZ2KwNPyh+spveJwaGQIR5Hl87MX/JqNu7PQ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=itjj/Cr5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BIBJmhiT; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="itjj/Cr5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BIBJmhiT"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id ED9F913800C0;
	Mon,  8 Apr 2024 02:46:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 08 Apr 2024 02:46:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712558790; x=1712645190; bh=SVhOfi8sQu
	TFXlecowHMEVCQ1okrByEhItVZ25Hs5Vg=; b=itjj/Cr5s6r8+xKH12oTHgd24K
	SQvSR0JZq+wGXvLx98oyL18MSUKpFsSWYHqMLpJpRnGpYdf10hRZCTqS7dbw6Q4T
	XNBx7616Gl7RzGv1zXHb9P9g5+FhY9SPQLOJAmRcUVY/CLa7M5yxOgsgd5MZCU79
	LkEqOgiYqwCfavpixQ2bfwDgK5o5U3AQKBFPfaPejJzlNZWbvOlXBy72YEDBE6pj
	+MSBsDqJjETheggsc4adsfazHkubcnVPFbsSQbyEad+3BZITe7fl+Qr1vIWfrqaD
	JqBulxxvABVAEHTeANPPj0kgP7EjS4Pkrm8H+0qEUM3SwnJhKLJl2AzXlsVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712558790; x=1712645190; bh=SVhOfi8sQuTFXlecowHMEVCQ1okr
	ByEhItVZ25Hs5Vg=; b=BIBJmhiTTGFhzbL+NQhN0VdKo08pVrppmOGWF7y1vG+k
	FfFfbbxSYCqEI0YtboTVkPWXHLOhsUpaRudt+wBAo+T52ZdsSY8vAOjvSsbf4wwh
	7ahg6w7iNmweQTwO547W4JYTqHgwU396H37kOyzjBijizDQd3xe5BxlgFhZUUzWG
	rZWvsPiB0hM+cRWpF76+wXYMz80zNPvBLxmF6TE/Fk1nUaYAsX7P+w8Yp3YRLvFX
	SeK7kMN5hDG/u6hhOXqFBLQniJU+GEQHrfFLlNRgLMM+6dNnFB48Q7GCMKKkB4a8
	aeiLXyO5V/YEOp12vLzd5ZaV+LFND99QTcE5+eBcLw==
X-ME-Sender: <xms:xpITZqgrxmDZ_Faccn4ZIen7J-HRQoWsaAnkzMXWrU-uGXAXyzUPkg>
    <xme:xpITZrCib3ZBOvqaiPeKNyswIEcVHXcTpUvLUzVFKhtaFaiPROjlc55XpMtgYUSXi
    o9sHhhiAQFjca7zAg>
X-ME-Received: <xmr:xpITZiG9Uksnb7RLA-9C1dasB6DhQFRLud24ydCWktdUs8My5ohwBZLYZ5baBBPLnOWb6z3o34pjYB9V_-m91NQ9NlbXqvm_yiC6mQqmRU0jd4G5-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeghedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeejffefvdfglefhjeekfeetfffhjeduhffhvddtveejvdehgfdvudfhudeggeek
    gfenucffohhmrghinhepphgvrhhfohhrtggvrdgtohhmpdhgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhk
    shdrihhm
X-ME-Proxy: <xmx:xpITZjSZdaUTCkdrJQFn5K7RdMTJo9zYA2oPOldj9RYcV35uI8RRwg>
    <xmx:xpITZny36qqPxBaHQ9xaGGsPib5tOiwkNpe9wfdpS4YDj2-pSiocoA>
    <xmx:xpITZh4kANa6GBTD3NuY9R6IlLHGG7vFLpYRSNcpQxPqECh02ecIBA>
    <xmx:xpITZkzmxwClMvWIS3S8T0P7J0V4A_IFbZtBFc9q0jZ4axw7ZTFPbg>
    <xmx:xpITZioE9BRng7yDymJXnP70pnazkiBkcSJuJD_JCueHYBiwJb9Kc2IT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 02:46:29 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ad1b1dda (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 06:46:23 +0000 (UTC)
Date: Mon, 8 Apr 2024 08:46:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 04/12] ci: drop duplicate package installation for
 "linux-gcc-default"
Message-ID: <b4f6d6d3bfe28164f74ac927a0ac67950827d7df.1712555682.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712555682.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1SOMDaed9SQ8Emwg"
Content-Disposition: inline
In-Reply-To: <cover.1712555682.git.ps@pks.im>


--1SOMDaed9SQ8Emwg
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


--1SOMDaed9SQ8Emwg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYTksIACgkQVbJhu7ck
PpRgChAAj9F/DGuar8MjF6vk/dQlrJsvXKcpztKWT8+c8ULvUD6rGKl47qUXl06R
XWriEiRg71iJIDkJuPdVaKAXlT5RME6iC+hPvsXgZL/HAKVRWfDDpQJVVQ6bdmez
rYAGDPjNza8IKHAEDsSweGzlAY5XA8yXdbpTXLbc4LK9RptExF6TOHeQAC3yzjwc
RtcdGA2zPqmsX9lZoMoc4tZZZqWjHFFmEij2Qf1O6I3M0ef2krP4yOgxTLpRUrkb
MsvVXsUy/30ASh+a3lq7wc+Ghc9fKQQH1gO3SiPfeh4WMJzUNg9iGPP1asbAXOHs
UhRlU3fPfgUaclWESrvQaMIPBo9Gmz51wptTfvj2dACqZ/B0etsoUAwHIvp52y40
5YuJrtWzylhelPVIKN+AR0z6QEBNE8YRnKYu2ynMMzqAWY2t050D8ogkjKFw56x9
KhU3q8v29i/AxN61sjef65cHRHWr01VpXGa/jW9BNakuCCA60jEjkgLZhf0WLWV0
XrIO3FEz+jU+RGaeVfhfxhevg/NRfKOHXWmOei/WqqnCMhHTJPYcOw8hia1AURlZ
WoAcqLIKJx8ABD0IYtmlGUOLcZANBNA3N6bsnFOGVWtZNmYfUzZXAe/0sDIWWulK
g3/BhIoKbmkAPrmTPRNLLjPJfYtQjE5+ynzjGxsFhJIAvVRqKiQ=
=QAQL
-----END PGP SIGNATURE-----

--1SOMDaed9SQ8Emwg--
