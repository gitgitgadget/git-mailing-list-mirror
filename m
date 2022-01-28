Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBEFC433F5
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 02:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345178AbiA1CEa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 21:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235461AbiA1CE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 21:04:29 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFAEC061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 18:04:29 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id ka4so10742481ejc.11
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 18:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dSZDR/Gw0zezuW6QZBj0RFEowkhZWJ0OYuwm34Bnfvc=;
        b=F8Av0Lc+Rf+9gFCoV7n+KQS8GNxrsOguyNUUvIcWDPgfbER+Qloe0jpW70GExHTr9U
         yJDyswix0HfjkIX0+/NIznvnzw56z73Vyn6ebBZheFYJmsoz0YvfTuYwTa3MywJtXPUx
         f5diISQvqj+F2DsQEmS9PyW5MNRmS9oTfPJbgW/cG1nEC7E/D/xg6FGXrPTq8ogzh0gT
         tIyTCYTXM5IPljUX8ysi2tl1/7BIyBK62FM1UzNsXeqzAyomvmEAQdu09gDN9VCXDaL2
         NsquUhsMCKqBSqPWaJt7xG277IBldo0WaLp8/eCSvHcewpAnVVFA6sWSwszrpJEWJXfa
         nZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dSZDR/Gw0zezuW6QZBj0RFEowkhZWJ0OYuwm34Bnfvc=;
        b=Z9QKlxN3qYOkrHnC25KdK2CAofKHc/KQst3MkRnOUDyEmqIIRls+QigObmxv8X0gBG
         hJzITMOXmaWIl9atFONZHca/21UAQuRJlLSOceePbX6NUK6mlqxSMNRU8r1B238n2OL8
         ZIe72laa4OoXQD3GjE3Vse4ys27gBPH0JVArz+7VR9lpZQBctJ0k3MUJ/aAwCpWfDUyt
         zH7Suk/xjcmtO+nWFtTLhbFqFFAgcT+jDjzXhqNw/gW4mNXjWm0vvcI2xD/kXItCrg16
         42tJTcOi5luRgvPnh9ayUXKezqQO6XPhbo0Cc+T4q3KkbflLOsMlSKbbscLK6t8ntpa2
         jDvQ==
X-Gm-Message-State: AOAM530ryaSm/drttlUTM/Cs3sdJ393COphY4Yu9RBmzX1pVgpI8MiVS
        EhRL5VU4lw8jmRtZmi6QcLfI6iSoK911Gmiv85Q=
X-Google-Smtp-Source: ABdhPJyP9eWJNsNrvMAakVz/LkUw3rGtBAenaJKNnfEpTtqHH1mpqnLMpn7sdB2hBqcJt0DtrkoSDZa29n7mSU+A2j0=
X-Received: by 2002:a17:907:7d88:: with SMTP id oz8mr5235853ejc.328.1643335467885;
 Thu, 27 Jan 2022 18:04:27 -0800 (PST)
MIME-Version: 1.0
References: <pull.1108.v3.git.1641841193.gitgitgadget@gmail.com>
 <pull.1108.v4.git.1643318514.gitgitgadget@gmail.com> <5bb598a055dd8121ad5c7228b11618b037029478.1643318514.git.gitgitgadget@gmail.com>
 <CABPp-BFdaLpmcnU2DUy0Wx1rapsWckz4=aG5yTGdCcM3U3on8Q@mail.gmail.com> <xmqqtudoy653.fsf@gitster.g>
In-Reply-To: <xmqqtudoy653.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 27 Jan 2022 18:04:16 -0800
Message-ID: <CABPp-BH0ED=6+tcjaxDFypdopH3LtQsDYWbBUW0B9icZjTGMKw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] completion: add sparse-checkout tests
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        johannes.schindelin@gmail.com, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 27, 2022 at 5:56 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Thu, Jan 27, 2022 at 1:21 PM Lessley Dennington via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >>
> >> From: Lessley Dennington <lessleydennington@gmail.com>
> >>
> >> Add tests for missing/incorrect components of custom tab completion for
> >> the sparse-checkout command. These tests specifically highlight the
> >> following:
> >>
> >> 1. git sparse-checkout <TAB> results in an incomplete list of subcommands
> >> (it is missing reapply and add).
> >> 2. git sparse-checkout set <TAB> and git sparse-checkout add <TAB> show
> >> both file names and directory names. While this is the correct behavior
> >
> > s/is/may be/
>
> I would stop at "this may be a less surprising behaviour" without
> going into "correctness".

Ooh, I like that wording even better.

> >> +test_expect_success 'non-cone mode sparse-checkout uses bash completion' '
> >> +       # reset sparse-checkout repo to non-cone mode
> >> +       git -C sparse-checkout sparse-checkout disable &&
> >> +       git -C sparse-checkout sparse-checkout set &&
> >
> > Can we add a --no-cone here in preparation for the default to switch?
>
> It would be good to do so, if we plan to switch the default.

We've talked about it for a few cycles, so I created a patch series to
do so.  But it depends on two or three in-flight series (from
Victoria, myself, and now Stolee) to avoid textual conflicts, so I've
been waiting for those to settle.
