Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C02C1D1720
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 15:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882203; cv=none; b=klkOoHdgibWvHJfcWlqMsY2BhywXVXO0s5izpdtXHeiBpBLJZQDgwJFw6ucZr7AlJoOgvf9cBZfObvrcqTzVSHod4+Tvp3SEGMEcMk9mkG8PCv1Vp99NmIjIXqfeF7fAKZtrpEPjVPHS7nZjayFiEi2jyf6KYBRI0SFGvnpcYNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882203; c=relaxed/simple;
	bh=IDVwhURqWS2jkTw/PKwwi5Cqd3qJgNJf6uLLDcsEbWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOXEHR2RwMcpjtRECgRCn0i25JeMNLbWmvjUbCYWACLm3La7MJACCDckqpMxINwDIWqz6Sxoq2COXiof3VKUZdxeWb8G8xa2XV/OxZKwdHBRklAe3mISluZxzMkBLk1VhVllWpwzXiQSJJQmWqGQAlkiRENyzLc9zQ0drCQ2r70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Huyan8rq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dQfRi8wR; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Huyan8rq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dQfRi8wR"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 37DA113801D9;
	Wed,  2 Oct 2024 11:16:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 02 Oct 2024 11:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727882201; x=1727968601; bh=ZGPsE/82zv
	wmi3zkjCXYTNz4sKF2+iiyahv0DtwwWZw=; b=Huyan8rqKrSozBFBKiB6F3Vp47
	p+8XhH+rKm037aouKC0EnM7Eum8+6aieH4gie8KEm5IxHfy/p0uwt2TqCHmz5r84
	a5FaGdp5nwH0Ck71kEhOM7/+RnL6K5jQgaiQ5Z+Bq5JXHj5tPaRw9vnfJmqe4vaf
	FmOim1c5QG/90tmkaiXEphAmU7UGBLRvErRTfjvLNXeuDUVR+4DOWgmjFyV5a+fH
	1aSgP1PsaEh16rHEPZ1tsIPpzs5GN6hRSNzBPftk/OYvdoyiM0gsbrqD6rr0KWKi
	U/qYHOavuLkh7EaqkhK7G65TkL+7srgkJ2JG7hOcBxEM/aKjQ24GPZ2yGAtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727882201; x=1727968601; bh=ZGPsE/82zvwmi3zkjCXYTNz4sKF2
	+iiyahv0DtwwWZw=; b=dQfRi8wRehC79OSlNqOUuwC902S3BtAVfdv47PgqhbQ4
	4Y6N9kt4NquCmoSzSPeNzzUr5CCdiwqnfGvCvd/z46wIZ6mDUMYCj2DN2g55AwqP
	SuSN5dyJTYwaBflKr6E6kjSSRmm8VWwv/AHGHGQk5dIrJtF7RTHednjdtLgz8lJU
	QsaLPf6yqZAEVqAc4CadIafG01nZQiK/AUVxyYxZ+LKruIyWHe17NWfKGW6aDGPL
	ukH7pMTv6P516wD2c59L6DsPm0JmczoJIHCknjYPhbiqadIIWuVMSR0dMsDcFYCx
	IJkwx+xHBmllTMVHXoCYZNXE1QEniJ5YofFO01fGSA==
X-ME-Sender: <xms:2GP9ZsHK7yEdXhaXa-ht5JkM2DSfoCt5lMnEl3k43wdWW4PBSCE4BA>
    <xme:2GP9ZlXWJHNlWt8uG2hfe_zuLY8SDxYfUhiSGrtsShbKBRTZ3MEdtx_VywgTRoDMn
    OZKyHJI-Mcq6NGAuQ>
X-ME-Received: <xmr:2GP9ZmL4-2JdrPd5Ztas2EffRKoOWhlD36GG_tPWYGRXExXoaj1IEv6HZWPLuZHxdjEwLGzeOeNDFQBxV2vIYwp2TGOilwcyRNgZi3HG1rTP-SdW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrgh
X-ME-Proxy: <xmx:2WP9ZuE5rMHFLnZFARww30AB2sMiBIny804wK6IaRHSa35blpXGHsg>
    <xmx:2WP9ZiWPBOjHwQBznnDxoYE19KSAhHjFG07QhvnSzZeMJKYEYFW9Qg>
    <xmx:2WP9ZhPNjm9wMM3sF18dLnA1fUC1fqLUkAioGx6-77Nd7im31ZqaBw>
    <xmx:2WP9Zp30LcbFfZadUQzweN-nhc5IMb_081IrHNfD6Ddh42U_r2L5hw>
    <xmx:2WP9Zvh7oiVF76K7H1Q3U_ncEGEi8WWd38MUGHnzbR9YfmLAr2Zv1cD4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 11:16:40 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dfdb323a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 15:15:49 +0000 (UTC)
