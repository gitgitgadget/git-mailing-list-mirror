Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6896FB5
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 09:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712826637; cv=none; b=dQH/o/yilu6WuBUQt3bHJZ1JTwlIAAjN6UL+qexPMdZDgYWHNdx/k+giNbE/8vKzc1dpzJ+X+pZzLX6lMksNQhnzyEGQQ5iaxI7wYEfWj8bvohJ+HcAakRxf8gkuLLw0P0kyiVJZz4dnyIix132fgNR0SwOo41Byg1TOAkJFJHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712826637; c=relaxed/simple;
	bh=q/8hdGUJzUJjvwLRKYxQDbZ+r2p2ceZmQsj9DhQINE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSxCqBnBOfocf/i6ApEnoIh1HXP0tSMbTDUNEiUWHaig/aei9pSwLU00/d8VFwrqoOPOWY4gfDC0aL30DkU3iJhvS4MepjbuUkW4LBYdSH8ELbjLYxpRXxa7+yRgc+5PJFbLb6sdIyy/ojGfWFJ1rAkPIz/YNDe19GABtRZxOP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oc5mTQN4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hV5r13TV; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oc5mTQN4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hV5r13TV"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 4B8021140178;
	Thu, 11 Apr 2024 05:10:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 11 Apr 2024 05:10:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712826635; x=1712913035; bh=muFuvoCvxD
	IQlfRh+fbK5XFYE0T0D4cEG72UiDyyRXo=; b=oc5mTQN48ZLZiZ5iLVGGXE97cn
	Airz4wcNNEJkXmoKLSW4KHjQ06mGq+angul909PwEcDvRXshN84qOQH1Jqr5N83V
	MVNSANjya2Prom3Vepiig8IK7MB5golrWJmkYSRY0UH2Sp8pXvA+IxLR7zUjBzHi
	AHIX2BwM0spv+kOz7BYCk5Sj6wpMk2neQJb2mfUXREke2JbhuFZcCTmb0mbWw2La
	dJgE7BNA71AyWBD5cepvdsgsIGXTPcsjFoXnRUJ5dpy+ikhG8eSt7gI698s+tQVk
	CYsWIIQYqJQ35mgnxaLin8vTA2MndwIknEuzcf2a/pgGwabuf5z6xqhskn9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712826635; x=1712913035; bh=muFuvoCvxDIQlfRh+fbK5XFYE0T0
	D4cEG72UiDyyRXo=; b=hV5r13TVR+6URkAUnq+YEF3+6rik9An2VNddHqEjWlXn
	6+7fO/HzPaP2neTV37DVoQBa+u2wBVSmhHvLmNJQ+vx4KB+9MWCzXsKSde42SoS7
	MiXrLUcnq/Nhe5QtXPft89Wi5t3mqYQCqPXi7B2XXukMeR/kI0thyPrgm/Pl6k9Q
	KRoGSRp7v6Tf5i5B/TqawZ+zy8sPvnWqS78VTMwYuHa89HzgZ9avtaL5fBvC7geq
	7QyJEp4LqnI7W+dkZHgeCVR/zslc/qOL/nlrCWFsoYi4NDE12GwRys8ZkblVVYd2
	XF/nVWaQq5lkhlMmHAEyJYFWyS6cOYTAvtsDlCozvA==
X-ME-Sender: <xms:C6kXZiG3tGtEk0rZqv7IpU1szVjWDcLzKrTvh_6QWthYkniIZNHExg>
    <xme:C6kXZjW72_B3DNwm6w3DNKNmNf7gFN_H_YHUMlvXlTcmARsBmMAC5LZs4_TlKVokg
    RW-MqpEFs4zEHYwyQ>
