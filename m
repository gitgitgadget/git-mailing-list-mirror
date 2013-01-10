From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v2 1/2] wincred: accept CRLF on stdin to simplify
 console usage
Date: Thu, 10 Jan 2013 13:10:09 +0100
Message-ID: <50EEAFA1.2030000@dcon.de>
References: <50E73B80.4070105@gmail.com> <CABPQNSYcOrOZJd0vK=4ESC4qPpcj7RRdhVt3R0dAE-ouhOb5YA@mail.gmail.com> <50EC473A.6060203@gmail.com> <CABPQNSb7MjTKgmeB9TcUV0+-FfjPZ1sgKPsfVDg6+uaw2f_azQ@mail.gmail.com>
Reply-To: blees@dcon.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: kusmabite@gmail.com, msysgit@googlegroups.com, 
 Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: msysgit+bncBCH3XYXLXQDBBIW7XKDQKGQEZHUW4SQ@googlegroups.com Thu Jan 10 13:10:28 2013
Return-path: <msysgit+bncBCH3XYXLXQDBBIW7XKDQKGQEZHUW4SQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ea0-f186.google.com ([209.85.215.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBIW7XKDQKGQEZHUW4SQ@googlegroups.com>)
	id 1TtGxm-0001UZ-Sh
	for gcvm-msysgit@m.gmane.org; Thu, 10 Jan 2013 13:10:26 +0100
Received: by mail-ea0-f186.google.com with SMTP id e1sf216342eaa.13
        for <gcvm-msysgit@m.gmane.org>; Thu, 10 Jan 2013 04:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:x-received:received-spf
         :x-received:message-id:date:from:reply-to:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=rrkh5vKrEOGr3g4275e4oY7F6pIB4Q/s76/hGxEqgmo=;
        b=dvwUslzrKIX71tzysbGhTTR055FK/PY5ltDuInMJbWj5Dq+VoFfud9arGTG1mQPK+z
         hgmOvr4bRg9beSoN+xKQ/ECXQ0cpU4wbmWGA5nDC8QTndipw9iU2zlyXVsylUfzBWj2P
         V3EpdXPVnHqn+Y85Mb2WhYyluPzPmAr/MSHK+ARIMz4AB+gv8K4+vrvbmerUo0vqcsiL
         F+8Qn8E6BZkiKl9zuTTYpyKureP9AtLZ+kaAB90F5vDhYXQ1hjpb70IkLiM32aw490fk
         Sp/rCExzCUZZTaQMasklU 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:x-beenthere:x-received:x-received:received-spf
         :x-received:message-id:date:from:reply-to:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=rrkh5vKrEOGr3g4275e4oY7F6pIB4Q/s76/hGxEqgmo=;
        b=Z/0YJWrAY/+2TCj8nLK6kFzM3HUOAfxJ/q2ehNb6HApwUgiTZ2GI32s9J4tM2kBBcs
         ME/sTBz+kgyVKnFjgdz10O/5+Kj+53ceAT4/s1QRIHnQK3ZTfupjONhm8tcAcL9QbwtX
         o7uvSbuOdLKmj5wS1wFkHooJGi2sydLvWMILGA+9x5o/RVLEnAJHy82Y1M+qLe+hvH90
         CK056ftJJmn7c+Yzv05y7EDZteuxa1j1RDDCdM2DhaVb1+gjWwHeMuUSVKhdD42k//7w
         j7nIPdiHUTryUwgjpNoVboJlUXyD 
X-Received: by 10.180.90.107 with SMTP id bv11mr1245731wib.0.1357819811062;
        Thu, 10 Jan 2013 04:10:11 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.90.233 with SMTP id bz9ls1518402wib.27.gmail; Thu, 10 Jan
 2013 04:10:10 -0800 (PST)
X-Received: by 10.204.153.206 with SMTP id l14mr3552186bkw.5.1357819810273;
        Thu, 10 Jan 2013 04:10:10 -0800 (PST)
X-Received: by 10.204.153.206 with SMTP id l14mr3552185bkw.5.1357819810244;
        Thu, 10 Jan 2013 04:10:10 -0800 (PST)
Received: from mail-la0-f47.google.com (mail-la0-f47.google.com [209.85.215.47])
        by gmr-mx.google.com with ESMTPS id 7si124448bkr.3.2013.01.10.04.10.10
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 10 Jan 2013 04:10:10 -0800 (PST)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 209.85.215.47 as permitted sender) client-ip=209.85.215.47;
Received: by mail-la0-f47.google.com with SMTP id fh20so469229lab.6
        for <msysgit@googlegroups.com>; Thu, 10 Jan 2013 04:10:10 -0800 (PST)
X-Received: by 10.152.109.139 with SMTP id hs11mr69166456lab.13.1357819810081;
        Thu, 10 Jan 2013 04:10:10 -0800 (PST)
Received: from [10.1.100.50] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPS id hq9sm624539lab.8.2013.01.10.04.10.08
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 10 Jan 2013 04:10:09 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <CABPQNSb7MjTKgmeB9TcUV0+-FfjPZ1sgKPsfVDg6+uaw2f_azQ@mail.gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 209.85.215.47 as
 permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213139>

The windows credential helper currently only accepts LF on stdin, but bash
and cmd.exe both send CRLF. This prevents interactive use in the console.

Change the stdin parser to optionally accept CRLF.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 contrib/credential/wincred/git-credential-wincred.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
index cbaec5f..94d7140 100644
--- a/contrib/credential/wincred/git-credential-wincred.c
+++ b/contrib/credential/wincred/git-credential-wincred.c
@@ -284,10 +284,13 @@ static void read_credential(void)
 
 	while (fgets(buf, sizeof(buf), stdin)) {
 		char *v;
+		int len = strlen(buf);
+		/* strip trailing CR / LF */
+		while (len && strchr("\r\n", buf[len - 1]))
+			buf[--len] = 0;
 
-		if (!strcmp(buf, "\n"))
+		if (!*buf)
 			break;
-		buf[strlen(buf)-1] = '\0';
 
 		v = strchr(buf, '=');
 		if (!v)
-- 
1.8.0.msysgit.0.4.g4e40dea

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
