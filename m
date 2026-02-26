Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7382223AE62
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 00:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772065658; cv=none; b=YA5KOJhG943WSEjh/eL5VB+0URd844MtCr0FmVJw6hMe+eqlpzR/qcYeVxQbJy2u2vVRkWOaKmoq+l/+dC0bQLfDIoVvTFIckZKqvPBVi35qeLvgosCHD2rK8OrGzPP83eRZrAlSrDKyEAsvbPk0lnYhQEVqwztbwficcyIJYl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772065658; c=relaxed/simple;
	bh=ZLx2c04PFImLnKHQylfcbs/UdC5V3rUUnblqXQwk2Fg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=V4ns976fxCPnRDZjrg2qPj3VXxUvNnU3H5WZoDLGOcfPX8Sdu7VxYoxotBqgNzfN0zZ+AVYMvHleX/IbtJB4FBRfsM3JELVa0Fb1YBorvEAegGfWHD4NEEBB8zm2dNb7hgouTrjqPo/K3TquitrkLoFqroy5TjetEjEk5CkcrU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPZ/uvgy; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPZ/uvgy"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2bdc4f2b680so217167eec.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 16:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772065656; x=1772670456; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxdC20Gc7Z/EM3LIkiO8duLbEzl2MGj1Xhoi/26ll+w=;
        b=EPZ/uvgy1Dke1r5TDI+XAIbjjYAMshpq6vGoSwQALgH1nok/CGLAuE/Cyk/8awH9OS
         RX5343TVXgP9rIgvnZz7wkM3K2PB3bAvu70TU4QaBBpOIEmb1YJ9udHW7DX/de4xNMHi
         jgulKwLabgzuw3Md3+IKTfQhRMVEGYE7vgX9b+KDWYgesxu5VMkQ5lNwCw/j94ZIf3lH
         X0JDypFG5ErxsdRWBXWmGMVig0BAE3UUNSP9kOloeA9S8lKZUk3+LylrMq6pEP+ZjAIx
         tIt29JTKdqPFtKcn0lI10P5Pfivt5ba7eSTNGpTEandH+ZGh0ED0XauVuttH5JXYaDBC
         F0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772065656; x=1772670456;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qxdC20Gc7Z/EM3LIkiO8duLbEzl2MGj1Xhoi/26ll+w=;
        b=nOP4rULkgTVX4/MQgiDsNBTP0fMgbbJaXvg0yAf3Ecye+jAcB49ThOyipCc6LXnNhl
         4sPa35xgqHyHYHjCLR3uO1kFnmvvr9jJveEwD7+DgR5/GwnTla/BcwlTCvkqm5o2gh35
         C+Nn8q0Sn5G0wX2tzxVOMQfrm0hIjVvROimayZYB7gMhZE9gwBRKcb21F7SkEbOdUkIC
         KSKkj3LZSw6wgABANGkS6fXx5x9AMlmSHBBvzvRi2b1cLuuaKy6m5SMWWKgs0JvDN/bY
         iK+2t81k44XDsN3KjW86DLlo/j+kKPjUECd+0s2S1b4j0KKE+EgU4k+zFSHXrumwfJVY
         wjbQ==
X-Gm-Message-State: AOJu0YyZOUHqsoLMY/HslhhB0990DJjWU275ulLci5c7KI79v6jIcFLa
	KaRc0xZh2y2R5scom7eYq2a0FDKo/7DQM7IyApWd/L/1bdzQaRPDQbKFxlRXzDxj
X-Gm-Gg: ATEYQzyOpfhoaQki1lnDDBnd4sbLCf8R9gtBgmsNlSP2amH2+D1roUNwr6yq5Khkzks
	4lfPEJo734+d9WJswZl8DculgtRT9HtpHK6wn1vAfOm8JV9RcQX50Su7Q9MKURk4koSv1h++BVO
	t4AYiyJ+EaNXKlaROWFoIyGpIGku22IJEmH4XGW7c/u7ziYh7oeSIAW3XF3J+QXFkJ7bLWE0FiR
	gBQucD0Br9WI5yaS6xnEHuCheWnMk5gDpT6zYpsr33vdqi7n4awKCPGjblq6nDfrirjKs9Rn5be
	+gkLf7KDMK9GL8CLGvN4rGuFgeWDxrsS5RkWrDuqrD4bHJ1r+7LBWhu6SgTA8JrrqztBAj6g7MS
	UUZSm2adpwXhJkjh+OCc/QzE5IDHfxFB1aA1SpDzX4xhXLmiICybpcdH8/yFMM9u7khiXIu4vmk
	k9NcSqTTArTBGyxPCNCRqzODUsQg==
