Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA7E238C36
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 00:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772065649; cv=none; b=rvNqxdVuX/Ek6YLwnGuxjCyw7BCr5DEVBIyD5448U8kwLj2noBxitSvUauHpL3Z/CPTWj8fEBTg8Su7S7cjBWfsETZMSQEtbcoFQrrtgSUdtNpRdJmRQs4ivoFr7GKgFMFQASgyH08e7ZI4U+UbkoEur/trxdiGHnlfQEOVVb1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772065649; c=relaxed/simple;
	bh=NkAe0rCq1OaZ7iG65bee+Jj3Gj+pegTHchY9COTowlg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bzhxC30RcOFj7pIFwh8XKv82mpEwh48bBXvJu2nl8o4Lmmj4bcX0EKE94TrtrOoQVjEmHjfN95Cj5GXyNGWFMGVY2s5cya/pX317mpX1/i4797L9lQJN+6Yx2G2N+5ZNion4lvrQvtJYvjKpY+yJcsFobvmjGjatiX9dBK/nZY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=am3RwimB; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="am3RwimB"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12732165d1eso134648c88.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 16:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772065646; x=1772670446; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Edr2iYtJTilYixX2FxbH6WYD8OvYl2J00kJkk+51Wg=;
        b=am3RwimBLPZcdUNjsQ6B2T3Uf7RznSaNFah0sc0S0AYTIu8K2Khki4UhJC16DW7A+e
         zA50loj8/IRgN8Qh2MQkUBmbeNPQESpMTfmEq04ac46C06AumXm5OzZ/ADWfcQp8Ezs6
         NvhTRqIAfxzYVgh1AW628yjSD4tloWDQpQOnTSgSULmpAE6eF24kQwKUMAkVKpRFTryL
         qISwQ2fCk+A1mgY4gsQv1T840uMr8qKWc7z+xrf5Pchgo7qu9etBlT0zolpOZ3VRsGXI
         qjuNMtsZg4aTGJeRcG4ZuyJfpP+k2lVF8+VoAEPLtJKwx+ZNq5zvgcPLf9d7xmEmrCt/
         CrYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772065646; x=1772670446;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7Edr2iYtJTilYixX2FxbH6WYD8OvYl2J00kJkk+51Wg=;
        b=tRG43go5iXNNRqGqDFI86GyVAtAgp4F56H7DnoDaFI2ZFZms22FO1Ow6UzezbzR4F8
         /7pa4PWW1BFEjdjPmy8hySnS5MUzqq+9XU2WyIGjqNjrYmHMKbFCbVyMNrOssHEz/k/s
         8Y0Il4zLGILVu32uug7F6Pz9/mn/KDVixNgPAb6ejd2LnHrty9cOK0pHS/Vnf8BdyfZA
         3W2X8Kt2Yq63Vf5vKVZwPc8fXSUFLq8Tl2X3vpvhxjPqvmSHhMkMjenALSFXqkSTEGUI
         7O59YU6R33GC4Lp4LJ5KfrjPOZ+yzGAOon4co6hsUi45LUq5CVO2TQgmXVMb4rt9K/gC
         brjQ==
X-Gm-Message-State: AOJu0Yyy0vGJSXmfyI2OeINTyr6krscJ1siLAFuPIKwVYe02sgqTOwmB
	J4jrXH1cY/zQyW/swY9P6fL1scBfW8HGLsM47Qx/I+L1ZOuwjDyO3vgG3ZGd8Q==
