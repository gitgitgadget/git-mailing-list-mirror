Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1601EC433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 06:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD0AE6101E
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 06:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhJHGyH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 02:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhJHGyF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 02:54:05 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C027C061570
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 23:52:10 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id a25so16662004edx.8
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 23:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gGLjfFpv8XocPLW8PIxS/zwu+PwXJUhgV19tVCzqPmU=;
        b=HlZmqcnog4L+sFgoPN0fw5Ir3Tu5Y1iAmFEj6356lR0jgmc4Zhx7/sHCoJYt2HRh6P
         J3pBeFuSIgUqjAPej75q3ET9NVUt1oQLINNwrGxrA8Ag1Mg2wK+SLZ/8sna6iDo7jMjP
         4qLeXGqBzgbIqyJ2imCvMfqpjWc8qnlRll5OqWptfvhrd3Dm/jZTV0+li3Szp161apt5
         W4ATGqBdCSEfTs06emTDmVAduX6qHtqMDysm6cMmnol5Iq7P4LqwQOjnw/nUddcD29RZ
         U0Fv0ZBTcKcOIJD4yH5jPLC6ftAIezySleXYNxYV/rQXJBE0Sx2pPMbFvnyOdu4Twlrb
         zfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gGLjfFpv8XocPLW8PIxS/zwu+PwXJUhgV19tVCzqPmU=;
        b=beltKChP9XdHef8Nblqb79XcPngKhWORj2bGYSoDzsCbQbdQODDfoJ5jA/1a9zqdTn
         O+QGS9BrUjW4tROQ23Hk6DTKW/4yx8GcbH63ncoKNWEGoRYz3+ilLlXPP0L108VkETYF
         JoKprsUgnbrZU/1nvJRdKZRvXj6NxyfKjzUIWFzgZmohHpZcsEEbWXKINtphAiMgf31k
         nRPhs9Fepg/kwrGwd9dvpKzVzryQMLzyQC4pUVJUQe9zxM4MV/hTQIrFDPIq2iw6VqE3
         WwEDMm1RzuLZPs5tbdmrRuiWI5z++NeTHrzRK/GtZh4hhpdfKWtZrgSlrd2U+6zkPrZL
         L6JA==
X-Gm-Message-State: AOAM533AWlAbmjnSKn67drDpPARu4+Dz08bCdQLAnwiVv7oNQ2xf16hR
        4OygpYLR/wfYzwmoA+qxasIKMg0462XwFRLCi9g=
X-Google-Smtp-Source: ABdhPJw2m0FcJ7Y1dWxjdt6rRcJxY0yd70srsCUzGToQ0B+bFqkGhjrpyuYAN+WhryYgJAaTwmlfAYN9gGFWd4ZgF+g=
X-Received: by 2002:a05:6402:7d0:: with SMTP id u16mr12625310edy.62.1633675929113;
 Thu, 07 Oct 2021 23:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq8rzhmsi7.fsf@gitster.g> <CABPp-BGuzd_TH57-1RvwJQD5r3S3ZkJcuiPnU8aWee8pgzUBEw@mail.gmail.com>
 <87v92lxhh4.fsf@evledraar.gmail.com> <xmqqilykliiz.fsf@gitster.g>
 <20210928210059.vy5isvmcj75vufdu@neerajsi-x1.localdomain> <xmqq8rzgi8a7.fsf@gitster.g>
 <CANQDOddZ-KYTB4q0nYNDinis8aKktm6Ek6F+mJouTV-yRtTpUw@mail.gmail.com> <xmqq4k9spk8p.fsf@gitster.g>
In-Reply-To: <xmqq4k9spk8p.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 7 Oct 2021 23:51:57 -0700
Message-ID: <CABPp-BE=7+XifO3mAzNB90Y0vatvhwk7wwM4ptBrg79BhiFqSg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2021, #08; Mon, 27)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Neeraj Singh <nksingh85@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 7, 2021 at 3:01 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Neeraj Singh <nksingh85@gmail.com> writes:
>
> > Elijah,
> >
> > Here's a branch of your changes based on the amalgamated tmp-objdir code:
> > https://github.com/neerajsi-msft/git/commits/neerajsi/remerge-diff
> >
> > This commit adapts your code to use the amalgamated API:
> > https://github.com/neerajsi-msft/git/commit/725328fe1d8be8326d2ddef78e164ca21450b100
>
> It seems that the discussion petered out at this point.
>
> Right now I have a version of ns/remerge-diff before this adjustment
> in 'seen', and Neeraj's latest version is kept out of 'seen' as they
> do not play well together without an adjustment like that.
>
> What's the good way forward?  I do not deeply care which one goes
> first, but I have a feeling that the need by remerge-diff that wants
> to discard temporary objects would involve more work to make it safe
> than the need by batched fsync where newly created objects will not
> be discarded but merely moved to the primary store before the end of
> the operation, so from that point of view, it seems simpler and
> safer to queue ns/batched-fsync topic first (especially given that
> it is a no-op until the end-user opts into the experiment), and have
> a remerge-diff that uses the infrastructure from Neeraj's topic.
>
> What's your take on the rebase Neeraj made, Elijah (at the URL
> above)?

I meant to dig further, but nearly all my git time in the last week
and a half was attempting to keep up with other patch reviews.  My git
time is fast disappearing in the near term, and it's not clear how
much, if any, time I'll have to work on patches (or even continued
reviewing) before, say, mid-November.  I most likely won't be able to
do any discussion-prep work in advance of the Git Contributor's
Summit, and might not even be able to attend anymore.

I had looked over Neeraj's patches and they looked reasonable.  I
thought there might be some tweaks that I could try out, but at this
point, just take what he has and keep my topic as expecting an update.
I'll circle back eventually.

Sorry for the delay.
