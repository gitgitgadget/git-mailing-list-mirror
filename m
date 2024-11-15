Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5B8186E26
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 07:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731655301; cv=none; b=IhBv+m9nNT8KEpeONTX8MDV/Ir0c0Jfcu4dkXl1I42MzDbIECXhhP4li8yHGN4vfnrLapUSiGJilLhG4mJz6ngPZLT0A0wr3eKQj2NAWhec7R0V3R2qGpH6HTTaYZ5S9Ulg4IcnTw/rD8Y/5xgKeRHdY2V5L42xyZWbDamC+ias=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731655301; c=relaxed/simple;
	bh=/HcMMnRgJfx7dLt0IAipc1N0A5t42CYYLJ9y5SPQEuM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h+aypPOjMvCwZ3E/EFikuRAkcrUH7WM9p2oh2Nt9XRC6NQ/DWgV9rPXymRJmakU0WrV6T6TNZkBsC6S8kYxL4U+RocgFDSHV+NM1wzhG/Vkzg2Lfvgl5q2UXvdVUHMaAAyWwk8gsRcMO86F8mtOvbc2eyMzsTSIOZlxKUE8bPqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W/6wjw9s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hyh8juAH; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W/6wjw9s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hyh8juAH"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 8FC12138052D;
	Fri, 15 Nov 2024 02:21:38 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 15 Nov 2024 02:21:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731655298;
	 x=1731741698; bh=XoSvYJKJeYQufp8hI+5wyxYrdSHhy2K6E6O6jA1ND2Y=; b=
	W/6wjw9s7s8BmpNBwdhNNceCvnk2Bo+7KPqpT+6/m7WgIE+4I77RWbvgurGLtrEi
	Yzsa+0nHuGdgX/xnCZclvKfPKANKSLeYq0Q2Lt76srOkPgsF/H101uzktvycqjnY
	jOIsVRkBMUuLyhLc4wnuBYSR912VR5iQmp7PPBKPa+7+xg6EncVpHFIfsLt+/HBz
	JZH3hkWaYrUOyufE+At1XY1A+1MfL4B4QumpGEqkLINFg4RyLsc6OC/CnQLjSfV5
	xjn1LFTvL1SmJRWZCGURjJ4cbnZsJH8u8QZecI7eLQMCrHqBgTkxWf787vE7sHpA
	HO0/gJCLcRlyWdcXiBR89g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731655298; x=
	1731741698; bh=XoSvYJKJeYQufp8hI+5wyxYrdSHhy2K6E6O6jA1ND2Y=; b=h
	yh8juAHJobhRLVVuyIzCDH/w+2Li9g5tMXx3j3OHDZmc2MguQ1PbdNJIl7C8rOIg
	hnujLIvw92Kbo2Vzbjb4kst8tP9YUv5SSAK91nEpvFX/FkVIO5q/FsRt+O7/9isw
	/pi6GyND1A2pmaGD0YlH/F9tobeZsWVvpnWrrHdIeJjOw5bHPylDFhnlBtNkY49P
	r/QyjfuPIXVLFKoR89fJEq/oARiTLlA0IQNQOQ+5x9WlmCPZuGktg2zxUDebZGIp
	tu+qFNCAO4Oik8NW+nLn1KH9fMKnT4/yPmVKeFuIO1waHv8gZs+8QEyb+LcJEYsH
	AEKP8q+5nlPIDv6e7paGA==
X-ME-Sender: <xms:gvY2ZxBGlIWMneWhGgrayKJEgOc6mMAGLi67K7OrzFjunHrkCnkCZQ>
    <xme:gvY2Z_hQytVs9j-RN0T8zSm_tnqVrxNwDKd3peGgpJr2OprnY-tW97x71u_M_RS9y
    oMqMrjagIWxZpR6dQ>
X-ME-Received: <xmr:gvY2Z8mh43dqfrLOTN4kDW4Ovc6QSywlPf8GkQ7EnqAXCH5bTwgq5E21TYFeaxgwer1QLAwo5_l7daUBUPZv3B96Jq3e0g2jHPwV3_7o6yHOQ_Y37w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdefgddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeegudehhfdvudejgeeugfejledvtdefieeuffeliefg
    geffledtleeikeeugeejveenucffohhmrghinhepghhithhfohhrfihinhguohifshdroh
    hrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehp
    shesphhkshdrihhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgt
    phhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsuhhnshhhihhnvges
    shhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtg
    homhdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgt
    ohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpth
    htohepuggrvhhvihgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghf
    fhdrnhgvth
