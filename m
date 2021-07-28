Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0653C4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 22:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CC9D60EE2
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 22:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbhG1Wti (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 18:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbhG1Wtd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 18:49:33 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E14FC061757
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 15:49:30 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id u25so5789321oiv.5
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 15:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/GguIIxqeww5iI5JQp15LH/Ao/VBYHxLmIsExoaHnL8=;
        b=hwYEBv3fKe3FOZISx0ND5cfeSogl3PwbITo8QTvqi6jYzcAQcWBYVK/76Ar5/N0+NY
         rIxd9mDu3pMl2fBI+h0QfZYcpBT83y/rmuDH5/fozO4bwoDckw+D87UayBjxNxs6kHXU
         EubFa7LPlA59mTc/2ZaLJ1IWDiWT2G/9ySN887Zhjg4UlR4ieTCES2hTdrPB/ysKBCiD
         UQHJRzrlsIjR8I9mgUpD0BCHAlGd0MNOAl4AvXZH8/OEjNc6exAMIKl4ScwsK3KsB0Vi
         rX8N9eCzEU3JlN5yedT1kDchOqIa2QeeT1X7YP3Rs5Bce3S4SOw1mTTLl00OS1ItxTYO
         7coQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/GguIIxqeww5iI5JQp15LH/Ao/VBYHxLmIsExoaHnL8=;
        b=an6PHFGyCL7zaQ5tNGK4VybNOmHay86PVvy21sTmu7bd3yHWV+49Ywpc42PY29mR8T
         bVb/Fez0KsYIMxB7ovVc9sSczvgBJWJYLUfHuD9+NcKLxotV2VzKgT7ZYBfE5NdvF/98
         UwGlbLTWlvP8PQ5v+42x8Wicy1BzshedW0veGJih6H/NN47PmyYeKA24bduCdR+UsGbW
         0TAu3DwSTMDkrobSBFwMoQRTh6Oiy9ihXOf6pkziQcEWdE6gMK5MPOLRhI5J7p0Ux+jz
         oic643SSs588Hnjql+Bl30PnFBu8FJPX0+IAUxv7Ri4VP5Bgspkq03ANzLFVNU3+GIPd
         BDuA==
X-Gm-Message-State: AOAM530P/ybyHT+b8q9Kii6YfX+K4ZvxRpOPRCcf/43/JKebtv2hFryH
        RoHEgruoNuRBGft9BBGm7ggv8PfAUkwbrw+5kA8=
X-Google-Smtp-Source: ABdhPJyaWzlDImQrPByC9duoyErp+hl7GS9TBETyq5GEnlxBFX0+dkP6oHDMDSPmuJ26/y8yzJ+6onnYAHJUhEIlne4=
X-Received: by 2002:aca:c0c3:: with SMTP id q186mr8021473oif.39.1627512569854;
 Wed, 28 Jul 2021 15:49:29 -0700 (PDT)
MIME-Version: 1.0
References: <pull.990.git.1627044897.gitgitgadget@gmail.com>
 <e30b8c8fea110b2475d00a4b37eb62a4883999c4.1627044897.git.gitgitgadget@gmail.com>
 <bc24ea9c-178c-bcc9-2097-2271df93ae76@gmail.com>
In-Reply-To: <bc24ea9c-178c-bcc9-2097-2271df93ae76@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 28 Jul 2021 16:49:18 -0600
Message-ID: <CABPp-BGjrKWXn2ZzeJ-nsZTwsDE=gbaX=1YKfiNtC70VeN9VVA@mail.gmail.com>
Subject: Re: [PATCH 3/7] merge-ort: add pool_alloc, pool_calloc, and
 pool_strndup wrappers
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 26, 2021 at 8:36 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 7/23/2021 8:54 AM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > We need functions which will either call
> >     xmalloc, xcalloc, xstrndup
> > or
> >     mem_pool_alloc, mem_pool_calloc, mem_pool_strndup
> > depending on whether we have a non-NULL memory pool.  Add these
> > functions; the next commit will make use of these.
>
> I briefly considered that this should just be the way the
> mem_pool_* methods work. It does rely on the caller knowing
> to free() the allocated memory when their pool is NULL, so
> perhaps such a universal change might be too much. What do
> you think?

That's interesting, but I'm worried it might be a bit much.  Do others
on the list have an opinion here?
