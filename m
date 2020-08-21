Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7F0C433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 22:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABD2920738
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 22:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWxUTx4L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgHUW0A (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 18:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbgHUWZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 18:25:58 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0CBC061573
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 15:25:58 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id o8so69427otp.9
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 15:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jZrUIfMsIHCoEas+ktU3Emip7BRpofAIgMS/12U4l7U=;
        b=CWxUTx4LtGd1vd5zn8CwuEjMY+wpVUDF8oHrS3hmsUOsJcnpfATzazAUTzvsxUM0sW
         Zyy01kc6z41GEAEwrW1qVaC8nPNFZClhiG8Ca1Ix0nO0vOlc172pZorg8B+ZXacjqFzC
         mHCmOO0kPex4nUiaB72yaNIR/hwb1WztAk6ipOTULsJttVZyoXjyJUa6GC5jaQr4PIGT
         hVlKiTmdGuSVNif6HdPwnhf67Y3WHerzjsJSIJtHgK25rtSr2hRx0SyJBEbSBhL6Em5g
         YQreRMy2r7W2ogiLUsnINNhToRQr32Sk1JNmHMTZWWnqZ2oPhxngryfLuLdc5pcPHrqs
         UdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jZrUIfMsIHCoEas+ktU3Emip7BRpofAIgMS/12U4l7U=;
        b=asAsOo+p593UhsYoHccyLEDbD5NMdixe4QRGddxPT5/cCIiKL2nOT3/J8dPoPKNju8
         HqhD63UW4WDPsGh2BIhRzCKAOOzZKRRybBnhFS7ogmECUbUYaCZugFWu0N/hZd5Q7sS8
         OEwQpFFTZX7UCw1ReY+JTHazPrHTuzH8Vd7bDdFIs3BlxwauaYmvZJl8/CSdh7OOGsgh
         zeckHswPQ6lNQ4O/Kw8Q692MOVNwcI3vnDlZdkDzNuYOgAHqxjRF2FwYJ2GiSttC11Uf
         b+w+5U3pwyRdgJPtmv6W8nrp2JSKi3uSsbrO1xge4Y7cY/uyxeSei0XM9EEF9q9VVYnp
         fkwQ==
X-Gm-Message-State: AOAM532l2dg47OR5Qqour6zMoNCN/TnkplySHM6crBTFGLv1JORjs19k
        9Qs9VVhAuZe7QCg91fkRc5Mw6h/RV+RdHAg8dSjDA45lRCo+BA==
X-Google-Smtp-Source: ABdhPJywk7gfQPbT1tQunFkZPatzOt8IFfzmo6JcniVoxQ5P2zrwIqSRDngTMOD6kX/bO9TG7a6dpYdwg6KIvS+v6iw=
X-Received: by 2002:a9d:4783:: with SMTP id b3mr3642471otf.316.1598048757217;
 Fri, 21 Aug 2020 15:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
 <b3095d97d8ee9d6576292731cc100492e7c64f13.1598035949.git.gitgitgadget@gmail.com>
 <20200821200121.GF1165@coredump.intra.peff.net> <CABPp-BGJK4C7U+-MB-+TUgFAuuFJKE-E7y17FFJDRTyFydVX2A@mail.gmail.com>
 <20200821210301.GA11806@coredump.intra.peff.net>
In-Reply-To: <20200821210301.GA11806@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 21 Aug 2020 15:25:44 -0700
Message-ID: <CABPp-BE8tdpjx2RBGyZOYV4hsfjm5HF_dmehvX792x7TtWkLcA@mail.gmail.com>
Subject: Re: [PATCH 4/5] strmap: add strdup_strings option
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 21, 2020 at 2:03 PM Jeff King <peff@peff.net> wrote:
>
> On Fri, Aug 21, 2020 at 01:41:44PM -0700, Elijah Newren wrote:
>
> > > This is actually one of the ugliest parts of string_list, IMHO, and I'd
> > > prefer if we can avoid duplicating it. Yes, sometimes we can manage to
> > > avoid an extra copy of a string. But the resulting ownership and
> > > lifetime questions are often very error-prone. In other data structures
> > > we've moved towards just having the structure own its data (e.g.,
> > > strvec does so, and things like oidmap store their own oids). I've been
> > > happy with the simplicity of it.
> > >
> > > It also works if you use a flex-array for the key storage in the
> > > strmap_entry. :)
> >
> > I can see how it's easier, but that worries me about the number of
> > extra copies for my usecase.  In order to minimize actual computation,
> > I track an awful lot of auxiliary data in merge-ort so that I know
> > when I can safely perform many different case-specific optimizations.
> > Among other things, this means 15 strmaps.  1 of those stores a
> > mapping from all paths that traverse_trees() walks over (file or
> > directory) to metadata about the content on the three different sides.
> > 9 of the remaining 14 simply share the strings in the main strmap,
> > because I don't need extra copies of the paths in the repository.  I
> > could (and maybe should) extend that to 11 of the 14.  Only 3 actually
> > do need to store a copy of the paths (because they store data used
> > beyond the end of an inner recursive merge or can be used to
> > accelerate subsequent commits in a rebase or cherry-pick sequence).
>
> I'd have to see the code, of course, but:

>   - keep in mind you're allocating 8 bytes for a pointer (plus 24 for
>     the rest of the strmap entry). If you use a flex-array you get those
>     8 bytes back. Full paths do tend to be longer than that, so it's
>     probably net worse than a pointer to an existing string. But how
>     much worse, and does it matter?

I'll investigate; it may take a while...

>   - That sounds like a lot of maps. :) I guess you've looked at
>     compacting some of them into a single map-to-struct?

Oh, map-to-struct is the primary use.  But compacting them won't work,
because the reason for the additional maps is that they have different
sets of keys (this set of paths meet a certain condition...).  Only
one map contains all the paths involved in the merge.

Also, several of those maps don't even store a value; and are really
just a set implemented via strmap (thus meaning the only bit of data I
need for some conditions is whether any given path meets it).  It
seems slightly ugly to have to call strmap_put(map, string, NULL) for
those.  I wonder if I should have another strset type much like your
suggesting for strintmap.  Hmm...

Also, one thing that inflates the number of strmaps I use is that
several of those conditions are specific to a certain side of the
merge, thus requiring two strmaps for each of those special
conditions.

> > So, in most my cases, I don't want to duplicate strings.  I actually
> > started my implementation using FLEX_ALLOC_STR(), as you suggested
> > earlier in this thread, but tossed it because of this same desire to
> > not duplicate strings but just share them between the strmaps.
> >
> > Granted, I made that decision before I had a complete implementation,
> > so I didn't measure the actual costs.  It's possible that was a
> > premature optimization.
>
> I'm just really concerned that it poisons the data structure with
> complexity that many of the other callers will have to deal with. We've
> had several "oops, strdup_strings wasn't what I expected it to be" bugs
> with string-list (in both directions: leaks and use-after-free). It
> would be nice to have actual numbers and see if it's worth the cost.

I'll go get some and find out what the impact is.
