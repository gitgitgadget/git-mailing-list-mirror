Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC4D1DAC97
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 12:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729773620; cv=none; b=gAlxHy4G/TY/JpvKJoJmRU9R/btrGQ6MEkiw0n6ltYzXFcUlkPE+GYaOzsXhomLeBC+SEtuTAKJ9Q0D7PEbgkpZOFAbyJ0KYEImr/Jd923XQEI3rTtKPq0jGprJm37pal9g/DqpzkrsAPSnuURDlnLKtBKnFx6UEgxbWzxC9bkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729773620; c=relaxed/simple;
	bh=1KLy5bewpCeBK8mrlBESolx9RewKKl3u7hDIS9dRyuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eaaDD4GN/63AH6HRzzjXdUhZxPFlfD7stZ6/RhSPLzlLVgPsROLUCxef8Oi07HWlUGzqyrOexO9Vcc0MN6XhkvNl0GatA0k+BlbzSlla3qM/WxiTMR/TDk8vTGHyz4r3u0FPe1rIDOKqTwSO2B/hCACX52iuWM3H1AO4yoraygE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=p7z5gYNd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DGu+iclf; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="p7z5gYNd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DGu+iclf"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id A9A821140127;
	Thu, 24 Oct 2024 08:40:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 24 Oct 2024 08:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729773617; x=1729860017; bh=9BSexjhKkN
	pmgRox0iENchkWyIG22BwPLMeVVqirOgg=; b=p7z5gYNd7XEnuSOpX+aOpx1dNH
	6R3vBr59g4DejppLmzdQXi/hK/WHsQYc3VjFqvfgSLJBkxdCIZWVC0Ko+2erAIYr
	bkvg4LDbxssr+rL8TOsnH6SftLrkT2T5lBUxW5YepYFfSx0xmxig1xlF4UFQuS6S
	aq7l5RSkVIskPqI4mZTN14a9TJt7x/ChOwySJlYTeygDbm8/4EGLlB9I05Jhlxh8
	LPAC1m9Rd43Se69uKqx0b1CDxrW0XUAY4A+wV70Izt6J+3b/rJAmaP2cy8oU2lKt
	dUM4fR9NcVZ5p+zq6F2nr6UM6ZQMU3ubH9yi/M8YTYvgJzLxHp5iILGc0+vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729773617; x=1729860017; bh=9BSexjhKkNpmgRox0iENchkWyIG2
	2BwPLMeVVqirOgg=; b=DGu+iclf8BeBG/KN44y/COJYtLOZybgopxDrb+FgcdJT
	mEnwTFSIvYBk/s+1YDoZDUxBJou1Honlz5jCZaPMdJx92+Bxm4z8DNDzaBFAwECy
	QFBNS+dynF5dU/3OMGDHPLo+oXgIdSKcWwKtKc3A7IDH0gKrWEPYM6H7tBqjv7Ne
	DbAyp4BV8u9KiJVYoEdidT+7m5C/Vo4VIeHiPGpuIC8e2rNaAUmad0ooAKAJl4nJ
	xhDVYSBxrQ26qyHukwJzsuHBnYFT2lPVeHcCo/q7pnGTsJ81gWi8yEI7fwDSws/3
	HhecAkMWNN/itio2ndZ+h39/mOEedOtrtsk/7Gbwwg==
X-ME-Sender: <xms:MUAaZ4pdzut_I9qYm9HjjBaWKjGYFW-WlvKfbh9k2qJ3tqxWUxdpsQ>
    <xme:MUAaZ-rrFf63FaqYQLbpAlU4BHbloCPDW5OU8L23TKTnSpmKcDDqHVF1TSLCWRYpw
    UKM2mRx4QwmvIKo2g>
