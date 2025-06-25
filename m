Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0681320CCDC
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 07:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750836935; cv=none; b=Z2RIiWFnrE03L8YkZhx12vmo9Vf2VGfxFgu8GnL4Sa6uFLzCUjgOwtMHVWVaepAoXUafsabWGnlfeZHJp1IXKq/MfxdC76KyaeBluk4oO+h6HL2yqaimzybtmbKD2E9YluIDZIk0R0ZLd/RvKmkX57EwZBfTQ/YRtQdfAz60L4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750836935; c=relaxed/simple;
	bh=SiLUMu0HQXuLVYNu4PYqU6lODmo4sSE7WJv8P/B5Vtk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=QvjIm8oIANbjVRwTTCU35jRMBcD/dTqmjcWkxgS3Emez9r7C4DI0J9xa5SyD8tLxOunT1fmObp4DRIJ8vln2Fq5mFSoKIDB4yYZQx2jp6eVTbmdRcO/ywME0ozud5WV0jE8h2hd0Gnjj05FD0qjtQCK+CFsMJUQsGbmZEzGK4c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRB51uK9; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRB51uK9"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a52874d593so5969160f8f.0
        for <git@vger.kernel.org>; Wed, 25 Jun 2025 00:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750836931; x=1751441731; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49ePsGZyC/YGkB6w+Vary3M6/qV1bui3UyBKlnZGbxo=;
        b=CRB51uK9jhdnxZWR3wkddkTOigY9t9zFAsjyTyIcMHtOS/zAhcSN8B8weIfqcgXHuo
         qc9fWoWFild4QIhnDtXrq5Fo0bRYfptwbIcdToWjZg9TTOsKmEO7c++UwIR3+vVqrQ8l
         CsFTR5SuNq7qiBVJ/JqNLUNl1YagIjj/0HOnjtPCq/Cr73RUEBmDsOCTjrPpZu3YhzFk
         hGpzAlGii35C/4/4y8eXm6J65dpz6YyX2hFJyKMRmIFjLTZO5yZTsqUZ06qdqQThuWrf
         N09vOUQ3jJ6tWAtHsKLTac3sA+Muff8VxiIKYLzYPhvVcHQfW1kyAYPledg7B97EqFRO
         nWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750836931; x=1751441731;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=49ePsGZyC/YGkB6w+Vary3M6/qV1bui3UyBKlnZGbxo=;
        b=SpfT6N6e7ie97BkHTCXBhtpWxfVGSFibxp/AuhszEXWGjYOqEcGPGK+eJZ6j233GKF
         KWvB+7Pgxkjibc7Q9LBGiXJA03+GU9cwK4KAzyL5IaxgAxdN77+rqpnYArne3UeWZvj3
         HNm70giisd5l/uVEtNXCWw4qs1U3ME4uK8yQr8R3ebknCyquNh8ikF4ND4W7DOwJURTg
         5H9U+pxkIP7KLoXBOjISPUWl2z9mSyWB0VcroQ+5D/WKJhiR/mW/L/CA+mipzOkIV+wi
         OiFJEMTPEPl1av3qifBQab8td/NSFPQgkvHaaNUG9VkfwMxQtybuCHl1Glr6MRSaGPBu
         Fc/g==
X-Gm-Message-State: AOJu0YxC0QJSWyCZlg57pobrbR0tX+nr8Bzb8OC5HBWnC23hWj+DgpXs
	WX5OaWcWFz2YUGFkk6LmShllpZyXyqd6WPatW3MAcuSeK0xlajVOtAKHOyed3w==
X-Gm-Gg: ASbGnctO6PGrrDFpSqnASl5M3vSkRJivAlI3lM+t7YfE82uKfbIVsv5ovobgFArMMxW
	hbwvufdcoyOoZPTgwek7lv+P4khqDDV8jgC2PnhPi2+H2/gs2WNd4XL0hggNWRbbGtZGGR02O9J
	GjbHLycc44J5w7UmLrHNUltvzlpab7jY4HvMCdMmk1i+V67kuBicjvb66wBG1g5qAV2k40KmtUI
	x3TK3qvNOwZRDa9alpTQToLAzWLQvswQuRXXLSO1rNxFjI20qcAdmFEKCKqXdvqCPj+XBqDKJSj
	xg+XCdcx40OMwftWNbcUGzVsgwIh7pAR5VnI+QxVHQMV+/GH30cFt4Fs4sVwCBU=
