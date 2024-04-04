Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112F91272D3
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 13:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712237119; cv=none; b=KPvWYxSUzKTGY4iL4SKVfgVHaskn3CbcBBAIVCBWuVWlCgdTHPnGZcXGTKhZmDaiKXnE8JX1srvwG/F6P+MDyJHNEA9bwKIA1HRo+ykCryG8AyNKtZv0cc3yzJ+uwsrUfWTx+iH/A6DMrGQmMdm2hRCKdpj7HE7hBuEXnEw9ziQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712237119; c=relaxed/simple;
	bh=wY0wEaidWt6fGJTDLxoP/FSxa3ZtUO62/DMyk+BZpxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcHSqlQHMer+z+pbBe8iY8vrJmSEC5e5SawalPg5er8lstUrqFMgaYsgUSAjUDHIbst9ou9yynN9XzmfKbi1tSgP8j81IgjL7cOeE8uwMTHw1eWqWcx1KxualneFs7xj9yPYXiWuNjtL9N5Ny4VUKEbRaLCK39ZfBogr7e66+jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E1aFGmwl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GTSmaJ2v; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E1aFGmwl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GTSmaJ2v"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 108CB138017F;
	Thu,  4 Apr 2024 09:25:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 04 Apr 2024 09:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712237117; x=1712323517; bh=WbHvK1rlo7
	7/jU6u9707Vad8oHhxYU7E0dCko28HaTU=; b=E1aFGmwl7Eoq4cc6ZK0dMkmX9R
	+3WwdbXesYixLWaBuy2FISu26x1Pl4eslQ/5Elb9u59JCnB05H/Si8j+/69N0ULF
	9pw52Pm873m1KTOerbmMg7VBU0Aqbn0KDZEFg5ofosftQzpefuqoorJD7rPbmuBq
	YhAf8KxraX/iB19Wh8jS+e4x7J7R/8V0aA7F5rTW+gOa8Cx0J7rooeRQgao2IgJe
	Nv99zHRHWui+m8FtUugkqVCve16Nd39TcYeFPscqrW2n/3ktaxpkxT6WtpHrozZM
	tJA5YXAR5wNhcTky6k6gYywMwaJ17qSV09cgF1XfaSL1LDTADdrjecDBX/QA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712237117; x=1712323517; bh=WbHvK1rlo77/jU6u9707Vad8oHhx
	YU7E0dCko28HaTU=; b=GTSmaJ2vm1ybzb4++YkWLwWfIBjjrIkRi+4eycHKaEDX
	yGGEoCBZOvjBnJeCKkP3hYSHU6TYObZlvNi+gWG4Hb9LZuiYbtrWORhsOIEfDJG/
	r2C8eMz0b/slbi8jBSxKLNXxAUmUrARQKYg8hFm8mXJ/VNjHjCFixQIA9Ct6qh4f
	xsjVAmVoxCT8KCt5BrI2GnsN0LbV4RA5pKsTdadXHUfGyc4/Auu9YjsdAbWdMw8V
	ICtyWClwSWQwAUIAsj8/30j5/si2uAh6A1TrcctjVsLT8U2FQyuRpVcz+LnTscBh
	g2dRePJEZpUJH1jUsXDeuQmDD/7qs4kU1DPk7WPZ+Q==
X-ME-Sender: <xms:PKoOZuQ4SCyL-gSJRFbuAlk7_FJAwD6nbtDq7Mky3ZHhZiY1EKdO1A>
    <xme:PKoOZjwtAzAWUtySOeyFm6q5HXHQYDKsXGdHncKPUq6r4pyEfQM_DtCGtms3_uAIa
    imX0Re6XA0WAo8YQQ>
X-ME-Received: <xmr:PKoOZr2Crv6q0EyTXa8JTOg-1ZAPS4QKV5HpokgrBopmiYRMZ-tYdxkLIceyO_zqyjfh9g_O_s8IIdtwNd9NSxPH6CFeVIf7qE2US458m4xRQWvx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefkedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:PKoOZqDk4uqC0TkosEMqKcRwUlwIra1N1RNDkcaRlI_8XY-yFvdxuA>
    <xmx:PKoOZnjcxptkv2Q9qZx-zfYt5MBVIPMsKQWD8NGeOdkHmBmfCHWP0A>
    <xmx:PKoOZmpLRs295o3M6mw0SQy-sS54uAZkWgSvP22WQtrNxjSkzCserA>
    <xmx:PKoOZqjpBHN8dSoeF5CvhXtI4RrYhQKLm8fvx9lgTIL3M1CRbWnRgw>
    <xmx:PaoOZiWfhcGrUdLTLqpLaPQxA_V_1VWgau9jTXlR7L8-wM7QfIOeOnW9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Apr 2024 09:25:15 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5f946cf0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Apr 2024 13:25:12 +0000 (UTC)
Date: Thu, 4 Apr 2024 15:25:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	JGit Developers list <jgit-dev@eclipse.org>
Subject: [PATCH 03/12] ci: allow skipping sudo on dockerized jobs
Message-ID: <8abc9ad6a70a09aae0a350499ee1f3a79796fe8d.1712235356.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Gqb/XQPYUWJ1fDwn"
Content-Disposition: inline
In-Reply-To: <cover.1712235356.git.ps@pks.im>


--Gqb/XQPYUWJ1fDwn
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


--Gqb/XQPYUWJ1fDwn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYOqjgACgkQVbJhu7ck
PpS9Ng//ey56IopVi6/TyHh8oWNdCWL2bicGI13pgU8ooXg+/YeXY7/LC73rLcyO
nBV39cbkJEYMwzeWOYK2DQxiDdFSQE0ewgqXSKYjWzyaxomXzMR0KHP48Y/yiYmw
c2p3yxXlAKgL1XPMLKRqHXNhN9+ODtwZVGYpr5scnQSHl5r5ry4PHWojnXwARXH4
RARkDqCFJI9YXACMJlsqirk9rgOb7kojgQ1Hi0m3pe7zMGt2UwgUyQRz5Z3YhMMw
wvHhB2iq2HZ7PvsYnFD3ISrGLGoEMsl75tkmTFitp3kztkARMZVrZt6jy2+yyOtn
UMnwQlzPkd8Ii8in179lH2Zj/Za/t5snZ+4tfcsX/Y3bceWLBqka9lf1niGfD7Kq
yiDTB6R6SR0rl/gxi1SbW6yIrSb01Oj+4M/VZySMFt74yFmOuJwSQ/E6Grublgr4
MUSR5L1RG6DuRa3e/yQbNku7EQou8sX8v4QwgCx6i4wnTCwc14CjX55J79+S8clT
3Dxsqds2CvDQxP1TGy+6zo9ACxEoeQ93m1u2ZIms7zerRWyIZg+pyzkKfGd0+JL4
80xw1p7FHEf0doMWjI3dJd2pH2Tkcv25K/tMWXDXe77U/6fuh55sAkbXYTaNtDz4
HDv1HqKNw5ouYpChxE0FzFgHQfn11RjwGUwY3YbyQWqTU8Un3f8=
=wNgh
-----END PGP SIGNATURE-----

--Gqb/XQPYUWJ1fDwn--
