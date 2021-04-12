Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BC4C433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E280A61220
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243851AbhDLRFI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 13:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243915AbhDLRD6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 13:03:58 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190E0C06138F
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:03:29 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id g17so18701224ejp.8
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=formlabs.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jkJoXh8dytHVYbRakBQJDNeDg1zYIUvbGwubF/D8Uz4=;
        b=eDH0/37pwIHvftnlGGCziOq4Bn/Jk7r9HZfWQgDYqgk3blxx9OCFcqXFgVIml7/zHL
         IBBQEd2tZbwiAgTVCON0G0L251q7TzJN2nHPqX9Rpf8YHMkMcVAl531r1R7XEZUhA5UB
         opS2U9fEccMUqJmnjGjAyZkvdhGIfV5TYIHoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jkJoXh8dytHVYbRakBQJDNeDg1zYIUvbGwubF/D8Uz4=;
        b=tiDzEUpES/i51wv24OpDu1jTVxpdaHkavgD5jRwG9BlcvdQX1SaGO1VaJKjdEbIPhk
         c9LwkTtOMEwOEk9Qd2sbtbLNIkh4DEnWx12F60h/+MfUXBt8ybVLqGEryGEZTbodIs2R
         Y7CrxGKuiej3jQxVhk9a4h3s0amwziekgUhUauJUdUD+sYwg/qM2b/25/BBsEGCFqQgz
         Wat1euvmKd84uZyuEMZ3C2gc4DZmMiOhatXoIDxhSX7gsmMF2EXQfSuPYCkQfmTr5Jh2
         chV8f+7pPIS0kIACN1aoFeOi0B0yM+NM+0mq/3f7MdIVHTd7mlepO17g77LGueIhjErq
         aD/g==
X-Gm-Message-State: AOAM531mmDwoStJvj45wBw0WOBLz2OnMPvkkoBj39Sr2HsH2dtBsCCku
        7nHYMGr7XFXIxYvdePPtye/ISIVNOOGodxx73NI1V62+uwDTKg==
X-Google-Smtp-Source: ABdhPJx84KYX/bChmjsEhEajyWtdjKT4CCpeg2nKhNBm/mevZXhy4vlf1Ho2cDjXJQO9wfvyVL8QkrlSMX/7iWb1t6Y=
X-Received: by 2002:a17:906:3684:: with SMTP id a4mr26456508ejc.316.1618247007761;
 Mon, 12 Apr 2021 10:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAKJ37DfivxL-2Sy0qa+M_1Pw0c9-CWsCJO5=VqP1UOB5zTSP_Q@mail.gmail.com>
 <CABPp-BEOnrnQKov1YDdHXkb6CCNxudE9bUdntOeq3k0wOODc1A@mail.gmail.com>
 <CAKJ37Dc5-rOeN_=vq5P3=z=_1bqGFRuFhuWde6cS0vGg3mkLnQ@mail.gmail.com> <CABPp-BHASo5CFejED8CFbB1zszAaQW1Q8yitUdqW-wi8eFuvWg@mail.gmail.com>
In-Reply-To: <CABPp-BHASo5CFejED8CFbB1zszAaQW1Q8yitUdqW-wi8eFuvWg@mail.gmail.com>
From:   Tamas Peregi <tamas.peregi@formlabs.com>
Date:   Mon, 12 Apr 2021 19:02:51 +0200
Message-ID: <CAKJ37DeVyQOfQAN-k9MvUT4TY1HBSU6+hJuLBauGAW_7i=ojTg@mail.gmail.com>
Subject: Re: Unexpected conflict during cherry-pick after moving submodule
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

thanks for the expanded reply, I think it cleared everything up.

Regards,
Tam=C3=A1s

On Mon, Apr 12, 2021 at 6:53 PM Elijah Newren <newren@gmail.com> wrote:
>
> Hi Tamas,
>
> On Mon, Apr 12, 2021 at 9:08 AM Tamas Peregi <tamas.peregi@formlabs.com> =
wrote:
> >
> > Hi Elijah,
> >
> > thanks for the quick reply and the useful information about the ort str=
ategy!
> >
> > Do I understand correctly that the problem is in the recursive
> > strategy, i.e. inside the cherry-pick step, not the submodule
> > movement? That sounds a bit unfortunate in my case, as I'm the one
> > moving the submodule (then merging it back to master), and others in
> > my company want to cherry-pick over it, so I'm breaking their
> > workflows if I go ahead with moving. (Unless I tell all of them to use
> > the experimental ort strategy instead, which may introduce its own set
> > of problems.) Is there any way of moving the submodule that doesn't
> > break cherry-picking with the default (recursive) strategy? I'm
> > willing to do some extra work to spare confusion by others down the
> > line.
>
> Unfortunately, the recursive merge machinery had a variety of issues
> with submodules (see e.g.
> https://git.kernel.org/pub/scm/git/git.git/commit/?id=3Daa2faac03ad646873=
ebac2b230581d1d26dd1b99)
> and yes, the merge machinery is intrinsic to cherry-pick's
> functionality.  I don't have a good workaround for you, short of "wait
> until git-2.32 is released".
>
> > Also: up until now, I thought cherry-pick simply exports the source
> > commit as a patch, then applies it to the target commit, but
> > "recursive" is a merge strategy, correct? So is cherry-pick doing
> > something vastly more complex than I thought, involving merging in the
> > background?
>
> Right, cherry-pick makes use of the merge machinery using a particular
> specially crafted merge while recording it as a regular commit.
> Interestingly, the rebase command has multiple backends, one of which
> used the merge machinery and another that behaved as you thought by
> creating and applying patches.  While the use of an appropriate
> special merge (as done by cherry-pick and rebase) is roughly
> semantically equivalent to what creating and applying patches
> provides, the create-and-apply-patches procedure actually discards
> relevant information and results in some shortcomings that simply
> cannot be fixed.  As such, we switched the default rebase backend from
> "apply" to "merge" as of git-2.26.  If you're curious, read up on the
> "BEHAVIORAL DIFFERENCES" section of the git-rebase(1) manual,
> especially the "Context" section.
>
> Hope that helps,
> Elijah
