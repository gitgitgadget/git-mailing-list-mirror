From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git grep -O -i: if the pager is 'less', pass
 the '-i' option
Date: Thu, 15 May 2014 15:18:24 -0400
Message-ID: <20140515191824.GB29746@sigill.intra.peff.net>
References: <20140514155010.GA4592@camelia.ucw.cz>
 <xmqq7g5okztp.fsf@gitster.dls.corp.google.com>
 <20140514182654.GA9218@google.com>
 <20140514190716.GA2715@sigill.intra.peff.net>
 <alpine.DEB.1.00.1405151944410.14982@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Stepan Kasal <kasal@ucw.cz>,
	GIT Mailing-list <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBDO2DJFKTEFBBBFG2SNQKGQELPHO4CY@googlegroups.com Thu May 15 21:18:29 2014
Return-path: <msysgit+bncBDO2DJFKTEFBBBFG2SNQKGQELPHO4CY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-oa0-f59.google.com ([209.85.219.59])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDO2DJFKTEFBBBFG2SNQKGQELPHO4CY@googlegroups.com>)
	id 1Wl1Aj-0003HN-7H
	for gcvm-msysgit@m.gmane.org; Thu, 15 May 2014 21:18:29 +0200
Received: by mail-oa0-f59.google.com with SMTP id eb12sf421124oac.14
        for <gcvm-msysgit@m.gmane.org>; Thu, 15 May 2014 12:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-disposition;
        bh=SHq5I/SeqtkdFgO1SWhjmEUbI3dlBO1YoUvsadUZ1Ag=;
        b=Mo9a1IgZegN4cGbABiSD8Qf03XUM7XnAYMYo8WkRTUWIFZm7AEvnK7i5gIsv4DeNgl
         4WWnFErKlcUzFosb45ID5AqcNoAAWCcstbsYozXe4hWHzH/KeZtrri9eLM9UpYiy0nYm
         7B/eGCKZDPNff7SkZgLDw3FGK6ogrjPUWw1XAew72gT2NzdbyYu7GjjBL3v7vPpUuNN9
         RN5nXxdstwVY5etvJeIzMd1e2XOh841+mHJQ1NBrtPv0nyeMzjNDEMGFI0tIK2jgikUC
         4kzST8OMwk+IQc+nxd53J0YYJcENg4CajombZeC0+ydMrVfj12C1TMAEcf7yKqCJjaJy
         90Mw==
X-Received: by 10.50.73.69 with SMTP id j5mr364654igv.14.1400181508371;
        Thu, 15 May 2014 12:18:28 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.253.161 with SMTP id ab1ls569159igd.9.gmail; Thu, 15 May
 2014 12:18:27 -0700 (PDT)
X-Received: by 10.66.157.138 with SMTP id wm10mr3461627pab.23.1400181507828;
        Thu, 15 May 2014 12:18:27 -0700 (PDT)
Received: from peff.net (cloud.peff.net. [50.56.180.127])
        by gmr-mx.google.com with SMTP id b5si557784igl.0.2014.05.15.12.18.27
        for <msysgit@googlegroups.com>;
        Thu, 15 May 2014 12:18:27 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff@peff.net designates 50.56.180.127 as permitted sender) client-ip=50.56.180.127;
Received: (qmail 30374 invoked by uid 102); 15 May 2014 19:18:27 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 15 May 2014 14:18:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 May 2014 15:18:24 -0400
In-Reply-To: <alpine.DEB.1.00.1405151944410.14982@s15462909.onlinehome-server.info>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249187>

On Thu, May 15, 2014 at 07:46:49PM +0200, Johannes Schindelin wrote:

> > We've already found the lines of interest to the user. It would be nice
> > if we could somehow point the pager at them by number, rather than
> > repeating the (slightly incompatible) search.
> 
> FWIW it is exactly that type of "I want your patch to do more than you do"
> type of comments that makes it impossible for myself to contribute patches
> anymore. It just does not fit inside my Git time budget anymore.

I'm sorry you took it that way. What I meant to say was "it would be
nice if we could do it this other way, which is more robust, but I don't
think it is easy.  Let's take the patch". I.e., when I later said:

>>> But as is, it's an improvement, so (except that "-i" should be
>>> replaced by "-I") it seems like a good change.
>>
>>Agreed. Thanks for the list of problematic options.

the "agreed" there is with "it seems like a good change".

And I also wanted to point people to existing work, if they did want to
explore doing it that other way.  I really didn't expect anything from
you (beyond s/i/I/, as Jonathan suggested).

> Besides, it breaks exactly the intended usage. My intent is not just to
> see the matching lines in the pager, but to be able to adjust the search
> pattern further if needed. Your suggestion completely breaks that usage.

Thanks, this is a point I hadn't considered.

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
