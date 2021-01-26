Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5130EC433DB
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 20:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AEB0221FC
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 20:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731320AbhAZFFU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbhAZCuc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 21:50:32 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1C6C0613D6
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 18:49:51 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id z22so11330114qto.7
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 18:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IeMCX3KEKWF+mMbEMl8MpKXy0c5/0JGG9I0qrw+V2uo=;
        b=wAN31NUAloSjwvKtf6jtv6yiJw+ZSzDKDsY/5Un6q6MjPv0KASEEZRFqaBy1h2Y9cn
         n1nu1ZqPkDBWpoeHBv1ycOuj5ZJykK0AH5kNB5Iyx3pLB+OYope0zkjh4mH1yV2KhgTO
         DixIOl2tAw3hIY3ngkR/B1vWmbPWSITEe7FYvzQnXcjXN1BHt4CDlIjgj5hrOhlW2xJA
         SuFjOzyMnJG4ECvVf95c64+vZjUSTzoGjHHZSKQpvDo5rgDcbw+Tlc4HtEAfYoWb9/Dg
         AN3ULUt0FC6mFhO2KmIz3rNmU/65sLpd3obhS7rmDV/LqNw9Hviz9wFoRZbDxfsI6c2e
         A7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IeMCX3KEKWF+mMbEMl8MpKXy0c5/0JGG9I0qrw+V2uo=;
        b=Qk/pe2KpTORwawK1OnDQupzgQsYlLmesLqoMbChLYU2GEUUA6Nu4y50M1vYwWW4kpl
         av1QoKPDZS81nrDI4OrV/31bh2UHg8xYYXlYDrqV8+tD+z1GsiqtEjrKPFFzmn65rQZU
         LZKIIfUdcM+o/eYILocO5s40koShXXeAa3iXUlipI3gVDTezgVlx55pw1TnSOlJfzkB3
         yMnEg1/sVOICf9oO5dmH/iehoUYXqXX1RJWpCwscLgstT80BjlH65AoktJIlAXkCzndk
         GZoV1fATOCy6MSICWVGbsr0poIy1x9tRwbkD90oO3jaOIXbFUWx7+wrX1grXUZSObbdB
         5XNA==
X-Gm-Message-State: AOAM5312He+J3JqCzIRhtHMbRz4DTfp2Tcjr9hg6VhaOhN8I6yVi8L3B
        10kg86VSE7YAfj1Y8UQHKzdA/A==
X-Google-Smtp-Source: ABdhPJxpbIiCJ1NjVJXliO2NQRtJ94NzpdD2tTmKLu7TsvocwoZ8Y+COvPvTB1xF4jdDSgX4LEcf7Q==
X-Received: by 2002:ac8:7599:: with SMTP id s25mr3472889qtq.89.1611629390995;
        Mon, 25 Jan 2021 18:49:50 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:5e9f:a2e5:e7ac:394d])
        by smtp.gmail.com with ESMTPSA id i93sm10500223qtd.42.2021.01.25.18.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 18:49:50 -0800 (PST)
Date:   Mon, 25 Jan 2021 21:49:47 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, jrnieder@gmail.com, peff@peff.net
Subject: Re: [PATCH v3 00/10] pack-revindex: introduce on-disk '.rev' format
Message-ID: <YA+DS87avb2Klc4x@nand.local>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1611617819.git.me@ttaylorr.com>
 <xmqq7do04e6c.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7do04e6c.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 25, 2021 at 06:36:43PM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Here is a third reroll of my series to introduce an on-disk format for the
> > reverse index. Since the first series (to introduce a new API) has been merged
> > to 'next', this series has been rebased onto 'next', too.
>
> Ehh, does that mean you are OK to see the remainder of 'next' to
> take this topic hostage?
>
> Unless you use some new features that came from other topics in
> 'next', I'd discourage such a rebasing.  If the API topic gained
> some fix-up patches on top since it was merged to 'next', it is
> perfectly sensible to rebase this series on top of the updated API
> topic---it does not change the fact that this topic is dependent on
> the API topic.

Ah; my apologies. I thought that rebasing onto next would make it easier
for you to merge this topic, but after reading what you wrote I can see
that's not the case.

The only dependency that this topic should have is on the API one, which
I am glad to see in 'master'.

> As it happens that the API topic is now in 'master', none of the
> above complaint should actually apply, even if this new round of
> patches do not cleanly apply to the tip of the API topic, as long as
> they apply cleanly to tonight's 'master'.  It will make the topic
> ineligible to be merged later to 'maint', but this is a new feature,
> so nothing is lost.
>
> So, I'll try to apply them first on top of the tip of the API topic,
> which is at 779412b9 (for_each_object_in_pack(): clarify pack vs
> index ordering, 2021-01-14), and if I do not feel like spending time
> to resolve conflicts, I'll then try to apply them on top of tonight's
> master.  We'll see what happens.

I'm happy to send another version based on 'master', but I expect that
this should apply cleanly either way.

> Thanks.

Thanks,
Taylor
