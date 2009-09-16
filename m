From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 10/15] Make usage of windows.h lean and mean
Date: Wed, 16 Sep 2009 10:20:26 +0200
Message-ID: <38f180f3899d1f7a6acc8cf8c65f5f0ffb61699a.1253088099.git.mstormo@gmail.com>
References: <cover.1253088099.git.mstormo@gmail.com> <213f3c7799721c3f42ffa689498175f0495048eb.1253088099.git.mstormo@gmail.com> <26c067500d8adf17a2d75e2956e4d4a6cef27fc1.1253088099.git.mstormo@gmail.com> <6e6345fb3fbc19b1a2467e33e1633fe9025e547b.1253088099.git.mstormo@gmail.com> <929c5a34cd2621af24bcda7e47ff2e76b51c2e09.1253088099.git.mstormo@gmail.com> <eec2b652c5a8e3e21348a8211d336fce66cb21a5.1253088099.git.mstormo@gmail.com> <28e3400f29353cf8f93b4ca054b87f083f9e33e1.1253088099.git.mstormo@gmail.com> <8f578bb08bf5663a8ce5b02e3e4f77727692c501.1253088099.git.mstormo@gmail.com> <7afd55f9b2f0f7859f757c715034cc3520e07f0e.1253088099.git.mstormo@gmail.com> <489a0e7c6c41985a5208e85e9b24900c97dcacdb.1253088099.git.mstormo@gmail.com>
Cc: Johannes.Schindelin@gmx.de, msysgit@googlegroups.com, gitster@pobox.com, j6t@kdbg.org, lznuaa@gmail.com, raa.lkml@gmail.com, snaury@gmail.com, Marius Storm-Olsen <mstormo@gmail.com>
To: git@vger.kernel.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Sep 16 10:21:24 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f140.google.com ([209.85.211.140])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnplR-0004rX-MK
	for gcvm-msysgit@m.gmane.org; Wed, 16 Sep 2009 10:21:21 +0200
Received: by mail-yw0-f140.google.com with SMTP id 4so12827951ywh.9
        for <gcvm-msysgit@m.gmane.org>; Wed, 16 Sep 2009 01:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=bDwxCbQPMsT1BfpRPtxnMGy8nAm+CW9V1D/0OrkgCMQ=;
        b=H507w2xjA4+X54z+KfPAjjWwJjYpG1zY9XhXI9+EucO7/AGTGw6UnlzvoJPOz34yZW
         wrgdrpEK/zE8B6lddH1NdAgBvCevgDBLza5UIBS/vcvb6CiNU9XuPtMxZqUzdCUN13Ym
         2SXF/DMZc0/feehXaBo0EMPxAS6c7AGgoiMXU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=XD6aM2abL+s5MmJa/+3OzyMp5NAsGqPgW8Fh/zxIP41VFJiKdCa5ymKZiD364wSmtk
         O2TVHUusn+xsLnZ4ra4ZB84nFx0HFfK31tPuh62AJ5wnRDJZHy8oRaBLd4d13lEzFh/F
         JJ7xjFLGBHHAkLjX/bfc3xqf96QOLFaZud90w=
Received: by 10.91.117.14 with SMTP id u14mr92563agm.20.1253089275330;
        Wed, 16 Sep 2009 01:21:15 -0700 (PDT)
Received: by 10.176.58.28 with SMTP id g28gr7045yqa.0;
	Wed, 16 Sep 2009 01:21:06 -0700 (PDT)
X-Sender: mstormo@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.96.28 with SMTP id t28mr1269402ebb.28.1253089265253; Wed, 16 Sep 2009 01:21:05 -0700 (PDT)
Received: by 10.210.96.28 with SMTP id t28mr1269401ebb.28.1253089265226; Wed, 16 Sep 2009 01:21:05 -0700 (PDT)
Received: from mail-ew0-f220.google.com (mail-ew0-f220.google.com [209.85.219.220]) by gmr-mx.google.com with ESMTP id 15si1687106ewy.0.2009.09.16.01.21.04; Wed, 16 Sep 2009 01:21:04 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstormo@gmail.com designates 209.85.219.220 as permitted sender) client-ip=209.85.219.220;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of mstormo@gmail.com designates 209.85.219.220 as permitted sender) smtp.mail=mstormo@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by mail-ew0-f220.google.com with SMTP id 20so3886379ewy.21 for <msysgit@googlegroups.com>; Wed, 16 Sep 2009 01:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references:in-reply-to:references; bh=8e1FAQpF55rLoLsHJCHTA8wlYY8LNC06L73Wb+ww77M=; b=nyCZtJcUv39x0HMIoCo7WXK6pSlZNyAi6rUfCgpE/oN8PSncvkwFokEoFfILgd19T/ jZpS2GtY68Kf5G/PTURdx6Ju3p2TVMq1Cit4K4fHev3Vgtz6D0WV+3uzoSjjRRCPLAJQ qsXDDx88KnB0tv82T1C689L5VltKImpOkczoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=lZWhCK5ERxwlbjVIHiHO/cYf0kWPBL1dxN+T89lXuD//F4LGrMPKlm7K3oxhHsnOvO y3gfL10pPxBMC4mmNx4FszoukFcKczW+gW3EBvwVdNpVEBGkuS4gNhTyoQfBSIuhPKVt YEY+QSRKfI74OdKC21Zi1+zGRqw+8Iw4pBaK4=
Received: by 10.211.131.39 with SMTP id i39mr9618012ebn.98.1253089264118; Wed, 16 Sep 2009 01:21:04 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104]) by mx.google.com with ESMTPS id 10sm1370859eyd.16.2009.09.16.01.21.02 (version=SSLv3 cipher=RC4-MD5); Wed, 16 Sep 2009 01:21:03 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <489a0e7c6c41985a5208e85e9b24900c97dcacdb.1253088099.git.mstormo@gmail.com>
In-Reply-To: <cover.1253088099.git.mstormo@gmail.com>
References: <cover.1253088099.git.mstormo@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128626>


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
index bcd23b0..5b5258b 100644
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