X-ME-Received: <xmr:C6kXZsKr_HlA_CjLuHbtn7285Nck4R-dhY6bziDTlwtcyNps2B0K0kHEz2WA9KBfwrI2l5OfgjOt28U7fky-OhNkej3zUiocwgiWIpVtW3WKAPI1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehkedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:C6kXZsHZoMo4DCyboc3MLQrbh40daOMaKdsp2qQyXlqJQHjyS1NPXg>
    <xmx:C6kXZoXhTyJqe1AoAFr5RNHVukyBorrjaP-cthrbl8udBVMeDmeGsA>
    <xmx:C6kXZvMfIx593jSv1cdMY2N5UYtjKJZY9zmiYctTX8pVrDOmGF1T9Q>
    <xmx:C6kXZv19SgTO3ZcfpIbj1n2vI6OqJmGFA47YVG20BKZcSLV6IKVJ2w>
    <xmx:C6kXZrF8roXJB5Jm-SWKqd-D1zRR75dA1nADjcT_qhWGNeviuxfNBFjh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Apr 2024 05:10:33 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 92f5c85e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Apr 2024 09:10:21 +0000 (UTC)
Date: Thu, 11 Apr 2024 11:10:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 07/13] ci: fix setup of custom path for GitLab CI
Message-ID: <ef61b578da84dbd8087bf22c43029acf6983e547.1712825204.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712825204.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5X5zxCjyLw5nvazF"
Content-Disposition: inline
In-Reply-To: <cover.1712825204.git.ps@pks.im>


--5X5zxCjyLw5nvazF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Part of "install-dependencies.sh" is to install some binaries required
for tests into a custom directory that gets added to the PATH. This
directory is located at "$HOME/path" and thus depends on the current
user that the script executes as.

This creates problems for GitLab CI, which installs dependencies as the
root user, but runs tests as a separate, unprivileged user. As their
respective home directories are different, we will end up using two
different custom path directories. Consequently, the unprivileged user
will not be able eto find the binaries that were setu up as root user.

Fix this issue by allowing CI to override the custom path, which allows
GitLab to set up a constant value that isn't derived from "$HOME".
---
 .gitlab-ci.yml | 2 ++
 ci/lib.sh      | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index c0fa2fe90b..3a0ef4d4d4 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -9,6 +9,8 @@ workflow:
=20
 test:linux:
   image: $image
+  variables:
+    CUSTOM_PATH: "/custom"
   before_script:
     - ./ci/install-docker-dependencies.sh
   script:
diff --git a/ci/lib.sh b/ci/lib.sh
index 4cce854bad..473a2d0348 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -350,7 +350,7 @@ macos-*)
 	;;
 esac
=20
-CUSTOM_PATH=3D"$HOME/path"
+CUSTOM_PATH=3D"${CUSTOM_PATH:-$HOME/path}"
 export PATH=3D"$CUSTOM_PATH:$PATH"
=20
 case "$jobname" in
--=20
2.44.GIT


--5X5zxCjyLw5nvazF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYXqQYACgkQVbJhu7ck
PpR56A/+JVQ6DZ9LGAkqpQmM0epdhVelQvI+ut+Uwh1jqk7vMvZFtuZUmOdwXKsJ
g84r86UI5RzM6acfgQ7CjPmuYPcsow3Sl2NJJFNeLo0cl21XrgkHaG0Zp995tQ28
ucj7QXhrTKfin/gkHpcKNCkBeN/wV6NghSsJTkKTIIGCekR8xJDA1jMi/QPmo6Ii
te+73ou9vX2YF2pm/aziAutDVlTerXQTolrdtuD+86NMIAt6IqDQHgBn8JLKApZy
qbZNVrzURc7g1t7/FoCP2hiot5IpT1b6c1EkgX6SMnUxvYsjWJTk+gdzeghzSri9
7SYKicd14p6G5IlMtlHF5SOq8zqGMj6P6Ez7qlRBwOJJr3loJWua45KQF6J0jOTj
xYviIbuE0HEQpoKaO6yh3k2Uui0VkxgKKmX743XPbMZs4j6V8HiY6ka/RppKdSOj
u0MfMLLY2cA4SMWSeIk615B1q8+6m1ledXT++9YeWLi05bkyoDOGDqZhm4Iw8tUc
RdM61iKVFOqtK0K0c7DQIZCCAcIXlfiJZqc4WX6J5zXlqYe/pR3mVWe/dJk7TEaH
jAQFl9DxdeiABqix1/3Pieqvw6yOQG4+pVBkTJ613Tgu+rM6ZrncFGEORdybySiQ
3KWXtpUPp2p27IC0K3/VVAeFe7srHMiZrewqtIdbrzuIKOuAWlw=
=T6Ro
-----END PGP SIGNATURE-----

--5X5zxCjyLw5nvazF--
