Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1853D6CA4
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 18:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648137; cv=none; b=ph8n+x5K8FscGdA5o+oFeSf17gznK8/GHVrOHO2T9cPZcqcuoKGCDoUcF1zohL58bRrX5AYaKpwLul467NjNv76PzOpssPlOVlZkSmuO+9lVnn3mVLTGONZO3VbZjfBQGzYaSQrqZQTVeI3jJVideFjCY7GLwawf+aXaVBnAN80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648137; c=relaxed/simple;
	bh=4sUYuwgXFW5H6Mv7VJbi66D6m3SGZ54Hzc99dpd3ElU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ff7NPpfCaOxUQCNT2QkjOh9MH+GA4BU2Tjav2+XdT8DZVAOphFPhUU3RgfNN0ZDEztm6DqrTHwmo0VdJVRlxVw0dUSTggnh31HAf34H36tzYIk4HOzQQ8/QpIhdG+rBTuHNEPomnctwf8ZtxVO7pCVPiSEVti9x9oZoY5p/SAdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhHh0SvW; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhHh0SvW"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2be1ab1fa7dso4120487eec.0
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 10:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772648129; x=1773252929; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckSRUA7rP0dtPcsaYMcXBp5mCEYXc1+TVG8IQxUJnuk=;
        b=dhHh0SvW+Mwo0Y3j50+Y0SjDoBLPcZFEeztGloN9CpPA/P5tPcXdL7HbnXxIttrEdc
         KmSu0dwjE+o7l98y8PjsRNNpb/ruAEpLs3dLxp5SqaRkw3MSt2j2j/TXZS5zSL82QhzN
         o+ix1YKmym3GA1Fl7wx+9/4GK/ep3yLw49NNwWuDTM7T+Ae4tx4RrOv1JQxq/bglw39w
         JDOgXIqMQbe7gsdvWi4kj1DHbeYh+hldZGer4hlH9M1Be2Fbluq63a/0d88IkmAO80sS
         0sM+qRe6KfejnpT2z39qLUfMjBSz7ZJ68MgeNM5jvU84Whegr6VVwz28VBO1Ei7/hpXd
         uATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772648129; x=1773252929;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ckSRUA7rP0dtPcsaYMcXBp5mCEYXc1+TVG8IQxUJnuk=;
        b=wtYV7hBwCZuuV0FdfUlZOlpJ/f3cE6wijMHgFTaJrmqqh0QnUT4jSC/9eACYSw0+4e
         mlG7cLbRktd5xOi5vBYEL8XzGOtrIzIgTr7g3lfTgfZXacyUU9LK/ey2wGgluzZURFmW
         l1qloXjneJtEbl1/2ziXxyVvgn59961w5LDVY9+P+yTwQfkWyCK6OIyHFZsfDK1i0Gj7
         LaJBwz+r+hvq4Qo6E5Aqd0vaot/UW/ruZrfcpxlulW7I1Ru5VonFsEyzuN4ZIQsb0eDE
         Gwu2cQWm3BUd1Lg2JJU2UIXdL2m/4aLtf3kycUC0TyEbaItQBelsp1CMkpGsJ7yjmYVY
         fuvg==
X-Gm-Message-State: AOJu0YzNpplMO6trdgEI33CVzB7StFxXU4ygmMWPTaSt5WWpVzMGs1+R
	63lHbotnA0qvuAsCqt5chioGZAAbS80V6pEMYdhAF9xuH7BZSJQkBq8+RxDk3A==
X-Gm-Gg: ATEYQzwMOwG8VPZx78jjKftRfcBwDBBl0PLsqTg79tv+yiRMOuQXZkxQJtOn5EDB+cO
	oOALmffzKokdz2IIc8lLzcwwvsbdg3gqvOBJNg525bsQKzMYUv2/SFo0rlmmuGt/Rx7goqE82ZW
	N2d4l1ovp2+y7UTzDksElwLU9EXWMHvclpYEyFwq55WWnkWuKJ8wiaCzR2tscmYImQTaaJxjNGV
	cQn8DEPUM2/hE+u9eKeZGEcysRiilzro42Y4W4z3RVquY2b1+imEnsKda59p0UkdZwRej25b4lN
	33qf5cWGjZKgZi19nRo8Lbjmc6zb32V222RVon2yibOTwVLW6YAArgBbHl2XPVu4FmfyaxPxEI3
	1t4C44Zl2RqUDkLSeX/gqCRB/ampoRNcvhT5mnh6fNAyeEtNF7tEbmSb/S02IXJrl0ojz0DDEBv
	0Jw5hIs0PjFn1jc/+u14uVUH3LoA==
X-Received: by 2002:a05:7301:1009:b0:2b8:6b32:1cf1 with SMTP id 5a478bee46e88-2be311b7b5fmr1277711eec.29.1772648127585;
        Wed, 04 Mar 2026 10:15:27 -0800 (PST)
