Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62863C433E0
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 22:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 176162076B
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 22:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KG0w3xyq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgHLWEW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 18:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbgHLWEW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 18:04:22 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07741C061383
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 15:04:22 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id n25so1907714vsq.6
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 15:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=23uDrIdPQ7jdx2jEReqaBN8tMl9nzXkP0EHG7nDSnnc=;
        b=KG0w3xyqTFlBbRtSBvTv1DrPZJ8urkLnORWTJkcemUWhUfAoIPxlvVLUpjJEPp/o0d
         BgZsruSf60bDLRrppL1j3tTKzSTXpGIhDxxXbRdsN3Opa/0OKr/fVK1VCyLvwr7n92x2
         GFj3jorbv67jLo5aQvFaygpN3CFYSu8FIdr44PntG0eC55n3j4dasSiQFh5iy60IHAmJ
         HkjnVqNXprz04s2eyfkC4QH6kbJQ1UTSavZXw9MAQv9ZTHswEOw+FIDiQUAzU5DRZ2sq
         rP/Qd5HLpu6v/6JaOaaogF+t2bcDU+sT8EqHcCkq7UYweR54sQ9TcRvsbQj9Ad08wWbQ
         IBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=23uDrIdPQ7jdx2jEReqaBN8tMl9nzXkP0EHG7nDSnnc=;
        b=NzBQSUhefHhbWrAzSdg36wopXLyARpoSJd6OeNi2PHfbLvgj1X2XoR04WAiQemeyO9
         BrRUHt5fM4Aw/hcwWO/P3NSVRs6dKY4kyepGhDSV3GmMmEgKPwzAw6JrpMk7UTeVzvRk
         dcrHToRPqMjz/c/VCvXsCH+1bTJORD/rfoHfxQFqe0sxqrs/AR8ZuwZ5b/a4mETjNjwj
         29LXmoWo5eWOHhYpnk98ZlSe3mX6Yj+/YwoVtDSaSGBgZ8ouUGq9y696pxt151f1QnR5
         Vs+8fctaLYesQxc5Xl5SEzeOrUMH1uJBR8dcdZMYTWRsF7LIkSuK0A4tscw7UTrP9uwd
         Ul/g==
X-Gm-Message-State: AOAM5329tvqLYiaPGMC2nNPRcMjewurHP3ieOjT3o8calxkBDVxinwt5
        F0iN+qVX5ynZuqobp4iV7meHfq9+fzHGA96VQQ/OGR3+
X-Google-Smtp-Source: ABdhPJzPVaIGJ6cBFAduIc5CiJiRS4pLnDagUmaAsn3Z9uD+9gpfqdhybrYLbQyj5rO78gFFpXPzoeE+OlDHZvLTkFI=
X-Received: by 2002:a67:edd0:: with SMTP id e16mr1121965vsp.153.1597269861149;
 Wed, 12 Aug 2020 15:04:21 -0700 (PDT)
MIME-Version: 1.0
References: <CA+P7+xpokJ3Z4xZ9ibCBpBO65D1v-AD6_JknprGUsEDxEvMGGw@mail.gmail.com>
 <20200805063704.GA2690083@coredump.intra.peff.net>
In-Reply-To: <20200805063704.GA2690083@coredump.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 12 Aug 2020 15:04:09 -0700
Message-ID: <CA+P7+xp5aRWV0udmf03+ox4+8nCOmXtfEckmhJrAs-42Tomn0w@mail.gmail.com>
Subject: Re: avoiding fetching specific refs from a remote
To:     Jeff King <peff@peff.net>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 4, 2020 at 11:37 PM Jeff King <peff@peff.net> wrote:
>
> On Tue, Aug 04, 2020 at 02:53:30PM -0700, Jacob Keller wrote:
>
> > This results in the annoying completion behavior where:
> >
> > $git checkout ma<TAB>
> > main
> > master
> >
> > Essentially, because both main and master have similar names, tab
> > completion requires remembering to type one additional character than
> > I am used to.
>
> Heh, I didn't think anybody considered that implication so far; the fact
> that they were similar names has generally been considered a positive. I
> agree it would be annoying.
>
> > I'd like to be able to customize my pull so that I either (a) exclude
> > the reference when performing a fetch, or (b) exclude the reference
> > when tab completing.
>
> Not quite (b), but if you:
>
>   - delete any local "master" branch, if you haven't already
>
>   - set $GIT_COMPLETION_CHECKOUT_NO_GUESS to "1"
>
> then it shouldn't complete "master". The second is necessary because
> we'd try to complete the magic "git checkout master" that auto-creates
> the branch from the remote version.
>
> > something like adding a remote.<name>.excludeRefs which would allow
> > specifying a set of references to exclude from matching the refspec..
> >
> > I realize I could customize the refspec to list the set of things I
> > want, but then I would miss any potential future branches until I
> > updated my remote config again.
>
> This is definitely a reasonable thing to want, and it has come up off
> and on over the years. One search term for the list archive is "negative
> refspecs", though it turns up a lot of useless hits when the two words
> are not directly adjacent.
>
> This old thread might be worth reading:
>
>   https://lore.kernel.org/git/20140124090104.GA396@x4/
>
> and there is even a patch in there:
>
>   https://lore.kernel.org/git/20140125013433.GA22336@sigill.intra.peff.net/
>
> but I didn't go over it carefully enough to know whether it is utter
> trash, or something that could be used as a starting point.
>
> -Peff

I dug up the patch and have applied it to master. One concern I have
is how do we tell what side the negative refspec applies to? It seems
like we'd need to be able to distinguish whether it applies to the
refname on the remote, or the refname on the local branch. The patch
as-is assumes that negative refspecs only ever have "src".. I guess
for fetch that means the name of the ref on the remote, and for push
that means the name of the ref on the local end?

I was trying to modify the patch to add support to the push code flows
so that it was more complete and could be submitted. I'll be sending
what I have as an RFC soon.

Thanks,
Jake
