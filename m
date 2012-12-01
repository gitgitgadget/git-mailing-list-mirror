From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC 2/5] compat/terminal: factor out echo-disabling
Date: Sat, 1 Dec 2012 13:43:12 +0100
Message-ID: <CABPQNSY_vHdvBvU_ezjyOzoZeBJAYTJ2829o6Vxs-nJjQVcvDQ@mail.gmail.com>
References: <1352815447-8824-1-git-send-email-kusmabite@gmail.com>
 <1352815447-8824-3-git-send-email-kusmabite@gmail.com> <alpine.DEB.1.00.1211301858570.31987@s15462909.onlinehome-server.info>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com, peff@peff.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBDR53PPJ7YHRBCHX46CQKGQERZ2U2GI@googlegroups.com Sat Dec 01 13:44:11 2012
Return-path: <msysgit+bncBDR53PPJ7YHRBCHX46CQKGQERZ2U2GI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pb0-f58.google.com ([209.85.160.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBCHX46CQKGQERZ2U2GI@googlegroups.com>)
	id 1TemQQ-0007JH-3C
	for gcvm-msysgit@m.gmane.org; Sat, 01 Dec 2012 13:44:06 +0100
Received: by mail-pb0-f58.google.com with SMTP id xa7sf1374610pbc.3
        for <gcvm-msysgit@m.gmane.org>; Sat, 01 Dec 2012 04:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:mime-version:reply-to:in-reply-to
         :references:from:date:message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=sMvlW/ZBeKCOKIOUjjhqLBSisGspDVXBNUhqOliwoeo=;
        b=slAGYwB+16qgATboMXx9/L20J1mdTEK8go7Oq6u8Ty31o8NJ2jwoBnHSrjM3agApBp
         HQvLioDDEZUbDtRV5x/knkPqmv7hjvYIp4r5XCaDBcCnvqRQOiyhOJKsHolFw8d/wTzL
         EazVT3JbMhVjZP5leu+w5b0Z7r0IXB5QNBMLNkU98RruWiCFuwfow5uZcfij20G+5gh8
         TVRXc4Zj/OpM99hVNvvw/8Adx7XfnQCwhkUXp1cbIzeOwp52q3mR/u23sECRIT94shza
         3vD08dWVh4614z996o1hnTzi8m1Aypjc4SMN6KISzY4xDEwlAJhzkOARhjzRoL1V/Tja
         ecLQ==
Received: by 10.49.96.196 with SMTP id du4mr1175903qeb.37.1354365833358;
        Sat, 01 Dec 2012 04:43:53 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.49.82.70 with SMTP id g6ls959232qey.33.gmail; Sat, 01 Dec 2012
 04:43:52 -0800 (PST)
Received: by 10.58.221.132 with SMTP id qe4mr1682978vec.9.1354365832804;
        Sat, 01 Dec 2012 04:43:52 -0800 (PST)
Received: by 10.58.221.132 with SMTP id qe4mr1682977vec.9.1354365832793;
        Sat, 01 Dec 2012 04:43:52 -0800 (PST)
Received: from mail-vc0-f178.google.com (mail-vc0-f178.google.com [209.85.220.178])
        by gmr-mx.google.com with ESMTPS id es5si2401309vdb.2.2012.12.01.04.43.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 01 Dec 2012 04:43:52 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.220.178 as permitted sender) client-ip=209.85.220.178;
Received: by mail-vc0-f178.google.com with SMTP id x16so504568vcq.9
        for <msysgit@googlegroups.com>; Sat, 01 Dec 2012 04:43:52 -0800 (PST)
Received: by 10.220.151.72 with SMTP id b8mr3679175vcw.38.1354365832680; Sat,
 01 Dec 2012 04:43:52 -0800 (PST)
Received: by 10.58.169.106 with HTTP; Sat, 1 Dec 2012 04:43:12 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1211301858570.31987@s15462909.onlinehome-server.info>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.220.178 as permitted sender)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210969>

On Fri, Nov 30, 2012 at 6:59 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Tue, 13 Nov 2012, Erik Faye-Lund wrote:
>
>> By moving the echo-disabling code to a separate function, we can
>> implement OS-specific versions of it for non-POSIX platforms.
>>
>> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
>> ---
>>  compat/terminal.c | 43 +++++++++++++++++++++++++------------------
>>  1 file changed, 25 insertions(+), 18 deletions(-)
>>
>> diff --git a/compat/terminal.c b/compat/terminal.c
>> index bbb038d..3217838 100644
>> --- a/compat/terminal.c
>> +++ b/compat/terminal.c
>> @@ -14,6 +14,7 @@ static void restore_term(void)
>>               return;
>>
>>       tcsetattr(term_fd, TCSAFLUSH, &old_term);
>> +     close(term_fd);
>>       term_fd = -1;
>>  }
>
> That looks like an independent resource leak fix... correct?

It might look like it, but it's not; term_fd used to be returned by
"fileno(fh)", and fh did get properly closed.

With my refactoring, disable_echo/restore_term takes opens /dev/tty a
second time, like Jeff points out. And that second file descriptor
needs to be closed.

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
