Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EAA22A4E5
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 15:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764688052; cv=none; b=oJcPDolhK+yO0p3v+ORBX4mP+Vf6u7PPhpHjGzQaf8EAzafSu/L3szFA7LHkVHmkuKHDNEGIQqkyK7hpJrsqgF/Z0w2pL+yADhfV42JMrpEKFgEOylDnaMcTzt4MyPgB5NQ8AuKlW9pZspdDHA5pH+wQeljAr+bDAWxrCnnGxko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764688052; c=relaxed/simple;
	bh=cOhMiM0iYf2SPQ/mKIC/KHnNEV7bsHyIws2Ms7f4FUw=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=fWALlUocMlRm7j/FODDVB0GQyZhZSaAwyyNFzGvAxIqSETg/i3XtSSsz0EoHEgDmOJGHsY9YZMkoU6XFwDEFSfcdCvCoNW5/w87EZCXPVT8KdUEoavrjW3T77QTyXP37u9mhsnbND0X0sEGzVQPzpZE7857Vl4hTI9M5DjQky2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dciFdWuq; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dciFdWuq"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-343d73d08faso2877080a91.0
        for <git@vger.kernel.org>; Tue, 02 Dec 2025 07:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764688049; x=1765292849; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IYJ3pYe69ZlXf2xadNnsjFYkw+cBCuDol5N9vUR9eg4=;
        b=dciFdWuqQFAbZo/Ji0XZ4od7D4dbfEhTNwbGSUX316HrUN3vXTq3WunnFYg+kZl0NK
         ZUqM2xFgefuoBa7OvqtpDZKtGDSlIf+W8dwpOMP42NTKFPqZcClmiim7srUvOjkJH4UG
         Lp84IIGbLxvgpOlVxAxb8r56e3X6S1pd+E3p+bQs0qZwmIfOIn2cdU/fwkW/lhh4PZoH
         iIr8LIe/DS3RxKXUL2x6O5Zyic+5WTfKyyMbYRRxRXqTJQc6/U7CY3Gt0xbmQO3Sjz5G
         XUzlBIKPFajOE2J268R44rOOwqJRJiCsoW99Af+crbshzuy/kCu3GRcywuDl8odllwwA
         ieaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764688049; x=1765292849;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IYJ3pYe69ZlXf2xadNnsjFYkw+cBCuDol5N9vUR9eg4=;
        b=Swwk4xI9P27qHVmukhZrKCEEGimm7Aw0engPl3/MVaJpMXRJ7C2QmPx8CMf1vI3Zuv
         AHeSG2HWRc6JcWKtyoCCKZHC4lIM1f5xrTWKXuqETrHsXCvZN0PyZ+KNpLJ20KYKcEGU
         rf+vqC+nVcLSJvlComUg0txij5QXaFSO0wUtvoq91s6A42lVHvoKQmdq3/+PRscMVe2c
         lcb7bcBkISKo/EfuKO+stDWEXL7SWK56qQpzUvd8fqXKXvu2apcNlbVdfQnyMDXc2u61
         7comgzrR8EmzmVbIUtOO7QcwoomP8O+pr626WrxHn7ji+iO6HikKhtwlmjYdNUwc2waQ
         CKAQ==
X-Gm-Message-State: AOJu0YxerBFOdiFP/L/UOjQjEsSeWBuJEKcPlin1Kl+7Lg0vdxlGrcfb
	Q66h0dF8oyxwoZUZlDkcoPmu9zAp59jYYB4RrcbnCwFHl/WWotmLfDGTgYYjDw==
X-Gm-Gg: ASbGncscO7jPU/9Mb0GuBkeOxDuX4iCgMAz/58d2Zy2aOzROzwcNkRMQX151AALt0KV
	M0hzevOqzd3o/bNh2zz4jQZaa0V2gwl6nyXOucyr+eTgPB3209D9ydSYGM3uFljpqaz4elL9cd5
	0kxiM1QVy5YybOxHTZ6XWTxI/vXV4aIPIcOIVd7KrY+dzOnZtkKe9SAqOnSs+KqoWPPBBIvl6VT
	VlnfJbZ6jjxAS33IcOrLMNmPPxU4REnOAdZXeelrxeqS1KaHQrD30VS/jjfoITKHtnd7FfNILFr
	pTAY+nHrMXKrKWWUTRP8mgTnTImKlcL/S7iAC2bXUqo+Ja8tp1u9xg+0/VZOKgyeaAscoctI8wz
	+HdHrWYeTDmMPrWecmb4FQ3+/QsoL/uMCf9bJLmOkr2NTu0Emy+5g5YWzx7K8tBeslHSCOSbgmp
	tddceM+pRmQaygt22a6Wbwq1qgMA==
