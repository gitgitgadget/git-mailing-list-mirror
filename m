Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1CD2AD16
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 07:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736149903; cv=none; b=CmLgGBPEobnovA1tenXirI5hHZfH8SdFm5GYhHyq0KSJlLMecnGZenwC6DtkyQy0gbz6I9Cv+QfINAsRygQlZlCBE8Far4SMhNiIigvcJXcV//Kn0cRw64VBGsLd/m/vie3DeMmXIY5qOa3KM0zTTrIUtZr9fSsHipiaVjFv0Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736149903; c=relaxed/simple;
	bh=6/d8HKyONtaoDaBghz3bz0IKRdb4zXPUnOYm3wsbPu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V3iAiB2HyIHOlHCA10rK/JnyVV/wexSuzJwOttK0wfCUSbSssWF4u+pRxvW5Lcye6s+TKOTD2r7r8riwT4e7V/mcu5rzvZF5Ikwh+gBk4ZmNmGgMapctGnMTf9KxT6bZuXdBZxsQ0uC69NgIZTE3GRfL4MelSi28LI88+rkHt7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OY+hdAMa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yRPOa4BX; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OY+hdAMa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yRPOa4BX"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 3D90D1380938;
	Mon,  6 Jan 2025 02:51:40 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 06 Jan 2025 02:51:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736149900;
	 x=1736236300; bh=OTtQDdzEpB8FXaFh85brj1zxNtIyL7VOHrKk8TfMTks=; b=
	OY+hdAMaQgykjhXlN/xyQivMwqIMEI5xB9H88yVhuz2tkeHG3sqgvbOGK9bKCR7c
	jXtCE/iQr55lsxoEmwrZxLLw/3xnqIIdBz8bJKIB8ygHYXgMIMU3dNg9hqmhFpMy
	+YHlRglIt5SgTUhqthus68/NvzJ50J72q16iWPqTka6DmoFYQteZKweCeM/xB+HE
	aBLDU9pgUoDvxJO5UYFA1InxS64HUsKNLSo0uYBQjqrB4TPRrvdD5S+KwXAV2x+w
	2nYDfqQyo4D6Bhd2OUkKSlexqKWHdV7a1Fldahp38Vab6Nsi+lX9hNf96RiRU/J2
	GS2GvkB7B4GhKlMA+CIYHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736149900; x=
	1736236300; bh=OTtQDdzEpB8FXaFh85brj1zxNtIyL7VOHrKk8TfMTks=; b=y
	RPOa4BXpSjU3Mb+SRI5nkcCvucFRF99n73OgTliBNB0L5jQYDOZguUQGcLtrxwib
	SUVi9PwtJqq3EMNzotr+p4y9UnBZN1HvnUykBeDQPtmwxShSGcfhuCbXnKkMG6OS
	GmuIJW1Gfr90RR8+d4u+quF0Dc6cCbtEaQDIZQwTtXwYc433xBSVCLbQH/E2uGu1
	pjP26O2c4C53onwDA0weyEyfoWpa8iNsh9LyMpX1UUQQXl7d7c3On9gkmr/s9jJH
	Pq1gBeXJ8iR/84Zrr8CQwPSz/0F49eJNZw3QxhqzD+z2po6L2CPWj2ubFtXFcrpQ
	sTlePjg9+mR2gOn4WYNVA==
X-ME-Sender: <xms:jIt7Z_E6cDC0tHirRifnu433qGdxuhD1aBT7an2EOUZAmzv06Cvz7g>
    <xme:jIt7Z8W63xA8rwZbxzqAYZss_ToX3_5t_KtSY-wG2WFg555eiU_sR6PbrwwMK9baz
    JJkZWQt2ntdeLmAyQ>
