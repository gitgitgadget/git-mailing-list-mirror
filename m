Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254505FDB5
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 08:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863118; cv=none; b=oxV7Gk175jOR9CjecHjHn0DR17RAvr3z3wFmdAt3IN5KWGqVKf/zyB3LOASi5odLptu9bGHMx0WzIoa6LfBUaFPnOOtpPo9fl+c0+Tl/0ZRWB0QvQzqny+qSgJ3Qr/Rifr5iJqCH9csp+42u4Ne7NHigCGZuq6OqRzvm6CYzEDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863118; c=relaxed/simple;
	bh=gIOLhQV02skFXk9plHwyOzJ9ufXsx7/OEZ1yQb9pC1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/uopG7EaSSzo1tBaQfF8yFj+33tjILkDZt/uVJoeYPgvg0qo83TiK1nE/VE1adhmV6XBqZAzTGU1OJS0F6Wmo6lhS7CpnW/Qbq7l34qS+hqGh5gP10fxesNR2gZyQwN6z23Ymam49KF3pWA8jvqFl8VNVPpFz6hXJA72DDlBr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VSTKsxA+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cNqOPxqr; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VSTKsxA+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cNqOPxqr"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 10BCE1380083;
	Fri,  2 Feb 2024 03:38:36 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 02 Feb 2024 03:38:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706863116; x=1706949516; bh=g3ThscMiDX
	4EJSd9CbaeU5CL0MHJYkI5VIdr6+9+K3o=; b=VSTKsxA+CaEWE4gFpeocTvVBFD
	inZ6/O9rugukoKNx/GUDr5if1nxq10zifiZ6XHmeYGUu6Ehu4/YO7OGGKxUc+imk
	DNOZGf9KgnM6NzS0vOn7LJAw9rKl1VR8JPjPHZNphDpowjnnVfqGbfWverzKOpaY
	FeCp3zLR3tOuUpuEUOrWgZNqEEMsph/ajVianZ30U4diLzscQWtQoMgID2eMgRuM
	A7iDHxQ4UTkKLGuDZEr/+QUtLfe8GJVR2dbYyBGrmTKdfcWuzi07+trunsPybDdI
	CJ1zCBvHIwBNgAfzgNSKb5bhUvMBIWa9mqtcUn9G5GfsKYfez9mRDFdNvynQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706863116; x=1706949516; bh=g3ThscMiDX4EJSd9CbaeU5CL0MHJ
	YkI5VIdr6+9+K3o=; b=cNqOPxqrWeGF3AwzhDZ520LJRHLt+zL9MMmQR7O/SNRG
	921DCxG8iYDMu4gRSdp4c2ZfTccAo+ELYwOb06RiqmXGD0IJaKO5f59N8lAC+gPB
	im9+er7ZbNmRCVbD3w89HIKwkNdgyPmfRuhrEgNnE2xxslqHuN0xDszFiKd/wBlm
	bJNx9rfYfO8CM1MqyyzTX2TCHGZBrvcFkk4QiZf09BRaikj86eUdE33zx2lX7fVs
	KXaevjNcX5CmoZeowOlQyHfHlTCzAVts2xxN/PHqPER2fJ9VbJ4aNknTNcikG1Or
	LXZSG2E3Umlu2au4bW6PoabdQL5vF/JLHmZ6aU8+eQ==
X-ME-Sender: <xms:C6q8ZaZkHim-GcbFp9xbx9zQSlJtHT5s1iiY7TxNwQMtG_uriEJAmA>
    <xme:C6q8ZdYaXNW7dMu-T2mNnqvgpxEUVspB-21MqOESuNijt6LwEZU76qZw6h0OZ9C_o
    fvAUVQu4nfEury1fw>
X-ME-Received: <xmr:C6q8ZU8J_OAyycotmGMUIHpys0piS2j2wkp5f7eCKE-i8Jsj7ytCg1Mxs5HgoHqjQYSX_YS7zY0G_4sdNCyjWos2uyMZCE6hhezaxbcI-c21jw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedufedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:C6q8ZcpcZJfd5b5YUS6crgZLLkmn0xaGAcIeVy2XWPuo7ZwrOdUGqA>
    <xmx:C6q8ZVrClJNXhQErrE-z7jPVQDxW3pXaDX4Rgex4nW6U-t9mjIHZEg>
    <xmx:C6q8ZaQ40jT5VejJLYKiqXtgEPlzTqSdGrzYgZDNKzBpI1RDCMBOnw>
    <xmx:DKq8ZWlnGAEPeh0N-c3jrQXY-GDIsrnXqRwowgUTas9miT9IgR0sqQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Feb 2024 03:38:34 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a4abb670 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 2 Feb 2024 08:35:11 +0000 (UTC)
Date: Fri, 2 Feb 2024 09:38:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Han-Wen Nienhuys <hanwen@google.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 2/2] ci: add jobs to test with the reftable backend
Message-ID: <63eafc9f5bd062fb74b4bb9d9c0dcd7a11125766.1706862705.git.ps@pks.im>
References: <cover.1706601199.git.ps@pks.im>
 <cover.1706862705.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RlZxXIluHOg/uUvX"
Content-Disposition: inline
In-Reply-To: <cover.1706862705.git.ps@pks.im>


