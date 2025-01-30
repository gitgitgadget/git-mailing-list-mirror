Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A1B1E9906
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738248256; cv=none; b=cHpgVqTsfJLnNoVC9JE6vlSnNS6Wp7BoMWIgXWe/+zDxyMF8pLu9CZsaeYyZTSxJwl61UEtEqV3LnUL3LGj4znOjtEfUSVnH+d5nqO987yoxnInbeonB+zqXjPwZ6j40Pq2iupnHHph6afI7B7KemdUXs+1+B5IVWe6c4PcbRcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738248256; c=relaxed/simple;
	bh=goJQnGWIoowLxOUySZAtq8fnQ8UcM0wBKXag9S27vNw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gOL2/0TUvrNzAjM0AhzFX1va4Cx7towDGFSv2RXp0qSeSrIvCKzWmEeOBQYz9awhKhy+sM/hpG7P3UAIg3KNsTwxJ0+lS+7nJccgq1lsUnRuXCPhR1Sf8SqUUj3nLcVKxj0vNC9AJ7yQO/rZtcfZ6x2xArWxiqk2gp3XaRxJ/lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=et5I98uu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TbSZdX5s; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="et5I98uu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TbSZdX5s"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4D24D11400DA;
	Thu, 30 Jan 2025 09:44:14 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 30 Jan 2025 09:44:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738248254;
	 x=1738334654; bh=qgkHTeLOzJg0jc2HUFzbimHSMyBLfaNkti9ODLwgYu8=; b=
	et5I98uucPOhciuOUzMVQArZlkpX9zAZYqixSjopVPUEZu9qIBzjxSY5fxiJQXIi
	ADvPHHNVVbMTYcJG8jtClu4U4qaygGPYCh1AMLDjoSOWflaW7raXGtzsBGPfrzLH
	KeA6Up8hYT0XmfbSh2OOX8pWPnUUtbTcINztAMcoSpqd2lAnoJig/a1XX/5qTdUM
	77NzzLaKFEcEh6dvZV7NJVJozFI8qM1tVcoQLphGFWLd2ZLoqbehPRwwtUAjpOdk
	xvVjCTk686UcweYDhPfB4jI2V5FC3Uv67vyRlSB0/QY+2Behy7ZwgjTseXP3MTWj
	p+dux6jZc6JUW+EWvsfopQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738248254; x=
	1738334654; bh=qgkHTeLOzJg0jc2HUFzbimHSMyBLfaNkti9ODLwgYu8=; b=T
	bSZdX5sMTaR6MHmAc++cn997o0xyEjFPN8SO/zQ2tl4UbGYml5Kci45q4tbJwZiV
	zUCA0/equHZfOj33bWpFBCEQDbTP6WGAG09WcfbxNr6iMobdToBW56TRSt0LeXi9
	XHeA5mrIMWskIQu4OKld+7TROE0vVNlB1qF0Y2LJsuneReyJpHxUWGOOpAUZjw2H
	xgxvzzABnU5hFY1KqzuPdWzH+nXoNtRDQxK+yEN+duRmZwYHs5j2yom9ZBUiqqLf
	NTD3GmkGe2Iy+DDH+qxnBFmqzRCQNdNmMA0A/xZg1FQ9ugXcbCkLLZEjmGeNcQcG
	385d52F6Aq1vCpllNHdCQ==
X-ME-Sender: <xms:PpCbZ1mvaOHu_QhjD-mkrwROMlsw7ejBAQ5oWM2fQjP_5ebheT9D9w>
    <xme:PpCbZw27HiN5FaTDRkaJQu61LjnJkmTDPlFaRzs5vXPktK8I9bTWCF-4zoppHaKcP
    2j51DKB2XF_gB6r7g>
