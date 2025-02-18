Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B731D5CFF
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 07:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739864771; cv=none; b=TQ2GoqiUZtO9i3+/bBWFXn95PiXsTCzh5CFVoRA7yP9OXnJn5I323LoMd8FbTYn3ojHXAoTyPIHUaJFWMqnwViMHC0zaMIqVblZvZBRCWXgXH7cpYkZ9ETMuT7kjXO5f6gMYekTICpDP/MLKsLp5wOacx68oREcx3jn2LESeVss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739864771; c=relaxed/simple;
	bh=Rd9wQ5zgXkkM3T2Gu64uxETczmCGqKhp0H3DqVxDsas=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jyuyKL/wBj3UlEGvByceqtQinTcNKjo5BmyY3dcRSlrMzAzygOQbGQfEEsZkJUj4Wf1cre9o/yDtNnufsDFQvY9V+ujD317+5tPEboo32/rDjZAIu7h9As2eWN2HZlucQoNBermUY2SpyHXocUvs+Z+6LWQAUNs6pD+IwmRo/wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qtCNVKrp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OAtbOWRN; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qtCNVKrp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OAtbOWRN"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id CE3F51380A39;
	Tue, 18 Feb 2025 02:46:07 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 18 Feb 2025 02:46:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739864767;
	 x=1739951167; bh=SyHglFKHmLfI+/6kFH4OxJTSPVCdEVLD9u+PUcUmZMM=; b=
	qtCNVKrpimDoudBehnXEZ+g1gBbQGSGVwqALaVIPThLbarlOcgWIo8/xqCWRV33A
	uN3q4uWSdlByNPcQjJIbQ626978yxMOV+N9W75eN8f5D85e+QFJYXeDRTHT9+lId
	fxRe6kOmpeiKPQqhhy7YNw++mWoxt16dKv419ihLckzYcXqj6NQk6rOrT0jgg9xO
	vXAQbuM+GwxMRCVO1wLluOpgIde8supEfxj8an3hrZPIG1LMluzX2+O4vCa9Mz+E
	tHEA5XeFb+KUYbRM1wgVD3+angMGZ7KLi+D4OOMmw2iDdc7tKpI7mDX7WVy+qQYK
	fyKvIQH60ZPD5DuVG21uxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739864767; x=
	1739951167; bh=SyHglFKHmLfI+/6kFH4OxJTSPVCdEVLD9u+PUcUmZMM=; b=O
	AtbOWRNXlfs8KOf8Fu9kJvdBw2CCbN+AnUL+dLhv0exj9aDWsrCc20pdeTHvO2tE
	p16yeCOpe+Zi5K3LvOShqzgHdoUwrsIykyNfDocVylv5b2hjkIdCwFGAEfaJ4TMj
	oJqAfoHvOpKVBAL31LsgDOlHyyC7mtQEkB9vo22K7NMlIyrQ5jg4e4176C21iERN
	F1GVPNGpodkUgqs4HLEcOjCrwPmvw0+boh4rSDpJEcTJIwYpkGjpb2tK+3WLerFa
	7GsgIA+OfMJqMaS9IkBXBV7OiVM7tywmVOfuDP8ZH3hwBjgFjlfKVHmqrTzRrrMD
	QjyuCV86d0JH8ilbPcsaQ==
X-ME-Sender: <xms:vzq0Z1mUzHTTlvw4K0lYXGeA-MMf_dQmSI1kVhcEZMT0QrQdZm5Xyg>
    <xme:vzq0Zw08ZcDM5Mdx-HxwYWO5s53BIF1rjGpPjxRkf2yo6l_fLKI9d9XlNwDms25I-
    CDQh5B2XeauFfoHAQ>
X-ME-Received: <xmr:vzq0Z7qXanhD3as9LkQrqtHQpDLcdwEyZw84FeqpHB6azxnm9pP6HVpqeWyifyCw7dtrCELQxuhIZlaPyGSL_U4eBNZj9saJAmrqCFJF0BETgxRx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdejvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepmhhirhhthhdrhhhitghkfhhorhgusehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:vzq0Z1kiD3q44u6YGoB2TFH9b8HzyVZl-AhceUmuQ8v1okTKAWYOBw>
    <xmx:vzq0Zz1anaV4ZehAIDZjePZxDwYmScVT7YuF5pcQJCA4VRkilsOABA>
    <xmx:vzq0Z0vWNHqManHQ1kNDEwPjLG4Z6WUWjxWxiMe_NTfKiYsXwNeKfw>
    <xmx:vzq0Z3UxyIo638IvvwEQU_Jna9oB24HMfXidHNsValhbv1SXdGnKhw>
    <xmx:vzq0ZxCS8L7-MQULYqxfXFrQ8ktwRE05QRKKgGzllKHFxjFUePb6hie8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 02:46:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 974fc5d8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Feb 2025 07:46:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 18 Feb 2025 08:45:49 +0100
Subject: [PATCH 01/12] GIT-BUILD-OPTIONS: propagate project's source
 directory
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-b4-pks-meson-contrib-v1-1-c3edd292beb8@pks.im>
References: <20250218-b4-pks-meson-contrib-v1-0-c3edd292beb8@pks.im>
In-Reply-To: <20250218-b4-pks-meson-contrib-v1-0-c3edd292beb8@pks.im>
To: git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>
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

