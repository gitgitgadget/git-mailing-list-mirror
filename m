Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9BF1E0DE6
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 13:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739970847; cv=none; b=FGTAfq4XIL7Xqec7iVdIrGkoAlo0jjfporvdJZ0LiPhSJdGG7cHqRoV6g4anleqhlEtR8AZOjz14D6wsImVtAMuaWDhLN0cMxmY9heV06wONJzU+AhZo0moGX5+JLZ+sKt++LE2OHwax89O5kf11BIEN1LmQNHnwPK0nBobByMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739970847; c=relaxed/simple;
	bh=Rd9wQ5zgXkkM3T2Gu64uxETczmCGqKhp0H3DqVxDsas=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Az6Dtzo3IRpb6gGHwV/1X1gS5wbKakHZi8Y5ehww+o9I5T0Um5y7hnd69fU7FNdBTkobQ1lRaqlKAO5t3XCK7a9ozB3zYekueTD/3e9WSQVkAKHKTz6rlOAEDp/k4+Se4Peod7q556LxZzYSu4bnAKsWOcoafRyvd+7qYc6xzlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HTe7F3d6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S6WBOXvP; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HTe7F3d6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S6WBOXvP"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id BE6E21140090;
	Wed, 19 Feb 2025 08:14:01 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 19 Feb 2025 08:14:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739970841;
	 x=1740057241; bh=SyHglFKHmLfI+/6kFH4OxJTSPVCdEVLD9u+PUcUmZMM=; b=
	HTe7F3d6t6qJpbBxm7AQXt9g1ujHnvrc1RV2k6Qiq47f+ycmc4cp25n0021W4DTE
	YqBg08dI90ah7Gqu2VRKlEpoNY9K5wkvcVA/jd28zFUPyS+9TEVqyzcjO8RvEWg7
	E7G8GSbOxgaXZzVdyumEC22tFDWlCu33vGlZGbYZIxTQ7AOSAZPmVimfJDltOaZa
	dcdd/sj5vHyNwVMaFJANwgdRTd/olZzmgjam23Qit1i+BzUxeaATbZADwORvgqtD
	cpmx/XmAiWvHAKwgs79GO/zjDU0P2upemphZfgekEZtO3ViDEtajgSFIa1wgvIfI
	MYeY5pFiKaoiZsY5LNxFBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739970841; x=
	1740057241; bh=SyHglFKHmLfI+/6kFH4OxJTSPVCdEVLD9u+PUcUmZMM=; b=S
	6WBOXvPHkQJOxj0iD9T091AwI+lpKSqFLTAXlY0/bMrvK14kaA5v+dyjxjEwTJ2o
	wqj7K4rsorMDpqXUAW9cLs+hwU6Lt5yd+ekim8VZDx75Wy66uskdsjFBckBrP9om
	h4mNi6E/IVhM7E5reM+GrHDb1ZeXk+j68QjvXR9gH7Hw9hib8C1jT250TnBjVfJ/
	fGlcczMRF0uTaxXHHNS5Ugz10Yhugm22eAmVmArzZwPryTwXEeexJCvTjTgI4X6L
	G5apICkO1V/ogvYUxZIBgmXPoLIzSnmQjGzF/ruoSrFKaTI10UFzcLFYiiPSlNfU
	ZMZeB+X705ncGfwLWyC5Q==
X-ME-Sender: <xms:Gdm1Zz6FkRH9PxfdQG3XtXvOTACj-m1M5H0W9pEKIDTjXtcnRQdi9A>
    <xme:Gdm1Z46LyRlw9mHudzLuliQhKSIUDGgx7Lanw6iXOEzQ_5_JdXWQ5uGtNPcEMpjDw
    -VO5jBkRJ3PTWsLtg>
X-ME-Received: <xmr:Gdm1Z6dXetAmumku115HU_jou2WHUlKO230aRX89-qYCLJnlBEkUSb3SMMvlSHE1svobI_TbhnJviXJK7Ix5bym66U1Wm6BYhZH4nD1chfJb0FY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehmihhrthhhrdhhihgtkhhfohhrugesghhmrghilhdrtghomhdprhgtphht
    thhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:Gdm1Z0LIrpNCDN_xYl_qgJjK9ovDDy9S08w1ifZSiGWpAhNbbzpIkQ>
    <xmx:Gdm1Z3JUcv7fh6iGZEZk1NQvTbJYN58xNGIkMqs4cIroiUVbr0H_Pg>
    <xmx:Gdm1Z9z8ikS_Gb841Il1ESjPgnBPQ3GzB9kWyL2iaVHBYtRAkkkDjg>
    <xmx:Gdm1ZzLjyGNrbuZwKhOM5nJLPQOoDksrgeAjOxzRd4UohOOT0kcOwA>
    <xmx:Gdm1Z0HmLNvSo_H5p9mWHgLt49PJZNh5dPBJqRTWWnGgHYgTyQDpx2zH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 08:14:00 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c41598a9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Feb 2025 13:13:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Feb 2025 14:13:41 +0100
