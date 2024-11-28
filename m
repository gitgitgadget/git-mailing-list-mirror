Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4972D1BF80C
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 16:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732810352; cv=none; b=hGgiDsvAe2904M7ailykA6Y7Yt+JxPz/pUY04+kGv4RMUzKPzeaWWk50TSdkBhK7pvVcK+KGZCLmSnRrWUkf/VDFsFqmC2kEqyiuR73Ab80zhrHlFQJBc0jKP5NJ7onB6hU8ez0SIjFw7aeOemBNEzPKcXAObRAnolksmRypYaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732810352; c=relaxed/simple;
	bh=NeVncDrAUq30rUZVQ+AKQUFY8/JFa27XZstMsmCIQx8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TLBvr8fLTfJ4CPjsH7jL582yZuQOG4bEJNMImDvZ8T32lRB5wXmKkik8W1jWs/QnHDf6OgbuXpQicedxJhsYrn6yl8lGgQitEQPSD8nzOUfELaz/bbTlYOU9m02VWC7uA4hKDluMY0G93eMN79Bk0zpB+P1nPJQIAuNuWhMoL1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=xAeom6fw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2cBnQNeh; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="xAeom6fw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2cBnQNeh"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5C39F1140136;
	Thu, 28 Nov 2024 11:12:29 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 28 Nov 2024 11:12:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732810349;
	 x=1732896749; bh=JOs0HN82A1BE3uwzNWBjy5+mfI5R0vxVCJTAro66I7s=; b=
	xAeom6fwwsH4Jlp+YYhArvhRiLb5J/NsUIfblBDHFxynzBiqzxquZR1OIe+oI4Kv
	tHi0fK9mE1EjpKmN6DPENB7tH0Qs5tB9e/SsJd2hu4PfvISd8jzfEjosCoubuwyx
	6KwfYsSYaw6S3PwKx7ez8UyiEJZVpBs05uKh+M7nYsf7j7GyROGwqwG0L3JDTgOK
	jw0jniPKm7KKItk4V1hUVbdp3wbqn8lAOx4bnZA+XWykK1LCHQecFK+ANPPjTVh1
	WaN5W0UHJB68FOlINJ7ECHFcWjKGFMQrmx2t6520TF1KnqmpeYcc2AueIDY+JkCD
	YoBBASYBSPQFfrMkXKMMog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732810349; x=
	1732896749; bh=JOs0HN82A1BE3uwzNWBjy5+mfI5R0vxVCJTAro66I7s=; b=2
	cBnQNehZsv9k2VSU96AWE+NXEKLhwhuLyW2/eRUmjOnyBgRHH418yRrW0CgmYxFL
	+D8CCooaX4XVSDlgCVa01ShBHCCPPjj/1yNaR2eRSQTCL6WB7xHvsgzgqNdFrEDD
	ghbUQdhRO9DXA7NMKEEzME8LRVaKNZGJIuBVaS6byqJOMxa3H5kUx/ZkW8zuSvKt
	j2hXcoLkm7NiIq3sXy6LmJ/A1znuxt6FS7zy6di/rwUaSwtnyyLOvbEWgAIonvHG
	NcM5zRTZ5QaWfKBiP8+WEiZinX3tSqtknJtW+JgW0Ts8JETpFH6ZobhKgInfHW8N
	Fi/THVj3yDYjJC2Ao0/6Q==
X-ME-Sender: <xms:bJZIZy5Ahfe_TB_67EVkSFyKMm-i-k7GINCbp_D6MP9xfWjDeyr38w>
    <xme:bJZIZ77Dw3FuXSBlSxERRMCOupt3UNyTE4Z0kfD86HI-R_q0pHgifgMcebb-PXPJ6
    pOBfNvnxhyb22-JNw>
X-ME-Received: <xmr:bJZIZxdkv4Ck0_2wr-pq3giEurkGbRfPxTLBqIW7TWwoz2odEs7b4OxMnydK0FLms7z7EK8j53A6Yfn3k2IBJEnmiYar3UOuwNOkCITtgPncQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedugdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepgeduhefhvddujeeguefgjeelvddtfeeiueffleeigfeg
    ffeltdelieekueegjeevnecuffhomhgrihhnpehgihhtfhhorhifihhnughofihsrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhs
    sehpkhhsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhr
    tghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehmvgesthhtrgihlh
    horhhrrdgtohhmpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohep
    shhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopegvshgthh
    ifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhg
X-ME-Proxy: <xmx:bJZIZ_KzgUGounJyj2r4RkTdJ9NHVzTsLKPw40FOGOGGR0W7HvdV3Q>
    <xmx:bJZIZ2LOQGcNhZKFby8MsQ5XZK3ez70dFPkJ4IDYkj6BLWzztYRgnQ>
    <xmx:bJZIZwyIQu8VlXBBdVrliy1QwUDRxF2oXbrSkqvMq5oSTRMU2hY5zg>
    <xmx:bJZIZ6JGPOvsDE68_2BpSBP1BvwvQd9bjRYwaCqUR-sV498GeZJ4ww>
    <xmx:bZZIZ8y1-qimFFKBapspvo1tMlUBAS4fUn8PEPxKQcHcIgew7_A5PRKn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Nov 2024 11:12:26 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9f0c1544 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Nov 2024 16:11:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 28 Nov 2024 17:12:04 +0100
