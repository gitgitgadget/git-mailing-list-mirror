Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E10617980
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 08:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706085912; cv=none; b=sm+tzmCUsBoJmGx4JK8wMr5GlVBXezqV6MLfhg8O5b0Vussb8g+CDUjnuFVEgrw3+/h4OeRU6xfaIG/TaJOrIlaPyIf/fgE+sHfidA2zKBMCY9vuesLEoxU1sK7A5v8kl94QLYa9f2b+1TtN/t1Gl4aeJqZjl8ECAtJ9pBcgla4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706085912; c=relaxed/simple;
	bh=yY8sAq93md3ovEdK199ktE9uN37cL7Xpzn9itEZ1sQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=haQFug5l4Q8AJwnIhZ66VrK3dcvCJ2jSjIe1mojVSFIEUh3TAOhuQoaqhuDjV2ghYXeVWaMzEYs2KdVNT5yJyPLOiAlk4Wrjh3R3bu1ZKaAtmip3VQ6hvKeTMtwjMm3oF3qDlVnfyleaGTg6iTIJcSnxqU2WzX0F2s8JcfOA2k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=a7j/DcgK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HGWQbPzH; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a7j/DcgK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HGWQbPzH"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 2C29A3200AED;
	Wed, 24 Jan 2024 03:45:09 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 24 Jan 2024 03:45:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706085908; x=1706172308; bh=CQtudOrNcu
	QNHGXuMzSQwV4QGeDoCOOxLXNQjCpsha0=; b=a7j/DcgKizyFJ3qXCkv6s6XNYv
	nhBOR1bl8ip1g+ByODFOh+xU7Sa/F6xON1a62S2mfyQSzNi/AcwoB2KvhKwKhAzm
	APagPAWCmKJCzU1mWz082uOod47uFSF/bUb/PJODs+06viNemJiE1KUGolDM0o8W
	FERVfl4AUh5bUiI+1VV2vhFyjTm8QpAj+X1oZh6dgkNND4kBobCGGHD3NinXXMRY
	dWM/6QX8ALsY1UHW7HBdZDQkkNKKVfYPeuXziedszUU3v+xE/pehoIGkDJJkwiYx
	Ip3iUqgGu9jT5lVodcZWp567EP85KGLTaGKrjnpjWPawjEmeCLmjUmXRpzgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706085908; x=1706172308; bh=CQtudOrNcuQNHGXuMzSQwV4QGeDo
	COOxLXNQjCpsha0=; b=HGWQbPzHToNYHCbVbWeAyHEShtEneuWAqdFg5PoEUUiv
	U1zGiGdI4XjinQQT+dKVNHN5FzakQISRSESrR9oQ8ja0sy6mtzejT2G0p4/cL6Uz
	qcMpqGBDVTk7ZLbYWfUf/qwcuhEqjY2YuvXFaYRU9ONepgNp2jLbQhHbTsW3GEI1
	yyjngaXnRF17mW4Dmsl6jqTGZQlL7gehQvje4NjxGeDqF9/auTGROO516FGOvuza
	aKzgaCZ22zXNEFQs0Ka9kMJ9ZQQm2hh1vid3YxKyrPH9JDggQcxrD02ouFJyTw5f
	Vl5GyJIQNKxlKvQnyt4TDy1EoQ/fcn7L/FnnTV3bnw==
X-ME-Sender: <xms:FM6wZYMIRyuYpWYVW3nG-vyFdTX1s3M6j1mNf8V_OTqqpGTTNE655A>
    <xme:FM6wZe9tnvn5OtQCknPb6UTsJE0gSYBvtfYGoRympRcN9XRd1ibXKLtSvAOfOyVc8
    O564mTnuX_wbRvx1Q>
