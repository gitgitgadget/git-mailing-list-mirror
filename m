Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB1BC07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 17:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8AC060FED
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 17:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbhGTQcs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 12:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbhGTQaf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 12:30:35 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2294C061766
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 10:11:09 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id h9so25275357oih.4
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 10:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hDVH+DHJVWjirRPkXSd++shjuE1SLQpGeGPaBIHAr3k=;
        b=UtielEWRMFYfrpbHj3cQdzsS+n9wEyxBDoXPo5zdJ/YccUfjsi8fDe7vBo11tYX9TP
         VyMk3rzcvXMcsjYdf1ToG7WUhypwRQEs8YAYA/B32Td2OYgvc43tCNOFcse5E7o6/uCJ
         LcNO1VRpY4WouEXkQoprYqJpBynRU75sfQgL1DU2fTOgvzN3OFNsFFp0x4pT/xZUprzh
         uBP4REbyP2YxAzj1+bpQi+5mvGCWWOfV4n9fxHuWnjInXJ9qzSMcxWdSLDgzBj5+eskz
         fsB4IMj6SZ5dxGRUcVR5Op4P7XZFeF7xmlIE0eGJl3es8fCQrF8tqfcj+5Se5nKAcjht
         NIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hDVH+DHJVWjirRPkXSd++shjuE1SLQpGeGPaBIHAr3k=;
        b=NJzKRXYl7iCXadOP8RTNmZRZmtSrsYhWWPPZ/TLFz9M4hGCrZvpPWlhdMxgkI7G+bW
         r3VelneonIoLtm37X/hc80kWwdNllzxtFdV/7QrHFW2KFPC1Yhb2Gkvc5G5Ef1vJSP4u
         gBgPYquCsabpnCyChs8idw+bkV8yXCFTL2k90FuJdzZTRwIdjx4JLI0Kez5QA6P7UUgY
         gie186xSrJtoOV0h1OXFMp/lZDWVbUophTQcAq8fiZ6K+xGESKEo1s1DsaLYO+ncPNo6
         hiOpi9BwcTwZyNckEp5TzkdtY5PyDLKEqhlYT9Um2ESVuVriLDKGoh0Ts9zdRif2rGCS
         LCjA==
X-Gm-Message-State: AOAM530dYKS2yvPTTAI2txMHBG9RAP5tcSFaneTu6DUca8IByNKBPjeA
        QNtLYQWeHFD4Qe9H8oAg+ThYgL3pWl6Ez8tAvD4=
X-Google-Smtp-Source: ABdhPJyXWZjPQqnyCT4czC0i/LsdgBM5qs4KqWcBxea7cxpXUe4VaWS7Af/aNJnEqg7qJMA53YvlWDUHCzGyWLKd3Jc=
X-Received: by 2002:aca:acc5:: with SMTP id v188mr25608514oie.167.1626801069172;
 Tue, 20 Jul 2021 10:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
 <6cb771297f5f7d5bb0c6734bcb3fe6d3b8bb4c88.1626536508.git.gitgitgadget@gmail.com>
 <xmqq35samac9.fsf@gitster.g>
