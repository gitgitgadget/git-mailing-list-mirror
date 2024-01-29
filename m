Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7996A5D73B
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 11:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706526444; cv=none; b=n87c1+jAHTRMcJehU24pOeigRt7/htOfC3YcKvU7iFVPr9b9jfUXRE7exSQUWTQHVcqAxFCyxDWWJ4dEXa//zBBiSZyoqsth6sUFwFjv6KuSjeyF3IzuP2gk53skmimchpkfevYKorF8uwM6CVo/6Yp6WCl771V0ufOPbxgaFtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706526444; c=relaxed/simple;
	bh=WioqFTS8UdVasZeESmCML8utLS2fWfT00ORVIUou/ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqssFZEzOxW1hXm3a4K84JvbVt7n3P40dv9fN/SWBuKFPDmuU4lKHR5dqNGEalP7+zxwNGVEQLwlJ5XU6VICaoXh2EgPZK8rz5vLpNKAlfN6d9PG1PyVWwV8EY0uiWtqftn7SjHsoX5ldZIEcV3qAYgZVUauSkoqyjo67I+MhRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MFfgMJCq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VAHqqM/Q; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MFfgMJCq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VAHqqM/Q"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 4C8CA114009B;
	Mon, 29 Jan 2024 06:07:21 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 29 Jan 2024 06:07:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706526441; x=1706612841; bh=bSa5bG/0GS
	HN6p+qWja4YQIOMoya4rQIx9eEmCQ0/z0=; b=MFfgMJCqTppouutlPqf+wmiznn
	HaNEBOeCLBqJVQ6RDkk8oynovY8f/ETGenyQo2NREF1OgLmz7RBLWAmSiYaVhiCM
	Sr3eqQIceppbWji6dBX5T95QV7HKqcN3tFBSm+s5ScVobwCXUOSIH/2+KNV6kwG2
	0cYqX65C4clqgMU1nGJdwP8SejMKP8I6XLpT9FlMkYkjfVGQWeH6nTs0LudhfyDp
	VWDOyMpKZdbHFZftTNC7VpVdqdC3+UpPvm9LdhWkzvDDPHLxG2xFm5P/INvBzdsP
	R6ueBcJlRpQ+kypHYIBe26F1KVhQ8cSvhs9+guNvlCbxGqoeDY3bJLdYuolQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706526441; x=1706612841; bh=bSa5bG/0GSHN6p+qWja4YQIOMoya
	4rQIx9eEmCQ0/z0=; b=VAHqqM/QWNWYvDudMoV28NVOh8MXFwULu2p2mvvAjaB9
	fOSrkJHOMQfMdFonTmMDv4TMkwJZA9dOkta8edoOOK3BjOTUDG/tqEx2T4Bn4zFw
	CCYZ11sN66dQ7fDH0yZjGsblbmvQsfsW4EnAYl4rWBk2qp1LY9BrlLfayurAm3s3
	KfgbuS9PaoiAtDmnOS+ZY8SDnn3AonRCJjGbUjFVvk/6l4LpOBzh+8JV2ceDh58/
	bfWyPmRJXWa38pxeE+rJgXZvRnS1DkejXyBQM1ghsVafh+HCHODg8f/2d6gDPWkI
	OuXMy90JMmgqqTXJhZoWy/XwEfg3B4KFMIPdk/D07A==
X-ME-Sender: <xms:6Ya3ZR9AG7eKu5WxN80hCOvXLNljc1fBLSBnhTlGKIss-xZ__GzRYw>
    <xme:6Ya3ZVtDwLgZulhxaZYGbZwllQ3fl17X0XGXU97oauYyKyrmT0VRb4kwB-jOyZGkB
    KTwwJegDhdwB88Hnw>
