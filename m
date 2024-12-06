Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C7B20CCE4
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 13:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733491534; cv=none; b=nf/p23aYAeyGwRUzT6Av596oOFdVsdS6tHmdXzp29AKlwUcoVmMGMVuyzjgkjqzKpliUV+yLj4RLv4ItZLOfDeoCMCv8SZn3H/Ed5S9O87NMXtdTk45wo90RGIMi/XVHlvIi2KvhckFFgAUt016EndaFBEsO8+yvU+RnOVtMrXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733491534; c=relaxed/simple;
	bh=9l3cC3Q1ISPlxu983W7qG7xKnj2O8Jl33QyfcXcK9EI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aRRrntC2Ch6BJg+ikY+fuGWVLiykP9GYPAmS9pvpcN2g/P2R+8jSLk3N4XmFujgPv5k/1XXk3T57xvdvPQiL49cCVzpGXDUexq5GaoWAeDCmLeKBqfml3ZLa8GJxV94uCggCNPveA8EXAG3CxqNQoZf2i6/pFO5fqc8esZdvscQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=phow0fzY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ShLiC5bQ; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="phow0fzY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ShLiC5bQ"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B9E3D25401C2;
	Fri,  6 Dec 2024 08:25:30 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 06 Dec 2024 08:25:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733491530;
	 x=1733577930; bh=2At6n33ACVNvqNo/TbSipq0YDPwyyoRNUTR4zfKQO4o=; b=
	phow0fzY8I9JpTNxaoYt8guANVqULZ3Sy+tOg6alJRb/QJHkQC0SJR86fPPuHX19
	2PGD6f9tyb/NLjS+m0qJSwlUWPziCxS8ptsnRJaMOuuk3Z8kFz+RcnzWgNNq0LpO
	UNTPeSHfnS/BlY23GE9MfAcsKJfRuwUxjnxo8b7gxHG/TN6XNTbxQF6vBo/+mQ9b
	hMZA64t/YyGxyLJNE2KrLY4cjGro15CTT4CZfQjD8pDvhzRrT1JZJUlb1LntuV+L
	zEQc/DrB0nxLm7sGzmmuzOBL+j2TSvbpuAIkEMTQOK9ZcPhtOJZvoPxEWE/abeTn
	JAlCVxnB91Q47Dg3AXYw8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733491530; x=
	1733577930; bh=2At6n33ACVNvqNo/TbSipq0YDPwyyoRNUTR4zfKQO4o=; b=S
	hLiC5bQKwH97P5l0inRGGkUhJ0BQ2yUUJ+UI5nIkGvOVDtTlrAjlK3QQNTrU0TR2
	s69TIorUvbQbwvc7Y3XK8xXhF+7eNnLzlFYHryFAHQ/HqvzEjRkQFjJTdL1VPeER
	vGfVQCkSqkPRhwZKjwqtNGNNjFA/oDi4j35GknDSskdpaEY7E8czVBIePqrcCGIG
	BccyJOw+LEc1hDvpBb+RFWpXFHL79Ol6PsgkWKPR29MZMeLIO6oNMQIPplZTCmYM
	aMYdCOcVF1PTFM7B8ls4Q4S1vdq093ru0Uk+yjiX87aELSlqRILY6y+z+gpNho3z
	bIekMnLKEnuxrPL5x94pQ==
X-ME-Sender: <xms:SvtSZ3G_OgfJY3gR9pdUzD5_szBpU0SxEmy0W8M1BB159Ddz_hBLfg>
    <xme:SvtSZ0UlJZ5JAkbcCSlqmfEEjEGd8euxHYWhWc0UicpihI5CymkWef5ZnZ4_xhlrX
    ozF718vPUwQKr5Mmg>
