Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493EA1FBC8C
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 08:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738569843; cv=none; b=oyHdrw8jbUDze9iFpSem1iurFEVOZw54dlLTQkVXzVBVzyFe0Z63bK6s/AbAYMHuWV3RnXoTASzyMGPt4mSfH/G7p9GudKoCodogmetry/exzIo7new+ohDRiRFFUj5hMnAfC9JY+Cu5doVMHLDRIkXD2gdfpsRPoA0enBxnLuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738569843; c=relaxed/simple;
	bh=wXfxzp1lfrgtA7UuRHsOxQtcIpvK6H1D5visXvFGehU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KoygdEKajN6ivHerjnZVna7A/3uWn/VhwGAEGeGQGsj0hqncDuLm1rII3ps1lNfS2/jPntlMcVDzazxflh7cegH/MyvgIyI32UWZxLsskQVxyB2Pz6Q2YDZ7BURR8vD4EosJv8BVo/5yBxWzrLmAt3KBlY98xRGGjwCokx8WmXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=op3Q5PqQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SVdLet3A; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="op3Q5PqQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SVdLet3A"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 83328138009C;
	Mon,  3 Feb 2025 03:04:00 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 03 Feb 2025 03:04:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738569840;
	 x=1738656240; bh=RstHdj3gJVi3HiMUiDp8VN6a4o/MhLxIxSQSkfuFou0=; b=
	op3Q5PqQHs7yspxI8zLfV/uLfO8auPk4VuamsBWOcDHwfXMFAuZWziVQ3JteWPdt
	RPfY1NmjMUyzWth9lOfzcv27Llke0DcG0QkHT39QsWiEkZYIsDeS1Mg7/1G9LcSJ
	evR96A7ilGAix14gBVdAk22NNA4R/bNmVlbdIzq6o/BuznV7w8Wfzk0OnynVYooE
	taDab2Aha1G7MUPTR3OeWxG86uGIE2qimd27LFccfk77IGnhRlZ4LG3oUzOJAu7o
	qgLeH95JL3v4BpoYV9HDb8p0CE5qWbaPZfk6kKYFWmQik/fE1wydqVXRgV7l3M8f
	o/xsUQhv02Y8bpPrClbGmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738569840; x=
	1738656240; bh=RstHdj3gJVi3HiMUiDp8VN6a4o/MhLxIxSQSkfuFou0=; b=S
	VdLet3A9qjPMbUO2z1uQl7YEu3jlEB2FhWQ5ALTS4fqjTriwR1yHuCbxpoK86O5m
	v//WXtpwQHcnOCOtD+fHHr0sST5+Kp6xJp1j+VqegaG5GO8g3pVi53LlBqGB7mPD
	Ie9aHdQE+s6Chi9SYYPdejht9zlU5eclaI6dlxdrxEqI6XOxaWazYaOCpBeeybdm
	YMToomjE/yEqAB7evrwToagRCB7cGpmOijX68TBspt4KgOBc74j3HpDoyuUoubun
	k3d/GJHY+Glu1mt7SOXm482+AKTSHB1XGnpsxEieU9M8yeUw/OEk50Qlj6RBrNqm
	RsslYm7cBh9U1lohy1LGw==
X-ME-Sender: <xms:cHigZ83QaOMQay1qvNnOMqjZFMnJnog2iocsjv5u21dQvYeZjOdeYg>
    <xme:cHigZ3ExK4of-D-S5VbYdtS_KPUohlPhP92bPY4H-THwUspHGF8pNc1wGGVmRsShB
    axKRVNeN4lXjZhUjA>
X-ME-Received: <xmr:cHigZ07rWyxkj-FWA-dYxfMGATUQPCuXqV7nnCBPNmeGL3T4RIQ1S8vqlMm6xXtmBk6m_RzFOADIBLGuj9f-TU3ZSziQulTk7jvyawz5ijapGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepvght
    hhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohepjhhlth
    hosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:cHigZ12wVk0acKEZ-rvMZRwFS22H1Z5byOD_nQuyna6VuXtiJeem7Q>
    <xmx:cHigZ_FpXEiQAge5591ibhLip-ONyp6OB5eKA93IWmrWBSbo_vp0Tg>
    <xmx:cHigZ-89mv-pfDY2c0JEhCeLelDSy42WkXbhrW797C_wxHMyLy5Olg>
    <xmx:cHigZ0mqQjXavXyxlMd9IsJB8GVtUlT-AkiWCMKdLoq-2wJLJX_CCg>
    <xmx:cHigZzjZ2Y2jry3XBjthugOrPiHMiqDLm--Dh10Lrnmb0dBmhqQsvOLM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 03:03:59 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dd0a1b23 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 08:03:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Feb 2025 09:03:47 +0100
Subject: [PATCH v3 16/18] git-compat-util.h: split out POSIX-emulating bits
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250203-pks-reftable-drop-git-compat-util-v3-16-446c9ed4ee9e@pks.im>
References: <20250203-pks-reftable-drop-git-compat-util-v3-0-446c9ed4ee9e@pks.im>
In-Reply-To: <20250203-pks-reftable-drop-git-compat-util-v3-0-446c9ed4ee9e@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The "git-compat-util.h" header is a treasure trove of various bits and
pieces used throughout the project. It basically mixes two different
things into one:

  - Providing a POSIX-like interface even on platforms that aren't
    POSIX-compliant.

  - Providing low-level functionality that is specific to Git.

This intermixing is a bit of a problem for the reftable library as we
don't want to recreate the POSIX-like interface there. But neither do we
want to pull in the Git-specific functionality, as it is otherwise quite
easy to start depending on the Git codebase again.

