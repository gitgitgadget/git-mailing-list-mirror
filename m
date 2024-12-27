Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E241474A0
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 12:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735301457; cv=none; b=VdVMGUnXpqaQ8ECOimERZVWoZer+nFZn6U+NfcrpzJfFXGeeVvaZTO0VvvXmrvueuWoitX3pnlpKAVwTICcDzxT4agDDRaDMrHP174XC63FVydAxeZrP0/AuKZvWlryzgw+f9jnHTvcwHYSqM15k/nKpGjeKSRLvNpzI8QU5xNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735301457; c=relaxed/simple;
	bh=oLng+SLUHvNDC1YCJMl4Z77lQp+Qo2zUSY1CYzwVYEc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZKCGpZpFsuFJW57ia4K9vVz0aA5MvlYBWdd2seTFnagt6nRRq+VhbfyWYU601GYyx9CdMItqzZr2gFftdvXNzXp+0w4tj8lDZfvzfnM3PqLf9fTow6rimSFdh2AeZgjhp4DZY/KADE4pUBvQEN79z5iXQRHq2jLWqDa08kIJmC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Q79Ug+5a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eGKZdatw; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Q79Ug+5a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eGKZdatw"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 81D011140152
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 07:10:53 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 27 Dec 2024 07:10:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735301453;
	 x=1735387853; bh=dkOeiFfMrF2Kvlg1I3ZE8fyz7Fq8uT5imPhZRpAFszc=; b=
	Q79Ug+5aICFh49bLUr/j5d2uie9AsaWgK9ryqUX/KrzFbZQdqGVL7upb1fDc3qlg
	J+PMmJ/PDS3H6o+0xB/kt+ujLreApakMyEuIsbRPpHsPJ2kDu9bCEaaUTO3UeZM9
	15UT217/a+016rch7f0kt7o+lP4nTUue/D1LcRibkXIWKQEsFArD/ABuai9Cbfwq
	Rby9r7rpCuRLW1IVoP2O6ixT6keCow09xW65MX8Keyr2dYMNJb2UWbRJ1Z40emeb
	7MA3akInO1FpB6h4vE6V2TjlvLEAzNi67WtP5CK+K+xsyHdGdpROcBaH4eaOjcFL
	dr+TSvngVZDY4BNLtqbOfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735301453; x=
	1735387853; bh=dkOeiFfMrF2Kvlg1I3ZE8fyz7Fq8uT5imPhZRpAFszc=; b=e
	GKZdatwyl8C2Tz5/wQM6WPL3kcM7pg5+dkq93dZmjLLlTKYnRARUkOu2zeRY79PQ
	6oOmhmGDc6PBgY2UucVCe7EA5dYaJJ/EmnxnN69YImGY3mPdjTa2eecCKhz8/BIO
	J628u7FDeGbCQe2zJmIg1KIoMwf+Ng1zR/kg0L8x9/p5GFbXmnDqW7vOUKoQTiSn
	MA+FThHbIn9CujFaDykz2xYf9iLhFQWbjU2ABscsSPWXxX3OrR4+1g71OOVrjaCJ
	xQs+faEPgghrRbMqQBSEFQeAgWi7QZVCVoJ5/Unyhk/OiIW1EBfbytovMxyoqbuf
	CBIGg44oqu/fxRvuNj6Jg==
X-ME-Sender: <xms:TZluZ_j9nVqvfYlIRTmMkgbQxiMbkadHVvkWtRjiaFhpG4B9P4J7Lw>
    <xme:TZluZ8AOCAB4UESpzLQRLPLsHxWqJxD7ycYAXUgX2dm9z0gmJB83-SQ_-VtEKF0oh
    W7T-5yjBY3ADC6FAw>