X-ME-Received: <xmr:SvtSZ5I0Sd4irL4u_l9-xIrj2EY1Txq-BeQxGnsbLcrC75R8ZLmcdHd8BmC3umyAZPsY-MvtwRJyWXc2CJZNaTmRFDOqdQJoHEl_MGFVRxEZ7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnheptdeuvdegkeevuedtleelveelgfehgfdvheevuefhueeg
    jeefleejhfdvkeehudetnecuffhomhgrihhnpehrtgdrihhnnecuvehluhhsthgvrhfuih
    iivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhstg
    hoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtoheprhgrmhhsrgihsehrrghm
    shgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopegurghvvhhiugesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghp
    thhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehjiehtsehkuggsgh
    drohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehsuhhnsh
    hhihhnvgesshhunhhshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:SvtSZ1H64cGGJpwKtqtGuYnuWsi9xdw3ASXq8NbvtY5tTnYczR83fw>
    <xmx:SvtSZ9UeDNH_FrF1XXqbRGZ4Zky3xNEqcsQ-_PdiHQ43-wrGfO-weg>
    <xmx:SvtSZwMbH4lxk1M_aV-wBbqXApGZeMDjpMvfXKx3xAMTB1rGYaKODw>
    <xmx:SvtSZ83D5Ee3GkpKCyJewqJgC0cucRcaiUnCD07S1STGE2WD3Gfdfg>
    <xmx:SvtSZ4P0Dav6Q_TmUGujIBNCq_hOAoALFFZycM2JTnWjv_fVolTiLn6H>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 08:25:28 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3087092d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Dec 2024 13:24:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Dec 2024 14:24:45 +0100
Subject: [PATCH v11 10/26] Makefile: extract script to massage Shell
 scripts
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-pks-meson-v11-10-525ed4792b88@pks.im>
References: <20241206-pks-meson-v11-0-525ed4792b88@pks.im>
In-Reply-To: <20241206-pks-meson-v11-0-525ed4792b88@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>, 
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>, 
 Johannes Sixt <j6t@kdbg.org>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Same as in the preceding commits, extract a script that allows us to
unify how we massage shell scripts.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 GIT-BUILD-OPTIONS.in                |  4 ++++
 Makefile                            | 34 ++++++++++------------------------
 contrib/buildsystems/CMakeLists.txt | 31 ++++++++++++++++++++-----------
 generate-script.sh                  | 34 ++++++++++++++++++++++++++++++++++
 4 files changed, 68 insertions(+), 35 deletions(-)

diff --git a/GIT-BUILD-OPTIONS.in b/GIT-BUILD-OPTIONS.in
index 050432f9fc49f93d0f6ed98c1307405c52761be0..9b95a6b3eee334b6f691702696ca9d92201b6bac 100644
--- a/GIT-BUILD-OPTIONS.in
+++ b/GIT-BUILD-OPTIONS.in
@@ -36,3 +36,7 @@ GIT_INTEROP_MAKE_OPTS=@GIT_INTEROP_MAKE_OPTS@
 GIT_TEST_INDEX_VERSION=@GIT_TEST_INDEX_VERSION@
 GIT_TEST_PERL_FATAL_WARNINGS=@GIT_TEST_PERL_FATAL_WARNINGS@
 RUNTIME_PREFIX=@RUNTIME_PREFIX@
+GITWEBDIR=@GITWEBDIR@
+USE_GETTEXT_SCHEME=@USE_GETTEXT_SCHEME@
+LOCALEDIR=@LOCALEDIR@
+BROKEN_PATH_FIX=@BROKEN_PATH_FIX@
diff --git a/Makefile b/Makefile
index b6221a027aa0a093b75c278a68771d97eb387751..2ad644e85649f7bdea391ead6356ecee1e9e737a 100644
--- a/Makefile
+++ b/Makefile
@@ -1558,10 +1558,10 @@ endif
 
 ifdef SANE_TOOL_PATH
 SANE_TOOL_PATH_SQ = $(subst ','\'',$(SANE_TOOL_PATH))
-BROKEN_PATH_FIX = 's|^\# @BROKEN_PATH_FIX@$$|git_broken_path_fix "$(SANE_TOOL_PATH_SQ)"|'
+BROKEN_PATH_FIX = s|^\# @BROKEN_PATH_FIX@$$|git_broken_path_fix "$(SANE_TOOL_PATH_SQ)"|
 PATH := $(SANE_TOOL_PATH):${PATH}
 else
-BROKEN_PATH_FIX = '/^\# @BROKEN_PATH_FIX@$$/d'
+BROKEN_PATH_FIX = /^\# @BROKEN_PATH_FIX@$$/d
 endif
 
 ifeq (,$(HOST_CPU))
@@ -2546,26 +2546,8 @@ GIT-SCRIPT-DEFINES: FORCE
 		echo "$$FLAGS" >$@; \
             fi
 
