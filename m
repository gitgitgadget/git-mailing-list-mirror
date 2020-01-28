Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD47C33CB3
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 05:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA022173E
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 05:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnY/nkRn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbgA1FVz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 00:21:55 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:40732 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgA1FVz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 00:21:55 -0500
Received: by mail-oi1-f174.google.com with SMTP id a142so7577119oii.7
        for <git@vger.kernel.org>; Mon, 27 Jan 2020 21:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nv0YUUrW+r8TLGCmCVkQW0w8ZX8fF4PNrEawxoWwx4A=;
        b=hnY/nkRnZSXPblnqorwixzsnL3PpWQMvQAR1ypgJujnmemMOHj+/ZNt2lbAYSvSMNT
         Hm+DZUKw8TdrRZTG72NcT/4qmC+afDDqeZiXveGCoaaqq7VzZ6uV33LyAkGTxcZBGcuS
         AqWf+Vc+pJcSyRmRftDyhq9drJp8pnCJnIKFGnzALGIxKkiRGLMvQZ7eGYJZey7dZtMt
         /iPhkLWU7zEcipGikoUWmFb2NIVymQnC80Vwv8qjOO0i7iCnk75dngkwqLGkBNX69pjc
         fHCaCdJG0o1n8f33PP3FjveiuKGBhBXSiwq3fFeGwNox+4rcUWkk0WPswvRRDhYtTa3j
         FbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nv0YUUrW+r8TLGCmCVkQW0w8ZX8fF4PNrEawxoWwx4A=;
        b=W9gpe8j0OZb1lRZeP4Nk4gN873sUvjIkXJIfbZ4zXrBOkP0F5JJl/ZYgfvCFWn2krG
         On1TfvVhFSUQKMuKNfFyQ5WBfvVsBpghATPQ/PuDUMuzHXwUP80osNoPT1L0N45wXqU8
         3BKOYkfDY2K3DbHxcE9KnqB7z+CWnzp5o+UtwRXDtlE4hpTC4RsRMPUEkMUtG0Wxdb2F
         uFeQlSowYa/3KFrkzwgew37uF3Xi3UpTYlU6d6YT+PrzoK41WHslk3KE3ZZC0czAYRT/
         sCrJF0SOs3dRGUcbeMME85Ya344bOr6OcamtRShC6On2w6f/g7X+SHCKBV/1m03RA6ts
         oLLg==
X-Gm-Message-State: APjAAAWKTtrYxa1ZvvWI75hJJvK/br/79CEMAp6ml/hPjRCk/kE3SmXI
        174IX4bzMTi8l2Z+xrn7+Wb2cqP9ZYylp9ReLpBQ4Q==
X-Google-Smtp-Source: APXvYqwaU0sTGwQSAI4I7coBj+mpGPikvPqqlaOM2+H1OMisobBCJhltYFmnRCi3oMnM5gGu0abWHMzWUignYOr1FWc=
X-Received: by 2002:aca:1b01:: with SMTP id b1mr1693343oib.6.1580188914081;
 Mon, 27 Jan 2020 21:21:54 -0800 (PST)
MIME-Version: 1.0
References: <062301d5d0bc$c3e17760$4ba46620$@Frontier.com> <d4056731-c13b-c89d-dfd2-e6235e29fed6@gmail.com>
 <405d83bd-cd50-49c5-a068-6d3ce102f669@gmail.com> <CABPp-BFB3pN1arWb9Acj7La1aX7j=axANnSWV8f7SmW_KuqD0g@mail.gmail.com>
 <de300697-baba-62a6-ea4c-c5bd472954c2@gmail.com>
In-Reply-To: <de300697-baba-62a6-ea4c-c5bd472954c2@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 27 Jan 2020 21:21:41 -0800
Message-ID: <CABPp-BHRAA71LmfYb61N+qAgwhtii7TSEVJksiAGnnO-4bk2dQ@mail.gmail.com>
Subject: Re: Sparse Checkout Trouble (2.5.0)
To:     Derrick Stolee <stolee@gmail.com>
Cc:     JunkYardMail1 <JunkYardMail1@frontier.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 26, 2020 at 6:09 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 1/25/2020 3:59 PM, Elijah Newren wrote:
> > On Fri, Jan 24, 2020 at 7:41 AM Derrick Stolee <stolee@gmail.com> wrote:
> >> I'm CC'ing Elijah because he also made changes to dir.c, and
> >> perhaps he has some idea of what's going on.
> >
> > If you think it might be related to the dir.c changes, I can take a
> > look.  I don't have any immediate ideas off the top of my head.
>
> The only thing I can think of is that these paths are already
> marked as sparse, but something is requiring us to test if the
> path can be created with the filesystem. I'll try to debug
> more into exactly where that is. It's telling that this happens
> both in cone mode and without.

Yeah, I'll take a look.  The exponentially slow 'status --ignored'
report is forcing me to look at dir.c again anyway, though it's also
delaying me from getting a chance to look at this particular report.

> > However, since I'm really suffering with "git read-tree -mu HEAD"
> > being the mechanism for updating sparsity (for reasons independent of
> > the issue being discussed here), I've been tempted to dig into that
> > anyway to write a replacement without the nasty side-effects.  I'll
> > take a look early next week and see if I can spot anything.
>
> If by "nasty side-effects" you mean "overwrites staged changes, even
> if in the sparse set before and after" then I would welcome such a
> change. Otherwise, it will fall to me, and this is far outside of
> my expertise. Of course, it is something I should learn, but I can
> learn that during code review, too. ;)

Yep, that's exactly what I mean.  It'd be nice if Duy were still
around to bug, but I've touched unpack-trees a few times so I might be
able to find my way around.  I'll try to take a stab at it.

> Thanks,
> -Stolee
