Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A40C4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 23:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16B3261019
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 23:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbhHJX7t (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 19:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234289AbhHJX7s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 19:59:48 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB82C061765
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 16:59:25 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id z2so1621691lft.1
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 16:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2UchjkfOs45k5l1efoCmrWTwHRNpsBzcMkSH6EMxbak=;
        b=rH+wOq+rJ5TUEuCrzVmdCi7D93nRoQhAnvjWKMkp1jc/JgKVl1mxJOA3enfeqqWYyU
         2qIzQGk6P86FYWx4PeXpRbilvc+CudZJLYehP3Dtb+IEltenYIUymHGlqmGhcgwYBRZA
         lLg3LfG+9vKqvFypnJ0qdnwgNGSBUFmIlX733AKfr7Z5hjbKfY3ozQ/Tek8nkrhNwQxp
         y0+dvFbzT/NPhrFGbsLBy4uTJ0XbuiXZ6leed1F3kHcROoCrUXHLjr6Fdh8w2Xs4C0qa
         c6pe7SsPTY7ERaewo6ehcBl/Cg3YQ5WqUL/ctQXIO7yvjs4pA+Jw5KNi8kTqUJ9j3/RN
         uC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2UchjkfOs45k5l1efoCmrWTwHRNpsBzcMkSH6EMxbak=;
        b=AfX2lMfvj7oCgy9kPjb2veZSR8jCK97V6efIFrSYe1tXw+2tTYaWlpPphr/z5X1Tbd
         T9jrJ/bz4ejP2lf+EJu6r7cYa8CFmZPmHxZv0qNsCczUjh8FLL+/EGgVrHNRGRjlsg4A
         R7P7t+CwIhlhKPJ2Lm81DunYJM2Tp1u5gPywo/ta4N6eu9rHqLTnAz5q6KNCztJyW+4l
         xONQd514PxfC07yNi83UOxqQ6VmCl+KQnIrPTdsv7g2HDuHA5wD/Ug9g7etapFGSwafV
         UU1oBFjJvAmR3Eu+xejzBAihI0nv6Ye73/Ppix5JX+/bDCNRQxycIBsLBDlkIfobIjzX
         oGWQ==
X-Gm-Message-State: AOAM532kslGpPdHLFmeAja50erEoPtuYHVJVw5vPQTTTM3XANf72SOxX
        xjKehq44h03bW/jtOsIKFJo1GKObXH19TD+aoOMo4g==
X-Google-Smtp-Source: ABdhPJztrkYrMVl9QPNwcEIuLahLvww15J77ncRGgC/bYWB25Yh5Z8Yl+/yMnC9S1wF/oVXYIxQ9B2pMkamwittZhrc=
X-Received: by 2002:a05:6512:556:: with SMTP id h22mr23128942lfl.461.1628639963560;
 Tue, 10 Aug 2021 16:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1006.v3.git.1627946590.gitgitgadget@gmail.com>
 <pull.1006.v4.git.1628536305810.gitgitgadget@gmail.com> <xmqqzgtqe2w6.fsf@gitster.g>
 <CAN3QUFYPjsvBRGegO-kC7+gcFDczOqQSw-UYphnLHx=6-6kkwA@mail.gmail.com>
 <xmqqa6lpdu4z.fsf@gitster.g> <8f24d532-b021-2a96-415b-467f715cb1ec@gmail.com>
In-Reply-To: <8f24d532-b021-2a96-415b-467f715cb1ec@gmail.com>
From:   Mahi Kolla <mahikolla@google.com>
Date:   Tue, 10 Aug 2021 16:59:11 -0700
Message-ID: <CAN3QUFaPBqZj68PYv_+=KV_cvbyhHfDtNPpWDbnnNeq+XD8MrQ@mail.gmail.com>
Subject: Re: [PATCH v4] clone: update submodule.recurse in config when using --recurse-submodule
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Mahi Kolla via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillippe and Junio,

On Tue, Aug 10, 2021 at 4:04 PM Philippe Blain
<levraiphilippeblain@gmail.com> wrote:
>
> Hi Junio,
>
> Le 2021-08-10 =C3=A0 14:36, Junio C Hamano a =C3=A9crit :
> > Mahi Kolla <mahikolla@google.com> writes:
> >
> >>> Is it possible to avoid changing the behaviour unconditionally and
> >>> potentially breaking existing users by making it an opt-in feature,
> >>> e.g. "git clone --recurse-submodules" would work as the current
> >>> users would expect, while "git clone --recurse-submodules=3Dsticky"
> >>> would set submodule.recurse to true, or something?
> >>
> >> As mentioned, the `submodule.recurse=3Dtrue` will only apply to active
> >> submodules specified by the user. Setting this config value when the
> >> user runs their initial `git clone` minimizes the number of times a
> >> developer must use the `--recurse-submodule` option on other commands.
> >>
> >> However, this is a behavior change that may be surprising for
> >> developers. To ensure a smooth rollout and easy adoption, I think
> >> adding a message using an `advice.*` config setting would be useful.
> >
> > It may be better than nothing, but that still is a unilateral
> > behaviour change.  Can't we come up with a way to make it an opt-in
> > feature?  I've already suggested to allow the "--recurse-submodules"
> > option of "git clone" to take an optional parameter (e.g. "sticky")
> > so that the user can request configuration variable to be set, but
> > you seem to be ignoring or skirting it.
>
> The '--recures-submodule' option in 'git clone' already takes an optional
> argument, which is a pathspec and if given, only submodules matching the =
given
> pathspec will be initialized (as opposed to all submodules if the flag is=
 given without
> an argument). So, it does not seem to be possible to use this
> flag as a way to also set 'submodule.recurse'.
>

Because of the optional pathspec argument, adding a `=3Dsticky` argument
to the option may be hard to implement. That was my initial hesitation
to the opt in design.

> When Emily (CC'ed) sent her roadmap for submodule enhancements in [1], th=
e enhancement
> that Mahi is suggesting was explicitely mentioned:
>
> > - git clone
> ...
> > What doesn't already work:
> >
> >    * --recurse-submodules should turn on submodule.recurse=3Dtrue
>
> I don't know if Mahi is part of this effort or just came up with the same=
 idea,
> but in any case maybe Emily would be able to add more justification for t=
his change.
>

I am part of the team and am implementing that exact feature from the
roadmap :)

> > Even though I am not
> > married to the "give optional parameter to --recurse-submodules"
> > design, unconditionally setting the variable, with or without advice
> > or warning, is a regression we'd want to avoid.
> >
>
> In my opinion, it would not be a regression; it would a behaviour change =
that
> would be a *vast improvement* for the majority of projects that use submo=
dules, at
> least those that use non-optional submodules (which, I believe, is the va=
st majority
> of projects that use submodules, judging by what I've read on the web ove=
r the past 3
> years of my interest in the subject.)
>
> As soon as you use submodules in a non-optional way, you really *want* su=
bmodule.recurse=3Dtrue,
> because if not:
>
> 1. 'git checkout' does not recursively check out your submodules, which p=
robably breaks your build.
>     You have to remember to always run 'git checkout --recurse-submodules=
' or run 'git submdule update'
>     after each checkout, and teach your team to do the same.
> 2. 'git pull' fetches submodules commits, but does not recursively check =
out your submodules,
>     which also probably breaks your build. You have to remember to always=
 run 'git pull --recurse-submodules',
>     or run 'git submodule update' after each pull, and also teach your te=
am to do so.
> 3. If you forget to do 1. or 2., and then use 'git commit -am "some messa=
ge" (as a lot
>     of Git beginners unfortunately do), you regress the submodule commit,=
 creating a lot
>     of problems down the line.
>
> These are the main reasons that I think Git should recurse by default. Se=
tting 'submodule.recurse'
> also brings other niceties, like 'git grep' recursing into submodules.
>

I completely agree with this! These are a lot of the reasons why the
feature was initially suggested. An alternative path forward the team
discussed was testing `submodule.recurse=3Dtrue` under
`feature.experimental`. This way we can collect feedback from
developers before making this the default config value.

> If we can agree that the behaviour *should* change eventually, then at le=
ast
> 'git clone --recurse-submodules' could be changed *right now* to suggest =
setting
> 'submodule.recurse' using the advice API, and stating that this will be t=
he default
> some day.
>
> Even if we don't agree that the behaviour should enventually change, I th=
ink
> having this advice would be a strict improvement because
> it would help user discover the setting, which would already go a long wa=
y.
>
> Thanks,
>
> Philippe.
>
>
> [1] https://lore.kernel.org/git/YHofmWcIAidkvJiD@google.com/

I agree that adding an advice message when a user runs `git clone
--recurse-submodules` would at least alert users of their options,
giving them the choice to set `submodule.recurse` accordingly.

Thanks!

Best,
Mahi Kolla
