Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D92AC433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 05:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61B5C61157
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 05:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbhDSFzV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 01:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhDSFzV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 01:55:21 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38411C06174A
        for <git@vger.kernel.org>; Sun, 18 Apr 2021 22:54:52 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id z8so37921518ljm.12
        for <git@vger.kernel.org>; Sun, 18 Apr 2021 22:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XU3lQUdQqYI8CgmE7jJiCQ05g0t5jkmzVnBAzNf0g8Y=;
        b=B0zfvHmgHKiM8pa9h/huL72D/2RIOET6xzsdd1mEGH8DRhHHHEIdFt2R5k3iIXPgs3
         aI73qVEuVgPcazhdWR+XmmVNgS4zjkcah3qEKSFoivs1g/SidgtQ/xu3cG2N94MPdV3N
         y4A6DnQhdHyDEGHUtrnoDl/YdiqmUm5Ywn3GYcReKzmNOGHFjOSyqO4C0JVCvWPmsVun
         zGuaxST0kzA8X6a+6K4QjEhdmoUM1ZHKWs3QdGk1hg2Lr9shwqeQjGpHKdG0Zda9/Drn
         fgrWvKqakkxHHdgp+YKJKaOOI2t6EJjlTGzUOmb9Of5Azhr9McfYm0m4EecjvXu9CVc0
         ygxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XU3lQUdQqYI8CgmE7jJiCQ05g0t5jkmzVnBAzNf0g8Y=;
        b=CPIPDKnKctmTO50ZhKo3YdimipcZjSvNQ/EHpRYWRUhuAkkMjhWF1pexLRrVOgpjpI
         e3eEQQnseEi2A5K23D5tygDgvM40VezrAZNF18AdiIWtkpJXt3jmd+oiXpXnehiBOkRw
         1ex1vTBDMt/lq2rG/CdlNdlXE/LxxOelB+dwbUrXwqaTCDsv8WjQ6hCHZ08Fh8AMi97j
         Zg8OwO7tYK+2i89Q3cjuqjnZNW7DEoymG21qDDwJgpIE5gvTkXRBQ4qe7b+HZmgwIqrl
         kCpBzcUeMb9gNFwJVUH6OvcUufuvm8o8M4V/iJxK6URX71f0JGDvApg1qrjpA1wpKAQg
         c9vg==
X-Gm-Message-State: AOAM5304X1UEl4uHHA+e9LVQOgvhzjSv4QImmJ16OO8rWv3qWsLL7yZC
        PIytLCbdYsKEclNP3lt0BnXghOBAISxPZNCZPykTruOLCHqlbQ==
X-Google-Smtp-Source: ABdhPJw+tMag9693DOrnXjBKrmNxNqWNi2Xyi4mBEHiM5J5Z3ApH27K35pU+peFjAPGRxwCswnYkwofa0iQgrImjjuU=
X-Received: by 2002:a2e:8e6e:: with SMTP id t14mr10374565ljk.230.1618811690472;
 Sun, 18 Apr 2021 22:54:50 -0700 (PDT)
MIME-Version: 1.0
References: <YHaIBvl6Mf7ztJB3@google.com> <22a0a383-0ae1-c7d1-75f7-7dfdfe5fb504@gmail.com>
 <87fszn48lh.fsf@evledraar.gmail.com>
In-Reply-To: <87fszn48lh.fsf@evledraar.gmail.com>
From:   Sebastian Schuberth <sschuberth@gmail.com>
Date:   Mon, 19 Apr 2021 07:54:37 +0200
Message-ID: <CAHGBnuOVmzzhgW6GanHBXNb22UW3P1m3i6PJnOUEhYPO76hH4g@mail.gmail.com>
Subject: Re: Pain points in Git's patch flow
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, patchwork@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 18, 2021 at 10:54 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:

> And thank you for participating in the discussion. I think it's
> especially valuable to get a viewpoint like yours, i.e. someone who (per
> this E-Mail below) gave up in frustration with the current development
> flow.

