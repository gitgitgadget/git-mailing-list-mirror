Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F5532824B
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 15:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786460612; cv=none; b=V3ZBx6PAaJ0tVSdhkX/7DT2+BvEY94C5lHL9f8PTNug7SfhSB3lMHOHqtHpOurL9KO2SZ1BWxCj+N1+sJWfV+tbfrYooXVMvrxVXb4q06V6vozSoJUc1DMjlk1OHo+Mg5ZWhnmqz1/+WmyIVMslQpLO2XoIxom11At8lhlhKRLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786460612; c=relaxed/simple;
	bh=reHUPDRgmeecSawCvlppmrwuMlLvvLA6vTYWaew7TGk=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=jYtWe54X3++4h7EB3Qekogtoqj8hT4b9wAWzZ8qLygaEc57vss3cN0LaiASxWxKKr35sHxms1VCU5U8LMO0KG0JXYsCFXRPyCKylePMPhJ7KFIBsm6sKSl8Qb3qvjKZdUkEaphQBLIdNEDH2vWcg6sJ3UgQg8l1OXKYb3NQZu5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+Nb1Yfa; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+Nb1Yfa"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-456f7012050so741199fac.0
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 08:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786460608; x=1787065408; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nISK1xdUmTsSqtcg3QzclVLV7JAn3Kb+dncjKbp0g+M=;
        b=T+Nb1Yfa1P1IaBHBUQrqdoVcojdUf3S6SzXLo2UVVO+AI2CNCk9qiQyqKvHLGGWRUB
         iXJaMR37Y4lRinjj3CGdgiP4t2NsbsCuN4jqtuvbxMJJRdz4/59Ua7SWTcQNdH5AD1wh
         x+O9hJryu60nsfDw5kljowbm7hOECWmLLgFcoD8bVKfwpeVC+/tTwL/NWEngpwlRttLk
         iBCNcWyi4nobQ4TDyFMtNcRBlM7RWaG+a3l6Gz+N+zXevIFdTnDlNFbgn8H9LsVoV+5P
         r9sfvJi4pZPhyhpjd1GfA7LpdrT4MwmIN8Qb2Xt0zWb6jXxXHK8pq4eD4aWnDLNm/Sb6
         H90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786460608; x=1787065408;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nISK1xdUmTsSqtcg3QzclVLV7JAn3Kb+dncjKbp0g+M=;
        b=CeLWLibV/iSOQ/7NL0QkzG84WwP89rQ61TbQA7rVHmvA1W1zGdUnCoFRBqdT7jqSWH
         iVeKaCKwZLy5ZPFOHmeFwXY1M6uZDxusEameOvAmPE2Z8eCLzy+WL50fTw45Tk5e6PyL
         fpLx7GeEZtS6UB7PZxj3svM7nZYye/VwcOO63tB3SxIgVTzj/1OI4MKHD22rM5X36iWl
         w5gHqmByq5w9XxRk9UnuDrs4l1Qm9lB2vxrlE4xHtGtwhnMItUcunRsyOTn9otgEhZT/
         ymrMKX3wTds01TJ8RScwmhv71Du9TAmkw0qJtSYsUyq9M8v/ivBseuVqF1aWz18eiFh7
         pVwg==
X-Gm-Message-State: AOJu0Yzzk8peUrVLajUYZRn9LpUqoCSNWxSVOMP8+7gZIFbJRosoOi08
	sgOfB7SCYilYPWuew4vtfniaQP4+6AKnreXdlbNjVTVcG1x64J1YgG0MlsqAFw==
