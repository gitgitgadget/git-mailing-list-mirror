Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CF32D5923
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 20:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772050641; cv=none; b=du7rhwvFHi70w57BP/uf1Tx+LTJSS0HoeW4WTByAR1gz9lmdKiLVhS7p0VUJFGLLwfPqyFPFrA1T7M09U1GcLIn5JzeoxEbJHTISmhuLdRRsNBrl9ocBvg7BbuYlXAqql7Go7848AeT2I4Aow/2xmv7ZTa/XstXDG7/XuGx4K1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772050641; c=relaxed/simple;
	bh=623CGF1fH0G8ZJUQnzqKYEuu/HKsEHEHaVInyDWyhr4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VZKMW7o3ZcnDxax43nGIQvw5gc1WVvHx2pQ24anYSrbtMdWmldliKLxbEdFPP7SDxXGfcqIWfGfuZDq5Le+BoPVIz+Ub9eQ4z0roDiMUTt7hBeVQEpALzv3mEExZXW/0YXTj7VyImJY1eh6pfqdNJR09BP3xJD/UQw3KMkSv3qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bL80yTnv; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bL80yTnv"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8ca01dc7d40so704355885a.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 12:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772050638; x=1772655438; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRR90DTCL6ij2Q+ds68+hKQmU2+IT9St45DaFshNcUY=;
        b=bL80yTnvh1wMS+XiD0Gx7+WvYWG3Ix8LRzW9InRIETcg5WT6BNMXwR4qHh4xN+tIjB
         1/vP0ebN4rcsJGutYGmlnQPkssfaxa+8iu/IvfyUrgzgTraMpGHtXIuUzqmuHBpCFDkQ
         Yna6vLVCH+ObfYyPQfXOTq9Moj9IYXYGFoqmFRKwZm/SdSSc15xx0h25I5i+4Z4ZSwSO
         4W/y+95DEOnZQ3y41MNCDAFwbFpPnRr5Ijh1C8eDMRysfxTwD99w+aU7iI4WrzWCKCIt
         KKCx+8ewEhsgJw1dwbKDOYA21bxAY+IdSnStfsipSi5suPayfJxE8zy/A1b1rtDJAmIH
         ekqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772050638; x=1772655438;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yRR90DTCL6ij2Q+ds68+hKQmU2+IT9St45DaFshNcUY=;
        b=YCbvr0qYQ4WxFnOGZ7ShqbfQcMt+vcSwA8uTV3+bCgKCy3QCAuq4s5TaIKvSIYjT11
         2FSflW0nqIyscaJENpuV1QCsso+19s/vAOV+w8RZK62xg2MwKb89fmuLbIKhB+50E3Jf
         f636BWKNCu7iq2XLmS7Pm53CQAqXPDnaCxSLvMNjL1kJIL0sXhYtjA8WM2r8TmFu5dx5
         VFS9CSVNhONMDT399OeTclswbB16nyjdJLk/LH4JI7z0YcA1efO5RjOiAFl9GP8uvvm7
         fHuzS0XUW+kegI9EAaKlAevs7SSMGAUjTJjHPxqfzdsffEXS6lrM7/HAhKGjbYMQNhIA
         8ynQ==
X-Gm-Message-State: AOJu0YxZtx6JXIAEUY6uglU6LECOpfwK1t7ntrUPoSF03VPDnE/zarao
	rpqZdamvMnpXFFU98UHVRogT5QmdIypKxHRIeGPStaR5sf0s0zQrCf4m8auW+w==
X-Gm-Gg: ATEYQzwpBuvqUQF+34dwHd8EsCestTwwMx/smYaSjXLzS8UKR4+vW7rLVrXR6MQupLw
	nnl5J+EFB7lKuJVaiKIjWHtXlSIHeoqsUImMbcspBp1ArU8Y4+sDE7PFSr2g+hSxu4RCneDalKg
	2MCHfdZUHvWw3fksReJ/V3B6Yw66YmYpWNtZOuPOB/z5Qv6XnNjS8bkh1T5cRVYO2HZMX2YZgYN
	Aggwm4iCmwqqRJeibfbJm8NVWlVVvcfRQJd8AM19YcJBT6njYgnjVj66Kc9X6T+bTHsw32s5Co+
	VfA6jPHWAwTlOs6WUeHAzlCfQNxPP/LiQP0mcqVTwjnF6AN2qkkgLaRMU0wS+qAfOZPbSiVAPYt
	b+jZkkr67iXHVdPoA5QI2YsMRhbChE555n/+DtwUTgI1nCUxf7gfLTZNQ+3C50OUE2kE09tUbRo
	qRT/LfDxmqrglJ9MEHxO3zKyfmG8x9SzeIeOWL
