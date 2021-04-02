Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2133C433ED
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 10:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E8AD610E8
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 10:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhDBKaz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 06:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhDBKax (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 06:30:53 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204A5C061788
        for <git@vger.kernel.org>; Fri,  2 Apr 2021 03:30:51 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z1so5004196edb.8
        for <git@vger.kernel.org>; Fri, 02 Apr 2021 03:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=x+GLz9vpxD7kGGEre47MrlNRPJEXFyiEHBQbm4Yy1N4=;
        b=hiT6GH3Ax37MAWaQbSdJDRrnK0bXwVezEw25o7hPHIdpoz8iYmpG75AO6mkx8rl41H
         LTCCElpS+cAn0lGHVLeYX468GRtnc5fhrpRZHJ7Qiz8FH6wFYH9J67TQWUtfX8MUIWVh
         irVjV/xuD4Fx8axkIXeH2of2GcPsfRZEaP0JQOoOIGPG/GkbiaH/QtfRrqbf1B/KYZ0a
         kqFCpSZ0lTya+0cMHjjj8fbNCJjnwMGtFuE/qQdkNGVIBcUuhYe9IQYgc7dOWI6tIDMk
         axw+l4/WTSRIVm02WNK5EInqRcssZ6Wf6uKHDDGnyCal3DhcslsrbnTfEZoGa7O2oSiW
         ropQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=x+GLz9vpxD7kGGEre47MrlNRPJEXFyiEHBQbm4Yy1N4=;
        b=qWCBCiBLTjC5ruj6K5ThOVKt98+yigzK7l4GgVfz9mlxrEBbQi31ly5ZHRDtGiVl0d
         sYTh4nuIC8MNJYpVBwXL9/ZTahfLzR/OiCIP/p6rAUbe+Foe74kxl6jSwAJCAWXvgI+b
         oLhGAGQRxga4JjvqS5+AouZRUAjR939KfY02I0Y78D5aeoqVC6jfRTcxToabXcO9eX4o
         9F7gIjHEt76sAqeC2ttDS5svn+HVSfyNSC8PopGs65uVpbrcBwAXFO21D1fGTiX72FRl
         4PNgC9ERAlATAC8i4LqI6IuoFMOuOxIrExies5dlNF8lrj2wFeCUh4lGkhu7L9X0HKuc
         ry9Q==
X-Gm-Message-State: AOAM533cPYqqY9apFIAGbrl5VYeTSvaMxtAzWRUp2oii7gDVLsJHZR+D
        k6FnYgvOHfUrnirfq5ig4xRX2diwmEpYnA==
X-Google-Smtp-Source: ABdhPJzGnHmBmob6/3j7PdXCaxYiE9ZMOHviPyR6JnulZx1mBvOw6bF3UiDU1sO4HSTpVYcTKd4zIQ==
X-Received: by 2002:a50:9ea4:: with SMTP id a33mr15062715edf.295.1617359448979;
        Fri, 02 Apr 2021 03:30:48 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id r24sm5099344edw.11.2021.04.02.03.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 03:30:48 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Albert Cui via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Albert Cui <albertqcui@gmail.com>
Subject: Re: [PATCH v2] hooks: propose project configured hooks
References: <pull.908.git.1616105016055.gitgitgadget@gmail.com>
 <pull.908.v2.git.1616723016659.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <pull.908.v2.git.1616723016659.gitgitgadget@gmail.com>
Date:   Fri, 02 Apr 2021 12:30:48 +0200
Message-ID: <87zgyhj7vr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 26 2021, Albert Cui via GitGitGadget wrote:

> From: Albert Cui <albertqcui@gmail.com>
>
> Hooks today are configured at the repository level, making it difficult to
> share hooks across repositories. Configuration-based hook management, by
> moving hooks configuration to the config, makes this much easier. However,
> there is still no good way for project maintainers to encourage or enforce
> adoption of specific hook commands on specific hook events in a repository.
> As such, there are many tools that provide this functionality on top of Git.
>
> This patch documents the requirements we propose for this feature as well as
> a design sketch for implementation.

I had comments on the v1 that are still unanswered by this re-roll:
https://lore.kernel.org/git/87im5nzbe6.fsf@evledraar.gmail.com/

I think a more productive way to handle such proposals is to reply to
such general discussion and /then/ re-roll the series.

I'm not going to repeat the outstanding points there (but would like you
to reply to it, and having just read Derrick Stolee's E-Mail downthread
there's another significant point of feedback to reply to.

So just comments on the range-diff below. I think for any one paragraph
reading ahead helps, because it's a bit of stream-of-conciousness as I
try to make sense of things that are then hinted at in later parts of
the document (which itself is a suggestion to maybe re-arrange some of
it).

>      -+* The `pre-commit` hook event: before committing, a developer may want to lint
>      -+their changes to enforce certain code style and quality. If there are style
>      -+issues, the developer may want the commit to fail so that they can fix the
>      -+issues.
>      ++* The `pre-commit` hook event:
>       +
>      -+* The `commit-msg` hook event: after committing, repository owners may want to
>      -+enforce a certain commit message style. This may be out of necessity:
>      ++  ** A developer may want to lint their changes to enforce certain code style
>      ++  and quality. The project may want the commit to fail so that commits that
>      ++  violate the project's style don't get uploaded.
>      ++
>      ++  ** The project may want to prevent developers from committing passwords or
>      ++  other sensitive information e.g. via
>      ++  https://github.com/awslabs/git-secrets[git-secrets].

Why does the project want to prevent developers from *committing* such
information by default? I commit such stuff all the time, it's only a
problem once it's pushed.

The genesis of this series seems to be need within the
Google-plex. Having operated a similar central-repository corporate
setup before I'm surprised that you're even trying to prevent such
things on local computers, surely you'll have to re-do such checks
on-push on the server, so just have them live there?

But I think this is answered below:

>      ++Server-side vs Local Checks
>      ++^^^^^^^^^^^^^^^^^^^^^^^^^^^
>      ++
>      ++A large motivation for this change is providing projects a method to enable
>      ++local checks of code e.g. linting. As documented in
>      ++https://git-scm.com/docs/gitfaq#_hooks[gitfaq], in some cases, server-side
>      ++checks may be more appropriate, especially since developers can always skip
>      ++local hook execution. We think there are still benefits to local checks:
>      ++
>      ++* Ensuring commit message style and preventing the committing of sensitive data,
>      ++as described above. In particular, if CI results are public, as with many open
>      ++source projects, server side checks are useless for guarding against leaking
>      ++sensitive data.

So what you really mean is you want a pre-commit hook as an alternative
to some "once we've accpted the push and CI runs we notice naughty
data", not as a pre-receive hook alternative?

>      ++
>      ++* Helps developers catch issues earlier: typically developers need to push to
>      ++the remote to trigger server-side checks. Local hooks can be run anytime the
>      ++developer wants. This is especially useful if the project has slow
>      ++server-checks; catching issues locally can save the developer a lot of time
>      ++waiting for CI. They are also useful for locally reproducing an issue identified
>      ++in CI, helping resolve issues faster.
>      ++
>      ++* Since the typical goal of developers to submit changes to a central
>      ++repository, their interests are aligned with the project maintainers'; while
>      ++they can choose to skip local hook execution, it is in their interest to allow
>      ++hooks to run at least before proposing code for submission to the central
>      ++repository to increase the chances of the code getting accepted.

This all makes sense, but is really missing how this problem isn't adequately solved by:

    $ HACKING
    Welcome to project XYZ, first you'll be much more productive with
    our hooks, run:

        ./setup-hooks.sh

    [...]

Presumably developers working on some central repo are the ones least
served by this type of thing, since such setups usually have established
setup scripts etc. that you (mostly) go through once.

>      ++In the ideal world, developers and project maintainers use both local and server
>      ++side checks in their workflow. However, for many smaller projects, this may not
>      ++be possible: CI may be too expensive to run or configure. The number of local
>      ++solutions to this use case speaks to this need (see <<prior-art, Prior Art>>).
>      ++Bringing this natively to Git can give all these developers a well-supported,
>      ++secure implementation opposed to the fragmentation we see today.

The end-goal of this series combined with Emily's configurable hook is
basically to have less friction when it comes to setting up and
maintaining hooks.

I don't see how it would help with "CI may be too expensive to run or
configure" though. We're basically talking about auto-updating a script
in .git/hooks, which today is essentially a ./setup-hooks.sh, and the
script checking for a new version of itself when it runs at
origin/myscripts:myname.sh, no?

>      -+* As a repository owner / project maintainer,
>      ++* As a project maintainer,
>       +
>       +    ** I want to enforce code style so I require developers to use a
>       +    standardized linter.
>       +
>      -+    ** I want to prevent leaks / share code widely so I check that developers
>      -+    are uploading code to the right place.
>      ++    ** I want to prevent sensitive data from getting checked in.
>       +
>      -+    ** I want this to just work for all the developers in my repository, without
>      ++    ** I want to prevent leaks so I check that developers are uploading code to
>      ++    the right private central repository. Conversely, I may want to encourage
>      ++    more open source development and encourage developers to push to public
>      ++    central repositories.

I think I'm beginning to get the gist of this, so it's really also a
proposed workaround for projects that host on platforms like github.com
and whatnot where you can run arbitrary code in a CI, but you can't
install a custom pre-receive hook?

I think it might be worth explicitly spelling that out. E.g. if those
platforms gained a feature (which isn't that hard to imagine) of hiding
your ref until after some pre-receive part of a CI check has run (which
would not have public logs, so you could "safely" check/push passwords)
it seems to me that a large part of the immediate need for this would go
away.

Which doesn't per-se mean we shouldn't do it, just that assumptions,
constaints etc. should be documented.

>      ++* Trust comes from the central repository:
>      ++  ** Most users don't have the time or expertise to properly audit every hook
>      ++  and what it does. There must be trust between the user and the remote that the
>      ++  code came from, and the Git project should ensure trust to the degree it can
>      ++  e.g. enforce HTTPS for its integrity guarantees.

I won't belabor the point but in my feedback on v1 I suggested an
alternate mechanism of doing this which I think is more
distributed-friendly and more safe:
https://lore.kernel.org/git/87im5nzbe6.fsf@evledraar.gmail.com/

...

>      ++Example User Experience
>      ++^^^^^^^^^^^^^^^^^^^^^^^
>      ++
>      ++===== Case 1: Consent through clone
>      ++
>      ++....
>      ++$ git clone --setup-hooks
>      ++...
>      ++
>      ++The following hooks were installed from remote `origin` ($ORIGIN_URL):
>      ++
>      ++pre-commit: git-secrets --pre_commit_hook
>      ++pre-push:  $GIT_ROOT/pre_push.sh
>      ++....
>      ++
>      ++===== Case 2: Prompting after clone
>      ++....
>      ++$ git clone
>      ++...
>      ++
>      ++Remote `origin` ($ORIGIN_URL) suggest installing the following hooks:
>      ++
>      ++pre-commit: git-secrets --pre_commit_hook
>      ++pre-push:  $GIT_ROOT/pre_push.sh
>      ++
>      ++# instead of prompting, we could give users commands to run instead
>      ++# see case 3
>      ++
>      ++Do you wish to install them?
>      ++1. Yes (this time)
>      ++2. Yes (always from origin)
>      ++3. No (not this time)
>      ++4. No (never)
>      ++....
>      ++
>      ++===== Case 3: Re-prompting when hooks change
>      ++....
>      ++$ git pull
>      ++
>      ++The following hooks were updated from remote `origin` ($ORIGIN_URL):
>      ++
>      ++pre-push:  $GIT_ROOT/pre_push.sh
>      ++
>      ++If you wish to install them, run `git hook setup origin`.
>      ++
>      ++If you wish to always accept hooks from `origin`, run `git hook setup --always
>      ++origin`. You should only do this if you trust code changes from origin.
>      ++
>      ++To always ignore hooks from `origin`, run `git hook ignore origin`.
>      ++....
>      ++

That alternate security model I suggested above would make this much
less painful. I.e. you could say "I'll trust updates as long as the
whole chain is signed by XYZ authority".

> [...]

Snip the rest of the doc, which as noted I've god unreplied-to feedback
on in https://lore.kernel.org/git/87im5nzbe6.fsf@evledraar.gmail.com/