X-Received: by 2002:a05:7301:1295:b0:2bd:cbc7:16ec with SMTP id 5a478bee46e88-2bdd3017066mr188357eec.24.1772065656114;
        Wed, 25 Feb 2026 16:27:36 -0800 (PST)
Received: from [127.0.0.1] ([52.159.229.150])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1f46c21sm480089eec.23.2026.02.25.16.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 16:27:35 -0800 (PST)
Message-Id: <0a83bb9c8e71f6c388a50eb62afd03680020eb94.1772065643.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v7.git.git.1772065643.gitgitgadget@gmail.com>
References: <pull.2147.v6.git.git.1772050636.gitgitgadget@gmail.com>
	<pull.2147.v7.git.git.1772065643.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Feb 2026 00:27:19 +0000
Subject: [PATCH v7 06/10] fsmonitor: deduplicate settings logic for Unix
 platforms
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Paul Tarjan <github@paulisageek.com>,
    Paul Tarjan <github@paulisageek.com>

From: Paul Tarjan <github@paulisageek.com>

The macOS fsm-settings-darwin.c is applicable to other Unix variants
as well.  Rename it to fsm-settings-unix.c, using the safer
xstrdup()+dirname() approach and including the "vfat" filesystem check.

Now that both fsm-ipc and fsm-settings use the "unix" variant name,
set FSMONITOR_OS_SETTINGS to "unix" for macOS in config.mak.uname and
remove the if/else conditionals from the build files.

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 Makefile                                      |  6 +----
 ...-settings-darwin.c => fsm-settings-unix.c} | 24 +++++++++++-------
 config.mak.uname                              |  2 +-
 contrib/buildsystems/CMakeLists.txt           | 25 +++++++++----------
 meson.build                                   | 14 +++++------
 5 files changed, 35 insertions(+), 36 deletions(-)
 rename compat/fsmonitor/{fsm-settings-darwin.c => fsm-settings-unix.c} (82%)

diff --git a/Makefile b/Makefile
index 7480ce3e1d..062347997a 100644
--- a/Makefile
+++ b/Makefile
@@ -2365,15 +2365,11 @@ ifdef FSMONITOR_DAEMON_BACKEND
 	COMPAT_CFLAGS += -DHAVE_FSMONITOR_DAEMON_BACKEND
 	COMPAT_OBJS += compat/fsmonitor/fsm-listen-$(FSMONITOR_DAEMON_BACKEND).o
 	COMPAT_OBJS += compat/fsmonitor/fsm-health-$(FSMONITOR_DAEMON_BACKEND).o
-ifeq ($(FSMONITOR_DAEMON_BACKEND),win32)
-	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-win32.o
-else
-	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-unix.o
-endif
 endif
 
 ifdef FSMONITOR_OS_SETTINGS
 	COMPAT_CFLAGS += -DHAVE_FSMONITOR_OS_SETTINGS
+	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-$(FSMONITOR_OS_SETTINGS).o
 	COMPAT_OBJS += compat/fsmonitor/fsm-settings-$(FSMONITOR_OS_SETTINGS).o
 	COMPAT_OBJS += compat/fsmonitor/fsm-path-utils-$(FSMONITOR_DAEMON_BACKEND).o
 endif
diff --git a/compat/fsmonitor/fsm-settings-darwin.c b/compat/fsmonitor/fsm-settings-unix.c
similarity index 82%
rename from compat/fsmonitor/fsm-settings-darwin.c
rename to compat/fsmonitor/fsm-settings-unix.c
index a382590635..27d89207af 100644
--- a/compat/fsmonitor/fsm-settings-darwin.c
+++ b/compat/fsmonitor/fsm-settings-unix.c
@@ -5,7 +5,7 @@
 #include "fsmonitor-settings.h"
 #include "fsmonitor-path-utils.h"
 
