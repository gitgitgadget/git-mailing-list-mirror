Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4365222258C
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 01:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772673392; cv=none; b=bylN/xxModb2Fl+R46asMLZGuNxxC4RNMah/MU0vQWEySDfxDUmFPo59kBwfV62jDLCvUA80dFAEVhfiZwQ8mUEixaCySLO32pHNuT5dUCEOxfQ0EjmVi/cF35l0pGoSfj0vxhizU4ilLade/SjXQpvJo8DOp0zDgBUW0hPhqMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772673392; c=relaxed/simple;
	bh=EsgHUGDMRhuks515iSzmHNeqU4szO86Gm6UxEyphQ9E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PKQQxr5wkcSjDzjb0vlJP4epXFKdJG0eloO35HOFpGTbcOy+45nkhwzWz/r8dRHZ9O8Cgwv4bGKGwQa3EufEqjwzb9ndz+wQzVgqeUHGzh7PtLyF9MHPg8OWehAYflYxAycc+23KbKjjM4nabloQNEe+VlVGzzYyQKgDRJiPn0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJPOBjk+; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJPOBjk+"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-899d6b7b073so75298496d6.2
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 17:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772673390; x=1773278190; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfq55mn7MJ04jqjtTP4/AbbAEktb2oJtSvHfgUnB3sY=;
        b=QJPOBjk+6Ntki+CavNgp67kmmQ7gvamlxhFQdFfwj31bQ62pSnoWqFLJ4zJzIRznLP
         4QhGfCqdM/bqNqkrYDHKzNqtt16WEfaLMnLafRJvZ7Dh7kMu2wWnhLuOlXqTlSxI/PyB
         1uLQrtNK4w+LPmEY9Ewfz6LPDhaopQKTahBzOB1xiydljI+1vp47btdhnhVvf7QobpPZ
         bSNqOGzHCrJfsQSDeAOnzHUK+fxuP6Rb2CC7FrRzyiScnWLwqzjHdkOW+gDY9+hPSIQ5
         wcpLxNCkRSXlCHMs41wvoQfdosnZ2kIwoWre9/R1WGhZWOpwfymna+pzEzeiE6lMr4FE
         rLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772673390; x=1773278190;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hfq55mn7MJ04jqjtTP4/AbbAEktb2oJtSvHfgUnB3sY=;
        b=iDJ80hBrhuht6wncSu7xUQZV6rFVriX//BDSzmRpXNQvSQ8xvY5tRm5lMchSJ27wTJ
         hkH0y6Jed40ZiUnHknBstdUrjZ3XyZVJGxsjgqxgh85lXbqzIFNgV3aaYyxNHos9Q76f
         gmoh57pKQekoy4CF7n9WQwq41Ui9URTYb814FnhbHXh9Rhib+S0xkJjF+WmGukcu1IOF
         7dS0OvI31RgwJcakns0aCkLnnmWJ/ShH46vEpi7xePnoOo54HjVr/eQTyz9swUK7Ha64
         ofGZsxZgxBKK5hwhELxOj3QDn/hH35QKN3Cotz2xl+iOF9Nhov1A7oWpdQsJlTopi4Fz
         HDuA==
X-Gm-Message-State: AOJu0YzotLKHMLUJeQyJehjRzw5Aj0cc0YEjFAwAiOjFH8YuIH+jMZ4X
	PHA/sTTCX8k6uIRAENjTGtgUbVMQd3rDGyAJxWu5sdEwz38She6U3ocbxmGTL8xM
X-Gm-Gg: ATEYQzyJXYE5N59cHbuYnlQNJ7J85DK7c4skff5HcY+7Ccun0nmx9vJEeyr0a2rOn0j
	jH7g8RX2uUFUATnQ7w9VVBpkk0TEzMp3A8lNPV0gThKa51KqgI7+FNtNKL+2dj9h7qck9jxCgEF
	yvEawgBSkDAlLx6K44H+B3h6syE9SoNGtGDRPGoA/0VOlsOsz2drfe1ug+mVB6oa8p3KThwvuDc
	5IwUYtiUuB/WFJlRiW9pgGYVkfHr/4lhhK299c1E5EEnF3lzkvy6ZO0pn0Ac7SFvs7GTXFVV/XW
	c/HlhrletOQ0Qnffc74TA8RmzvOa22HddZ08rGy3N0UJZQ2N8dJQb/PVZnDOCSxVPyRFi35cIWu
	8sw70UJc7F0wusZ7m0FVKt2znNOPSlkxJNwANVcDBUMKGgOHy6gigzHDHDdHtHt93m6eJu7/hWH
	ohZZ47hMKM24/V1I/2m1R0ozFuKDA4Piufmg==
X-Received: by 2002:a05:6214:262c:b0:89a:9b1:a21a with SMTP id 6a1803df08f44-89a19ab8d0dmr57265056d6.25.1772673389787;
        Wed, 04 Mar 2026 17:16:29 -0800 (PST)
Received: from [127.0.0.1] ([51.8.152.229])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a05b72186sm63815676d6.50.2026.03.04.17.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 17:16:28 -0800 (PST)
Message-Id: <dec0fb144f9ea4efe8d15526b376f51ef470ed5d.1772673378.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v10.git.git.1772673378.gitgitgadget@gmail.com>
References: <pull.2147.v9.git.git.1772671920.gitgitgadget@gmail.com>
	<pull.2147.v10.git.git.1772673378.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Mar 2026 01:16:11 +0000
Subject: [PATCH v10 05/12] fsmonitor: rename fsm-ipc-darwin.c to
 fsm-ipc-unix.c
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
    Paul Tarjan <paul@paultarjan.com>,
    Paul Tarjan <github@paulisageek.com>,
    Paul Tarjan <github@paulisageek.com>