Date: Wed, 2 Oct 2024 17:16:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>
Subject: [RFC PATCH 19/21] t: better support for out-of-tree builds
Message-ID: <7a0a6b996c3dea5fd8061dd3714047bee59e566c.1727881164.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727881164.git.ps@pks.im>

Our in-tree builds used by the Makefile use various different build
directories scattered around different locations. The paths to those
build directories have to be propagated to our tests such that they can
find the contained files. This is done via a mixture of hardcoded paths
in our test library and injected variables in our bin-wrappers or
"GIT-BUILD-OPTIONS".

The latter two mechanisms are preferable over using hardcoded paths. For
one, we have all paths which are subject to change stored in a small set
of central files instead of having the knowledge of build paths in many
files. And second, it allows build systems which build files elsewhere
to adapt those paths based on their own needs. This is especially nice
in the context of build systems that use out-of-tree builds like CMake
or Meson.

Remove hardcoded knowledge of build paths from our test library and move
it into our bin-wrappers and "GIT-BUILD-OPTIONS".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 GIT-BUILD-OPTIONS.in                |  5 +++++
 Makefile                            |  9 +++++++++
 bin-wrappers/wrap-for-bin.sh        | 11 ++++++-----
 contrib/buildsystems/CMakeLists.txt |  8 ++++++++
 t/lib-gettext.sh                    |  4 ++--
 t/t7609-mergetool--lib.sh           |  2 +-
 t/test-lib.sh                       |  6 +++---
 7 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/GIT-BUILD-OPTIONS.in b/GIT-BUILD-OPTIONS.in
index e73cd5fa1a..2b3f5ef2d6 100644
--- a/GIT-BUILD-OPTIONS.in
+++ b/GIT-BUILD-OPTIONS.in
@@ -32,4 +32,9 @@ GIT_PERF_MAKE_COMMAND=@GIT_PERF_MAKE_COMMAND@
 GIT_INTEROP_MAKE_OPTS=@GIT_INTEROP_MAKE_OPTS@
 GIT_TEST_INDEX_VERSION=@GIT_TEST_INDEX_VERSION@
 GIT_TEST_PERL_FATAL_WARNINGS=@GIT_TEST_PERL_FATAL_WARNINGS@
+GIT_TEST_TEXTDOMAINDIR=@GIT_TEST_TEXTDOMAINDIR@
+GIT_TEST_POPATH=@GIT_TEST_POPATH@
+GIT_TEST_TEMPLATE_DIR=@GIT_TEST_TEMPLATE_DIR@
+GIT_TEST_GITPERLLIB=@GIT_TEST_GITPERLLIB@
+GIT_TEST_MERGE_TOOLS_DIR=@GIT_TEST_MERGE_TOOLS_DIR@
 RUNTIME_PREFIX=@RUNTIME_PREFIX@
diff --git a/Makefile b/Makefile
index b0c21c4c0d..e6b75b6e3e 100644
--- a/Makefile
+++ b/Makefile
@@ -3168,6 +3168,11 @@ GIT-BUILD-OPTIONS: FORCE
 		-e "s|@GIT_INTEROP_MAKE_OPTS@|\'$(GIT_INTEROP_MAKE_OPTS)\'|" \
 		-e "s|@GIT_TEST_INDEX_VERSION@|\'$(GIT_TEST_INDEX_VERSION)\'|" \
 		-e "s|@GIT_TEST_PERL_FATAL_WARNINGS@|\'$(GIT_TEST_PERL_FATAL_WARNINGS)\'|" \
