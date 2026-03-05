Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A36222582
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 00:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772671925; cv=none; b=SnKNkZu5cbTZ0eNov/LcaoXpOAz3YkEMuk1ThUNd3qKVENEt0M2rEfOSpUhZD1bgPrSLFZQ60ESmvtOGsARilJ9+b3ysEwmGJoBInJnU2xXX/N1loLy/0TT5fcv3jh1mYJIs5kxZkV0OFdlhHwxGhMJO8JTlgzeGa58naXv8EpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772671925; c=relaxed/simple;
	bh=FRraqP0MB1FA5AwafEQ0DL9ED6AJDMe2dBN/hpHCKRk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gtdR/rNnOHBF/tmLM5tzzrlV4OyZOecSjPuJOlDnOoh/zzPtYVt/+GkvNYkF8ICUocMz4FFH12uL/u8G+uyUT5zz5Qef7I9UqA0zRYemM2MLNugRrYXbRos/6xZYs84RP4av2KoTcZFXn0pAN4vfrTFa8GAip6hGminRYEXGPpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCZSbvnA; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCZSbvnA"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b4520f6b32so8608876eec.0
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 16:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772671923; x=1773276723; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AmzCpNCGfIPFV8lX4gsZoe+hKua617V54U0VYHjPOHQ=;
        b=lCZSbvnAPSXD7i3UBwpsNCT80XA1qLEdr5DQMmjEfJ6HsuC0WBNS7JD98ZPEroMyIh
         VbXpf23UDa62OJ5go6YiXqu+gVRx5G9kc3EMYa//AldXpaxoBfngjTxX8iLYIwiIgQPE
         kIlOmtM0qldL6MtUjwM/zSDE0S9yu/eCb+NUaGR/0e1AIeszPk66+B0+skNYSvmEQmhf
         eFKohEZX1RX/inbAwuhSxNwph7EjzkofLeaqqSSw0fEcNHvKsV4F0t/02oSdz1E7kAjF
         imU7D66PB+k4PPtrTgTVCCrXNoB55lL5LE4n3pP0q4fzJ27Mwb/R7tXkaFX/BpCb+M/t
         Fj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772671923; x=1773276723;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AmzCpNCGfIPFV8lX4gsZoe+hKua617V54U0VYHjPOHQ=;
        b=HxBbOtHHV1y8Kbis2NfxF71fV3wFsz2701PJCv/TO7n4dWPZsn6PA9bdHevHGsdt3E
         Q0NIMBbgVX8ZvIItGD41CIEiHWZtKv6f9xnXdgMJsRw3PmApHYH/wPr7hcKKei/m/iQu
         9mTSqUXvnyGFaz2dY1k/Nc1e2jLFb/a28d5T4EYNhjX0k7emHL0WSfOiZXvjN9IlRqvk
         av5rUqxsomFHds18sVSlWNHyqyAjcPi+3YyHcw0S1jLYYH5PTEIrzW2arY2M2bgrqQwY
         G1YiWALF1AMLmqh/tsxojJPTfH4oQAPfMm0JC0miMoIBRoHFa/eRB1rmHbyf000ZI+ZL
         GRlQ==
X-Gm-Message-State: AOJu0YwtFyIHbcY2j/PAxH75MIh9+SXru40v5vTkkgq0wi6qflFhWxSs
	kzQuJHbplqVeJMMftc/mckm2w8YxgBJ94zxczqnhA3ZuPa9U6cFRAKIsQbHhhg==
X-Gm-Gg: ATEYQzxBCBUCiV2DijrW3/RyBTbBd+IJ+bAGuaRqrRPST3KRbxONMuu/SD775P9KHXQ
	V9+n+ZYhTyo4OqTbAX+DWp0P3ufMAqlYwIjHqHytGN2FRDdz5LJoM9laqQD1QsmJNEOoEO7xmtj
	tdKr3j/fnkEFExK1Q3+CaoSFqtvdFgl+3D8WK+GIy5/YNwALRG4m+UnJznOzxHgoos3ObFof9yq
	2E4bPxyQDEqzme01jzVYAu++oAQMQHEKo0f1mfePnRgWKGNBsJd6DatY0CyalyTshkM1JO6SEMV
	Q554DoKgRDrBnpxr6o2t2b2xUEbnEFmgiDWWH10ehp72BIB5qReve0Pwj+6MgLDKMZZ2wyAxh3n
	StAc9gE5Jj/PI+394kcmZ3zOnb9KKAlaOioCkRe8evIM3lWfWTpejRhFODkrhzXU3FbQcedRAoM
	4KO9JtPC7jlbWKVHx9SboktyP9