X-ME-Received: <xmr:TZluZ_EfD1EBTsTHzobOEn1wj85jmMsjs8poIciETn-QVScNBIN9B3Bg4ymZZMTk1mZPR_Yu_1MXrvvRjGMbnQIwl5cGKy8NNueqyWv7uiX40g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:TZluZ8SLMs-c3mBBl5E8hjmxOUDHq2FDkAI2Gga4wiOpzoXMEzS18w>
    <xmx:TZluZ8xeC69pwBDhLps5CgquRAD0Km8WQgDXv8aB739783CFbn2ygw>
    <xmx:TZluZy5B-YvBdViAz-UCHKTwfA1x-UcsaZzBVRKaD15qA7uRKhqvIw>
    <xmx:TZluZxymtfbIVvmjKkDT_bCRTqW1CmXdvmfk7dF7G8nSw1FRfUl4JQ>
    <xmx:TZluZ5rL_SQnGs-9YZF0IWqSNcKkBEadCBLaJSJ3zJ8HcqRT8x-f2CdA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 27 Dec 2024 07:10:52 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 47b86ae0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 27 Dec 2024 12:08:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 27 Dec 2024 13:10:17 +0100
Subject: [PATCH 1/3] GIT-BUILD-OPTIONS: sort variables alphabetically
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241227-b4-pks-meson-wo-gitweb-v1-1-14ca8515bb3b@pks.im>
References: <20241227-b4-pks-meson-wo-gitweb-v1-0-14ca8515bb3b@pks.im>
In-Reply-To: <20241227-b4-pks-meson-wo-gitweb-v1-0-14ca8515bb3b@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The variables declared and substituted in GIT-BUILD-OPTIONS are not
ordered in any obvious way. Sort them alphabetically so that it becomes
obvious where new variables should go.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 GIT-BUILD-OPTIONS.in                | 70 ++++++++++++++++++-------------------
 Makefile                            | 70 ++++++++++++++++++-------------------
 contrib/buildsystems/CMakeLists.txt | 70 ++++++++++++++++++-------------------
 3 files changed, 105 insertions(+), 105 deletions(-)

diff --git a/GIT-BUILD-OPTIONS.in b/GIT-BUILD-OPTIONS.in
index f651116102ae2977622dccd12b199fe7ad65af99..162cc391903c911383fb0fb358589b4cee4b64aa 100644
--- a/GIT-BUILD-OPTIONS.in
+++ b/GIT-BUILD-OPTIONS.in
@@ -1,47 +1,47 @@
-SHELL_PATH=@SHELL_PATH@
-TEST_SHELL_PATH=@TEST_SHELL_PATH@
-PERL_PATH=@PERL_PATH@
-PERL_LOCALEDIR=@PERL_LOCALEDIR@
-NO_PERL_CPAN_FALLBACKS=@NO_PERL_CPAN_FALLBACKS@
+BROKEN_PATH_FIX=@BROKEN_PATH_FIX@
 DIFF=@DIFF@
-PYTHON_PATH=@PYTHON_PATH@
-TAR=@TAR@
+FSMONITOR_DAEMON_BACKEND=@FSMONITOR_DAEMON_BACKEND@
+FSMONITOR_OS_SETTINGS=@FSMONITOR_OS_SETTINGS@
+GITWEBDIR=@GITWEBDIR@
+GIT_INTEROP_MAKE_OPTS=@GIT_INTEROP_MAKE_OPTS@
+GIT_PERF_LARGE_REPO=@GIT_PERF_LARGE_REPO@
+GIT_PERF_MAKE_COMMAND=@GIT_PERF_MAKE_COMMAND@
+GIT_PERF_MAKE_OPTS=@GIT_PERF_MAKE_OPTS@
+GIT_PERF_REPEAT_COUNT=@GIT_PERF_REPEAT_COUNT@
+GIT_PERF_REPO=@GIT_PERF_REPO@
+GIT_TEST_CMP=@GIT_TEST_CMP@
+GIT_TEST_CMP_USE_COPIED_CONTEXT=@GIT_TEST_CMP_USE_COPIED_CONTEXT@
+GIT_TEST_GITPERLLIB=@GIT_TEST_GITPERLLIB@
+GIT_TEST_INDEX_VERSION=@GIT_TEST_INDEX_VERSION@
+GIT_TEST_MERGE_TOOLS_DIR=@GIT_TEST_MERGE_TOOLS_DIR@
+GIT_TEST_OPTS=@GIT_TEST_OPTS@
+GIT_TEST_PERL_FATAL_WARNINGS=@GIT_TEST_PERL_FATAL_WARNINGS@
+GIT_TEST_POPATH=@GIT_TEST_POPATH@
+GIT_TEST_TEMPLATE_DIR=@GIT_TEST_TEMPLATE_DIR@
+GIT_TEST_TEXTDOMAINDIR=@GIT_TEST_TEXTDOMAINDIR@
+GIT_TEST_UTF8_LOCALE=@GIT_TEST_UTF8_LOCALE@
+LOCALEDIR=@LOCALEDIR@
 NO_CURL=@NO_CURL@
