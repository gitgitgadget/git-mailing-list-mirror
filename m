Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55C8C433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 16:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbiBVQ11 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 11:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233885AbiBVQ1X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 11:27:23 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FD06C947
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 08:26:55 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id lw4so44576486ejb.12
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 08:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GV9VteCvrmUTyIdd7aEjASp5yyEUKOtzJVCJldQ73T0=;
        b=FikUWf5qqYEkhtR6zEbF7EzhVKqCXWYy10dioeqfTjGfAKC1SZrxCD7E0fvTfdRrRz
         tBPDZhpNBUPPeEzhJXddZNxivfln8ldCsORr7sJ+m8x/tftSzJ8pZQOLUbq6s/mq3hHR
         3o/AqP5UniVsYE7oqiqSAJQGUQZSMImN1kwCDmlx7i5/cInWaevjiygnMguG856gam84
         0sEPjNHjuGLLuxhVsPHORI2wbejZso/dJ1NEdUdh5HvbcNlMoOsBH/9Za9lmKj+Oex0X
         WCBhmcLAZJvsHreLC/94/IqQPVtBQypDNErnC6DlW/6TyPBKoVNR6Fmji9jUaI4HmYsb
         WqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GV9VteCvrmUTyIdd7aEjASp5yyEUKOtzJVCJldQ73T0=;
        b=zPq5v1/AzpKNeNQF1c35JMVs8b8qONMafv6+fTUTyfiR1tKVk8aigwbBev8NYFp5OV
         7GDrSwaVu/HIWqOSU2hl4oxUPsPEtEMZ32dXCYHRo/N6UI4UTr6Uj7suFgJDqcCHAE5e
         57sPmwvMOELROxRowA2iRJ/E7nc8vDU71y+fRYH8CnKW0bml3qdoE94/W8WCbZ8C8yJV
         09uylB5LCp1bkpo4d5BYQaKDBB0BmJsoipwwpMvgJyYlmkm8TqmxPptkiBGqc6GOs+UQ
         53K2/5+F6plz510BRsACokHIzxLoWpSEjavedV8zLb7+noeDEPe/KxWVm23/KW2uG1tn
         Ktxw==
X-Gm-Message-State: AOAM530KVR3X8/MaJc80BKN8uL2I1rlCJ8z9rWz7rF9pKMF//LViPxqf
        VKSczisZFbQQ3JN4MEFpUaCBCEK7Y1enxRHITUM=
X-Google-Smtp-Source: ABdhPJwysRSjP5KX3PSo7+1JzzyeyYtbhtptoqddWFgwgnS8UDPOTk9ARnaDiHdn9EwpMudmPiVUyitAox9GfRJ4xjw=
X-Received: by 2002:a17:906:3a18:b0:6cd:ba45:995f with SMTP id
 z24-20020a1709063a1800b006cdba45995fmr20590361eje.328.1645547213559; Tue, 22
 Feb 2022 08:26:53 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
 <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com> <02c29f920d0d5fde6d85f7b86a69be92e3f0f34d.1643787281.git.gitgitgadget@gmail.com>
 <xmqqy22tx8t1.fsf@gitster.g> <CABPp-BGpD6g5QH3=4X_dCuSX0Bs0utHn5hyuU4_UiwNhU0h8sg@mail.gmail.com>
 <xmqqh79hvsgn.fsf@gitster.g> <CABPp-BEaemkGGm0cSofP0gau7YN-y6HFoi0yJbHA8+iGjxsYSA@mail.gmail.com>
 <xmqqee3wt5g3.fsf@gitster.g>
In-Reply-To: <xmqqee3wt5g3.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 22 Feb 2022 08:26:41 -0800
Message-ID: <CABPp-BE+DaBkis0r7pqs-kaChCvFhCEsyDg=gs3=QjWOPERaXQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/15] merge-tree: implement real merges
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 21, 2022 at 10:55 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > Adding such an ability to merge-tree would be trivial -- it basically
> > involves just two things: (1) accepting one extra argument, and (2)
> > calling merge_incore_nonrecursive() instead of
> > merge_incore_recursive().
> >
> > However, I think forking a subprocess for every merge of a series of
> > commits is a completely unreasonable overhead, so even if we provide
> > such an option to merge-tree, I still want a separate plumbing-ish
> > tool that does non-worktree/non-index replaying of commits which is
> > not written as a driver of merge-tree.  That other tool should just
> > call merge_incore_nonrecursive() directly.  And such a tool, since it
> > should handle an arbitrary number of commits, should certainly be able
> > to handle just one commit.  From that angle, it feels like adding
> > another mode to merge-tree would just be a partial duplication of the
> > other tool.
>
> The above does not make much sense to me.
>
> I am hearing that "multi-step cherry-picks and reverts need to be
> fast and we need something like sequencer that is all written in C,

