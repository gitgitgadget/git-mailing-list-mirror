Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88C7195FE8
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 09:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528645; cv=none; b=eLY3J9Ul1KaAykEe4+/JbSpX6Za9Ri7Gvm10l72+wEmyMcvwefU720kQynCWt0ZpfDGMrE9IJMkP4juMou2GN7TxMpbA3rbl7HDRUOvfdMNk6jAGgFe0wXGAqwwHJREZEEMEgsROQtoVAg/NwQXkeUIH4KOWIP+vTTocjtKNxHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528645; c=relaxed/simple;
	bh=cRX8XL0RF0MA09lSsNwfJ3BQHkwKLCw0OxgVffYc0vs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NBYFKc4/URBnUOEDWJpnPqjMgwx6CL0WQmEuoDE0Ts9aFECa3pBlWnLxUhqFk8RnU7BpIe5LjAH0h+FlYfrm5c5ejuENuhB7+/xU4fYcwcmgw4QNFwZZYDSyudjocxaEVixdye3b1izKhkrp2CTn4d0MwgTSQyfCoogyr+DG6Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=I1bN6Hzt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jRcPXaLQ; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I1bN6Hzt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jRcPXaLQ"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C52D4254007C;
	Mon, 25 Nov 2024 04:57:22 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 25 Nov 2024 04:57:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732528642;
	 x=1732615042; bh=9qL1VQRdwgbrXUuYEQ7kNOV/ceBgCcjCaudWUnhkgPs=; b=
	I1bN6HztaC8UamzDzASdFh5yQGhJw0xyGTqZ1sj2c58dD4iOjNqJI/QxdcLG4Kmd
	6/jo2s965Ab3BLK7Kw00rq10Cz1yeAe/NSfdAkW9KHAduwSC/epybf+XttuRTowJ
	Ml4s8RLwTQCdt3RkmX3NJO1V56E+2oUjzXMC9p2TWadDvzBPkCIm5VuGm+VP0nhR
	8S3yg6SzLDVOOsNPtNdxdQcODTTtOFrnybzs21W5v+BsfjiJQm9cUarImldaQoyv
	DnO5GQqQ56lGzawa8TMYKyXatB1Vo0l2FUYe/r3P0DJtASMkWW8kuMYdR2JXW8VH
	4zhWO7SYQR5ZJsVKW2AWIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732528642; x=
	1732615042; bh=9qL1VQRdwgbrXUuYEQ7kNOV/ceBgCcjCaudWUnhkgPs=; b=j
	RcPXaLQJ2QVwKtozlkw0jpfV0+V/SAlAE3JnnczdO60D1QoNxu1SkByrUY6Lti/y
	m6y7NtD5RADAzcl+zkJEP/Ubj5UzkOjCk75OA3B0M6f/C/ytvoB0sEYvThEUP8zb
	hp9kOp+XAME/VrKn+pl7EusOq/YiiRBYfqwbDyX27ruoJKwUKA23MUZDlWfbhXsR
	4FdBOneC3Gto47BSOviaGUmhfgp3s02n6wGrRv50bZo0MJFd7oDTdYOSdmO/S5r/
	UeJSkyF6j/fAoDi9RqnJDRo3fZmYtr4bapBxilq/XN52Y6Rg7Ljsg8n4p+acJ4mW
	aUN7lNv1yer/nxiviAq4A==
X-ME-Sender: <xms:AkpEZ0EZY4zw8uXl5qJCytIYiAaDPoWHxILRAv8fpeb-B4ecF4xljA>
    <xme:AkpEZ9VCxLzhbf_0ob-a7lCFvlCkRQWjbNNUlP8m4bibHEmZn2-XuG-GYYxe_HjNM
    rKYiyJbJ12DafaGcA>
X-ME-Received: <xmr:AkpEZ-IqWP19ebkHlSrKJT-V3DXIqP5Gzpb7pbGXNORRWTxPgB83mafnEzB1gvP9XRdth644lOw-BywbI0F7PZS0QkB37W7-4HaOV0gF4p90ew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeehgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnheptdeuvdegkeevuedtleelveelgfehgfdvheevuefhueeg
    jeefleejhfdvkeehudetnecuffhomhgrihhnpehrtgdrihhnnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsuhhnshhhih
    hnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtth
    hopegurghvvhhiugesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtph
    htthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthht
    oheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtth
    hopegvshgthhifrghrthiisehgvghnthhoohdrohhrgh
X-ME-Proxy: <xmx:AkpEZ2G6TN6mzrcgYISfOM-2xIOfHIf3X54xnsZtKmayruMcIcTcSw>
    <xmx:AkpEZ6VFzsEJ_Khx1MbxCpgXBHeNu0yvfF2FqG1fU9Qn4LpiNKPTRw>
    <xmx:AkpEZ5OBaKK3Vi0ymFPeNeIbC8jTJf7cFpZEZOe0VYL_7IIL2qrzOQ>
    <xmx:AkpEZx3PCmtNem3gObNT_5dKyl6IPm9oYGWI44ltUkceixMIePpgfw>
    <xmx:AkpEZxMfviJli6ghavHo_oZSWLVOgULjSVSkRE37phUalCvzg9zMMyGm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 04:57:20 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 01562014 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 09:56:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 25 Nov 2024 10:56:58 +0100
Subject: [PATCH v9 10/23] Makefile: extract script to massage Shell scripts
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-pks-meson-v9-10-1c6cf242a5f1@pks.im>
References: <20241125-pks-meson-v9-0-1c6cf242a5f1@pks.im>
In-Reply-To: <20241125-pks-meson-v9-0-1c6cf242a5f1@pks.im>
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
index b8f96581097d7a29a745afd81de2f58b703da7da..c898720861b6aad04610b43b33244234dafaee4d 100644
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
@@ -3199,6 +3181,10 @@ GIT-BUILD-OPTIONS: FORCE
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
2.47.0.274.g962d0b743d.dirty

