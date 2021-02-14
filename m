Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AA0C433DB
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 01:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0591F64E3F
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 01:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhBNBZo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Feb 2021 20:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhBNBZm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Feb 2021 20:25:42 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587FAC061574
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 17:25:02 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id l19so4091984oih.6
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 17:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a0KrSwFLzBuxJ51kIYkzoFz8x7Gj64GwsAv9kx3gLVo=;
        b=cw1XVZJJreMLzBR6TLSxabTWO3DzUIltx5HffXSsJNFFSDIOWGxlB91/FSogYv0DeW
         vThDtInOjnDZ8Ju8BmW/wMeuHRabTfVSl8trBinX/pJlumSBNgcZXTBRBh7qDDBruQSX
         4iP7Ie+Uk/rWE8uEpcPxUfayg+DA42aKueYAcYT9qYttk215bkDRSyBFUcqz7rqPKrwF
         /xKQWhDHDAHaeIeP1HQVfZygMHlzhOGSYcvt8L9Evehwy3UikkEtOkvXAACOgMsHqC/m
         jRGMpcoVLVBG4nlZ31XGyiMs2BGldAnIfA13wlA4NftJ6Fu6j/nTqwOIR7GGWPooquzZ
         nOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a0KrSwFLzBuxJ51kIYkzoFz8x7Gj64GwsAv9kx3gLVo=;
        b=uS1u/RyXfvZ9OIN/mqD85sHy2gb9g9bN0Xs3nIupDUr1PV9Z0aYAkIUwkx/bxATI37
         wPNF56nHATVDZOT6SaypKhZ2CL1xqeLPxFwVU950vLTcLKd48BnmV+gKUYohgMKRQqJu
         XVBEt+1uR+9t5v4Wp8xFsY8auldwSLQMKxKYqfMcI8tI0dg5GZDwoMfP1+ZyXGvcKIVk
         itaFRMBin095ppXQsfPDDy2RzwWoMmbnUR9OjrOYXwLPzrq7HO0gzAN/VZnCVV0yX0qY
         bqGKLLgapC8g3BO6uCY6Au/YxwM07GDaeRAqQEshvIZvKJibk5J0ip1gR171Eq4n3dQX
         toow==
X-Gm-Message-State: AOAM532cdqIN60kMzhNL0TvVf0+DRQa9d67nRRnbR7Swkza6K7mctH2J
        QS3LT9435K3m0XZdxDGZ+KoY1FJTXhHAgAFWOx84vHrJb2bBeQ==
X-Google-Smtp-Source: ABdhPJydLmUweR8+SYTlGQyXmmQ9ewoaXmgeOIzXp4FGz/u/FYVJrYBC6N33UGm2OvbiLhQyg8wXCFjvWApex8rW8BY=
X-Received: by 2002:a05:6808:42:: with SMTP id v2mr4233902oic.39.1613265901644;
 Sat, 13 Feb 2021 17:25:01 -0800 (PST)
MIME-Version: 1.0
References: <pull.843.v2.git.1612870326.gitgitgadget@gmail.com>
 <pull.843.v3.git.1612970140.gitgitgadget@gmail.com> <3e6af929d135ef2dc239e2f47f92a7e2e91cbd17.1612970140.git.gitgitgadget@gmail.com>
 <xmqq4kigvkct.fsf@gitster.c.googlers.com> <CABPp-BHyYOAw939vU20oA_tOSFRVm=EaLKuw+4M1oP1GDDV5cg@mail.gmail.com>
 <xmqqblcnttcr.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqblcnttcr.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 13 Feb 2021 17:24:50 -0800
Message-ID: <CABPp-BErByO=6jE+tZQHSsGJacr92AqVL7dnctE9MjQzmeQfcg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] t4001: add a test comparing basename similarity
 and content similarity
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 13, 2021 at 3:56 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > This is not true.  If src/main.c is 99% similar to src/foo.c, and is
> > 0% similar to the src/main.c in the new commit, we match the old
> > src/main.c to the new src/main.c despite being far more similar
> > src/foo.c.  Unless break detection is turned on, we do not allow
> > content similarity to trump (full) filename equality.
>
> Absolutely.  And we are talking about a new optimization that kicks
> in only when there is no break or no copy detection going on, no?

Yes, precisely, we are only considering cases without break
detection...and thus we are considering cases where for the last 15
years or more, sufficiently large filename similarity (an exact
fullname match) trumps any level of content similarity.  I think it is
useful to note that while my optimization is adding more
considerations that can overrule maximal content similarity, it is not
the first such code choice to do that.

But let me back up a bit...

When I submitted the series, you and Stolee went into a long
discussion about an optimization that I didn't submit, one that feels
looser on "matching" than anything I submitted, and which I think
might counter-intuitively reduce performance rather than aid it.  (The
performance side only comes into view in combination with later
series, but it was why I harped so much since then on only comparing
against at most one other file in the steps before full inexact rename
detection.)  I was quite surprised by the diversion, but it made it
clear to me that my descriptions and commit messages were far too
vague and could be read to imply a completely different algorithm than
I intended.  So, I tried to be far more careful in subsequent
iterations by adding wider context and contrasts.

Further, after I wrote various things to try to clarify the
misunderstandings, I noticed that Stolee picked out one thing and
stated that "This idea of optimizing first for 100% filename
similarity is a good perspective on Git's rename detection algorithm."
(see https://lore.kernel.org/git/57d30e7d-7727-8d98-e3ef-bcfeebf9edd3@gmail.com/)
 So, that particular point seemed to help him understand more, and
thus might be useful extra context for others reading along now or in
the future.

Given all the above, I was trying to address earlier misunderstandings
and provide more context.  Perhaps I swung the pendulum too far and
talked too much about other cases, or perhaps I just worded things
poorly again.  All I was attempting to do in the commit message was
point out the multiple basic rules with filename and content
similarity, to lay the groundwork for new rules that do alternative
weightings.

Anyway, I've added a few more tweaks to try to improve the wording for
the next round I'll submit today.  Given my track record so far, it
would not be surprising if it still needed more tweaks.