-NO_ICONV=@NO_ICONV@
 NO_EXPAT=@NO_EXPAT@
-USE_LIBPCRE2=@USE_LIBPCRE2@
+NO_GETTEXT=@NO_GETTEXT@
+NO_ICONV=@NO_ICONV@
 NO_PERL=@NO_PERL@
+NO_PERL_CPAN_FALLBACKS=@NO_PERL_CPAN_FALLBACKS@
 NO_PTHREADS=@NO_PTHREADS@
 NO_PYTHON=@NO_PYTHON@
 NO_REGEX=@NO_REGEX@
 NO_UNIX_SOCKETS=@NO_UNIX_SOCKETS@
 PAGER_ENV=@PAGER_ENV@
-SANITIZE_LEAK=@SANITIZE_LEAK@
+PERL_LOCALEDIR=@PERL_LOCALEDIR@
+PERL_PATH=@PERL_PATH@
+PYTHON_PATH=@PYTHON_PATH@
+RUNTIME_PREFIX=@RUNTIME_PREFIX@
 SANITIZE_ADDRESS=@SANITIZE_ADDRESS@
-X=@X@
-FSMONITOR_DAEMON_BACKEND=@FSMONITOR_DAEMON_BACKEND@
-FSMONITOR_OS_SETTINGS=@FSMONITOR_OS_SETTINGS@
+SANITIZE_LEAK=@SANITIZE_LEAK@
+SHELL_PATH=@SHELL_PATH@
+TAR=@TAR@
 TEST_OUTPUT_DIRECTORY=@TEST_OUTPUT_DIRECTORY@
-GIT_TEST_OPTS=@GIT_TEST_OPTS@
-GIT_TEST_CMP=@GIT_TEST_CMP@
-GIT_TEST_CMP_USE_COPIED_CONTEXT=@GIT_TEST_CMP_USE_COPIED_CONTEXT@
-GIT_TEST_UTF8_LOCALE=@GIT_TEST_UTF8_LOCALE@
-NO_GETTEXT=@NO_GETTEXT@
-GIT_PERF_REPEAT_COUNT=@GIT_PERF_REPEAT_COUNT@
-GIT_PERF_REPO=@GIT_PERF_REPO@
-GIT_PERF_LARGE_REPO=@GIT_PERF_LARGE_REPO@
-GIT_PERF_MAKE_OPTS=@GIT_PERF_MAKE_OPTS@
-GIT_PERF_MAKE_COMMAND=@GIT_PERF_MAKE_COMMAND@
-GIT_INTEROP_MAKE_OPTS=@GIT_INTEROP_MAKE_OPTS@
-GIT_TEST_INDEX_VERSION=@GIT_TEST_INDEX_VERSION@
-GIT_TEST_PERL_FATAL_WARNINGS=@GIT_TEST_PERL_FATAL_WARNINGS@
-GIT_TEST_TEXTDOMAINDIR=@GIT_TEST_TEXTDOMAINDIR@
-GIT_TEST_POPATH=@GIT_TEST_POPATH@
-GIT_TEST_TEMPLATE_DIR=@GIT_TEST_TEMPLATE_DIR@
-GIT_TEST_GITPERLLIB=@GIT_TEST_GITPERLLIB@
-GIT_TEST_MERGE_TOOLS_DIR=@GIT_TEST_MERGE_TOOLS_DIR@
-RUNTIME_PREFIX=@RUNTIME_PREFIX@
-GITWEBDIR=@GITWEBDIR@
+TEST_SHELL_PATH=@TEST_SHELL_PATH@
 USE_GETTEXT_SCHEME=@USE_GETTEXT_SCHEME@
