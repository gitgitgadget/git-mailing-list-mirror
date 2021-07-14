Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E91C07E9C
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 15:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD799613C5
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 15:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239567AbhGNP0C (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 11:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239545AbhGNP0C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 11:26:02 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39DBC06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 08:23:09 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 59-20020a9d0ac10000b0290462f0ab0800so2822469otq.11
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 08:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/w93QO+a4XU9qKu8CV98RqMA/o6bGAy2XQuxGVZHNh0=;
        b=GRbiSHMZ8lJYoZnQ5l/+fPJij0olP6rEMuk/fjdDI+s00+shf3aPXCe4PK5XXyP/aT
         /Rh6ISPdXdthT4Yxorf7iHjnvK3sx5JIaThogamIBe7tOWvum/CgKrzQWFSNP+x8/jDg
         goVGV+N2b0cUNmzYU8j3oZMFDRwhfHDAhI2Zrfi53LjKlQd1MwAHkpkNNFv3mNZ9F8Pk
         VcGi4yO/8a+4PogWah0Ymiow+q9NlaDWxD1Lw8uuIhqeGGAjK6t4zQobNEhS4aTuDV+r
         kL2o/G4JhG1TjsWtcUyYrEZtY5m/GzCYsv0JkUlPFOTwv/V/p/Z141iFHP9RWDshmjbD
         7dMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/w93QO+a4XU9qKu8CV98RqMA/o6bGAy2XQuxGVZHNh0=;
        b=kbkQUX95HGHgPBN/MULZYJJ+Q2dFZnluAN6tYcseLs/lk/SS4q4Km8nzOvxB+nviGQ
         FSEH6glsO/f+27cv06D2e1kUc3KzsP7xWXtKv7BeEMT8DRyg8HZlaUrO6x7e7MQIdqf/
         ux4Kiv5GyF7bdjaSMyrr4r4xiC59QzI02VbkcflNjLq1YA90I/QzWM54bn+WB2OQn1+M
         /1qs11YFuYuC/Kx1szjomsIkXvBqGtgcZOkCC2IUjrQAzXfTTEFVXDg3DyFQhkj+0e2q
         QR5w4nmvsbXhTcOl355tCc2Psec8+TSRKAQZBC4iCXrPLHtfkjcjPjwLYUo8SjMY5J7r
         cagg==
X-Gm-Message-State: AOAM5312ejyERSqDw9DIwVRx2ThS7fgjuXonN1xgn4n+ziwRgR0cbsmd
        rQG1UOvh25cHCEE+ogh2DusIzHWQ/1zE0lKLqn0=
X-Google-Smtp-Source: ABdhPJxpv6qQJ1cVI903j83feq85Z0+OefqwVZxrG+ZDl6XRxjtpH/SVyxHB087MKU2zVl5sf12S+Qvz2vkN2Ll+HFY=
X-Received: by 2002:a9d:5a8:: with SMTP id 37mr8638100otd.345.1626276189263;
 Wed, 14 Jul 2021 08:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210711012604.947321-1-alexhenrie24@gmail.com> <CAL3xRKdOyVWvcLXK7zoXtFPiHBjgL24zi5hhg+3yjowwSUPgmg@mail.gmail.com>
In-Reply-To: <CAL3xRKdOyVWvcLXK7zoXtFPiHBjgL24zi5hhg+3yjowwSUPgmg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 14 Jul 2021 08:22:58 -0700
Message-ID: <CABPp-BEqnTuDgC0Bb+feFj=vBB48wdb60thO+Pq3N0jL74jH8Q@mail.gmail.com>
Subject: Re: [PATCH] pull: abort if --ff-only is given and fast-forwarding is impossible
To:     Son Luong Ngoc <sluongng@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, git <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 14, 2021 at 1:37 AM Son Luong Ngoc <sluongng@gmail.com> wrote:
>
> Hi folks,
>
> I am out of the loop in this thread but I have been seeing strange behaviors
> with pull.rebase=true in the 'next' branch and also in the 'master'
> branch in recent days.

I'm not surprised it happens with recent versions, but I'd expect this
to have happened with older versions too.  Is this not reproducible
with git-2.32.0 or older git versions?

>   > git version
>   git version 2.32.0.432.gabb21c7263
>   > git config -l | grep pull
>   pull.rebase=true
>   pull.ff=false

So, you have conflicting configuration options set.  pull.ff=false
maps to --no-ff which is documented to create a merge.
pull.rebase=true maps to --rebase which says to run a rebase.

You probably want to drop one of these.

> But a git pull would still run fast-forward.
> Some of our users (including myself) rely on disabling fast-forward to emit the
> per-file change log summary after each git-pull
>
>   Updating 245f278cb729..5e8d960db7b3
>   Fast-forward
>    some/file/dir.ext         | 44 ++++++++++++++++++++++++++++++++++++++++++++
>    another/file/dir.ext     |  6 +++---
>   2 files changed, 47 insertions(+), 3 deletions(-)
>
> In a big, fast moving monorepo, this summary is a lot of noise and
> switching to pull.rebase=true
> used to be the way to turn it off. If the change is intended for next
> version release, is there a
> workaround for this?

Thanks for the report.  This particular commit has not yet been picked
up, not even in seen.  But it's a good example of how conflicting
configuration really ought to result in an error rather than randomly
picking one to trump, and suggests why we should complete the patch.

However, since I'm commenting on this and the stat information appears
to be important to you, note that there are also merge.stat and
rebase.stat configuration variables for controlling whether those are
shown at the end of merge and rebase operations.

Hope that helps,
Elijah
