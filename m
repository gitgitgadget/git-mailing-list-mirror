Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23414346E6E
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 19:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769109831; cv=none; b=SW0VNEeTOgMv476kDqK9SmqhWoF+9UVQjde5SdkOwGZqz99xat7e7mgo92kz1KMTtMekgl56OdR2SZrAWB/RNIMQJYZBIOoAjXCBtNdR7qgfOXlJUt74oIlbanDrBg5De+XK4e/Ve1giKgkbtKpV/cRxDk+JZmokMIW3jRtBNkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769109831; c=relaxed/simple;
	bh=z5C2rplL7TujQtz05rsSLz0CqHp1p5oBYFWDXl/I2Ck=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Aj7+c+DzN/9T+V6eUk9vTN07KKWs6T2XxqHyJRfBDTv/wo1ZfYduBlcl4BSeumkLi7okV1QmZIbnWBT87A2WZdtxeV7QeHrjjF25X4g51M5Me7+X53NxJeFzaTFXB/JzeURNZo4dx0mGrgcEhqKeaT/qH6K97yJ/BzJqAYv7Ghs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7v4r9K4; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7v4r9K4"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2b6fd5bec41so2606203eec.1
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 11:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769109817; x=1769714617; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cl39M8dLsqFtGGb5XYIXZcshDbYq//OaujZS3EKESbQ=;
        b=R7v4r9K4zBHnlxL0T8vqTADMa3yNXrSrGsBicAVkZoVA2EKalHUp+eO9b6XAxnyTgV
         vHhFFrzy04XCHoBog9NetW/WS6rFOM22I40Zn09x4oqkrWKcGbDKgvILNYxOOLFDUuD7
         bAMt6CPhGCKiSOd3bcl8Y7yhGnNmiZYoOeHXQBCvFeZc62SemOsQG4cbDlptk1PFLH0G
         TLpNNJTL92Y6jEF9JPKSyACH0pPb3Lb5YwdM45i+14DgqTAAaHhYGL46cKNwZztT2CUL
         wzqbYt5wJUurryw8RgOWds2dePDqkrv1Yt30aGbK7VKOtIGGSMvs2ycnxZ/hz8MdtmyF
         08Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769109817; x=1769714617;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cl39M8dLsqFtGGb5XYIXZcshDbYq//OaujZS3EKESbQ=;
        b=uSOkad4h++0Q7PTCzGat+M6OF2KcZEzQ3DnUUQBH/f8wVzjIyXzp+Ibk4OuFmNlNx9
         G2PtIpfeJjq61MArryDcBgqOwTIS9PmmjleMkvshT/awy+8JV5RedHjXroav7wV0YxT3
         5B7qVWxB7Tui1BuKVSIwgibvvH0BIFwyzaVIgnEhEwYmztKcfCjRvqItakr/EHkmtc8H
         7dfcmsd4qVFgdfWPuPNipDg+zTPronf7xAQunS0OCP8Gmd6kXeuc0pVRsKjFO7TDOHva
         cEAa2UtIn30ld8Guvso2+JNInt4zY5g/QjLMyOq6JJpGJPqhZAFELh4Cekj+ILKCfw+z
         q4zA==
X-Gm-Message-State: AOJu0YwYmbW73waQ9eltgFDA6fKF1749HFz4WGqQWjyjKrt/XdSweM62
	x2Mnwu0MgTcCBg5Z3sVM4qppWJm3ia27U1BB6fzp12KOfGb/w2U4qZhWfBtnUA==
X-Gm-Gg: AZuq6aJQmeTjPwZ3ae7vPukrlVWN2eE1SYKObY5DEjff5DI0XG0QEDllJTIfyH2VeGF
	wmiZT/8PHtkcCdV6aXYcfWOyHwcPG4z5TlPnzONBQyElGHvXZPNZLrInAb/VttQnQ3d0fSDIEAt
	7xGp2G4yxZxP1ayAz5TP72ZWEWZTSNd23ORDPQVWKmDXI8nLMdVZB5Sb8GoxH6+ac+IvCqZVe6B
	egfJx5XHk1cWwkoeA0oY/ZCMY4hdejRCLL24WY7kZuFTWKZmha2HZXZPNPJJaKNGbtPQmH//HSH
	Ki4ovUaPPqriUnSu498WcgMRZfq5Dc+YpNae6B9CEr5Jg4YZJICvLzJktLm13O1hEIs87rOXR/L
	9duB0e7fsRyvub7UlQN9s2eO3UV7TcjvQ37atNYhgx+/ire5pn2TByZC36Nwfy7YYAV2ygBOOPQ
	mmAPw+dE3QyWwBNSA491FQFj0=