X-Google-Smtp-Source: AGHT+IEfKYjLqt2vOA0djKXuk2O6PXwwzi5yrPiXQXWA1q+qWEPyGDImcRZthb2wqzK9TSxKExOE9w==
X-Received: by 2002:a17:90b:4d8d:b0:343:87b3:6fbb with SMTP id 98e67ed59e1d1-34907f64079mr2992946a91.8.1764688048903;
        Tue, 02 Dec 2025 07:07:28 -0800 (PST)
Received: from [127.0.0.1] ([172.215.210.113])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3476a546ed0sm20487216a91.3.2025.12.02.07.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 07:07:28 -0800 (PST)
Message-Id: <pull.2011.git.1764688047077.gitgitgadget@gmail.com>
From: "Paulo Casaretto via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 02 Dec 2025 15:07:27 +0000
Subject: [PATCH] lockfile: add PID file for debugging stale locks
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
    Paulo Casaretto <pcasaretto@gmail.com>,
    Paulo Casaretto <pcasaretto@gmail.com>

From: Paulo Casaretto <pcasaretto@gmail.com>

When a lock file is held, it can be helpful to know which process owns
it, especially when debugging stale locks left behind by crashed
processes. Add an optional feature that creates a companion .lock.pid
file alongside each lock file, containing the PID of the lock holder.

The .lock.pid file is created when a lock is acquired (if enabled), and
automatically cleaned up when the lock is released (via commit or
rollback). The file is registered as a tempfile so it gets cleaned up
by signal and atexit handlers if the process terminates abnormally.

When a lock conflict occurs, the code checks if the PID from the .pid
file is still running using kill(pid, 0). This allows providing
context-aware error messages. With PID info enabled:

  Lock is held by process 12345. Wait for it to finish, or remove
  the lock file to continue.

Or for a stale lock:

  Lock was held by process 12345, which is no longer running.
  Remove the stale lock file to continue.

Without PID info (default):

  Another git process seems to be running in this repository.
  Wait for it to finish, or remove the lock file to continue.

The feature is opt-in via GIT_LOCK_PID_INFO=1 environment variable.

Signed-off-by: Paulo Casaretto <pcasaretto@gmail.com>
---
    lockfile: add holder info file for debugging stale locks

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2011%2Fpcasaretto%2Fpid-holder-file-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2011/pcasaretto/pid-holder-file-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2011

 Documentation/git.adoc  |  10 ++++
 lockfile.c              | 109 +++++++++++++++++++++++++++++++++++++---
 lockfile.h              |  21 +++++---
 t/meson.build           |   1 +
 t/t0031-lockfile-pid.sh |  73 +++++++++++++++++++++++++++
 5 files changed, 199 insertions(+), 15 deletions(-)
 create mode 100755 t/t0031-lockfile-pid.sh

diff --git a/Documentation/git.adoc b/Documentation/git.adoc
index ce099e78b8..6fdd509d34 100644
--- a/Documentation/git.adoc
+++ b/Documentation/git.adoc
@@ -1010,6 +1010,16 @@ be in the future).
 	the background which do not want to cause lock contention with
 	other operations on the repository.  Defaults to `1`.
 
+`GIT_LOCK_PID_INFO`::
+	If this Boolean environment variable is set to `1`, Git will create
+	a `.lock.pid` file alongside each lock file containing the PID of the
+	process that created the lock. This information is displayed in error
+	messages when a lock conflict occurs, making it easier to identify
+	stale locks or debug locking issues. The PID files are automatically
+	cleaned up via signal and atexit handlers; however, if a process is
+	terminated abnormally (e.g., SIGKILL), the file may remain as a stale
+	indicator. Disabled by default.
+
 `GIT_REDIRECT_STDIN`::
 `GIT_REDIRECT_STDOUT`::
 `GIT_REDIRECT_STDERR`::
