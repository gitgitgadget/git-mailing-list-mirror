Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8B3C433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 16:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbiBXQs3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 11:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiBXQs3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 11:48:29 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D12013858D
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 08:47:58 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id r13so5659394ejd.5
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 08:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g2djkzUfc/RoUalYym2mSfkplfMVJQ205E8i1cYDE4g=;
        b=gefsP2KqSzM1HcxvsnGgC8D3mUKWJt3ySf5+PYzFOA6dW46ECAEIbqTo4DygNzaNxW
         1f9hTM580VGBYgaIqpruWZdwIDlOy7kHbq8tMXab0P2nAi/c4hOYD1gLds8Ftm7UXjzO
         t4Rb6/hZ4YmmZIzu2TFYCFykmMoFx8fNWDAYh5P5fdP+bD6rE8A+Tcw9Zs3ihAwPsrhX
         o3p/3UlWbtXW6PgLRAdLG5yc5UlpxQXfvmeWrJS6RwPLL0tJTito12I8kq2sipt1uz4u
         Ghk93XLF0sSOJFKHPv2iyqjw4o8k+K0ZEySRcQZil3ztM+KzaET+jq61Z309l/o0WVm3
         T7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g2djkzUfc/RoUalYym2mSfkplfMVJQ205E8i1cYDE4g=;
        b=iouOHJgvdlMBp2zdLOKaHNCOKulj99KJE3WRkwlxtyNJOhH8zZmLMTsd0sFrcxya/G
         /2O5jf+3bG58IoOyhcykCCCgsmVVrfMa4i/k8kTRQFC6ZNTM7c6Twsac/loTKUH+YZlJ
         DUB2yaAt6CSevgdW3RWG1RblGT9fk3jX2PEvV8jMkjOgywYSy1kcyGOdjZLU0DALsJwR
         bC2ZPkHGvSPCK5MsfcnbPkQf78zdUNDZuqCaONAOAF2OdFEBmOJ4ZSkVth2xzfBGOsNr
         PKBRQI08twUpd8acgnVpxOEcfuZpFPvyG8S+TgRIkBqpkHDPx4VFb3LhonNBPlkDlPdV
         0uAQ==
X-Gm-Message-State: AOAM533JWRQvlph2v3/mVIIZVRO68/3wlvqmhcE3lDG1XBWn7uJLFP1D
        JKmnnG/C02s0hUDaeeSjuOGkVVa6vgiPr4Za+3yNszdjk7A27Q==
X-Google-Smtp-Source: ABdhPJxW0GHKaEMk9igso376LbG3I56K+Nzy2o6B+PvHuiqBvtk5M1QbRejJWADVe7qexYcxDD5NALQCK446eenopuA=
X-Received: by 2002:a17:907:7613:b0:6d0:ee20:8a37 with SMTP id
 jx19-20020a170907761300b006d0ee208a37mr2935541ejc.316.1645721277071; Thu, 24
 Feb 2022 08:47:57 -0800 (PST)
MIME-Version: 1.0
References: <CAPMMpog6vKBfYEWqKDgK7YQQ96pPVMH7hYPXUHMnJsgLNgYMXA@mail.gmail.com>
 <b54a6cde-5065-632b-012c-0d6f777249ef@odoo.com>
In-Reply-To: <b54a6cde-5065-632b-012c-0d6f777249ef@odoo.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Thu, 24 Feb 2022 17:47:46 +0100
Message-ID: <CAPMMpojn9uYEuG07ky6Jz-F4PAGRjY8Y_az2EbM1cvq98QBnwQ@mail.gmail.com>
Subject: Re: branch.autoSetupMerge option for "if name matches only"?
To:     Xavier Morel <xmo@odoo.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Xavier,

Thanks for the follow-up.

>I found this message when trying to see if someone had already suggested
> something along those lines.

Did you find any other related threads that could add context? I did
not find anything when I looked.

> what I wanted to propose was to only automatically setup the merge on
> implicit remote tracking branches

While I understand this as a personal expectation/preference, that
doesn't seem to align with the expectations of the "beginner users"
that I interact with;

generally, they expect a branch that is "the local version of a remote
branch" to behave one way, and a branch that "was 'branched' from the
then-HEAD of a remote branch" to behave another way - regardless of
whether a given user knows the "pretend I already have the branch
locally / create it on-the-fly" syntax, or is explicit about saying "I
want to work on (for example) master which I know is origin/master on
the remote".

> As far as I'm concerned, `git switch` actually behaving as documented
> would resolve the entire issue

I'm not sure I understand this. I just tested and got exactly what I
expected from the doc:

$ git -c merge.autosetupmerge=false switch -t origin/mybranch
Branch 'mybranch' set up to track remote branch 'mybranch' from 'origin'.
Switched to a new branch 'mybranch'

I agree being able to say "git switch mybranch", without the other
side effects of merge.autosetupmerge=true, would be convenient... but
then I'm arguing for a broader change and (in my opinion) better value
of "merge.autosetupmerge" altogether :)

Fwiw, I submitted a patch introducing this
"merge.autosetupmerge=simple" option earlier today, but no reactions
yet. I don't know whether that's because project members disagree that
there is inherent unnecessary complexity facing "beginners" in the
current behavior, or disagree that this is a reasonable direction to
reduce that complexity, or are frustrated with my spotty participation
record in this mailing list, or the terrible quality of my C- and
project-novice code, or simply haven't looked at this topic yet!

The patch series is titled "adding new branch.autosetupmerge option "simple"".

Thanks again,
Tao


On Wed, Feb 9, 2022 at 2:46 PM Xavier Morel <xmo@odoo.com> wrote:
>
> I found this message when trying to see if someone had already suggested
> something along those lines.
>
> In fact I would be even more restrictive: what I wanted to propose was
> to only automatically setup the merge on implicit remote tracking
> branches, that is:
>
>      git switch foo
>
> if there is no such branch locally will look for the corresponding
> branch in the remotes, and will create a matching local one. In that
> case it makes a lot of sense to create a remote-tracking branch: when
> implicitly checking out a remote branch, it's likely the goal is to
> track it.
>
> The issue is that
>
>      git switch -c bar foo
>
> will do the same, despite explicitely creating a differently named
> branch, which is probably some sort of feature which needs to be
> remote-ed somewhere else. If this issue is not caught immediately it is
> possible to push directly upstream by mistake.
>
> Upon reading the documentation of `git switch` I actually believed this
> would behave correctly given `autoSetupMerge=false`:
>
>      --guess, --no-guess
>          If <branch> is not found but there does exist a tracking branch
> in exactly one remote (call it <remote>) with
>          a matching name, treat as equivalent to
>
>              $ git switch -c <branch> --track <remote>/<branch>
>
> Because `--guess` is the default for the `git switch <name>` form, this
> description made me believe the tracking would be forced.
>
> Sadly it is not so, setting `autoSetupMerge=false` will also disable
> automatic remote-tracking on guessed branch.
>
> As far as I'm concerned, `git switch` actually behaving as documented
> would resolve the entire issue (especially if it were possible to
> disable `git checkout` somehow, such that I would have to force muscle
> memory).
>
> This is made more annoying because
>
>      git switch -t foo
>
> *does not work*, frustratingly (if as documented, this time) `-t`
> implies `-c`. So it's not even possible to remember to type `git switch
> -t remotebranch` and then live happily with `autoSetupMerge=false`. This
> makes `autoSetupMerge=false` a lot more frustrating that necessary.