X-Google-Smtp-Source: AGHT+IGBRfvKqoT7rD4pFkiI9QTkfwY32SVlElik1HWS92SqShVzWFMKh8txQ7bP3Rt9bzgjv9j9iQ==
X-Received: by 2002:a05:6000:2705:b0:3a4:e1e1:7779 with SMTP id ffacd0b85a97d-3a6ed637ae3mr709263f8f.32.1750836930389;
        Wed, 25 Jun 2025 00:35:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e8050e09sm3904314f8f.19.2025.06.25.00.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 00:35:29 -0700 (PDT)
Message-Id: <pull.2002.v2.git.git.1750836928.gitgitgadget@gmail.com>
In-Reply-To: <pull.2002.git.git.1750774122.gitgitgadget@gmail.com>
References: <pull.2002.git.git.1750774122.gitgitgadget@gmail.com>
From: "Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Jun 2025 07:35:25 +0000
Subject: [PATCH v2 0/3] daemon: explicitly allow EINTR during poll()
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= <carenas@gmail.com>

This series addresses and ambiguity that is at least visible in OpenBSD,
where zombie proceses would only be cleared after a new connection is
received.

The underlying problem is that when this code was originally introduced,
SA_RESTART was not widely implemented, and the signal() call usually
implemented SysV like semantics, at least until it started being
reimplemented by calling sigaction() internally.

Changes since v1

 * Almost all references to siginterrupt has been removed and a better named
   variable used instead
 * Changes had been anstracted to minimize ifdefs and their introduction
   staged more naturally

Carlo Marcelo Arenas Belón (3):
  compat/posix.h: track SA_RESTART fallback
  daemon: use sigaction() to install child_handler()
  daemon: explicitly allow EINTR during poll()

 Makefile             |  6 +++++
 compat/mingw-posix.h |  1 -
 compat/posix.h       |  8 +++++++
 config.mak.uname     |  7 +++---
 configure.ac         | 17 +++++++++++++++
 daemon.c             | 52 +++++++++++++++++++++++++++++++++++++++-----
 meson.build          |  4 ++++
 7 files changed, 85 insertions(+), 10 deletions(-)


base-commit: cb3b40381e1d5ee32dde96521ad7cfd68eb308a6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2002%2Fcarenas%2Fsiginterrupt-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2002/carenas/siginterrupt-v2
Pull-Request: https://github.com/git/git/pull/2002