diff --git a/lockfile.c b/lockfile.c
index 1d5ed01682..4a694b9c3d 100644
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
@@ -71,6 +74,62 @@ static void resolve_symlink(struct strbuf *path)
 	strbuf_reset(&link);
 }
 
+/*
+ * Lock PID file functions - write PID to a .lock.pid file alongside
+ * the lock file for debugging stale locks. The PID file is registered
+ * as a tempfile so it gets cleaned up by signal/atexit handlers.
+ */
+
+static int lock_pid_info_enabled(void)
+{
+	return git_env_bool(GIT_LOCK_PID_INFO_ENVIRONMENT, 0);
+}
+
+static struct tempfile *create_lock_pid_file(const char *lock_path, int mode)
+{
+	struct strbuf pid_path = STRBUF_INIT;
+	struct strbuf content = STRBUF_INIT;
+	struct tempfile *pid_tempfile = NULL;
+	int fd;
+
+	if (!lock_pid_info_enabled())
+		return NULL;
+
+	strbuf_addf(&pid_path, "%s%s", lock_path, LOCK_PID_SUFFIX);
+	fd = open(pid_path.buf, O_WRONLY | O_CREAT | O_TRUNC, mode);
+	if (fd >= 0) {
+		strbuf_addf(&content, "%"PRIuMAX"\n", (uintmax_t)getpid());
+		if (write_in_full(fd, content.buf, content.len) < 0)
+			warning_errno(_("could not write lock pid file '%s'"),
+				      pid_path.buf);
+		close(fd);
+		pid_tempfile = register_tempfile(pid_path.buf);
+	}
+	strbuf_release(&content);
+	strbuf_release(&pid_path);
+	return pid_tempfile;
+}
+
+static int read_lock_pid(const char *lock_path, uintmax_t *pid_out)
+{
+	struct strbuf pid_path = STRBUF_INIT;
+	struct strbuf content = STRBUF_INIT;
+	int ret = -1;
+
+	strbuf_addf(&pid_path, "%s%s", lock_path, LOCK_PID_SUFFIX);
+	if (strbuf_read_file(&content, pid_path.buf, LOCK_PID_MAXLEN) > 0) {
+		char *endptr;
+		*pid_out = strtoumax(content.buf, &endptr, 10);
+		if (*pid_out > 0 && (*endptr == '\n' || *endptr == '\0'))
+			ret = 0;
+		else
+			warning(_("malformed lock pid file '%s'"), pid_path.buf);
+	}
+	strbuf_release(&pid_path);
+	strbuf_release(&content);
+	return ret;
+}
+
 /* Make sure errno contains a meaningful value on error */
 static int lock_file(struct lock_file *lk, const char *path, int flags,
 		     int mode)
@@ -80,9 +139,12 @@ static int lock_file(struct lock_file *lk, const char *path, int flags,
 	strbuf_addstr(&filename, path);
 	if (!(flags & LOCK_NO_DEREF))
 		resolve_symlink(&filename);
-
 	strbuf_addstr(&filename, LOCK_SUFFIX);
+
 	lk->tempfile = create_tempfile_mode(filename.buf, mode);
+	if (lk->tempfile)
+		lk->pid_tempfile = create_lock_pid_file(filename.buf, mode);
+
 	strbuf_release(&filename);
 	return lk->tempfile ? lk->tempfile->fd : -1;
 }
