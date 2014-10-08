From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 10/14] Makefile: introduce CROSS_COMPILE variable
Date: Wed,  8 Oct 2014 22:01:03 +0400
Message-ID: <1412791267-13356-11-git-send-email-marat@slonopotamus.org>
References: <1412791267-13356-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: marat@slonopotamus.org,
	msysGit <msysgit@googlegroups.com>
To: git@vger.kernel.org
X-From: msysgit+bncBCE7TAPITACRBIP62WQQKGQE5WRQGXY@googlegroups.com Wed Oct 08 20:14:59 2014
Return-path: <msysgit+bncBCE7TAPITACRBIP62WQQKGQE5WRQGXY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f64.google.com ([209.85.215.64])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRBIP62WQQKGQE5WRQGXY@googlegroups.com>)
	id 1XbvlK-0001LT-Ck
	for gcvm-msysgit@m.gmane.org; Wed, 08 Oct 2014 20:14:58 +0200
Received: by mail-la0-f64.google.com with SMTP id mk6sf846754lab.19
        for <gcvm-msysgit@m.gmane.org>; Wed, 08 Oct 2014 11:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=zrLBmVdBwmFEvuzinbe0GszY7Peg5E3ro7HfNXCLPKA=;
        b=BIhgGdPmQgZD04Eg8t5pMQ465Yo26JTP69DLLekq24CxNbQ1DyNKmOZ7kvGh5cMxx8
         swSp04q3820SeUTzpIZAMUipOMwaOLaUu8+4SZGf7QDNrWwjRdboF97gEfArbU1C5V/9
         kPgGAXyLAqQGMVjKbW6w5GvqFnCl2jgMlYSYLIvmip1uZocYLB6+q+4YGY0brROe43Ws
         oH02CA51+ZIpBqJaF+N5tx9+Gi9ioqafPzIns/6OKvtKHJVOMslA+q2HMYsZO+P+rbEv
         v1J95GK95Lakw0vDRBHV/4xUn6sZBfk8J8uCgojXDRUBhi2GjlY4noF04z9Lqd9XYzFC
         dXGQ==
X-Received: by 10.180.107.99 with SMTP id hb3mr154907wib.13.1412792098204;
        Wed, 08 Oct 2014 11:14:58 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.78.2 with SMTP id x2ls138539wiw.1.gmail; Wed, 08 Oct 2014
 11:14:57 -0700 (PDT)
X-Received: by 10.194.249.134 with SMTP id yu6mr1829595wjc.1.1412792097681;
        Wed, 08 Oct 2014 11:14:57 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id rb5si152221lbb.0.2014.10.08.11.14.57
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Oct 2014 11:14:57 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from [176.57.72.72] (helo=noblesse.home.ru)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1XbvYD-0003Rz-Qi; Wed, 08 Oct 2014 22:01:26 +0400
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1412791267-13356-1-git-send-email-marat@slonopotamus.org>
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

To ease cross-compilation process, introduce a single variable
with the prefix to all compiler-related executables.

Define CROSS_COMPILE=foo- if your compiler and binary utilities
are foo-cc, foo-ar, foo-strip, etc.  More specific variables
override this, so if you set CC=gcc CROSS_COMPILE=ia64-linux-gnu-
then the compiler will be 'gcc', not 'ia64-linux-gnu-gcc'.

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
---
 Makefile         | 19 +++++++++++++------
 config.mak.uname |  2 +-
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index f34a2d4..c412996 100644
--- a/Makefile
+++ b/Makefile
@@ -339,6 +339,11 @@ all::
 # return NULL when it receives a bogus time_t.
 #
 # Define HAVE_CLOCK_GETTIME if your platform has clock_gettime in librt.
+#
+# Define CROSS_COMPILE=foo- if your compiler and binary utilities
+# are foo-cc, foo-ar, foo-strip, etc.  More specific variables
+# override this, so if you set CC=gcc CROSS_COMPILE=ia64-linux-gnu-
+# then the compiler will be 'gcc', not 'ia64-linux-gnu-gcc'.
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -350,7 +355,6 @@ CFLAGS = -g -O2 -Wall
 LDFLAGS =
 ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
-STRIP ?= strip
 
 # Among the variables below, these:
 #   gitexecdir
@@ -390,8 +394,12 @@ htmldir_relative = $(patsubst $(prefix)/%,%,$(htmldir))
 
 export prefix bindir sharedir sysconfdir gitwebdir localedir
 
-CC = cc
-AR = ar
+AR = $(CROSS_COMPILE)ar
+CC = $(CROSS_COMPILE)cc
+GCOV = $(CROSS_COMPILE)gcov
+RC = $(CROSS_COMPILE)windres
+STRIP = $(CROSS_COMPILE)strip
+
 RM = rm -f
 DIFF = diff
 TAR = tar
@@ -404,13 +412,12 @@ XGETTEXT = xgettext
 MSGFMT = msgfmt
 PTHREAD_LIBS = -lpthread
 PTHREAD_CFLAGS =
-GCOV = gcov
 
 export TCL_PATH TCLTK_PATH
 
 SPARSE_FLAGS =
 
-
+RCFLAGS =
 
 ### --- END CONFIGURATION SECTION ---
 
@@ -1669,7 +1676,7 @@ $(SCRIPT_LIB) : % : %.sh GIT-SCRIPT-DEFINES
 	mv $@+ $@
 
 git.res: git.rc GIT-VERSION-FILE
-	$(QUIET_RC)$(RC) \
+	$(QUIET_RC)$(RC) $(RCFLAGS) \
 	  $(join -DMAJOR= -DMINOR=, $(wordlist 1,2,$(subst -, ,$(subst ., ,$(GIT_VERSION))))) \
 	  -DGIT_VERSION="\\\"$(GIT_VERSION)\\\"" $< -o $@
 
diff --git a/config.mak.uname b/config.mak.uname
index f79c0e0..9f7037e 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -523,7 +523,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	EXTLIBS += -lws2_32
 	GITLIBS += git.res
 	PTHREAD_LIBS =
-	RC = windres -O coff
+	RCFLAGS += -O coff
 	NATIVE_CRLF = YesPlease
 	X = .exe
 	SPARSE_FLAGS = -Wno-one-bit-signed-bitfield
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