Split out a new header "compat/posix.h" that only contains the bits and
pieces relevant for the emulation of POSIX, which we will start using in
the next commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 compat/posix.h    | 541 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 git-compat-util.h | 531 +----------------------------------------------------
 2 files changed, 543 insertions(+), 529 deletions(-)

diff --git a/compat/posix.h b/compat/posix.h
new file mode 100644
index 0000000000..8aa41f7183
--- /dev/null
+++ b/compat/posix.h
@@ -0,0 +1,541 @@
+#ifndef COMPAT_POSIX_H
+#define COMPAT_POSIX_H
+
+#define _FILE_OFFSET_BITS 64
+
+/*
+ * Derived from Linux "Features Test Macro" header
+ * Convenience macros to test the versions of gcc (or
+ * a compatible compiler).
+ * Use them like this:
+ *  #if GIT_GNUC_PREREQ (2,8)
+ *   ... code requiring gcc 2.8 or later ...
+ *  #endif
+ *
+ * This macro of course is not part of POSIX, but we need it for the UNUSED
+ * macro which is used by some of our POSIX compatibility wrappers.
+*/
+#if defined(__GNUC__) && defined(__GNUC_MINOR__)
+# define GIT_GNUC_PREREQ(maj, min) \
+	((__GNUC__ << 16) + __GNUC_MINOR__ >= ((maj) << 16) + (min))
+#else
+ #define GIT_GNUC_PREREQ(maj, min) 0
+#endif
+
+/*
+ * UNUSED marks a function parameter that is always unused.  It also
+ * can be used to annotate a function, a variable, or a type that is
+ * always unused.
+ *
+ * A callback interface may dictate that a function accepts a
+ * parameter at that position, but the implementation of the function
+ * may not need to use the parameter.  In such a case, mark the parameter
+ * with UNUSED.
+ *
+ * When a parameter may be used or unused, depending on conditional
+ * compilation, consider using MAYBE_UNUSED instead.
+ */
+#if GIT_GNUC_PREREQ(4, 5)
+#define UNUSED __attribute__((unused)) \
+	__attribute__((deprecated ("parameter declared as UNUSED")))
+#elif defined(__GNUC__)
+#define UNUSED __attribute__((unused)) \
+	__attribute__((deprecated))
+#else
+#define UNUSED
+#endif
+
+#ifdef __MINGW64__
+#define _POSIX_C_SOURCE 1
+#elif defined(__sun__)
+ /*
+  * On Solaris, when _XOPEN_EXTENDED is set, its header file
+  * forces the programs to be XPG4v2, defeating any _XOPEN_SOURCE
+  * setting to say we are XPG5 or XPG6.  Also on Solaris,
+  * XPG6 programs must be compiled with a c99 compiler, while
+  * non XPG6 programs must be compiled with a pre-c99 compiler.
+  */
+# if __STDC_VERSION__ - 0 >= 199901L
+# define _XOPEN_SOURCE 600
+# else
+# define _XOPEN_SOURCE 500
+# endif
+#elif !defined(__APPLE__) && !defined(__FreeBSD__) && !defined(__USLC__) && \
+      !defined(_M_UNIX) && !defined(__sgi) && !defined(__DragonFly__) && \
+      !defined(__TANDEM) && !defined(__QNX__) && !defined(__MirBSD__) && \
+      !defined(__CYGWIN__)
+#define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
+#define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
+#endif
+#define _ALL_SOURCE 1
+#define _GNU_SOURCE 1
+#define _BSD_SOURCE 1
+#define _DEFAULT_SOURCE 1
+#define _NETBSD_SOURCE 1
+#define _SGI_SOURCE 1
+
+#if defined(WIN32) && !defined(__CYGWIN__) /* Both MinGW and MSVC */
+# if !defined(_WIN32_WINNT)
+#  define _WIN32_WINNT 0x0600
+# endif
+#define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
+#include <winsock2.h>
+#ifndef NO_UNIX_SOCKETS
+#include <afunix.h>
+#endif
+#include <windows.h>
+#define GIT_WINDOWS_NATIVE
+#endif
+
+#include <unistd.h>
+#include <stdio.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <stddef.h>
+#include <stdlib.h>
+#include <stdarg.h>
+#include <stdbool.h>
+#include <string.h>
+#ifdef HAVE_STRINGS_H
+#include <strings.h> /* for strcasecmp() */
+#endif
+#include <errno.h>
+#include <limits.h>
+#include <locale.h>
+#ifdef NEEDS_SYS_PARAM_H
+#include <sys/param.h>
+#endif
+#include <sys/types.h>
+#include <dirent.h>
+#include <sys/time.h>
+#include <time.h>
+#include <signal.h>
+#include <assert.h>
+#include <regex.h>
+#include <utime.h>
+#include <syslog.h>
+#if !defined(NO_POLL_H)
+#include <poll.h>
+#elif !defined(NO_SYS_POLL_H)
+#include <sys/poll.h>
+#else
+/* Pull the compat stuff */
+#include <poll.h>
+#endif
+#ifdef HAVE_BSD_SYSCTL
+#include <sys/sysctl.h>
+#endif
+
+#if defined(__MINGW32__)
+#include "mingw/posix.h"
+#elif defined(_MSC_VER)
+#include "msvc/posix.h"
+#else
+#include <sys/utsname.h>
+#include <sys/wait.h>
+#include <sys/resource.h>
+#include <sys/socket.h>
+#include <sys/ioctl.h>
+#include <sys/statvfs.h>
+#include <termios.h>
+#ifndef NO_SYS_SELECT_H
+#include <sys/select.h>
+#endif
+#include <netinet/in.h>
+#include <netinet/tcp.h>
+#include <arpa/inet.h>
+#include <netdb.h>
+#include <pwd.h>
+#include <sys/un.h>
+#ifndef NO_INTTYPES_H
+#include <inttypes.h>
+#else
+#include <stdint.h>
+#endif
+#ifdef HAVE_ARC4RANDOM_LIBBSD
+#include <bsd/stdlib.h>
+#endif
+#ifdef HAVE_GETRANDOM
+#include <sys/random.h>
+#endif
+#ifdef NO_INTPTR_T
+/*
+ * On I16LP32, ILP32 and LP64 "long" is the safe bet, however
+ * on LLP86, IL33LLP64 and P64 it needs to be "long long",
+ * while on IP16 and IP16L32 it is "int" (resp. "short")
+ * Size needs to match (or exceed) 'sizeof(void *)'.
+ * We can't take "long long" here as not everybody has it.
+ */
+typedef long intptr_t;
+typedef unsigned long uintptr_t;
+#endif
+#undef _ALL_SOURCE /* AIX 5.3L defines a struct list with _ALL_SOURCE. */
+#include <grp.h>
+#define _ALL_SOURCE 1
+#endif
+
+#ifdef MKDIR_WO_TRAILING_SLASH
+#define mkdir(a,b) compat_mkdir_wo_trailing_slash((a),(b))
+int compat_mkdir_wo_trailing_slash(const char*, mode_t);
+#endif
+
+#ifdef time
+#undef time
+#endif
+static inline time_t git_time(time_t *tloc)
+{
+	struct timeval tv;
+
+	/*
+	 * Avoid time(NULL), which can disagree with gettimeofday(2)
+	 * and filesystem timestamps.
+	 */
+	gettimeofday(&tv, NULL);
+
+	if (tloc)
+		*tloc = tv.tv_sec;
+	return tv.tv_sec;
+}
+#define time git_time
+
+#ifdef NO_STRUCT_ITIMERVAL
+struct itimerval {
+	struct timeval it_interval;
+	struct timeval it_value;
+};
+#endif
+
+#ifdef NO_SETITIMER
+static inline int git_setitimer(int which UNUSED,
+				const struct itimerval *value UNUSED,
+				struct itimerval *newvalue UNUSED) {
+	return 0; /* pretend success */
+}
+#undef setitimer
+#define setitimer(which,value,ovalue) git_setitimer(which,value,ovalue)
+#endif
+
+#ifndef NO_LIBGEN_H
+#include <libgen.h>
+#else
+#define basename gitbasename
+char *gitbasename(char *);
+#define dirname gitdirname
+char *gitdirname(char *);
+#endif
+
+#ifndef NO_ICONV
+#include <iconv.h>
+#endif
+
+/* On most systems <netdb.h> would have given us this, but
+ * not on some systems (e.g. z/OS).
+ */
+#ifndef NI_MAXHOST
+#define NI_MAXHOST 1025
+#endif
+
+#ifndef NI_MAXSERV
+#define NI_MAXSERV 32
+#endif
+
+/* On most systems <limits.h> would have given us this, but
+ * not on some systems (e.g. GNU/Hurd).
+ */
+#ifndef PATH_MAX
+#define PATH_MAX 4096
+#endif
+
+#ifndef NAME_MAX
+#define NAME_MAX 255
+#endif
+
+typedef uintmax_t timestamp_t;
+#define PRItime PRIuMAX
+#define parse_timestamp strtoumax
+#define TIME_MAX UINTMAX_MAX
+#define TIME_MIN 0
+
+int lstat_cache_aware_rmdir(const char *path);
+#if !defined(__MINGW32__) && !defined(_MSC_VER)
+#define rmdir lstat_cache_aware_rmdir
+#endif
+
+#if defined(NO_MMAP) || defined(USE_WIN32_MMAP)
+
+#ifndef PROT_READ
+#define PROT_READ 1
+#define PROT_WRITE 2
+#define MAP_PRIVATE 1
+#endif
+
+#define mmap git_mmap
+#define munmap git_munmap
+void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t offset);
+int git_munmap(void *start, size_t length);
+
+#else /* NO_MMAP || USE_WIN32_MMAP */
+
+#include <sys/mman.h>
+
+#endif /* NO_MMAP || USE_WIN32_MMAP */
+
+#ifndef MAP_FAILED
+#define MAP_FAILED ((void *)-1)
+#endif
+
+#ifdef NEEDS_MODE_TRANSLATION
+#undef S_IFMT
+#undef S_IFREG
+#undef S_IFDIR
+#undef S_IFLNK
+#undef S_IFBLK
+#undef S_IFCHR
+#undef S_IFIFO
+#undef S_IFSOCK
+#define S_IFMT   0170000
+#define S_IFREG  0100000
+#define S_IFDIR  0040000
+#define S_IFLNK  0120000
+#define S_IFBLK  0060000
+#define S_IFCHR  0020000
+#define S_IFIFO  0010000
+#define S_IFSOCK 0140000
+#ifdef stat
+#undef stat
+#endif
+#define stat(path, buf) git_stat(path, buf)
+int git_stat(const char *, struct stat *);
+#ifdef fstat
+#undef fstat
+#endif
+#define fstat(fd, buf) git_fstat(fd, buf)
+int git_fstat(int, struct stat *);
+#ifdef lstat
+#undef lstat
+#endif
+#define lstat(path, buf) git_lstat(path, buf)
+int git_lstat(const char *, struct stat *);
+#endif
+
+#ifdef NO_PREAD
+#define pread git_pread
+ssize_t git_pread(int fd, void *buf, size_t count, off_t offset);
+#endif
+
+#ifdef NO_SETENV
+#define setenv gitsetenv
+int gitsetenv(const char *, const char *, int);
+#endif
+
+#ifdef NO_MKDTEMP
+#define mkdtemp gitmkdtemp
+char *gitmkdtemp(char *);
+#endif
+
+#ifdef NO_UNSETENV
+#define unsetenv gitunsetenv
+int gitunsetenv(const char *);
+#endif
+
+#ifdef NO_STRCASESTR
+#define strcasestr gitstrcasestr
+char *gitstrcasestr(const char *haystack, const char *needle);
+#endif
+
+#ifdef NO_STRLCPY
+#define strlcpy gitstrlcpy
+size_t gitstrlcpy(char *, const char *, size_t);
+#endif
+
+#ifdef NO_STRTOUMAX
+#define strtoumax gitstrtoumax
+uintmax_t gitstrtoumax(const char *, char **, int);
+#define strtoimax gitstrtoimax
+intmax_t gitstrtoimax(const char *, char **, int);
+#endif
+
+#ifdef NO_HSTRERROR
+#define hstrerror githstrerror
+const char *githstrerror(int herror);
+#endif
+
+#ifdef NO_MEMMEM
+#define memmem gitmemmem
+void *gitmemmem(const void *haystack, size_t haystacklen,
+		const void *needle, size_t needlelen);
+#endif
+
+#ifdef OVERRIDE_STRDUP
+#ifdef strdup
+#undef strdup
+#endif
+#define strdup gitstrdup
+char *gitstrdup(const char *s);
+#endif
+
+#ifdef NO_GETPAGESIZE
+#define getpagesize() sysconf(_SC_PAGESIZE)
+#endif
+
+#ifndef O_CLOEXEC
+#define O_CLOEXEC 0
+#endif
+
+#ifdef FREAD_READS_DIRECTORIES
+# if !defined(SUPPRESS_FOPEN_REDEFINITION)
+#  ifdef fopen
+#   undef fopen
+#  endif
+#  define fopen(a,b) git_fopen(a,b)
+# endif
+FILE *git_fopen(const char*, const char*);
+#endif
+
+#ifdef SNPRINTF_RETURNS_BOGUS
+#ifdef snprintf
+#undef snprintf
+#endif
+#define snprintf git_snprintf
+int git_snprintf(char *str, size_t maxsize,
+		 const char *format, ...);
+#ifdef vsnprintf
+#undef vsnprintf
+#endif
+#define vsnprintf git_vsnprintf
+int git_vsnprintf(char *str, size_t maxsize,
+		  const char *format, va_list ap);
+#endif
+
+#ifdef OPEN_RETURNS_EINTR
+#undef open
+#define open git_open_with_retry
+int git_open_with_retry(const char *path, int flag, ...);
+#endif
+
+#ifdef __GLIBC_PREREQ
+#if __GLIBC_PREREQ(2, 1)
+#define HAVE_STRCHRNUL
+#endif
+#endif
+
+#ifndef HAVE_STRCHRNUL
+#define strchrnul gitstrchrnul
+static inline char *gitstrchrnul(const char *s, int c)
+{
+	while (*s && *s != c)
+		s++;
+	return (char *)s;
+}
+#endif
+
+#ifdef NO_INET_PTON
+int inet_pton(int af, const char *src, void *dst);
+#endif
+
+#ifdef NO_INET_NTOP
+const char *inet_ntop(int af, const void *src, char *dst, size_t size);
+#endif
+
+#ifdef NO_PTHREADS
+#define atexit git_atexit
+int git_atexit(void (*handler)(void));
+#endif
+
+#ifndef HOST_NAME_MAX
+#define HOST_NAME_MAX 256
+#endif
+
+#include "sane-ctype.h"
+
+void git_stable_qsort(void *base, size_t nmemb, size_t size,
+		      int(*compar)(const void *, const void *));
+#ifdef INTERNAL_QSORT
+#define qsort git_stable_qsort
+#endif
+
+#define QSORT(base, n, compar) sane_qsort((base), (n), sizeof(*(base)), compar)
+static inline void sane_qsort(void *base, size_t nmemb, size_t size,
+			      int(*compar)(const void *, const void *))
+{
+	if (nmemb > 1)
+		qsort(base, nmemb, size, compar);
+}
+
+#define STABLE_QSORT(base, n, compar) \
+	git_stable_qsort((base), (n), sizeof(*(base)), compar)
+
+#ifndef HAVE_ISO_QSORT_S
+int git_qsort_s(void *base, size_t nmemb, size_t size,
+		int (*compar)(const void *, const void *, void *), void *ctx);
+#define qsort_s git_qsort_s
+#endif
+
+#define QSORT_S(base, n, compar, ctx) do {			\
+	if (qsort_s((base), (n), sizeof(*(base)), compar, ctx))	\
+		BUG("qsort_s() failed");			\
+} while (0)
+
+#ifdef NO_NSEC
+#undef USE_NSEC
+#define ST_CTIME_NSEC(st) 0
+#define ST_MTIME_NSEC(st) 0
+#else
+#ifdef USE_ST_TIMESPEC
+#define ST_CTIME_NSEC(st) ((unsigned int)((st).st_ctimespec.tv_nsec))
+#define ST_MTIME_NSEC(st) ((unsigned int)((st).st_mtimespec.tv_nsec))
+#else
+#define ST_CTIME_NSEC(st) ((unsigned int)((st).st_ctim.tv_nsec))
+#define ST_MTIME_NSEC(st) ((unsigned int)((st).st_mtim.tv_nsec))
+#endif
+#endif
+
+#ifndef va_copy
+/*
+ * Since an obvious implementation of va_list would be to make it a
+ * pointer into the stack frame, a simple assignment will work on
+ * many systems.  But let's try to be more portable.
+ */
+#ifdef __va_copy
+#define va_copy(dst, src) __va_copy(dst, src)
+#else
+#define va_copy(dst, src) ((dst) = (src))
+#endif
+#endif
+
+#ifndef _POSIX_THREAD_SAFE_FUNCTIONS
+static inline void git_flockfile(FILE *fh UNUSED)
+{
+	; /* nothing */
+}
+static inline void git_funlockfile(FILE *fh UNUSED)
+{
+	; /* nothing */
+}
+#undef flockfile
+#undef funlockfile
+#undef getc_unlocked
+#define flockfile(fh) git_flockfile(fh)
+#define funlockfile(fh) git_funlockfile(fh)
+#define getc_unlocked(fh) getc(fh)
+#endif
+
+#ifdef FILENO_IS_A_MACRO
+int git_fileno(FILE *stream);
+# ifndef COMPAT_CODE_FILENO
+#  undef fileno
+#  define fileno(p) git_fileno(p)
+# endif
+#endif
+
+#ifdef NEED_ACCESS_ROOT_HANDLER
+int git_access(const char *path, int mode);
+# ifndef COMPAT_CODE_ACCESS
+#  ifdef access
+#  undef access
+#  endif
+#  define access(path, mode) git_access(path, mode)
+# endif
+#endif
+
+#endif /* COMPAT_POSIX_H */
diff --git a/git-compat-util.h b/git-compat-util.h
index b96fb98e1e..30ad0725fb 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -23,26 +23,9 @@
 #include <crtdbg.h>
 #endif
 
