Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD345202A0
	for <e@80x24.org>; Sun, 19 Nov 2017 17:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751088AbdKSRcF (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 12:32:05 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:45787 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751053AbdKSRcD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 12:32:03 -0500
Received: by mail-io0-f195.google.com with SMTP id z74so13474030iof.12
        for <git@vger.kernel.org>; Sun, 19 Nov 2017 09:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r+fRu6UYooLRQyH5Tsp6w06HCmFWoj+bXOIMmYlV3HE=;
        b=Xsx1feCgbfZpL4ajj2nbl69xS3Ic9nOKogrBUdl3y5cudL0eCESLYmPWlA04FTzQK6
         6WrxOOgdpB8TQqmte7o7uIZxOoFVpDlihfB+ro26LoyaUD1RXOXrc07qFsMEenOwg/tn
         rEeKZibwJdM0H3y0ULTcPTujYkxOF5oHL8DWllfcmVwH8NN7ZuZBplOOpacUdU7YeTAU
         YFYc6UIEe8anjntPdP6JMlEz6EFsULeIu+EhoiruMztzGYxO2qeK6vtTijHSOJetTPpq
         KrLso1ys/bu1AgWszUblS9Sa5rpZL775hNvj8B5ivC81kiIrIUaCuNE3D9RhtM6cuw5C
         rccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r+fRu6UYooLRQyH5Tsp6w06HCmFWoj+bXOIMmYlV3HE=;
        b=cGfaMLtHoN2Qwlik9KZEKgIcfAX8IGDZOtKmB7+dtTDizi6SZsi0su8Kw9Prmdowoz
         YjMzZGE+4DP6vUhawFRSEwGofyuFVLmOhNQ0fUWPo5gtZmrpOZQQgzCMxV1UF1khclGG
         AoR10DzcLhEsLlrAUEzzZh2ge4RZeWu8oBZeUbicVAEyyEHIFsQ+NaPajMH+rFw3EUxX
         M4OgD+1Ta0vieqDvgBZPzBx13Rv3PerHQcqay9DfULS3Cg1dnaMjRzuL+WGo5dsOrh6o
         N/ueJGTDOXf7Jsziy4PrckjHBNKyRzv2KYcf8fqaBZ1gPv9PtqpXNfEl7bInHjOIytin
         tTTg==
X-Gm-Message-State: AJaThX50CmLb4QXoLwS0JR7baIrld8/qIvpjoAzhXhdQRKGPsT43jX/x
        pO+n9lm5f6g6yUHeLy2/NFIPldwU0lg=
X-Google-Smtp-Source: AGs4zMahoYcanMqTbL+7ObpetVrW25wPQiyVU/0uOOsiW8DdI8yTbe/1tuTZgGI06rJwob4sgs8ibg==
X-Received: by 10.107.53.98 with SMTP id c95mr10870988ioa.199.1511112721483;
        Sun, 19 Nov 2017 09:32:01 -0800 (PST)
Received: from dnj.pit.corp.google.com ([2620:0:1019:0:5840:7173:18ff:ed41])
        by smtp.gmail.com with ESMTPSA id h187sm438573ioe.17.2017.11.19.09.32.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Nov 2017 09:32:00 -0800 (PST)
From:   Dan Jacques <dnj@google.com>
To:     git@vger.kernel.org
Cc:     Dan Jacques <dnj@google.com>
Subject: [PATCH 1/1] exec_cmd: RUNTIME_PREFIX on some POSIX systems
Date:   Sun, 19 Nov 2017 12:31:41 -0500
Message-Id: <20171119173141.4896-2-dnj@google.com>
X-Mailer: git-send-email 2.15.0.170.gd77a2c32b
In-Reply-To: <20171119173141.4896-1-dnj@google.com>
References: <20171119173141.4896-1-dnj@google.com>
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
- KERN_PROC_PATHNAME sysctl on BSDs.
- argv0, if absolute (all, including Windows).

This is used to enable RUNTIME_PREFIX support for non-Windows systems,
notably Linux and Darwin. When configured with RUNTIME_PREFIX, Git will
do a best-effort resolution of its executable path and automatically use
this as its "exec_path" for relative helper and data lookups, unless
explicitly overridden.

Git's PERL tooling now responds to RUNTIME_PREFIX_PERL. When configured,
Git's generated PERL scripts resolve the Git library location relative to
their runtime paths instead of hard-coding them. Structural changes
were made to Makefile to support selective PERL header generation.

Small incidental formatting cleanup of "exec_cmd.c".

Signed-off-by: Dan Jacques <dnj@google.com>
---
 .gitignore       |   1 +
 Makefile         |  88 +++++++++++++++++---
 cache.h          |   1 +
 common-main.c    |   4 +-
 config.mak.uname |   7 ++
 exec_cmd.c       | 239 +++++++++++++++++++++++++++++++++++++++++++++++--------
 exec_cmd.h       |   4 +-
 gettext.c        |   8 +-
 git.c            |   2 +-
 9 files changed, 304 insertions(+), 50 deletions(-)

diff --git a/.gitignore b/.gitignore
index 833ef3b0b..89bd7bd8a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -3,6 +3,7 @@
 /GIT-LDFLAGS
 /GIT-PREFIX
 /GIT-PERL-DEFINES
+/GIT-PERL-HEADER
 /GIT-PYTHON-VARS
 /GIT-SCRIPT-DEFINES
 /GIT-USER-AGENT
diff --git a/Makefile b/Makefile
index ee9d5eb11..6fddb8b8f 100644
--- a/Makefile
+++ b/Makefile
@@ -296,7 +296,8 @@ all::
 # Define PERL_PATH to the path of your Perl binary (usually /usr/bin/perl).
 #
 # Define NO_PERL_MAKEMAKER if you cannot use Makefiles generated by perl's
-# MakeMaker (e.g. using ActiveState under Cygwin).
+# MakeMaker (e.g. using ActiveState under Cygwin). NO_PERL_MAKEMAKER is
+# automatically enabled when using RUNTIME_PREFIX_PERL.
 #
 # Define NO_PERL if you do not want Perl scripts or libraries at all.
 #
@@ -416,6 +417,16 @@ all::
 #
 # Define HAVE_BSD_SYSCTL if your platform has a BSD-compatible sysctl function.
 #
+# Define HAVE_BSD_KERN_PROC_SYSCTL if your platform supports the KERN_PROC BSD
+# sysctl function.
+#
+# Define PROCFS_EXECUTABLE_PATH if your platform mounts a "procfs" filesystem
+# capable of resolving the path of the current executable. If defined, this
+# must be the canonical path for the "procfs" current executable path.
+#
+# Define HAVE_NS_GET_EXECUTABLE_PATH if your platform supports calling
+# _NSGetExecutablePath to retrieve the path of the running executable.
+#
 # Define HAVE_GETDELIM if your system has the getdelim() function.
 #
 # Define PAGER_ENV to a SP separated VAR=VAL pairs to define
@@ -425,6 +436,16 @@ all::
 #
 # to say "export LESS=FRX (and LV=-c) if the environment variable
 # LESS (and LV) is not set, respectively".
+#
+# Define RUNTIME_PREFIX to configure Git to resolve its ancillary tooling and
+# support files relative to the location of the runtime binary, rather than
+# hard-coding them into the binary. Git installations built with RUNTIME_PREFIX
+# can be moved to arbitrary filesystem locations. Users may want to enable
+# RUNTIME_PREFIX_PERL as well (see below).
+#
+# Define RUNTIME_PREFIX_PERL to configure Git's PERL commands to locate Git
+# support libraries relative to their filesystem path instead of hard-coding
+# it. RUNTIME_PREFIX_PERL also sets NO_PERL_MAKEMAKER.
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -462,6 +483,7 @@ ARFLAGS = rcs
 #   mandir
 #   infodir
 #   htmldir
+#   localedir
 # This can help installing the suite in a relocatable way.
 
 prefix = $(HOME)
@@ -485,6 +507,7 @@ pathsep = :
 mandir_relative = $(patsubst $(prefix)/%,%,$(mandir))
 infodir_relative = $(patsubst $(prefix)/%,%,$(infodir))
 htmldir_relative = $(patsubst $(prefix)/%,%,$(htmldir))
+localedir_relative = $(patsubst $(prefix)/%,%,$(localedir))
 
 export prefix bindir sharedir sysconfdir gitwebdir localedir
 
@@ -1522,9 +1545,6 @@ ifdef SHA1_MAX_BLOCK_SIZE
 	LIB_OBJS += compat/sha1-chunked.o
 	BASIC_CFLAGS += -DSHA1_MAX_BLOCK_SIZE="$(SHA1_MAX_BLOCK_SIZE)"
 endif
-ifdef NO_PERL_MAKEMAKER
-	export NO_PERL_MAKEMAKER
-endif
 ifdef NO_HSTRERROR
 	COMPAT_CFLAGS += -DNO_HSTRERROR
 	COMPAT_OBJS += compat/hstrerror.o
@@ -1549,6 +1569,15 @@ ifdef RUNTIME_PREFIX
 	COMPAT_CFLAGS += -DRUNTIME_PREFIX
 endif
 
+ifdef RUNTIME_PREFIX_PERL
+	# Control PERL library location so its paths and contents are not dependent on
+	# the host's PERL version. See perl/Makefile for more information.
+	NO_PERL_MAKEMAKER = YesPlease
+endif
+ifdef NO_PERL_MAKEMAKER
+	export NO_PERL_MAKEMAKER
+endif
+
 ifdef NO_PTHREADS
 	BASIC_CFLAGS += -DNO_PTHREADS
 else
@@ -1628,10 +1657,23 @@ ifdef HAVE_BSD_SYSCTL
 	BASIC_CFLAGS += -DHAVE_BSD_SYSCTL
 endif
 
+ifdef HAVE_BSD_KERN_PROC_SYSCTL
+	BASIC_CFLAGS += -DHAVE_BSD_KERN_PROC_SYSCTL
+endif
+
 ifdef HAVE_GETDELIM
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
@@ -1714,6 +1756,7 @@ bindir_relative_SQ = $(subst ','\'',$(bindir_relative))
 mandir_relative_SQ = $(subst ','\'',$(mandir_relative))
 infodir_relative_SQ = $(subst ','\'',$(infodir_relative))
 localedir_SQ = $(subst ','\'',$(localedir))
+localedir_relative_SQ = $(subst ','\'',$(localedir_relative))
 gitexecdir_SQ = $(subst ','\'',$(gitexecdir))
 template_dir_SQ = $(subst ','\'',$(template_dir))
 htmldir_relative_SQ = $(subst ','\'',$(htmldir_relative))
@@ -1962,17 +2005,16 @@ perl/perl.mak: GIT-CFLAGS GIT-PREFIX perl/Makefile perl/Makefile.PL
 	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' $(@F)
 
 PERL_DEFINES = $(PERL_PATH_SQ):$(PERLLIB_EXTRA_SQ)
-$(SCRIPT_PERL_GEN): % : %.perl perl/perl.mak GIT-PERL-DEFINES GIT-VERSION-FILE
+
+$(SCRIPT_PERL_GEN): % : %.perl perl/perl.mak GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C perl -s --no-print-directory instlibdir` && \
 	INSTLIBDIR_EXTRA='$(PERLLIB_EXTRA_SQ)' && \
 	INSTLIBDIR="$$INSTLIBDIR$${INSTLIBDIR_EXTRA:+:$$INSTLIBDIR_EXTRA}" && \
 	sed -e '1{' \
 	    -e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
-	    -e '	h' \
-	    -e '	s=.*=use lib (split(/$(pathsep)/, $$ENV{GITPERLLIB} || "'"$$INSTLIBDIR"'"));=' \
-	    -e '	H' \
-	    -e '	x' \
+	    -e '	rGIT-PERL-HEADER' \
+	    -e '	G' \
 	    -e '}' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    $< >$@+ && \
@@ -1986,6 +2028,29 @@ GIT-PERL-DEFINES: FORCE
 		echo "$$FLAGS" >$@; \
 	    fi
 
+GIT-PERL-HEADER: perl/perl.mak GIT-PERL-DEFINES FORCE
+ifndef RUNTIME_PREFIX_PERL
+	# Hardcode the runtime path.
+	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C perl -s --no-print-directory instlibdir` && \
+	INSTLIBDIR_EXTRA='$(PERLLIB_EXTRA_SQ)' && \
+	echo \
+	  'use lib (split(/$(pathsep)/, $$ENV{GITPERLLIB} || "'"$$INSTLIBDIR"'"));' \
+	  >$@
+else
+	# Probe the runtime path relative to the PERL script. RUNTIME_PREFIX_PERL
+	# automatically sets NO_PERL_MAKEMAKER, causing PERL scripts to be installed
+	# to "$(prefix)/lib" (see "perl/Makefile"). This expectation is hard-coded
+	# into the generated code below.
+	GITEXECDIR='$(gitexecdir_SQ)' && \
+	echo \
+	  'sub _get_git_lib{'\
+	  'use FindBin;'\
+	  '(my $$p=$$FindBin::Bin)=~s=/'$${GITEXECDIR}'$$==;'\
+		'return File::Spec->catdir($$p,"'"lib"'");' \
+	  '};' \
+	  'use lib (split(/$(pathsep)/, $$ENV{GITPERLLIB}||_get_git_lib()));'\
+	  >$@
+endif
 
 .PHONY: gitweb
 gitweb:
@@ -2130,6 +2195,7 @@ endif
 exec_cmd.sp exec_cmd.s exec_cmd.o: GIT-PREFIX
 exec_cmd.sp exec_cmd.s exec_cmd.o: EXTRA_CPPFLAGS = \
 	'-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' \
+	'-DGIT_LOCALE_PATH="$(localedir_relative_SQ)"' \
 	'-DBINDIR="$(bindir_relative_SQ)"' \
 	'-DPREFIX="$(prefix_SQ)"'
 
@@ -2147,7 +2213,7 @@ attr.sp attr.s attr.o: EXTRA_CPPFLAGS = \
 
 gettext.sp gettext.s gettext.o: GIT-PREFIX
 gettext.sp gettext.s gettext.o: EXTRA_CPPFLAGS = \
-	-DGIT_LOCALE_PATH='"$(localedir_SQ)"'
+	-DGIT_LOCALE_PATH='"$(localedir_relative_SQ)"'
 
 http-push.sp http.sp http-walker.sp remote-curl.sp imap-send.sp: SPARSE_FLAGS += \
 	-DCURL_DISABLE_TYPECHECK
@@ -2704,7 +2770,7 @@ ifndef NO_TCLTK
 endif
 	$(RM) GIT-VERSION-FILE GIT-CFLAGS GIT-LDFLAGS GIT-BUILD-OPTIONS
 	$(RM) GIT-USER-AGENT GIT-PREFIX
-	$(RM) GIT-SCRIPT-DEFINES GIT-PERL-DEFINES GIT-PYTHON-VARS
+	$(RM) GIT-SCRIPT-DEFINES GIT-PERL-DEFINES GIT-PERL-HEADER GIT-PYTHON-VARS
 
 .PHONY: all install profile-clean clean strip
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
diff --git a/cache.h b/cache.h
index cb7fb7c00..fb7795410 100644
--- a/cache.h
+++ b/cache.h
@@ -445,6 +445,7 @@ static inline enum object_type object_type(unsigned int mode)
 #define GIT_ICASE_PATHSPECS_ENVIRONMENT "GIT_ICASE_PATHSPECS"
 #define GIT_QUARANTINE_ENVIRONMENT "GIT_QUARANTINE_PATH"
 #define GIT_OPTIONAL_LOCKS_ENVIRONMENT "GIT_OPTIONAL_LOCKS"
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
index 685a80d13..58fd62b4d 100644
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
@@ -206,6 +208,7 @@ ifeq ($(uname_S),FreeBSD)
 	HAVE_PATHS_H = YesPlease
 	GMTIME_UNRELIABLE_ERRORS = UnfortunatelyYes
 	HAVE_BSD_SYSCTL = YesPlease
+	HAVE_BSD_KERN_PROC_SYSCTL = YesPlease
 	PAGER_ENV = LESS=FRX LV=-c MORE=FRX
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 endif
@@ -218,6 +221,8 @@ ifeq ($(uname_S),OpenBSD)
 	BASIC_LDFLAGS += -L/usr/local/lib
 	HAVE_PATHS_H = YesPlease
 	HAVE_BSD_SYSCTL = YesPlease
+	HAVE_BSD_KERN_PROC_SYSCTL = YesPlease
+	PROCFS_EXECUTABLE_PATH = /proc/curproc/file
 endif
 ifeq ($(uname_S),MirBSD)
 	NO_STRCASESTR = YesPlease
@@ -236,6 +241,8 @@ ifeq ($(uname_S),NetBSD)
 	USE_ST_TIMESPEC = YesPlease
 	HAVE_PATHS_H = YesPlease
 	HAVE_BSD_SYSCTL = YesPlease
+	HAVE_BSD_KERN_PROC_SYSCTL = YesPlease
+	PROCFS_EXECUTABLE_PATH = /proc/curproc/exe
 endif
 ifeq ($(uname_S),AIX)
 	DEFAULT_PAGER = more
diff --git a/exec_cmd.c b/exec_cmd.c
index ce192a2d6..c9006c4c9 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -2,53 +2,232 @@
 #include "exec_cmd.h"
 #include "quote.h"
 #include "argv-array.h"
-#define MAX_ARGS	32
 
-static const char *argv_exec_path;
+#if defined(RUNTIME_PREFIX)
+
+#if defined(HAVE_NS_GET_EXECUTABLE_PATH)
+#include <mach-o/dyld.h>
+#endif
+
+#if defined(HAVE_BSD_KERN_PROC_SYSCTL)
+#include <sys/param.h>
+#include <sys/types.h>
+#include <sys/sysctl.h>
+#endif
+
+#endif /* RUNTIME_PREFIX */
+
+#define MAX_ARGS 32
+
+static const char *system_prefix(void);
 
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
+		trace_printf("trace: resolved executable path from argv0: %s\n",
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
+	if (strbuf_realpath(buf, PROCFS_EXECUTABLE_PATH, 0)) {
+		trace_printf(
+			"trace: resolved executable path from procfs: %s\n",
+			buf->buf);
+		return 0;
+	}
+	return -1;
+}
+#endif /* PROCFS_EXECUTABLE_PATH */
+
+#ifdef HAVE_BSD_KERN_PROC_SYSCTL
+/*
+ * Resolves the executable path using KERN_PROC_PATHNAME BSD sysctl.
+ *
+ * Returns 0 on success, -1 on failure.
+ */
+static int git_get_exec_path_bsd_sysctl(struct strbuf *buf)
+{
+	int mib[4];
+	char path[MAXPATHLEN];
+	size_t cb = sizeof(path);
+
+	mib[0] = CTL_KERN;
+	mib[1] = KERN_PROC;
+	mib[2] = KERN_PROC_PATHNAME;
+	mib[3] = -1;
+	if (!sysctl(mib, 4, path, &cb, NULL, 0)) {
+		trace_printf(
+			"trace: resolved executable path from sysctl: %s\n",
+			path);
+		strbuf_addstr(buf, path);
+		return 0;
+	}
+	return -1;
+}
+#endif /* HAVE_BSD_KERN_PROC_SYSCTL */
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
+			"trace: resolved executable path from Darwin stack: %s\n",
+			path);
+		strbuf_addstr(buf, path);
+		return 0;
+	}
+	return -1;
+}
+#endif /* HAVE_NS_GET_EXECUTABLE_PATH */
+
+/*
+ * Resolves the absolute path of the current executable.
+ *
+ * Returns 0 on success, -1 on failure.
+ */
+static int git_get_exec_path(struct strbuf *buf, const char *argv0)
+{
+	/*
+	 * Identifying the executable path is operating system specific.
+	 * Selectively employ all available methods in order of preference,
+	 * preferring highly-available authoratative methods over
+	 * selectively-available or non- authoratative methods.
+	 *
+	 * All cases fall back on resolving against argv[0] if there isn't a
+	 * better functional method. However, note that argv[0] can be
+	 * used-supplied on many operating sysetems, and is not authoratative
+	 * in those cases.
+	 *
+	 * Each of these functions returns 0 on success, so evaluation will stop
+	 * after the first successful method.
+	 */
+	if (
+#ifdef HAVE_BSD_KERN_PROC_SYSCTL
+		git_get_exec_path_bsd_sysctl(buf) &&
+#endif /* HAVE_BSD_KERN_PROC_SYSCTL */
+
+#ifdef HAVE_NS_GET_EXECUTABLE_PATH
+		git_get_exec_path_darwin(buf) &&
+#endif /* HAVE_NS_GET_EXECUTABLE_PATH */
+
+#ifdef PROCFS_EXECUTABLE_PATH
+		git_get_exec_path_procfs(buf) &&
+#endif /* PROCFS_EXECUTABLE_PATH */
+
+		git_get_exec_path_from_argv0(buf, argv0)) {
+		return -1;
+	}
 
+	if (strbuf_normalize_path(buf)) {
+		trace_printf("trace: could not normalize path: %s\n", buf->buf);
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
+
+	if (git_get_exec_path(&buf, argv0)) {
+		trace_printf(
+			"trace: could not determine executable path from: %s\n",
+			argv0);
+		strbuf_release(&buf);
+		return;
+	}
+
+	resolved = strbuf_detach(&buf, NULL);
+	slash = find_last_dir_sep(resolved);
 	if (slash)
-		argv0_path = xstrndup(argv0, slash - argv0);
+		resolved[slash - resolved] = '\0';
+
+	executable_dirname = resolved;
+	trace_printf("trace: resolved executable dir: %s\n",
+		     executable_dirname);
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
 
@@ -65,32 +244,28 @@ char *system_path(const char *path)
 	return strbuf_detach(&d, NULL);
 }
 
-void git_set_argv_exec_path(const char *exec_path)
+static const char *exec_path_value;
+
+void git_set_exec_path(const char *exec_path)
 {
-	argv_exec_path = exec_path;
+	exec_path_value = exec_path;
 	/*
 	 * Propagate this setting to external programs.
 	 */
 	setenv(EXEC_PATH_ENVIRONMENT, exec_path, 1);
 }
 
-
-/* Returns the highest-priority, location to look for git programs. */
+/* Returns the highest-priority location to look for git programs. */
 const char *git_exec_path(void)
 {
-	static char *cached_exec_path;
-
-	if (argv_exec_path)
-		return argv_exec_path;
-
-	if (!cached_exec_path) {
+	if (!exec_path_value) {
 		const char *env = getenv(EXEC_PATH_ENVIRONMENT);
 		if (env && *env)
-			cached_exec_path = xstrdup(env);
+			exec_path_value = xstrdup(env);
 		else
-			cached_exec_path = system_path(GIT_EXEC_PATH);
+			exec_path_value = system_path(GIT_EXEC_PATH);
 	}
-	return cached_exec_path;
+	return exec_path_value;
 }
 
 static void add_path(struct strbuf *out, const char *path)
@@ -103,10 +278,12 @@ static void add_path(struct strbuf *out, const char *path)
 
 void setup_path(void)
 {
+	const char *exec_path = git_exec_path();
 	const char *old_path = getenv("PATH");
 	struct strbuf new_path = STRBUF_INIT;
 
-	add_path(&new_path, git_exec_path());
+	git_set_exec_path(exec_path);
+	add_path(&new_path, exec_path);
 
 	if (old_path)
 		strbuf_addstr(&new_path, old_path);
@@ -125,7 +302,8 @@ const char **prepare_git_cmd(struct argv_array *out, const char **argv)
 	return out->argv;
 }
 
-int execv_git_cmd(const char **argv) {
+int execv_git_cmd(const char **argv)
+{
 	struct argv_array nargv = ARGV_ARRAY_INIT;
 
 	prepare_git_cmd(&nargv, argv);
@@ -140,8 +318,7 @@ int execv_git_cmd(const char **argv) {
 	return -1;
 }
 
-
-int execl_git_cmd(const char *cmd,...)
+int execl_git_cmd(const char *cmd, ...)
 {
 	int argc;
 	const char *argv[MAX_ARGS + 1];
diff --git a/exec_cmd.h b/exec_cmd.h
index ff0b48048..2522453cd 100644
--- a/exec_cmd.h
+++ b/exec_cmd.h
@@ -3,8 +3,8 @@
 
 struct argv_array;
 
-extern void git_set_argv_exec_path(const char *exec_path);
-extern void git_extract_argv0_path(const char *path);
+extern void git_set_exec_path(const char *exec_path);
+extern void git_resolve_executable_dir(const char *path);
 extern const char *git_exec_path(void);
 extern void setup_path(void);
 extern const char **prepare_git_cmd(struct argv_array *out, const char **argv);
diff --git a/gettext.c b/gettext.c
index db727ea02..6b64d5c2e 100644
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
@@ -157,10 +158,11 @@ static void init_gettext_charset(const char *domain)
 
 void git_setup_gettext(void)
 {
-	const char *podir = getenv("GIT_TEXTDOMAINDIR");
+	const char *podir = getenv(GIT_TEXT_DOMAIN_DIR_ENVIRONMENT);
 
 	if (!podir)
-		podir = GIT_LOCALE_PATH;
+		podir = system_path(GIT_LOCALE_PATH);
+
 	bindtextdomain("git", podir);
 	setlocale(LC_MESSAGES, "");
 	setlocale(LC_TIME, "");
diff --git a/git.c b/git.c
index 9e96dd409..dc4cc1419 100644
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
-- 
2.15.0.448.gf294e3d99a-goog