-define cmd_munge_script
-sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
-    -e 's|@SHELL_PATH@|$(SHELL_PATH_SQ)|' \
-    -e 's|@DIFF@|$(DIFF_SQ)|' \
-    -e 's|@LOCALEDIR@|$(localedir_SQ)|g' \
-    -e 's/@USE_GETTEXT_SCHEME@/$(USE_GETTEXT_SCHEME)/g' \
-    -e $(BROKEN_PATH_FIX) \
-    -e 's|@GITWEBDIR@|$(gitwebdir_SQ)|g' \
-    -e 's|@PERL_PATH@|$(PERL_PATH_SQ)|g' \
-    -e 's|@PAGER_ENV@|$(PAGER_ENV_SQ)|g' \
-    $@.sh >$@+
-endef
-
-$(SCRIPT_SH_GEN) : % : %.sh GIT-SCRIPT-DEFINES
-	$(QUIET_GEN)$(cmd_munge_script) && \
-	chmod +x $@+ && \
-	mv $@+ $@
-
-$(SCRIPT_LIB) : % : %.sh GIT-SCRIPT-DEFINES
-	$(QUIET_GEN)$(cmd_munge_script) && \
+$(SCRIPT_SH_GEN) $(SCRIPT_LIB) : % : %.sh generate-script.sh GIT-BUILD-OPTIONS GIT-SCRIPT-DEFINES
+	$(QUIET_GEN)./generate-script.sh "$<" "$@+" ./GIT-BUILD-OPTIONS && \
 	mv $@+ $@
 
 git.rc: git.rc.in GIT-VERSION-GEN GIT-VERSION-FILE
@@ -2635,8 +2617,8 @@ GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES Makefile
 perllibdir:
 	@echo '$(perllibdir_SQ)'
 
-git-instaweb: git-instaweb.sh GIT-SCRIPT-DEFINES
-	$(QUIET_GEN)$(cmd_munge_script) && \
+git-instaweb: git-instaweb.sh generate-script.sh GIT-BUILD-OPTIONS GIT-SCRIPT-DEFINES
+	$(QUIET_GEN)./generate-script.sh "$<" "$@+" ./GIT-BUILD-OPTIONS && \
 	chmod +x $@+ && \
 	mv $@+ $@
 else # NO_PERL
@@ -3200,6 +3182,10 @@ GIT-BUILD-OPTIONS: FORCE
 		-e "s|@GIT_TEST_INDEX_VERSION@|\'$(GIT_TEST_INDEX_VERSION)\'|" \
 		-e "s|@GIT_TEST_PERL_FATAL_WARNINGS@|\'$(GIT_TEST_PERL_FATAL_WARNINGS)\'|" \
 		-e "s|@RUNTIME_PREFIX@|\'$(RUNTIME_PREFIX_OPTION)\'|" \
+		-e "s|@GITWEBDIR@|\'$(gitwebdir_SQ)\'|" \
+		-e "s|@USE_GETTEXT_SCHEME@|\'$(USE_GETTEXT_SCHEME)\'|" \
+		-e "s|@LOCALEDIR@|\'$(localedir_SQ)\'|" \
+		-e "s!@BROKEN_PATH_FIX@!\'$(BROKEN_PATH_FIX)\'!" \
 		GIT-BUILD-OPTIONS.in >$@+
 	@if grep -q '^[A-Z][A-Z_]*=@.*@$$' $@+; then echo "Unsubstituted build options in $@" >&2 && exit 1; fi
 	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 52b479e2e5342c3a08c83ecf77a83504778f16a0..defdd958bb64906489482b77752b1a137282824f 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -838,18 +838,23 @@ set(git_shell_scripts
 	${git_sh_scripts} ${git_shlib_scripts} git-instaweb)
 
 foreach(script ${git_shell_scripts})
