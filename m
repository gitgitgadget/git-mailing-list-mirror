Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1405C07E95
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 01:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 982266117A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 01:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237244AbhGNBZw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 21:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237223AbhGNBZv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 21:25:51 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3D5C0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 18:23:00 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id c197so450354oib.11
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 18:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sFIpVI/H9WEVv7UAApRSEQpWUXi91azm9xq9vcKK3zw=;
        b=o5Wt1CfsYE51Rbzsxwyagu2jdhqGm9JAvvKge+72VsPvNiWupBUXfb/DLR1tz0EjKl
         Uf4AZ7ybzG1/N+TDdO2IW/o7go+s5ST8S3ge/K4AhQlfa3UUCzP9qsJ6QC1HB10+9haP
         dF3qBUEXzvxueFqoSWWQZ/183YiROp5TEyOPaB2LQEy81686jB4ULMMRWxStzUKH8ogX
         OeeURmJ6SBu3dYNo8kqo9A5tjNB+NF5Al1LmtjWZfk/VI5+/wQGNez//qfnReNvuF2he
         7oHobtKmV+jnUpLcPThBsyX77KF7AXWve8xYgQ4S038GBCpTkek72xPyY/AAB+gQnR+U
         DQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sFIpVI/H9WEVv7UAApRSEQpWUXi91azm9xq9vcKK3zw=;
        b=hhUwRMIYPhksE3c9e1U+hEzr1w55/PfWttCvoo0Ld6yogm8lhGEbzIFC0IIdaRYQW6
         NFX9CzpmD71qOHJiEnfU63yInPC8OdFgSva7GKR4KvDe51E2Tm5m+GWpxO6b/jRuB3mE
         WjCIrsNmqq4CXznoG/qZ4NOG5aRBj+rGGNep6Prlsz4mJ2rg37BrzkTUlC/HmS4VA7nj
         FDDC8X73c1FDGj2+ffCxJSvsyliTqm93J0rvUbHMTOwAGci799YEhSve/Fo0ZWKTScsV
         Rcm5auy3ZiiJ9Xw0bRzp0DF+iV1xqd1SXEjAzmrepNdVsYGPpWZ5Ie2/NWVj+aL2Dskr
         o5yQ==
X-Gm-Message-State: AOAM532ybOF8+UFbrE6co01ccZW6gZd2R9ymIh4gB80MaZA4jv3QmXzn
        wvbXJDhSDZ1ttY7zYWPoF5BMfhJme+g432OtDa0=
X-Google-Smtp-Source: ABdhPJxrjiae0K4CCKQFOJ2jmIjp8M6/Y+t/GYh/Hr81t5QOJS9zmRtNuRYmh9xQpx2MKNQMw+tdoxPAKz74liE/6dc=
X-Received: by 2002:aca:d644:: with SMTP id n65mr5412336oig.31.1626225779394;
 Tue, 13 Jul 2021 18:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1044.git.git.1625964399.gitgitgadget@gmail.com>
 <44a5d5efaa637d01ec3266b34f31d46acce5ef24.1625964399.git.gitgitgadget@gmail.com>
 <9707b299-3846-6388-36ba-e8d93a28e2ac@gmail.com> <CABPp-BHF3Os7fOeaF_EQOo+Bs7f1DXbYr26WmAQrPjv63nq1Pg@mail.gmail.com>
 <xmqqzgupzppb.fsf@gitster.g> <CABPp-BHdAZYPf0QPOTiekU914u6pNxUSRQEmdN0xOLGv5hdkzA@mail.gmail.com>
 <xmqqim1dzomt.fsf@gitster.g>
In-Reply-To: <xmqqim1dzomt.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 13 Jul 2021 18:22:48 -0700
Message-ID: <CABPp-BFrLd+h0rzkY5nijVLzXh7bUK5t7Go=EY9jZksCeKqQLg@mail.gmail.com>
Subject: Re: [PATCH 3/3] diff: correct warning message when renameLimit exceeded
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 13, 2021 at 6:10 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > The exhaustiveness of the quadratic portion comes from comparing each
> > file to more other files, not in using a different type of comparison.
>
> Exactly.  By culling potential matches early with heuristics, we
> make a trade-off of risking false-negatives but save a lot of cycles
> while trying to find "renames with modifications (which is what we
> called 'inexact rename')", and my comment equated  fewer false-negatives
> with more precision.

Okay, I think I'm following what you're saying now, mostly, but I'm
curious about the false negative comment.

Am I mixing up negatives/positives (as I'm prone to do), or would it
be more correct to say the new algorithm risks suboptimal positives
rather than that it risks false negatives?

In particular, the new algorithm will compare files with the same
basename and just accept that pairing if they are similar enough, even
if there might be a better match elsewhere.  However, a lack of a
match in same-basenamed files will not cause those files to have no
match; they will instead just be included in the exhaustive detection
portion, so we can still detect renames for such paths.
