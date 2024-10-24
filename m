Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0376B1D8A12
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 12:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729773640; cv=none; b=OqkBF0lGXtfi3fuGTvnL1HaPM+nh/r6OByo9516tAHnuSusdDlBaIrICWoti4GXtctg5Bis6FB3eYUdshaxYXHfqKMWRKSurgd0JPp1S/+O40k2EF1hzDNckC6R0DsDdQvCakWcWpgKpVhLunSFHsSdM9tZjdHpOsl1qa9tKXHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729773640; c=relaxed/simple;
	bh=NAVsD4quCli6PS91n1MIFeCrG+1ckZe6opQR4lU21pU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AffMTQJb0ujssJ6/xLB6+u2h0Uf/cqaC7f337hR+qQjjLG9uokb0hjqE+DWhPII+/kM2u9K0k4i1wRAGAyU/bHU+p5a9gelhK2BntAQu61iWjlBivf6hOFax1tGuHcmrvQeVBDuxOa17IFZvZSr4sIfVHa63tKchCJ7AmByCR9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Qhewb9GH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c4lmD/vc; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Qhewb9GH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c4lmD/vc"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 17DF625400C8;
	Thu, 24 Oct 2024 08:40:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 24 Oct 2024 08:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729773636; x=1729860036; bh=m03yDItTpf
	8Lj5ElroED2D3GKbY6C4l0J1BIqtq2dVk=; b=Qhewb9GHO/aWKFLoH9GlKZJAyD
	UCVGMpcjwd/oqof5J8jkKN5MYGAIv1XU+H5Cz4ck0asKfOvwCjS86zYzUPas5n21
	+pqXVcxHqmbo7ZHJNieqgqbRAdcNmgPg4aT8mYOsvthvkt8y7eHjjNgDCKiBEPrZ
	MK6UQou/1OT5j6BLuMsf8Wl5aKqV420flsUGP+NLsc3ZIRJe+DDUxbYQIGN7Kf4w
	KRo9sVCdtiPFmQEDFSGKGV23vQO7HDJC/l00GKV9FM3iUctSWWGe86IYzo20UTrS
	gON0jBPqHBOy8UmFCSoyYARPw6/xqxFLBxLp5lwHYJH8FzgqKpThvj9QtwFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729773636; x=1729860036; bh=m03yDItTpf8Lj5ElroED2D3GKbY6
	C4l0J1BIqtq2dVk=; b=c4lmD/vc8JnTatesqZgsf4y/z7Dl7LVNpDQpjKw6bsfb
	tpcNIOvOkfvhtvuYxj/3woNCLuNzSfUr2GEmLAxsNGwkP4ZSSoNX6z29+lTY0s5W
	Y8aQ+YF4mNkOb2WhDNfvdzh3K1WV4o8kf0DKTSAxeDrka/rAo//ekY7TJYWA+Ifd
	zZ/7qOcvKl/PA2m6i8Jr1KG1DD8NEI0tiN2oAQIF4oHLrUuUcNGpAW+wx8unYaUc
	P8+9VoojGSVL5xRRrmTjbe2pi820m80DjoloEsUH+qPtcBl7sQ8ZeF9Yc1Vx07lI
	ARIOKhVDd9J34VkwV0g/kgmjtwvfpZ+mgxl49kDsPQ==
X-ME-Sender: <xms:REAaZ9Ko6WL5PgSMvYBi3NkGfhQAnWRh4Lg5SmAfYbgcTPzJNH2CZg>
    <xme:REAaZ5KptxAKrqDStdVbScF3U1kV5wkgfbgIA5UVWPnOXS04N101LRs4lDRnn-J63
    A86Edg6rjhMVcHf9A>
X-ME-Received: <xmr:REAaZ1u3hAZ80EA7pAHqsXMJG-ygIU7irO5onCf1BlQ6uGD-PmfWWCkaHdKh4BXRHu5eproiDgNnW2RhY7Jde0I8H1H9wnEBDDtvnk_kP-lLZJMG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejtddgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepheenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehrrghmshgrhiesrhgrmh
    hsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiies
    ghgvnhhtohhordhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
    dprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:REAaZ-Y_BToytnVfCGhTIweUpf1OgSBF4hWewOc98JyAkNJiwQeknA>
    <xmx:REAaZ0ad8APyK3iPnvbTsWewe_2i39KlnxTuP65U7mFsuA63ax359g>
    <xmx:REAaZyB3LgyzcWGskb_RkmSEHTM59yCgCMXiKIwQXJjnJkiQxRFMGg>
    <xmx:REAaZyYK7fKn6bCAseNRYaqHZ5huEaX4qdjF8Ae0fUwtL9OtgnzZHg>
    <xmx:REAaZ068hjZQQh_xeuIyvwp4XLLNk0DYuq_2Qt1CYYsopGWrKyXZVrZw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Oct 2024 08:40:35 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4f1f94aa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Oct 2024 12:40:37 +0000 (UTC)
Date: Thu, 24 Oct 2024 14:40:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [RFC PATCH v4 15/19] t: better support for out-of-tree builds
Message-ID: <ed3affb794cc0cee65404da716a5ab31116c223f.1729771605.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729771605.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729771605.git.ps@pks.im>

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
index 9b95a6b3eee..f651116102a 100644
--- a/GIT-BUILD-OPTIONS.in
+++ b/GIT-BUILD-OPTIONS.in
@@ -35,6 +35,11 @@ GIT_PERF_MAKE_COMMAND=@GIT_PERF_MAKE_COMMAND@
 GIT_INTEROP_MAKE_OPTS=@GIT_INTEROP_MAKE_OPTS@
 GIT_TEST_INDEX_VERSION=@GIT_TEST_INDEX_VERSION@
 GIT_TEST_PERL_FATAL_WARNINGS=@GIT_TEST_PERL_FATAL_WARNINGS@