-LOCALEDIR=@LOCALEDIR@
-BROKEN_PATH_FIX=@BROKEN_PATH_FIX@
+USE_LIBPCRE2=@USE_LIBPCRE2@
+X=@X@
diff --git a/Makefile b/Makefile
index 3fa4bf0d065a1299b060c22ddf716f9b502db472..f80e70702fcd8df884c7634344cc4ae23d2cb605 100644
--- a/Makefile
+++ b/Makefile
@@ -3145,53 +3145,53 @@ endif
 # and the first level quoting from the shell that runs "echo".
 GIT-BUILD-OPTIONS: FORCE
 	@sed \
-		-e "s|@SHELL_PATH@|\'$(SHELL_PATH_SQ)\'|" \
-		-e "s|@TEST_SHELL_PATH@|\'$(TEST_SHELL_PATH_SQ)\'|" \
-		-e "s|@PERL_PATH@|\'$(PERL_PATH_SQ)\'|" \
-		-e "s|@PERL_LOCALEDIR@|\'$(perl_localedir_SQ)\'|" \
-		-e "s|@NO_PERL_CPAN_FALLBACKS@|\'$(NO_PERL_CPAN_FALLBACKS_SQ)\'|" \
+		-e "s!@BROKEN_PATH_FIX@!\'$(BROKEN_PATH_FIX)\'!" \
 		-e "s|@DIFF@|\'$(DIFF)\'|" \
-		-e "s|@PYTHON_PATH@|\'$(PYTHON_PATH_SQ)\'|" \
-		-e "s|@TAR@|\'$(TAR)\'|" \
+		-e "s|@FSMONITOR_DAEMON_BACKEND@|\'$(FSMONITOR_DAEMON_BACKEND)\'|" \
+		-e "s|@FSMONITOR_OS_SETTINGS@|\'$(FSMONITOR_OS_SETTINGS)\'|" \
+		-e "s|@GITWEBDIR@|\'$(gitwebdir_SQ)\'|" \
+		-e "s|@GIT_INTEROP_MAKE_OPTS@|\'$(GIT_INTEROP_MAKE_OPTS)\'|" \
+		-e "s|@GIT_PERF_LARGE_REPO@|\'$(GIT_PERF_LARGE_REPO)\'|" \
+		-e "s|@GIT_PERF_MAKE_COMMAND@|\'$(GIT_PERF_MAKE_COMMAND)\'|" \
+		-e "s|@GIT_PERF_MAKE_OPTS@|\'$(GIT_PERF_MAKE_OPTS)\'|" \
+		-e "s|@GIT_PERF_REPEAT_COUNT@|\'$(GIT_PERF_REPEAT_COUNT)\'|" \
+		-e "s|@GIT_PERF_REPO@|\'$(GIT_PERF_REPO)\'|" \
+		-e "s|@GIT_TEST_CMP@|\'$(GIT_TEST_CMP)\'|" \
+		-e "s|@GIT_TEST_CMP_USE_COPIED_CONTEXT@|\'$(GIT_TEST_CMP_USE_COPIED_CONTEXT)\'|" \
+		-e "s|@GIT_TEST_GITPERLLIB@|\'$(shell pwd)/perl/build/lib\'|" \
+		-e "s|@GIT_TEST_INDEX_VERSION@|\'$(GIT_TEST_INDEX_VERSION)\'|" \
+		-e "s|@GIT_TEST_MERGE_TOOLS_DIR@|\'$(shell pwd)/mergetools\'|" \
+		-e "s|@GIT_TEST_OPTS@|\'$(GIT_TEST_OPTS)\'|" \
+		-e "s|@GIT_TEST_PERL_FATAL_WARNINGS@|\'$(GIT_TEST_PERL_FATAL_WARNINGS)\'|" \
+		-e "s|@GIT_TEST_POPATH@|\'$(shell pwd)/po\'|" \
+		-e "s|@GIT_TEST_TEMPLATE_DIR@|\'$(shell pwd)/templates/blt\'|" \
+		-e "s|@GIT_TEST_TEXTDOMAINDIR@|\'$(shell pwd)/po/build/locale\'|" \
+		-e "s|@GIT_TEST_UTF8_LOCALE@|\'$(GIT_TEST_UTF8_LOCALE)\'|" \
+		-e "s|@LOCALEDIR@|\'$(localedir_SQ)\'|" \
 		-e "s|@NO_CURL@|\'$(NO_CURL)\'|" \