Range-diff vs v1:

 1:  2b5a58e53ac ! 1:  e82b7425bbc compat/posix.h: track SA_RESTART fallback
     @@ Metadata
       ## Commit message ##
          compat/posix.h: track SA_RESTART fallback
      
     -    Systems without SA_RESTART where using custom CFLAGS instead of
     -    the standard header file.
     +    Systems without SA_RESTART are using custom CFLAGS or headers
     +    instead of the standard header file.
      
     -    Consolidate that, so it will be easier to use in a future commit.
     +    Correct that, and invent a Makefile variable to track the
     +    exceptions which will become handy in the next commits.
      
          Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
      
     + ## Makefile ##
     +@@ Makefile: include shared.mak
     + # when attempting to read from an fopen'ed directory (or even to fopen
     + # it at all).
     + #
     ++# Define USE_NON_POSIX_SIGNAL if don't have support for SA_RESTART or
     ++# prefer to use ANSI C signal() over POSIX sigaction()
     ++#
     + # Define OPEN_RETURNS_EINTR if your open() system call may return EINTR
     + # when a signal is received (as opposed to restarting).
     + #
     +@@ Makefile: ifdef FREAD_READS_DIRECTORIES
     + 	COMPAT_CFLAGS += -DFREAD_READS_DIRECTORIES
     + 	COMPAT_OBJS += compat/fopen.o
     + endif
     ++ifdef USE_NON_POSIX_SIGNAL
     ++	COMPAT_CFLAGS += -DUSE_NON_POSIX_SIGNAL
     ++endif
     + ifdef OPEN_RETURNS_EINTR
     + 	COMPAT_CFLAGS += -DOPEN_RETURNS_EINTR
     + endif
     +
     + ## compat/mingw-posix.h ##
     +@@ compat/mingw-posix.h: struct sigaction {
     + 	sig_handler_t sa_handler;
     + 	unsigned sa_flags;
     + };
     +-#define SA_RESTART 0
     + 
     + struct itimerval {
     + 	struct timeval it_value, it_interval;
     +
       ## compat/posix.h ##
      @@ compat/posix.h: char *gitdirname(char *);
       #define NAME_MAX 255
       #endif
       
     -+/* On most systems <signal.h> would have given us this, but
     ++/*
     ++ * On most systems <signal.h> would have given us this, but
      + * not on some systems (e.g. NonStop, QNX).
      + */
      +#ifndef SA_RESTART
     -+#define SA_RESTART 0	/* disabled for sigaction() */
     ++# define SA_RESTART 0	/* disabled for sigaction() */
      +#endif
      +
       typedef uintmax_t timestamp_t;
     @@ compat/posix.h: char *gitdirname(char *);
       #define parse_timestamp strtoumax
      
       ## config.mak.uname ##
     +@@ config.mak.uname: ifeq ($(uname_S),Windows)
     + 	NO_STRTOUMAX = YesPlease
     + 	NO_MKDTEMP = YesPlease
     + 	NO_INTTYPES_H = YesPlease
     ++	USE_NON_POSIX_SIGNAL = YesPlease
     + 	CSPRNG_METHOD = rtlgenrandom
     + 	# VS2015 with UCRT claims that snprintf and friends are C99 compliant,
     + 	# so we don't need this:
      @@ config.mak.uname: ifeq ($(uname_S),NONSTOP_KERNEL)
       	FREAD_READS_DIRECTORIES = UnfortunatelyYes
       
     @@ config.mak.uname: ifeq ($(uname_S),NONSTOP_KERNEL)
       	# Apparently needed in compat/fnmatch/fnmatch.c.
       	COMPAT_CFLAGS += -DHAVE_STRING_H=1
       	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
     +@@ config.mak.uname: ifeq ($(uname_S),NONSTOP_KERNEL)
     + 	NO_MMAP = YesPlease
     + 	NO_POLL = YesPlease
     + 	NO_INTPTR_T = UnfortunatelyYes
     ++	USE_NON_POSIX_SIGNAL = UnfortunatelyYes
     + 	CSPRNG_METHOD = openssl
     + 	SANE_TOOL_PATH = /usr/coreutils/bin:/usr/local/bin
     + 	SHELL_PATH = /usr/coreutils/bin/bash
     +@@ config.mak.uname: ifeq ($(uname_S),MINGW)
     + 	NEEDS_LIBICONV = YesPlease
     + 	NO_STRTOUMAX = YesPlease
     + 	NO_MKDTEMP = YesPlease
     ++	USE_NON_POSIX_SIGNAL = YesPlease
     + 	NO_SVN_TESTS = YesPlease
     + 
     + 	# The builtin FSMonitor requires Named Pipes and Threads on Windows.
      @@ config.mak.uname: ifeq ($(uname_S),MINGW)
               endif
       endif
     @@ config.mak.uname: ifeq ($(uname_S),MINGW)
       	EXPAT_NEEDS_XMLPARSE_H = YesPlease
       	HAVE_STRINGS_H = YesPlease
       	NEEDS_SOCKET = YesPlease
     +@@ config.mak.uname: ifeq ($(uname_S),QNX)
     + 	NO_PTHREADS = YesPlease
     + 	NO_STRCASESTR = YesPlease
     + 	NO_STRLCPY = YesPlease
     ++	USE_NON_POSIX_SIGNAL = UnfortunatelyYes
     + endif
     +
     + ## configure.ac ##
     +@@ configure.ac: fi
     + GIT_CONF_SUBST([ICONV_OMITS_BOM])
     + fi
     + 
     ++# Define USE_NON_POSIX_SIGNAL if don't have support for SA_RESTART or
     ++# prefer using ANSI C signal() over POSIX sigaction()
     ++
     ++AC_CACHE_CHECK([whether SA_RESTART is supported], [ac_cv_siginterrupt], [
     ++	AC_COMPILE_IFELSE(
     ++		[AC_LANG_PROGRAM([#include <signal.h>], [[
     ++		#ifdef SA_RESTART
     ++		#endif
     ++		siginterrupt(SIGCHLD, 1)
     ++		]])],[ac_cv_siginterrupt=yes],[
     ++			ac_cv_siginterrupt=no
     ++			USE_NON_POSIX_SIGNAL=UnfortunatelyYes
     ++		]
     ++	)
     ++])
     ++GIT_CONF_SUBST([USE_NON_POSIX_SIGNAL])
     ++
     + ## Checks for typedefs, structures, and compiler characteristics.
     + AC_MSG_NOTICE([CHECKS for typedefs, structures, and compiler characteristics])
     + #
     +
     + ## meson.build ##
     +@@ meson.build: else
     +   build_options_config.set('NO_EXPAT', '1')
     + endif
     + 
     ++if compiler.get_define('SA_RESTART', prefix: '#include <signal.h>') == ''
     ++  libgit_c_args += '-DUSE_NON_POSIX_SIGNAL'
     ++endif
     ++
     + if not compiler.has_header('sys/select.h')
     +   libgit_c_args += '-DNO_SYS_SELECT_H'
     + endif
 2:  2e8c4643a60 ! 2:  05d945aa1e5 daemon: use sigaction() to install child_handler()
     @@ Commit message
          In a future change, the flags used for processing SIGCHLD will need to
          be updated, which is only possible by using sigaction().
      
     -    Replace the call, which hs the added benefit of using BSD semantics
     -    reliably and therefore not needing the rearming call.
     +    Factor out the call to set the signal handler and use sigaction instead
     +    of signal for the systems that allow that, which has the added benefit
     +    of using BSD semantics reliably and therefore not needing the rearming
     +    call.
      
          Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
      
       ## daemon.c ##
     -@@ daemon.c: static void child_handler(int signo UNUSED)
     +@@ daemon.c: static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
     + 		add_child(&cld, addr, addrlen);
     + }
     + 
     +-static void child_handler(int signo UNUSED)
     ++static void child_handler(int signo MAYBE_UNUSED)
     + {
       	/*
     - 	 * Otherwise empty handler because systemcalls will get interrupted
     - 	 * upon signal receipt
     +-	 * Otherwise empty handler because systemcalls will get interrupted
     +-	 * upon signal receipt
      -	 * SysV needs the handler to be rearmed
     ++	 * Otherwise empty handler because systemcalls should get interrupted
     ++	 * upon signal receipt.
       	 */
      -	signal(SIGCHLD, child_handler);
     ++#ifdef USE_NON_POSIX_SIGNAL
     ++	/*
     ++	 * SysV needs the handler to be rearmed, but this is known
     ++	 * to trigger infinite recursion crashes at least in AIX.
     ++	 */
     ++	signal(signo, child_handler);
     ++#endif
       }
       
       static int set_reuse_addr(int sockfd)
      @@ daemon.c: static void socksetup(struct string_list *listen_addr, int listen_port, struct s
     + 	}
     + }
     + 
     ++#ifndef USE_NON_POSIX_SIGNAL
     ++
     ++static void set_signal_handler(struct sigaction *psa)
     ++{
     ++	sigemptyset(&psa->sa_mask);
     ++	psa->sa_flags = SA_NOCLDSTOP | SA_RESTART;
     ++	psa->sa_handler = child_handler;
     ++	sigaction(SIGCHLD, psa, NULL);
     ++}
     ++
     ++#else
     ++
     ++static void set_signal_handler(struct sigaction *psa UNUSED)
     ++{
     ++	signal(SIGCHLD, child_handler);
     ++}
     ++
       static int service_loop(struct socketlist *socklist)
       {
     - 	struct pollfd *pfd;
      +	struct sigaction sa;
     + 	struct pollfd *pfd;
       
       	CALLOC_ARRAY(pfd, socklist->nr);
     - 
      @@ daemon.c: static int service_loop(struct socketlist *socklist)
       		pfd[i].events = POLLIN;
       	}
       
      -	signal(SIGCHLD, child_handler);
     -+	sigemptyset(&sa.sa_mask);
     -+	sa.sa_flags = SA_NOCLDSTOP | SA_RESTART;
     -+	sa.sa_handler = child_handler;
     -+	sigaction(SIGCHLD, &sa, NULL);
     ++	set_signal_handler(&sa);
       
       	for (;;) {
       		check_dead_children();
 3:  a450bdb0066 ! 3:  b737e0389df daemon: explicitly allow EINTR during poll()
     @@ Commit message
          might not return with -1 and set errno to EINTR when a signal is
          received.
      
     -    Since the logic to reap zombie childs relies om those interruptions
     +    Since the logic to reap zombie childs relies on those interruptions
          make sure to explicitly disable SA_RESTART around this function.
      
     -    Add a Makefile flag for portability to systems that don't have the
     -    functionality to change those flags or where it is not needed.
     -
          Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
      
     - ## Makefile ##
     -@@ Makefile: include shared.mak
     - # Define NO_PREAD if you have a problem with pread() system call (e.g.
     - # cygwin1.dll before v1.5.22).
     - #
     -+# Define NO_SIGINTERRUPT if you don't have siginterrupt() or SA_RESTART
     -+# or if your signal(SIGCHLD) implementation doesn't set SA_RESTART.
     -+#
     - # Define NO_SETITIMER if you don't have setitimer()
     - #
     - # Define NO_STRUCT_ITIMERVAL if you don't have struct itimerval
     -@@ Makefile: ifdef NO_PREAD
     - 	COMPAT_CFLAGS += -DNO_PREAD
     - 	COMPAT_OBJS += compat/pread.o
     - endif
     -+ifdef NO_SIGINTERRUPT
     -+	COMPAT_CFLAGS += -DNO_SIGINTERRUPT
     -+endif
     - ifdef NO_FAST_WORKING_DIRECTORY
     - 	BASIC_CFLAGS += -DNO_FAST_WORKING_DIRECTORY
     - endif
     -
     - ## config.mak.uname ##
     -@@ config.mak.uname: ifeq ($(uname_S),Windows)
     - 	NO_STRTOUMAX = YesPlease
     - 	NO_MKDTEMP = YesPlease
     - 	NO_INTTYPES_H = YesPlease
     -+	NO_SIGINTERRUPT = YesPlease
     - 	CSPRNG_METHOD = rtlgenrandom
     - 	# VS2015 with UCRT claims that snprintf and friends are C99 compliant,
     - 	# so we don't need this:
     -@@ config.mak.uname: ifeq ($(uname_S),NONSTOP_KERNEL)
     - 	NO_PREAD = YesPlease
     - 	NO_MMAP = YesPlease
     - 	NO_POLL = YesPlease
     -+	NO_SIGINTERRUPT = UnfortunatelyYes
     - 	NO_INTPTR_T = UnfortunatelyYes
     - 	CSPRNG_METHOD = openssl
     - 	SANE_TOOL_PATH = /usr/coreutils/bin:/usr/local/bin
     -@@ config.mak.uname: ifeq ($(uname_S),MINGW)
     - 	NEEDS_LIBICONV = YesPlease
     - 	NO_STRTOUMAX = YesPlease
     - 	NO_MKDTEMP = YesPlease
     -+	NO_SIGINTERRUPT = YesPlease
     - 	NO_SVN_TESTS = YesPlease
     - 
     - 	# The builtin FSMonitor requires Named Pipes and Threads on Windows.
     -@@ config.mak.uname: ifeq ($(uname_S),QNX)
     - 	NO_PTHREADS = YesPlease
     - 	NO_STRCASESTR = YesPlease
     - 	NO_STRLCPY = YesPlease
     -+	NO_SIGINTERRUPT = UnfortunatelyYes
     - endif
     -
     - ## configure.ac ##
     -@@ configure.ac: GIT_CHECK_FUNC(getdelim,
     - [HAVE_GETDELIM=])
     - GIT_CONF_SUBST([HAVE_GETDELIM])
     - #
     -+# Define NO_SIGINTERRUPT if you don't have siginterrupt.
     -+GIT_CHECK_FUNC(siginterrupt,
     -+[NO_SIGINTERRUPT=],
     -+[NO_SIGINTERRUPT=YesPlease])
     -+GIT_CONF_SUBST([NO_SIGINTERRUPT])
     - #
     - # Define NO_MMAP if you want to avoid mmap.
     - #
     -
       ## daemon.c ##
     -@@ daemon.c: static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
     - 		add_child(&cld, addr, addrlen);
     +@@ daemon.c: static void set_signal_handler(struct sigaction *psa)
     + 	sigaction(SIGCHLD, psa, NULL);
       }
       
     --static void child_handler(int signo UNUSED)
     -+static void child_handler(int signo)
     - {
     - 	/*
     --	 * Otherwise empty handler because systemcalls will get interrupted
     --	 * upon signal receipt
     -+	 * Empty handler because systemcalls should get interrupted
     -+	 * upon signal receipt.
     - 	 */
     -+#ifdef NO_SIGINTERRUPT
     -+	/* SysV needs the handler to be rearmed */
     -+	signal(signo, child_handler);
     -+#endif
     ++static void set_sa_restart(struct sigaction *psa, int enable)
     ++{
     ++	if (enable)
     ++		psa->sa_flags |= SA_RESTART;
     ++	else
     ++		psa->sa_flags &= ~SA_RESTART;
     ++	sigaction(SIGCHLD, psa, NULL);
     ++}
     ++
     + #else
     + 
     + static void set_signal_handler(struct sigaction *psa UNUSED)
     +@@ daemon.c: static void set_signal_handler(struct sigaction *psa UNUSED)
     + 	signal(SIGCHLD, child_handler);
       }
       
     - static int set_reuse_addr(int sockfd)
     -@@ daemon.c: static void socksetup(struct string_list *listen_addr, int listen_port, struct s
     - 
     ++static void set_sa_restart(struct sigaction *psa UNUSED, int enable UNUSED)
     ++{
     ++}
     ++
     ++#endif
     ++
       static int service_loop(struct socketlist *socklist)
       {
     --	struct pollfd *pfd;
     -+#ifndef NO_SIGINTERRUPT
       	struct sigaction sa;
     -+#endif
     -+	struct pollfd *pfd;
     - 
     - 	CALLOC_ARRAY(pfd, socklist->nr);
     - 
      @@ daemon.c: static int service_loop(struct socketlist *socklist)
     - 		pfd[i].events = POLLIN;
     - 	}
     - 
     -+#ifdef NO_SIGINTERRUPT
     -+	signal(SIGCHLD, child_handler);
     -+#else
     - 	sigemptyset(&sa.sa_mask);
     - 	sa.sa_flags = SA_NOCLDSTOP | SA_RESTART;
     - 	sa.sa_handler = child_handler;
     - 	sigaction(SIGCHLD, &sa, NULL);
     -+#endif
     - 
       	for (;;) {
       		check_dead_children();
       
     -+#ifndef NO_SIGINTERRUPT
     -+		sa.sa_flags &= ~SA_RESTART;
     -+		sigaction(SIGCHLD, &sa, NULL);
     -+#endif
     ++		set_sa_restart(&sa, 0);
       		if (poll(pfd, socklist->nr, -1) < 0) {
       			if (errno != EINTR) {
       				logerror("Poll failed, resuming: %s",
     @@ daemon.c: static int service_loop(struct socketlist *socklist)
       			}
       			continue;
       		}
     -+#ifndef NO_SIGINTERRUPT
     -+		sa.sa_flags |= SA_RESTART;
     -+		sigaction(SIGCHLD, &sa, NULL);
     -+#endif
     ++		set_sa_restart(&sa, 1);
       
       		for (size_t i = 0; i < socklist->nr; i++) {
       			if (pfd[i].revents & POLLIN) {
     -
     - ## meson.build ##
     -@@ meson.build: checkfuncs = {
     -   'setenv' : ['setenv.c'],
     -   'mkdtemp' : ['mkdtemp.c'],
     -   'initgroups' : [],
     -+  'siginterrupt' : [],
     -   'strtoumax' : ['strtoumax.c', 'strtoimax.c'],
     -   'pread' : ['pread.c'],
     - }

-- 
gitgitgadget
