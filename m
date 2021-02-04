Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C3EC4332E
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 00:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE2EA64DF5
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 00:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbhBDAGd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 19:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbhBDAGY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 19:06:24 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67665C061573
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 16:05:44 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id d20so1853377oiw.10
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 16:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vD9gmRmkdhfypqT1XEvDBsXG9aXVFsyBMA32mjeyVWY=;
        b=DReldKtwkpCfeKwrr5Zc0KDdia5K/mBkRtm6+XkCBg6a5HmNBagcwiinGErkDt7ykJ
         S7o1wZdPc9u7vWjsa8nBIaBoOyAA9X9C+cy6sClnXD1z9o9YgbfYWR3cQGiQJBWIHKkW
         PzV2SMyWqKDy0dtCDvJrMQVH6BahrXzsra5QsHfHIUA5Kihwq24PScqw5EFC3kI/ixES
         6JV1wcHpSivOQpU26JvNAU+kanrFfyCOP+f/k+WrWNI3nlp0k6dlyrecz75FiNZoPVv/
         byFKHuNLFCUxFmjSvtH1/uC8dzqL16r1xdyunA/PmJVyh+ra+7SEpmEZ0q12FZtmEx27
         rBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vD9gmRmkdhfypqT1XEvDBsXG9aXVFsyBMA32mjeyVWY=;
        b=c+Iv5O2VNTiKmHnIhvJ+c2Nc8jvqp9uNSucZpuanacW9t5ljVzLkNdkZdzPiuwQviT
         /VuiaVkIitbTm7VbnZE0uisz07evznuz5FRnmOik2KG/2c1APNxGZ5v5+bQXvdH4KThO
         aUUow/ctE1K5+vX+x/bQuYvAKjMZuX51ua4Jwim08hK3bAm0oHc5ooPrjm+wDTIwFJrF
         3NfmmQfzdpgnZWSlacUlfv3nW0+e0py+YGaO1Zyg6Bqf3kyvX8lBwUuG521SZa7uIsf6
         zONGrV8g6Trw+bqjTOFnrQ/4HgpifM7aaLfQSMZcuGJigAivQW+eXgiF4R2hEgwHOvwQ
         lX5Q==
X-Gm-Message-State: AOAM5337sHVmuj4Cf6Wg5lhyjYYehJVssX+cmRrp5Ghfh0x2qaSTm9Tv
        EByvcEbrcwMqTltgmakES09dF2byZQDNasBjEIg=
X-Google-Smtp-Source: ABdhPJwGV/O24IxJxW8V2YxZODHM4TGvJODi8xfgcDEr3U6P4ja2i8KtfPZQGMONhD2a/ufJtXKQNDc2hZtwaTBT210=
X-Received: by 2002:a54:4790:: with SMTP id o16mr3571086oic.39.1612397143789;
 Wed, 03 Feb 2021 16:05:43 -0800 (PST)
MIME-Version: 1.0
References: <pull.842.git.1612331345.gitgitgadget@gmail.com>
 <pull.842.v2.git.1612382628.gitgitgadget@gmail.com> <xmqqlfc4byt6.fsf@gitster.c.googlers.com>
 <CABPp-BEgwfv70NRGgyAnHnQBPx4APSyYxNCbvH9F=7WGSj4DLQ@mail.gmail.com> <YBszm/s9na3ixUsO@coredump.intra.peff.net>
In-Reply-To: <YBszm/s9na3ixUsO@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 3 Feb 2021 16:05:32 -0800
Message-ID: <CABPp-BHMDi2i=9etq-L=0H=OO7Mbo=RFwMWTNebNB3H9Vbm3+A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Optimization batch 6: make full use of exact renames
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Karsten Blees <blees@dcon.de>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 3, 2021 at 3:37 PM Jeff King <peff@peff.net> wrote:
>
> On Wed, Feb 03, 2021 at 03:06:26PM -0800, Elijah Newren wrote:
>
> > >    In an early attempt, I tried to retire rename_src[j], once
> > >    rename_dst[i] has been found to be a "good enough" match for it,
> > >    from the pool of rename src candidates to find a good match for
> > >    rename_dst[k] for i < k, but naive implementation of it would not
> > >    work well for obvious reasons---rename_src[j] may match a lot
> > >    better with rename_dst[k] than rename_dst[i] but we do not know
> > >    that until we try to estimate similarity with rename_dst[k].
> >
> > You may really like the next two series I submit.  I have a smarter
> > way to find a "good enough" match (comparing to exactly one other file
> > and often finding sufficient similarity), and one that'll make
> > intuitive sense to users.
>
> Here's a really old thread with an approach that may or may not be
> similar to what you're thinking of:
>
>   https://lore.kernel.org/git/596909b30710220240g665054d8hc40bc5d2234ba9e1@mail.gmail.com/
>
> Though maybe start with this summary message:
>
>   https://lore.kernel.org/git/596909b30710220309l1a28e646r9fd47f967dc32574@mail.gmail.com/

Interesting thread; thanks for the link.  It's not remotely similar to
what I have done, but a brief glance through it reminds me of the
ideas at https://github.com/gitgitgadget/git/issues/519.

> I remember experimenting some with it at the time, but never making
> things faster. It's entirely possible (likely, even) that I was simply
> not doing it well enough.
>
> It's also been long enough since I looked at the rename code that I'm
> not sure how different it is in practice. It still has a quadratic
> matrix in the end. We basically do a similar strategy of
> rolling-hash-fingerprint-and-see-where-things-collide, but I think we
> may end up with more work during the quadratic part (again, it's been
> a while, so I may just be totally off-base).

I'm not sure if I should spoil the surprise for the patchsets I
haven't yet submitted but... when I get done, for the testcases I have
looked at, rename detection is no longer the slowest part of
merging/rebasing/cherry-picking -- not even when there are tens of
thousands of renames on one side of history.  And I didn't achieve
that by making other parts of the code slower.

If someone can come up with a real-world testcase where rename
detection is still really slow in a merge/rebase/cherry-pick with my
implemented optimizations, I've got at least one more optimization
that I hadn't bothered implementing because everything was fast enough
for me already.  And the idea you linked above and the ideas in the
gitgitgadget issue linked above all have more possibilities that are
complementary to what I have done that might help further.

> I've also wondered if something similar might be helpful for delta
> compression (which is now done with an O(m*n) sliding window).
