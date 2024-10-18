Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3532F262A3
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 12:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729254265; cv=none; b=NzL6fC90lfRBuPuM2l2E8t749hVG7qm9pmmCIlhuHLz+NHcd6vNIlurk6xbAKbDPJo06Xo60EqVGRG7NGW70Nzf7EceAlA5zS2Q/N1ZaQVochv8EIIuoedJHI+xvELdLjq8QK1MdWtkEoDESPDFIfqag177j9axtrL/WMDRMu+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729254265; c=relaxed/simple;
	bh=tkHzlCYlSWQvJMi4eHxAa+6Vnnw8cxsecCHpv7Vd91c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JxsPZI3Zc2gGxHsdTV3yYw/8jMJQYWBLgV7opTvT1Se9RQ7UNtsFvtqxcxC/JNn2715XTCpIHbg2KTU00pcCpBK3//c6JeSzJKrulJSjlTvR6H2CrTrced4+hq4SHJvBPRzFVQdfH7pWzwrWXLAw+0EsgT8m3u+wA6TQHJIPAPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XIDynlnH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nQ0EGcxj; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XIDynlnH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nQ0EGcxj"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 42FEC11400CD;
	Fri, 18 Oct 2024 08:24:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 18 Oct 2024 08:24:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729254263; x=1729340663; bh=d1HXSFTQ6y
	0VR6eLIDVo3y6Pift2HMuwsAg+90AuQW8=; b=XIDynlnHxEj1WAxOEmZZzqasf2
	79kv0AqZ1f+KfV5B8CmAqGreQOfYRASfIpN1oytj02HPSUPX+Dy44fhzgzI5cwqE
	CLyXpK18KAj+td8/hwr9F79CQBXfs1ixoJ9M2IIDxExyXZa6xCVCrdkLYfBfjNSQ
	zHqkoZw9PM3RU4qWvW3AxENb0bbYkvSUPisciAK5cT/vSE8HyiOooNBnklNSgxvh
	+Ef4ggcA5LpGDE2klkhvgH/FrWQ2GdaqKeMEMrCwekN9NYBbcP4+K3pBYzH7tl8f
	wIv4nJuITF/V5z6Qg9Pj3tSfMV+9RHzrk0ykyITXlnYJpbWgse4gGd/FKb0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729254263; x=1729340663; bh=d1HXSFTQ6y0VR6eLIDVo3y6Pift2
	HMuwsAg+90AuQW8=; b=nQ0EGcxjhjoXK8USGBf8s3yIKd8RpbDgFfPgLreKLQBD
	S30LYcuB0ppQCVSp+lNoBqHRfhqG+s1mOVfbK/rrgBW2YbNLsE3FHc4ticqTSz8F
	8swQxL95BH0+ZJdyPaR5r2hx+83916L+NE0RHxEdubj/QnFyaL8Jol/B/2wRfCtS
	T3c72YrHhO+GNsarzBlg+ajfbAeOEl31uT3KKybKj7kziJFC7r5pWKZ0mv+UwqrU
	5KxH3k1Zsy8uOabPQPZPmcObJN/X2pcnBYfBCSh6cRt6V6IevZcoqm/Um8PgUtjS
	38e8J5s+dpofJgUcRM50ka74HiyBJpoyNoqwf8mLlQ==
X-ME-Sender: <xms:dlMSZ7utKvbwtE6U9gd0NdbtlXyYRIqFA89BcXFeRJEUFh8a1HyiTg>
    <xme:dlMSZ8cWnMKWqcWOUSdxwAKCIGhZGxJrzN83A7Zjb7OuOfg5Ko_Pxk6lQmyZruCCK
    -gSzdE2ifiTCsiZdg>
X-ME-Received: <xmr:dlMSZ-zUwKH-Uucv2GWXVuFiYP8f5T-hQfl6bcAcrlWwJNoQZxAQLirH4Ie2emwqgk9JVkEDfH7mWEBxrMz-kkZKRuWqnZlaEVT4E2mwhqoV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehfedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphhhihhl
    lhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehrrghmshgrhi
    esrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepshhunhhshhhi
    nhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopegvshgthhifrghrthiise
    hgvghnthhoohdrohhrgh
X-ME-Proxy: <xmx:dlMSZ6Mc2lThwnrRL6SVL4I9gWVljg_Ga_5fz2L066rBBfppeQ9__w>
    <xmx:dlMSZ79nIBOtlQ7ir_Nf_OjLgbmvv32E_u-3ShhBfAYgFYt-UmnlsA>
    <xmx:dlMSZ6Vi_Ag1SwW3Jl6RDSHOshQ1ulpVUsYXbxwioRuZQ3vsOQJa7w>
    <xmx:dlMSZ8fPzwxLfRr_xyQcdtfPaY6WRWKUKuIVhXE-tGdM6wxLvxqmvw>
    <xmx:d1MSZ7z3Wlrt6bIQ15bPSq_PcE6guOD5zNT06Q_vlJLPbxyTkA-PwZ9F>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Oct 2024 08:24:21 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3018da9b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 18 Oct 2024 12:23:00 +0000 (UTC)
Date: Fri, 18 Oct 2024 14:24:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [RFC PATCH v3 09/15] Makefile: refactor generators to be
 PWD-independent
Message-ID: <9be0719ce1b73a82310a06edbcf5de8890fdc220.1729254070.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729254070.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729254070.git.ps@pks.im>

We have multiple scripts that generate headers from other data. All of
these scripts have the assumption built-in that they are executed in the
current source directory, which makes them a bit unwieldy to use during
out-of-tree builds. This makes them a bit unwieldy to use. Refactor them
to instead take the source directory as well as the output file as
arguments.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                            |  6 ++---
 contrib/buildsystems/CMakeLists.txt | 12 +++------
 generate-cmdlist.sh                 | 42 ++++++++++++++++++-----------
 generate-configlist.sh              | 20 ++++++++++----
 generate-hooklist.sh                | 15 ++++++++++-
 5 files changed, 61 insertions(+), 34 deletions(-)

diff --git a/Makefile b/Makefile
index 2211adbeba2..d10a72132f7 100644
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
2.47.0.72.gef8ce8f3d4.dirty