-		-e "s|@NO_ICONV@|\'$(NO_ICONV)\'|" \
 		-e "s|@NO_EXPAT@|\'$(NO_EXPAT)\'|" \
-		-e "s|@USE_LIBPCRE2@|\'$(USE_LIBPCRE2)\'|" \
+		-e "s|@NO_GETTEXT@|\'$(NO_GETTEXT)\'|" \
+		-e "s|@NO_ICONV@|\'$(NO_ICONV)\'|" \
 		-e "s|@NO_PERL@|\'$(NO_PERL)\'|" \
+		-e "s|@NO_PERL_CPAN_FALLBACKS@|\'$(NO_PERL_CPAN_FALLBACKS_SQ)\'|" \
 		-e "s|@NO_PTHREADS@|\'$(NO_PTHREADS)\'|" \
 		-e "s|@NO_PYTHON@|\'$(NO_PYTHON)\'|" \
 		-e "s|@NO_REGEX@|\'$(NO_REGEX)\'|" \
 		-e "s|@NO_UNIX_SOCKETS@|\'$(NO_UNIX_SOCKETS)\'|" \
 		-e "s|@PAGER_ENV@|\'$(PAGER_ENV)\'|" \
-		-e "s|@SANITIZE_LEAK@|\'$(SANITIZE_LEAK)\'|" \
+		-e "s|@PERL_LOCALEDIR@|\'$(perl_localedir_SQ)\'|" \
+		-e "s|@PERL_PATH@|\'$(PERL_PATH_SQ)\'|" \
+		-e "s|@PYTHON_PATH@|\'$(PYTHON_PATH_SQ)\'|" \
+		-e "s|@RUNTIME_PREFIX@|\'$(RUNTIME_PREFIX_OPTION)\'|" \
 		-e "s|@SANITIZE_ADDRESS@|\'$(SANITIZE_ADDRESS)\'|" \
-		-e "s|@X@|\'$(X)\'|" \
-		-e "s|@FSMONITOR_DAEMON_BACKEND@|\'$(FSMONITOR_DAEMON_BACKEND)\'|" \
-		-e "s|@FSMONITOR_OS_SETTINGS@|\'$(FSMONITOR_OS_SETTINGS)\'|" \
+		-e "s|@SANITIZE_LEAK@|\'$(SANITIZE_LEAK)\'|" \
+		-e "s|@SHELL_PATH@|\'$(SHELL_PATH_SQ)\'|" \
+		-e "s|@TAR@|\'$(TAR)\'|" \
 		-e "s|@TEST_OUTPUT_DIRECTORY@|\'$(TEST_OUTPUT_DIRECTORY)\'|" \
-		-e "s|@GIT_TEST_OPTS@|\'$(GIT_TEST_OPTS)\'|" \
-		-e "s|@GIT_TEST_CMP@|\'$(GIT_TEST_CMP)\'|" \
-		-e "s|@GIT_TEST_CMP_USE_COPIED_CONTEXT@|\'$(GIT_TEST_CMP_USE_COPIED_CONTEXT)\'|" \
-		-e "s|@GIT_TEST_UTF8_LOCALE@|\'$(GIT_TEST_UTF8_LOCALE)\'|" \
-		-e "s|@NO_GETTEXT@|\'$(NO_GETTEXT)\'|" \
-		-e "s|@GIT_PERF_REPEAT_COUNT@|\'$(GIT_PERF_REPEAT_COUNT)\'|" \
-		-e "s|@GIT_PERF_REPO@|\'$(GIT_PERF_REPO)\'|" \
-		-e "s|@GIT_PERF_LARGE_REPO@|\'$(GIT_PERF_LARGE_REPO)\'|" \
-		-e "s|@GIT_PERF_MAKE_OPTS@|\'$(GIT_PERF_MAKE_OPTS)\'|" \
-		-e "s|@GIT_PERF_MAKE_COMMAND@|\'$(GIT_PERF_MAKE_COMMAND)\'|" \
-		-e "s|@GIT_INTEROP_MAKE_OPTS@|\'$(GIT_INTEROP_MAKE_OPTS)\'|" \
-		-e "s|@GIT_TEST_INDEX_VERSION@|\'$(GIT_TEST_INDEX_VERSION)\'|" \
-		-e "s|@GIT_TEST_PERL_FATAL_WARNINGS@|\'$(GIT_TEST_PERL_FATAL_WARNINGS)\'|" \
-		-e "s|@GIT_TEST_TEXTDOMAINDIR@|\'$(shell pwd)/po/build/locale\'|" \
-		-e "s|@GIT_TEST_POPATH@|\'$(shell pwd)/po\'|" \
-		-e "s|@GIT_TEST_TEMPLATE_DIR@|\'$(shell pwd)/templates/blt\'|" \
-		-e "s|@GIT_TEST_GITPERLLIB@|\'$(shell pwd)/perl/build/lib\'|" \
-		-e "s|@GIT_TEST_MERGE_TOOLS_DIR@|\'$(shell pwd)/mergetools\'|" \
-		-e "s|@RUNTIME_PREFIX@|\'$(RUNTIME_PREFIX_OPTION)\'|" \
-		-e "s|@GITWEBDIR@|\'$(gitwebdir_SQ)\'|" \
+		-e "s|@TEST_SHELL_PATH@|\'$(TEST_SHELL_PATH_SQ)\'|" \
 		-e "s|@USE_GETTEXT_SCHEME@|\'$(USE_GETTEXT_SCHEME)\'|" \