+		-e "s|@GIT_TEST_TEXTDOMAINDIR@|\'$(shell pwd)/po/build/locale\'|" \
+		-e "s|@GIT_TEST_POPATH@|\'$(shell pwd)/po\'|" \
+		-e "s|@GIT_TEST_TEMPLATE_DIR@|\'$(shell pwd)/templates/blt\'|" \
+		-e "s|@GIT_TEST_GITPERLLIB@|\'$(shell pwd)/perl/build/lib\'|" \
+		-e "s|@GIT_TEST_MERGE_TOOLS_DIR@|\'$(shell pwd)/mergetools\'|" \
 		-e "s|@RUNTIME_PREFIX@|\'$(RUNTIME_PREFIX)\'|" \
 		GIT-BUILD-OPTIONS.in >$@+
 	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
@@ -3192,6 +3197,10 @@ all:: $(TEST_PROGRAMS) $(test_bindir_programs) $(UNIT_TEST_PROGS) $(CLAR_TEST_PR
 bin-wrappers/%: bin-wrappers/wrap-for-bin.sh
 	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	     -e 's|@BUILD_DIR@|$(shell pwd)|' \
+	     -e 's|@GIT_TEXTDOMAINDIR@|$(shell pwd)/po/build/locale|' \
+	     -e 's|@GITPERLLIB@|$(shell pwd)/perl/build/lib|' \
+	     -e 's|@MERGE_TOOLS_DIR@|$(shell pwd)/mergetools|' \
+	     -e 's|@TEMPLATE_DIR@|$(shell pwd)/templates/blt|' \
 	     -e 's|@PROG@|$(patsubst test-%,t/helper/test-%,$(@F))$(if $(filter-out $(BINDIR_PROGRAMS_NO_X),$(@F)),$(X),)|' < $< > $@ && \
 	chmod +x $@
 
diff --git a/bin-wrappers/wrap-for-bin.sh b/bin-wrappers/wrap-for-bin.sh
index 7898a1c238..1d3a59a008 100755
--- a/bin-wrappers/wrap-for-bin.sh
+++ b/bin-wrappers/wrap-for-bin.sh
@@ -4,21 +4,22 @@
 # to run test suite against sandbox, but with only bindir-installed
 # executables in PATH.  The Makefile copies this into various
 # files in bin-wrappers, substituting
-# @BUILD_DIR@ and @PROG@.
+# @BUILD_DIR@, @TEMPLATE_DIR@ and @PROG@.
 
 GIT_EXEC_PATH='@BUILD_DIR@'
 if test -n "$NO_SET_GIT_TEMPLATE_DIR"
 then
 	unset GIT_TEMPLATE_DIR
 else
-	GIT_TEMPLATE_DIR='@BUILD_DIR@/templates/blt'
+	GIT_TEMPLATE_DIR='@TEMPLATE_DIR@'
 	export GIT_TEMPLATE_DIR
 fi
-GITPERLLIB='@BUILD_DIR@/perl/build/lib'"${GITPERLLIB:+:$GITPERLLIB}"
-GIT_TEXTDOMAINDIR='@BUILD_DIR@/po/build/locale'
+MERGE_TOOLS_DIR='@MERGE_TOOLS_DIR@'
+GITPERLLIB='@GITPERLLIB@'"${GITPERLLIB:+:$GITPERLLIB}"
+GIT_TEXTDOMAINDIR='@GIT_TEXTDOMAINDIR@'
 PATH='@BUILD_DIR@/bin-wrappers:'"$PATH"
 
-export GIT_EXEC_PATH GITPERLLIB PATH GIT_TEXTDOMAINDIR
+export MERGE_TOOLS_DIR GIT_EXEC_PATH GITPERLLIB PATH GIT_TEXTDOMAINDIR
 
 case "$GIT_DEBUGGER" in
 '')
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 23c2fb91ce..4048d3c367 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1087,6 +1087,9 @@ endforeach()
 
 file(STRINGS ${CMAKE_SOURCE_DIR}/bin-wrappers/wrap-for-bin.sh content NEWLINE_CONSUME)
 string(REPLACE "@BUILD_DIR@" "${CMAKE_BINARY_DIR}" content "${content}")
+string(REPLACE "@GIT_TEXTDOMAINDIR@" "${CMAKE_BINARY_DIR}/po/build/locale" content "${content}")
+string(REPLACE "@GITPERLLIB@" "${CMAKE_BINARY_DIR}/perl/build/lib" content "${content}")
+string(REPLACE "@MERGE_TOOLS_DIR@" "${CMAKE_SOURCE_DIR}/mergetools" content "${content}")
 string(REPLACE "@PROG@" "git-cvsserver" content "${content}")
 file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/git-cvsserver ${content})
 
