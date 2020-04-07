Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F56C2D0EC
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 19:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B693420730
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 19:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyWwEY83"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgDGTqI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 15:46:08 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44361 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgDGTqI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 15:46:08 -0400
Received: by mail-ot1-f67.google.com with SMTP id a49so4394982otc.11
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 12:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=avTeJm4SjQWb3VLF3hrn1Rq09GaAk3YAG4vzkmMgPOc=;
        b=JyWwEY83mArPPqCnqWeRKY+Nj6UY9S7pQvNlLFrs6NMUmnIGGsNWTt9jfgmD2bWc3n
         kU6Q9KUB3UQoUrnOO59iIgBJnRDueDNP4zzDOmIM0jzkfWdqH9VIgllB253AUlVS5rL1
         efNy9h2J8UyfOunbKhEJlb+FEr5LyCQn+M22TOYsj4WdlFG6gv3XxRQr0wSm6uFRJHmd
         HhPeBDZ7nbh7y5zGVGw3Qb0fz6IVypQfZWc/sF0t++cYxkX8O9jN0WtUWUSZLVARWCY7
         n+WiLhaE0pyjdQi6huehYRTJR+YuL2IHgwiGKxVs2aCrkX5fDq6GBk8rD9Xwdk+KyR1t
         RJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=avTeJm4SjQWb3VLF3hrn1Rq09GaAk3YAG4vzkmMgPOc=;
        b=CLWkJiDHYEzc2/kum4d3ekGQd/6l6bdzQ9iFdFNW4igbMlprW+lR5OxnKaH1cX+cPm
         O8XCTlt8i1f1z/gYmAQ8pnNbcvnLLqvl4Hbv6R+X9h9NUmmU7Nx9W6khzLB+/hNdamWz
         iVutIkilxu32yuDU2QwlQ5PmxQ4n+qq3Da7pTEdUl8BNibkU3F8Br29A+CwxC+oP2YpO
         5JAaCCb9WtDaeKMAxFIDchx3EGzMN24Gel747Xp5v6sWm1WqKDlONH7v1MX4AZ9DulQb
         BnJSvsRb1W2dwoEdIQzfPDZbA3NafmJi3JCkBzQqr5tFhSyT+rISusk3Vh5Y+G5Vodbp
         NOgw==
X-Gm-Message-State: AGi0Pubjlfk8+iBndTw6bh8pPYN+GjNCYvAsCSCNw0geWBXEtAMClQM3
        YL/tSklxDWqd0EjflWRg9BrXJ3ETbpY+RiHjf/A=
X-Google-Smtp-Source: APiQypLymHPIjGjFY2JAAEOFxBJs4auITsSXXDlt/C2+Y0nGTRmSePRmIvd13MYERwRwkIWWDt2dDWk50Z1Uzpuvfm8=
X-Received: by 2002:a9d:6097:: with SMTP id m23mr1302256otj.316.1586288766965;
 Tue, 07 Apr 2020 12:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAAb+AL8+c6knrQnoi7YOjyM+Wc8-rws-JXVufBc=PciAvPPFJQ@mail.gmail.com>
 <CABPp-BGFinonZJb2u_0-fX3y_UyJ1dY+O40oN0WAzZht0ddJ4w@mail.gmail.com> <xmqqh7xvtby2.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqh7xvtby2.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 7 Apr 2020 12:45:55 -0700
Message-ID: <CABPp-BF8eokQTVwgo80ffq3tn=NA=mPf7oymce5P4itDyZBiMg@mail.gmail.com>
Subject: Re: New git-rebase backend: no way to drop already-empty commits
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sami Boukortt <sami@boukortt.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 7, 2020 at 10:58 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > Yes, from the manpage:
> >
> > ...
> >
> > and
> >
> > """
> > Empty commits
> > ~~~~~~~~~~~~~
> >
> > The apply backend unfortunately drops intentionally empty commits, i.e.
> > commits that started empty, though these are rare in practice.  It
> > also drops commits that become empty and has no option for controlling
> > this behavior.
>
> This is a very good illustration that shows why "switch the default
> and retire the apply backend" deserves to be cooked for quite a long
> time.

Yep.  I suspect it may be a long time before we have --whitespace=fix
implemented anyway (because I'm not sure there are folks who want to
dig into xdiff), but even if it was implemented soon, retiring a
backend that has been the default for many, many years is the kind of
thing that should wait a while.

>  The 'apply' dropping empty commits may have looked like an
> 'unfortunate' thing to whoever wrote the above paragraph in the
> documentation, but it clearly shows that person (me included) did
> not think of the ramifications deeply enough that there may be valid
> workflows that _depend_ on the behaviour.

Guilty as charged.  I did try to highlight the empty handling for
reviewers when I posted the backend switch series (see e.g.
https://lore.kernel.org/git/pull.679.git.git.1576861788.gitgitgadget@gmail.com/
and
https://lore.kernel.org/git/pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com/
and some of the emails between Phillip and I directly about that topic
while discussing the series), but it's understandable that this could
be overlooked by not just me but reviewers as well -- the workaround
of running an interactive rebase and remove the lines they don't want
probably seemed really simple and clear.

> As we will be dropping 'apply' that could be used as an escape
> hatch, before we do so, we should teach the other backends an
> alternate escape hatch to help those who have been depending on the
> behaviour of 'apply' that discards the empty ones, whether they
> become empty, or they are empty from the beginning.  I think the
> "has contents originally but becomes empty" side is already taken
> care of, so we'd need to make sure it is easy to optionally discard
> the ones that are originally empty.
>
> Thanks.

I will take a look into it, using (or at least starting with) the
suggestion Sami provided.