-		-e "s|@LOCALEDIR@|\'$(localedir_SQ)\'|" \
-		-e "s!@BROKEN_PATH_FIX@!\'$(BROKEN_PATH_FIX)\'!" \
+		-e "s|@USE_LIBPCRE2@|\'$(USE_LIBPCRE2)\'|" \
+		-e "s|@X@|\'$(X)\'|" \
 		GIT-BUILD-OPTIONS.in >$@+
 	@if grep -q '^[A-Z][A-Z_]*=@.*@$$' $@+; then echo "Unsubstituted build options in $@" >&2 && exit 1; fi
 	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 802445c1eb0e8b109d79083367553f3892ce5084..f45407b060221bf900fd0a19a315f0d0dce23147 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1158,53 +1158,53 @@ if(NOT PYTHON_TESTS)
 endif()
 
 file(STRINGS ${CMAKE_SOURCE_DIR}/GIT-BUILD-OPTIONS.in git_build_options NEWLINE_CONSUME)
-string(REPLACE "@SHELL_PATH@" "'${SHELL_PATH}'" git_build_options "${git_build_options}")
-string(REPLACE "@TEST_SHELL_PATH@" "'${TEST_SHELL_PATH}'" git_build_options "${git_build_options}")
-string(REPLACE "@PERL_PATH@" "'${PERL_PATH}'" git_build_options "${git_build_options}")
-string(REPLACE "@PERL_LOCALEDIR@" "'${LOCALEDIR}'" git_build_options "${git_build_options}")
-string(REPLACE "@NO_PERL_CPAN_FALLBACKS@" "" git_build_options "${git_build_options}")
+string(REPLACE "@BROKEN_PATH_FIX@" "" git_build_options "${git_build_options}")
 string(REPLACE "@DIFF@" "'${DIFF}'" git_build_options "${git_build_options}")