X-ME-Received: <xmr:PpCbZ7qqfz2fgrgS6hA1Lc6h5mCG_Tttr8Qzz8mIlUhWMgXQ4xhMpzMz_ryoiXfppUxmL8cKeGzaEqdXAuAY7Utqgw4TJ2CqcD_dMyc8kxTf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:PpCbZ1k5GtdBVTH_G3hleTMqW8F9LvD02atAwNTEF0sfWevAlmsPhg>
    <xmx:PpCbZz0lAG5mD1S0Fb4PD6UeuuTa54VP8XdPZokD1d6oHLuiFXlUHQ>
    <xmx:PpCbZ0tFp7IcFdI94gmWFCiDSy4cUkHD7vH-cIbY--Z_RzGiyj6z5w>
    <xmx:PpCbZ3V0O7e9xIDS-HTF80jDHeOwcSl378U7ZmkvYbhYg1XJsNhNZQ>
    <xmx:PpCbZxC9wUa_G7kZEmic29bDdkbziK1IBWmYsTZX4w4drO68peCSHhyJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 09:44:13 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id acff5fc7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 Jan 2025 14:44:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 30 Jan 2025 15:43:56 +0100
Subject: [PATCH v2 04/13] meson: simplify use of the common-main library
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250130-b4-pks-meson-improvements-v2-4-2f05581ffb44@pks.im>
References: <20250130-b4-pks-meson-improvements-v2-0-2f05581ffb44@pks.im>
In-Reply-To: <20250130-b4-pks-meson-improvements-v2-0-2f05581ffb44@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

The "common-main.c" file is used by multiple executables. In order to
make it easy to set it up we have created a separate library that these
executables can link against. All of these executables also want to link
against `libgit.a` though, which makes it necessary to specify both of
these as dependencies for every executable.

Simplify this a bit by declaring the library as a source dependency:
instead of creating a static library, we now instead compile the common
set of files into each executable separately.

This change surfaces an issue when linking aliases for git-remote-http:
we extract all objects from `git-remote-http` et al and then link them
into the new executable. As such, these objects would already contain
a `main()` function. But now that we also compile "common-main.c" into
these aliased executables we see a linker error due to `main()` being
defined twice. We fix this by only linking against `libgit.a`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build          | 34 +++++++++++++++-------------------
 oss-fuzz/meson.build |  2 +-
 t/helper/meson.build |  4 ++--
 t/meson.build        |  4 ++--
 4 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/meson.build b/meson.build
index a124101a73..c7d597eda8 100644
--- a/meson.build
+++ b/meson.build
@@ -1604,15 +1604,11 @@ if host_machine.system() == 'windows'
     error('Unsupported compiler ' + compiler.get_id())
   endif
 endif