Subject: [PATCH v10 03/23] Makefile: refactor GIT-VERSION-GEN to be
 reusable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241128-pks-meson-v10-3-79a3fb0cb3a6@pks.im>
References: <20241128-pks-meson-v10-0-79a3fb0cb3a6@pks.im>
In-Reply-To: <20241128-pks-meson-v10-0-79a3fb0cb3a6@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>, 
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>, 
 Johannes Sixt <j6t@kdbg.org>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Our "GIT-VERSION-GEN" script always writes the "GIT-VERSION-FILE" into
the current directory, where the expectation is that it should exist in
the source directory. But other build systems that support out-of-tree
builds may not want to do that to keep the source directory pristine,
even though CMake currently doesn't care.

Refactor the script such that it won't write the "GIT-VERSION-FILE"
directly anymore, but instead knows to replace @PLACEHOLDERS@ in an
arbitrary input file. This allows us to simplify the logic in CMake to
determine the project version, but can also be reused later on in order
to generate other files that need to contain version information like
our "git.rc" file.

While at it, change the format of the version file by removing the
spaces around the equals sign. Like this we can continue to include the
file in our Makefiles, but can also start to source it in shell scripts
in subsequent steps.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 GIT-VERSION-FILE.in                 |  1 +
 GIT-VERSION-GEN                     | 61 ++++++++++++++++++++++++++++---------
 Makefile                            |  5 ++-
 ci/test-documentation.sh            |  2 +-
 contrib/buildsystems/CMakeLists.txt | 23 ++++----------
 contrib/buildsystems/git-version.in |  1 +
 6 files changed, 59 insertions(+), 34 deletions(-)

diff --git a/GIT-VERSION-FILE.in b/GIT-VERSION-FILE.in
new file mode 100644
index 0000000000000000000000000000000000000000..3789a48a34a3f9e37531fc24b577ffe3c657a3e9
--- /dev/null
+++ b/GIT-VERSION-FILE.in
@@ -0,0 +1 @@
+GIT_VERSION=@GIT_VERSION@
diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 78e8631f677bbebe8f18d83191f0fd014465563e..7afc7aad1413d552cbadc68b7582ba639faa4d8a 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -1,23 +1,48 @@
 #!/bin/sh
 
-GVF=GIT-VERSION-FILE
 DEF_VER=v2.47.GIT
 
 LF='
 '
 
+if test "$#" -ne 3
+then
+    echo >&2 "USAGE: $0 <SOURCE_DIR> <INPUT> <OUTPUT>"
+    exit 1
+fi
+
+SOURCE_DIR="$1"
+INPUT="$2"
+OUTPUT="$3"
+
+if ! test -f "$INPUT"
+then
+	echo >&2 "Input is not a file: $INPUT"
+	exit 1
+fi
+
+# Protect us from reading Git version information outside of the Git directory
+# in case it is not a repository itself, but embedded in an unrelated
+# repository.
+GIT_CEILING_DIRECTORIES="$SOURCE_DIR/.."
+export GIT_CEILING_DIRECTORIES
+
 # First see if there is a version file (included in release tarballs),
 # then try git-describe, then default.
-if test -f version
+if test -f "$SOURCE_DIR"/version
 then
-	VN=$(cat version) || VN="$DEF_VER"
-elif { test -d "${GIT_DIR:-.git}" || test -f .git; } &&
-	VN=$(git describe --match "v[0-9]*" HEAD 2>/dev/null) &&
+	VN=$(cat "$SOURCE_DIR"/version) || VN="$DEF_VER"
+elif {
+		test -d "$SOURCE_DIR/.git" ||
+		test -d "${GIT_DIR:-.git}" ||
+		test -f "$SOURCE_DIR"/.git;
+	} &&
+	VN=$(git -C "$SOURCE_DIR" describe --match "v[0-9]*" HEAD 2>/dev/null) &&
 	case "$VN" in
 	*$LF*) (exit 1) ;;
 	v[0-9]*)
-		git update-index -q --refresh
-		test -z "$(git diff-index --name-only HEAD --)" ||
+		git -C "$SOURCE_DIR" update-index -q --refresh
+		test -z "$(git -C "$SOURCE_DIR" diff-index --name-only HEAD --)" ||
 		VN="$VN-dirty" ;;
 	esac
 then
@@ -26,15 +51,21 @@ else
 	VN="$DEF_VER"
 fi
 
