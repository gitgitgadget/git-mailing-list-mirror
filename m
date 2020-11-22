Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB17BC63697
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 03:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93A8F207C3
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 03:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vI6oXnBw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgKVDr5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Nov 2020 22:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgKVDr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Nov 2020 22:47:56 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702CDC0613CF
        for <git@vger.kernel.org>; Sat, 21 Nov 2020 19:47:55 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id 79so12759743otc.7
        for <git@vger.kernel.org>; Sat, 21 Nov 2020 19:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DZd5LNxeVbYLHS+zgm0tEOKi0NtPbj4n83Da9WwuLx4=;
        b=vI6oXnBwsFjS/+nERWHp4r+0jD2X8eiWQecoPpmd5O5qvVMQPkKl9Co9SjF3C8HnIR
         +tt5UFJFLJ+0E3g7eJO6vNcMaCLl1IeuhI2n+YDru1JlfGlI67P/DknQ3d/Rya+gtxDt
         hJNHdnOMeMT9Vh0BBViTgJkwrI8suirk+P0qW0b3FyqrM55ehfeu4VXOlfSwzOiTU8bT
         jMKcwQG8MhDAM/arO3ftNP/M8HyDLcPVt1oyqHi+vlSfB4aPv0/+J4jH341zKHVMtTg5
         Cr7kVCr+cLyyQx1WBkmeEI93PHF2e8pQXie8CHD4T+H/fAkRhudRzTFQ8XQ805bLpDfC
         Pa4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DZd5LNxeVbYLHS+zgm0tEOKi0NtPbj4n83Da9WwuLx4=;
        b=mDg2pWJgb7FckNyFUT2vKDBBpL5UHnk9GvYvz2Ha6s1kPGMLHb9RqY9aft2pndE458
         iXKMJHa34Rr67qsCjJdbD36Thtf+iVVll5hC0pcyYUwPfYvZvaqj2qRKszI7bKM7o+XA
         eqXQ2PtNxhowFnTCdz8yyFr+HIhnb/OmavgFy3dJau9/0AoVWI27pDzTq5bWFUVSmgz9
         hMcxgIL4W3SBIol4CeH2ntJfTKMFcT4zLJE7qfNDcHGzCTM7tA0Oi1/1WdDHs3TrGDhg
         GT7+1Fs4K0EfFzdps/EBMQDmxf2Yhl2izxNzloTjom441YmikPy1t2/lQ43hSfFANeuh
         EZOg==
X-Gm-Message-State: AOAM530bhZkudtk/XfW7xyzH7peWEYsv4rBh3WcCdI3xcpsHDmEyumQ1
        LFtFawJ5Jir4U/PB05PLJen104hOQr9dZZMEmrw2xhZqI3c=
X-Google-Smtp-Source: ABdhPJxEGoaO54TVtMOWSpw3yji8MeSTpUhaR4ZYzYZrkc1XoX5hQx//LQ7xHPuzq+D7DdUXaaZbFHrbMZg7Ua9pPeQ=
X-Received: by 2002:a05:6830:1002:: with SMTP id a2mr19685666otp.316.1606016874800;
 Sat, 21 Nov 2020 19:47:54 -0800 (PST)
MIME-Version: 1.0
References: <pull.919.git.git.1605891222.gitgitgadget@gmail.com>
 <5143cba7047d25137b3d7f8c7811a875c1931aee.1605891222.git.gitgitgadget@gmail.com>
 <CAPx1GvfaZ-pRznnOQELBYQ7LCk-sr_-Rd0aPcJ6ghM5yt8LpnA@mail.gmail.com>
In-Reply-To: <CAPx1GvfaZ-pRznnOQELBYQ7LCk-sr_-Rd0aPcJ6ghM5yt8LpnA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 21 Nov 2020 19:47:43 -0800
Message-ID: <CABPp-BELMS9o2+cCsefY-p9fF1j4BiYFaeYpLOHNmYXH3YVrpw@mail.gmail.com>
Subject: Re: [PATCH 3/3] stash: fix stash application in sparse-checkouts
To:     Chris Torek <chris.torek@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 21, 2020 at 4:47 AM Chris Torek <chris.torek@gmail.com> wrote:
>
> On Fri, Nov 20, 2020 at 8:56 AM Elijah Newren via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > branch.  However, this simplistic view doesn't quite work in practice,
> > because stash tweaks it a bit due to two factors: (1) flags like
> > --keep-index and --include-untracked (why we used two different verbs,
> > 'keep' and 'include', is a rant for another day)
>
> :-)
>
> Not that this should affect any of these changes, but I'd also note
> that the fact that using `-u` or  `-a` makes a third commit that cannot
> be ignored later is a problem as well.  (`git stash list` should probably
> annotate the listed stashes as to whether they are two- or three-commit
> stashes.)

Yeah, it seems a bit odd when you compare to saving and applying
cached changes; for that, stash requires you to specify BOTH
--keep-index to to push/save, AND --index to pop/apply.

However, for saving and applying untracked or ignored changes, you
merely need to record them at push/save time and they automatically
always apply.

Not very consistent.  (But, again, unrelated to these patches, so this
is mostly just recreational complaining at this point.  I'm not
planning to tackle these bits.)

> > stash has traditionally gotten this special behavior by first doing a
> > merge, and then when it's clean, applying a pipeline of commands to
> > modify the result.  This series of commands for
> > unstaging-non-newly-added-files came from the following commands:
> >
> >     git diff-index --cached --name-only --diff-filter=A $CTREE >"$a"
> >     git read-tree --reset $CTREE
> >     git update-index --add --stdin <"$a"
> >     rm -f "$a"
> >
> > You might that between the merge that proceeded these commands and these
>
> s/might/might think/, perhaps?  And, s/proceeded/preceded/, probably.

Indeed; thanks for catching those.  I will fix them up.

> (I didn't look closely at the rest of this but the idea seems sound.)
>
> Chris
