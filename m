Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B132C433F5
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 05:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbiBHFnF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 00:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbiBHFnD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 00:43:03 -0500
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D7FC0401F0
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 21:43:02 -0800 (PST)
Received: by mail-pj1-f54.google.com with SMTP id om7so1998683pjb.5
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 21:43:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=im03o4+CQgpnVk5KHJpt9R7SR9zBfQupYmNESyc15d0=;
        b=P+lu01HO8QCuhzP0X7Z7OsauLVeJsYoL9jYWCNDypy5m67A2AABXcKYLGBsA2WRRPd
         hKf+fk1doUP3OySfu6OlmDFOfPhWrIUuyap51Iz6K2+CYBJDLKXM3MKyPN9Nt4s0g5y6
         ddM+Q2kKg5Qhh9DNToevfqpKaPoqJuP+RfgAeFgXg8E2QUsyBuaDy3cNbaMsggeoIiN1
         U8qx/5jKTIgMWwU7EGjetvIuqoIMoZ7iGOZWXwWj9gN/a9kpaw+viJa71r5mZjKth5x1
         +XOpvf1xjwrijMvpwnBOWOlnxXU6KuNVr4PtBAXatdt5f2iCM30iKxGF/kiNj17SII/C
         qdcg==
X-Gm-Message-State: AOAM531j8xQYPMRr8Abq4GhabZSOJkMg44v9MOAJIpLyUxrqTGsu5S6D
        Aa+8LAu00F8lRjNrmkFO6pgT7NY9gAu+33Sz6+qLCOOMu3M=
X-Google-Smtp-Source: ABdhPJw0VIyjGOcxJAsrY+XteRvftMitoAdTKdRMq5rGmR8GCMCA4BKxM6TiJwpMeWvvJscfMJrhfSPTkxQeZBWclSE=
X-Received: by 2002:a17:902:a413:: with SMTP id p19mr3088198plq.35.1644298981704;
 Mon, 07 Feb 2022 21:43:01 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
 <pull.1101.v6.git.1644269583.gitgitgadget@gmail.com> <CABPp-BG4m6i+yobjnD6UC5S5n3k-HbB7Y5uUNEvrD79ErOoYHg@mail.gmail.com>
 <CAPig+cT7GwyhPOBdqDDh8jGm+mWK1x9Gt4Zebcw34dgFyaufkw@mail.gmail.com> <CABPp-BGZoGwpMaqo2px1SqOBk1xLHtwkkBBAaqU5sNfTvKD1og@mail.gmail.com>
In-Reply-To: <CABPp-BGZoGwpMaqo2px1SqOBk1xLHtwkkBBAaqU5sNfTvKD1og@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 8 Feb 2022 00:42:50 -0500
Message-ID: <CAPig+cQWnuG+-eWyih7-Q75PeFjQRHN58SWWhFQWHU2=R6GfyA@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] Sparse checkout: fix bug with worktree of bare repo
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 8, 2022 at 12:18 AM Elijah Newren <newren@gmail.com> wrote:
> On Mon, Feb 7, 2022 at 9:03 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On Mon, Feb 7, 2022 at 11:14 PM Elijah Newren <newren@gmail.com> wrote:
> > > Was the empty bullet point meant to cover the new patch 6?
> >
> > The "Updates in v6" section was botched a bit. If you look closely,
> > the remaining bullet points actually ended up in the "Updates in v5"
> > section. The complete "Updates in v6" section should have been
> > (approximately):
> >
> >  * Updated documentation to use "working tree" over "worktree" and
> >    "<id>" over "<worktree-name>"
> >  * Delay some allocations to avoid leaking memory in error conditions.
> >  * Use "main worktree" over "base worktree" in comments.
> >  * Removed use of git_configset_get_string_tmp() and added a patch that
> >    removes its public declaration.
> >  * Fragile variables are replaced with better ones.
> >  * Variable names and code style improved.
> >  * Several test cleanups in patch 5.
>
> So, you clearly also read the patches in this round.  Do they also
> look good to you?   :-)

I have not yet looked at either the patches or the range-diff, and I
only scanned my eye quickly over the cover letter, but the empty
bullet point made me stop and look a bit more carefully at that part
(and only that part) of the cover letter. Not sure yet when I'll have
time to carefully read this round.
