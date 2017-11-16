Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53ED9202D7
	for <e@80x24.org>; Thu, 16 Nov 2017 17:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750738AbdKPRGT (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 12:06:19 -0500
Received: from mail-yw0-f194.google.com ([209.85.161.194]:51220 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936248AbdKPRGA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 12:06:00 -0500
Received: by mail-yw0-f194.google.com with SMTP id k3so19959020ywk.8
        for <git@vger.kernel.org>; Thu, 16 Nov 2017 09:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XV6/NFclw2DyZANpv+EDJmLJ8UDLbD3FJyQ0bKQiNHc=;
        b=tUXjuyqIJsK2jq5ZfGnJR4qzvEcQOvackuxsJGwqQBtBwmDFOrkaCmkN3xKzKux17K
         sPOT/DRQyTJGj0uTs4T2RBzEuaJ8jYxcHcXfVqsKpCSML/WLVEuAJdFqbKYTumwk26os
         9HXUonG/w9UENbB5JaMMOgRNc+5gzQpD5fywbyURPZxBNOPZ1TR0MWR8AJadhfeh9IPd
         jNvzWku7MsIBO5r5wYUJjsg1LF1lUZSjFSp85rrmWiXBlhHRWEa3muEMYxsla5rcDHZF
         hjivoFsfyXGugWsUrvKKnvGQY9EGQlGdmvTx64Im3n2AsfPqJSiYjC8H6qyf+QzN1pB8
         aMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XV6/NFclw2DyZANpv+EDJmLJ8UDLbD3FJyQ0bKQiNHc=;
        b=jZZdK6/y71NNkUKedzCBU+V8OIevASXY/daNeFEovYl56wRSflXEs97lSQvUbh6Qnl
         NWfqmdw4gbxrAY9yeo0vGqBbXbvXlzlDTPnZ2nIayf3cvYXYYAeLh0fGYblZhMbaoV1P
         bDoZ4QZem0f8Dh5mkqgFDBKEf8XxsU6lBabRE7P4LkSYpo7guUsw/UN35x0PGfjrSQL8
         jkZDFEoDNSTTNcwQ86WImO5xSLC0vwLvc7by9xA+9rdZEb3T4g3n70/i5e8pBZxKu9Dc
         9eeK4Aj275g6sLErdh3YM2P0ZAMHURFQwC8YojaEXgaOJxn38Dn2LKwZPd4uHEBKv+Qm
         UU6Q==
X-Gm-Message-State: AJaThX5+Ti1hI/VMogdlBFI9qoMMs03cpC10hYxp114x2ZHZ76pX6pMG
        kfws+fCwqFYBLb6OpKSIDNFp2KM7TAg=
X-Google-Smtp-Source: AGs4zMYfal+j9/yseN1oQN+6k2oiBWPkcYcvMYo3hRj2EBE+v8JlQwRDUfBHcU8Gkn4+33unTuDQRw==
X-Received: by 10.129.56.197 with SMTP id f188mr1363483ywa.144.1510851958650;
        Thu, 16 Nov 2017 09:05:58 -0800 (PST)
Received: from dnj.pit.corp.google.com ([2620:0:1019:0:5840:7173:18ff:ed41])
        by smtp.gmail.com with ESMTPSA id f4sm601077ywa.68.2017.11.16.09.05.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Nov 2017 09:05:58 -0800 (PST)
From:   Dan Jacques <dnj@google.com>
To:     git@vger.kernel.org
Cc:     Dan Jacques <dnj@google.com>
Subject: [PATCH 1/1] exec_cmd: RUNTIME_PREFIX on some POSIX systems
Date:   Thu, 16 Nov 2017 12:05:23 -0500
Message-Id: <20171116170523.28696-2-dnj@google.com>
X-Mailer: git-send-email 2.15.0.170.g1a936b6eb
In-Reply-To: <20171116170523.28696-1-dnj@google.com>
References: <20171116170523.28696-1-dnj@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Enable Git to resolve its own binary location using a variety of
OS-specific and generic methods, including:

- procfs via "/proc/self/exe" (Linux)
- _NSGetExecutablePath (Darwin)
- argv0, if absolute (all, including Windows).

This is used to enable RUNTIME_PREFIX support for non-Windows systems,
notably Linux and Darwin. When configured with RUNTIME_PREFIX, Git will
do a best-effort resolution of its executable path and automatically use
this as its "exec_path" for relative helper and data lookups, unless
explicitly overridden.

Git will also always export and consume its resolved "exec_path" using
the EXEC_PATH_ENVIRONMENT regardless of whether the user has overridden
it, simplifying future lookups and ensuring consistency in Git tooling
execution.

When building with a runtime prefix, Git's PERL libraries are now
installed to a consistently-named directory. This path is resolved and
exported to Git's delegate PERL invocations using the GITPERLLIB
environment variable. This enables Git's delegate PERL scripts to import
Git's own PERL libraries from a path relative to the executable.

Small incidental formatting cleanup of "exec_cmd.c".

Signed-off-by: Dan Jacques <dnj@google.com>
---
 Makefile               |  29 ++++++--
 builtin/receive-pack.c |   2 +-
 cache.h                |   2 +
 common-main.c          |   4 +-
 config.mak.uname       |   4 ++
 exec_cmd.c             | 189 +++++++++++++++++++++++++++++++++++++++++++------
 exec_cmd.h             |   6 +-
 gettext.c              |   7 +-
 git.c                  |   7 +-
 http-backend.c         |   2 +-
 shell.c                |   2 +-
 upload-pack.c          |   2 +-
 12 files changed, 217 insertions(+), 39 deletions(-)

diff --git a/Makefile b/Makefile
index ee9d5eb11..80db01706 100644
--- a/Makefile
+++ b/Makefile
@@ -296,7 +296,8 @@ all::
 # Define PERL_PATH to the path of your Perl binary (usually /usr/bin/perl).
 #
 # Define NO_PERL_MAKEMAKER if you cannot use Makefiles generated by perl's
-# MakeMaker (e.g. using ActiveState under Cygwin).
+# MakeMaker (e.g. using ActiveState under Cygwin, or building with a fixed
+# runtime prefix).
 #
 # Define NO_PERL if you do not want Perl scripts or libraries at all.
 #
@@ -462,6 +463,7 @@ ARFLAGS = rcs
 #   mandir
 #   infodir
 #   htmldir
+#   localedir
 # This can help installing the suite in a relocatable way.
 
 prefix = $(HOME)
@@ -485,6 +487,7 @@ pathsep = :
 mandir_relative = $(patsubst $(prefix)/%,%,$(mandir))
 infodir_relative = $(patsubst $(prefix)/%,%,$(infodir))
 htmldir_relative = $(patsubst $(prefix)/%,%,$(htmldir))
+localedir_relative = $(patsubst $(prefix)/%,%,$(localedir))
 
 export prefix bindir sharedir sysconfdir gitwebdir localedir
 
@@ -1522,9 +1525,6 @@ ifdef SHA1_MAX_BLOCK_SIZE
 	LIB_OBJS += compat/sha1-chunked.o
 	BASIC_CFLAGS += -DSHA1_MAX_BLOCK_SIZE="$(SHA1_MAX_BLOCK_SIZE)"
 endif
-ifdef NO_PERL_MAKEMAKER
-	export NO_PERL_MAKEMAKER
-endif
 ifdef NO_HSTRERROR
 	COMPAT_CFLAGS += -DNO_HSTRERROR
 	COMPAT_OBJS += compat/hstrerror.o
@@ -1547,6 +1547,14 @@ else
 endif
 ifdef RUNTIME_PREFIX
 	COMPAT_CFLAGS += -DRUNTIME_PREFIX
+
+	# Control PERL library location so it can be referenced by relocatable
+	# code.
+	NO_PERL_MAKEMAKER = YesPlease
+endif
+
+ifdef NO_PERL_MAKEMAKER
+	export NO_PERL_MAKEMAKER
 endif
 
 ifdef NO_PTHREADS
@@ -1632,6 +1640,15 @@ ifdef HAVE_GETDELIM
 	BASIC_CFLAGS += -DHAVE_GETDELIM
 endif
 
+ifneq ($(PROCFS_EXECUTABLE_PATH),)
+	procfs_executable_path_SQ = $(subst ','\'',$(PROCFS_EXECUTABLE_PATH))
+	BASIC_CFLAGS += '-DPROCFS_EXECUTABLE_PATH="$(procfs_executable_path_SQ)"'
+endif
+
+ifdef HAVE_NS_GET_EXECUTABLE_PATH
+	BASIC_CFLAGS += -DHAVE_NS_GET_EXECUTABLE_PATH
+endif
+
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK = NoThanks
 endif
@@ -1714,6 +1731,7 @@ bindir_relative_SQ = $(subst ','\'',$(bindir_relative))
 mandir_relative_SQ = $(subst ','\'',$(mandir_relative))
 infodir_relative_SQ = $(subst ','\'',$(infodir_relative))
 localedir_SQ = $(subst ','\'',$(localedir))
+localedir_relative_SQ = $(subst ','\'',$(localedir_relative))
 gitexecdir_SQ = $(subst ','\'',$(gitexecdir))
 template_dir_SQ = $(subst ','\'',$(template_dir))
 htmldir_relative_SQ = $(subst ','\'',$(htmldir_relative))
@@ -2130,6 +2148,7 @@ endif
 exec_cmd.sp exec_cmd.s exec_cmd.o: GIT-PREFIX
 exec_cmd.sp exec_cmd.s exec_cmd.o: EXTRA_CPPFLAGS = \
 	'-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' \
+	'-DGIT_LOCALE_PATH="$(localedir_relative_SQ)"' \
 	'-DBINDIR="$(bindir_relative_SQ)"' \
 	'-DPREFIX="$(prefix_SQ)"'
 
@@ -2147,7 +2166,7 @@ attr.sp attr.s attr.o: EXTRA_CPPFLAGS = \
 
 gettext.sp gettext.s gettext.o: GIT-PREFIX
 gettext.sp gettext.s gettext.o: EXTRA_CPPFLAGS = \
-	-DGIT_LOCALE_PATH='"$(localedir_SQ)"'
+	-DGIT_LOCALE_PATH='"$(localedir_relative_SQ)"'
 
 http-push.sp http.sp http-walker.sp remote-curl.sp imap-send.sp: SPARSE_FLAGS += \
 	-DCURL_DISABLE_TYPECHECK
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 4d37a160d..51203cc3d 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1947,7 +1947,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 
 	service_dir = argv[0];
 
-	setup_path();
+	setup_path_and_env();
 
 	if (!enter_repo(service_dir, 0))
 		die("'%s' does not appear to be a git repository", service_dir);
diff --git a/cache.h b/cache.h
index cb7fb7c00..9ef59f1cc 100644
--- a/cache.h
+++ b/cache.h
@@ -445,6 +445,8 @@ static inline enum object_type object_type(unsigned int mode)
 #define GIT_ICASE_PATHSPECS_ENVIRONMENT "GIT_ICASE_PATHSPECS"
 #define GIT_QUARANTINE_ENVIRONMENT "GIT_QUARANTINE_PATH"
 #define GIT_OPTIONAL_LOCKS_ENVIRONMENT "GIT_OPTIONAL_LOCKS"
+#define GIT_PERL_LIB_ENVIRONMENT "GITPERLLIB"
+#define GIT_TEXT_DOMAIN_DIR_ENVIRONMENT "GIT_TEXTDOMAINDIR"
 
 /*
  * This environment variable is expected to contain a boolean indicating
diff --git a/common-main.c b/common-main.c
index 6a689007e..6516a1f89 100644
--- a/common-main.c
+++ b/common-main.c
@@ -32,12 +32,12 @@ int main(int argc, const char **argv)
 	 */
 	sanitize_stdfds();
 
+	git_resolve_executable_dir(argv[0]);
+
 	git_setup_gettext();
 
 	attr_start();
 
-	git_extract_argv0_path(argv[0]);
-
 	restore_sigpipe_to_default();
 
 	return cmd_main(argc, argv);
diff --git a/config.mak.uname b/config.mak.uname
index 685a80d13..bd5c326d4 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -37,6 +37,7 @@ ifeq ($(uname_S),Linux)
 	HAVE_GETDELIM = YesPlease
 	SANE_TEXT_GREP=-a
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
+	PROCFS_EXECUTABLE_PATH = /proc/self/exe
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	HAVE_ALLOCA_H = YesPlease
@@ -111,6 +112,7 @@ ifeq ($(uname_S),Darwin)
 	BASIC_CFLAGS += -DPROTECT_HFS_DEFAULT=1
 	HAVE_BSD_SYSCTL = YesPlease
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
+	HAVE_NS_GET_EXECUTABLE_PATH = YesPlease
 endif
 ifeq ($(uname_S),SunOS)
 	NEEDS_SOCKET = YesPlease
@@ -218,6 +220,7 @@ ifeq ($(uname_S),OpenBSD)
 	BASIC_LDFLAGS += -L/usr/local/lib
 	HAVE_PATHS_H = YesPlease
 	HAVE_BSD_SYSCTL = YesPlease
+	PROCFS_EXECUTABLE_PATH = /proc/curproc/file
 endif
 ifeq ($(uname_S),MirBSD)
 	NO_STRCASESTR = YesPlease
@@ -236,6 +239,7 @@ ifeq ($(uname_S),NetBSD)
 	USE_ST_TIMESPEC = YesPlease
 	HAVE_PATHS_H = YesPlease
 	HAVE_BSD_SYSCTL = YesPlease
+	PROCFS_EXECUTABLE_PATH = /proc/curproc/exe
 endif
 ifeq ($(uname_S),AIX)
 	DEFAULT_PAGER = more
diff --git a/exec_cmd.c b/exec_cmd.c
index ce192a2d6..10ca7a75a 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -2,53 +2,187 @@
 #include "exec_cmd.h"
 #include "quote.h"
 #include "argv-array.h"
+
+#if defined(RUNTIME_PREFIX) && defined(HAVE_NS_GET_EXECUTABLE_PATH)
+#include <mach-o/dyld.h>
+#endif
+
 #define MAX_ARGS	32
 
 static const char *argv_exec_path;
 
+static const char *system_prefix(void);
+
 #ifdef RUNTIME_PREFIX
-static const char *argv0_path;
+
+/**
+ * When using a runtime prefix, Git dynamically resolves paths relative to its
+ * executable.
+ *
+ * The method for determining the path of the executable is highly
+ * platform-specific.
+ */
+
+/**
+ * Path to the current Git executable. Resolved on startup by
+ * 'git_resolve_executable_dir'.
+ */
+static const char *executable_dirname;
 
 static const char *system_prefix(void)
 {
 	static const char *prefix;
 
-	assert(argv0_path);
-	assert(is_absolute_path(argv0_path));
+	assert(executable_dirname);
+	assert(is_absolute_path(executable_dirname));
 
 	if (!prefix &&
-	    !(prefix = strip_path_suffix(argv0_path, GIT_EXEC_PATH)) &&
-	    !(prefix = strip_path_suffix(argv0_path, BINDIR)) &&
-	    !(prefix = strip_path_suffix(argv0_path, "git"))) {
+	    !(prefix = strip_path_suffix(executable_dirname, GIT_EXEC_PATH)) &&
+	    !(prefix = strip_path_suffix(executable_dirname, BINDIR)) &&
+	    !(prefix = strip_path_suffix(executable_dirname, "git"))) {
 		prefix = PREFIX;
 		trace_printf("RUNTIME_PREFIX requested, "
-				"but prefix computation failed.  "
-				"Using static fallback '%s'.\n", prefix);
+			     "but prefix computation failed.  "
+			     "Using static fallback '%s'.\n",
+			     prefix);
 	}
 	return prefix;
 }
 
-void git_extract_argv0_path(const char *argv0)
+/*
+ * Resolves the executable path from argv[0], only if it is absolute.
+ *
+ * Returns 0 on success, -1 on failure.
+ */
+static int git_get_exec_path_from_argv0(struct strbuf *buf, const char *argv0)
 {
 	const char *slash;
 
 	if (!argv0 || !*argv0)
-		return;
+		return -1;
 
 	slash = find_last_dir_sep(argv0);
+	if (slash) {
+		trace_printf("Determined executable path from argv0: %s\n",
+			     argv0);
+		strbuf_add_absolute_path(buf, argv0);
+		return 0;
+	}
+	return -1;
+}
+
+#ifdef PROCFS_EXECUTABLE_PATH
+/*
+ * Resolves the executable path by examining a procfs symlink.
+ *
+ * Returns 0 on success, -1 on failure.
+ */
+static int git_get_exec_path_procfs(struct strbuf *buf)
+{
+	char *path = realpath(PROCFS_EXECUTABLE_PATH, NULL);
+	if (path) {
+		trace_printf("Determined executable path from procfs: %s\n",
+			     path);
+		strbuf_addstr(buf, path);
+		free(path);
+		return 0;
+	}
+	return -1;
+}
+#endif /* PROCFS_EXECUTABLE_PATH */
+
+#ifdef HAVE_NS_GET_EXECUTABLE_PATH
+/*
+ * Resolves the executable path by querying Darwin applicaton stack.
+ *
+ * Returns 0 on success, -1 on failure.
+ */
+static int git_get_exec_path_darwin(struct strbuf *buf)
+{
+	char path[PATH_MAX];
+	uint32_t size = sizeof(path);
+	if (!_NSGetExecutablePath(path, &size)) {
+		trace_printf(
+			"Determined executable path from Darwin stack: %s\n",
+			path);
+		strbuf_addstr(buf, path);
+		return 0;
+	}
+	return -1;
+}
+#endif /* HAVE_NS_GET_EXECUTABLE_PATH */
+
+/*
+ * Resolves the absolute path of the current executable by employing
+ * one or more platform-specific methods.
+ *
+ * Returns 0 on success, -1 on failure.
+ */
+static int git_get_exec_path(struct strbuf *buf, const char *argv0)
+{
+	if (
+#ifdef PROCFS_EXECUTABLE_PATH
+		git_get_exec_path_procfs(buf) &&
+#endif /* PROCFS_EXECUTABLE_PATH */
+#ifdef HAVE_NS_GET_EXECUTABLE_PATH
+		git_get_exec_path_darwin(buf) &&
+#endif /* HAVE_NS_GET_EXECUTABLE_PATH */
+		git_get_exec_path_from_argv0(buf, argv0)) {
+		return -1;
+	}
+
+	if (strbuf_normalize_path(buf)) {
+		trace_printf("Could not normalize path: %s\n", buf->buf);
+		return -1;
+	}
+
+	return 0;
+}
+
+void git_resolve_executable_dir(const char *argv0)
+{
+	struct strbuf buf = STRBUF_INIT;
+	char *resolved;
+	const char *slash;
+	const char *path;
+
+	path = getenv(EXEC_PATH_ENVIRONMENT);
+	if (path) {
+		trace_printf("Determined executable path from ENV: %s\n", path);
+		executable_dirname = path;
+	} else {
+		if (git_get_exec_path(&buf, argv0)) {
+			trace_printf(
+				"Could not determine executable path from: %s\n",
+				argv0);
+			strbuf_release(&buf);
+			return;
+		}
+
+		resolved = strbuf_detach(&buf, NULL);
+		slash = find_last_dir_sep(resolved);
+		if (slash)
+			resolved[slash - resolved] = '\0';
+
+		executable_dirname = resolved;
+	}
 
-	if (slash)
-		argv0_path = xstrndup(argv0, slash - argv0);
+	trace_printf("Determined executable dir: %s\n", executable_dirname);
 }
 
 #else
 
+/**
+ * When not using a runtime prefix, Git uses a hard-coded path, and there is
+ * nothing to resolve.
+ */
+
 static const char *system_prefix(void)
 {
 	return PREFIX;
 }
 
-void git_extract_argv0_path(const char *argv0)
+void git_resolve_executable_dir(const char *argv0)
 {
 }
 
@@ -65,7 +199,7 @@ char *system_path(const char *path)
 	return strbuf_detach(&d, NULL);
 }
 
