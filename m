Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC9C1D54B
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 04:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712897053; cv=none; b=RAvnq9UW4Y9WOdoPXL8tZeCpw0qVKbqZ8qotoWqLbMaB6xc3P5K501+g6ZnhzUxmbybNL0f4TJJ5n2dvuGvNHRABPz95H17UsO7Huehonu3V0fOZt5/N8h5ie+EXwCXazWSA6QsLkbWj58ZEqAOUu0u8sNP/mmRwCGNC5XgE1Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712897053; c=relaxed/simple;
	bh=pZnXdx3aZZ1cjfNPvV3iayvnukr7aDKMgK/U6+zxFL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrFfLq1Cq5oiAyMoLSvHGvV1O0WdM2a2Iox7gq0DH6thvAJ7IHYxohvrZgX451NVjBKU92rQYvfnkyS9D28/H1o3slr2r54zsXYS6XAvhKyCxtl5XVWF1agsHTSMqzUsqqVW2oae8pKfCMPzvLpcERHDwTzyve5fcqUylmkjRIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WWyTeuv3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NogiDGkO; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WWyTeuv3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NogiDGkO"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2C5FC13802F7;
	Fri, 12 Apr 2024 00:44:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 12 Apr 2024 00:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712897051; x=1712983451; bh=aihsZgRb3/
	4V16/Gcjo4TKpsma8zxZnR5+5zNslb4V4=; b=WWyTeuv3jUGgF+rhqYyFDPULRt
	QmSuWuDRzXuN69yTZJcV/2dsONONAXk70Nrpfp7Wybfcsma7lEBXwQo2/+SJEkXB
	qmO2juPF2Zr5Tsrr50/VJqhwgUouEGwc7pcujD8RnuVy6sHv/GaFq3QgRGGRpmO3
	QMFLEc1htCN2o+JJl1pvI9+0tilnap59UsjeG3f8kvh01er64mt9uRhsgbIXWEpD
	pU7bijaC6u9D1Fu7mEzdIAfoUTeAlKqYXIIvwatarb+ohGkKn2cXLp/DgWYFnX3J
	4LsnHCgxZvp2NXMb5z9/mfjUMZzrZHVKENl8lWo/TAEs3SmKGylJ+r61O36w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712897051; x=1712983451; bh=aihsZgRb3/4V16/Gcjo4TKpsma8z
	xZnR5+5zNslb4V4=; b=NogiDGkOMSwWENL00owWrGB1MGgurS0D8Tf2Wgy9eBZF
	tUYAmoa3Bt61giYf7SBvKeBnxFPLKRYW0Bisbq4g45a4Uqc2Kh7p2JzRXLmiKCyy
	BpTiiqExbdMGzkvNWwRSlsu2odocezC/KytsrUH0n3ikWwsUjN21CX90Zz50hqNV
	vu2ayBhYKFY4eB+mx1An0uDZadmIylXhyR6wRh7wJEk3EAeA/j6cRD+IYcORcZ8A
	229ykHU8d6eOeow71qpAswpAkQ9rRSR35/mlA2zH/ci43eSbojJgNhP3gPPuD0ZX
	PXamKD+WVeVg7NmBLLIgJatlINwwkCKHWopjilUPpA==
X-ME-Sender: <xms:GrwYZliMVhxuPODijy-DLnb879bPsUpPEiIFwTto7pSCh05LSTytiQ>
    <xme:GrwYZqDtBsydeHvg8T9C60BeWrv_7Y8pePjl6pXybHDkonBZHXo4Oh3l9NjPl03Us
    pwTH8eeqPSck9_vjQ>
X-ME-Received: <xmr:GrwYZlFFUd8PiQwqMTInvtpYD7tEY033HOUPkJNfO19dOQk3BMmD9pwiY3iKmVFTV0EjDQ4OGw8ZRGX8dZzfgCthxHUejUGxAMx0wAVyvZe3AEho-Kc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeitddghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:GrwYZqS1cIPXoP9W1CPv5MdwqyMRolRgW4ez_xnqNpczmtzG5lSOzw>
    <xmx:GrwYZixzoiEvgvCXpwRGRSDsAVY4bQReQAvfuMX6uV3oKwOGKwvXQQ>
    <xmx:GrwYZg4uGxs10PqRD_rNTDYByBTz0QBQVrkeLXUDgL52wM_6-6E9cg>
    <xmx:GrwYZnzBeAEnUESheUOSX9gHsVIwQlCPu1TPSfNr3XI6zbDZX6MrnQ>
    <xmx:G7wYZtwfh3p3mF1DSuhhtlp8EAfQhw1s8F331kSoUejNLN16IymysIUB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Apr 2024 00:44:09 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 97123517 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 12 Apr 2024 04:43:56 +0000 (UTC)
Date: Fri, 12 Apr 2024 06:44:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 03/13] ci: skip sudo when we are already root
Message-ID: <44a0e0760010a585a63e61b922783157227d3fb8.1712896869.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712896868.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="69x7CxbhoeVZokIo"
Content-Disposition: inline
In-Reply-To: <cover.1712896868.git.ps@pks.im>


--69x7CxbhoeVZokIo
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


--69x7CxbhoeVZokIo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYYvBYACgkQVbJhu7ck
PpTgRRAAmQxhtQ0vkvVKQoh6ZnkvYZAH08/EcGRP9g4Ncm+TtUWk1T4hGRh0t5gi
7Mq2bNyfKXbix5jvm4CIYXNWw/s13zCm67NCYAj1v49u+hS7n7lb0Tpvo6m/DCRy
t3uJC5wmnrYxH0unF+qXxWgELqV+7dPgS3/qew6w1t2Pp/wnaEz3phvSPEeiE92F
Vlh+GTjht46pxlQpOR9xwNVv4vNM6Ef3YpcK6xzi3QDLnegg/gG29E5vCsyDTmaf
bTK28LTRnlRqbiUUIf8GtOdBtWULgbKeOnhl1DGka2l7JK+uXKRKn4wb7KWuwNRT
8VGknZhKohJF1q4GK13Ww2L+XKgc4v0aM/5UVgKEC8NGyfsEXUixtev2JpAOV4R8
dz7sx/rFbqxQLSx79RmXZYzj5fu/PYaAuB+hheY6oIkKw6HS/k/czjG8Rbkz0d6z
B3Vn9LXbXIUVkfmfMmCV89nIjjMBpWQDPT1oH9zpF4lP8jTGxCgOOeM/F7CfDj8X
kFgjTbhJSsD4xfz30/SX36n0YxtjnbrpIqfeCVJwQlK04U3rPsApPMDTWFulNoN9
Ncw3WA9/VUmO9rOMnEsLtIHvhA8/ASg3tjV+p1BfQX3q1GGwtYJZRxhi1+R3Bull
ESmWiyBucNdUSdBjabG5v8YMRNn6kyiF1urt8my4U0QkEkFD/AU=
=xosW
-----END PGP SIGNATURE-----

--69x7CxbhoeVZokIo--
