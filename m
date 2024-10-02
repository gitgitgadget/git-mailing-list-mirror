Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A628D1D0DE9
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 15:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882184; cv=none; b=UfpS8NhC+2qH/BFFgla39M8kv0Q4yvEmkvB61cy0FKJVeEXuhAzaTFF4N3jtICXWGVN/9HMJ2AKs2c+lC7Ck/cPAEsN6UlKw8oTY7g+w+tCoMZJjQzCzVvTh1dkz+bCP0uJangT26Fb+uB3AQyX9Hnnr5y2zeRcS+RMxKIjl5sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882184; c=relaxed/simple;
	bh=BBs4gnf0HNX17eHsXq7JQ3P5bvbJK3cDcO0NDvoGzhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbBDLPa5G1r9swEE7cgxA834SgK5nbVw2mrsxqk/KtNdHaT1f/Ca8KccVtLP48hwHNpQZ//dty9895MtMpedFzvVSSQTAq7+0yT5vg7K7JBYw1usDdqyKA1+Vy/5XpICtndGR5th3SoTOvVrGklJVCGoApV+sSFk6/3jnQlyXBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CU7Od2eL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WGrG0kBH; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CU7Od2eL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WGrG0kBH"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id C635D13801B1;
	Wed,  2 Oct 2024 11:16:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 02 Oct 2024 11:16:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727882181; x=1727968581; bh=Zz/nGvoah/
	UnRs1bCgYhrmEhmjpZOb2Jyoej8ZlELFM=; b=CU7Od2eL8op6+oakvxji5vgwZB
	aNoJuOhBvv422dRJ0TXmJuQYjGndygl07fq/HD9VOVLf61//7CxsaQYh+UTywvGf
	V9V5bX/hwGLPR+MEqwAqDMZ1ej5v/A27aTrcih3nnIUxAiIe5wiO+EutcPOa0NQz
	3YUrGQa0qr+us7xasb9AQDKxTOqdCAatMpa8yOYHmWFTjrvp0yW8f8WXY/TIJorg
	a24TOvRB9J0qusDjFb6hBt9Z5eZAWOGTZWOrt25EVKEPFRvtVCqZpP5PXH9rtaym
	it6NUJgE6c2p/emMpIyQ0LPMn8fEP+8Zw+l+uDKDhy8iENBtmUJvHR+8FwfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727882181; x=1727968581; bh=Zz/nGvoah/UnRs1bCgYhrmEhmjpZ
	Ob2Jyoej8ZlELFM=; b=WGrG0kBHiGbNol253uj4EYItp1Bjg+m6DYSnDPtDS+pc
	OIMnDeNtfh5k3hVJGWleGAsD88sKZIB4792x+9OU8lO6vZ441cEexrVqSyNka/uh
	JBlwYtQNMn0C0gIvprtPTVl5VZvaALx+a1V0wLpY4fyyc17B2XYyQMgorjDhqYz+
	tgy87hzqQPEGq5ME/OkSoyJzS4lsxOHv0S0M4QX08HEtagbAoEnuIsAueDo3r8OC
	ymVpWQVZ3nXa9TV/UiNct4ZqrHbs0mTfPBvHZ3IC0ROXbtgzeRQNMd5XmHK/B2Ik
	9IDOgBWqSKPZ6hm+pr4Vt9wPt7+gKfS9ROtVlWMdiA==
X-ME-Sender: <xms:xWP9Zg15Q5LCRpu-cAcJ2jblwOE17y1-_E1_vMz5g2KV3-_ZbKuBlg>
    <xme:xWP9ZrFUbgvbT08xFKxbrw5Aaq4HmQlxwSZi1KywHGfFVT-b9AmaCEezFsVDBuJt1
    Ngx-CJJx-GXyGbrFw>
X-ME-Received: <xmr:xWP9Zo5tnYZmP_Hgae5ApeyQLHQFYVLDBUcavP1sMMG1hsoyqS3dJ_YISWeT19m7doS14CEmpY0JtHvlaZz1LsOcvIaEh-5xraARaQss2UEaTxgT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:xWP9Zp2lQCnQP-TnpBeGMrZ7g9ZiZRFW52Q6xOZKWgaF5Tumi48M-g>
    <xmx:xWP9ZjFWUbS2nwl58wJiHTlfH0x6lNbNhq-GVbIwxN0swJ_u2ilSwA>
    <xmx:xWP9Zi9VJE5gDP9iXNo2bYZ0NCRrQ2IyJXF8Bbt-TABRAg0qN9WIIw>
    <xmx:xWP9ZokQ8qWI6RL4N_Kz7qQ6mqef4TwoPAdRLF0uofdCtYMmv3B0vA>
    <xmx:xWP9ZoSY5GPid_4V5qpkPpInG8NdPb2Zy8KtAkhJC7ewxh3GtcXbODGi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 11:16:20 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 397dc525 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 15:15:30 +0000 (UTC)
Date: Wed, 2 Oct 2024 17:16:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>
Subject: [RFC PATCH 13/21] Makefile: refactor generators to be PWD-independent
Message-ID: <7136aeaa1388cfc431948df7783abe051df5e60e.1727881164.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727881164.git.ps@pks.im>

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
index fae931ff0b..d128b5b3e4 100644
--- a/Makefile
+++ b/Makefile
@@ -2498,17 +2498,17 @@ $(BUILT_INS): git$X
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
index 01a23788e1..27d986eaf0 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -655,23 +655,17 @@ set(EXCLUSION_PROGS_CACHE ${EXCLUSION_PROGS} CACHE STRING "Programs not built" F
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
+	execute_process(COMMAND ${SH_EXE} ${CMAKE_SOURCE_DIR}/generate-configlist.sh ${CMAKE_SOURCE_DIR} ${CMAKE_BINARY_DIR}/config.list)
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
index 205541e0f7..b923a5aab8 100755
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
index 8692fe5cf4..512804a1ca 100755
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
index 2f9f54eb54..0ff2a0b6fb 100755
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
2.47.0.rc0.dirty

