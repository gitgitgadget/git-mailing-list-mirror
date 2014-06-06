From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 3/5] Win32 dirent: change FILENAME_MAX to MAX_PATH
Date: Fri,  6 Jun 2014 22:15:42 +0200
Message-ID: <1402085744-15829-4-git-send-email-kasal@ucw.cz>
References: <5391ED57.1000601@gmail.com>
 <1402085744-15829-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysGit <msysgit@googlegroups.com>,
	Karsten Blees <blees@dcon.de>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Stepan Kasal <kasal@ucw.cz>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRB6OCZCOAKGQEVG45WZQ@googlegroups.com Fri Jun 06 22:15:57 2014
Return-path: <msysgit+bncBCU63DXMWULRB6OCZCOAKGQEVG45WZQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f62.google.com ([74.125.82.62])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRB6OCZCOAKGQEVG45WZQ@googlegroups.com>)
	id 1Wt0YM-0005KH-43
	for gcvm-msysgit@m.gmane.org; Fri, 06 Jun 2014 22:15:54 +0200
Received: by mail-wg0-f62.google.com with SMTP id b13sf401586wgh.27
        for <gcvm-msysgit@m.gmane.org>; Fri, 06 Jun 2014 13:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=yR8jhOYHH0q2plSqYnfOx2l9Hfy7WydpWtVIOFspS5E=;
        b=j5nh7hnP39Q0jAM9xOCPzzPHwiF5fSFYmI0kxKoaaF4ooGFvNf9GULZQotrCbFuAB7
         DkIpyEjlMrSxITez5+57qsya3WPpzUqeCsNqd7W7oF2dwylX0CVLIYpxX7bCBquQVGWD
         GrNlQl+lEz5t4ymJymayxY/dtAGaLJAN2oU9cTy9I4H0eidV52cQRd3avJBc6vYGk/MQ
         xea9fT1GHo7v8w8p1rUhyaVB2r2kmN9GbmMOMGIBl/LdwCWbrS0k1A+RdpPAOTIdF6O0
         TWXzd6xZxzVgO1XDPIu8qZ5jKuqrQrpZAj4lIIxbNSZmPKCIZk7wdDY0oXrQffuUIUHK
         rP5g==
X-Received: by 10.180.99.197 with SMTP id es5mr37009wib.9.1402085753868;
        Fri, 06 Jun 2014 13:15:53 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.9.41 with SMTP id w9ls157036wia.50.gmail; Fri, 06 Jun 2014
 13:15:52 -0700 (PDT)
X-Received: by 10.180.206.33 with SMTP id ll1mr1581861wic.5.1402085752918;
        Fri, 06 Jun 2014 13:15:52 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id ck3si706876wib.0.2014.06.06.13.15.52
        for <msysgit@googlegroups.com>;
        Fri, 06 Jun 2014 13:15:52 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id B8ED31C00AA; Fri,  6 Jun 2014 22:15:52 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1402085744-15829-1-git-send-email-kasal@ucw.cz>
X-Original-Sender: kasal@ucw.cz
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: kasal@ucw.cz does not designate permitted sender hosts) smtp.mail=kasal@ucw.cz
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250960>

From: Karsten Blees <blees@dcon.de>
Date: Fri, 7 Jan 2011 17:43:14 +0100

FILENAME_MAX and MAX_PATH are both 260 on Windows, however, MAX_PATH is
used throughout the other Win32 code in Git, and also defines the length
of file name buffers in the Win32 API (e.g. WIN32_FIND_DATA.cFileName,
from which we're copying the dirent data).

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 compat/win32/dirent.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/win32/dirent.h b/compat/win32/dirent.h
index 7f4e6c7..8838cd6 100644
--- a/compat/win32/dirent.h
+++ b/compat/win32/dirent.h
@@ -9,8 +9,8 @@ typedef struct DIR DIR;
 #define DT_LNK     3
 
 struct dirent {
-	char d_name[FILENAME_MAX];       /* File name. */
 	unsigned char d_type;      /* file type to prevent lstat after readdir */
+	char d_name[MAX_PATH];     /* file name */
 };
 
 DIR *opendir(const char *dirname);
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
