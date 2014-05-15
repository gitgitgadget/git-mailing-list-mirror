From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] grep -I: do not bother to read known-binary files
Date: Thu, 15 May 2014 15:22:26 -0400
Message-ID: <20140515192226.GC29746@sigill.intra.peff.net>
References: <20140514154419.GA4517@camelia.ucw.cz>
 <20140514194128.GC2715@sigill.intra.peff.net>
 <alpine.DEB.1.00.1405151940170.14982@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stepan Kasal <kasal@ucw.cz>, GIT Mailing-list <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBDO2DJFKTEFBB5FH2SNQKGQEMG4CH3I@googlegroups.com Thu May 15 21:22:31 2014
Return-path: <msysgit+bncBDO2DJFKTEFBB5FH2SNQKGQEMG4CH3I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ie0-f184.google.com ([209.85.223.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDO2DJFKTEFBB5FH2SNQKGQEMG4CH3I@googlegroups.com>)
	id 1Wl1Ec-0005uB-6C
	for gcvm-msysgit@m.gmane.org; Thu, 15 May 2014 21:22:30 +0200
Received: by mail-ie0-f184.google.com with SMTP id at1sf421352iec.11
        for <gcvm-msysgit@m.gmane.org>; Thu, 15 May 2014 12:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-disposition;
        bh=4hB6qUgh7qnsDf0PPeFmo36cP0zbGmCW+VrSPMCv3yA=;
        b=drnHoxSlR/Nq7ulwIsnHyuG8sZ/Y4VWlMWhjgwgZbtxR4UgIsSIlg6CGalu3aiLS+6
         h5/zAeg2fMHYpR+2sTsw9Np+JZnnxV0QF7mKdVz0I7J6hx1kVhW0BRSLe6aNwdVk68u+
         S6LJOvOznmnECZCzCMVAywHOJW6EufFyNP8XKx0BPCF0OZvJ1UINSgcCCtm4NZUST2oG
         UKUiXksixoQ4xt0oeiCLNKpftqKanpHVjzfwRVkjp5XOjAQmemMnrfoIIgfc6vmRgOFp
         fX94tyMxrD+D8RqcS0vObmaPdcSjpOmSrbDkt6dFtODiL6IHuzQZn3ObemxHGTsU5P0E
         UYgg==
X-Received: by 10.140.50.83 with SMTP id r77mr56297qga.15.1400181749318;
        Thu, 15 May 2014 12:22:29 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.106.98 with SMTP id d89ls364484qgf.57.gmail; Thu, 15 May
 2014 12:22:28 -0700 (PDT)
X-Received: by 10.236.159.39 with SMTP id r27mr5646799yhk.7.1400181748871;
        Thu, 15 May 2014 12:22:28 -0700 (PDT)
Received: from peff.net (cloud.peff.net. [50.56.180.127])
        by gmr-mx.google.com with SMTP id jj2si1617762igb.3.2014.05.15.12.22.28
        for <msysgit@googlegroups.com>;
        Thu, 15 May 2014 12:22:28 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff@peff.net designates 50.56.180.127 as permitted sender) client-ip=50.56.180.127;
Received: (qmail 30565 invoked by uid 102); 15 May 2014 19:22:28 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 15 May 2014 14:22:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 May 2014 15:22:26 -0400
In-Reply-To: <alpine.DEB.1.00.1405151940170.14982@s15462909.onlinehome-server.info>
X-Original-Sender: peff@peff.net
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of peff@peff.net designates 50.56.180.127 as permitted
 sender) smtp.mail=peff@peff.net
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249188>

On Thu, May 15, 2014 at 07:42:00PM +0200, Johannes Schindelin wrote:

> > Hrm. Is this patch still necessary? In the time since this patch was
> > written, we did 0826579 (grep: load file data after checking
> > binary-ness, 2012-02-02)
> 
> I have no time to test this but I trust that you made sure that it works
> as advertised. In my case, there were about 500 gigabytes of image data
> intermixed with code, and waiting for 'git grep' was not funny at all (and
> I did not have time back then to go through a full code submission cycle
> on the Git mailing list, either).
> 
> So I guess we can drop my patch.

Certainly I tested it at the time (those commits I referenced contain
timing information), and it should have improved the workload you
describe. I did not test before/after the patch in this thread, but only
read it and noticed that it was trying to do the same thing (that is why
I said "I suspect...").

As the person who is proposing the patch for git.git, I would hope
Stepan would follow up on such review and confirm whether or not it is
still needed.

-Peff

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
