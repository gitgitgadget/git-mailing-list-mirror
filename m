Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE36C4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 16:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDBD1208C3
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 16:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730520AbgLRQhy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 11:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgLRQhx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 11:37:53 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A83C0617A7
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 08:37:13 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id j20so2447232otq.5
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 08:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pWug9FhnvC4aJtd9KpPrXQeJRkFbGo4GN/WiIAuPd48=;
        b=g78Y7sQYVY1gX4Ar25MW1S0o9mnP0EQzWifbPE1mhVrYsfkgDR0HqKmvqnM2IhYzlE
         rlmbOZJKotirP5b8z5LKIkBdI3wEDP9bpvUJR8D6lfH4PDMxAyVQ1x3OtHHPReIiB/ZE
         UZLEunILM3xLzA501U8k6sNPOaYglTnRtfWmR0DWUWXI9yakN7I8FLs4NVn5c3EtQy+Q
         3IR95MphuwTeydn2eFeaf5gSH+Pf0/5dgxlyjYSr6Rgnd+kTn618A8HCpq42Cs+khv/K
         o0Zp1H9J7wByL8YyzkbOko1p8+Qh56JLI3rX600WJl0i4NC3SZqhn0Oy5U6olFkjFz8C
         JrpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pWug9FhnvC4aJtd9KpPrXQeJRkFbGo4GN/WiIAuPd48=;
        b=ICuYk2LnanzgqyP1wdMTJBZab01H32my6OXk7AuXtaCIVWcG8ySTUHnoL2UdtXBh+2
         NBUgjTjHRPKqOkuCnSUog7umx/DkXf/CwDsi5SrtqwIH5YtSarW8VrW32Xyp2yS3zDop
         +UZZQKLonomaMWRVBC12ZGYJqnCbt191GZuuq87YDGgDvf8WVDFN9xFKFLee5lrUQ5U3
         6xiWG3dB8E+ZK4dU8RhhC2yyo3ahlFkgcirBRjxSoBPAdlXVsQwvZQIbXTXdxqtBwGDw
         tZuRJX75Dwz1EiifNa0DkC55/PJ+8wGcrtSnfXov/YTVh7xz1dr7ZacOd5kde125SyFC
         L/6A==
X-Gm-Message-State: AOAM531x/BOizG3L4XsRq067EQJp7zpJvKn80LPM+jvWZiH3CjZXP5VO
        uVGGY6a14Y1ad+2E8n1QacIuW6qNb5uvBxGDZ2M=
X-Google-Smtp-Source: ABdhPJyvevvXWCCey1zEGqRKlsGglwMzyqtl1JDTgwmjBV5P/PaAlgcH+C/nSgeelOo6MfF3kRdWwFH4durChxfcarU=
X-Received: by 2002:a05:6830:1610:: with SMTP id g16mr3407601otr.345.1608309432446;
 Fri, 18 Dec 2020 08:37:12 -0800 (PST)
MIME-Version: 1.0
References: <20201101193330.24775-1-sorganov@gmail.com> <20201216184929.3924-1-sorganov@gmail.com>
 <20201216184929.3924-25-sorganov@gmail.com> <CABPp-BHh4VSTQ=VOzik5H34OcJaQ63wSgPgrZqJ5-_XvBSow+g@mail.gmail.com>
 <875z4zciwd.fsf@osv.gnss.ru>
In-Reply-To: <875z4zciwd.fsf@osv.gnss.ru>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 18 Dec 2020 08:37:01 -0800
Message-ID: <CABPp-BGg9oBkG3ZaWztKMnQE4sREOK_L3so5fer5hbiAKxMaHg@mail.gmail.com>
Subject: Re: [PATCH v2 24/33] diff-merges: handle imply -p on -c/--cc logic
 for log.c
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 18, 2020 at 6:01 AM Sergey Organov <sorganov@gmail.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Wed, Dec 16, 2020 at 10:50 AM Sergey Organov <sorganov@gmail.com> wrote:
> >>
> >> Move logic that handles implying -p on -c/--cc from
> >> log_setup_revisions_tweak() to diff_merges_setup_revs(), where it
> >> belongs.
> >
> > A very minor point, but I'd probably drop the "where it belongs";
> > while I think the new place makes sense for it, it reads to me like
> > you're either relying on a consensus to move it or implying there was
> > a mistake to not put it here previously, neither of which makes sense.
>
> Well, it was meant to be an excuse for not moving it there earlier in
> the patch series indeed. I just overlooked this piece of code that
> logically belongs to the diff-merges module. I think you need to
> consider the state of the sources right before this patch to see the
> point of phrasing it like this.
>
> That said, I'm fine removing this either.

If it should have been moved there earlier, then you should amend the
relevant previous commit instead of making a new one.  rebase -i is
your friend and should be used, especially with long patch series.
:-)

> > Much more importantly, this patch doesn't do what you said in
> > discussions on the previous round.  It'd be helpful if the commit
> > message called out that you are just moving the logic for now and that
> > a subsequent patch will tweak the logic to only trigger this for
> > -c/--cc and not for --diff-merges=.* flags.
>
> I believe this patch is useful by itself, even without any future
> improvements (that we actually discussed), if any, so I don't see the
> point in describing what this patch doesn't do.
>
> OTOH, the commit message seems to be clear enough to expect this patch
> to be pure refactoring, without any functional changes, no?

I'm just pointing out that reading the patch triggers a "wait, you
said you wanted to enable diffs for merges without diffs for regular
commits" reaction and makes reviewers start diving into the code to
check if they missed where that happened.  Sometimes they'll even
respond to the commit asking about it...and then read a later patch
and find the answer.  Perhaps I'm more attuned to this, because I've
done this to reviewers a number of times and they have asked me to add
a note in the earlier commit message to make it easier for other
reviewers to follow and read the series.  You don't need to describe
in full detail the subsequent changes that will come, just highlight
that they are coming to give reviewers an aid.  For example, this
could be as simple as:

"""
Move logic that handles implying -p on -c/--cc from
log_setup_revisions_tweak() to diff_merges_setup_revs().  A
subsequent commit will tweak this logic further.
"""

(Note that 'git log --grep=subsequent' in git.git will find you
several examples of where people have done this kind of thing.)
