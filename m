Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF26718FC92
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 07:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737358988; cv=none; b=bYampqN8W22msX5uPyojPDMrgJq2pSaVl8dHbvY0NDW0qHTskyv0vapZMLOiEawu+Pd3SXcAEZTCVBFH7JDXCY0XKyVS2WC9efJRZh6jf3ad5H7raTJjxcnEdFg83xp21wOg+WbhKdCO66C296r/ZwzVspcsPOhU2vlyY80yyHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737358988; c=relaxed/simple;
	bh=sLje2TTIAv4VxIu5yBaTmpV+OL67bnq8uMXaPNaFHwk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BFqN2mV12OlFrUW8e9QxUZxpLhvwfzUEAieXgq1Hy8K/vVdLEsMt9KK+9r0iIeNhHmEu+w7GBAHd9Q4PWhyGlp9VZnmAy17NaCLiXWZM1pOkIOZG4FCtD791Mo6mm1b445gvYY/OMrQpoUTI1isHDD6yzLFJuNEnIDCaEmjF+MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=glrl9cjo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NqO8tx/r; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="glrl9cjo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NqO8tx/r"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A149E2540113;
	Mon, 20 Jan 2025 02:43:05 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 20 Jan 2025 02:43:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737358985;
	 x=1737445385; bh=vxvZjcGkYuHjB2vv5nD6ItzKb6OUNlNp/ubQh2ToHz8=; b=
	glrl9cjo+8HHva2713JxTIpwOGmk5wd450XqZpqSLAj8oC6siZo+njSJbg+9ElWO
	GIWGLKpPspAUMopcyprwfAgJfzbG2H0kQAmfO80YWnKXATSDe7w7FMAgnTjSymEG
	01AQGWWIeYQiSVUY0DxpjYCfcVeAMvdbTMkO5rjYlhQp6Q4qORlI5XKolahQDVP8
	xuJhKOnu5kqZbTCwnBcyCJkG+PwkisZBrIwMN4eREf1yIN7YXIwD0SrhfG9V88op
	Dlbwx7kgjxFepkamVownic99FTP5UKPuC54kRtqH+XdfnSU8kXhyFDKncPM4zTIH
	Ul+5lywuVItKAGeC92oNcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737358985; x=
	1737445385; bh=vxvZjcGkYuHjB2vv5nD6ItzKb6OUNlNp/ubQh2ToHz8=; b=N
	qO8tx/rx4mHrj7ybkDp8cr4aOxBiN+jcYyBWzo2SwQMuC21V2XjjuUjFOHGT17v1
	uzy3p8Ee+5pa2Rs/UeUQGA4J1du4+ws/M8/VT19EenAJjxxWDgpVBaZKkPXbEyYF
	v+rP9XCBsxuu1diy/+y4bmB1g403/8eKNg+IRVn0v8ZTzW1RlFKUdkER86byeXBM
	7R49QjqOogb6K6N7F8S7yk0bW28ovqIDWTsNRGiloEKsAtnWAD0HRszU5QY7Y+KC
	ab9rBXs+GxwkjTKHDUY4OkTgBu8GTnY1uJhaQEXisslRstU/GPhMZIEadpkCYaaA
	e//QGCH6ueQGab8H4ws3w==
X-ME-Sender: <xms:if6NZ5yjQ0N7kb68raXbakPTeVCiljnWL1zZ1iqKSY7WjYEXzXcF6w>
    <xme:if6NZ5TtkMxJHX0ly-GbZBbhz8c1j761VPIc0ZQv3KwRXu72Sii9guuQkWPbPeKdL
    oiQcgY4MqBCiUNgfg>
X-ME-Received: <xmr:if6NZzV4-KKgxr3e-adt7e3niSo3p8DrVdzCU3DkSHfe5zzqD5JX0u8zrabP7GWx20CHbavwwu4KRb9iPs4UEDIstP2cZMEhfGIvHhi9wlzPZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeikedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehrrghnuggrlhhlrdgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtggrpdhr
    tghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtth
    hopehrohgsvghrthdrtghouhhpsehkohhorhguihhnrghtvghsrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknh
    hosghlvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:if6NZ7g4iqsxYdPjE2B-Cvl3vC0kFzX0UkYj_SpnpBeaZkqOa2fAYA>
    <xmx:if6NZ7A6s04Nep0OD-8Sl0T86xJWXu6_J_HvKKroAXLQFpvShpa-eA>
    <xmx:if6NZ0K5MMT84O_OORyNuXdKgQQRXRLVnTTy3c88q4NXqhw9atoTrw>
    <xmx:if6NZ6C-pcYoVDrQNcapdQkM61kVrKRasMy4FeXGDdkCf1Z9jyf1Dg>
    <xmx:if6NZ90nkentrGgLbDknEwmaBlp1WSMPKl1MVsuBkb5uQwxgrMMlO7-Y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jan 2025 02:43:03 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 67ece214 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Jan 2025 07:43:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 20 Jan 2025 08:42:58 +0100
Subject: [PATCH v3 1/5] Makefile: wire up build option for deprecated
 features
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250120-pks-remote-branches-deprecation-v3-1-c7e539b6a84f@pks.im>
References: <20250120-pks-remote-branches-deprecation-v3-0-c7e539b6a84f@pks.im>
In-Reply-To: <20250120-pks-remote-branches-deprecation-v3-0-c7e539b6a84f@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Robert Coup <robert.coup@koordinates.com>, 
 Christian Couder <chriscool@tuxfamily.org>, 
 "Randall S. Becker" <randall.becker@nexbridge.ca>
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
wire it up with both our Makefiles and Meson. This does not yet wire up
the build flag for existing deprecations.

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
index f651116102..f1d0ecf123 100644
--- a/GIT-BUILD-OPTIONS.in
+++ b/GIT-BUILD-OPTIONS.in
@@ -45,3 +45,4 @@ GITWEBDIR=@GITWEBDIR@
 USE_GETTEXT_SCHEME=@USE_GETTEXT_SCHEME@
 LOCALEDIR=@LOCALEDIR@
 BROKEN_PATH_FIX=@BROKEN_PATH_FIX@
+WITH_BREAKING_CHANGES=@WITH_BREAKING_CHANGES@
diff --git a/Makefile b/Makefile
index 06f01149ec..dc3c980aa7 100644
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
index 49904ca8a9..63d0088928 100644
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
index 0dccebcdf1..316cd93264 100644
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
index 32a72139ba..800e518d95 100644
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
index 62dfcc4aaf..6e423f655d 100644
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
2.48.0.257.gd3603152ad.dirty