X-Gm-Gg: ATEYQzzkSrA4L8eswnzsGJU/c2LLtefWNsmrBSnoo06OPWRKzAty2z7BfwSsiFbP550
	bLgKEHGHkSt1om80+1Wa5romCF5eOCoK1VdY2kKHqRPfqjuxTscjVRzdavXtUEvkmRCI9jWQDfZ
	i9WlY/6IilJD96b3D84eLOi8C8KVv04omFtsFSNkR+sYZ8XKCEkUTsyeW2mXv5uiHxyZWfmb9K2
	Ze1A7TypH9HCwcAQToBw7nUK8sjy2yxLijE+D4A/EmVLHBbpdoSYEGRgLGW+vCWTweB/ca94Fwq
	ilJNICgXAO6UY3hXi3H9f177O/GubR95NQXRecR2akaWDOoMlMeFl7MF6VJu97Wt0576/KHmw07
	eI17SC/3VaXx5rc2Hsbs55XHwb7enezBeqc6h14lUw8mHmhRoTHolplR+zMOiDALp4U5fyBwReE
	YDITIYDokAZFskdh8hthUd1hQ0zaC+kV/CCNiR
X-Received: by 2002:a05:7022:6288:b0:127:c88:d597 with SMTP id a92af1059eb24-12789c653d5mr258296c88.10.1772065645697;
        Wed, 25 Feb 2026 16:27:25 -0800 (PST)
Received: from [127.0.0.1] ([52.159.229.150])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127899ea1e5sm610563c88.7.2026.02.25.16.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 16:27:25 -0800 (PST)
Message-Id: <pull.2147.v7.git.git.1772065643.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v6.git.git.1772050636.gitgitgadget@gmail.com>
References: <pull.2147.v6.git.git.1772050636.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Feb 2026 00:27:13 +0000
Subject: [PATCH v7 00/10] fsmonitor: implement filesystem change listener for Linux
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
    Paul Tarjan <github@paulisageek.com>

This series implements the built-in fsmonitor daemon for Linux using the
inotify API, bringing it to feature parity with the existing Windows and
macOS implementations. It also fixes two memory leaks in the
platform-independent daemon code and deduplicates the IPC and settings logic
that is now shared between macOS and Linux.

The implementation uses inotify rather than fanotify because fanotify
requires either CAP_SYS_ADMIN or CAP_PERFMON capabilities, making it
unsuitable for an unprivileged user-space daemon. While inotify has the
limitation of requiring a separate watch on every directory (unlike macOS
FSEvents, which can monitor an entire directory tree with a single watch),
it operates without elevated privileges and provides the per-file event
granularity needed for fsmonitor.

The listener uses inotify_init1(O_NONBLOCK) with a poll loop that checks for
events with a 50-millisecond timeout, keeping the inotify queue well-drained
to minimize the risk of overflows. Bidirectional hashmaps map between watch
descriptors and directory paths for efficient event resolution. Directory
renames are tracked using inotify cookie mechanism to correlate
IN_MOVED_FROM and IN_MOVED_TO event pairs; a periodic check detects stale
renames where the matching IN_MOVED_TO never arrived, forcing a resync.

New directory creation triggers recursive watch registration to ensure all
subdirectories are monitored. The IN_MASK_CREATE flag is used where
available to prevent modifying existing watches, with a fallback for older
kernels. When IN_MASK_CREATE is available and inotify_add_watch returns
EEXIST, it means another thread or recursive scan has already registered the
watch, so it is safe to ignore.

Remote filesystem detection uses statfs() to identify network-mounted
filesystems (NFS, CIFS, SMB, FUSE, etc.) via their magic numbers. Mount
point information is read from /proc/mounts and matched against the statfs
f_fsid to get accurate, human-readable filesystem type names for logging.
When the .git directory is on a remote filesystem, the IPC socket falls back
to $HOME or a user-configured directory via the fsmonitor.socketDir setting.

This series builds on work from https://github.com/git/git/pull/1352 by Eric
DeCosta and https://github.com/git/git/pull/1667 by Marziyeh Esipreh,
updated to work with the current codebase and address all review feedback.

Changes since v6:

 * Introduced FSMONITOR_OS_SETTINGS build variable (set to "unix" for macOS
   and Linux, "win32" for Windows) to eliminate if/else conditionals in
   Makefile, meson.build, and CMakeLists.txt per Junio's review
 * Moved fsm-path-utils from FSMONITOR_OS_SETTINGS to
   FSMONITOR_DAEMON_BACKEND since path-utils files are platform-specific
 * Removed V9FS_MAGIC from remote filesystem detection (9p is used for local
   VM/container host mounts where fsmonitor works fine)
 * Removed redundant #include <libgen.h> (already provided by
   compat/posix.h)
 * Fixed cookie wait comment wording ("see" → "observe")
 * Rewrote commit messages for IPC and settings dedup patches