X-ME-Received: <xmr:6Ya3ZfDHpF_iMToqi18_A27lHYPybWzYXqRzjcrnh36SRO_MY2rDCo1sqAPzA5tKy6nEK3USqjRm65UD-NvEzgVeNPShNfDA5QNfxYXfiKrPuS5HBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtgedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:6Ya3ZVct7nrazDdFjje3z4WfBd6KmwIc3Q4w70QbSKAxjFJnV1fb7w>
    <xmx:6Ya3ZWM8nc62x3GBPtVKzDYo7qMtwVJJw4-CRxsvzQwrFFl7mFjJfQ>
    <xmx:6Ya3ZXlEXkPDFJLqFWfqBP4mEuWAdeENv3_51kuCmCJrUQX8SFeXKg>
    <xmx:6Ya3ZSDr5A1DI91l1kv3riElvoCCA9ksXDRj0xTF1rxEK0W1DDJFxg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 06:07:20 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 44bfd440 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jan 2024 11:04:03 +0000 (UTC)
Date: Mon, 29 Jan 2024 12:07:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>,
	Toon Claes <toon@iotcl.com>,
	Christian Couder <christian.couder@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 1/6] t1300: make tests more robust with non-default ref
 backends
Message-ID: <80a74bbb567de165a8dadf0664167140e4bf0504.1706525813.git.ps@pks.im>
References: <cover.1704802213.git.ps@pks.im>
 <cover.1706525813.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k9pZyeL/Tu0l5wWI"
Content-Disposition: inline
In-Reply-To: <cover.1706525813.git.ps@pks.im>


--k9pZyeL/Tu0l5wWI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The t1300 test suite exercises the git-config(1) tool. To do so, the
test overwrites ".git/config" to contain custom contents in several
places with code like the following:

```
cat > .git/config <<\EOF
=2E..
EOF
```

While this is easy enough to do, it may create problems when using a
non-default repository format because this causes us to overwrite the
repository format version as well as any potential extensions. With the
upcoming "reftable" ref backend the result is that Git would try to
access refs via the "files" backend even though the repository has been
initialized with the "reftable" backend, which will cause failures when
trying to access any refs.

Ideally, we would rewrite the whole test suite to not depend on state
written by previous tests, but that would result in a lot of changes in
this test suite. Instead, we only refactor tests which access the refdb
to be more robust by using their own separate repositories, which allows
us to be more careful and not discard required extensions.

Note that we also have to touch up how the CUSTOM_CONFIG_FILE gets
accessed. This environment variable contains the relative path to a
custom config file which we're setting up. But because we are now using
subrepositories, this relative path will not be found anymore because
our working directory changes. This issue is addressed by storing the
absolute path to the file in CUSTOM_CONFIG_FILE instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1300-config.sh | 78 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 50 insertions(+), 28 deletions(-)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index f4e2752134..31c3878687 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1098,15 +1098,20 @@ test_expect_success SYMLINKS 'symlink to nonexisten=
t configuration' '
 	test_must_fail git config --file=3Dlinktolinktonada --list
 '
=20
-test_expect_success 'check split_cmdline return' "
-	git config alias.split-cmdline-fix 'echo \"' &&
-	test_must_fail git split-cmdline-fix &&
-	echo foo > foo &&
-	git add foo &&
-	git commit -m 'initial commit' &&
-	git config branch.main.mergeoptions 'echo \"' &&
-	test_must_fail git merge main
-"
+test_expect_success 'check split_cmdline return' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git config alias.split-cmdline-fix "echo \"" &&
+		test_must_fail git split-cmdline-fix &&
+		echo foo >foo &&
+		git add foo &&
+		git commit -m "initial commit" &&
+		git config branch.main.mergeoptions "echo \"" &&
+		test_must_fail git merge main
+	)
+'
=20
 test_expect_success 'git -c "key=3Dvalue" support' '
 	cat >expect <<-\EOF &&
@@ -1157,10 +1162,16 @@ test_expect_success 'git -c works with aliases of b=
uiltins' '
 '
=20
 test_expect_success 'aliases can be CamelCased' '
-	test_config alias.CamelCased "rev-parse HEAD" &&
-	git CamelCased >out &&
-	git rev-parse HEAD >expect &&
-	test_cmp expect out
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit A &&
+		git config alias.CamelCased "rev-parse HEAD" &&
+		git CamelCased >out &&
+		git rev-parse HEAD >expect &&
+		test_cmp expect out
+	)
 '
=20
 test_expect_success 'git -c does not split values on equals' '
