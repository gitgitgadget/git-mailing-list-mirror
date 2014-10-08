From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 09/14] MINGW: config.mak.uname: reorganize MinGW settings
Date: Wed,  8 Oct 2014 22:01:02 +0400
Message-ID: <1412791267-13356-10-git-send-email-marat@slonopotamus.org>
References: <1412791267-13356-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: marat@slonopotamus.org,
	msysGit <msysgit@googlegroups.com>
To: git@vger.kernel.org
X-From: msysgit+bncBCE7TAPITACRB6HX2WQQKGQESD5GJJA@googlegroups.com Wed Oct 08 20:01:35 2014
Return-path: <msysgit+bncBCE7TAPITACRB6HX2WQQKGQESD5GJJA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ee0-f63.google.com ([74.125.83.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRB6HX2WQQKGQESD5GJJA@googlegroups.com>)
	id 1XbvYJ-0003cZ-9i
	for gcvm-msysgit@m.gmane.org; Wed, 08 Oct 2014 20:01:31 +0200
Received: by mail-ee0-f63.google.com with SMTP id d17sf805643eek.8
        for <gcvm-msysgit@m.gmane.org>; Wed, 08 Oct 2014 11:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=2fFhoLmslgzLuVFWWmiCBWvDIU5qgtccmcd6ttHeReA=;
        b=LUTifYNfXBmrkL7k8RO3lnEESuNiQNPZQ+kXx2jzUjILYgK9Jvyr9fTQjMV2KItLoV
         TCMKJ4Agz5lfu5TKvXj9bf2MUF20iYlV2x4hd13GY3Z8NixPQPpKRo9+KE9o4E/cLVvU
         /u9QdvmtjA4asDvE60IxpQq/pF3aVHrzWpaf3LEx+MXV5PbsI3S6AC1yLxQvOo9w9As5
         +od3tHjhpqnTX3bLKgR+7wf92FUrsYZVBQn6XQNg2cPyB1Z6/ToLHobidwPZfCcnNn/j
         yrGH9ZpWD7vflzhgy83Gplqcwmq2Qo9x+fur8YlVcaA2mdafwxrHc9qQAHPhER06WFwJ
         XWgw==
X-Received: by 10.152.36.71 with SMTP id o7mr21392laj.29.1412791291046;
        Wed, 08 Oct 2014 11:01:31 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.153.6.2 with SMTP id cq2ls84653lad.102.gmail; Wed, 08 Oct 2014
 11:01:28 -0700 (PDT)
X-Received: by 10.112.168.225 with SMTP id zz1mr718383lbb.8.1412791288084;
        Wed, 08 Oct 2014 11:01:28 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id hv5si126617wib.1.2014.10.08.11.01.28
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Oct 2014 11:01:28 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from [176.57.72.72] (helo=noblesse.home.ru)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1XbvYC-0003Rz-IW; Wed, 08 Oct 2014 22:01:24 +0400
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

HAVE_LIBCHARSET_H and NO_R_TO_GCC_LINKER are not specific to
msysGit, they're general MinGW settings.

Logic behind HAVE_LIBCHARSET_H: if user is on MinGW and has iconv,
we expect him to have libcharset.h. If user doesn't have iconv,
he has to explicitly say so via NO_ICONV=1 regardless of this
commit.

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
---
 config.mak.uname | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index c7aaa1c..f79c0e0 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -532,11 +532,11 @@ ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
 	prefix =
 	INSTALL = /bin/install
 	EXTLIBS += /mingw/lib/libz.a
-	NO_R_TO_GCC_LINKER = YesPlease
 	INTERNAL_QSORT = YesPlease
-	HAVE_LIBCHARSET_H = YesPlease
 	NO_GETTEXT = YesPlease
 endif
+	HAVE_LIBCHARSET_H = YesPlease
+	NO_R_TO_GCC_LINKER = YesPlease
 endif
 ifeq ($(uname_S),QNX)
 	COMPAT_CFLAGS += -DSA_RESTART=0
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
