Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892AFC4167B
	for <git@archiver.kernel.org>; Sat, 12 Dec 2020 01:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5063E2343E
	for <git@archiver.kernel.org>; Sat, 12 Dec 2020 01:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437696AbgLLBC7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 20:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405903AbgLLBCr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 20:02:47 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90865C0613CF
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 17:02:07 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id a11so3010646wrr.13
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 17:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PUgkCOoJbaDpDATOVUTPoD87sGKh9PITYLMmJn4yPXI=;
        b=Dovf2jbXApeyKeoq3iwohXWSGKoy4XSr38ReEuHNoboQnbpAzzKMoIqJQm42VOZ+Co
         uUTHjR1JjaDyKWWxJ8IgIRDz/5qs8ulyo53Wxc7ZMv4koeEZ9nGwF1IWXI3UMaORLj6Q
         DIbW+Y0YpC2daQNn4mjOPi0DjkDMsFCTzqN/t3awGg6ERO4SEhwwQDTM+F4ipELii4Qu
         OLLiOZ/pbs9okVLS0JGqJWgPz6Sl7aLX4+bIPr9oMunb+8IeRuVXhRT+x2DVlYtyUNmn
         ltz1Uh5h33z/CLFckcgsLlOSaNwUBkomUWOex8fadHtqUun+S/XYhk3m+wk7Ks6BgarB
         UiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PUgkCOoJbaDpDATOVUTPoD87sGKh9PITYLMmJn4yPXI=;
        b=LxxV+dLy5cFGdoC+ao2ylWQ/VsPz3w7kxFHBvVaNN4UrRU35uXI3smUj3fOuif2VH8
         74F2jeMJK9L1NBWydJXBD4Pljg9UMo7MDn2/76arAB8ROMX4qga72mTRvv8JmMXq9ZpA
         +HcyF6r/1xjQ7uSAHv1ZWFleePUxGoHjqXDGyZtpwBbim20Rth1DVc23O2b+b+blJOsG
         89CAgIpbBjulMuBAnpPaS1JL8PaZVS2rTYmYQjoV4D8/NXb3RNf/j/0AqhsmbMpkxqFC
         kKlYI2wTaIEmabvQPxWZPFuCilrD0w0H10at72RNM56FN9z4LoWNcMjqaD13T0d+wa69
         0+fg==
X-Gm-Message-State: AOAM530JlZT2XMIVLquoWEJ3AewE98Wh7cPkrBfenEN2iEWU2xT00YeW
        C69PIB601aWxTKSvqHICHXllQgtRp7STQR+fe5k=
X-Google-Smtp-Source: ABdhPJwnhN1VTQVptHPQKVV/4ZdlH9HqKoXHKp40co/lTD9KT1y5Agf+Yo5yPgoU8akr4OfFLq9ca34QBIPIQBgUzG4=
X-Received: by 2002:a5d:68c9:: with SMTP id p9mr16650857wrw.139.1607734926093;
 Fri, 11 Dec 2020 17:02:06 -0800 (PST)
MIME-Version: 1.0
References: <20201210100538.696787-1-felipe.contreras@gmail.com>
 <20201210100538.696787-4-felipe.contreras@gmail.com> <xmqqzh2kitn9.fsf@gitster.c.googlers.com>
 <CAMP44s0wjfZ9TeQzpJvVD-OzFA47HFd87TABiJo3Ec9H8j-fjA@mail.gmail.com> <xmqqa6ujj3s4.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqa6ujj3s4.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 11 Dec 2020 19:01:55 -0600
Message-ID: <CAMP44s256RnOy0pPDCa1M18Ahu30i3NY4S7OZD41U0tfZWYTCQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] pull: display default warning only when non-ff
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 11, 2020 at 5:56 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
> >> We seem to be losing test coverage by checking how pull.ff=only prevents
> >> the command from working in a non-ff merge.
> >
> > No we don't. Remove the "test_config pull.ff only" and the test fails,
> > as expected.
>
> > ...
> > What do we get?
> >
> > not ok 4 - pull.rebase not set and pull.ff=true
> > not ok 5 - pull.rebase not set and pull.ff=false
> > not ok 6 - pull.rebase not set and pull.ff=only
> > not ok 7 - pull.rebase not set and --rebase given
> > not ok 8 - pull.rebase not set and --no-rebase given
> > not ok 9 - pull.rebase not set and --ff given
> > not ok 10 - pull.rebase not set and --no-ff given
> > not ok 11 - pull.rebase not set and --ff-only given
> >
> > All failures. Exactly as expected.
>
> Assuming only one kind of breakage and try to break exactly that
> thing does not prove much.

It proves we are testing exactly the thing the test is meant to test.

No test is ever perfect.

> I'll keep this short as I am supposed to be off officially.

I appreciate that.

> With pulling without choosing between rebase/merge, the old code
> had one behaviour wrt the message---it always advised, whether
> the pull was ff or not.
>
> The new code has two behaviour wrt this aspect.  It behaves
> differently when the pull is ff or non-ff.  That would double the
> possibility that needs to be tested if we wanted to keep covering
> the original set of conditions *and* cover all new possibilities.
>
> I am saying that you should keep the original ones, and add new ones
> to cover the new cases if that matters.  Otherwise the conditions
> under which the original tests were checking would no longer be
> tested.

I disagree. The old condition is perfectly well tested with this test:

  test_expect_success 'pull.rebase not set' '
    git reset --hard c2 &&
    git -c color.advice=always pull . c1 2>err &&
    test_decode_color <err >decoded &&
    test_i18ngrep "<YELLOW>hint: " decoded &&
    test_i18ngrep "Pulling without specifying how to reconcile" decoded
  '

In other words; we have tests going horizontally, and tests going
vertically. That should cover all the bases.

But fine, if you want a matrix of tests I can do that.

> >  test_expect_success 'pull.rebase not set and --rebase given' '
> > -     git reset --hard c0 &&
> > +     git reset --hard c2 &&
> >       git pull --rebase . c1 2>err &&
> >       test_i18ngrep ! "Pulling without specifying how to reconcile" err
> >  '
>
> This used to make sure an attempt to rebase c1 onto c0, which can be
> fast-forwarded, would work fine,

No it didn't. It may very well have done a merge, or done nothing at all.

The tests that actually check that "git pull --rebase" works both in
the fast-forward and non-fast-forward are in t/t5520-pull.sh.

The goal of this particular test is to check that the warning is not there.

> even though it used to give
> warning.  We should keep testing the same condition.

We are testing what was originally tested: that the warning is not presented.

> The expectation of seeing the warning is what must be changed, not the
> test condition (i.e. rebasing c1 onto c2 instead of c0)---you are no
> longer making sure that c1 can be rebased onto c0 cleanly.

We disagree on what the "test condition" is supposed to be on this test.

But fine, I'll create the matrix.

Cheers.

-- 
Felipe Contreras
