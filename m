Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FB3C433ED
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 01:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7BD861106
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 01:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbhDCA6q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 20:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbhDCA6p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 20:58:45 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CBEC0613E6
        for <git@vger.kernel.org>; Fri,  2 Apr 2021 17:58:42 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 15so7130357ljj.0
        for <git@vger.kernel.org>; Fri, 02 Apr 2021 17:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zCZEx0gkASyakzdkm+iVY38d3+3fbdjeil1a5qIaaKk=;
        b=nU0pl4amVbVXVGNmOmRZm+OtRbkdsCTuB7BbyIX+am7P5SitB0gDOtGdUzpjTs/Sct
         kOXSqVMFDYnhO2fP8TuMlX1ZOsbab6CeQiD6CiA2lHru+cWhW+lGnQ7kJ0pK7yHoMQ6d
         AFVHxpl17vTLG6WLmx9XcCQ70ZtQ8rrV7XEDuP3hho9RL1C1dkx0058jPwm78BW2hJPD
         dgiTQ3zLUF3INp36jmbW4qLfUFsrCFx0NgTFUoFSnBytf+bXwRJwr/+PScohOdjw1NzW
         lbANmbBpLKX9RF+q7HUZdMQSdbBEeAjeT8dWGGbDsCprEHXkE8HejUCnuet6XjTu48Li
         uTTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zCZEx0gkASyakzdkm+iVY38d3+3fbdjeil1a5qIaaKk=;
        b=XcgYvxRQ1tkMWnvCg0cOKyRyQ4umH2wT0JreOsgsQSze3rPCl4HTZY/J88eGijBiCP
         da+yv3clspZ4VMS2ULzSgwu7JWr4pYbTMPHZl9oXlVbgatKlAu+D0zEezVRA/9rrlhNE
         rmhl+pRKDZGU2TlV5kTzPzHL69mD8J0WpbR2rKbjQSKOQU8le9tPqrUj5EX41gGyaJCf
         5xkzQRuxvOqRrhTgv4d0XxjYd8zt6Bybl/5uepIWNmLFFjQxiwuNb7XZ/bl6FjJDR8eI
         gPHZsTom/A+fF2qqvyFx0GS79W20TJW9w7k7gQdlLeni6ILJcClXcvdKvgZRQ5MsEkYm
         KAzg==
X-Gm-Message-State: AOAM532lnHYy7XR/HIWwb+Fm4ScD55QvL1pb/CiPxoy71IjLJWhB2Xqb
        ovBTG9knYkP55a6gJUPJH4kis03hUt6UEAamkp7qR+GahvwkQQ==
X-Google-Smtp-Source: ABdhPJwO3oq9c66GZsaJCsj1L5LKHQ1IgBw6kxrGRFsdy8vkLvy9fwZO+oNEbWj0kO7fhoCs8laJCXOQ/pGbuSPPc8M=
X-Received: by 2002:a2e:85c7:: with SMTP id h7mr9948300ljj.369.1617411520472;
 Fri, 02 Apr 2021 17:58:40 -0700 (PDT)
MIME-Version: 1.0
References: <pull.908.git.1616105016055.gitgitgadget@gmail.com>
 <pull.908.v2.git.1616723016659.gitgitgadget@gmail.com> <87zgyhj7vr.fsf@evledraar.gmail.com>
In-Reply-To: <87zgyhj7vr.fsf@evledraar.gmail.com>
From:   Albert Cui <albertqcui@gmail.com>
Date:   Fri, 2 Apr 2021 17:58:29 -0700
Message-ID: <CAMbkP-Q4_z-nQzJwr2ZeM16deHKmzr=Z4908UzgOyk9FA-gKEA@mail.gmail.com>
Subject: Re: [PATCH v2] hooks: propose project configured hooks
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Albert Cui via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 2, 2021 at 3:30 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> I had comments on the v1 that are still unanswered by this re-roll:
> https://lore.kernel.org/git/87im5nzbe6.fsf@evledraar.gmail.com/
>
> I think a more productive way to handle such proposals is to reply to
> such general discussion and /then/ re-roll the series.
>
> I'm not going to repeat the outstanding points there (but would like you
> to reply to it, and having just read Derrick Stolee's E-Mail downthread
> there's another significant point of feedback to reply to.
>
Thanks for the feedback! I'm new to this process. I'll make sure to
reply to both.

[...]

> >      ++  ** The project may want to prevent developers from committing =
passwords or
> >      ++  other sensitive information e.g. via
> >      ++  https://github.com/awslabs/git-secrets[git-secrets].
>
> Why does the project want to prevent developers from *committing* such
> information by default? I commit such stuff all the time, it's only a
> problem once it's pushed.
>
> But I think this is answered below:
>
> >      ++Server-side vs Local Checks
> >      ++^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >      ++
> >      ++A large motivation for this change is providing projects a metho=
d to enable
> >      ++local checks of code e.g. linting. As documented in
> >      ++https://git-scm.com/docs/gitfaq#_hooks[gitfaq], in some cases, s=
erver-side
> >      ++checks may be more appropriate, especially since developers can =
always skip
> >      ++local hook execution. We think there are still benefits to local=
 checks:
> >      ++
> >      ++* Ensuring commit message style and preventing the committing of=
 sensitive data,
