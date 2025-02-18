Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A196C23A560
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 09:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870533; cv=none; b=Lrpg3SuCk2J3vMDAD2SwMgdVnVfair4nEDusZymkEiBH+FS7x00GggYy4tmy6+4BDc4LTyk/8zUlYDalzPSgwITcSD/OIhDagOBu5NktUc5ic5J8wQKpChsxoJNyF+WMk9ggDO6JSjegXVKMG4IFNcwW+A9ECsZzeBWp9FAQmY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870533; c=relaxed/simple;
	bh=gVbpmZLeqPlQHjbR+RMiCm6DoAXM5avXa+cM/v+sRSo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=psFGgQT0VO9E/P/JMLIXMVjx0jQy9ncG1boz5fJzvSgcddWDdwlslQeJ9seHfwtkGBC/xY2I8P7Pb41c9aHQOrRfdlbSRmk4CWfD0Y+lp0lXkXF1NxjmxN8UbKpATcU0MXufXvBcOdIoBP1RFhYMPRrMJQzDPb3RAlStg/YgPEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mMGj6ae3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZvWQ527W; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mMGj6ae3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZvWQ527W"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id C301B1380A40;
	Tue, 18 Feb 2025 04:22:09 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 18 Feb 2025 04:22:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739870529;
	 x=1739956929; bh=M4qNptMGH1SMAwDg53+D3lxrBtArWUtWDgFwfv5gICg=; b=
	mMGj6ae3HSuW722QBVom2skvAJ+8K3YafysH7gdVC8i9hgdfX7Evvqk/oY9t8Qr7
	U9Ukm17bKEW8OtvvY57ch4DVeI7n1Zm4AiZtS0n0oLNXQX7lkdyOO1n7qrL29wd6
	cALZRfR9zWfnItMwYz7dhKkAr/6EY6Gc25H8/Ka3Gxgk/aKN+Ru9cKS0JAOeTgv+
	vvWvCMUwouIrqp4D3rmIpFx3ioc0Im/iL+/wFSyHJWH8+zqMPfKYWaeshJSwWlqv
	F+Poc2c5gFIlme047gZk2mx4Bi2T2n6BA75cwP84H5iXZDyhFfsIaGhZCMGeeJKv
	F9YGB3p6La5RBJOmgYO4bA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739870529; x=
	1739956929; bh=M4qNptMGH1SMAwDg53+D3lxrBtArWUtWDgFwfv5gICg=; b=Z
	vWQ527WD7hTycxzi6CYG5QDLVmXs6Xw35PUfgzo2lBNxcH/Sc/NiZ4g+4GrJyuh9
	CjKfp1E9Fn19mw3cWZPQAYVRY/YSvDF/9x8t5uKWcjheWHtk4g+BfA/Itca2jqmG
	PHy7xTtDQXRvb28K7P8SRXCUFdzsJGPiRJuOdCVwJmll9BRuUXbZ3T0zFT0AlRR4
	L+b5tjFBNql7MLmvfVZpzEPENkcOlkKhGDgXGUghhi9sQYtalIt51aZ9uX8gzc2n
	6M/PDO8lPj2ZfCci/IcC0pn4jfcmLEW37kteOU+bVKN2tBzh/35HqajEFktGnDj3
	BQppArZviDuwrLOff+A/w==
X-ME-Sender: <xms:QVG0Zz2wfWkJs6lW5pFcbqxZ30BiEatUp2dIJx4LWudDV0irCQviZQ>
    <xme:QVG0ZyH0DH03tWLwrahARpq0C-9Xsp9KzeHH38yFDWs1yT5heJPn815dYp3kNKEtk
    9_ZVIp2wWAkhfLVgQ>
X-ME-Received: <xmr:QVG0Zz7wpYUo2M5AWayTZWmSKN-1g3TWayirPd8Pi84AOE0YjlMesX-r-lintjJjpis8cgii4UlGfkvcaluZBoYHQtnn0gqPTLtv-oqXPJ3EJ_Zv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvght
    hhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohepjhhlth
    hosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjheitheskhgusghgrdhorhhg
    pdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:QVG0Z41qin_AQr8b4NY9CBqCgIinTRuapydNdmw0aO6lhADHYGWqHg>
    <xmx:QVG0Z2HQ6WXWd5p-MbCVCLaqUpVtP6JSYoClKfb-fq-c10OhgGdOWQ>
    <xmx:QVG0Z597Fy4GciyX-LND-jrBbwYzn-xNiPdkaF3W7Xdud_C4o2dQUw>
    <xmx:QVG0ZzkOQgTedTTwuyzaKOrNmGB93QXQvJgqH1eI3VD8rcwOTUnIvA>
    <xmx:QVG0Z76eWysHaWpCeSWvEoHThy7zKpoijHlvN0EZe9Hel4OUXXP3LZjp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 04:22:08 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b80f6d7e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Feb 2025 09:22:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 18 Feb 2025 10:20:51 +0100
