From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Win32: nanosecond-precision file times
Date: Thu, 12 Feb 2015 15:38:13 -0800
Message-ID: <xmqqsieaog4a.fsf@gitster.dls.corp.google.com>
References: <54DBEAA5.6000205@gmail.com>
	<xmqqbnkysygl.fsf@gitster.dls.corp.google.com>
	<54DD2FDA.7030604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>, Johannes Schindelin <johannes.schindelin@gmx.de>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCG77UMM3EJRBZ7S6STAKGQEGXP5AZA@googlegroups.com Fri Feb 13 00:38:18 2015
Return-path: <msysgit+bncBCG77UMM3EJRBZ7S6STAKGQEGXP5AZA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ie0-f183.google.com ([209.85.223.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBZ7S6STAKGQEGXP5AZA@googlegroups.com>)
	id 1YM3Kq-0007mT-W0
	for gcvm-msysgit@m.gmane.org; Fri, 13 Feb 2015 00:38:17 +0100
Received: by iebtr6 with SMTP id tr6sf1058435ieb.2
        for <gcvm-msysgit@m.gmane.org>; Thu, 12 Feb 2015 15:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=2KrsRL9o9TpCLZaxALzqvjYE29V2PP2Pu+aDxukbO7Q=;
        b=GFf0sxvZV7saUEfpSFFKngA8RHdX8xglejqH3Tl+1H1KqgSdHKzwxdKxStLIgUBbdY
         74c0VnY1ud9a+J/7Pk62qNw0O9LTVUE/+GUbhF8fwwRt1c8ft1fhk0p97g6TGManvFA5
         1pUdsPp+zzazQdnI4VEf+Aef8ohddKkIE1dTRZG7UOXjjXzximgEOlgbxqdQDvmpZHqo
         JbKyMb9wKvxywHJYvbbjrC0IeINjNu5tjFWpJov3UtJc8fQKYPw6RgEk83puZr+GiObg
         Il/sJ+Iadj1lDUQy8iNMgwIBU6mOMYC0ed7+AId/GsxX5PtKAYvTk2F4E+2ghw3mrz69
         EsKQ==
X-Received: by 10.140.40.242 with SMTP id x105mr89977qgx.14.1423784296175;
        Thu, 12 Feb 2015 15:38:16 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.25.145 with SMTP id 17ls1113089qgt.82.gmail; Thu, 12 Feb
 2015 15:38:15 -0800 (PST)
X-Received: by 10.236.2.227 with SMTP id 63mr6274938yhf.12.1423784295761;
        Thu, 12 Feb 2015 15:38:15 -0800 (PST)
Received: from sasl.smtp.pobox.com (pb-smtp1.int.icgroup.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id jn10si254960igb.3.2015.02.12.15.38.15
        for <msysgit@googlegroups.com>;
        Thu, 12 Feb 2015 15:38:15 -0800 (PST)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DF7D7386F8;
	Thu, 12 Feb 2015 18:38:14 -0500 (EST)
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D6CF6386F6;
	Thu, 12 Feb 2015 18:38:14 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5D0CE386F5;
	Thu, 12 Feb 2015 18:38:14 -0500 (EST)
In-Reply-To: <54DD2FDA.7030604@gmail.com> (Karsten Blees's message of "Thu, 12
	Feb 2015 23:57:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 36957D94-B310-11E4-A704-A4119F42C9D4-77302942!pb-smtp1.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263789>

Karsten Blees <karsten.blees@gmail.com> writes:

> This is more about copying 'old' things around, which usually also
> copies mtime on Windows. E.g.:
>
>   # create two files with slightly different mtime
>   for i in {1..10}; do (echo "v1" >> test); done &&
>   for i in {1..10}; do (echo "v2" >> test2); done
>   # wait a bit so that '.git/index' is always newer than 'test' / 'test2'
>   sleep 1
>   git add test
>   git commit -m v1
>   # copy test2 over test (similar to 'cp -p', but native 'copy' also
>   # copies mtime nanoseconds)
>   cmd //c "copy /y test2 test"
>   git add test
>   git commit -m v2
>
> Without these patches, git does not detect the change, and the second
> git add / git commit are noops.

We do have sec/nsec fields in cache_time structure, so I have
nothing against updating the msysGit port to fill that value.

I was and am just reacting to the fact that this is sold as if it
"fixes" something.  It doesn't fundamentally change the fact that
mtime that does not follow the semantics Dscho mentioned in his
earlier message does not work well with Git.

Having said that, even with such a patch, as long as the system is
sufficiently fast, test and test2 will have nonoseconds identical
timestamp and you would have the same issue, no?

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
