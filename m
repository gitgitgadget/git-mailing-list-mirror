From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] submodule operations: tighten pathspec errors
Date: Mon, 6 Jun 2016 12:31:22 -0700
Message-ID: <CAGZ79kY+K4-hbzL-KGgsyTHvM0BoXBLawvj2GmWJ9tbTuiSGbg@mail.gmail.com>
References: <1463793689-19496-1-git-send-email-sbeller@google.com>
 <xmqqd1o8vbc4.fsf@gitster.mtv.corp.google.com> <CAGZ79kbdfEJ1iSpOJ=HfHP=EvVxB9Sv+5Zk+goLSOJphh8ZZ+w@mail.gmail.com>
 <xmqqy46owr0n.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 21:31:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bA0FG-0004yX-38
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 21:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893AbcFFTbZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 15:31:25 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:33587 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848AbcFFTbY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 15:31:24 -0400
Received: by mail-qg0-f41.google.com with SMTP id j96so37935359qge.0
        for <git@vger.kernel.org>; Mon, 06 Jun 2016 12:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NioTh+w4FZI1Fv5QIvk4RRshEaNr6q1npuD4rKNuybM=;
        b=Fu2FF5RhL3jzU7m1W0a5WA7gn6VQ0u0iwQfqchmPtiU2gdFeji403+lJDKpSWsG5Pd
         1aqif4HEcHt1uUKXyVOWWQfd9MiWdqjJ9Vx91T5BbYlGpTQkPeAPkmsCUFqKykQy8IsH
         M/7b2YHOvHhuZw6fkmx/NRXnknSPe4JgW4elE+dR5PiI7osVdc4oHPKLH9Hxdm0HWsjU
         2Xuqhp0IQgsM3HXlfW0nCn2ksK69/QCZcoPs07qgpK2bQCOYNi+Fgytb5CxeacXkjGY8
         j7UMcYIPMatoQSEfBLirQTqZlsg8JwwOOw3dR8sZpcRDenqR8VZNWGvdJhE33wPCpjZS
         z6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NioTh+w4FZI1Fv5QIvk4RRshEaNr6q1npuD4rKNuybM=;
        b=B/LptI1EmC/XF/l71luSTng8sC9yyA0EBBWQcrFcP+hAhhxkH9CmMprpYKiXX5F7HB
         2Vzv6pa8yxcWZQiQ9+CpLnQABW6L9WYdfe3C5QoHM+6lvxR4Y7sNAF6NILfHtoMrOjEd
         gSLvGhIKfm2ZziKAsQ09V5gfOJosIW9EuV04HLNsm6Zf/nbpeobQm8y6X8sIVL+UooJe
         A9qos0AneKOm3SggHxOUcPlg78OC3XqfdTrc4Wb6Q3UkJYNQXfpSLZVYvKfRxkYPTe++
         +WTMTMEUvBzuYgEfUrK0XoJ5BW58A1vYbdE1OQ7R39qU2rXRN9AJx6fL9S5BYiPiryk1
         1nSA==
X-Gm-Message-State: ALyK8tKZzGLDMJ9/6McH/Fqa5BDhkHH06mKLcrKPlZ94NYP4R0Mz7XvTjSCtkJ+So7LfSpJbF116G/rzBgkJd+Bp
X-Received: by 10.140.153.135 with SMTP id 129mr17730196qhz.71.1465241483655;
 Mon, 06 Jun 2016 12:31:23 -0700 (PDT)
Received: by 10.200.55.212 with HTTP; Mon, 6 Jun 2016 12:31:22 -0700 (PDT)
In-Reply-To: <xmqqy46owr0n.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296555>

