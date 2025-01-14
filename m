Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72110234CE1
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 11:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736855877; cv=none; b=ADw0zF5ArEATdRByxH2B2i7QsKTBy/Hi5nRKj02sWMOg7BGb3D3EulD+BAkucbWWyG29wdCDaGpTXYTZJPATUUCTzEypXNBsy+K1vAo0gsUP8pmJEdfbs7Ph3wNn4G3wCGk54jgtmct4F9fXOPqpKdUxQ+PWFHgSGxQNQMHqpWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736855877; c=relaxed/simple;
	bh=EEdAPCE3r4ALi0QR7iuoKOy0IsrWtJF0in86h86z9kE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uQtMDYHaydsfsWqztrK6ByewdbwN/eeUkQMw772ePqfZBFSeGDKo8bPlC9OW85N7VmTPMrWHm0gRUmIe4vf5V+oMJs++U1Bi/PlFItO08FeBV640hgWw47/ERjksZ+t6L9ZQOQLRsZMPoTjy0573OKMaw9EZ1JZlUlCgmW3mkSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jIVLnrce; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HbEm1h4Y; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jIVLnrce";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HbEm1h4Y"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B7DC51140141;
	Tue, 14 Jan 2025 06:57:54 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 14 Jan 2025 06:57:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736855874;
	 x=1736942274; bh=MI4hu3GHj3d7JayYXZT+VUBPRnsNKflwzpJqzkbo5ZI=; b=
	jIVLnrceMQFK3x+iif4PUktiU/3Hi3xm7vKkGdEdQvOODgCzcDciSDL/1dnsAm0O
	ZydUiN6PZnV48goYYrFWx+rNQjdile5jwwaJEee5y5l7RIUUlNfMgbI8+ZPeXTZg
	sN3M6tBhFP4+Qt52yT1Otb6CeUC6Z0LwIK8buuAR0oHxHF/o8Px3gvgDPwTzldU5
	id5B+s6ExKMMfcm949TK6Vc2jPVd1mYln4+ZrSxht1SuGY332Yz/TUNCkzgnZgrZ
	cKWwWUr9FanGoS+gemQ3i9PRDK/Uufh/zae+XgxcKhnAzz7c+sJHMsI120sEm0zH
	CIU1WZVXYEhs8fMEmy+YRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736855874; x=
	1736942274; bh=MI4hu3GHj3d7JayYXZT+VUBPRnsNKflwzpJqzkbo5ZI=; b=H
	bEm1h4YI4ABtGbNXzoiubpDSPNyTDmCb6YF2zDPh0vaMI74ZJUmu+9oCbR7zljpZ
	ug+kfI5cdY/rZCAPH8JokJ0xD8fCwDxMsLY/yV4JInM1otdISP9tZ9+lk//oWF+U
	OE/enTT3Hn886KgeRtm+gd/xsj1LACxnu+zpRCGz3Gk8e9682I8eAW+0kCl5wccy
	ynR7Esz/3yUSRWThrE338Vncw16xBtzZUEAEfrw4vLtPFv80qjWgc250IoflktmK
	NQXAMOCG1SSSZhpb3mVcP2zzJQTlA56qQlz9ZVicc/BbobaBRPcxZ3usClbAWKeW
	BZpT0+cgq+2hYfpiyKJTA==
X-ME-Sender: <xms:QlGGZ7C0A4ADdY9vGxAq0mAyp5y3XG2nsBX3cR0jsUO_d3O6-p32Uw>
    <xme:QlGGZxgrIFBRsYlTuUxvPOuLs_czl9wj9MH1-1PQ7DzVmrLS-fss6WLf7NGDS8dQ8
    P5vVbb2ECG-9gKI3w>
X-ME-Received: <xmr:QlGGZ2lB6oXaQ1ntRSxmYq319T05lGf0Q0uo0NiJpCnXz2fm0WSusDgG_MruROFasnM0t3av7WY8EIRCbN_ejuP9qcLMQl7wvVbBOtYfBVCIDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrd
    gtohhm
X-ME-Proxy: <xmx:QlGGZ9ybMRswqCXL2IIDWvGKu3AAG1MhAQhE0cqaQO4bLD5a8PadCQ>
    <xmx:QlGGZwTJOtkW9JNg3zMbLHUTSMONnKjS_LsKRmSO569wkwUDZWJR0A>
    <xmx:QlGGZwbLN5dlkRu3oxTM-Gg2-kE7lTlM_7J6VR4UsvKZDSPlLVsflw>
    <xmx:QlGGZxRnTlOlEHHNpOGxU6abfT0OzF-TT5piIrWs5ezLnNNLpVPTbQ>
    <xmx:QlGGZ7dyzMmcY5_RDyAyyuql73h-x2L_vZy11VXcy9n8UJ9ARaskXaw1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 06:57:53 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8ba91226 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Jan 2025 11:57:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 14 Jan 2025 12:57:50 +0100
Subject: [PATCH v2 09/10] ci: switch linux-musl to use Meson
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-b4-pks-compat-drop-uncompress2-v2-9-614a2158e34e@pks.im>
References: <20250114-b4-pks-compat-drop-uncompress2-v2-0-614a2158e34e@pks.im>
In-Reply-To: <20250114-b4-pks-compat-drop-uncompress2-v2-0-614a2158e34e@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
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
index 7f55f8b3a91d6caf95934af308a2bd35a19a62f1..83bf9b918ba1b90c778d1a72cdbfa9a97ef86bdf 100644
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
index 4976e18a0503298f38230f5ba7348675baf48664..f737e4177c24d21f08dfa5c2fba8aa082c4cf6b1 100644
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
index d1cb9fa8785388b3674fcea4dd682abc0725c968..5ae80b0486c65833825352019b2873498e801db0 100755
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
index 8885ee3c3f86c62e8783d27756b8779bd491e7e6..71d85ae85a02e5a4389e133ed53f45a5042af36e 100755
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
index 6c828c3b755153dab179f73346e7124bda49c90e..8f79ccf53e1e92f344e0e0117e93113e5610c3a2 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -54,7 +54,8 @@ case "$jobname" in
 	group "Configure" meson setup build . \
 		--warnlevel 2 --werror \
 		--wrap-mode nofallback \
-		-Dfuzzers=true
+		-Dfuzzers=true \
+		$MESONFLAGS
 	group "Build" meson compile -C build --
 	if test -n "$run_tests"
 	then
diff --git a/meson.build b/meson.build
index 3e31648dc171d7149c296941591eb94516ca6c93..eadd8a99a3f2e65deb20c36945d0abb8106cf083 100644
--- a/meson.build
+++ b/meson.build
@@ -657,7 +657,7 @@ build_options_config.set('GIT_TEST_CMP_USE_COPIED_CONTEXT', '')
 build_options_config.set('GIT_TEST_INDEX_VERSION', '')
 build_options_config.set('GIT_TEST_OPTS', '')
 build_options_config.set('GIT_TEST_PERL_FATAL_WARNINGS', '')
-build_options_config.set('GIT_TEST_UTF8_LOCALE', '')
+build_options_config.set_quoted('GIT_TEST_UTF8_LOCALE', get_option('test_utf8_locale'))
 build_options_config.set_quoted('LOCALEDIR', fs.as_posix(get_option('prefix') / get_option('localedir')))
 build_options_config.set('GITWEBDIR', fs.as_posix(get_option('prefix') / get_option('datadir') / 'gitweb'))
 
diff --git a/meson_options.txt b/meson_options.txt
index c962c0a676172ed478333b9e56d1430ff9cf0af0..e9f8e990e3e88de5baea652825b4745c230473c4 100644
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