To be fair, Git's contribution flow isn't the only reason why I chose
to stop contributing. Another reason is the very lengthy and tedious
discussions that too often spark from rather small changes.

Also, I wouldn't say I "gave up in frustration". It was a mostly
unemotional decision on which of the many OSS projects I contribute to
my rare spare time is spent best.

> I think it's important not to conflate tooling issues with social
> issues. It's not that we e.g. couldn't whip up a quick script to

I'm not sure I agree completely here, because some tools make it
easier to overcome social issues than others.

> Rather it's that it's a volunteer project and people work on what
> they're interested in.

Exactly. That's why I believe tooling should allow people to subscribe
to changes in code areas they're interested in, rather than a
contributor having to know which subsystem maintainer to put in CC
(e.g. for gitk changes). At least at the time when I contributed it
was sometimes hard to move things forward if you didn't reach out to
the right people.

> So maybe having assigned reviewers would help move things along. But I
> wonder if it wouldn't also lead down the rut of PRs/MRs languishing for
> months, because the reviewers just want to spend their time in some
> other way.

Having default assignees for reviews / code owners / however you want
to call it does not mean that only these people should review, or that
something cannot be merged without their review. It just makes it more
clear who's opinion would be the best to get, and who should execute a
"word of command" if things do not move forward.

> I.e. the design of many of these tools in this regard assumes you have a
> workforce, not the cat-herding problem of volunteers working on whatever
> strikes their fancy.

E.g. GitHub makes the distinction between "reviewers" for a PR and
"assignees" for a PR, and the former can be configured from a
CODEOWNERS file. In projects I contribute to on GitHub, "reviewers"
are used as an optional list of named reviewers, i.e. these people are
explicitly invited for a review. There's no obligation to review,
though. On the other hand, if there are additional "assignees", these
people are explicitly asked for a review. Assignees can also be
assigned only at a later stage of the review, to "settle" a
discussion.

The cat-herd of volunteers would neither be "reviewers" nor
"assignees", but they would just browse the list or open PRs can jump
it where they want to.

> I think characterizing E-Mail as a "legacy" workflow isn't accurate. All

I admit it was a deliberately provocative choice of words, well
knowing it's not reflecting the current state, to underline how I'm
feeling about the workflow. E-mail is great. Also plain text e-mail is
great (I've configured all my client to only send plain text), but
please, not for sending around code patches.

If you send around code patches by mail instead of directly working on
Git repos plus some UI, that feels to me like serializing a data class
instance to JSON, printing the JSON string to paper, taking that sheet
of paper to another PC with a scanner, using OCR to scan it into a
JSON string, and then deserialize it again to a new data class
instance, when you could have just a REST API to push the data from on
PC to the other.

> of these proposed alternatives involve moving away from something that's
> a distributed system today (E-Mail infrastructure, local clients), to
> what's essentially some website run by a centralized entity, in some
> cases proprietary.

That's a good point, I admit I haven't thought of that. Probably
because I also don't care much. So *does* it really matter? What
exactly concerns you about a "centralized entity"? Is it the technical
aspect of a single point of failure, or the political / social aspect
of being dependent on someone you do not want to get influenced by? I
guess it's a bit of both.

While these concerns could probably be addressed somewhat e.g. by
multiple independently operated Gerrit servers that are kept in sync,
I was curious and quickly search for more fitting "truly
decentralized" solutions, and came across radicle [1]. Just FYI.

> So really basic things that are comparatively trivial with E-Mail
> (e.g. "I think the search sucks, try another client") run up against a
> brick wall with those tools.

Not necessarily. As many of these tools have (REST) APIs, also
different API clients exist that you could try.

> And to e.g. as one good example to use (as is the common convention on
> this list) git-range-diff to display a diff to the "last rebased
> revision" would mean some long feature cycle in those tools, if they're
> even interested in implementing such a thing at all.

AFAIK Gerrit can already do that.

--=20
Sebastian Schuberth