> >      ++as described above. In particular, if CI results are public, as =
with many open
> >      ++source projects, server side checks are useless for guarding aga=
inst leaking
> >      ++sensitive data.
>
> So what you really mean is you want a pre-commit hook as an alternative
> to some "once we've accpted the push and CI runs we notice naughty
> data", not as a pre-receive hook alternative?
>

I think you're identifying that "prevent developers from commiting" is
the wrong wording.
Maybe a better phrasing is "prevent sensitive information from getting push=
ed or
checked in."

Yes, this could be done in CI, but as noted below, catching this
before the push (or commit)
happens is more productive for developers:

> >      ++
> >      ++* Helps developers catch issues earlier: typically developers ne=
ed to push to
> >      ++the remote to trigger server-side checks. Local hooks can be run=
 anytime the
> >      ++developer wants. This is especially useful if the project has sl=
ow
> >      ++server-checks; catching issues locally can save the developer a =
lot of time
> >      ++waiting for CI. They are also useful for locally reproducing an =
issue identified
> >      ++in CI, helping resolve issues faster.
> >      ++

An additional point I should also call out is that for large
repositories, pushes themselves
can be slow, so even if server-side checks are fast, being able to
avoid unnecessary pushes
can help developer velocity.

>
> This all makes sense, but is really missing how this problem isn't adequa=
tely solved by:
>
>     $ HACKING
>     Welcome to project XYZ, first you'll be much more productive with
>     our hooks, run:
>
>         ./setup-hooks.sh
>
>     [...]
>
> Presumably developers working on some central repo are the ones least
> served by this type of thing, since such setups usually have established
> setup scripts etc. that you (mostly) go through once.
>

One issue that immediately comes to mind with a setup script is that
developers could
easily miss out on updates to the hooks. One nice thing about this
proposal is that we
try to address that problem.

Anothing issue is that people in general are bad at reading
instructions; that's why I'm
trying to get as close as possible to `git clone` doing set up for you
while balancing the
security concerns (I know Derrick Stolee finds issue with this in his
reply, which I'll try to
address in my reply there.)

> >      ++In the ideal world, developers and project maintainers use both =
local and server
> >      ++side checks in their workflow. However, for many smaller project=
s, this may not
> >      ++be possible: CI may be too expensive to run or configure. The nu=
mber of local
> >      ++solutions to this use case speaks to this need (see <<prior-art,=
 Prior Art>>).
> >      ++Bringing this natively to Git can give all these developers a we=
ll-supported,
> >      ++secure implementation opposed to the fragmentation we see today.
>
> The end-goal of this series combined with Emily's configurable hook is
> basically to have less friction when it comes to setting up and
> maintaining hooks.
>
> I don't see how it would help with "CI may be too expensive to run or
> configure" though. We're basically talking about auto-updating a script
> in .git/hooks, which today is essentially a ./setup-hooks.sh, and the
> script checking for a new version of itself when it runs at
> origin/myscripts:myname.sh, no?
>

By "expensive", I mean from both a money and a time perspective: for small
projects, you may not set up any server-side checks and instead rely
purely on local checks,
and this helps by, as you said, reducing the friction to set up these
local checks.

From my own experience: When I start a new weekend project, setting up
CI is not at the top
of the list of things I want to spend time on; I'm usually not even
writing tests. Maybe
I'm just a bad developer :D But I do set up local checks: linting,
code formatters.

To your point about updating hooks (we're thinking on the same
lines!): that's putting the
responsibility on the developer to implement. From a
maximizing-global-productivity
point of view, isn't it more elegant for us to extend Git's
functionality and provide good support
for this use case?

> >      -+* As a repository owner / project maintainer,
> >      ++* As a project maintainer,
> >       +
> >       +    ** I want to enforce code style so I require developers to u=
se a
> >       +    standardized linter.
> >       +
> >      -+    ** I want to prevent leaks / share code widely so I check th=
at developers
> >      -+    are uploading code to the right place.
> >      ++    ** I want to prevent sensitive data from getting checked in.
> >       +
> >      -+    ** I want this to just work for all the developers in my rep=
ository, without
> >      ++    ** I want to prevent leaks so I check that developers are up=
loading code to
> >      ++    the right private central repository. Conversely, I may want=
 to encourage
> >      ++    more open source development and encourage developers to pus=
h to public
> >      ++    central repositories.
>
> I think I'm beginning to get the gist of this, so it's really also a
> proposed workaround for projects that host on platforms like github.com
> and whatnot where you can run arbitrary code in a CI, but you can't
> install a custom pre-receive hook?
>
> I think it might be worth explicitly spelling that out. E.g. if those
> platforms gained a feature (which isn't that hard to imagine) of hiding
> your ref until after some pre-receive part of a CI check has run (which
> would not have public logs, so you could "safely" check/push passwords)
> it seems to me that a large part of the immediate need for this would go
> away.
>
> Which doesn't per-se mean we shouldn't do it, just that assumptions,
> constaints etc. should be documented.
>

Agree we can call this out, but as I'm saying above, I don't think
it's fair to assume
everyone is already using server-side checks and there's still benefit
to doing the same
checks locally even if you have server-side checks.

[...]

> Snip the rest of the doc, which as noted I've god unreplied-to feedback
> on in https://lore.kernel.org/git/87im5nzbe6.fsf@evledraar.gmail.com/

Really appreciate the engagement! I'll try to reply early next week.
