Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8469760267
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 11:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706526452; cv=none; b=aOS4zHm9aoh2bkfcNzkzcIatyaTM5QY4crD/tAnqJMXrUhLBuYnau4KleQrOdVMnTunwpDzPunJUZzJRPiDF2XY86bnAe/9uYVyQwRyylaZWho9AixV1Y3qAxWmbZBeb2Y6oEYvoKQr8oQEp3oObc4bC6uAa1fgDJWMqrlO1/To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706526452; c=relaxed/simple;
	bh=8WGLtC/++J3iWBOs7WWrCZbkQwYrv1ree8WU1RCcoYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iShuENTogt1wLxVCdPIgPwimiFDY0EU+UBkar6OAXGVhv0o9xYlxt7L1n/SKc5Xqpsmjjf7vmHMvmfWEHt5LaaK18XxqNhx2a7O+RBm+GVH8E+OPc54MFkPcqwKiYQocFkDDadnK49gtXeuP49SbH0ekdSz2NmuGSqNHaMwpyhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CooDKsRg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aP+4/VyX; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CooDKsRg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aP+4/VyX"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6DE45138009D;
	Mon, 29 Jan 2024 06:07:29 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 29 Jan 2024 06:07:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706526449; x=1706612849; bh=ePpoFF20lQ
	4DJXG+XLpNmLus7+/g9UrMMbgoqe4CVLY=; b=CooDKsRgpy6A9NbZEoHAP/kqLB
	DCZLQ7FKIv+rgBHy/wWmtORXSoD33ztO8jli20e5OcnbwZdVkxLH3HRkGflHvBEl
	uveIrJIvCSkv8oTk1rd9y3Ian8jeOxuAmItpl5ykJIp6+Ko7v2lQ4+/4mKpSzM8b
	bCn9pQwj+RyXANYemaPaZ6WSoViFqJ6dpIEGhX7Z0CBKZvAfsk6rh+Z44/h1Yt4D
	aflZCHQamUMg5IJNOd6DLQK2CF0k9ik3KTbAh1k6kcC50F/N/UFRpfNeW4jXgtRE
	qTJSoikWAgOkdragmgPCzuXKsSikrWd9kzN0lhJxr5fOO3L/9xwnTUoym7FQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706526449; x=1706612849; bh=ePpoFF20lQ4DJXG+XLpNmLus7+/g
	9UrMMbgoqe4CVLY=; b=aP+4/VyXNZsSZAnXV4J0uieQdeLD7lViOxgWenlx66RC
	Ax4jpTpIDlRbC5CwE5AS+KEmXT56b5WDKEVyxPTJ4cv2IpdDMbDsgOgAA8xr0WxW
	eFetjfqZwFWHMWWdXcBxRF59vc4NaP31l4z/v6orLAgbV4CqIlMJvTGzRQr690Ic
	a0GtG+6ITjVvPWYBJnoHGKNoaS38HiV4hP8JeVuNXjP+/9scSZYtrHRld1rf6p+9
	X+iRbSvn7tmoETOeKRR+jCugyQxyrI2+bewh3NKFddihdmP7AjB/K/zGo6qzb53P
	gxWPDi8KODt8KdLlu8ZZvC5bnqHmTA1NvHTu88I7Cw==
X-ME-Sender: <xms:8Ya3ZQx_T2paaHttDP5ZvuG59hKWU91bqeVJuWwmmASbSj1IzJFang>
    <xme:8Ya3ZUT8A3_qqbIFHsuJzzRyitHD589WAYAtabIQVG6AEknUI5IUzSHGVl9tXD1Af
    nCcB2KmAzssqRO_oQ>
X-ME-Received: <xmr:8Ya3ZSXZZydK0YdkSil-DAYjiUTz78edNdJ8qk1dmZIEjPYnj6CECv2q2t2ncgEBoO67heXzNSZv3YKynTj1jjZ-ETdrJO8dK5F4ksyKGX4CMYkx4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtgedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:8Ya3ZegeTp1fUl8OtD3kg3r7RxS9SjabgE8PUNy5UcfjTexDwpDXcA>
    <xmx:8Ya3ZSBdKxSZY0276ybKA3ic9iUXnyAd7ucMZtaYWPlb-ZCVFgjBPg>
    <xmx:8Ya3ZfICiKbE8i7vODlhQbvbYTkwTC6mYEevyApuzLFwyNILeLEPYg>
    <xmx:8Ya3ZU2_CloL-NX_APxYp3XsEW7t6JwOgffiIVYqc07zmjgEbOccwQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 06:07:28 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id af9206df (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jan 2024 11:04:11 +0000 (UTC)
Date: Mon, 29 Jan 2024 12:07:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>,
	Toon Claes <toon@iotcl.com>,
	Christian Couder <christian.couder@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 3/6] t1302: make tests more robust with new extensions
Message-ID: <b72d85df60b1f92e427e31b44cf08c1bf025e11f.1706525813.git.ps@pks.im>
References: <cover.1704802213.git.ps@pks.im>
 <cover.1706525813.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aRMPRaRaSo/JA/bb"
