Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD821C433EF
	for <git@archiver.kernel.org>; Sun, 27 Feb 2022 23:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiB1AAW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Feb 2022 19:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiB1AAW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Feb 2022 19:00:22 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FEB5A593
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 15:59:44 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id p4so116806edi.1
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 15:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mwkpZ0JEmRF5mTS7ZZxqsNHi6pyoJ9wojhfDzNItRnk=;
        b=2E47JBYRc8QYUKlDWAMJSxyMHecQHufxBXChIsG1L67Pglp4EOJWfNijfKm3d95Rnu
         lZr7BAXSu3t+SszcR/GDSfD9GLUtlOXzqMNaUcXKtwO1V9I50MOZQwrIsbPA/OiWPDZt
         r1+yPuqNIARe/Z63DKSvR3VMCxeCD4kKnS6evpB1lxVSBU3dCFcFaUnMta6zC68/4o4K
         RMYA0RZ5fGHSRNzPiWuE/qqWE47DHQ0mxcShylrIfNBVW+rIhOidoY0tb/WPnr00WJUm
         rkSa8FWIUrI7NAYQJpUKJ0HPaIz6ta3gzFPoR+V8blon/aN1bfjVTWnRw27Obkw6NSNs
         Begw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mwkpZ0JEmRF5mTS7ZZxqsNHi6pyoJ9wojhfDzNItRnk=;
        b=HcMlkN8f0uZdcFCNk5nbl1uTwh9hBR+CrIRpLeSD4aKOnOuX2CpPeRG5BMxggpV/0R
         fWBH7A/NkOE4MHmsVsRJyWmKsiFpp8UNshZMGCTDPsnEk/f13ZmbbMUz0FDQ6BNm/Bu6
         qOrPua8GbWI/XZQXc/HS3Fv4L4uQxFQY8BUDEoqExuDMgffofXgmHcHHQsS/33DPVE8B
         SW3ExVIlUnukv7o/l22nSXXLlWQdid3C1QBrwmEfuD3qfELog7/ZAA0Pgp7GCe0iGtR3
         h/bUnafs+fx77dA0QwZ9Lco/nGKVHkHLaDbDPK1Tx3gmgLwRfu7J/NoUGaNJsRaqxvid
         Vasw==
X-Gm-Message-State: AOAM532CZv9w3lHo3xPxoq3E118B3bhJ8xy4UJ1tD4uX1fjwby5QNs/7
        2NsXAaN4KTo0hb8b2c0ryuLLs8UM5/YAn7KM5Gq+DtKEVVU=
X-Google-Smtp-Source: ABdhPJw8x3viN8dZ7S6OF39YVAcm9M/vhJCda5xPe3AY7zUYk7ntWN5IyinKuk/Bo+OgAtlkaFGTLCxgSB+a7ju9RME=
X-Received: by 2002:a05:6402:5244:b0:410:f41c:ebe7 with SMTP id
 t4-20020a056402524400b00410f41cebe7mr17080494edd.77.1646006382935; Sun, 27
 Feb 2022 15:59:42 -0800 (PST)
MIME-Version: 1.0
References: <pull.1161.git.1645695940.gitgitgadget@gmail.com>
 <pull.1161.v2.git.1645815142.gitgitgadget@gmail.com> <890e016bfc0809d25a4ae8ae924b23895f520810.1645815142.git.gitgitgadget@gmail.com>
 <xmqqczjaaeiv.fsf@gitster.g>
In-Reply-To: <xmqqczjaaeiv.fsf@gitster.g>
From:   Tao Klerks <tao@klerks.biz>
Date:   Mon, 28 Feb 2022 00:59:31 +0100
Message-ID: <CAPMMpoiJyWQp+UtaZWeWodkjVkm0buSykfuDZDrM4d1eC3vstQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] merge: new autosetupmerge option 'simple' for
 matching branches
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 25, 2022 at 9:15 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > This commit introduces a new option to the branch.autosetupmerge
> > setting, "simple", which is intended to be consistent with and
> > complementary to the push.default "simple" option.
>
> Documentation/SubmittingPatches.
>
> We do not say "This commit does this".  Instead, we say "Add a new
> option that does X".  Usually that is done after the explanation of
> the status quo is finished to make readers understand what the
> problem the change is trying to solve is.  So...

Yep, sorry, thx! (fixed, reroll coming!)

>
> > The push.defaut option "simple" helps produce
> > predictable/understandable behavior for beginners, where they don't
> > accidentally push to the "wrong" branch in centralized workflows. If
> > they create a local branch with a different name and then try to do a
> > plain push, it will helpfully fail and explain why.
>
> ... this would be a better first paragraph to start the proposed log
> message with.
>
>         With push.default set to "simple", the users fork from a
>         local branch from a remote-tracking branch of the same name,
>         and are protected from a mistake to push to a wrong branch.
>         If they create a ... and explain why.
>
> > However, such users can often find themselves confused by the behavior
> > of git after they first branch, and before they push. At that stage,
>
> Depending on how they "branch", they may or may not be confused.  Be
> more specific to illustrate what problem you are solving, e.g.
>
>         ... after they create a new local branch from a
>         remote-tracking branch with a different name.
>
> > their upstream tracking branch is the original remote branch, and pull
> > will be bringing in "upstream changes" - eg all changes to "main", in
> > a typical project where that's where they branched from.
>
> OK.  So "pull" tries to grab from the upstream (which is most likely
> an integration branch with bland name like 'master', 'main' or
> 'trunk'), while "push" does not allow the work on a branch (which is
> named after the theme of the work and not a bland name suitable for
> integration branches) to be pushed to the upstream.
>
> It may probably not be so clear why it is a problem to many readers,
> I suspect.  Isn't that what happens in a typical triangular workflow
> to work with a project with a centralized repository?  You fork from
> the integration branch shared among project participants, you work on
> your own branch, occasionally rebasing on top of the updated upstream,
> and when you are done, try to push it out to the integration branch,
> and that final leg needs to be explicit to make sure you won't push
> out to a wrong branch (in this case, a new branch at the remote with
> the same name as your local topic branch) by mistake?
>
> > On the other hand, once they push their new branch (dealing with the
> > initial error, following instructions to push to the right name),
> > subsequent "pull" calls will behave as expected, only bring in any
> > changes to that new branch they pushed.
>
> Is that because the upstream for this local branch is updated?
> The "following instructions..." part may want to clarify.
>
> It somehow feels that a better solution might be to suggest
> updating the push.default to 'upstream' when it happens?  I dunno.
>
> In any case, now we have explained what happens with today's code,
> here is a good place to propose a solution.  Do so in imperative,
> e.g.
>
>     Allow branch.autosetupmerge to take a new value, 'simple', which
>     sets the upstream of the new branch only when the local branch
>     being created has the same name as the remote-tracking branch it
>     was created out of.  Otherwise the new local branch will not get
>     any tracking information and
>
> or something, perhaps?

Thank you for taking the time to make sense of the rambling /
largely incoherent message and helping me identify some context
other reviewers will expect.

I've rewritten the whole thing to try to address these concerns, but of
course I may well have introduced a whole new set. If nothing else, it's
become even more rambling. Is there a recommended limit to the
length of a commit message?
