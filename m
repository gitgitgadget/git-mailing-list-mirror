Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB24A3D8138
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 17:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773165191; cv=none; b=WqduV1iQVVUZwsxT/fSKjBfpK2CGdl7aiKIa09ArE4HGenraVWop8+fLVN5eZqYBcr/UuSykCb09OKZ+9xWr3VNSAVc7jQ69fcZqxwSMW8/8DdJSz2NouEGn85cLecTQhKowOy+cBMdaF/wX0LlwE4FoEpKpv2YzdEKKgP4DkMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773165191; c=relaxed/simple;
	bh=jhAg8uxWN5I/tzSpzNdUl4v27RHRjt0xBdYnDhxzrqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RjlSe1UKgcADgSPhKVq0DMHmfUyd2etmiaTG6z33ZF2dZSzJwYW/GA+Mn9tDeENQ86NOYH0k67yR/nW1PfPxRNCBkzVUdxXUItdo3FnEacEt3dRPaPffqkFeB/IgQ1xr6NB7GaTgYugXWvLu/CJuZtJ+CbszRU8MQHjkzlxwsJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=U+idJhQd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=6HREzpPF; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U+idJhQd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="6HREzpPF"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CE5DC140016A
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 13:53:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 10 Mar 2026 13:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773165186;
	 x=1773251586; bh=Ov5rGAEL0TmCagtbuI8jpqxsyp5hHAXImzIohqhFffo=; b=
	U+idJhQdoyKgV8LVvrbG08De3Nagjd8vMkqoicq1wWGYkzkWWwxM69miRK4fGZHp
	o2LlsZccZmejyG0ydEhs/UrKqeycrbZeK9hKpk9x8hWHleaLumAoUbg5ldrdn18t
	+npA9uRbC5rIWddip4h8ErPbBLG+a3UrcwnCRMmIUz4kQ6uNwpg3Vf5Z9fzG7H19
	AZbJ+O6PsbRPgCsq3MDcJqa90smuJX85iroQbDJXklZmv1VaMEJlQUUTv+gH2hsM
	W3tWmhN5W2cLktkpTrM0KAmAkDv1D0YKQqNRaihMVXnvxis5yjO5wnf8q5KUxRoz
	lQ9kuPfa47fW/X9Zcm0www==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773165186; x=
	1773251586; bh=Ov5rGAEL0TmCagtbuI8jpqxsyp5hHAXImzIohqhFffo=; b=6
	HREzpPFmNArrsL4jS+PSwvWyEGUQcEs1hfaBudFsOo+wFuCBlrQjniKY6r/0u6Ve
	8UAJw/95cjk+YyrhWrpAuWlnV0U8Ze5W5HO4fSjMpMWlmKLgxsFcVVedMe4p3zIQ
	EWdyHnoR3BXuHdCldwVUE/6u+LAovP71dZ1CGcTkKOlkpenc90f3xQ3G9c5wZYDW
	vE9fyY55ZYzoIWRCI2CkcuKnU25kgJIW3Cs5qncGQiJnDKsZ4t06Wv4aWih6IIN7
	C21L/aj+ATRJoPdbF4vu0SlBveYhB0DUuyRhnnno69YwYMXuV6rvrOBmChqA9g8S
	R2bslukZNGqS/SN+/RSdQ==
X-ME-Sender: <xms:glqwaQh2aFzm1kJnXfRKuG0Wiftds33TXUqHStmqsjrqHlkY8NLlCA>
    <xme:glqwaf-FhZiT-yHYw_AcXeAqLxPDW_n30-q9uT1UxuEYZR_JwNDk67m_op0ETM2j0
    get6jb8BH_c-TyjLn2aIjVBGS-BfxrFX6ex5wYO75TmC1secDVo18s>
X-ME-Received: <xmr:glqwaduScwwMvhIm56fKHWFVTED0BEs7T71uvQjkSMfGWNMi_2ZDXSnYe4PV7OVasam5y5vcoy0QUv8wQOgflEF8vuNJNB3SDDZmel9z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepuefhheejvdeiveekleelieduudefgfduge
    euheetffekhfelveduvedvfffgteegnecuffhomhgrihhnpehmrghkrdguvghvpdhrtgdr
    ihhnpdhshhdrthhoohhlshdptghhvggtkhdqsghuihhlthhinhhsrdhshhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:glqwaWbKf9dNNd0nAIV3m54sQVAoWZ0UEaZdOnltKemGJbvrvW2bnA>
    <xmx:glqwadrGbTzsEk06xwx192STIggoUiH58PT2j4j6iWYpohZ7Demxtg>
    <xmx:glqwab9zCHoZ7EM6elbhJWS9U4jB43xXvlmDzoPHQvuicnCDfbYpTg>
    <xmx:glqwac_rqfKLzGzwLEMuvrrN7eSJyK_PwZtWvEjMue6PR66bnFTMnw>
    <xmx:glqwaVh_Mw9AJNmqg-jwqB4FMUmuIrXHuPHDyDMZWPFdiEM6xIX9q644>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 10 Mar 2026 13:53:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 918b38d5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 10 Mar 2026 17:53:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 10 Mar 2026 18:52:38 +0100
