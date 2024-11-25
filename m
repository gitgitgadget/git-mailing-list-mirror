Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B87B197A7E
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 09:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528648; cv=none; b=s0nfmZ0qsg4uHLFgqIW7cqSeqr+ivndXj8fCc6c2E98ONNT30MG5FfH6N8rFucU3xNNXfvaITXQECE+OJAlc6ypD53yAcouD2W7afs+qIuxxyUoaCo3XMtkvio9Lm9JTI4+xrxnlVVxA8aHqiR+tS4z84HNrtowcZljiHU6gUuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528648; c=relaxed/simple;
	bh=ZQJM1VygZgXRoXDqzniweJAjc0cJyg4lUo6+9KOZ4fw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o5Yd+gNdCAXZz4dWj5U2dy99sFB6ajpkG8o4KSDM5iPzRt1ozbhb59Bk632WkmFCgZ0pMhgUxHdAU0YCNjp2rgiRBO/8X6D24ocDTniHCI6LgMKvMZFkFS6MBrnHCtR522ENdfFvRZxs0rrAxnH9lV1kjAYpGS3FQEjKJV+Vhf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fFNDoOAm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jZPxz10z; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fFNDoOAm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jZPxz10z"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 7264C114015C;
	Mon, 25 Nov 2024 04:57:25 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 25 Nov 2024 04:57:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732528645;
	 x=1732615045; bh=xR+Tn02Oaxr695TQyQE5n5qOwwjyOAbQ1KI+5CLEtIQ=; b=
	fFNDoOAmJGZT3Zvio7xkh+oAreKwwE9OT4FYTsHnMVIW2Giy7467bSWSb8eKrHOX
	Y9eo+bMb02fPd5q7vsIxoqZIwYRkxEV9gukk4ZOLPXQ74IkEYnpYk4zbVL0f422p
	5S8FwugpgwdeflqbXW57/9r+6zNgqabjzx+VHmqt4sU3VezSvhSyzNhhAjQ9u0Tx
	iKBD3xS14TYoBo3PCpgRdlpzXjWGW3oC2eP7tODITdbPb9UkyWRSB7LZGgKdnOTy
	GKmRJriO/kD8IzimQofr0JyPFju49k7ca2kxAupu4t6IYPc7kHktuDtb7xP82sj7
	LSqhTAZR9n+CeOBX/HdIjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732528645; x=
	1732615045; bh=xR+Tn02Oaxr695TQyQE5n5qOwwjyOAbQ1KI+5CLEtIQ=; b=j
	ZPxz10zDCEPnC2hEFFnPVvRMq28Vy23+Hqzi7kI7y6S3xatR1CJCaZWbgxZ2DJ9c
	sCAOpFJsBTjCkyKdCuuYw0Nfdok6ReocjZM2ZG/C0AdIiSJLzdONhd9Nr/HCqxMR
	cfI5TcF7vbSBb53MgjUdaQurThzKlLxp/faL8k20MaeOnGU+4xptOKS6/Y3c9+r+
	PBNMkZkB4LyVNmqynXAJVGhRdwZBBJ8ATAd+N6v0WLl8O3jXj58Q5SIje2drIrTT
	E40t5a2NKw1h+o+iTelIK6XgHd4yF0DynikYtgJlEsggxQiOtVw7kvfhiTSF4ZQ+
	sDEq4je0b/bh1XIlBitxw==
X-ME-Sender: <xms:BUpEZ5eH2ZY1R9-P1N-sNAQCkfwdV_dx5D541fP33M4gSPRikHY3FQ>
    <xme:BUpEZ3OBmuPDPTY_tDXr6lH6Jmrvp8usfDpplJ-xjmNRTG4CqZfDtEtiht3ofwOHu
    Hv1vjjHH5heqCCchA>
X-ME-Received: <xmr:BUpEZyjIesD9F8YcJAeIYJtbu65_dDto8KcW7hlryN4ynN7ToY8Y_9uspTePTl2iCNVjPVgWpBns_CnYUrOGzJQB1LVIBtVcUAXlx4keG08HUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeehgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrih
    hlrdgtohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhi
    nhgvtghordgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthho
    pegurghvvhhiugesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorh
    hrrdgtohhm
X-ME-Proxy: <xmx:BUpEZy-V3r0yQ5VXgck0fVcU6i4tfEqRO8xOwz93UIYXduMsfz2s2w>
    <xmx:BUpEZ1uDZVfJ1N0nCkYbbgsaRZcM8Qhq-mN4ivQ7eNpVHU693oQP-Q>
    <xmx:BUpEZxFMB-1VKsiO_tkG4muZ9P8VOtj6xF3juaxDOdK7SdjcxeVZIw>
    <xmx:BUpEZ8M6vMp8Redh7Pv4-sWrZVQWd-hwUI09yqgz7EXLXchXtd_aRw>
    <xmx:BUpEZxGFvFMSkT1P7ouaffp3PiGEN8kZLUzYpW9CHnC1wsGJi-91fVtj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 04:57:23 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c5554f77 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 09:56:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 25 Nov 2024 10:57:01 +0100
Subject: [PATCH v9 13/23] Makefile: refactor generators to be
 PWD-independent
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-pks-meson-v9-13-1c6cf242a5f1@pks.im>
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
index c898720861b6aad04610b43b33244234dafaee4d..61639d17dc364acf30ffd2d317015d8db440acc1 100644
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
index defdd958bb64906489482b77752b1a137282824f..de2c24e66b5b94e18368aba576fc11418e2aa049 100644
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
2.47.0.274.g962d0b743d.dirty