-void git_set_argv_exec_path(const char *exec_path)
+void git_set_exec_path(const char *exec_path)
 {
 	argv_exec_path = exec_path;
 	/*
@@ -74,7 +208,6 @@ void git_set_argv_exec_path(const char *exec_path)
 	setenv(EXEC_PATH_ENVIRONMENT, exec_path, 1);
 }
 
-
 /* Returns the highest-priority, location to look for git programs. */
 const char *git_exec_path(void)
 {
@@ -101,12 +234,14 @@ static void add_path(struct strbuf *out, const char *path)
 	}
 }
 
-void setup_path(void)
+void setup_path_and_env(void)
 {
+	const char *exec_path = git_exec_path();
 	const char *old_path = getenv("PATH");
 	struct strbuf new_path = STRBUF_INIT;
 
-	add_path(&new_path, git_exec_path());
+	git_set_exec_path(exec_path);
+	add_path(&new_path, exec_path);
 
 	if (old_path)
 		strbuf_addstr(&new_path, old_path);
@@ -116,6 +251,20 @@ void setup_path(void)
 	setenv("PATH", new_path.buf, 1);
 
 	strbuf_release(&new_path);
+
+	/*
+	 * If RUNTIME_PREFIX is set, the relative PERL library and locale paths
+	 * must be exported for invoked programs to inherit the calculated
+	 * runtime path.
+	 *
+	 * When RUNTIME_PREFIX is defined, Git's PERL include path is always
+	 * "$(PREFIX)/lib" (by setting NO_PERL_MAKEMAKER).
+	 */
+#ifdef RUNTIME_PREFIX
+	setenv(GIT_TEXT_DOMAIN_DIR_ENVIRONMENT, system_path(GIT_LOCALE_PATH),
+	       1);
+	setenv(GIT_PERL_LIB_ENVIRONMENT, system_path("lib"), 1);
+#endif /* RUNTIME_PREFIX */
 }
 
 const char **prepare_git_cmd(struct argv_array *out, const char **argv)
