From: Stepan Kasal <kasal@ucw.cz>
Subject: Re: Re: [PATCH] Add a Windows-specific fallback to getenv("HOME");
Date: Wed, 4 Jun 2014 17:45:03 +0200
Organization: <)><
Message-ID: <20140604154503.GB22681@camelia.ucw.cz>
References: <20140604114730.GB22250@camelia.ucw.cz> <CACsJy8BDk4gdRzjp_XpQXXMW1sEnS4DoedanFLONODuJXdeeRA@mail.gmail.com> <CABPQNSYXsu1muRTVUg6ybB9_MJP_wJi-4PmSec+8EwrvsCHMRw@mail.gmail.com> <alpine.DEB.1.00.1406041713500.14982@s15462909.onlinehome-server.info> <CABPQNSavYCrdUDyNru-HHMFkdgDRvaCp++f8ZgGKv07sS0eXGQ@mail.gmail.com> <alpine.DEB.1.00.1406041725460.14982@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Erik Faye-Lund <kusmabite@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        msysGit <msysgit@googlegroups.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBCU63DXMWULRBAX6XSOAKGQERGJEOEQ@googlegroups.com Wed Jun 04 17:45:10 2014
Return-path: <msysgit+bncBCU63DXMWULRBAX6XSOAKGQERGJEOEQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f188.google.com ([74.125.82.188])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBAX6XSOAKGQERGJEOEQ@googlegroups.com>)
	id 1WsDNC-0007Wa-RJ
	for gcvm-msysgit@m.gmane.org; Wed, 04 Jun 2014 17:45:06 +0200
Received: by mail-we0-f188.google.com with SMTP id p10sf730886wes.5
        for <gcvm-msysgit@m.gmane.org>; Wed, 04 Jun 2014 08:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:organization:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=bfAvuM7tysZ5GLDV5eK0qf2XshE4MzL1VcDZMzTIA+U=;
        b=kwKQwRUcxO35U2PxE7HFY6Sc+r5JO5mLhVDMC0IzBBm+aKOPt+vKIClz/g32cEvtJh
         zSRA2J4OBho2oL83v9BV4QNuGr+AQ37q5o9N8znvCsGrw0zSosCG45uyz3aElc94WKuO
         QphHgWraL+mBQttP6gJs1FPNkmJVzM1v3XNECE8oDKwFWMbSPCfJzyli2Z9Pqpw4pI3t
         4rBKjQ8gxmps7dEKG8/CQ2xchNjBSV3K/8ZkLoX66pZ3MkodRQhnL5PdyJT6ipcL1Vft
         B8tFVadjjDLqaODdIQhB0ppMETp8rzYp+dIjOVMJ3ZO3SZglXgA0nuxI4EXhK1j4ouN6
         WE4w==
X-Received: by 10.152.88.65 with SMTP id be1mr10219lab.35.1401896706482;
        Wed, 04 Jun 2014 08:45:06 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.44.130 with SMTP id e2ls476189lam.16.gmail; Wed, 04 Jun
 2014 08:45:05 -0700 (PDT)
X-Received: by 10.152.170.130 with SMTP id am2mr557619lac.8.1401896705543;
        Wed, 04 Jun 2014 08:45:05 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id xk11si612913wib.0.2014.06.04.08.45.05
        for <msysgit@googlegroups.com>;
        Wed, 04 Jun 2014 08:45:05 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id DD3D11C0093;
	Wed,  4 Jun 2014 17:45:04 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s54Fj4wc023154;
	Wed, 4 Jun 2014 17:45:04 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s54Fj3Ok023153;
	Wed, 4 Jun 2014 17:45:03 +0200
In-Reply-To: <alpine.DEB.1.00.1406041725460.14982@s15462909.onlinehome-server.info>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250741>

Hi dscho,

> > On Wed, Jun 4, 2014 at 5:14 PM, Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > > No. Git is not always called through Bash or the git-wrapper,
> > > unfortunately.

but you have to admit, that in most cases it is called through bash
or the git wrapper.

> The problem arises whenever git.exe calls subprocesses. You can pollute
> the environment by setting HOME, I do not recall the details, but I
> remember that we had to be very careful *not* to do that, hence the patch.
> Sorry, has been a long time.

Yeah, memories.  Is this experience still valid?  How many users do
profit from this, using c:/Program\ Files \(86\)/bin/git.exe instead of 
c:/Program\ Files \(86\)/cmd/git.exe, either by pure luck or
intentionally?

It seems that we should keep the patch, to minimize surprise if
bin/git.exe is used directly.

But we should probably make it consistent with other places:
- $HOMEDRIVE$HOMEPATH (without the slash)
- $USERPROFILE if the above dir does not exist.
- setenv HOME instead of wrapper

We can make this change for msysGit 2.0.0 only, so that we do not
break 1.9.4 ;-)

Does this make sense?
	Stepan

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
