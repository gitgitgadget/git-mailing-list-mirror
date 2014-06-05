From: Stepan Kasal <kasal@ucw.cz>
Subject: Re: [PATCH v2] Add a Windows-specific fallback to getenv("HOME");
Date: Thu, 5 Jun 2014 13:23:22 +0200
Organization: <)><
Message-ID: <20140605112322.GB28309@camelia.ucw.cz>
References: <20140604114730.GB22250@camelia.ucw.cz> <CACsJy8BDk4gdRzjp_XpQXXMW1sEnS4DoedanFLONODuJXdeeRA@mail.gmail.com> <CABPQNSYXsu1muRTVUg6ybB9_MJP_wJi-4PmSec+8EwrvsCHMRw@mail.gmail.com> <alpine.DEB.1.00.1406041713500.14982@s15462909.onlinehome-server.info> <CABPQNSavYCrdUDyNru-HHMFkdgDRvaCp++f8ZgGKv07sS0eXGQ@mail.gmail.com> <alpine.DEB.1.00.1406041725460.14982@s15462909.onlinehome-server.info> <alpine.DEB.1.00.1406041741470.14982@s15462909.onlinehome-server.info> <538FCAF5.7030102@gmail.com> <20140605080317.GA28029@camelia.ucw.cz> <53903B22.70507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Erik Faye-Lund <kusmabite@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        msysGit <msysgit@googlegroups.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCU63DXMWULRBLFGYGOAKGQETCURSCI@googlegroups.com Thu Jun 05 13:23:26 2014
Return-path: <msysgit+bncBCU63DXMWULRBLFGYGOAKGQETCURSCI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f184.google.com ([74.125.82.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBLFGYGOAKGQETCURSCI@googlegroups.com>)
	id 1WsVlV-00014m-BJ
	for gcvm-msysgit@m.gmane.org; Thu, 05 Jun 2014 13:23:25 +0200
Received: by mail-we0-f184.google.com with SMTP id x48sf97476wes.21
        for <gcvm-msysgit@m.gmane.org>; Thu, 05 Jun 2014 04:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:organization:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=deSiXlqE4quQXZGj1zK+LnZPKuVvGcfNtcU9p+tSFjs=;
        b=hqF1DjRGGHazN0ePaJEqc3pPfjp08k+IjetkYuNXKvY7wJwMMSv1vg1xcYOtwZSEfO
         k04uUDGMxCpAjJ3KOGpRuPkUmyoQ9EdBpAvsPQKxOvHxW5gw4KDa+5oF4+i00ocG2LKK
         PTZC1pe9Tbl0+rr45SDl7tRLPPm/e47honEjmJ8hOwtNZE+OtN6fgdgfpu34OkxxZirm
         rut2tMqRfixXi074S05tmvJjjJUM4zsvMYgD5MnrIwwe2OwQxST3BXSrg1lt4lf49HBu
         vyKAnfuWpkE2EdmEnLO0L3Ake+nH2Xg6hJAJG+DOUELvSR1C7iA3uBOefRAhCCqx94Vl
         5MAQ==
X-Received: by 10.180.106.230 with SMTP id gx6mr34635wib.0.1401967405023;
        Thu, 05 Jun 2014 04:23:25 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.189.208 with SMTP id gk16ls77661wic.32.gmail; Thu, 05 Jun
 2014 04:23:23 -0700 (PDT)
X-Received: by 10.180.82.98 with SMTP id h2mr2224715wiy.0.1401967403929;
        Thu, 05 Jun 2014 04:23:23 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id s1si898938wiw.3.2014.06.05.04.23.23
        for <msysgit@googlegroups.com>;
        Thu, 05 Jun 2014 04:23:23 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 9B9AF1C0094;
	Thu,  5 Jun 2014 13:23:23 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s55BNNVC028720;
	Thu, 5 Jun 2014 13:23:23 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s55BNMR7028719;
	Thu, 5 Jun 2014 13:23:22 +0200
In-Reply-To: <53903B22.70507@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250830>

Hello,

On Thu, Jun 05, 2014 at 11:40:50AM +0200, Karsten Blees wrote:
> Am 05.06.2014 10:03, schrieb Stepan Kasal:
> > I hope you can ack this patch as a step forward.
> 
> No, not really. It's sure better than introducing a special
> get_home_directory(), but it still increases the diff between
> upstream and msysgit rather than reducing it. [...]

this patch (v3) is a win-win for both sides:

- upstream would get at least $HOMEDRIVE$HOMEPATH
- downstream would get rid of get_home_directory
- it would decrease the diff, in my metric[*]

[*]  The patch with get_home_directory() could be that dropped.
Yes, the patch "84b7969 Win32: patch Windows environment on startup"
would have to be updated, but I can handle that easily.

> The main critique points still remain:
>  * $HOME is usually set up correctly before calling git, [...]
>  * even if $HOME was empty, git should setenv("HOME") [...]
>  * no fallback to $USERPROFILE [...]

This is a plan for further work, but not an argument against the
current version of patch.

> If you really have time to spare, I suggest you focus on getting
> the Unicode patches upstream so that we can progress from there

Not that much time.  That's why I try to push the patches that seem
to be simpler.  Some get discussed, some get ignored, but some get
accepted (or dropped).

Stepan

PS:
tongue in cheek:
If _you_ could find some time, could you please support these:
http://thread.gmane.org/gmane.comp.version-control.msysgit/20324

The first patch of the pair introduces mingw_startup, which is a good
base for other changes.
The second one is my new fix for const warnings, exactly according
to the lines mentioned here: instead of fixing all the consumers and
waiting when it'll break again, I modified the mingw-specific code
to adapt better.

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
