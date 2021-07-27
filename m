Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17EFC4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 20:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC35760F57
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 20:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbhG0UdE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 16:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhG0UdC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 16:33:02 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B621C061757
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 13:33:02 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id j21so263840ioo.6
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 13:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6Jy/b0Ym07NCoaguBCzAN5lYAo3uX2V8nVTjQNbMc0g=;
        b=g4/Y4Xzlk63t1+KY0N7BTFkTTZfLGHbor6fqQbzey7AXgdk4BUY8tpyntIZHFNv+AE
         bai2R4WVQuPTwZZwRia127h+uXId4Okcwm+Pgj6/DStIcHKwb9MD/K8pNSLGBUCqUmpf
         GyU8Uz3DQ66AI47gqkEDJK8Am44IeA3T/L5HxS+BA17BaZnqzA7mTAPkjI1FdVOdSwum
         6eDbQm9TGRqDHJ1FhLTyl13W6VW1vGob3E/f0svQrDifviuTSBqv0E9mMv9lwZsTAwWi
         dxHywhzNS7Z5Ejl3Uw6DiBF69JEFUf16mI/uut7KcCqd0F0ugBHZdMzbVmo1QyCtRBzu
         nUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6Jy/b0Ym07NCoaguBCzAN5lYAo3uX2V8nVTjQNbMc0g=;
        b=SmUkzy4QOEe9fxqNAn1GWa06PRpIdG2uAMSYnTWSK3YVIppPJoo58pLAhVb4t/tXNe
         BTowfBPCp0uRA6gXv+faOjIT41BXqj8jONiLyTIq0Qcg4MoR4sELeh5DPB+PDGljv5aX
         7rWuWFFvD4qnYDR4jhMey1HD4Rv4PeqBhePJJ2ltPtyVABscFcklr5fxZ7x4zl0RV9hS
         a47Nz3rf+KTk84lDXJVv0oR/FhBVt+hxzMucTKIQs/Ut5IEBMLm2LD2HE4gST0ldjsmN
         rs3f+NxjS4P5BdDRsgRPF3pHpr7Q2hkFZV/SvGJuEjlIEEcUZw1AP86TZS22BsisTqG1
         qy7w==
X-Gm-Message-State: AOAM530GYwENCJY0Oxn8L83Ga/Zemi9vvCGEwVlO5ylCefdP8PmanFAI
        HJn8Xo6XgVanLbfr44c00YA6Iw==
X-Google-Smtp-Source: ABdhPJwy+aulsep/qOtD1VaOzu7YxFPwK0hFpQUhSQEu4fheBQi72n7vGb1QjJmYkTG6rVvBb+YKYQ==
X-Received: by 2002:a6b:c40d:: with SMTP id y13mr20777119ioa.78.1627417981912;
        Tue, 27 Jul 2021 13:33:01 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:6813:d625:75e6:4f64])
        by smtp.gmail.com with ESMTPSA id w1sm2258866ilv.59.2021.07.27.13.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 13:33:01 -0700 (PDT)
Date:   Tue, 27 Jul 2021 16:33:01 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 14/24] pack-bitmap: write multi-pack bitmaps
Message-ID: <YQBtfRP0svLL6VDl@nand.local>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <a8cec2463d0993b1118abdd31cb6c9e88a32e0c4.1624314293.git.me@ttaylorr.com>
 <YPgObwXjt/tzAJvV@coredump.intra.peff.net>
 <YP77DiffrCrxunvg@nand.local>
 <YQA+PaWb7tweEKuk@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YQA+PaWb7tweEKuk@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 27, 2021 at 01:11:25PM -0400, Jeff King wrote:
> On Mon, Jul 26, 2021 at 02:12:30PM -0400, Taylor Blau wrote:
> > But it does mirror the behavior of our previous bitmap generation
> > settings, which has been running for years.
> >
> > So... we could probably drop this hunk? I'd probably rather err on the
> > safe side and leave this alone since it matches a system that we know to
> > work well in practice.
>
> I'd rather drop it, if we think it's doing nothing. While I do value
> history in production as a sign of stability, upstream review is a good
> time to make sure we understand all of the "why", and to clean things up
> (e.g., another example is the questionable close_midx() stuff discussed
> elsewhere).

OK, I think that's a very reasonable way of thinking about it, so I'd
rather just get rid of it (not to mention that I really doubt it's doing
much of anything in the first place).

> > Luckily, any new packs will be loaded (and likewise have their indexes
> > open, too), via the the add_pack_to_midx() callback that we pass as an
> > argument to for_each_file_in_pack_dir().
>
> Hmm, OK. Your second paragraph makes it sound like we _don't_ need to do
> this. But the key is "new packs". In add_pack_to_midx() we skip any
> packs that are already in the existing midx, assuming they've already
> been added. And we probably must do that, otherwise we end up with
> duplicate structs that are not actually shared by ctx->m.

Exactly.

> It's interesting that your earlier iteration didn't call
> open_pack_index(). Is it necessary, or not? From your description, it
> seems like it should be. But maybe some later step lazy-loads it? Even
> if so, I can see how prepare_midx_pack() would still be required
> (because we want to make sure we are using the same struct).

It's only necessary now (at least for determining a preferred pack if
the caller didn't specify one with `--preferred-pack`) because we care
about reading the `num_objects` field, which the index must be loaded
for.

Thanks,
Taylor
