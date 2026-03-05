Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F6E70818
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 01:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772673383; cv=none; b=cWhiKA82qtheg9F063AcTcEA4UHKTbZxShMTKsJFzv2UcBJgDkM24fE6QRC4414ckiIM2A/t0S/1JLYgRX8+smtW1TtWCvPHS9c3iE8aNng8GQeY0BH6wuzboxlc/urE0aQqXFFydMyAIKk9qY853vvAJ2su+lK4o4s057i72kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772673383; c=relaxed/simple;
	bh=BNvjxSWT6pgHEXjaSRrpI0Lr4tOYXSap0wHLj99/Ycs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tupVd2sDSBYzSV972n0CYW3p+1OgBjzfcY1kY8+NsuwYXbeO8CtFKYaeShCjoVslcNYsoaPZX1kJGnyxI99/4QQ3c31uIuc/SIMWbyzA/MH0DR4Bh1HBvtNHHIOWYHB3WqdQBKc8gWwqrPhFsSL6h7uy8IBEs22Ku9QOQnjcOiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiXlzOCN; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiXlzOCN"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cb3dfb3461so751912085a.3
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 17:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772673381; x=1773278181; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6uacCkh6zyCclG12D4lq/BHBZgBtivAyq7xGxmP6hc=;
        b=UiXlzOCNr8bfhtVsdT6ZGYb1qmvUSOACLaLSAqA/F69S9LbObOShOjsdXRJU0KhlpK
         Y2Pn3yqMMDowx3Uh7OR+AEhhz2rKi6c/1lTQWoAT4FFmW1daAfEtl35u1T7i7JzX1B+P
         w4qVMpMDTmP7Z4UMZCCBmOVe7FjeDpcp12GQw0AvVgIXOEm3knbuLPUd8wcBX8hcQs86
         YZvA1/q84B6+lWIhcqeS2s/nvNVCQZp9Kc1zFwtHi2EFrDlm1HAqU1d083zaotcvEEJX
         to8G7VaiYN2fZwJq46AMe9pjBgTXxUPEREzsWWzlKa6NMjedxpw6WEMJqUVdt6XWoa4c
         Z+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772673381; x=1773278181;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L6uacCkh6zyCclG12D4lq/BHBZgBtivAyq7xGxmP6hc=;
        b=MZC/kGM9ZQFJH7MiZdEziVyr07G8UTR5KAkpm0UU6H75D53GIXI7v60MZWPLq3mNpE
         HBXZGze1AQtraApmtzwP7/6GQigyDswWzCbs2SrNET7dQqBQfkaNflfnVOdPpn+Q188n
         hs2I1KvikvOHG5mufYdwduSseHt1nJRoCS6UZbDvOvuYaFSJ1rEsUHN4j7tQst13Vs8M
         zWTh1VOLV4UTP0491ia1f7itfg9qtJsgT5vcUDzYkzMpFvXJQFJzuMUyKk85nrAC8gYj
         MqA6LCM/h/wuAkDNPKc3Jwms4wehzhmBwKaIBN5t2griAB04k/6nX7lhQfayGSrZy3rw
         p1FA==
X-Gm-Message-State: AOJu0Yw2rLC/D+bbLXNvFXPKhK+lFJQjTBrD5s+u+xKWGLj+PM0FzlfW
	MVkqJwy7A25xuegjbAYbdBHJHuB1NEMFgtC6v2E2MT+TK3It2qBdpkI0b9fWBw==
X-Gm-Gg: ATEYQzyUs2wB+3E6pHajtiSUOwRMeEAyD5NrkCcZABipeZaQK0rHAifwZRqYzBN6Gb5
	nDMMNlfV4cjAwYjAA/Wa0IxJlJpGXOMp3Bf5idfGFi69dqkpFXJu2KqI3h9r7njPUwEUqSYzT9A
	5vat1LTC7m1AgumbK/aZ89GGdXCkc+s8rExAnImvyffPVVmXq2t8fSoao5pMuRfZRtRGOjMooT7
	APyfXAJgSwuD0R1XrWt7VJdUR8hAveLlu4B5iSslvyjyXYRGmriKgMzEzzn614B5s1SFi07yFEN
	/LW1xXgUgYcsDa4q0FMT/riMduab85exepbAXXf3zdr7f+N3ZsXeuHIzR6/sHb3S+vgr9431kel
	Y+Z1bi59biSloKHWHu8HTDnchVBi00ofTRzAYlkBh3ApCNMBncxquF4nCGQbl573Ya8+9QMblZn
	jK58GGHv8tPoCpjbNoPMmyohk=
X-Received: by 2002:a05:620a:1904:b0:8c5:2f36:660f with SMTP id af79cd13be357-8cd5afc75e3mr525487385a.78.1772673380700;
        Wed, 04 Mar 2026 17:16:20 -0800 (PST)
