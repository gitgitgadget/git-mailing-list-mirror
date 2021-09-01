Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFE5C432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 06:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C5246101A
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 06:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242247AbhIAGJo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 02:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242085AbhIAGJn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 02:09:43 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7B7C061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 23:08:47 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id r26so2455047oij.2
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 23:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HdJN15KsQy2Ww56bbdaazevMIx1MXvzubNNFqSTAOUA=;
        b=D3XT3Gsh3uSe5dcG+ktB1ELBWHxYDpZ1hbzG+aGUIAKDwaXcvtBBfieHI4h60WL5xn
         +WOS7OnZRqVYGyZZ/JBwn9pg2bZcapwUO1khuW/VlUwxYQeK7mNGkymu66L2lnCK6dFM
         ssKTvj3RKnJ2Ova2+3MNYFplHQ8cMy2Ol+UYYC6OEaajXXBor6dP7FHK4jGdJe0o2xQl
         L/2m+HqRb0RGWz1xhqO6cUM/VGnDSjCLsWXo+OcJ/RhdMfUGDXcI5UUTFEKY2S5T6gVr
         2LkdQdz88HIMiSWjkPTolcn7j5UHh7mNKsgsurbK193I0xzpVk5LlXkv+2lSJTFaIKcj
         9wmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HdJN15KsQy2Ww56bbdaazevMIx1MXvzubNNFqSTAOUA=;
        b=KFCdZATFZEcbw7o8y41m5lrke8L9J/pq5goNgK3YXraVeSFPjIfxSqphX0spe0ERdy
         ODSSwGyrzOf/zEPZVyzXpNNaLwnIGLaqDatqO8ZGX5sDOh85od+2x3VJZDYUtYUFYWW0
         K9yZVcquVJXPCwbNknoy7VNl1C7DUcdCY86F1mDezo2Nmd9oAdziEluAGfRBpmN1wVYl
         m2I6Iire6Evqi4E9ZVzAamEOxeb2nRFJ+oklEC46DKY1H56h1obKjXToAd8jFA8WXgjI
         9Z7n+RbmFZvfIPsfp6aXAy9MD0DaXISmowU780oeU33KBeNv6jzFm7wrRrgV734TD/wb
         rGsA==
X-Gm-Message-State: AOAM533D8qZiX4ho6+2EQAmV0aTq+YG5R4jn9fmjElKgs5akcO1sHjej
        9fEBQuYO3xiL5PbbrXpS3eLGqmuxjuqdzeHBC98=
X-Google-Smtp-Source: ABdhPJx+4ej2kQLQ7U2q41RBgtzvQz8bjZK8yeMTkzFt142lWvs8P9484TrYU6K9VTYWs9oxA0KD1gLaBs8xWnaRnik=
X-Received: by 2002:a05:6808:1787:: with SMTP id bg7mr5999534oib.39.1630476526727;
 Tue, 31 Aug 2021 23:08:46 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1083.git.git.1630379030665.gitgitgadget@gmail.com>
 <YS3Tv7UfNkF+adry@coredump.intra.peff.net> <CABPp-BFmU+RaAjq4_0-PSfRgH1Jc63nN0fMuDWk2+iDbdz7CCA@mail.gmail.com>
 <xmqqk0k0sw2h.fsf@gitster.g>
In-Reply-To: <xmqqk0k0sw2h.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 31 Aug 2021 23:08:35 -0700
Message-ID: <CABPp-BFET9PhgAh+xvMWzTGD+pW3ujOUXO6JOF1rtFMMpDHZvg@mail.gmail.com>
Subject: Re: [PATCH] rebase, cherry-pick, revert: only run from toplevel
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 31, 2021 at 10:29 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > Ooh, this sounds intriguing to me...but what if we changed that rule
> > slightly and just decided to never make the cwd go away?  Currently,
> > the checkout code removes directories if they have no tracked or
> > untracked or ignored files left, i.e. if they're empty.  What if we
> > decide to only have remove_scheduled_dirs() remove directories that
> > are empty AND they are not the current working directory?
>
> Is that generally doable?  What would we do when the directory the
> subcommand was started from (or one of its parent directories) is
> not just missing but has to be a file in the revision the subcommand
> is trying to checkout?

The same problem (an untracked directory is in the way) already exists
and has to be handled by all relevant subcommands, right?

In particular, if the current working directory only has untracked
files in it, then the directory cannot be removed.  That will prevent
us from checking out the revision we want, so we have to throw an
error.

So my idea just piggy backs on that, resulting in the same error also
being shown when the current working directory has 0 untracked files
within it.

Since the whole thread started from, "maybe we should throw an error
instead of continuing if it would result in the current working
directory getting deleted", I believe this idea does exactly what we
were looking for...and nicely tailors the new error cases to precisely
the situations we wanted them for -- when the current working
directory would have been removed by the old code.
