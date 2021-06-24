Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C94C48BC2
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 03:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADBC0613A9
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 03:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhFXDki (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 23:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhFXDkh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 23:40:37 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13FBC061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 20:38:17 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id r5so7800859lfr.5
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 20:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aDuEBSKvX4dzh5O1UaN+O4jRKNtp9T5yxcAHrFhZ2qc=;
        b=kjngEdZwazL/ImGEl0X0XaJPXxhneLkehiYTKQLgqZIvbuPPLPL7fxTzxG2Olcfl61
         hYtURVoSk6oeMou2L1bYd6nqgqY9f3gf+HsQO7dRYYOpl8dMMMAafIVIS8GbtYWpoLSm
         O5PopIVH9m+9JF2uVuRFiaZopLpev9d6U+RPSWmwZxNYXliR7R9SZPu62sCZ2aoI3qqv
         aE+k+BzCKFP8rLjsN7voenvdTU2cGugyASKLLsuQkTKGUKTvYt+K/d8FDJRC8Zx/qLVa
         q/kTwpStUrZ4FHZXiK7ANANAjnVUy2XSxQAPxlyJMluO7oou3qJxvTO1LaHbZ5dcUeK2
         1cQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aDuEBSKvX4dzh5O1UaN+O4jRKNtp9T5yxcAHrFhZ2qc=;
        b=T42i6GTNWIynnmt1SllaZ8lpkXjAWIxACOeCMI5K/aJoCwc19bUf5bhquI40aN8qIy
         AHXbvb3pxj0DBG2jTU7hE3evcKb47WsfCJa+c9PaAnegtbWH6Q3uNSwVIRqGzRu3OLfD
         OqgMzrqjpOm38AmpGByxZSKzfEnsW6AwDMCEVTCyo1B5bfRjdaZeGnrpjjzBYn37tBsn
         0+bG/zXN/LS3Mr4J3uLPEjyRv3Ojq9tT0AINQaWKMGZtMHz4A7Y+IcB+JZcP9iwx8h7I
         ajxITs5/5aCpesAFcZ20sML/dINiJe2yNtPAWfj8Vlq4ViBiqyvlbcY5Y9dZk9doatQ4
         GDHg==
X-Gm-Message-State: AOAM530IGzJ1HnCq4Xqs8/ALvSQWUWAz0lP5JWDp8v/eHlaIeNAFzwwU
        AMqkA92bI3D3LNL1MaSg9NXjiFdnR3yk9Lyq9vY=
X-Google-Smtp-Source: ABdhPJxo24fpZkPCtuaNtabIirjah4pU8At4lH5F8HLqjsjB9BDdRlSL+v25L/BS8VSzUtE+/0t6QAEiJHCrwiNcnFY=
X-Received: by 2002:a05:6512:1381:: with SMTP id p1mr2160352lfa.367.1624505895147;
 Wed, 23 Jun 2021 20:38:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210621175234.1079004-1-felipe.contreras@gmail.com>
 <20210621175234.1079004-3-felipe.contreras@gmail.com> <CAMMLpeR2Y_EGwqGJzghSQ1DzpYQyWr6ENmGCvPRdhhYFkTW4yw@mail.gmail.com>
 <60d0df99d91e1_108e902085e@natae.notmuch> <CAMMLpeRnUC+nOek=Kz6bj0_R6EUaDr=7ObKF01V641_ByOmk6A@mail.gmail.com>
 <60d10ebd99d86_113139208cd@natae.notmuch> <CAMMLpeRa3atkZxEtV--YD6-JSf0Bp9xRw9kS5wSWerxpsGrvrw@mail.gmail.com>
 <CABPp-BF1noWhiJadHzjJmnGo8hdZj6Fk7XnZ=u6BVVSGfHE7og@mail.gmail.com>
 <60d289c84fadf_312208dc@natae.notmuch> <CABPp-BHSxNT0rG3LMrDVH64mBwTgeF197oZFnbHvvKk=SB--WA@mail.gmail.com>
 <60d37b3b77aeb_378720834@natae.notmuch>
In-Reply-To: <60d37b3b77aeb_378720834@natae.notmuch>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Wed, 23 Jun 2021 21:38:05 -0600
Message-ID: <CAMMLpeTQjw0W8ZTegPru_9muRBGj7RDfk3WgEEN34vm-PG9Jfg@mail.gmail.com>
Subject: Re: [PATCH 2/2] pull: improve default warning
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 22, 2021 at 8:20 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Tue, Jun 22, 2021 at 2:22 PM Alex Henrie <alexhenrie24@gmail.com> wrote:
> >
> > While
> > we're on the subject, do you have any thoughts on what (if anything)
> > more should be done before making the switch to aborting instead of
> > merging with a warning in `git pull`?
>
> I think Junio already answered that over here:
> https://lore.kernel.org/git/xmqq360h8286.fsf@gitster.c.googlers.com/
> (he discussed it multiple times in that thread, but hopefully that's a
> good enough example).

Wow, if I understand correctly from that message, Junio wouldn't mind
making the switch right away. That's very encouraging.

On Wed, Jun 23, 2021 at 12:19 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Similarly, until "git pull" does something sensible by default (which
> isn't the case now), these debates will continue, and there's value in
> them.

At this point, I'm inclined to push for s/advise/die/ in pull.c in the
next release, without a transitional period, just to end the argument
over how to best explain the current awkward situation. (I'm sure
there will be more arguments after that, but hopefully they won't be
as tiresome.)

-Alex
