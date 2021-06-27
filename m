Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657B7C48BC2
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 07:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 375D461C2F
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 07:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhF0HwW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Jun 2021 03:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhF0HwW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jun 2021 03:52:22 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61583C061574
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 00:49:57 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id h9so17672597oih.4
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 00:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1nWRS0YP0ozbBKB2D0z/vJWVJVeQ6/nqepIlXJ4oDkY=;
        b=fPJXwyVjkOrsCs24KIsrPPcwNFa4V3GXo9fnSUSnmf+jD4lrKlbS94Z/+tl0Y6rZ3r
         b9NPeEwzEuYNrTouy2SPqqVltf39d/TjYO7qelvhidb2VE7IeuhfQHOgBCU6CbW83Lze
         j21FdZN78WH1ZRW2jKFTYj8qui5v5fxTLuCQa9nyGKjvtnJvrUajS6F+XOk2k9cxHiQW
         dOnGTC5fnwvJ7DiB1tnoAe9Wl6ABGa8ysTuoRVNPDqAqDH8XKadJmshwq2qCJnUjR//k
         0HJL/FSaem3VR5oWFssMJHSpUbmcwEeU9t+wUuaTqfUAcNEq0mfKW/smxuUbZ0Ox5Ukf
         tVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1nWRS0YP0ozbBKB2D0z/vJWVJVeQ6/nqepIlXJ4oDkY=;
        b=Aa10viXO0fglDgb/SUcb6yQU12CK7QTJk52MuizriImMotJOkpHCGxoj3hnapWxN2Z
         kBmvA4LwC9jxFsb/jZ8lLdx2K1w3z2LOjT02unPFQv90NwYl04VEwn5vc7D1dE5S4WmI
         2Eq11POiAGYKzvu0uQ0PWBsVelQ5iOuUSweK7/QQlOuoOyoD1duEzYHvC06JYrfkHlX6
         UzDjVN0vJdT2wUtREEWaxuydTr2YIs2kQMM8IbyFjUv68savh5DHfojEQsulZa2ZbqZt
         HoV5E5olK8LeBQ92d4iT8ZAQ6xRe1viV6MIQ8IRoW7iMAjUuRIPgEY/VcHXaQ9FpkUCm
         7yBQ==
X-Gm-Message-State: AOAM5338Zg7HB7IK/0pE+1p5zVn/Bw+Qsyc/jU+7VJtP+wJ0E7isZgRg
        1G4mvvFUHLV2oapZBTTgL9UQbUNEhhYF/uOpLM8=
X-Google-Smtp-Source: ABdhPJwxa7HbpjeL6KcvoaVkBuzQpssWqsH5YfsndDD38M/InDhrDGb5QaBwCpfqoDJxqRaA2pgf+KROVkpSNBLQq2I=
X-Received: by 2002:aca:330a:: with SMTP id z10mr13925009oiz.31.1624780196402;
 Sun, 27 Jun 2021 00:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210627000855.530985-1-alexhenrie24@gmail.com>
 <CABPp-BGko7BP6ZMyRKwKrv0xz7FM9ehe67HSAtzgHF9eV2TD3A@mail.gmail.com> <60d7fbb770397_b8dfe2087d@natae.notmuch>
In-Reply-To: <60d7fbb770397_b8dfe2087d@natae.notmuch>
From:   Elijah Newren <newren@gmail.com>
Date:   Sun, 27 Jun 2021 00:49:45 -0700
Message-ID: <CABPp-BGXQ4vbFf6Gx21X-Ms+1VQsZfod1waNJZQxVmB7b-gD7Q@mail.gmail.com>
Subject: Re: [PATCH] pull: abort by default if fast-forwarding is impossible
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 26, 2021 at 9:16 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Elijah Newren wrote:
>
> > The code changes look good, but you'll need to add several test
> > changes as well, or this code change will cause test failures.
>
> Wouldn't you consider sending a patch without running 'make test'
> "cavalier"?
>
> > Thanks for working on this.
>
> Such a completely different tone for a "cavalier" patch depending 100%
> on the person who sent it. Weird.

First of all, attacking a random bystander like Alex is rather
uncalled for.  As far as we know, Alex is trying to help out and made
a mistake or oversight, but will likely correct the problem if kindly
pointed out.  This email is egregiously far from constructive
criticism for Alex.

Second, why do you grossly mischaracterize folks (not just me) and try
so hard to insinuate unfairness?  I don't get it.  Do you really not
understand?

Let me attempt to explain...



Not running the tests is a problem, sure.  I pointed it out.  It could
have been a mistake or oversight on Alex's part.  Now, if Alex were to
state it was not accidental and then repeatedly defend submitting
patches without running tests, I would absolutely start calling out
both his submission and his professed level of reasonable due
diligence.  He hasn't done that though.  People deserve a chance to
respond and correct things first.

We gave you that same opportunity.  It was pointed out to you rather
politely that you had neglected to act on a report that a patch caused
a segfault[1]; in fact, you re-submitted the old patch as-is and
suggested it might be a good default[2].  You had a chance to point
out that what you had done was just a mistake or oversight.  Instead,
you confirmed that you saw the report and just didn't bother acting on
it[3].  And then you defended your misbehavior[4].  Over[5] and
over[6] and over[7] again.  And you also defended your related
patches[8] instead of double checking or trying to correct them --
even when prompted to double check[9] -- despite those additional
patches having severe problems of their own[10].