Subject: [PATCH v6 15/18] compat/mingw: split out POSIX-related bits
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-pks-reftable-drop-git-compat-util-v6-15-8c1f39fb4c02@pks.im>
References: <20250218-pks-reftable-drop-git-compat-util-v6-0-8c1f39fb4c02@pks.im>
In-Reply-To: <20250218-pks-reftable-drop-git-compat-util-v6-0-8c1f39fb4c02@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Johannes Sixt <j6t@kdbg.org>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.2

Split out POSIX-related bits from "compat/mingw.h" and "compat/msvc.h".
This is in preparation for splitting up "git-compat-utils.h" into a
header that provides POSIX-compatibility and a header that provides
common wrappers used by the Git project.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 compat/mingw-posix.h | 431 +++++++++++++++++++++++++++++++++++++++++++++++++++
 compat/mingw.h       | 426 +-------------------------------------------------
 compat/msvc-posix.h  |  33 ++++
 compat/msvc.h        |  30 +---
 4 files changed, 467 insertions(+), 453 deletions(-)

diff --git a/compat/mingw-posix.h b/compat/mingw-posix.h
new file mode 100644
index 00000000000..8dddfa818d6
--- /dev/null
+++ b/compat/mingw-posix.h
@@ -0,0 +1,431 @@
+#ifndef COMPAT_MINGW_POSIX_H
+#define COMPAT_MINGW_POSIX_H
+
+#ifdef __MINGW64_VERSION_MAJOR
+#include <stdint.h>
+#include <wchar.h>
+typedef _sigset_t sigset_t;
+#endif
+#include <winsock2.h>
+#include <ws2tcpip.h>
+
+/* MinGW-w64 reports to have flockfile, but it does not actually have it. */
+#ifdef __MINGW64_VERSION_MAJOR
+#undef _POSIX_THREAD_SAFE_FUNCTIONS
+#endif
+
+/*
+ * things that are not available in header files
+ */
+
+typedef int uid_t;
+typedef int socklen_t;
+#ifndef __MINGW64_VERSION_MAJOR
+typedef int pid_t;
+#define hstrerror strerror
+#endif
+
+#define S_IFLNK    0120000 /* Symbolic link */
+#define S_ISLNK(x) (((x) & S_IFMT) == S_IFLNK)
+#define S_ISSOCK(x) 0
+
+#ifndef S_IRWXG
+#define S_IRGRP 0
+#define S_IWGRP 0
+#define S_IXGRP 0
+#define S_IRWXG (S_IRGRP | S_IWGRP | S_IXGRP)
+#endif
+#ifndef S_IRWXO
+#define S_IROTH 0
+#define S_IWOTH 0
+#define S_IXOTH 0
+#define S_IRWXO (S_IROTH | S_IWOTH | S_IXOTH)
+#endif
+
+#define S_ISUID 0004000
+#define S_ISGID 0002000
+#define S_ISVTX 0001000
+
+#define WIFEXITED(x) 1
+#define WIFSIGNALED(x) 0
+#define WEXITSTATUS(x) ((x) & 0xff)
+#define WTERMSIG(x) SIGTERM
+
+#ifndef EWOULDBLOCK
+#define EWOULDBLOCK EAGAIN
+#endif
+#ifndef ELOOP
+#define ELOOP EMLINK
+#endif
+#define SHUT_WR SD_SEND
+
+#define SIGHUP 1
+#define SIGQUIT 3
+#define SIGKILL 9
+#define SIGPIPE 13
+#define SIGALRM 14
+#define SIGCHLD 17
+
+#define F_GETFD 1
+#define F_SETFD 2
+#define FD_CLOEXEC 0x1
+
+#if !defined O_CLOEXEC && defined O_NOINHERIT
+#define O_CLOEXEC	O_NOINHERIT
+#endif
+
+#ifndef EAFNOSUPPORT
+#define EAFNOSUPPORT WSAEAFNOSUPPORT
+#endif
+#ifndef ECONNABORTED
+#define ECONNABORTED WSAECONNABORTED
+#endif
+#ifndef ENOTSOCK
+#define ENOTSOCK WSAENOTSOCK
+#endif
+
+struct passwd {
+	char *pw_name;
+	char *pw_gecos;
+	char *pw_dir;
+};
+
+typedef void (__cdecl *sig_handler_t)(int);
+struct sigaction {
+	sig_handler_t sa_handler;
+	unsigned sa_flags;
+};
+#define SA_RESTART 0
+
+struct itimerval {
+	struct timeval it_value, it_interval;
+};
+#define ITIMER_REAL 0
+
+struct utsname {
+	char sysname[16];
+	char nodename[1];
+	char release[16];
+	char version[16];
+	char machine[1];
+};
+
+/*
+ * sanitize preprocessor namespace polluted by Windows headers defining
+ * macros which collide with git local versions
+ */
+#undef HELP_COMMAND /* from winuser.h */
+
+/*
+ * trivial stubs
+ */
+
+static inline int readlink(const char *path UNUSED, char *buf UNUSED, size_t bufsiz UNUSED)
+{ errno = ENOSYS; return -1; }
+static inline int symlink(const char *oldpath UNUSED, const char *newpath UNUSED)
+{ errno = ENOSYS; return -1; }
+static inline int fchmod(int fildes UNUSED, mode_t mode UNUSED)
+{ errno = ENOSYS; return -1; }
+#ifndef __MINGW64_VERSION_MAJOR
+static inline pid_t fork(void)
+{ errno = ENOSYS; return -1; }
+#endif
+static inline unsigned int alarm(unsigned int seconds UNUSED)
+{ return 0; }
+static inline int fsync(int fd)
+{ return _commit(fd); }
+static inline void sync(void)
+{}
+static inline uid_t getuid(void)
+{ return 1; }
+static inline struct passwd *getpwnam(const char *name UNUSED)
+{ return NULL; }
+static inline int fcntl(int fd UNUSED, int cmd, ...)
+{
+	if (cmd == F_GETFD || cmd == F_SETFD)
+		return 0;
+	errno = EINVAL;
+	return -1;
+}
+
+#define sigemptyset(x) (void)0
+static inline int sigaddset(sigset_t *set UNUSED, int signum UNUSED)
+{ return 0; }
+#define SIG_BLOCK 0
+#define SIG_UNBLOCK 0
+static inline int sigprocmask(int how UNUSED, const sigset_t *set UNUSED, sigset_t *oldset UNUSED)
+{ return 0; }
+static inline pid_t getppid(void)
+{ return 1; }
+static inline pid_t getpgid(pid_t pid)
+{ return pid == 0 ? getpid() : pid; }
+static inline pid_t tcgetpgrp(int fd UNUSED)
+{ return getpid(); }
+
+/*
+ * simple adaptors
+ */
+
+int mingw_mkdir(const char *path, int mode);
+#define mkdir mingw_mkdir
+
+#define WNOHANG 1
+pid_t waitpid(pid_t pid, int *status, int options);
+
+#define kill mingw_kill
+int mingw_kill(pid_t pid, int sig);
+
+#define locate_in_PATH mingw_locate_in_PATH
+char *mingw_locate_in_PATH(const char *cmd);
+
+/*
+ * implementations of missing functions
+ */
+
+int pipe(int filedes[2]);
+unsigned int sleep (unsigned int seconds);
+int mkstemp(char *template);
+int gettimeofday(struct timeval *tv, void *tz);
+#ifndef __MINGW64_VERSION_MAJOR
+struct tm *gmtime_r(const time_t *timep, struct tm *result);
+struct tm *localtime_r(const time_t *timep, struct tm *result);
+#endif
+int getpagesize(void);	/* defined in MinGW's libgcc.a */
+struct passwd *getpwuid(uid_t uid);
+int setitimer(int type, struct itimerval *in, struct itimerval *out);
+int sigaction(int sig, struct sigaction *in, struct sigaction *out);
+int link(const char *oldpath, const char *newpath);
+int uname(struct utsname *buf);
+
+/*
+ * replacements of existing functions
+ */
+
+int mingw_unlink(const char *pathname);
+#define unlink mingw_unlink
+
+int mingw_rmdir(const char *path);
+#define rmdir mingw_rmdir
+
+int mingw_open (const char *filename, int oflags, ...);
+#define open mingw_open
+#undef OPEN_RETURNS_EINTR
+
+int mingw_fgetc(FILE *stream);
+#define fgetc mingw_fgetc
+
+FILE *mingw_fopen (const char *filename, const char *otype);
+#define fopen mingw_fopen
+
+FILE *mingw_freopen (const char *filename, const char *otype, FILE *stream);
+#define freopen mingw_freopen
+
+int mingw_fflush(FILE *stream);
+#define fflush mingw_fflush
+
+ssize_t mingw_write(int fd, const void *buf, size_t len);
+#define write mingw_write
+
+int mingw_access(const char *filename, int mode);
+#undef access
+#define access mingw_access
+
+int mingw_chdir(const char *dirname);
+#define chdir mingw_chdir
+
+int mingw_chmod(const char *filename, int mode);
+#define chmod mingw_chmod
+
+char *mingw_mktemp(char *template);
+#define mktemp mingw_mktemp
+
+char *mingw_getcwd(char *pointer, int len);
+#define getcwd mingw_getcwd
+
+#ifdef NO_UNSETENV
+#error "NO_UNSETENV is incompatible with the Windows-specific startup code!"
+#endif
+
+/*
+ * We bind *env() routines (even the mingw_ ones) to private mingw_ versions.
+ * These talk to the CRT using UNICODE/wchar_t, but maintain the original
+ * narrow-char API.
+ *
+ * Note that the MSCRT maintains both ANSI (getenv()) and UNICODE (_wgetenv())
+ * routines and stores both versions of each environment variable in parallel
+ * (and secretly updates both when you set one or the other), but it uses CP_ACP
+ * to do the conversion rather than CP_UTF8.
+ *
+ * Since everything in the git code base is UTF8, we define the mingw_ routines
+ * to access the CRT using the UNICODE routines and manually convert them to
+ * UTF8.  This also avoids round-trip problems.
+ *
+ * This also helps with our linkage, since "_wenviron" is publicly exported
+ * from the CRT.  But to access "_environ" we would have to statically link
+ * to the CRT (/MT).
+ *
+ * We require NO_SETENV (and let gitsetenv() call our mingw_putenv).
+ */
+#define getenv       mingw_getenv
+#define putenv       mingw_putenv
+#define unsetenv     mingw_putenv
+char *mingw_getenv(const char *name);
+int   mingw_putenv(const char *name);
+
+int mingw_gethostname(char *host, int namelen);
+#define gethostname mingw_gethostname
+
+struct hostent *mingw_gethostbyname(const char *host);
+#define gethostbyname mingw_gethostbyname
+
+int mingw_getaddrinfo(const char *node, const char *service,
+		      const struct addrinfo *hints, struct addrinfo **res);
+#define getaddrinfo mingw_getaddrinfo
+
+int mingw_socket(int domain, int type, int protocol);
+#define socket mingw_socket
+
+int mingw_connect(int sockfd, struct sockaddr *sa, size_t sz);
+#define connect mingw_connect
+
+int mingw_bind(int sockfd, struct sockaddr *sa, size_t sz);
+#define bind mingw_bind
+
+int mingw_setsockopt(int sockfd, int lvl, int optname, void *optval, int optlen);
+#define setsockopt mingw_setsockopt
+
+int mingw_shutdown(int sockfd, int how);
+#define shutdown mingw_shutdown
+
+int mingw_listen(int sockfd, int backlog);
+#define listen mingw_listen
+
+int mingw_accept(int sockfd, struct sockaddr *sa, socklen_t *sz);
+#define accept mingw_accept
+
+int mingw_rename(const char*, const char*);
+#define rename mingw_rename
+
+#if defined(USE_WIN32_MMAP) || defined(_MSC_VER)
+int mingw_getpagesize(void);
+#define getpagesize mingw_getpagesize
+#endif
+
+int win32_fsync_no_flush(int fd);
+#define fsync_no_flush win32_fsync_no_flush
+
+#define FSYNC_COMPONENTS_PLATFORM_DEFAULT (FSYNC_COMPONENTS_DEFAULT | FSYNC_COMPONENT_LOOSE_OBJECT)
+#define FSYNC_METHOD_DEFAULT (FSYNC_METHOD_BATCH)
+
+struct rlimit {
+	unsigned int rlim_cur;
+};
+#define RLIMIT_NOFILE 0
+
+static inline int getrlimit(int resource, struct rlimit *rlp)
+{
+	if (resource != RLIMIT_NOFILE) {
+		errno = EINVAL;
+		return -1;
+	}
+
+	rlp->rlim_cur = 2048;
+	return 0;
+}
+
+/*
+ * Use mingw specific stat()/lstat()/fstat() implementations on Windows,
+ * including our own struct stat with 64 bit st_size and nanosecond-precision
+ * file times.
+ */
+#ifndef __MINGW64_VERSION_MAJOR
+#define off_t off64_t
+#define lseek _lseeki64
+#ifndef _MSC_VER
+struct timespec {
+	time_t tv_sec;
+	long tv_nsec;
+};
+#endif
+#endif
+
+struct mingw_stat {
+    _dev_t st_dev;
+    _ino_t st_ino;
+    _mode_t st_mode;
+    short st_nlink;
+    short st_uid;
+    short st_gid;
+    _dev_t st_rdev;
+    off64_t st_size;
+    struct timespec st_atim;
+    struct timespec st_mtim;
+    struct timespec st_ctim;
+};
+
+#define st_atime st_atim.tv_sec
+#define st_mtime st_mtim.tv_sec
+#define st_ctime st_ctim.tv_sec
+
+#ifdef stat
+#undef stat
+#endif
+#define stat mingw_stat
+int mingw_lstat(const char *file_name, struct stat *buf);
+int mingw_stat(const char *file_name, struct stat *buf);
+int mingw_fstat(int fd, struct stat *buf);
+#ifdef fstat
+#undef fstat
+#endif
+#define fstat mingw_fstat
+#ifdef lstat
+#undef lstat
+#endif
+#define lstat mingw_lstat
+
+
+int mingw_utime(const char *file_name, const struct utimbuf *times);
+#define utime mingw_utime
+size_t mingw_strftime(char *s, size_t max,
+		   const char *format, const struct tm *tm);
+#define strftime mingw_strftime
+
+pid_t mingw_spawnvpe(const char *cmd, const char **argv, char **env,
+		     const char *dir,
+		     int fhin, int fhout, int fherr);
+int mingw_execvp(const char *cmd, char *const *argv);
+#define execvp mingw_execvp
+int mingw_execv(const char *cmd, char *const *argv);
+#define execv mingw_execv
+
+static inline unsigned int git_ntohl(unsigned int x)
+{ return (unsigned int)ntohl(x); }
+#define ntohl git_ntohl
+
+sig_handler_t mingw_signal(int sig, sig_handler_t handler);
+#define signal mingw_signal
+
+int mingw_raise(int sig);
+#define raise mingw_raise
+
+/*
+ * ANSI emulation wrappers
+ */
+
+int winansi_isatty(int fd);
+#define isatty winansi_isatty
+
+int winansi_dup2(int oldfd, int newfd);
+#define dup2 winansi_dup2
+
+void winansi_init(void);
+HANDLE winansi_get_osfhandle(int fd);
+
+#if !defined(__MINGW64_VERSION_MAJOR) && (!defined(_MSC_VER) || _MSC_VER < 1800)
+#define PRIuMAX "I64u"
+#define PRId64 "I64d"
+#else
+#include <inttypes.h>
+#endif
+
+#endif /* COMPAT_MINGW_POSIX_H */
diff --git a/compat/mingw.h b/compat/mingw.h
index ebfb8ba423b..444daedfa52 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -1,185 +1,10 @@
-#ifdef __MINGW64_VERSION_MAJOR
-#include <stdint.h>
-#include <wchar.h>
-typedef _sigset_t sigset_t;
-#endif
-#include <winsock2.h>
-#include <ws2tcpip.h>
-
-/* MinGW-w64 reports to have flockfile, but it does not actually have it. */
-#ifdef __MINGW64_VERSION_MAJOR
-#undef _POSIX_THREAD_SAFE_FUNCTIONS
-#endif
+#include "mingw-posix.h"
 
 struct config_context;
 int mingw_core_config(const char *var, const char *value,
 		      const struct config_context *ctx, void *cb);
 #define platform_core_config mingw_core_config
 
