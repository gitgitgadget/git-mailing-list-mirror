From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 2/2] wincred: avoid overwriting configured variables
Date: Tue, 13 May 2014 08:53:35 +0200
Organization: <)><
Message-ID: <20140513065335.GA28417@camelia.ucw.cz>
References: <20140430064610.GA22094@camelia.ucw.cz> <CABPQNSZsviaGqFeKZE4ofF6HoUQrPvNPuowar4YDjk_Mbu5iCQ@mail.gmail.com> <20140430112724.GA22929@camelia.ucw.cz> <CABPQNSafKXDLyBj5OYW-PPWdxfxQtC23vKQsQ-_Pa1empU=n8g@mail.gmail.com> <20140513055953.GA28182@camelia.ucw.cz> <20140513060144.GC28182@camelia.ucw.cz> <CABPQNSYU5haMzdy2cDn=KF2+j_aFK19Ju+x+LTeex6JqWJMncQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Mailing-list <git@vger.kernel.org>,
        Pat Thoyts <patthoyts@users.sourceforge.net>,
        msysGit <msysgit@googlegroups.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: msysgit+bncBCU63DXMWULRB4ECY6NQKGQEB7C6Y3A@googlegroups.com Tue May 13 08:53:38 2014
Return-path: <msysgit+bncBCU63DXMWULRB4ECY6NQKGQEB7C6Y3A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f186.google.com ([209.85.217.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRB4ECY6NQKGQEB7C6Y3A@googlegroups.com>)
	id 1Wk6an-0003Tz-QK
	for gcvm-msysgit@m.gmane.org; Tue, 13 May 2014 08:53:37 +0200
Received: by mail-lb0-f186.google.com with SMTP id c11sf763753lbj.13
        for <gcvm-msysgit@m.gmane.org>; Mon, 12 May 2014 23:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:organization:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=ZiWXeu1Jm8tGZYMbxG0VO+SkxFO9DsWqZjy3XjC2sTo=;
        b=GKjHZNiagKJELFjSMxXj4G6qrkh2hl/kEa59r67tt4P6dfVXUzs8k5+Vt9SBJj8Y+B
         Pf2ecSp4xElEY5Lzp76BZ1agiZBaT6pE7fPnG19ZayIgNvhwwSByIKyA0aGoGap7Gyng
         THlgQCnJ+7Fvl7MlpPp0rGkBzfqIa1LnKIcLiwYOM6t7nmndwGgXcVlezXHh3pzI2IHp
         prmIhwacruL1AAAqZt1Ek36WcEyHvoXDw7trxOERCVTrwV7MNi5qlGb0TtUYtTGcWRSX
         qxtUKU2wJuwL6Bt6oHrYEoUH2NGSjoDMR1wfb0dS+nY/mTmE5uD8v+SqswODQZUcNX0g
         exCA==
X-Received: by 10.180.109.161 with SMTP id ht1mr98133wib.6.1399964017487;
        Mon, 12 May 2014 23:53:37 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.104.1 with SMTP id ga1ls856633wib.41.canary; Mon, 12 May
 2014 23:53:36 -0700 (PDT)
X-Received: by 10.14.218.9 with SMTP id j9mr760530eep.2.1399964016466;
        Mon, 12 May 2014 23:53:36 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id u49si1704070eeo.1.2014.05.12.23.53.36
        for <msysgit@googlegroups.com>;
        Mon, 12 May 2014 23:53:36 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 34F581C00EF;
	Tue, 13 May 2014 08:53:36 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s4D6rZFd028453;
	Tue, 13 May 2014 08:53:35 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s4D6rZ3G028452;
	Tue, 13 May 2014 08:53:35 +0200
In-Reply-To: <CABPQNSYU5haMzdy2cDn=KF2+j_aFK19Ju+x+LTeex6JqWJMncQ@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248752>

From: Pat Thoyts <patthoyts@users.sourceforge.net>
Date: Wed, 24 Oct 2012 00:15:29 +0100

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---

Hi kusma,

On Tue, May 13, 2014 at 08:34:36AM +0200, Erik Faye-Lund wrote:
> Would it be better to set these if not already set, i.e:
> 
> -CC = gcc
> -RM = rm -f
> -CFLAGS = -O2 -Wall
> +CC ?= gcc
> +RM ?= rm -f
> +CFLAGS ?= -O2 -Wall
> 
> instead?

... and moving it after the two includes, so that it does not
override the values set there?

Can you ack this?

 contrib/credential/wincred/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/credential/wincred/Makefile b/contrib/credential/wincred/Makefile
index 39fa5e0..6e992c0 100644
--- a/contrib/credential/wincred/Makefile
+++ b/contrib/credential/wincred/Makefile
@@ -1,12 +1,12 @@
 all: git-credential-wincred.exe
 
-CC = gcc
-RM = rm -f
-CFLAGS = -O2 -Wall
-
 -include ../../../config.mak.autogen
 -include ../../../config.mak
 
+CC ?= gcc
+RM ?= rm -f
+CFLAGS ?= -O2 -Wall
+
 prefix ?= /usr/local
 libexecdir ?= $(prefix)/libexec/git-core
 
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