X-Received: by 2002:a05:7300:4307:b0:2b8:6ae5:79c3 with SMTP id 5a478bee46e88-2be311df800mr1470949eec.38.1772671922430;
        Wed, 04 Mar 2026 16:52:02 -0800 (PST)
Received: from [127.0.0.1] ([68.220.62.148])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1f23c01sm16176332eec.16.2026.03.04.16.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 16:52:01 -0800 (PST)
Message-Id: <pull.2147.v9.git.git.1772671920.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v8.git.git.1772648125.gitgitgadget@gmail.com>
References: <pull.2147.v8.git.git.1772648125.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Mar 2026 00:51:48 +0000
Subject: [PATCH v9 00/12] fsmonitor: implement filesystem change listener for Linux
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
 run-command.c                                 |  15 +
 run-command.h                                 |  15 +
 t/t7527-builtin-fsmonitor.sh                  |  89 ++-
 18 files changed, 1271 insertions(+), 63 deletions(-)
 create mode 100644 compat/fsmonitor/fsm-health-linux.c
 rename compat/fsmonitor/{fsm-ipc-darwin.c => fsm-ipc-unix.c} (100%)
 create mode 100644 compat/fsmonitor/fsm-listen-linux.c
 create mode 100644 compat/fsmonitor/fsm-path-utils-linux.c
 rename compat/fsmonitor/{fsm-settings-darwin.c => fsm-settings-unix.c} (100%)


base-commit: 3e0db84c88c57e70ac8be8c196dfa92c5d656fbc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2147%2Fptarjan%2Fclaude%2Fupdate-pr-1352-current-85Gk8-v9
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2147/ptarjan/claude/update-pr-1352-current-85Gk8-v9
Pull-Request: https://github.com/git/git/pull/2147