-	file(STRINGS ${CMAKE_SOURCE_DIR}/${script}.sh content NEWLINE_CONSUME)
-	string(REPLACE "@SHELL_PATH@" "${SHELL_PATH}" content "${content}")
-	string(REPLACE "@DIFF@" "diff" content "${content}")
-	string(REPLACE "@LOCALEDIR@" "${LOCALEDIR}" content "${content}")
-	string(REPLACE "@GITWEBDIR@" "${GITWEBDIR}" content "${content}")
-	string(REPLACE "@NO_CURL@" "" content "${content}")
-	string(REPLACE "@USE_GETTEXT_SCHEME@" "" content "${content}")
-	string(REPLACE "# @BROKEN_PATH_FIX@" "" content "${content}")
-	string(REPLACE "@PERL_PATH@" "${PERL_PATH}" content "${content}")
-	string(REPLACE "@PAGER_ENV@" "LESS=FRX LV=-c" content "${content}")
-	file(WRITE ${CMAKE_BINARY_DIR}/${script} ${content})
+	if ("${script}" IN_LIST git_sh_scripts)
+		string(REPLACE ".sh" "" shell_gen_path "${script}")
+	else()
+		set(shell_gen_path "${script}")
+	endif()
+
+	add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/${shell_gen_path}"
+		COMMAND "${SH_EXE}" "${CMAKE_SOURCE_DIR}/generate-script.sh"
+			"${CMAKE_SOURCE_DIR}/${script}.sh"
+			"${CMAKE_BINARY_DIR}/${shell_gen_path}"
+			"${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS"
+		DEPENDS "${CMAKE_SOURCE_DIR}/generate-script.sh"
+			"${CMAKE_SOURCE_DIR}/${script}.sh"
+		VERBATIM)
+	list(APPEND shell_gen ${CMAKE_BINARY_DIR}/${shell_gen_path})
 endforeach()
+add_custom_target(shell-gen ALL DEPENDS ${shell_gen})
 
 #perl scripts
 parse_makefile_for_scripts(git_perl_scripts "SCRIPT_PERL" "")
@@ -1183,6 +1188,10 @@ string(REPLACE "@GIT_INTEROP_MAKE_OPTS@" "" git_build_options "${git_build_optio
 string(REPLACE "@GIT_TEST_INDEX_VERSION@" "" git_build_options "${git_build_options}")
 string(REPLACE "@GIT_TEST_PERL_FATAL_WARNINGS@" "" git_build_options "${git_build_options}")
 string(REPLACE "@RUNTIME_PREFIX@" "'${RUNTIME_PREFIX}'" git_build_options "${git_build_options}")
+string(REPLACE "@GITWEBDIR@" "'${GITWEBDIR}'" git_build_options "${git_build_options}")
+string(REPLACE "@USE_GETTEXT_SCHEME@" "" git_build_options "${git_build_options}")
+string(REPLACE "@LOCALEDIR@" "'${LOCALEDIR}'" git_build_options "${git_build_options}")
+string(REPLACE "@BROKEN_PATH_FIX@" "" git_build_options "${git_build_options}")
 if(USE_VCPKG)
 	string(APPEND git_build_options "PATH=\"$PATH:$TEST_DIRECTORY/../compat/vcbuild/vcpkg/installed/x64-windows/bin\"\n")
 endif()
diff --git a/generate-script.sh b/generate-script.sh
new file mode 100755
index 0000000000000000000000000000000000000000..a149e4f0ba348e62b963a2a95e1b250e8732fc20
--- /dev/null
+++ b/generate-script.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+
+set -e
+
+if test $# -ne 3
+then
+	echo >&2 "USAGE: $0 <INPUT> <OUTPUT> <GIT-BUILD-OPTIONS>"
+	exit 1
+fi
+
+INPUT="$1"
+OUTPUT="$2"
+BUILD_OPTIONS="$3"
+
+. "$BUILD_OPTIONS"
+
+sed -e "1s|#!.*/sh|#!$SHELL_PATH|" \
+    -e "s|@SHELL_PATH@|$SHELL_PATH|" \
+    -e "s|@DIFF@|$DIFF|" \
+    -e "s|@LOCALEDIR@|$LOCALEDIR|g" \
+    -e "s/@USE_GETTEXT_SCHEME@/$USE_GETTEXT_SCHEME/g" \
+    -e "$BROKEN_PATH_FIX" \
+    -e "s|@GITWEBDIR@|$GITWEBDIR|g" \
+    -e "s|@PERL_PATH@|$PERL_PATH|g" \
+    -e "s|@PAGER_ENV@|$PAGER_ENV|g" \
+    "$INPUT" >"$OUTPUT"
+
+case "$(basename "$INPUT")" in
+git-mergetool--lib.sh|git-sh-i18n.sh|git-sh-setup.sh)
+	;;
+*)
+	chmod a+x "$OUTPUT"
+	;;
+esac

-- 
2.47.0.366.g5daf58cba8.dirty

