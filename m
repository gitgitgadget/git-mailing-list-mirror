From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re: [PATCH] Add a Windows-specific fallback to getenv("HOME");
Date: Wed, 4 Jun 2014 17:14:34 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1406041713500.14982@s15462909.onlinehome-server.info>
References: <20140604114730.GB22250@camelia.ucw.cz> <CACsJy8BDk4gdRzjp_XpQXXMW1sEnS4DoedanFLONODuJXdeeRA@mail.gmail.com> <CABPQNSYXsu1muRTVUg6ybB9_MJP_wJi-4PmSec+8EwrvsCHMRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: Duy Nguyen <pclouds@gmail.com>, Stepan Kasal <kasal@ucw.cz>, 
    GIT Mailing-list <git@vger.kernel.org>, 
    Thomas Braun <thomas.braun@virtuell-zuhause.de>, 
    msysGit <msysgit@googlegroups.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRBX7PXSOAKGQEB3P54GQ@googlegroups.com Wed Jun 04 17:14:42 2014
Return-path: <msysgit+bncBCZPH74Q5YNRBX7PXSOAKGQEB3P54GQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f190.google.com ([209.85.217.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBX7PXSOAKGQEB3P54GQ@googlegroups.com>)
	id 1WsCtk-0002K4-ST
	for gcvm-msysgit@m.gmane.org; Wed, 04 Jun 2014 17:14:40 +0200
Received: by mail-lb0-f190.google.com with SMTP id p9sf771683lbv.27
        for <gcvm-msysgit@m.gmane.org>; Wed, 04 Jun 2014 08:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=V8sZpDx1u3vk2cwQ7oeIZ0LvOkDMIwyBfm2Y1MT2yGU=;
        b=qsJVRMG82HFJdXu5HL6BXDviTW9t39bvkH4r40lR6SP+MMxlXn3zRYj6H6nJuM2zQ9
         x7RYmxrg/cgweDrUqctvIwmHCrMw1FGZ9OpZnSmb0OduH4y0hwWeB0a5G5PhzJFem9eL
         8PhFfbiAq1weWEVPUXYAO0Co8X+vc7niJvIS0PMwj5veFfmUCzT80P7FgUIZuzi+OUyG
         BCHEviJlggcAMrHBjptlOlYMM6woYSXSZ+fjl/9xXGURJxL/2rAOZ7DGGQTcmhDssh+M
         2L/8Qot/HLEXz4ixj6dxhBRsu3kiZkI+0EbkaDl9Sdea96vDQx24RibBxYeAODWaCFNg
         +E4g==
X-Received: by 10.180.198.171 with SMTP id jd11mr12323wic.15.1401894880068;
        Wed, 04 Jun 2014 08:14:40 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.189.163 with SMTP id gj3ls283625wic.27.gmail; Wed, 04 Jun
 2014 08:14:39 -0700 (PDT)
X-Received: by 10.14.198.200 with SMTP id v48mr619421een.5.1401894878537;
        Wed, 04 Jun 2014 08:14:38 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.21])
        by gmr-mx.google.com with ESMTPS id xk11si597744wib.0.2014.06.04.08.14.38
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jun 2014 08:14:38 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.21 as permitted sender) client-ip=212.227.17.21;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0MOkQc-1Wuvuu3kEI-0069Zd;
 Wed, 04 Jun 2014 17:14:34 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <CABPQNSYXsu1muRTVUg6ybB9_MJP_wJi-4PmSec+8EwrvsCHMRw@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:USGYaHRVOPMMxSr+tcTFNzXxJ9gmTReIFDywbC8NM9o2rKqXNO8
 8PIy8iVesqTJzNg/Ltw4dFSxY/1TaajKXWdgvQjKT+rvHA7mDqTFF7zKx821/GOafWMN/5Z
 UVyw2LGR5TzNTovvM2WwpgKbBUBzDIerm9N3/5za4GGkGxkgspDSrLIeKEuSx/anmjFIh/R
 O1GITXXephy1tqMNb7yvw==
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.21 as
 permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250738>

Hi Erik,

On Wed, 4 Jun 2014, Erik Faye-Lund wrote:

> On Wed, Jun 4, 2014 at 3:47 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> > On Wed, Jun 4, 2014 at 6:47 PM, Stepan Kasal <kasal@ucw.cz> wrote:
> >> @@ -133,7 +133,7 @@ char *git_path(const char *fmt, ...)
> >>  void home_config_paths(char **global, char **xdg, char *file)
> >>  {
> >>         char *xdg_home = getenv("XDG_CONFIG_HOME");
> >> -       char *home = getenv("HOME");
> >> +       const char *home = get_home_directory();
> >>         char *to_free = NULL;
> >>
> >>         if (!home) {
> >
> > Just checking. Instead of replace the call sites, can we check and
> > setenv("HOME") if it's missing instead? MinGW port already replaces
> > main(). Extra initialization should not be a problem. I feel
> > "getenv("HOME")" a tiny bit more familiar than get_home_directory(),
> > but that's really weak argument as the number of call sites has not
> > increased in 4 years.
> 
> Yeah. But we already set %HOME% to %HOMEDRIVE%%HOMEPATH% in
> /etc/profile, git-cmd.bat, gitk.cmd *and* git-wrapper... Do we really
> need one more place?
> 
> It seems some of these could be dropped...

No. Git is not always called through Bash or the git-wrapper,
unfortunately.

Ciao,
Dscho

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