-/*
- * things that are not available in header files
- */
-
-typedef int uid_t;
-typedef int socklen_t;
-#ifndef __MINGW64_VERSION_MAJOR
-typedef int pid_t;
-#define hstrerror strerror
-#endif
-
-#define S_IFLNK    0120000 /* Symbolic link */
-#define S_ISLNK(x) (((x) & S_IFMT) == S_IFLNK)
-#define S_ISSOCK(x) 0
-
-#ifndef S_IRWXG
-#define S_IRGRP 0
-#define S_IWGRP 0
-#define S_IXGRP 0
-#define S_IRWXG (S_IRGRP | S_IWGRP | S_IXGRP)
-#endif
-#ifndef S_IRWXO
-#define S_IROTH 0
-#define S_IWOTH 0
-#define S_IXOTH 0
-#define S_IRWXO (S_IROTH | S_IWOTH | S_IXOTH)
-#endif
-
-#define S_ISUID 0004000
-#define S_ISGID 0002000
-#define S_ISVTX 0001000
-
-#define WIFEXITED(x) 1
-#define WIFSIGNALED(x) 0
-#define WEXITSTATUS(x) ((x) & 0xff)
-#define WTERMSIG(x) SIGTERM
-
-#ifndef EWOULDBLOCK
-#define EWOULDBLOCK EAGAIN
-#endif
-#ifndef ELOOP
-#define ELOOP EMLINK
-#endif
-#define SHUT_WR SD_SEND
-
-#define SIGHUP 1
-#define SIGQUIT 3
-#define SIGKILL 9
-#define SIGPIPE 13
-#define SIGALRM 14
-#define SIGCHLD 17
-
-#define F_GETFD 1
-#define F_SETFD 2
-#define FD_CLOEXEC 0x1
-
-#if !defined O_CLOEXEC && defined O_NOINHERIT
-#define O_CLOEXEC	O_NOINHERIT
-#endif
-
-#ifndef EAFNOSUPPORT
-#define EAFNOSUPPORT WSAEAFNOSUPPORT
-#endif
-#ifndef ECONNABORTED
-#define ECONNABORTED WSAECONNABORTED
-#endif
-#ifndef ENOTSOCK
-#define ENOTSOCK WSAENOTSOCK
-#endif
-
-struct passwd {
-	char *pw_name;
-	char *pw_gecos;
-	char *pw_dir;
-};
-
-typedef void (__cdecl *sig_handler_t)(int);
-struct sigaction {
-	sig_handler_t sa_handler;
-	unsigned sa_flags;
-};
-#define SA_RESTART 0
-
-struct itimerval {
-	struct timeval it_value, it_interval;
-};
-#define ITIMER_REAL 0
-
-struct utsname {
-	char sysname[16];
-	char nodename[1];
-	char release[16];
-	char version[16];
-	char machine[1];
-};
-
-/*
- * sanitize preprocessor namespace polluted by Windows headers defining
- * macros which collide with git local versions
- */
-#undef HELP_COMMAND /* from winuser.h */
-
-/*
- * trivial stubs
- */
-
-static inline int readlink(const char *path UNUSED, char *buf UNUSED, size_t bufsiz UNUSED)
-{ errno = ENOSYS; return -1; }
-static inline int symlink(const char *oldpath UNUSED, const char *newpath UNUSED)
-{ errno = ENOSYS; return -1; }
-static inline int fchmod(int fildes UNUSED, mode_t mode UNUSED)
-{ errno = ENOSYS; return -1; }
-#ifndef __MINGW64_VERSION_MAJOR
-static inline pid_t fork(void)
-{ errno = ENOSYS; return -1; }
-#endif
-static inline unsigned int alarm(unsigned int seconds UNUSED)
-{ return 0; }
-static inline int fsync(int fd)
-{ return _commit(fd); }
-static inline void sync(void)
-{}
-static inline uid_t getuid(void)
-{ return 1; }
-static inline struct passwd *getpwnam(const char *name UNUSED)
-{ return NULL; }
-static inline int fcntl(int fd UNUSED, int cmd, ...)
-{
-	if (cmd == F_GETFD || cmd == F_SETFD)
-		return 0;
-	errno = EINVAL;
-	return -1;
-}
-
-#define sigemptyset(x) (void)0
-static inline int sigaddset(sigset_t *set UNUSED, int signum UNUSED)
-{ return 0; }
-#define SIG_BLOCK 0
-#define SIG_UNBLOCK 0
-static inline int sigprocmask(int how UNUSED, const sigset_t *set UNUSED, sigset_t *oldset UNUSED)
-{ return 0; }
-static inline pid_t getppid(void)
-{ return 1; }
-static inline pid_t getpgid(pid_t pid)
-{ return pid == 0 ? getpid() : pid; }
-static inline pid_t tcgetpgrp(int fd UNUSED)
-{ return getpid(); }
-
-/*
- * simple adaptors
- */
-
-int mingw_mkdir(const char *path, int mode);
-#define mkdir mingw_mkdir
-
-#define WNOHANG 1
-pid_t waitpid(pid_t pid, int *status, int options);
-
-#define kill mingw_kill
-int mingw_kill(pid_t pid, int sig);
-
-#define locate_in_PATH mingw_locate_in_PATH
-char *mingw_locate_in_PATH(const char *cmd);
-
 #ifndef NO_OPENSSL
 #include <openssl/ssl.h>
 static inline int mingw_SSL_set_fd(SSL *ssl, int fd)
