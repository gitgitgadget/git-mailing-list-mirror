Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671D6C001EC
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 17:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49658613D0
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 17:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235647AbhDARnE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 13:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbhDARhJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 13:37:09 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4C9C02FEB9
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 09:31:38 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id n140so2327909oig.9
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 09:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kvPK8FC3wQhs2bEKykxAVj3ZzEPAYL83llRu5Uy9Y6A=;
        b=cZLotvRr6O+QvnAkWnDhVfYxZhMPUgqZ4FTBwfiTLVC/Lb7drjSG/EZg7JmzuFmnht
         Y08XGL09JPr2SaPw3UC8e0tu3PXQ4z+DnwOE6sf6iGdEi77kzscDB6RlFZMllbY64ie3
         ueCNR8Qpac4FMD0N347PgUrdJK1ZffWcJo9sd/g6bfPxkrln6oJqwY7glb21f5ResSTa
         w3Vrcy+JS8Yt7oeL4NMfofX6lb9KKgPTu70+xjoURmAwNfMEqCNS378++1+2vHePoJ4L
         aadcy3sjWR081r5SaYocer3fvAdbl6486+3xIbaH28e1pZyMueDo01BUcBlNPhGBWKFn
         sJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kvPK8FC3wQhs2bEKykxAVj3ZzEPAYL83llRu5Uy9Y6A=;
        b=WL1XIwNimy+7LcbKHafDYDvIBH9HEIUSIFX0Vqak0gShSjsdfhPFmejts3rahVB4nV
         9dqpqQUer/IOE+qnec0Al933TtUFYtEFaa6KH0Ioq2OlSUrdgAj15b9Xfakg10pmAc89
         kaszUJiVqKdl+RN8U4Xitdv9nyeT75oQ2qYUcxkpaUlYe4dIvTdTnuz7fAMcDT//MnEw
         bpIPHSxWzNfQIby7xKXHqWdcE/KUt4HF6vSkGsOeipTrvA8JX7meQ2jYZcqMtV+YWWp0
         30zSiQ4f2/m7A+r/Ns4qxzCkMcrd/+5NXHin29jJggZb1dRfpOWVNYnEF3NcmldEd5gp
         tFjg==
X-Gm-Message-State: AOAM531G/+1jZi1KilTHwZhp3TrdeKux2fhamMpiEHZ+BK/hXl1MQL39
        BSSWT972pN4NkdZgindqYY3vGYS6saSkAl84lz4=
X-Google-Smtp-Source: ABdhPJyF2zIrn+IMIUazlpCtURdDtQUvHcfi5IdaDwwkWges4BRYmsl5IlMoDDEgkEFXOBzFELvTPLb9kIablPUIVes=
X-Received: by 2002:a05:6808:14cf:: with SMTP id f15mr6565316oiw.39.1617294698331;
 Thu, 01 Apr 2021 09:31:38 -0700 (PDT)
MIME-Version: 1.0
References: <pull.988.git.git.1616742969145.gitgitgadget@gmail.com>
 <pull.988.v2.git.git.1617070174458.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2103301200020.52@tvgsbejvaqbjf.bet> <xmqq7dloeawf.fsf@gitster.g>
 <CABPp-BErXWkEOCyZtYP9AHd9eP2osL4s1xjMZ_BRkGSktdFnKg@mail.gmail.com> <xmqqmtuj8ank.fsf@gitster.g>
In-Reply-To: <xmqqmtuj8ank.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 1 Apr 2021 09:31:26 -0700
Message-ID: <CABPp-BFLyYTboiGkP=sc7S+stRZvozAqnJPnza+M0q2nakvD2Q@mail.gmail.com>
Subject: Re: [PATCH v2] sequencer: fix edit handling for cherry-pick and
 revert messages
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 31, 2021 at 11:01 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > ... would you two prefer
> > that I add a new affirm() function that is ALSO compiled out in
> > production?
>
> The reason I do not think affirm would fly is because it shares the
> most problematic trait with assert(): it can be comipled out.
>
> There was at least one bug we found and fixed in a piece of code
> that came later in a codepath that had an assert() in it.  The buggy
> code (IIRC, it was added way after the assert() was written in an
> unrelated patch) was unknowingly depending on a side-effect of an
> innocuous function call (i.e. assert(func_tion(args) == expected))
> made in the assert condition, and the bug did not reproduce in the
> developer's environment.

Ah, now that's a much different argument than claiming assert is
useless.  I had to debug one of those once about a decade ago, in a
different project, put in by some other developer, and yeah it's
painful.

If that causes assert() to be frowned upon, then I can understand
based on this reason.  If so, perhaps a BUG_ON() function would be
useful?  The "if (...) BUG()" construct causes line coverage problems
and I find it an onerous way to signal to future code readers "hey,
just as a reminder, these things should be true at this point".  If
you need to signal something more than that or explain why the things
being false is a problem or what might cause it, then the "if (...)
BUG()" construct is useful and there are certainly many places for
that, but it just doesn't fit all the cases.
