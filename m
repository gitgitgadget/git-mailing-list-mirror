From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC 1/5] mingw: make fgetc raise SIGINT if apropriate
Date: Tue, 4 Dec 2012 18:40:44 +0100
Message-ID: <CABPQNSZFDBCZh-T-HFaK3=LmKik65JoMSr4pWkuNE2VrXoo0_g@mail.gmail.com>
References: <1352815447-8824-1-git-send-email-kusmabite@gmail.com>
 <1352815447-8824-2-git-send-email-kusmabite@gmail.com> <alpine.DEB.1.00.1211301857170.31987@s15462909.onlinehome-server.info>
 <CABPQNSaCV820zhJGdW++LMf2U7AeODSbfukix3fMfffmNex4YA@mail.gmail.com> <alpine.DEB.1.00.1212041809150.31987@s15462909.onlinehome-server.info>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com, peff@peff.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBDR53PPJ7YHRBRPL7CCQKGQEILYDZ2I@googlegroups.com Tue Dec 04 18:41:42 2012
Return-path: <msysgit+bncBDR53PPJ7YHRBRPL7CCQKGQEILYDZ2I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vc0-f186.google.com ([209.85.220.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBRPL7CCQKGQEILYDZ2I@googlegroups.com>)
	id 1TfwV0-0006lR-EW
	for gcvm-msysgit@m.gmane.org; Tue, 04 Dec 2012 18:41:38 +0100
Received: by mail-vc0-f186.google.com with SMTP id fl17sf2563705vcb.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 04 Dec 2012 09:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:mime-version:reply-to:in-reply-to
         :references:from:date:message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=Vrr8JnZiX+5+YXGx0yWJU4XVHrnZM7Ty/n+iCWYm06E=;
        b=ajEWNZnkQ+88R1fgrK6eiz7rElmV45//2LWlQDeyUL2PVnjw1wq5nQF9Yozy7VhYI7
         sisc+9YWmxHMa7aPhTEfvbtXFYg4m23pbUcq+yLkJQwvdYHm6cmwk/EDzHhrTV0+w+oH
         66syMJd2YFTJJdjxaUtHy9tJXE/AXwtPrRCl9vZAbDLvUCCeo163kOsB8Xh5k4XYNork
         ck6qyl0n5uPQpr8Fb7CXXiNr7GwO8B+2Ucp3u++ZQvj/ogJIPwxfDVkhb9yRp8Cgph7w
         5wwhkzSCz0kpCnwubn5GIrFfZrc/nzUr9G1rbBasdlxSc0b9mYJj12CMZsNJ4yK97998
         LSag==
Received: by 10.49.62.164 with SMTP id z4mr3179176qer.34.1354642886185;
        Tue, 04 Dec 2012 09:41:26 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.49.64.97 with SMTP id n1ls462836qes.58.gmail; Tue, 04 Dec 2012
 09:41:25 -0800 (PST)
Received: by 10.58.202.234 with SMTP id kl10mr4965948vec.33.1354642885203;
        Tue, 04 Dec 2012 09:41:25 -0800 (PST)
Received: by 10.58.202.234 with SMTP id kl10mr4965947vec.33.1354642885191;
        Tue, 04 Dec 2012 09:41:25 -0800 (PST)
Received: from mail-vc0-f178.google.com (mail-vc0-f178.google.com [209.85.220.178])
        by gmr-mx.google.com with ESMTPS id es5si678084vdb.2.2012.12.04.09.41.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 04 Dec 2012 09:41:25 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.220.178 as permitted sender) client-ip=209.85.220.178;
Received: by mail-vc0-f178.google.com with SMTP id x16so4102300vcq.37
        for <msysgit@googlegroups.com>; Tue, 04 Dec 2012 09:41:25 -0800 (PST)
Received: by 10.58.94.109 with SMTP id db13mr12592036veb.39.1354642885091;
 Tue, 04 Dec 2012 09:41:25 -0800 (PST)
Received: by 10.58.169.106 with HTTP; Tue, 4 Dec 2012 09:40:44 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1212041809150.31987@s15462909.onlinehome-server.info>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211091>

On Tue, Dec 4, 2012 at 6:12 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi kusma,
>
> On Sat, 1 Dec 2012, Erik Faye-Lund wrote:
>
>> On Fri, Nov 30, 2012 at 6:58 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>> > Hi,
>> >
>> > On Tue, 13 Nov 2012, Erik Faye-Lund wrote:
>> >
>> >> Set a control-handler to prevent the process from terminating, and
>> >> simulate SIGINT so it can be handled by a signal-handler as usual.
>> >
>> > One thing you might want to mention is that the fgetc() handling is not
>> > thread-safe, and intentionally so: if two threads read from the same
>> > console, we are in trouble anyway.
>>
>> I'm not entirely sure if I know what you mean. Do you suggest that two
>> threads can race for setting the console ctrl-handler?
>
> That was my idea, yes.
>
>> I don't think that's the case; "SetConsoleCtrlHandler(x, TRUE)" adds a
>> console handler to the handler-chain, and SetConsoleCtrlHandler(x,
>> FALSE) removes it. If two threads add handlers, it is my understanding
>> that one of them will be run, only to report "no, no more ctrl-handling
>> needed". Since both handlers block further ctrl-handling, I don't think
>> there's a problem.
>
> My idea was that the SetConsoleCtrlHandler(x, FALSE) could remove the
> handler prematurely iff another thread wanted to install the very same
> handler (but it was already installed by the first thread).
>

Yes, but that's not how SetConsoleCtrlHandler works; if a routine x
gets added twice, it needs to be removed twice as well to not get
called. This little C-program demonstrates that:

---8<---
#include <windows.h>
#include <stdio.h>

BOOL WINAPI HandlerRoutine1(DWORD dwCtrlType)
{
        printf("Hello from handler1!\n");
        return TRUE;
}

BOOL WINAPI HandlerRoutine2(DWORD dwCtrlType)
{
        printf("Hello from handler2!\n");
        return FALSE;
}

int main()
{
        SetConsoleCtrlHandler(HandlerRoutine1, TRUE);
        SetConsoleCtrlHandler(HandlerRoutine2, TRUE);
        SetConsoleCtrlHandler(HandlerRoutine2, TRUE);
        SetConsoleCtrlHandler(HandlerRoutine2, FALSE);
        GenerateConsoleCtrlEvent(CTRL_C_EVENT, 0);
        SetConsoleCtrlHandler(HandlerRoutine2, FALSE);
        SetConsoleCtrlHandler(HandlerRoutine1, FALSE);
}
---8<---

This program outputs:
Hello from handler2!
Hello from handler1!

So since that other thread would add the console ctrl handler before
it removed it again, this should still be thread-safe as far as I can
tell.

> But as I said: for this to happen, *two* threads need to want to access
> the console for reading. In that case we'd be in bigger trouble than
> thread unsafety... We cannot read two passwords from the same console at
> the same time.

I agree with that, but I'm saying that *even if* we didn't have this
limitation, the code shouldn't be problematic.

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