In-Reply-To: <xmqq35samac9.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 20 Jul 2021 10:10:58 -0700
Message-ID: <CABPp-BFMHhxgaLnA+gLHJENVfzVv6j2Ax4G6y+XsrU3wBJq6rQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] t7601: add relative precedence tests for merge and
 rebase flags/options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 19, 2021 at 11:23 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +test_does_rebase() {
>
> Style: missing SP before ().

Will fix.

...
> > +test_does_merge_noff() {
> > +     git reset --hard c0 &&
> > +     git "$@" . c1 &&
> > +     # Check that we actually did a merge
> > +     git rev-list --count HEAD >actual &&
> > +     git rev-list --merges --count HEAD >>actual &&
> > +     test_write_lines 3 1 >expect &&
> > +     test_cmp expect actual &&
> > +     rm actual expect
> > +}
> > +
> > +test_does_merge_ff() {
> > +     git reset --hard c0 &&
> > +     git "$@" . c1 &&
> > +     # Check that we actually did a merge
> > +     git rev-list --count HEAD >actual &&
> > +     git rev-list --merges --count HEAD >>actual &&
> > +     test_write_lines 2 0 >expect &&
> > +     test_cmp expect actual &&
> > +     rm actual expect
> > +}
> > +
> > +test_does_need_full_merge() {
> > +     git reset --hard c2 &&
> > +     git "$@" . c1 &&
> > +     # Check that we actually did a merge
> > +     git rev-list --count HEAD >actual &&
> > +     git rev-list --merges --count HEAD >>actual &&
> > +     test_write_lines 4 1 >expect &&
> > +     test_cmp expect actual &&
> > +     rm actual expect
> > +}
> > +
> > +test_attempts_fast_forward() {
> > +     git reset --hard c2 &&
> > +     test_must_fail git "$@" . c1 2>err &&
> > +     test_i18ngrep "Not possible to fast-forward, aborting" err
> > +}
>
> The same reasoning says these test_does_X helpers make sense.  I am
> not sure about the name does_need_full_merge though---what does it
> want to ensure is not very clear to me.  Is it named that way because
> you found "test_does_merge" (when contrasted to "test_does_merge_ff")
> sounds too weak?

I should probably rename the functions for clarity; I'm testing the
matrix of ff/noff possibilities:

# Prefers merge over fast-forward; rename from test_does_merge
test_does_merge_when_ff_possible ()

# Prefers fast-forward over merge; rename from test_does_merge_ff
test_does_fast_forward ()

# Attempts fast forward and bails since it is impossible
test_attempts_fast_forward ()

# Does a merge when a fast forward is not possible
test_falls_back_to_full_merge ()


In particular, `test_does_need_full_merge` would become
`test_falls_back_to_full_merge`


> > +#
> > +# Rule 1: --ff-only takes precedence over --[no-]rebase
> > +# (Corollary: pull.ff=only overrides pull.rebase)
> > +#
> > +test_expect_failure '--ff-only takes precedence over --rebase' '
> > +     test_attempts_fast_forward pull --rebase --ff-only
> > +'
> > +
> > +test_expect_failure '--ff-only takes precedence over --rebase even if first' '
> > +     test_attempts_fast_forward pull --ff-only --rebase
> > +'
> > +
> > +test_expect_success '--ff-only takes precedence over --no-rebase' '
> > +     test_attempts_fast_forward pull --ff-only --no-rebase
> > +'
> > +
> > +test_expect_failure 'pull.ff=only overrides pull.rebase=true' '
> > +     test_attempts_fast_forward -c pull.ff=only -c pull.rebase=true pull
> > +'
> > +
> > +test_expect_success 'pull.ff=only overrides pull.rebase=false' '
> > +     test_attempts_fast_forward -c pull.ff=only -c pull.rebase=false pull
> > +'
>
> OK.  These all ensure that when the history does not fast-forward,
> the command will fail when --ff-only tells us to allow only
> fast-forward.  I am not sure "takes precedence" is a meaningful
> label, though.  It is more like "ff-only means ff-only and fails
> when the upstream history is not a descendant, no matter how the
> possible integration is set to be performed".

So, I think you're saying you view fast-forwards as a subset of valid
rebases (and fast-forwards are also a subset of valid rmerges), and
thus you view --ff-only --rebase as an instruction to only proceed if
both command line flags can be satisfied.

That makes sense, but I don't know how to put that into a test
description that isn't ridiculously long.  I tried replacing "takes
precedence over" with just "overrides" but you might not like that
either.  If you've got better wording for the comments before each
group and the test descriptions, I'm all ears.  Otherwise I'll just
take my best stab at it.

> > +# Rule 2: --rebase=[!false] takes precedence over --no-ff and --ff
> > +# (Corollary: pull.rebase=!false overrides pull.ff=!only)
> > +test_expect_success '--rebase takes precedence over --no-ff' '
> > +     test_does_rebase pull --rebase --no-ff
> > +'
> > +
> > +test_expect_success '--rebase takes precedence over --ff' '
> > +     test_does_rebase pull --rebase --ff
> > +'
> > +
> > +test_expect_success 'pull.rebase=true takes precedence over pull.ff=false' '
> > +     test_does_rebase -c pull.rebase=true -c pull.ff=false pull
> > +'
> > +
> > +test_expect_success 'pull.rebase=true takes precedence over pull.ff=true' '
> > +     test_does_rebase -c pull.rebase=true -c pull.ff=true pull
> > +'
>
> Sounds sensible.  Again, I do not view this as precedence, though.
> "--ff" is merely "if there is nothing else needs to be done, it is
> OK to fast-forward to their history", so with --rebase, it either
> (1) gets ignored when we have something to be done, i.e. our own
> development to replay on top of their history, or (2) becomes a
> no-op as there truly isn't any development of our own.
>
> And "--no-ff" is more or less a meaningless thing to say ("I do not
> want to just fast-forward when I do not have anything meaningful to
> add, I want an empty merge commit to mark where I was") in the
> context of "--rebase".  Erroring out only when their histroy is
> descendant of ours and "--no-ff" and "--rebase=<set>" are given
> explicitly from the command line might make sense, but I do not
> think of a sensible corrective action the end-user wants to do after
> seeing such an error (after all, there was nothing to rebase on top
> of their history), so I think ignoring is a more acceptable outcome
> when we have nothing to replay.
>
> Do we ensure that "pull --rebase --ff" fast-forwards when the
> history truly fast-forwards?  test_does_rebase only and always
> checks what happens when pulling c1 into c2 and nothing else, so I
> do not think the above are testing that case.
>
> IOW, I think "test_does_merge_ff pull --rebase --ff" wants to be
> there somewhere?

Sounds good; I added "--rebase --ff fast-forwards when possible" test.

...
> > +test_expect_success '--rebase takes precedence over pull.ff=true' '
> > +     test_does_rebase -c pull.ff=true pull --rebase
> > +'
> > +
> > +test_expect_success '--rebase takes precedence over pull.ff=false' '
> > +     test_does_rebase -c pull.ff=false pull --rebase
> > +'
> > +
> > +test_expect_success '--rebase takes precedence over pull.ff unset' '
> > +     test_does_rebase pull --rebase
> > +'
>
> These three are correct but again I do not see them as precedence
> matter.
>
...
>
> > +test_expect_success 'pull.rebase=true takes precedence over --ff' '
> > +     test_does_rebase -c pull.rebase=true pull --ff
> > +'
>
> Again, I am not sure if this is "precedence" issue.  "ff" merely
> means "fast-forwarding is allowed, when we do not have anything to
> add to their history", and we do have our own work in the test
> scenario test_does_rebase presents us, so rebasing would be quite
> sensible.  Similarly
>
>     test_does_need_full_merge -c pull.rebase=false pull --ff
>
> would be true, right?

Yep, I added that test since you thought to ask to make sure it's covered.

> > +# End of precedence rules
> > +
> >  test_expect_success 'merge c1 with c2' '
> >       git reset --hard c1 &&
> >       test -f c0.c &&
>
> The series of new tests makes me wonder if there is a good way to
> ensure we covered full matrix, but I didn't see any that smelled
> wrong.

Fair question.  I covered all the ones in
https://lore.kernel.org/git/xmqqwnpqot4m.fsf@gitster.g/, except that
when '*' was given, I might have just picked a representative example
rather than all possible options.  I also just used --rebase as a
proxy for any --rebase=* option other than --rebase=false.  Of course,
that table may have been incomplete but it at least covered the ones I
could think of.
