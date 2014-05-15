From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git grep -O -i: if the pager is 'less', pass
 the '-i' option
Date: Thu, 15 May 2014 10:56:14 -0700
Message-ID: <20140515175614.GN9218@google.com>
References: <20140514155010.GA4592@camelia.ucw.cz>
 <xmqq7g5okztp.fsf@gitster.dls.corp.google.com>
 <20140514182654.GA9218@google.com>
 <20140514190716.GA2715@sigill.intra.peff.net>
 <alpine.DEB.1.00.1405151944410.14982@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Stepan Kasal <kasal@ucw.cz>, GIT Mailing-list <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBD6LRKOE4AIRBQP72ONQKGQEIR4I5JY@googlegroups.com Thu May 15 19:56:24 2014
Return-path: <msysgit+bncBD6LRKOE4AIRBQP72ONQKGQEIR4I5JY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pb0-f56.google.com ([209.85.160.56])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBD6LRKOE4AIRBQP72ONQKGQEIR4I5JY@googlegroups.com>)
	id 1WkztD-0004eE-Ne
	for gcvm-msysgit@m.gmane.org; Thu, 15 May 2014 19:56:20 +0200
Received: by mail-pb0-f56.google.com with SMTP id ma3sf398850pbc.1
        for <gcvm-msysgit@m.gmane.org>; Thu, 15 May 2014 10:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=s+ZO+aoOz5nrqCBV4NyNiB/3bTbqpqsLDS2OO9amWEs=;
        b=IvUYIUzAuIMHns+3Hat/GxOAEL2TJ9H5cGi/UGigSagAF12KfEcRjb8aEGy7xzQfF4
         lyZVkLoS07qSBZX2yd/TW1JCxRZ4rFoFuXrLDTV/94v4QxL9jua7jwdT1mlDlZu5FqQF
         hbyl78jhIy99oWeUpPSrN3ZAeR4+aVlm2zfEwek8hwgah6bpvT39CFZW9CZu4Dy+LbGx
         CqQ8kfitqsrNV7jzk99CbbBK4Yy5yOuRXc4Mg28DkzzbkwfdpDzajz/64AE7HqzPxP7n
         XwMz3SqfWeLLFwDiM5fiT9MOpkL54wn/TXk0dr4I3m2ftBV7EBTVl1huI3n5dCNulZB9
         FTdg==
X-Received: by 10.50.92.34 with SMTP id cj2mr769871igb.4.1400176578678;
        Thu, 15 May 2014 10:56:18 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.79.199 with SMTP id l7ls568125igx.30.gmail; Thu, 15 May
 2014 10:56:17 -0700 (PDT)
X-Received: by 10.42.236.68 with SMTP id kj4mr4963594icb.6.1400176577824;
        Thu, 15 May 2014 10:56:17 -0700 (PDT)
Received: from mail-pb0-x234.google.com (mail-pb0-x234.google.com [2607:f8b0:400e:c01::234])
        by gmr-mx.google.com with ESMTPS id zs4si1310669pbc.1.2014.05.15.10.56.17
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 15 May 2014 10:56:17 -0700 (PDT)
Received-SPF: pass (google.com: domain of jrnieder@gmail.com designates 2607:f8b0:400e:c01::234 as permitted sender) client-ip=2607:f8b0:400e:c01::234;
Received: by mail-pb0-f52.google.com with SMTP id rr13so1398669pbb.25
        for <msysgit@googlegroups.com>; Thu, 15 May 2014 10:56:17 -0700 (PDT)
X-Received: by 10.66.148.197 with SMTP id tu5mr14419410pab.108.1400176577708;
        Thu, 15 May 2014 10:56:17 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id gj9sm10222210pbc.7.2014.05.15.10.56.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 May 2014 10:56:17 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1405151944410.14982@s15462909.onlinehome-server.info>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Original-Sender: jrnieder@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of jrnieder@gmail.com designates 2607:f8b0:400e:c01::234
 as permitted sender) smtp.mail=jrnieder@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249172>

Johannes Schindelin wrote:
> On Wed, 14 May 2014, Jeff King wrote:

>> We've already found the lines of interest to the user. It would be nice
>> if we could somehow point the pager at them by number, rather than
>> repeating the (slightly incompatible) search.
>
> FWIW it is exactly that type of "I want your patch to do more than you do"
> type of comments that makes it impossible for myself to contribute patches
> anymore.

I think you're overreacting to Peff's "It would be nice".

It is a way of talking about where this lies in a design space that
also includes the git-jump tool that Peff worked on.  Maybe the tools
can learn from each other.  It is not a reason not to apply the patch.

Jonathan

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
