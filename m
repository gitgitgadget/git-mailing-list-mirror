Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B90F3D812C
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 17:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773165197; cv=none; b=isjb0LKJCMvV7LqIUoxYT8KS50TwDmtJdlruip/dRnFdN6NcRf/oMsC6Lkn74TciMRnt0lWmqWdDthJe5SC7kiNReJZ9oruI5e7P1mwHu5jS09axZBifWZiWtrSylzbFkGgp1X86nRtQ+u4KZE+H6nQnX3AEiIWkJeVqcuRFM6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773165197; c=relaxed/simple;
	bh=Zkxh91FodO7r5T7UHrWd3wKB1XFvtfmmeRh/Nj7MBc8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L3RfWQKtcObz9XPUMGanrZUy3agNmbm8tmW0sDuzVEi5fAJDx4cARcmEMXvAt14dV/WgsrdwhRV+Gr3cuJz7QW+aSKtVYFQK/ox7zFV8oa7yTI8Z8+qaKnG94vwmSR5jG9PdkEbb2vCVMVbGI2vNtpO03Rio12SYa2yM1DalLHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=I5GmWUIJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ao4I4YZ6; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I5GmWUIJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ao4I4YZ6"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 5603FEC0FD8
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 13:53:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 10 Mar 2026 13:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773165191;
	 x=1773251591; bh=2++WyNmbWXOIifDARpabJqbYtctCdWm2J84NAHfjc8c=; b=
	I5GmWUIJfjbQgvuDtqRyY2nNar/G/hEzwVhYsdVWE0upBIX3ZuC9lhYPIh6NQuUm
	BHQlRRH0jtNnmP5sOD5PMZXWmg/a1mRDUpwy18vhZPTZ+svyJxFlGLpYatDqRT8t
	B+cp2yYNIezGFu5dxxdFzXuehmAK/nJXdGBfZztzGDRfBRKFDJ+6VBOzeZCBP7rL
	2wQFhkPUUSz0GCospBSgCiLH9w80xDR5XI5Gj8+yVkoPAwzb822txl/h3pG3R/cJ
	MXqxNEZaszp/Fzr3UlwERpexNtRWYP1eDjym9DXCL83DOWQ6Q4msK7ZsgAGbHlDS
	NkkolXfeUNS74i5vYE7wQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773165191; x=
	1773251591; bh=2++WyNmbWXOIifDARpabJqbYtctCdWm2J84NAHfjc8c=; b=a
	o4I4YZ63q7AS5k+CpDNDLd3+whxeGswEJ0xfcz+wAzn+lxKCD8Q/w/q3xXAe2cIM
	zIWqRZMPkMAtJO9s5/zNQ/t6Tt3c2FWyCus5CJKeMkuTK/OSJO1k6IWZIzag+Tws
	4RIg9PUMspsZt64Y8csvxrWlhbeaI+DA8axMJodWQ69sjFHUXX/E0+G4yXo8MFxv
	M+qQMQvE7N/UXcTl+t3X5hySsCa6OW/ldRNnASVGEHV8WygnO8wHn+LOn+yom5zR
	EwrPRBXiX7V42d5iWyjAr2U8kJESp6ceqR/VWIMSW1LZMQwvwX/2L1foTQXGcVL7
	JlXX6u5LhBsRWlZaL0mRw==
X-ME-Sender: <xms:h1qwaXVZtlLIQZr_eHr0JtDzT9ngQxUwewED_xqjKsX--6rDuCraUA>
    <xme:h1qwaWhJf6CaagQ_knvFeNPmjVGyQPN4k2_mJeAIz8xpW7gs9-lUXDWbVrKV5Pdy6
    1OsDfZ6GLxJphpmuhE5PMvxYoKmR3LBwsCqRZdkSp_39zkwFeZHSrs>
X-ME-Received: <xmr:h1qwaZAcKAoXQ-6hH5xtf6kIgm7oJJMdxTUw4lOxg6OCP6ZQJNmEuUoGxeS-cwVi2NurfkOLWeNUJRw-wBTG1_OxocVjeOlVx2G6ffGu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:h1qwaXcK8_m7B_rrDJ-37IZDfzJ-u2c9dFqKeAGtCVX573_i6CI2jQ>
    <xmx:h1qwaRdUu0CCwFGCIbsOwc8V79SMmLZ4CpBniL3cwwZLfPwwFIbyGg>
    <xmx:h1qwabhkLha5fyFKLMw1foUmGMj2FWHU39wSqiMLfU46jgLbqMuWgg>
    <xmx:h1qwadQ73Zg-x_YaV_7q4KFzvhDAtrumbhjgLYItIrmdCTThk88qbA>
    <xmx:h1qwaanlqhxkRy_V1m5jhZN2kxJ9y7jumkpigPfPLenM3haBEIVXuf_O>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 10 Mar 2026 13:53:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 083cee63 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 10 Mar 2026 17:53:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 10 Mar 2026 18:52:40 +0100