X-ME-Received: <xmr:FM6wZfTg7TCwsrN1BERZvKv6IYy5CcHAF6WbC1EJJezk9U2L5sXSjvWeDzaUwGCqMlfjM9qvKYOZx1HjzW33mRd4iP_zlLNFtPfvimm4ErxOtg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeltddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:FM6wZQtsN8udopAnKji5tKkQQrAeyzMLZjnpRT2nt7HFMNUWZc-iHA>
    <xmx:FM6wZQenErKE8sb-lhPs3-3uEs-GXF2ZJeWr3AUQMwRBziu22C8vbA>
    <xmx:FM6wZU0EXCFyoqtrMR8klXmzLMJg2a9C_vIaBPbNQKc_YLfw5XgLTQ>
    <xmx:FM6wZf69sBHXni7aPu2s07_Rml0Kc5ipzec_5TDCgbP5XRg8xdVIPA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jan 2024 03:45:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 23b38d73 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jan 2024 08:42:01 +0000 (UTC)
Date: Wed, 24 Jan 2024 09:45:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>,
	Toon Claes <toon@iotcl.com>,
	Christian Couder <christian.couder@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 1/6] t1300: make tests more robust with non-default ref
 backends
Message-ID: <a57e57a7c33ff3b2664ccfe305af4d7208a74901.1706085756.git.ps@pks.im>
References: <cover.1704802213.git.ps@pks.im>
 <cover.1706085756.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gbmG25keGpAr1Hpq"
Content-Disposition: inline
In-Reply-To: <cover.1706085756.git.ps@pks.im>


--gbmG25keGpAr1Hpq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The t1300 test suite exercises the git-config(1) tool. To do so, the
test overwrites ".git/config" to contain custom contents. While this is
easy enough to do, it may create problems when using a non-default
repository format because this causes us to overwrite the repository
format version as well as any potential extensions. With the upcoming
"reftable" ref backend the result is that Git would try to access refs
via the "files" backend even though the repository has been initialized
with the "reftable" backend, which will cause failures when trying to
access any refs.

Refactor tests which access the refdb to be more robust by using their
own separate repositories, which allows us to be more careful and not
discard required extensions.

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


--gbmG25keGpAr1Hpq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWwzhAACgkQVbJhu7ck
PpRiMA/+K9eshSgc1qppv8+6X/N0kUuQiRPMgTloj+E9QT+q5pEIq6CEQPFIndL9
v3u8eHLcnRBzimN8k1CTu4XEtzhq6a4b66381aqRpmCzbPkC8nCYA493+/0qDkd0
x7NqzE3MIC5KFDb+RAHHWvk6goSnZZa+gBYO5IFxqRGno0g3K+jmHfVZOfFx5nI1
H0D0VW/JpciXBV4u+cHrut9GdE9GCJsJsS61zjGIPr9wkZzob6c6612UrZee7lTl
LJtLvBf50Bb4C98hCb6JdB/oioiofTSr5WI3g1fvcSSgy+D+WXHw/eGQxZkxEp5w
ejgsR3V8JBbxd2ic/gxQWfbk213QcpJuytOZ12Gc483nV3dNwuGYG7hQI7MuRS4m
LurS+qgnMnZtBFhULQAGbOsXhjh6VBNR8e5ZpWvntmPFK8AJ1QfuxJwUdX7VHF3M
9NO/PDIbHelKki6quL9ku901X7OW08oCS/TNagdc0s23Fw6Wwc81AbvnnbpXiGfR
O/541/nFItXP1+tQuD2lmqUFSzV5BJiR7DVXTY64NClOc8mXl1rbJaqy2gcUHhLA
RknMRYCMmDgwiZUfYP2MzFE6RAjM7HcunPaFcKP4e9aWhxUzwLnFI6MZdr63+zr/
PaOTARUlrn75NeUhbcq2tDO+CyKHMjOYj2CDibwvVpLiZgNuNzY=
=Vcrx
-----END PGP SIGNATURE-----

--gbmG25keGpAr1Hpq--
