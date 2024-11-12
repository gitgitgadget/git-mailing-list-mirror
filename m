Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A926212D37
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 17:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731431018; cv=none; b=Ysfqa+4P8VGJG6M/BF97a7qMa+9clggRWGuRcxJza716UPeXet3tWgNFj33vwuE8X8LZgzKT7J8kln5QI8JcT5BQenz/SUy3usSV0Mq9DgDYdzILyB7qAShd35lmxkriE92JFrDqTEfsGwsQjLmGaDLXlOQ17er/agGXLGpzgSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731431018; c=relaxed/simple;
	bh=iH2OsxOeiSC8krcrrxWeeyNsFhmd14SxSMH7/1bJg94=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j/7CJGYP4YMYxhxvFRLM1YQ9gFr6NQ7oVu1uG1YQnL3EgYFCxvKVaxy44TC9mEaI626ZoUDvbbbvne/5GnoaO1QB8Ap/9FUvJkGS0Zu7GGb3g+REP3OkAiPWKed1kmCd5Hx7m6LyWMbf67G9hooWP5hj0HlrGyF1qz7paHz64xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JvHypqfV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FietqmgK; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JvHypqfV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FietqmgK"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6E038254013C;
	Tue, 12 Nov 2024 12:03:35 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 12 Nov 2024 12:03:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731431015;
	 x=1731517415; bh=PIS+PGwg1TfN0otqCrLgn/W9LQSfbaWNY7ab14pLcX4=; b=
	JvHypqfVPoS52ZuG/sxXBWFoqa/QW5GhQjgRlGXCZh6Zm/P1Gr7FL2QTiKaVvP4r
	bvCEVldnWsgJkmU0itg9uxCerFM/xJq8vMZYlyL5a79/2w+OXZHlienPJ6EOUm0R
	Lc8Ao10k4vHW84CfgBs6QSF6EtSXyoAp8Dn97eo65Irrw5IkB3xydzjVnbPx/eCN
	BMKQNOMqhT+vaeN0kqtiRZIKq5ckTUyJVLqmpSHQMbrErQyP7LRrphM1PLAG7egK
	pC8u31j9sOWbbDXdI6e7AHbrGblZ63oo25Tm9lhBVQQp5dCOTMVCSWxzcbmvLs6e
	BkMt7+yVLeRmuHBSp+wWcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731431015; x=
	1731517415; bh=PIS+PGwg1TfN0otqCrLgn/W9LQSfbaWNY7ab14pLcX4=; b=F
	ietqmgKlNS7FU78+ao0loJ4ynnhMdwYKGOuyBTUMaS9DFnNwUKpBmFwqGhQav+Pr
	GP5wSoDmxgJUf4qW9GsAT1rZc6FxbTk8tr6yP4KowEoeT2Hut/V14F2oKPGJQcwi
	Q/BNen0eAqAN94AHPmzIdQjjvMEEvGT7lu4jWd63DjtpC277+fDVhDLUM7Ta/lMx
	XTR7kfW4qGWO3Ecb5JwJwmob+IbMtqlvDmKeoqFIHbdTlWWohEcBQIjmxFrfbnFr
	wzt2c6BNSliIKYgpJJN0BKC1M4tM+nwFSbA2H+LPNxQ+qjU8BdiLOFhxl9Q2LAXO
	0CsszAPSNbj2y/gwapxEw==
X-ME-Sender: <xms:ZoozZxMWj0-YV6xAiRxEd67Pk2hGdMRADh0K3rZtXT0WtHuJloBA-Q>
    <xme:ZoozZz-UO4mYykRa7odkIJ4WvTkTch1dKGk8lSYBj3VDSO0fmsqCa2-a47TrV32G2
    sDBsWM22RmYkCdlSw>
X-ME-Received: <xmr:ZoozZwQRAzkI16EKsTwHj4-SzjKrEJe0v7JZc6627G2eZJNvGECyxwSHUQgsl16KQUh6VWDcNeZfpihzvELulzEbCFjcspp8ccVYWVv4P3nNN4c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehphhhi
    lhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtth
    grhihlohhrrhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgv
    tghordgtohhmpdhrtghpthhtohepuggrvhhvihgusehgmhgrihhlrdgtohhmpdhrtghpth
    htoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfse
    hpvghffhdrnhgvth
X-ME-Proxy: <xmx:ZoozZ9tCK3QbExvkhDzg86OB0FK8gUZa_VH2ZSoPixUlTmXClwOA1Q>
    <xmx:ZoozZ5f9oxwX3Y7ut6Y9kUdQqBhE78EsxQn0mhzMp0bSYlszd4XrgQ>
    <xmx:ZoozZ50_w8H1_rUUoUGkTYtQ0yvYJdWrJB9MKE82dZGD80W5TVoL_Q>
    <xmx:ZoozZ1-1oii2DMYGRXHKlA5GI8YqWUPdftH5d_OmP_s5ZZ-PbAYVLw>
    <xmx:Z4ozZ17Q0l2SdJEX4Z55wovF1HH_k4DlcySTGfYTkg-fjC0oJ2fjHVHo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 12:03:32 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c7af1f16 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 12 Nov 2024 17:02:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 12 Nov 2024 18:02:49 +0100
Subject: [PATCH RFC v6 06/19] Makefile: extract script to massage Shell
 scripts
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-pks-meson-v6-6-648b30996827@pks.im>
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
index cff71e5e84c69d87bb67b72f7bcfecd639ae7188..28f5e96c4def70f2eed3675cfad665022ad91704 100644
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
index 97504c3d7e4aa67041139c6bc9d5731874de19ef..d2ec6cfc78f092f6299a624d5382d71fcb4d0644 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -834,18 +834,23 @@ set(git_shell_scripts
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
@@ -1160,6 +1165,10 @@ string(REPLACE "@GIT_INTEROP_MAKE_OPTS@" "" git_build_options "${git_build_optio
 string(REPLACE "@GIT_TEST_INDEX_VERSION@" "" git_build_options "${git_build_options}")
 string(REPLACE "@GIT_TEST_PERL_FATAL_WARNINGS@" "" git_build_options "${git_build_options}")
 string(REPLACE "@RUNTIME_PREFIX@" "${RUNTIME_PREFIX}" git_build_options "${git_build_options}")
+string(REPLACE "@GITWEBDIR@" "${GITWEBDIR}" git_build_options "${git_build_options}")
+string(REPLACE "@USE_GETTEXT_SCHEME@" "" git_build_options "${git_build_options}")
+string(REPLACE "@LOCALEDIR@" "${LOCALEDIR}" git_build_options "${git_build_options}")
+string(REPLACE "@BROKEN_PATH_FIX@" "" git_build_options "${git_build_options}")
 if(USE_VCPKG)
 	string(APPEND git_build_options "PATH=\"$PATH:$TEST_DIRECTORY/../compat/vcbuild/vcpkg/installed/x64-windows/bin\"\n")
 endif()
diff --git a/generate-script.sh b/generate-script.sh
new file mode 100755
index 0000000000000000000000000000000000000000..d001e43d7bf1c4d72f41f805128ae42330a54558
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
2.47.0.251.gb31fb630c0.dirty