@@ -151,13 +213,36 @@ static int lock_file_timeout(struct lock_file *lk, const char *path,
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
+		struct strbuf lock_path = STRBUF_INIT;
+		uintmax_t pid;
+		int pid_status = 0; /* 0 = unknown, 1 = running, -1 = stale */
+
+		strbuf_addf(&lock_path, "%s%s", absolute_path(path), LOCK_SUFFIX);
+
+		strbuf_addf(buf, _("Unable to create '%s': %s.\n\n"),
+			    lock_path.buf, strerror(err));
+
+		if (lock_pid_info_enabled() &&
+		    !read_lock_pid(lock_path.buf, &pid)) {
+			if (kill((pid_t)pid, 0) == 0)
+				pid_status = 1;
+			else
+				pid_status = -1;
+		}
+
+		if (pid_status == 1)
+			strbuf_addf(buf, _("Lock is held by process %"PRIuMAX". "
+			    "Wait for it to finish, or remove the lock file to continue"),
+			    pid);
+		else if (pid_status == -1)
+			strbuf_addf(buf, _("Lock was held by process %"PRIuMAX", "
+			    "which is no longer running. Remove the stale lock file to continue"),
+			    pid);
+		else
+			strbuf_addstr(buf, _("Another git process seems to be running in this repository. "
+			    "Wait for it to finish, or remove the lock file to continue"));
+
+		strbuf_release(&lock_path);
 	} else
 		strbuf_addf(buf, _("Unable to create '%s.lock': %s"),
 			    absolute_path(path), strerror(err));
@@ -207,6 +292,8 @@ int commit_lock_file(struct lock_file *lk)
 {
 	char *result_path = get_locked_file_path(lk);
 
+	delete_tempfile(&lk->pid_tempfile);
+
 	if (commit_lock_file_to(lk, result_path)) {
 		int save_errno = errno;
 		free(result_path);
@@ -216,3 +303,9 @@ int commit_lock_file(struct lock_file *lk)
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
index 1bb9926497..b2d5a1bc6c 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -119,6 +119,7 @@
 
 struct lock_file {
 	struct tempfile *tempfile;
+	struct tempfile *pid_tempfile;
 };
 
 #define LOCK_INIT { 0 }
@@ -127,6 +128,15 @@ struct lock_file {
 #define LOCK_SUFFIX ".lock"
 #define LOCK_SUFFIX_LEN 5
 
+/* Suffix for PID file that stores PID of lock holder: */
+#define LOCK_PID_SUFFIX ".pid"
+#define LOCK_PID_SUFFIX_LEN 4
+
+/* Maximum length for PID file content */
+#define LOCK_PID_MAXLEN 32
+
+/* Environment variable to enable lock PID info (default: disabled) */
+#define GIT_LOCK_PID_INFO_ENVIRONMENT "GIT_LOCK_PID_INFO"
 
 /*
  * Flags
@@ -319,13 +329,10 @@ static inline int commit_lock_file_to(struct lock_file *lk, const char *path)
 
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
index dc43d69636..9a880db57c 100644
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
index 0000000000..3c1e9bf60e
--- /dev/null
+++ b/t/t0031-lockfile-pid.sh
@@ -0,0 +1,73 @@
+#!/bin/sh
+
+test_description='lock file PID info tests
+
+Tests for PID info file alongside lock files.
+The feature is opt-in via GIT_LOCK_PID_INFO=1.
+'
+
+. ./test-lib.sh
+
+test_expect_success 'stale lock detected when PID is not running' '
+	git init repo &&
+	(
+		cd repo &&
+		touch .git/index.lock &&
+		echo "99999" >.git/index.lock.pid &&
+		test_must_fail env GIT_LOCK_PID_INFO=1 git add . 2>err &&
+		test_grep "process 99999, which is no longer running" err &&
+		test_grep "Remove the stale lock file" err
+	)
+'
+
+test_expect_success 'PID info not shown by default' '
+	git init repo2 &&
+	(
+		cd repo2 &&
+		touch .git/index.lock &&
+		echo "99999" >.git/index.lock.pid &&
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
+		# Create a lock and PID file with current shell PID (which is running)
+		touch .git/index.lock &&
+		echo $$ >.git/index.lock.pid &&
+		# Verify our PID is shown in the error message
+		test_must_fail env GIT_LOCK_PID_INFO=1 git add file 2>err &&
+		test_grep "held by process $$" err
+	)
+'
+
+test_expect_success 'PID info file cleaned up on successful operation when enabled' '
+	git init repo4 &&
+	(
+		cd repo4 &&
+		echo content >file &&
+		env GIT_LOCK_PID_INFO=1 git add file &&
+		# After successful add, no lock or PID files should exist
+		! test -f .git/index.lock &&
+		! test -f .git/index.lock.pid
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
+		! test -f .git/index.lock.pid
+	)
+'
+
+test_done

base-commit: 6ab38b7e9cc7adafc304f3204616a4debd49c6e9
-- 
gitgitgadget