Changes since v5:

 * Split monolithic commit into 10-patch series per Patrick's review
 * Deduplicated fsm-ipc and fsm-settings into shared Unix implementations
 * Rewrote commit message with prose paragraphs, explain inotify vs
   fanotify, removed "Issues addressed" sections, added Based-on-patch-by
   trailers
 * Removed redundant includes already provided by compat/posix.h
 * Fixed error/trace message capitalization per coding guidelines
 * Fixed stale rename check interval from 1000 seconds to 1 second
 * Changed poll timeout from 1ms to 50ms to reduce idle CPU wake-ups
 * Replaced infinite pthread_cond_wait cookie loop with one-second
   pthread_cond_timedwait (prevents daemon hangs on overlay filesystems
   where events are never delivered)
 * Added pthread_cond_timedwait to Windows pthread compatibility layer
 * Separated test into its own commit with smoke test that skips when
   inotify events are not delivered (e.g., overlayfs with older kernels)
 * Fixed test hang on Fedora CI: stop_git() looped forever when ps was
   unavailable because bash in POSIX/sh mode returns exit 0 from kill with
   an empty process group argument. Fixed by falling back to /proc/$pid/stat
   for process group ID and guarding stop_git against empty pgid.
 * Redirect spawn_daemon() stdout/stderr to /dev/null and close inherited
   file descriptors to prevent the intermediate process from holding test
   pipe file descriptors
 * Call setsid() on daemon detach to prevent shells with job control from
   waiting on the daemon process group
 * Close inherited file descriptors 3-7 in the test watchdog subprocess
 * Added 30-second timeout to "fsmonitor--daemon stop" to prevent indefinite
   blocking
 * Added helpful error message when inotify watch limit (max_user_watches)
   is reached
 * Initialize fd_inotify to -1 and use fd >= 0 check for correct fd 0
   handling
 * Use sysconf(_SC_OPEN_MAX) instead of hardcoded 1024 for fd close limit
 * Check setsid() return value

Changes since v4:

 * Added Meson build support

Changes since v3:

 * Fix crash on rapid nested directory creation (EEXIST from
   inotify_add_watch with IN_MASK_CREATE)
 * Extensive stress testing

Changes since v2:

 * Fix khash memory leak in do_handle_client

Changes since v1:

 * Fix hashmap memory leak in fsmonitor_run_daemon()

Paul Tarjan (10):
  fsmonitor: fix khash memory leak in do_handle_client
  fsmonitor: fix hashmap memory leak in fsmonitor_run_daemon
  compat/win32: add pthread_cond_timedwait
  fsmonitor: use pthread_cond_timedwait for cookie wait
  fsmonitor: deduplicate IPC path logic for Unix platforms
  fsmonitor: deduplicate settings logic for Unix platforms
  fsmonitor: implement filesystem change listener for Linux
  fsmonitor: add tests for Linux
  run-command: add close_fd_above_stderr option
  fsmonitor: close inherited file descriptors and detach in daemon

 Documentation/config/fsmonitor--daemon.adoc   |   4 +-
 Documentation/git-fsmonitor--daemon.adoc      |  28 +-
 Makefile                                      |   4 +-
 builtin/fsmonitor--daemon.c                   |  71 +-
 compat/fsmonitor/fsm-health-linux.c           |  33 +
 .../{fsm-ipc-darwin.c => fsm-ipc-unix.c}      |   4 +-
 compat/fsmonitor/fsm-listen-linux.c           | 746 ++++++++++++++++++
 compat/fsmonitor/fsm-path-utils-linux.c       | 220 ++++++
 ...-settings-darwin.c => fsm-settings-unix.c} |  24 +-
 compat/win32/pthread.c                        |  26 +
 compat/win32/pthread.h                        |   2 +
 config.mak.uname                              |  12 +-
 contrib/buildsystems/CMakeLists.txt           |  29 +-
 fsmonitor-ipc.c                               |   3 +
 meson.build                                   |  13 +-
 run-command.c                                 |  11 +
 run-command.h                                 |   9 +
 t/t7527-builtin-fsmonitor.sh                  | 101 ++-
 18 files changed, 1278 insertions(+), 62 deletions(-)
 create mode 100644 compat/fsmonitor/fsm-health-linux.c
 rename compat/fsmonitor/{fsm-ipc-darwin.c => fsm-ipc-unix.c} (96%)
 create mode 100644 compat/fsmonitor/fsm-listen-linux.c
 create mode 100644 compat/fsmonitor/fsm-path-utils-linux.c
 rename compat/fsmonitor/{fsm-settings-darwin.c => fsm-settings-unix.c} (82%)


