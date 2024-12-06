Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0A820D50C
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 13:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733491536; cv=none; b=ufM0RDK00tyuT09FIB+Hd4d/qG2MGG6OakvpAJw2nt2cz99HCJ1XeZqXIAbmvlC5Hqewtb9SJmHJSQiwXggwkgCPpMUvo6E0RB3mNDh9mwq+EjcjXP8z466E91X1KqxXpL3jWzD61iTB4H5fa/YXDrlhFWkl7BCWqKgiH7N2nN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733491536; c=relaxed/simple;
	bh=LFIuxnSXxwGsa1DrURxS8sckjs3WxHPp4awRbpm5i4I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B1zWh4Buo5ytdzA0HjnBglz9M9WrS+FUM5uf9RivPNOpPA/n+N9GXUlcD3G2S3L12z0I9VzjE4WB9kvjPsc1C7nIswv2PJdyyif2CYpCsgw0CMiLn9O0QKNtNA15kmBdM7Y++lPNfJ882NoTAuL5CLLNO+6gPCRoI06oPQ5r5cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LxQwORUr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1dvL709n; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LxQwORUr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1dvL709n"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id A91AF1140193;
	Fri,  6 Dec 2024 08:25:33 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 06 Dec 2024 08:25:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733491533;
	 x=1733577933; bh=sgBs2gNbsphTb4YDMeXsWC4qO/RykWCBfs+IHrACYoA=; b=
	LxQwORUrquRGiYTFdfxJD1HF2UAJ2JG6x6J5L+tuwdHv9AViG2//NycxXdgSjAGL
	i4sjJOHYIjgvpuuU9lAesP9hr3Ajis15Ptb2QH5mtq4nsY4wJHGi83K2q/6zWiG/
	0QkHbXhTltk0S3T1b88cDIXTQ0Ug6hzpTjWM1iZVuZ9Mj+DJvwIkRuoAvi/EgfAz
	tJnEFBYjS7HR6LwXQ/NTiSsO0kk7O7TASwq8cYdd/lIcXFE8xjcP19N/gHKDEqpj
	VGfXufEaHWWxH0BWY1Le7SgZeqSoC2oXsAjcqa4EZeA2vMGPSa5RkIO/BMLnk0kT
	3JBsrGY95UHOBzMu462pvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733491533; x=
	1733577933; bh=sgBs2gNbsphTb4YDMeXsWC4qO/RykWCBfs+IHrACYoA=; b=1
	dvL709n+5Zfov5jyRHd1Pqk3kYImL5nh5Qj2+EKCFVUh0tos+xyuu9JCa7iXNaSh
	HGE6H9qv1m4q+ZEHGs2FX4p7o3lfwzrelZX2+SWOfwJ7cMpLTapXJLVpIuONeHrh
	EaZ/+KXbHcAWJZwqTT7qmOzBD+6YCstGZ5kKkTod5F5XtJpx4qtn8UPVXa80GG8T
	v31nGUvctkGkcwAQjAUGdN5uvO5FSHX/qn9kPOTZ0dIfFadrwwbccNO/6Dq0nEUZ
	PASIMepDnjIGbQ9GHo+/wIsJtneH9IorsBbM66OjZZ9L/sQOjhDh28/lck35Ix4H
	TMLzwgQnxBSAsYSboC4Ug==
X-ME-Sender: <xms:TftSZ4mRJwvD7J2GRNh2LduqqbKPHXhBDnfgo8jeYKU13Nu45Qs8UQ>
    <xme:TftSZ30p3Iz9u0VSb48c-tHmKQ43mK1NkJHOlEmV1o0E39mEDlDJUYPklaj86iP6f
    VLSW7041H0LfcIqVQ>
X-ME-Received: <xmr:TftSZ2pQoGOCOaMXyTC50bTkVd7eyJA8nyAipOnoy3RBZrvWHrKJncF3w5a38yXIjFIXVQ7wK0Otw1BVWgAyzYMfVWJd-qFd7-8AhCrlL6Jtpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrd
    horhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdp
    rhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphgvfhhfse
    hpvghffhdrnhgvthdprhgtphhtthhopegurghvvhhiugesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrmh
    hsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopegvshgt
    hhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:TftSZ0nlHMbuWuOM5s2TSRApfva1FKzOGXc9ZLwRB2mQJjvRKkdHjg>
    <xmx:TftSZ2363DmB4Ceg8eJXWEm5lz3X9AjXcvpglVTuDnKjFpev6yQU1w>
    <xmx:TftSZ7sqdw_HU_5zQng3Tv6-RLsJCvVYu7AuLzXdV3Zos1qsMBpveQ>
    <xmx:TftSZyXFIqfITLp49FPWtTB8hdGUdWLY6sAnFo9CuxzeRl-lJTeZ7g>
    <xmx:TftSZzti6ZYPR-9JUUtGZRnJGqQni3etKhR_gBHZdVaaLiqVzKgrojDY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 08:25:31 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 066532eb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Dec 2024 13:24:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Dec 2024 14:24:49 +0100
Subject: [PATCH v11 14/26] Makefile: refactor generators to be
 PWD-independent
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-pks-meson-v11-14-525ed4792b88@pks.im>
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

We have multiple scripts that generate headers from other data. All of
these scripts have the assumption built-in that they are executed in the
current source directory, which makes them a bit unwieldy to use during
out-of-tree builds.

Refactor them to instead take the source directory as well as the output
file as arguments.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                            |  6 +++---
 contrib/buildsystems/CMakeLists.txt | 19 +++++++++--------
 generate-cmdlist.sh                 | 42 +++++++++++++++++++++++--------------
 generate-configlist.sh              | 20 +++++++++++++-----
 generate-hooklist.sh                | 15 ++++++++++++-
 5 files changed, 68 insertions(+), 34 deletions(-)

diff --git a/Makefile b/Makefile
index 32648a1c92d378820873c50fd799f7d4614395d7..884da0d42a1b7860364aae98216ad6e7134179c9 100644
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
index 93c865ee2bf0fc7eb42f21a2c015a2e1ea5cd737..e7bd45cbb68d1a313227cc6c335bba137d9d9458 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -638,23 +638,24 @@ set(EXCLUSION_PROGS_CACHE ${EXCLUSION_PROGS} CACHE STRING "Programs not built" F
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
index 205541e0f7f81b1df4061215ae34a2742a45475d..b923a5aab80dfa571a40a4f6fa3d860fcf8f8dd1 100755
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
index 8692fe5cf4d5e4025265e6110254b05640615fea..579422619cc777ff597523a4db81b99912aac3aa 100755
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
+	echo >&2 "USAGE: $0 <SOURCE_DIR> <OUTPUT>"
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
index 2f9f54eb545be2bd79c37a868dbeef96d2ddfb9f..e22068c2fa4139983d685fd3bcd78e3e2a52beb0 100755
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
+	echo >&2 "USAGE: $0 <SOURCE_DIR> <OUTPUT>"
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
2.47.0.366.g5daf58cba8.dirty