So, yes, I used terms like negligent, reckless, careless, and cavalier
in my critiques with you, but I very carefully always used those terms
to describe either the patches you submitted or the amount of due
diligence that you repeatedly defended.  I never applied those terms
to you.  And those terms didn't apply to you, as you could have chosen
to change and use a different level of due diligence.  So, your
accusations of personal attacks, harassment, and ad hominem arguments
that you made against me earlier[11], and your insinuations of
unfairness both then and now, are all false.

This, of course, isn't your first time grossly mischaracterizing
events and trying to claim unfairness.  Let me give you a second
example of why there was no unfairness in case the first is hard for
you to understand.  Let's use [12] as another example, and explain the
lead-up to that time: I politely gave you a chance to correct a
misleading claim[13], which you then instead admitted to being no
mistake[14], and didn't bother to correct.  The original misleading
claim was a minor issue.  If it had been corrected (even if it had
been intentional), it could have been no big deal.  The reason I drew
significant attention to it[15] was due to your response.  I pointed
out quite clearly when I drew attention to it, that it was your
*response* to the error that was problematic, and even reiterated it
in a follow-up.  I do not see why you ignored that, mischaracterized
my objections as being entirely about the initial error, hand picked
an example that didn't even do what you said it did, all to lead up to
your "Could it be that this has absolutely nothing to do with the
action, and everything to do with the person doing the action?"  The
answer is quite simply "Of course not."  I would also call out other
people if they stated that misleading claims of theirs were
intentionally submitted and did not try to correct them.  I just
haven't ever seen anyone else do that.  (Let alone follow it up again
a short time later quite similarly[16], except that at least you
corrected it.)

Unfortunately, these aren't isolated incidents of claims of
unfairness, and it's not just me you hurl these accusations against.
In fact, in other cases with other people you go much further
overboard.  For example, you recently used the phrase "petty personal
animus"[17] with Junio.  Perhaps you don't see the problem, so let me
state it in a way you might recognize:
     Could it be that you always use these perjorative phrases in
questions just to provide plausible deniability that you are directly
accusing folks of severe personal failings?
Just as I shouldn't ask the above question (I only did so to try to
highlight how your questions come across), you shouldn't be asking
yours.  It's inappropriate.  Putting such negative words in a question
format might make the phrases less objectionable, but the questions
are still way out of line.  If you react negatively to my example
sentence above, hopefully that helps you see why that is
inappropriate.  Please correct this pattern.

And all of this hardly even touches on your interactions with
reviewers, which sadly is following the same arc as in 2013 and
2014[18].

In short, please stop:
  * Please stop attacking random bystanders like Alex (or other folks[19])
  * Please stop defending shockingly inadequate levels of due
diligence, and adopt a higher one.
  * Please stop accusing others of bias, unfairness, and other
shortcomings.  Learn to recognize why your behavior often results in
others changing theirs.
  * And please find ways to stop burning out reviewers, especially
since they are the rate-limiting resource in determining git's overall
velocity


Please know that I really do think you are talented.  I tried really
hard to help you change and improve because I thought you could have
been a great addition to the community.  I'm nowhere near as talented
as Michael in expressing it (again, [18]), but I really wish you had
chosen to change.  I agree with his sentiments back then.


[1] https://lore.kernel.org/git/YMYnVWSEgxvKRU9j@coredump.intra.peff.net/
[2] https://lore.kernel.org/git/20210613143155.836591-1-felipe.contreras@gmail.com/
[3] https://lore.kernel.org/git/60c647c1d9b5c_41f452089@natae.notmuch/
[4] https://lore.kernel.org/git/60c82a622ae66_e5292087f@natae.notmuch/
[5] https://lore.kernel.org/git/60c86ff87d598_e6332085b@natae.notmuch/
[6] https://lore.kernel.org/git/60c85bfd112a9_e633208d5@natae.notmuch/
[7] https://lore.kernel.org/git/60cb7f3e66cfd_1305720822@natae.notmuch/

[8] https://lore.kernel.org/git/60c85bfd112a9_e633208d5@natae.notmuch/
[9] https://lore.kernel.org/git/CABPp-BGZ2H1MVgw9RvSdogLMdqsX3n89NkkDYDa2VM3TRHn7tg@mail.gmail.com/
[10] https://lore.kernel.org/git/CABPp-BEXtJtkkh9Diuo4e1K1ci=vggGxkLRDfkpOH12LM8TCfA@mail.gmail.com/

[11] https://lore.kernel.org/git/60cb5a02f1b31_1259c2086f@natae.notmuch/
[12] https://lore.kernel.org/git/60cb7f3e66cfd_1305720822@natae.notmuch/
[13] https://lore.kernel.org/git/CABPp-BGstXDbzxpySw7q_jn22HD05MsrZeHNv+kXFHOFS2_WCQ@mail.gmail.com/
[14] https://lore.kernel.org/git/60c887f678c88_e63320846@natae.notmuch/
[15] https://lore.kernel.org/git/CABPp-BG53Kd7MhzE3hdq5fjBQVV2Ew3skcUCAuTfM5daP2wmZA@mail.gmail.com/
[16] https://lore.kernel.org/git/CABPp-BF1noWhiJadHzjJmnGo8hdZj6Fk7XnZ=u6BVVSGfHE7og@mail.gmail.com/

[17] https://lore.kernel.org/git/60d289c84fadf_312208dc@natae.notmuch/

[18] https://lore.kernel.org/git/53709788.2050201@alum.mit.edu/

[19] "if you eyes have trouble seeing", from
https://lore.kernel.org/git/60839422353fc_10cb9208c7@natae.notmuch/
       https://lore.kernel.org/git/87fszfafkh.fsf@angela.anarc.at/
