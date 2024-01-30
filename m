Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F5656B9E
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 08:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706601941; cv=none; b=lTmG9FJz54y7DbdvdB62XJd5NWFRbdnZFzqwI8AUtbLSzjGvVIhxSV0UkW3P8Rta+2pu/x9cionRfTTdxodpIcJhSG3DF6tjxZGUPSbfE5BSlnqo6WEKlsGtrGnLrgO76zV3Ismg1Ky1xl5jT84erHWOpT8GESWK0H63evgyjjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706601941; c=relaxed/simple;
	bh=zgHhZ47ZiOpqZl+dhyQc6hWZlKRhT6Kfhi8YbcxTijo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfHL43CwvwNjd/6U9fkTZMezQMoL652kbJt1AHn07l5maYVPMpPd+1xtgr2DAKi5V1u5PtVrk0lAgpHmrBGB3cartT5Nrgn2M1AIpgBoJQotVkBH6vcvNV5HpXkW9AcrFnls3bTvIUibmGqLgu+Gj0NDO5TRbApVwrN8IJ62ZpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fNe6XjUM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qDVRMbJM; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fNe6XjUM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qDVRMbJM"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 319113200B80;
	Tue, 30 Jan 2024 03:05:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 30 Jan 2024 03:05:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706601937; x=1706688337; bh=LmlaslAP1m
	+BgUSQcSNdWEpgmY5gfUxvstlK6mVua4Y=; b=fNe6XjUMg6khtP+yCvvrStVOaZ
	PudMiR/lyyfEt3mFGUJOJiUy7SHjA4H3A6/dzWUnqbO3Agqs8weXYVCtf4xycU+R
	k7u/hUzFnFgUrNkjoFQq//3Gm84MZzdwkDBc7w58C58eneWHQRHv8GhEJ8S8x3G8
	/cEeNHYezC5ESSFUy+S3hyy646SOCprMG4ym2kD+/5Pg8lh46q3ciTvj1wKTxlqS
	zXEvuIWbQ4hBGP2QFdbgcXXT3Wax8CmszR+IIUdBXts6zI9nI0xl5armzxIAoqNR
	y5hrSCG5zwoJjMdMlLCRwcjdHRZfA5A4Z+aQo3eGagTKIRYh0bD7iiZS39kQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706601937; x=1706688337; bh=LmlaslAP1m+BgUSQcSNdWEpgmY5g
	fUxvstlK6mVua4Y=; b=qDVRMbJMyAjdEMFbeZuSlLXWZ3hV3hhJSbYz9nfQ0hvT
	dEySqNA4XPPsgYmdnClcweWk3amgcuEEan52lgABPSpXIyTOb1bt1qwH7EPLSHkv
	6OHAESsg+TxL0G8Iji2f8gPZa+XHzGcMB3PbqASZ7l2iZLQr9yyLPPxRs+roVAKs
	zwOYRSLogkof8+Qmf0mT+nK3+SucKe9RO7URFPbuQE1Qc5oVvPb1teZ/EuomzsYK
	C+PdU0GsFANdiQPC9KjjMyqsQLa+1gUX1iCTNlBWs/MS+2M+3dfvO19wyag0g5ho
	47Zh4SqgGMQsVYUAeYf/dbTCqepTPLaLeJIXjnzh1Q==
X-ME-Sender: <xms:0a24ZbZ0-WIaMBJasnnuWsrLtgwTi22hKHJUeWu6-RK9cwE6xZ3zag>
    <xme:0a24ZaZR0PZL66Hqtw2UFVIGXnXGXK85zjm_4yxrWPs3NmK51EDHQ7c7n5WdbMVIH
    RTk7KzjwB57iW8cCA>
X-ME-Received: <xmr:0a24Zd8_dnDvKdzpavx5ADqnuBewImGXf7f0KXtFAy310kuI2f9HBNExESFIHy0Jo4LdI_2rudIo4bhUEQrjx9xMjWCZo9FtIw9g4eblTVFIdjY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedthedguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:0a24ZRr4MqhUc4VMyHRxh4WpcVw-hOQcx5pjhkbO8U3LHJadabPpTg>
    <xmx:0a24ZWrD1uikzLgQPezk4tcSFB59IPlARBdNc0C_qcLSUE5I8slcBQ>
    <xmx:0a24ZXQMoakoFi32sDm-AH-oXubaqgMf8tzRzWtp6npXSf_cLPd9ZQ>
    <xmx:0a24ZbAsw3P6vSK19eMTmUtjuWSWBBo38AcD5azGcfVeQfRyTw3NGA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jan 2024 03:05:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8d1e21e1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jan 2024 08:02:19 +0000 (UTC)
Date: Tue, 30 Jan 2024 09:05:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH 2/2] ci: add jobs to test with the reftable backend
Message-ID: <bb694fa132fe602c92a7e96d5ccf3fef7986fff8.1706601199.git.ps@pks.im>
References: <cover.1706601199.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xS5UcRnUsZJc/6Be"
Content-Disposition: inline
In-Reply-To: <cover.1706601199.git.ps@pks.im>


--xS5UcRnUsZJc/6Be
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


--xS5UcRnUsZJc/6Be
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW4rc4ACgkQVbJhu7ck
PpQbDhAArXxhRhLi/gc9RereIO2iVMS1gsP8BqXBK1kz90YQL+44bW98kd0TQf1h
cymlGhBTmvC5SvXERDpJXaEF0oov4kNVZruKoh0ER9GCw+gy5LA7HQGFluim7Osr
e9QqxDtHuozdh22IShwKUvesng6jzRXxM/2tYre3wqdm9oGMno8NY6Y9IrVmfiTQ
0Ojoj3sIV4+N8xbn9XxDHC5xE0o0ETKq2EAPJ8Wa66P7hDZwu6LKUMQpDoUzmS9U
VDQ2nmStvWpNsgNPi/WNjhIWHNa/xgr1FJDyY1eDsBYhiXFN5g2uCFi0nW7QOhPw
iPLCG7LfedLB1NCyIwHqw+n+BRM8q636B8imtr3+STWZ9DRJijrWbwNCk95ta3f6
QwROioKj1walBgLmrOCcvIW2n8a0uXMpHfX36Z9PP9ExycPEmcngNP7rmtn7OlNO
2WsF5JO/0vlMwCPqhTahcPHl5ECKHWQ/ugSOn6ZDBttqN8Uyx0rZHN4NL0c4A3rI
IRaZXKXi8NTK73RPQrsWyR0Ubz9FdiVOTP9TnKlFfwRS92mZO/01gEU9vm3ntDuS
z8kBBVr7edzU6CNpT9xVKegKtIMrTA17kNu5MCftU3A26qHzVOJ9Rov2yrzeoO2n
vnPjca9sN06TUlPO9aPTg5+Ot6/EiFTwR/O+n45LW1WBRszdgTc=
=GCOX
-----END PGP SIGNATURE-----

--xS5UcRnUsZJc/6Be--
