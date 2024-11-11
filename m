Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C801A264C
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 15:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731339071; cv=none; b=AqUqG3amIUG1/BoBHZrQPB4FOZ94ZnJ370gGt9gY/2s8c3xfqs1y8mBcyyx3b1igJCH7GECiKzqZyBLNG6MU0maAm86EwAfQGEQW0I2+GoJb5NSGyU5Kdk2NIYLEGWMwmOqbGxrccIe2xW17sGecnTYW67+FSoeE4gK6zrqtyCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731339071; c=relaxed/simple;
	bh=PHTGj8Gy/nNXEpqLPNkjDMcdm8HW7YJie/8BGMAlwEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRVvQbSVZfXW6M/aFI4bffFh4OUMWND8mk6GtAxswfi6R62sSNaCZhBSryeKxR0bUF5sKq6DyO3kTPoIsrW3R8Cds8DQsNy3lC2ZdD9CiKDty9LueoAtYYw/UKW0vU/rKYnj8K2P8DyYfLSOjZm5+Dh21yS6LWmx9/1WGLZhjJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GkeaNtbm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GnhHPmfU; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GkeaNtbm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GnhHPmfU"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 27F4213806E7;
	Mon, 11 Nov 2024 10:31:09 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 11 Nov 2024 10:31:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731339069; x=1731425469; bh=Tt1c88DDUf
	ajOOK+c7aSPaCTd0Wk8+MkRZB/qB8dP7E=; b=GkeaNtbmEU04+rIZ14qzDa/iXF
	l71HlFAvRTVqddg1VpidcETvQZaRymD7rrVzXN0NbJair87ucmTqMwQyJrmsb3cs
	ldikfuDokjXqoeIgRcokUIhOiXLPTQTBQzPn43Xj75i4MeM5g2Ntv4DRVSFj+M5p
	ihc/e+1QSk1V3I3fQkrFp+2HUFGWLXmqDFrUoA0sdlcx25pV+PxCq+pQHOQEu/Zo
	X789S4CsWyfC/cVQ3QPCLlWIwrlNd8Dpm1EcAxNGXcz9DMwVFUqEWlS6w4EEM+NN
	EJp1L05wKv01R30lSIVAaDASyYfX5sbsAR1qBnFdVh9KZ9bpu4UZ2VKqCrbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731339069; x=1731425469; bh=Tt1c88DDUfajOOK+c7aSPaCTd0Wk8+MkRZB
	/qB8dP7E=; b=GnhHPmfU/a+5GcUKvGiNJGKhF2ckkFqrJSTOPFP+StrODvLuhj1
	bVO9UvHU5zaqRaJ+hX+MOF4UrececxUnHRPyUh6SZgXfmcUqwlpsM3RNtFLKe7UR
	N9ZpCR2AAvKUYD/PGNRWDSQufDfR9LOojHhNdfkKTi+HyNqcJ/RY35iCYvBfWFYb
	2sC0FAGzRB+gj68cATPPN2ESAYaCvpVjSu4Fk353mH8Asb91I7loQ/VszvJl9wlb
	qANtxEONIfBOb47MgE0nP5k4FCPDhE+Z5WpDG5tb7cGpltiI3SU37h+s07YMlxll
	5/y9b0C3Rlf9b/j8GV3dtsuDEWVjvTNVdBA==
X-ME-Sender: <xms:PCMyZ0v8T48jhgu46UasY8uaFHp-x11jvCnPvRrjtfbRnEsEUgZV_g>
    <xme:PCMyZxfq08h6pmL7HV6YOzsRZJBNrQXNRwhac2XuDTXzMc7R8j1hodF08AgY2PiMw
    KTl2CM8Hs0MnJWVjw>
