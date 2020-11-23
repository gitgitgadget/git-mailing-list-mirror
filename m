Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1737C63697
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 22:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 565A1206CA
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 22:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/Q4XMod"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732234AbgKWWDW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 17:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732203AbgKWWDV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 17:03:21 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22424C0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 14:03:21 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id u19so25991027lfr.7
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 14:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fkUqMcD9SAEv0lRpG3DC3fBhCozhpLiE1K9s/h8obj8=;
        b=L/Q4XModx1MM2SwXJYrPIModNMOUZjmxbc6s9VY6IRnjKNBGYEP2IKqqJtd6bveYMs
         +WjX72xvRBWbY6wdbWyhKSWnWiDyICji3DTq0uZG5sV/0wlbjCUV6uOfwV1MBqR45tmE
         s43G/Li5htFgGlPQGX/2Um8FLAU844HIXJ1UtKuf4BBbgHYecQFRxmIvXNU6EjeYVxli
         zdJM5tJXu0WUSF78mu6QT/xlkH9keca181bYmxcVdCgoY6oLB3NjensM5TYCLUntgSpe
         Fivqo1RFGkm5x0yNAeyMRg8J+krrh391O9CjbE/5c/QVul46XkcZlL2/1huteC2rxno4
         vNjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fkUqMcD9SAEv0lRpG3DC3fBhCozhpLiE1K9s/h8obj8=;
        b=LLAuVRQBitTvb8xEvaDMRlVhjAy1fZuzHHEKzJdcoMEqxBGrM3xxJdkDIDVDQ/gdUC
         v/M7an+zW7UrbR21ZrgFlDucjAzsv17+nJ6zU7l5MoSeYupRCWFM9v1G+AXoBKFqnH8x
         XcY+tZhtXBh3qhf/duoCQuJosvT86D7GapQuo0EUA3yA40Hw9gPon5+rWF2gf3fB5GLX
         DTjEmmqLH+xfJoQ9xSYIYexZbcDFKwPy+gAvxXPaXZhI3RZdqeGHD2A8YB4QanAPauXb
         f332rYA+Uafrr1ZNY4C37dWvdmVGbv2oikJTmnLZlmmqufuf05p/7MzlPP6HH+hmw8CV
         6vtA==
X-Gm-Message-State: AOAM5323tYaeofrSyQ5OntnzeuGXtku6KBoe8FxfOTbpbXeoxZQaWIj8
        kAaVCjGCimnH6RIbTJkAZ0AnbhwT8ScdFtRPO3/uXHaHXfg=
X-Google-Smtp-Source: ABdhPJy8R2CKLj2rqwIRxLeNMb9ggdX9iTorgS0wYMxBzcaAh4ScSfzK8nsFOLk31bsn1XP7iY6IwwsC99VyMIOUUaw=
X-Received: by 2002:ac2:5475:: with SMTP id e21mr459773lfn.153.1606168999553;
 Mon, 23 Nov 2020 14:03:19 -0800 (PST)
MIME-Version: 1.0
References: <742df4c2-2bc5-8a4b-8de1-cd5e48718398@redhat.com>
 <CAMMLpeRLsE=zNDjCRKmEMFxJBYcnTOdDGxEL9cZuVhuDMF=sLg@mail.gmail.com>
 <20201123191355.GA132317@mit.edu> <CAMP44s3cKVxKa0gOPfi3XRKbGbV=DweFE5pL0HM+v0kECFyPWA@mail.gmail.com>
 <20201123202003.GB132317@mit.edu> <CAMP44s27oEjScrJjeDVoNcWcvRsn173L_Kx+TOPfchOwge9zUQ@mail.gmail.com>
 <X7wuMvHRURK1QS/Q@coredump.intra.peff.net>
In-Reply-To: <X7wuMvHRURK1QS/Q@coredump.intra.peff.net>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Mon, 23 Nov 2020 15:03:07 -0700
Message-ID: <CAMMLpeS2e2dFjPHC7N5O67QTo48cpvWEHiU8E55w9YYP4MU0MQ@mail.gmail.com>
Subject: Re: Pick the right default and stop warn on `git pull`
To:     Jeff King <peff@peff.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 23, 2020 at 2:48 PM Jeff King <peff@peff.net> wrote:
>
> On Mon, Nov 23, 2020 at 02:34:18PM -0600, Felipe Contreras wrote:
>
> > > > Which is why I suggested to make fast-forward-only the default:
> > > >
> > > > https://lore.kernel.org/git/1398988808-29678-1-git-send-email-felipe.contreras@gmail.com/
> > > >
> > > > In what case would that default not be what most people want?
> > >
> > > Well, it *was* the default, previously, IIRC.
> >
> > There has never been a "pull.mode=ff-only" option; that's what I tried
> > to introduce.
>
> There is pull.ff=only these days, which also squelches the message. But
> you're right that it was never the default.
>
> The default has continued to be merging. If we were going to switch that
> to bailing out and doing nothing with a warning, I agree that doing so
> only in the non-fast-forward case would be much better (because in that
> case, all three modes have the same result).

I'd be fine with making fast-forward-only the default. But then again,
some users like to set pull.ff=no, which creates a merge commit even
when fast-forwarding is possible. The existence of that workflow might
be a good reason to require the user to always be explicit.

> I don't recall whether there is any active plan to move away from the
> merge default, though.

There's no formal plan yet. I didn't want to propose anything until
people had gotten used to explicitly setting the reconciliation
strategy. However, it has been on my long-term radar ever since the
warning was added.

-Alex
