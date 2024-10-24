Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBE41D8DFD
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 12:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729773613; cv=none; b=sUiUShmhtyB/yeZsWvxUUqGTxNi7AcWO6edeQxQ1t2gJTnnUpQRR4Ysjs/wB62XAnBw72o5FcOz8SELFj6O0kYypYWEHyRZrJJ2wv4nK4iRkgYY4Gby7BanMH99P+8sVWgCvd83/VF29QdlXAgxI7DvZCdkqlOVo8FNmKzrteEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729773613; c=relaxed/simple;
	bh=SzitgHVUDgZPvI/rLYyA4erg2FYYGfuZ21WIgxWQIzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jk4ghU8++VbdB9UoZCScj8tWrV626uMKp7pzDXQAV8eVDjart2M2FUSyIrxFyieJ65GYrme/sSv3EQoBwW8gAcHB3zgmKg4f9ZTw8llJESrLfZ0chco3LOXU4dmlr4uh3nFHT8SCDj3RG4HTwVDIYJiqYOBEgh3mhTxtVqv7wvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iGxmiiFY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Du8DZ+F+; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iGxmiiFY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Du8DZ+F+"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 6105E114011F;
	Thu, 24 Oct 2024 08:40:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 24 Oct 2024 08:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729773609; x=1729860009; bh=6r/zvlDHWW
	JuIBge+FlG53FPFui1yaJZduClKayMlek=; b=iGxmiiFYGODRrcC1QYBOjd53Xe
	0DD91+rjnsmsph80LnPH43bsb0yfGiO3BvM87BvAeAhzx/e92Wy3wKhm+6IPO6YL
	cQ7fDkADsTD05Yz8zWu/gIWH56uJL13nOlGmCBg8W2WEsJAbijoIX2IwRAFsTO8e
	5wFAj+Fg72KfCUJSD22yUfUGbB4n6qcTgSOHMZ19sdPQYgRSpxOV8YBCy9Ar+H91
	PEBfMtQRowrG+yPixxqfkszkKig1hmTTydImWeASW6dPBVTKJgDQHpTlToqCTm76
	qLy3kB1pb8H1qV8g5GRFsBjGC0V00/FMUnlIXYybwio0efis7eHqXILTFFYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729773609; x=1729860009; bh=6r/zvlDHWWJuIBge+FlG53FPFui1
	yaJZduClKayMlek=; b=Du8DZ+F+4chnvnEvpvoPzZ2YnRhZkBchkzCMxZEn6Zpi
	xcjBI+kMYVmnG/reZJCmmwPPofmDJJ7uYmI3dBXMhIvO92hx9YGVLTVCJF2uE2N/
	vTqIbysJ9NRS8RImGuLnbKX6XJrDydtDmCPvJ9lz47+mNI/0VWlDux14rPofVP0e
	QpZV8sKyB2MSaVL7Mb+CLPkKeXDhM9tt+cys1k9WQJjZYYibTL8wHsKq3ZhxEOMl
	XLYxFCjh/Z8xXjO2JJ3QWCqggdwxVpAJToCkukCjj36r0vHchOmHYBuNhffAB7p+
	YWEf3R2qTk0nFxHDBJ2IKlljggQEPxW0ViyjhXd6tA==
X-ME-Sender: <xms:KEAaZx3eS-7Pp-XVIEHm1_TsAuiRG1fabF7FaR3lGtX2sgdMdowzvg>
    <xme:KEAaZ4G8jdDfOD8ZV5DUkFV4HCIGTAyzSBC9U_pYygp-OtAP4dxMjCVeORb6JSYHH
    kUmdMh6A9Z5ZT3H4g>
X-ME-Received: <xmr:KEAaZx6BAcCFV1xn_ss3JogAOAJ6qSlOGwwtNeR_vnhOSJIRbwvz4DmxKB4zP7DqRns2VrZNpYwlAB7cHa_fgzBe95naYcqPWl6z8kw7_9KkXOYZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejtddgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplh
    hushdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
    dprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepvghstghh
    figrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:KEAaZ-1ZMGv893ba08e05PYyo4sSY0QwjJixAJG9cNno6hyEFaMSfg>
    <xmx:KEAaZ0H8IL352V9-QQMFg95ZWIW2ufcQpKNB3QZpmw_ja2pTIH8w5w>
    <xmx:KEAaZ_9pgJTQUCQ1EZXjkSW34lDj_rIrm8tRxv1xUjXNJ36B9IWdfw>
    <xmx:KEAaZxnNmeVasYQUALh0x_Gv4ZibTIsA0fqXYnJjb49wCYi6UpqR4Q>
    <xmx:KUAaZ_1oU8wqAMZUMhBJpAEvuoUyFlSnmx-bQqUoAgwyE-wdYREh3HVl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Oct 2024 08:40:07 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 85821edf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Oct 2024 12:40:09 +0000 (UTC)
Date: Thu, 24 Oct 2024 14:40:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [RFC PATCH v4 06/19] Makefile: extract script to massage Shell
 scripts
Message-ID: <2cf8cf86218e0cb1f3477897cb3d0be950d452ac.1729771605.git.ps@pks.im>
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

