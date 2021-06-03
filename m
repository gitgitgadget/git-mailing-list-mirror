Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7027C47082
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 20:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0BAB60FE4
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 20:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhFCUTc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 16:19:32 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:34341 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhFCUTb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 16:19:31 -0400
Received: by mail-lf1-f49.google.com with SMTP id f30so10725841lfj.1
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 13:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xv64+Q17hdEm5fcgvOnZ/DgEuzBgyhffN63A/5Wp7lQ=;
        b=i2H1SWxgNoWPBJPzPBMnu1ZcSDOhNJjD79txuPuYD9mnrYo9Zj4cuMd2O/WVYwos+T
         4/g9zlK5qwdIJdSxuY9o0vRFHnWhDvN0f8S6Cz9E7p6qQk2wzcW2VcYf47KRMKvfyNJ8
         QBRigjaN6EB8NjGq478Wprgd1ENRnyh7ZJ2zgR+ZRKDtgB+eeyiRKezZ/q/rIvRH0KYY
         wHoBcxKeE1R/kpTE27zYJvUEV+GQ7j6Dqm5LP5fLnq4WT47zAj8alTipnJ0pCLs4RUp8
         2G463F+jA1Fg7/XyWS2nwG1woKC0vQDR4HJFY1grWZNFv01z6kz/QN8OLR+e5iWEmLEB
         BsaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xv64+Q17hdEm5fcgvOnZ/DgEuzBgyhffN63A/5Wp7lQ=;
        b=gOAWINQY4uVQFx2x8DZm1H28+HJ3AnDz5nWSIcbooMhOcoZ4cpxd4tbF1sHEL1ExMy
         fr1fi8RE9MKTVpaPepNUJDtF45eiKaLKImQq/a5a7Rr5Bz7pd/8tyhG09rE2Z/F4rx6e
         cjmbkDnuhAi76DCOkTjuvmeN4F0nKPK8YJ+QZFObH4iVESUzg+C0m7VRYXfMZsMG9j2L
         ksisFl8aEftHyEpUT2mJcD3yq6sDlRdV+iUWPMx2Dqa6NTkOSgXjbIJPmpmrTcRwAjVs
         EY9Jd6W80fPXYnWU12gwfiUNMl42tMkgOw118FeqJ6TLzoiDa07OV//0Mk6SrsuaPN8a
         oYNA==
X-Gm-Message-State: AOAM530qp1ARglg0oCHjcd71CVzFw855wacqaydK2xi3mz1bm8AWC19J
        FVqs87xgyodg6BVU7OGg3nUiXKSbaQXKZ+HFH7s=
X-Google-Smtp-Source: ABdhPJwmd7CX5cL/RiTvpv7ZkPF2JoebIhH6555R0wMLjzozt5I/XYLpPdKze/PR+YA/3h8pxmiAsuUDD1iZzCAWlVE=
X-Received: by 2002:ac2:5497:: with SMTP id t23mr448668lfk.52.1622751392392;
 Thu, 03 Jun 2021 13:16:32 -0700 (PDT)
MIME-Version: 1.0
References: <pull.908.v4.git.1620241892929.gitgitgadget@gmail.com> <20210603033142.353066-1-jonathantanmy@google.com>
In-Reply-To: <20210603033142.353066-1-jonathantanmy@google.com>
From:   Albert Cui <albertqcui@gmail.com>
Date:   Thu, 3 Jun 2021 13:16:20 -0700
Message-ID: <CAMbkP-Qkd0EzNvhKLeOU3LCdTDiYKpTmZJqMN5rFDg-WkVMrAw@mail.gmail.com>
Subject: Re: [PATCH v4] hooks: propose project configured hooks
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Albert Cui via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>, emaste@freebsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 2, 2021 at 8:31 PM Jonathan Tan <jonathantanmy@google.com> wrot=
e:
>
> > +* After clone, repository suggests hooks to the user
> > +
> > +    ** User receives a non-interactive message advertising hooks avail=
able to
> > +    install
> > +
> > +    ** User can see what hooks and commands are being suggested and fr=
om what
> > +    remote.
>
> From the implementation point of view, would it be sufficient to just
> advertise that hooks are available? Assuming that the hooks will be
> available from a specially named ref (as stated below), then we would
> only need to inform the user that this ref exists and hooks can be
> inspected using a special command. Likewise for when we fetch and notice
> that the ref now points to a different object. Then, we wouldn't need to
> do any extra fetching upon clone/fetch, saving time and bandwidth, but
> just do so if the user requests it.
>

