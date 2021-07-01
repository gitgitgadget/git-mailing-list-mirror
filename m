Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14DBC11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 15:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAADE61057
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 15:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbhGAPHE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 11:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbhGAPHD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 11:07:03 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81275C061762
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 08:04:31 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id m6-20020a9d1d060000b029044e2d8e855eso6791342otm.8
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 08:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3YQCrUlehkXL8+kgtHur6JuyHx98R2gOQC8IRzM/r+Y=;
        b=uyzafFcg0Lwjdf9DUcWrNeQFi1HMfA3g7faVJtbUDQE7M5LEAFMfR0147bv9xVBo56
         St3IJVBsfcXEh6TIi4TKL7Egv7wE7MZR52reW3tUEWlnauvewkDBfO1J2qTdPh67kUU1
         UDukxpJeVxmVBrf15SwqKS0IxGU3vGmX/PFDb0HhUszn6qQ0HwswccijfUlrDBwFBzX8
         8vCv8k1EiP/ra1WAlKJq7Ah7yjjLf9SF1mjSpFvcT93WFeFBYaAu3C0APyPPhlsvRQ9U
         GMtMUO1FO91XMnhHK9ifhED6spxyoePLD+Rl64UDQ6dXID3s9ux/30VluR2U5YfATD1D
         F4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3YQCrUlehkXL8+kgtHur6JuyHx98R2gOQC8IRzM/r+Y=;
        b=s3dIiTWNzYRqRC/VSkOvffOq3VrBH03efittuxgWaNQt9CzLpqadT1bbqgwbQ7a4YD
         THPIAoSxKNSda5pB8N6PTgSeubvMdfBXwV4P0CA+Neu+7oQDG47gKRemMfqM5FWoa2Qa
         HDa+GdGEhfr/bopwCrym05j7qQfbHoqSilWyr4DJpLayp7qiKNP997Ii+HjaKQWcGfZM
         CuRKP/+VP4LpvpcpTKxKDBrZXcPGk7ov7pUUMx8mv8jyiv/uupz/TT3lP41mfKtNBDX+
         R5Gv2cZSoQap23DF+TGo898eVaonB7D7SjiUu+0FKku7GNzDVI4ZQeLAnIcjYiXlS/9C
         F4FA==
X-Gm-Message-State: AOAM532APMrdOnpAzOQipyiCeiIex9GYHFHUr3wk3oc4kbc3uYWtxIOB
        QUzgZrCwkniVCssi2/8u3AaCt2kr8NsxPROHDqI=
X-Google-Smtp-Source: ABdhPJzNMX2r6GFb7DkQB1ADkQVgG11PSbvOxpfUwec7EOsgIRROFHGVxZgCtRxyzRHSUPBqxGWjbu1GB0IvPcTDKBY=
X-Received: by 2002:a9d:7c92:: with SMTP id q18mr347282otn.345.1625151870696;
 Thu, 01 Jul 2021 08:04:30 -0700 (PDT)
MIME-Version: 1.0
References: <pull.988.git.1625111177.gitgitgadget@gmail.com> <87wnqacg9i.fsf@evledraar.gmail.com>
In-Reply-To: <87wnqacg9i.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 1 Jul 2021 08:04:19 -0700
Message-ID: <CABPp-BGRgL-SnHDgefq887e51z9t_TMXcc4DLrazggC-1iQWng@mail.gmail.com>
Subject: Re: [PATCH 0/7] Optimization batch 14: trivial directory resolution
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 1, 2021 at 6:31 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> On Thu, Jul 01 2021, Elijah Newren via GitGitGadget wrote:
>
> > This series depends textually on ort-perf-batch-12, but is semantically
> > independent. (It is both semantically and textually independent of
> > ort-perf-batch-13.)
>
> For others following along, that ort-perf-batch-12 is at
> https://lore.kernel.org/git/pull.962.v4.git.1623168703.gitgitgadget@gmail=
.com/#t
> & currently marked as 'will merge to next' in what's cooking.
>
> > Most of my previous series dramatically accelerated cases with lots of
> > renames, while providing comparatively minor benefits for cases with fe=
w or
> > no renames. This series is the opposite; it provides huge benefits when
> > there are few or no renames, and comparatively smaller (though still qu=
ite
> > decent) benefits for cases with many uncached renames.
>
> Sounds good, one thing I haven't seen at a glance is how these
> performance numbers compare to the merge-recursive backend. Are we in a
> state of reaching parity with it, or pulling ahead?

Oh, wow, I really need to improve my wording if that's a question.
When I referred to "the performance results we started with" at the
end, that's referring to the numbers I got with merge-recursive before
I started this journey.  So these were the merge-recursive numbers
(with git-2.29.0 or git-2.30.0):

no-renames-am:      6.940 s =C2=B1  0.485 s
no-renames:        18.912 s =C2=B1  0.174 s
mega-renames:    5964.031 s =C2=B1 10.459 s
just-one-mega:    149.583 s =C2=B1  0.751 s

