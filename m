Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8930C200B9
	for <e@80x24.org>; Thu,  3 May 2018 18:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751095AbeECSMa (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 14:12:30 -0400
Received: from mail-yb0-f174.google.com ([209.85.213.174]:44899 "EHLO
        mail-yb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbeECSM3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 14:12:29 -0400
Received: by mail-yb0-f174.google.com with SMTP id v63-v6so6824318ybi.11
        for <git@vger.kernel.org>; Thu, 03 May 2018 11:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=B+usi2iqMgM/Q5Ywp2o67/j3R7Qs7+L2864lrTGVCx8=;
        b=XHzSINz+/T2pr+UlgcaAWS0P6Q+UYoiMy0VSaNELOiXrHz4rDGfIuMiaBa3gTcuFQI
         JzYN1HwCsvD6d4QBv+SYcOYrjm7Gh7biuT6b+0dMdh320YjYNMaZ5dpOw8ssYzW+1/Gt
         ug8jK8B8/xytzr2nP8azWN+CEIvAHBKnMc5pSo74M6Qw246C6TnVjCuv8tD2H/QzhjcQ
         S4gvHavm/XJPJq1oqiesNSA86yNadgrFp62BeJ38BvH2mwEGXJjwWdE+zmpMaZgRpxbH
         GKhF+7nAJXdJnGLb6l/7IuhtQW7jD8IjtLjT7o/szlMQVVAR9hNMIdtFYPsKwMFg9elT
         c47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=B+usi2iqMgM/Q5Ywp2o67/j3R7Qs7+L2864lrTGVCx8=;
        b=XtpM+7S2Oaa8TAGnD1QEH0z4SNKARUPKje051yEQnQOfxkKZSJvUDFHjyB2KTTefVJ
         Are+UOk1/u/tlFbKrHmPzWELATH0q3aA03lxrxUc7q2Z/2fRHUpFRZRFOZz623l7GD2Y
         8YwqykqwOFM8pgBUYWuOoAFCbww2OtAlZ3rzHvFxq6fY2gSa3VIWZb96/1h3p9vwDsus
         ztnWkBfgh4S0atLuc2Mjy2yO4X2/FoOF3JZnkulrXUYkvJwqOo6YLQKgZ0SffaETZ4pz
         xzN2SWL/Z/T/f24c8MLBztyd6oxcSajjgwJlIp68Xim6Jlk8OfWOBhz3IbvsAAtjoySy
         TFlw==
X-Gm-Message-State: ALQs6tAvk/wtaqqUhATSiWWhKK0khcgdZoROQakPSdkqXsuYc5L6nE0D
        A1xtueCs6pBAdBAGB+++Yc27fMJfwnWs2Hq3XO5MNA==
X-Google-Smtp-Source: AB8JxZp/7hL8PPaQ9qAx6Mt5vHo3/3lgm1qBDvNfVRNRqyOKYZimTQ/DlT59zixXkGaKIE6ciz6io1zIXV0bIOR5hXg=
X-Received: by 2002:a5b:14f:: with SMTP id c15-v6mr15612995ybp.292.1525371147938;
 Thu, 03 May 2018 11:12:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Thu, 3 May 2018 11:12:27 -0700 (PDT)
In-Reply-To: <20180503104754.6aefd8ba38eb5a8871281b01@google.com>
References: <20180503005358.89082-1-sbeller@google.com> <20180503005358.89082-2-sbeller@google.com>
 <20180503104754.6aefd8ba38eb5a8871281b01@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 3 May 2018 11:12:27 -0700
Message-ID: <CAGZ79kYq0Qs7tvG0NEYwKHeYxF_tN1-eZA2skdjCiDZ4JkyuRQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] submodule foreach: correct '$path' in nested
 submodules from a subdirectory
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 3, 2018 at 10:47 AM, Jonathan Tan <jonathantanmy@google.com> wrote:
> On Wed,  2 May 2018 17:53:54 -0700
> Stefan Beller <sbeller@google.com> wrote:
>
>> From: Prathamesh Chavan <pc44800@gmail.com>
>>
>> When running 'git submodule foreach --recursive' from a subdirectory of
>> your repository, nested submodules get a bogus value for $path:
>
> I know I said in a previous e-mail [1] that we should use $path instead
> of $sm_path, but now I got confused because the test shows a difference
> in $sm_path, not $path. Maybe add "(and $sm_path, which is an alias of
> $path)".
>
> [1] https://public-inbox.org/git/20180206145406.b759164cead02cd3bb3fdce0@google.com/
>
>> There are three different possible solutions that have more value:
>> (a) The path value is documented as the path from the toplevel of the
>>     superproject to the mount point of the submodule. If 'the' refers to
>>     the superproject holding this submodule ('sub' holding 'nested'),
>>     the path would be expected to be path='nested'.
>
> What is "the", and why is it quoted?

because it is unclear what is emphasizes.
It could be the intermediate (direct) superproject, or it
could be the topmost superproject (where the command was run from).

Just having "the", makes it unclear which of both it refers to.

