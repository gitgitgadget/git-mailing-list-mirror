Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A806C433E6
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AF4D64E12
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355367AbhCDAXn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245321AbhCCTWx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 14:22:53 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06D1C061763
        for <git@vger.kernel.org>; Wed,  3 Mar 2021 11:22:08 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id u3so6506439otg.13
        for <git@vger.kernel.org>; Wed, 03 Mar 2021 11:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Y3DFa5s1KKv0gVWQQ9zZjpmEZzdOaiH6zu5Jw7aZmM=;
        b=A/oN2yH6KCkyFxzpeKmxRoYPvP114ZqM17uLSDqifVMkEBI1WMkpHmThL0LRd5azEe
         vD8nxNJzGLwoNAu10lnXMI6y/dd1INa+tfsafRK7ve0VIdKlfSCr0OqySuh422j/mwXU
         AoLuH4AijH4gLZE2CE+3sF/o7hf15YEwYJPPRSAWLJnh5clnAptAGfrG+qa9n89HRyut
         VmqAxwbaQQiXQulvIAw+UvsMOS/zqXSQk6Hkj9Nz2M/Fz6mRyPM+WQJZPIQGycN0zyv2
         Wa7KaKsHSoIQLZ9LrVnnwXZP/xr/NBgPmyOggwdRj4igxN1+AKuN7lQGTwzKm//07Ssa
         S/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Y3DFa5s1KKv0gVWQQ9zZjpmEZzdOaiH6zu5Jw7aZmM=;
        b=KVFMAO4VNeCk2VpsuzOTZIpX8uav+ZYGgJqr+Wnv04r23CWeblYSDS9ju8B769r9qJ
         WGJM61t9JtvlWTxPNiNtVzgDUrHZ00SrqY3vGlkbrctDTaMMbV/IoA47vgiDxAp6oJha
         X3F3Q8sL2uakN+N5vMrRGIuTuy0O9gsCX3Ybqlt4ZWxTNhI1stRJgFoowuyhpuKseXSg
         qu7e9rbbGDZEcpiop9pFPCzsQu84YepNgTNnD383W5IVnYnV+GrunvlU7Aeb0FWbInP8
         pRW9U73gShLViNf/9n6/YH2DDxri+SGWLA1kCJLqMDDfuu6oanHFH3+hvcCs7zaKcGK9
         lQfg==
X-Gm-Message-State: AOAM532Wks1i9ZCLdMBz7mLRCXlxnQ8sNqMdyPpQlQRWR/hGaIRYr5BM
        zU6/cVCbCUL4CHl7oZP65gJhOQc5afRmJ1m6d4+zU2Bg3rs=
X-Google-Smtp-Source: ABdhPJySyxounAJ6Kecozr8N6h+hyZrxKnKW2Qk0QQE6z9a07qpv880LnhjlxAXRog/IAz10n7OJ/rKk/9GyACm20uM=
X-Received: by 2002:a9d:6b8b:: with SMTP id b11mr519586otq.210.1614799328362;
 Wed, 03 Mar 2021 11:22:08 -0800 (PST)
MIME-Version: 1.0
References: <20210301084512.27170-1-charvi077@gmail.com> <20210301084512.27170-3-charvi077@gmail.com>
 <CAPig+cQAG3p6rhGHzBNGPUxMXQbbLZgiw-uUpizNiEWY9wm-3A@mail.gmail.com>
 <xmqqlfb6mrnx.fsf@gitster.c.googlers.com> <CAPSFM5fmK_3rFfTbD7o3qCcYYeMXoX7K-HhGorXDPcFseBEDzQ@mail.gmail.com>
 <CAPig+cQcjUzXpW1OBCiEC3Sr13uyeesqK49KWmgnY1iHNnS2Rw@mail.gmail.com>
In-Reply-To: <CAPig+cQcjUzXpW1OBCiEC3Sr13uyeesqK49KWmgnY1iHNnS2Rw@mail.gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Thu, 4 Mar 2021 00:51:57 +0530
Message-ID: <CAPSFM5eAdfAD+TeLn8f4+1x38g_6r7T=DuyPJf2f-828pwqgyQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] commit: add amend suboption to --fixup to create
 amend! commit
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 3 Mar 2021 at 13:27, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
[...]
> > I am not sure about this because we used the starts_with() so that it can
> > support the _any_ prefix of `amend` or `reword` i.e to make all below
> > like combinations possible :
> > --fixup=a:HEAD~2
> > --fixup=am:HEAD~2
> >
> > So, I am not sure if we need to replace it with !strcmp and work for
> > the specified prefix only ?
>
> Hmm, I see. I didn't follow whatever discussion led to the decision to
> use this sort of prefix matching, but I have to wonder if it is a good
> idea. Was the idea that it behave similarly to sequencer commands in
> `git rebase --interactive` which are often abbreviated to a single
> letter?

Yes, this is also true. Also, same is discussed as here:
https://lore.kernel.org/git/CAPSFM5cEnex1xaBy5ia_xNFDNzt5_Y=W-6TB9d9yW_AiPAKxDg@mail.gmail.com/

>I personally would feel much more comfortable requiring a
> full-word match for `amend` and `reword` at initial implementation.
> That leaves the door open to later loosening it to do prefix-matching
> if enough people request such a feature, whereas starting with
> prefix-matching closes that door since we can never later tighten it
> to require full words.
>
> Anyhow, if the decision is to keep this behavior, then it almost
> certainly deserves an in-code comment explaining the sort of
> prefix-matching it's doing since it's otherwise too easy for readers
> to be fooled as Junio and I were by not noticing that you had reversed
> the arguments to starts_with().

Okay, I will add the comments to it .
