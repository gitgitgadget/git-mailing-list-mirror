Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292D21E00AB
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 14:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485834; cv=none; b=mm916NS93mLXqhwzPfHcxnKQTUACFn0VIJzTHut221bh20hdkVK/H5JJsMPrrXqCRqj0ZoPjCljdnGxvW5B+MOkeGiokUGqW1B/dgKZdysb9bwQEvkOeRvhzxdAIpyRDqwCRe/pPrCVnnCFKDuImyydYjd0+ndlevIc6tNKMWO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485834; c=relaxed/simple;
	bh=tymBAXt0Hwn6z5TIsexqx+fydviDih27pZ0rNcxcKD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gquGjRIQyvYcyub4P+8FUwyfPzyOEde6itmdUQ7VGIjcguJZ0wqRKJMpQ3vW6thUbKHVHjNwMsWpCDC9XW1d3oHYFN/2URSahHKoVbBWmcUjAeKF2yFO/PvMATFzcFUWN8rQKDMHOiC/C0THi/TSKWtgi0hFVAm4QW+Oy9Pb+nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aZwCyHo4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b0/3KuU4; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aZwCyHo4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b0/3KuU4"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 873BD13801D8;
	Wed,  9 Oct 2024 10:57:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 09 Oct 2024 10:57:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728485832; x=1728572232; bh=bNj569NXAr
	9px6QicReMLIwoO9rHXhNPmo0PSNx4MLM=; b=aZwCyHo4m4UMIUN+hvveAOMcfi
	2WJrlZ0HCgjzvaMip8NbGp+3nNExm23PBdnEwMlES4bRYR/X3owjk13cCN7ka1RB
	xxXBbaUfbJ4qXiPBFw+gEorLNDdf+nAT9EupQx0psXTod+d2yEjgjlTmkEm5QItx
	mGofjyDtP729CneWBf13D7KiPPnaUvvbNO95kJocvxa0oCIkh7u7OZJkQCvOxCGI
	M2qYj+Pc59Yjr6/2upnlGm704xzesjAueM7oGvFt+S38Az50iaITKyILoYstgYOF
	0f7CssHd3JqopvNbbI9JEDRSqZV9A5Qu4CzSWnIf0r+y9alkJB+cilSMhtjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728485832; x=1728572232; bh=bNj569NXAr9px6QicReMLIwoO9rH
	XhNPmo0PSNx4MLM=; b=b0/3KuU4fndXsE+ZYLNVe1Sbkxp95eaun55hwG9osQvG
	HIgOmryvgNlcQTDYKQn2hMXHnSmaqEX+Jwqygjb+o3NTC4lhP8FZDHOMFmuYGjqw
	8SeSwqsX+efCNHzzWbnG9MNBqgdMW3lmSVHARbIW331XRbUQi6JYzFYdvB/KRWCb
	Y1gsdtMTyn2cQzm6jZ5bxD8ibMHd/EpUE8ORWwunTnwGS4bjTPWaOpie018nKRPB
	VxQnmOLFI/BuYTHXLILadvQ1A+XnThauvMmzrQncBySgUZv8fkykm91IdjPXiTSj
	QnOrkhU5enIyNZ8F3w+vBb/ZG0E8xPHgCGn8Q3Y/hg==
X-ME-Sender: <xms:yJkGZ2WiXHXzKkOsn8WdOb9TkQCMkrZx4pZP3WUMr38z37VWnhA3lQ>
    <xme:yJkGZyn_acXjxZ1ttx8NdKmsrk0jTSWyET3bjj-F1g39Ir-cLRveu5UnkASZQN9IM
    ZlNJl7F32urRKv3SA>
X-ME-Received: <xmr:yJkGZ6bSjAiwMRNarIxqW5Fnl6YPlXZno-UdALAdhKXnHGzpUHVxwN8DWUTT1XOpLN3iF0CzLTzbwrG7GRBCCD7ZUQBJVe4GDAoCeuH1L5YrlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepheenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohep
    phhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegvsh
    gthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:yJkGZ9VAIpNtmtCQZ0YJjfQvOlGtWAAtHO4Q8ajaNDgmqYvjEjk4VA>
    <xmx:yJkGZwm9dCIB6blVJBQLoVwJbHE43rGHbw4rKOdnYSRfz_-LyaKYbg>
    <xmx:yJkGZycvvSAux02hul458ACrNvraGyGN8TgCewJPcbVCu4YUEjJJOg>
    <xmx:yJkGZyGve6WnHd1yjQLyAFEa21fXtaC0hU4NTGS5NJ8UzQYquYIcUg>
    <xmx:yJkGZ_vpar54UzX9vX9P8XPXVHKXcDDGXxieSJZ6L-wZLGfO3MbrjQmy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 10:57:11 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 395c695c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Oct 2024 14:56:07 +0000 (UTC)
Date: Wed, 9 Oct 2024 16:57:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH v2 21/24] t: better support for out-of-tree builds
Message-ID: <1172c44060024eac3f10a615add8969ca98157a2.1728485139.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1728485139.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728485139.git.ps@pks.im>

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
index f0ca240493c..cce06577840 100644
--- a/GIT-BUILD-OPTIONS.in
+++ b/GIT-BUILD-OPTIONS.in
@@ -33,4 +33,9 @@ GIT_PERF_MAKE_COMMAND=@GIT_PERF_MAKE_COMMAND@
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
index 554d8ea83b2..7764d3e284c 100644
--- a/Makefile
+++ b/Makefile
@@ -3194,6 +3194,11 @@ GIT-BUILD-OPTIONS: FORCE
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
@@ -3218,6 +3223,10 @@ all:: $(TEST_PROGRAMS) $(test_bindir_programs) $(UNIT_TEST_PROGS) $(CLAR_TEST_PR
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
index 7898a1c238d..1d3a59a0081 100755
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
index b95287468cd..bf5e2b5c08d 100644
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
 
@@ -1171,6 +1174,11 @@ string(REPLACE "@GIT_INTEROP_MAKE_OPTS@" "" git_build_options "${git_build_optio
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
index cc6bb2cdeaa..7a734c6973e 100644
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
index 8b1c3bd39f2..a9273ba58d7 100755
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
index 4dd641baefe..677424ced06 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1478,7 +1478,7 @@ else # normal case, use ../bin-wrappers only unless $with_dashes:
 		PATH="$GIT_BUILD_DIR:$GIT_BUILD_DIR/t/helper:$PATH"
 	fi
 fi
-GIT_TEMPLATE_DIR="$GIT_BUILD_DIR"/templates/blt
+GIT_TEMPLATE_DIR="$GIT_TEST_TEMPLATE_DIR"
 GIT_CONFIG_NOSYSTEM=1
 GIT_ATTR_NOSYSTEM=1
 GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/.."
@@ -1494,9 +1494,9 @@ then
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
2.47.0.rc1.33.g90fe3800b9.dirty

