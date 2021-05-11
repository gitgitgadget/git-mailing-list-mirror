Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FFFC433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 17:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AEED61352
	for <git@archiver.kernel.org>; Tue, 11 May 2021 17:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhEKROl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 13:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbhEKROk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 13:14:40 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE15C061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 10:13:32 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id y9so26064519ljn.6
        for <git@vger.kernel.org>; Tue, 11 May 2021 10:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KbXSmjUCAIjLihgPkq1KdIPa0RWF+GCWpYhR51NxvEw=;
        b=rACeZ16WbpHB8tERd60xcMSsCZd6SMT6fo0tcX0/Z7SAIy8azcfVu9xYa1+UhImiET
         a9VIcJYXa/OvnbACplF9oXARehV9RwBGpXqHtlSK/ntD8zpJ19TwLxZV/gBqYctK0uyA
         7rmWdcgF66PIa1Agscd/psVawO1NS7D3zGFZER2HAc4vJRsU5MyFHQ/zOrk0mJLVZhiU
         G9OIWVrPi7LjI/dH3QZIXqE4NR6t4pZXhuEDKveMf2Azpy/ykfDzcpaE57aTcNu/Gf2r
         QFJjUta5MR7d2HG4rotBBYOLlNm0t5ex8fRN8Dxvyr/AsK4YzDFmrIyYfsFIFI1muKYA
         LvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KbXSmjUCAIjLihgPkq1KdIPa0RWF+GCWpYhR51NxvEw=;
        b=DJsus+sSu+MgG7C7De5pmwJfLQHEH5JCsf+nsVLkQ4+ODo4SVKdzZ83e8UkWwz9zq3
         NVZMI2rbT+zIzTe8LlJxKFRyDNIS++23P2RP5OS+O64D1q16RCHPHMG/3Y6cUS2/rCt0
         Jk74NikEtVc1T4KrRyDNXJldKrGzkaRdlLF9AxxzzvzRKXePDsLDkHR2sBhsQfyelIIv
         1ThOGq+QxHF6/E3shBYsc3hDXLmPKk50cvR4la62V5BYtMuwkud9dR2zijXQYlSRvNPP
         YUW6gP2Q28TgTq29O5gNgwWntKzg5W1zdlNGlrqwZuaiZUn0ftoTFCK+G9tL7oLQnu9V
         eCYA==
X-Gm-Message-State: AOAM533K4GJTr+6jX0sNeS8i62UIe+KiPIL0KPO927qPe+1jH0ChWgHm
        MVJI2RQaK1AKpWRvz2kLfM5pHSdmmFneHFjL3WU=
X-Google-Smtp-Source: ABdhPJx/ajRZvlzDfcR95wZzk7M0rDKi3nmjl0AUEpsWSaskz74cv5bu7decIWZL8AndXpzEFfWmX92Wfgy/LFvBrIY=
X-Received: by 2002:a05:651c:c8:: with SMTP id 8mr23286210ljr.274.1620753210830;
 Tue, 11 May 2021 10:13:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <20210510153451.15090-1-sorganov@gmail.com> <20210510153451.15090-7-sorganov@gmail.com>
 <xmqqsg2toqik.fsf@gitster.g> <xmqqo8dhool7.fsf@gitster.g> <87v97pv04p.fsf@osv.gnss.ru>
In-Reply-To: <87v97pv04p.fsf@osv.gnss.ru>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Tue, 11 May 2021 11:13:19 -0600
Message-ID: <CAMMLpeTL9ZOuHLhqonFOwMu8yC9bETMVzkCZ__F2JsR=0umL3A@mail.gmail.com>
Subject: Re: [PATCH 6/6] diff-merges: let -m imply -p
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 11, 2021 at 8:03 AM Sergey Organov <sorganov@gmail.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Junio C Hamano <gitster@pobox.com> writes:
>
> [...]
>
> > If we enable "some kind of diff" for "-m", I actually think that by
> > default "git log -m" should be turned into "log --cc".  As you told
> > Alex in your response, "log -m -p" is a quite unpleasant format to
> > read---it is there only because it was the only thing we had before
> > we invented "-c/--cc".
>
> Please, no! --cc has unfortunate feature of outputting exactly nothing
> for a lot of merge commits, causing even more confusion than historical
> "-m -p" format.
>
> The best default for -m output is --diff-merges=first-parent. Everybody
> is familiar with it, and it's useful.
>
> > But that might be outside the scope of this series.  I dunno, but if
> > there is no other constraints (like backward compatibility issues),
> > I have a moderately strong preference to use "--cc" over "-m -p"
> > from the get go for unconfigured people, rather than forcing
> > everybody to configure
>
> I rather have strong preference for --diff-merges=first-parent. --cc is
> only suitable for Git experts, and they know how to get what they want
> anyway. Yep, by using --cc. Why spare yet another short option for that?
>
> Overall, let's rather make -m give diff to the first parent by default.
> Simple. Useful. Not confusing.

Honestly --diff-merges=separate is fine. Two weeks ago, when I started
this discussion, I was trying to use `git log -m` and `git show -m` to
find which merge commit introduced a particular change. Extremely
verbose diff output would have been great for that, the confusing part
was just that `git show -m` produced diff output and `git log -m` did
not.

Maybe what we really want is a new short option like `git log -m1`
which would both enable diff output and set --diff-merges=1.

But again, I don't have a strong opinion on which particular diff
output is "the best", so I'm happy to leave that decision to the
experts.

-Alex
