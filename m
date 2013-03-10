From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: inotify to minimize stat() calls
Date: Sun, 10 Mar 2013 13:53:27 +0530
Message-ID: <CALkWK0n_9wy575U5os287J+dnc_LqrJ0JwP3ur6kA+4S_=yMag@mail.gmail.com>
References: <7vehgqzc2p.fsf@alter.siamese.dyndns.org> <7va9rezaoy.fsf@alter.siamese.dyndns.org>
 <7vsj56w5y9.fsf@alter.siamese.dyndns.org> <9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com>
 <CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com>
 <CALkWK0nQVjKpyef8MDYMs0D9HJGCL8egypT3YWSdU8EYTO7Y+w@mail.gmail.com>
 <CACsJy8CEHzqH1X=v4yau0SyZwrZp1r6hNp=yXD+eZh1q_BS-0g@mail.gmail.com>
 <CALkWK0=6_n4rf6AWci6J+uhGHpjTUmK7YFdVHuSJedN2zLWtMA@mail.gmail.com>
 <CACsJy8DeM5--WVXg3b65RxLBS7Jho-7KmcGwWk7B5uAx77yOEw@mail.gmail.com>
 <20130210111732.GA24377@lanh> <20130210112205.GA28434@lanh>
 <7vhaljudos.fsf@alter.siamese.dyndns.org> <CACsJy8DnvAjQPL4aP_LRC7aqx6OC4M5dMtj-OUot76qET2z08Q@mail.gmail.com>
 <513911B3.7010903@web.de> <7vr4jqkb9g.fsf@alter.siamese.dyndns.org>
 <51398CD5.1070603@web.de> <7v7glijoiy.fsf@alter.siamese.dyndns.org> <CACsJy8DZm153Tu_3GTOnxF8bFrYPh7_DP6Rn6rr3n6tfuVuv2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Git List <git@vger.kernel.org>, finnag@pvv.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 10 09:24:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEbYH-00073i-UR
	for gcvg-git-2@plane.gmane.org; Sun, 10 Mar 2013 09:24:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752272Ab3CJIXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 04:23:51 -0400
Received: from mail-ia0-f177.google.com ([209.85.210.177]:41438 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125Ab3CJIXr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 04:23:47 -0400
Received: by mail-ia0-f177.google.com with SMTP id y25so2747026iay.36
        for <git@vger.kernel.org>; Sun, 10 Mar 2013 00:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=goSdBSSIxBpSnEFmNISPaoP/Gvp7KpPYNn6sbPMo5GY=;
        b=mpTMsx1AleiWWD/IC8BrpN6OGWO7sY/oS7S7CwsXXcOVURzcn9zW1iqE4luv8FsQyR
         +wxsRK153QOmPO8f1eGkolOhsizrUxv/+Gi2YOTnlL8yIPJlyWMkYVA5lQveak1dkn82
         jUPQNx6lqmJwHqKsZA3baEVv+cbixwPBHHYc6KlzmdLBz4miGVOKwR+sTcpCsu7/kEIP
         2N4DCvtZBEiPeBEJOdOiZftnsKDKR3eIG8qE0DDrDM3HEqj/tRlytpODyxubXrNfUn2K
         i9JvBdGx27lSTdi7pM1xJJ1Funk6SuMnLNiRJ/JDrqJIP0gJ/m1kV0XeBXSiufY11qw2
         EJPg==
X-Received: by 10.50.17.71 with SMTP id m7mr3368469igd.14.1362903827161; Sun,
 10 Mar 2013 00:23:47 -0800 (PST)
Received: by 10.64.166.33 with HTTP; Sun, 10 Mar 2013 00:23:27 -0800 (PST)
In-Reply-To: <CACsJy8DZm153Tu_3GTOnxF8bFrYPh7_DP6Rn6rr3n6tfuVuv2Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217791>

Duy Nguyen wrote:
> On Fri, Mar 8, 2013 at 3:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>  The possible options are:
>>>  +
>>> -       - 'no'     - Show no untracked files
>>> +       - 'no'     - Show no untracked files (this is fastest)
>>
>> There is a trade-off around the use of -uno between safety and
>> performance.  The default is not to use -uno so that you will not
>> forget to add a file you newly created (i.e safety).  You would pay
>> for the safety with the cost to find such untracked files (i.e.
>> performance).
>>
>> I suspect that the documentation was written with the assumption
>> that at least for the people who are reading this part of the
>> documentation, the trade-off is obvious.  In order to find more
>> information, you naturally need to spend more cycles.
>>
>> If the trade-off is not so obvious, however, I do not object at all
>> to describing it. But if we are to do so, I do object to mentioning
>> only one side of the trade-off.  People who choose "fastest" needs
>> to be made very aware that they are disabling "safety".
>
> On the topic of trading off, I was thinking about new -uauto as
> default that is like -uall if it takes less than a certan amount of
> time (e.g. 0.5 seconds), if it exceeds that limit, the operation is
> aborted (i.e. it turns to -uno). The safety net is still there, "git
> status" advices to use -u to show full information.

Ugh, this is too opaque; the user has no idea whether untracked files
are being counted or not.

> Or a less intrusive approach: measure the time and advice the user to
> (read doc and) use -uno.

I just learnt about -uno myself, from this thread.  At best, it's a
stopgap until we get inotify support.

> But it's probably worth waiting for the first cut of inotify support
> from Ram. It's better with inotify anyway.

This is quite urgent in my opinion.  One of git's primary tasks is to
quickly tell me what changed in the repository, and inotify is the
perfect way to do this.
I'll try to get the first cut out quickly, so we can immediately
correct any fundamental design flaws.
