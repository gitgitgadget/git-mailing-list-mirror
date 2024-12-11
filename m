Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266C7239BC5
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 10:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733914617; cv=none; b=GAUs3FaV06+xsLNXgPTe10uKbAMFb3wrXgr704E8sP9DfO7S4Iuhrdbg1GmMfkqXNTDBUasqnNzOyM8LK6gNgMqrhoGKFrRbntr0quu8YoAhuCPeL/NFohShOW/huRchoXw9ImWjvXdeiaSgiV38tTjDgkKXzHSN88tMS6jSoxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733914617; c=relaxed/simple;
	bh=ib3XPWPPLSwz4Gys960BG9vaRv7pIusiBPWlYL0A4Ms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p30S3CCL6vUBuNpu/mLRyjMB3qgd7ZgnWrBW9kAAZ16dd9TgtSI0hi7QEv3xXlbgBrWiJAjaeDgT3GezNmgvKGxVpkaZMqZZ6E282ba8uirRB/gBavxG4S5QjNPfmgvjt3SuqMlKMIMBquzeCuRRUXQvC2xfJdhHxOjpqac01jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=yQNdmRGX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BZEtfniy; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="yQNdmRGX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BZEtfniy"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 125B82540268
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 05:56:55 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 11 Dec 2024 05:56:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733914614;
	 x=1734001014; bh=nwX66yBOoxc9zoOoX+ZRydYKzziei/YtZmIjStY8l4A=; b=
	yQNdmRGX8pc68/xVBDelimhTsyfxwZwmj1da1XUzxQepVhLLgovvbQK2D2zoFH9n
	1EmWfGKfWLsBIQaVpUhZ7hqJpPDFE5qS12MtUV+ZSTwA9eyOQGO0U9lPv9WjwXGL
	aUUxJaqi6+lPai2mh6U7UVrHNP8VN0vFTZLu5TIzy4CZvvyxQsGzgV/5CF4/0aq2
	tz4nNARA2dMta/HsOCcSNgCo06+/JEISZOhKUkYn/HLY3PUjPcd3xKL7PyPxin+P
	YdeL9jvcVGP9ujJqfNrZ/KY2l+0b/17Ir3Wxnl6DhRvoUx2vCKgDJSQlL7zzGWy1
	Tn55uvCGTVX0lk1FYI6umQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733914614; x=
	1734001014; bh=nwX66yBOoxc9zoOoX+ZRydYKzziei/YtZmIjStY8l4A=; b=B
	ZEtfniyGyCu4eN+49V2AWoH67teG0lL4pgD3WDbkVxxTygsyQJSfsdTzPVBF78sw
	0erwUTGhq85PjZwT9BWojyN8Y0GUYLa0DEnkuIBiBYLBe9dS+9CF2f91e0x0PzwA
	TRstMeT0bT5VZjXLF4woTnDmpOILU3FIKJwbuA7ktLe5DaXoJWChk3gniWVLUQ/F
	3PcE63wtT++AcTuq2vK0PMmSsbFYKEMo9qZyQskVMS7UBM9VBsHacCGWqq24I4Yz
	vqpcC29bgL75ilLIf1PFcREj2LRcxMNrKqnwt/xZM0odXvLOUb4NqfSgko77qkin
	BEQOJ0MGH90aX2teodWZg==
X-ME-Sender: <xms:9m9ZZ6TlPH6D5aRB5SLjZwLp9Oq2FIkIdCaABXT86ubLOj-d0ugPGw>
    <xme:9m9ZZ_w6Zam7pK-SlX2v1ULSCjtd3UY-y8_2ZHBenE7xeI_hVwvOM4AKXhIgB5QG7
    C5rarMydo-fe7QjVg>
X-ME-Received: <xmr:9m9ZZ33dyPK7nEMDLyWpzErv2yB3Z5rA-Y7AWjglNGFwG-5Fx8Gp4kUqhfQKNAdf23jR0OpUDTM0qK9UZ2OdJHoskC1-yYJZ92anvvt9gs7z-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkedtgddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:9m9ZZ2AIpLDMRDR324QOgh6_B-EokHwvIdde46LtIFC7uJ5mbkmhLg>
    <xmx:9m9ZZziVIcpKzvqIjud0fetJiQmtaPPOX7WR-PXUilvGpDOFBYjiMQ>
    <xmx:9m9ZZyp149zOVxvqnwbbtYavMcllqunW4HI4tdjPjHGFFo8hUAKDew>
    <xmx:9m9ZZ2gwckkkukEN4LH3_7qfNTKz2V7h2wwLpjQ2c1W4rttPdSuCYA>
    <xmx:9m9ZZ7a_j5coR3EyAFvaycOh8uBjR6SBtQ6Qc9z5ywgyuwIk7_fdkkMM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 11 Dec 2024 05:56:54 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fb2d45e7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 11 Dec 2024 10:55:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 11 Dec 2024 11:56:37 +0100
Subject: [PATCH 1/5] Makefile: wire up build option for deprecated features
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-pks-remote-branches-deprecation-v1-1-1431e2369135@pks.im>
References: <20241211-pks-remote-branches-deprecation-v1-0-1431e2369135@pks.im>
In-Reply-To: <20241211-pks-remote-branches-deprecation-v1-0-1431e2369135@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

With 57ec9254eb (docs: introduce document to announce breaking changes,
2024-06-14), we have introduced a new document that tracks upcoming
breaking changes in the Git project. In 2454970930 (BreakingChanges:
early adopter option, 2024-10-11) we have amended the document a bit to
mention that any introduced breaking changes must be accompanied by
logic that allows us to easily enable the breaking change at runtime.
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
2.47.1.447.ga7e8429e30.dirty

