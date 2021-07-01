Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20205C11F66
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 00:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E48A0601FE
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 00:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbhGAAJ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 20:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhGAAJ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 20:09:28 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAD4C061756
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 17:06:59 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id c5so4253129pfv.8
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 17:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I0It+gpw2QAHFhqfQ0AVddd1MnJoZ2CaFAYLNyGx1dQ=;
        b=rspWGH5YqmoZ8EeIw7N59kwtX3gDeMo49uduzUlTqv0sak1iaot0/8GkT3LvHib8Z2
         ZbbXrbfLSAPrPO6MvzsLcemF1OwVH2utHk5kAHz9g65n3CPjAl3Wx94NWG4E9WlQOqZf
         7KIXdrOHyaAz2xPIrwUOvPf7jB0PxV+WX8exp0fpPYp3j9cP4reQ1ZnT8YNDFMWR1KuH
         JhIUjpe6xl5UptI7+h0KO7+l157hcjXxfjW5cJ2kKBT8S6T3z3PCcS6K/FqAQ3W8Fw07
         4MEvIP2JYN09zJ+SB3wUNqocjudTjPJi0kbz79Cy1NLkueLcPchGrWRKTPVafkQ1sRQw
         cZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I0It+gpw2QAHFhqfQ0AVddd1MnJoZ2CaFAYLNyGx1dQ=;
        b=XxH/Y+TFOObtGM5CzbrOuZ2aAA1wcUlSpqaKLAj7avuXZgDTiJ5aTiCfJPJXY9vkNB
         SkyyoZprbCvvrOiIARQD6nto3w3/UveRRpPzavW4xjDmt3sdnTN7+SaJ3EZiEzBFoby6
         cNpq2UuVvG5zrDucMK3otobtEf6OfDeH/E+YddlD73h59IZWjnDPjtDSZy1UfQLr5qsm
         Bni+6WK+P8EGKLr0n41PZXoRY7MAFd8ufd5780dHKAz2kGj/SpIw3WFulv4MUqBotySO
         bMGb91uEXBB1rrsJwqcBRARff8vbG3B3GVR8jBE/Su2GnM6mC3rP0ndDEuORZ4lqCV+F
         ooWA==
X-Gm-Message-State: AOAM533sRF0CRuisa44IoaIULE1MallWLcy3hn4ZKjUnOrjUS2xo/Xbh
        v1kceiliWnd7O/z9+3VtV29KXDnyfBvtxeQkGPQ=
X-Google-Smtp-Source: ABdhPJws/YsQ9qbnooRkJB3nlCzDP1hp96+8imQ8DqjFap8sq/u3dSbqra1bJgOOsmsKBNKtWo3QaO1KAgz0JEi9KW0=
X-Received: by 2002:a63:d711:: with SMTP id d17mr13492000pgg.268.1625098018544;
 Wed, 30 Jun 2021 17:06:58 -0700 (PDT)
MIME-Version: 1.0
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <xmqqk0mcy6g2.fsf@gitster.g> <b667ca37-b3cb-fce2-a298-63c3b839089d@mfriebe.de>
 <xmqqpmw4uwh2.fsf@gitster.g> <7870a0ad-8fa1-9dbd-1978-1f44ec6970c5@mfriebe.de>
In-Reply-To: <7870a0ad-8fa1-9dbd-1978-1f44ec6970c5@mfriebe.de>
From:   Matt Rogers <mattr94@gmail.com>
Date:   Wed, 30 Jun 2021 20:06:47 -0400
Message-ID: <CAOjrSZuoD5-5FeRXmFPbRxFptyv_x-G3quFqCptvCX_XY9mSyw@mail.gmail.com>
Subject: Re: PATCH: improve git switch documentation
To:     Martin <git@mfriebe.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 30, 2021 at 4:50 AM Martin <git@mfriebe.de> wrote:
>
> On 30/06/2021 00:39, Junio C Hamano wrote:
> > Martin <git@mfriebe.de> writes:
> >
> >> My text may indeed have lacked clarity. I was trying to emphasize to
> >> hard, that this
> >> command's "force" enables 2 actions that may both not be
> >> wanted. Usually if one applies
> >> "force" to a command only one such action is expected, or at least I
> >> would only expect the one.
> > Oh, I do agree wholeheartedly if two things are forced at the same
> > time, things can become confusing.
> >
> > But the thing is, there are no such "two things are forced at once"
> > in this case.  That is why I emphasized, in my response to you, that
> > "switch -C <newbranch>" does not touch working tree, so "ok, the
> > switch stops because it requires some working tree files with
> > changes clobbered, and I can force it to make it happen" is not
> > involved.  If it were, then it becomes fuzzy if --force is allowing
> > an existing branch getting overwritten, or allowing a modification
> > in a working tree file getting discarded, or both.
> Well, yes and no. IMHO.
>
>  From what I have seen, there are main 2 cases people use -C.
>
> 1) By accident, meaning to do something else. Most often meaning to do a
> rebase.
> I.e. some one who is new, desperately to fix "branch has diverged".
> For this, those people need to be made aware that -C does not move the
> commits.
>
> 2) Intentional, when the branch to be re-created points to a commit,
> which is hold
>   by further branches. So no commit becomes unreachable.
> In that case it is not a documentation issue. It is a, how can I enable
> the re-create,
> but have git warn me, if I somehow misjudged the situation and on other
> branch
> has the commit. That is, when I see this as 2 individually actions, out
> of which I want
> to allow only one. Anyway that is not documentation, and I did sent
> another mail.
>

I just want to point out that my usual use-case for using -C (or checkout -f,
but the usage is similar enough for this discussion) is when I want to create
a temporary branch with a generic name (e.g. tmp) and I haven't cleaned
out my unused branches in a while.  If I find myself having branched off the
wrong commit and wanting to move work I already committed, the user should
be looking to use either rebase or merge for that.

I would also consider that using a command literally called "switch
--force-create"
does not seem like the obvious first choice for "My history is
different than that
history".



> And yes, for the documentation, it *should* be clear that, removing a
> branch, removes the
> commits on it.
> But then it must be said, that the branch is first removed. That is not
> currently the case.
> I proposed an alternate text to that nature in my last mail.
>
> For the rest, it is a matter of opinion.
> When I think a new user may read this, I believe such consequential
> implications should
> be mention rather explicit.
> But, if your view (the view of the git team is) a new user should have
> read up far enough
> to be fully aware of those consequence, then so be it.
>
> As per my previous mail, then maybe
>        Force creating a branch, means that an existing branch of the
> same name is removed.
>       A new branch is created at the specified <start point>. The
> new branch will not
>       necessarily have all the commits that the existing branch used to
> have.
>

I think the current documentations usage of "reset" in

    Similar to --create except that if <new-branch> already exists, it
will be reset to <start-point>.

Is pretty clear about what happens, although it does rely on users
being familiar
with the semantics of "resetting" a la git reset.  I think rephrasing
it in terms of
branch removal/creation actually obfuscates the matter.


> Well, if one creates a new feature branch, and instead of forking of
> master, one forks of some
> random other branch. Then one can immediately re-create it at the
> original intended
> branch point. No commits on the branch, none lost.
> But teach that to a newbie, and they may have committed to the branch,
> before they
> realize they forked at the wrong point. If the then do -C those commit
> will be gone. (well, yes the reflog).
>

I don't think that this is a great usage of switch -C.  generally I teach people
to look at the state of their repository via `git log --graph
--oneline --all` and then
decide whether they need to rebase their work or if they can just reset onto the
branch they want to.


-- 
Matthew Rogers