--RlZxXIluHOg/uUvX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add CI jobs for both GitHub Workflows and GitLab CI to run Git with the
new reftable backend.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml | 9 +++++++++
 .gitlab-ci.yml             | 9 +++++++++
 ci/lib.sh                  | 2 +-
 ci/run-build-and-tests.sh  | 3 +++
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 4d97da57ec..1b43e49dad 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -266,6 +266,9 @@ jobs:
           - jobname: linux-sha256
             cc: clang
             pool: ubuntu-latest
+          - jobname: linux-reftable
+            cc: clang
+            pool: ubuntu-latest
           - jobname: linux-gcc
             cc: gcc
             cc_package: gcc-8
@@ -277,6 +280,9 @@ jobs:
           - jobname: osx-clang
             cc: clang
             pool: macos-13
+          - jobname: osx-reftable
+            cc: clang
+            pool: macos-13
           - jobname: osx-gcc
             cc: gcc
             cc_package: gcc-13
@@ -287,6 +293,9 @@ jobs:
           - jobname: linux-leaks
             cc: gcc
             pool: ubuntu-latest
+          - jobname: linux-reftable-leaks
+            cc: gcc
+            pool: ubuntu-latest
           - jobname: linux-asan-ubsan
             cc: clang
             pool: ubuntu-latest
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 43bfbd8834..c0fa2fe90b 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -26,6 +26,9 @@ test:linux:
       - jobname: linux-sha256
         image: ubuntu:latest
         CC: clang
+      - jobname: linux-reftable
+        image: ubuntu:latest
+        CC: clang
       - jobname: linux-gcc
         image: ubuntu:20.04
         CC: gcc
@@ -40,6 +43,9 @@ test:linux:
       - jobname: linux-leaks
         image: ubuntu:latest
         CC: gcc
+      - jobname: linux-reftable-leaks
+        image: ubuntu:latest
+        CC: gcc
       - jobname: linux-asan-ubsan
         image: ubuntu:latest
         CC: clang
@@ -79,6 +85,9 @@ test:osx:
       - jobname: osx-clang
         image: macos-13-xcode-14
         CC: clang
+      - jobname: osx-reftable
+        image: macos-13-xcode-14
+        CC: clang
   artifacts:
     paths:
       - t/failed-test-artifacts
diff --git a/ci/lib.sh b/ci/lib.sh
index d5dd2f2697..0a73fc7bd1 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -367,7 +367,7 @@ linux-musl)
 	MAKEFLAGS=3D"$MAKEFLAGS NO_REGEX=3DYes ICONV_OMITS_BOM=3DYes"
 	MAKEFLAGS=3D"$MAKEFLAGS GIT_TEST_UTF8_LOCALE=3DC.UTF-8"
 	;;
-linux-leaks)
+linux-leaks|linux-reftable-leaks)
 	export SANITIZE=3Dleak
 	export GIT_TEST_PASSING_SANITIZE_LEAK=3Dtrue
 	export GIT_TEST_SANITIZE_LEAK_LOG=3Dtrue
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 7a1466b868..c192bd613c 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -37,6 +37,9 @@ linux-clang)
 linux-sha256)
 	export GIT_TEST_DEFAULT_HASH=3Dsha256
 	;;
+linux-reftable|linux-reftable-leaks|osx-reftable)
+	export GIT_TEST_DEFAULT_REF_FORMAT=3Dreftable
+	;;
 pedantic)
 	# Don't run the tests; we only care about whether Git can be
 	# built.
--=20
2.43.GIT


--RlZxXIluHOg/uUvX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW8qggACgkQVbJhu7ck
PpTjLw/8DkwBVez6Bd8gX9Iy+hSuDEwWEap289usGBbTMqLfXGR/Fyo/7wSFLO0t
cTVyzi+I5xrvQyZeZpQ4TsV3KNxttQpJY0DFnOEKNtIh23BJ011PPe5nbIVt0Kkv
9xT5AxRL54xxU9p9BffBs666KF/PMhCtc80QETvV9+won2C+SdZBmRv3wLwXrGGo
f/YkJD8GJVczr2WRMGsX0s/iypfdlSUOHeyis/hR0gb6JXXYbq4Nyo+Z++17kuR2
8MhSyGwA+mz2JmfgBYVQyz69u1OuXp+xD9//kdZgEt+HvAze8xiA39S2HNEtKoda
zz+FBJU7iuCxCqyJHwm+ONiatyjoW6JDvzNsUaSjbcNcWWOdxNy8YcupHbpnHfUU
Q4G4KzRgRp2IG5P83VVyDHNumQC+IRQX/7sLi1dJ/iFECFkuFQg0CTjfEX5Fk8XH
+1F2ywSCEmTBBOXB1oAIBssJdZg+V9sP8ESYmn8KpJCvL8bsUw4QhPQjYxiKxVBu
E9+G0h0ammdICkIMd/nrWzmsqCdt06NIPWsoBivyUVMYBPZA0MY+JOenGdJgfIsp
0HYBwIi+tW2KqjpQ7FSb+mbtzpV77ZhF56Bio6u6QiemKkh94ZpQjf4uaqQz807L
1mHHu0LUYYiKIIqZHcb8tXgyoysUne4q5oPdxOvJoprNwl80jNI=
=Qd2h
-----END PGP SIGNATURE-----

--RlZxXIluHOg/uUvX--
