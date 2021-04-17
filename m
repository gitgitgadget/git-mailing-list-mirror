Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8741FC433B4
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 01:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A5AE610FC
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 01:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbhDQBH4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 21:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbhDQBHz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 21:07:55 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB0DC061574
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 18:07:30 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id r9so44601404ejj.3
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 18:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pt5tqLkDnz+V+HaDj2y/eJL4yJanf+F2uMN6I3+5FLg=;
        b=i1DcSRlOPQUrweFtCkFrLXtSgAN/Ph/hxCyvx/wmGv3ZTeATqguPzWrTa6QScLTBzO
         sGOMQla4gbxqm4YfHpChdmZ44sI4NPlVaYqwclLsEzRRjucDZVo46/GCBx+cm24YbOmK
         C1+th8zmf+Tl49hn6YG+POjz0Ib3EscqXCgbTUO5msODjAqGiInkRQBHzpzuXsVrlQ5z
         ZofUaikUP9/Jw55n9IErBUl6J1S6keA+MsTfdsGMNBJgUgYcvXVSiHA4BStwFqVlfFEZ
         Tj5vB6QDS1D6z1kN1xWJC/gBsVbvhqD23Qzn2UEiytvSQAtJjMec+RYe1uydLyE67oLZ
         lWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pt5tqLkDnz+V+HaDj2y/eJL4yJanf+F2uMN6I3+5FLg=;
        b=bV0WBRNzb3Q/Pr1dlSlpuUiPRcRxsgBC/QMk05loBFkBZPzc/HRaUA8qnrPwhta9f9
         Zgi0v7So72ZAj7HxieSzQXIQuMYuhOGGM9maUQFCtUQCreBJveQy9gYEQk3QRR3qpr/t
         3w4ol3NdX04LR7r5SYFzv5DbRX9hF51szWTJEohcSaOVLY8tor/Q1genBCkjrzJZkXY9
         ZU6ysfYWDtIAwlasRTEVkEiA6QOyN7xV1BQ52dg8Mzieb/Xc3zDdzIGTsWiE5ytgWz5X
         ggvkh5H5R1GqefIwU6p0p8uYftIxkO9wvO1+Nxp+MFslluLIJWAUyCeN8akpoNKMboKU
         7IQg==
X-Gm-Message-State: AOAM531oEJOJPqZyvUuZQHcldmFzkTtfy0RkfIlkX/Bj6uWtBSJQHjHc
        UgFUhAuchYFFdBuwk2yzfJpWAt0U7Kna2DVCXVYxZg==
X-Google-Smtp-Source: ABdhPJwYtbmUeVhRPJk4CHZmFC846eKO5CaWC5CVlytSYfBzeJdYjW3vDgaoPcDVy4sIwhwU25v7V1oEJqr96hDdoWY=
X-Received: by 2002:a17:907:217b:: with SMTP id rl27mr10949552ejb.359.1618621648773;
 Fri, 16 Apr 2021 18:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210417001525.19960-1-jerry@skydio.com> <xmqqzgxxivrb.fsf@gitster.g>
In-Reply-To: <xmqqzgxxivrb.fsf@gitster.g>
From:   Jerry Zhang <jerry@skydio.com>
Date:   Fri, 16 Apr 2021 18:07:18 -0700
Message-ID: <CAMKO5Cutas2BM_CTHTJs_O9NSp2Vyn-bK0jV0K758eq5M6-Oag@mail.gmail.com>
Subject: Re: [PATCH] git-rev-list: add --exclude-path-first-parent flag
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Ross Yeager <ross@skydio.com>,
        Abraham Bachrach <abe@skydio.com>,
        Brian Kubisiak <brian.kubisiak@skydio.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 16, 2021 at 5:45 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jerry Zhang <jerry@skydio.com> writes:
>
> > Add the --exclude-path-first-parent flag,
> > which works similarly to --first-parent,
> > but affects only the graph traversal for
> > the set of commits being excluded.
> >
> >    -A-------E-HEAD
> >      \     /
> >       B-C-D
> >
> > In this example, the goal is to return the
> > set {B, C, D} which represents a working
> > branch that has been merged into main branch
> > E. `git rev-list D ^E` will end up returning
> > no commits since the exclude path eliminates
> > D and its ancestors.
> > `git rev-list --exclude-path-first-parent D ^E`
> > however will return {B, C, D} as desired.
>
> It is not clera why you want to have this, instead of doing a more
> obvious "D..E^".  Even better is "E^..E", which is often what you
> want when viewing a history like my 'seen' that is a straight-line
> into which tips of branches are merged.
My motivation is to find the point at which a release branch forked off from
a main branch, even though the release branch could have been merged
into the main branch multiple times since it was forked off.

If we add another merge from release to main, it will be more clear
that those give different results:

        -A-------E-F-main
          \   / /
           B-C-D-release

`git rev-list --exclude-path-first-parent release ^main` returns {B, C, D}.
I've added commit F to show that we don't necessarily have info on E,
there could be many commits between it and the tip of main.

`git rev-list E^..E` returns {E, D} only, it depends on us knowing E and
loses all the commits after a merge from release to main.

I could do `git rev-parse (git rev-list --first-parent main
^release)^` and I'd get
A, but then I have to run `git rev-list D ^A` to get the set {B, C, D},
whereas the --exclude-path-first-parent invocation gives exactly
what I want in one invocation. I'm sure there's more use-cases
I'm not able to think of.

>
> E^..E (or doing the same for any commit on the mainline in such a
> history whose first-parent chain solely consists of merges) would
> show the list of the commits that came from the side branch that was
> merged, plus the merge commit, where the committer who created a
> merge would hava a chance to give a summary of what happened on the
> side branch.
