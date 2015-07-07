From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: refspecs with '*' as part of pattern
Date: Tue, 7 Jul 2015 16:20:33 -0700
Message-ID: <CA+P7+xoobt_W11ruGVmJ0hzTEqNcdqk=cgRUAuYqSchPJcTsrw@mail.gmail.com>
References: <CA+P7+xoosLG3J5uUVakzwYoxVARs-NH4BJBtsMgw2NB39vyE6A@mail.gmail.com>
 <xmqqzj38yjpg.fsf@gitster.dls.corp.google.com> <alpine.LNX.2.00.1507062208580.2241@iabervon.iabervon.org>
 <xmqqbnfo3paa.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Daniel Barkalow <barkalow@iabervon.iabervon.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 01:21:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCcAc-000337-PF
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 01:20:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757352AbbGGXUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 19:20:54 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:36260 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753580AbbGGXUx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 19:20:53 -0400
Received: by obdbs4 with SMTP id bs4so139512924obd.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 16:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=TqAc9Xg4NFEAxJM01jrs0rK8keGba9hOk0JdfW8gmWw=;
        b=jRnkgn8++x8MxzYqynOzo22xKkymowhEmgew5UjMKSpGvh5WoHgqP2tqJkNheYkD76
         yYvK5NJH0v9pyUBZbnRSL3mn9rdx38dqVaPdNBQA9Fy6CHVUg+GE9c+SMLIJDwfXoTQj
         7DwaKMeeJcjrm6bDw132ro2A4k/w38C5DKmqg0aoTxkdjc+YOFwp1WiuDmIekaMB2ZR+
         8M0v2NvRNYRGzW89WENA1kdQ+qc/nq666C6ggIT9FeV6q6FwOt62hnK0HOovVClfi6rf
         P+pbLCt2KBmhTSIVN8u1SY4ugGdyrIlh70+3SxoNPTDv3ibNJ+YxQHKGJmAe+sIjyQGf
         I1jg==
X-Received: by 10.182.230.75 with SMTP id sw11mr6409605obc.17.1436311253077;
 Tue, 07 Jul 2015 16:20:53 -0700 (PDT)
Received: by 10.76.174.8 with HTTP; Tue, 7 Jul 2015 16:20:33 -0700 (PDT)
In-Reply-To: <xmqqbnfo3paa.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273619>

On Tue, Jul 7, 2015 at 9:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Daniel Barkalow <barkalow@iabervon.iabervon.org> writes:
>
>> On Mon, 6 Jul 2015, Junio C Hamano wrote:
>>
>>> I cannot seem to be able to find related discussions around that
>>> patch, so this is only my guess, but I suspect that this is to
>>> discourage people from doing something like:
>>>
>>>      refs/tags/*:refs/tags/foo-*
>>>
>>> which would open can of worms (e.g. imagine you fetch with that
>>> pathspec and then push with refs/tags/*:refs/tags/* back there;
>>> would you now get foo-v1.0.0 and foo-foo-v1.0.0 for their v1.0.0
>>> tag?) we'd prefer not having to worry about.
>>
>> That wouldn't be it, since refs/tags/*:refs/tags/foo/* would have the same
>> problem, assuming you didn't set up the push refspec carefully.
>
> Thanks, I was wondering where you were ;-)  Nice to hear from you
> from time to time.
>
>> I think it was mostly that it would be too easy to accidentally do
>> something you don't want by having some other character instead of a
>> slash, like refs/heads/*:refs/heads-*.
>
> Hmm, interesting thought.
>
> But refs/heads/*:refs/heade/* would not be saved, so I do not think
> that is it, either.

In this case, I'm more in favor of just allowing these refs because
the user already has to manually change the refspecs, which is
something many users will never do. I also think that given the above
comments, we're not really protecting the user from anything extra...
aside from adding more pain because the globs don't work as expected.

I did submit a patch (from my @intel.com address since I can't seem to
get git-for-windows to send from my home computer) but I am willing to
re-work to drop the setting if everyone is ok with that...

Thoughts?

Regards,
Jake
