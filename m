Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE875C2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8233520795
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1zAG9Zo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731256AbgKDUYU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 15:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbgKDUYU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 15:24:20 -0500
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489D1C0613D3
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 12:24:20 -0800 (PST)
Received: by mail-oo1-xc42.google.com with SMTP id n16so5407240ooj.2
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 12:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vft+5C/aFioHojYBbjqr9+r42042NhAUqx0zGsd8XEE=;
        b=R1zAG9ZomN6IGTmLEF1s2kVrE8sWFVOJX5jHWdmm1EsWMCZ9jHgwp3DKQbQDxfPhmD
         kHfdH1kQYbzrGcCxLw5ZSQYpCUEfmUu2AU8SqU+c5/BUN3uqsWoRIEIRY2TdBbMQl1cL
         vVlQO+e++DUi/E/TmPeRHq054gckaJUCFWWxrcI9Re8R3KjAaylz1GW9p5ZDpSu1weco
         R6chT45OlBCuD0Zp1/ueOYyvilNH5Yc5hBFfYrjDthWZRuJAS155FSm10UeYW8eH+2D7
         JVUfUd4rOcQBBYZkG9yAGcYc7O73ywuJRnB6btAoysprzTkpvNwvtmSu0soMGzBw8e7/
         ibZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vft+5C/aFioHojYBbjqr9+r42042NhAUqx0zGsd8XEE=;
        b=plgI9boS7DpLn0m5FOzw8Sl37UBBNCcMlg6A11uMACR/yhCF/x3x7TAsM1oNCZtQ+/
         68RJLgiA+HbFm49vkJfPLE84EhjZehJrbUbHIvpzhw7bUtKYvoumtDbMDaNorTiq7uVV
         JUzQNebnb7aEOwdp37IUJxjBmxw/leMQ/XgVUpSNIMIqclPZ5icEle1ytkIYa4nQahKG
         oxFiDltHZBV7418xnm9qwal5Y8tCjEnZ1zrbsNEPrvm13AgjOMCvtkRIvoQqTmCwXwB8
         I9E4mxil7ukaFiA5LlVhUrOtQw89bA+u4JZ7gcPIlgAllscjXR/9Bf2tTG7noii6s8c/
         RLFg==
X-Gm-Message-State: AOAM530tM8FPU3y+9BtXkzyCbSKRVPhDKBY46sRdvsRb8nU5UsUXgz3b
        E/jfJ1vlSmpXygLVbAtQxG0A3cd7afM+i4tfopA=
X-Google-Smtp-Source: ABdhPJwAH8wmpVTZNlIAtVsyvsMJzczQjjTFQGF8FkbIt++jKc0VDFOTerS9TFz3C4fl3Yh58fl4uV0O+Xmcz6LkVLk=
X-Received: by 2002:a4a:b308:: with SMTP id m8mr20480073ooo.7.1604521459615;
 Wed, 04 Nov 2020 12:24:19 -0800 (PST)
MIME-Version: 1.0
References: <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
 <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com> <42633b8d03008a159bc42bde319f50e87ddb00f6.1604343314.git.gitgitgadget@gmail.com>
 <20201104201327.GA3629238@coredump.intra.peff.net>
In-Reply-To: <20201104201327.GA3629238@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 4 Nov 2020 12:24:08 -0800
Message-ID: <CABPp-BF7kEaX=d8Wm=BQKqGBS1+4AexMJCPtzFtpaDtOjm-g1w@mail.gmail.com>
Subject: Re: [PATCH v3 07/13] strmap: add more utility functions
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 4, 2020 at 12:13 PM Jeff King <peff@peff.net> wrote:
>
> On Mon, Nov 02, 2020 at 06:55:07PM +0000, Elijah Newren via GitGitGadget wrote:
>
> > +/*
> > + * iterate through @map using @iter, @var is a pointer to a type strmap_entry
> > + */
> > +#define strmap_for_each_entry(mystrmap, iter, var)   \
> > +     for (var = hashmap_iter_first_entry_offset(&(mystrmap)->map, iter, 0); \
> > +             var; \
> > +             var = hashmap_iter_next_entry_offset(iter, 0))
> > +
>
> I think this resolves my offset question from the last round. But I
> wonder if you tried:
>
>   #define strmap_for_each_entry(mystrmap, iter, var) \
>         hashmap_for_each_entry(&(mystrmap)->map, iter, var, ent)
>
> which is a bit more abstract and should function the same (I think; I
> didn't try it).

I tried another variant or two besides what I used here, but not the
one you suggest.  Your suggestion seems obvious and nicer now that you
point it out.