X-ME-Received: <xmr:MUAaZ9MGYkDAbZCPr8BvRMkhRSEuN5F7wCVTPdci_5RD2Kpokzu6_b2WzEL223NwVz49vFdh_AmIDzvR7S-Tp8FZPuYzim2oDtDdHbQAsG6AGhah>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejtddgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhl
    lhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhih
    hnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiies
    ghgvnhhtohhordhorhhgpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvg
    hsrdhplhhushdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:MUAaZ_7lRQWDYH-5S9JIjidlAihP-Egwnmh7SPLc-jB6ju0UFjlOPQ>
    <xmx:MUAaZ37l0JFLMXg-lqbTGKuy1XgOYnrXqlDwa4C1ZRKOFHYGhzg7KA>
    <xmx:MUAaZ_iGLxkIceCIzVlkrfk3vOVCziATwNAn9KV6APVTdY3Z8QA7bg>
    <xmx:MUAaZx7ZvFt8qt6zxHzRlmCAhujonp4ZPTpMI-9gtHUORdf8_ZvzKA>
    <xmx:MUAaZ6ZE2kfiAWUw2llzvwb_jDhwTQ6byLSkkn0sB88viRdSplgYoQbf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Oct 2024 08:40:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1f12c2ca (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Oct 2024 12:40:18 +0000 (UTC)
Date: Thu, 24 Oct 2024 14:40:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [RFC PATCH v4 09/19] Makefile: refactor generators to be
 PWD-independent
Message-ID: <46b7760fbcd0708a1137807d3bfc4070246f8556.1729771605.git.ps@pks.im>
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

We have multiple scripts that generate headers from other data. All of
these scripts have the assumption built-in that they are executed in the
current source directory, which makes them a bit unwieldy to use during
out-of-tree builds.

Refactor them to instead take the source directory as well as the output
file as arguments.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                            |  6 ++---
 contrib/buildsystems/CMakeLists.txt | 12 +++------
 generate-cmdlist.sh                 | 42 ++++++++++++++++++-----------
 generate-configlist.sh              | 20 ++++++++++----
 generate-hooklist.sh                | 15 ++++++++++-
 5 files changed, 61 insertions(+), 34 deletions(-)

diff --git a/Makefile b/Makefile
index 461f0216bf6..975c18dfb8f 100644
--- a/Makefile
+++ b/Makefile
@@ -2523,17 +2523,17 @@ $(BUILT_INS): git$X
 config-list.h: generate-configlist.sh
 
 config-list.h: Documentation/*config.txt Documentation/config/*.txt
-	$(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh >$@
+	$(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh . $@
 
 command-list.h: generate-cmdlist.sh command-list.txt
 
 command-list.h: $(wildcard Documentation/git*.txt)
 	$(QUIET_GEN)$(SHELL_PATH) ./generate-cmdlist.sh \
 		$(patsubst %,--exclude-program %,$(EXCLUDED_PROGRAMS)) \
-		command-list.txt >$@
+		. $@
 
 hook-list.h: generate-hooklist.sh Documentation/githooks.txt
-	$(QUIET_GEN)$(SHELL_PATH) ./generate-hooklist.sh >$@
+	$(QUIET_GEN)$(SHELL_PATH) ./generate-hooklist.sh . $@
 
 SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):\
 	$(localedir_SQ):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ):\
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index e1200f294de..f4ffe64965d 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -648,23 +648,17 @@ set(EXCLUSION_PROGS_CACHE ${EXCLUSION_PROGS} CACHE STRING "Programs not built" F
 if(NOT EXISTS ${CMAKE_BINARY_DIR}/command-list.h OR NOT EXCLUSION_PROGS_CACHE STREQUAL EXCLUSION_PROGS)
 	list(REMOVE_ITEM EXCLUSION_PROGS empty)
 	message("Generating command-list.h")
-	execute_process(COMMAND ${SH_EXE} ${CMAKE_SOURCE_DIR}/generate-cmdlist.sh ${EXCLUSION_PROGS} command-list.txt
-			WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
-			OUTPUT_FILE ${CMAKE_BINARY_DIR}/command-list.h)
+	execute_process(COMMAND ${SH_EXE} ${CMAKE_SOURCE_DIR}/generate-cmdlist.sh ${EXCLUSION_PROGS} ${CMAKE_SOURCE_DIR} ${CMAKE_BINARY_DIR}/command-list.h)
 endif()
 
 if(NOT EXISTS ${CMAKE_BINARY_DIR}/config-list.h)
 	message("Generating config-list.h")
-	execute_process(COMMAND ${SH_EXE} ${CMAKE_SOURCE_DIR}/generate-configlist.sh
-			WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
-			OUTPUT_FILE ${CMAKE_BINARY_DIR}/config-list.h)
+	execute_process(COMMAND ${SH_EXE} ${CMAKE_SOURCE_DIR}/generate-configlist.sh ${CMAKE_SOURCE_DIR} ${CMAKE_BINARY_DIR}/config-list.h)
 endif()
 
 if(NOT EXISTS ${CMAKE_BINARY_DIR}/hook-list.h)
 	message("Generating hook-list.h")
-	execute_process(COMMAND ${SH_EXE} ${CMAKE_SOURCE_DIR}/generate-hooklist.sh
-			WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
-			OUTPUT_FILE ${CMAKE_BINARY_DIR}/hook-list.h)
+	execute_process(COMMAND ${SH_EXE} ${CMAKE_SOURCE_DIR}/generate-hooklist.sh ${CMAKE_SOURCE_DIR} ${CMAKE_BINARY_DIR}/hook-list.h)
 endif()
 
 include_directories(${CMAKE_BINARY_DIR})
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 205541e0f7f..b923a5aab80 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -64,7 +64,7 @@ define_category_names () {
 print_command_list () {
 	echo "static struct cmdname_help command_list[] = {"
 
-	echo "$1" |
+	echo "$2" |
 	while read cmd rest
 	do
 		synopsis=
@@ -76,7 +76,7 @@ print_command_list () {
 				break
 				;;
 			esac
-		done <"Documentation/$cmd.txt"
+		done <"$1/Documentation/$cmd.txt"
 
 		printf '\t{ "%s", N_("%s"), 0' "$cmd" "$synopsis"
 		printf " | CAT_%s" $rest
@@ -93,18 +93,28 @@ do
 	shift
 done
 
-commands="$(command_list "$1")"
-categories="$(category_list "$commands")"
+if test "$#" -ne 2
+then
+	die "USAGE: $0 <SOURCE_DIR> <OUTPUT>"
+fi
+
+SOURCE_DIR="$1"
+OUTPUT="$2"
+
+{
+	commands="$(command_list "$SOURCE_DIR"/command-list.txt)"
+	categories="$(category_list "$commands")"
 
-echo "/* Automatically generated by generate-cmdlist.sh */
-struct cmdname_help {
-	const char *name;
-	const char *help;
-	uint32_t category;
-};
-"
-define_categories "$categories"
-echo
-define_category_names "$categories"
-echo
-print_command_list "$commands"
+	echo "/* Automatically generated by generate-cmdlist.sh */
+	struct cmdname_help {
+		const char *name;
+		const char *help;
+		uint32_t category;
+	};
+	"
+	define_categories "$categories"
+	echo
+	define_category_names "$categories"
+	echo
+	print_command_list "$SOURCE_DIR" "$commands"
+} >"$OUTPUT"
diff --git a/generate-configlist.sh b/generate-configlist.sh
index 8692fe5cf4d..512804a1ca1 100755
--- a/generate-configlist.sh
+++ b/generate-configlist.sh
@@ -1,13 +1,19 @@
 #!/bin/sh
 
