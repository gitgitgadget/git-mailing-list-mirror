Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA07CC433EF
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 15:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0E3961166
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 15:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239191AbhJFPDM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 11:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239125AbhJFPBM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 11:01:12 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DBBC061760
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 07:59:19 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id d8so10943268edx.9
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 07:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z8iixKXELMTWlZdJtmkP8lSyc//nzf9HzxWcj3KBPsU=;
        b=bb/c/Y74gG5PnuSBOoGuATze2NMBvlXYVJTHyHhhq4UOjd43fr0LPviFccq5Rn1qF3
         gDYMhkEFo+H/lvGhjxZKefHglTK7812xB0pN84FgGsN30qPgTwQozQeWBcg9fFX3Y1tS
         MtVN2qfOlTj8DqoGfKEn5pN302UTFsUxHLkGqU90xXXpHwTD0/8inM11L/O3cKk+WZxL
         cq5NB48m5v9jbaKFdstz0yqgiyG5X6/SW03GTkw+PRNXg08qDrrEhLMLL5Prn486bDc4
         qzgoJIhW+nF5O29Ygzhh+vreAh4bj2cUtBYzIv3a8rEqH2YzJixYjZUCnYlMF/Y2L+Q1
         NgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z8iixKXELMTWlZdJtmkP8lSyc//nzf9HzxWcj3KBPsU=;
        b=noJwktZn4sGt9AG3Mf5mXFM4iWlNneS400gQoFuREMBcA4MzFRIzzX8BuYdHMTffRc
         WV4dYM80pVdS4+/8Q88N12GlUvKPEIH3s4u2smeFo9wE7H6pP1cDKn3LVCeN6oekF9qh
         UhKrKUSSsXrlVebAGdd4ICbN2jwQTT//+rSOshpvRq7FTJzQEnoPux0nNZ17JCjtAMHz
         yd9ljMMpKE+P0suemOe1wyUcDMANVR+cDVWfC8c/soNdCMopZm5GoQqvCV7G78BcQPaW
         g35qQHNMniSSD1hHFpZh8ay9YxaPjoeYyBLyvVPLzPj1KVdmNfRlM9CazxLqFeaNojPD
         aKzw==
X-Gm-Message-State: AOAM533XEL2I+qAA/NPKG7aSQmAyYZdZ4e5d6NFRuDPndRN2bHK0Hanw
        fDOykX4uDzcowjq4FG8Nm2358wQmODAhrxfWIDTzXIT1gUM=
X-Google-Smtp-Source: ABdhPJyU6kte1ZQ/wKZRqjFiAjlbb2QduPi2R4BANqIS96UraLD7v8XtRrAQlzF+eiQ2N9paLrmAUzDIHKxyMmt/y4A=
X-Received: by 2002:a17:906:38c8:: with SMTP id r8mr32485265ejd.172.1633532333638;
 Wed, 06 Oct 2021 07:58:53 -0700 (PDT)
MIME-Version: 1.0
References: <9e4411aa-e757-0653-0c2a-24894b13158f@gmail.com>
In-Reply-To: <9e4411aa-e757-0653-0c2a-24894b13158f@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 6 Oct 2021 07:58:41 -0700
Message-ID: <CABPp-BF8R-i0CnYE9mQjvwTWuZCgW0VsTTajWTpi15fk9F48Lg@mail.gmail.com>
Subject: Re: Merge ORT performance in the wild
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 5, 2021 at 12:42 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> Hello all, especially Elijah.
>
> We finally shipped Git 2.33.0 (with VFS for Git) to the Windows OS
> engineers, and the microsoft/git fork enables the ORT merge strategy
> by default in this version.
>
> I know that we are queued to include the ORT merge strategy as on
> by default in Git 2.34.0, and to further support that change (and
> thank Elijah for working hard on the feature), I wanted to share
> some early data on our users interacting with it.
>
> We have about 250 users who have upgraded, relative to ~2,300 users
> who were active on the previous version. However, we saw sufficiently
> high use of 'git cherry-pick' and 'git merge' in these early users to
> share these results for how they are experiencing the new world:
>
> | Builtin     | Percentile | Recursive | ORT   |
> |-------------|------------|-----------|-------|
> | cherry-pick | 50         |  18.4s    | 14.1s |
> | cherry-pick | 80         |  34.9s    | 15.4s |
> | cherry-pick | 95         | 117.9s    | 17.7s |
> | merge       | 50         |   7.7s    |  1.2s |
> | merge       | 80         |  17.9s    | 12.7s |
> | merge       | 95         |  58.9s    | 22.3s |
>
> This matches the results from a synthetic performance test I ran
> in our monorepos: ORT is always faster, but its outlier performance
> is far faster than the outlier performance of the 'recursive'
> strategy.

Great news, thanks for sharing.

This is basically just testing one of the optimizations, too.  I'm
still curious what the performance difference would be on your large
repositories, comparing git <= v2.30's recursive (i.e. before my
optimizations, some of which benefitted recursive) with rename
detection _not_ turned off, and current ort.  I suspect you'd have a
hard time convincing users to use the former, though.  IIRC, Ben
reported one example merge took on the order of an hour, but I don't
know which repository that was with or if it even had many renames.
Anyway, it's nice to know that even without the consideration of
rename detection in the old comparison numbers, you're still seeing
nice speedups.
