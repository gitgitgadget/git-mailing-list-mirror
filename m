Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F16155336
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 12:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735301456; cv=none; b=vBehesc+Plmt7kBiVMj3vnTtgIadqimMwEzqP2shXQYZu9vU/mFbttl64/GdHbZHoqM3kYe3sgJc82gFgopysmTjMg/UB7v3mCR5K3OboDh0YLWTAdEtBbGaXR+j+eeCiZ2qgwa/N22FslG0Zik5O+VJkQ4O+AKVji1RpMxIwb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735301456; c=relaxed/simple;
	bh=HMHOsCEW63sFqDcxO3u8fE8/tZf9Vl7TDLPcCxc+PIQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FrTrE+O6xvEQfVDLj9LOSo5tRiVS74G+blmR67CdqOUTYhAC6Hdy1wOrsHHtybFYCJcomVw6gCp5WmeDHAVkgV2boKWvePUhMSIdkB7U4ETyMxRvwbbnktLzVnDXC4M1gklpiAe27lZqJAJhk9frL6/k43jthFOdqQePHgcqhm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Feor5aD1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KENwjHBl; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Feor5aD1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KENwjHBl"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id BF86D114015E
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 07:10:53 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 27 Dec 2024 07:10:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735301453;
	 x=1735387853; bh=85lA1O1tNp9ug9xftaHEmO16nh+RELL7JdnSAq2BWKQ=; b=
	Feor5aD1yYi3bmfvwZd8D0EBY1ES7rLSEcvZ5iBF3NDMILr+NM7P1CE1dVtb6Pre
	7/kYYbrlqOIFhYXlLe1rezxQmdnbxw6ZIFWSOssV9gGOJU5jU5TpEgFkWdoi4Cvh
	T23TPJk8q/agsHmrCCo9Q35bhe9LpLvPar4s3oisiTyieSh/fd+L+Mv9Nl4k+m2K
	TyFxY5bl8PASp6IbH+9MiJpQwZ4UplcaZTPCB+VMY2C2VKnDOhjelctYoxeq4vbu
	aun/Ei2Gi6Di53XIbuTrRZG9o1iGaVwoCa99rp50+G4XhDYMuBthTzNmWWVhySwf
	Cjsr8zr8sUuZPOt47U8OhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735301453; x=
	1735387853; bh=85lA1O1tNp9ug9xftaHEmO16nh+RELL7JdnSAq2BWKQ=; b=K
	ENwjHBlErtYrh2GYfIGVylI8yLMPTKHbiBHn5UWVioJ6hsHY+3HA6Y6/z5jH4E6l
	Gc+WCFEtDB+X4sOOcIikDQ2IGL9K09NSFSHT2QL6ZOnsYRU42YANq5WNtAWih4y3
	nAWw5HhgSc77IylZBJunCPGJR2zmBvqt8hCKiA+m8QPYrj8fstkwBHMYbMGMIjn7
	udNqwo1nVt5QTwaxp2OxYWhZ52mcm/7Ke6zRsFn/Z842X5mkfQgL582UJC/830kj
	KwGVkxldQIelVqCJAs3qnJuMLovI+c6u9AOkfxotH8sPFeRCh4sjNHSbgpU+kKXO
	GqJ57xUaDvrmQUKXvQIQg==
X-ME-Sender: <xms:TZluZ1z7m0_g92eDH8ldna4qcntFxXkql2OwrTGTn9cJrrB9r7vVQA>
    <xme:TZluZ1TKBNLlXv8v4B-JZOtFqeZUw1o2ne30WI_cHX3T_zxt1C2_QeN1P0QzNhMvb
    MCtZdZ9s5VZxwomrA>
X-ME-Received: <xmr:TZluZ_X1oQ4cY1ihEVNdTw2nl312-r9zCE8gv6CYIcG0WZKlf4xgyXyb16mTpT-sdkMxs32nv3i1w1Zh8fwU95U8KzNHN8Hp1XQ7ZIwq6vGDhg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:TZluZ3hDrzbhMDF-4v2b48V-PTXMCme11b75vmAsuwLYwWWsFerH5g>
    <xmx:TZluZ3BOIT5m8HTghIr1RkAZXxAMtFmNsStGr0glKKDZs2T_U8TocQ>
    <xmx:TZluZwKizVBC0J4qgsICHG_InM1h9ozxetdxmwlR-46slh8wYjg9fw>
    <xmx:TZluZ2BYka8CKgDm6kN7K6vy-uq0FldE-oSg9zmdZmURptDCFiFqwA>
    <xmx:TZluZ85FLksmzhOKGN4DoG6WG8YEybvjLcPRPnu2U8mf-dGJl7niHMBN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 27 Dec 2024 07:10:52 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6fc3ff11 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 27 Dec 2024 12:08:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 27 Dec 2024 13:10:18 +0100
