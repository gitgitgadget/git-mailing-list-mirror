Return-Path: <SRS0=cZ0k=DR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CB3C433E7
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 05:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3C0A207E8
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 05:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=webstech-net.20150623.gappssmtp.com header.i=@webstech-net.20150623.gappssmtp.com header.b="Sw/PB7mt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbgJJF1A (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Oct 2020 01:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbgJJF0h (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Oct 2020 01:26:37 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05C2C0613CF
        for <git@vger.kernel.org>; Fri,  9 Oct 2020 22:26:36 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id v123so12923320qkd.9
        for <git@vger.kernel.org>; Fri, 09 Oct 2020 22:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=webstech-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EsVUuSUN0fjggH92G5Qo8DAQM1omif9/GZBpq+8oZA8=;
        b=Sw/PB7mtidgkGW8DnVc6N9nzi6WXpyKm37evlSxWsNCaDV/TM4V3517Ng0pz9BhF1Y
         /pevVGsFsAuxXJTZ+nlFBXxsAcweH+euyGeBUcQdPncxhH3nLPElnqjlGBhE/ShEBFub
         zHkp/1uOB0OVzD+5r1FzKMZKJIlAZKnfE5dxN5r71L1PdgjmK60v2XehnYW8nf2CA4nW
         Hyo3HlL2B1glG4WrsOSDWvTjrLKrMrcTZFc4kHAkMqjxFWvFrZfz7XF+NtCXD7/nRNbR
         /OxjZsPo7O8RfmN63kWlL+1T2c2jeil5sfJs6mH3A/8J+bU1oOZPV0+FsSYP4sWhKHHo
         qeEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EsVUuSUN0fjggH92G5Qo8DAQM1omif9/GZBpq+8oZA8=;
        b=UK6Z6ew+4C9hF0qxLiKO1w53cZAtD3o0Nt9x3p+879cpEe4wGsAT18+1ULf9tMoQqH
         cg7gMtc+IaoPPRJhMO1E6m19KeXwI81idQvIHeMCEwpe7olloj7u66QjzCLlLB1Th/br
         Lap8LN5jC4URRPmW+25/k4NmMnmrw1pKEgbtXZPYjiMmJYyZAxEppstpPd9kh8cqXBbI
         RUSodn1jmGHYkjk/TdbIg9aqCo7jAEtphgE7oOqHL13SybIZ2aPJaXfASXrL08m4RsUs
         V/3Kko2skZ5gGHvDp39QiwYMyQsmiD36Bsr9xZVpx+XWa5QILfxEULjPRpxhcKYDPlxg
         zpRw==
X-Gm-Message-State: AOAM532j0j+tnt7OO5YdajGuj/YhlgOLvzNB14nNhBGDuGOrP9Qt9piu
        mIwSIp3N2EQ0i3xvPwe8KQzoANZpm/pRu9twfazBhA==
X-Google-Smtp-Source: ABdhPJy8qrqXad7aGapE48QBtC8W2Dk4kquatSmVwt48L1Izb98Mu0nZERRQ43g5tQKGQdCuHE0PXkMhESSDzdoAs9I=
X-Received: by 2002:a37:52c2:: with SMTP id g185mr1083573qkb.283.1602307596053;
 Fri, 09 Oct 2020 22:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <pull.709.git.1600759684548.gitgitgadget@gmail.com>
 <20200922170745.GA541915@coredump.intra.peff.net> <xmqq1ritlmrk.fsf@gitster.c.googlers.com>
 <CAGT1KpU4Kjv2PEAA7-bNbGp2DFvfsKqABuUK68128xkLjdcEhA@mail.gmail.com>
 <CAGT1KpXz4nFBu2xkVSaoW4DgXc_5oB69MQRQW=365gfgd_R-mQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.2010091519460.50@tvgsbejvaqbjf.bet> <xmqqtuv3tlkv.fsf@gitster.c.googlers.com>
 <20201009175917.GA963340@coredump.intra.peff.net> <xmqqeem7tgh4.fsf@gitster.c.googlers.com>
 <20201009181827.GA965760@coredump.intra.peff.net> <xmqq8scfteh7.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq8scfteh7.fsf@gitster.c.googlers.com>
From:   Chris Webster <chris@webstech.net>
Date:   Fri, 9 Oct 2020 22:26:35 -0700
Message-ID: <CAGT1KpV+vcD59W2qWBsgg2qfSSLaJ37aVi__y5u=wHjsSDiiOQ@mail.gmail.com>
Subject: Re: [PATCH] ci: github action - add check for whitespace errors
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "Chris. Webster via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 9, 2020 at 11:57 AM Junio C Hamano <gitster@pobox.com> wrote:

> Thanks.
>
> Another thing the resending does is that it can credit who helped
> the patch into the final shape with Reviewed-by/Helped-by etc.  If
> the maintainer must hunt for the names of those who had input to the
> discussion and judge the degree of contribution for a topic whose
> review has been delegated to trusted others, that defeats the whole
> point of delegation (I think the attached clarification may help).
>
> For this particular patch, I added Reviewed-by: naming you before
> applying.
>
> Thanks.
>

Thank you for moving forward with this.  I apologize for not
re-reviewing the SubmittingPatches doc.  I should have done that.

Thanks to Johannes for the input on this before it was submitted.
Will work on improving the commit messages with more credits.

Is there an opportunity here for a gitgitgadget command to send the
'consensus reached' email?  The value may be in deciding who is
getting the email and trying to select content from the PR comments.

...chris.
