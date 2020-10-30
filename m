Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D37C00A89
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 19:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F08A20739
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 19:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKXAey0D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgJ3Tmo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 15:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbgJ3TlE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 15:41:04 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6256C0613CF
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 12:31:25 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id l26so1845798oop.9
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 12:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XVLaatggPvSPmPS9s+g2Y1zemjbALAAL7XpRwn8s+xY=;
        b=TKXAey0DD2Q5dxyxqmvXg9S5jj5284DZICG6suo1wZ8E6jxt1i9tP0ffweNAq0eBKV
         yMrhN5XCb1h/E2Ac8mJySsqT905S9xXE6fS63595HXd6PfAfgZgVolOs8NaCHO5Zx/i5
         IbATWyaNcaO38btm57qJe/Ym4KFLCJm8GqtWO1e2+bEgk53I4G9FNKa5xnFmndGVboyc
         Mu7wjkk0w1w93nxnKnK0AKX1p1XJ9Y9gK9pjuxLkhTFQ3WD8ABeNW77rl1GpgWTmG+8d
         ppmlygUtgQML6Xg4I5uFC5ziN4coXwxpnMvSV4oa4rpqpwPLaW68mdy0MQxqsMIapnym
         gDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XVLaatggPvSPmPS9s+g2Y1zemjbALAAL7XpRwn8s+xY=;
        b=fHcPz718t6AMTFCXOmuYzBbJGKbq8xZULId3HIhS/0s/PHqnmZRxZtyXD7SWSQEq27
         x2PsbXjBIOJIpq72B2sO3g0TOxxONPON+5y9uj5Q2sdObTeVHb+PwHb072OSwoM8Fods
         erNEhcuE884lB4hWDBvCvIM2S5lh0BOIGujXSv3y1PHkb/a2Ncwx7K/K7CgWXkh6FuNw
         tDCCX6gNGuLj4fh8MFmJk6r4tqXiLId3DJ+GJDJfJqw9Qn2qRYhNQ76cWC7inqx3X38n
         nYrBmtDpJKI4DkNrRRnzDN2+jr70IYzL89RDp/FJSW51TC+0m6dj6emuxROPe1jDpgOg
         9f+g==
X-Gm-Message-State: AOAM532rlXYL9H37aPGC7IJbxySqV9qH/hDhlDmC2/bEThYwvN4C5vcU
        j0n51GLom/XuNdbrjIsGGDhTLVne1aWS/X7dMPE=
X-Google-Smtp-Source: ABdhPJyjaUk2HJygy9Yu65PvzABX1V6GVDAsvEjp1yVu6Yn+nTUdi1LCoGC70NhRf4ooU2kjIuLYhvJEJgiu33CozBY=
X-Received: by 2002:a4a:b308:: with SMTP id m8mr3174505ooo.7.1604086284977;
 Fri, 30 Oct 2020 12:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
 <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com> <eca4f1ddbaa1cd8dc3fc64dbe9206af538cb317d.1602549650.git.gitgitgadget@gmail.com>
 <20201030145604.GJ3277724@coredump.intra.peff.net>
In-Reply-To: <20201030145604.GJ3277724@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 30 Oct 2020 12:31:13 -0700
Message-ID: <CABPp-BEY5R79WGsMB1y1MEbcvw8EF5-ADxvDPzL+Hn-PiyobsA@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] strmap: enable allocations to come from a mem_pool
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 30, 2020 at 7:56 AM Jeff King <peff@peff.net> wrote:
>
> On Tue, Oct 13, 2020 at 12:40:50AM +0000, Elijah Newren via GitGitGadget wrote:
>
> > For heavy users of strmaps, allowing the keys and entries to be
> > allocated from a memory pool can provide significant overhead savings.
> > Add an option to strmap_ocd_init() to specify a memory pool.
>
> So this one interacts badly with my FLEXPTR suggestion.
>
> I guess it provides most of the benefit that FLEXPTR would, because
> we're getting both the entries and the strings from the mempool. Which
> really ends up being an almost identical memory layout, since the
> mempool presumably just gives you the N bytes for the string right after
> the last thing you allocated, which would be the struct.
>
> The only downside is that if you don't want to use the mempool (e.g.,
> because you might actually strmap_remove() things), you don't get the
> advantage.
>
> I think we could fall back to a FLEXPTR when there's no mempool (or even
> when there is, though you'd be on your own to reimplement the
> computation parts of FLEXPTR_ALLOC). I'm not sure how ugly it would end
> up.

Yeah, we'd need a mempool-specific reimplementation of FLEXPTR_ALLOC
with the mempool, and just avoid using it at all whenever
strdup_strings was 0.  Seems slightly ugly, but maybe it wouldn't be
too bad.  I could look into it.

> I haven't used our mem_pool before, but the code all looks quite
> straightforward to me. I guess the caller is responsible for
> de-allocating the mempool, which makes sense. It would be nice to see
> real numbers on how much this helps, but again, you might not have the
> commits in the right order to easily find out.

At the time I implemented it, I did grab some numbers.  It varied
quite a bit between different cases, since a lot of my strmaps are for
tracking when special cases arise and we can implement various
optimizations.  Naturally, a usecase which involves heavier use of
strmaps will mean greater benefits from using a mempool.  Also, if I
had implemented it later, after one rename-related optimization I
hadn't yet discovered at the time, then it would have shown a larger
relative reduction in overall execution time.  Anyway, at the time I
put the mempool into strmaps and made use of it in relevant places,
one of my rebase testcases saw an almost 5% reduction in overall
execution time.  I'm sure it would have been over 5% if I had
reordered it to come after my final rename optimization.
