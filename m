Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CF8C2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 16:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF08A207BB
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 16:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FA1TfpWl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbgKCQst (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 11:48:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728431AbgKCQss (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 11:48:48 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A61C0613D1
        for <git@vger.kernel.org>; Tue,  3 Nov 2020 08:48:48 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id j14so6358811ots.1
        for <git@vger.kernel.org>; Tue, 03 Nov 2020 08:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BAAGTtWIxAknmYib/6ImYuzxrNHhSRFlmUnLs1qhTHw=;
        b=FA1TfpWlzwrSXQcH7XTnbQEPtUSk7U1C60o9B3n4PRgK9wJIogXA41obJ0hOAI3Afo
         ZfUGP3WioooI8p9igBIVntfxgSdiJhATSyTMv+02cNTqUcrBJsoB4Wlplq3iglDpwRjF
         rAhA6MCTrCY0RZaqgkuRjsF5ugYIu6v2/eOfN5vmu+C/14q2cUak8hYwSAMbnuZlL1r0
         FAW8HgyyhjizPMlUJ++bPdNZjHTMo5K2tIbvNzRMpEUpIsE6pEzyIryjhI4uzuWLSyp2
         ThOV2SFtua+R54uJgq164QYqwcnUMewrXzUDRCN16VkWLT+xEcjeEHFDnYOre+d8ZMmU
         ZBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BAAGTtWIxAknmYib/6ImYuzxrNHhSRFlmUnLs1qhTHw=;
        b=IubcE6PbqgCaDkxd+6+h90ITcDOprzfvmt/QJ1QzjfKuIhArCDa/wJVdaH4yE9902l
         vKDeNtruYE1VuUC/ZDtk1idrXFGyNHPbl16jWApRE2sCx3pVDwfEme/worFp/L188EUQ
         VJPQ3L2iL7mnWkgSMos/PWX0tspBWWqunriYkJba6pZZn3I1K3wgZ3/ewdeoWWGi/Mlg
         ttC0UsUyE5l/8ragEU5PHfMgDVc6nXQNsIAPh6/SYTvcNgI3IDhlYUvzIavZXKxFijUu
         Gbck6azPnpUUcd1/eNWjyZF8c52COZUCEAzMPtgKCMVQk2grFrkyo+feWxL4qfG4Kp3m
         mmbg==
X-Gm-Message-State: AOAM532nIzpntNYzEHrQ48BRo6LQxTpH9sGPZYiTxbBngethw51fGymH
        kdWfnW+HiV7k0dn3sARMkMuI6GEx7U0DQIHfi96DxD5MmhDAjg==
X-Google-Smtp-Source: ABdhPJxZ4XiiDdJerScd87tMfpX0PfdzoBlShZyKlSi2C+Tg92+4jCZvB406XYbErPHAF8zEFrTGOwYG1QqT/fyWHl0=
X-Received: by 2002:a9d:8d7:: with SMTP id 81mr11982266otf.345.1604422128141;
 Tue, 03 Nov 2020 08:48:48 -0800 (PST)
MIME-Version: 1.0
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
 <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com> <af6b6fcb460be900d3fffeb743a42f3f87ce6b7f.1602549650.git.gitgitgadget@gmail.com>
 <20201030125059.GA3277724@coredump.intra.peff.net> <CABPp-BGdM0tkQgqRQzzpTOyKPoQVLsppK_EUcthAO8LbtzcTNA@mail.gmail.com>
 <20201103162607.GG444466@coredump.intra.peff.net>
In-Reply-To: <20201103162607.GG444466@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 3 Nov 2020 08:48:37 -0800
Message-ID: <CABPp-BHvD+JkZ60i=KQ=sxQYZcmu0OrfXUKq_2vmUkT1jEmiRg@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] hashmap: add usage documentation explaining hashmap_free[_entries]()
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 3, 2020 at 8:26 AM Jeff King <peff@peff.net> wrote:
>
> On Fri, Oct 30, 2020 at 12:55:51PM -0700, Elijah Newren wrote:
>
> > > But I think in the current scheme that "free" is somewhat overloaded,
> > > and if we end with a "clear" and a "free" that seems confusing to me.
> >
> > Hmm...there are quite a few calls to hashmap_free() and
> > hashmap_free_entries() throughout the codebase.  I'm wondering if I
> > should make switching these over to your new naming suggestions a
> > separate follow-on series from this one, so that if there are any
> > conflicts with other series it doesn't need to hold these first 10
> > patches up.
>
> Yeah, it will definitely need a lot of mechanical fix-up. Those kinds of
> conflicts aren't usually a big deal. Junio will have to resolve them,
> but if the resolution is easy and mechanical, then it's not likely to
> hold up either topic.
>
> > If I do that, I could also add a patch to convert several callers of
> > hashmap_init() to use the new HASHMAP_INIT() macro, and another patch
> > to convert shortlog to using my strset instead of its own.
>
> Yeah, both would be nice. I'm happy if it comes as part of the series,
> or separately on top.

After sending the email, I ended up deciding to convert the callers
just to sanity check the HASHMAP_INIT macro and discovered that the
code will BUG() if you don't also include .do_count_items = 1.  So, I
just decided to include that in the v3 of the series after all.
