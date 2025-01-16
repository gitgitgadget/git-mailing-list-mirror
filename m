Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F8D1DDA14
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 09:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737019054; cv=none; b=k0V+Cmkla5nOKaQGS/CI9QUxj62SOouhY8N3Ww9sfTlM0LH0Tu9M44XpvgPXczLD6fGfneTlu0YR2Y7PzsxBW06c60J0Bo9SPZFxK6+gjbt0p1d9dmc8wisqMkQM7ySfB+IxL7A3PPLSju01EzMtNLMlcSwkvQ4+mZJpjcQu7wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737019054; c=relaxed/simple;
	bh=Jq7bRZnrmGVKTQRmFkmGcWet/89CJsgYJ9vRn6ZK1K8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FqRfX1ZUdAILGVLV6qLHY+s+NaeQbQY+AfWXCXrOPGzx88hml5eCQkOU8xcmnnCXDY07xVNZKUBOnpWjvWT1NvOMbMmXzyAajtt1I+U/2IccqTHrM7L/kVTdETWYWsLQN6eiRUh/upE4//nd8zCZa7i8nsFVcNCGLM/48yx0Iss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SkR1WBM7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p/Eot3dB; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SkR1WBM7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p/Eot3dB"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 799B21140158;
	Thu, 16 Jan 2025 04:17:30 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 16 Jan 2025 04:17:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737019050;
	 x=1737105450; bh=z3C/vgZ10dW1DRUKWukLqo3OgMq1u5pRScbzP5uXm0o=; b=
	SkR1WBM7b2eQIlF1s1tkhO8S9n/DsiD20vXsNHDDJZAxb6zx2q9KcslsnFdPVWXF
	/hzJDTsFe7lC1CSSYbxZEpoP+sv4+vEE6zthxGUP5FfhxHflNXnN2+VM2W/niG2c
	0pSaGQFjyM4PcZ/6kCaGwmm52HF3m8bTXQtZED0twdjcV0eD86gJ4Mw6noTYku0f
	HQfc+Sh6FFmbo5unJp4hxc6r62SXNpFtCVo0Lj3AMWAcVy9dnU3WTonG/EkBHX/a
	x9YdL6aL6au0RLAxXSs+qGd1+T9U7/NIxrYOC9AiRjmL5I2Rn+vE8+FXUhrMieYn
	hPMB7uPa3/XAiltATafYEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737019050; x=
	1737105450; bh=z3C/vgZ10dW1DRUKWukLqo3OgMq1u5pRScbzP5uXm0o=; b=p
	/Eot3dBtOikitZF7GuLnuyvv3FxeAnnR0jd4Hds48cvWDwUY6edem+i2aWIY6e5r
	znybyUXy5aOAWISE4QI8ugfVvM9BuX+Od0p4uKwgm8yHrhF8eFm0fFvdMaqN0xTC
	uvNgrEFeBR7UvmLJMsNSDvLqhs+IaCwpLoL1SXlxjX6mFXavR8ubziNI1k3Heqw7
	YJ7iyBTjrXBkGvkAIBM6e9ajkdNHthSG8+w5oKzgShzf5Mx/qcHWYBtXqcj3dH7D
	MU+xs/DqW58jy0iLQHJlXLkPoDc/vNX8DoFHSznd+0ZQJbDOdYeF4HX//JwQHRXR
	rPNSNkg9AGL3/Ls8SHjeA==
X-ME-Sender: <xms:qs6IZxgq296XFx12kpMOou4mlcsNXlRCz9NjS5CB2IhmAhjRnjz8LA>
    <xme:qs6IZ2CYOLEGHub-tY1kXOY5SvsmnRhqE3Lr0Fa_ERCPQqzaU5kHis9YVLiy2KQ7E
    Iio6OY7bWgg9MdKDQ>
X-ME-Received: <xmr:qs6IZxF53_1ByS9Q6928UV7LovUvDN2GSMvvFt7vpVu8xyA1pzMsdWOswoZw9L5VZO78u41fS7onwDnVYFC54_9qp3eWtt5nXHx1xwziJA37kCqCIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:qs6IZ2Q-e33RsLHRIR3TSd8LUewLRxROXm4rvk7evCyGDpMtql7ljg>
    <xmx:qs6IZ-ws-58ie_ZtkhsD0Y5OAR5z_imTWTmIojA5zBXpdCWGHy3D7Q>
    <xmx:qs6IZ87ExFoAf6ogyTmirDltyZEImc-AgL5cokE1DCHP5q16OrDTLg>
    <xmx:qs6IZzxxHvOmaBawtFSxuJNUkjm_PG6E9a6WORPjcdSxx2a9WXYhYA>
    <xmx:qs6IZy-2BzMYjE_nmKalOCsUEgzlPArNQj10WOEXhloBaRm0fKWmq21w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 04:17:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 46883c11 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jan 2025 09:17:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Jan 2025 10:17:22 +0100
Subject: [PATCH v3 09/10] ci: switch linux-musl to use Meson
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-b4-pks-compat-drop-uncompress2-v3-9-f2af1f5c4a06@pks.im>
References: <20250116-b4-pks-compat-drop-uncompress2-v3-0-f2af1f5c4a06@pks.im>
In-Reply-To: <20250116-b4-pks-compat-drop-uncompress2-v3-0-f2af1f5c4a06@pks.im>
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
2.48.0.257.gd3603152ad.dirty