Subject: [PATCH v2 01/10] GIT-BUILD-OPTIONS: propagate project's source
 directory
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-b4-pks-meson-contrib-v2-1-1ba5d7fde0b9@pks.im>
References: <20250219-b4-pks-meson-contrib-v2-0-1ba5d7fde0b9@pks.im>
In-Reply-To: <20250219-b4-pks-meson-contrib-v2-0-1ba5d7fde0b9@pks.im>
To: git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
X-Mailer: b4 0.14.2

A couple of our tests require knowledge around where to find the
project's source directory in order to locate files required for the
test itself. Until now we have been wiring these up ad-hoc via new,
specialized variables catered to the specific usecase. This is quite
awkward though, as every test that potentially needs to locate paths
relative to the source directory needs to grow another variable.

Introduce a new "GIT_SOURCE_DIR" variable into GIT-BUILD-OPTIONS to stop
this proliferation. Remove existing variables that can be derived from
it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 GIT-BUILD-OPTIONS.in                | 3 +--
 Makefile                            | 3 +--
 contrib/buildsystems/CMakeLists.txt | 3 +--
 meson.build                         | 3 +--
 t/lib-gettext.sh                    | 2 +-
 t/t7609-mergetool--lib.sh           | 2 +-
 6 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/GIT-BUILD-OPTIONS.in b/GIT-BUILD-OPTIONS.in
index ada575fbcb7..0a9884e0ade 100644
--- a/GIT-BUILD-OPTIONS.in
+++ b/GIT-BUILD-OPTIONS.in
@@ -9,14 +9,13 @@ GIT_PERF_MAKE_COMMAND=@GIT_PERF_MAKE_COMMAND@
 GIT_PERF_MAKE_OPTS=@GIT_PERF_MAKE_OPTS@
 GIT_PERF_REPEAT_COUNT=@GIT_PERF_REPEAT_COUNT@
 GIT_PERF_REPO=@GIT_PERF_REPO@
+GIT_SOURCE_DIR=@GIT_SOURCE_DIR@
 GIT_TEST_CMP=@GIT_TEST_CMP@
 GIT_TEST_CMP_USE_COPIED_CONTEXT=@GIT_TEST_CMP_USE_COPIED_CONTEXT@
 GIT_TEST_GITPERLLIB=@GIT_TEST_GITPERLLIB@
 GIT_TEST_INDEX_VERSION=@GIT_TEST_INDEX_VERSION@
-GIT_TEST_MERGE_TOOLS_DIR=@GIT_TEST_MERGE_TOOLS_DIR@
 GIT_TEST_OPTS=@GIT_TEST_OPTS@
 GIT_TEST_PERL_FATAL_WARNINGS=@GIT_TEST_PERL_FATAL_WARNINGS@
-GIT_TEST_POPATH=@GIT_TEST_POPATH@
 GIT_TEST_TEMPLATE_DIR=@GIT_TEST_TEMPLATE_DIR@
 GIT_TEST_TEXTDOMAINDIR=@GIT_TEST_TEXTDOMAINDIR@
 GIT_TEST_UTF8_LOCALE=@GIT_TEST_UTF8_LOCALE@
diff --git a/Makefile b/Makefile
index cd0806e1e69..a3483e15c4a 100644
--- a/Makefile
+++ b/Makefile
@@ -3192,14 +3192,13 @@ GIT-BUILD-OPTIONS: FORCE
 		-e "s|@GIT_PERF_MAKE_OPTS@|\'$(GIT_PERF_MAKE_OPTS)\'|" \
 		-e "s|@GIT_PERF_REPEAT_COUNT@|\'$(GIT_PERF_REPEAT_COUNT)\'|" \
 		-e "s|@GIT_PERF_REPO@|\'$(GIT_PERF_REPO)\'|" \
+		-e "s|@GIT_SOURCE_DIR@|\'$(shell pwd)\'|" \
 		-e "s|@GIT_TEST_CMP@|\'$(GIT_TEST_CMP)\'|" \
 		-e "s|@GIT_TEST_CMP_USE_COPIED_CONTEXT@|\'$(GIT_TEST_CMP_USE_COPIED_CONTEXT)\'|" \
 		-e "s|@GIT_TEST_GITPERLLIB@|\'$(shell pwd)/perl/build/lib\'|" \
 		-e "s|@GIT_TEST_INDEX_VERSION@|\'$(GIT_TEST_INDEX_VERSION)\'|" \
-		-e "s|@GIT_TEST_MERGE_TOOLS_DIR@|\'$(shell pwd)/mergetools\'|" \
 		-e "s|@GIT_TEST_OPTS@|\'$(GIT_TEST_OPTS)\'|" \
 		-e "s|@GIT_TEST_PERL_FATAL_WARNINGS@|\'$(GIT_TEST_PERL_FATAL_WARNINGS)\'|" \
