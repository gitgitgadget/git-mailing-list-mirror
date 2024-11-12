Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB364218936
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 17:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731431026; cv=none; b=pjikX4iMv+vgMU+TFxje/ctgHxoEj3lR+qqRylKmM7DwZueT03Deta6SjadFK3Kyu2pHertgyq/Kibp3ZVJ75arUwSKXvdzpI9jA2+FDwGGC5oMPcUBO8gZSmIDfUOyZ4Cnol5FcUOF7l/4/BMPcnNlcTMIjZ/oylNGu1Nwp+CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731431026; c=relaxed/simple;
	bh=+GMsVgvZOCPIPFkLFCiysttI2GEDBXQL/GkGdGhIzEg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kTT41CJJfd2pkDUdcqShl/u4A3bGHicL0UMJS1jM3s2Tbefaf3vq42vge0moN5OvR06cGYS5Ht6cKPeq2c9B9r8nrwouG89gM6EKdTGQmQ8wykY9GT32xwc/WSempz1zTXBrhv/Ft7R5GaO/LE/4DDZTYtIAfuacD9bafWUR/zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aw0D159Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nCnGlIhc; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aw0D159Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nCnGlIhc"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id C171E1140146;
	Tue, 12 Nov 2024 12:03:42 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 12 Nov 2024 12:03:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731431022;
	 x=1731517422; bh=mPEny+BnWk7SnkJncakMGi2GFDr8oSiISGbqqz7T7vU=; b=
	aw0D159Zq3sDuQXkqf2cWL+xblTpiID0bSVtqWI9cpXhvlDJyc6TqnkafKqzQRdS
	44wQuvReIhZbDhnXN4tHVcAH0mUQFEOCZ8fvfE2JlDAlcJEKHEif0d0RTVbFpbA0
	ouOnfQfOe6LPcYaeY9wCLLE3IDX8dNfZKP3vtDJy88AX+LJo/P3HczDwiWd+16aw
	jGPH1ENqInkxB76L2JflWYw1gLa04agiuIUOkxMrmgwAvhOmQDwbJrYOVpkbAPfb
	KmdFES6nqBqWJR6GDPCkAcLLDUDRSwl15Pn1ylLe8nwBRcBCN0opdseYIPtzCPke
	u7cSR9qnKueoIYD9DZ2H2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731431022; x=
	1731517422; bh=mPEny+BnWk7SnkJncakMGi2GFDr8oSiISGbqqz7T7vU=; b=n
	CnGlIhcu43rW2vAi58vB5fmG0MyWKawjazBrof3QBa0jAJTqf/oj/jzhk18Ubk0x
	fkMHlKa4d14gDuHXij+YwxcnKGbw8Xfvp1Upd3vWdRwje71ZRrlRR4ttCxhfWVMW
	1j+6u26lNMwg9JgxJvyRFV+KXrHDXjMGUPE1MdB8y8qApt14EQLKjh3pXCBh5K8r
	hR0+L0Rud12R8Tb1E4sx4GBidlUWzU3pHePr2IVLE28EYo6i+m4Oovyv9HgzrstS
	xUywgPh0FDAp54VMrZZnNaEaw+RUXyVoDiFL4yz1inW5g6YwCLzvA10iwTkQfUei
	4kGN0A/HBek6zRSVEyo0Q==
X-ME-Sender: <xms:boozZzulUGjj_5OAaA9yG7JHuhzTbBVJ-sq38XqiPpaY56fTt0jsOQ>
    <xme:boozZ0d4I6MDz8LQKwtC9oKzZ2UZVG-qSQmVS8cIEp0zeFbUCR9vM7G8AJ4l8gGRv
    7ch38WAV7d-A4tuUg>
X-ME-Received: <xmr:boozZ2xY_r5qf5OqDcGoxYnydrYDD94fKeeT1VBw63CZTmlAF6PnVu0OgEl2jYpUqCFuc_rsOoRoTb8WMSXmdj7MHA0wgcUhQ6KMkhX_HOCo2dQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdr
    fihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgessh
    hunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepuggrvhhvihgusehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghstghhfigrrhhtiiesghgv
    nhhtohhordhorhhgpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrd
    hplhhushdrtghomh
X-ME-Proxy: <xmx:boozZyMaMEaUfnp0scGPXM-0AcQ734VXuIUixk_UOZ25YS21G7w0Nw>
    <xmx:boozZz9XfsjiopyyiEoJ2e6EosEYKZRTUqUdhdHeTG6XC9pGCeGJYw>
    <xmx:boozZyVcKHHYBZe3fxLF-GXsT9bKMQaHM22e-JhEGAexHFCWp_eNwg>
    <xmx:boozZ0cLsuue8Xe9l01G2BIQRuJcK4Yq-BzghgXf1VgCAsVhfVN4sQ>
    <xmx:boozZ6YJXEepb0qPGlji0iYO7O3aDECHUSZkavRPXXlY7NxjJygHYmpD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 12:03:40 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 58e07193 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 12 Nov 2024 17:03:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 12 Nov 2024 18:02:58 +0100
Subject: [PATCH RFC v6 15/19] t: better support for out-of-tree builds
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-pks-meson-v6-15-648b30996827@pks.im>
References: <20241112-pks-meson-v6-0-648b30996827@pks.im>
In-Reply-To: <20241112-pks-meson-v6-0-648b30996827@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>, 
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>
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
index f6f4381c8e6246e8dbab0ca0193320146edc9dca..41221f330b3e46fb13fb3165700fa0242e842324 100644
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
index f63661c6b5d9f51778a0e08fab7032bea5010e6f..665f3638e9b200c7a5c2931cc93e1ee4e49db2f3 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1066,6 +1066,9 @@ endforeach()
 
 file(STRINGS ${CMAKE_SOURCE_DIR}/bin-wrappers/wrap-for-bin.sh content NEWLINE_CONSUME)
 string(REPLACE "@BUILD_DIR@" "${CMAKE_BINARY_DIR}" content "${content}")
+string(REPLACE "@GIT_TEXTDOMAINDIR@" "${CMAKE_BINARY_DIR}/po/build/locale" content "${content}")
+string(REPLACE "@GITPERLLIB@" "${CMAKE_BINARY_DIR}/perl/build/lib" content "${content}")
+string(REPLACE "@MERGE_TOOLS_DIR@" "${CMAKE_SOURCE_DIR}/mergetools" content "${content}")
 string(REPLACE "@PROG@" "git-cvsserver" content "${content}")
 file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/git-cvsserver ${content})
 
@@ -1151,6 +1154,11 @@ string(REPLACE "@GIT_PERF_MAKE_COMMAND@" "" git_build_options "${git_build_optio
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
index 4dd641baefee532e2c0fa80bc78c7b7c6ab768a1..677424ced06a0351133d6e44d1b7ca1e77623a59 100644
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
2.47.0.251.gb31fb630c0.dirty

