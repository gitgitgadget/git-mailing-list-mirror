Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6952D8396
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 20:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772050648; cv=none; b=o7kowBtv1Oi7C0T+XAVoAmMMD9m8fas8CUjT8+VPqa9puXXy4vEHto3EeQl2oy+ot6Fj8hxc4ObUBRDMAJ1Sy8V6ydLzL7y1Wg934tQ0BVoXvmht+QznQMUD8/RYuvsNLNQzjN0FAuicEXff0kWXFcBxySk9FAsq7jGjssNGe2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772050648; c=relaxed/simple;
	bh=WoVwBebDLP1L58D3yfXpkZur/VvRYBObhRH9oOXi9tM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dz5ubMN44IOQa4+CvWxoxEu07Ij5v1LlDEoArlxWvn+L4NU5AihgYxgARIUhcsAWYhiDNbwdQgGWjMdFYv5zr79oPxwB11Xx9YAjxACu6BOuZbyPf7n31dLsxfJaELPfmHC5YIcpaTj5ezQ/q8pJv1npXrRkISWf+lL+2Kme0Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnIbHXqr; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnIbHXqr"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8cb49f63238so1433085a.0
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 12:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772050646; x=1772655446; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e16B2hYSwiuWwHC4muzll+PUd3JxZKb+DKnX51j0lBI=;
        b=MnIbHXqrPYD4WQLJ2qbmM/ACzUQqBLvJlrZ2Yt35cAMVFHynSy5ONMHLaaHb9JmH/I
         lCznAmCOV+jI9kpS2qVXXSIaFB4YNxEpGWVuXMnXCoYi1Ot3lYzuKKgPa/HDEawSdV/I
         4cTN5OHxfy5uynfNZ54oR3C/vFKz1Uq70Xigp4BbZhTsBtagNWggEjGGwT32Hsp5ufnx
         F/u8U7cjZy6Wp2Hu3X46ur+cJd60SL8Lt3/0FIWyK8w1B1ds0rO50OkNepOhp6RIi9ss
         4NKjYEqUdoYnaxBUvvOqKKl4BaYLusq/ZJa9jRO0Q5gA+4MtMAWzqh+ZTu7BWJ+SbFd6
         TiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772050646; x=1772655446;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e16B2hYSwiuWwHC4muzll+PUd3JxZKb+DKnX51j0lBI=;
        b=TOrLWwAdVfQZGdMSsasrrV8OuFicGNTNrV5+5B+Mc28efPdRIwDgJ2E22UyzszaELu
         Xkbh22JiWpHDRSBUdLfi9C5n6KnRRGPa8io0KHfXXQeCchEjWy9Bnw9OSs6BghdcdEaa
         z55FeiHqeFg3UYQgG6+pv+0+m2R8e+7CJEQ7S0U8EAg1cNIE9pWh+l8EGpAW0YYFte9T
         B+jJuAWuq1p1cmUCEDit+kxxP+XHOrE+vObz7iBoAfT8Do32N5Q6DrU5UQ7jlsOWBTXJ
         6sCQtiCVGd29B+14x08aySyxmLw42T9wIlf6nHyvAa//ypX6kWhyOH6sFJ8Lf302KiK8
         7A5A==
X-Gm-Message-State: AOJu0Yx7MYlT9uAF/mCAmL0k7Tr48LTRJmt+RAYpp0lJ/dRO/n38PUqc
	NNNn1E+Qz1Vuv4GIWcMRv0z0FY/kB0TwZWniOoPk45GkqP5mgD3UnzY80DTW3w==
X-Gm-Gg: ATEYQzympARycXDOKXe+Wctmo1/raGm+YRPGAG+1yUUt4NRHTOGix6sLyyQfgBhBA+l
	h+KdsOSCbAV6fHM1KzYfWHtthQdGSU7d1hvJpvCPSlbjGXCkGuk71UI1G05xD0o5PFxw4EvL5zC
	tJwOiRHg+gWqjIUf4bXjWWjVkbd16SaVknKSxJ11V1iAKjm1BbG1FMgkfWj7jNBF6ey/N9GY7YQ
	GDKfZ7STUVIyrkaOCCOUVj1cnZwI++Ry99hRtgedT9nC5V11H1RIcphMcZQiQnXLEwIfKh7mHSt
	38d0Q+F+Mwc+EZIt0iEEdhNSpZGpTNrO1W/JcWE4QGw02ugNEejFxkGC5iCqMOyfYrOLJfd27Ne
	BoWIMtjg+JI5lwd9kxB749U1hhA9WJsx9uzgId92RUdU9h8zB74sftxm1JM5fcK595Oi5kDywin
	ICnVB5J9Eq/XTRFJiuQq6CFqb1pQ==