-VN=$(expr "$VN" : v*'\(.*\)')
+GIT_VERSION=$(expr "$VN" : v*'\(.*\)')
+
+read GIT_MAJOR_VERSION GIT_MINOR_VERSION GIT_MICRO_VERSION trailing <<EOF
+$(echo "$GIT_VERSION" 0 0 0 | tr '.a-zA-Z-' ' ')
+EOF
+
+sed -e "s|@GIT_VERSION@|$GIT_VERSION|" \
+	-e "s|@GIT_MAJOR_VERSION@|$GIT_MAJOR_VERSION|" \
+	-e "s|@GIT_MINOR_VERSION@|$GIT_MINOR_VERSION|" \
+	-e "s|@GIT_MICRO_VERSION@|$GIT_MICRO_VERSION|" \
+	"$INPUT" >"$OUTPUT"+
 
-if test -r $GVF
+if ! test -f "$OUTPUT" || ! cmp "$OUTPUT"+ "$OUTPUT" >/dev/null
 then
-	VC=$(sed -e 's/^GIT_VERSION = //' <$GVF)
+	mv "$OUTPUT"+ "$OUTPUT"
 else
-	VC=unset
+	rm "$OUTPUT"+
 fi
-test "$VN" = "$VC" || {
-	echo >&2 "GIT_VERSION = $VN"
-	echo "GIT_VERSION = $VN" >$GVF
-}
diff --git a/Makefile b/Makefile
index 75e26d2e312f186bd5a0e3b48fb38850613bca4b..73510d6bcbc9ca60d45b70459f9e1c79f19b4c09 100644
--- a/Makefile
+++ b/Makefile
@@ -592,7 +592,10 @@ include shared.mak
 #        Disable -pedantic compilation.
 
 GIT-VERSION-FILE: FORCE
-	@$(SHELL_PATH) ./GIT-VERSION-GEN
+	@OLD=$$(cat $@ 2>/dev/null || :) && \
+	$(SHELL_PATH) ./GIT-VERSION-GEN "$(shell pwd)" GIT-VERSION-FILE.in $@ && \
+	NEW=$$(cat $@ 2>/dev/null || :) && \
+	if test "$$OLD" != "$$NEW"; then echo "$$NEW" >&2; fi
 -include GIT-VERSION-FILE
 
 # Set our default configuration.
diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
index 02b3af394117f840e078479ca60030141e47f998..6c018b673e0563fa5589195a77804c91deb93515 100755
--- a/ci/test-documentation.sh
+++ b/ci/test-documentation.sh
@@ -6,7 +6,7 @@
 . ${0%/*}/lib.sh
 
 filter_log () {
-	sed -e '/^GIT_VERSION = /d' \
+	sed -e '/^GIT_VERSION=/d' \
 	    -e "/constant Gem::ConfigMap is deprecated/d" \
 	    -e '/^    \* new asciidoc flags$/d' \
 	    -e '/stripped namespace before processing/d' \
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 1abf5f099c1c6735ae7aec345de96bf623e2aa18..376d748ce9021710eb72258ab3b9bac52950a933 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -83,23 +83,12 @@ if(NOT SH_EXE)
 			"On Windows, you can get it as part of 'Git for Windows' install at https://gitforwindows.org/")
 endif()
 
-#Create GIT-VERSION-FILE using GIT-VERSION-GEN
-if(NOT EXISTS ${CMAKE_SOURCE_DIR}/GIT-VERSION-FILE)
-	message("Generating GIT-VERSION-FILE")
-	execute_process(COMMAND ${SH_EXE} ${CMAKE_SOURCE_DIR}/GIT-VERSION-GEN
-		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})
-endif()
-
-#Parse GIT-VERSION-FILE to get the version
-file(STRINGS ${CMAKE_SOURCE_DIR}/GIT-VERSION-FILE git_version REGEX "GIT_VERSION = (.*)")
-string(REPLACE "GIT_VERSION = " "" git_version ${git_version})
-string(FIND ${git_version} "GIT" location)
-if(location EQUAL -1)
-	string(REGEX MATCH "[0-9]*\\.[0-9]*\\.[0-9]*" git_version ${git_version})
-else()
-	string(REGEX MATCH "[0-9]*\\.[0-9]*" git_version ${git_version})
-	string(APPEND git_version ".0") #for building from a snapshot
-endif()
+message("Generating Git version")
+execute_process(COMMAND ${SH_EXE} "${CMAKE_SOURCE_DIR}/GIT-VERSION-GEN"
+		"${CMAKE_SOURCE_DIR}"
+		"${CMAKE_SOURCE_DIR}/contrib/buildsystems/git-version.in"
+		"${CMAKE_BINARY_DIR}/git-version")
+file(STRINGS "${CMAKE_BINARY_DIR}/git-version" git_version)
 
 project(git
 	VERSION ${git_version}
diff --git a/contrib/buildsystems/git-version.in b/contrib/buildsystems/git-version.in
new file mode 100644
index 0000000000000000000000000000000000000000..9750505ae77685ebb31a38468caaf13501b6739d
--- /dev/null
+++ b/contrib/buildsystems/git-version.in
@@ -0,0 +1 @@
+@GIT_MAJOR_VERSION@.@GIT_MINOR_VERSION@.@GIT_MICRO_VERSION@

-- 
2.47.0.366.g5daf58cba8.dirty