Subject: [PATCH 5/8] builds: move build scripts into "tools/"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-pks-build-infra-improvements-v1-5-ec75d0710d6a@pks.im>
References: <20260310-b4-pks-build-infra-improvements-v1-0-ec75d0710d6a@pks.im>
In-Reply-To: <20260310-b4-pks-build-infra-improvements-v1-0-ec75d0710d6a@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

We have a bunch of scripts used by our different build systems that are
all located in the top-level directory. Now that we have introduced the
new "tools/" directory though we have a better home for them.

Move the scripts into the "tools/" directory.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                                           | 34 +++++++++++-----------
 config.mak.dev                                     |  2 +-
 contrib/buildsystems/CMakeLists.txt                | 18 ++++++------
 contrib/subtree/meson.build                        |  2 +-
 meson.build                                        | 14 ++++-----
 check-builtins.sh => tools/check-builtins.sh       |  0
 detect-compiler => tools/detect-compiler           |  0
 generate-cmdlist.sh => tools/generate-cmdlist.sh   |  0
 .../generate-configlist.sh                         |  0
 generate-hooklist.sh => tools/generate-hooklist.sh |  0
 generate-perl.sh => tools/generate-perl.sh         |  0
 generate-python.sh => tools/generate-python.sh     |  0
 generate-script.sh => tools/generate-script.sh     |  0
 13 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/Makefile b/Makefile
index 8564b1be36..322f5940e3 100644
--- a/Makefile
+++ b/Makefile
@@ -2689,21 +2689,21 @@ $(BUILT_INS): git$X
 	ln -s $< $@ 2>/dev/null || \
 	cp $< $@
 
-config-list.h: generate-configlist.sh
+config-list.h: tools/generate-configlist.sh
 	@mkdir -p .depend
-	$(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh . $@ .depend/config-list.h.d
+	$(QUIET_GEN)$(SHELL_PATH) ./tools/generate-configlist.sh . $@ .depend/config-list.h.d
 
 -include .depend/config-list.h.d
 
-command-list.h: generate-cmdlist.sh command-list.txt
+command-list.h: tools/generate-cmdlist.sh command-list.txt
 
 command-list.h: $(wildcard Documentation/git*.adoc)
-	$(QUIET_GEN)$(SHELL_PATH) ./generate-cmdlist.sh \
+	$(QUIET_GEN)$(SHELL_PATH) ./tools/generate-cmdlist.sh \
 		$(patsubst %,--exclude-program %,$(EXCLUDED_PROGRAMS)) \
 		. $@
 
-hook-list.h: generate-hooklist.sh Documentation/githooks.adoc
-	$(QUIET_GEN)$(SHELL_PATH) ./generate-hooklist.sh . $@
+hook-list.h: tools/generate-hooklist.sh Documentation/githooks.adoc
+	$(QUIET_GEN)$(SHELL_PATH) ./tools/generate-hooklist.sh . $@
 
 SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):\
 	$(localedir_SQ):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ):\
@@ -2716,8 +2716,8 @@ GIT-SCRIPT-DEFINES: FORCE
 		echo "$$FLAGS" >$@; \
             fi
 
-$(SCRIPT_SH_GEN) $(SCRIPT_LIB) : % : %.sh generate-script.sh GIT-BUILD-OPTIONS GIT-SCRIPT-DEFINES
-	$(QUIET_GEN)./generate-script.sh "$<" "$@+" ./GIT-BUILD-OPTIONS && \
+$(SCRIPT_SH_GEN) $(SCRIPT_LIB) : % : %.sh tools/generate-script.sh GIT-BUILD-OPTIONS GIT-SCRIPT-DEFINES
+	$(QUIET_GEN)./tools/generate-script.sh "$<" "$@+" ./GIT-BUILD-OPTIONS && \
 	mv $@+ $@
 
 git.rc: git.rc.in GIT-VERSION-GEN GIT-VERSION-FILE
@@ -2757,8 +2757,8 @@ endif
 
 PERL_DEFINES += $(gitexecdir) $(perllibdir) $(localedir)
 
