From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 10/14] Make usage of windows.h lean and mean
Date: Tue, 15 Sep 2009 15:44:13 +0200
Message-ID: <606db5a89cc49818fa225312a3bb6dbda18867a6.1253021728.git.mstormo@gmail.com>
References: <cover.1253021221.git.mstormo@gmail.com> <213f3c7799721c3f42ffa689498175f0495048eb.1253021728.git.mstormo@gmail.com> <26c067500d8adf17a2d75e2956e4d4a6cef27fc1.1253021728.git.mstormo@gmail.com> <6e6345fb3fbc19b1a2467e33e1633fe9025e547b.1253021728.git.mstormo@gmail.com> <badc5d24387c28c752a45f75e8aec6bce64f81fe.1253021728.git.mstormo@gmail.com> <8368a0b347c01e7ddb5e5b514a46e55dd6f0daf7.1253021728.git.mstormo@gmail.com> <ffd7cfd6114f08c6502b21140d56d9bcd5d2a554.1253021728.git.mstormo@gmail.com> <4924c3de4fa490d1f41b75d18864f0a57fbd0eda.1253021728.git.mstormo@gmail.com> <88c817f030cfcc1e3b9e08f80d7ccfbcdfad7ecb.1253021728.git.mstormo@gmail.com> <8bcd4b022f59a5f55b63f87c9cf6a4dadc71cc44.1253021728.git.mstormo@gmail.com>
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com, raa.lkml@gmail.com, snaury@gmail.com, Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes.Schindelin@gmx.de
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Sep 15 15:45:27 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f137.google.com ([209.85.210.137])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnYLS-0007FX-TO
	for gcvm-msysgit@m.gmane.org; Tue, 15 Sep 2009 15:45:23 +0200
Received: by mail-yx0-f137.google.com with SMTP id 1so7426650yxe.21
        for <gcvm-msysgit@m.gmane.org>; Tue, 15 Sep 2009 06:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=7jQtNNGln6F52vncUmRqpDQrii+ROjXNhBc4hp07ub4=;
        b=Vq0mxyzejlhWSKmrFiU873su/WrjV04pppsyyhmm74MyJZMluNpQ2Rlk5ib3CJPsrn
         HH3R6wWAu1rWekEH9zLWZwbr12mGxKXwjweUZ5fpmhLFEO7EDMtWJpM7u8UP4yl/jRyP
         QI9i6QGKQztu20/Vb84gjyjkZ7FWCZxROCZxM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=EOjH30Y5iSX7rwD7tO/jvnKtLs8Cq4jrbd9/nk/K01ZYSGXY2I+vDa5yMesiifZq4I
         tOEFaIJoCo0Le0i1r8G9HycBll3Mk2CSkjPdMp5uhzzi6t0cM6TeC3Sx1oYg2dJlByDQ
         X37kjspsOZ1Pw+rAIoCDsrZAdOfB8GGlZ8LhQ=
Received: by 10.100.240.3 with SMTP id n3mr1742258anh.17.1253022304868;
        Tue, 15 Sep 2009 06:45:04 -0700 (PDT)
Received: by 10.177.111.12 with SMTP id o12gr7016yqm.0;
	Tue, 15 Sep 2009 06:44:53 -0700 (PDT)
X-Sender: mstormo@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.160.14 with SMTP id i14mr1256988ebe.26.1253022292239; Tue, 15 Sep 2009 06:44:52 -0700 (PDT)
Received: by 10.210.160.14 with SMTP id i14mr1256987ebe.26.1253022292191; Tue, 15 Sep 2009 06:44:52 -0700 (PDT)
Received: from mail-ew0-f228.google.com (mail-ew0-f228.google.com [209.85.219.228]) by gmr-mx.google.com with ESMTP id 16si1527580ewy.3.2009.09.15.06.44.51; Tue, 15 Sep 2009 06:44:51 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstormo@gmail.com designates 209.85.219.228 as permitted sender) client-ip=209.85.219.228;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of mstormo@gmail.com designates 209.85.219.228 as permitted sender) smtp.mail=mstormo@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by ewy28 with SMTP id 28so156818ewy.28 for <msysgit@googlegroups.com>; Tue, 15 Sep 2009 06:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references:in-reply-to:references; bh=3spWnyV5vY+gqaM+1sMbe7glFkAzaRa+8k1pfwFrmbw=; b=XK/YKvsQa+mWD3B1do4gT0LTu5Pod4O2CZwjD2CZ3rmi4UhgA0rt3yxkkWvl+1dVCq 02cMKWYqGJDM0KT5R8eJMogUyXpZQN/luM9EpLM7jsaFpGK8CE/HN7MRDNJDWcH7e9lN uBUqT40TEo2BRsXQTVKz0dwioLWAqpJCxueR8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=geG0qbLCQbcedFW5CNR2O2UKpXbRNq/3s2NXS3RAfB36K6KTboGer+d3hEKGGVMYxT piRlDAYQ43fOsGBchAkffyV9r0YmNtMPemBWngXFvKgYxyXT2k8XlJ4lU+IUwrZsuvee saDvcO3qTzSqsuO+837MaRUoGxi3RIRwX7QfE=
Received: by 10.211.139.17 with SMTP id r17mr8472576ebn.88.1253022291053; Tue, 15 Sep 2009 06:44:51 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104]) by mx.google.com with ESMTPS id 7sm81939eyg.4.2009.09.15.06.44.49 (version=SSLv3 cipher=RC4-MD5); Tue, 15 Sep 2009 06:44:50 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <8bcd4b022f59a5f55b63f87c9cf6a4dadc71cc44.1253021728.git.mstormo@gmail.com>
In-Reply-To: <cover.1253021728.git.mstormo@gmail.com>
References: <cover.1253021728.git.mstormo@gmail.com>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128556>