Subject: [PATCH 2/3] GIT-BUILD-OPTIONS: wire up NO_GITWEB option
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241227-b4-pks-meson-wo-gitweb-v1-2-14ca8515bb3b@pks.im>
References: <20241227-b4-pks-meson-wo-gitweb-v1-0-14ca8515bb3b@pks.im>
In-Reply-To: <20241227-b4-pks-meson-wo-gitweb-v1-0-14ca8515bb3b@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Building our "gitweb" interface is optional in our Makefile and in Meson
and not wired up at all with CMake, but disabling it causes a couple of
tests in the t950* range that pull in "t/lib-gitweb.sh". This is because
the test library knows to execute gitweb-tests based on whether or not
Perl is available, but we may have Perl available and still end up not
building gitweb e.g. with `make test NO_GITWEB=YesPlease`.

Fix this issue by wiring up a new "NO_GITWEB" build option so that we
can skip these tests in case gitweb is not built.

Note that this new build option requires us to move the configuration of
GIT-BUILD-OPTIONS to a later point in our Meson build instructions. But
as that file is only consumed by our tests at runtime this change does
not cause any issues.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 GIT-BUILD-OPTIONS.in                |  1 +
 Makefile                            |  1 +
 contrib/buildsystems/CMakeLists.txt |  1 +
 meson.build                         | 59 +++++++++++++++++++------------------
 t/lib-gitweb.sh                     |  5 ++++
 t/test-lib.sh                       |  1 +
 6 files changed, 40 insertions(+), 28 deletions(-)

diff --git a/GIT-BUILD-OPTIONS.in b/GIT-BUILD-OPTIONS.in
index 162cc391903c911383fb0fb358589b4cee4b64aa..edff75ae16be90e21a0e9fc5df16a6605439f907 100644
--- a/GIT-BUILD-OPTIONS.in
+++ b/GIT-BUILD-OPTIONS.in
@@ -24,6 +24,7 @@ LOCALEDIR=@LOCALEDIR@
 NO_CURL=@NO_CURL@
 NO_EXPAT=@NO_EXPAT@
 NO_GETTEXT=@NO_GETTEXT@
+NO_GITWEB=@NO_GITWEB@
 NO_ICONV=@NO_ICONV@
 NO_PERL=@NO_PERL@
 NO_PERL_CPAN_FALLBACKS=@NO_PERL_CPAN_FALLBACKS@
diff --git a/Makefile b/Makefile
index f80e70702fcd8df884c7634344cc4ae23d2cb605..97e8385b6643b963c54affb3ae621fc93fad28b5 100644
--- a/Makefile
+++ b/Makefile
@@ -3171,6 +3171,7 @@ GIT-BUILD-OPTIONS: FORCE
 		-e "s|@NO_CURL@|\'$(NO_CURL)\'|" \
 		-e "s|@NO_EXPAT@|\'$(NO_EXPAT)\'|" \
 		-e "s|@NO_GETTEXT@|\'$(NO_GETTEXT)\'|" \