@@ -125,7 +274,8 @@ const char **prepare_git_cmd(struct argv_array *out, const char **argv)
 	return out->argv;
 }
 
-int execv_git_cmd(const char **argv) {
+int execv_git_cmd(const char **argv)
+{
 	struct argv_array nargv = ARGV_ARRAY_INIT;
 
 	prepare_git_cmd(&nargv, argv);
@@ -140,8 +290,7 @@ int execv_git_cmd(const char **argv) {
 	return -1;
 }
 
-
-int execl_git_cmd(const char *cmd,...)
+int execl_git_cmd(const char *cmd, ...)
 {
 	int argc;
 	const char *argv[MAX_ARGS + 1];
diff --git a/exec_cmd.h b/exec_cmd.h
index ff0b48048..490493745 100644
--- a/exec_cmd.h
+++ b/exec_cmd.h
@@ -3,10 +3,10 @@
 
 struct argv_array;
 
-extern void git_set_argv_exec_path(const char *exec_path);
-extern void git_extract_argv0_path(const char *path);
+extern void git_set_exec_path(const char *exec_path);
+extern void git_resolve_executable_dir(const char *path);
 extern const char *git_exec_path(void);
-extern void setup_path(void);
+extern void setup_path_and_env(void);
 extern const char **prepare_git_cmd(struct argv_array *out, const char **argv);
 extern int execv_git_cmd(const char **argv); /* NULL terminated */
 LAST_ARG_MUST_BE_NULL
diff --git a/gettext.c b/gettext.c
index db727ea02..f1c162cd8 100644
--- a/gettext.c
+++ b/gettext.c
@@ -2,7 +2,8 @@
  * Copyright (c) 2010 Ævar Arnfjörð Bjarmason
  */
 
-#include "git-compat-util.h"
+#include "cache.h"
+#include "exec_cmd.h"
 #include "gettext.h"
 #include "strbuf.h"
 #include "utf8.h"
@@ -157,10 +158,10 @@ static void init_gettext_charset(const char *domain)
 
 void git_setup_gettext(void)
 {
-	const char *podir = getenv("GIT_TEXTDOMAINDIR");
+	const char *podir = getenv(GIT_TEXT_DOMAIN_DIR_ENVIRONMENT);
 
 	if (!podir)
-		podir = GIT_LOCALE_PATH;
+		podir = system_path(GIT_LOCALE_PATH);
 	bindtextdomain("git", podir);
 	setlocale(LC_MESSAGES, "");
 	setlocale(LC_TIME, "");
diff --git a/git.c b/git.c
index 9e96dd409..f6336bca0 100644
--- a/git.c
+++ b/git.c
@@ -65,7 +65,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 		 */
 		if (skip_prefix(cmd, "--exec-path", &cmd)) {
 			if (*cmd == '=')
-				git_set_argv_exec_path(cmd + 1);
+				git_set_exec_path(cmd + 1);
 			else {
 				puts(git_exec_path());
 				exit(0);
@@ -676,8 +676,11 @@ int cmd_main(int argc, const char **argv)
 	 * precedence paths: the "--exec-path" option, the GIT_EXEC_PATH
 	 * environment, and the $(gitexecdir) from the Makefile at build
 	 * time.
+	 *
+	 * If RUNTIME_PREFIX is defined, we export some additional environment
+	 * variables to help subprocess code identify runtime-derived paths.
 	 */
-	setup_path();
+	setup_path_and_env();
 
 	while (1) {
 		int was_alias = run_argv(&argc, &argv);
diff --git a/http-backend.c b/http-backend.c
index f3dc218b2..200d4dc13 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -697,7 +697,7 @@ int cmd_main(int argc, const char **argv)
 	if (!cmd)
 		not_found(&hdr, "Request not supported: '%s'", dir);
 
-	setup_path();
+	setup_path_and_env();
 	if (!enter_repo(dir, 0))
 		not_found(&hdr, "Not a git repository: '%s'", dir);
 	if (!getenv("GIT_HTTP_EXPORT_ALL") &&
diff --git a/shell.c b/shell.c
index 234b2d4f1..82177f5bc 100644
--- a/shell.c
+++ b/shell.c
@@ -12,7 +12,7 @@ static int do_generic_cmd(const char *me, char *arg)
 {
 	const char *my_argv[4];
 
-	setup_path();
+	setup_path_and_env();
 	if (!arg || !(arg = sq_dequote(arg)) || *arg == '-')
 		die("bad argument");
 	if (!starts_with(me, "git-"))
diff --git a/upload-pack.c b/upload-pack.c
index 6d5f3c0d3..aa3d693ab 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1058,7 +1058,7 @@ int cmd_main(int argc, const char **argv)
 	if (timeout)
 		daemon_mode = 1;
 
-	setup_path();
+	setup_path_and_env();
 
 	dir = argv[0];
 
-- 
2.15.0.448.gf294e3d99a-goog

