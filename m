From: Stepan Kasal <kasal@ucw.cz>
Subject: Re: Re: [PATCH] Add a Windows-specific fallback to getenv("HOME");
Date: Wed, 4 Jun 2014 18:16:25 +0200
Organization: <)><
Message-ID: <20140604161625.GB23226@camelia.ucw.cz>
References: <20140604114730.GB22250@camelia.ucw.cz> <CACsJy8BDk4gdRzjp_XpQXXMW1sEnS4DoedanFLONODuJXdeeRA@mail.gmail.com> <CABPQNSYXsu1muRTVUg6ybB9_MJP_wJi-4PmSec+8EwrvsCHMRw@mail.gmail.com> <alpine.DEB.1.00.1406041713500.14982@s15462909.onlinehome-server.info> <CABPQNSavYCrdUDyNru-HHMFkdgDRvaCp++f8ZgGKv07sS0eXGQ@mail.gmail.com> <alpine.DEB.1.00.1406041725460.14982@s15462909.onlinehome-server.info> <20140604154503.GB22681@camelia.ucw.cz> <alpine.DEB.1.00.1406041749590.14982@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Erik Faye-Lund <kusmabite@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        msysGit <msysgit@googlegroups.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBCU63DXMWULRBW4MXWOAKGQEHVGJULQ@googlegroups.com Wed Jun 04 18:16:54 2014
Return-path: <msysgit+bncBCU63DXMWULRBW4MXWOAKGQEHVGJULQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f185.google.com ([209.85.212.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBW4MXWOAKGQEHVGJULQ@googlegroups.com>)
	id 1WsDrY-0005Ye-1U
	for gcvm-msysgit@m.gmane.org; Wed, 04 Jun 2014 18:16:28 +0200
Received: by mail-wi0-f185.google.com with SMTP id e4sf124376wiv.2
        for <gcvm-msysgit@m.gmane.org>; Wed, 04 Jun 2014 09:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:organization:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=ckcYcWyHCMG7EhxPATGXtXJ0Gpr5rjIvJJc19zOgkNg=;
        b=RGEW2aP6F/sLAwvCHluszcNG6cVd8A4aPI4BrN0U9jdnRQlcPPVWGMmpDuxlfL1Mn1
         VwVDlszI+eecYD7DEW+M9lYAXMDuU+4j3jIC5FM8UJSqZpYY0j8HzLIb08AG1yGH9PHE
         fiG2eZ3/6k/H4Yk+5rHoJBjE3xYQFRg0OeXboCvUe2zzsPGr71Jzm/HxzMreFZKLQwJc
         i1ya7CLR/Fdo5AtoAzjB4NCfXgm537EUnApj6IBFnzGalHDEyq+qutCp1a5SzUSjtKw2
         a6KYwRYKdZyRqgTXBjIelA/xwFB9jjhm5aZfETTtC6ZJERUTfERqs/WaKdCE84CShGdz
         3S1A==
X-Received: by 10.152.37.65 with SMTP id w1mr101laj.42.1401898587763;
        Wed, 04 Jun 2014 09:16:27 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.205.11 with SMTP id lc11ls585441lac.79.gmail; Wed, 04 Jun
 2014 09:16:26 -0700 (PDT)
X-Received: by 10.112.163.195 with SMTP id yk3mr400871lbb.20.1401898586817;
        Wed, 04 Jun 2014 09:16:26 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id el3si1221923wib.0.2014.06.04.09.16.26
        for <msysgit@googlegroups.com>;
        Wed, 04 Jun 2014 09:16:26 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 7A97E1C00A8;
	Wed,  4 Jun 2014 18:16:26 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s54GGQRs023376;
	Wed, 4 Jun 2014 18:16:26 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s54GGP5c023375;
	Wed, 4 Jun 2014 18:16:25 +0200
In-Reply-To: <alpine.DEB.1.00.1406041749590.14982@s15462909.onlinehome-server.info>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250746>

Hi dscho,

your arguments seem really strong.  (Especially the four years of
battle testing, with the memories of constant problems with HOME before.)

I hope they are strong enough to convince Junio to accept this patch;
that would help.

Stepan

PS (about mingwGitDevEnv):
> plan is to switch to mingwGitDevEnv for said release. No more msysGit.
> Like, bu-bye. Thanks for all the fish.

Interesting.

With msysgit, there is the "net installer" - first time I installed
msys/mingw sucessfully, it was as easy as Cygwin, perhaps even
easier.

When I go to mingwGitDevEnv home page, I read about chickens, eggs,
and upgrading Perl (which msysGit simply gives up, hinting that it is
almost impossible).
So I decided to wait for their Git 2.0.0 release before I try to
install it (again).

I apologize for being so cheeky, I hope it will help anyway...

PPS: from marketing point of view, mingwGitDevEnv is far from usable
name.  Dscho, if you support the idea, would you mind franchising
msysGit 2.0 for a decent amount?

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
