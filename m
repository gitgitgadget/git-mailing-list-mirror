Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5ACBC433FE
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 15:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbiKDPds (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 11:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbiKDPdW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 11:33:22 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7870C303E4
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 08:33:19 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id s10so2206235ioa.5
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 08:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JyPcM/Qf/1TdDbV341E0LAFN1i/OxDlCrVok5yX+UBc=;
        b=Ke7Oc+pExNfGDPis58+bAr8P4vcYfltW+XWObt0UTNjOavvNm0mg8pk4or9Qc3acfF
         kyV2VyuicY2VAJ/lMDHgbFnTscp5RvFiSRy+icHaFgbY+ZmtqNQLEnPNgd1VswiHXWMs
         PXVhgX7CaNXo1xpAJVXeYuDyPRdCxDNYP9Mb2XtG5n4N/LNYzO8dVROwbq5j3llBQPbw
         tmxh/T0kZjUn6tp8UPl0OljQyM5vCETmuCYUybOg9U8mcMpO9gDenfwRnluh+hGosll3
         /tC+M03tCTuvVXk2KcdFRzkUTco3ODECMjpVui6G7yPfM8Cbg19SY+zu17x8lf7NA2q8
         x64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JyPcM/Qf/1TdDbV341E0LAFN1i/OxDlCrVok5yX+UBc=;
        b=Yy0RoHIxoGn5UAWDYv+JCdWjSxBZ5/h7gIr+cOeWuWE3BUfWP/q/jGm47qR/tigCNe
         pcyjL6mve0zq1mDclKqAvGfkWWX/DawhpQ4DYdm8E5SThjHJWogE48JBwp641NTZXG36
         BYtxSM+qKUnUZbBWvmZ7PViGr/iz2R++hqnyOwUHZRZeqmaqxbHwM/hsdOjJlpZcXJ49
         mdZL4JfW+KeTDuS+nSmoMi/kDvY50Fyk2SlXAcnopBG08znElG7xbZrikI9ETY+kcGNm
         sXJ97FLU9SzMFTtKRpeGb3LJPsivYIKl08kYumQ2dELrzU/B+3MjXFivO80r1sSQYcf/
         59Dg==
X-Gm-Message-State: ACrzQf1jO8GHbvcTpcQgeCstZCG/ZwIrSmyaknGK1Bqf3+YfHzcwwReS
        idvVsgjJnObVyyABPzUWsyTffKceUQIBSCrJ7yqfe4Dbz5A=
X-Google-Smtp-Source: AMsMyM6ktueik9IB5YBQTBORNDE9/Uk2Y3iug7wfZhf23V/KFwUfCWu+JWezSLUYCFRVb3xkI5q9UFhtA20KKrOBagw=
X-Received: by 2002:a02:3c18:0:b0:375:7ddf:64e2 with SMTP id
 m24-20020a023c18000000b003757ddf64e2mr9245978jaa.133.1667575998567; Fri, 04
 Nov 2022 08:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1384.git.1665839050813.gitgitgadget@gmail.com>
 <pull.1384.v2.git.1667002005494.gitgitgadget@gmail.com> <8abc5272-4e01-e793-5155-ea116e9ad4fd@jeffhostetler.com>
 <Y2MEXyhh2cJ14ba9@nand.local> <CANaDLWK6-KkfKP0mipuWccfQFacDWsLHFNjS7ogL_xWvvmrCfQ@mail.gmail.com>
 <221104.867d0byu5e.gmgdl@evledraar.gmail.com>
In-Reply-To: <221104.867d0byu5e.gmgdl@evledraar.gmail.com>
From:   Rudy Rigot <rudy.rigot@gmail.com>
Date:   Fri, 4 Nov 2022 10:33:07 -0500
Message-ID: <CANaDLWLNMjUsetvsc9_b9GfM0qEQnETJ7TQhRL8Y3K6JSqQEzQ@mail.gmail.com>
Subject: Re: [PATCH v2] status: long status advice adapted to recent capabilities
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Rudy Rigot via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> One thing that I find glaringly omitted, which since you're working on
> this you might consider adding: Suggest to just try running the exact
> same command again, maybe it was just the FS cache.

I have to admit that would be by far my personal preference.


We've been having a number of very great points made by several people
on this thread, but a number of them contradicting each other across
people, and yet clearly nobody's wrong, everybody makes very real
points. I'm trying to turn this into actionable changes I should make,
but I think I need guidance on that. This is my first ever contribution
to the project, so I'm lacking the organizational awareness of the
project to be able to drive this to a consensus on what we should do.

Here's a proposal that tries to make opinionated moves towards what
I understand to be the priorities that were expressed:


1- We keep the new paragraph doc, because I'd say why not, it's
well-written (thanks Jeff!) and useful. When people are looking for
ways to make git status faster, it's good that there's a reference
about it, and I'd expect it to be a common need across all kinds
of user situations.


2- When untracked cache is not on, if I understand =C3=86var's suggestion,
it would say something like:

> It took %.2f seconds to enumerate untracked files.
> Try to enable untracked cache to see if it helps make it faster
> for you:
>    git config core.untrackedCache true

It would satisfy that the message gives concise advice with actionable
next steps, without making assumptions about whether it will or won't
work. (Untracked cache alone did not make much of a difference in our
very large repo's case.) And it doesn't point to the help anymore, in
order not to saturate the user with too much detail.


3- When untrackedcache is on but fsmonitor is off, and git status is
still slow (that's the situation we had on our very large repo), it
could say something like:

> It took %.2f seconds to enumerate untracked files.
> Try to enable FSMonitor to see if it helps make it faster for you:
>    git config core.fsmonitor true

Same as before, concise, no assumptions.

This setup is more advanced, but we are in a case where untracked cache
is not helping, so I'm thining that should be very few repos.
If the user feels a need to better understand what's up, the feature
is mentioned by name, so they can look it up and dig in if they wish to.


4- When fsmonitor is on:

> It took %.2f seconds to enumerate untracked files.
> Your runs are being cached, try running git status again to see if
> it's faster.

Same as before, concise, no assumptions, and matches =C3=86var's suggestion
above that was also my preference, as it would apply perfectly to our
very large repo's use case and the grievances we've received.


Please let me know what your thoughts are about it all. A downside with
all that is the option to disable untracked files is not mentioned at
all, but if we keep the doc as it is, and it gets painful enough that
they search for other ways, I'm hopefuly the user would find it there.


I want to say it again: I'm not very opinionated about any of this,
just trying to collate feedback into an actionable plan. If I understood
feedback wrong, or my plan is not the best based on the feedback, that
is very fine, but I will need guidance to know what makes more sense.


> the untracked cache is
> pretty much an unambiguous win (we should probably turn it on on
> default, but we'd need to check on-the-fly if the FS supports it
> properly).

I could take on the work to make untracked cache on by default after
this, as another patch, if it sounds relevant to try. I feel I
lack the technical understanding of what we need to check that you're
mentioning here, so I'll have questions, but I'd be on board with
trying.