Received: from [127.0.0.1] ([51.8.152.229])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf6869f5sm2039626285a.20.2026.03.04.17.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 17:16:19 -0800 (PST)
Message-Id: <pull.2147.v10.git.git.1772673378.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v9.git.git.1772671920.gitgitgadget@gmail.com>
References: <pull.2147.v9.git.git.1772671920.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Mar 2026 01:16:06 +0000
Subject: [PATCH v10 00/12] fsmonitor: implement filesystem change listener for Linux
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

Changes since v8:

 * Replaced close_fd_above_stderr flag with generic pre_exec_cb callback in
   struct child_process per Junio's review
 * Provided close_fd_above_stderr() as a ready-made callback function
 * Fixed Windows build: close_fd_above_stderr() compiles as a no-op on
   Windows since there is no fork/exec

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
  run-command: add pre-exec callback for child processes
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
 run-command.c                                 |  18 +
 run-command.h                                 |  16 +
 t/t7527-builtin-fsmonitor.sh                  |  89 ++-
 18 files changed, 1275 insertions(+), 63 deletions(-)
 create mode 100644 compat/fsmonitor/fsm-health-linux.c
 rename compat/fsmonitor/{fsm-ipc-darwin.c => fsm-ipc-unix.c} (100%)
 create mode 100644 compat/fsmonitor/fsm-listen-linux.c
 create mode 100644 compat/fsmonitor/fsm-path-utils-linux.c
 rename compat/fsmonitor/{fsm-settings-darwin.c => fsm-settings-unix.c} (100%)


base-commit: 3e0db84c88c57e70ac8be8c196dfa92c5d656fbc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2147%2Fptarjan%2Fclaude%2Fupdate-pr-1352-current-85Gk8-v10
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2147/ptarjan/claude/update-pr-1352-current-85Gk8-v10
Pull-Request: https://github.com/git/git/pull/2147

Range-diff vs v9:

  1:  4d4dec8fa1 =  1:  4d4dec8fa1 fsmonitor: fix khash memory leak in do_handle_client
  2:  cb270120f0 =  2:  cb270120f0 fsmonitor: fix hashmap memory leak in fsmonitor_run_daemon
  3:  44a063074d =  3:  44a063074d compat/win32: add pthread_cond_timedwait
  4:  b1081d1e13 =  4:  b1081d1e13 fsmonitor: use pthread_cond_timedwait for cookie wait
  5:  dec0fb144f =  5:  dec0fb144f fsmonitor: rename fsm-ipc-darwin.c to fsm-ipc-unix.c
  6:  b2aaadb4ae =  6:  b2aaadb4ae fsmonitor: rename fsm-settings-darwin.c to fsm-settings-unix.c
  7:  03cf12d01b =  7:  03cf12d01b fsmonitor: implement filesystem change listener for Linux
  8:  31fa1fb324 !  8:  39dcfbb7c8 run-command: add pre-exec callback for child processes
     @@ Commit message
          Signed-off-by: Paul Tarjan <github@paulisageek.com>
      
       ## run-command.c ##
     -@@ run-command.c: static void trace_run_command(const struct child_process *cp)
     - 	strbuf_release(&buf);
     +@@ run-command.c: static void atfork_parent(struct atfork_state *as)
     + 		"restoring signal mask");
     + #endif
       }
     ++
     + #endif /* GIT_WINDOWS_NATIVE */
       
      +void close_fd_above_stderr(void)
      +{
     ++#ifndef GIT_WINDOWS_NATIVE
      +	long max_fd = sysconf(_SC_OPEN_MAX);
      +	int fd;
      +	if (max_fd < 0 || max_fd > 4096)
     @@ run-command.c: static void trace_run_command(const struct child_process *cp)
      +		if (fd != child_notifier)
      +			close(fd);
      +	}
     ++#endif
      +}
      +
     - int start_command(struct child_process *cmd)
     + static inline void set_cloexec(int fd)
       {
     - 	int need_in, need_out, need_err;
     + 	int flags = fcntl(fd, F_GETFD);
      @@ run-command.c: fail_pipe:
       			child_close(cmd->out);
       		}
     @@ run-command.h: struct child_process {
      +/**
      + * Close file descriptors 3 and above.  Suitable for use as a
      + * pre_exec_cb to prevent the child from inheriting pipe endpoints
     -+ * or other descriptors from the parent environment.
     ++ * or other descriptors from the parent environment.  On Windows
     ++ * this is a no-op since there is no fork/exec.
      + */
      +void close_fd_above_stderr(void);
      +
  9:  c963074cbd =  9:  5db0591c15 fsmonitor: close inherited file descriptors and detach in daemon
 10:  ee3ee75c94 = 10:  8a9a6ba4fa fsmonitor: add timeout to daemon stop command
 11:  54bd8f604a = 11:  27d5560007 fsmonitor: add tests for Linux
 12:  e603fc7dde = 12:  8ea20aab4c fsmonitor: convert shown khash to strset in do_handle_client

-- 
gitgitgadget