-common_main_library = static_library('common-main',
+
+libgit_commonmain = declare_dependency(
   sources: common_main_sources,
-  c_args: libgit_c_args,
-  dependencies: libgit_dependencies,
-  include_directories: libgit_include_directories,
-)
-common_main = declare_dependency(
-  link_with: common_main_library,
   link_args: common_main_link_args,
+  dependencies: [ libgit ],
 )
 
 bin_wrappers = [ ]
@@ -1620,7 +1616,7 @@ test_dependencies = [ ]
 
 git = executable('git',
   sources: builtin_sources + 'git.c',
-  dependencies: [libgit, common_main],
+  dependencies: [libgit_commonmain],
   install: true,
   install_dir: get_option('libexecdir') / 'git-core',
 )
@@ -1628,35 +1624,35 @@ bin_wrappers += git
 
 test_dependencies += executable('git-daemon',
   sources: 'daemon.c',
-  dependencies: [libgit, common_main],
+  dependencies: [libgit_commonmain],
   install: true,
   install_dir: get_option('libexecdir') / 'git-core',
 )
 
 test_dependencies += executable('git-sh-i18n--envsubst',
   sources: 'sh-i18n--envsubst.c',
-  dependencies: [libgit, common_main],
+  dependencies: [libgit_commonmain],
   install: true,
   install_dir: get_option('libexecdir') / 'git-core',
 )
 
 bin_wrappers += executable('git-shell',
   sources: 'shell.c',
-  dependencies: [libgit, common_main],
+  dependencies: [libgit_commonmain],
   install: true,
   install_dir: get_option('libexecdir') / 'git-core',
 )
 
 test_dependencies += executable('git-http-backend',
   sources: 'http-backend.c',
-  dependencies: [libgit, common_main],
+  dependencies: [libgit_commonmain],
   install: true,
   install_dir: get_option('libexecdir') / 'git-core',
 )
 
 bin_wrappers += executable('scalar',
   sources: 'scalar.c',
-  dependencies: [libgit, common_main],
+  dependencies: [libgit_commonmain],
   install: true,
   install_dir: get_option('libexecdir') / 'git-core',
 )
@@ -1669,7 +1665,7 @@ if get_option('curl').enabled()
 
   git_remote_http = executable('git-remote-http',
     sources: curl_sources + 'remote-curl.c',
-    dependencies: [libgit, common_main],
+    dependencies: [libgit_commonmain],
     install: true,
     install_dir: get_option('libexecdir') / 'git-core',
   )
@@ -1677,7 +1673,7 @@ if get_option('curl').enabled()
 
   test_dependencies += executable('git-http-fetch',
     sources: curl_sources + 'http-fetch.c',
-    dependencies: [libgit, common_main],
+    dependencies: [libgit_commonmain],
     install: true,
     install_dir: get_option('libexecdir') / 'git-core',
   )
@@ -1685,7 +1681,7 @@ if get_option('curl').enabled()
   if expat.found()
     test_dependencies += executable('git-http-push',
       sources: curl_sources + 'http-push.c',
-      dependencies: [libgit, common_main],
+      dependencies: [libgit_commonmain],
       install: true,
       install_dir: get_option('libexecdir') / 'git-core',
     )
@@ -1694,7 +1690,7 @@ if get_option('curl').enabled()
   foreach alias : [ 'git-remote-https', 'git-remote-ftp', 'git-remote-ftps' ]
     test_dependencies += executable(alias,
       objects: git_remote_http.extract_all_objects(recursive: false),
-      dependencies: [libgit, common_main],
+      dependencies: [libgit],
     )
 
     install_symlink(alias + executable_suffix,
@@ -1711,7 +1707,7 @@ endif
 
 test_dependencies += executable('git-imap-send',
   sources: imap_send_sources,
-  dependencies: [libgit, common_main],
+  dependencies: [libgit_commonmain],
   install: true,
   install_dir: get_option('libexecdir') / 'git-core',
 )
@@ -1719,7 +1715,7 @@ test_dependencies += executable('git-imap-send',
 foreach alias : [ 'git-receive-pack', 'git-upload-archive', 'git-upload-pack' ]
   bin_wrappers += executable(alias,
     objects: git.extract_all_objects(recursive: false),
-    dependencies: [libgit, common_main],
+    dependencies: [libgit],
   )
 
   install_symlink(alias + executable_suffix,
diff --git a/oss-fuzz/meson.build b/oss-fuzz/meson.build
index ed79665501..878afd8426 100644
--- a/oss-fuzz/meson.build
+++ b/oss-fuzz/meson.build
@@ -15,6 +15,6 @@ foreach fuzz_program : fuzz_programs
       'dummy-cmd-main.c',
       fuzz_program,
     ],
-    dependencies: [libgit, common_main],
+    dependencies: [libgit_commonmain],
   )
 endforeach
diff --git a/t/helper/meson.build b/t/helper/meson.build
index f502d1aaa3..ae01b3fc45 100644
--- a/t/helper/meson.build
+++ b/t/helper/meson.build
@@ -79,14 +79,14 @@ test_tool_sources = [
 
 test_tool = executable('test-tool',
   sources: test_tool_sources,
-  dependencies: [libgit, common_main],
+  dependencies: [libgit_commonmain],
 )
 bin_wrappers += test_tool
 test_dependencies += test_tool
 
 test_fake_ssh = executable('test-fake-ssh',
   sources: 'test-fake-ssh.c',
-  dependencies: [libgit, common_main],
+  dependencies: [libgit_commonmain],
 )
 bin_wrappers += test_fake_ssh
 test_dependencies += test_fake_ssh
diff --git a/t/meson.build b/t/meson.build
index 35f25ca4a1..dae50601fe 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -39,7 +39,7 @@ clar_sources += custom_target(
 
 clar_unit_tests = executable('unit-tests',
   sources: clar_sources + clar_test_suites,
-  dependencies: [libgit, common_main],
+  dependencies: [libgit_commonmain],
 )
 test('unit-tests', clar_unit_tests)
 
@@ -72,7 +72,7 @@ foreach unit_test_program : unit_test_programs
       'unit-tests/lib-reftable.c',
       unit_test_program,
     ],
-    dependencies: [libgit, common_main],
+    dependencies: [libgit_commonmain],
   )
   test(unit_test_name, unit_test,
     workdir: meson.current_source_dir(),

-- 
2.48.1.468.gbf5f394be8.dirty

