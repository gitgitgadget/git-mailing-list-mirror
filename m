Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF76C04FF3
	for <git@archiver.kernel.org>; Mon, 24 May 2021 20:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8C5A613CC
	for <git@archiver.kernel.org>; Mon, 24 May 2021 20:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbhEXUTz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 16:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbhEXUTz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 16:19:55 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A911CC061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 13:18:25 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w12so25664130edx.1
        for <git@vger.kernel.org>; Mon, 24 May 2021 13:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tV9nBwqBsV7RDnCeAPX+yz4vWtKLqY6+P1LFbw5dCcA=;
        b=mN4Jz9Ff1s3bLmyxiJttHSSTBZX9UYpHQhkWvoLwTvOWghp7NiSm7/avW/scIEPEAz
         6pTNUdpMxLcRNrncXF9e7yIzJehOwruDtCG99qBneOuEB1fz8Ti57sZLj2j9OWUcZroA
         xJs6Lj+5VKJXRg8F1O7lXpuLrD3/8R5SeQZc81irrg3V2hSFIC2f48Bb3pARZbQxnijv
         HFdBQIdn1MruAdC/96I7a69cLdjneratgK1x/AAgDmTyY7tVi3eVqzVVL9KKIIVzkn1B
         Ysrwt2AvOuayb+kVlhU8tXRFgEPovkIhNatyi1+mIHlcRTV4W4KJJgz8nJffB3D0QCvV
         P1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tV9nBwqBsV7RDnCeAPX+yz4vWtKLqY6+P1LFbw5dCcA=;
        b=WJKlu5rFmvusxgXY3F/Mw0hRd/u2JmuNJRV660VyNkg+HN9IEnTXgQy9aZtOrqd8x0
         9/gn+m7Wmy4ux+vnZwVNaB9Wrcdzb0rqtsSry/uttlCd1bipTU0wNMzw37upqAnKU/Jk
         IdN0NHch4uBGZizOx3XZm9Bxx0+Q3CsABIzqstzAF5B4wZcZf+aDDpbCksEjhsOL0Z7O
         mhthwVcXX3FLVqb4/lTTxZPc+Y6WcgLe6bDj1tRtYwbsWChJDotjAkW/AjqlsLjZeVOn
         VKDxjJ2F0JOixw1KFXcCjnSA1G2/f3dxsq1v7vzUSANrMkbB27j5/T1PldaRFLxEPVRq
         DqPw==
X-Gm-Message-State: AOAM533mZcgb82i9x2pe2czULvN8bIaT8lWteUkCAPruPmq65CxdAYf9
        x2AIMLWRzEP11tmyIpGWkdVAgLGZCw7/N6/Sge0=
X-Google-Smtp-Source: ABdhPJwkXM17BexEtFDJ+4GCNlvzx2tSckXV2tRr3uMyJ3JSIieLPelLEIWP5k8fvL3O4xQAKTwZlXJwL7Ic4DtZBrM=
X-Received: by 2002:a05:6402:1d2c:: with SMTP id dh12mr24526811edb.237.1621887504306;
 Mon, 24 May 2021 13:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <35493133-2504-4CAE-B700-79EAB990DD17@gmail.com>
In-Reply-To: <35493133-2504-4CAE-B700-79EAB990DD17@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 24 May 2021 22:18:13 +0200
Message-ID: <CAP8UFD1P5tnDtuzBgvHL+dZMWNKoGQpitZGyYAy8qcaDUnouFg@mail.gmail.com>
Subject: Re: [GSoC] My Git Dev Blog
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Atharva,

On Sat, May 22, 2021 at 6:42 PM Atharva Raykar <raykar.ath@gmail.com> wrote:
>
> Hi all,
>
> As is tradition, I have started my weekly GSoC blog :)
>
> Here is week 1: https://atharvaraykar.me/gitnotes/week1
>
> I shall be sharing my progress, thoughts, experiences and any
> information that might help future contributors in my blog.
>
> After my GSoC period, I hope to convert it into a blog that
> will help pull in and guide new contributors to Git development.
>
> Any kind of feedback will be appreciated!

Great!

I found only a missing "how":

s/as I have not yet fully understood config handling generally
works/as I have not yet fully understood how config handling generally
works/

> You can find the listing of all of the posts at
> https://atharvaraykar.me/gitnotes/
>
> I will update this thread every week when I make a new post.

Thanks,
Christian.