Yes, I agree with that part so far.  jj is kicking our butt on rebase
speed; I'm not sure if we can catch it, but it'd be nice to see us not
be more than a hundred times slower.

> and single-step cherry-pick is merely a special case that does not
> deserve a plumbing".

Well, apparently I failed at communication if that's what you heard.
Perhaps I can step back and provide my high-level goals, and then
mention how this series fits in.  My high-level goals:

  * new sequencer-like replay tool, including multiple abilities
today's rebase/cherry-pick tools don't have
  * enable folks to use merging machinery for server side operations
(merge, rebase, cherry-pick, revert)
  * do not repeat or encourage the rebase-as-shell-script mistakes of yesteryear
  * somehow split this up into reviewable chunks

Now, in particular, the "merge divergent branches" piece seemed like a
really simple portion of the problem space for which I could get some
early feedback without having to address the whole problem space all
at once, and which doesn't seem to have any downside risk.

And even with my attempt to narrow it in scope, and even despite lots
of early feedback from the Git Virtual Contributor Summit six months
ago, it's been nearly two months of active discussions including all
kinds of intrinsic and tangential points about the UI and design.  Why
try to prematurely widen the scope?  Can we just focus on merging
divergent branches for now, and cover the rest later?

> But that argument leads to "and the same something-like-sequencer
> that is all written in C would need '--rebase-merges' that can pick
> multi-step merge sequences, and single-step merge does not deserve a
> plumbing", which is an argument against this topic that is utterly
> absurd.
>
> So why isn't your objection not equally absurd against having a
> single step cherry-pick or revert primitive as a plumbing?

The objection you are arguing against is not my position.  In fact,
I'm not even objecting to having a single-step cherry-pick, I'm
objecting to providing it _now_, which I thought would have been clear
from the portion of my email you snipped ("...I'm happy to add [a
single step cherry-pick primitive] along with the tool I submit
later...").  Since that wasn't clear, and since that wasn't my only
communication failure here, let me attempt to be clearer about my
objection(s):

1. I'm really trying to pick off a small piece of the problem space
and get feedback on it without unnecessarily complicating things with
unrelated issues.  Thus, this series is _only_ about merging branches
that have diverged, and leaves commit replaying for later.

2. Two folks have chimed in about the single step cherry-pick, and the
ONLY reason given for wanting such a thing was to create a
rebasing/cherry-picking script which was driven by repeatedly invoking
this low-level primitive command.  That's also the only usecase I can
currently think of for such a primitive.  To me, that means providing
such a low-level command now would be likely to result in the
rebase-as-a-script mistake of yesteryear.  I think we can avoid that
pitfall by first providing a tool that avoids the
repeatedly-fork-git-subprocesses model.  (Also, providing a low-level
single-step cherry-pick command also has the added negative of further
distracting from the focus on merging divergent branches.)

3. The merge primitive in this series is useful completely independent
of any rebasing script (it would not be used solely for rebasing
merges, if it's used for that purpose at all, as evidenced by the fact
that dscho is already trying to use it for doing new real merges).

4. Once we have a git-replay tool that can replay a sequence of
commits, there _might_ not be a need for a single commit replaying
primitive.  If we provided one as you and Johannes Altimanninger were
asking for, and it turned out to be deemed useless because the later
tool I provide can do everything it can and more, haven't we just
wasted time in providing it?  And perhaps also wasted future time as
we then have work to do to deprecate and remove the new command or
mode? (NOTE: I did *not* say there was "no need" for a single-commit
replaying primitive -- I said there "might not" be a need.)

Also, since you bring up --rebase-merges, there's an additional point
about it that might be relevant:

5. While you could implement a naive --rebase-merges in terms of a
primitive for merging divergent branches (or vice-versa, i.e.
implement merging divergent branches from a naive --rebase-merges
implementation), I think replaying merges more intelligently[*] is
actually a distinct operation from doing a new merge of divergent
branches and that you probably can't implement one in terms of the
other.  (I'm not certain on this, and definitely don't want to argue
the finer points on it while my implementation is still half-baked,
but I really do think they are different things right now.)

[*] https://lore.kernel.org/git/CABPp-BHp+d62dCyAaJfh1cZ8xVpGyb97mZryd02aCOX=Qn=Ltw@mail.gmail.com/
