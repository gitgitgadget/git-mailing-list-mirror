Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8DAC433F5
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 16:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CA816128C
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 16:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344370AbhI2Qdn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 12:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244930AbhI2Qdm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 12:33:42 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855CCC06161C
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 09:32:01 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id g7so10815580edv.1
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 09:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tPjKUP2MX3QIm8Rgbb+3fROhVdNAvj0kGOtIuxfMIC4=;
        b=Btd+yJhbrP9Cts5epJjBGQnhSQq3sbzMNDYi8GsK1aKitlc8nXJyaK6hIGvp0RNxs8
         L6WscNol5P/RDQ8vOgKfTgP/x+vs2I36mr9CofWSXOTLDbX+Uglha+0UjwSEIi48Gic1
         ktwJnOWZ4Zw55qZLsCSnuXcLh6FII3B+HWWk9Xy4NKxJ+al57hYI8FQehpkhR8DjcdFL
         8YWizxtbSXGNYt0Ua18LyHRFAoI1o7M32CIXpR8t+V5QJp+553Bju+yEegcCueOacYjd
         D0UD8o32ocKP3m9BOTv/6uo/xbzg/J3KXIoQTEHFjUmJtpKSeteJvazVUzedpc8M1uvu
         aagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tPjKUP2MX3QIm8Rgbb+3fROhVdNAvj0kGOtIuxfMIC4=;
        b=Xold/5hqOspMF6paeUrA1JQ4GR7pB3A0Num5NAovNeEKq4Vj2aZfDJSgcrP0hhcQzS
         AjoafxuEYow1UiDs4SlV9MNB3mNt41DLfeRVD/2teZ6dL281Z2PnpjY///ARJ/u3NeVN
         edTdLk3gukkcNzNKUq7gCULGqfOIPDCa0brltvMeu7TPfYqACRS3S5fRURVcmhMjSiNj
         cqIDXzKF7HZjV0sA/ODlCZaywukVwzrIzOCS2cRrO+cD/jmNxQ4tnAFd0E0K3mdwFWwu
         O+M6em0qon/G03IouZVqQIzZQZVtmT6a9beh1Y7GcoHbpveCgwncEtvqcNXffnvAKmzH
         53Og==
X-Gm-Message-State: AOAM533kzSWtRze3MHAoPct28xXhRLw6GRKiESkfLvsx1RiyIbRdz7jg
        G3nmGzHTAbPBtfgtE3vwJTuuRt+FV/ZVOZTiJAWgDdAqymw=
X-Google-Smtp-Source: ABdhPJx2TWkAtafNvrdvPNRxdh2sJ3BJ4nNC8JTnCMIAiNGYsARTY++mY+PCKVWfmJanPUHIEqbA8dKE+Vwleb95YjU=
X-Received: by 2002:a50:be82:: with SMTP id b2mr975074edk.56.1632933119840;
 Wed, 29 Sep 2021 09:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
 <ed71913886e19ccc276b382de707b4bab7834d12.1630376800.git.gitgitgadget@gmail.com>
 <YVOXPTjsp9lrxmS6@coredump.intra.peff.net> <CABPp-BEioOUJRd6FSsmsDtYHhUy7xhr4YabdEmVKzkduo4g9TQ@mail.gmail.com>
 <xmqqr1d7e4ug.fsf@gitster.g>
In-Reply-To: <xmqqr1d7e4ug.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 29 Sep 2021 09:31:46 -0700
Message-ID: <CABPp-BEidvD6Hi0rj4tnG5xioi1RXQK95NjGJkPYqjqmaU12nA@mail.gmail.com>
Subject: Re: [PATCH 2/7] merge-ort: add ability to record conflict messages in
 a file
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 29, 2021 at 9:14 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > I also don't like how diff.orderFile provides a global ordering of the
> > files listed, rather than providing some scheme for relative
> > orderings.  That'd either force me to precompute the diff to determine
> > all the files that were different so I can list _all_ of them,...
>
> Don't we determine all the files that would be listed in the diff
> anyway?  The diffcore pipeline collects all the different filepairs,
> matches them up for rename/copy detection, and finally do the output
> formatting for each individual filepair.

merge-ort is missing one side of the diff.  It only has the parents of
the merge commit, and their merge base.  So, merge-ort would now need
to know about an additional commit (the original merge), and compute
the diff between that and the merge-result it is creating, in advance
of an external caller (log) calling diff to compute the result between
those two trees.

> > So, I'm not so sure about this solution; it feels like it introduces
> > bigger holes than the ugly space character it is fixing.
> >
> >>  - there can be other non-diff data between the individual segments. For
> >>    example, "patch" will skip over non-diff lines. And certainly in Git
> >>    we have our own custom headers. I'm wondering if we could attach
> >>    these annotations to the diff-pair somehow, and then show something
> >>    like:
> >>
> >>      diff --git a/foo.c b/foo.c
> >>      index 1234abcd..5678cdef 100644
> >>      conflict modify/delete foo.c
> >
> > A couple things here...
> >
> > First, I'm not so sure I like the abbreviation here.  Just knowing
> > "modify/delete" might be enough in some cases, but I'd rather have the
> > full messages that would have been printed to the console...
> >
> > Second, what about when there are multiple ...
> >
> > Third, what about the cases where there is no diff, ...
>
> None of the above seems like a problem to me at least from the
> presentation and consumption sides.  There is no rule that extended
> diff headers has to fit on a 72-char line, cannot use line folding
> by inserting LF-SP in the middle of a logical line, and there
> already is at least one case we give an extended diff header without
> a single line of content change (namely, "chmod +x README").

Cool, that's good to hear.  I'll look into it.