X-ME-Received: <xmr:PCMyZ_ytH50c5u0TKMti7ghdAxRw_xcsiZeLGG1BMsh9f4_4q-uk_hEz_libt8UftSXIgNl7axGCvCYcYg9whv7ikBkTY_GPFfRAIieTzR7OqiK8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghmshgrhies
    rhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepshhunhhshhhinh
    gvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopegvshgthhifrghrthiisehg
    vghnthhoohdrohhrghdprhgtphhtthhopegurghvvhhiugesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphhhihhl
    lhhiphdrfihoohguuddvfeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:PCMyZ3PoAI5tnLAdmr2Qc26z1xEDab-D-0yfD3aRDkDVyWrLUAC4Hg>
    <xmx:PSMyZ08Pgoe33_cUXwj1smDa9z0_sjvMFxsO5KDRhu11FcbbANRhgQ>
    <xmx:PSMyZ_Ua3KtBZ5ntLttqpFoabXcCrupkHgPP8d-Zwa9f3I-0IasGzw>
    <xmx:PSMyZ9cpaa-LbM7cqbTLnKq2TNKs-7Hdv2F73oa8EncAiNAuPA9Wbg>
    <xmx:PSMyZ4QNRrL6eLRyzNv8qgE_84sAOvfhlEXtuYEmWq3wBmQkfz1Nxk0C>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 10:31:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 804d451b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 15:30:32 +0000 (UTC)
Date: Mon, 11 Nov 2024 16:30:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Taylor Blau <me@ttaylorr.com>, David Aguilar <davvid@gmail.com>
Subject: [RFC PATCH v5 09/19] Makefile: refactor generators to be
 PWD-independent
Message-ID: <817d58cbaf9739e4621397bc989a3332cddff976.1731335939.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1731335938.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1731335938.git.ps@pks.im>

We have multiple scripts that generate headers from other data. All of
these scripts have the assumption built-in that they are executed in the
current source directory, which makes them a bit unwieldy to use during
out-of-tree builds.

Refactor them to instead take the source directory as well as the output
file as arguments.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                            |  6 ++---
 contrib/buildsystems/CMakeLists.txt | 19 ++++++-------
 generate-cmdlist.sh                 | 42 ++++++++++++++++++-----------
 generate-configlist.sh              | 20 ++++++++++----
 generate-hooklist.sh                | 15 ++++++++++-
 5 files changed, 68 insertions(+), 34 deletions(-)

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
index 689b76578ad..73a3cbf5302 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -648,23 +648,24 @@ set(EXCLUSION_PROGS_CACHE ${EXCLUSION_PROGS} CACHE STRING "Programs not built" F
 if(NOT EXISTS ${CMAKE_BINARY_DIR}/command-list.h OR NOT EXCLUSION_PROGS_CACHE STREQUAL EXCLUSION_PROGS)
 	list(REMOVE_ITEM EXCLUSION_PROGS empty)
 	message("Generating command-list.h")
-	execute_process(COMMAND ${SH_EXE} ${CMAKE_SOURCE_DIR}/generate-cmdlist.sh ${EXCLUSION_PROGS} command-list.txt
-			WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
-			OUTPUT_FILE ${CMAKE_BINARY_DIR}/command-list.h)
+	execute_process(COMMAND "${SH_EXE}" "${CMAKE_SOURCE_DIR}/generate-cmdlist.sh"
+				${EXCLUSION_PROGS}
+				"${CMAKE_SOURCE_DIR}"
+				"${CMAKE_BINARY_DIR}/command-list.h")
 endif()
 
 if(NOT EXISTS ${CMAKE_BINARY_DIR}/config-list.h)
 	message("Generating config-list.h")
-	execute_process(COMMAND ${SH_EXE} ${CMAKE_SOURCE_DIR}/generate-configlist.sh
-			WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
-			OUTPUT_FILE ${CMAKE_BINARY_DIR}/config-list.h)
+	execute_process(COMMAND "${SH_EXE}" "${CMAKE_SOURCE_DIR}/generate-configlist.sh"
+				"${CMAKE_SOURCE_DIR}"
+				"${CMAKE_BINARY_DIR}/config-list.h")
 endif()
 
 if(NOT EXISTS ${CMAKE_BINARY_DIR}/hook-list.h)
 	message("Generating hook-list.h")
-	execute_process(COMMAND ${SH_EXE} ${CMAKE_SOURCE_DIR}/generate-hooklist.sh
-			WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
-			OUTPUT_FILE ${CMAKE_BINARY_DIR}/hook-list.h)
+	execute_process(COMMAND "${SH_EXE}" ${CMAKE_SOURCE_DIR}/generate-hooklist.sh
+				"${CMAKE_SOURCE_DIR}"
+				"${CMAKE_BINARY_DIR}/hook-list.h")
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
2.47.0.229.g8f8d6eee53.dirty

