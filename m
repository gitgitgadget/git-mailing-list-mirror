Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDBE156F2B
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 11:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737545499; cv=none; b=Wypm5WKzaiXI9wpJNvpF0+Gco78DtF+viVZgBP6iiRZyCgNpu6WHCBh7+utzpjnxhXIvvw7mZsASmt1t/8xp9QtYpCbLmR0xMBwXDBuDtkUyyeRLAR6N0eDim7jirXbgTmrXQuWJX3XVxecT92L7XY/cAgRwYTJ5kGtxOBP7QEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737545499; c=relaxed/simple;
	bh=D/kLwR3I0FOH0MmJpKK+21io7hwpNSQp9HEenhAtft4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ACDkbCKwNzAMYg+OZsa8sA1qC2ucOQk3bjDVQNmogau+otGcR+434U6JMVN7q7QOzyOu5SPzF0BQvYLNpZ3l3FXvObJrioudkpaA5XnrBNIJXNNYbMJ86ADbtih+xaKq+u3iSTpZjhk5kvH2JLYiPbz5DjWwrUlUzDDS/9QmkHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LIM0ISn9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YLsxGkvW; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LIM0ISn9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YLsxGkvW"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 825E8114011C;
	Wed, 22 Jan 2025 06:31:36 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 22 Jan 2025 06:31:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737545496;
	 x=1737631896; bh=AMNy1+3ZP7nwdA5WQT6Lgny1HpgGhfLUH7AOYszCjHM=; b=
	LIM0ISn9WenkYbp/dW/QwWb8RA1mVmCjYXrqXcCEbDW0Yu+mAbuv1N8yNVfoFwmI
	9iUB4W2eqIlIzQupsZXN+O+wOVakDvx3t2qXipz1dtIb9kZ2//A9RRF58Ts8Pclg
	HWMP7siXaAFzY5KgB1/bTiMahfv1wSbmJ8YyB+dqIC9+1ajkYjvjMXxW0AL7XJtD
	gD/nnZgu2L/abyT94CGx0J9BSQHy31qn46NekvGzYJEiJpgW1Xdywy345yPaG1qv
	KewjS1cQuTp3OQ2e9/EGMDcXYVO/T9rSj4yjgKozJjVg3A1bjecia/FtOiKiEiHR
	JfK2KJK7qCG6IZzoucOZVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737545496; x=
	1737631896; bh=AMNy1+3ZP7nwdA5WQT6Lgny1HpgGhfLUH7AOYszCjHM=; b=Y
	LsxGkvWbNKDAzOA9ft8BZ1fE9+ah5yqhH7Dbp04NuPHxyldkiGeRh6v1qnf1neyB
	lV7GrpsvxB1dH3uiwfkZTDmEk37rOo/FvP8dmhTYM/yMVuxEwdeEKvQgPcfjGfxP
	H9IJa4yAM0ub4qyQJtcrS0ZWajPHzwJv0uhZGGhONRfPfW7wknroyDIqbfW3f3Uj
	sN3p42yIFOM+Uxh01FWliZh6fx88VQgf/4eGpYHKAUnZ+kYCC7kqAeU6hw0Cq1a/
	2zbngc/haNPkkqBt0g0IL5QBvmcz+P9NYOUEhodyeZS7MrM9/50eDEtOQ2EfYjsa
	oXzFAk61RVhYbQ3MPsadg==
X-ME-Sender: <xms:GNeQZwESKuDfPythRl3BpoDGO94jffTZaElXK08BXxwUU7wHXHMh3w>
    <xme:GNeQZ5Ws-PxIlZMD9uvARnGK1gMHxJnH-Bo5_J7agoEmu5D0NmfTu4g0nI2UWCtNp
    vP_EknwvOfYMceJ4A>
X-ME-Received: <xmr:GNeQZ6Kxq2d8xonXwsnFtWbjvHW0SvUldWubrevqSkxqNGQWisc-3FkZAPZ6kRZiBperYfbozSgzNmEtnP-_uKFYuG-jDAwKyopAYhuotOdiswY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheprhgrnhgurghllhdrsggvtghkvghrsehnvgigsg
    hrihgughgvrdgtrgdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhih
    rdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehrohgs
    vghrthdrtghouhhpsehkohhorhguihhnrghtvghsrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:GNeQZyGa7ecQwLYRnIcpMiq20XDQQ46w_Ano9w_RhXngehGlEmhSQQ>
    <xmx:GNeQZ2UKVCl_DCluaaN0SyHZ1idToQA4IIwVpRu85BRKdc6WedKlEQ>
    <xmx:GNeQZ1PHIcb9Qwy_vvCj_U0_FsjWPHhXsi2AkGuQl6QzhQX5KJ_7vw>
    <xmx:GNeQZ90BmOKJKr0qEE_Vopxf_nd5odV0XHwmKJx3dbgzHP1a8BXtSw>
    <xmx:GNeQZ4L5s3J8PiPEEzEdRDoKbQ54Sl869I1zKifIlwMAsoUyvGx_ToUP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 06:31:35 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4a23c53d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 Jan 2025 11:31:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 22 Jan 2025 12:31:29 +0100
Subject: [PATCH v4 1/5] Makefile: wire up build option for deprecated
 features
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250122-pks-remote-branches-deprecation-v4-1-5cbf5b28afd5@pks.im>
References: <20250122-pks-remote-branches-deprecation-v4-0-5cbf5b28afd5@pks.im>
In-Reply-To: <20250122-pks-remote-branches-deprecation-v4-0-5cbf5b28afd5@pks.im>
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
2.48.1.321.gbf1f004a4a.dirty

