From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v10 11/12] Documentation: add documentation for 'git interpret-trailers'
Date: Tue, 29 Apr 2014 13:47:51 +0200
Message-ID: <CAP8UFD2oXpW9QEkSh+vpNGRAxRFp0zJF39ZZ8sUZLTcKB9mHWQ@mail.gmail.com>
References: <20140406163214.15116.91484.chriscool@tuxfamily.org>
	<20140406170204.15116.15559.chriscool@tuxfamily.org>
	<xmqqmwfv3433.fsf@gitster.dls.corp.google.com>
	<20140425.215619.2296838250398594645.chriscool@tuxfamily.org>
	<xmqq8uqptno9.fsf@gitster.dls.corp.google.com>
	<535F8785.10302@game-point.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Johan Herland <johan@herland.net>
To: Jeremy Morton <admin@game-point.net>
X-From: git-owner@vger.kernel.org Tue Apr 29 13:48:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf6Vx-0000oY-6P
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 13:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933750AbaD2Lrx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 07:47:53 -0400
Received: from mail-ve0-f173.google.com ([209.85.128.173]:56716 "EHLO
	mail-ve0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727AbaD2Lrw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 07:47:52 -0400
Received: by mail-ve0-f173.google.com with SMTP id oy12so91831veb.4
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 04:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7Z42YevZWF7EBGQ8eAAWnCinPogYXZK6kIh1qFK4Cc0=;
        b=CHek70H5MKfhC9zqc+4h//fmslSV+N0Kdw3ZdRN8hnd7vHlIIcvHkpkHR2+ePhfoyC
         tro2+tMbtL89n7P56BfUdCljYYz3xBJ7GOJatxIRdOxRDbWh0G8ck413FHyjETxia0LH
         2sLetem4n0ZSRovd56NbRwx18Wyk95vnIM6gw+VAjut02MEN4WINgaFkd1Svkt9uaZgf
         M241HFcbfs4VTjDKuJCDWmI68QvwOJOcSV4jaKFPYWlRaQOfusJZLvdsTqFbLC5ApNOm
         25DhJsYeVhRbTUnjTTPwl+vsYd6cb17VOuk+9SONQNP+TRK9gTeIwDHpI8XlCOT3tveT
         urDQ==
X-Received: by 10.221.29.137 with SMTP id ry9mr29264702vcb.6.1398772071711;
 Tue, 29 Apr 2014 04:47:51 -0700 (PDT)
Received: by 10.58.143.72 with HTTP; Tue, 29 Apr 2014 04:47:51 -0700 (PDT)
In-Reply-To: <535F8785.10302@game-point.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247574>

On Tue, Apr 29, 2014 at 1:05 PM, Jeremy Morton <admin@game-point.net> wrote:
> On 28/04/2014 17:37, Junio C Hamano wrote:
>>
>> Christian Couder<chriscool@tuxfamily.org>  writes:
>>
>>> From: Junio C Hamano<gitster@pobox.com>
>>>>
>>>>
>>>> Christian Couder<chriscool@tuxfamily.org>  writes:
>>>> ...
>>>
>>>
>>>>> +       trailer. After some alphanumeric characters, it can contain
>>>>> +       some non alphanumeric characters like ':', '=' or '#' that will
>>>>> +       be used instead of ':' to separate the token from the value in
>>>>> +       the trailer, though the default ':' is more standard.
>>>>
>>>>
>>>> I assume that this is for things like
>>>>
>>>>         bug #538
>>>>
>>>> and the configuration would say something like:
>>>>
>>>>         [trailer "bug"]
>>>>                 key = "bug #"
>>>>
>>>> For completeness (of this example), the bog-standard s-o-b would
>>>> look like
>>>>
>>>>         Signed-off-by: Christian Couder<chriscool@tuxfamily.org>
>>>>
>>>> and the configuration for it that spell the redundant "key" would
>>>> be:
>>>>
>>>>         [trailer "Signed-off-by"]
>>>>                 key = "Signed-off-by: "
>>>
>>>
>>> Yeah, but you can use the following instead:
>>>
>>>         [trailer "s-o-b"]
>>>                 key = "Signed-off-by: "
>
>
> One thing I'm not quite understanding is where the "Christian
> Couder<chriscool@tuxfamily.org>" bit comes from.  So you've defined the
> trailer token and key, but interpret-trailers then needs to get the value it
> will give for the key from somewhere.  Does it have to just be hardcoded in?
> We probably want some way to get various variables like current branch name,
> current git version, etc.  So in the case of always adding a trailer for the
> branch that the commit was checked in to at the time (Developed-on,
> Made-on-branch, Author-branch, etc. [I think my favourite is
> Made-on-branch]), you'd want something like:
>
>         [trailer "m-o-b"]
>                 key = "Made-on-branch: "
>                 value = "$currentBranch"
>
> ... resulting in the trailer (for example):
>         Made-on-branch: pacman-minigame

In the documentation patch, there is:

trailer.<token>.command::
       This option can be used to specify a shell command that will
       be used to automatically add or modify a trailer with the
       specified 'token'.

       When this option is specified, it is like if a special 'token=value'
       argument is added at the end of the command line, where 'value' will
       be given by the standard output of the specified command.

       If the command contains the `$ARG` string, this string will be
       replaced with the 'value' part of an existing trailer with the same
       token, if any, before the command is launched.

That's why Something like the following should work if "git commit"
automitically runs "git interpret-trailers":

         [trailer "m-o-b"]
                 key = "Made-on-branch: "
                 command = "git name-rev --name-only HEAD"


> Also, if there were no current branch name because you're committing in a
> detached head state, it would be nice if you could have some logic to
> determine that, and instead write the trailer as:
>         Made-on-branch: (detached HEAD: AB12CD34)

You may need to write a small script for that.
Then you just need the "trailer.m-o-b.command" config value to point
to your script.

> ... or whatever.  And also how about some logic to be able to say that if
> you're committing to the "master" branch, the trailer doesn't get inserted
> at all?

You can script that too.

Best,
Christian.