X-Received: by 2002:a05:620a:bc2:b0:8cb:3fb3:7bee with SMTP id af79cd13be357-8cb8ca65f6emr2165643785a.51.1772050645437;
        Wed, 25 Feb 2026 12:17:25 -0800 (PST)
Received: from [127.0.0.1] ([135.119.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf731c0bsm13466185a.45.2026.02.25.12.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 12:17:24 -0800 (PST)
Message-Id: <39da1e6be359a23ddad8f099d427823a774324f7.1772050636.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v6.git.git.1772050636.gitgitgadget@gmail.com>
References: <pull.2147.v5.git.git.1771896704209.gitgitgadget@gmail.com>
	<pull.2147.v6.git.git.1772050636.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Feb 2026 20:17:12 +0000
Subject: [PATCH v6 06/10] fsmonitor: deduplicate settings logic for Unix
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

The fsmonitor settings logic for checking Unix domain socket
compatibility is nearly identical between macOS and Linux.  Both check
whether the IPC socket directory resides on a remote filesystem or a
filesystem that does not support Unix domain sockets (NTFS, FAT32, etc).

Merge the two implementations into a single fsm-settings-unix.c shared
by both platforms.  The unified version uses the safer xstrdup() +
dirname() approach from the macOS implementation (avoiding strbuf
mutation with dirname()) and includes the "vfat" filesystem check.

Update Makefile, meson.build, and CMakeLists.txt to use the new shared
file for non-Windows platforms.

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 Makefile                                      |  6 ++++-
 ...-settings-darwin.c => fsm-settings-unix.c} | 24 ++++++++++++-------
 contrib/buildsystems/CMakeLists.txt           |  2 +-
 meson.build                                   | 11 ++++++---
 4 files changed, 29 insertions(+), 14 deletions(-)
 rename compat/fsmonitor/{fsm-settings-darwin.c => fsm-settings-unix.c} (82%)

diff --git a/Makefile b/Makefile
index 2157bbf173..febdaeb42c 100644
--- a/Makefile
+++ b/Makefile
@@ -2374,7 +2374,11 @@ endif
 
 ifdef FSMONITOR_OS_SETTINGS
 	COMPAT_CFLAGS += -DHAVE_FSMONITOR_OS_SETTINGS
-	COMPAT_OBJS += compat/fsmonitor/fsm-settings-$(FSMONITOR_OS_SETTINGS).o
+ifeq ($(FSMONITOR_OS_SETTINGS),win32)
+	COMPAT_OBJS += compat/fsmonitor/fsm-settings-win32.o
+else
+	COMPAT_OBJS += compat/fsmonitor/fsm-settings-unix.o
+endif
 	COMPAT_OBJS += compat/fsmonitor/fsm-path-utils-$(FSMONITOR_OS_SETTINGS).o
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
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 32ef6ebe1b..0eba0c2c98 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -307,7 +307,7 @@ if(SUPPORTS_SIMPLE_IPC)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-darwin.c)
 
 		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-darwin.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-unix.c)
 	endif()
 endif()
 
diff --git a/meson.build b/meson.build
index 8de795f9d4..e02f9708da 100644
--- a/meson.build
+++ b/meson.build
@@ -1334,13 +1334,18 @@ if fsmonitor_backend != ''
     'compat/fsmonitor/fsm-health-' + fsmonitor_backend + '.c',
     'compat/fsmonitor/fsm-listen-' + fsmonitor_backend + '.c',
     'compat/fsmonitor/fsm-path-utils-' + fsmonitor_backend + '.c',
-    'compat/fsmonitor/fsm-settings-' + fsmonitor_backend + '.c',
   ]
 
   if fsmonitor_backend == 'win32'
-    libgit_sources += 'compat/fsmonitor/fsm-ipc-win32.c'
+    libgit_sources += [
+      'compat/fsmonitor/fsm-ipc-win32.c',
+      'compat/fsmonitor/fsm-settings-win32.c',
+    ]
   else
-    libgit_sources += 'compat/fsmonitor/fsm-ipc-unix.c'
+    libgit_sources += [
+      'compat/fsmonitor/fsm-ipc-unix.c',
+      'compat/fsmonitor/fsm-settings-unix.c',
+    ]
   endif
 endif
 build_options_config.set_quoted('FSMONITOR_DAEMON_BACKEND', fsmonitor_backend)
-- 
gitgitgadget

