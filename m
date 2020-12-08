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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8990C433FE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5D36239ED
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgLHASa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbgLHASa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 19:18:30 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1604CC061749
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 16:17:50 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id y17so5100009wrr.10
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 16:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HCjFJ/q72fkIAmpdOVUnRD67fSp1P8U+30/II3ppb2s=;
        b=Mzp2gvSge+5vKli74Fq7izIBPJQssl7bLTv94RxrthJVeuRBqILD/ivon+82hm7fPC
         w3cHmQKbjnOMAPI0gChJkzkZ0Dr8DfKn53UXMpFNDVmYnuHNJR4iYt94L1jsI3dzal8I
         qdnfH405hv7zU9LDaT55ZUNVhXNPBzGO1aH49gz2WC+Jb4pMr1MvfEZMFiz3nFMVKDpk
         6k6YsRHdK5skHWUWA5pKKMxXmMHS+dblNJ9E69bQN3Esamr1jG/zX5XDkuXuMYagFvYg
         0PdDcxCORbrKdin6OsWXLXrZ84tgsEuUVTISi4KgIjeK1Jwa/NtPC+5f/swgO8FFQ6Z+
         hOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HCjFJ/q72fkIAmpdOVUnRD67fSp1P8U+30/II3ppb2s=;
        b=DLhp6XaqU7dhCElx8NfxLhJj+61qTUIuOnI5fsjxob1N6MiNhS3SVzQZmYxZ/wFfOi
         kYPqDrUmLAaU5PKokdyq8lsQMxatd0mATZX2iyzqoowXXo50MVkiF7Yz8m240EXq7bAt
         0ZmQAEmNNfADJEoO5IXgZ+4pCiEpYmtnYXc3mq+yr03cQNzLwvyLkkicTDlyll/G56/6
         7mimhwke/GktWLZXSrWqShAbQP/b8T6f1KPWfcIpEGl+xevsfdBWnKlCTTp+afV+NVDb
         LP5dM6GX8a2zr2ldtlRi66Pk5ha9M5iMedfhJ3QaGo1xhxXgFDh81laCG7Cl0CNZJdtr
         l3Fw==
X-Gm-Message-State: AOAM5314pj/dIl3m2nydYXk1bEhE4mSB/LAE/wopKL0gl7Tndr1sXMdh
        cph+sUdc03UnyOI/RE0/XDHG57ZszA706uVFZl0=
X-Google-Smtp-Source: ABdhPJydxUx709oCXHN+xx7HN3nmFsGO4DvrA3ewKsc/I2qwqqEVc8WiyxC98sIWWHsHPhuykqYoO903rG9wsQbcsMo=
X-Received: by 2002:a5d:4349:: with SMTP id u9mr21639968wrr.319.1607386668736;
 Mon, 07 Dec 2020 16:17:48 -0800 (PST)
MIME-Version: 1.0
References: <20201205195313.1557473-1-felipe.contreras@gmail.com>
 <20201205195313.1557473-2-felipe.contreras@gmail.com> <xmqq8sa99wh3.fsf@gitster.c.googlers.com>
 <CAMP44s1ZDXzGfEqpTeiG=aGAYK40ebnBLQKAbA7KGtcePGARfw@mail.gmail.com> <CABPp-BEkKMuZHWJ8mrFUFm3okDDsMHeZZNxtGzgq-RLLddMxdw@mail.gmail.com>
In-Reply-To: <CABPp-BEkKMuZHWJ8mrFUFm3okDDsMHeZZNxtGzgq-RLLddMxdw@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Mon, 7 Dec 2020 18:17:37 -0600
Message-ID: <CAMP44s0g7JLTZZs=O3gUcEiPt--p3gXEPHL0GsBqoqweKA=9Rw@mail.gmail.com>
Subject: Re: [PATCH v3 01/16] doc: pull: explain what is a fast-forward
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 7, 2020 at 4:40 PM Elijah Newren <newren@gmail.com> wrote:
> On Mon, Dec 7, 2020 at 2:22 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:

> > The glossary defines a fast-forward as:
> >
> >   A fast-forward is a special type of `merge`
> >
> > So, if you consider "merge" a noun, then a fast-forward is an
> > adjective. If you consider it a verb, then it's an adverb. But it's
> > not a verb.
>
> A square is a special type of a rectangle, but that doesn't make
> "square" an adjective; both square and rectangle are nouns.

Words have multiple definitions. The word "square" is both a noun, and
an adjective [1]. It's perfectly fine to say "square corner".

Just like it's perfectly fine to say "fast-forward merge", or "quick sort".

And that's how many people use it:

https://git-scm.com/docs/git-merge#_fast_forward_merge
https://docs.gitlab.com/ee/user/project/merge_requests/fast_forward_merge.html
https://www.atlassian.com/git/tutorials/using-branches/git-merge#:~:text=Fast%20Forward%20Merge

Plus there's many instances in the documentation:

* non-fast-forward update
* fast-forward merges
* fast-forward check
* "fast-forward-ness"
* fast-forward situation
* fast-forward push
* non-fast-forward pushes
* non-fast-forward reference
* fast-forward cases
* "fast-forward" merge

> > If it was a verb, then we should have `git fast-forward`, which may
> > not be a terrible idea, but right now a fast-forward is a modifier.
> >
> > At least that's what I have in my mind, and the glossary seems to agree.
>
> If you read the release notes and even various messages printed by
> git, "fast-forwards", "fast-forwarded", "fast-forwarding", and "to
> fast-forward" all appear multiple times.  And yes, "fast-forward" also
> appears multiple times as a noun in addition to the various uses as a
> verb.  So, I'd say the glossary just isn't comprehensive because in
> this case we have a word that serves as both a noun and a verb.

It can be a noun, a verb, an adjective, and an adverb. But the
question is not what it can be, but what it actually is. I'm just
telling you my rationale:

1. noun: it doesn't make sense because you don't create, pick, show,
or push a "fast-forward"
2. verb: there's no idiom to tell git "do fast-forward"
3. adjective: there are merge nouns (commits), but no instances of
fast-forward merge commits, like say octopus merge commits
4. adverb: you can tell git "do merge", and "do fast-forward merge"

So, in my opinion a fast-forward today can only logically be an adverb.

Like a bubble sort is a special type of sort, and theoretically you
can say "do a bubble", but it's just weird. My mind is left hanging: a
bubble $what? Likewise, when people say "do me a solid", I'm
annoyed... A solid $what?! They mean "a solid favor". People do it, so
it's part of language, but it doesn't stop it from being weird in my
opinion.

An adverb typically answers the question "in what way?". Do me a
favor... In what way? In a solid way. Do a sort... In what way? In a
quick way. Do a move... In what way? In a bold way. Do a merge... In
what way? In a fast-forward way.

> Going back to the text Junio highlighted, I agree with him that the
> phrase looks really awkward, and much prefer his suggestion
> (regardless of whether it aligns with the current glossary).

Normally I don't show credentials, but in this case I think it might
be relevant. I've read multiple linguists, like Noam Chomsky, and
Steven Pinker. I follow many others and read their articles. I also
read The Pinker's Sense of Style: The Thinking Person's Guide to
Writing in the 21st Century [2], which I can't recommend enough for
people writing technical documents or any other classic style. I have
an arguably successful blog with more than 200 articles and more than
1 million views, which is regularly linked from other blogs, and
technical resources. I constantly get thanked both in person, and
online for what I write. And at some point I was asked by a publisher
to write a book about Git (which I didn't feel prepared for at that
time).

So, clearly at least some people value the way I write.

I'm not trying to be stubborn here, I just honestly put effort into
the art of writing, and I do care deeply about language.

Of course I might be wrong in this particular instance, but if I am,
it's not because of lack of effort.

I think fast-forward is mainly an adverb, but even if it isn't the
main usage; it's still clearly an usage.

Cheers.

[1] https://www.merriam-webster.com/dictionary/square
[2] https://www.amazon.com/Sense-Style-Thinking-Persons-Writing/dp/0143127799

-- 
Felipe Contreras