Received: from [127.0.0.1] ([57.154.172.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be1281ff70sm8347601eec.14.2026.03.04.10.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 10:15:26 -0800 (PST)
Message-Id: <pull.2147.v8.git.git.1772648125.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v7.git.git.1772065643.gitgitgadget@gmail.com>
References: <pull.2147.v7.git.git.1772065643.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Mar 2026 18:15:13 +0000
Subject: [PATCH v8 00/12] fsmonitor: implement filesystem change listener for Linux
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

Changes since v7:

 * Added patch 12: convert khash to strset in do_handle_client (Patrick's
   #leftoverbit suggestion)
 * Fixed "Forcing shutdown" trace message to start with lowercase
 * Fixed redundant statfs() call in find_mount() (caller already had the
   result)
 * Fixed CMakeLists.txt GIT-BUILD-OPTIONS: was hardcoded to "win32" for
   FSMONITOR_DAEMON_BACKEND and FSMONITOR_OS_SETTINGS, now uses the CMake
   variables
 * Fixed uninitialized strset on trivial response path (STRSET_INIT)
 * Removed V9FS_MAGIC from get_fs_typename() to match is_remote_fs() (9p is
   local VM mounts)
 * Split 30-second stop timeout into its own commit per review request
 * Fixed misleading indentation on shutdown assignment in handle_events()
 * Updated commit messages to describe all changes (test hardening,
   fsmonitor-ipc.c spawn changes)
 * Updated Makefile comment for FSMONITOR_OS_SETTINGS to mention fsm-ipc

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
 * Fixed cookie wait comment wording ("see" to "observe")
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

Paul Tarjan (12):
  fsmonitor: fix khash memory leak in do_handle_client
  fsmonitor: fix hashmap memory leak in fsmonitor_run_daemon
  compat/win32: add pthread_cond_timedwait
  fsmonitor: use pthread_cond_timedwait for cookie wait
  fsmonitor: rename fsm-ipc-darwin.c to fsm-ipc-unix.c
  fsmonitor: rename fsm-settings-darwin.c to fsm-settings-unix.c
  fsmonitor: implement filesystem change listener for Linux
  run-command: add close_fd_above_stderr option
  fsmonitor: close inherited file descriptors and detach in daemon
  fsmonitor: add timeout to daemon stop command
  fsmonitor: add tests for Linux
  fsmonitor: convert shown khash to strset in do_handle_client

 Documentation/config/fsmonitor--daemon.adoc   |   4 +-
 Documentation/git-fsmonitor--daemon.adoc      |  28 +-
 Makefile                                      |   6 +-
 builtin/fsmonitor--daemon.c                   |  92 ++-
 compat/fsmonitor/fsm-health-linux.c           |  33 +
 .../{fsm-ipc-darwin.c => fsm-ipc-unix.c}      |   0
 compat/fsmonitor/fsm-listen-linux.c           | 746 ++++++++++++++++++
 compat/fsmonitor/fsm-path-utils-linux.c       | 217 +++++
 ...-settings-darwin.c => fsm-settings-unix.c} |   0
 compat/win32/pthread.c                        |  26 +
 compat/win32/pthread.h                        |   2 +
 config.mak.uname                              |  12 +-
 contrib/buildsystems/CMakeLists.txt           |  33 +-
 fsmonitor-ipc.c                               |   3 +
 meson.build                                   |  13 +-
 run-command.c                                 |  11 +
 run-command.h                                 |   9 +
 t/t7527-builtin-fsmonitor.sh                  |  89 ++-
 18 files changed, 1261 insertions(+), 63 deletions(-)
 create mode 100644 compat/fsmonitor/fsm-health-linux.c
 rename compat/fsmonitor/{fsm-ipc-darwin.c => fsm-ipc-unix.c} (100%)
 create mode 100644 compat/fsmonitor/fsm-listen-linux.c
 create mode 100644 compat/fsmonitor/fsm-path-utils-linux.c
 rename compat/fsmonitor/{fsm-settings-darwin.c => fsm-settings-unix.c} (100%)


base-commit: 3e0db84c88c57e70ac8be8c196dfa92c5d656fbc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2147%2Fptarjan%2Fclaude%2Fupdate-pr-1352-current-85Gk8-v8
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2147/ptarjan/claude/update-pr-1352-current-85Gk8-v8
Pull-Request: https://github.com/git/git/pull/2147

Range-diff vs v7:

  1:  4d4dec8fa1 =  1:  4d4dec8fa1 fsmonitor: fix khash memory leak in do_handle_client
  2:  d0bd3e32ca !  2:  cb270120f0 fsmonitor: fix hashmap memory leak in fsmonitor_run_daemon
     @@ Commit message
      
          The `state.cookies` hashmap is initialized during daemon startup but
          never freed during cleanup in the `done:` label of
     -    fsmonitor_run_daemon().  Add a hashmap_clear() call to prevent this
     -    memory leak.
     +    fsmonitor_run_daemon().  The cookie entries also have names allocated
     +    via strbuf_detach() that must be freed individually.
     +
     +    Iterate the hashmap to free each cookie name, then call
     +    hashmap_clear_and_free() to release the entries and table.
      
          Signed-off-by: Paul Tarjan <github@paulisageek.com>
      
     @@ builtin/fsmonitor--daemon.c: static int fsmonitor_run_daemon(void)
       done:
       	pthread_cond_destroy(&state.cookies_cond);
       	pthread_mutex_destroy(&state.main_lock);
     -+	hashmap_clear(&state.cookies);
     ++	{
     ++		struct hashmap_iter iter;
     ++		struct fsmonitor_cookie_item *cookie;
     ++
     ++		hashmap_for_each_entry(&state.cookies, &iter, cookie, entry)
     ++			free(cookie->name);
     ++		hashmap_clear_and_free(&state.cookies,
     ++				       struct fsmonitor_cookie_item, entry);
     ++	}
       	fsm_listen__dtor(&state);
       	fsm_health__dtor(&state);
       
  3:  d2c5ca0939 !  3:  44a063074d compat/win32: add pthread_cond_timedwait
     @@ Commit message
          compatibility layer using SleepConditionVariableCS() with a millisecond
          timeout computed from the absolute deadline.
      
     -    This enables callers to use bounded waits on condition variables
     -    instead of blocking indefinitely with pthread_cond_wait().
     -
          Signed-off-by: Paul Tarjan <github@paulisageek.com>
      
       ## compat/win32/pthread.c ##
     @@ compat/win32/pthread.c: int pthread_cond_wait(pthread_cond_t *cond, pthread_mute
      +		      abstime->tv_nsec / 1000000;
      +
      +	if (deadline_ms <= now_ms)
     -+		timeout_ms = 0;
     ++		return ETIMEDOUT;
      +	else
      +		timeout_ms = (DWORD)(deadline_ms - now_ms);
      +
  4:  0a58670952 =  4:  b1081d1e13 fsmonitor: use pthread_cond_timedwait for cookie wait
  6:  0a83bb9c8e !  5:  dec0fb144f fsmonitor: deduplicate settings logic for Unix platforms
     @@ Metadata
      Author: Paul Tarjan <github@paulisageek.com>
      
       ## Commit message ##
     -    fsmonitor: deduplicate settings logic for Unix platforms
     +    fsmonitor: rename fsm-ipc-darwin.c to fsm-ipc-unix.c
      
     -    The macOS fsm-settings-darwin.c is applicable to other Unix variants
     -    as well.  Rename it to fsm-settings-unix.c, using the safer
     -    xstrdup()+dirname() approach and including the "vfat" filesystem check.
     +    The fsmonitor IPC path logic in fsm-ipc-darwin.c is not
     +    Darwin-specific and will be reused by the upcoming Linux
     +    implementation.  Rename it to fsm-ipc-unix.c to reflect that it
     +    is shared by all Unix platforms.
      
     -    Now that both fsm-ipc and fsm-settings use the "unix" variant name,
     -    set FSMONITOR_OS_SETTINGS to "unix" for macOS in config.mak.uname and
     -    remove the if/else conditionals from the build files.
     +    Introduce FSMONITOR_OS_SETTINGS (set to "unix" for non-Windows, "win32"
     +    for Windows) as a separate variable from FSMONITOR_DAEMON_BACKEND so
     +    that the build files can distinguish between platform-specific files
     +    (listen, health, path-utils) and shared Unix files (ipc, settings).
      
     +    Move fsm-ipc to the FSMONITOR_OS_SETTINGS section in the Makefile, and
     +    switch fsm-path-utils to use FSMONITOR_DAEMON_BACKEND since path-utils
     +    is platform-specific (there will be separate darwin and linux versions).
     +
     +    Based-on-patch-by: Eric DeCosta <edecosta@mathworks.com>
     +    Based-on-patch-by: Marziyeh Esipreh <marziyeh.esipreh@gmail.com>
          Signed-off-by: Paul Tarjan <github@paulisageek.com>
      
       ## Makefile ##
     +@@ Makefile: include shared.mak
     + # If your platform has OS-specific ways to tell if a repo is incompatible with
     + # fsmonitor (whether the hook or IPC daemon version), set FSMONITOR_OS_SETTINGS
     + # to the "<name>" of the corresponding `compat/fsmonitor/fsm-settings-<name>.c`
     +-# that implements the `fsm_os_settings__*()` routines.
     ++# and `compat/fsmonitor/fsm-ipc-<name>.c` files.
     + #
     + # Define LINK_FUZZ_PROGRAMS if you want `make all` to also build the fuzz test
     + # programs in oss-fuzz/.
      @@ Makefile: ifdef FSMONITOR_DAEMON_BACKEND
       	COMPAT_CFLAGS += -DHAVE_FSMONITOR_DAEMON_BACKEND
       	COMPAT_OBJS += compat/fsmonitor/fsm-listen-$(FSMONITOR_DAEMON_BACKEND).o
       	COMPAT_OBJS += compat/fsmonitor/fsm-health-$(FSMONITOR_DAEMON_BACKEND).o
     --ifeq ($(FSMONITOR_DAEMON_BACKEND),win32)
     --	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-win32.o
     --else
     --	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-unix.o
     --endif
     +-	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-$(FSMONITOR_DAEMON_BACKEND).o
       endif
       
       ifdef FSMONITOR_OS_SETTINGS
       	COMPAT_CFLAGS += -DHAVE_FSMONITOR_OS_SETTINGS
      +	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-$(FSMONITOR_OS_SETTINGS).o
       	COMPAT_OBJS += compat/fsmonitor/fsm-settings-$(FSMONITOR_OS_SETTINGS).o
     - 	COMPAT_OBJS += compat/fsmonitor/fsm-path-utils-$(FSMONITOR_DAEMON_BACKEND).o
     +-	COMPAT_OBJS += compat/fsmonitor/fsm-path-utils-$(FSMONITOR_OS_SETTINGS).o
     ++	COMPAT_OBJS += compat/fsmonitor/fsm-path-utils-$(FSMONITOR_DAEMON_BACKEND).o
       endif
     -
     - ## compat/fsmonitor/fsm-settings-darwin.c => compat/fsmonitor/fsm-settings-unix.c ##
     -@@
     - #include "fsmonitor-settings.h"
     - #include "fsmonitor-path-utils.h"
     - 
     -- /*
     -+/*
     -  * For the builtin FSMonitor, we create the Unix domain socket for the
     -  * IPC in the .git directory.  If the working directory is remote,
     -  * then the socket will be created on the remote file system.  This
     -@@
     -  * The builtin FSMonitor uses a Unix domain socket in the .git
     -  * directory for IPC.  These Windows drive formats do not support
     -  * Unix domain sockets, so mark them as incompatible for the daemon.
     -- *
     -  */
     - static enum fsmonitor_reason check_uds_volume(struct repository *r)
     - {
     - 	struct fs_info fs;
     - 	const char *ipc_path = fsmonitor_ipc__get_path(r);
     --	struct strbuf path = STRBUF_INIT;
     --	strbuf_add(&path, ipc_path, strlen(ipc_path));
     -+	char *path;
     -+	char *dir;
     -+
     -+	/*
     -+	 * Create a copy for dirname() since it may modify its argument.
     -+	 */
     -+	path = xstrdup(ipc_path);
     -+	dir = dirname(path);
       
     --	if (fsmonitor__get_fs_info(dirname(path.buf), &fs) == -1) {
     --		strbuf_release(&path);
     -+	if (fsmonitor__get_fs_info(dir, &fs) == -1) {
     -+		free(path);
     - 		return FSMONITOR_REASON_ERROR;
     - 	}
     - 
     --	strbuf_release(&path);
     -+	free(path);
     - 
     - 	if (fs.is_remote ||
     --		!strcmp(fs.typename, "msdos") ||
     --		!strcmp(fs.typename, "ntfs")) {
     -+	    !strcmp(fs.typename, "msdos") ||
     -+	    !strcmp(fs.typename, "ntfs") ||
     -+	    !strcmp(fs.typename, "vfat")) {
     - 		free(fs.typename);
     - 		return FSMONITOR_REASON_NOSOCKETS;
     - 	}
     + ifdef WITH_BREAKING_CHANGES
     +
     + ## compat/fsmonitor/fsm-ipc-darwin.c => compat/fsmonitor/fsm-ipc-unix.c ##
      
       ## config.mak.uname ##
      @@ config.mak.uname: ifeq ($(uname_S),Darwin)
     @@ contrib/buildsystems/CMakeLists.txt: endif()
       		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
      -		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-darwin.c)
      -		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-darwin.c)
     --		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-unix.c)
     +-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-darwin.c)
      -		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-darwin.c)
      +		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-${FSMONITOR_DAEMON_BACKEND}.c)
      +		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-${FSMONITOR_DAEMON_BACKEND}.c)
     -+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-${FSMONITOR_DAEMON_BACKEND}.c)
      +		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-${FSMONITOR_OS_SETTINGS}.c)
     ++		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-${FSMONITOR_DAEMON_BACKEND}.c)
       
       		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
      -		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-darwin.c)
     -+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-${FSMONITOR_OS_SETTINGS}.c)
     ++		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-${FSMONITOR_DAEMON_BACKEND}.c)
       	endif()
       endif()
       
     @@ meson.build: else
       endif
       if fsmonitor_backend != ''
      @@ meson.build: if fsmonitor_backend != ''
     + 
     +   libgit_sources += [
           'compat/fsmonitor/fsm-health-' + fsmonitor_backend + '.c',
     +-    'compat/fsmonitor/fsm-ipc-' + fsmonitor_backend + '.c',
     ++    'compat/fsmonitor/fsm-ipc-' + fsmonitor_os + '.c',
           'compat/fsmonitor/fsm-listen-' + fsmonitor_backend + '.c',
           'compat/fsmonitor/fsm-path-utils-' + fsmonitor_backend + '.c',
     --    'compat/fsmonitor/fsm-settings-' + fsmonitor_backend + '.c',
     -+    'compat/fsmonitor/fsm-ipc-' + fsmonitor_os + '.c',
     -+    'compat/fsmonitor/fsm-settings-' + fsmonitor_os + '.c',
     +     'compat/fsmonitor/fsm-settings-' + fsmonitor_backend + '.c',
         ]
     --
     --  if fsmonitor_backend == 'win32'
     --    libgit_sources += 'compat/fsmonitor/fsm-ipc-win32.c'
     --  else
     --    libgit_sources += 'compat/fsmonitor/fsm-ipc-unix.c'
     --  endif
       endif
       build_options_config.set_quoted('FSMONITOR_DAEMON_BACKEND', fsmonitor_backend)
      -build_options_config.set_quoted('FSMONITOR_OS_SETTINGS', fsmonitor_backend)
  5:  037ae2a03f !  6:  b2aaadb4ae fsmonitor: deduplicate IPC path logic for Unix platforms
     @@ Metadata
      Author: Paul Tarjan <github@paulisageek.com>
      
       ## Commit message ##
     -    fsmonitor: deduplicate IPC path logic for Unix platforms
     +    fsmonitor: rename fsm-settings-darwin.c to fsm-settings-unix.c
      
     -    The macOS fsm-ipc-darwin.c is applicable to other Unix variants as
     -    well.  Rename it to fsm-ipc-unix.c and add a worktree NULL check
     -    (BUG guard) that was missing from the macOS version.
     +    The fsmonitor settings logic in fsm-settings-darwin.c is not
     +    Darwin-specific and will be reused by the upcoming Linux
     +    implementation.  Rename it to fsm-settings-unix.c to reflect that it
     +    is shared by all Unix platforms.
      
     -    To support this, introduce FSMONITOR_OS_SETTINGS which is set to
     -    "unix" for both macOS and Linux, distinct from FSMONITOR_DAEMON_BACKEND
     -    which remains platform-specific (darwin, linux, win32).  Move
     -    fsm-path-utils from FSMONITOR_OS_SETTINGS to FSMONITOR_DAEMON_BACKEND
     -    since the path-utils files are platform-specific.
     +    Update the build files (meson.build and CMakeLists.txt) to use
     +    FSMONITOR_OS_SETTINGS for fsm-settings, matching the approach already
     +    used for fsm-ipc.
      
     +    Based-on-patch-by: Eric DeCosta <edecosta@mathworks.com>
     +    Based-on-patch-by: Marziyeh Esipreh <marziyeh.esipreh@gmail.com>
          Signed-off-by: Paul Tarjan <github@paulisageek.com>
      
     - ## Makefile ##
     -@@ Makefile: ifdef FSMONITOR_DAEMON_BACKEND
     - 	COMPAT_CFLAGS += -DHAVE_FSMONITOR_DAEMON_BACKEND
     - 	COMPAT_OBJS += compat/fsmonitor/fsm-listen-$(FSMONITOR_DAEMON_BACKEND).o
     - 	COMPAT_OBJS += compat/fsmonitor/fsm-health-$(FSMONITOR_DAEMON_BACKEND).o
     --	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-$(FSMONITOR_DAEMON_BACKEND).o
     -+ifeq ($(FSMONITOR_DAEMON_BACKEND),win32)
     -+	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-win32.o
     -+else
     -+	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-unix.o
     -+endif
     - endif
     - 
     - ifdef FSMONITOR_OS_SETTINGS
     - 	COMPAT_CFLAGS += -DHAVE_FSMONITOR_OS_SETTINGS
     - 	COMPAT_OBJS += compat/fsmonitor/fsm-settings-$(FSMONITOR_OS_SETTINGS).o
     --	COMPAT_OBJS += compat/fsmonitor/fsm-path-utils-$(FSMONITOR_OS_SETTINGS).o
     -+	COMPAT_OBJS += compat/fsmonitor/fsm-path-utils-$(FSMONITOR_DAEMON_BACKEND).o
     - endif
     - 
     - ifdef WITH_BREAKING_CHANGES
     -
     - ## compat/fsmonitor/fsm-ipc-darwin.c => compat/fsmonitor/fsm-ipc-unix.c ##
     -@@ compat/fsmonitor/fsm-ipc-unix.c: const char *fsmonitor_ipc__get_path(struct repository *r)
     - 	if (ipc_path)
     - 		return ipc_path;
     - 
     --
     - 	/* By default the socket file is created in the .git directory */
     - 	if (fsmonitor__is_fs_remote(r->gitdir) < 1) {
     - 		ipc_path = fsmonitor_ipc__get_default_path();
     - 		return ipc_path;
     - 	}
     - 
     -+	if (!r->worktree)
     -+		BUG("repository has no worktree");
     -+
     - 	git_SHA1_Init(&sha1ctx);
     - 	git_SHA1_Update(&sha1ctx, r->worktree, strlen(r->worktree));
     - 	git_SHA1_Final(hash, &sha1ctx);
     + ## compat/fsmonitor/fsm-settings-darwin.c => compat/fsmonitor/fsm-settings-unix.c ##
      
       ## contrib/buildsystems/CMakeLists.txt ##
      @@ contrib/buildsystems/CMakeLists.txt: if(SUPPORTS_SIMPLE_IPC)
     - 		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
     - 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-darwin.c)
     - 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-darwin.c)
     --		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-darwin.c)
     -+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-unix.c)
     - 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-darwin.c)
     + 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-${FSMONITOR_DAEMON_BACKEND}.c)
       
       		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
     +-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-${FSMONITOR_DAEMON_BACKEND}.c)
     ++		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-${FSMONITOR_OS_SETTINGS}.c)
     + 	endif()
     + endif()
     + 
      
       ## meson.build ##
      @@ meson.build: if fsmonitor_backend != ''
     - 
     -   libgit_sources += [
     -     'compat/fsmonitor/fsm-health-' + fsmonitor_backend + '.c',
     --    'compat/fsmonitor/fsm-ipc-' + fsmonitor_backend + '.c',
     +     'compat/fsmonitor/fsm-ipc-' + fsmonitor_os + '.c',
           'compat/fsmonitor/fsm-listen-' + fsmonitor_backend + '.c',
           'compat/fsmonitor/fsm-path-utils-' + fsmonitor_backend + '.c',
     -     'compat/fsmonitor/fsm-settings-' + fsmonitor_backend + '.c',
     +-    'compat/fsmonitor/fsm-settings-' + fsmonitor_backend + '.c',
     ++    'compat/fsmonitor/fsm-settings-' + fsmonitor_os + '.c',
         ]
     -+
     -+  if fsmonitor_backend == 'win32'
     -+    libgit_sources += 'compat/fsmonitor/fsm-ipc-win32.c'
     -+  else
     -+    libgit_sources += 'compat/fsmonitor/fsm-ipc-unix.c'
     -+  endif
       endif
       build_options_config.set_quoted('FSMONITOR_DAEMON_BACKEND', fsmonitor_backend)
     - build_options_config.set_quoted('FSMONITOR_OS_SETTINGS', fsmonitor_backend)
  7:  adac7964cc !  7:  03cf12d01b fsmonitor: implement filesystem change listener for Linux
     @@ compat/fsmonitor/fsm-listen-linux.c (new)
      +			if (errno == EAGAIN || errno == EINTR)
      +				goto done;
      +			error_errno(_("reading inotify message stream failed"));
     -+				state->listen_data->shutdown = SHUTDOWN_ERROR;
     ++			state->listen_data->shutdown = SHUTDOWN_ERROR;
      +			goto done;
      +		}
      +
     @@ compat/fsmonitor/fsm-listen-linux.c (new)
      +			/* File system was unmounted or event queue overflowed */
      +			if (em_force_shutdown(event->mask)) {
      +				if (trace_pass_fl(&trace_fsmonitor))
     -+					log_mask_set("Forcing shutdown", event->mask);
     ++					log_mask_set("forcing shutdown", event->mask);
      +				state->listen_data->shutdown = SHUTDOWN_FORCE;
      +				goto done;
      +			}
     @@ compat/fsmonitor/fsm-path-utils-linux.c (new)
      +#ifndef CODA_SUPER_MAGIC
      +#define CODA_SUPER_MAGIC 0x73757245
      +#endif
     -+#ifndef V9FS_MAGIC
     -+#define V9FS_MAGIC 0x01021997
     -+#endif
      +#ifndef FUSE_SUPER_MAGIC
      +#define FUSE_SUPER_MAGIC 0x65735546
      +#endif
     @@ compat/fsmonitor/fsm-path-utils-linux.c (new)
      +}
      +
      +/*
     -+ * Get the filesystem type name for logging purposes.
     ++ * Map filesystem magic numbers to human-readable names as a fallback
     ++ * when /proc/mounts is unavailable.  This only covers the remote and
     ++ * special filesystems in is_remote_fs() above; local filesystems are
     ++ * never flagged as incompatible, so we do not need their names here.
      + */
      +static const char *get_fs_typename(unsigned long f_type)
      +{
     @@ compat/fsmonitor/fsm-path-utils-linux.c (new)
      +		return "afs";
      +	case CODA_SUPER_MAGIC:
      +		return "coda";
     -+	case V9FS_MAGIC:
     -+		return "9p";
      +	case FUSE_SUPER_MAGIC:
      +		return "fuse";
      +	default:
     @@ compat/fsmonitor/fsm-path-utils-linux.c (new)
      +
      +/*
      + * Find the mount point for a given path by reading /proc/mounts.
     -+ * Returns the filesystem type for the longest matching mount point.
     ++ *
     ++ * statfs(2) gives us f_type (the magic number) but not the human-readable
     ++ * filesystem type string.  We scan /proc/mounts to find the mount entry
     ++ * whose path is the longest prefix of ours and whose f_fsid matches,
     ++ * which gives us the fstype string (e.g. "nfs", "ext4") for logging.
      + */
     -+static char *find_mount(const char *path, struct statfs *fs)
     ++static char *find_mount(const char *path, const struct statfs *path_fs)
      +{
      +	FILE *fp;
      +	struct strbuf line = STRBUF_INIT;
      +	struct strbuf match = STRBUF_INIT;
      +	struct strbuf fstype = STRBUF_INIT;
      +	char *result = NULL;
     -+	struct statfs path_fs;
     -+
     -+	if (statfs(path, &path_fs) < 0)
     -+		return NULL;
      +
      +	fp = fopen("/proc/mounts", "r");
      +	if (!fp)
     @@ compat/fsmonitor/fsm-path-utils-linux.c (new)
      +			     path[strlen(mountpoint)] == '\0')) {
      +				/* Check if filesystem ID matches */
      +				if (statfs(mountpoint, &mount_fs) == 0 &&
     -+				    !memcmp(&mount_fs.f_fsid, &path_fs.f_fsid,
     ++				    !memcmp(&mount_fs.f_fsid, &path_fs->f_fsid,
      +					    sizeof(mount_fs.f_fsid))) {
      +					/* Keep the longest matching mount point */
      +					if (strlen(mountpoint) > match.len) {
     @@ compat/fsmonitor/fsm-path-utils-linux.c (new)
      +						strbuf_addstr(&match, mountpoint);
      +						strbuf_reset(&fstype);
      +						strbuf_addstr(&fstype, type);
     -+						*fs = mount_fs;
      +					}
      +				}
      +			}
     @@ contrib/buildsystems/CMakeLists.txt: if(SUPPORTS_SIMPLE_IPC)
       	endif()
       
       	if(FSMONITOR_DAEMON_BACKEND)
     +@@ contrib/buildsystems/CMakeLists.txt: endif()
     + file(STRINGS ${CMAKE_SOURCE_DIR}/GIT-BUILD-OPTIONS.in git_build_options NEWLINE_CONSUME)
     + string(REPLACE "@BROKEN_PATH_FIX@" "" git_build_options "${git_build_options}")
     + string(REPLACE "@DIFF@" "'${DIFF}'" git_build_options "${git_build_options}")
     +-string(REPLACE "@FSMONITOR_DAEMON_BACKEND@" "win32" git_build_options "${git_build_options}")
     +-string(REPLACE "@FSMONITOR_OS_SETTINGS@" "win32" git_build_options "${git_build_options}")
     ++string(REPLACE "@FSMONITOR_DAEMON_BACKEND@" "${FSMONITOR_DAEMON_BACKEND}" git_build_options "${git_build_options}")
     ++string(REPLACE "@FSMONITOR_OS_SETTINGS@" "${FSMONITOR_OS_SETTINGS}" git_build_options "${git_build_options}")
     + string(REPLACE "@GITWEBDIR@" "'${GITWEBDIR}'" git_build_options "${git_build_options}")
     + string(REPLACE "@GIT_INTEROP_MAKE_OPTS@" "" git_build_options "${git_build_options}")
     + string(REPLACE "@GIT_PERF_LARGE_REPO@" "" git_build_options "${git_build_options}")
      
       ## meson.build ##
      @@ meson.build: fsmonitor_os = ''
  9:  c684fc9094 !  8:  29a6461915 run-command: add close_fd_above_stderr option
     @@ Commit message
          run-command: add close_fd_above_stderr option
      
          Add a new option to struct child_process that closes file descriptors
     -    3 and above in the child after forking but before exec.  This prevents
     -    long-running child processes from inheriting pipe endpoints or other
     +    3 and above in the child after forking but before exec.  Without this,
     +    long-running child processes inherit pipe endpoints and other
          descriptors from the parent environment.
      
          The upper bound for the fd scan comes from sysconf(_SC_OPEN_MAX),
 10:  4987a009a2 !  9:  b596c5004d fsmonitor: close inherited file descriptors and detach in daemon
     @@ Commit message
          holds these open, the parent process never sees EOF and may appear to
          hang.
      
     -    Set close_fd_above_stderr on the child process at daemon startup so
     -    that file descriptors 3 and above are closed before any daemon work
     -    begins.  This ensures the daemon does not inadvertently hold open
     -    descriptors from its launching environment.
     +    Set close_fd_above_stderr on the child process at both daemon startup
     +    paths: the explicit "fsmonitor--daemon start" command and the implicit
     +    spawn triggered by fsmonitor-ipc when a client finds no running daemon.
     +    Also suppress stdout and stderr on the implicit spawn path to prevent
     +    the background daemon from writing to the client's terminal.
      
          Additionally, call setsid() when the daemon starts with --detach to
     -    create a new session and process group.  Without this, shells that
     -    enable job control (e.g. bash with "set -m") treat the daemon as part
     -    of the spawning command's job.  Their "wait" builtin then blocks until
     -    the daemon exits, which it never does.  This specifically affects
     -    systems where /bin/sh is bash (e.g. Fedora), since dash only waits for
     -    the specific PID rather than the full process group.
     -
     -    Add a 30-second timeout to "fsmonitor--daemon stop" so it does
     -    not block indefinitely if the daemon fails to shut down.
     +    create a new session and process group.  This prevents the daemon
     +    from being part of the spawning shell's process group, which could
     +    cause the shell's "wait" to block until the daemon exits.
      
          Signed-off-by: Paul Tarjan <github@paulisageek.com>
      
       ## builtin/fsmonitor--daemon.c ##
     -@@ builtin/fsmonitor--daemon.c: static int do_as_client__send_stop(void)
     - {
     - 	struct strbuf answer = STRBUF_INIT;
     - 	int ret;
     -+	int max_wait_ms = 30000;
     -+	int elapsed_ms = 0;
     - 
     - 	ret = fsmonitor_ipc__send_command("quit", &answer);
     - 
     -@@ builtin/fsmonitor--daemon.c: static int do_as_client__send_stop(void)
     - 		return ret;
     - 
     - 	trace2_region_enter("fsm_client", "polling-for-daemon-exit", NULL);
     --	while (fsmonitor_ipc__get_state() == IPC_STATE__LISTENING)
     -+	while (fsmonitor_ipc__get_state() == IPC_STATE__LISTENING) {
     -+		if (elapsed_ms >= max_wait_ms) {
     -+			trace2_region_leave("fsm_client",
     -+					    "polling-for-daemon-exit", NULL);
     -+			return error(_("daemon did not stop within %d seconds"),
     -+				     max_wait_ms / 1000);
     -+		}
     - 		sleep_millisec(50);
     -+		elapsed_ms += 50;
     -+	}
     - 	trace2_region_leave("fsm_client", "polling-for-daemon-exit", NULL);
     - 
     - 	return 0;
      @@ builtin/fsmonitor--daemon.c: done:
       	return err;
       }
     @@ fsmonitor-ipc.c: static int spawn_daemon(void)
       	cmd.trace2_child_class = "fsmonitor";
       	strvec_pushl(&cmd.args, "fsmonitor--daemon", "start", NULL);
       
     -
     - ## t/meson.build ##
     -@@ t/meson.build: test_environment = script_environment
     - test_environment.set('GIT_BUILD_DIR', git_build_dir)
     - 
     - foreach integration_test : integration_tests
     --  per_test_kwargs = test_kwargs
     --  # The fsmonitor tests start daemon processes that in some environments
     --  # can hang.  Set a generous timeout to prevent CI from blocking.
     --  if fs.stem(integration_test) == 't7527-builtin-fsmonitor'
     --    per_test_kwargs += {'timeout': 1800}
     --  endif
     -   test(fs.stem(integration_test), shell,
     -     args: [ integration_test ],
     -     workdir: meson.current_source_dir(),
     -     env: test_environment,
     -     depends: test_dependencies + bin_wrappers,
     --    kwargs: per_test_kwargs,
     -+    kwargs: test_kwargs,
     -   )
     - endforeach
     - 
     -
     - ## t/t7527-builtin-fsmonitor.sh ##
     -@@ t/t7527-builtin-fsmonitor.sh: do
     - 		else
     - 			test_expect_success "Matrix[uc:$uc_val][fsm:$fsm_val] enable fsmonitor" '
     - 				git config core.fsmonitor true &&
     --				git fsmonitor--daemon start &&
     -+				git fsmonitor--daemon start --start-timeout=10 &&
     - 				git update-index --fsmonitor
     - 			'
     - 		fi
     -@@ t/t7527-builtin-fsmonitor.sh: start_git_in_background () {
     - 		nr_tries_left=$(($nr_tries_left - 1))
     - 	done >/dev/null 2>&1 3>&- 4>&- 5>&- 6>&- 7>&- &
     - 	watchdog_pid=$!
     -+
     -+	# Disable job control before wait.  With "set -m", bash treats
     -+	# "wait $pid" as waiting for the entire job (process group),
     -+	# which blocks indefinitely if the fsmonitor daemon was spawned
     -+	# into the same process group and is still running.  Turning off
     -+	# job control makes "wait" only wait for the specific PID.
     -+	set +m &&
     - 	wait $git_pid
     -+	wait_status=$?
     -+	set -m
     -+	return $wait_status
     - }
     - 
     - stop_git () {
  -:  ---------- > 10:  72125ac20f fsmonitor: add timeout to daemon stop command
  8:  fad2f0a81a ! 11:  76b171ab5c fsmonitor: add tests for Linux
     @@ Commit message
          as harmless.  An earlier version of the listener crashed in this
          scenario.
      
     -    Signed-off-by: Paul Tarjan <github@paulisageek.com>
     +    Reduce --start-timeout from the default 60 seconds to 10 seconds so
     +    that tests fail promptly when the daemon cannot start.
      
     - ## t/meson.build ##
     -@@ t/meson.build: test_environment = script_environment
     - test_environment.set('GIT_BUILD_DIR', git_build_dir)
     - 
     - foreach integration_test : integration_tests
     -+  per_test_kwargs = test_kwargs
     -+  # The fsmonitor tests start daemon processes that in some environments
     -+  # can hang.  Set a generous timeout to prevent CI from blocking.
     -+  if fs.stem(integration_test) == 't7527-builtin-fsmonitor'
     -+    per_test_kwargs += {'timeout': 1800}
     -+  endif
     -   test(fs.stem(integration_test), shell,
     -     args: [ integration_test ],
     -     workdir: meson.current_source_dir(),
     -     env: test_environment,
     -     depends: test_dependencies + bin_wrappers,
     --    kwargs: test_kwargs,
     -+    kwargs: per_test_kwargs,
     -   )
     - endforeach
     - 
     +    Harden the test helpers to work in environments without procps
     +    (e.g., Fedora CI): fall back to reading /proc/$pid/stat for the
     +    process group ID when ps is unavailable, guard stop_git() against
     +    an empty pgid, and redirect stderr from kill to /dev/null to avoid
     +    noise when processes have already exited.
     +
     +    Use set -m to enable job control in the submodule-pull test so that
     +    the background git pull gets its own process group, preventing the
     +    shell wait from blocking on the daemon.  setsid() in the previous
     +    commit detaches the daemon itself, but the intermediate git pull
     +    process still needs its own process group for the test shell to
     +    manage it correctly.
     +
     +    Signed-off-by: Paul Tarjan <github@paulisageek.com>
      
       ## t/t7527-builtin-fsmonitor.sh ##
      @@ t/t7527-builtin-fsmonitor.sh: then
  -:  ---------- > 12:  6c36c9e11e fsmonitor: convert shown khash to strset in do_handle_client

-- 
gitgitgadget