@@ -1165,6 +1168,11 @@ string(REPLACE "@GIT_INTEROP_MAKE_OPTS@" "" git_build_options "${git_build_optio
 string(REPLACE "@GIT_TEST_INDEX_VERSION@" "" git_build_options "${git_build_options}")
 string(REPLACE "@GIT_TEST_PERL_FATAL_WARNINGS@" "" git_build_options "${git_build_options}")
 string(REPLACE "@RUNTIME_PREFIX@" "${RUNTIME_PREFIX}" git_build_options "${git_build_options}")
+string(REPLACE "@GIT_TEST_TEXTDOMAINDIR@" "${CMAKE_BINARY_DIR}/po/build/locale" git_build_options "${git_build_options}")
+string(REPLACE "@GIT_TEST_POPATH@" "${CMAKE_BINARY_DIR}/po" git_build_options "${git_build_options}")
+string(REPLACE "@GIT_TEST_TEMPLATE_DIR@" "${CMAKE_BINARY_DIR}/templates/blt" git_build_options "${git_build_options}")
+string(REPLACE "@GIT_TEST_GITPERLLIB@" "${CMAKE_BINARY_DIR}/perl/build/lib" git_build_options "${git_build_options}")
+string(REPLACE "@GIT_TEST_MERGE_TOOLS_DIR@" "${RUNTIME_PREFIX}" git_build_options "${git_build_options}")
 if(USE_VCPKG)
 	string(APPEND git_build_options "PATH=\"$PATH:$TEST_DIRECTORY/../compat/vcbuild/vcpkg/installed/x64-windows/bin\"\n")
 endif()
diff --git a/t/lib-gettext.sh b/t/lib-gettext.sh
index cc6bb2cdea..7a734c6973 100644
--- a/t/lib-gettext.sh
+++ b/t/lib-gettext.sh
@@ -6,8 +6,8 @@
 
 . ./test-lib.sh
 
-GIT_TEXTDOMAINDIR="$GIT_BUILD_DIR/po/build/locale"
-GIT_PO_PATH="$GIT_BUILD_DIR/po"
+GIT_TEXTDOMAINDIR="$GIT_TEST_TEXTDOMAINDIR"
+GIT_PO_PATH="$GIT_TEST_POPATH"
 export GIT_TEXTDOMAINDIR GIT_PO_PATH
 
 if test -n "$GIT_TEST_INSTALLED"
diff --git a/t/t7609-mergetool--lib.sh b/t/t7609-mergetool--lib.sh
index 8b1c3bd39f..a9273ba58d 100755
--- a/t/t7609-mergetool--lib.sh
+++ b/t/t7609-mergetool--lib.sh
@@ -8,7 +8,7 @@ TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'mergetool --tool=vimdiff creates the expected layout' '
-	. "$GIT_BUILD_DIR"/mergetools/vimdiff &&
+	. "$GIT_TEST_MERGE_TOOLS_DIR"/vimdiff &&
 	run_unit_tests
 '
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 3fab470f3b..e36a21ddf7 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1504,7 +1504,7 @@ else # normal case, use ../bin-wrappers only unless $with_dashes:
 		PATH="$GIT_BUILD_DIR:$GIT_BUILD_DIR/t/helper:$PATH"
 	fi
 fi
-GIT_TEMPLATE_DIR="$GIT_BUILD_DIR"/templates/blt
+GIT_TEMPLATE_DIR="$GIT_TEST_TEMPLATE_DIR"
 GIT_CONFIG_NOSYSTEM=1
 GIT_ATTR_NOSYSTEM=1
 GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/.."
@@ -1520,9 +1520,9 @@ then
 	fi
 fi
 
-GITPERLLIB="$GIT_BUILD_DIR"/perl/build/lib
+GITPERLLIB="$GIT_TEST_GITPERLLIB"
 export GITPERLLIB
-test -d "$GIT_BUILD_DIR"/templates/blt || {
+test -d "$GIT_TEMPLATE_DIR" || {
 	BAIL_OUT "You haven't built things yet, have you?"
 }
 
-- 
2.47.0.rc0.dirty

