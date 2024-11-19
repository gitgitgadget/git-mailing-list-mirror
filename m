Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DE71CC17A
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 11:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732017070; cv=none; b=prhr2UBkaW9lBsNumQ9l0HL/Ul/jK7gQkqDqnhkmd9Jt/ZaZK4eHkKA+4jL1w4EuaH14tBiCr8Jj6juo2+128w4f+2RpcArTS2N4IDtwzko7LWntOn4sgHuOfuAg/jlpXiucZcPFhUcMnxaBPvzibd5Q7jq+HABNP5QQYJuHUow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732017070; c=relaxed/simple;
	bh=l0UqwohMxLy2IU6azV3PHFn+NkjwutTGEPX7donBKNM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Et7ElDyxZnx9TaofnA7sN4T+9b5Jz2gSbpuv60E3qEgel1Q6pQFxvp3M/2ykcbEfcsIHo0Ie4n2v6wlsJAnSOU18b9nS9Cp0Ot766fDsXNRNQ+Iepg8F+8HtyciAT6ZdqFu7JeOPd7HVuwqvoYm9+IrX7+BigI6OEXPn7ZqnaGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bJWnD5RD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KlRsowtX; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bJWnD5RD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KlRsowtX"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5C36011400FE;
	Tue, 19 Nov 2024 06:51:08 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 19 Nov 2024 06:51:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1732017068;
	 x=1732103468; bh=Ggz/XkdwIU31xOt1z/WMpVKQTRIO9YW5nCDeYg2LbnQ=; b=
	bJWnD5RD9i+A92Bcz3Vw8ZEq+YpfeOEAAmXKBFv/3Z3guMo6Mx4SSw9h2+abuyfk
	1hH7QPEUBB/fnFZZ0GoJVgspbXL/yfgmGaoO/w8jl2LFhSt/OLDlyxIdwv7Mp4R9
	7Ol9e15sQLsehiliykzI18nc7zE9jlfuqdQ5WIQIU+dyD02J+4LaL9WBA3N9CfHI
	+lfiUDBYmjV/Clw3deYMRuJkUySF3hXsfdha5+iTSM4ZtYFSERmOg/udKkIWaFf6
	q3N1JRv7UxmbVEe6wzIfC2RDeVxFZAc5feFq+ShPjy3Rm5IOPjBC5tmc/or6Up71
	CfxFfmFxQQ7UuGb3q04ZnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1732017068; x=
	1732103468; bh=Ggz/XkdwIU31xOt1z/WMpVKQTRIO9YW5nCDeYg2LbnQ=; b=K
	lRsowtXyf4el6wmvB501BEvh8TlLdvnp//DwnToch0os94xz8nwIN8ltAkrYqATR
	EyEW/BENIxFnCSUCxoTtaez3qpBz5gG3PoMdrlcPcVdopIdXKYjw2OoOFUzoeWi1
	1DZtYKH0JuRXcPeBSk27cJ27LAOuDOBgogW6UdZxiFPMfGfQf8sUp5TG0Vmb6gOX
	o9Cbcs7d4cfsYzy1WRqUTwxu1CLvJ5NZ3GWmko77fuaWmECEd7e4R2hVhqDTWOPu
	ER1FEXWDdfrLixqeyVmA2TPKTjOdNU5GSwgd6aYXjEtgRYSr2z/io4wuUm7XuiAT
	3weyt7/isZFINlkvaSNpw==
X-ME-Sender: <xms:rHs8ZzJPtKcbAcjhgu4T1GiKz41yHX0_O0A7nT3JhTPaWFTNH6pcKw>
    <xme:rHs8Z3LA-gxhDOpe__neOOpuM9dit33Zeh-G7t3VJXoeU6ELffeZMb7ZRcJSI225-
    M4IuKw-p3T4LWOVVA>
X-ME-Received: <xmr:rHs8Z7u0Igz93dDX3xo3Q7lencWbTZ2F4tEz1BZ-dXuOBUk1BiSMCSzF8fZWleqVKpFP_2h3dK2Eh3VZH-fzQUwf5X-tJx_GUHImLrfm5mQX07c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedvgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtgho
    mhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
    dprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepuggrvhhv
    ihgusehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjoh
    hnvghsrdhplhhushdrtghomh
X-ME-Proxy: <xmx:rHs8Z8ZhbmSyEQC8XABf6iAaO6fY9D9JvUiN9UO_9xscrqR-Gby0mQ>
    <xmx:rHs8Z6ZJowFxRn-cQdccrFak2_i3FgAxdlmBK6r5_NhLRWv723FSgQ>
    <xmx:rHs8ZwAcoMCN4uFfeOVIomLcSFkt-pyCNxHzCD4h-I1qy-gE3oA5lQ>
    <xmx:rHs8Z4Z98R9fWOWkUMCDJ_jAPZ4ZUoxG8AYT4LNH_xF0yIg0p5Op7g>
    <xmx:rHs8Z8AudRcwLdE8uwL4w-cM4R_m4ILCUdZVN2XxG_lvXXDzXCnJU_s7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Nov 2024 06:51:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1eca7087 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 19 Nov 2024 11:50:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 Nov 2024 12:50:50 +0100
Subject: [PATCH v8 13/23] Makefile: refactor generators to be
 PWD-independent
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-pks-meson-v8-13-809bf7f042f3@pks.im>
References: <20241119-pks-meson-v8-0-809bf7f042f3@pks.im>
In-Reply-To: <20241119-pks-meson-v8-0-809bf7f042f3@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>, 
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>, 
 Christian Couder <chriscool@tuxfamily.org>
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
index 0d40dbdffa06311c2727f9ed47a730b772a7e684..0417adbbbb5be9e8b3f45a468faa059a40f2ddea 100644
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
index 7121fdfbc2ba50b4c7afb3f2b45fdaa5b9909a60..be1ce1f37a775c366098717047cd7579cd81015d 100644
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
index 8692fe5cf4d5e4025265e6110254b05640615fea..512804a1ca1b63a0630ae152569b31486273eae0 100755
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
index 2f9f54eb545be2bd79c37a868dbeef96d2ddfb9f..0ff2a0b6fbd16772de1f88cad36af8185892bb47 100755
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
2.47.0.274.g962d0b743d.dirty