- /*
+/*
  * For the builtin FSMonitor, we create the Unix domain socket for the
  * IPC in the .git directory.  If the working directory is remote,
  * then the socket will be created on the remote file system.  This
@@ -22,25 +22,31 @@
  * The builtin FSMonitor uses a Unix domain socket in the .git
  * directory for IPC.  These Windows drive formats do not support
  * Unix domain sockets, so mark them as incompatible for the daemon.
- *
  */
 static enum fsmonitor_reason check_uds_volume(struct repository *r)
 {
 	struct fs_info fs;
 	const char *ipc_path = fsmonitor_ipc__get_path(r);
-	struct strbuf path = STRBUF_INIT;
-	strbuf_add(&path, ipc_path, strlen(ipc_path));
+	char *path;
+	char *dir;
+
+	/*
+	 * Create a copy for dirname() since it may modify its argument.
+	 */
+	path = xstrdup(ipc_path);
+	dir = dirname(path);
 
-	if (fsmonitor__get_fs_info(dirname(path.buf), &fs) == -1) {
-		strbuf_release(&path);
+	if (fsmonitor__get_fs_info(dir, &fs) == -1) {
+		free(path);
 		return FSMONITOR_REASON_ERROR;
 	}
 
-	strbuf_release(&path);
+	free(path);
 
 	if (fs.is_remote ||
-		!strcmp(fs.typename, "msdos") ||
-		!strcmp(fs.typename, "ntfs")) {
+	    !strcmp(fs.typename, "msdos") ||
+	    !strcmp(fs.typename, "ntfs") ||
+	    !strcmp(fs.typename, "vfat")) {
 		free(fs.typename);
 		return FSMONITOR_REASON_NOSOCKETS;
 	}
diff --git a/config.mak.uname b/config.mak.uname
index 3c35ae33a3..33877020e9 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -165,7 +165,7 @@ ifeq ($(uname_S),Darwin)
         ifndef NO_PTHREADS
         ifndef NO_UNIX_SOCKETS
 	FSMONITOR_DAEMON_BACKEND = darwin
-	FSMONITOR_OS_SETTINGS = darwin
+	FSMONITOR_OS_SETTINGS = unix
         endif
         endif
 
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 32ef6ebe1b..4099f9a951 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -291,23 +291,22 @@ endif()
 
 if(SUPPORTS_SIMPLE_IPC)
 	if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
-		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-win32.c)
-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-win32.c)
-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-win32.c)
-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-win32.c)
-
-		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-win32.c)
+		set(FSMONITOR_DAEMON_BACKEND "win32")
+		set(FSMONITOR_OS_SETTINGS "win32")
 	elseif(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
+		set(FSMONITOR_DAEMON_BACKEND "darwin")
+		set(FSMONITOR_OS_SETTINGS "unix")
+	endif()
+
+	if(FSMONITOR_DAEMON_BACKEND)
 		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-darwin.c)
-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-darwin.c)
-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-unix.c)
-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-darwin.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-${FSMONITOR_DAEMON_BACKEND}.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-${FSMONITOR_DAEMON_BACKEND}.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-${FSMONITOR_DAEMON_BACKEND}.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-${FSMONITOR_OS_SETTINGS}.c)
 
 		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-darwin.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-${FSMONITOR_OS_SETTINGS}.c)
 	endif()
 endif()
 
diff --git a/meson.build b/meson.build
index 8de795f9d4..589624f399 100644
--- a/meson.build
+++ b/meson.build
@@ -1320,10 +1320,13 @@ else
 endif
 
 fsmonitor_backend = ''
+fsmonitor_os = ''
 if host_machine.system() == 'windows'
   fsmonitor_backend = 'win32'
+  fsmonitor_os = 'win32'
 elif host_machine.system() == 'darwin'
   fsmonitor_backend = 'darwin'
+  fsmonitor_os = 'unix'
   libgit_dependencies += dependency('CoreServices')
 endif
 if fsmonitor_backend != ''
@@ -1334,17 +1337,12 @@ if fsmonitor_backend != ''
     'compat/fsmonitor/fsm-health-' + fsmonitor_backend + '.c',
     'compat/fsmonitor/fsm-listen-' + fsmonitor_backend + '.c',
     'compat/fsmonitor/fsm-path-utils-' + fsmonitor_backend + '.c',
-    'compat/fsmonitor/fsm-settings-' + fsmonitor_backend + '.c',
+    'compat/fsmonitor/fsm-ipc-' + fsmonitor_os + '.c',
+    'compat/fsmonitor/fsm-settings-' + fsmonitor_os + '.c',
   ]
-
-  if fsmonitor_backend == 'win32'
-    libgit_sources += 'compat/fsmonitor/fsm-ipc-win32.c'
-  else
-    libgit_sources += 'compat/fsmonitor/fsm-ipc-unix.c'
-  endif
 endif
 build_options_config.set_quoted('FSMONITOR_DAEMON_BACKEND', fsmonitor_backend)
-build_options_config.set_quoted('FSMONITOR_OS_SETTINGS', fsmonitor_backend)
+build_options_config.set_quoted('FSMONITOR_OS_SETTINGS', fsmonitor_os)
 
 if not get_option('b_sanitize').contains('address') and get_option('regex').allowed() and compiler.has_header('regex.h') and compiler.get_define('REG_STARTEND', prefix: '#include <regex.h>') != ''
   build_options_config.set('NO_REGEX', '')
-- 
gitgitgadget

