From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC 1/5] mingw: make fgetc raise SIGINT if apropriate
Date: Sat, 1 Dec 2012 13:36:05 +0100
Message-ID: <CABPQNSaCV820zhJGdW++LMf2U7AeODSbfukix3fMfffmNex4YA@mail.gmail.com>
References: <1352815447-8824-1-git-send-email-kusmabite@gmail.com>
 <1352815447-8824-2-git-send-email-kusmabite@gmail.com> <alpine.DEB.1.00.1211301857170.31987@s15462909.onlinehome-server.info>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com, peff@peff.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBDR53PPJ7YHRBXXT46CQKGQEXSABXTA@googlegroups.com Sat Dec 01 13:37:02 2012
Return-path: <msysgit+bncBDR53PPJ7YHRBXXT46CQKGQEXSABXTA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ye0-f186.google.com ([209.85.213.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBXXT46CQKGQEXSABXTA@googlegroups.com>)
	id 1TemJX-0007jy-Im
	for gcvm-msysgit@m.gmane.org; Sat, 01 Dec 2012 13:36:59 +0100
Received: by mail-ye0-f186.google.com with SMTP id l10sf1310950yen.3
        for <gcvm-msysgit@m.gmane.org>; Sat, 01 Dec 2012 04:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:mime-version:reply-to:in-reply-to
         :references:from:date:message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=NUuG/JwREgAVFqxcs4+KSoOLWTtIv/wNcyUKPIaGOLk=;
        b=lX5zmmraMgeHasiLx+7SvyuTEMRfzhkg+OEVAFb68lmPLj+XXvWDetB925A0Bp2Kon
         8WT3C61Q7/lBQjO0atI0Hi0VFBSB016r064Al8TNA58gaOULN+xCOOo7/2jCIZgbInLv
         Rwhzp6Ms50d+EpUPR2Cf8C5J7CEgk96X9vwIiDiEad6ATKpgAXzrQGEb0DIPmTbzQ6Vb
         dlRwzXC6rkQ8PuIY+lVYOQmzmKaPHN1eW+9OoArBoHn+xyKg5TSRsGLbOpRrlKdSSQ2E
         cr//28WQmse7GIoG0Fo+vLYJdqHO4mtwKtux6qct4F387wocVi15J/Z3EWYNj7NH4Jku
         gAnw==
Received: by 10.49.15.6 with SMTP id t6mr1101258qec.20.1354365407415;
        Sat, 01 Dec 2012 04:36:47 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.49.0.176 with SMTP id 16ls899839qef.41.gmail; Sat, 01 Dec 2012
 04:36:46 -0800 (PST)
Received: by 10.58.205.203 with SMTP id li11mr1584899vec.14.1354365406558;
        Sat, 01 Dec 2012 04:36:46 -0800 (PST)
Received: by 10.58.205.203 with SMTP id li11mr1584898vec.14.1354365406547;
        Sat, 01 Dec 2012 04:36:46 -0800 (PST)
Received: from mail-vc0-f172.google.com (mail-vc0-f172.google.com [209.85.220.172])
        by gmr-mx.google.com with ESMTPS id h20si2398443vdg.3.2012.12.01.04.36.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 01 Dec 2012 04:36:46 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.220.172 as permitted sender) client-ip=209.85.220.172;
Received: by mail-vc0-f172.google.com with SMTP id fw7so711294vcb.17
        for <msysgit@googlegroups.com>; Sat, 01 Dec 2012 04:36:46 -0800 (PST)
Received: by 10.58.74.196 with SMTP id w4mr3806817vev.7.1354365406437; Sat, 01
 Dec 2012 04:36:46 -0800 (PST)
Received: by 10.58.169.106 with HTTP; Sat, 1 Dec 2012 04:36:05 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1211301857170.31987@s15462909.onlinehome-server.info>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.220.172 as permitted sender)
 smtp.mail=kusmabite@gmail.com; dkim=pass header.i=@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210968>

On Fri, Nov 30, 2012 at 6:58 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Tue, 13 Nov 2012, Erik Faye-Lund wrote:
>
>> Set a control-handler to prevent the process from terminating, and
>> simulate SIGINT so it can be handled by a signal-handler as usual.
>
> One thing you might want to mention is that the fgetc() handling is not
> thread-safe, and intentionally so: if two threads read from the same
> console, we are in trouble anyway.

I'm not entirely sure if I know what you mean. Do you suggest that two
threads can race for setting the console ctrl-handler? I don't think
that's the case; "SetConsoleCtrlHandler(x, TRUE)" adds a console
handler to the handler-chain, and SetConsoleCtrlHandler(x, FALSE)
removes it. If two threads add handlers, it is my understanding that
one of them will be run, only to report "no, no more ctrl-handling
needed". Since both handlers block further ctrl-handling, I don't
think there's a problem.

Do you care to clarify what your thread-safety complaint is?

> BTW I like the new mingw_raise() very much!

Thanks! I originally implemented it for a different reason, but that
patch didn't turn out to be useful, so it's nice to finally put it to
use ;)

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
