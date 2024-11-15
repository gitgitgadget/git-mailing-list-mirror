Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4818E1898FB
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 07:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731655312; cv=none; b=SEoucOHbbDLaU/z6bUmT0CUga7WE9W0G4KLK3LW97pmRzx86BCBMZW4APAMkY9pJOzWoPUvPizjyZDvXz8+5+t2s+yYI0YVSCzjantj3A5JdKmorSUk9uchi0P7TT9CQCYf4NmoLVluRowvCBHGu6VUd+vC/FFU1vJX1H+Qgi+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731655312; c=relaxed/simple;
	bh=Mdh2RQVcLk5WSluJsK+zKr3t4/+xfHD0OgutigVLC8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K7GZJILaWqis/Ixcbr6yFEgJPg9uSqF/Oywcpnv5Y9f0I+TJj1PUMOvZgyMHRM2aAsxyLf95L4UXNw8ytyTBAjZ3RQQMo0T12Kam//n+WuYMRK8EotWZok/c/WKO3hXGEznbLk0R8QbIdVSRkMt9olk/izhSM7FMhL7hTGEo0cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=giYi2UFK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VrehLcfu; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="giYi2UFK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VrehLcfu"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id A765613806E1;
	Fri, 15 Nov 2024 02:21:49 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 15 Nov 2024 02:21:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731655309;
	 x=1731741709; bh=hDI59GRaB2RQ9hpuxALs+NFF5v+Dunw/QUZBQoNqCMM=; b=
	giYi2UFKbojPYNN9q4P/Q9+3T5UW9n1D8UZ450QczpS3uxFSS3fRj4n4lVdkfyai
	tK9sr6YIMf3DZGrhsNT8GPBWXa9Cs61nsb6GYL184a2+Gj21S+jqwYsNs9/NYnvp
	P9kXbJ1zqVx8N516LSMPhkx7StMJaciKRoThZfrY+NpkVgq3WFbHCOAwCNM2rSJn
	e0yt1xeR0jU7dcWJI4wjX2RrO/2b/Yu3ZuqvT2oyEdXUnYHApvNHO436yeeoai1H
	j5+phUagZhuASTCYnzSXXoQzBcdPhbMLq+J42y/O1SSiBoimvzntGmeriy9DtVlU
	cqkPxBXItRajUMKmlGurDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731655309; x=
	1731741709; bh=hDI59GRaB2RQ9hpuxALs+NFF5v+Dunw/QUZBQoNqCMM=; b=V
	rehLcfu75gnkJPXpAEYaIoelqtQDqwFJ6xm36teOrf95/5tFN4wuNt09sQ7kvmge
	XLcrSyFklY+4C79r2L4suqbh0YNHxW4ARu4BX3K3OUGKUPCM1vZGTJTOqwWb3Uew
	6uEZmxfmiJXiArF0X/aSOsVFh792jtArJ1m+FMeFBs7HE1EsKVTGdPFpL+ko75bR
	BVGkTv77A9vYk39wxKeKwtKxhtyyKONQuWbdVTrENQvIHgN3VAUNqf83PkBmLqw/
	z3itdZ7U8e6O+6+ENKE2BwbHsC6ru9QB/JXUAphvSYAyr0tWNpWp2ulw3WYKtLjn
	f6tmloHIgHJ+YCdzIiN8A==
X-ME-Sender: <xms:jfY2Z4ntXSfDD5oNHekSY4Ow5ET9QvXmdYmK3ahn40b_VrrZLj3LUA>
    <xme:jfY2Z31VqTa2CTbSsVpNHeup72cAQeWy8Kfl2Zb3wBHmfVPiN7VxUTKX7bkUMUj_P
    nZ9SEJXwT8t7frkjw>
X-ME-Received: <xmr:jfY2Z2oMhJU1OBXBx-hTyvOhLkdYDiblNOeSl1SgioyFhC4IEUeD7kWXE5PidhWvuKr8-bWK_2QHclgIQu_ET6mkJJW05kfNmzQgte2uUdtTO5eqLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdefgddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedutddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtth
    hopegurghvvhhiugesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvges
    shhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdho
    rhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomh
    dprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoheprhgrmhhs
    rgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:jfY2Z0nx--7YDQuClVlAJZraAuLiDJQn9OJG9-3koLIG1JyqBaytgA>
    <xmx:jfY2Z20WnRWN8oiECsdwHRly5OuFIgk1qJgIft2XL23m5cpRxsjGZw>
    <xmx:jfY2Z7sWawn-HEMqbtC9RBmLkaNJyjRN-y0bgseNEDxvMKZGy3fD1g>
    <xmx:jfY2ZyVBBsoDOORCewRwV8p0K2Xn3UEPdeSMQnxPqKoBq1-uj6K_8g>
    <xmx:jfY2Z_sd2lDE5SWpyPoTDkBs8Z9zdzcuJefzM93wrIBC0j2xZTgbWsaF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Nov 2024 02:21:47 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3412aac5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 15 Nov 2024 07:21:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 15 Nov 2024 08:21:30 +0100