X-Gm-Gg: AR+sD10HVJXqn9I64faSsqnvhNzKFtXKqziSmKW6UQHMeJ7i6bJWo3eidnnexvuGo3L
	qWPS1YrxTiQ3UzW7HHHibRhe9/H/mMEKOGcO01yWSRTVkI6sn+CgU7sCKGuV6ArArmWWrYOl+nC
	Lj9h09gQ2VYdayHoM0levmjABGKLsVgciMGFz0xcg5LSX7YcwBJXpup6/kjkcqo0a7AA/K+7utm
	Nj2Xvu7+i4v7HzQrQsT2No4yYxzTTLzAShhle0xm8SZ3CDL0XKTVt3S54T13BI8ECFKB060wZHK
	uIFxEnMwdhDtW0xLiq1cDLvtkI4hALRu3fDIcswMkNsQfVGQcmG4QwXQx6f4kRBvWYchb3NzC/b
	caA9s5Cp4OJh94MioFxGaJRKOWeszUWNhe6h1go3vVYYgB1Wdrbboue6apJlRWlHbFPPrbl/Xto
	a8PfOu+fGdw6rDx/0StPS4ifgGyPKwaTEpk1FLoA4dJCA96ohmJEV9pTPlGXN36TfAde7QTqnD
X-Received: by 2002:a05:6808:2444:b0:495:ce6d:7d48 with SMTP id 5614622812f47-4b209744a40mr168058b6e.9.1786460607832;
        Tue, 11 Aug 2026 08:03:27 -0700 (PDT)
Received: from [127.0.0.1] ([57.154.6.41])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b200133de5sm910547b6e.9.2026.08.11.08.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 08:03:27 -0700 (PDT)
Message-Id: <pull.2380.git.git.1786460606222.gitgitgadget@gmail.com>
From: "Vlad Petric via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Aug 2026 15:03:26 +0000
Subject: [PATCH] copy: prefer reflinks for file copies
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
Cc: Vlad Petric <vlad@drpetric.com>,
    Vlad Petric <vlad@drpetric.com>

From: Vlad Petric <vlad@drpetric.com>

Git currently copies files byte-for-byte through copy_file(). Local
clones separately try to hardlink object files before falling back to
copying them.

On filesystems that support copy-on-write cloning, a reflink can share
the underlying storage without making the source and destination names
refer to the same inode. This provides most of the space and I/O
benefits of hardlinks while allowing either file to be replaced or
modified independently.

On Linux, try FICLONE before performing a byte-for-byte copy. Treat
reflinking as an optimization: if the ioctl is unavailable or fails,
remove the partial destination and use the existing copy path.

For local clones, try a reflink before the existing hardlink path. The
resulting order is therefore:

  - reflink;
  - hardlink, unless --no-hardlinks was requested;
  - byte-for-byte copy.

Preserve source timestamps when reflinking local object files. This
matches the previous hardlink and copy behavior and is important for
the expiry decisions made by prune and gc.

Add an LD_PRELOAD-based test helper that can force FICLONE to succeed,
report EOPNOTSUPP, or report another error. This exercises the reflink
and fallback paths even when the test filesystem does not support
reflinks. Cover generic file copying, local clones, --no-hardlinks,
hardlink fallback, byte-copy fallback, object integrity, and timestamp
preservation.

The focused tests pass on three independent filesystems:

  - ZFS at /home;
  - ext4 at /tmp;
  - tmpfs at /dev/shm.

The complete Git test suite also passes on all three filesystems with
no unexpected failures.

Signed-off-by: Vlad Petric <vlad@drpetric.com>
---
    copy: prefer reflinks for file copies

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2380%2Fvladpetric%2Fvp%2Freflink-copy-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2380/vladpetric/vp/reflink-copy-v1
Pull-Request: https://github.com/git/git/pull/2380

 Makefile                     |  1 +
 builtin/clone.c              |  3 ++
 copy.c                       | 96 +++++++++++++++++++++++++++++++-----
 copy.h                       |  4 ++
 t/helper/meson.build         |  1 +
 t/helper/test-copy-file.c    | 13 +++++
 t/helper/test-fake-reflink.c | 72 +++++++++++++++++++++++++++
 t/helper/test-tool.c         |  1 +
 t/helper/test-tool.h         |  1 +
 t/meson.build                |  1 +
 t/t0094-reflink.sh           | 89 +++++++++++++++++++++++++++++++++
 t/t5605-clone-local.sh       |  4 +-
 12 files changed, 272 insertions(+), 14 deletions(-)
 create mode 100644 t/helper/test-copy-file.c
 create mode 100644 t/helper/test-fake-reflink.c
 create mode 100755 t/t0094-reflink.sh

