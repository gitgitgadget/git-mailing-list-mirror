From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 6/6] t800[12]: work around MSys limitation
Date: Thu, 17 Jul 2014 17:37:05 +0200
Message-ID: <1405611425-10009-7-git-send-email-kasal@ucw.cz>
References: <20140716092959.GA378@ucw.cz>
 <1405611425-10009-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
	GIT Mailing-list <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>,
	Karsten Blees <blees@dcon.de>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stepan Kasal <kasal@ucw.cz>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCU63DXMWULRBMW3T6PAKGQE3LBL4ZY@googlegroups.com Thu Jul 17 17:37:30 2014
Return-path: <msysgit+bncBCU63DXMWULRBMW3T6PAKGQE3LBL4ZY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f188.google.com ([74.125.82.188])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBMW3T6PAKGQE3LBL4ZY@googlegroups.com>)
	id 1X7nkJ-00087G-G2
	for gcvm-msysgit@m.gmane.org; Thu, 17 Jul 2014 17:37:23 +0200
Received: by mail-we0-f188.google.com with SMTP id t60sf322983wes.25
        for <gcvm-msysgit@m.gmane.org>; Thu, 17 Jul 2014 08:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=Pm3UToSiwnBVMEWV1BNvauA7MSFCjk6Xj0ESA/XH+RA=;
        b=Xa1YIO2XE60msVJufxPTvQQRvAe40r7xLmAnKwoqdMHx/d/h3i9o/cgQrtNoAjPOTQ
         s8nqE7VWFDDoGxCqkaZ9NHFkOXOkw0GgEeHv3kU86RhjYNpXorkjgTLcBLsUi+v8og3R
         gK3i7c5X3OnT1rrZpmM8nsZHnmX3kKxW5BM49HLI2/xVduM2UXcTCmUYiAPFFYhHN7cr
         IOxXgApWVIK2aNoT6Ot32DsLdqmq+J0O6AIEvEQCL7qEDrYzAHxHSJQIYkv1SfFFFkdz
         II8wmBUncoFpn2JKzOAkED5607NGilkoYQx0Emw9BYEocd6Gy2XQjlY1ruv1C8ZmsUvx
         OYfQ==
X-Received: by 10.181.5.7 with SMTP id ci7mr87797wid.15.1405611443135;
        Thu, 17 Jul 2014 08:37:23 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.199.180 with SMTP id jl20ls456042wic.6.gmail; Thu, 17 Jul
 2014 08:37:22 -0700 (PDT)
X-Received: by 10.180.89.100 with SMTP id bn4mr1352630wib.0.1405611442368;
        Thu, 17 Jul 2014 08:37:22 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id r19si910821wik.0.2014.07.17.08.37.21
        for <msysgit@googlegroups.com>;
        Thu, 17 Jul 2014 08:37:21 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id 173951C01A6; Thu, 17 Jul 2014 17:37:21 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1405611425-10009-1-git-send-email-kasal@ucw.cz>
X-Original-Sender: kasal@ucw.cz
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: kasal@ucw.cz does not designate permitted sender hosts) smtp.mail=kasal@ucw.cz
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253742>

From: Karsten Blees <blees@dcon.de>

MSys works very hard to convert Unix-style paths into DOS-style ones.
*Very* hard.

So hard, indeed, that

	git blame -L/hello/,/green/

is translated into something like

	git blame -LC:/msysgit/hello/,C:/msysgit/green/

As seen in msys_p2w in src\msys\msys\rt\src\winsup\cygwin\path.cc, line
3204ff:

	case '-':
	  //
	  // here we check for POSIX paths as attributes to a POSIX switch.
	  //
	...

seemingly absolute POSIX paths in single-letter options get expanded by
msys.dll unless they contain '=' or ';'.

So a quick and very dirty fix is to use '-L/;*evil/'. (Using an equal sign
works only when it is before a comma, so in the above example, /=*green/
would still be converted to a DOS-style path.)

The -L mangling can be done by the script, just before the parameter is
passed to the executable.  This version does not modify the body of the
tests and is active on MinGW only.

Commit-message-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Author: Stepan Kasal <kasal@ucw.cz>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 t/annotate-tests.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index 304c7b7..071e4d7 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -1,6 +1,17 @@
 # This file isn't used as a test script directly, instead it is
 # sourced from t8001-annotate.sh and t8002-blame.sh.
 
+if test_have_prereq MINGW
+then
+  sanitize_L () {
+	echo "$1" | sed 'sX\(^-L\|,\)\^\?/X&\\;*Xg'
+  }
+else
+  sanitize_L () {
+	echo "$1"
+  }
+fi
+
 check_count () {
 	head= &&
 	file='file' &&
@@ -10,6 +21,7 @@ check_count () {
 		case "$1" in
 		-h) head="$2"; shift; shift ;;
 		-f) file="$2"; shift; shift ;;
+		-L*) options="$options $(sanitize_L "$1")"; shift ;;
 		-*) options="$options $1"; shift ;;
 		*) break ;;
 		esac
-- 
2.0.0.9635.g0be03cb

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
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