X-ME-Proxy: <xmx:gvY2Z7zkdUfjcLXONh6-Cxho76krbiYd51lxu61EnRGJWtyk1I-WUg>
    <xmx:gvY2Z2QQR3o7FzVz14RU2eTxvlfcij6UNM5bMKix-L1AkT-77CBisg>
    <xmx:gvY2Z-ZuEj53gcT1HfiOUzbv7Ri_OplXUJmdykThyCBUsyL8UtfjbA>
    <xmx:gvY2Z3RtISA-qEenUVsT0ry9vt8i2TsKKmpQxMXDBscm3cm2ikBUzg>
    <xmx:gvY2Z7KD4heqKMg3kiNf8ycszmyFK7NXmVg0Da5FCMzH7aYEHe1eHSwC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Nov 2024 02:21:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5ea1e68b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 15 Nov 2024 07:20:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 15 Nov 2024 08:21:15 +0100
Subject: [PATCH RFC v7 03/22] Makefile: refactor GIT-VERSION-GEN to be
 reusable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-pks-meson-v7-3-47ec19b780b2@pks.im>
References: <20241115-pks-meson-v7-0-47ec19b780b2@pks.im>
In-Reply-To: <20241115-pks-meson-v7-0-47ec19b780b2@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>, 
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>, 
 Christian Couder <chriscool@tuxfamily.org>
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
in subsequent steps. Furthermore, we already start to replace some
placeholders that are not yet of relevance in this commit. These are
going to become relevant in subsequent steps, as well.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 GIT-VERSION-FILE.in                 |  1 +
 GIT-VERSION-GEN                     | 62 ++++++++++++++++++++++++++++---------
 Makefile                            |  5 ++-
 ci/test-documentation.sh            |  2 +-
 contrib/buildsystems/CMakeLists.txt | 23 ++++----------
 contrib/buildsystems/git-version.in |  1 +
 6 files changed, 60 insertions(+), 34 deletions(-)

diff --git a/GIT-VERSION-FILE.in b/GIT-VERSION-FILE.in
new file mode 100644
index 0000000000000000000000000000000000000000..3789a48a34a3f9e37531fc24b577ffe3c657a3e9
--- /dev/null
+++ b/GIT-VERSION-FILE.in
@@ -0,0 +1 @@
+GIT_VERSION=@GIT_VERSION@
diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 78e8631f677bbebe8f18d83191f0fd014465563e..3a2dfd477b9b9c18ef34b33c9bf6a0d81b2740b5 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -1,23 +1,41 @@
 #!/bin/sh
 
-GVF=GIT-VERSION-FILE
 DEF_VER=v2.47.GIT
 
 LF='
 '
 
+if test "$#" -ne 3
+then
+    echo "USAGE: $0 <SOURCE_DIR> <INPUT> <OUTPUT>" >&2
+    exit 1
+fi
+
+SOURCE_DIR="$1"
+INPUT="$2"
+OUTPUT="$3"
+
+if ! test -f "$INPUT"
+then
+	echo "Input is not a file: $INPUT" >&2
+	exit 1
+fi
+
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
+elif { test -d "$SOURCE_DIR/.git" || test -d "${GIT_DIR:-.git}" || test -f "$SOURCE_DIR"/.git; } &&
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
@@ -26,15 +44,29 @@ else
 	VN="$DEF_VER"
 fi
 
-VN=$(expr "$VN" : v*'\(.*\)')
+GIT_BUILT_FROM_COMMIT=$(git -C "$SOURCE_DIR" rev-parse -q --verify HEAD 2>/dev/null)
+GIT_VERSION=$(expr "$VN" : v*'\(.*\)')
+if test -z "$GIT_USER_AGENT"
+then
+	GIT_USER_AGENT=git/$GIT_VERSION
+fi
+
+read GIT_MAJOR_VERSION GIT_MINOR_VERSION GIT_MICRO_VERSION GIT_PATCH_LEVEL trailing <<EOF
+$(echo "$GIT_VERSION" 0 0 0 0 | tr '.a-zA-Z-' ' ')
+EOF
+
+sed -e "s|@GIT_VERSION@|$GIT_VERSION|" \
+	-e "s|@GIT_MAJOR_VERSION@|$GIT_MAJOR_VERSION|" \
+	-e "s|@GIT_MINOR_VERSION@|$GIT_MINOR_VERSION|" \
+	-e "s|@GIT_MICRO_VERSION@|$GIT_MICRO_VERSION|" \
+	-e "s|@GIT_PATCH_LEVEL@|$GIT_PATCH_LEVEL|" \
+	-e "s|@GIT_USER_AGENT@|$GIT_USER_AGENT|" \
+	-e "s|@GIT_BUILT_FROM_COMMIT@|$GIT_BUILT_FROM_COMMIT|" \
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
index d59f6c16868e24a1e13b0c16cc05adb79f81bbc8..6c55c47e961047a8e9a80ab948e21c7466cf54de 100644
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
index 8b0020edeba289e5eaa15a5452013fa2e4c3ed33..752479cac59d3833e7fff9239ebea75179692bf4 100644
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
2.47.0.251.gb31fb630c0.dirty