@@ -201,249 +26,6 @@ static inline int mingw_SSL_set_wfd(SSL *ssl, int fd)
 #define SSL_set_wfd mingw_SSL_set_wfd
 #endif
 
-/*
- * implementations of missing functions
- */
-
-int pipe(int filedes[2]);
-unsigned int sleep (unsigned int seconds);
-int mkstemp(char *template);
-int gettimeofday(struct timeval *tv, void *tz);
-#ifndef __MINGW64_VERSION_MAJOR
-struct tm *gmtime_r(const time_t *timep, struct tm *result);
-struct tm *localtime_r(const time_t *timep, struct tm *result);
-#endif
-int getpagesize(void);	/* defined in MinGW's libgcc.a */
-struct passwd *getpwuid(uid_t uid);
-int setitimer(int type, struct itimerval *in, struct itimerval *out);
-int sigaction(int sig, struct sigaction *in, struct sigaction *out);
-int link(const char *oldpath, const char *newpath);
-int uname(struct utsname *buf);
-
-/*
- * replacements of existing functions
- */
-
-int mingw_unlink(const char *pathname);
-#define unlink mingw_unlink
-
-int mingw_rmdir(const char *path);
-#define rmdir mingw_rmdir
-
-int mingw_open (const char *filename, int oflags, ...);
-#define open mingw_open
-#undef OPEN_RETURNS_EINTR
-
-int mingw_fgetc(FILE *stream);
-#define fgetc mingw_fgetc
-
-FILE *mingw_fopen (const char *filename, const char *otype);
-#define fopen mingw_fopen
-
-FILE *mingw_freopen (const char *filename, const char *otype, FILE *stream);
-#define freopen mingw_freopen
-
-int mingw_fflush(FILE *stream);
-#define fflush mingw_fflush
-
-ssize_t mingw_write(int fd, const void *buf, size_t len);
-#define write mingw_write
-
-int mingw_access(const char *filename, int mode);
-#undef access
-#define access mingw_access
-
-int mingw_chdir(const char *dirname);
-#define chdir mingw_chdir
-
-int mingw_chmod(const char *filename, int mode);
-#define chmod mingw_chmod
-
-char *mingw_mktemp(char *template);
-#define mktemp mingw_mktemp
-
-char *mingw_getcwd(char *pointer, int len);
-#define getcwd mingw_getcwd
-
-#ifdef NO_UNSETENV
-#error "NO_UNSETENV is incompatible with the Windows-specific startup code!"
-#endif
-
-/*
- * We bind *env() routines (even the mingw_ ones) to private mingw_ versions.
- * These talk to the CRT using UNICODE/wchar_t, but maintain the original
- * narrow-char API.
- *
- * Note that the MSCRT maintains both ANSI (getenv()) and UNICODE (_wgetenv())
- * routines and stores both versions of each environment variable in parallel
- * (and secretly updates both when you set one or the other), but it uses CP_ACP
- * to do the conversion rather than CP_UTF8.
- *
- * Since everything in the git code base is UTF8, we define the mingw_ routines
- * to access the CRT using the UNICODE routines and manually convert them to
- * UTF8.  This also avoids round-trip problems.
- *
- * This also helps with our linkage, since "_wenviron" is publicly exported
- * from the CRT.  But to access "_environ" we would have to statically link
- * to the CRT (/MT).
- *
- * We require NO_SETENV (and let gitsetenv() call our mingw_putenv).
- */
-#define getenv       mingw_getenv
-#define putenv       mingw_putenv
-#define unsetenv     mingw_putenv
-char *mingw_getenv(const char *name);
-int   mingw_putenv(const char *name);
-
-int mingw_gethostname(char *host, int namelen);
-#define gethostname mingw_gethostname
-
-struct hostent *mingw_gethostbyname(const char *host);
-#define gethostbyname mingw_gethostbyname
-
-int mingw_getaddrinfo(const char *node, const char *service,
-		      const struct addrinfo *hints, struct addrinfo **res);
-#define getaddrinfo mingw_getaddrinfo
-
-int mingw_socket(int domain, int type, int protocol);
-#define socket mingw_socket
-
-int mingw_connect(int sockfd, struct sockaddr *sa, size_t sz);
-#define connect mingw_connect
-
-int mingw_bind(int sockfd, struct sockaddr *sa, size_t sz);
-#define bind mingw_bind
-
-int mingw_setsockopt(int sockfd, int lvl, int optname, void *optval, int optlen);
-#define setsockopt mingw_setsockopt
-
-int mingw_shutdown(int sockfd, int how);
-#define shutdown mingw_shutdown
-
-int mingw_listen(int sockfd, int backlog);
-#define listen mingw_listen
-
-int mingw_accept(int sockfd, struct sockaddr *sa, socklen_t *sz);
-#define accept mingw_accept
-
-int mingw_rename(const char*, const char*);
-#define rename mingw_rename
-
-#if defined(USE_WIN32_MMAP) || defined(_MSC_VER)
-int mingw_getpagesize(void);
-#define getpagesize mingw_getpagesize
-#endif
-
-int win32_fsync_no_flush(int fd);
-#define fsync_no_flush win32_fsync_no_flush
-
-#define FSYNC_COMPONENTS_PLATFORM_DEFAULT (FSYNC_COMPONENTS_DEFAULT | FSYNC_COMPONENT_LOOSE_OBJECT)
-#define FSYNC_METHOD_DEFAULT (FSYNC_METHOD_BATCH)
-
-struct rlimit {
-	unsigned int rlim_cur;
-};
-#define RLIMIT_NOFILE 0
-
-static inline int getrlimit(int resource, struct rlimit *rlp)
-{
-	if (resource != RLIMIT_NOFILE) {
-		errno = EINVAL;
-		return -1;
-	}
-
-	rlp->rlim_cur = 2048;
-	return 0;
-}
-
-/*
- * Use mingw specific stat()/lstat()/fstat() implementations on Windows,
- * including our own struct stat with 64 bit st_size and nanosecond-precision
- * file times.
- */
-#ifndef __MINGW64_VERSION_MAJOR
-#define off_t off64_t
-#define lseek _lseeki64
-#ifndef _MSC_VER
-struct timespec {
-	time_t tv_sec;
-	long tv_nsec;
-};
-#endif
-#endif
-
-struct mingw_stat {
-    _dev_t st_dev;
-    _ino_t st_ino;
-    _mode_t st_mode;
-    short st_nlink;
-    short st_uid;
-    short st_gid;
-    _dev_t st_rdev;
-    off64_t st_size;
-    struct timespec st_atim;
-    struct timespec st_mtim;
-    struct timespec st_ctim;
-};
-
-#define st_atime st_atim.tv_sec
-#define st_mtime st_mtim.tv_sec
-#define st_ctime st_ctim.tv_sec
-
-#ifdef stat
-#undef stat
-#endif
-#define stat mingw_stat
-int mingw_lstat(const char *file_name, struct stat *buf);
-int mingw_stat(const char *file_name, struct stat *buf);
-int mingw_fstat(int fd, struct stat *buf);
-#ifdef fstat
-#undef fstat
-#endif
-#define fstat mingw_fstat
-#ifdef lstat
-#undef lstat
-#endif
-#define lstat mingw_lstat
-
-
-int mingw_utime(const char *file_name, const struct utimbuf *times);
-#define utime mingw_utime
-size_t mingw_strftime(char *s, size_t max,
-		   const char *format, const struct tm *tm);
-#define strftime mingw_strftime
-
-pid_t mingw_spawnvpe(const char *cmd, const char **argv, char **env,
-		     const char *dir,
-		     int fhin, int fhout, int fherr);
-int mingw_execvp(const char *cmd, char *const *argv);
-#define execvp mingw_execvp
-int mingw_execv(const char *cmd, char *const *argv);
-#define execv mingw_execv
-
-static inline unsigned int git_ntohl(unsigned int x)
-{ return (unsigned int)ntohl(x); }
-#define ntohl git_ntohl
-
-sig_handler_t mingw_signal(int sig, sig_handler_t handler);
-#define signal mingw_signal
-
-int mingw_raise(int sig);
-#define raise mingw_raise
-
-/*
- * ANSI emulation wrappers
- */
-
-int winansi_isatty(int fd);
-#define isatty winansi_isatty
-
-int winansi_dup2(int oldfd, int newfd);
-#define dup2 winansi_dup2
-
-void winansi_init(void);
-HANDLE winansi_get_osfhandle(int fd);
-
 /*
  * git specific compatibility
  */