-$(SCRIPT_PERL_GEN): % : %.perl generate-perl.sh GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
-	$(QUIET_GEN)$(SHELL_PATH) generate-perl.sh ./GIT-BUILD-OPTIONS ./GIT-VERSION-FILE GIT-PERL-HEADER "$<" "$@+" && \
+$(SCRIPT_PERL_GEN): % : %.perl tools/generate-perl.sh GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
+	$(QUIET_GEN)$(SHELL_PATH) tools/generate-perl.sh ./GIT-BUILD-OPTIONS ./GIT-VERSION-FILE GIT-PERL-HEADER "$<" "$@+" && \
 	mv $@+ $@
 
 PERL_DEFINES := $(subst $(space),:,$(PERL_DEFINES))
@@ -2786,8 +2786,8 @@ GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES Makefile
 perllibdir:
 	@echo '$(perllibdir_SQ)'
 
-git-instaweb: git-instaweb.sh generate-script.sh GIT-BUILD-OPTIONS GIT-SCRIPT-DEFINES
-	$(QUIET_GEN)./generate-script.sh "$<" "$@+" ./GIT-BUILD-OPTIONS && \
+git-instaweb: git-instaweb.sh tools/generate-script.sh GIT-BUILD-OPTIONS GIT-SCRIPT-DEFINES
+	$(QUIET_GEN)./tools/generate-script.sh "$<" "$@+" ./GIT-BUILD-OPTIONS && \
 	chmod +x $@+ && \
 	mv $@+ $@
 else # NO_PERL
@@ -2804,9 +2804,9 @@ endif # NO_PERL
 $(SCRIPT_PYTHON_GEN): GIT-BUILD-OPTIONS
 
 ifndef NO_PYTHON
-$(SCRIPT_PYTHON_GEN): generate-python.sh
+$(SCRIPT_PYTHON_GEN): tools/generate-python.sh
 $(SCRIPT_PYTHON_GEN): % : %.py
-	$(QUIET_GEN)$(SHELL_PATH) generate-python.sh ./GIT-BUILD-OPTIONS "$<" "$@"
+	$(QUIET_GEN)$(SHELL_PATH) tools/generate-python.sh ./GIT-BUILD-OPTIONS "$<" "$@"
 else # NO_PYTHON
 $(SCRIPT_PYTHON_GEN): % : unimplemented.sh
 	$(QUIET_GEN) \
@@ -3226,9 +3226,9 @@ endif
 NO_PERL_CPAN_FALLBACKS_SQ = $(subst ','\'',$(NO_PERL_CPAN_FALLBACKS))
 endif
 
-perl/build/lib/%.pm: perl/%.pm generate-perl.sh GIT-BUILD-OPTIONS GIT-VERSION-FILE GIT-PERL-DEFINES
+perl/build/lib/%.pm: perl/%.pm tools/generate-perl.sh GIT-BUILD-OPTIONS GIT-VERSION-FILE GIT-PERL-DEFINES
 	$(call mkdir_p_parent_template)
-	$(QUIET_GEN)$(SHELL_PATH) generate-perl.sh ./GIT-BUILD-OPTIONS ./GIT-VERSION-FILE GIT-PERL-HEADER "$<" "$@"
+	$(QUIET_GEN)$(SHELL_PATH) tools/generate-perl.sh ./GIT-BUILD-OPTIONS ./GIT-VERSION-FILE GIT-PERL-HEADER "$<" "$@"
 
 perl/build/man/man3/Git.3pm: perl/Git.pm
 	$(call mkdir_p_parent_template)
@@ -3936,7 +3936,7 @@ check-docs::
 ### Make sure built-ins do not have dups and listed in git.c
 #
 check-builtins::
-	./check-builtins.sh
+	./tools/check-builtins.sh
 
 ### Test suite coverage testing
 #
diff --git a/config.mak.dev b/config.mak.dev
index e86b6e1b34..c8dcf78779 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -1,5 +1,5 @@
 ifndef COMPILER_FEATURES
