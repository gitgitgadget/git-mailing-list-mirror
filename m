Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC03A1CB52E
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 11:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732017064; cv=none; b=FiU15WXyGzLmMYPa2Xx20RFqca5XugNzm89jtvToHaQu9Gybmv/bEzrm6Eii11/yksnTir1CAuz2Mcqv5r5y63iSJ7RkDZY+VtiRAFm7N6DmXIhFiMMHljzHLUzc4Nxl9vejPUv2NJeb/qVO43uvf4aQIqfkz76vJtzb/FB/CiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732017064; c=relaxed/simple;
	bh=zsO7ScFsqMe0f+VMv1h9c6xNNC8MOTazt7OfQGcoxNs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cktiFWMyG3ZURh3gor74z9qFCym9Ho/zKRAUmyudBuu7lPArNEDmRCDMgpVVvzlS1GqcIvjOMeXmKH869X4D5MP7wEWlLNu7lX+qc41E7SCWKSwIAygU6BXW4ML8k02JjQRLWg0IHQMnqhy6gCEaE6F/2sl1XJWMzsozli4Fv0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iZB7l9RU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jgz3SMEd; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iZB7l9RU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jgz3SMEd"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id D6D51138020B;
	Tue, 19 Nov 2024 06:51:00 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 19 Nov 2024 06:51:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1732017060;
	 x=1732103460; bh=Xzfe+1thWhFyrKzgKIw7sNh+52tZhxdu2dNUwuD6zmM=; b=
	iZB7l9RUJP9cvFUysIExRdzD7mSgR3JRYAoCkQKZVs7jhYwY622m+jPBDmHrhnhi
	K0As6cD2o+BcZbrxJ0Poe6Q7VPkE65BIZqIJ1qMYZryzkpOyKJrfEHUevg0nfJ2k
	+wiEYLHAXMsRaxObiIx0XHGky+LtPdX6aCXLHHQTTzPJUyi0arpSpKnsTrhdNRlP
	D5bkZcdyxEkQj6kk8/IV+bPpxeWezliqeEZTyuQ08pBXHaUevImW3dmk20CeTgDZ
	ENyHFcNmna6yZ5R5uzr21HDgasgLcRCUoY0gyo3z+yLbOVJ6NLH3dpig2kS3iC2S
	d7djLxMNkv3c2WiCPrXYOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1732017060; x=
	1732103460; bh=Xzfe+1thWhFyrKzgKIw7sNh+52tZhxdu2dNUwuD6zmM=; b=J
	gz3SMEdBvqYmgMS5FA8uLxqXT51ikHAUXHYyxRlhAFb+SDNIjpv8RF7ABHA8r3L9
	AsMWVFvP0gBvtk9GpwZfTWYDF9wLqhtf8Ph8a5rCA2dgBTNPQH/it3G5BfDTPQQX
	u3aKH7H8g896ynfQDaroHA5RscjiYEo7FUiPRliUKSn9ZlFilMYGF/nZBtlzUfFm
	82u5iCrPMs4hO/2gyJBDIhFWHx9FSPl7+H3XQTUR+4MRqqTAJMMbNfm5sJ1fQZ/S
	F6FrmDwNaLC7Fq198mLe2DvoYnGHHbl8C+Xd5kHsEYGUEsM1z+Kcv9snboR9HHKc
	DwSm3LKh54lY3sVZUtkow==
X-ME-Sender: <xms:pHs8Z9BDrIlIgOUYpH8SVYjUMUUdW6EM4DT7gKxu_PltMMMJDlpVcg>
    <xme:pHs8Z7jb-44C-MHzbMYEWMfbqPpSAAjQlU-TfQ1R0ulwX8iAlsowKOInbO7NiRzhi
    NQvF8imURA7VQnQcQ>
X-ME-Received: <xmr:pHs8Z4k1pD3DBmnixBOqhXeA0m2ba-HuQCCJjvXIqH18HiHhfi_xg0TzwKPYePG29_zkelVqpCYnRmhw2FIbEVVpC04A0vjNnWvLjKikDyH3WhA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedvgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepgeduhefhvddujeeguefgjeelvddtfeeiueffleeigfeg
    ffeltdelieekueegjeevnecuffhomhgrihhnpehgihhtfhhorhifihhnughofihsrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhs
    sehpkhhsrdhimhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthht
    ohepuggrvhhvihgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihloh
    hrrhdrtghomhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdp
    rhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehg
    mhgrihhlrdgtohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrd
    hplhhushdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:pHs8Z3xNMzSj9rHgNAlvGQSRdFV8_2_aWBE4OtVp6F-f6mn5SzVHJg>
    <xmx:pHs8ZyQqCYS-G9sNe3pLZ2Vhioflt5YjwjE01fsf3xWPQcmSSHoRRg>
    <xmx:pHs8Z6bl2QUHjJvjwqT4v71WTBofdp3-x6DdpYIUP3moRv8FWgaybA>
    <xmx:pHs8ZzR9v13LbsshdSngX8GRv0IAaET6QNwzRQbfXXVJIKrTOetoQQ>
    <xmx:pHs8Z3KNXsGGUUcBLAkCGbM_u6IRntBb55mMR4k5XE8G5hZsJEUW11dA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Nov 2024 06:50:58 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 558449a3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 19 Nov 2024 11:50:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 Nov 2024 12:50:40 +0100
Subject: [PATCH v8 03/23] Makefile: refactor GIT-VERSION-GEN to be reusable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-pks-meson-v8-3-809bf7f042f3@pks.im>
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
 GIT-VERSION-GEN                     | 64 ++++++++++++++++++++++++++++---------
 Makefile                            |  5 ++-
 ci/test-documentation.sh            |  2 +-
 contrib/buildsystems/CMakeLists.txt | 23 ++++---------
 contrib/buildsystems/git-version.in |  1 +
 6 files changed, 62 insertions(+), 34 deletions(-)

diff --git a/GIT-VERSION-FILE.in b/GIT-VERSION-FILE.in
new file mode 100644
index 0000000000000000000000000000000000000000..3789a48a34a3f9e37531fc24b577ffe3c657a3e9
--- /dev/null
+++ b/GIT-VERSION-FILE.in
@@ -0,0 +1 @@
+GIT_VERSION=@GIT_VERSION@
diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 78e8631f677bbebe8f18d83191f0fd014465563e..16f23d44873462aeb0fdb6a928f89fa32786bbbf 100755
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
@@ -26,15 +44,31 @@ else
 	VN="$DEF_VER"
 fi
 
-VN=$(expr "$VN" : v*'\(.*\)')
+GIT_BUILT_FROM_COMMIT=$(git -C "$SOURCE_DIR" rev-parse -q --verify HEAD 2>/dev/null)
+GIT_DATE=$(git -C "$SOURCE_DIR" show --quiet --format='%as')
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
+	-e "s|@GIT_DATE@|$GIT_DATE|" \
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
index c3b546235a177cb090f8f6adcb13e07a1ccdcef1..456dfa0311b53627e6f5550c36a503808a4e5e3e 100644
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
2.47.0.274.g962d0b743d.dirty