@@ -457,12 +39,6 @@ static inline void convert_slashes(char *path)
 #define PATH_SEP ';'
 char *mingw_query_user_email(void);
 #define query_user_email mingw_query_user_email
-#if !defined(__MINGW64_VERSION_MAJOR) && (!defined(_MSC_VER) || _MSC_VER < 1800)
-#define PRIuMAX "I64u"
-#define PRId64 "I64d"
-#else
-#include <inttypes.h>
-#endif
 
 /**
  * Verifies that the specified path is owned by the user running the
diff --git a/compat/msvc-posix.h b/compat/msvc-posix.h
new file mode 100644
index 00000000000..c500b8b4aaf
--- /dev/null
+++ b/compat/msvc-posix.h
@@ -0,0 +1,33 @@
+#ifndef COMPAT_MSVC_POSIX_H
+#define COMPAT_MSVC_POSIX_H
+
+#include <direct.h>
+#include <process.h>
+#include <malloc.h>
+#include <io.h>
+
+#pragma warning(disable: 4018) /* signed/unsigned comparison */
+#pragma warning(disable: 4244) /* type conversion, possible loss of data */
+#pragma warning(disable: 4090) /* 'function' : different 'const' qualifiers (ALLOC_GROW etc.)*/
+
+/* porting function */
+#define inline __inline
+#define __inline__ __inline
+#define __attribute__(x)
+#define strcasecmp   _stricmp
+#define strncasecmp  _strnicmp
+#define ftruncate    _chsize
+#define strtoull     _strtoui64
+#define strtoll      _strtoi64
+
+#undef ERROR
+
+#define ftello _ftelli64
+
+typedef int sigset_t;
+/* open for reading, writing, or both (not in fcntl.h) */
+#define O_ACCMODE     (_O_RDONLY | _O_WRONLY | _O_RDWR)
+
+#include "mingw-posix.h"
+
+#endif /* COMPAT_MSVC_POSIX_H */
diff --git a/compat/msvc.h b/compat/msvc.h
index 1d7a8c61456..2b87c0a7c70 100644
--- a/compat/msvc.h
+++ b/compat/msvc.h
@@ -1,33 +1,7 @@
 #ifndef __MSVC__HEAD
 #define __MSVC__HEAD
 
-#include <direct.h>
-#include <process.h>
-#include <malloc.h>
-#include <io.h>
-
-#pragma warning(disable: 4018) /* signed/unsigned comparison */
-#pragma warning(disable: 4244) /* type conversion, possible loss of data */
-#pragma warning(disable: 4090) /* 'function' : different 'const' qualifiers (ALLOC_GROW etc.)*/
-
-/* porting function */
-#define inline __inline
-#define __inline__ __inline
-#define __attribute__(x)
-#define strcasecmp   _stricmp
-#define strncasecmp  _strnicmp
-#define ftruncate    _chsize
-#define strtoull     _strtoui64
-#define strtoll      _strtoi64
-
-#undef ERROR
-
-#define ftello _ftelli64
-
-typedef int sigset_t;
-/* open for reading, writing, or both (not in fcntl.h) */
-#define O_ACCMODE     (_O_RDONLY | _O_WRONLY | _O_RDWR)
-
-#include "compat/mingw.h"
+#include "msvc-posix.h"
+#include "mingw.h"
 
 #endif

-- 
2.48.1.666.gff9fcf71b7.dirty

