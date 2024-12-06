Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58682207DE8
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 13:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733491527; cv=none; b=XKIBlZuY2EKlQ9uDTt0MpvlOE677LkxPi0UsOhYZT3mi1+PFJPf31GQqNFhPLQMQPWU8H1JN2EvaEq4OKIwkBPAjqjINzLjLsoJojoXAc/IC7ICwFXZhw9LoCbnc6YIP+kMhuoNXw7h/lCZ10AkmVdTLR1Jq4gfEoxiwCKB6nO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733491527; c=relaxed/simple;
	bh=NoEHc40DcstxImklx/YY6l8Kg4zaJZuJvkDdRbqT9CQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uIyc24avwp9sUXRcJI72BhqVVzBAwWMhZoQTk+eBTnoT5fRE3dSG9yDryf+54tfC1EjhWZveSC5wJgypOjJmQ9ZgBY0G90CI8cRkd9iw8XpHeFF9qiH2wJSeQV/ptjJffh1FA1ox7zCSMSsUnB69OomXDLpeHAjbW26E2XpC04A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nG4fcURK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=StbtD7if; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nG4fcURK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="StbtD7if"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 4F7DA11401AA;
	Fri,  6 Dec 2024 08:25:24 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 06 Dec 2024 08:25:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733491524;
	 x=1733577924; bh=4r7dyuzYuuRcnwc9B54WQv5ZA1qnMJNK5Y4GKKo2Res=; b=
	nG4fcURKHbk5Tt7/cdyazUVpc30XYaNwe2VmXfwN9kyX8uUx2czFRTh09Gh8j71r
	b9wuQk/65cAO55OdMP2WoPunUEBjbaWOaga9lpMdlF9IH+dWfOJRQVpLbN+T0I+5
	2DVdmRHKrC4idFRevm1IlS+eZumU7h5bJTYLn5ZRUOfgH/vLlbciBCvUK/tbO6So
	6JyHX+LRpcNH8qRtec+nVIEjbUdC0J7a4gEYiMztX0T5eDrwdXB4CDrfdy6C8033
	OkWdyuAMmyKbsRR4+hFAO/zXB9aZOKELZQ1+aDFKBcWG4VJ2r89joLRgcB/SMMvO
	703UVjEseAKxaiMkDeUEhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733491524; x=
	1733577924; bh=4r7dyuzYuuRcnwc9B54WQv5ZA1qnMJNK5Y4GKKo2Res=; b=S
	tbtD7if6yT3CrDCWO0lXF3MBann95EcTEOV7oY8gd9eIQtuplMu0/ZywGZqm0Dyw
	vJ88wt4e/XInOfcfnBLmB5iOViagnYRyLQ/kTttvLkBkPQCYQv7UUbVbjEnkzBGw
	Jq47A4qQspZqEcIJR3Vy6FFIRLJulWIaFSVhERAqKIXBbrLzNV0vvgbg9v9sR9st
	3GCLqMrO4v9V+pHNia3EPPvAfCUVKOdInXxcCeQiQ941cJgUXIPZGg7CxkAo6hrM
	nc+SKfUq/GPGbNuwxe9GNh0DFGGGxi7l+zqzluXxyyEcMZNHYGsOlVDJEL0xga9Q
	8VVHa5VyMz5MAyPmRDtpw==
X-ME-Sender: <xms:Q_tSZ44VDvRBdizK7jXqdHca7LW-JVAROSkrD-WC0pMVQUcnrdl1fg>
    <xme:Q_tSZ57dOtyCYFHssu5C1CV3ItM9rGVuDqvMayFlTw2QMdVUkL2-3O6Igg1yfGG0Y
    QU7ou3lmZfc104Xhw>
X-ME-Received: <xmr:Q_tSZ3eoNPEXm9kMO9VholE6j1ExwzrLW8uDZGgTAS3iXsY7CNA9u-M3RCflFoqMS6iW0VaDf82UyMbnZkVvF6uf4w_VRCZUw46ie9Vw-ZxZJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepgeduhefhvddujeeguefgjeelvddtfeeiueffleeigfeg
    ffeltdelieekueegjeevnecuffhomhgrihhnpehgihhtfhhorhifihhnughofihsrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhs
    sehpkhhsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhu
    nhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehpvghffhesph
    gvfhhfrdhnvghtpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhp
    lhhushdrtghomhdprhgtphhtthhopegurghvvhhiugesghhmrghilhdrtghomhdprhgtph
    htthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopegvshgthhifrghrthiisehg
    vghnthhoohdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Q_tSZ9IQXsdVFm3zFCUYVnto2dSws3JaACZzExnG6FFH2v9hJXBm1g>
    <xmx:Q_tSZ8KZBUA7aeTTS12ltgr64TYkhPcxmsJfbjTyl_PxZeChdy8Wxg>
    <xmx:Q_tSZ-xfRcYyJaAxp2SNLPd4kw2iIWzoTv1B05_dpG4gBa07esRwZA>
    <xmx:Q_tSZwJx5UfMReclZSuilpF9B8hMpByp9xvKTS0SIpglo1PPUxEzEw>
    <xmx:RPtSZ6xF4xdVcz0AzcsqoZHq4mLXn8S0hYyzNGXcq-6u7hVcSRnKfyO_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 08:25:21 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a9085aae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Dec 2024 13:23:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Dec 2024 14:24:38 +0100
Subject: [PATCH v11 03/26] Makefile: refactor GIT-VERSION-GEN to be
 reusable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-pks-meson-v11-3-525ed4792b88@pks.im>
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
index 45c38088535fbb10fae7ea17eda44bd6fb6c91aa..a529df85ad4c68f6db981c8dc05540e9e4991995 100644
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