> Also, in (c), you use the same indicative present tense as "The path
> value is documented" to describe the current situation, whereas this
> seems like a situation you're proposing. It would be clearer to use the
> imperative here ("Document $path to be the path from the toplevel...").
> Do the same for the others.
>
> Also, whenever you mention "superproject", make it clear which
> superproject you're referring to ("outermost superproject" and
> "immediate superproject" seem like good terms to me).

ok, I'll rewrite the commit message with clearer superproject
annotations.

>> (b) In case 'the' superproject is referring to the toplevel, which
>>     is the superproject in which the original command was invoked,
>>     then path is expected to be path='sub/nested'.
>
> Same comment about "the", and I think s/toplevel, which is the
> superproject in which the original command was invoked/outermost
> superproject/.

The outermost superproject may not be the one you invoke the
command in.

We have
* the direct superproject. You can access it currently via $toplevel,
  which is misleading
* the superproject, where the command was invoked from,
  Currently only the undocumented $displaypath gives hints
  at this
* the outermost superproject, which may be even further
  out than the previous superproject in this list; Consider
  a layout with 4 git repositories nested as follows:

    outmost/invoked/direct/submodule

Submodule is part of the superproject "direct", but the command
could have been invoked from outmost/invoked/dir which has "direct"
as a submodule at '../direct' and itself is a submodule of outmost.

IMHO 'outmost' is of no relevance to the discussion. If you care about
it, discover it yourself via repeated calls to
'git rev-parse --show-superproject-working-tree'

'invoked' is only interesting for $displaypath, but apart from that
there is no benefit in knowing that at the time of processing
'submodule'. (It doesn't contain information for submodule, as
all those configs are in 'direct')

'direct' is a better name than 'toplevel', which is confusing as it
could be understood as any of 'direct', 'invoked' or 'outmost'.

>> (c) The documentation explains $path as [...] "relative to the
>>     superproject", following 091a6eb0fe (submodule: drop the
>>     top-level requirement, 2013-06-16), such that the nested submodule
>>     would be expected as path='../sub/nested', when "the" superproject
>>     is the superproject, where the command was run from
>
> How does "relative to the superproject" result in "../" appearing in the
> path? I would expect "../" to appear only if a path is relative to $pwd.

Gah. I messed that up. I wanted to emphasize *relative* and not the
superproject that is merely mentioned to form a sentence there.

>
>> (d) or the value of path='nested' is expected if we take the
>>     intermediate superproject into account. [This is the same as
>>     (a); it highlights that the documentation is not clear, but
>>     technically correct if we were to revert 091a6eb0fe.]
>
> How exactly are we taking the intermediate superproject into account?

'nested' is the full in-tree path from the intermediate (direct) superproject
to that submodule.

>> The behavior for (c) was introduced in 091a6eb0fe (submodule: drop the
>> top-level requirement, 2013-06-16) the intent for $path seemed to be
>> relative to $cwd to the submodule worktree, but that did not work for
>> nested submodules, as the intermittent submodules were not included in
>> the path.
>
> I think "pwd" is more used in the Git project than "cwd", so maybe use
> $pwd here.

ok.

>
>> If we were to fix the meaning of the $path using (a), (d) such that "path"
>> is "the path from the intermediate superproject to the mount point of the
>> submodule", we would break any existing submodule user that runs foreach
>> from non-root of the superproject as the non-nested submodule
>> '../sub' would change its path to 'sub'.
>>
>> If we were to fix the meaning of $path using (b) such that "path"
>> is "the path from the topmost superproject to the mount point of the
>> submodule", then we would break any user that uses nested submodules
>> (even from the root directory) as the 'nested' would become 'sub/nested'.
>>
>> If we were to fix the meaning of $path using (c) such that "path"
>> is "the display path from where the original command was invoked to the
>> submodule", then we would break users that rely on the assumption that
>> "$toplevel / $path" is the absolute path of the submodule.
>>
>> All groups can be found in the wild.  The author has no data if one group
>> outweighs the other by large margin, and offending each one seems equally
>> bad at first.  However in the authors imagination it is better to go with
>> (a) as running from a sub directory sounds like it is carried out by a
>> human rather than by some automation task.  With a human on the keyboard
>> the feedback loop is short and the changed behavior can be adapted to
>> quickly unlike some automation that can break silently.
>
> As I said in my previous e-mail, this is a good analysis.
>
>> Another argument in favor of (a) is the consistency of the variables
>> provided, "$toplevel / $path" gives the absolute path of the submodule,
>> with 'toplevel' (both the variable as well as the documentation) referring
>> to the immediate superproject of the submodule.
>
> It's confusing to me that $toplevel is not the path to the outermost
> superproject,

yes. That confused me for a while, too. Maybe deprecate that (just like we
deprecate $path) and introduce $superproject to mean the direct
superproject that holds the submodule currently being processed?


> but the path to the immediate superproject, so I'm not
> sure that the goodness of "$toplevel/$path" exists. I would omit this
> paragraph.

This exists for all nested submodules currently as these are run
from its root tree. For non-nested submodules, you still have the
part that is relative from pwd to the submodule.


>> Documentation of the variable is adjusted in a follow-up patch.
>
> By "the variable", I assume you mean $toplevel? If yes, this doesn't
> seem relevant to this patch, since this patch does not change the
> meaning of $toplevel at all.

ok.