X-ME-Received: <xmr:jIt7ZxLcCyyFbxrwNO1bx1TOEgEHbSmUtFziBL9zKI-33kIsLeDGRE7xaCOC8eGaP3oWhQDQUev4c-jXNJy0Rc9ETvwFpgq0JrGKAukkf7148w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefledguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:jIt7Z9FLQCqWeHwhvEd3zWzJ49KtPDhgtpUvqqtF0KpAJ93Ivenffw>
    <xmx:jIt7Z1XSbSCe-5qbhSacaeGb2bYZRs-zb9ztkAWpjxgJG8FfgZQsUA>
    <xmx:jIt7Z4OI_ZYjrcY9qd5c1MDhPxkxwTJPud6hDlE1AEc38bZIIki6vw>
    <xmx:jIt7Z01j-vfFrR36wQ5FOFhOw_vBKQ3DTv-3fWWAaX2L_YWJUTHJ9A>
    <xmx:jIt7Zyj13lHRX58-N3bcg4bMXL03z4tTtE4oM3I63VW_3ReRHy_HjCKI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 02:51:39 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9f280bcc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jan 2025 07:51:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 06 Jan 2025 08:51:33 +0100
Subject: [PATCH v2 1/5] Makefile: wire up build option for deprecated
 features
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250106-pks-remote-branches-deprecation-v2-1-2ce87c053536@pks.im>
References: <20250106-pks-remote-branches-deprecation-v2-0-2ce87c053536@pks.im>
In-Reply-To: <20250106-pks-remote-branches-deprecation-v2-0-2ce87c053536@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>
X-Mailer: b4 0.14.2

With 57ec9254eb (docs: introduce document to announce breaking changes,
2024-06-14), we have introduced a new document that tracks upcoming
breaking changes in the Git project. In 2454970930 (BreakingChanges:
early adopter option, 2024-10-11) we have amended the document a bit to
mention that any introduced breaking changes must be accompanied by
logic that allows us to enable the breaking change at compile-time.
While we already have two breaking changes lined up, neither of them has
such a switch because they predate those instructions.

Introduce the proposed `WITH_BREAKING_CHANGES` preprocessor macro and
wire it up with both our Makefiles and Meson.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 GIT-BUILD-OPTIONS.in                | 1 +
 Makefile                            | 5 +++++
 contrib/buildsystems/CMakeLists.txt | 1 +
 meson.build                         | 6 ++++++
 meson_options.txt                   | 2 ++
 t/test-lib.sh                       | 4 ++++
 6 files changed, 19 insertions(+)

diff --git a/GIT-BUILD-OPTIONS.in b/GIT-BUILD-OPTIONS.in
index f651116102ae2977622dccd12b199fe7ad65af99..f1d0ecf123031dd13232cc63e100da528bfea16a 100644
--- a/GIT-BUILD-OPTIONS.in
+++ b/GIT-BUILD-OPTIONS.in
@@ -45,3 +45,4 @@ GITWEBDIR=@GITWEBDIR@
 USE_GETTEXT_SCHEME=@USE_GETTEXT_SCHEME@
 LOCALEDIR=@LOCALEDIR@
 BROKEN_PATH_FIX=@BROKEN_PATH_FIX@
+WITH_BREAKING_CHANGES=@WITH_BREAKING_CHANGES@
diff --git a/Makefile b/Makefile
index 06f01149ecf399ae4bb1932188a007948d767283..dc3c980aa7a4f42d27ed72415a636ac82b2a5684 100644
--- a/Makefile
+++ b/Makefile
@@ -2230,6 +2230,10 @@ ifdef FSMONITOR_OS_SETTINGS
 	COMPAT_OBJS += compat/fsmonitor/fsm-path-utils-$(FSMONITOR_OS_SETTINGS).o
 endif
 
+ifdef WITH_BREAKING_CHANGES
+	BASIC_CFLAGS += -DWITH_BREAKING_CHANGES
+endif
+
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK = NoThanks
 endif
@@ -3187,6 +3191,7 @@ GIT-BUILD-OPTIONS: FORCE
 		-e "s|@USE_GETTEXT_SCHEME@|\'$(USE_GETTEXT_SCHEME)\'|" \
 		-e "s|@LOCALEDIR@|\'$(localedir_SQ)\'|" \
 		-e "s!@BROKEN_PATH_FIX@!\'$(BROKEN_PATH_FIX)\'!" \