base-commit: 3e0db84c88c57e70ac8be8c196dfa92c5d656fbc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2147%2Fptarjan%2Fclaude%2Fupdate-pr-1352-current-85Gk8-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2147/ptarjan/claude/update-pr-1352-current-85Gk8-v7
Pull-Request: https://github.com/git/git/pull/2147

Range-diff vs v6:

  1:  4d4dec8fa1 =  1:  4d4dec8fa1 fsmonitor: fix khash memory leak in do_handle_client
  2:  d0bd3e32ca =  2:  d0bd3e32ca fsmonitor: fix hashmap memory leak in fsmonitor_run_daemon
  3:  d2c5ca0939 =  3:  d2c5ca0939 compat/win32: add pthread_cond_timedwait
  4:  0051a19303 !  4:  0a58670952 fsmonitor: use pthread_cond_timedwait for cookie wait
     @@ builtin/fsmonitor--daemon.c: static enum fsmonitor_cookie_item_result with_lock_
      -	 * this.  Also note that the above open() and unlink() calls
      -	 * will cause at least two FS events on that path, so the odds
      -	 * of getting stuck are pretty slim.
     -+	 * Wait for the listener thread to see the cookie file.
     ++	 * Wait for the listener thread to observe the cookie file.
      +	 * Time out after a short interval so that the client
      +	 * does not hang forever if the filesystem does not deliver
      +	 * events (e.g., on certain container/overlay filesystems
  5:  ff31e359a7 !  5:  037ae2a03f fsmonitor: deduplicate IPC path logic for Unix platforms
     @@ Metadata
       ## Commit message ##
          fsmonitor: deduplicate IPC path logic for Unix platforms
      
     -    The IPC path logic for determining the Unix domain socket location is
     -    nearly identical between macOS and Linux.  Both need to check whether
     -    the .git directory is on a remote filesystem and, if so, fall back to
     -    a socket path under $HOME or a user-configured directory.
     +    The macOS fsm-ipc-darwin.c is applicable to other Unix variants as
     +    well.  Rename it to fsm-ipc-unix.c and add a worktree NULL check
     +    (BUG guard) that was missing from the macOS version.
      
     -    Merge the two implementations into a single fsm-ipc-unix.c that is
     -    shared by both platforms.  The unified version includes the worktree
     -    NULL check (BUG guard) from the Linux implementation, which was missing
     -    in the macOS version.
     -
     -    Update Makefile, meson.build, and CMakeLists.txt to use the new shared
     -    file for non-Windows platforms.
     +    To support this, introduce FSMONITOR_OS_SETTINGS which is set to
     +    "unix" for both macOS and Linux, distinct from FSMONITOR_DAEMON_BACKEND
     +    which remains platform-specific (darwin, linux, win32).  Move
     +    fsm-path-utils from FSMONITOR_OS_SETTINGS to FSMONITOR_DAEMON_BACKEND
     +    since the path-utils files are platform-specific.
      
          Signed-off-by: Paul Tarjan <github@paulisageek.com>
      
     @@ Makefile: ifdef FSMONITOR_DAEMON_BACKEND
       endif
       
       ifdef FSMONITOR_OS_SETTINGS
     + 	COMPAT_CFLAGS += -DHAVE_FSMONITOR_OS_SETTINGS
     + 	COMPAT_OBJS += compat/fsmonitor/fsm-settings-$(FSMONITOR_OS_SETTINGS).o
     +-	COMPAT_OBJS += compat/fsmonitor/fsm-path-utils-$(FSMONITOR_OS_SETTINGS).o
     ++	COMPAT_OBJS += compat/fsmonitor/fsm-path-utils-$(FSMONITOR_DAEMON_BACKEND).o
     + endif
     + 
     + ifdef WITH_BREAKING_CHANGES
      
       ## compat/fsmonitor/fsm-ipc-darwin.c => compat/fsmonitor/fsm-ipc-unix.c ##
      @@ compat/fsmonitor/fsm-ipc-unix.c: const char *fsmonitor_ipc__get_path(struct repository *r)
  6:  39da1e6be3 !  6:  0a83bb9c8e fsmonitor: deduplicate settings logic for Unix platforms
     @@ Metadata
       ## Commit message ##
          fsmonitor: deduplicate settings logic for Unix platforms
      
     -    The fsmonitor settings logic for checking Unix domain socket
     -    compatibility is nearly identical between macOS and Linux.  Both check
     -    whether the IPC socket directory resides on a remote filesystem or a
     -    filesystem that does not support Unix domain sockets (NTFS, FAT32, etc).
     +    The macOS fsm-settings-darwin.c is applicable to other Unix variants
     +    as well.  Rename it to fsm-settings-unix.c, using the safer
     +    xstrdup()+dirname() approach and including the "vfat" filesystem check.
      
     -    Merge the two implementations into a single fsm-settings-unix.c shared
     -    by both platforms.  The unified version uses the safer xstrdup() +
     -    dirname() approach from the macOS implementation (avoiding strbuf
     -    mutation with dirname()) and includes the "vfat" filesystem check.
     -
     -    Update Makefile, meson.build, and CMakeLists.txt to use the new shared
     -    file for non-Windows platforms.
     +    Now that both fsm-ipc and fsm-settings use the "unix" variant name,
     +    set FSMONITOR_OS_SETTINGS to "unix" for macOS in config.mak.uname and
     +    remove the if/else conditionals from the build files.
      
          Signed-off-by: Paul Tarjan <github@paulisageek.com>
      
       ## Makefile ##
     -@@ Makefile: endif
     +@@ Makefile: ifdef FSMONITOR_DAEMON_BACKEND
     + 	COMPAT_CFLAGS += -DHAVE_FSMONITOR_DAEMON_BACKEND
     + 	COMPAT_OBJS += compat/fsmonitor/fsm-listen-$(FSMONITOR_DAEMON_BACKEND).o
     + 	COMPAT_OBJS += compat/fsmonitor/fsm-health-$(FSMONITOR_DAEMON_BACKEND).o
     +-ifeq ($(FSMONITOR_DAEMON_BACKEND),win32)
     +-	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-win32.o
     +-else
     +-	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-unix.o
     +-endif
     + endif
       
       ifdef FSMONITOR_OS_SETTINGS
       	COMPAT_CFLAGS += -DHAVE_FSMONITOR_OS_SETTINGS
     --	COMPAT_OBJS += compat/fsmonitor/fsm-settings-$(FSMONITOR_OS_SETTINGS).o
     -+ifeq ($(FSMONITOR_OS_SETTINGS),win32)
     -+	COMPAT_OBJS += compat/fsmonitor/fsm-settings-win32.o
     -+else
     -+	COMPAT_OBJS += compat/fsmonitor/fsm-settings-unix.o
     -+endif
     - 	COMPAT_OBJS += compat/fsmonitor/fsm-path-utils-$(FSMONITOR_OS_SETTINGS).o
     ++	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-$(FSMONITOR_OS_SETTINGS).o
     + 	COMPAT_OBJS += compat/fsmonitor/fsm-settings-$(FSMONITOR_OS_SETTINGS).o
     + 	COMPAT_OBJS += compat/fsmonitor/fsm-path-utils-$(FSMONITOR_DAEMON_BACKEND).o
       endif
     - 
      
       ## compat/fsmonitor/fsm-settings-darwin.c => compat/fsmonitor/fsm-settings-unix.c ##
      @@
     @@ compat/fsmonitor/fsm-settings-darwin.c => compat/fsmonitor/fsm-settings-unix.c
       		return FSMONITOR_REASON_NOSOCKETS;
       	}
      
     + ## config.mak.uname ##
     +@@ config.mak.uname: ifeq ($(uname_S),Darwin)
     +         ifndef NO_PTHREADS
     +         ifndef NO_UNIX_SOCKETS
     + 	FSMONITOR_DAEMON_BACKEND = darwin
     +-	FSMONITOR_OS_SETTINGS = darwin
     ++	FSMONITOR_OS_SETTINGS = unix
     +         endif
     +         endif
     + 
     +
       ## contrib/buildsystems/CMakeLists.txt ##
     -@@ contrib/buildsystems/CMakeLists.txt: if(SUPPORTS_SIMPLE_IPC)
     - 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-darwin.c)
     +@@ contrib/buildsystems/CMakeLists.txt: endif()
     + 
     + if(SUPPORTS_SIMPLE_IPC)
     + 	if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
     +-		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
     +-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-win32.c)
     +-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-win32.c)
     +-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-win32.c)
     +-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-win32.c)
     +-
     +-		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
     +-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-win32.c)
     ++		set(FSMONITOR_DAEMON_BACKEND "win32")
     ++		set(FSMONITOR_OS_SETTINGS "win32")
     + 	elseif(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
     ++		set(FSMONITOR_DAEMON_BACKEND "darwin")
     ++		set(FSMONITOR_OS_SETTINGS "unix")
     ++	endif()
     ++
     ++	if(FSMONITOR_DAEMON_BACKEND)
     + 		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
     +-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-darwin.c)
     +-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-darwin.c)
     +-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-unix.c)
     +-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-darwin.c)
     ++		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-${FSMONITOR_DAEMON_BACKEND}.c)
     ++		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-${FSMONITOR_DAEMON_BACKEND}.c)
     ++		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-${FSMONITOR_DAEMON_BACKEND}.c)
     ++		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-${FSMONITOR_OS_SETTINGS}.c)
       
       		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
      -		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-darwin.c)
     -+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-unix.c)
     ++		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-${FSMONITOR_OS_SETTINGS}.c)
       	endif()
       endif()
       
      
       ## meson.build ##
     +@@ meson.build: else
     + endif
     + 
     + fsmonitor_backend = ''
     ++fsmonitor_os = ''
     + if host_machine.system() == 'windows'
     +   fsmonitor_backend = 'win32'
     ++  fsmonitor_os = 'win32'
     + elif host_machine.system() == 'darwin'
     +   fsmonitor_backend = 'darwin'
     ++  fsmonitor_os = 'unix'
     +   libgit_dependencies += dependency('CoreServices')
     + endif
     + if fsmonitor_backend != ''
      @@ meson.build: if fsmonitor_backend != ''
           'compat/fsmonitor/fsm-health-' + fsmonitor_backend + '.c',
           'compat/fsmonitor/fsm-listen-' + fsmonitor_backend + '.c',
           'compat/fsmonitor/fsm-path-utils-' + fsmonitor_backend + '.c',
      -    'compat/fsmonitor/fsm-settings-' + fsmonitor_backend + '.c',
     ++    'compat/fsmonitor/fsm-ipc-' + fsmonitor_os + '.c',
     ++    'compat/fsmonitor/fsm-settings-' + fsmonitor_os + '.c',
         ]
     - 
     -   if fsmonitor_backend == 'win32'
     +-
     +-  if fsmonitor_backend == 'win32'
      -    libgit_sources += 'compat/fsmonitor/fsm-ipc-win32.c'
     -+    libgit_sources += [
     -+      'compat/fsmonitor/fsm-ipc-win32.c',
     -+      'compat/fsmonitor/fsm-settings-win32.c',
     -+    ]
     -   else
     +-  else
      -    libgit_sources += 'compat/fsmonitor/fsm-ipc-unix.c'
     -+    libgit_sources += [
     -+      'compat/fsmonitor/fsm-ipc-unix.c',
     -+      'compat/fsmonitor/fsm-settings-unix.c',
     -+    ]
     -   endif
     +-  endif
       endif
       build_options_config.set_quoted('FSMONITOR_DAEMON_BACKEND', fsmonitor_backend)
     +-build_options_config.set_quoted('FSMONITOR_OS_SETTINGS', fsmonitor_backend)
     ++build_options_config.set_quoted('FSMONITOR_OS_SETTINGS', fsmonitor_os)
     + 
     + if not get_option('b_sanitize').contains('address') and get_option('regex').allowed() and compiler.has_header('regex.h') and compiler.get_define('REG_STARTEND', prefix: '#include <regex.h>') != ''
     +   build_options_config.set('NO_REGEX', '')
  7:  4eadc06004 !  7:  adac7964cc fsmonitor: implement filesystem change listener for Linux
     @@ config.mak.uname: ifeq ($(uname_S),Linux)
      +        ifndef NO_PTHREADS
      +        ifndef NO_UNIX_SOCKETS
      +	FSMONITOR_DAEMON_BACKEND = linux
     -+	FSMONITOR_OS_SETTINGS = linux
     ++	FSMONITOR_OS_SETTINGS = unix
      +	BASIC_CFLAGS += -DHAVE_LINUX_MAGIC_H
      +        endif
      +        endif
     @@ config.mak.uname: ifeq ($(uname_S),Linux)
      
       ## contrib/buildsystems/CMakeLists.txt ##
      @@ contrib/buildsystems/CMakeLists.txt: if(SUPPORTS_SIMPLE_IPC)
     - 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-unix.c)
     - 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-darwin.c)
     - 
     -+		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
     -+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-unix.c)
     + 	elseif(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
     + 		set(FSMONITOR_DAEMON_BACKEND "darwin")
     + 		set(FSMONITOR_OS_SETTINGS "unix")
      +	elseif(CMAKE_SYSTEM_NAME STREQUAL "Linux")
     -+		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
     ++		set(FSMONITOR_DAEMON_BACKEND "linux")
     ++		set(FSMONITOR_OS_SETTINGS "unix")
      +		add_compile_definitions(HAVE_LINUX_MAGIC_H)
     -+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-linux.c)
     -+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-linux.c)
     -+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-unix.c)
     -+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-linux.c)
     -+
     - 		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
     - 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-unix.c)
       	endif()
     + 
     + 	if(FSMONITOR_DAEMON_BACKEND)
      
       ## meson.build ##
     -@@ meson.build: endif
     - fsmonitor_backend = ''
     +@@ meson.build: fsmonitor_os = ''
       if host_machine.system() == 'windows'
         fsmonitor_backend = 'win32'
     +   fsmonitor_os = 'win32'
      +elif host_machine.system() == 'linux' and threads.found() and compiler.has_header('linux/magic.h')
      +  fsmonitor_backend = 'linux'
     ++  fsmonitor_os = 'unix'
      +  libgit_c_args += '-DHAVE_LINUX_MAGIC_H'
       elif host_machine.system() == 'darwin'
         fsmonitor_backend = 'darwin'
     -   libgit_dependencies += dependency('CoreServices')
     +   fsmonitor_os = 'unix'
  8:  8fec92d5b4 =  8:  fad2f0a81a fsmonitor: add tests for Linux
  9:  817489b3ea =  9:  c684fc9094 run-command: add close_fd_above_stderr option
 10:  bb438afbbe = 10:  4987a009a2 fsmonitor: close inherited file descriptors and detach in daemon

-- 
gitgitgadget
