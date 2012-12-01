From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC 1/5] mingw: make fgetc raise SIGINT if apropriate
Date: Sat, 1 Dec 2012 13:31:23 +0100
Message-ID: <CABPQNSZaaZsfcC6dHDEhYUDpX4doQC7H=1VHGHuqfU4+m31jkA@mail.gmail.com>
References: <1352815447-8824-1-git-send-email-kusmabite@gmail.com>
 <1352815447-8824-2-git-send-email-kusmabite@gmail.com> <alpine.DEB.1.00.1211301857170.31987@s15462909.onlinehome-server.info>
 <20121130181119.GA7197@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org, 
	msysgit@googlegroups.com
To: Jeff King <peff@peff.net>
X-From: msysgit+bncBDR53PPJ7YHRBQ7R46CQKGQEMKDG6MQ@googlegroups.com Sat Dec 01 13:32:20 2012
Return-path: <msysgit+bncBDR53PPJ7YHRBQ7R46CQKGQEMKDG6MQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ob0-f186.google.com ([209.85.214.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBQ7R46CQKGQEMKDG6MQ@googlegroups.com>)
	id 1TemEy-0002dy-Cs
	for gcvm-msysgit@m.gmane.org; Sat, 01 Dec 2012 13:32:16 +0100
Received: by mail-ob0-f186.google.com with SMTP id wp18sf1191207obc.3
        for <gcvm-msysgit@m.gmane.org>; Sat, 01 Dec 2012 04:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:mime-version:reply-to:in-reply-to
         :references:from:date:message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=4xjyvcDUjLm0zgCx+ZLHdxRColSv4sQm2BeV+zXJ5mA=;
        b=En8h7RJ3eIRavFX8uNcYVD3G4IHQUnjBfHPYDuXhw+nBp8aT723kGFXfmupFj1NDOu
         zftbXJc5QrWpYz7EmBN1NOB+CSV3iXntw84Q23qM5efVt2TQXFyjwnuamK6rKD8cnDih
         qkesr1enj39k/DakbDNxoCqlQ83i06PHKf26isAvBeXAGC6KWSI4lR6up66JhVBggSXR
         8TQEMbsQZt2z8t7B+Wye+167gZvRwkxFu2nSfeLBLPiTRizpC26n0rcLHMAjw8oNjiLj
         8miCtvLFg2n2FiQ3nbKbaPgzDlIzRCGljxF14DWij85x8GssPLmdWNOJGv9QX3OKETku
         Q5WQ==
Received: by 10.49.15.6 with SMTP id t6mr1099301qec.20.1354365124120;
        Sat, 01 Dec 2012 04:32:04 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.49.72.225 with SMTP id g1ls783781qev.15.gmail; Sat, 01 Dec
 2012 04:32:03 -0800 (PST)
Received: by 10.58.170.6 with SMTP id ai6mr1578271vec.35.1354365123559;
        Sat, 01 Dec 2012 04:32:03 -0800 (PST)
Received: by 10.58.170.6 with SMTP id ai6mr1578270vec.35.1354365123549;
        Sat, 01 Dec 2012 04:32:03 -0800 (PST)
Received: from mail-vb0-f51.google.com (mail-vb0-f51.google.com [209.85.212.51])
        by gmr-mx.google.com with ESMTPS id dj17si2397264vdb.1.2012.12.01.04.32.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 01 Dec 2012 04:32:03 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.212.51 as permitted sender) client-ip=209.85.212.51;
Received: by mail-vb0-f51.google.com with SMTP id fq11so304618vbb.24
        for <msysgit@googlegroups.com>; Sat, 01 Dec 2012 04:32:03 -0800 (PST)
Received: by 10.52.16.164 with SMTP id h4mr3292728vdd.21.1354365123322; Sat,
 01 Dec 2012 04:32:03 -0800 (PST)
Received: by 10.58.169.106 with HTTP; Sat, 1 Dec 2012 04:31:23 -0800 (PST)
In-Reply-To: <20121130181119.GA7197@sigill.intra.peff.net>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.212.51 as permitted sender)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210966>

On Fri, Nov 30, 2012 at 7:11 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Nov 30, 2012 at 06:58:11PM +0100, Johannes Schindelin wrote:
>
>> Hi,
>>
>> On Tue, 13 Nov 2012, Erik Faye-Lund wrote:
>>
>> > Set a control-handler to prevent the process from terminating, and
>> > simulate SIGINT so it can be handled by a signal-handler as usual.
>>
>> One thing you might want to mention is that the fgetc() handling is not
>> thread-safe, and intentionally so: if two threads read from the same
>> console, we are in trouble anyway.
>
> That makes sense to me, but I'm confused why it is part of mingw_fgetc,
> which could in theory read from arbitrary streams, no? It it is not
> necessarily a console operation at all. I feel like I'm probably missing
> something subtle here...

I did add an early out for the non-console cases. Is this what you're
missing, perhaps?

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