+		-e "s|@NO_GITWEB@|\'$(NO_GITWEB)\'|" \
 		-e "s|@NO_ICONV@|\'$(NO_ICONV)\'|" \
 		-e "s|@NO_PERL@|\'$(NO_PERL)\'|" \
 		-e "s|@NO_PERL_CPAN_FALLBACKS@|\'$(NO_PERL_CPAN_FALLBACKS_SQ)\'|" \
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index f45407b060221bf900fd0a19a315f0d0dce23147..10dc54fdcb647bbeeffb4eff6f18d10337b49873 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1184,6 +1184,7 @@ string(REPLACE "@LOCALEDIR@" "'${LOCALEDIR}'" git_build_options "${git_build_opt
 string(REPLACE "@NO_CURL@" "${NO_CURL}" git_build_options "${git_build_options}")
 string(REPLACE "@NO_EXPAT@" "${NO_EXPAT}" git_build_options "${git_build_options}")
 string(REPLACE "@NO_GETTEXT@" "${NO_GETTEXT}" git_build_options "${git_build_options}")
+string(REPLACE "@NO_GITWEB@" "1" git_build_options "${git_build_options}")
 string(REPLACE "@NO_ICONV@" "${NO_ICONV}" git_build_options "${git_build_options}")
 string(REPLACE "@NO_PERL@" "${NO_PERL}" git_build_options "${git_build_options}")
 string(REPLACE "@NO_PERL_CPAN_FALLBACKS@" "" git_build_options "${git_build_options}")
diff --git a/meson.build b/meson.build
index a0654a3f244adc19db434e01ca6b3709fb8ff8af..3e57793862e5fc15685b5f0fac7f7223af7bef1f 100644
--- a/meson.build
+++ b/meson.build
@@ -1456,34 +1456,6 @@ else
   build_options_config.set('RUNTIME_PREFIX', 'false')
 endif
 
-foreach key, value : {
-  'DIFF': diff.full_path(),
-  'GIT_TEST_CMP': diff.full_path() + ' -u',
-  'GIT_TEST_GITPERLLIB': meson.project_build_root() / 'perl',
-  'GIT_TEST_MERGE_TOOLS_DIR': meson.project_source_root() / 'mergetools',
-  'GIT_TEST_POPATH': meson.project_source_root() / 'po',
-  'GIT_TEST_TEMPLATE_DIR': meson.project_build_root() / 'templates',
-  'GIT_TEST_TEXTDOMAINDIR': meson.project_build_root() / 'po',
-  'PAGER_ENV': get_option('pager_environment'),
-  'PERL_PATH': perl.found() ? perl.full_path() : '',
-  'PYTHON_PATH': python.found () ? python.full_path() : '',
-  'SHELL_PATH': shell.full_path(),
-  'TAR': tar.full_path(),
-  'TEST_OUTPUT_DIRECTORY': test_output_directory,
-  'TEST_SHELL_PATH': shell.full_path(),
-}
-  if value != '' and cygpath.found()
-    value = run_command(cygpath, value, check: true).stdout().strip()
-  endif
-  build_options_config.set_quoted(key, value)
-endforeach
-
-configure_file(
-  input: 'GIT-BUILD-OPTIONS.in',
-  output: 'GIT-BUILD-OPTIONS',
-  configuration: build_options_config,
-)
-
 git_version_file = custom_target(
   command: [
     shell,
@@ -1893,6 +1865,9 @@ subdir('contrib')
 gitweb_option = get_option('gitweb').disable_auto_if(not perl.found())
 if gitweb_option.enabled()
   subdir('gitweb')
+  build_options_config.set('NO_GITWEB', '')
+else
+  build_options_config.set('NO_GITWEB', '1')
 endif
 
 subdir('templates')
@@ -1909,6 +1884,34 @@ if get_option('docs') != []
   subdir('Documentation')
 endif
 
+foreach key, value : {
+  'DIFF': diff.full_path(),
+  'GIT_TEST_CMP': diff.full_path() + ' -u',
+  'GIT_TEST_GITPERLLIB': meson.project_build_root() / 'perl',
+  'GIT_TEST_MERGE_TOOLS_DIR': meson.project_source_root() / 'mergetools',
+  'GIT_TEST_POPATH': meson.project_source_root() / 'po',
+  'GIT_TEST_TEMPLATE_DIR': meson.project_build_root() / 'templates',
+  'GIT_TEST_TEXTDOMAINDIR': meson.project_build_root() / 'po',
+  'PAGER_ENV': get_option('pager_environment'),
+  'PERL_PATH': perl.found() ? perl.full_path() : '',
+  'PYTHON_PATH': python.found () ? python.full_path() : '',
+  'SHELL_PATH': shell.full_path(),
+  'TAR': tar.full_path(),
+  'TEST_OUTPUT_DIRECTORY': test_output_directory,
+  'TEST_SHELL_PATH': shell.full_path(),
+}
+  if value != '' and cygpath.found()
+    value = run_command(cygpath, value, check: true).stdout().strip()
+  endif
+  build_options_config.set_quoted(key, value)
+endforeach
+
+configure_file(
+  input: 'GIT-BUILD-OPTIONS.in',
+  output: 'GIT-BUILD-OPTIONS',
+  configuration: build_options_config,
+)
+
 summary({
   'curl': curl.found(),
   'expat': expat.found(),
diff --git a/t/lib-gitweb.sh b/t/lib-gitweb.sh
index 7f9808ec2024d62edc3a3f1c01fb255d0fd37cb2..a6e3dd11b3552a477c84c974db29d902fd87183f 100644
--- a/t/lib-gitweb.sh
+++ b/t/lib-gitweb.sh
@@ -105,6 +105,11 @@ if ! test_have_prereq PERL; then
 	test_done
 fi
 
+if ! test_have_prereq GITWEB; then
+	skip_all='skipping gitweb tests, gitweb not available'
+	test_done
+fi
+
 perl -MEncode -e '$e="";decode_utf8($e, Encode::FB_CROAK)' >/dev/null 2>&1 || {
 	skip_all='skipping gitweb tests, perl version is too old'
 	test_done
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 62dfcc4aaf959d0cf066d07663d939e14f92485c..1a67adb20764d60a70ebfde6df52a0fbd3bf72ee 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1687,6 +1687,7 @@ esac
 
 ( COLUMNS=1 && test $COLUMNS = 1 ) && test_set_prereq COLUMNS_CAN_BE_1
 test -z "$NO_CURL" && test_set_prereq LIBCURL
+test -z "$NO_GITWEB" && test_set_prereq GITWEB
 test -z "$NO_ICONV" && test_set_prereq ICONV
 test -z "$NO_PERL" && test_set_prereq PERL
 test -z "$NO_PTHREADS" && test_set_prereq PTHREADS

-- 
2.48.0.rc0.311.gb6c66824c1.dirty

