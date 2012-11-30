From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC 1/5] mingw: make fgetc raise SIGINT if apropriate
Date: Fri, 30 Nov 2012 18:58:11 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1211301857170.31987@s15462909.onlinehome-server.info>
References: <1352815447-8824-1-git-send-email-kusmabite@gmail.com> <1352815447-8824-2-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com, peff@peff.net
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRBNHH4OCQKGQEEO67L4Y@googlegroups.com Fri Nov 30 18:58:29 2012
Return-path: <msysgit+bncBCZPH74Q5YNRBNHH4OCQKGQEEO67L4Y@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ea0-f186.google.com ([209.85.215.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBNHH4OCQKGQEEO67L4Y@googlegroups.com>)
	id 1TeUr2-0006rr-Q2
	for gcvm-msysgit@m.gmane.org; Fri, 30 Nov 2012 18:58:24 +0100
Received: by mail-ea0-f186.google.com with SMTP id c1sf433940eaa.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 30 Nov 2012 09:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:x-authenticated:x-provags-id:date:from
         :x-x-sender:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-y-gmx-trusted:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=RNpEo8V62rvEtvDGEEenjPimwk+pEEQQEFKQOfTG4Jo=;
        b=fH1yhm1e4TXXI2kUFNn2eNtwlqdFAXx6stneBOWONPFHY1AaS5DXSNCvtBSu922PyD
         bWwgBS0JayfFr1cJ5SM8uTs2jcvHxCl55dHCTzo5GDMMQ2k+f3SUWblMc8VF7hn4JDMT
         QwFAhf/Ue4LpcLae2Ja1GBUKYrfvbiWaWw2mdLLrpjkzWxrzsuwSpAMwKmX80DypEHq9
         SGk9LbpBiQ4RIsIrvgrYDqp6/EUkxrB5LpMvsOxPBPUuDAMW3V8ftGKCw/MyMj1/jmJv
         D34TDCI6nt7LjLYj+A 
Received: by 10.180.96.38 with SMTP id dp6mr473316wib.8.1354298293456;
        Fri, 30 Nov 2012 09:58:13 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.105.162 with SMTP id gn2ls3437915wib.44.canary; Fri, 30
 Nov 2012 09:58:12 -0800 (PST)
Received: by 10.14.208.198 with SMTP id q46mr2539802eeo.0.1354298292613;
        Fri, 30 Nov 2012 09:58:12 -0800 (PST)
Received: by 10.14.208.198 with SMTP id q46mr2539799eeo.0.1354298292603;
        Fri, 30 Nov 2012 09:58:12 -0800 (PST)
Received: from mailout-de.gmx.net (mailout-de.gmx.net. [213.165.64.22])
        by gmr-mx.google.com with SMTP id u8si1327891een.1.2012.11.30.09.58.12;
        Fri, 30 Nov 2012 09:58:12 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.22 as permitted sender) client-ip=213.165.64.22;
Received: (qmail invoked by alias); 30 Nov 2012 17:58:12 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp010) with SMTP; 30 Nov 2012 18:58:12 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+k64gjI6aki43bhuITXtbEv8GJARh7YxYjbfmI8i
	t14SVj9oaWnIGb
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <1352815447-8824-2-git-send-email-kusmabite@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of Johannes.Schindelin@gmx.de designates 213.165.64.22 as permitted
 sender) smtp.mail=Johannes.Schindelin@gmx.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210931>

Hi,

On Tue, 13 Nov 2012, Erik Faye-Lund wrote:

> Set a control-handler to prevent the process from terminating, and
> simulate SIGINT so it can be handled by a signal-handler as usual.

One thing you might want to mention is that the fgetc() handling is not
thread-safe, and intentionally so: if two threads read from the same
console, we are in trouble anyway.

BTW I like the new mingw_raise() very much!

Ciao,
Dscho

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
