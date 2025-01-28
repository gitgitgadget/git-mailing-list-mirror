Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11841DE4D6
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 08:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738053702; cv=none; b=uvBVDON0vV0SaYWjD72dzuoJBRBtuxjWQ2lcK/U2JsaKUd8X2FlD60EpULFMQ6JFvRhEfno7YLiMMp0RPdN5cPhjRykuA/B4wpYH9B19i7BYne5t9i+tI5qJnZDNtB2oA24R3x+W32eZWTqGJE+OTZaqklKnwhw8R2aqbE71lgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738053702; c=relaxed/simple;
	bh=pDVeIUOp8RhsvXDDwNaHQn5xHR5ZrDvGFX4F10o7/7g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JORCZsW2Ra/r1jqV7r19ZZslBULe4u1EFQXJKlAWqU3daQrGHHxbqkADgn0ZzaR0mYA790VmGVRZ79lJ7adiVdvlU6/zNauJqgsol98TLsKGgLWmzsfVuUlDz40yaB8Nep5pq4Ah5EKcaE8kJrJn5K3go7BAUC+lGGN3jnRz+Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RtcLIsmF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=idD1F5l/; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RtcLIsmF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="idD1F5l/"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id E675411401E8;
	Tue, 28 Jan 2025 03:41:39 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 28 Jan 2025 03:41:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738053699;
	 x=1738140099; bh=pqmoFcF7JhWM5WQL7oNJTmdZpvbSHk1K7Q4V+gnomUg=; b=
	RtcLIsmFshee6NpQBQ3WOdcLdP41+6H7y3SoIgzo+xLpNZ+eUVxofnvX5UJeBD/F
	IysoVOgR7Ql2OfegQAXWBo5KPCVwReP8p79axFneHNBxBeLCF9cTvEWj2HZ32ffO
	k52vIsTwp6cKBFjrRue4mCYI9LrlA+FEpYX8kDO01qNkUk8tHvs44mlihXR/28wW
	SuFPRlaEct6FfpPushCEkOMWzxQfkXW9z+N+7tHlWvxF1J27INrKnfGuRjTZgNYz
	0u9PZYGCGs1EnCbhf17CgjUk1oTMTL9IXcNKzz5Iffrow+4MgYV8EyKeYDSyTOcv
	q02t540yfQsMDqMXWa1+bA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738053699; x=
	1738140099; bh=pqmoFcF7JhWM5WQL7oNJTmdZpvbSHk1K7Q4V+gnomUg=; b=i
	dD1F5l/lM6sPtRXDGykP4ry93e3t4hKLSpLexKowTkDPVxqQf7lzM3M4Yo8PDqWJ
	2vWVt60DzaGczUpG7i5dUeaNTRiBO5IyuRRPvLmAVetL8zZamHvbiSaxnsFXRPpU
	XdfIa4f7P6vh3d/Br1ft/rHkouhK226q6qGDaUIpa/rprS9pTAsYJk71p+PkmXaA
	KgooOoZdNKJ0kAG7RmrRIOyV03kuVe99nbmdJpIxGiyShBr1Nv9tLAVeNERbdJHC
	5TBs6fW9e97PzflrenKlJXcEXgcRIroTxqINqN4o3K9iYj2QTvA68bNHJO3d7ysn
	yNU+JT/rnajB4TE4unJxg==
X-ME-Sender: <xms:Q5iYZxWBsR99V33ulA9IHtvSuG-G8h8qXIeFerVXMQy90l8gpHvIvQ>
    <xme:Q5iYZxnw3nUldbYvIaVIogXRHNHUIlgNoTbmVQtJs8xSq1sHn8dTnx9KuaIydhM8e
    rF5v9bI4r9DWTRgHA>
X-ME-Received: <xmr:Q5iYZ9YID3id7nS4MWuvI8mXcBsNpi-9x58D7dP3Wb_n2TkO283wvI3oN3ihH_U53FkRq52GBhzDoOde1NLDYCjaR-UODWLf40k0dQJnBSk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudehieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Q5iYZ0Vzgp4iRdxFt8iRENxu5D65jHRmMKTjjM4uSIkPLpX-drI96A>
    <xmx:Q5iYZ7nW-gYqBmE9n1rEGXoUTpzOW0ziCNUw7Rh4arpu2qkpYKG7xg>
    <xmx:Q5iYZxc_Kjd487izFM9sDqKntLfAhiBGbIX-lcFkThBylVV-ydV6-w>
    <xmx:Q5iYZ1EYff9kVI7m4AnwVn5NcGHrGuFakmGmZUxr7bUp2LMSNSJV1Q>
    <xmx:Q5iYZ5jQnKaGb6mLnrC5WJQhX6PTHUgHZK8d7w1QrjlX-sl4XahQdwB0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 03:41:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 64a9be1c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 Jan 2025 08:41:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 28 Jan 2025 09:41:35 +0100
Subject: [PATCH v4 09/10] ci: switch linux-musl to use Meson
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-b4-pks-compat-drop-uncompress2-v4-9-129bc36ae8f5@pks.im>
References: <20250128-b4-pks-compat-drop-uncompress2-v4-0-129bc36ae8f5@pks.im>
In-Reply-To: <20250128-b4-pks-compat-drop-uncompress2-v4-0-129bc36ae8f5@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

