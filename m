Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6712438CFF4
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 10:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773655706; cv=none; b=aUNnaWsR3r6LAxgnqMpXL6GREOgMZJ988hgnQwpJceqKRfSazXPXXxYhMFJUaywkByyp0vbouNfBpwfb99LAT4Oxkd/fxiK1qItNkF2yG0B9ALp6in73Nsh8wv3ewW/e+0LyoN73LWgI2IH3WU2HdO8y+hafdrHaWWMzNlqczZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773655706; c=relaxed/simple;
	bh=6iuTH1A4OpE2d9RVjGZhfjf+71zbaNkkK94pQQyZZr4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eAtnLufMk6Kselw9mjsMOoA7O+eX3CqtGQwjIMwsfyeb4c/YsDTzWGFvA9efb4XnOeJyBhtUWDlVtAT+Mi/CuwMRccb+drSDukHUE+DFJnsddZUCtjvjtI3EtXVGCTzuOA0CPGw1STPYWz58jz0N2uuD1R3UZDz5sU5CB9aKq3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=I7rcPmmP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pRiJP66/; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I7rcPmmP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pRiJP66/"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id A5183EC05B4;
	Mon, 16 Mar 2026 06:08:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 16 Mar 2026 06:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773655703;
	 x=1773742103; bh=IU/K8vmhfJVhDB3mqg8Bv955iMQ86CQ7pwTRAP92bFo=; b=
	I7rcPmmPwdvVR9dbSULT0aJhF+0GnfQbK/dNzX15Gi7u8r7eODJKfU5XfTrvlzYW
	/poKh7mPm4Zjpz9eN9NAARp2M+9WSY2p8hvuvZl211fX6tDiallMoMFJdEnkezcD
	MlwcGNDVmdx1HNgmba6zD0YrB6Jwi0qdeV9lxx9NVVsyme9eGk6m56xfgRfE5NnR
	g1ekSdsSChKPZH5taEEuk3VIqzPc9wrx9B0EbiIrhKjHhHtqqFXb4MVGFgldohhb
	R0SMbT9Q58Cqx9BrWWIigrAdhzCtSBP1vxYa5iQKXaR6wr0bhmThfRuQjvgkYNbs
	9c/3C7mFZo9q4dYvn9CycA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773655703; x=
	1773742103; bh=IU/K8vmhfJVhDB3mqg8Bv955iMQ86CQ7pwTRAP92bFo=; b=p
	RiJP66/W27hPbwlw76KDAR1hTcqzARD35ufsmhA94rzzxHSfsdJBIvRz3vre9u65
	qj0wv6h8GQGWRD4JnQ7SFHsYzD8FS4LxF9YQzzufG8IkgdbZrfjuifRfYva3GZUi
	GSRcFkhq3O5GyjR7lZ2GOnpaM4A3eoxHa9mMK+Mfg0z0DI1KOtFqhXA0Ez9eM6z5
	0eD7JsJUSlK4zEsLGgpneWZhlYD7f/A73T1Ke0RsFeI7MXnF0NXgOK5vBBWFIzdR
	YMvAE9MNn45MzTcMLKeQJ/oWmYjJJGZjAeV0mrsO03FpA2VvT/ZLqyGepILb0A4I
	SLmkin4prVEO+VWbZ4N/A==
X-ME-Sender: <xms:l9a3aXfIbOCuFF2hCn9nTmRymhlyCKBnrGa_DujhjgMVZp5EYT2LVQ>
    <xme:l9a3abBSQCMbmpO4a1TXmlFJFEFsNy73Kqr9no03Zn8LrVdgpaDQyHSO87mXNrHfP
    ZfkVZr0p85MSbWqO3gz8Cc3a6nk0ONMiYpLhacKu9g4qHjlNQOYLsg>
X-ME-Received: <xmr:l9a3aa-KLlSgtMX87oH3Gokpn_vWZTK6DZQ9Esz1GqxAP0owkHh_evuhzl-foxLdA0Aa35GQpK0QCiPJnP_VNrtGu5Gb0E3PlsnMuiS3YSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleekuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeuhfehjedvieevkeelleeiuddufefgudegueehteffkefhleevudevvdffgfetgeen
    ucffohhmrghinhepmhgrkhdruggvvhdprhgtrdhinhdpshhhrdhtohholhhspdgthhgvtg
    hkqdgsuhhilhhtihhnshdrshhhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsh
    iivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdr
    fihoohguseguuhhnvghlmhdrohhrghdruhhk
X-ME-Proxy: <xmx:l9a3aWKUVJJDJfIrt7hieiC3kiAV7qKkgRqFBl06SnMACXMN6SoALg>
    <xmx:l9a3aThNlpnpSSdODrRid5mjlTwG-p-PDdMSF_XHUAytDISGhZ2MfQ>
    <xmx:l9a3aW4XLEkaY3SMa5dcUfg-kNT5BNNC1qTTBRYZBfgXMBKaVM3Pow>
    <xmx:l9a3abZgTWWQ6MV6UZKFR1MhsQoGq-GbC0tmx7beU5Neq23z6LBZ6A>
    <xmx:l9a3aa6PbyySza9QnmnqMscRh4mMn6NwOJJUxRScQPkbSf75QBIc7NXC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 06:08:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e5ab8ea8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Mar 2026 10:08:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 16 Mar 2026 11:08:00 +0100
Subject: [PATCH v2 5/8] builds: move build scripts into "tools/"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-b4-pks-build-infra-improvements-v2-5-4b2c2c0c0425@pks.im>
References: <20260316-b4-pks-build-infra-improvements-v2-0-4b2c2c0c0425@pks.im>
In-Reply-To: <20260316-b4-pks-build-infra-improvements-v2-0-4b2c2c0c0425@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
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
2.53.0.959.g497ff81fa9.dirty