-struct strbuf;
-
-
-#define _FILE_OFFSET_BITS 64
+#include "compat/posix.h"
 
-
-/* Derived from Linux "Features Test Macro" header
- * Convenience macros to test the versions of gcc (or
- * a compatible compiler).
- * Use them like this:
- *  #if GIT_GNUC_PREREQ (2,8)
- *   ... code requiring gcc 2.8 or later ...
- *  #endif
-*/
-#if defined(__GNUC__) && defined(__GNUC_MINOR__)
-# define GIT_GNUC_PREREQ(maj, min) \
-	((__GNUC__ << 16) + __GNUC_MINOR__ >= ((maj) << 16) + (min))
-#else
- #define GIT_GNUC_PREREQ(maj, min) 0
-#endif
+struct strbuf;
 
 #if defined(__GNUC__) || defined(__clang__)
 #  define PRAGMA(pragma)           _Pragma(#pragma)
@@ -176,71 +159,6 @@ DISABLE_WARNING(-Wsign-compare)
 /* Approximation of the length of the decimal representation of this type. */
 #define decimal_length(x)	((int)(sizeof(x) * 2.56 + 0.5) + 1)
 
-#ifdef __MINGW64__
-#define _POSIX_C_SOURCE 1
-#elif defined(__sun__)
- /*
-  * On Solaris, when _XOPEN_EXTENDED is set, its header file
-  * forces the programs to be XPG4v2, defeating any _XOPEN_SOURCE
-  * setting to say we are XPG5 or XPG6.  Also on Solaris,
-  * XPG6 programs must be compiled with a c99 compiler, while
-  * non XPG6 programs must be compiled with a pre-c99 compiler.
-  */
-# if __STDC_VERSION__ - 0 >= 199901L
-# define _XOPEN_SOURCE 600
-# else
-# define _XOPEN_SOURCE 500
-# endif
-#elif !defined(__APPLE__) && !defined(__FreeBSD__) && !defined(__USLC__) && \
-      !defined(_M_UNIX) && !defined(__sgi) && !defined(__DragonFly__) && \
-      !defined(__TANDEM) && !defined(__QNX__) && !defined(__MirBSD__) && \
-      !defined(__CYGWIN__)
-#define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
-#define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
-#endif
-#define _ALL_SOURCE 1
-#define _GNU_SOURCE 1
-#define _BSD_SOURCE 1
-#define _DEFAULT_SOURCE 1
-#define _NETBSD_SOURCE 1
-#define _SGI_SOURCE 1
-
-/*
- * UNUSED marks a function parameter that is always unused.  It also
- * can be used to annotate a function, a variable, or a type that is
- * always unused.
- *
- * A callback interface may dictate that a function accepts a
- * parameter at that position, but the implementation of the function
- * may not need to use the parameter.  In such a case, mark the parameter
- * with UNUSED.
- *
- * When a parameter may be used or unused, depending on conditional
- * compilation, consider using MAYBE_UNUSED instead.
- */
-#if GIT_GNUC_PREREQ(4, 5)
-#define UNUSED __attribute__((unused)) \
-	__attribute__((deprecated ("parameter declared as UNUSED")))
-#elif defined(__GNUC__)
-#define UNUSED __attribute__((unused)) \
-	__attribute__((deprecated))
-#else
-#define UNUSED
-#endif
-
-#if defined(WIN32) && !defined(__CYGWIN__) /* Both MinGW and MSVC */
-# if !defined(_WIN32_WINNT)
-#  define _WIN32_WINNT 0x0600
-# endif
-#define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
-#include <winsock2.h>
-#ifndef NO_UNIX_SOCKETS
-#include <afunix.h>
-#endif
-#include <windows.h>
-#define GIT_WINDOWS_NATIVE
-#endif
-
 #if defined(NO_UNIX_SOCKETS) || !defined(GIT_WINDOWS_NATIVE)
 static inline int _have_unix_sockets(void)
 {
@@ -253,45 +171,6 @@ static inline int _have_unix_sockets(void)
 #define have_unix_sockets _have_unix_sockets
 #endif
 
-#include <unistd.h>
-#include <stdio.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <stddef.h>
-#include <stdlib.h>
-#include <stdarg.h>
-#include <stdbool.h>
-#include <string.h>
-#ifdef HAVE_STRINGS_H
-#include <strings.h> /* for strcasecmp() */
-#endif
-#include <errno.h>
-#include <limits.h>
-#include <locale.h>
-#ifdef NEEDS_SYS_PARAM_H
-#include <sys/param.h>
-#endif
-#include <sys/types.h>
-#include <dirent.h>
-#include <sys/time.h>
-#include <time.h>
-#include <signal.h>
-#include <assert.h>
-#include <regex.h>
-#include <utime.h>
-#include <syslog.h>
-#if !defined(NO_POLL_H)
-#include <poll.h>
-#elif !defined(NO_SYS_POLL_H)
-#include <sys/poll.h>
-#else
-/* Pull the compat stuff */
-#include <poll.h>
-#endif
-#ifdef HAVE_BSD_SYSCTL
-#include <sys/sysctl.h>
-#endif
-
 /* Used by compat/win32/path-utils.h, and more */
 static inline int is_xplatform_dir_sep(int c)
 {
@@ -308,48 +187,6 @@ static inline int is_xplatform_dir_sep(int c)
 #elif defined(_MSC_VER)
 #include "compat/win32/path-utils.h"
 #include "compat/msvc/compat-util.h"
-#else
-#include <sys/utsname.h>
-#include <sys/wait.h>
-#include <sys/resource.h>
-#include <sys/socket.h>
-#include <sys/ioctl.h>
-#include <sys/statvfs.h>
-#include <termios.h>
-#ifndef NO_SYS_SELECT_H
-#include <sys/select.h>
-#endif
-#include <netinet/in.h>
-#include <netinet/tcp.h>
-#include <arpa/inet.h>
-#include <netdb.h>
-#include <pwd.h>
-#include <sys/un.h>
-#ifndef NO_INTTYPES_H
-#include <inttypes.h>
-#else
-#include <stdint.h>
-#endif
-#ifdef HAVE_ARC4RANDOM_LIBBSD
-#include <bsd/stdlib.h>
-#endif
-#ifdef HAVE_GETRANDOM
-#include <sys/random.h>
-#endif
-#ifdef NO_INTPTR_T
-/*
- * On I16LP32, ILP32 and LP64 "long" is the safe bet, however
- * on LLP86, IL33LLP64 and P64 it needs to be "long long",
- * while on IP16 and IP16L32 it is "int" (resp. "short")
- * Size needs to match (or exceed) 'sizeof(void *)'.
- * We can't take "long long" here as not everybody has it.
- */
-typedef long intptr_t;
-typedef unsigned long uintptr_t;
-#endif
-#undef _ALL_SOURCE /* AIX 5.3L defines a struct list with _ALL_SOURCE. */
-#include <grp.h>
-#define _ALL_SOURCE 1
 #endif
 
 /* used on Mac OS X */
@@ -370,60 +207,6 @@ static inline const char *precompose_string_if_needed(const char *in)
 #define probe_utf8_pathname_composition()
 #endif
 
-#ifdef MKDIR_WO_TRAILING_SLASH
-#define mkdir(a,b) compat_mkdir_wo_trailing_slash((a),(b))
-int compat_mkdir_wo_trailing_slash(const char*, mode_t);
-#endif
-
-#ifdef time
-#undef time
-#endif
-static inline time_t git_time(time_t *tloc)
-{
-	struct timeval tv;
-
-	/*
-	 * Avoid time(NULL), which can disagree with gettimeofday(2)
-	 * and filesystem timestamps.
-	 */
-	gettimeofday(&tv, NULL);
-
-	if (tloc)
-		*tloc = tv.tv_sec;
-	return tv.tv_sec;
-}
-#define time git_time
-
-#ifdef NO_STRUCT_ITIMERVAL
-struct itimerval {
-	struct timeval it_interval;
-	struct timeval it_value;
-};
-#endif
-
-#ifdef NO_SETITIMER
-static inline int git_setitimer(int which UNUSED,
-				const struct itimerval *value UNUSED,
-				struct itimerval *newvalue UNUSED) {
-	return 0; /* pretend success */
-}
-#undef setitimer
-#define setitimer(which,value,ovalue) git_setitimer(which,value,ovalue)
-#endif
-
-#ifndef NO_LIBGEN_H
-#include <libgen.h>
-#else
-#define basename gitbasename
-char *gitbasename(char *);
-#define dirname gitdirname
-char *gitdirname(char *);
-#endif
-
-#ifndef NO_ICONV
-#include <iconv.h>
-#endif
-
 #ifndef NO_OPENSSL
 #ifdef __APPLE__
 #undef __AVAILABILITY_MACROS_USES_AVAILABILITY
@@ -441,34 +224,6 @@ char *gitdirname(char *);
 # include <sys/sysinfo.h>
 #endif
 
-/* On most systems <netdb.h> would have given us this, but
- * not on some systems (e.g. z/OS).
- */
-#ifndef NI_MAXHOST
-#define NI_MAXHOST 1025
-#endif
-
-#ifndef NI_MAXSERV
-#define NI_MAXSERV 32
-#endif
-
-/* On most systems <limits.h> would have given us this, but
- * not on some systems (e.g. GNU/Hurd).
- */
-#ifndef PATH_MAX
-#define PATH_MAX 4096
-#endif
-
-#ifndef NAME_MAX
-#define NAME_MAX 255
-#endif
-
-typedef uintmax_t timestamp_t;
-#define PRItime PRIuMAX
-#define parse_timestamp strtoumax
-#define TIME_MAX UINTMAX_MAX
-#define TIME_MIN 0
-
 #ifndef PATH_SEP
 #define PATH_SEP ':'
 #endif
@@ -492,11 +247,6 @@ static inline int noop_core_config(const char *var UNUSED,
 #define platform_core_config noop_core_config
 #endif
 
-int lstat_cache_aware_rmdir(const char *path);
-#if !defined(__MINGW32__) && !defined(_MSC_VER)
-#define rmdir lstat_cache_aware_rmdir
-#endif
-
 #ifndef has_dos_drive_prefix
 static inline int git_has_dos_drive_prefix(const char *path UNUSED)
 {
@@ -822,25 +572,6 @@ static inline bool strip_suffix(const char *str, const char *suffix,
 	memcpy(_swap_b_ptr, _swap_buffer, sizeof(a));		\
 } while (0)
 
-#if defined(NO_MMAP) || defined(USE_WIN32_MMAP)
-
-#ifndef PROT_READ
-#define PROT_READ 1
-#define PROT_WRITE 2
-#define MAP_PRIVATE 1
-#endif
-
-#define mmap git_mmap
-#define munmap git_munmap
-void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t offset);
-int git_munmap(void *start, size_t length);
-
-#else /* NO_MMAP || USE_WIN32_MMAP */
-
-#include <sys/mman.h>
-
-#endif /* NO_MMAP || USE_WIN32_MMAP */
-
 #ifdef NO_MMAP
 
 /* This value must be multiple of (pagesize * 2) */
@@ -856,177 +587,15 @@ int git_munmap(void *start, size_t length);
 
 #endif /* NO_MMAP */
 
-#ifndef MAP_FAILED
-#define MAP_FAILED ((void *)-1)
-#endif
-
 #ifdef NO_ST_BLOCKS_IN_STRUCT_STAT
 #define on_disk_bytes(st) ((st).st_size)
 #else
 #define on_disk_bytes(st) ((st).st_blocks * 512)
 #endif
 
-#ifdef NEEDS_MODE_TRANSLATION
-#undef S_IFMT
-#undef S_IFREG
-#undef S_IFDIR
-#undef S_IFLNK
-#undef S_IFBLK
-#undef S_IFCHR
-#undef S_IFIFO
-#undef S_IFSOCK
-#define S_IFMT   0170000
-#define S_IFREG  0100000
-#define S_IFDIR  0040000
-#define S_IFLNK  0120000
-#define S_IFBLK  0060000
-#define S_IFCHR  0020000
-#define S_IFIFO  0010000
-#define S_IFSOCK 0140000
-#ifdef stat
-#undef stat
-#endif
-#define stat(path, buf) git_stat(path, buf)
-int git_stat(const char *, struct stat *);
-#ifdef fstat
-#undef fstat
-#endif
-#define fstat(fd, buf) git_fstat(fd, buf)
-int git_fstat(int, struct stat *);
-#ifdef lstat
-#undef lstat
-#endif
-#define lstat(path, buf) git_lstat(path, buf)
-int git_lstat(const char *, struct stat *);
-#endif
-
 #define DEFAULT_PACKED_GIT_LIMIT \
 	((1024L * 1024L) * (size_t)(sizeof(void*) >= 8 ? (32 * 1024L * 1024L) : 256))
 
-#ifdef NO_PREAD
-#define pread git_pread
-ssize_t git_pread(int fd, void *buf, size_t count, off_t offset);
-#endif
-
-#ifdef NO_SETENV
-#define setenv gitsetenv
-int gitsetenv(const char *, const char *, int);
-#endif
-
-#ifdef NO_MKDTEMP
-#define mkdtemp gitmkdtemp
-char *gitmkdtemp(char *);
-#endif
-
-#ifdef NO_UNSETENV
-#define unsetenv gitunsetenv
-int gitunsetenv(const char *);
-#endif
-
-#ifdef NO_STRCASESTR
-#define strcasestr gitstrcasestr
-char *gitstrcasestr(const char *haystack, const char *needle);
-#endif
-
-#ifdef NO_STRLCPY
-#define strlcpy gitstrlcpy
-size_t gitstrlcpy(char *, const char *, size_t);
-#endif
-
-#ifdef NO_STRTOUMAX
-#define strtoumax gitstrtoumax
-uintmax_t gitstrtoumax(const char *, char **, int);
-#define strtoimax gitstrtoimax
-intmax_t gitstrtoimax(const char *, char **, int);
-#endif
-
-#ifdef NO_HSTRERROR
-#define hstrerror githstrerror
-const char *githstrerror(int herror);
-#endif
-
-#ifdef NO_MEMMEM
-#define memmem gitmemmem
-void *gitmemmem(const void *haystack, size_t haystacklen,
-		const void *needle, size_t needlelen);
-#endif
-
-#ifdef OVERRIDE_STRDUP
-#ifdef strdup
-#undef strdup
-#endif
-#define strdup gitstrdup
-char *gitstrdup(const char *s);
-#endif
-
-#ifdef NO_GETPAGESIZE
-#define getpagesize() sysconf(_SC_PAGESIZE)
-#endif
-
-#ifndef O_CLOEXEC
-#define O_CLOEXEC 0
-#endif
-
-#ifdef FREAD_READS_DIRECTORIES
-# if !defined(SUPPRESS_FOPEN_REDEFINITION)
-#  ifdef fopen
-#   undef fopen
-#  endif
-#  define fopen(a,b) git_fopen(a,b)
-# endif
-FILE *git_fopen(const char*, const char*);
-#endif
-
-#ifdef SNPRINTF_RETURNS_BOGUS
-#ifdef snprintf
-#undef snprintf
-#endif
-#define snprintf git_snprintf
-int git_snprintf(char *str, size_t maxsize,
-		 const char *format, ...);
-#ifdef vsnprintf
-#undef vsnprintf
-#endif
-#define vsnprintf git_vsnprintf
-int git_vsnprintf(char *str, size_t maxsize,
-		  const char *format, va_list ap);
-#endif
-
-#ifdef OPEN_RETURNS_EINTR
-#undef open
-#define open git_open_with_retry
-int git_open_with_retry(const char *path, int flag, ...);
-#endif
-
-#ifdef __GLIBC_PREREQ
-#if __GLIBC_PREREQ(2, 1)
-#define HAVE_STRCHRNUL
-#endif
-#endif
-
-#ifndef HAVE_STRCHRNUL
-#define strchrnul gitstrchrnul
-static inline char *gitstrchrnul(const char *s, int c)
-{
-	while (*s && *s != c)
-		s++;
-	return (char *)s;
-}
-#endif
-
-#ifdef NO_INET_PTON
-int inet_pton(int af, const char *src, void *dst);
-#endif
-
-#ifdef NO_INET_NTOP
-const char *inet_ntop(int af, const void *src, char *dst, size_t size);
-#endif
-
-#ifdef NO_PTHREADS
-#define atexit git_atexit
-int git_atexit(void (*handler)(void));
-#endif
-
 static inline size_t st_add(size_t a, size_t b)
 {
 	if (unsigned_add_overflows(a, b))
@@ -1293,12 +862,6 @@ static inline size_t xsize_t(off_t len)
 	return (size_t) len;
 }
 
-#ifndef HOST_NAME_MAX
-#define HOST_NAME_MAX 256
-#endif
-
-#include "sane-ctype.h"
-
 /*
  * Like skip_prefix, but compare case-insensitively. Note that the comparison
  * is done via tolower(), so it is strictly ASCII (no multi-byte characters or
@@ -1364,34 +927,6 @@ static inline int strtol_i(char const *s, int base, int *result)
 	return 0;
 }
 
-void git_stable_qsort(void *base, size_t nmemb, size_t size,
-		      int(*compar)(const void *, const void *));
-#ifdef INTERNAL_QSORT
-#define qsort git_stable_qsort
-#endif
-
-#define QSORT(base, n, compar) sane_qsort((base), (n), sizeof(*(base)), compar)
-static inline void sane_qsort(void *base, size_t nmemb, size_t size,
-			      int(*compar)(const void *, const void *))
-{
-	if (nmemb > 1)
-		qsort(base, nmemb, size, compar);
-}
-
-#define STABLE_QSORT(base, n, compar) \
-	git_stable_qsort((base), (n), sizeof(*(base)), compar)
-
-#ifndef HAVE_ISO_QSORT_S
-int git_qsort_s(void *base, size_t nmemb, size_t size,
-		int (*compar)(const void *, const void *, void *), void *ctx);
-#define qsort_s git_qsort_s
-#endif
-
-#define QSORT_S(base, n, compar, ctx) do {			\
-	if (qsort_s((base), (n), sizeof(*(base)), compar, ctx))	\
-		BUG("qsort_s() failed");			\
-} while (0)
-
 #ifndef REG_STARTEND
 #error "Git requires REG_STARTEND support. Compile with NO_REGEX=NeedsStartEnd"
 #endif
@@ -1416,39 +951,12 @@ int git_regcomp(regex_t *preg, const char *pattern, int cflags);
 # define FORCE_DIR_SET_GID 0
 #endif
 
-#ifdef NO_NSEC
-#undef USE_NSEC
-#define ST_CTIME_NSEC(st) 0
-#define ST_MTIME_NSEC(st) 0
-#else
-#ifdef USE_ST_TIMESPEC
-#define ST_CTIME_NSEC(st) ((unsigned int)((st).st_ctimespec.tv_nsec))
-#define ST_MTIME_NSEC(st) ((unsigned int)((st).st_mtimespec.tv_nsec))
-#else
-#define ST_CTIME_NSEC(st) ((unsigned int)((st).st_ctim.tv_nsec))
-#define ST_MTIME_NSEC(st) ((unsigned int)((st).st_mtim.tv_nsec))
-#endif
-#endif
-
 #ifdef UNRELIABLE_FSTAT
 #define fstat_is_reliable() 0
 #else
 #define fstat_is_reliable() 1
 #endif
 
-#ifndef va_copy
-/*
- * Since an obvious implementation of va_list would be to make it a
- * pointer into the stack frame, a simple assignment will work on
- * many systems.  But let's try to be more portable.
- */
-#ifdef __va_copy
-#define va_copy(dst, src) __va_copy(dst, src)
-#else
-#define va_copy(dst, src) ((dst) = (src))
-#endif
-#endif
-
 /* usage.c: only to be used for testing BUG() implementation (see test-tool) */
 extern int BUG_exit_code;
 
@@ -1478,41 +986,6 @@ void bug_fl(const char *file, int line, const char *fmt, ...);
 # define SHELL_PATH "/bin/sh"
 #endif
 
-#ifndef _POSIX_THREAD_SAFE_FUNCTIONS
-static inline void git_flockfile(FILE *fh UNUSED)
-{
-	; /* nothing */
-}
-static inline void git_funlockfile(FILE *fh UNUSED)
-{
-	; /* nothing */
-}
-#undef flockfile
-#undef funlockfile
-#undef getc_unlocked
-#define flockfile(fh) git_flockfile(fh)
-#define funlockfile(fh) git_funlockfile(fh)
-#define getc_unlocked(fh) getc(fh)
-#endif
-
-#ifdef FILENO_IS_A_MACRO
-int git_fileno(FILE *stream);
-# ifndef COMPAT_CODE_FILENO
-#  undef fileno
-#  define fileno(p) git_fileno(p)
-# endif
-#endif
-
-#ifdef NEED_ACCESS_ROOT_HANDLER
-int git_access(const char *path, int mode);
-# ifndef COMPAT_CODE_ACCESS
-#  ifdef access
-#  undef access
-#  endif
-#  define access(path, mode) git_access(path, mode)
-# endif
-#endif
-
 /*
  * Our code often opens a path to an optional file, to work on its
  * contents when we can successfully open it.  We can ignore a failure

-- 
2.48.1.502.g6dc24dfdaf.dirty

