Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE56DC636CC
	for <git@archiver.kernel.org>; Mon, 20 Feb 2023 16:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjBTQ4n (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Feb 2023 11:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjBTQ4m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2023 11:56:42 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E554D1CAD6
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 08:56:41 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id bh1so2170158plb.11
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 08:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1676912201;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TXd36uWO4DeGJEyPs6XgA6nqp11BNdDdlKRU22gzKxw=;
        b=S4N9n+PKAGtEuAjtJTnkFjMRqGzKhYSuzfw5KFQ6NPDpzzS0sDT2kN2kmJTEobCZUV
         tMLiEfeCzozOsaUh1TYf1l6htxMTaesFSZ4+fnikHUUWYQjtHGCY+nQagUclA2hUHsCa
         3PkFSmI5x6O7sRhvoJ90VB9kZgC/W2iFppGf39eGVcR+08oGKDFUKVVAN2Vp8WTZLvaT
         bANKkrco66cvVvQQNISvhZk5lnsjinRPBubr9IdJfBbE2bbbEb10KYa2AeYV/HUtGljH
         WCdf/UAyAcd4UTkjeFxo+HnEeeY4G/gdsdoSp/+zXPZhMO1i40OhovF/mEkGzoLo8Wto
         AUEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676912201;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TXd36uWO4DeGJEyPs6XgA6nqp11BNdDdlKRU22gzKxw=;
        b=VmFYhnqIErINzIhPkO/pQV3PPnOjAqsti3BKjhmWJPgGZYpHvM4FNCwP3v6YFXYof4
         DxoBxpXz9XBl0HSwSuuthtzvsunK6pRfRv5c7Q5b+yKP5hAA4Bwy1MzYoB2Zh9I5F8Uq
         nokKlt9p/Lo0XZF7GOUFWMhtBXr0o2S26dCoW120N4DMXqz1iwM3kK+2UvOOw+BUzhVl
         x2Xp4YgfkU49AykhOt2/hDiM9NDqvcqCl4nGIv8GKiyEgzP4tPwv4vuOwcNex9ae57Sn
         hIdxIr3vShpfZ2BKztzyqnajLLIBLacdJxKnEUsl3gI7hhtU/5pcRnKZStq5/KmstQ4f
         zvCg==
X-Gm-Message-State: AO0yUKVOkR8wO9HMGQM+Xf12/DkRVgxys/uTVAsxbKD8tJAItqKLyI/D
        FhLpXtSZl+NrdpJf+Cvv2jNH7tMElfXwT0Xiebk=
X-Google-Smtp-Source: AK7set+lhe70aWW8ZT0STDM/r0bjiUvewYLVUUEE1UVbl0+bc/psDEn6yFYH66URr9rDhLV23YPxBR0GlQT3lJDm1qQ=
X-Received: by 2002:a17:902:7683:b0:19a:9739:b597 with SMTP id
 m3-20020a170902768300b0019a9739b597mr223586pll.16.1676912201197; Mon, 20 Feb
 2023 08:56:41 -0800 (PST)
MIME-Version: 1.0
References: <pull.1474.git.1675614276549.gitgitgadget@gmail.com>
 <CAMMLpeTPEoKVTbfc17w+Y9qn7jOGmQi_Ux0Y3sFW5QTgGWJ=SA@mail.gmail.com>
 <CAPMMpogFAR6cvcR8T5fx+AoytAJ7TsPpSeOjHNzW4Gmkuq7FLQ@mail.gmail.com>
 <CAMMLpeTQ1RpsvwRdZ0G3wdvH1+LXE5tw=7Cs6Q+HxMcRU0qj5Q@mail.gmail.com>
 <CABPp-BFxGYQ_JTC5c4_S_gOK3GxWKuZ=KfvycpkBjPGyKzCJ+g@mail.gmail.com>
 <c3ef69e0-c37a-01fe-a40a-c2940e329793@dunelm.org.uk> <CAPMMpogi_QoGKD824JW+85v_Sgaf5d3TAd_P55YyT5NF6AUJ=w@mail.gmail.com>
In-Reply-To: <CAPMMpogi_QoGKD824JW+85v_Sgaf5d3TAd_P55YyT5NF6AUJ=w@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 20 Feb 2023 08:56:27 -0800
Message-ID: <CABPp-BFhvX6eg04+qTk7P64NfmUKnCTV7o1ufp447z6-XdUcJw@mail.gmail.com>
Subject: Re: [PATCH] pull: conflict hint pull.rebase suggestion should offer
 "merges" vs "true"
To:     Tao Klerks <tao@klerks.biz>
Cc:     phillip.wood@dunelm.org.uk, Alex Henrie <alexhenrie24@gmail.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 20, 2023 at 12:03 AM Tao Klerks <tao@klerks.biz> wrote:
>
> On Sat, Feb 18, 2023 at 5:39 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
> >
> > On 18/02/2023 03:17, Elijah Newren wrote:
> > >
[...]
> > > My personal opinion would be adding such a capability should be step
> > > 2.5 in your list, though I suspect that would make Tao unhappy (it's a
> > > non-trivial amount of work, unlike the other steps in your list).
> >
> > I've got a couple of patches[1] that cherry-pick the merge if only one
> > of the parents has changed. I've never tried upstreaming them as it is
> > only a partial solution to the problem of rebasing merges but that
> > approach should work well with "git pull --rebase=merges" as only the
> > upstream side will have changed (when rebasing my git integration branch
> > with that patch the merges are cherry-picked). They might make a useful
> > starting point if anyone wants to try and improve the rebasing of merges.
> >
>
> This is awesome!
>
> It feels like the first step towards the general strategy that was (I
> believe) best described by Buga at
> https://public-inbox.org/git/a0cc88d2-bfed-ce7b-1b3f-3c447d2b32da@gmail.com/
> !

The strategies described by Buga and others in that mega-thread were
suboptimal solutions, in my opinion.  Johannes went and implemented
some and found them wanting; see the thread over at
https://lore.kernel.org/git/nycvar.QRO.7.76.6.1804130002090.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz/.
There were follow-ups with an improved strategy in the thread over at
https://lore.kernel.org/git/CABPp-BHWVO5VRhr1-Ou60F1wjKzJZ1e_dC01Mmzs+qB9kGayww@mail.gmail.com/
(Note that this route has also independently been discovered and
implemented in jj and found to work well, though it does handle
conflicts much differently).  And I've since improved the strategy
further at https://github.com/newren/git/blob/e84f5f3585fd770ed21f398d2ae5f96e90a51b1e/replay-design-notes.txt#L264-L341.
However, note that this isn't a case of merely performing the proper
series of merges, it needs some specialized logic and some new
capabilities at the xdiff level.