Switch over the "linux-musl" job to use Meson instead of Makefiles. This
is done due to multiple reasons:

  - It simplifies our CI infrastructure a bit as we don't have to
    manually specify a couple of build options anymore.

  - It verifies that Meson detects and sets those build options
    automatically.

  - It makes it easier for us to wire up a new CI job using zlib-ng as
    backend.

One platform compatibility that Meson cannot easily detect automatically
is the `GIT_TEST_UTF8_LOCALE` variable used in tests. Wire up a build
option for it, which we set via a new "MESONFLAGS" environment variable.

Note that we also drop the CC variable, which is set to "gcc". We
already default to GCC when CC is unset in "ci/lib.sh", so this is not
needed.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml | 2 +-
 .gitlab-ci.yml             | 2 +-
 ci/install-dependencies.sh | 2 +-
 ci/lib.sh                  | 5 +----
 ci/run-build-and-tests.sh  | 3 ++-
 meson.build                | 2 +-
 meson_options.txt          | 2 ++
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 7f55f8b3a9..83bf9b918b 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -394,7 +394,7 @@ jobs:
       fail-fast: false
       matrix:
         vector:
-        - jobname: linux-musl
+        - jobname: linux-musl-meson
           image: alpine
           distro: alpine-latest
         # Supported until 2025-04-02.
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 4976e18a05..f737e4177c 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -67,7 +67,7 @@ test:linux:
         CC: clang
       - jobname: pedantic
         image: fedora:latest
-      - jobname: linux-musl
+      - jobname: linux-musl-meson
         image: alpine:latest
       - jobname: linux-meson
         image: ubuntu:latest
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index d1cb9fa878..5ae80b0486 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -24,7 +24,7 @@ fi
 
 case "$distro" in
 alpine-*)
-	apk add --update shadow sudo build-base curl-dev openssl-dev expat-dev gettext \
+	apk add --update shadow sudo meson ninja-build gcc libc-dev curl-dev openssl-dev expat-dev gettext \
 		pcre2-dev python3 musl-libintl perl-utils ncurses \
 		apache2 apache2-http2 apache2-proxy apache2-ssl apache2-webdav apr-util-dbd_sqlite3 \
 		bash cvs gnupg perl-cgi perl-dbd-sqlite perl-io-tty >/dev/null
diff --git a/ci/lib.sh b/ci/lib.sh
index 8885ee3c3f..71d85ae85a 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -378,10 +378,7 @@ linux32)
 	CC=gcc
 	;;
 linux-musl)
-	CC=gcc
-	MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python3 USE_LIBPCRE2=Yes"
-	MAKEFLAGS="$MAKEFLAGS NO_REGEX=Yes ICONV_OMITS_BOM=Yes"
-	MAKEFLAGS="$MAKEFLAGS GIT_TEST_UTF8_LOCALE=C.UTF-8"
+	MESONFLAGS="$MESONFLAGS -DGIT_TEST_UTF8_LOCALE=C.UTF-8"
 	;;
 linux-leaks|linux-reftable-leaks)
 	export SANITIZE=leak
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 964322055f..643c6a9dcc 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -55,7 +55,8 @@ case "$jobname" in
 		--fatal-meson-warnings \
 		--warnlevel 2 --werror \
 		--wrap-mode nofallback \
-		-Dfuzzers=true
+		-Dfuzzers=true \
+		$MESONFLAGS
 	group "Build" meson compile -C build --
 	if test -n "$run_tests"
 	then
diff --git a/meson.build b/meson.build
index f9e6a051e0..35b3c51fb1 100644
--- a/meson.build
+++ b/meson.build
@@ -664,7 +664,7 @@ build_options_config.set('GIT_TEST_CMP_USE_COPIED_CONTEXT', '')
 build_options_config.set('GIT_TEST_INDEX_VERSION', '')
 build_options_config.set('GIT_TEST_OPTS', '')
 build_options_config.set('GIT_TEST_PERL_FATAL_WARNINGS', '')
-build_options_config.set('GIT_TEST_UTF8_LOCALE', '')
+build_options_config.set_quoted('GIT_TEST_UTF8_LOCALE', get_option('test_utf8_locale'))
 build_options_config.set_quoted('LOCALEDIR', fs.as_posix(get_option('prefix') / get_option('localedir')))
 build_options_config.set('GITWEBDIR', fs.as_posix(get_option('prefix') / get_option('datadir') / 'gitweb'))
 
diff --git a/meson_options.txt b/meson_options.txt
index c962c0a676..e9f8e990e3 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -99,5 +99,7 @@ option('tests', type: 'boolean', value: true,
   description: 'Enable building tests. This requires Perl, but is separate from the "perl" option such that you can build tests without Perl features enabled.')
 option('test_output_directory', type: 'string',
   description: 'Path to the directory used to store test outputs')
+option('test_utf8_locale', type: 'string',
+  description: 'Name of a UTF-8 locale used for testing.')
 option('fuzzers', type: 'boolean', value: false,
   description: 'Enable building fuzzers.')

-- 
2.48.1.362.g079036d154.dirty

