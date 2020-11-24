Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFB5C2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 07:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72F9920715
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 07:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G01fazl/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbgKXHtK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 02:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgKXHtJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 02:49:09 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F54BC0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 23:49:09 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id 23so21232338wrc.8
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 23:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3iXyKOrjRwuOpFFl8O+d0AeAhRsGOy0DQslScDG2rHQ=;
        b=G01fazl/JbctyU3HMRIuRVLpjVXFREOKeCkzY6DshWMnEVAmEIok+4/xBM/D7J/GM7
         RQonRTGmEuGM4NO687WBcJptYX0TMB6WhRhMFCqxPrE6mEA3zSUn7/rjt+4DMaUe/9rS
         Ws1kcCjjAisbIhbL7cFxncLmxR6f2MXfBYe5LIf6RaZWfB3C8CE5CnO9tRfQPnV9Fd8G
         3Pi/iMizE4Tecz2Xq3yBQbyZaZE6zUqyVdnnG6+rM2UtLHqeq4dotpHqXA8hn+gLJskN
         uJqcf1UO6bdLBmYqRjXVrngcDjczkyNW0suou75Mhm8fidb12/nc6HgIQLaP+RxvVE1p
         5m4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3iXyKOrjRwuOpFFl8O+d0AeAhRsGOy0DQslScDG2rHQ=;
        b=TJgXZaMjgU5ciT4yzs68Lg7FA44WpgcmctMEEb3/wBN3mdRwMJaZsQp9PXaAKrIjvz
         Vcrua/z3UkJcfQBvr+DaCwLm2gK7oqxlIitAENfe+SVu1JFmItcREGruUGhvWA+SNJgO
         wZSZQ7IRd7d/s2TEGT9lRILQYXeq2qdOpQzAYAWA95KHvs4ntUCRlZUQVImMFHp7eMj/
         1nmBBMs0F9FeeCLzFGx78mTmiAdhBhsadcfHiMvwQeHL2W/ApFtEHfeAWnAXJFAYM+JY
         t/rjysaKl/XPfVxW+33wPtX0LLUBIp3l3TLCKzRhFj7Djif52+hsfU63rJ2C+8Q9dtSp
         Fz+g==
X-Gm-Message-State: AOAM533pwvqDRyQhceXf0vH4wBVhle3QQyd1nS/lUy7Al5eU6DfULdql
        pZP9e225d1tGcrZXJtYpDC3Pt9I2EyW4CfBbtUM=
X-Google-Smtp-Source: ABdhPJwwiNmTeqYVWdedGABWr/RXE0jx5Z5SbpWHLIueZzl1PYS2WiWyrSwaBVYyr6g7YT5sk541fhkrJROBDmnwQdw=
X-Received: by 2002:a5d:474f:: with SMTP id o15mr3703338wrs.100.1606204147740;
 Mon, 23 Nov 2020 23:49:07 -0800 (PST)
MIME-Version: 1.0
References: <20201123202003.GB132317@mit.edu> <CAMP44s27oEjScrJjeDVoNcWcvRsn173L_Kx+TOPfchOwge9zUQ@mail.gmail.com>
 <X7wuMvHRURK1QS/Q@coredump.intra.peff.net> <CAMP44s0QOcMnYQqFFSE1jV_T6=e4=xTM0zr_06C6+aYb7oqb4A@mail.gmail.com>
 <X7xWSs3/vVqKl6sK@coredump.intra.peff.net> <CAMP44s1Z4tDXO4jstGMtYVOYzkQQnZMHp45pYPOimk+=jwFHcw@mail.gmail.com>
 <X7xgow4pchnhf2iY@coredump.intra.peff.net> <xmqqy2irjy4f.fsf@gitster.c.googlers.com>
 <X7xw0xb9UnGKbS8m@coredump.intra.peff.net> <CAMP44s08mEyYqbjOeTeS46CngrbQMqP2=cMr1dtRLLk_BLAq3w@mail.gmail.com>
 <X7y0GbBQa0a5Alh0@coredump.intra.peff.net>