Same as in the preceding commits, extract a script that allows us to
unify how we massage shell scripts.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 GIT-BUILD-OPTIONS.in                |  4 ++++
 Makefile                            | 34 +++++++++--------------------
 contrib/buildsystems/CMakeLists.txt | 30 +++++++++++++++----------
 generate-script.sh                  | 34 +++++++++++++++++++++++++++++
 4 files changed, 67 insertions(+), 35 deletions(-)
 create mode 100755 generate-script.sh

diff --git a/GIT-BUILD-OPTIONS.in b/GIT-BUILD-OPTIONS.in
index 050432f9fc4..9b95a6b3eee 100644
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
index fc13d5bb01c..2afad000762 100644
--- a/Makefile
+++ b/Makefile
@@ -1555,10 +1555,10 @@ endif
 
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
@@ -2545,26 +2545,8 @@ GIT-SCRIPT-DEFINES: FORCE
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
 
 git.res: git.rc GIT-VERSION-FILE GIT-PREFIX
@@ -2633,8 +2615,8 @@ GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES Makefile
 perllibdir:
 	@echo '$(perllibdir_SQ)'
 
-git-instaweb: git-instaweb.sh GIT-SCRIPT-DEFINES
-	$(QUIET_GEN)$(cmd_munge_script) && \
+git-instaweb: git-instaweb.sh generate-script.sh GIT-BUILD-OPTIONS GIT-SCRIPT-DEFINES
+	$(QUIET_GEN)./generate-script.sh "$<" "$@+" ./GIT-BUILD-OPTIONS && \
 	chmod +x $@+ && \
 	mv $@+ $@
 else # NO_PERL
@@ -3191,6 +3173,10 @@ GIT-BUILD-OPTIONS: FORCE
 		-e "s|@GIT_TEST_INDEX_VERSION@|\'$(GIT_TEST_INDEX_VERSION)\'|" \
 		-e "s|@GIT_TEST_PERL_FATAL_WARNINGS@|\'$(GIT_TEST_PERL_FATAL_WARNINGS)\'|" \
 		-e "s|@RUNTIME_PREFIX@|\'$(RUNTIME_PREFIX)\'|" \
+		-e "s|@GITWEBDIR@|\'$(gitwebdir_SQ)\'|" \
+		-e "s|@USE_GETTEXT_SCHEME@|\'$(USE_GETTEXT_SCHEME)\'|" \
+		-e "s|@LOCALEDIR@|\'$(localedir_SQ)\'|" \
+		-e "s|@BROKEN_PATH_FIX@|\'$(BROKEN_PATH_FIX)\'|" \
 		GIT-BUILD-OPTIONS.in >$@+
 	@if grep -q '^[A-Z][A-Z_]*=@.*@$$' $@+; then echo "Unsubstituted build options in $@" >&2 && exit 1; fi
 	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index ddf39dc90e7..2e22e87d188 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -834,18 +834,22 @@ set(git_shell_scripts
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
+	add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/${shell_gen_path}
+		COMMAND ${CMAKE_SOURCE_DIR}/generate-script.sh
+			${CMAKE_SOURCE_DIR}/${script}.sh
+			${CMAKE_BINARY_DIR}/${shell_gen_path}
+			${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS
+		DEPENDS ${CMAKE_SOURCE_DIR}/generate-script.sh
+			${CMAKE_SOURCE_DIR}/${script}.sh)
+	list(APPEND shell_gen ${CMAKE_BINARY_DIR}/${shell_gen_path})
 endforeach()
+add_custom_target(shell-gen ALL DEPENDS ${shell_gen})
 
 #perl scripts
 parse_makefile_for_scripts(git_perl_scripts "SCRIPT_PERL" "")
@@ -1156,6 +1160,10 @@ string(REPLACE "@GIT_INTEROP_MAKE_OPTS@" "" git_build_options "${git_build_optio
 string(REPLACE "@GIT_TEST_INDEX_VERSION@" "" git_build_options "${git_build_options}")
 string(REPLACE "@GIT_TEST_PERL_FATAL_WARNINGS@" "" git_build_options "${git_build_options}")
 string(REPLACE "@RUNTIME_PREFIX@" "${RUNTIME_PREFIX}" git_build_options "${git_build_options}")
+string(REPLACE "@GITWEBDIR@" "${GITWEBDIR}" git_build_options "${git_build_options}")
+string(REPLACE "@USE_GETTEXT_SCHEME@" "" git_build_options "${git_build_options}")
+string(REPLACE "@LOCALEDIR@" "LOCALEDIR" git_build_options "${git_build_options}")
+string(REPLACE "@BROKEN_PATH_FIX@" "" git_build_options "${git_build_options}")
 if(USE_VCPKG)
 	string(APPEND git_build_options "PATH=\"$PATH:$TEST_DIRECTORY/../compat/vcbuild/vcpkg/installed/x64-windows/bin\"\n")
 endif()
diff --git a/generate-script.sh b/generate-script.sh
new file mode 100755
index 00000000000..d001e43d7bf
--- /dev/null
+++ b/generate-script.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+
+set -e
+
+if test $# -ne 3
+then
+	echo "USAGE: $0 <INPUT> <OUTPUT> <GIT-BUILD-OPTIONS>" >&2
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
2.47.0.118.gfd3785337b.dirty

