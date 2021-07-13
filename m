Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B74C07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 08:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 221B3613AB
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 08:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234912AbhGMIuW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 04:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234858AbhGMIuR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 04:50:17 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6B7C0613EE
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 01:47:27 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id t9so21015688pgn.4
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 01:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H0GP6KZ5OJkHAm4mTxbBUBp8/0WF7zbM1nEJYtdFoXA=;
        b=KCl/HVWWd/P+qbqF6Cyb3vuy0/hZYOkmv5NeXNiuic42WQu+3oOr+c1QGL86rWGO6I
         hYoJ5k96IEOXZlTsm8tD6dzQtp5Fx6229b0wTmNHB8A+Qi6q8VSt4Pji7g04HmIo+Odz
         WPAu5XAxWHmX6TgMT7AjQSMypVmu6VjuwJKOvMnCr1WhXk1o11ZukojXlCKEn9YHDUgC
         afDKezAsOBrNnmRA/gn1r57q0rY/bAvWglajzlYSMYot90/U4ndIlJofgZlzXlX9NZEn
         QABWt2jafjhrD75c1vo4brXEeDEh7mFJQIv25KR4WspjXr2oPr+3PRtO3K3hEJBUAMEi
         01WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H0GP6KZ5OJkHAm4mTxbBUBp8/0WF7zbM1nEJYtdFoXA=;
        b=ZJjFu+qx8mpuK+4advvl1xVyInC8q56CSy7jH94YIxxNngvVUvydjS26EeOmdBgvxc
         TYtbBZ0BjlHk9tQHDOyNxnI5KjV5Ot1GBHtFGlHaYUSVu37aO6sK1EG5o/rh7Cwo/miy
         iIAF/cUubl7PjDaMd/1ibbKU+QnPpEUQPTBtlBhEZhAugZl7eROMP4/nTLvr7d3ZaGbs
         bSzUCNHHHKNpMrVxLOyJ24MBuCPO1DuPyPgNCdzhEvjyMG1RP8Mnx3MUbPfbGj9Ppa19
         cDSzAkLqYIEybgCxHACpZvoUSXEJclspmSqAjkFbqtYiKYnOF2PyzSJ5cd7Ox0f+6g4P
         Aciw==
X-Gm-Message-State: AOAM531inLDos2ylTgN4jLJzsdk9Nmnzh49nREsRhRPDgxzeN5bHjNYr
        XE98M2ikLIFV5sD3rLGi4fbPy620Dh5eUBmjWPg=
X-Google-Smtp-Source: ABdhPJzdNDTK76u4VHldHNmzGZ4L1ewTQM9VXk83cPs6BuVJSwfrQVlDkjFWz8txnfyk0Ix3H5bl5yZ66gAIzs2D2is=
X-Received: by 2002:a63:ba1e:: with SMTP id k30mr3358996pgf.39.1626166047260;
 Tue, 13 Jul 2021 01:47:27 -0700 (PDT)
MIME-Version: 1.0
References: <YOzY+qNFM2GsgKMO@coredump.intra.peff.net> <20210713074018.232372-1-martin.agren@gmail.com>
 <YO1GNWjMol8JV8MR@coredump.intra.peff.net>
In-Reply-To: <YO1GNWjMol8JV8MR@coredump.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 13 Jul 2021 10:47:16 +0200
Message-ID: <CAN0heSpFDC2c=S6RZo=mrM3n09WL1jFsv-Px=8DpYP=ZYKHjDA@mail.gmail.com>
Subject: Re: [PATCH v2] load_ref_decorations(): fix decoration with tags
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 13 Jul 2021 at 09:52, Jeff King <peff@peff.net> wrote:
>
> [+cc Junio; this patch looks good to me, and should go on top of
>             jk/log-decorate-optim, which is in 'next' and has a pretty
>             ugly regression]

Thanks for calling out the branch name when I failed to. That's indeed
where my copy of the patch sits and where I've tested this.

> >  Maybe you wrote this before circling back and actually writing that
> >  "even better" thing? Because it seems to me like that's what you did.
> >  Maybe I'm still missing something.
>
> Nope, I'm just dumb. I wrote what I sent in the other email (rather than
> just adding the "if" as above) because it only involved having a single
> parse_object() call in the function. To my credit, I did realize about
> an hour after sending the other email that I had in fact done the
> "better thing" quite accidentally. But I really like how you explained
> it in the commit message here, which I had not quite thought through.

That's the best kind of hindsight: the sudden realization that you
actually got it right.

> Patch looks good. Thanks for noticing the problem and cleaning up my
> mess.

Thanks a lot for your comments and all the help. I'm glad you liked my
explanation in the posted patch.

Martin
