From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 08/14] MINGW: git-compat-util.h: use inttypes.h for
 printf macros
Date: Sun, 28 Sep 2014 17:24:24 +0400
Message-ID: <1411910670-31285-9-git-send-email-marat@slonopotamus.org>
References: <1411910670-31285-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: marat@slonopotamus.org,
	msysGit <msysgit@googlegroups.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: msysgit+bncBCE7TAPITACRBZUYUCQQKGQEDTLE5LQ@googlegroups.com Sun Sep 28 15:26:02 2014
Return-path: <msysgit+bncBCE7TAPITACRBZUYUCQQKGQEDTLE5LQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f61.google.com ([74.125.82.61])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRBZUYUCQQKGQEDTLE5LQ@googlegroups.com>)
	id 1XYEUC-0000Er-L2
	for gcvm-msysgit@m.gmane.org; Sun, 28 Sep 2014 15:26:00 +0200
Received: by mail-wg0-f61.google.com with SMTP id b13sf45279wgh.6
        for <gcvm-msysgit@m.gmane.org>; Sun, 28 Sep 2014 06:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=/BBM/aFiZOQlGwM7TrI8coizeXBoK5GqJLTaajY4cc4=;
        b=Ij51/XHx4K0EFGKBrwnpZSiiX/l+bGVNfI7/nAbdOG4MNJQQeI4oGee8D+DVO1GnKy
         QmPehpvvkfmjUu3foRSMliJn7weL/pAc5O6n4bOuMs+SBthkiMxXItIpMh67/xAvscVR
         YSKI86h2EOPQnFdrxv0iZl+TJkkXJjb58VeqmEVdr7CJiZM6IpFWZYsX5lLIRzMXJimx
         U22bFQAIv1J71CYbM6+XKlTA8iUzBb6SGt6Ug+SGxi6eEKdRcU2xdbOB7qAfiRVq71r0
         0Yz0l9SurAS+8nRwRa7Fx8aoU/YNyHU6A0VpXYQ5lI38TQAZnUbjBtjSRaBoSTHD/fLH
         Lctw==
X-Received: by 10.152.43.43 with SMTP id t11mr672050lal.4.1411910760377;
        Sun, 28 Sep 2014 06:26:00 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.197.68 with SMTP id is4ls220280lac.6.gmail; Sun, 28 Sep
 2014 06:25:58 -0700 (PDT)
X-Received: by 10.152.23.166 with SMTP id n6mr27293laf.9.1411910758097;
        Sun, 28 Sep 2014 06:25:58 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id h1si447267wib.0.2014.09.28.06.25.58
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Sep 2014 06:25:58 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from [176.57.72.72] (helo=noblesse.home.ru)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1XYEU7-0000Yl-TU; Sun, 28 Sep 2014 17:25:56 +0400
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1411910670-31285-1-git-send-email-marat@slonopotamus.org>
X-Original-Sender: marat@slonopotamus.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: marat@slonopotamus.org does not designate permitted sender
 hosts) smtp.mail=marat@slonopotamus.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257605>

All MinGW flavors have inttypes.h, so just include it.

However, we need to pass -D__USE_MINGW_ANSI_STDIO=1 to select
GNU-compatible macro definitions on MinGW-W64:
http://sourceforge.net/p/mingw-w64/wiki2/gnu%20printf/

As a side-effect, Git no longer builds with MSVC < 2010 due to
its lack of stdint.h but hopefully that is not a problem.

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
---
 compat/mingw.h    |  2 --
 compat/msvc.h     |  3 +++
 config.mak.uname  |  3 ++-
 git-compat-util.h | 11 ++++++-----
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index d113b19..4bae842 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -353,8 +353,6 @@ static inline char *mingw_find_last_dir_sep(const char *path)
 int mingw_offset_1st_component(const char *path);
 #define offset_1st_component mingw_offset_1st_component
 #define PATH_SEP ';'
-#define PRIuMAX "I64u"
-#define PRId64 "I64d"
 
 void mingw_open_html(const char *path);
 #define open_html mingw_open_html
diff --git a/compat/msvc.h b/compat/msvc.h
index a63d878..84a03f9 100644
--- a/compat/msvc.h
+++ b/compat/msvc.h
@@ -17,6 +17,9 @@
 
 typedef int pid_t;
 
+#define PRIuMAX "I64u"
+#define PRId64 "I64d"
+
 static __inline int strcasecmp (const char *s1, const char *s2)
 {
 	int size1 = strlen(s1);
diff --git a/config.mak.uname b/config.mak.uname
index 4470a928..c7aaa1c 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -328,6 +328,7 @@ ifeq ($(uname_S),Windows)
 	NO_PREAD = YesPlease
 	NEEDS_CRYPTO_WITH_SSL = YesPlease
 	NO_LIBGEN_H = YesPlease
+	NO_INTTYPES_H = UnfortunatelyYes
 	NO_POLL = YesPlease
 	NO_SYMLINK_HEAD = YesPlease
 	NO_IPV6 = YesPlease
@@ -510,7 +511,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_POSIX_GOODIES = UnfortunatelyYes
 	DEFAULT_HELP_FORMAT = html
 	NO_D_INO_IN_DIRENT = YesPlease
-	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/win32
+	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -D__USE_MINGW_ANSI_STDIO=1 -DNOGDI -Icompat -Icompat/win32
 	ifneq (,$(findstring i686,$(CC_MACH)))
 		COMPAT_CFLAGS += -D_USE_32BIT_TIME_T
 		BASIC_LDFLAGS += -Wl,--large-address-aware
diff --git a/git-compat-util.h b/git-compat-util.h
index 0c4e663..9d2d5ab 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -96,6 +96,12 @@
 #define GIT_WINDOWS_NATIVE
 #endif
 
+#ifndef NO_INTTYPES_H
+#include <inttypes.h>
+#else
+#include <stdint.h>
+#endif
+
 #include <unistd.h>
 #include <stdio.h>
 #include <sys/stat.h>
@@ -147,11 +153,6 @@
 #include <netdb.h>
 #include <pwd.h>
 #include <sys/un.h>
-#ifndef NO_INTTYPES_H
-#include <inttypes.h>
-#else
-#include <stdint.h>
-#endif
 #ifdef NO_INTPTR_T
 /*
  * On I16LP32, ILP32 and LP64 "long" is the save bet, however
-- 
2.1.1

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