X-Received: by 2002:a05:620a:4891:b0:8c6:f76e:c6f1 with SMTP id af79cd13be357-8cb8ca034f5mr2214272085a.26.1772050637600;
        Wed, 25 Feb 2026 12:17:17 -0800 (PST)
Received: from [127.0.0.1] ([135.119.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf6f93b5sm13028985a.31.2026.02.25.12.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 12:17:16 -0800 (PST)
Message-Id: <pull.2147.v6.git.git.1772050636.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v5.git.git.1771896704209.gitgitgadget@gmail.com>
References: <pull.2147.v5.git.git.1771896704209.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Feb 2026 20:17:06 +0000
Subject: [PATCH v6 00/10] fsmonitor: implement filesystem change listener for Linux
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
 Makefile                                      |  12 +-
 builtin/fsmonitor--daemon.c                   |  71 +-
 compat/fsmonitor/fsm-health-linux.c           |  33 +
 .../{fsm-ipc-darwin.c => fsm-ipc-unix.c}      |   4 +-
 compat/fsmonitor/fsm-listen-linux.c           | 746 ++++++++++++++++++
 compat/fsmonitor/fsm-path-utils-linux.c       | 220 ++++++
 ...-settings-darwin.c => fsm-settings-unix.c} |  24 +-
 compat/win32/pthread.c                        |  26 +
 compat/win32/pthread.h                        |   2 +
 config.mak.uname                              |  10 +
 contrib/buildsystems/CMakeLists.txt           |  14 +-
 fsmonitor-ipc.c                               |   3 +
 meson.build                                   |  17 +-
 run-command.c                                 |  11 +
 run-command.h                                 |   9 +
 t/t7527-builtin-fsmonitor.sh                  | 101 ++-
 18 files changed, 1286 insertions(+), 49 deletions(-)
 create mode 100644 compat/fsmonitor/fsm-health-linux.c
 rename compat/fsmonitor/{fsm-ipc-darwin.c => fsm-ipc-unix.c} (96%)
 create mode 100644 compat/fsmonitor/fsm-listen-linux.c
 create mode 100644 compat/fsmonitor/fsm-path-utils-linux.c
 rename compat/fsmonitor/{fsm-settings-darwin.c => fsm-settings-unix.c} (82%)


base-commit: 3e0db84c88c57e70ac8be8c196dfa92c5d656fbc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2147%2Fptarjan%2Fclaude%2Fupdate-pr-1352-current-85Gk8-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2147/ptarjan/claude/update-pr-1352-current-85Gk8-v6
Pull-Request: https://github.com/git/git/pull/2147

Range-diff vs v5:

  -:  ---------- >  1:  4d4dec8fa1 fsmonitor: fix khash memory leak in do_handle_client
  -:  ---------- >  2:  d0bd3e32ca fsmonitor: fix hashmap memory leak in fsmonitor_run_daemon
  -:  ---------- >  3:  d2c5ca0939 compat/win32: add pthread_cond_timedwait
  -:  ---------- >  4:  0051a19303 fsmonitor: use pthread_cond_timedwait for cookie wait
  -:  ---------- >  5:  ff31e359a7 fsmonitor: deduplicate IPC path logic for Unix platforms
  -:  ---------- >  6:  39da1e6be3 fsmonitor: deduplicate settings logic for Unix platforms
  1:  c54814eb31 !  7:  4eadc06004 fsmonitor: implement filesystem change listener for Linux
     @@ Metadata
       ## Commit message ##
          fsmonitor: implement filesystem change listener for Linux
      
     -    Implement fsmonitor for Linux using the inotify API, bringing it to
     -    feature parity with existing Windows and macOS implementations.
     +    Implement the built-in fsmonitor daemon for Linux using the inotify
     +    API, bringing it to feature parity with the existing Windows and macOS
     +    implementations.
      
     -    The Linux implementation uses inotify to monitor filesystem events.
     -    Unlike macOS's FSEvents which can watch a single root directory,
     -    inotify requires registering watches on every directory of interest.
     -    The implementation carefully handles directory renames and moves
     -    using inotify's cookie mechanism to track IN_MOVED_FROM/IN_MOVED_TO
     -    event pairs.
     +    The implementation uses inotify rather than fanotify because fanotify
     +    requires either CAP_SYS_ADMIN or CAP_PERFMON capabilities, making it
     +    unsuitable for an unprivileged user-space daemon.  While inotify has
     +    the limitation of requiring a separate watch on every directory (unlike
     +    macOS's FSEvents, which can monitor an entire directory tree with a
     +    single watch), it operates without elevated privileges and provides
     +    the per-file event granularity needed for fsmonitor.
      
     -    Key implementation details:
     -    - Uses inotify_init1(O_NONBLOCK) for non-blocking event monitoring
     -    - Maintains bidirectional hashmaps between watch descriptors and paths
     -      for efficient event processing
     -    - Handles directory creation, deletion, and renames dynamically
     -    - Detects remote filesystems (NFS, CIFS, SMB, etc.) via statfs()
     -    - Falls back to $HOME/.git-fsmonitor-* for socket when .git is remote
     +    The listener uses inotify_init1(O_NONBLOCK) with a poll loop that
     +    checks for events with a 50-millisecond timeout, keeping the inotify
     +    queue well-drained to minimize the risk of overflows.  Bidirectional
     +    hashmaps map between watch descriptors and directory paths for efficient
     +    event resolution.  Directory renames are tracked using inotify's cookie
     +    mechanism to correlate IN_MOVED_FROM and IN_MOVED_TO event pairs; a
     +    periodic check detects stale renames where the matching IN_MOVED_TO
     +    never arrived, forcing a resync.
      
     -    Build configuration:
     -    - Enabled via FSMONITOR_DAEMON_BACKEND=linux and FSMONITOR_OS_SETTINGS=linux
     -    - Requires NO_PTHREADS and NO_UNIX_SOCKETS to be unset
     -    - Adds HAVE_LINUX_MAGIC_H for filesystem type detection
     +    New directory creation triggers recursive watch registration to ensure
     +    all subdirectories are monitored.  The IN_MASK_CREATE flag is used
     +    where available to prevent modifying existing watches, with a fallback
     +    for older kernels.  When IN_MASK_CREATE is available and
     +    inotify_add_watch returns EEXIST, it means another thread or recursive
     +    scan has already registered the watch, so it is safe to ignore.
      
     -    Documentation updated to note that fsmonitor.socketDir is now supported
     -    on both Mac OS and Linux, and adds a section about inotify watch limits.
     -
     -    Issues addressed from PR #1352 (git/git) review comments:
     -    - GPLv3 ME_REMOTE macro: Rewrote remote filesystem detection from
     -      scratch using statfs() and linux/magic.h constants (no GPLv3 code)
     -    - Memory leak on inotify_init1 failure: Added FREE_AND_NULL cleanup
     -    - Unsafe hashmap iteration in dtor: Collect entries first, then modify
     -    - Missing null checks in stop_async: Added proper guard conditions
     -    - dirname() modifying argument: Create copy with xstrdup() first
     -    - Non-portable f_fsid.__val: Use memcmp() for fsid comparison
     -    - Missing worktree null check: Added BUG() for null worktree
     -    - Header updates: Use git-compat-util.h, hash_to_hex_algop()
     -    - Code style: Use xstrdup() not xmemdupz(), proper pointer style
     -
     -    Issues addressed from PR #1667 (git/git) review comments:
     -    - EINTR handling: read() now handles both EAGAIN and EINTR
     -    - Trailing pipe in log_mask_set: Added strbuf_strip_suffix()
     -    - Unchecked add_watch return: Now logs failure in rename_dir()
     -    - String building: Consolidated strbuf operations with strbuf_addf()
     -    - Translation markers: Added _() to all error_errno() messages
     -
     -    Based on work from https://github.com/git/git/pull/1352 by Eric DeCosta,
     -    and https://github.com/git/git/pull/1667 by Marziyeh Esipreh, updated to
     -    work with the current codebase and address all review feedback.
     +    Remote filesystem detection uses statfs() to identify network-mounted
     +    filesystems (NFS, CIFS, SMB, FUSE, etc.) via their magic numbers.
     +    Mount point information is read from /proc/mounts and matched against
     +    the statfs f_fsid to get accurate, human-readable filesystem type names
     +    for logging.  When the .git directory is on a remote filesystem, the
     +    IPC socket falls back to $HOME or a user-configured directory via the
     +    fsmonitor.socketDir setting.
      
     +    Based-on-patch-by: Eric DeCosta <edecosta@mathworks.com>
     +    Based-on-patch-by: Marziyeh Esipreh <marziyeh.esipreh@gmail.com>
          Signed-off-by: Paul Tarjan <github@paulisageek.com>
      
       ## Documentation/config/fsmonitor--daemon.adoc ##
     @@ Documentation/git-fsmonitor--daemon.adoc: By default, the socket is created in t
       -------------
       
      
     - ## builtin/fsmonitor--daemon.c ##
     -@@ builtin/fsmonitor--daemon.c: static int do_handle_client(struct fsmonitor_daemon_state *state,
     - 	const struct fsmonitor_batch *batch;
     - 	struct fsmonitor_batch *remainder = NULL;
     - 	intmax_t count = 0, duplicates = 0;
     --	kh_str_t *shown;
     -+	kh_str_t *shown = NULL;
     - 	int hash_ret;
     - 	int do_trivial = 0;
     - 	int do_flush = 0;
     -@@ builtin/fsmonitor--daemon.c: static int do_handle_client(struct fsmonitor_daemon_state *state,
     - 		total_response_len += payload.len;
     - 	}
     - 
     --	kh_release_str(shown);
     --
     - 	pthread_mutex_lock(&state->main_lock);
     - 
     - 	if (token_data->client_ref_count > 0)
     -@@ builtin/fsmonitor--daemon.c: static int do_handle_client(struct fsmonitor_daemon_state *state,
     - 	trace2_data_intmax("fsmonitor", the_repository, "response/count/duplicates", duplicates);
     - 
     - cleanup:
     -+	kh_destroy_str(shown);
     - 	strbuf_release(&response_token);
     - 	strbuf_release(&requested_token_id);
     - 	strbuf_release(&payload);
     -@@ builtin/fsmonitor--daemon.c: static int fsmonitor_run_daemon(void)
     - done:
     - 	pthread_cond_destroy(&state.cookies_cond);
     - 	pthread_mutex_destroy(&state.main_lock);
     -+	hashmap_clear(&state.cookies);
     - 	fsm_listen__dtor(&state);
     - 	fsm_health__dtor(&state);
     - 
     -
       ## compat/fsmonitor/fsm-health-linux.c (new) ##
      @@
      +#include "git-compat-util.h"
     @@ compat/fsmonitor/fsm-health-linux.c (new)
      +
      +void fsm_health__stop_async(struct fsmonitor_daemon_state *state UNUSED)
      +{
     -+}
     -
     - ## compat/fsmonitor/fsm-ipc-linux.c (new) ##
     -@@
     -+#define USE_THE_REPOSITORY_VARIABLE
     -+
     -+#include "git-compat-util.h"
     -+#include "config.h"
     -+#include "gettext.h"
     -+#include "hex.h"
     -+#include "path.h"
     -+#include "repository.h"
     -+#include "strbuf.h"
     -+#include "fsmonitor-ll.h"
     -+#include "fsmonitor-ipc.h"
     -+#include "fsmonitor-path-utils.h"
     -+
     -+static GIT_PATH_FUNC(fsmonitor_ipc__get_default_path, "fsmonitor--daemon.ipc")
     -+
     -+const char *fsmonitor_ipc__get_path(struct repository *r)
     -+{
     -+	static const char *ipc_path = NULL;
     -+	git_SHA_CTX sha1ctx;
     -+	char *sock_dir = NULL;
     -+	struct strbuf ipc_file = STRBUF_INIT;
     -+	unsigned char hash[GIT_SHA1_RAWSZ];
     -+
     -+	if (!r)
     -+		BUG("No repository passed into fsmonitor_ipc__get_path");
     -+
     -+	if (ipc_path)
     -+		return ipc_path;
     -+
     -+	/* By default the socket file is created in the .git directory */
     -+	if (fsmonitor__is_fs_remote(r->gitdir) < 1) {
     -+		ipc_path = fsmonitor_ipc__get_default_path();
     -+		return ipc_path;
     -+	}
     -+
     -+	if (!r->worktree)
     -+		BUG("repository has no worktree");
     -+
     -+	git_SHA1_Init(&sha1ctx);
     -+	git_SHA1_Update(&sha1ctx, r->worktree, strlen(r->worktree));
     -+	git_SHA1_Final(hash, &sha1ctx);
     -+
     -+	repo_config_get_string(r, "fsmonitor.socketdir", &sock_dir);
     -+
     -+	/* Create the socket file in either socketDir or $HOME */
     -+	if (sock_dir && *sock_dir) {
     -+		strbuf_addf(&ipc_file, "%s/.git-fsmonitor-%s",
     -+			    sock_dir, hash_to_hex_algop(hash, &hash_algos[GIT_HASH_SHA1]));
     -+	} else {
     -+		strbuf_addf(&ipc_file, "~/.git-fsmonitor-%s",
     -+			    hash_to_hex_algop(hash, &hash_algos[GIT_HASH_SHA1]));
     -+	}
     -+	free(sock_dir);
     -+
     -+	ipc_path = interpolate_path(ipc_file.buf, 1);
     -+	if (!ipc_path)
     -+		die(_("Invalid path: %s"), ipc_file.buf);
     -+
     -+	strbuf_release(&ipc_file);
     -+	return ipc_path;
      +}
      
       ## compat/fsmonitor/fsm-listen-linux.c (new) ##
     @@ compat/fsmonitor/fsm-listen-linux.c (new)
      +#include "string-list.h"
      +#include "trace.h"
      +
     -+#include <dirent.h>
     -+#include <fcntl.h>
     -+#include <poll.h>
      +#include <sys/inotify.h>
     -+#include <sys/stat.h>
      +
      +/*
      + * Safe value to bitwise OR with rest of mask for
     @@ compat/fsmonitor/fsm-listen-linux.c (new)
      +			return 0; /* directory was deleted or is not a directory */
      +		if (errno == EEXIST)
      +			return 0; /* watch already exists, no action needed */
     ++		if (errno == ENOSPC)
     ++			return error(_("inotify watch limit reached; "
     ++				       "increase fs.inotify.max_user_watches"));
      +		return error_errno(_("inotify_add_watch('%s') failed"), interned);
      +	}
      +
     @@ compat/fsmonitor/fsm-listen-linux.c (new)
      +	hashmap_entry_init(&k1.ent, memhash(&k1.wd, sizeof(int)));
      +	w1 = hashmap_remove_entry(&data->watches, &k1, ent, NULL);
      +	if (!w1)
     -+		BUG("Double remove of watch for '%s'", w->dir);
     ++		BUG("double remove of watch for '%s'", w->dir);
      +
      +	if (w1->cookie)
     -+		BUG("Removing watch for '%s' which has a pending rename", w1->dir);
     ++		BUG("removing watch for '%s' which has a pending rename", w1->dir);
      +
      +	k2.dir = w->dir;
      +	hashmap_entry_init(&k2.ent, strhash(k2.dir));
      +	w2 = hashmap_remove_entry(&data->revwatches, &k2, ent, NULL);
      +	if (!w2)
     -+		BUG("Double remove of reverse watch for '%s'", w->dir);
     ++		BUG("double remove of reverse watch for '%s'", w->dir);
      +
      +	/* w1->dir and w2->dir are interned strings, we don't own them */
      +	free(w1);
     @@ compat/fsmonitor/fsm-listen-linux.c (new)
      +		} else {
      +			/* Directory was moved out of watch tree */
      +			trace_printf_key(&trace_fsmonitor,
     -+					 "No matching watch for rename to '%s'", path);
     ++					 "no matching watch for rename to '%s'", path);
      +		}
      +		hashmap_remove_entry(&data->renames, &rek, ent, NULL);
      +		free(re);
      +	} else {
      +		/* Directory was moved from outside the watch tree */
      +		trace_printf_key(&trace_fsmonitor,
     -+				 "No matching cookie for rename to '%s'", path);
     ++				 "no matching cookie for rename to '%s'", path);
      +	}
      +}
      +
     @@ compat/fsmonitor/fsm-listen-linux.c (new)
      +	CALLOC_ARRAY(data, 1);
      +	state->listen_data = data;
      +	state->listen_error_code = -1;
     ++	data->fd_inotify = -1;
      +	data->shutdown = SHUTDOWN_ERROR;
      +
      +	fd = inotify_init1(O_NONBLOCK);
     @@ compat/fsmonitor/fsm-listen-linux.c (new)
      +
      +	FREE_AND_NULL(state->listen_data);
      +
     -+	if (fd && (close(fd) < 0))
     ++	if (fd >= 0 && (close(fd) < 0))
      +		error_errno(_("closing inotify file descriptor failed"));
      +}
      +
     @@ compat/fsmonitor/fsm-listen-linux.c (new)
      +			if (errno == EAGAIN || errno == EINTR)
      +				goto done;
      +			error_errno(_("reading inotify message stream failed"));
     -+			state->listen_data->shutdown = SHUTDOWN_ERROR;
     ++				state->listen_data->shutdown = SHUTDOWN_ERROR;
      +			goto done;
      +		}
      +
     @@ compat/fsmonitor/fsm-listen-linux.c (new)
      +void fsm_listen__loop(struct fsmonitor_daemon_state *state)
      +{
      +	int poll_num;
     -+	const int interval = 1000;
     ++	/*
     ++	 * Interval in seconds between checks for stale directory renames.
     ++	 * A directory rename that is not completed within this window
     ++	 * (i.e. no matching IN_MOVED_TO for an IN_MOVED_FROM) indicates
     ++	 * missed events, forcing a shutdown.
     ++	 */
     ++	const int interval = 1;
      +	time_t checked = time(NULL);
      +	struct pollfd fds[1];
      +
     @@ compat/fsmonitor/fsm-listen-linux.c (new)
      +	for (;;) {
      +		switch (state->listen_data->shutdown) {
      +		case SHUTDOWN_CONTINUE:
     -+			poll_num = poll(fds, 1, 1);
     ++			poll_num = poll(fds, 1, 50);
      +			if (poll_num == -1) {
      +				if (errno == EINTR)
      +					continue;
     @@ compat/fsmonitor/fsm-listen-linux.c (new)
      +				if (check_stale_dir_renames(&state->listen_data->renames,
      +							    checked - interval)) {
      +					trace_printf_key(&trace_fsmonitor,
     -+							 "Missed IN_MOVED_TO events, forcing shutdown");
     ++							 "missed IN_MOVED_TO events, forcing shutdown");
      +					state->listen_data->shutdown = SHUTDOWN_FORCE;
      +					continue;
      +				}
     @@ compat/fsmonitor/fsm-path-utils-linux.c (new)
      +#include "gettext.h"
      +#include "trace.h"
      +
     -+#include <errno.h>
     -+#include <stdio.h>
     -+#include <string.h>
      +#include <sys/statfs.h>
      +
      +#ifdef HAVE_LINUX_MAGIC_H
     @@ compat/fsmonitor/fsm-path-utils-linux.c (new)
      +			       const struct alias_info *info UNUSED)
      +{
      +	return NULL;
     -+}
     -
     - ## compat/fsmonitor/fsm-settings-linux.c (new) ##
     -@@
     -+#include "git-compat-util.h"
     -+#include "config.h"
     -+#include "fsmonitor-ll.h"
     -+#include "fsmonitor-ipc.h"
     -+#include "fsmonitor-settings.h"
     -+#include "fsmonitor-path-utils.h"
     -+
     -+#include <libgen.h>
     -+
     -+/*
     -+ * For the builtin FSMonitor, we create the Unix domain socket for the
     -+ * IPC in the .git directory.  If the working directory is remote,
     -+ * then the socket will be created on the remote file system.  This
     -+ * can fail if the remote file system does not support UDS file types
     -+ * (e.g. smbfs to a Windows server) or if the remote kernel does not
     -+ * allow a non-local process to bind() the socket.  (These problems
     -+ * could be fixed by moving the UDS out of the .git directory and to a
     -+ * well-known local directory on the client machine, but care should
     -+ * be taken to ensure that $HOME is actually local and not a managed
     -+ * file share.)
     -+ *
     -+ * FAT32 and NTFS working directories are problematic too.
     -+ *
     -+ * The builtin FSMonitor uses a Unix domain socket in the .git
     -+ * directory for IPC.  These Windows drive formats do not support
     -+ * Unix domain sockets, so mark them as incompatible for the daemon.
     -+ */
     -+static enum fsmonitor_reason check_uds_volume(struct repository *r)
     -+{
     -+	struct fs_info fs;
     -+	const char *ipc_path = fsmonitor_ipc__get_path(r);
     -+	char *path;
     -+	char *dir;
     -+
     -+	/*
     -+	 * Create a copy for dirname() since it may modify its argument.
     -+	 */
     -+	path = xstrdup(ipc_path);
     -+	dir = dirname(path);
     -+
     -+	if (fsmonitor__get_fs_info(dir, &fs) == -1) {
     -+		free(path);
     -+		return FSMONITOR_REASON_ERROR;
     -+	}
     -+
     -+	free(path);
     -+
     -+	if (fs.is_remote ||
     -+	    !strcmp(fs.typename, "msdos") ||
     -+	    !strcmp(fs.typename, "ntfs") ||
     -+	    !strcmp(fs.typename, "vfat")) {
     -+		free(fs.typename);
     -+		return FSMONITOR_REASON_NOSOCKETS;
     -+	}
     -+
     -+	free(fs.typename);
     -+	return FSMONITOR_REASON_OK;
     -+}
     -+
     -+enum fsmonitor_reason fsm_os__incompatible(struct repository *r, int ipc)
     -+{
     -+	enum fsmonitor_reason reason;
     -+
     -+	if (ipc) {
     -+		reason = check_uds_volume(r);
     -+		if (reason != FSMONITOR_REASON_OK)
     -+			return reason;
     -+	}
     -+
     -+	return FSMONITOR_REASON_OK;
      +}
      
       ## config.mak.uname ##
     @@ config.mak.uname: ifeq ($(uname_S),Linux)
      
       ## contrib/buildsystems/CMakeLists.txt ##
      @@ contrib/buildsystems/CMakeLists.txt: if(SUPPORTS_SIMPLE_IPC)
     + 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-unix.c)
     + 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-darwin.c)
       
     - 		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
     - 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-darwin.c)
     ++		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
     ++		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-unix.c)
      +	elseif(CMAKE_SYSTEM_NAME STREQUAL "Linux")
      +		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
      +		add_compile_definitions(HAVE_LINUX_MAGIC_H)
      +		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-linux.c)
      +		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-linux.c)
     -+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-linux.c)
     ++		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-unix.c)
      +		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-linux.c)
      +
     -+		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
     -+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-linux.c)
     + 		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
     + 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-unix.c)
       	endif()
     - endif()
     - 
      
       ## meson.build ##
      @@ meson.build: endif
     @@ meson.build: endif
       elif host_machine.system() == 'darwin'
         fsmonitor_backend = 'darwin'
         libgit_dependencies += dependency('CoreServices')
     -
     - ## t/t7527-builtin-fsmonitor.sh ##
     -@@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'directory changes to a file' '
     - 	grep "^event: dir1$" .git/trace
     - '
     - 
     -+test_expect_success 'rapid nested directory creation' '
     -+	test_when_finished "git fsmonitor--daemon stop; rm -rf rapid" &&
     -+
     -+	start_daemon --tf "$PWD/.git/trace" &&
     -+
     -+	# Rapidly create nested directories to exercise race conditions
     -+	# where directory watches may be added concurrently during
     -+	# event processing and recursive scanning.
     -+	for i in $(test_seq 1 20)
     -+	do
     -+		mkdir -p "rapid/nested/dir$i/subdir/deep" || return 1
     -+	done &&
     -+
     -+	# Give the daemon time to process all events
     -+	sleep 1 &&
     -+
     -+	test-tool fsmonitor-client query --token 0 &&
     -+
     -+	# Verify daemon is still running (did not crash)
     -+	git fsmonitor--daemon status
     -+'
     -+
     - # The next few test cases exercise the token-resync code.  When filesystem
     - # drops events (because of filesystem velocity or because the daemon isn't
     - # polling fast enough), we need to discard the cached data (relative to the
  -:  ---------- >  8:  8fec92d5b4 fsmonitor: add tests for Linux
  -:  ---------- >  9:  817489b3ea run-command: add close_fd_above_stderr option
  -:  ---------- > 10:  bb438afbbe fsmonitor: close inherited file descriptors and detach in daemon

-- 
gitgitgadget