In-Reply-To: <X7y0GbBQa0a5Alh0@coredump.intra.peff.net>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 24 Nov 2020 01:48:56 -0600
Message-ID: <CAMP44s31OqnRnMO3bcO43VyUCP27o8UGPA5ognGi1s8Se+CRiw@mail.gmail.com>
Subject: Re: Pick the right default and stop warn on `git pull`
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Alex Henrie <alexhenrie24@gmail.com>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 24, 2020 at 1:19 AM Jeff King <peff@peff.net> wrote:
>
> On Mon, Nov 23, 2020 at 09:41:05PM -0600, Felipe Contreras wrote:
>
> > What we really need is something like:
> >
> > 1. git pull # fail by default unless it's a fast-forward
> > 2. git pull --merge # force a merge (unless it's a fast-forward,
> > depending on pull.ff)
> > 3. git pull --rebase # force a rebase (unless it's a fast-forward,
> > depending on pull.ff)
> >
> > Therefore, what we really want is "git pull --rebase" *ignore*
> > "pull.ff=only" (a possible default) or ignore "pull.rebase=ff-only"
> > (also another possible default).
>
> Yep. After reading the first half of your mail, I started to respond
> with the exact same thing. The key thing is letting the command-line
> options override all of the related config. But I guess after reading to
> the end that you don't actually like this. ;)

Yes, the command-line options should override the configuration, and
the configuration should override the default.

I'm not sure what makes you think I wouldn't like that.

> I do agree it would be more clear in the long run with a single option
> (config and command-line) that makes it clear the values are mutually
> exclusive. I'm just not sure if it's painful to get there without
> breaking compatibility or introducing confusion in the meantime.

I think it is possible. I did the patches several years ago. And I'm
working on the patches right now. We'll see.

> > It would be possible to do something like:
> >
> >   if (!opt_rebase && (!opt_ff || !strcmp(opt_ff, "--ff-only")))
> >     turn_default_behavior = 1;
> >
> > But then how would we distinguish between "git pull", and "git pull
> > --no-rebase" (aka. "git pull --merge" / "pull.rebase=false")?
>
> I'm not sure what you mean. We can tell the difference between those
> based on what we saw on the command-line option. I.e., your
> "!opt_rebase" is really a tri-state, which allows something like:
>
>   if (opt_rebase == REBASE_UNSET) {
>           if (opt_ff == FF_UNSET)
>                   opt_ff = ff_default; /* from config or baked-in */
>           }
>           opt_rebase = rebase_default;
>   }
>
> but I didn't look at the logic in git-pull.

Well, in git-pull there's a callback called: parse_opt_rebase(), and
if no argument is passed, then it returns REBASE_FALSE (0).

The rest of the code assumes 0 is no-rebase (i.e. merge).

There's no REBASE_UNSET.

Granted, it may be possible to change all the code, introduce a
REBASE_UNSET, and make it so 0 is not REBASE_FALSE, and so on.
Additionally, the code that deals with the configuration part needs to
be changed too.

I'd rather not.

> > This is just too much unnecessary complication There's no need to
> > entertain a dozen possible heuristics to avoid "pull.mode", none of
> > which avoid breaking existing behavior.
> >
> > Let's just accept we need push.mode, and then we can have everything:
> > default, ff-only, merge, rebase.
>
> I think it could be possible for the documentation to make clear the
> interactions, especially if the feature is designed with eventual
> deprecation of other options (e.g., if it says "pull.mode=ff-only" means
> that pull.ff won't be examined, and there's no need to ever use it
> anymore).

I'm not sure there will be no need for "pull.ff". Even with
"pull.mode=ff-only", you should be able to do "git pull --merge"
(should override the configured mode), in which case pull.ff will be
considered (and maybe in "git pull --rebase" too).

Regarding the documentation; I think it should be possible to describe
the interactions clearly, but as a sequence of overrides, and when no
override is specified (default) do something sensible (which right now
it's quite complex to determine).

Cheers.

-- 
Felipe Contreras
