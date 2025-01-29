Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28271194A7C
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 07:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738134731; cv=none; b=MSN035rQHFWlrSrb9nH59GxHhIJwgmXWzQ5qwNshb2A5lBh+KoOCHqUJEcWb4zkccM7Qs8BD9GNUFYIrdp+/HvlBPfhV7Gbj75EPGLCyU7XdnbjQ8yAuaOFzrpzzLnm1Ena55LDj01+6Rc7ypALSCQ3hoRElXQH9UG0UPJvgWes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738134731; c=relaxed/simple;
	bh=Kzsn/iwa0mVIppahmX8XtQVyVeLx4DiI/bgsmE5Dnb8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fIzN3hfi/c3JmaJmkYSJaEoKpqqOJyVz8Ret4Gs0pZBsqGt9+QoavwzZ2QGdmAXOxlHME3cCMtR/3VlNGo0zXyWXdRi+qqg4pNxnQqJmPB8RuNYJoOKclcDDAnWv48gITGKse3S7k6ztoF0RinPeQYsqhWmh/ySLSCiMt6SJZ94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qCoh9dad; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YOiq+hid; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qCoh9dad";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YOiq+hid"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 8A7721380B22
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 02:12:08 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 29 Jan 2025 02:12:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738134728;
	 x=1738221128; bh=7YGh8f9c/mN/tNICB4ZxxtHxUlncfBMdNBYQKeZbt3Y=; b=
	qCoh9dadWh5B+8g65ICGjUrh2uznPBTmh72tZa6C0uuVXTv9gPBtQWg2QPveD6cf
	vUpYs2rvzdKm/bHxm656qgrCfCWCMW/OkbHgYMfwSNKSpNmrgRMhQT71PxVfpFgS
	Xz746uBpFAYNgNyUSeL/7s+mCjDKqupOBjbmNylC55LOvXCWwZRxyASCQpWVe7qG
	J2KvEAeEWnT10kfAlLvAn2mO3mpZdT9hXVRVe5Q6eN0L3ftS1dytKZqOl20yNY7X
	3fb8B5IGBp0ZAvTk2qmmgdZd28Y6I791bVU/XOH++OYvoMH4qJxkA5SoKBq+Tzhm
	TAQFKwyht8lkkq+Jnft2Zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738134728; x=
	1738221128; bh=7YGh8f9c/mN/tNICB4ZxxtHxUlncfBMdNBYQKeZbt3Y=; b=Y
	Oiq+hidYzir2dCLskPVfx9nPRsfjwleojBLmJDia6S+tkdcExtPgvyrPiqtHlixm
	UtLZYKDKMv5hXag3NsEu45zca6E0cQBoKwOv6HRDUlgTNdZFvXmADUpCngzqt4Gj
	jR/Eh6Bd+z8WWVL8GL0X1Iefv4Se8jnimFMSasc4CyQ9SqdcjzjwRKCQQeW02cPg
	mz8BwsSe6XglXLBW6pkCbrdxLN1agJbOo2YnXrl/gmUmUy4QjYEMCBJSYm3aDUkj
	ML73H2NzxzNujplVc2/C9xum6arccM5VO/0GulwcjmwCANqjBM/aZITVokVb0Rs/
	G8KQN4x1MOgzDS97oOemA==
X-ME-Sender: <xms:yNSZZ2wqzy5LVfH3TOul7KUUKgCPJanKXVRXmgmF92dLmMhucP_XPw>
    <xme:yNSZZyQ02BkJqFsxn-mMmlQ1BhWxsnmvxetGgHUKKqkG-FSErAb2AFM49IOSvJ6mr
    Z3Pq5HHpvitI9nHFA>
X-ME-Received: <xmr:yNSZZ4XjdoC-N8724W4T641z_YszFopdZMpnDJIr58158PUqU2HFZGZsL-KExUJFyDcPPjiShRAfSg-tgvL9Ci7W0K_ZMeR0xVEJ6uIPAtRuZuW3nw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yNSZZ8jJh9xo-aRJuFsjYTSh2LWUy190NfvIUEpAs-MpOVvXcw1aow>
    <xmx:yNSZZ4BevpXLeQ6iDyzD_pQCsPkDTt-vhTGrSeRBena_seFuYbR8gQ>
    <xmx:yNSZZ9LY22nG1BjPbIXcEmsplBDDI_QLN2VM4fMAwqZlVIHhKAd8fw>
    <xmx:yNSZZ_COnQcBhZw8o2hQTNsdqipa6A_cEC_046YpIdWMq3VTR4uskA>
    <xmx:yNSZZx5GE0FEYy7THAawK8r-4xElxK0BnY1WgateRMNj9AEDnvLSOcs8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 29 Jan 2025 02:12:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6c1c30f0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 29 Jan 2025 07:12:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 29 Jan 2025 08:11:56 +0100