+		-e "s|@WITH_BREAKING_CHANGES@|\'$(WITH_BREAKING_CHANGES)\'|" \
 		GIT-BUILD-OPTIONS.in >$@+
 	@if grep -q '^[A-Z][A-Z_]*=@.*@$$' $@+; then echo "Unsubstituted build options in $@" >&2 && exit 1; fi
 	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 49904ca8a93981c514540bad5efa6833ddd14426..63d008892848c20d5937d9a624a480f700b19498 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1198,6 +1198,7 @@ string(REPLACE "@GITWEBDIR@" "'${GITWEBDIR}'" git_build_options "${git_build_opt
 string(REPLACE "@USE_GETTEXT_SCHEME@" "" git_build_options "${git_build_options}")
 string(REPLACE "@LOCALEDIR@" "'${LOCALEDIR}'" git_build_options "${git_build_options}")
 string(REPLACE "@BROKEN_PATH_FIX@" "" git_build_options "${git_build_options}")
+string(REPLACE "@WITH_BREAKING_CHANGES@" "" git_build_options "${git_build_options}")
 if(USE_VCPKG)
 	string(APPEND git_build_options "PATH=\"$PATH:$TEST_DIRECTORY/../compat/vcbuild/vcpkg/installed/x64-windows/bin\"\n")
 endif()
diff --git a/meson.build b/meson.build
index 0dccebcdf16b07650d943e53643f0e09e2975cc9..316cd9326437876828a88d96a1bc93d503199900 100644
--- a/meson.build
+++ b/meson.build
@@ -644,6 +644,12 @@ build_options_config.set('GIT_TEST_UTF8_LOCALE', '')
 build_options_config.set_quoted('LOCALEDIR', fs.as_posix(get_option('prefix') / get_option('localedir')))
 build_options_config.set('GITWEBDIR', fs.as_posix(get_option('prefix') / get_option('datadir') / 'gitweb'))
 
+if get_option('breaking_changes')
+  build_options_config.set('WITH_BREAKING_CHANGES', 'YesPlease')
+else
+  build_options_config.set('WITH_BREAKING_CHANGES', '')
+endif
+
 if get_option('sane_tool_path') != ''
   build_options_config.set_quoted('BROKEN_PATH_FIX', 's|^\# @BROKEN_PATH_FIX@$|git_broken_path_fix "' + get_option('sane_tool_path') + '"|')
 else
diff --git a/meson_options.txt b/meson_options.txt
index 32a72139bae870745d9131cc9086a4594826be91..800e518d959c4143812f8840415b99a593667a8d 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -43,6 +43,8 @@ option('sha256_backend', type: 'combo', choices: ['openssl', 'nettle', 'gcrypt',
   description: 'The backend used for hashing objects with the SHA256 object format')
 
 # Build tweaks.
+option('breaking_changes', type: 'boolean', value: false,
+  description: 'Enable upcoming breaking changes.')
 option('macos_use_homebrew_gettext', type: 'boolean', value: true,
   description: 'Use gettext from Homebrew instead of the slightly-broken system-provided one.')
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 62dfcc4aaf959d0cf066d07663d939e14f92485c..6e423f655d35adf5a2d4f8b3a78d9e8c1119caab 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1864,6 +1864,10 @@ test_lazy_prereq CURL '
 	curl --version
 '
 
+test_lazy_prereq WITHOUT_BREAKING_CHANGES '
+	test -z "$WITH_BREAKING_CHANGES"
+'
+
 # SHA1 is a test if the hash algorithm in use is SHA-1.  This is both for tests
 # which will not work with other hash algorithms and tests that work but don't
 # test anything meaningful (e.g. special values which cause short collisions).

-- 
2.48.0.rc1.245.gb3e6e7acbc.dirty

