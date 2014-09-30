From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 10/14] Makefile: introduce CROSS_COMPILE variable
Date: Tue, 30 Sep 2014 11:02:39 +0400
Message-ID: <1412060563-22041-11-git-send-email-marat@slonopotamus.org>
References: <1412060563-22041-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: marat@slonopotamus.org,
	msysGit <msysgit@googlegroups.com>
To: git@vger.kernel.org
X-From: msysgit+bncBCE7TAPITACRB65QVGQQKGQE2WQTOCI@googlegroups.com Tue Sep 30 09:15:13 2014
Return-path: <msysgit+bncBCE7TAPITACRB65QVGQQKGQE2WQTOCI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f187.google.com ([209.85.217.187])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRB65QVGQQKGQE2WQTOCI@googlegroups.com>)
	id 1XYreO-0004ou-Ma
	for gcvm-msysgit@m.gmane.org; Tue, 30 Sep 2014 09:15:08 +0200
Received: by mail-lb0-f187.google.com with SMTP id w7sf219847lbi.24
        for <gcvm-msysgit@m.gmane.org>; Tue, 30 Sep 2014 00:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=zrLBmVdBwmFEvuzinbe0GszY7Peg5E3ro7HfNXCLPKA=;
        b=g8wW5cGcZSrbPzvHzeGpFCZICDYrRWnZYDfd/9+r3QMBQTbtjpN8+K7ddK6xc1m1RF
         Z86kuPtF3MHOZf6ASeLwctaBWTWOf4yWDTrTJ2J1ThEDsTjGUKAwg3fWNoYmc3T2Bh/J
         ZEwQqbj5zrAGbapH8Of//OATo6nITwJcl6D5XSOW2dBv/O0qul3nJIl4A/dbqnDIJchi
         7CGRREthu2BEBZ137IUFM1st/9XLNcrRhUGnNj1GcuatCkNgoli1hOmKFR+9PtOmHN1Z
         ULuzn5J5gClN/o4NAT500nk7h5vh7PfV59lGOkooE4SPza1OBxA3LqcQcLv7OzdDtv/2
         22Rg==
X-Received: by 10.152.5.37 with SMTP id p5mr2526lap.31.1412061308542;
        Tue, 30 Sep 2014 00:15:08 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.5.226 with SMTP id v2ls3788lav.50.gmail; Tue, 30 Sep 2014
 00:15:06 -0700 (PDT)
X-Received: by 10.152.29.130 with SMTP id k2mr5762328lah.3.1412061306687;
        Tue, 30 Sep 2014 00:15:06 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id n6si743858wiv.0.2014.09.30.00.15.06
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Sep 2014 00:15:06 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from [185.6.245.138] (helo=radchenko-d-lnx.mail.msk)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1XYrSq-0004X0-Dd; Tue, 30 Sep 2014 11:03:12 +0400
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1412060563-22041-1-git-send-email-marat@slonopotamus.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257661>

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