@@ -2009,11 +2020,11 @@ test_expect_success '--show-origin getting a single=
 key' '
 '
=20
 test_expect_success 'set up custom config file' '
-	CUSTOM_CONFIG_FILE=3D"custom.conf" &&
-	cat >"$CUSTOM_CONFIG_FILE" <<-\EOF
+	cat >"custom.conf" <<-\EOF &&
 	[user]
 		custom =3D true
 	EOF
+	CUSTOM_CONFIG_FILE=3D"$(test-tool path-utils real_path custom.conf)"
 '
=20
 test_expect_success !MINGW 'set up custom config file with special name ch=
aracters' '
@@ -2052,22 +2063,33 @@ test_expect_success '--show-origin stdin with file =
include' '
 '
=20
 test_expect_success '--show-origin blob' '
-	blob=3D$(git hash-object -w "$CUSTOM_CONFIG_FILE") &&
-	cat >expect <<-EOF &&
-	blob:$blob	user.custom=3Dtrue
-	EOF
-	git config --blob=3D$blob --show-origin --list >output &&
-	test_cmp expect output
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		blob=3D$(git hash-object -w "$CUSTOM_CONFIG_FILE") &&
+		cat >expect <<-EOF &&
+		blob:$blob	user.custom=3Dtrue
+		EOF
+		git config --blob=3D$blob --show-origin --list >output &&
+		test_cmp expect output
+	)
 '
=20
 test_expect_success '--show-origin blob ref' '
-	cat >expect <<-\EOF &&
-	blob:main:custom.conf	user.custom=3Dtrue
-	EOF
-	git add "$CUSTOM_CONFIG_FILE" &&
-	git commit -m "new config file" &&
-	git config --blob=3Dmain:"$CUSTOM_CONFIG_FILE" --show-origin --list >outp=
ut &&
-	test_cmp expect output
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		cat >expect <<-\EOF &&
+		blob:main:custom.conf	user.custom=3Dtrue
+		EOF
+		cp "$CUSTOM_CONFIG_FILE" custom.conf &&
+		git add custom.conf &&
+		git commit -m "new config file" &&
+		git config --blob=3Dmain:custom.conf --show-origin --list >output &&
+		test_cmp expect output
+	)
 '
=20
 test_expect_success '--show-origin with --default' '
--=20
2.43.GIT


--k9pZyeL/Tu0l5wWI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW3huQACgkQVbJhu7ck
PpRcuA/+LhIhrocOb1Q8wdj7bpegZ/pUE0OZzx8QNid6CqZ2l8Lg4rjphifemk/F
BVndZXXq9aLDt1Ro8/k+aLdmmF5Dj9h6SPKI8tL7smzla+l9Cy5HlyVkf5eYUTKu
qFZfiJF8v5kRqf1G4gVhKvqWFzhaWFatrZ8gaZev8bdEX+0WA/bHSwLaSPs9wVDP
xMpbgu3QXN5usEBIVUZIfDPSNqZ2e3eyGo0ri6SOePfhgesdg623BJZGHN7t14uL
xb3Gv1RiA9T0i0Pppl66LrEy2R1RZKY8fmUabEER5uqPLrWQJqVPx7t0IEPqFx/X
TaQ5uCCiHacNDQupgVFywN2Nm+3LXhSY9q7acozubQplU49T0KXDhQH0KlHDk0if
KRqVj9lQmsif3T2ZL/nZ5Io7apuZ81Qppmxm3q4w6MxcRZihPKhieZiTfXl8eCDT
YbGLmfo4h1l+ICu3I5grzlSICzO352aTXglyJWyurW2hF5Hlm4bNhI74325XXgro
Xt3HDNpjzhdtCz5CrWzWeqFOyhmaMU6c7QeYYqKC+gTQoxqdhfzlW7wJjmW8HC0o
Yki5R1qnQntJXe+K+4YJ+EIu/bWQyfwWT4fdOq0OqeLbiLGa3reG9gnRSqqTfwyc
h0g7lO/knxdLuVDSZgXb2NP79VPXQDQAPfcKUVz0AYG6//Lkmmw=
=deHN
-----END PGP SIGNATURE-----

--k9pZyeL/Tu0l5wWI--
