Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51153C433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 17:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B1EF61ABB
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 17:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355353AbhJARl3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 13:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhJARlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 13:41:25 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCD4C061775
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 10:39:41 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id i4so42102174lfv.4
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 10:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WfBCmxzqY0EFSFA2nUOumtctlygGbZUqnzKdtX2tGIQ=;
        b=BmbjxPCve1OzkMVVpqT6FGQXlhWQYjLN8ZlZbHT/Sp2bSqhg4RFKB+hMTug9shpECO
         gtyhklYpTgSS56qSygPv0mNfWcOAM0NtitUGwtn70uGSgzmfvdTJQcY/dzP4qzSj8CPI
         +fcRSWDIGUOU6VOw8y75RKwNAx5F2WWjKLMXaVRDy7r7Znj7+zSnLpkNMhuztCutrOSz
         Iwonnai5no6SyMuDEBEAl244rKZddY3nScIXvwsUpdggOa8yDKOSJySJLigr+UM+k06g
         498YkrHxr5kCyEzOAtnaf9MSFl/5b216L6WGCkNutYX3/Kp1z+DMbXGJMHPMVn1Ko+gZ
         3gOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WfBCmxzqY0EFSFA2nUOumtctlygGbZUqnzKdtX2tGIQ=;
        b=YFpRv1y73M6osAykVWnSBvK0xmH/rSAdVHTsPixXc+gygEnCN2i4Pc6p0KzYXI0Mze
         0Zgx+342/yIFpn0CGnw5WtGbWQLKLn1jMd2ykEiTlyukYWbNJX4BuFXEjcHQu7razODe
         1jTPY3UbZ1biRIsE7h32q5HEWG6QK9C4LH9F41WsugRujJ8CnibaSnTRRkqQYC+zL+RC
         su2wvheAUooYXTHwNzTs4lquLl6FsbMPYmQHg1hjnPknsV8VKWB8SnchsT3gNbDbNnXe
         PKBeOoHWUakuL4Am3cxvNTwucWUnxybk+xr7J7g4mFGBLiaRIbFjH+oRbaQEeqtuHO6v
         DYHw==
X-Gm-Message-State: AOAM531+Z+RTFlQYWwGWdyxT7PplWEkMfIpAX9GrgWt8ehdXwLgWjz3K
        zfnLtTdiJqG5T0ii2OxE4J4aDNB45ceF8gYMo2KuZHE09S/2DQ==
X-Google-Smtp-Source: ABdhPJy8jL75xk5Mq0n3dHpGgxf1EscIHNRTHKDcRX0PIkKR/JtpfZPqpgcIukBzurh8LyBpvBXdVstRIcK/N6zj8CI=
X-Received: by 2002:a05:6512:753:: with SMTP id c19mr6758887lfs.74.1633109979605;
 Fri, 01 Oct 2021 10:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq8rzhmsi7.fsf@gitster.g> <CABPp-BGuzd_TH57-1RvwJQD5r3S3ZkJcuiPnU8aWee8pgzUBEw@mail.gmail.com>
 <YVOn3hDsb5pnxR53@coredump.intra.peff.net> <20210929184339.GA19712@neerajsi-x1.localdomain>
 <YVVyUkwYNfkEqNfU@coredump.intra.peff.net> <CABPp-BH6ZzC9p94xda3SqfL0JjxoVAb3oV57a9cpg2ZDc=5NNA@mail.gmail.com>
 <xmqq7dew8yq6.fsf@gitster.g>
In-Reply-To: <xmqq7dew8yq6.fsf@gitster.g>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Fri, 1 Oct 2021 10:39:29 -0700
Message-ID: <CANQDOdcBEQQS4c22AiXhAB6sEABWP-kRhmq8Vdd6KG0GemSa9g@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2021, #08; Mon, 27)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 1, 2021 at 10:02 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > Said another way, I don't think anything should be writing a critical
> > file that needs to be durable when we're in the middle of a
> > "read-only" process like git-log.  The only things written should be
> > temporary stuff, like the automatic remerge calculation from
> > merge-ort, the textconv cache optimization stuff, or perhaps future
> > gitattributes transformation caching.  All that stuff can safely be
> > blown away at the completion of each merge.
>
> The textconv cache can be populated/written during "git log -p" into
> the object store to persist.  With or without "--remerge-diff", we
> can make design decision to either
>
>  - use temporary object store to discard everything we create at the
>    end in one-go, or
>
>  - write them into the object store to let later gc to handle the
>    crufts.
>
> The former will disable persistent write access to the cache.  It
> still allows accesses the cached data during the same process,
> though.  We so far deemed that textconv cache, when the user enables
> it, is valuable enough to make persistent.  Perhaps remerge-diff's
> tentative merge result may fall into the same category?  Some folks
> may want to cache, others may not.
>
> If we were to use the same notes-cache mechanism, we record the tree
> object (perhaps the object name) as the cached value for the merge
> commit in question.  Hopefully most of the merges are clean merges,
> and "caching" the results of the recreation of the merge would cost
> almost nothing.  We need objects to record the fact that "this merge
> has cached result" in the notes-cache, but the tree object that
> represents the cached result is already in the history the merge
> belongs to.
>

Elijah,
To Junio's point, I'm also curious about why it's so important to
aggressively purge the
mechanical merge cache that you want to do it after each diff
operation rather than once
at the end.
