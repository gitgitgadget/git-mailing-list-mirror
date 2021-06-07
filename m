Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411AFC47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 16:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24B6E6023B
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 16:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhFGQld (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 12:41:33 -0400
Received: from mail-ej1-f43.google.com ([209.85.218.43]:34437 "EHLO
        mail-ej1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhFGQld (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 12:41:33 -0400
Received: by mail-ej1-f43.google.com with SMTP id g8so27776491ejx.1
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 09:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=6sP1dFCOfeS0ZZE4dLfKnIIjvdXiJHCFlSO8ZW3i78A=;
        b=bGtjwxUUUiUQ2frhqYOQCfvTDlfxRdqp2g1Jk5qHNO5r91FKE6eZbqdcOu9YYrmuCT
         XdK9wz7wjfa05jN+LS63RA58enCkoBamhkHxR7JqdXpF0HaGY46wC6H9dZ0SNSUyWgBo
         tVncR5q0Sis1QOkd2I47VGrXPh1q5on6grjQLT92m9WW8Pc+xmsHmCe9cr2bTsf/sCsR
         ZRhA4dajNJmKmSk2wegXKJIbNuI9b+olR+PjrsTgIli/T4j+Yjtv8BA0ftsWAVCambQQ
         oJTsOwcPfq5MCBggAHIeXJLsOXqKnac8i+4CNFocS1szi/Zr5VdhOW8jgaHFFZkj0Fgs
         9e4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=6sP1dFCOfeS0ZZE4dLfKnIIjvdXiJHCFlSO8ZW3i78A=;
        b=U+iC5l5234RHJ6Ygg9J2AuV5an8by8c56SoRuSOT0C85/J89xCoepbP5cIRlyJliF7
         n++AKrI2tBW7SKcMujgCftjAqh76uZsmwV7SsqgumXvFNUdyvh/9lCTHahdfayrGaccm
         vWYhUev4jxuWDwQ14H7vxDL2zLd8IPOxUTSyQk8oTa8wyEcXwMp3LMIHK8V5T/uW+yyK
         VwrpetqlmisYtXK/rItXlZS07aH8zpRpxVhpcMG465/z4gCSpzq8SOpqrdGERR5q4Hhz
         WBzfGcPwKEoIRiY+UsCAwrSG7bQ9GrM251Uw4jApoGNyNOAxWzhR6CFKK0cW8Vut+VQi
         CgOA==
X-Gm-Message-State: AOAM5323tUI55olkCQx1ECQewUWFUZBzohMxlSRWHaify0QBo/uzY05j
        CeNgnq8/otgw6OMC0yz+TGc=
X-Google-Smtp-Source: ABdhPJzfUzybBxy0EbFaQlkFBDCM4Tzu4Q0k9Yh+fyPM+8biqsYpH76MReWnkw3JvoVtNYXi/cS6YA==
X-Received: by 2002:a17:907:6289:: with SMTP id nd9mr18649600ejc.384.1623083907143;
        Mon, 07 Jun 2021 09:38:27 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id t2sm6610464ejx.72.2021.06.07.09.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 09:38:26 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] branch: make -v useful
Date:   Mon, 07 Jun 2021 18:05:35 +0200
References: <20210605011339.2202-1-felipe.contreras@gmail.com>
 <87czt059sn.fsf@evledraar.gmail.com>
 <60be3b2d6e1e6_39c0a20883@natae.notmuch>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <60be3b2d6e1e6_39c0a20883@natae.notmuch>
Message-ID: <87h7i94ola.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 07 2021, Felipe Contreras wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Fri, Jun 04 2021, Felipe Contreras wrote:
>>=20
>> > Currently `git branch -v` shows something like "[ahead 10]", but ahead
>> > of what?
>> >
>> > We git experts know ahead of what, but not what that what is set to. J=
ust
>> > like "[@{upstream}: ahead 10]" would not be particularly useful to
>> > anyone that doesn't know, or remembers, what @{upstream} is set to.
>> >
>> > On the other hand "[master: ahead 10]" is perfectly clear to anyone.
>> >
>> > This confusion only gets worse when you see "[ahead 10, behind 100]". =
Is
>> > it master? Is it next? Is it
>> > john/experimental-feature-i-based-my-branch-on?
>> >
>> > Inevitably most users will need to know what @{upstream} is.
>> >
>> > So let's make `git branch -v` output what is most useful:
>> >
>> >   [master]
>> >
>> > Before:
>> >
>> >   * fc/branch/sane-colors b2489a3735 [ahead 1] branch: make -v useful
>> >
>> > After:
>> >
>> >   * fc/branch/sane-colors b2489a3735 [master] branch: make -v useful
>> >
>>=20
>> Having applied this patch I find the description a bit confusing. The
>> example led me to believe that you'd stripped the remote name, so the
>> common case of "origin/master" would become "master", but instead the
>> example is from a "fc/branch/sane-colors" branch where your "remote
>> tracking branch" is actually tracking your *local* master, i.e. "remote
>> =3D ."?
>
> Yes, in my particular setup I have a local "master" and many branches
> based on it. A simply picked a real example.
>
> But yeah, it would have been clearer with origin/master.

*nod*

>> Disambiguating that is one of the reasons we prefix with the remote
>> name, but I'd say it makes for a confusing example in a commit message,
>> and also if instead of saying:
>>=20
>>     branch: make -v useful
>>=20
>> It said e.g.:
>>=20
>>     branch: reverse the priority of what -v and -vv show
>
> I guess that depends on what you consider this patch is doing, why, and h=
ow.
>
> But I have no problem with your version.
>
>> Or something similar to note that it's not "useful" now, but an
>> opinionated change about what we should show on verbosity level 1 and 2.
>
> I'm not sure I parsed that correctly, but that's the whole point:
> verbosity level 1 is not very useful (I'd argue not useful at all).

Maybe, anyway I meant to suggest saying something approaching "reverse
the order of the data we consider important" instead of the equivalent
of "make the data useful".

>> In any case, this proposed patch is missing a doc update, in
>> git-branch.txt we say both:
>>=20
>>     When in list mode, show sha1 and commit subject line for each head,
>>     along with relationship to upstream branch (if any). If given twice,
>>     print the path of the linked worktree (if any) and the name of the
>>     upstream branch, as well (see also git remote show <remote>).
>>=20
>> And later, for the --track option:
>>=20
>>     When creating a new branch, set up branch.<name>.remote and
>>     branch.<name>.merge configuration entries to mark the start-point
>>     branch as "upstream" from the new branch. This configuration will
>>     tell git to show the relationship between the two branches in git
>>     status and git branch -v.
>>=20
>> Both of those need to be updated,
>
> Sure, I missed that.
>
>> and I think the commit messages should discuss whether we break this
>> promise of having consistent output between "status" and "branch -v"
>> now.
>
> But we don't with "branch -vv".

I think the wording there needs to be changed in any case, I'm not sure
what it's supposed to mean.

I think the "show the relationship between" there is referring to the
ahead/behind relationship, or maybe it's just speaking more generally
about the short (branch -v[-v]) v.s. long (git status) blurb we show
about the branch status overall.

>> As for the proposal, I don't use "branch -v" all that much much, so I
>> don't have strong knee-jerk feelings on it, but just considering it now
>> I'd think that the current default is a fundamentally better
>> approximation of what most users would like as a default.
>>=20
>> I.e. I think it's fair to say that to the extent that most users have
>> topic branches they're part of some pull-request workflow where they're
>> always tracking the one upstream they always care about, usually
>> origin/master.
>
> Because git has poor support for triangular workflows users are forced
> to pick between one of two approaches:
>
>  1. If you rebase a lot you pick origin/master
>  2. If you push a lot you pick github/my-pull-request
>
> There's a reason `git push --set-upstream` exists.
>
> A quick Google search shows these top results:
>
> 1. https://devconnected.com/how-to-set-upstream-branch-on-git/
>
>  * git push --set-upstream <remote> <branch>
>  * git branch -vv
>
> The author doesn't even mention any other way to setup branches, and of
> course doesn't bother himself with `git branch -v`, which is not useful
> at all for his purposes.
>
> 2. https://git-scm.com/book/en/v2/Git-Branching-Remote-Branches
>
>   If you want to see what tracking branches you have set up, you can use
>   the -vv option to git branch. This will list out your local branches
>   with more information including what each branch is tracking and if
>   your local branch is ahead, behind or both.
>
> Once again another author that doesn't bother himself with
> `git branch -v`.
>
> And the examples show why:
>
>     iss53     7e424c3 [origin/iss53: ahead 2] Add forgotten brackets
>     master    1ae2a45 [origin/master] Deploy index fix
>   * serverfix f8674d9 [teamone/server-fix-good: ahead 3, behind 1] This s=
hould do it
>     testing   5ea463a Try something new
>
> In only one example is the upstream branch origin/master.
>
> 3. https://stackoverflow.com/questions/1783405/how-do-i-check-out-a-remot=
e-git-branch
>
> The top answer to "How do I check out a remote Git branch?" mentions:
>
>   git checkout -t <name of remote>/test
>
> This most certainly will not create an origin/master upstream.
>
> 4. https://www.git-tower.com/learn/git/faq/track-remote-upstream-branch/
>
>   git checkout --track origin/dev
>   git push -u origin dev
>   git branch -u origin/dev
>
> Once again no sight of origin/master, which isn't even mentioned in the
> whole article.
>
>
> So no, I don't think it's accurate to say that most people would track
> origin/master, in fact, I would say of the people that know how to set
> upstream tracking branches, the minority would pick origin/master.
>
>> The -v output showing the ahead/behind relationship to that branch
>
> What branch?
>
> If I show you the output of my `git branch -v` on git.git do you think you
> would be able to figure out what branch is being tracked? Not even I
> could figure that out.
>
>> Whereas you are presumably tracking origin/master for some, building on
>> your own topic (or other people's topics) for another etc., I think that
>> workflow is much rarer outside of linux.git and git.git, and even for
>> those most people usually track origin/master with most of their topics.
>
> That's an unsupported assumption.
>
> As I showed above, most pople track the branch they push to, not
> origin/master.
>
> Google "git branch -v", and you will find mostly official documentation
> and man pages.
>
> Google "git branch -vv", and you will find mostly blog posts, Stack
> Overflow questions, and cheat sheets.
>
> I think the reason why is obvious.

Yes, I stand corrected.

For what it's worth I think one thing to salvage from my ill-informed
rambling is that I was under that impression because I set
push.default=3Dupstream.

But yes, with "simple" being the default and refusing to have
avar/my-topic have an upstream of origin/master my setup is probably not
the common case.

I wonder if this should depend on the setting of push.default, or
whether we can infer anything at all from that setting. After all you
can set it to whatever and then either manually do "git push <remote>
<src>:<dst>" (my usual worklow is just "git push origin HEAD"), or
manually do the "git rebase origin/master" or whatever in the case where
your upstream is your own topic branch.