+GIT_TEST_TEXTDOMAINDIR=@GIT_TEST_TEXTDOMAINDIR@
+GIT_TEST_POPATH=@GIT_TEST_POPATH@
+GIT_TEST_TEMPLATE_DIR=@GIT_TEST_TEMPLATE_DIR@
+GIT_TEST_GITPERLLIB=@GIT_TEST_GITPERLLIB@
+GIT_TEST_MERGE_TOOLS_DIR=@GIT_TEST_MERGE_TOOLS_DIR@
 RUNTIME_PREFIX=@RUNTIME_PREFIX@
 GITWEBDIR=@GITWEBDIR@
 USE_GETTEXT_SCHEME=@USE_GETTEXT_SCHEME@
diff --git a/Makefile b/Makefile
index c409a0e1b7d..1f0c3bc72ed 100644
--- a/Makefile
+++ b/Makefile
@@ -3173,6 +3173,11 @@ GIT-BUILD-OPTIONS: FORCE
 		-e "s|@GIT_INTEROP_MAKE_OPTS@|\'$(GIT_INTEROP_MAKE_OPTS)\'|" \
 		-e "s|@GIT_TEST_INDEX_VERSION@|\'$(GIT_TEST_INDEX_VERSION)\'|" \
 		-e "s|@GIT_TEST_PERL_FATAL_WARNINGS@|\'$(GIT_TEST_PERL_FATAL_WARNINGS)\'|" \
+		-e "s|@GIT_TEST_TEXTDOMAINDIR@|\'$(shell pwd)/po/build/locale\'|" \
+		-e "s|@GIT_TEST_POPATH@|\'$(shell pwd)/po\'|" \
+		-e "s|@GIT_TEST_TEMPLATE_DIR@|\'$(shell pwd)/templates/blt\'|" \
+		-e "s|@GIT_TEST_GITPERLLIB@|\'$(shell pwd)/perl/build/lib\'|" \
+		-e "s|@GIT_TEST_MERGE_TOOLS_DIR@|\'$(shell pwd)/mergetools\'|" \
 		-e "s|@RUNTIME_PREFIX@|\'$(RUNTIME_PREFIX)\'|" \
 		-e "s|@GITWEBDIR@|\'$(gitwebdir_SQ)\'|" \
 		-e "s|@USE_GETTEXT_SCHEME@|\'$(USE_GETTEXT_SCHEME)\'|" \
@@ -3202,6 +3207,10 @@ all:: $(TEST_PROGRAMS) $(test_bindir_programs) $(UNIT_TEST_PROGS) $(CLAR_TEST_PR
 $(test_bindir_programs): bin-wrappers/%: bin-wrappers/wrap-for-bin.sh
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
index ad4e3f0b6ce..f0a1a75382a 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1054,6 +1054,9 @@ endforeach()
 
 file(STRINGS ${CMAKE_SOURCE_DIR}/bin-wrappers/wrap-for-bin.sh content NEWLINE_CONSUME)
 string(REPLACE "@BUILD_DIR@" "${CMAKE_BINARY_DIR}" content "${content}")
+string(REPLACE "@GIT_TEXTDOMAINDIR@" "${CMAKE_BINARY_DIR}/po/build/locale" content "${content}")
+string(REPLACE "@GITPERLLIB@" "${CMAKE_BINARY_DIR}/perl/build/lib" content "${content}")
+string(REPLACE "@MERGE_TOOLS_DIR@" "${CMAKE_SOURCE_DIR}/mergetools" content "${content}")
 string(REPLACE "@PROG@" "git-cvsserver" content "${content}")
 file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/git-cvsserver ${content})
 
@@ -1139,6 +1142,11 @@ string(REPLACE "@GIT_PERF_MAKE_COMMAND@" "" git_build_options "${git_build_optio
 string(REPLACE "@GIT_INTEROP_MAKE_OPTS@" "" git_build_options "${git_build_options}")
 string(REPLACE "@GIT_TEST_INDEX_VERSION@" "" git_build_options "${git_build_options}")
 string(REPLACE "@GIT_TEST_PERL_FATAL_WARNINGS@" "" git_build_options "${git_build_options}")
+string(REPLACE "@GIT_TEST_TEXTDOMAINDIR@" "${CMAKE_BINARY_DIR}/po/build/locale" git_build_options "${git_build_options}")
+string(REPLACE "@GIT_TEST_POPATH@" "${CMAKE_BINARY_DIR}/po" git_build_options "${git_build_options}")
+string(REPLACE "@GIT_TEST_TEMPLATE_DIR@" "${CMAKE_BINARY_DIR}/templates/blt" git_build_options "${git_build_options}")
+string(REPLACE "@GIT_TEST_GITPERLLIB@" "${CMAKE_BINARY_DIR}/perl/build/lib" git_build_options "${git_build_options}")
+string(REPLACE "@GIT_TEST_MERGE_TOOLS_DIR@" "${RUNTIME_PREFIX}" git_build_options "${git_build_options}")
 string(REPLACE "@RUNTIME_PREFIX@" "${RUNTIME_PREFIX}" git_build_options "${git_build_options}")
 string(REPLACE "@GITWEBDIR@" "${GITWEBDIR}" git_build_options "${git_build_options}")
 string(REPLACE "@USE_GETTEXT_SCHEME@" "" git_build_options "${git_build_options}")
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
2.47.0.118.gfd3785337b.dirty

