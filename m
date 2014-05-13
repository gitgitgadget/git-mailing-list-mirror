From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 2/2] wincred: avoid overwriting configured variables
Date: Tue, 13 May 2014 08:01:44 +0200
Organization: <)><
Message-ID: <20140513060144.GC28182@camelia.ucw.cz>
References: <20140430064610.GA22094@camelia.ucw.cz> <CABPQNSZsviaGqFeKZE4ofF6HoUQrPvNPuowar4YDjk_Mbu5iCQ@mail.gmail.com> <20140430112724.GA22929@camelia.ucw.cz> <CABPQNSafKXDLyBj5OYW-PPWdxfxQtC23vKQsQ-_Pa1empU=n8g@mail.gmail.com> <20140513055953.GA28182@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Mailing-list <git@vger.kernel.org>,
        Pat Thoyts <patthoyts@users.sourceforge.net>, msysgit@googlegroups.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: msysgit+bncBCU63DXMWULRBSXKY2NQKGQEOU23CMQ@googlegroups.com Tue May 13 08:01:47 2014
Return-path: <msysgit+bncBCU63DXMWULRBSXKY2NQKGQEOU23CMQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f60.google.com ([209.85.215.60])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBSXKY2NQKGQEOU23CMQ@googlegroups.com>)
	id 1Wk5md-0001xc-4I
	for gcvm-msysgit@m.gmane.org; Tue, 13 May 2014 08:01:47 +0200
Received: by mail-la0-f60.google.com with SMTP id pn19sf308454lab.5
        for <gcvm-msysgit@m.gmane.org>; Mon, 12 May 2014 23:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:organization:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=rYfT1c44w0rzupYwf9ECQ0PUQR2VdbHNbzV29kJH8EI=;
        b=Ln6gq9r+uMB8vOaf9V71231TbsDJl66Dhdc4jO/EG4vMKwLbnYxy/NB9g/Qmy55xmO
         GG5hqHkRU1lYZv5+6RdMRND6j1bfBJHqxesN9GLGq/1OwLUIvIOgVjAFUa6r5dTALeGX
         BbcN/NCtTKEEVE2P3/lf5gApIzmqVMxZIe+V8bs2XSDO/YTcxEr+fncOZMysEDGSQC1a
         tuQOJAIZqR/wONMN7HwIsRtwVl8pgLAn1lHVR5X4ycSCSmn41qG/oY5zXVa2a+h8/B7i
         6wcqEGeNpBhRvD6lMt21SWCwpuKcolAbjl0jXs0gXQz5E8e9gQnVDOsDPl/V7mIukWqD
         ikDg==
X-Received: by 10.152.42.193 with SMTP id q1mr190943lal.5.1399960906792;
        Mon, 12 May 2014 23:01:46 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.115.233 with SMTP id jr9ls27688lab.49.gmail; Mon, 12 May
 2014 23:01:45 -0700 (PDT)
X-Received: by 10.152.43.101 with SMTP id v5mr297lal.10.1399960905483;
        Mon, 12 May 2014 23:01:45 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id r49si787030eep.0.2014.05.12.23.01.45
        for <msysgit@googlegroups.com>;
        Mon, 12 May 2014 23:01:45 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 43A3F1C00E9;
	Tue, 13 May 2014 08:01:45 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s4D61iHF028285;
	Tue, 13 May 2014 08:01:44 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s4D61igP028284;
	Tue, 13 May 2014 08:01:44 +0200
In-Reply-To: <20140513055953.GA28182@camelia.ucw.cz>
User-Agent: Mutt/1.5.19 (2009-01-05)
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
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248749>

From: Pat Thoyts <patthoyts@users.sourceforge.net>
Date: Wed, 24 Oct 2012 00:15:29 +0100

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 contrib/credential/wincred/Makefile | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/contrib/credential/wincred/Makefile b/contrib/credential/wincred/Makefile
index 39fa5e0..e64cd9a 100644
--- a/contrib/credential/wincred/Makefile
+++ b/contrib/credential/wincred/Makefile
@@ -1,9 +1,5 @@
 all: git-credential-wincred.exe
 
-CC = gcc
-RM = rm -f
-CFLAGS = -O2 -Wall
-
 -include ../../../config.mak.autogen
 -include ../../../config.mak
 
-- 
1.9.2.msysgit.0.161.g83227c1

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
