From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Win32: nanosecond-precision file times
Date: Mon, 16 Feb 2015 14:10:58 -0800
Message-ID: <xmqqtwyl4idp.fsf@gitster.dls.corp.google.com>
References: <54DBEAA5.6000205@gmail.com>
	<xmqqbnkysygl.fsf@gitster.dls.corp.google.com>
	<54DD2FDA.7030604@gmail.com>
	<xmqqsieaog4a.fsf@gitster.dls.corp.google.com>
	<54DD5A89.5080502@gmail.com>
	<xmqq61b5obla.fsf@gitster.dls.corp.google.com>
	<54E250A6.4070605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>,  Johannes Schindelin <johannes.schindelin@gmx.de>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCG77UMM3EJRB5OVRGTQKGQEEMFDBUY@googlegroups.com Mon Feb 16 23:11:04 2015
Return-path: <msysgit+bncBCG77UMM3EJRB5OVRGTQKGQEEMFDBUY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yk0-f186.google.com ([209.85.160.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRB5OVRGTQKGQEEMFDBUY@googlegroups.com>)
	id 1YNTsc-00054P-HA
	for gcvm-msysgit@m.gmane.org; Mon, 16 Feb 2015 23:11:02 +0100
Received: by mail-yk0-f186.google.com with SMTP id 10sf5863559ykt.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 16 Feb 2015 14:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=6ATilcHjhZDFUHxXz1ArR4PJpSX8B6vFsfkpos51Bcw=;
        b=UZSyYkWUrcHrlfAdjpacycY3Vlp1KZi/YfHdcZo8YT8a+ImJmsOmoOa+Bqz6UUHIjp
         nQDs6qahly8ncmlWnTucs9wMhgCKHJI6jpmGpbCOaF8pHq8ptJolSlShq1JXf2Mag7QU
         iCP+7gaImn0FH55bUEHlkzSEiAfbA2BhUV+2peRnbyaVPnYw5BV+XrKYwB14+kf3HLpF
         fq2efOyPHWtkIYoOCPoa54fmPglFNPvbqOUCqQB2byu/elagXfv+poAoGvuFH+B4p8iT
         cdNWeMUOwWp+37I9jhwxuEENDUsjFJgaVpWrDytQomOVCHIQ6dGcE9an3RqDXBJALCmL
         k4Bg==
X-Received: by 10.50.119.131 with SMTP id ku3mr276175igb.2.1424124661895;
        Mon, 16 Feb 2015 14:11:01 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.51.16.129 with SMTP id fw1ls1277171igd.2.gmail; Mon, 16 Feb
 2015 14:11:01 -0800 (PST)
X-Received: by 10.66.252.138 with SMTP id zs10mr23341749pac.3.1424124661377;
        Mon, 16 Feb 2015 14:11:01 -0800 (PST)
Received: from sasl.smtp.pobox.com (pb-smtp1.int.icgroup.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id e3si1183500igq.1.2015.02.16.14.11.01
        for <msysgit@googlegroups.com>;
        Mon, 16 Feb 2015 14:11:01 -0800 (PST)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 389513784F;
	Mon, 16 Feb 2015 17:11:00 -0500 (EST)
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E5A13784E;
	Mon, 16 Feb 2015 17:11:00 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7B3E63784C;
	Mon, 16 Feb 2015 17:10:59 -0500 (EST)
In-Reply-To: <54E250A6.4070605@gmail.com> (Karsten Blees's message of "Mon, 16
	Feb 2015 21:18:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AFF7A62E-B628-11E4-8A93-A4119F42C9D4-77302942!pb-smtp1.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted
 sender) smtp.mail=junio@pobox.com;       dkim=pass header.i=@pobox.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263919>

Karsten Blees <karsten.blees@gmail.com> writes:

> However, the Makefile has this to say on the subject:
>
> # Define USE_NSEC below if you want git to care about sub-second file mtimes
> # and ctimes. Note that you need recent glibc (at least 2.2.4) for this, and
> # it will BREAK YOUR LOCAL DIFFS! show-diff and anything using it will likely
> # randomly break unless your underlying filesystem supports those sub-second
> # times (my ext3 doesn't).
>
> Am I missing something?

I think "it would break" is about show-diff which wanted to use the
cached stat information for freshness.

	>foo
	git update-index --add foo
        sleep 2
        >foo
        git diff-files ;# modern counterpart of show-diff

would say that "foo" is *different*, because the plumbing commands
like diff-files expect you to refresh the index before you call
them.

And if you did "git update-index --refresh" after touching "foo" the
last time before running "git diff-files" in the above sequence, you
should expect that it does not say "foo" is different, no matter how
much time passes between the time you run that "refresh" and
"diff-files" (or between the time you last touched "foo" and you run
"refresh", for that matter), as long as you do not touch "foo" in
the meantime.  The following should say "foo" is *not* different,
that is:

	>foo
	git update-index --add foo
        sleep 2
        >foo
        sleep arbitrary
        git update-index --refresh
        sleep arbitrary
        git diff-files ;# modern counterpart of show-diff

If you use NSEC, however, and "refresh" grabbed a subsecond time and
then later "diff-files" learned a truncated/rounded time because the
filesystem later purged the cached inodes and re-read it from the
underlying filesystem with no subsecond time resolution, the times
would not match so you will again see "diff-files" report that "foo"
is now different.

That is what the comment you cited is about.

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
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
