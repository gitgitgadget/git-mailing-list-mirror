From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2] pull: handle --log=<n>
Date: Tue, 19 May 2015 14:33:17 -0700
Message-ID: <CAGZ79kaw_6Cq5SaLvJHrXDm9bh3+ovAddv9CQJ78m65MYF=SqA@mail.gmail.com>
References: <1431956396-21788-1-git-send-email-pyokagan@gmail.com>
	<5661061272076a1883cfde1087be4a42@www.dscho.org>
	<xmqq617pda0r.fsf@gitster.dls.corp.google.com>
	<6b905c01c9b57abc05fb49117c28c10e@www.dscho.org>
	<CAPc5daVze4+8aLGPpZgxDnvKSwvQiaR=kRdwfAHXFYA7HChmMg@mail.gmail.com>
	<1432070690.14498.4.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Tue May 19 23:33:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yup8f-0005Bh-P8
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 23:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbbESVdU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 17:33:20 -0400
Received: from mail-qc0-f180.google.com ([209.85.216.180]:32819 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048AbbESVdT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 17:33:19 -0400
Received: by qcblr10 with SMTP id lr10so13912946qcb.0
        for <git@vger.kernel.org>; Tue, 19 May 2015 14:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PNkG04ZmtFW+qLAF5ndxr+mlt9XbfdwUFTG6aRsp0a4=;
        b=L9pWC7ufrdF3oCBv3J3c6I1t4bSpVQZjMFI2b6fXBr6udqUm/OZVmrhH8bzTjpc3TM
         Epj8NKEOCYy0LZY75isqsLA0sKv7VqJAAwq5aySbnKvKzP5+z96GzLqbrHcVf23DPF8D
         JzaWSgNCbRJGL7CfuFdzBVweAm1ClZhInjCE25iVaiqZXnnEkLiS9IsIFO3Hj8Yfjwh5
         Wzf0DckFdttYT9AY4mY8ixx+Be4nNVXD6BZyj3TsbK/GzX3H24/gnDT6goQhgL8oRXn0
         RPx4OzjGfClPBtRLtKDPvMGqAk/LdoClxKWQM1gQHaR/TgVKLv8W9kCTuj4v9IifCcgu
         x2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=PNkG04ZmtFW+qLAF5ndxr+mlt9XbfdwUFTG6aRsp0a4=;
        b=fA7FQt7sB7iwZVTAAaxX4jIntkOg4EyntcNbvD0WS/+R2J/LI6hHPG/ehi2HZ9I4SP
         aw3Lb7xCICXbBFLSuxzfJV+NOLAwXZgCgODiGOOLaoLkhnVk/Sa5J/m9EhNWg526sYnk
         wA5b+aKv3BVs/Fb7gK0VjuuhPR5rW2m1kykEx3mTGq5xnvxx1pE3bJRyzJ4IBaLa2qa/
         h0DAZgqsw2nEx9+hoS1jRMKIg+qDhswx35AcG95bCViPJFiQnfC3b3eO2mI8J5UXJDXF
         FL62riqV3aS6NCJBSjRoCM0RT1a/lgG8nyoLQERoQ6fxEp6gGV6NjQ1QYHlBK60JVKIv
         jPFg==
X-Gm-Message-State: ALoCoQkoK2bsAnKkYpDkLJ4t2cUCXPDqqBFbWUrvo6tSXxjA8CsBPMfkVHhfgT5iXiP2NRyKHV4c
X-Received: by 10.55.52.18 with SMTP id b18mr64398064qka.85.1432071197906;
 Tue, 19 May 2015 14:33:17 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Tue, 19 May 2015 14:33:17 -0700 (PDT)
In-Reply-To: <1432070690.14498.4.camel@kaarsemaker.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269404>

On Tue, May 19, 2015 at 2:24 PM, Dennis Kaarsemaker
<dennis@kaarsemaker.net> wrote:
> On di, 2015-05-19 at 06:57 -0700, Junio C Hamano wrote:
>> On Tue, May 19, 2015 at 6:35 AM, Johannes Schindelin
>> <johannes.schindelin@gmx.de> wrote:
>> >
>> > On 2015-05-18 20:18, Junio C Hamano wrote:
>> >>
>> >> So I dunno.  I really wish test_commit didn't create tags and either
>> >> left the tagging to the calling script.
>> >
>> > Or maybe just add a --tag flag to `test_commit` and use that in all cases where the tags were actually needed. Yeah, I think I like that option best.
>>
>> Thanks for inferring what I wanted to say but left unsaid due to my
>> stupidity and
>> lack of proofreading. I meant to follow "either left to the caller"
>> with "or with an
>> option" ;-)
>
> I took a stab at this, adding a --tag option to test_commit and adding
> the option to the test_commit calls that need it (or removing tests'
> reliance on these tags where appropriate, or removing tests' workarounds
> for dealing with these tags when they don't want them), and the result
> is 59 files changed, 280 insertions(+), 281 deletions(-)

I guess most of the line changes are just adding the --tag?
And I'd guess (281-280) that there is no huge code inside of test_commit
either, so I'd assume it doesn't add clutter, but rather cleans up....

>
> A test run on master with GIT_TEST_LONG set causes 1138 calls to
> test_commit on my system, of which 255 now use the --tag option
> (measured with a really crude hack that INCR's some keys in redis at
> appropriate points in test_commit).

... 255 out of 1138 is awesome IMHO! Do you see an improvement in time as
well (as in "time make test" is X% faster overall) ?

>
> Is this interesting enough to turn into a proper patch series?

I'd think this is worth making a real patch, definitely!

Thanks,
Stefan