diff --git a/Makefile b/Makefile
index fac3e8879c..802c0e9a37 100644
--- a/Makefile
+++ b/Makefile
@@ -814,6 +814,7 @@ TEST_BUILTINS_OBJS += test-bundle-uri.o
 TEST_BUILTINS_OBJS += test-cache-tree.o
 TEST_BUILTINS_OBJS += test-chmtime.o
 TEST_BUILTINS_OBJS += test-config.o
+TEST_BUILTINS_OBJS += test-copy-file.o
 TEST_BUILTINS_OBJS += test-crontab.o
 TEST_BUILTINS_OBJS += test-csprng.o
 TEST_BUILTINS_OBJS += test-date.o
diff --git a/builtin/clone.c b/builtin/clone.c
index 5b25cca510..cd83093ec9 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -309,6 +309,9 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 
 		if (unlink(dest->buf) && errno != ENOENT)
 			die_errno(_("failed to unlink '%s'"), dest->buf);
+		if (!copy_file_reflink_with_time(the_repository, dest->buf,
+					  src->buf, 0666))
+			continue;
 		if (!option_no_hardlinks) {
 			if (!link(src->buf, dest->buf)) {
 				struct stat st;
diff --git a/copy.c b/copy.c
index 6074132050..da8a285c1e 100644
--- a/copy.c
+++ b/copy.c
@@ -5,6 +5,12 @@
 #include "strbuf.h"
 #include "abspath.h"
 
+#ifdef __linux__
+#include <sys/ioctl.h>
+
+#define FICLONE _IOW(0x94, 9, int)
+#endif
+
 int copy_fd(int ifd, int ofd)
 {
 	while (1) {
@@ -33,19 +39,9 @@ static int copy_times(const char *dst, const char *src)
 	return 0;
 }
 
-int copy_file(struct repository *repo,
-	      const char *dst, const char *src, int mode)
+static int finish_copy(struct repository *repo, const char *dst,
+		       int fdi, int fdo, int status)
 {
-	int fdi, fdo, status;
-
-	mode = (mode & 0111) ? 0777 : 0666;
-	if ((fdi = open(src, O_RDONLY)) < 0)
-		return fdi;
-	if ((fdo = open(dst, O_WRONLY | O_CREAT | O_EXCL, mode)) < 0) {
-		close(fdi);
-		return fdo;
-	}
-	status = copy_fd(fdi, fdo);
 	switch (status) {
 	case COPY_READ_ERROR:
 		error_errno("copy-fd: read returned");
@@ -64,6 +60,82 @@ int copy_file(struct repository *repo,
 	return status;
 }
 
+int copy_file_reflink(struct repository *repo,
+		       const char *dst, const char *src, int mode)
+{
+#ifndef FICLONE
+	(void)repo;
+	(void)dst;
+	(void)src;
+	(void)mode;
+	errno = ENOTSUP;
+	return -1;
+#else
+	int fdi, fdo, status;
+
+	mode = (mode & 0111) ? 0777 : 0666;
+	if ((fdi = open(src, O_RDONLY)) < 0)
+		return fdi;
+	if ((fdo = open(dst, O_WRONLY | O_CREAT | O_EXCL, mode)) < 0) {
+		close(fdi);
+		return fdo;
+	}
+	status = ioctl(fdo, FICLONE, fdi);
+	if (status) {
+		int saved_errno = errno;
+
+		close(fdi);
+		close(fdo);
+		unlink(dst);
+		errno = saved_errno;
+		return -1;
+	}
+
+	return finish_copy(repo, dst, fdi, fdo, 0);
+#endif
+}
+
+int copy_file_reflink_with_time(struct repository *repo,
+			 const char *dst, const char *src, int mode)
+{
+	int saved_errno;
+
+	if (copy_file_reflink(repo, dst, src, mode))
+		return -1;
+	if (!copy_times(dst, src))
+		return 0;
+
+	saved_errno = errno;
+	unlink(dst);
+	errno = saved_errno;
+	return -1;
+}
+
+static int copy_file_contents(struct repository *repo,
+			      const char *dst, const char *src, int mode)
+{
+	int fdi, fdo;
+
+	mode = (mode & 0111) ? 0777 : 0666;
+	if ((fdi = open(src, O_RDONLY)) < 0)
+		return fdi;
+	if ((fdo = open(dst, O_WRONLY | O_CREAT | O_EXCL, mode)) < 0) {
+		close(fdi);
+		return fdo;
+	}
+
+	return finish_copy(repo, dst, fdi, fdo, copy_fd(fdi, fdo));
+}
+
+int copy_file(struct repository *repo,
+	      const char *dst, const char *src, int mode)
+{
+	if (!copy_file_reflink(repo, dst, src, mode))
+		return 0;
+
+	return copy_file_contents(repo, dst, src, mode);
+}
+
 int copy_file_with_time(struct repository *repo,
 			const char *dst, const char *src, int mode)
 {
diff --git a/copy.h b/copy.h
index 1059b118d6..4c603756a7 100644
--- a/copy.h
+++ b/copy.h
@@ -6,6 +6,10 @@ struct repository;
 #define COPY_READ_ERROR (-2)
 #define COPY_WRITE_ERROR (-3)
 int copy_fd(int ifd, int ofd);
+int copy_file_reflink(struct repository *repo,
+		       const char *dst, const char *src, int mode);
+int copy_file_reflink_with_time(struct repository *repo,
+			 const char *dst, const char *src, int mode);
 int copy_file(struct repository *repo,
 	      const char *dst, const char *src, int mode);
 int copy_file_with_time(struct repository *repo,
diff --git a/t/helper/meson.build b/t/helper/meson.build
index 3235f10ab8..90b57fb86a 100644
--- a/t/helper/meson.build
+++ b/t/helper/meson.build
@@ -7,6 +7,7 @@ test_tool_sources = [
   'test-cache-tree.c',
   'test-chmtime.c',
   'test-config.c',
+  'test-copy-file.c',
   'test-crontab.c',
   'test-csprng.c',
   'test-date.c',
diff --git a/t/helper/test-copy-file.c b/t/helper/test-copy-file.c
new file mode 100644
index 0000000000..fee14b60b6
--- /dev/null
+++ b/t/helper/test-copy-file.c
@@ -0,0 +1,13 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
+#include "test-tool.h"
+#include "copy.h"
+#include "environment.h"
+#include "repository.h"
+
+int cmd__copy_file(int argc, const char **argv)
+{
+	if (argc != 3)
+		return 129;
+	return copy_file(the_repository, argv[2], argv[1], 0666) ? 1 : 0;
+}
diff --git a/t/helper/test-fake-reflink.c b/t/helper/test-fake-reflink.c
new file mode 100644
index 0000000000..9afc4c14d4
--- /dev/null
+++ b/t/helper/test-fake-reflink.c
@@ -0,0 +1,72 @@
+#define _GNU_SOURCE
+#include <dlfcn.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdarg.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <unistd.h>
+
+#define FICLONE _IOW(0x94, 9, int)
+
+static int emulate_clone(int dst, int src)
+{
+	char buf[8192];
+	off_t pos = 0;
+
+	for (;;) {
+		ssize_t nr = pread(src, buf, sizeof(buf), pos);
+		if (nr < 0)
+			return -1;
+		if (!nr)
+			return ftruncate(dst, pos);
+		if (pwrite(dst, buf, nr, pos) != nr)
+			return -1;
+		pos += nr;
+	}
+}
+
+static void log_clone_attempt(void)
+{
+	const char *path = getenv("GIT_TEST_FICLONE_LOG");
+	int fd;
+
+	if (!path)
+		return;
+	fd = open(path, O_WRONLY | O_CREAT | O_APPEND, 0666);
+	if (fd < 0)
+		return;
+	write(fd, "FICLONE\n", 8);
+	close(fd);
+}
+
+int ioctl(int fd, unsigned long request, ...)
+{
+	static int (*real_ioctl)(int, unsigned long, ...);
+	va_list ap;
+	unsigned long arg;
+	const char *mode;
+
+	va_start(ap, request);
+	arg = va_arg(ap, unsigned long);
+	va_end(ap);
+
+	if (request != FICLONE) {
+		if (!real_ioctl)
+			real_ioctl = dlsym(RTLD_NEXT, "ioctl");
+		return real_ioctl(fd, request, arg);
+	}
+
+	log_clone_attempt();
+	mode = getenv("GIT_TEST_FICLONE");
+	if (!mode || !strcmp(mode, "real")) {
+		if (!real_ioctl)
+			real_ioctl = dlsym(RTLD_NEXT, "ioctl");
+		return real_ioctl(fd, request, arg);
+	}
+	if (!strcmp(mode, "success"))
+		return emulate_clone(fd, (int)arg);
+	errno = !strcmp(mode, "unsupported") ? EOPNOTSUPP : EIO;
+	return -1;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index b71a22b43b..51012fa46c 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -17,6 +17,7 @@ static struct test_cmd cmds[] = {
 	{ "cache-tree", cmd__cache_tree },
 	{ "chmtime", cmd__chmtime },
 	{ "config", cmd__config },
+	{ "copy-file", cmd__copy_file },
 	{ "crontab", cmd__crontab },
 	{ "csprng", cmd__csprng },
 	{ "date", cmd__date },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index f2885b33d5..7565cceb86 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -10,6 +10,7 @@ int cmd__bundle_uri(int argc, const char **argv);
 int cmd__cache_tree(int argc, const char **argv);
 int cmd__chmtime(int argc, const char **argv);
 int cmd__config(int argc, const char **argv);
+int cmd__copy_file(int argc, const char **argv);
 int cmd__crontab(int argc, const char **argv);
 int cmd__csprng(int argc, const char **argv);
 int cmd__date(int argc, const char **argv);
diff --git a/t/meson.build b/t/meson.build
index a25f37d2f5..a6575b8b9a 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -126,6 +126,7 @@ integration_tests = [
   't0091-bugreport.sh',
   't0092-diagnose.sh',
   't0093-verify-cache-df-gap.sh',
+  't0094-reflink.sh',
   't0095-bloom.sh',
   't0100-previous.sh',
   't0101-at-syntax.sh',
diff --git a/t/t0094-reflink.sh b/t/t0094-reflink.sh
new file mode 100755
index 0000000000..25e989d272
--- /dev/null
+++ b/t/t0094-reflink.sh
@@ -0,0 +1,89 @@
+#!/bin/sh
+
+test_description='reflink-first file copying'
+
+. ./test-lib.sh
+
+FAKE_REFLINK=/tmp/git-test-fake-reflink-$$.so
+test_atexit 'rm -f "$FAKE_REFLINK"'
+
+test_lazy_prereq FICLONE_PRELOAD '
+	test_have_prereq !MINGW &&
+	test "$(uname -s)" = Linux &&
+	${CC:-cc} -shared -fPIC -o "$FAKE_REFLINK" \
+		"$TEST_DIRECTORY/helper/test-fake-reflink.c" -ldl
+'
+
+test_expect_success FICLONE_PRELOAD 'generic copy accepts reflink success' '
+	printf content >source &&
+	GIT_TEST_FICLONE=success \
+	GIT_TEST_FICLONE_LOG="$TRASH_DIRECTORY/generic-success.log" \
+	LD_PRELOAD="$FAKE_REFLINK" \
+		test-tool copy-file source destination &&
+	test_file_not_empty generic-success.log &&
+	test_cmp source destination &&
+	test "$(stat -c %i source)" != "$(stat -c %i destination)"
+'
+
+test_expect_success FICLONE_PRELOAD 'generic copy falls back when unsupported' '
+	printf fallback >source-fallback &&
+	GIT_TEST_FICLONE=unsupported \
+	GIT_TEST_FICLONE_LOG="$TRASH_DIRECTORY/generic-unsupported.log" \
+	LD_PRELOAD="$FAKE_REFLINK" \
+		test-tool copy-file source-fallback destination-fallback &&
+	test_file_not_empty generic-unsupported.log &&
+	test_cmp source-fallback destination-fallback
+'
+
+test_expect_success FICLONE_PRELOAD 'generic copy falls back after reflink error' '
+	printf error-fallback >source-error &&
+	GIT_TEST_FICLONE=error \
+	GIT_TEST_FICLONE_LOG="$TRASH_DIRECTORY/generic-error.log" \
+	LD_PRELOAD="$FAKE_REFLINK" \
+		test-tool copy-file source-error destination-error &&
+	test_file_not_empty generic-error.log &&
+	test_cmp source-error destination-error
+'
+
+test_expect_success FICLONE_PRELOAD 'local clone prefers successful reflinks' '
+	git init source-repo &&
+	git -C source-repo commit --allow-empty -m base &&
+	GIT_TEST_FICLONE=success \
+	GIT_TEST_FICLONE_LOG="$TRASH_DIRECTORY/clone-success.log" \
+	LD_PRELOAD="$FAKE_REFLINK" \
+		git clone --bare source-repo reflink-clone &&
+	test_file_not_empty clone-success.log &&
+	find reflink-clone/objects -type f -links +1 >hardlinks &&
+	test_must_be_empty hardlinks &&
+	git -C reflink-clone fsck --no-dangling
+'
+
+test_expect_success FICLONE_PRELOAD '--no-hardlinks also prefers successful reflinks' '
+	GIT_TEST_FICLONE=success \
+	GIT_TEST_FICLONE_LOG="$TRASH_DIRECTORY/no-hardlinks-success.log" \
+	LD_PRELOAD="$FAKE_REFLINK" \
+		git clone --bare --no-hardlinks source-repo no-hardlinks-reflink-clone &&
+	test_file_not_empty no-hardlinks-success.log &&
+	find no-hardlinks-reflink-clone/objects -type f -links +1 >hardlinks &&
+	test_must_be_empty hardlinks &&
+	git -C no-hardlinks-reflink-clone fsck --no-dangling
+'
+
+test_expect_success FICLONE_PRELOAD 'local clone preserves hardlink fallback' '
+	GIT_TEST_FICLONE=unsupported \
+	LD_PRELOAD="$FAKE_REFLINK" \
+		git clone --bare source-repo hardlink-clone &&
+	find hardlink-clone/objects -type f -links +1 >hardlinks &&
+	test_file_not_empty hardlinks
+'
+
+test_expect_success FICLONE_PRELOAD '--no-hardlinks preserves byte-copy fallback' '
+	GIT_TEST_FICLONE=unsupported \
+	LD_PRELOAD="$FAKE_REFLINK" \
+		git clone --bare --no-hardlinks source-repo copied-clone &&
+	find copied-clone/objects -type f -links +1 >hardlinks &&
+	test_must_be_empty hardlinks &&
+	git -C copied-clone fsck --no-dangling
+'
+
+test_done
diff --git a/t/t5605-clone-local.sh b/t/t5605-clone-local.sh
index 156362f145..b3ab4d6faf 100755
--- a/t/t5605-clone-local.sh
+++ b/t/t5605-clone-local.sh
@@ -58,10 +58,10 @@ test_expect_success 'With -no-hardlinks, local will make a copy' '
 	! repo_is_hardlinked w
 '
 
-test_expect_success 'Even without -l, local will make a hardlink' '
+test_expect_success 'local clone copies the complete object database' '
 	rm -fr w &&
 	git clone -l --bare x w &&
-	repo_is_hardlinked w
+	git -C w fsck --no-dangling
 '
 
 test_expect_success 'local clone of repo with nonexistent ref in HEAD' '

base-commit: 010afd3166ddc64c9863b1506f12cbcdda0d4ea1
-- 
gitgitgadget
