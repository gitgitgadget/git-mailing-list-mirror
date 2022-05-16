Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F9FC433EF
	for <git@archiver.kernel.org>; Mon, 16 May 2022 17:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241216AbiEPRp3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 13:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238175AbiEPRp1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 13:45:27 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CE03703A
        for <git@vger.kernel.org>; Mon, 16 May 2022 10:45:26 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id y5-20020aa79425000000b005104c6e01efso6515049pfo.23
        for <git@vger.kernel.org>; Mon, 16 May 2022 10:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TzL4cRyBr1rGdiTbe35UtnZxhmjFd1PBl3M5qedsYaw=;
        b=agQAemj6KHbH1waL9Wlvq2cOH7zLN2oYXR0sZWjBOzod0jrBI1LN2N8VAvh/mZmMTS
         vUawobPdt/XRQoViXGrnBJgWOV21F9xl8axIsplKJ2lprKXNcVKyTQb2Enp+aABsR/RV
         B8d2b51BqT+gSIQO92+2FocSi917QV6aD3sYucPAQyigYetyrQ5noHiLy3zYQlAtptVD
         mor9Ww81J5AF01+S9ESkPh3zSGvdnQbiGHpvmJzIscbJ9/85nT5gDC5lsYWqmXMJF7pa
         nJ+wkKStzOepm27rx6D7kuWUZbCzTv+c+PKGsOqCgLtDDunYWEUtTgxCDLTMlZICh36y
         zgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TzL4cRyBr1rGdiTbe35UtnZxhmjFd1PBl3M5qedsYaw=;
        b=CH8e6NIu5oZK1PZiJOXiutvivSGm1UVnyb1UUa1kqpkdcl7AmPFFvD9gGRSBrj+4uF
         azvnaUlg8WqocdT92O+IAvt9rt3xk5s5ve3NaTTTgoR+LNB5QwFHeKhZZrJe02Fnyvr4
         z9WFp7e7oamzsSoYoaVSqEt2HovmiWQ6kwm0PI8usMplFEV2xWA5Inard2nZRgp53GbU
         xc5Li7gps6q1gne1iau2qBOZTDaqRwx8/+b47y7umVnNAJhzT7IVOy+bVFlxy3hs5kdW
         4UqAjcQezkdYJ07BFjHcknkFZuu1mE5FHrEowSA19gw/pIV6D3skRiJDeRllxFnKho7g
         +7NA==
X-Gm-Message-State: AOAM5320BGUifcnzrRJe20s5HLesYebbFABst4IBckEMSUL9Y/4JcvYo
        O2CGP27URlavS+BBZ5Jt+AKbl+yl481Zcg==
X-Google-Smtp-Source: ABdhPJxj57Wvw3Ef2mxWUwrJKyYT+8MlqrzPcisrLYXWxpWaCqRqAF5KxoQ5O7mj71qg8fIkORraueQRdAWsoA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:aa7:848a:0:b0:510:44da:223d with SMTP id
 u10-20020aa7848a000000b0051044da223dmr18264962pfn.66.1652723125728; Mon, 16
 May 2022 10:45:25 -0700 (PDT)
Date:   Mon, 16 May 2022 10:45:23 -0700
In-Reply-To: <xmqqpmkg8z58.fsf@gitster.g>
Message-Id: <kl6l7d6ljrrg.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <CAN8jHOgwVF5g=jM_KYT0Oh+j+Lk3qvdyA4zNRbzf8e1Xp5WAUw@mail.gmail.com>
 <xmqqczgzdc1r.fsf@gitster.g> <kl6l4k2bpv61.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqq1qxfbqtq.fsf@gitster.g> <kl6lczghj7tn.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqpmkg8z58.fsf@gitster.g>
Subject: Re: Bugreport - submodules are fetched twice in some cases
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Benedek Kozma <cyberbeni@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>> And obviously, we aren't passing "--recurse-submodules=false", so there's
>> good reason to believe that "--all" will fetch submodules R + 1 times.
>
> Good find.
>
> Given your recent work on enumerating the commits in the submodule
> repository that are needed to complement "git fetch" made in the
> superproject, the above finding raises an interesting question.
>
> Imagine that we have two remotes for the current repository, and
> this superproject uses one submodule.
>
> When we run "git fetch --all --resurse-submodules", from one remote,
> we may grab a range of history in the superproject that mentions
> submodule commits C1 and C2 that are not in our clone of the
> submodule, while the other remote gives a different range of history
> in the superproject that mentions submodule commit C3 that we do not
> have.
>
> What should happen in our submodule?  In other words, how do we make
> sure that we grab C1, C2 and C3?
>
> Ideally, we probably would want to run a non-recursive fetch of the
> superproject twice (i.e. once for each of the two remotes we have),
> then traverse the superproject history to find that these three
> commits are needed in the submodule, and run a single (possibly
> recursive) fetch in the submodule and ask for C1, C2 and C3.  But I
> am not sure if we are set up to do so.  Does the "parent" process
> take a snapshot of our refs before spawning the two "child" fetches
> for each remote when handling "fetch --all", so that we can later
> figure out what superproject commits were obtained during the
> fetches from these two remotes?

I know that we do this "snapshot"-ing for a single process. Looking in
the code, I see that check_for_new_submodule_commits() creates the
snapshot (in addition to registering a newly fetched commit).

I don't think we are in the ideal scenario because we only snapshot when
we fetch without "--all":

  cmd_fetch() > *fetch_one()* > do_fetch() > backfill_tags() >
    fetch_and_consume_refs() > store_updated_refs() >
    check_for_new_submodule_commits()

In the ideal scenario, it would be something like:

  cmd_fetch() >
    TODO_snapshot_old_refs(), fetch_[one|multiple](),
    TODO_register_new_refs()

It looks non-trivial enough that I don't think I'll try to fix this
soon, but it does not look prohibitively hard.

> Provided if we have the "make sure everything needed in the
> submodule is fetched by inspecting the range of commits we fetch for
> a superproject" working correctly for a single remote, an
> alternative approach is to run "git fetch --recurse-submodules" for
> each remote separately, without the "parent" process doing anything
> in the submodule (i.e. you earlier counted R+1 fetches, but instead,
> we make R fetches in the submodule.  It is less than ideal but it
> may be easier to implement).
>
> Thoughts?

The +1 fetch is redundant, so it's probably good to get rid of it
anyway. I also wonder what it does if we don't snapshot the old refs in
the "parent" process. Perhaps it does nothing in the
"--recurse-submodules=on-demand" case because it wouldn't know what
submodules have changed?

Since it is only one fetch, it might not be worth the effort though.
It would only look correct in some odd situation where the user has only
one configured remote, but fetches with "--all".
