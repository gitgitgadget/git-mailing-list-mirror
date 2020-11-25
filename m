Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849ECC2D0E4
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 00:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24C9F2151B
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 00:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ihrp7d0B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgKYAJY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 19:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgKYAJY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 19:09:24 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9637FC0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 16:09:23 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id i2so190213wrs.4
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 16:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iPY9z+bAhLfkJ5TpIVFNcrQ3dHGtJJiyOIDsc3WzBn8=;
        b=Ihrp7d0BKQdjRBL25vaeqhmBXweUoP3zXoFygPfkIMXtvkWbUfZlC14IvWsKTKxipF
         JIt7t7BBKgINXR2sFwqgn34t/2U3YAiMw7joplSew1wZvj39eMXFzbJhNvOWyS7urqms
         7ilav/hcw2FdxleSAN7UtH04Yczwb0kz7iS4ZPUDM/osjdc4E5uEiD0FkoXGyHqtg542
         sMBeCpyRlNOR4maTQpsfIOkxoTPqpsi3RXjolyw1cMFxg5LdDgbIZnYhkEq9eXVjXkZU
         /CysnNTq9FQmoDMiPoGGUws5uxykFnmIhgLi1qKpmkXqd7RrsJf4z4WXe2esorlimXE9
         W/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iPY9z+bAhLfkJ5TpIVFNcrQ3dHGtJJiyOIDsc3WzBn8=;
        b=KZc99uwB0k0P/6rmqtSfvYKQmQ+8Fr38cPYexhv45RLUW4fwN61HCDN9ENOXo7NuAH
         LJ0I6gK18lCv9jxDUUISLpx8hZQN+5j1CGRWovv5VdbowjY7e3WI2IwB4SbBIry3reLJ
         86W1vpmfXyLsIjuBpHFUf0b+2uZPDIMmvXs/yxVqSjXOpattXeBIBm45V5wq/jhYY4cG
         yc6vtypKPly/e7+pAz38wvKfGrcUx3WKa3tU5VJ+kjBtY7pvqFXCgi1OYbBwqeQz44AM
         mocxsEZLb6uKQIRhDTz2/Z47a6sIZcs19mHp8rw0BodSbcQFeJbRut/s9bh1PrlBBlFA
         c+eA==
X-Gm-Message-State: AOAM531G2OCQjhEi0LrLnsiu7qmoSlZMalmIHhYv5Z9zJbrq2/jrwoTV
        h5yHuKX1IWTSOIHB43PSU3VgZ6qT9hQmNZhKMW4=
X-Google-Smtp-Source: ABdhPJwOitbidzmKDqdwcg505Lbhqkw/K73IcJ/1Omiqk3KR2DvtuzeWUlp99X2L2/OKn4lPeMEDFTRxRO8kgWhZBoY=
X-Received: by 2002:a5d:4349:: with SMTP id u9mr952006wrr.319.1606262962296;
 Tue, 24 Nov 2020 16:09:22 -0800 (PST)
MIME-Version: 1.0
References: <20201122164641.2091160-1-felipe.contreras@gmail.com>
 <X7y5Wxu1eY4k6753@coredump.intra.peff.net> <xmqqlfeqjzi1.fsf@gitster.c.googlers.com>
 <CAMP44s0PwJ8qEuCCpavshpm0GqV8p37rF8McR2=gdCk2kj+JiQ@mail.gmail.com> <xmqqo8jmgyrd.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqo8jmgyrd.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 24 Nov 2020 18:09:10 -0600
Message-ID: <CAMP44s3f_cO61YVjvwsiswKQRESznOFn7KTshgv06a=zVRPLug@mail.gmail.com>
Subject: Re: [PATCH] refspec: make @ a valid refspec
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git <git@vger.kernel.org>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 24, 2020 at 4:45 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
> >> I too find that "@ is a shortcut for HEAD" looks ugly both at the UI
> >> level and at the implementation level [*1*], but as long as we have
> >> it, it is good to try to be consistent and allow "@" everywhere
> >> where one would write "HEAD" in places where it is syntacitically
> >> infeasible---at least we would be consistently ugly that way ;-).
> >
> > Beauty is in the eye of the beholder.
>
> Using "@" is rather "illogical" than "ugly", and at that point it is
> not so subjective.

I disagree.

> @-mark leads a suffix that applies some "magic" to what comes before
> it (e.g. next@{1}, maint@{2.weeks.ago}, and master@{-1}).  Making @
> a synonym for HEAD means '@' sometimes means a ref and most of the
> time means the introducer of magic that applies to a ref.

All this was discussed back then [1].

In my mind "@" means the same as "@{0}", and "@{0}~0^0". So I don't
see any inconsistency.

Your mind may be different.

> Worse yet, @{4} does not refer to HEAD@{4} but refers to the 4-th
> previous commit the current branch pointed at, so a mnemonic for the
> end user to remember the distinction between the two is that a bare
> "@" is different from HEAD, which is a total opposite X-<.

Once again; each user is different. Personally I never use these
shortcuts precisely because I'm not entirely sure what I want to tell
git. I just use "git reflog" and manually pick the commit id I want.

I suspect most users don't use this notation either, so even if
there's an inconsistency (which I'm not entirely sure the @ shortcut
has anything to do with it), it would affect few users.

> This is all water under the bridge, though ;-)

Indeed.

And I take it we can agree that it's better to have instructions like:

  git push -u origin @

Rather than:

  git push -u origin master

Regardless of what some users think of "@", it's less contentious than "master".

Cheers.

[1] https://lore.kernel.org/git/1367264106-2351-1-git-send-email-felipe.contreras@gmail.com/

-- 
Felipe Contreras
