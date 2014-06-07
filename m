From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH v2 0/2] mingw: macro main(), const warnings
Date: Sat,  7 Jun 2014 08:46:39 +0200
Message-ID: <1402123601-26312-1-git-send-email-kasal@ucw.cz>
References: <53922F58.80509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysGit <msysgit@googlegroups.com>,
	Stepan Kasal <kasal@ucw.cz>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRBWHKZKOAKGQEVFPDDSA@googlegroups.com Sat Jun 07 08:46:49 2014
Return-path: <msysgit+bncBCU63DXMWULRBWHKZKOAKGQEVFPDDSA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f187.google.com ([209.85.217.187])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBWHKZKOAKGQEVFPDDSA@googlegroups.com>)
	id 1WtAOu-0001gz-VL
	for gcvm-msysgit@m.gmane.org; Sat, 07 Jun 2014 08:46:48 +0200
Received: by mail-lb0-f187.google.com with SMTP id z11sf451522lbi.4
        for <gcvm-msysgit@m.gmane.org>; Fri, 06 Jun 2014 23:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=8Ny0alR6QSf/7jWdK/kGY/LgxEci50y0nRSHFawgCSQ=;
        b=mutkxrX1pMHQ4u/gGbsmQdo0bk4PGwDFbXcJ3Lw0ooXa5dESaculshlKyOF4PJLUr/
         XKC9GigmKvBEHaKCRWGN2uNwSfwq+0LVl4G3ZdRzGmi08shgtRv7IGKpObQRqkF4heGg
         Iq33WmXFw4Xey5MEfgq1fylAx9I8Zde82qgDXmu+qAFOJB6Ytjmxs0V8g+/xg/VlttdL
         w7PCxNTIbfPeFa2UvnYw6/QQ/XtE7Srq5OEIg14GoqhwtGIZJH475zhbG3vox7k070Hp
         zT0NlwnFXpkRf23+fsvWm1fkUtnjobmSzmqnmbVQiYdqFqf+zn0FjAajj0XNH/Zrx+HA
         ljGQ==
X-Received: by 10.152.23.165 with SMTP id n5mr138872laf.5.1402123608758;
        Fri, 06 Jun 2014 23:46:48 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.36.4 with SMTP id m4ls177589laj.45.gmail; Fri, 06 Jun 2014
 23:46:47 -0700 (PDT)
X-Received: by 10.152.21.133 with SMTP id v5mr51127lae.9.1402123607632;
        Fri, 06 Jun 2014 23:46:47 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id xk11si77373wib.0.2014.06.06.23.46.47
        for <msysgit@googlegroups.com>;
        Fri, 06 Jun 2014 23:46:47 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id 6B88D1C00A0; Sat,  7 Jun 2014 08:46:47 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <53922F58.80509@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251026>

Hi,

On Fri, Jun 06, 2014 at 11:15:04PM +0200, Karsten Blees wrote:
> Am 06.06.2014 21:13, schrieb Junio C Hamano:
> > I am wondering why the solution is not a more obvious "drop const
> > that is not ANSI C", though.  I only have a ready-access to N1570
> > draft but in it I find:
> >
>
> Actually, that was the original solution ($gmane/247535).

> > Karsten Blees <karsten.blees@gmail.com> writes:
> >> A simpler solution that works with all definitions of main() is to
> >> cast to void* (tell the compiler all responsibility is on
> >> us).

Indeed, verified.  Re-submitting.
Cheers,
	Stepan

Karsten Blees (1):
  Win32: move main macro to a function

Stepan Kasal (1):
  mingw: avoid const warning

 compat/mingw.c | 15 +++++++++++++++
 compat/mingw.h | 14 ++++----------
 2 files changed, 19 insertions(+), 10 deletions(-)

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