Centralize the include of windows.h in git-compat-util.h, turn on
WIN32_LEAN_AND_MEAN to avoid including plenty of other header files
which is not needed in Git. Also ensure we load winsock2.h first,
so we don't load the older winsock definitions at a later stage,
since they contain duplicate definitions.

When moving windows.h into git-compat-util.h, we need to protect
the definition of struct pollfd in mingw.h, since this file is used
by both MinGW and MSVC, and the latter defines this struct in
winsock2.h.

We need to keep the windows.h include in compat/win32.h, since its
shared by both MinGW and Cygwin, and we're not touching Cygwin in
this commit. The include in git-compat-util.h is protected with an
ifdef WIN32, which is not the case when compiling for Cygwin.

Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 compat/mingw.c    |    2 ++
 compat/mingw.h    |    2 ++
 compat/msvc.h     |    7 -------
 compat/win32.h    |    2 ++
 compat/winansi.c  |    1 -
 git-compat-util.h |    6 ++++++
 thread-utils.c    |    5 +----
 7 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 34ee427..6b5b5b2 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -3,6 +3,8 @@
 #include <conio.h>
 #include "../strbuf.h"
 
+#include <shellapi.h>
+
 static int err_win_to_posix(DWORD winerr)
 {
 	int error = ENOSYS;
diff --git a/compat/mingw.h b/compat/mingw.h
index 384b667..544b576 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -41,6 +41,7 @@ struct passwd {
 
 extern char *getpass(const char *prompt);
 
+#ifndef POLLIN
 struct pollfd {
 	int fd;           /* file descriptor */
 	short events;     /* requested events */
@@ -48,6 +49,7 @@ struct pollfd {
 };
 #define POLLIN 1
 #define POLLHUP 2
+#endif
 
 typedef void (__cdecl *sig_handler_t)(int);
 struct sigaction {
diff --git a/compat/msvc.h b/compat/msvc.h
index 6daf313..53a6d30 100644
--- a/compat/msvc.h
+++ b/compat/msvc.h
@@ -1,13 +1,6 @@
 #ifndef __MSVC__HEAD
 #define __MSVC__HEAD
 
-/* Define minimize windows version */
-#define WINVER 0x0500
-#define _WIN32_WINNT 0x0500
-#define _WIN32_WINDOWS 0x0410
-#define _WIN32_IE 0x0700
-#define NTDDI_VERSION NTDDI_WIN2KSP1
-#include <winsock2.h>
 #include <direct.h>
 #include <process.h>
 #include <malloc.h>
diff --git a/compat/win32.h b/compat/win32.h
index e8c178d..8ce9104 100644
--- a/compat/win32.h
+++ b/compat/win32.h
@@ -2,7 +2,9 @@
 #define WIN32_H
 
 /* common Win32 functions for MinGW and Cygwin */
+#ifndef WIN32         /* Not defined by Cygwin */
 #include <windows.h>
+#endif
 
 static inline int file_attr_to_st_mode (DWORD attr)
 {
diff --git a/compat/winansi.c b/compat/winansi.c
index 9217c24..dedce21 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -2,7 +2,6 @@
  * Copyright 2008 Peter Harris <git@peter.is-a-geek.org>
  */
 
-#include <windows.h>
 #include "../git-compat-util.h"
 
 /*
diff --git a/git-compat-util.h b/git-compat-util.h
index 8ea444f..8d6e29c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -65,6 +65,12 @@
 #define _NETBSD_SOURCE 1
 #define _SGI_SOURCE 1
 
+#ifdef WIN32 /* Both MinGW and MSVC */
+#define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
+#include <winsock2.h>
+#include <windows.h>
+#endif
+
 #include <unistd.h>
 #include <stdio.h>
 #include <sys/stat.h>
diff --git a/thread-utils.c b/thread-utils.c
index 55e7e29..4f9c829 100644
--- a/thread-utils.c
+++ b/thread-utils.c
@@ -1,9 +1,6 @@
 #include "cache.h"
 
-#ifdef _WIN32
-#  define WIN32_LEAN_AND_MEAN
-#  include <windows.h>
-#elif defined(hpux) || defined(__hpux) || defined(_hpux)
+#if defined(hpux) || defined(__hpux) || defined(_hpux)
 #  include <sys/pstat.h>
 #endif
 
-- 
1.6.2.1.418.g33d56.dirty