-		-e "s|@GIT_TEST_POPATH@|\'$(shell pwd)/po\'|" \
 		-e "s|@GIT_TEST_TEMPLATE_DIR@|\'$(shell pwd)/templates/blt\'|" \
 		-e "s|@GIT_TEST_TEXTDOMAINDIR@|\'$(shell pwd)/po/build/locale\'|" \
 		-e "s|@GIT_TEST_UTF8_LOCALE@|\'$(GIT_TEST_UTF8_LOCALE)\'|" \
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 3179e7ff7a3..c6fbd57e158 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1169,14 +1169,13 @@ string(REPLACE "@GIT_PERF_MAKE_COMMAND@" "" git_build_options "${git_build_optio
 string(REPLACE "@GIT_PERF_MAKE_OPTS@" "" git_build_options "${git_build_options}")
 string(REPLACE "@GIT_PERF_REPEAT_COUNT@" "" git_build_options "${git_build_options}")
 string(REPLACE "@GIT_PERF_REPO@" "" git_build_options "${git_build_options}")
+string(REPLACE "@GIT_SOURCE_DIR@" "${CMAKE_SOURCE_DIR}" git_build_options "${git_build_options}")
 string(REPLACE "@GIT_TEST_CMP@" "" git_build_options "${git_build_options}")
 string(REPLACE "@GIT_TEST_CMP_USE_COPIED_CONTEXT@" "" git_build_options "${git_build_options}")
 string(REPLACE "@GIT_TEST_GITPERLLIB@" "'${CMAKE_BINARY_DIR}/perl/build/lib'" git_build_options "${git_build_options}")
 string(REPLACE "@GIT_TEST_INDEX_VERSION@" "" git_build_options "${git_build_options}")
-string(REPLACE "@GIT_TEST_MERGE_TOOLS_DIR@" "'${CMAKE_BINARY_DIR}/mergetools'" git_build_options "${git_build_options}")
 string(REPLACE "@GIT_TEST_OPTS@" "" git_build_options "${git_build_options}")
 string(REPLACE "@GIT_TEST_PERL_FATAL_WARNINGS@" "" git_build_options "${git_build_options}")
-string(REPLACE "@GIT_TEST_POPATH@" "'${CMAKE_BINARY_DIR}/po'" git_build_options "${git_build_options}")
 string(REPLACE "@GIT_TEST_TEMPLATE_DIR@" "'${CMAKE_BINARY_DIR}/templates/blt'" git_build_options "${git_build_options}")
 string(REPLACE "@GIT_TEST_TEXTDOMAINDIR@" "'${CMAKE_BINARY_DIR}/po/build/locale'" git_build_options "${git_build_options}")
 string(REPLACE "@GIT_TEST_UTF8_LOCALE@" "" git_build_options "${git_build_options}")
diff --git a/meson.build b/meson.build
index 0df3872c6ad..d77d7b6b603 100644
--- a/meson.build
+++ b/meson.build
@@ -1960,10 +1960,9 @@ subdir('contrib')
 
 foreach key, value : {
   'DIFF': diff.full_path(),
+  'GIT_SOURCE_DIR': meson.project_source_root(),
   'GIT_TEST_CMP': diff.full_path() + ' -u',
   'GIT_TEST_GITPERLLIB': meson.project_build_root() / 'perl',
-  'GIT_TEST_MERGE_TOOLS_DIR': meson.project_source_root() / 'mergetools',
-  'GIT_TEST_POPATH': meson.project_source_root() / 'po',
   'GIT_TEST_TEMPLATE_DIR': meson.project_build_root() / 'templates',
   'GIT_TEST_TEXTDOMAINDIR': meson.project_build_root() / 'po',
   'PAGER_ENV': get_option('pager_environment'),
diff --git a/t/lib-gettext.sh b/t/lib-gettext.sh
index 7a734c6973e..b3dd68b0b95 100644
--- a/t/lib-gettext.sh
+++ b/t/lib-gettext.sh
@@ -7,7 +7,7 @@
 . ./test-lib.sh
 
 GIT_TEXTDOMAINDIR="$GIT_TEST_TEXTDOMAINDIR"
-GIT_PO_PATH="$GIT_TEST_POPATH"
+GIT_PO_PATH="$GIT_SOURCE_DIR/po"
 export GIT_TEXTDOMAINDIR GIT_PO_PATH
 
 if test -n "$GIT_TEST_INSTALLED"
diff --git a/t/t7609-mergetool--lib.sh b/t/t7609-mergetool--lib.sh
index e8e205707e4..af3ad284eed 100755
--- a/t/t7609-mergetool--lib.sh
+++ b/t/t7609-mergetool--lib.sh
@@ -7,7 +7,7 @@ Testing basic merge tools options'
 . ./test-lib.sh
 
 test_expect_success 'mergetool --tool=vimdiff creates the expected layout' '
-	. "$GIT_TEST_MERGE_TOOLS_DIR"/vimdiff &&
+	. "$GIT_SOURCE_DIR"/mergetools/vimdiff &&
 	run_unit_tests
 '
 

-- 
2.48.1.666.gff9fcf71b7.dirty

