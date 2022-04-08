Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0695C433EF
	for <git@archiver.kernel.org>; Fri,  8 Apr 2022 11:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbiDHLvx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Apr 2022 07:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235144AbiDHLvw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Apr 2022 07:51:52 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFA424A
        for <git@vger.kernel.org>; Fri,  8 Apr 2022 04:49:48 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id k23so16815533ejd.3
        for <git@vger.kernel.org>; Fri, 08 Apr 2022 04:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=pKKlKeoU/PrPj+gMnKNu6z38TAFOmx+5xeeFVLwEqNg=;
        b=JlOm7p3b4DPpAdIkz3OnljB4+8hEEdHU1yuTGLbdHmN1iY/oekZNnCxdFn7T66Dprd
         ZQ5YO8WVgl35yhve8TSafS3pRrAyDWMRut+PBXRL34G/opXpSOk7fZ9hW+YyBw/nlSuw
         G9LhvCi/d56zNFzpBgccVKARrRmXs4qXznvP7VTWdfSUo3BmqxKNWUGEiB9oidwK+HC0
         ExA+1blcJPlYn2qv1zfZW6rgSkJTNs25GBoJbh1o+ssGpPmvNk5w1IWRqVh2NNVdLUPS
         NzB5RRDqICVJiRs9M7PRZvHWSCkqgwSTnwbbk3+yKM8a5Cp7AE+UYYKAHnEcEws12aMV
         TlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=pKKlKeoU/PrPj+gMnKNu6z38TAFOmx+5xeeFVLwEqNg=;
        b=J+LoiEH9YEUGfk/gB8YEH7AI7ReG5NkdqkF5RkV0HFD7Ob5TTd/HCmx5761W5PRl8W
         vcLaB+KRiENv2k1OeVV6DilW9tc+JLkzvr9MZe7P/mmpu3BQ2msuqfLHhw31TglERuS4
         Fm7lQL41+bty8LP0XrUosMG/yWoYK+wJwYgvHSGi4c1nU+JUaseUj712Q5bGB045reZ7
         pxBFvgo/Q+f/kiwX3BDznYfp2yD+cUYOcS1tUOSF57T57uwiaE72FYBn2vvlBUqj6bWa
         WsFrEPD1RTL88VTprM/Iv+29KwPQq66SK4CVyRFh4jn2ywDEBDF3kFHK3G2IWLNlLJAi
         SIxg==
X-Gm-Message-State: AOAM531j4tSPkUAhfvbpzufrjjcRPWohWKfOEA6ZfWtTIklupxXbT0w/
        Vu5oyQcDl9gqrW7E7k5jB80=
X-Google-Smtp-Source: ABdhPJxBSgqPSE7c+H0u5UrIg9y0baCSdyBG0PwN0EP48mVF3e78yyaTCCAUvB/Wb2nDL8z0TAr3Cg==
X-Received: by 2002:a17:907:6d07:b0:6e7:979e:9c0a with SMTP id sa7-20020a1709076d0700b006e7979e9c0amr17706682ejc.614.1649418586906;
        Fri, 08 Apr 2022 04:49:46 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z1-20020a170906434100b006e7efa329fbsm5704647ejm.109.2022.04.08.04.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 04:49:46 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ncn7Z-001KGv-Ml;
        Fri, 08 Apr 2022 13:49:45 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     jurgen_gjoncari@icloud.com, git <git@vger.kernel.org>
Subject: Re: Make commit messages optional
Date:   Fri, 08 Apr 2022 13:26:40 +0200
References: <7ED89912-2E10-4356-9C61-14B90EC0719C@icloud.com>
 <CAP8UFD2Tk-FuGcFN0DEKK6g3O8G=SGuU99FPRRqPM_-39i9t0A@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CAP8UFD2Tk-FuGcFN0DEKK6g3O8G=SGuU99FPRRqPM_-39i9t0A@mail.gmail.com>
Message-ID: <220408.86r167bxra.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 08 2022, Christian Couder wrote:

> On Fri, Apr 8, 2022 at 6:10 AM <jurgen_gjoncari@icloud.com> wrote:
>>
>> I think that often commit messages are unnecessary. I propose that by default a user should be able to commit without a message.
>
> We prefer to encourage users to do the right thing by default and
> provide a commit message. We think that good software development
> practices should be encouraged and that providing a good commit
> message is good software development practice.
>
>> I don't think this would be a problem from the UX point of view,
>> because a user could get a lot of information about a change, from
>> the history of the GitHub repository, such as from the time of
>> change, and seeing the diff.
>
> What about `git log --oneline`?
>
>> I think that making commit messages options wouldn't even be a problem for retro compatibility because the feature would remain still functional for those who would want to use it.
>
> Yeah, there is no compatibility issue because `git commit` already has
> an `--allow-empty-message` option, so empty commit messages are
> already supported. That's not a good reason to make it the default
> though.

I agree that we should do away with the check for the empty commit
message.

I also added --allow-empty-message in the first place, so I'm a bit
biased.

Now, anyone who's seen pretty much any of my commits knows I don't have
much of an issue with writing commit messages when it matters.

But to get around this requirement of git I've got a local alias that
basically does:

    git commit -m"$(line from http://whatthecommit.com/)"

I could use --allow-empty-message, but I think at some point we still
had tooling (git am?) that was annoying to use with it, so I settled on
that "solution", and muscle memory dies hard (I've got a short alias for
this thing)>

In general I wish git were more helpful and less opinionated. It's fine
to have sane defaults, or to help users, but e.g. this case I think was
always better handled with an advise() or something.

Git is also used in a lot of contexts that aren't "normal" software
development, e.g. the "gist" feature on GitHub creates commits without
commit messages.

Now, of course they know about --allow-empty-message, and users *can*
find it too. But UX friction is like taxation, you add friction where
you want to discourage things, and sometimes users are discouraged
entirely because you've added that cost. After all you probably know
better, maybe they shouldn't be doing that with the tool. Or they never
check that it *can* be done, and just stop because it's erroring by
default.

But even if git were only used for software development I think adding
this friction *there* is entirely misguided.

It's perpetuating the notion that there shouldn't be a disconnect
between "what you commit" and "what you push".

I think one of the best things about git's design is how in most other
areas we've really leaned into that design ethos. I.e. you can commit
whatever train-of-thought garbage you want, but we make it really easy
to interactively rebase all of that before pushing (or "finalizing") it.

Which, as an aside is a notable difference to the fossil SCM system,
which heavily leans into the exact opposite notion. I.e. that thou shalt
not alter work already committed (even if not "pushed").

So I'd really like to see (from someone who's got more interest & time
to work on this) some change to this default limitation that steered
users more towards use cases we actually care about.

E.g. I wouldn't mind if we made pushes start failing (probably guarded
by appropriate isatty() checks) if the user was pushing content without
commit messages, unless some option were overridden, or we could start
sternly warning about that. Ditto for merging a branch into another one
(especially if we can see it's the default branch).

All of those things would actually have some hope of aligning with what
we're *actually* trying to encourage.

But doing this at the point of commits? I think it just amounts to some
misguided rear-guard action, and it's actually doing more harm than
good.

We're encouraging users to think that there's a 1=1 mapping between
commit message and time of commit/snapshot. If I had to pick one thing
that's the difference between a beginner novice git user and someone
who's an intermediate/advanced it's knowing that there's a disconnect
between the two, and using it to one's advantage (i.e. rebase -i before
pushing)>

All that being said I think a perfectly good incremental step would be
to make --allow-empty-message the default, and just replace it with some
advise() instead.

We could even emit such advise() e.g. if we see the message is shorter
than some length, or if there's a big delta between commit message
length & diff length. Both of those things would be a lot easier than
the suggested "error on push" above, and wouldn't require revision
walking, just a small change or check in builtin/commit.c.

But of course any such changes would need to get through list review,
and I know there's a lot of people who feel quite strongly about this in
the opposite direction.

But I'm also pretty sure that those people are engaged in a proxy war,
and we should just attack the "problem" directly instead. I.e. it's not
a problem that some commit somewhere has an empty message, rather it's
that such a commit gets "propagated". A better place to check for it is
then at the point of point of propagation.
