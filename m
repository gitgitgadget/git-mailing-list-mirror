From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH] mingw: do not crash on open(NULL, ...)
Date: Thu, 23 Sep 2010 17:35:25 +0000
Message-ID: <1285263325-2016-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Cc: git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: msysgit@googlegroups.com
X-From: msysgit+bncCOPdven-DxC8n-7kBBoE7Hrpqg@googlegroups.com Thu Sep 23 19:35:20 2010
Return-path: <msysgit+bncCOPdven-DxC8n-7kBBoE7Hrpqg@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-px0-f186.google.com ([209.85.212.186])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOPdven-DxC8n-7kBBoE7Hrpqg@googlegroups.com>)
	id 1OyphV-0004rH-OU
	for gcvm-msysgit@m.gmane.org; Thu, 23 Sep 2010 19:35:17 +0200
Received: by pxi18 with SMTP id 18sf567672pxi.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 23 Sep 2010 10:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:mime-version:x-beenthere:received
         :received:received:received:received-spf:received:received:received
         :from:to:cc:subject:date:message-id:x-mailer:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=Ea14NBJ3zmGWi84wFjCKCkGzPsedzrWYT0HeVSMlWVc=;
        b=kYK1jD2fgPjKGUuVhTqpsit9uG71slBm4Modssng80fbRxQo6PGjFFYK8p2RnKDSTP
         mNxnOgdwmgx0/Y4S6zdqlrV7YkV6/yNENgTdK0MPEOnylzW8QENkNAeikj3jo0xZUsg6
         59qTa6iobbEJr9Ns15Jy7sC72TwavSvT6H4+M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        b=mSXabvNgDcnH4EHp/hXsCknwO3Ey9DEp3du4yeRv+7EAI3vBEFWgvgGCkdWwcfzXNB
         E+1vtAkMcJsQORWGSewZRLzRvBz7Qb8dwrYwhcUxUgKYJJ5GMdZKwGBYCN7E3THdhAho
         M1zGET33INzT3uNEhJKoyQnzddmKuX6lqPex8=
Received: by 10.142.133.10 with SMTP id g10mr126895wfd.15.1285263292785;
        Thu, 23 Sep 2010 10:34:52 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.142.117.2 with SMTP id p2ls1349723wfc.1.p; Thu, 23 Sep 2010
 10:34:52 -0700 (PDT)
Received: by 10.142.202.10 with SMTP id z10mr370821wff.31.1285263292203;
        Thu, 23 Sep 2010 10:34:52 -0700 (PDT)
Received: by 10.142.202.10 with SMTP id z10mr370820wff.31.1285263292174;
        Thu, 23 Sep 2010 10:34:52 -0700 (PDT)
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com [74.125.83.179])
        by gmr-mx.google.com with ESMTP id e3si1274063wfh.3.2010.09.23.10.34.51;
        Thu, 23 Sep 2010 10:34:51 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 74.125.83.179 as permitted sender) client-ip=74.125.83.179;
Received: by mail-pv0-f179.google.com with SMTP id 13so681459pvg.38
        for <msysgit@googlegroups.com>; Thu, 23 Sep 2010 10:34:51 -0700 (PDT)
Received: by 10.114.126.3 with SMTP id y3mr2204271wac.74.1285263288616;
        Thu, 23 Sep 2010 10:34:48 -0700 (PDT)
Received: from localhost ([209.133.114.32])
        by mx.google.com with ESMTPS id d2sm1764125wam.14.2010.09.23.10.34.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 23 Sep 2010 10:34:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.msysgit.0.207.gda0b3
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 74.125.83.179 as permitted sender)
 smtp.mail=kusmabite@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156887>

Since open() already sets errno correctly for the NULL-case, let's just
avoid the problematic strcmp.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/mingw.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index b0ad919..b408c3c 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -297,7 +297,7 @@ int mingw_open (const char *filename, int oflags, ...)
 	mode = va_arg(args, int);
 	va_end(args);
 
-	if (!strcmp(filename, "/dev/null"))
+	if (filename && !strcmp(filename, "/dev/null"))
 		filename = "nul";
 
 	fd = open(filename, oflags, mode);
-- 
1.7.2.3.msysgit.0.207.gda0b3
