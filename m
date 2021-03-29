Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E141C433DB
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 22:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 640EF61585
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 22:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbhC2WfV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 18:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbhC2We1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 18:34:27 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1CCC061765
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 15:34:25 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id g8-20020a9d6c480000b02901b65ca2432cso13800039otq.3
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 15:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nXrtSynJec8DMQig7TF/AQSvuOSQCzpfGPRfRFCn6hM=;
        b=LlCVXkK9H3OSISva4EbQt7JtG8uffaymfSTG0eD2ZMyWu6JXaw5NF3i5RqBfq7R+mx
         cIokA5H8a8KgFDEk4gvaTT6/hItqJUcgFfE6yqEicv9+fP7DlgMoNKHrJCxOfZU4wU+Q
         L+9n++SwUhy3UQy/fMAZ+n4xTNtPz7Ev6o7jZLusS7jSGaTznr6Z8fex0rGqnHnAE2Em
         tLEN+eJQjUEJrbP9PakLD8raderUnRiWTx3tGw4VpSP6HU7U30Dq8k0duryk7vvmRBry
         ubKqTcbgtUMOYYXx9hotPuAiTnpFupVU465Y1ClfLkAfgXE9TAGejU6d7U4V8O8IA9gg
         JVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nXrtSynJec8DMQig7TF/AQSvuOSQCzpfGPRfRFCn6hM=;
        b=BbAFTJbvIJAex86r/eY0gKTtPPMSioJKWpsnUTQJz7Eyfr09S04fZ7+iVaBAUS0I2T
         mN6jaDUAgLTd7awvtLqeTarOmuaEPQ1poUbQxrx9e5bErnKxDOd+6QT2zt41ArhAvFOU
         qaimFh+TMab+jjZWJ5C8q03Vcf9I57khHd3vl9NHL4ALLOrylg18mL6F5lCdf0WtobeG
         PAZMHR+R0+rv3kqOSi6GWnj0UXuEijFcsbVg7JLPzqmdskmLwbfbbf2kRkMeQvS1NWbn
         UF5xWDG8nrGfTB0+fJg2VuNPAbOyzjMsTC0a8Jvx5ELRFQDyojZWV53lLKOq7H9aB6W0
         ZRdQ==
X-Gm-Message-State: AOAM532AbhtuqrOyv2YkYYApE1FyNwy0YqcCdVu5I3E+cN/Tr8IA3bRk
        +Los66Yv7j32u8+LxrsntywhJJEF2iljV9qlBxNJHUDqk/QrUQ==
X-Google-Smtp-Source: ABdhPJxGhVnPbd4yjjk6GFEwpNa8Q8oO+FJY5YwMKnuiAJCLtM3i4LMogdS/vuv6/FXDPPoTQ9fR4XjpNbh7Inde0WY=
X-Received: by 2002:a9d:8d5:: with SMTP id 79mr24929375otf.345.1617057264711;
 Mon, 29 Mar 2021 15:34:24 -0700 (PDT)
MIME-Version: 1.0
References: <pull.859.git.1616621553.gitgitgadget@gmail.com>
 <xmqqv99gw6n3.fsf@gitster.g> <CABPp-BGMhyn1ricXzx539n-09+BYRHPeruNd4MG2PyQzWaRKow@mail.gmail.com>
 <xmqqzgyrukic.fsf@gitster.g>
In-Reply-To: <xmqqzgyrukic.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 29 Mar 2021 15:34:13 -0700
Message-ID: <CABPp-BGrevGj+xrm9bVcX5bp_WRv9cYP+g0hrAtjZK0u=sTHzQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] Optimization batch 11: avoid repeatedly detecting
 same renames
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 25, 2021 at 12:00 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >> And each step in this "rebase" is a 3-way merge of commits A, B and
> >> C onto HEAD, using the parent of the commit being cherrk-picked as a
> >> virtual common ancestor.  Which means
> >
> > You generated nearly the same description and diagram I used in the
> > commit message (the one in 3/7) describing this.  :-)
> >
> >>  - To transplant A (i.e. the first step), we'd compare the diff of
> >>    A^..O (i.e. what our side did, including the renames done at X)
> >>    and diff of A^..A (i.e. what the first commit did in the range),
> >>    and the former does quite a lot of rename detection.
> >>
> >>  - After transplanting B (i.e. the second step), then we'd compare
> >>    the diff of A^..A' (where A' is A cherry-picked on O, i.e. the
> >
> > Close, but for transplanting B we do the diff of B^..A', not A^...A'.
> > (And in this diagram, B^ is A.)  That's critical below...
>
> Yes, I upfront said "pretend that the parent of the commit being
> picked is the common ancestor and run 3-way merge", but then got
> confused by the ancestry graph myself, forgetting that the reason
> why A^ is used in the first "pick" is *not* because the it is the
> fork point of our history and the side branch, but it is because it
> is A's parent.
>
> And if the renames in B^..A' and A^..A' are different that must have
> come only from the difference between A..B (which is B^..B), but
> that comparison is what we do when cherry-picking B on top of A',
> so it is easy to take into account to reuse the renames precisely
> without "assuming they are the same".
>
> Thanks.

After sending the initial series, I decided to type up a more thorough
document that
  * spelled out in more detail how the sequence of cherry-picks work
  * proved why the renames in one pick are always a superset of the
renames in the next
  * proved why the renames in one pick are _almost_ always also a
rename in the next
  * discussed the counterexample cases in more detail, and why the
optimization is still reasonable
I figured the more extended document would be useful in case people
decide to change how things work in the future (e.g. what if someone
wants to turn on break detection?), and wants to be able to check
whether all the conditions and cases still hold.

I then also added details about how things work with directory
renames, in the case that merge.directoryRenames is not the default of
"conflict" (which is trivially handled by stopping and dropping the
cache) but is set to true...and found a case that needed more care due
to interactions with some of the earlier optimizations.  (The earlier
optimizations could result in bypassing directory rename detection in
one merge because there was no file added to the old directory, but
the no-directory-rename would be cached for subsequent rebases.)

So I need to get that fixed up and resubmit this series.
