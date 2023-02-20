Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930E0C05027
	for <git@archiver.kernel.org>; Mon, 20 Feb 2023 08:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjBTIDo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Feb 2023 03:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjBTIDn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2023 03:03:43 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9F8BDCF
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 00:03:41 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id h32so1383659eda.2
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 00:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tU3S1x/U9VghluBTkhuLy8OHPYdkydAuIDR3w95h3Z4=;
        b=LvXadSSD4ZtnOlSDSQjazV/u72EiHCpHIDP/2VR6UiAn/vBlmMpXZi+AJcCxro+DOf
         T7rPxwHXu7B91acEjWmD6cUm0a98vwdH4fhQrZA9HHqt42kzM0SCnu1YAGvcWS2XSZ9N
         olXbglhOleR/qcd39xHGVghEK5bAfwfKrTBMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tU3S1x/U9VghluBTkhuLy8OHPYdkydAuIDR3w95h3Z4=;
        b=3SaxW+OtuuSWooXF8Tx5ZCWJJVFsydRIKjQK5wsIVnxO5oM54x82TYPV0feg9NpIxN
         KDzatnb7tqRSuDoUSuV798zwXu3EJ5r3aR0xJsL6RO8JibTWyinIK3Gfo37dPEdIgz/z
         wVMcELkOFsHlPkj1GafD32jDR4sac9XQvZs4gAW00GGuwL7dePhQp54VbmKRZEcxuPfe
         4fZpK/3O9NKEPwxYNw/fyngND7uo3Tl+1zgixyi6hCIwhvBMm6v7zklxrgcArF8WpRTn
         KFixoE8WtRNhQI//66lNlD1kNH5Ta1HKUKy37xBHSFX6HPhg7hAeUtC31E+zH+4ulYot
         aevg==
X-Gm-Message-State: AO0yUKVzX/mlwV3uXnF1R4M3mqVvTOD982WeW9T/7pCkWhR0bLPa6ZbI
        lu4s6pXyqlXcK2XDfbjiEs2nhDJleprYFfLdbqS4Pw==
X-Google-Smtp-Source: AK7set9dC8dj+PrJDsUnmIR8h6sviUgS3NIZ/t7CthcXvXGfGKk10ixUVI976+KISrpneyKykVvUTTSHuTb+3LPRnOY=
X-Received: by 2002:a50:9b18:0:b0:4ac:b442:5a4b with SMTP id
 o24-20020a509b18000000b004acb4425a4bmr1070100edi.0.1676880219476; Mon, 20 Feb
 2023 00:03:39 -0800 (PST)
MIME-Version: 1.0
References: <pull.1474.git.1675614276549.gitgitgadget@gmail.com>
 <CAMMLpeTPEoKVTbfc17w+Y9qn7jOGmQi_Ux0Y3sFW5QTgGWJ=SA@mail.gmail.com>
 <CAPMMpogFAR6cvcR8T5fx+AoytAJ7TsPpSeOjHNzW4Gmkuq7FLQ@mail.gmail.com>
 <CAMMLpeTQ1RpsvwRdZ0G3wdvH1+LXE5tw=7Cs6Q+HxMcRU0qj5Q@mail.gmail.com>
 <CABPp-BFxGYQ_JTC5c4_S_gOK3GxWKuZ=KfvycpkBjPGyKzCJ+g@mail.gmail.com> <c3ef69e0-c37a-01fe-a40a-c2940e329793@dunelm.org.uk>
In-Reply-To: <c3ef69e0-c37a-01fe-a40a-c2940e329793@dunelm.org.uk>
From:   Tao Klerks <tao@klerks.biz>
Date:   Mon, 20 Feb 2023 09:03:29 +0100
Message-ID: <CAPMMpogi_QoGKD824JW+85v_Sgaf5d3TAd_P55YyT5NF6AUJ=w@mail.gmail.com>
Subject: Re: [PATCH] pull: conflict hint pull.rebase suggestion should offer
 "merges" vs "true"
To:     phillip.wood@dunelm.org.uk
Cc:     Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 18, 2023 at 5:39 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> On 18/02/2023 03:17, Elijah Newren wrote:
> >
> > One concern I have is that "--rebase-merges" itself has negative user
> > surprises in store.  In particular, "--rebase-merges", despite its
> > name, does not rebase merges.  It uses the existing author & commit
> > message info, but otherwise just discards the existing merge and
> > creates a new one.  Any information it contained about fixing
> > conflicts, or making adjustments to make the two branches work
> > together, is summarily and silently discarded.
>
> That's a good point. Another potentially surprising behavior is that
> when I'm rebasing an integration branch with -rno-rebase-cousins then if
> one of the topic branches merged into the integration branch happens to
> share the same base as the integration branch itself the topic branch
> gets rebased as well.

I've been trying to understand how this behavior is (potentially)
surprising - I imagine it's been discussed elsewhere but I'm having a
hard time understanding, sorry.

The situation you described is a boundary condition between two others, right?
* The topic branch could be branched from the integration branch
(potentially *after* some other change were made to the integration
branch, but not in this case) - in which case rebasing is what you
would expect
* The topic branch could be branched from the main branch (potentially
*before* the integration branch branched, but not in this case) - in
which case not rebasing is what you would expect.

If topic branched from main (at around the same time as integration),
it might be surprising that it rebases; if it branched from
integration (before that had any changes), then it is expected.

> -rno-rebase-cousins is also slower that it needs
> to be because it creates a todo list that contains all the commits on
> the topic branches merged into the integration branch rather than just
> the merges. The commits on the topic branches are fast-forwarded rather
> than rewritten so long as they don't share the same base as the
> integration branch but it noticeably slower than using a todo list with
> just the merge commands.

This seems improvable, but no worse than a plain legacy rebase (as
Alex's new patch would have it, "rebase-merges=drop"), right? Insofar
as we're discussing why it might make sense to avoid promoting this
over a plain rebase, I don't understand the concern.


>
> > My personal opinion would be adding such a capability should be step
> > 2.5 in your list, though I suspect that would make Tao unhappy (it's a
> > non-trivial amount of work, unlike the other steps in your list).
>
> I've got a couple of patches[1] that cherry-pick the merge if only one
> of the parents has changed. I've never tried upstreaming them as it is
> only a partial solution to the problem of rebasing merges but that
> approach should work well with "git pull --rebase=merges" as only the
> upstream side will have changed (when rebasing my git integration branch
> with that patch the merges are cherry-picked). They might make a useful
> starting point if anyone wants to try and improve the rebasing of merges.
>

This is awesome!

It feels like the first step towards the general strategy that was (I
believe) best described by Buga at
https://public-inbox.org/git/a0cc88d2-bfed-ce7b-1b3f-3c447d2b32da@gmail.com/
!

(unless I'm missing something, the result of this is exactly the same
as the result of that strategy, in these "simple" cases where it kicks
in)

The one concern I have with this is that, *if I understand correctly*,
it sometimes throws away the existing merge information, and sometimes
doesn't, and there's no easy way to know which it is at runtime. Would
adding a warning on stderr when a both-parents merge is encountered
(and any merge resolutions or related changes are still discarded) be
enough to make this shippable?

Are there *any* circumstances where the new cherry-picking behavior
introduced here wouldn't be the right thing to have happen?