Subject: [PATCH 03/11] meson: simplify use of the common-main library
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250129-b4-pks-meson-improvements-v1-3-ab709f0be12c@pks.im>
References: <20250129-b4-pks-meson-improvements-v1-0-ab709f0be12c@pks.im>
In-Reply-To: <20250129-b4-pks-meson-improvements-v1-0-ab709f0be12c@pks.im>
To: git@vger.kernel.org
Cc: 
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
 t/helper/meson.build |  4 ++--
 t/meson.build        |  4 ++--
 3 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/meson.build b/meson.build
index 84d100fd25..82b6e62029 100644
--- a/meson.build
+++ b/meson.build
@@ -1570,15 +1570,11 @@ if host_machine.system() == 'windows'
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
@@ -1586,7 +1582,7 @@ test_dependencies = [ ]
 
 git = executable('git',
   sources: builtin_sources + 'git.c',
-  dependencies: [libgit, common_main],
+  dependencies: [libgit_commonmain],
   install: true,
   install_dir: get_option('libexecdir') / 'git-core',
 )
@@ -1594,35 +1590,35 @@ bin_wrappers += git
 
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
@@ -1635,7 +1631,7 @@ if get_option('curl').enabled()
 
   git_remote_http = executable('git-remote-http',
     sources: curl_sources + 'remote-curl.c',
-    dependencies: [libgit, common_main],
+    dependencies: [libgit_commonmain],
     install: true,
     install_dir: get_option('libexecdir') / 'git-core',
   )
@@ -1643,7 +1639,7 @@ if get_option('curl').enabled()
 
   test_dependencies += executable('git-http-fetch',
     sources: curl_sources + 'http-fetch.c',
-    dependencies: [libgit, common_main],
+    dependencies: [libgit_commonmain],
     install: true,
     install_dir: get_option('libexecdir') / 'git-core',
   )
@@ -1651,7 +1647,7 @@ if get_option('curl').enabled()
   if expat.found()
     test_dependencies += executable('git-http-push',
       sources: curl_sources + 'http-push.c',
-      dependencies: [libgit, common_main],
+      dependencies: [libgit_commonmain],
       install: true,
       install_dir: get_option('libexecdir') / 'git-core',
     )
@@ -1660,7 +1656,7 @@ if get_option('curl').enabled()
   foreach alias : [ 'git-remote-https', 'git-remote-ftp', 'git-remote-ftps' ]
     test_dependencies += executable(alias,
       objects: git_remote_http.extract_all_objects(recursive: false),
-      dependencies: [libgit, common_main],
+      dependencies: [libgit],
     )
 
     install_symlink(alias + executable_suffix,
@@ -1677,7 +1673,7 @@ endif
 
 test_dependencies += executable('git-imap-send',
   sources: imap_send_sources,
-  dependencies: [libgit, common_main],
+  dependencies: [libgit_commonmain],
   install: true,
   install_dir: get_option('libexecdir') / 'git-core',
 )
@@ -1685,7 +1681,7 @@ test_dependencies += executable('git-imap-send',
 foreach alias : [ 'git-receive-pack', 'git-upload-archive', 'git-upload-pack' ]
   bin_wrappers += executable(alias,
     objects: git.extract_all_objects(recursive: false),
-    dependencies: [libgit, common_main],
+    dependencies: [libgit],
   )
 
   install_symlink(alias + executable_suffix,
diff --git a/t/helper/meson.build b/t/helper/meson.build
index 5e83884246..05bf35bd26 100644
--- a/t/helper/meson.build
+++ b/t/helper/meson.build
@@ -78,14 +78,14 @@ test_tool_sources = [
 
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
index 14fea8dddf..8896314b88 100644
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
2.48.1.362.g079036d154.dirty