-COMPILER_FEATURES := $(shell ./detect-compiler $(CC))
+COMPILER_FEATURES := $(shell ./tools/detect-compiler $(CC))
 endif
 
 ifeq ($(filter no-error,$(DEVOPTS)),)
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index c6cfb874ef..81b4306e72 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -636,7 +636,7 @@ set(EXCLUSION_PROGS_CACHE ${EXCLUSION_PROGS} CACHE STRING "Programs not built" F
 if(NOT EXISTS ${CMAKE_BINARY_DIR}/command-list.h OR NOT EXCLUSION_PROGS_CACHE STREQUAL EXCLUSION_PROGS)
 	list(REMOVE_ITEM EXCLUSION_PROGS empty)
 	message("Generating command-list.h")
-	execute_process(COMMAND "${SH_EXE}" "${CMAKE_SOURCE_DIR}/generate-cmdlist.sh"
+	execute_process(COMMAND "${SH_EXE}" "${CMAKE_SOURCE_DIR}/tools/generate-cmdlist.sh"
 				${EXCLUSION_PROGS}
 				"${CMAKE_SOURCE_DIR}"
 				"${CMAKE_BINARY_DIR}/command-list.h")
@@ -644,14 +644,14 @@ endif()
 
 if(NOT EXISTS ${CMAKE_BINARY_DIR}/config-list.h)
 	message("Generating config-list.h")
-	execute_process(COMMAND "${SH_EXE}" "${CMAKE_SOURCE_DIR}/generate-configlist.sh"
+	execute_process(COMMAND "${SH_EXE}" "${CMAKE_SOURCE_DIR}/tools/generate-configlist.sh"
 				"${CMAKE_SOURCE_DIR}"
 				"${CMAKE_BINARY_DIR}/config-list.h")
 endif()
 
 if(NOT EXISTS ${CMAKE_BINARY_DIR}/hook-list.h)
 	message("Generating hook-list.h")
-	execute_process(COMMAND "${SH_EXE}" ${CMAKE_SOURCE_DIR}/generate-hooklist.sh
+	execute_process(COMMAND "${SH_EXE}" ${CMAKE_SOURCE_DIR}/tools/generate-hooklist.sh
 				"${CMAKE_SOURCE_DIR}"
 				"${CMAKE_BINARY_DIR}/hook-list.h")
 endif()
@@ -832,11 +832,11 @@ foreach(script ${git_shell_scripts})
 	endif()
 
 	add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/${shell_gen_path}"
-		COMMAND "${SH_EXE}" "${CMAKE_SOURCE_DIR}/generate-script.sh"
+		COMMAND "${SH_EXE}" "${CMAKE_SOURCE_DIR}/tools/generate-script.sh"
 			"${CMAKE_SOURCE_DIR}/${script}.sh"
 			"${CMAKE_BINARY_DIR}/${shell_gen_path}"
 			"${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS"
-		DEPENDS "${CMAKE_SOURCE_DIR}/generate-script.sh"
+		DEPENDS "${CMAKE_SOURCE_DIR}/tools/generate-script.sh"
 			"${CMAKE_SOURCE_DIR}/${script}.sh"
 		VERBATIM)
 	list(APPEND shell_gen ${CMAKE_BINARY_DIR}/${shell_gen_path})
@@ -875,13 +875,13 @@ foreach(script ${git_perl_scripts} ${perl_modules})
 	file(MAKE_DIRECTORY "${CMAKE_BINARY_DIR}/${perl_gen_dir}")
 
 	add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/${perl_gen_path}"
-		COMMAND "${SH_EXE}" "${CMAKE_SOURCE_DIR}/generate-perl.sh"
+		COMMAND "${SH_EXE}" "${CMAKE_SOURCE_DIR}/tools/generate-perl.sh"
 			"${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS"
 			"${CMAKE_BINARY_DIR}/GIT-VERSION-FILE"
 			"${CMAKE_BINARY_DIR}/GIT-PERL-HEADER"
 			"${CMAKE_SOURCE_DIR}/${script}"
 			"${CMAKE_BINARY_DIR}/${perl_gen_path}"
-		DEPENDS "${CMAKE_SOURCE_DIR}/generate-perl.sh"
+		DEPENDS "${CMAKE_SOURCE_DIR}/tools/generate-perl.sh"
 			"${CMAKE_SOURCE_DIR}/${script}"
 			"${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS"
 			"${CMAKE_BINARY_DIR}/GIT-VERSION-FILE"
@@ -892,11 +892,11 @@ add_custom_target(perl-gen ALL DEPENDS ${perl_gen})
 
 # Python script
 add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/git-p4"
-	COMMAND "${SH_EXE}" "${CMAKE_SOURCE_DIR}/generate-python.sh"
+	COMMAND "${SH_EXE}" "${CMAKE_SOURCE_DIR}/tools/generate-python.sh"
 		"${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS"
 		"${CMAKE_SOURCE_DIR}/git-p4.py"
 		"${CMAKE_BINARY_DIR}/git-p4"
-	DEPENDS "${CMAKE_SOURCE_DIR}/generate-python.sh"
+	DEPENDS "${CMAKE_SOURCE_DIR}/tools/generate-python.sh"
 		"${CMAKE_SOURCE_DIR}/git-p4.py"
 		"${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS"
 	VERBATIM)
diff --git a/contrib/subtree/meson.build b/contrib/subtree/meson.build
index 161435abeb..804c315894 100644
--- a/contrib/subtree/meson.build
+++ b/contrib/subtree/meson.build
@@ -3,7 +3,7 @@ git_subtree = custom_target(
   output: 'git-subtree',
   command: [
     shell,
-    meson.project_source_root() / 'generate-script.sh',
+    meson.project_source_root() / 'tools/generate-script.sh',
     '@INPUT@',
     '@OUTPUT@',
     meson.project_build_root() / 'GIT-BUILD-OPTIONS',
diff --git a/meson.build b/meson.build
index 1d66b5181e..604fe89d2d 100644
--- a/meson.build
+++ b/meson.build
@@ -554,7 +554,7 @@ libgit_sources = [
 libgit_sources += custom_target(
   input: 'command-list.txt',
   output: 'command-list.h',
-  command: [shell, meson.current_source_dir() + '/generate-cmdlist.sh', meson.current_source_dir(), '@OUTPUT@'],
+  command: [shell, meson.current_source_dir() + '/tools/generate-cmdlist.sh', meson.current_source_dir(), '@OUTPUT@'],
   env: script_environment,
 )
 
@@ -723,10 +723,10 @@ endif
 builtin_sources += custom_target(
   output: 'config-list.h',
   depfile: 'config-list.h.d',
-  depend_files: [ 'generate-configlist.sh' ],
+  depend_files: [ 'tools/generate-configlist.sh' ],
   command: [
     shell,
-    meson.current_source_dir() / 'generate-configlist.sh',
+    meson.current_source_dir() / 'tools/generate-configlist.sh',
     meson.current_source_dir(),
     '@OUTPUT@',
     '@DEPFILE@',
@@ -739,7 +739,7 @@ builtin_sources += custom_target(
   output: 'hook-list.h',
   command: [
     shell,
-    meson.current_source_dir() + '/generate-hooklist.sh',
+    meson.current_source_dir() + '/tools/generate-hooklist.sh',
     meson.current_source_dir(),
     '@OUTPUT@',
   ],
@@ -1959,7 +1959,7 @@ foreach script : scripts_sh
     output: fs.stem(script),
     command: [
       shell,
-      meson.project_source_root() / 'generate-script.sh',
+      meson.project_source_root() / 'tools/generate-script.sh',
       '@INPUT@',
       '@OUTPUT@',
       meson.project_build_root() / 'GIT-BUILD-OPTIONS',
@@ -2008,7 +2008,7 @@ if perl_features_enabled
 
   generate_perl_command = [
     shell,
-    meson.project_source_root() / 'generate-perl.sh',
+    meson.project_source_root() / 'tools/generate-perl.sh',
     meson.project_build_root() / 'GIT-BUILD-OPTIONS',
     git_version_file.full_path(),
     perl_header,
@@ -2057,7 +2057,7 @@ if target_python.found()
       output: fs.stem(script),
       command: [
         shell,
-        meson.project_source_root() / 'generate-python.sh',
+        meson.project_source_root() / 'tools/generate-python.sh',
         meson.project_build_root() / 'GIT-BUILD-OPTIONS',
         '@INPUT@',
         '@OUTPUT@',
diff --git a/check-builtins.sh b/tools/check-builtins.sh
similarity index 100%
rename from check-builtins.sh
rename to tools/check-builtins.sh
diff --git a/detect-compiler b/tools/detect-compiler
similarity index 100%
rename from detect-compiler
rename to tools/detect-compiler
diff --git a/generate-cmdlist.sh b/tools/generate-cmdlist.sh
similarity index 100%
rename from generate-cmdlist.sh
rename to tools/generate-cmdlist.sh
diff --git a/generate-configlist.sh b/tools/generate-configlist.sh
similarity index 100%
rename from generate-configlist.sh
rename to tools/generate-configlist.sh
diff --git a/generate-hooklist.sh b/tools/generate-hooklist.sh
similarity index 100%
rename from generate-hooklist.sh
rename to tools/generate-hooklist.sh
diff --git a/generate-perl.sh b/tools/generate-perl.sh
similarity index 100%
rename from generate-perl.sh
rename to tools/generate-perl.sh
diff --git a/generate-python.sh b/tools/generate-python.sh
similarity index 100%
rename from generate-python.sh
rename to tools/generate-python.sh
diff --git a/generate-script.sh b/tools/generate-script.sh
similarity index 100%
rename from generate-script.sh
rename to tools/generate-script.sh

-- 
2.53.0.880.g73c4285caa.dirty

