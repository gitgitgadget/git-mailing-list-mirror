Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729E1C388F9
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 19:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 043E320BED
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 19:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vYwiMvYe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754054AbgJWTIN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 15:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754051AbgJWTIN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 15:08:13 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4FDC0613CE
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 12:08:12 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id k1so2416404ilc.10
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 12:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KXROMgmiKAQ1fWKE8VmWiW43nUMXZOjtxuojNckgg2k=;
        b=vYwiMvYe91Xz+I7Wi2HK0rKS6yW4WIP4Hif9WQC+4VuY3lUxTAN6b2Iw/wHxQvwtlm
         RZLj/d1H6kaKx9L1OW3URuNAkRz4TjDRzCSexNLRUdFWf9PVv2BUyzbXaNqVzPrCJgzw
         aRDelCZFN4NvVFNncS1aUnyBw+6hMx5GppnbpgAqF6nWcUILyuq0kRuzseZEGxgIherU
         h3q638uL5OubmD3fhz1jZAOM5AF66E/nxhj7IiCbAyaul1EIh4pg5ML3nbOTYWRTZwib
         j8IA4HCFCEoOHZNZvVHNySHG5cWE+uSdAR3SOh8tK4dFWTnuV3LLp5TGYG05IR9mbLzc
         dQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KXROMgmiKAQ1fWKE8VmWiW43nUMXZOjtxuojNckgg2k=;
        b=Mum097rswpYZkxqC/4/DhxsbHAoP7PZw0qdqNyKayXO71IK3wskSkuBk173PRzVg7O
         VFbKmxR+TPTRN+Rd4FhrkkiTu5OfF/U+WWiWzSRKYdDYLsYYsux+DeBLqpSXlJke9sVl
         jPo+ykGh8CG3JYH5RH5jr8/P+1VdVhwCu8wWd+9ClSc6WSys8DY7jVJfzT0POZ3IrWfq
         a8ZuOCgeRu2QGsX1O3SV+s4Y30dPz395lYLKUjSc6Axxk7wNT0PU1AmvobJpyp2v+pTd
         K2IaLQ6Pk8deuNMyTtCk7sKU++trXH+4dQPxvdyixySfpVGyO8WZ43Sn4aP6MJDY/Y17
         vsfA==
X-Gm-Message-State: AOAM531Ix8/x4vqyVWxvGrhd+bw8t8EZ3WSpRGw7g9zNwuEYwlnRaBuQ
        RAvjkJw03NK4QP3qHjS1Ry+e4gV67l40Lcn4n0s=
X-Google-Smtp-Source: ABdhPJwhDGjwJXctTU9J0eIeI7EjVlA5l31ch2f71r6raNApXhFRQkhBCj3pT/eI7udeju0Vy5Bl8e6B4GXtKQxv9wQ=
X-Received: by 2002:a05:6e02:11af:: with SMTP id 15mr2681769ilj.5.1603480092256;
 Fri, 23 Oct 2020 12:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <pull.751.git.1602781723670.gitgitgadget@gmail.com>
 <20201022112201.51459-1-sangunb09@gmail.com> <xmqqft66m8wm.fsf@gitster.c.googlers.com>
 <CAHjREB4qGO1=XCy-F+H39FP_KU_zZjKCDA=b9JxCe0WZdM06KQ@mail.gmail.com>
 <xmqqr1pphsvs.fsf@gitster.c.googlers.com> <CAHjREB4egt95fCz6pzON2h5rVH-XvYKf1oGnyU-8gVL-U3WrmA@mail.gmail.com>
 <xmqqd018hivx.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqd018hivx.fsf@gitster.c.googlers.com>
From:   Sangeeta NB <sangunb09@gmail.com>
Date:   Sat, 24 Oct 2020 00:38:01 +0530
Message-ID: <CAHjREB6E+okXUA8tffKkoC++zbv55GWwdYJocxo9ey_X5zPeiA@mail.gmail.com>
Subject: Re: [Outreachy] [PATCH v3] diff: do not show submodule with untracked
 files as "-dirty"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 24, 2020 at 12:25 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Sangeeta NB <sangunb09@gmail.com> writes:
>
> >> I found this change a "noise":
> >
> > Oh okay, Again sorry for the misunderstanding.
> >
> >>
> >>         strvec_pushl(&cp.args, "status", "--porcelain=2", NULL);
> >>         if (ignore_untracked)
> >> -               strvec_push(&cp.args, "-uno");
> >> +               strvec_push (&cp.args, "-uno");
> >>
> >> If it were going the other direction, "we fix coding style violation
> >> while at it" may be a good justification to do so, but this
> >> particular change (1) is not neeeded for the purpose of this patch,
> >> and (2) is making the code worse by deviating from the coding
> >> guideline.  Please drop it.
> >>
> > This part of the change was introduced because we had a failing test
> > here[3]. There was some problem it getting both the flags propagated
> > through ...
>
> Are you talking about the new "else" clause added to the "if"
> statement we see above?  I am not saying it is a "noise".
>
> But look at what you did to the existing call to strvec_push() to
> add "-uno" shown above in the patch, i.e. the addition of space
> before the parenthesis.  We cannot justify that change, can we?
> That's noise as far as I can see.

Oh okay. Now I understand. Ya, that doesn't make sense. I thought that
Eric above suggested adding it but looking at it again, Eric was
saying to drop the space in the else statement below and I
misunderstood that to this. I am really very sorry about this. Would
change it in the next patch.

Thanks again.