-string(REPLACE "@PYTHON_PATH@" "'${PYTHON_PATH}'" git_build_options "${git_build_options}")
-string(REPLACE "@TAR@" "'${TAR}'" git_build_options "${git_build_options}")
+string(REPLACE "@FSMONITOR_DAEMON_BACKEND@" "win32" git_build_options "${git_build_options}")
+string(REPLACE "@FSMONITOR_OS_SETTINGS@" "win32" git_build_options "${git_build_options}")
+string(REPLACE "@GITWEBDIR@" "'${GITWEBDIR}'" git_build_options "${git_build_options}")
+string(REPLACE "@GIT_INTEROP_MAKE_OPTS@" "" git_build_options "${git_build_options}")
+string(REPLACE "@GIT_PERF_LARGE_REPO@" "" git_build_options "${git_build_options}")
+string(REPLACE "@GIT_PERF_MAKE_COMMAND@" "" git_build_options "${git_build_options}")
+string(REPLACE "@GIT_PERF_MAKE_OPTS@" "" git_build_options "${git_build_options}")
+string(REPLACE "@GIT_PERF_REPEAT_COUNT@" "" git_build_options "${git_build_options}")
+string(REPLACE "@GIT_PERF_REPO@" "" git_build_options "${git_build_options}")
+string(REPLACE "@GIT_TEST_CMP@" "" git_build_options "${git_build_options}")
+string(REPLACE "@GIT_TEST_CMP_USE_COPIED_CONTEXT@" "" git_build_options "${git_build_options}")
+string(REPLACE "@GIT_TEST_GITPERLLIB@" "'${CMAKE_BINARY_DIR}/perl/build/lib'" git_build_options "${git_build_options}")
+string(REPLACE "@GIT_TEST_INDEX_VERSION@" "" git_build_options "${git_build_options}")
+string(REPLACE "@GIT_TEST_MERGE_TOOLS_DIR@" "'${CMAKE_BINARY_DIR}/mergetools'" git_build_options "${git_build_options}")
+string(REPLACE "@GIT_TEST_OPTS@" "" git_build_options "${git_build_options}")
+string(REPLACE "@GIT_TEST_PERL_FATAL_WARNINGS@" "" git_build_options "${git_build_options}")
+string(REPLACE "@GIT_TEST_POPATH@" "'${CMAKE_BINARY_DIR}/po'" git_build_options "${git_build_options}")
+string(REPLACE "@GIT_TEST_TEMPLATE_DIR@" "'${CMAKE_BINARY_DIR}/templates/blt'" git_build_options "${git_build_options}")
+string(REPLACE "@GIT_TEST_TEXTDOMAINDIR@" "'${CMAKE_BINARY_DIR}/po/build/locale'" git_build_options "${git_build_options}")
+string(REPLACE "@GIT_TEST_UTF8_LOCALE@" "" git_build_options "${git_build_options}")
+string(REPLACE "@LOCALEDIR@" "'${LOCALEDIR}'" git_build_options "${git_build_options}")
 string(REPLACE "@NO_CURL@" "${NO_CURL}" git_build_options "${git_build_options}")
-string(REPLACE "@NO_ICONV@" "${NO_ICONV}" git_build_options "${git_build_options}")
 string(REPLACE "@NO_EXPAT@" "${NO_EXPAT}" git_build_options "${git_build_options}")
-string(REPLACE "@USE_LIBPCRE2@" "" git_build_options "${git_build_options}")
+string(REPLACE "@NO_GETTEXT@" "${NO_GETTEXT}" git_build_options "${git_build_options}")
+string(REPLACE "@NO_ICONV@" "${NO_ICONV}" git_build_options "${git_build_options}")
 string(REPLACE "@NO_PERL@" "${NO_PERL}" git_build_options "${git_build_options}")
+string(REPLACE "@NO_PERL_CPAN_FALLBACKS@" "" git_build_options "${git_build_options}")
 string(REPLACE "@NO_PTHREADS@" "${NO_PTHREADS}" git_build_options "${git_build_options}")
 string(REPLACE "@NO_PYTHON@" "${NO_PYTHON}" git_build_options "${git_build_options}")
 string(REPLACE "@NO_REGEX@" "" git_build_options "${git_build_options}")
 string(REPLACE "@NO_UNIX_SOCKETS@" "${NO_UNIX_SOCKETS}" git_build_options "${git_build_options}")
 string(REPLACE "@PAGER_ENV@" "'${PAGER_ENV}'" git_build_options "${git_build_options}")
-string(REPLACE "@SANITIZE_LEAK@" "" git_build_options "${git_build_options}")
+string(REPLACE "@PERL_LOCALEDIR@" "'${LOCALEDIR}'" git_build_options "${git_build_options}")
+string(REPLACE "@PERL_PATH@" "'${PERL_PATH}'" git_build_options "${git_build_options}")
+string(REPLACE "@PYTHON_PATH@" "'${PYTHON_PATH}'" git_build_options "${git_build_options}")
+string(REPLACE "@RUNTIME_PREFIX@" "'${RUNTIME_PREFIX}'" git_build_options "${git_build_options}")
 string(REPLACE "@SANITIZE_ADDRESS@" "" git_build_options "${git_build_options}")