X-Received: by 2002:a05:7301:6093:b0:2b0:52ac:92fe with SMTP id 5a478bee46e88-2b739b74678mr257486eec.21.1769109816525;
        Thu, 22 Jan 2026 11:23:36 -0800 (PST)
Received: from [127.0.0.1] ([172.182.225.0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73a9e1bc8sm316460eec.22.2026.01.22.11.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 11:23:35 -0800 (PST)
Message-Id: <pull.2011.v6.git.1769109815197.gitgitgadget@gmail.com>
In-Reply-To: <pull.2011.v5.git.1768933954845.gitgitgadget@gmail.com>
References: <pull.2011.v5.git.1768933954845.gitgitgadget@gmail.com>
From: "Paulo Casaretto via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 22 Jan 2026 19:23:35 +0000
Subject: [PATCH v6] lockfile: add PID file for debugging stale locks
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
Cc: Taylor Blau <me@ttaylorr.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Jeff King <peff@peff.net>,
    "Paulo Casaretto (Shopify)" <paulo.casaretto@shopify.com>,
    Patrick Steinhardt <ps@pks.im>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Paulo Casaretto <pcasaretto@gmail.com>,
    Paulo Casaretto <pcasaretto@gmail.com>

From: Paulo Casaretto <pcasaretto@gmail.com>

When a lock file is held, it can be helpful to know which process owns
it, especially when debugging stale locks left behind by crashed
processes. Add an optional feature that creates a companion PID file
alongside each lock file, containing the PID of the lock holder.

For a lock file "foo.lock", the PID file is named "foo~pid.lock". The
tilde character is forbidden in refnames and allowed in Windows
filenames, which guarantees no collision with the refs namespace
(e.g., refs "foo" and "foo~pid" cannot both exist). The file contains
a single line in the format "pid <value>" followed by a newline.

The PID file is created when a lock is acquired (if enabled), and
automatically cleaned up when the lock is released (via commit or
rollback). The file is registered as a tempfile so it gets cleaned up
by signal and atexit handlers if the process terminates abnormally.

When a lock conflict occurs, the code checks for an existing PID file
and, if found, uses kill(pid, 0) to determine if the process is still
running. This allows providing context-aware error messages:

  Lock is held by process 12345. Wait for it to finish, or remove
  the lock file to continue.

Or for a stale lock:

  Lock was held by process 12345, which is no longer running.
  Remove the stale lock file to continue.

The feature is controlled via core.lockfilePid configuration (boolean).
Defaults to false. When enabled, PID files are created for all lock
operations.

Existing PID files are always read when displaying lock errors,
regardless of the core.lockfilePid setting. This ensures helpful
diagnostics even when the feature was previously enabled and later
disabled.

Signed-off-by: Paulo Casaretto <pcasaretto@gmail.com>
---
    lockfile: add holder info file for debugging stale locks
    
    Changes in v6:
    
     * Applied Junio's fix-up: removed unused fd = -1 assignments and the
       unreachable if (fd >= 0) close(fd) cleanup at the out label in
       create_lock_pid_file().
     * Kept close(fd) before unlink() in the error path for Windows
       compatibility, as noted by Eric Sunshine and Johannes Sixt.
     * Reverted the unnecessary whitespace-only changes to builtin/commit.c
       and builtin/gc.c - these files are no longer touched by this patch.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2011%2Fpcasaretto%2Fpid-holder-file-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2011/pcasaretto/pid-holder-file-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/2011

Range-diff vs v5:

 1:  5260bf2d40 ! 1:  f9ba2c20ec lockfile: add PID file for debugging stale locks
     @@ Documentation/config/core.adoc: confusion unless you know what you are doing (e.
       	Enable the reflog. Updates to a ref <ref> is logged to the file
       	"`$GIT_DIR/logs/<ref>`", by appending the new and old
      
     - ## builtin/commit.c ##
     -@@ builtin/commit.c: static const char *prepare_index(const char **argv, const char *prefix,
     - 
     - 	path = repo_git_path(the_repository, "next-index-%"PRIuMAX,
     - 			     (uintmax_t) getpid());
     --	hold_lock_file_for_update(&false_lock, path,
     --				  LOCK_DIE_ON_ERROR);
     -+	hold_lock_file_for_update(&false_lock, path, LOCK_DIE_ON_ERROR);
     - 
     - 	create_base_index(current_head);
     - 	add_remove_files(&partial);
     -
     - ## builtin/gc.c ##
     -@@ builtin/gc.c: static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
     - 		xsnprintf(my_host, sizeof(my_host), "unknown");
     - 
     - 	pidfile_path = repo_git_path(the_repository, "gc.pid");
     --	fd = hold_lock_file_for_update(&lock, pidfile_path,
     --				       LOCK_DIE_ON_ERROR);
     -+	fd = hold_lock_file_for_update(&lock, pidfile_path, LOCK_DIE_ON_ERROR);
     - 	if (!force) {
     - 		static char locking_host[HOST_NAME_MAX + 1];
     - 		static char *scan_fmt;
     -@@ builtin/gc.c: int cmd_gc(int argc,
     - 
     - 	if (daemonized) {
     - 		char *path = repo_git_path(the_repository, "gc.log");
     --		hold_lock_file_for_update(&log_lock, path,
     --					  LOCK_DIE_ON_ERROR);
     -+		hold_lock_file_for_update(&log_lock, path, LOCK_DIE_ON_ERROR);
     - 		dup2(get_lock_file_fd(&log_lock), 2);
     - 		atexit(process_log_file_at_exit);
     - 		free(path);
     -
       ## compat/mingw.c ##
      @@ compat/mingw.c: int mingw_kill(pid_t pid, int sig)
       			CloseHandle(h);
     @@ lockfile.c: static void resolve_symlink(struct strbuf *path)
      +{
      +	struct strbuf content = STRBUF_INIT;
      +	struct tempfile *pid_tempfile = NULL;
     -+	int fd = -1;
     ++	int fd;
      +
      +	if (!lockfile_pid_enabled)
      +		goto out;
     @@ lockfile.c: static void resolve_symlink(struct strbuf *path)
      +	if (write_in_full(fd, content.buf, content.len) < 0) {
      +		warning_errno(_("could not write lock pid file '%s'"), pid_path);
      +		close(fd);
     -+		fd = -1;
      +		unlink(pid_path);
      +		goto out;
      +	}
      +
      +	close(fd);
     -+	fd = -1;
      +	pid_tempfile = register_tempfile(pid_path);
      +
      +out:
     -+	if (fd >= 0)
     -+		close(fd);
      +	strbuf_release(&content);
      +	return pid_tempfile;
      +}


 Documentation/config/core.adoc |  11 +++
 compat/mingw.c                 |  10 ++
 environment.c                  |   6 ++
 lockfile.c                     | 168 ++++++++++++++++++++++++++++++---
 lockfile.h                     |  43 ++++++---
 t/meson.build                  |   1 +
 t/t0031-lockfile-pid.sh        | 105 +++++++++++++++++++++
 7 files changed, 315 insertions(+), 29 deletions(-)
 create mode 100755 t/t0031-lockfile-pid.sh

diff --git a/Documentation/config/core.adoc b/Documentation/config/core.adoc
index 01202da7cd..5c4bc9206f 100644
--- a/Documentation/config/core.adoc
+++ b/Documentation/config/core.adoc
@@ -348,6 +348,17 @@ confusion unless you know what you are doing (e.g. you are creating a
 read-only snapshot of the same index to a location different from the
 repository's usual working tree).
 
+core.lockfilePid::
+	If true, Git will create a PID file alongside lock files. When a
+	lock acquisition fails and a PID file exists, Git can provide
+	additional diagnostic information about the process holding the
+	lock, including whether it is still running. Defaults to `false`.
++
+The PID file is named by inserting `~pid` before the `.lock` suffix.
+For example, if the lock file is `index.lock`, the PID file will be
+`index~pid.lock`. The file contains a single line in the format
+`pid <value>` followed by a newline.
+
 core.logAllRefUpdates::
 	Enable the reflog. Updates to a ref <ref> is logged to the file
 	"`$GIT_DIR/logs/<ref>`", by appending the new and old
diff --git a/compat/mingw.c b/compat/mingw.c
index 939f938fe2..146b2585ce 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1972,6 +1972,16 @@ int mingw_kill(pid_t pid, int sig)
 			CloseHandle(h);
 			return 0;
 		}
+		/*
+		 * OpenProcess returns ERROR_INVALID_PARAMETER for
+		 * non-existent PIDs. Map this to ESRCH for POSIX
+		 * compatibility with kill(pid, 0).
+		 */
+		if (GetLastError() == ERROR_INVALID_PARAMETER)
+			errno = ESRCH;
+		else
+			errno = err_win_to_posix(GetLastError());
+		return -1;
 	}
 
 	errno = EINVAL;
diff --git a/environment.c b/environment.c
index a770b5921d..4adcce8606 100644
--- a/environment.c
+++ b/environment.c
@@ -21,6 +21,7 @@
 #include "gettext.h"
 #include "git-zlib.h"
 #include "ident.h"
+#include "lockfile.h"
 #include "mailmap.h"
 #include "object-name.h"
 #include "repository.h"
@@ -532,6 +533,11 @@ static int git_default_core_config(const char *var, const char *value,
 		return 0;
 	}
 
+	if (!strcmp(var, "core.lockfilepid")) {
+		lockfile_pid_enabled = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.createobject")) {
 		if (!value)
 			return config_error_nonbool(var);
diff --git a/lockfile.c b/lockfile.c
index 1d5ed01682..13e2ad1307 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -6,6 +6,9 @@
 #include "abspath.h"
 #include "gettext.h"
 #include "lockfile.h"
+#include "parse.h"
+#include "strbuf.h"
+#include "wrapper.h"
 
 /*
  * path = absolute or relative path name
@@ -71,19 +74,115 @@ static void resolve_symlink(struct strbuf *path)
 	strbuf_reset(&link);
 }
 
+/*
+ * Lock PID file functions - write PID to a foo~pid.lock file alongside
+ * the lock file for debugging stale locks. The PID file is registered
+ * as a tempfile so it gets cleaned up by signal/atexit handlers.
+ *
+ * Naming: For "foo.lock", the PID file is "foo~pid.lock". The tilde is
+ * forbidden in refnames and allowed in Windows filenames, guaranteeing
+ * no collision with the refs namespace.
+ */
+
+/* Global config variable, initialized from core.lockfilePid */
+int lockfile_pid_enabled;
+
+/*
+ * Path generation helpers.
+ * Given base path "foo", generate:
+ *   - lock path: "foo.lock"
+ *   - pid path:  "foo-pid.lock"
+ */
+static void get_lock_path(struct strbuf *out, const char *path)
+{
+	strbuf_addstr(out, path);
+	strbuf_addstr(out, LOCK_SUFFIX);
+}
+
+static void get_pid_path(struct strbuf *out, const char *path)
+{
+	strbuf_addstr(out, path);
+	strbuf_addstr(out, LOCK_PID_INFIX);
+	strbuf_addstr(out, LOCK_SUFFIX);
+}
+
+static struct tempfile *create_lock_pid_file(const char *pid_path, int mode)
+{
+	struct strbuf content = STRBUF_INIT;
+	struct tempfile *pid_tempfile = NULL;
+	int fd;
+
+	if (!lockfile_pid_enabled)
+		goto out;
+
+	fd = open(pid_path, O_WRONLY | O_CREAT | O_EXCL, mode);
+	if (fd < 0)
+		goto out;
+
+	strbuf_addf(&content, "pid %" PRIuMAX "\n", (uintmax_t)getpid());
+	if (write_in_full(fd, content.buf, content.len) < 0) {
+		warning_errno(_("could not write lock pid file '%s'"), pid_path);
+		close(fd);
+		unlink(pid_path);
+		goto out;
+	}
+
+	close(fd);
+	pid_tempfile = register_tempfile(pid_path);
+
+out:
+	strbuf_release(&content);
+	return pid_tempfile;
+}
+
+static int read_lock_pid(const char *pid_path, uintmax_t *pid_out)
+{
+	struct strbuf content = STRBUF_INIT;
+	const char *val;
+	int ret = -1;
+
+	if (strbuf_read_file(&content, pid_path, LOCK_PID_MAXLEN) <= 0)
+		goto out;
+
+	strbuf_rtrim(&content);
+
+	if (skip_prefix(content.buf, "pid ", &val)) {
+		char *endptr;
+		*pid_out = strtoumax(val, &endptr, 10);
+		if (*pid_out > 0 && !*endptr)
+			ret = 0;
+	}
+
+	if (ret)
+		warning(_("malformed lock pid file '%s'"), pid_path);
+
+out:
+	strbuf_release(&content);
+	return ret;
+}
+
 /* Make sure errno contains a meaningful value on error */
 static int lock_file(struct lock_file *lk, const char *path, int flags,
 		     int mode)
 {
-	struct strbuf filename = STRBUF_INIT;
+	struct strbuf base_path = STRBUF_INIT;
+	struct strbuf lock_path = STRBUF_INIT;
+	struct strbuf pid_path = STRBUF_INIT;
 
-	strbuf_addstr(&filename, path);
+	strbuf_addstr(&base_path, path);
 	if (!(flags & LOCK_NO_DEREF))
-		resolve_symlink(&filename);
+		resolve_symlink(&base_path);
+
+	get_lock_path(&lock_path, base_path.buf);
+	get_pid_path(&pid_path, base_path.buf);
+
+	lk->tempfile = create_tempfile_mode(lock_path.buf, mode);
+	if (lk->tempfile)
+		lk->pid_tempfile = create_lock_pid_file(pid_path.buf, mode);
 
-	strbuf_addstr(&filename, LOCK_SUFFIX);
-	lk->tempfile = create_tempfile_mode(filename.buf, mode);
-	strbuf_release(&filename);
+	strbuf_release(&base_path);
+	strbuf_release(&lock_path);
+	strbuf_release(&pid_path);
 	return lk->tempfile ? lk->tempfile->fd : -1;
 }
 
@@ -151,16 +250,49 @@ static int lock_file_timeout(struct lock_file *lk, const char *path,
 void unable_to_lock_message(const char *path, int err, struct strbuf *buf)
 {
 	if (err == EEXIST) {
-		strbuf_addf(buf, _("Unable to create '%s.lock': %s.\n\n"
-		    "Another git process seems to be running in this repository, e.g.\n"
-		    "an editor opened by 'git commit'. Please make sure all processes\n"
-		    "are terminated then try again. If it still fails, a git process\n"
-		    "may have crashed in this repository earlier:\n"
-		    "remove the file manually to continue."),
-			    absolute_path(path), strerror(err));
-	} else
+		const char *abs_path = absolute_path(path);
+		struct strbuf lock_path = STRBUF_INIT;
+		struct strbuf pid_path = STRBUF_INIT;
+		uintmax_t pid;
+		int pid_status = 0; /* 0 = unknown, 1 = running, -1 = stale */
+
+		get_lock_path(&lock_path, abs_path);
+		get_pid_path(&pid_path, abs_path);
+
+		strbuf_addf(buf, _("Unable to create '%s': %s.\n\n"),
+			    lock_path.buf, strerror(err));
+
+		/*
+		 * Try to read PID file unconditionally - it may exist if
+		 * core.lockfilePid was enabled.
+		 */
+		if (!read_lock_pid(pid_path.buf, &pid)) {
+			if (kill((pid_t)pid, 0) == 0 || errno == EPERM)
+				pid_status = 1;  /* running (or no permission to signal) */
+			else if (errno == ESRCH)
+				pid_status = -1; /* no such process - stale lock */
+		}
+
+		if (pid_status == 1)
+			strbuf_addf(buf, _("Lock may be held by process %" PRIuMAX "; "
+					   "if no git process is running, the lock file "
+					   "may be stale (PIDs can be reused)"),
+				    pid);
+		else if (pid_status == -1)
+			strbuf_addf(buf, _("Lock was held by process %" PRIuMAX ", "
+					   "which is no longer running; the lock file "
+					   "appears to be stale"),
+				    pid);
+		else
+			strbuf_addstr(buf, _("Another git process seems to be running in this repository, "
+					     "or the lock file may be stale"));
+
+		strbuf_release(&lock_path);
+		strbuf_release(&pid_path);
+	} else {
 		strbuf_addf(buf, _("Unable to create '%s.lock': %s"),
 			    absolute_path(path), strerror(err));
+	}
 }
 
 NORETURN void unable_to_lock_die(const char *path, int err)
@@ -207,6 +339,8 @@ int commit_lock_file(struct lock_file *lk)
 {
 	char *result_path = get_locked_file_path(lk);
 
+	delete_tempfile(&lk->pid_tempfile);
+
 	if (commit_lock_file_to(lk, result_path)) {
 		int save_errno = errno;
 		free(result_path);
@@ -216,3 +350,9 @@ int commit_lock_file(struct lock_file *lk)
 	free(result_path);
 	return 0;
 }
+
+int rollback_lock_file(struct lock_file *lk)
+{
+	delete_tempfile(&lk->pid_tempfile);
+	return delete_tempfile(&lk->tempfile);
+}
diff --git a/lockfile.h b/lockfile.h
index 1bb9926497..e7233f28de 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -119,6 +119,7 @@
 
 struct lock_file {
 	struct tempfile *tempfile;
+	struct tempfile *pid_tempfile;
 };
 
 #define LOCK_INIT { 0 }
@@ -127,6 +128,22 @@ struct lock_file {
 #define LOCK_SUFFIX ".lock"
 #define LOCK_SUFFIX_LEN 5
 
+/*
+ * PID file naming: for a lock file "foo.lock", the PID file is "foo~pid.lock".
+ * The tilde is forbidden in refnames and allowed in Windows filenames, avoiding
+ * namespace collisions (e.g., refs "foo" and "foo~pid" cannot both exist).
+ */
+#define LOCK_PID_INFIX "~pid"
+#define LOCK_PID_INFIX_LEN 4
+
+/* Maximum length for PID file content */
+#define LOCK_PID_MAXLEN 32
+
+/*
+ * Whether to create PID files alongside lock files.
+ * Configured via core.lockfilePid (boolean).
+ */
+extern int lockfile_pid_enabled;
 
 /*
  * Flags
@@ -169,12 +186,12 @@ struct lock_file {
  * handling, and mode are described above.
  */
 int hold_lock_file_for_update_timeout_mode(
-		struct lock_file *lk, const char *path,
-		int flags, long timeout_ms, int mode);
+	struct lock_file *lk, const char *path,
+	int flags, long timeout_ms, int mode);
 
 static inline int hold_lock_file_for_update_timeout(
-		struct lock_file *lk, const char *path,
-		int flags, long timeout_ms)
+	struct lock_file *lk, const char *path,
+	int flags, long timeout_ms)
 {
 	return hold_lock_file_for_update_timeout_mode(lk, path, flags,
 						      timeout_ms, 0666);
@@ -186,15 +203,14 @@ static inline int hold_lock_file_for_update_timeout(
  * argument and error handling are described above.
  */
 static inline int hold_lock_file_for_update(
-		struct lock_file *lk, const char *path,
-		int flags)
+	struct lock_file *lk, const char *path, int flags)
 {
 	return hold_lock_file_for_update_timeout(lk, path, flags, 0);
 }
 
 static inline int hold_lock_file_for_update_mode(
-		struct lock_file *lk, const char *path,
-		int flags, int mode)
+	struct lock_file *lk, const char *path,
+	int flags, int mode)
 {
 	return hold_lock_file_for_update_timeout_mode(lk, path, flags, 0, mode);
 }
@@ -319,13 +335,10 @@ static inline int commit_lock_file_to(struct lock_file *lk, const char *path)
 
 /*
  * Roll back `lk`: close the file descriptor and/or file pointer and
- * remove the lockfile. It is a NOOP to call `rollback_lock_file()`
- * for a `lock_file` object that has already been committed or rolled
- * back. No error will be returned in this case.
+ * remove the lockfile and any associated PID file. It is a NOOP to
+ * call `rollback_lock_file()` for a `lock_file` object that has already
+ * been committed or rolled back. No error will be returned in this case.
  */
-static inline int rollback_lock_file(struct lock_file *lk)
-{
-	return delete_tempfile(&lk->tempfile);
-}
+int rollback_lock_file(struct lock_file *lk);
 
 #endif /* LOCKFILE_H */
diff --git a/t/meson.build b/t/meson.build
index 459c52a489..2aec2c011e 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -98,6 +98,7 @@ integration_tests = [
   't0028-working-tree-encoding.sh',
   't0029-core-unsetenvvars.sh',
   't0030-stripspace.sh',
+  't0031-lockfile-pid.sh',
   't0033-safe-directory.sh',
   't0034-root-safe-directory.sh',
   't0035-safe-bare-repository.sh',
diff --git a/t/t0031-lockfile-pid.sh b/t/t0031-lockfile-pid.sh
new file mode 100755
index 0000000000..8ef87addf5
--- /dev/null
+++ b/t/t0031-lockfile-pid.sh
@@ -0,0 +1,105 @@
+#!/bin/sh
+
+test_description='lock file PID info tests
+
+Tests for PID info file alongside lock files.
+The feature is opt-in via core.lockfilePid config setting (boolean).
+'
+
+. ./test-lib.sh
+
+test_expect_success 'stale lock detected when PID is not running' '
+	git init repo &&
+	(
+		cd repo &&
+		touch .git/index.lock &&
+		printf "pid 99999" >.git/index~pid.lock &&
+		test_must_fail git -c core.lockfilePid=true add . 2>err &&
+		test_grep "process 99999, which is no longer running" err &&
+		test_grep "appears to be stale" err
+	)
+'
+
+test_expect_success 'PID info not shown by default' '
+	git init repo2 &&
+	(
+		cd repo2 &&
+		touch .git/index.lock &&
+		printf "pid 99999" >.git/index~pid.lock &&
+		test_must_fail git add . 2>err &&
+		# Should not crash, just show normal error without PID
+		test_grep "Unable to create" err &&
+		! test_grep "is held by process" err
+	)
+'
+
+test_expect_success 'running process detected when PID is alive' '
+	git init repo3 &&
+	(
+		cd repo3 &&
+		echo content >file &&
+		# Get the correct PID for this platform
+		shell_pid=$$ &&
+		if test_have_prereq MINGW && test -f /proc/$shell_pid/winpid
+		then
+			# In Git for Windows, Bash uses MSYS2 PIDs but git.exe
+			# uses Windows PIDs. Use the Windows PID.
+			shell_pid=$(cat /proc/$shell_pid/winpid)
+		fi &&
+		# Create a lock and PID file with current shell PID (which is running)
+		touch .git/index.lock &&
+		printf "pid %d" "$shell_pid" >.git/index~pid.lock &&
+		# Verify our PID is shown in the error message
+		test_must_fail git -c core.lockfilePid=true add file 2>err &&
+		test_grep "held by process $shell_pid" err
+	)
+'
+
+test_expect_success 'PID info file cleaned up on successful operation when enabled' '
+	git init repo4 &&
+	(
+		cd repo4 &&
+		echo content >file &&
+		git -c core.lockfilePid=true add file &&
+		# After successful add, no lock or PID files should exist
+		test_path_is_missing .git/index.lock &&
+		test_path_is_missing .git/index~pid.lock
+	)
+'
+
+test_expect_success 'no PID file created by default' '
+	git init repo5 &&
+	(
+		cd repo5 &&
+		echo content >file &&
+		git add file &&
+		# PID file should not be created when feature is disabled
+		test_path_is_missing .git/index~pid.lock
+	)
+'
+
+test_expect_success 'core.lockfilePid=false does not create PID file' '
+	git init repo6 &&
+	(
+		cd repo6 &&
+		echo content >file &&
+		git -c core.lockfilePid=false add file &&
+		# PID file should not be created when feature is disabled
+		test_path_is_missing .git/index~pid.lock
+	)
+'
+
+test_expect_success 'existing PID files are read even when feature disabled' '
+	git init repo7 &&
+	(
+		cd repo7 &&
+		touch .git/index.lock &&
+		printf "pid 99999" >.git/index~pid.lock &&
+		# Even with lockfilePid disabled, existing PID files are read
+		# to help diagnose stale locks
+		test_must_fail git add . 2>err &&
+		test_grep "process 99999" err
+	)
+'
+
+test_done

base-commit: 66ce5f8e8872f0183bb137911c52b07f1f242d13
-- 
gitgitgadget