Content-Disposition: inline
In-Reply-To: <cover.1706525813.git.ps@pks.im>


--aRMPRaRaSo/JA/bb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In t1302 we exercise logic around "core.repositoryFormatVersion" and
extensions. These tests are not particularly robust against extensions
like the newly introduced "refStorage" extension as we tend to clobber
the repository's config file. We thus overwrite any extensions that were
set, which may render the repository inaccessible in case it has to be
accessed with a non-default ref storage.

Refactor the tests to be more robust:

  - Check the DEFAULT_REPO_FORMAT prereq to determine the expected
    repository format version. This helps to ensure that we only need to
    update the prereq in a central place when new extensions are added.
    Furthermore, this allows us to stop seeding the now-unneeded object
    ID cache that was only used to figure out the repository version.

  - Use a separate repository to rewrite ".git/config" to test
    combinations of the repository format version and extensions. This
    ensures that we don't break the main test repository. While we could
    rewrite these tests to not overwrite preexisting extensions, it
    feels cleaner like this so that we can test extensions standalone
    without interference from the environment.

  - Do not rewrite ".git/config" when exercising the "preciousObjects"
    extension.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1302-repo-version.sh | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/t/t1302-repo-version.sh b/t/t1302-repo-version.sh
index 179474fa65..42caa0d297 100755
--- a/t/t1302-repo-version.sh
+++ b/t/t1302-repo-version.sh
@@ -9,10 +9,6 @@ TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup' '
-	test_oid_cache <<-\EOF &&
-	version sha1:0
-	version sha256:1
-	EOF
 	cat >test.patch <<-\EOF &&
 	diff --git a/test.txt b/test.txt
 	new file mode 100644
@@ -28,7 +24,12 @@ test_expect_success 'setup' '
 '
=20
 test_expect_success 'gitdir selection on normal repos' '
-	test_oid version >expect &&
+	if test_have_prereq DEFAULT_REPO_FORMAT
+	then
+		echo 0
+	else
+		echo 1
+	fi >expect &&
 	git config core.repositoryformatversion >actual &&
 	git -C test config core.repositoryformatversion >actual2 &&
 	test_cmp expect actual &&
@@ -79,8 +80,13 @@ mkconfig () {
=20
 while read outcome version extensions; do
 	test_expect_success "$outcome version=3D$version $extensions" "
-		mkconfig $version $extensions >.git/config &&
-		check_${outcome}
+		test_when_finished 'rm -rf extensions' &&
+		git init extensions &&
+		(
+			cd extensions &&
+			mkconfig $version $extensions >.git/config &&
+			check_${outcome}
+		)
 	"
 done <<\EOF
 allow 0
@@ -94,7 +100,8 @@ allow 1 noop-v1
 EOF
=20
 test_expect_success 'precious-objects allowed' '
-	mkconfig 1 preciousObjects >.git/config &&
+	git config core.repositoryFormatVersion 1 &&
+	git config extensions.preciousObjects 1 &&
 	check_allow
 '
=20
--=20
2.43.GIT


--aRMPRaRaSo/JA/bb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW3hu0ACgkQVbJhu7ck
PpTo0A//SrqBJDcyGa05mOP/0OqQt/9lzR3rRQEzSB8gqNTByTihFpHuMGxP04D0
CkJnkiJ0QyGiM9XwvlQHGzRMH0BcEglFHth2EK7Go4LM8+qGCQPRnIMCySBn5nPn
SxPFTxK7ui1aGzsdjP/48J2SnZqRzlVqimj95C+h0iF3QBRuFiAM6rGWZMPb6nKQ
HG10vsJcW7Az+eoBuopA4jtVM2panWKWkzHcmgV+aXTrKOR1duPNk66TiyXrAAqB
49m17IZdd38i7mmHikurhGpv17FTQuct+Q/m8tuRSLtF3o60Mzq1sHKkaLflf9hK
4pTCH0bK2G1YCClb2oL8KJW1HM414fS9IH97/xevuad8IbAuSYnYWbYUKduwVz14
lx0YHcKD3GlcNQUpBCtIGL/ScFZ53yWxU6LMuGiO5481Ezet23YMvmuF7pKzjDfo
vc1gUXNeYGBXzIkKf7WF0eVrRfzgIyXIbttRz51Bh2TzZwMFlzD4TH5xYlOJIF7t
gA6BoroWn1+rkyIZu0htWrWSL1/HFsmnJ6kdeI5Uk5IjkQ37BnlHRjniunZfP2QQ
hYBXYuonR8L2ybkA103YxK2r1atxIl7in6/BW/6n2LZ1hEs03RHlRX+16QVjRk3e
E/ZIxrtbWBwqWpIjpDMpsHITXqymFqvxA+mE4r2hf2Msi+T51qI=
=fbCN
-----END PGP SIGNATURE-----

--aRMPRaRaSo/JA/bb--