Subject: [PATCH RFC v7 18/22] t: better support for out-of-tree builds
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-pks-meson-v7-18-47ec19b780b2@pks.im>
References: <20241115-pks-meson-v7-0-47ec19b780b2@pks.im>
In-Reply-To: <20241115-pks-meson-v7-0-47ec19b780b2@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>, 
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

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
index 9b95a6b3eee334b6f691702696ca9d92201b6bac..f651116102ae2977622dccd12b199fe7ad65af99 100644
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
index 056234e0bc0722ebc9f5d6ccae97f98fc9a64a37..26845907657ae7d87530dc8d3f51761127afa95f 100644
--- a/Makefile
+++ b/Makefile
@@ -3174,6 +3174,11 @@ GIT-BUILD-OPTIONS: FORCE
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
@@ -3203,6 +3208,10 @@ all:: $(TEST_PROGRAMS) $(test_bindir_programs) $(UNIT_TEST_PROGS) $(CLAR_TEST_PR
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
index 7898a1c238dde20617cf96d144930dc59f67feab..1d3a59a0081e1fc6066af187093cb1d11d01a929 100755
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
index 852b841601642402fb47489fba07445435e27930..25d8452cc29ecf2ee21172bc8a31f57801908ba7 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1085,6 +1085,9 @@ endforeach()
 
 file(STRINGS ${CMAKE_SOURCE_DIR}/bin-wrappers/wrap-for-bin.sh content NEWLINE_CONSUME)
 string(REPLACE "@BUILD_DIR@" "${CMAKE_BINARY_DIR}" content "${content}")
+string(REPLACE "@GIT_TEXTDOMAINDIR@" "${CMAKE_BINARY_DIR}/po/build/locale" content "${content}")
+string(REPLACE "@GITPERLLIB@" "${CMAKE_BINARY_DIR}/perl/build/lib" content "${content}")
+string(REPLACE "@MERGE_TOOLS_DIR@" "${CMAKE_SOURCE_DIR}/mergetools" content "${content}")
 string(REPLACE "@PROG@" "git-cvsserver" content "${content}")
 file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/git-cvsserver ${content})
 
@@ -1170,6 +1173,11 @@ string(REPLACE "@GIT_PERF_MAKE_COMMAND@" "" git_build_options "${git_build_optio
 string(REPLACE "@GIT_INTEROP_MAKE_OPTS@" "" git_build_options "${git_build_options}")
 string(REPLACE "@GIT_TEST_INDEX_VERSION@" "" git_build_options "${git_build_options}")
 string(REPLACE "@GIT_TEST_PERL_FATAL_WARNINGS@" "" git_build_options "${git_build_options}")
+string(REPLACE "@GIT_TEST_TEXTDOMAINDIR@" "'${CMAKE_BINARY_DIR}/po/build/locale'" git_build_options "${git_build_options}")
+string(REPLACE "@GIT_TEST_POPATH@" "'${CMAKE_BINARY_DIR}/po'" git_build_options "${git_build_options}")
+string(REPLACE "@GIT_TEST_TEMPLATE_DIR@" "'${CMAKE_BINARY_DIR}/templates/blt'" git_build_options "${git_build_options}")
+string(REPLACE "@GIT_TEST_GITPERLLIB@" "'${CMAKE_BINARY_DIR}/perl/build/lib'" git_build_options "${git_build_options}")
+string(REPLACE "@GIT_TEST_MERGE_TOOLS_DIR@" "'${RUNTIME_PREFIX}'" git_build_options "${git_build_options}")
 string(REPLACE "@RUNTIME_PREFIX@" "'${RUNTIME_PREFIX}'" git_build_options "${git_build_options}")
 string(REPLACE "@GITWEBDIR@" "'${GITWEBDIR}'" git_build_options "${git_build_options}")
 string(REPLACE "@USE_GETTEXT_SCHEME@" "" git_build_options "${git_build_options}")
diff --git a/t/lib-gettext.sh b/t/lib-gettext.sh
index cc6bb2cdeaae7b5bb23211c0d9c37c9deb39e14f..7a734c6973e65995d3403a26cc9e5c1a5a1ce074 100644
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
index 8b1c3bd39f2249417099ea2f24218268925909af..a9273ba58d76333c74d0072794ed0d95b966f16f 100755
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
index 19057faa73925f619750fec30f05c3e5a1ba05ac..ceb926c4258db853eeb50b2259a7f521501cf719 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1487,7 +1487,7 @@ else # normal case, use ../bin-wrappers only unless $with_dashes:
 		PATH="$GIT_BUILD_DIR:$GIT_BUILD_DIR/t/helper:$PATH"
 	fi
 fi
-GIT_TEMPLATE_DIR="$GIT_BUILD_DIR"/templates/blt
+GIT_TEMPLATE_DIR="$GIT_TEST_TEMPLATE_DIR"
 GIT_CONFIG_NOSYSTEM=1
 GIT_ATTR_NOSYSTEM=1
 GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/.."
@@ -1503,9 +1503,9 @@ then
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
2.47.0.251.gb31fb630c0.dirty