On Wed, Jun 1, 2016 at 2:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Thu, May 26, 2016 at 1:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>>> @@ -36,10 +37,9 @@ static int module_list_compute(int argc, const char **argv,
>>>>
>>>>       for (i = 0; i < active_nr; i++) {
>>>>               const struct cache_entry *ce = active_cache[i];
>>>> -
>>>> -             if (!match_pathspec(pathspec, ce->name, ce_namelen(ce),
>>>> -                                 0, ps_matched, 1) ||
>>>> -                 !S_ISGITLINK(ce->ce_mode))
>>>> +             if (!S_ISGITLINK(ce->ce_mode) ||
>>>> +                 !match_pathspec(pathspec, ce->name, ce_namelen(ce),
>>>> +                                 0, ps_matched, 1))
>>>>                       continue;
>>>
>>> OK, this is the crucial bit in this patch. pathspec matches are now
>>> done only against gitlinks, so any unmatch is "pattern or path
>>> given, but there was no such submodule".
>>
>> right.
>
> That changes the semantics, and its user visible effect may deserve
> to be in the documentation, no?
>
> It used to be that "git submodule--helper list COPYING" did not
> complain, but with this change, it would.  Which may be a good
> change, but "git submodule--helper list sub*" where most but not all
> of glob expansion done by the shell are submodule directories may be
> a common thing people may do, and it may be irritating to see the
> unmatch complaints.  I dunno.

I fixed all the variable names and was confident with what I had,
but this is an issue indeed as the error message is plain wrong:
    git$ git submodule--helper list sub*
    error: pathspec 'submodule.c' did not match any file(s) known to git.
    error: pathspec 'submodule-config.c' did not match any file(s) known to git.
    error: pathspec 'submodule-config.h' did not match any file(s) known to git.
    error: pathspec 'submodule-config.o' did not match any file(s) known to git.
    error: pathspec 'submodule.h' did not match any file(s) known to git.
    error: pathspec 'submodule_multiple_references' did not match any
file(s) known to git.
    error: pathspec 'submodule.o' did not match any file(s) known to git.
    error: pathspec 'submodulespec.o' did not match any file(s) known to git.

(I realize I have some stray object files laying around)

So I do not think we can do

-               if (!match_pathspec(pathspec, ce->name, ce_namelen(ce),
-                                   0, ps_matched, 1) ||
-                   !S_ISGITLINK(ce->ce_mode))
+               if (!S_ISGITLINK(ce->ce_mode) ||
+                   !match_pathspec(pathspec, ce->name, ce_namelen(ce),
+                                   0, ps_matched, 1))

or we need to have custom error reporting, which checks if any file
still matches the pathspec (and ignore non gitlinks)

>
> When we know we are not going to complain (i.e. --unmatch-ok option

I'd rather go with ignore-unmatch as git-rm does use that.

> is given from the command line), I think it is perfectly fine (and
> it is even preferrable) to swap the order of the check.  The mode
> check done with S_ISGITLINK() is much cheaper and it is likely to
> yield true much less often, which in turn would allow us to make
> fewer calls to more expensive match_pathspec().

As said, in that case we would then need a
    pathspec_mark_ps_matched(ce->name, ce_namelen(ce), ps_matched)

>
> But when we want to diagnose typo (i.e. --unmatch-ok was not given),
> we may want to preserve the current order, so that the "sub*"
> example in a few paragraphs ago would not irritate the users.

I see.

     if (!S_ISGITLINK(ce->ce_mode)) {
        pathspec_mark_ps_matched(...);
        continue;
    } else {
        if ( !match_pathspec(pathspec, ce->name, ce_namelen(ce),
                                     0, ps_matched, 1))
        continue;
    }
    ...

doesn't look very appealing, so I guess we'd just keep the current behavior
of
-               if (!match_pathspec(pathspec, ce->name, ce_namelen(ce),
-                                   0, ps_matched, 1) ||
-                   !S_ISGITLINK(ce->ce_mode))


>
>>> It is tempting to update report_path_error() return "OK" when its
>>> first parameter is NULL.
>>
>> such that we can do a
>>
>>     if (report_path_error(unmatch_ok ? NULL : ps_matched, pathspec, prefix)))
>>         result = -1;
>
> I actually was thinking about setting ps_matched to NULL so that
> both match_pathspec() and report_path_error() would get NULL.
> match_pathspec() has to do _more_ work when ps_matched[] aka seen[]
> is given.

Yes for one call; No from the birds eye view;
the first lines that use the seen[]:

    if (seen && seen[i] == MATCHED_EXACTLY)
        continue;

so if we have  `ps->nr > 0` then it is beneficial to have a
seen array, I think?

>
>>>> @@ -407,7 +410,7 @@ cmd_foreach()
>>>>       # command in the subshell (and a recursive call to this function)
>>>>       exec 3<&0
>>>>
>>>> -     git submodule--helper list --prefix "$wt_prefix"|
>>>> +     git submodule--helper list ${unmatch:+--unmatch} --prefix "$wt_prefix"|
>>>
>>> For this to work, somebody must ensure that the variable unmatch is
>>> either unset or set to empty unless the user gave --error-unmatch to
>>> us.  There is a block of empty assignments hear the beginning of
>>> this file for that very purpose, i.e. resetting a stray environment
>>> variable that could be in user's environment.

done.

>>>
>>> The patch itself does not look too bad.  I do not have an opinion on
>>> which one should be the default, and I certainly would understand if
>>> you want to keep the default loose (i.e. not complaining) with an
>>> optional error checking, but whichever default you choose, the
>>> option and variable names need to be clarified to avoid confusion.
>>
>> Ok I'll fix the variable names; I think for consistency with e.g.
>> ls-files --error-unmatch
>> we would want to be loose by default and strict on that option.
>
> I do not think the "typo-prevention" safety measure should suddenly
> be turned into opt-in; I'd suggest "--unmatch-ok" instead.

--ignore-unmatch has the same meaning and is taken by git-rm already?