From a user perspective, I think it's better to not just tell users
that hooks are available but also /what/ hooks are available.

That said, that doesn't require getting everything from the ref as the
hook command itself might be stored in this ref. So something like
this seems sufficient to me: "Origin suggests setting up a `pre-push`
hook which runs `pre_push.sh`. To view the contents of `pre_push.sh`,
run {special command}."

> > +Feature Requirements
> > +~~~~~~~~~~~~~~~~~~~~
> > +
> > +Minimum Feature Set
> > +^^^^^^^^^^^^^^^^^^^
>
> [snip]
>
> > +* The configuration specifies where the hook commands reside
> > +
> > +    ** This could be a path to a script/binary within the repository
> > +
> > +    ** This could be a path to a script/binary contained within submod=
ules of
> > +    the repository
> > +
> > +    ** This could be a user installed command or script/binary that ex=
ists
> > +    outside of the repository and is present in `$PATH`
>
> Right now hooks are fixed files (well, not counting Emily Shaffer's work
> on config hooks). Would it be sufficient to just provide replacements
> for those files?
>

My thought was we'd leverage config hooks and basically write to the
config for setting up hooks.

> > +* The configuration lives outside the worktree.
> > +
> > +    ** Allows updated hooks to apply across history and branches, redu=
cing
> > +    the maintenance burden of keeping hooks updated.
> > +
> > +    ** Allows different remotes to specify different configuration. Th=
is is
> > +    useful for public vs private central repositories or for repositor=
ies which
> > +    support different Git functionality.
>
> Hmm...what would be a use case of this? And how would, say, a pre-commit
> hook know which remote it is for?
>

For a concrete example, we use Gerrit for internal reviews and need
the Change-Id hook, but we don't want that when upstreaming.

Good question for specifying remotes. This might imply the need for
something like `git commit --hooks-from=3Dorigin`.

> > +* The user receives advice to install hooks.
> > +
> > +    ** The advice should clearly indicate the suggested hook command(s=
) and hook
> > +    event(s) as well as the central repository that is suggesting them=
 (via
> > +    remote URL).
> > +
> > +    ** The user should be able to use configuration to turn off this a=
dvice.
> > +
> > +    ** The advice should appear at the following times:
> > +
> > +        *** After a clone
> > +
> > +        *** After a suggested hook would have run if not already insta=
lled. The
> > +        advice should include commands for installing the hook and inv=
oking it.
> > +        For example, for a hook on 'git commit', the user should recei=
ve advice
> > +        to amend their commit after hook installation.
>
> This seems contradictory to a point above where we only inform the user
> upon clone (when the user is in the setup mood).
>

Good catch, I should clarify that previous point. The main concern is
prompting before a hook will execute which would get in the way of
existing workflows, making users susceptible to blindly agreeing.
Showing advice after the fact doesn't get in the way, and this is one
reason why "advice" felt like the right terminology to use (more
below): it's merely a helpful message that a user can optionally
choose to follow.

> > +* If, after fetch, the central repository suggests new or updated hook=
s, the
> > +user should receive advice to install these new hooks (note: implement=
ation
> > +should not interfere with requirement listed in=E2=80=9CFast Follows")
>
> In Git, the term "advice" seems to be used more for extra
> explanations that you can turn off once you're experienced with Git.
> Here, these seem like things that we would want to notify users about
> regardless of experience level, so maybe the word "notification" is more
> appropriate.
>

Another reason to use "advice" here is because the existing system
allows users to turn off the advice when it's not needed for the
requirement: "The user should be able to use configuration to turn off
this advice."

Do advice settings work on a per-clone basis? If not, I agree "advice"
is probably not the right term.

> > +* Works across Windows/Linux/macOS
> > +
> > +Fast Follows
> > +^^^^^^^^^^^^
> > +
> > +* Behind configuration, a user can opt to automatically install hook u=
pdates
> > +from a given remote.
> > +
> > +* Allow users to make trust decisions based on GPG signing e.g. if the
> > +configuration came from a signed commit, the signature could be shown =
along
> > +with the remote it came from.
>
> For the MVP, do we need this?
>
No, that's what I meant by "Fast Follows" -- not needed for the initial fea=
ture.