-string(REPLACE "@X@" "${EXE_EXTENSION}" git_build_options "${git_build_options}")
-string(REPLACE "@FSMONITOR_DAEMON_BACKEND@" "win32" git_build_options "${git_build_options}")
-string(REPLACE "@FSMONITOR_OS_SETTINGS@" "win32" git_build_options "${git_build_options}")
+string(REPLACE "@SANITIZE_LEAK@" "" git_build_options "${git_build_options}")
+string(REPLACE "@SHELL_PATH@" "'${SHELL_PATH}'" git_build_options "${git_build_options}")
+string(REPLACE "@TAR@" "'${TAR}'" git_build_options "${git_build_options}")
 string(REPLACE "@TEST_OUTPUT_DIRECTORY@" "" git_build_options "${git_build_options}")
-string(REPLACE "@GIT_TEST_OPTS@" "" git_build_options "${git_build_options}")
-string(REPLACE "@GIT_TEST_CMP@" "" git_build_options "${git_build_options}")
-string(REPLACE "@GIT_TEST_CMP_USE_COPIED_CONTEXT@" "" git_build_options "${git_build_options}")
-string(REPLACE "@GIT_TEST_UTF8_LOCALE@" "" git_build_options "${git_build_options}")
-string(REPLACE "@NO_GETTEXT@" "${NO_GETTEXT}" git_build_options "${git_build_options}")
-string(REPLACE "@GIT_PERF_REPEAT_COUNT@" "" git_build_options "${git_build_options}")
-string(REPLACE "@GIT_PERF_REPO@" "" git_build_options "${git_build_options}")
-string(REPLACE "@GIT_PERF_LARGE_REPO@" "" git_build_options "${git_build_options}")
-string(REPLACE "@GIT_PERF_MAKE_OPTS@" "" git_build_options "${git_build_options}")
-string(REPLACE "@GIT_PERF_MAKE_COMMAND@" "" git_build_options "${git_build_options}")
-string(REPLACE "@GIT_INTEROP_MAKE_OPTS@" "" git_build_options "${git_build_options}")
-string(REPLACE "@GIT_TEST_INDEX_VERSION@" "" git_build_options "${git_build_options}")
-string(REPLACE "@GIT_TEST_PERL_FATAL_WARNINGS@" "" git_build_options "${git_build_options}")
-string(REPLACE "@GIT_TEST_TEXTDOMAINDIR@" "'${CMAKE_BINARY_DIR}/po/build/locale'" git_build_options "${git_build_options}")
-string(REPLACE "@GIT_TEST_POPATH@" "'${CMAKE_BINARY_DIR}/po'" git_build_options "${git_build_options}")
-string(REPLACE "@GIT_TEST_TEMPLATE_DIR@" "'${CMAKE_BINARY_DIR}/templates/blt'" git_build_options "${git_build_options}")
-string(REPLACE "@GIT_TEST_GITPERLLIB@" "'${CMAKE_BINARY_DIR}/perl/build/lib'" git_build_options "${git_build_options}")
-string(REPLACE "@GIT_TEST_MERGE_TOOLS_DIR@" "'${CMAKE_BINARY_DIR}/mergetools'" git_build_options "${git_build_options}")
-string(REPLACE "@RUNTIME_PREFIX@" "'${RUNTIME_PREFIX}'" git_build_options "${git_build_options}")
-string(REPLACE "@GITWEBDIR@" "'${GITWEBDIR}'" git_build_options "${git_build_options}")
+string(REPLACE "@TEST_SHELL_PATH@" "'${TEST_SHELL_PATH}'" git_build_options "${git_build_options}")
 string(REPLACE "@USE_GETTEXT_SCHEME@" "" git_build_options "${git_build_options}")
-string(REPLACE "@LOCALEDIR@" "'${LOCALEDIR}'" git_build_options "${git_build_options}")
-string(REPLACE "@BROKEN_PATH_FIX@" "" git_build_options "${git_build_options}")
+string(REPLACE "@USE_LIBPCRE2@" "" git_build_options "${git_build_options}")
+string(REPLACE "@X@" "${EXE_EXTENSION}" git_build_options "${git_build_options}")
 if(USE_VCPKG)
 	string(APPEND git_build_options "PATH=\"$PATH:$TEST_DIRECTORY/../compat/vcbuild/vcpkg/installed/x64-windows/bin\"\n")
 endif()

-- 
2.48.0.rc0.311.gb6c66824c1.dirty

