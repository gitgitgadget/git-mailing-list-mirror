Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BDFC433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 20:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238087AbiCIUGX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 15:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbiCIUGW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 15:06:22 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20830E6E
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 12:05:23 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id bu29so5836659lfb.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 12:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2CoHC7qB3QvaMc5Q3CbfNViFvdsRCzjHU4TC2gnaKdg=;
        b=VquTCRDuqa4ZtS+PclYGGzdATGunFchsbU9JMUSgOUXvP1JpdJ2yhMw+jgtfkMad3h
         HpUkl5HuogZ1S6Q1D0KgkvGxVHFdvqOQDr+uhXxTWaL1Popj8B9mM5ozpK29vAA74ilB
         4sxQwA3OlzGeQ54QS0pfrjnDXVMJfzI9vHcLXiIlKwdErAcOtvqVYN77c4AWKH3vMhBk
         ay3cYG6KyEOFFVmjGRdS3+2pistQsnsarS+R/oMNhynsHEf8mWf67zajtVrZJA5eKujg
         /3/KD8CiwiebweldjxkZ/w0JGjuu2GTlyg8JRCKjfvWMbDJzA9b+xfkdDrWg5WrKxfl3
         fUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2CoHC7qB3QvaMc5Q3CbfNViFvdsRCzjHU4TC2gnaKdg=;
        b=8IDQBJJG6gXIjgxzSzKMh31lAvvJCdQF3q1S2C5bkYHXUDqunrg9LX+TRKF5ZtMI7E
         vKzlen0hGO8CLcZL4e5NE65GGV5zBAZ2t56DhBBiQOHojfbo25GRGcei+0eX4On2r1YR
         P4eqJOMA7h3KypNrQK4tKZ8dMCmFnhi8qu7x9J62g6TJIDHEhW2+eUd27P4KI0rXIyJx
         pohvoZcfpRmmSHEr40u9vIhuIqsKAe6R6WjNtlilI/NlzczWzRlskFOC0vf+/b09cVCK
         BdWSnuQ0jXQd69XkmgfWw+CjpSaBLH+QZ61Pi7ksbzQsO2GOcWEvRIDaqiBFsgjAaaB0
         kZJA==
X-Gm-Message-State: AOAM532dbMGVON1uWK94wIVkjs8Frl3KQSNYpL3diUQblUH5WoQ43TVm
        uxA2ndZq8/400efjbjDV7x90IxsTtxE1rscEmVM=
X-Google-Smtp-Source: ABdhPJyu71148OutSI09v99rRjLS4nkqJYPJ69zApajWE9KKrGELsuz4YnlrROjxQQE5jZE4gAZcHkABv/GsqQCGUNI=
X-Received: by 2002:a05:6512:32ca:b0:446:4262:e29 with SMTP id
 f10-20020a05651232ca00b0044642620e29mr822156lfg.522.1646856320961; Wed, 09
 Mar 2022 12:05:20 -0800 (PST)
MIME-Version: 1.0
References: <pull.1093.v4.git.1643686424.gitgitgadget@gmail.com>
 <7a164ba95710b4231d07982fd27ec51022929b81.1643686425.git.gitgitgadget@gmail.com>
 <xmqqr18m8514.fsf@gitster.g> <xmqqy22u6o3d.fsf@gitster.g> <CANQDOdfVg4e=nLLAynm261_R5z+rjZV3QgE8nLwGEmj1wQm_uA@mail.gmail.com>
 <xmqqczjt9hbz.fsf@gitster.g> <CANQDOdcRM-GdxQ6iiV6pSBZifzpn+vJrBi0f88um9Rk4YJMFng@mail.gmail.com>
 <xmqq35kp806v.fsf@gitster.g> <Ygn/GvLEjbCxN3Cc@ncase> <xmqqh7914bbo.fsf@gitster.g>
 <YiiuqK/tCnQOXrSV@ncase>
In-Reply-To: <YiiuqK/tCnQOXrSV@ncase>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Wed, 9 Mar 2022 12:05:09 -0800
Message-ID: <CANQDOdfHYnKKFfQ6ptPcLacx=HX5cnXGRuL55Ttfr+zKCSBQJg@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] core.fsync: introduce granular fsync control
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 9, 2022 at 5:42 AM Patrick Steinhardt <ps@pks.im> wrote:
>
> On Mon, Feb 14, 2022 at 09:17:31AM -0800, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> > > To summarize my take: while the degree of durability may be something
> > > that's up for discussions, I think that the current defaults for
> > > atomicity are bad for users because they can and do lead to repository
> > > corruption.
> >
> > Good summary.
> >
> > If the user cares about fsynching loose object files in the right
> > way, we shouldn't leave loose ref files not following the safe
> > safety level, regardless of how this new core.fsync knobs would look
> > like.
> >
> > I think we three are in agreement on that.
>
> Is there anything I can specifically do to help out with this topic? We
> have again hit data loss in production because we don't sync loose refs
> to disk before renaming them into place, so I'd really love to sort out
> this issue somehow so that I can revive my patch series which fixes the
> known repository corruption [1].
>
> Alternatively, can we maybe find a way forward with applying a version
> of my patch series without first settling the bigger question of how we
> want the overall design to look like? In my opinion repository
> corruption is a severe bug that needs to be fixed, and it doesn't feel
> sensible to block such a fix over a discussion that potentially will
> take a long time to settle.
>
> Patrick
>
> [1]: http://public-inbox.org/git/cover.1636544377.git.ps@pks.im/

Hi Patrick,
Thanks for reviving this discussion.  I've updated the PR on
GitGitGadget with a rebase
onto the current 'main' branch and some minor build fixes. I've also
revamped the aggregate options
and documentation to be more inline with Junio's suggestion of having
'levels of safety' that we steer
the user towards. I'm still keeping the detailed options, but
hopefully the guidance is clear enough to
avoid confusion.

I'd be happy to make any point fixes as necessary to get that branch
into proper shape for
upstream, if we've gotten to the point where we don't want to change
the fundamental design.

I agree with Patrick that the detailed knobs are primarily for use by
hosters like GitLab and GitHub.

Please expect a v5 today.

Thanks,
Neeraj
