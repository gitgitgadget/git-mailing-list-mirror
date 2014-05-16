From: Stepan Kasal <kasal@ucw.cz>
Subject: Re: [PATCH] grep -I: do not bother to read known-binary files
Date: Fri, 16 May 2014 11:16:41 +0200
Organization: <)><
Message-ID: <20140516091641.GC19845@camelia.ucw.cz>
References: <20140514154419.GA4517@camelia.ucw.cz> <20140514194128.GC2715@sigill.intra.peff.net> <alpine.DEB.1.00.1405151940170.14982@s15462909.onlinehome-server.info> <20140515192226.GC29746@sigill.intra.peff.net> <20140516081957.GA19845@camelia.ucw.cz> <20140516082958.GA21956@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>,
        msysGit <msysgit@googlegroups.com>
To: Jeff King <peff@peff.net>
X-From: msysgit+bncBCU63DXMWULRB6VO26NQKGQEU4OKOUY@googlegroups.com Fri May 16 11:16:44 2014
Return-path: <msysgit+bncBCU63DXMWULRB6VO26NQKGQEU4OKOUY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f58.google.com ([209.85.215.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRB6VO26NQKGQEU4OKOUY@googlegroups.com>)
	id 1WlEFv-0006ka-2Z
	for gcvm-msysgit@m.gmane.org; Fri, 16 May 2014 11:16:43 +0200
Received: by mail-la0-f58.google.com with SMTP id gl10sf207065lab.23
        for <gcvm-msysgit@m.gmane.org>; Fri, 16 May 2014 02:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:organization:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=z6A+SdR6lhCH83HvrAFc7RdMBJLI4+kP9ovRyX8Akk8=;
        b=eVIs6+LfCD0xBdK0FSyhUsLzhz9nLm/8udlQxMCrNvR+cTO44kObql0E+2gldeo6T4
         W39cbQ8wt7TdVz9Douf9cc/4Clbahtik9zfFQmLPISWaH+QvkkHzqpoItCi/04L3nvTn
         rwvOa7DEz+VodyO2T1p6iUGxJapquUMP72dpmxgsMypRbn2OPX27s0a0b3MXKiNaScbd
         m2J20+rlzL1XV+03mgDucTHiim2hiXUJ1zF3eaBLSpn2V4eMwN1NUeME8mPgmUFNcjX6
         pZEMkSIFaM/jlPGJW6rBI08md2mW9YE7XGKtpxz7P7N4d4BorCmeuYLXf+Dgrc3rFJF2
         qNIQ==
X-Received: by 10.152.4.136 with SMTP id k8mr4867lak.17.1400231802718;
        Fri, 16 May 2014 02:16:42 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.37.169 with SMTP id z9ls95429laj.66.gmail; Fri, 16 May
 2014 02:16:41 -0700 (PDT)
X-Received: by 10.152.115.195 with SMTP id jq3mr34107lab.4.1400231801775;
        Fri, 16 May 2014 02:16:41 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id r49si2552576eep.0.2014.05.16.02.16.41
        for <msysgit@googlegroups.com>;
        Fri, 16 May 2014 02:16:41 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 789231C00C4;
	Fri, 16 May 2014 11:16:41 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s4G9GfX7020115;
	Fri, 16 May 2014 11:16:41 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s4G9GfDB020114;
	Fri, 16 May 2014 11:16:41 +0200
In-Reply-To: <20140516082958.GA21956@sigill.intra.peff.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249286>

Hi,

On Fri, May 16, 2014 at 04:29:58AM -0400, Jeff King wrote:
> [..] I hope I did not sound like "blame Stepan, he was screwed up".

no, you did not, it was ok.

> From msysgit's perspective, they may or may not want to revert the patch
> that they already have. That is a _separate_ issue, and I think the

I hope Dscho will help with the decision: he can say "keep it until
we have evidence or at least time to do a more thorough review," for
example.

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