From: Paul Tarjan <github@paulisageek.com>

The fsmonitor IPC path logic in fsm-ipc-darwin.c is not
Darwin-specific and will be reused by the upcoming Linux
implementation.  Rename it to fsm-ipc-unix.c to reflect that it
is shared by all Unix platforms.

Introduce FSMONITOR_OS_SETTINGS (set to "unix" for non-Windows, "win32"
for Windows) as a separate variable from FSMONITOR_DAEMON_BACKEND so
that the build files can distinguish between platform-specific files
(listen, health, path-utils) and shared Unix files (ipc, settings).

Move fsm-ipc to the FSMONITOR_OS_SETTINGS section in the Makefile, and
switch fsm-path-utils to use FSMONITOR_DAEMON_BACKEND since path-utils
is platform-specific (there will be separate darwin and linux versions).

Based-on-patch-by: Eric DeCosta <edecosta@mathworks.com>
Based-on-patch-by: Marziyeh Esipreh <marziyeh.esipreh@gmail.com>
Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 Makefile                                      |  6 ++---
 .../{fsm-ipc-darwin.c => fsm-ipc-unix.c}      |  0
 config.mak.uname                              |  2 +-
 contrib/buildsystems/CMakeLists.txt           | 25 +++++++++----------
 meson.build                                   |  7 ++++--
 5 files changed, 21 insertions(+), 19 deletions(-)
 rename compat/fsmonitor/{fsm-ipc-darwin.c => fsm-ipc-unix.c} (100%)

diff --git a/Makefile b/Makefile
index 8aa489f3b6..080d009bf0 100644
--- a/Makefile
+++ b/Makefile
@@ -417,7 +417,7 @@ include shared.mak
 # If your platform has OS-specific ways to tell if a repo is incompatible with
 # fsmonitor (whether the hook or IPC daemon version), set FSMONITOR_OS_SETTINGS
 # to the "<name>" of the corresponding `compat/fsmonitor/fsm-settings-<name>.c`
-# that implements the `fsm_os_settings__*()` routines.
+# and `compat/fsmonitor/fsm-ipc-<name>.c` files.
 #
 # Define LINK_FUZZ_PROGRAMS if you want `make all` to also build the fuzz test
 # programs in oss-fuzz/.
@@ -2365,13 +2365,13 @@ ifdef FSMONITOR_DAEMON_BACKEND
 	COMPAT_CFLAGS += -DHAVE_FSMONITOR_DAEMON_BACKEND
 	COMPAT_OBJS += compat/fsmonitor/fsm-listen-$(FSMONITOR_DAEMON_BACKEND).o
 	COMPAT_OBJS += compat/fsmonitor/fsm-health-$(FSMONITOR_DAEMON_BACKEND).o
-	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-$(FSMONITOR_DAEMON_BACKEND).o
 endif
 
 ifdef FSMONITOR_OS_SETTINGS
 	COMPAT_CFLAGS += -DHAVE_FSMONITOR_OS_SETTINGS
+	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-$(FSMONITOR_OS_SETTINGS).o
 	COMPAT_OBJS += compat/fsmonitor/fsm-settings-$(FSMONITOR_OS_SETTINGS).o
-	COMPAT_OBJS += compat/fsmonitor/fsm-path-utils-$(FSMONITOR_OS_SETTINGS).o
+	COMPAT_OBJS += compat/fsmonitor/fsm-path-utils-$(FSMONITOR_DAEMON_BACKEND).o
 endif
 
 ifdef WITH_BREAKING_CHANGES
diff --git a/compat/fsmonitor/fsm-ipc-darwin.c b/compat/fsmonitor/fsm-ipc-unix.c
similarity index 100%
rename from compat/fsmonitor/fsm-ipc-darwin.c
rename to compat/fsmonitor/fsm-ipc-unix.c
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
index 28877feb9d..6197d5729c 100644
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
-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-darwin.c)
-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-darwin.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-${FSMONITOR_DAEMON_BACKEND}.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-${FSMONITOR_DAEMON_BACKEND}.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-${FSMONITOR_OS_SETTINGS}.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-${FSMONITOR_DAEMON_BACKEND}.c)
 
 		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-darwin.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-${FSMONITOR_DAEMON_BACKEND}.c)
 	endif()
 endif()
 
diff --git a/meson.build b/meson.build
index dd52efd1c8..86a68365a9 100644
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
@@ -1332,14 +1335,14 @@ if fsmonitor_backend != ''
 
   libgit_sources += [
     'compat/fsmonitor/fsm-health-' + fsmonitor_backend + '.c',
-    'compat/fsmonitor/fsm-ipc-' + fsmonitor_backend + '.c',
+    'compat/fsmonitor/fsm-ipc-' + fsmonitor_os + '.c',
     'compat/fsmonitor/fsm-listen-' + fsmonitor_backend + '.c',
     'compat/fsmonitor/fsm-path-utils-' + fsmonitor_backend + '.c',
     'compat/fsmonitor/fsm-settings-' + fsmonitor_backend + '.c',
   ]
 endif
 build_options_config.set_quoted('FSMONITOR_DAEMON_BACKEND', fsmonitor_backend)
-build_options_config.set_quoted('FSMONITOR_OS_SETTINGS', fsmonitor_backend)
+build_options_config.set_quoted('FSMONITOR_OS_SETTINGS', fsmonitor_os)
 
 if not get_option('b_sanitize').contains('address') and get_option('regex').allowed() and compiler.has_header('regex.h') and compiler.get_define('REG_STARTEND', prefix: '#include <regex.h>') != ''
   build_options_config.set('NO_REGEX', '')
-- 
gitgitgadget

