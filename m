Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AA7C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 17:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D57D60C51
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 17:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbhGWRGm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 13:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhGWRGl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 13:06:41 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C40C061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 10:47:14 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id f20-20020a9d6c140000b02904bb9756274cso2819482otq.6
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 10:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EDv5P20YI9hzajJpphk1fj1YvSOlhxTTz2iHk6JtT+c=;
        b=LavrlLdk7NDu0xjjqb90QM79e+dG1yQNB82bN8TjhxEKvXrBg9KHkAliv/N4u/kxdF
         JvY4hXBOAfWBczDikb/MhKZwEfv/atZYrQHKQ1EvLQLNPOnFLtj1E1Fl9hPlZCloNLGm
         ZAvuWS5TG+pHL8RVFYt2FJGoDoqnrEswGN/3MXtqPsQp23rsxyjhu8FazFmG5thnlXju
         l0NJfIRqdjr0IdgM8U3bzK7vLXitoLWE3uE2HtmpMGapT6VJgk43rbxiW/68oinLNg81
         Y4FLaQdpEP10+zQXLG24OF5x7HLLDpzlG9uevGlFH8HIQuC9Vzfc5kq5/wYx2vgemMni
         sgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EDv5P20YI9hzajJpphk1fj1YvSOlhxTTz2iHk6JtT+c=;
        b=f9bv5iBdnuEi846BqcqT7L4ze3XhIBe7wIlUAo5yPsBkg6u5X+s6MwzdCGW0psBiKG
         b/5sPZoFXcawa+4URKka28U8cFaoVGqeWEY5afF5sjkI9CrijnaTK9xQ4M6awBRzaev8
         pNX1Nc4emywbfr33dRJllqwY4/TYcTLKF1I/hDMje+DWiK0cP/ZxnlFRXfDPNeafzFp0
         SzuHw90b3dUE2XT3J+3+O2wkLcDuZDGfvDQdIxfCYhHGhos052olt8ReA9LLmVsadL+n
         Uzr99UlEL90Iby+YzjubcCfosIj9EDVnOS/lBzze60YCF+uhA1P2d5d4rup0kyhRMgDq
         pdWg==
X-Gm-Message-State: AOAM53217+eig6gb3XdSG+wLSzOltQI+DJINblaLeZak3QEgG28nhPZ/
        qfrvoTc4/lswsZJz/Ya5HsJwntl1HzGGLwNYMJo=
X-Google-Smtp-Source: ABdhPJwV9p79L/8qQBkAJYdA2a/wrMBZRy8lbLo3+UAJQqErCf6gvJITRYLa/XJG5oFw1uGQp1OoknQSZnPZV37x6EA=
X-Received: by 2002:a9d:5a8:: with SMTP id 37mr3873629otd.345.1627062433387;
 Fri, 23 Jul 2021 10:47:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.999.git.1626901619.gitgitgadget@gmail.com>
 <a763a7d15b8e92dec61c1fa328ecb647b6f61682.1626901619.git.gitgitgadget@gmail.com>
 <CABPp-BF-UVZKWmsohjCzRLpbHZii+1g=SShEYg_cwScsOHi=5g@mail.gmail.com> <CAPig+cQwxXGmN=exrr9YN174LXDuHU2yH847uOCzQQKsTEVWtg@mail.gmail.com>
In-Reply-To: <CAPig+cQwxXGmN=exrr9YN174LXDuHU2yH847uOCzQQKsTEVWtg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 23 Jul 2021 10:47:02 -0700
Message-ID: <CABPp-BEBD_4j+r2nVGrJgEPBYUPoUfZ839w_oZVnUSYofVDhLA@mail.gmail.com>
Subject: Re: [PATCH 1/5] t1092: test merge conflicts outside cone
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 23, 2021 at 10:44 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Fri, Jul 23, 2021 at 1:34 PM Elijah Newren <newren@gmail.com> wrote:
> > On Wed, Jul 21, 2021 at 2:07 PM Derrick Stolee via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> > > +               for side in left right
> > > +               do
> > > +                       git checkout -b merge-$side base &&
> > > +                       echo $side >>deep/deeper2/a &&
> > > +                       echo $side >>folder1/a &&
> > > +                       echo $side >>folder2/a &&
> > > +                       git add . &&
> > > +                       git commit -m "$side" || return 1
> >
> > Why is this "|| return 1" here?
> >
> > It looks like there are a number of other cases of this in the file
> > too, which I must have overlooked previously, because I don't
> > understand any of them.
>
> A shell for-loop won't automatically terminate just because some
> command in its body fails. Instead it will run to completion and
> return the status of the last command of the last iteration, which may
> not be the iteration which failed, thus a failure can be hidden.
> Therefore, we need to proactively stop the loop iteration _and_ ensure
> that the return status of the loop itself reflects the failure, which
> we do by `|| return 1`. (If this loop was inside a subshell, we'd use
> `|| exit 1` instead.)

Ah, thanks for the explanation.