Subject: [PATCH 7/8] meson: compile compatibility sources separately
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-pks-build-infra-improvements-v1-7-ec75d0710d6a@pks.im>
References: <20260310-b4-pks-build-infra-improvements-v1-0-ec75d0710d6a@pks.im>
In-Reply-To: <20260310-b4-pks-build-infra-improvements-v1-0-ec75d0710d6a@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

In the next commit we're about to introduce a precompiled header for
"git-compat-util.h". The consequence of this change is that we'll
implicitly include that header for every compilation unit that uses the
precompiled headers.

This is okay for our "normal" library sources and our builtins. But some
of our compatibility sources do not include the header on purpose, and
doing so would cause compileir errors.

Prepare for this change by splitting out compatibility sources into
their static library. Like this we can selectively enable precompiled
headers for the library sources.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 79 +++++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 45 insertions(+), 34 deletions(-)

diff --git a/meson.build b/meson.build
index 604fe89d2d..cd00be1c23 100644
--- a/meson.build
+++ b/meson.build
@@ -271,6 +271,13 @@ version_gen_environment.set('GIT_VERSION', get_option('version'))
 
 compiler = meson.get_compiler('c')
 
+compat_sources = [
+  'compat/nonblock.c',
+  'compat/obstack.c',
+  'compat/open.c',
+  'compat/terminal.c',
+]
+
 libgit_sources = [
   'abspath.c',
   'add-interactive.c',
@@ -304,10 +311,6 @@ libgit_sources = [
   'commit.c',
   'common-exit.c',
   'common-init.c',
-  'compat/nonblock.c',
-  'compat/obstack.c',
-  'compat/open.c',
-  'compat/terminal.c',
   'compiler-tricks/not-constant.c',
   'config.c',
   'connect.c',
@@ -1163,7 +1166,7 @@ endif
 
 if not has_poll_h and not has_sys_poll_h
   libgit_c_args += '-DNO_POLL'
-  libgit_sources += 'compat/poll/poll.c'
+  compat_sources += 'compat/poll/poll.c'
   libgit_include_directories += 'compat/poll'
 endif
 
@@ -1179,7 +1182,7 @@ endif
 # implementation to threat things like drive prefixes specially.
 if host_machine.system() == 'windows' or not compiler.has_header('libgen.h')
   libgit_c_args += '-DNO_LIBGEN_H'
-  libgit_sources += 'compat/basename.c'
+  compat_sources += 'compat/basename.c'
 endif
 
 if compiler.has_header('paths.h')
@@ -1209,7 +1212,7 @@ if host_machine.system() != 'windows'
   foreach symbol : ['inet_ntop', 'inet_pton', 'hstrerror']
     if not compiler.has_function(symbol, dependencies: networking_dependencies)
       libgit_c_args += '-DNO_' + symbol.to_upper()
-      libgit_sources += 'compat/' + symbol + '.c'
+      compat_sources += 'compat/' + symbol + '.c'
     endif
   endforeach
 endif
@@ -1251,18 +1254,18 @@ else
 endif
 
 if host_machine.system() == 'darwin'
-  libgit_sources += 'compat/precompose_utf8.c'
+  compat_sources += 'compat/precompose_utf8.c'
   libgit_c_args += '-DPRECOMPOSE_UNICODE'
   libgit_c_args += '-DPROTECT_HFS_DEFAULT'
 endif
 
 # Configure general compatibility wrappers.
 if host_machine.system() == 'cygwin'
-  libgit_sources += [
+  compat_sources += [
     'compat/win32/path-utils.c',
   ]
 elif host_machine.system() == 'windows'
-  libgit_sources += [
+  compat_sources += [
     'compat/winansi.c',
     'compat/win32/dirent.c',
     'compat/win32/flush.c',
@@ -1289,20 +1292,20 @@ elif host_machine.system() == 'windows'
   libgit_include_directories += 'compat/win32'
   if compiler.get_id() == 'msvc'
     libgit_include_directories += 'compat/vcbuild/include'
-    libgit_sources += 'compat/msvc.c'
+    compat_sources += 'compat/msvc.c'
   else
-    libgit_sources += 'compat/mingw.c'
+    compat_sources += 'compat/mingw.c'
   endif
 endif
 
 if host_machine.system() == 'linux'
-  libgit_sources += 'compat/linux/procinfo.c'
+  compat_sources += 'compat/linux/procinfo.c'
 elif host_machine.system() == 'windows'
-  libgit_sources += 'compat/win32/trace2_win32_process_info.c'
+  compat_sources += 'compat/win32/trace2_win32_process_info.c'
 elif host_machine.system() == 'darwin'
-  libgit_sources += 'compat/darwin/procinfo.c'
+  compat_sources += 'compat/darwin/procinfo.c'
 else
-  libgit_sources += 'compat/stub/procinfo.c'
+  compat_sources += 'compat/stub/procinfo.c'
 endif
 
 if host_machine.system() == 'cygwin' or host_machine.system() == 'windows'
@@ -1315,13 +1318,13 @@ endif
 
 # Configure the simple-ipc subsystem required fro the fsmonitor.
 if host_machine.system() == 'windows'
-  libgit_sources += [
+  compat_sources += [
     'compat/simple-ipc/ipc-shared.c',
     'compat/simple-ipc/ipc-win32.c',
   ]
   libgit_c_args += '-DSUPPORTS_SIMPLE_IPC'
 else
-  libgit_sources += [
+  compat_sources += [
     'compat/simple-ipc/ipc-shared.c',
     'compat/simple-ipc/ipc-unix-socket.c',
   ]
@@ -1339,7 +1342,7 @@ if fsmonitor_backend != ''
   libgit_c_args += '-DHAVE_FSMONITOR_DAEMON_BACKEND'
   libgit_c_args += '-DHAVE_FSMONITOR_OS_SETTINGS'
 
-  libgit_sources += [
+  compat_sources += [
     'compat/fsmonitor/fsm-health-' + fsmonitor_backend + '.c',
     'compat/fsmonitor/fsm-ipc-' + fsmonitor_backend + '.c',
     'compat/fsmonitor/fsm-listen-' + fsmonitor_backend + '.c',
@@ -1355,7 +1358,7 @@ if not get_option('b_sanitize').contains('address') and get_option('regex').allo
 
   if compiler.get_define('REG_ENHANCED', prefix: '#include <regex.h>') != ''
     libgit_c_args += '-DUSE_ENHANCED_BASIC_REGULAR_EXPRESSIONS'
-    libgit_sources += 'compat/regcomp_enhanced.c'
+    compat_sources += 'compat/regcomp_enhanced.c'
   endif
 elif not get_option('regex').enabled()
   libgit_c_args += [
@@ -1364,7 +1367,7 @@ elif not get_option('regex').enabled()
     '-DNO_MBSUPPORT',
   ]
   build_options_config.set('NO_REGEX', '1')
-  libgit_sources += 'compat/regex/regex.c'
+  compat_sources += 'compat/regex/regex.c'
   libgit_include_directories += 'compat/regex'
 else
     error('Native regex support requested but not found')
@@ -1428,7 +1431,7 @@ else
 
   if get_option('b_sanitize').contains('address')
     libgit_c_args += '-DNO_MMAP'
-    libgit_sources += 'compat/mmap.c'
+    compat_sources += 'compat/mmap.c'
   else
     checkfuncs += { 'mmap': ['mmap.c'] }
   endif
@@ -1438,7 +1441,7 @@ foreach func, impls : checkfuncs
   if not compiler.has_function(func)
     libgit_c_args += '-DNO_' + func.to_upper()
     foreach impl : impls
-      libgit_sources += 'compat/' + impl
+      compat_sources += 'compat/' + impl
     endforeach
   endif
 endforeach
@@ -1449,13 +1452,13 @@ endif
 
 if not compiler.has_function('strdup')
   libgit_c_args += '-DOVERRIDE_STRDUP'
-  libgit_sources += 'compat/strdup.c'
+  compat_sources += 'compat/strdup.c'
 endif
 
 if not compiler.has_function('qsort')
   libgit_c_args += '-DINTERNAL_QSORT'
 endif
-libgit_sources += 'compat/qsort_s.c'
+compat_sources += 'compat/qsort_s.c'
 
 if compiler.has_function('getdelim')
   libgit_c_args += '-DHAVE_GETDELIM'
@@ -1511,7 +1514,7 @@ if meson.can_run_host_binaries() and compiler.run('''
   }
 ''', name: 'fread reads directories').returncode() == 0
   libgit_c_args += '-DFREAD_READS_DIRECTORIES'
-  libgit_sources += 'compat/fopen.c'
+  compat_sources += 'compat/fopen.c'
 endif
 
 if not meson.is_cross_build() and fs.exists('/dev/tty')
@@ -1745,14 +1748,22 @@ else
 endif
 
 libgit = declare_dependency(
-  link_with: static_library('git',
-    sources: libgit_sources,
-    c_args: libgit_c_args + [
-      '-DGIT_VERSION_H="' + version_def_h.full_path() + '"',
-    ],
-    dependencies: libgit_dependencies,
-    include_directories: libgit_include_directories,
-  ),
+  link_with: [
+    static_library('compat',
+      sources: compat_sources,
+      c_args: libgit_c_args,
+      dependencies: libgit_dependencies,
+      include_directories: libgit_include_directories,
+    ),
+    static_library('git',
+      sources: libgit_sources,
+      c_args: libgit_c_args + [
+        '-DGIT_VERSION_H="' + version_def_h.full_path() + '"',
+      ],
+      dependencies: libgit_dependencies,
+      include_directories: libgit_include_directories,
+    ),
+  ],
   compile_args: libgit_c_args,
   dependencies: libgit_dependencies,
   include_directories: libgit_include_directories,

-- 
2.53.0.880.g73c4285caa.dirty