-echo "/* Automatically generated by generate-configlist.sh */"
-echo
+SOURCE_DIR="$1"
+OUTPUT="$2"
+
+if test -z "$SOURCE_DIR" || ! test -d "$SOURCE_DIR" || test -z "$OUTPUT"
+then
+	echo "USAGE: $0 <SOURCE_DIR> <OUTPUT>" >&2
+	exit 1
+fi
 
 print_config_list () {
 	cat <<EOF
 static const char *config_name_list[] = {
 EOF
-	grep -h '^[a-zA-Z].*\..*::$' Documentation/*config.txt Documentation/config/*.txt |
+	grep -h '^[a-zA-Z].*\..*::$' "$SOURCE_DIR"/Documentation/*config.txt "$SOURCE_DIR"/Documentation/config/*.txt |
 	sed '/deprecated/d; s/::$//; s/,  */\n/g' |
 	sort |
 	sed 's/^.*$/	"&",/'
@@ -17,5 +23,9 @@ EOF
 EOF
 }
 
-echo
-print_config_list
+{
+	echo "/* Automatically generated by generate-configlist.sh */"
+	echo
+	echo
+	print_config_list
+} >"$OUTPUT"
diff --git a/generate-hooklist.sh b/generate-hooklist.sh
index 2f9f54eb545..0ff2a0b6fbd 100755
--- a/generate-hooklist.sh
+++ b/generate-hooklist.sh
@@ -2,6 +2,17 @@
 #
 # Usage: ./generate-hooklist.sh >hook-list.h
 
+SOURCE_DIR="$1"
+OUTPUT="$2"
+
+if test -z "$SOURCE_DIR" || ! test -d "$SOURCE_DIR" || test -z "$OUTPUT"
+then
+	echo "USAGE: $0 <SOURCE_DIR> <OUTPUT>" >&2
+	exit 1
+fi
+
+{
+
 cat <<EOF
 /* Automatically generated by generate-hooklist.sh */
 
@@ -11,10 +22,12 @@ EOF
 sed -n \
 	-e '/^~~~~*$/ {x; s/^.*$/	"&",/; p;}' \
 	-e 'x' \
-	<Documentation/githooks.txt |
+	<"$SOURCE_DIR"/Documentation/githooks.txt |
 	LC_ALL=C sort
 
 cat <<EOF
 	NULL,
 };
 EOF
+
+} >"$OUTPUT"
-- 
2.47.0.118.gfd3785337b.dirty