As per commit 557ac0350d ("merge-ort: begin performance work;
instrument with trace2_region_* calls", 2021-01-23), merge-ort was
faster than merge-recursive at the beginning.  But I wasn't content
with that....

Also in the cover letter, I showed the merge-ort numbers before and
after this series:

no-renames:        5.235 s =C2=B1  0.042 s   204.2  ms =C2=B1  3.0  ms
mega-renames:      9.419 s =C2=B1  0.107 s     1.076 s =C2=B1  0.015 s
just-one-mega:   480.1  ms =C2=B1  3.9  ms   364.1  ms =C2=B1  7.0  ms

So yeah, we've pulled a little ahead.  (Like my understatement there?)

Granted, merge-recursive doesn't take quite as long as it used to; it
also benefited from some of my optimizations[1].  Nowhere near as much
as merge-ort benefited, but it still would be about 20x faster on the
cases with "mega" in their name.  So, although today's merge-ort is
~5542.7x faster than git-2.29.0's merge-recursive for a massive set of
renames in a really long rebase sequence, it is probably only a mere
277x faster than today's merge-recursive on the same case.


If you'd like to catch up on the various optimizations, you can find
most of them with this:

git log --reverse --grep=3Dmega-renames --author=3Dnewren


[1] In particular, merge-recursive would benefit from these ones:
12bd17521c ("Merge branch 'en/diffcore-rename'", 2021-03-01),
d3a035b055 ("Merge branch 'en/merge-ort-perf'", 2021-02-11), and
a5ac31b5b1 ("Merge branch 'en/diffcore-rename'", 2021-01-25)

> > [...]
> > For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
> > performance work; instrument with trace2_region_* calls", 2020-10-28), =
the
> > changes in just this series improves the performance as follows:
> >
> >                      Before Series           After Series
> > no-renames:        5.235 s =C2=B1  0.042 s   204.2  ms =C2=B1  3.0  ms
> > mega-renames:      9.419 s =C2=B1  0.107 s     1.076 s =C2=B1  0.015 s
> > just-one-mega:   480.1  ms =C2=B1  3.9  ms   364.1  ms =C2=B1  7.0  ms
> >
> >
> > As a reminder, before any merge-ort/diffcore-rename performance work, t=
he
> > performance results we started with were:
> >
> > no-renames-am:      6.940 s =C2=B1  0.485 s
> > no-renames:        18.912 s =C2=B1  0.174 s
> > mega-renames:    5964.031 s =C2=B1 10.459 s
> > just-one-mega:    149.583 s =C2=B1  0.751 s
>
> I haven't given any of this a detailed look, just a note/question that
> (depending on the answer to the "v.s. merge-recursive above") we may
> want to consider bumping the default for the diff.renamelimit at some
> point along with any major optimizations.

I do think we should bump the diff.renamelimit, but not for these
reasons.  We should bump them for the same reasons we bumped them last
time at commit 92c57e5c1d ("bump rename limit defaults (again)",
2011-02-19).

In particular, none of my optimizations made the quadratic portion of
rename detection any faster.  It just added multiple ways for things
to either skip rename detection or be handled by a linear algorithm
instead and not be included in the quadratic loop.  Since
diff.renamelimit only applies to the stuff that goes into the
quadratic portion, most folks will notice that newer versions of git
detect renames with the same limits that older git would have given up
with.

It perhaps also is worth bearing that some of my rename detection
optimizations were specific to three-way merges (and thus help
merge/cherry-pick/rebase/etc. but not diff/log), some of my
optimizations were specific to reapplying long sequences of linear
commits (and thus help cherry-pick or rebase but not diff, log, or
even merge), while others help out all uses of the diff machinery
(diff/log/merge/cherry-pick/rebase/revert/etc.).

> <random musings follow, the tl;dr is above this line :)>
>
> As an aside that we have diff.renamelimit is one of the most "dangerous"
> landmines/fork-in-eye/shotgun-to-foot edge cases we have in using diff
> as plumbing IMO.
>
> E.g. I somewhat recently had to deal with some 3rd party Go-language
> lint plugin that can be configured to enforce lints "as of a commit".
> I.e. it does a diff from that commit, sees in any introduced "issues"
> are "new", and complains accordingly. The idea is that it allows you to
> enforce lints on "only new code", say ignoring the return value of
> os.Write(), without insisting that all existing code must be
> whitelisted/fixed first.
>
> The problem being two-fold, one that the thing will get slower over time
> as we grow history (can't be avoided), but the more subtle one that at
> some point we'll bump into the diff.renamelimit, and whatever unlucky
> sob does so will find that the lint is now complaining about ALL THE
> THINGS, since "old" code is now ending up as "new" to a na=C3=AFve diff
> parser relying on not bumping into the diff.renamelimit.
>
> Arguably bumping the diff.renamelimit would make that sort of problem
> worse for plumbing consumers, since they'd have more rope with which to
> hang themselves, maybe it's better to step on that landmine early.
>
> Sorry about the digression somewhat pointless but perhaps amusing
> digression in the last 4 paragraphs :)

Certainly a digression, but yes it's amusing.  :-)

Let me add a digression of my own: I got started on this because
people complained they couldn't cherry-pick patches to maintenance
branches, git just messed it all up when it gave up on renames.  I
told them to set diff.renameLimit higher, and they told me that didn't
work.

I didn't believe them.

So, I started on a bit of a journey, somewhere around commit
9f7e4bfa3b ("diff: remove silent clamp of renameLimit", 2017-11-13).
Then after that commit, git could detect renames but took forever
doing so (we needed a renameLimit of 48941 for the very first testcase
I was pointed at).  I dug into that, trying to figure out why
cherry-picking a simple patch that modified 7 files (and not with
particularly big edits) would take something approaching 10 minutes to
complete.  Then I went and found optimizations and rewrote the entire
merge machinery.  Now that same cherry-pick can complete without
bumping diff.renameLimit (1000 is more than enough), and completes in
less than a second (well, with all my optimizations, including the
series not yet submitted).

So, as I said, I didn't believe them when they reported git couldn't
detect renames for their case.  Look at all the work I've done in
order to continue to not believe them.  ;-)