Range-diff vs v8:

  1:  4d4dec8fa1 =  1:  4d4dec8fa1 fsmonitor: fix khash memory leak in do_handle_client
  2:  cb270120f0 =  2:  cb270120f0 fsmonitor: fix hashmap memory leak in fsmonitor_run_daemon
  3:  44a063074d =  3:  44a063074d compat/win32: add pthread_cond_timedwait
  4:  b1081d1e13 =  4:  b1081d1e13 fsmonitor: use pthread_cond_timedwait for cookie wait
  5:  dec0fb144f =  5:  dec0fb144f fsmonitor: rename fsm-ipc-darwin.c to fsm-ipc-unix.c
  6:  b2aaadb4ae =  6:  b2aaadb4ae fsmonitor: rename fsm-settings-darwin.c to fsm-settings-unix.c
  7:  03cf12d01b =  7:  03cf12d01b fsmonitor: implement filesystem change listener for Linux
  8:  29a6461915 !  8:  31fa1fb324 run-command: add close_fd_above_stderr option
     @@ Metadata
      Author: Paul Tarjan <github@paulisageek.com>
      
       ## Commit message ##
     -    run-command: add close_fd_above_stderr option
     +    run-command: add pre-exec callback for child processes
      
     -    Add a new option to struct child_process that closes file descriptors
     -    3 and above in the child after forking but before exec.  Without this,
     -    long-running child processes inherit pipe endpoints and other
     -    descriptors from the parent environment.
     +    Add a pre_exec_cb function pointer to struct child_process that is
     +    invoked in the child between fork and exec.  This gives callers a
     +    place to perform setup that must happen in the child's context,
     +    such as closing inherited file descriptors.
      
     -    The upper bound for the fd scan comes from sysconf(_SC_OPEN_MAX),
     -    capped at 4096 to avoid excessive iteration when the limit is set
     -    very high.
     +    Provide close_fd_above_stderr() as a ready-made callback that
     +    closes file descriptors 3 and above (skipping the child-notifier
     +    pipe), capped at sysconf(_SC_OPEN_MAX) or 4096, whichever is
     +    smaller.
      
          Signed-off-by: Paul Tarjan <github@paulisageek.com>
      
       ## run-command.c ##
     +@@ run-command.c: static void trace_run_command(const struct child_process *cp)
     + 	strbuf_release(&buf);
     + }
     + 
     ++void close_fd_above_stderr(void)
     ++{
     ++	long max_fd = sysconf(_SC_OPEN_MAX);
     ++	int fd;
     ++	if (max_fd < 0 || max_fd > 4096)
     ++		max_fd = 4096;
     ++	for (fd = 3; fd < max_fd; fd++) {
     ++		if (fd != child_notifier)
     ++			close(fd);
     ++	}
     ++}
     ++
     + int start_command(struct child_process *cmd)
     + {
     + 	int need_in, need_out, need_err;
      @@ run-command.c: fail_pipe:
       			child_close(cmd->out);
       		}
       
     -+		if (cmd->close_fd_above_stderr) {
     -+			long max_fd = sysconf(_SC_OPEN_MAX);
     -+			int fd;
     -+			if (max_fd < 0 || max_fd > 4096)
     -+				max_fd = 4096;
     -+			for (fd = 3; fd < max_fd; fd++) {
     -+				if (fd != child_notifier)
     -+					close(fd);
     -+			}
     -+		}
     ++		if (cmd->pre_exec_cb)
     ++			cmd->pre_exec_cb();
      +
       		if (cmd->dir && chdir(cmd->dir))
       			child_die(CHILD_ERR_CHDIR);
     @@ run-command.h: struct child_process {
       	unsigned wait_after_clean:1;
      +
      +	/**
     -+	 * Close file descriptors 3 and above in the child after forking
     -+	 * but before exec.  This prevents the long-running child from
     -+	 * inheriting pipe endpoints or other descriptors from the parent
     -+	 * environment (e.g., the test harness).
     ++	 * If set, the callback is invoked in the child between fork and
     ++	 * exec.  It can be used, for example, to close inherited file
     ++	 * descriptors that the child should not keep open.
      +	 */
     -+	unsigned close_fd_above_stderr:1;
     ++	void (*pre_exec_cb)(void);
      +
       	void (*clean_on_exit_handler)(struct child_process *process);
       };
       
     +@@ run-command.h: struct child_process {
     + 	.env = STRVEC_INIT, \
     + }
     + 
     ++/**
     ++ * Close file descriptors 3 and above.  Suitable for use as a
     ++ * pre_exec_cb to prevent the child from inheriting pipe endpoints
     ++ * or other descriptors from the parent environment.
     ++ */
     ++void close_fd_above_stderr(void);
     ++
     + /**
     +  * The functions: start_command, finish_command, run_command do the following:
     +  *
  9:  b596c5004d !  9:  c963074cbd fsmonitor: close inherited file descriptors and detach in daemon
     @@ builtin/fsmonitor--daemon.c: static int try_to_start_background_daemon(void)
       	cp.no_stdin = 1;
       	cp.no_stdout = 1;
       	cp.no_stderr = 1;
     -+	cp.close_fd_above_stderr = 1;
     ++	cp.pre_exec_cb = close_fd_above_stderr;
       
       	sbgr = start_bg_command(&cp, bg_wait_cb, NULL,
       				fsmonitor__start_timeout_sec);
     @@ fsmonitor-ipc.c: static int spawn_daemon(void)
       	cmd.no_stdin = 1;
      +	cmd.no_stdout = 1;
      +	cmd.no_stderr = 1;
     -+	cmd.close_fd_above_stderr = 1;
     ++	cmd.pre_exec_cb = close_fd_above_stderr;
       	cmd.trace2_child_class = "fsmonitor";
       	strvec_pushl(&cmd.args, "fsmonitor--daemon", "start", NULL);
       
 10:  72125ac20f = 10:  ee3ee75c94 fsmonitor: add timeout to daemon stop command
 11:  76b171ab5c = 11:  54bd8f604a fsmonitor: add tests for Linux
 12:  6c36c9e11e = 12:  e603fc7dde fsmonitor: convert shown khash to strset in do_handle_client

-- 
gitgitgadget
