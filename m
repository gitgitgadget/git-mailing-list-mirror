Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A074C433EF
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 22:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1181661139
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 22:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236785AbhJEW1q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 18:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236697AbhJEW1p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 18:27:45 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47069C061749
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 15:25:54 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b9-20020a5b07890000b0290558245b7eabso698863ybq.10
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 15:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=7C8T/y5WYuJe4PhZ3EF02mVyA8JqZkDbefy25PYFezw=;
        b=svMlAeOcTHJPaI6969zDLkqR5huvIysyaORVGY7ngPPMDUuffiRnkojjzoRkJQERnv
         cbzauWx2OWGzHWU3uOEISa+WwGxEGsrDV5U1oILPuCQl50/2SrTtH5ylAtAw5Gy40niS
         aO+ak6/Wkeh34ynxjaI5heuiUBMODyMOiDDuccXBaNHQihAJbPSWXQg054Y5KWmk9tbv
         ZkKIQma6JI+KWSx/sOQJb3Aiy6NziLSYEt5XMei6wGgF4IL2dyXjdBY/8ZFmKkYn5o26
         IICaY86SWHCFAL3m98W+iULibaVyIWjdWa0UNSTzSmcNcFvEnArnbIuvZ8HZfzYTxWrN
         zEww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=7C8T/y5WYuJe4PhZ3EF02mVyA8JqZkDbefy25PYFezw=;
        b=kaDAeCftWCPzmTUz5K2NShAn7hwCw8FFVwRKt47daRvhV6xfbNu+ThY2PCfZQmeq1d
         s0Fg8EOe02JjpoYQKWxMzVmpAxXxvu8cXuhiOCJ4ourWWOM8LCvHR6E9RbnNdJi+3ENV
         CPZiVJaMs5TqfyxPmpe/i+t2+fV+0gCKgVV1lMPSnagO3YyYFVFRlogzcHQ2v6158Vm1
         31DQJccUylvlIZWQ+ev4htZi3dZ9zy1zkKIRrn7Fwa3nk4Pc88QLkjfJuIb5hMaBDY5m
         Ppku1KAFzACkzXqiRpN/AaH+osNFOGtBswbe1dr9a+di5Af3wLrDBW9lSpebc8w7nJtS
         S3gA==
X-Gm-Message-State: AOAM530CVsvKHISOqUZ1lE4v9IMP3UWJiKNnSBVf75yqsTc01/ORhXGx
        h1ZHP4vV4cvpXXu8+nGIq12UOrq08m+oDw==
X-Google-Smtp-Source: ABdhPJzpQDJ39Y/B9GQiQ2aW6RuWTE5oauDonS4ufeldFZpmRemY3umsUZMORiIeD7kbMl3st04YsUeKi7rttg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:5606:: with SMTP id
 k6mr25635560ybb.51.1633472753561; Tue, 05 Oct 2021 15:25:53 -0700 (PDT)
Date:   Tue, 05 Oct 2021 15:25:38 -0700
In-Reply-To: <87lf37ll4k.fsf@evledraar.gmail.com>
Message-Id: <kl6lh7dvw1lp.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20210917225459.68086-1-chooglen@google.com> <20211005001931.13932-1-chooglen@google.com>
 <87lf37ll4k.fsf@evledraar.gmail.com>
Subject: Re: [PATCH v3 0/3] Use default values from settings instead of config
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I've looked this over carefully, it LGTM. I noticed some bugs in this
> area, but they pre-date your commits. I've pushed a
> "gc/use-repo-settings" to https://github.com/avar/git.git that you can
> check out, consider that branch partially as commentary, but feel free
> to pick/squash anything you find there.

Your review is very thoughtful, thank you :)

>  * This is somewhat of a case of throwing rocks from a glass house, but
>    I think the commit messages could really be shorter/get to the
>    point. I.e. say right away what's being changed and why, instead of
>    giving the reader an overview of the whole control flow.
>
>    I just adjusted adusted 1/3 in that direction below, I think 2/3
>    could do with being squashed into it & adjusted, it's really the
>    exact same bug/improvement, just with a different config key that
>    behaves the same.

In hindsight, I think this is how I should have initially structured my
commits because this improves the signal-noise ratio. I'll keep it in
mind in the future for sure. I'm hesitant to send a v4, but I can be
persuaded to do so :)

>  * The "test_unconfig" in your 2/3 is redundant, so is the "rm -rf" of
>    directories that can't exist by that point in 3/3.

These are redundant, but they serve a defensive purpose. By being extra
defensive, I was hoping to make it clear to the reader that the test is
*guaranteed* not to conflict with/rely on previous state and reduce the
number of greps needed.

>  * You use corrupting the graph as a shorthand for "did we run this
>    command?". See test_region for an approach that might be better,
>    i.e. just log with trace2 and grep that to see if we started the
>    relevant command. The test_region helper can't be used as-is for that
>    (you could manually grep the emitted PERF/EVENT output), but perhaps
>    that's easier/more reliable?

My intention here was not to assert "did git fsck call the function I
expected?", but something more along the lines of "did git fsck catch the
corrupted commit-graph?". Calling the function seems like an
implementation detail, but the actual desired behavior is that git fsck
catches the breakage.

Perhaps the test title should be reflect what I meant, like

  - git fsck (checks commit-graph when config set to true)
  + git fsck detects corrupted commit-graph

>  * This is again, something that pre-dates your patches, but I think
>    following the "is enabled?" behavior here for these variables in "git
>    fsck" is highly questionable. So just some thoughts after having
>    looked at that:

I think it depends on how we think about core.commitGraph (and others).
Do we want Git to be able to pretend that commit-graph doesn't exist at
all? If so, then we should skip the check in git fsck. Alternatively, is
commit-graph actually part of Git's core offering? If so,
core.commitGraph is more like a way to opt *out* of some commit-graph
behavior, but fsck should still verify our core data structures. Given
that we default to true, it sounds like more of the latter, but I'm not
sure what use case this serves.

>    Just because your config doen't say "use the graph" doesn't mean
>    another process won't do so, and if the graph is broken they might
>    probably encounter an error.

While that's true, I think that the user assumes a certain degree of
risk if they are using different commands with different config values.
I don't think it's unreasonable to say that "git -c
core.commitGraph=3Dfalse fsck" won't catch issues that will arise in "git
-c core.commitGraph=3Dtrue foo".

>    But in general for these auxiliary files (commit-graph, midix, *.rev
>    etc.) I think there's a good argument to be made that fsck should
>    *always* check them, and at most use the config to say something
>    like:
>
>        Hey, you've got a 100% broken commit-graph/midx/rev in your .git,
>        looks like the core.XYZ enabling it is off *right now* though, so
>        maybe we won't use it.  I hope you're feeling lucky...

I think "always check" sounds like the best way to maximize visibility
for users, though I don't think core.commitGraph should control the
severity of the warning/error. If we pursue "always check", I think we
could adopt fsck.<msg-id> instead.
