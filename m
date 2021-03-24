Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3B0C433C1
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 23:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5435461A16
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 23:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbhCXX0P (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 19:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbhCXX0B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 19:26:01 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD301C06174A
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 16:26:00 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id s11-20020a056830124bb029021bb3524ebeso269960otp.0
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 16:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zyMUJ8NQ57UqMjzkZyGdSrzmFOaJaUvF2KoDm60Ymtw=;
        b=MXy4uADxrNsDkRsa8zAuujTE2tRycFjo5qhBvbMXGP0N7iTKR5MzE9ATTYYqmU/TR+
         ljaS0JlaZrnwzy4/F9RHl71Qu/4lB2eV+AV+o58399C6RgvDF3hiWmKgv/Rwc+a+FZQ0
         Up+vJefy11m7PN0vheAekiXUV3iL4uh5mXa9M1wVZKZIx78mVmCnoEN/hJJWuvytLPPP
         TaJSYey4BpE1kBtKZJe/qWgUDuira9Zf1umAv2s9W3F5VRLpbUv9yS+k3Jd4oVBKsG3T
         tYy/qfsMX1gR+QNkAniF5ZvIGojh7lYrYT0dsyTNKmqu0cIzSh24f1kB3iIup+hyc0eF
         oVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zyMUJ8NQ57UqMjzkZyGdSrzmFOaJaUvF2KoDm60Ymtw=;
        b=iPRPRfuBiqgAcvLUcs1ooI+7XDiJ5Y5+id4eSKVSRMpTwU2jd20Klb1qGeCtp6rxZ+
         v4nVbh09NYBuEx6hn1PhNqsE7+6rMxF0kcCIEme4mDyj8fvvDbOM2EAJ4yoxZIMlUdmZ
         YXv0nzJGLX4qJGAw5qpRlE3mdXt7YvSfhjPMaOvw3dxTg0kiTJT1YqwuoWhHAXj3gTRQ
         n8KC6eraxogMfHwT6ETq+9sxryxroeERrznz/UZpG8HI27oV7PEV3H4/KE5BDDPr2U0o
         k+Ewg0yrkUyYSM8+vXgkyVsF9WSbKioXVG0Se2HTanbT56QggUka+E3NB4z2kG4Ds4T0
         gfnA==
X-Gm-Message-State: AOAM5329x1kbWkpmwz8WuOncRcFaWx0sEMAODkZUI0mIXoDkW38/+km6
        lDAyAxc5p57HKB/MUsu5XznCN9QXQcmW2iU1iSY=
X-Google-Smtp-Source: ABdhPJwmQKB5JcO7m6RaSHkVHlr1IodbolKvIKM1vu2KNZ/J8PSaT0O2vtDUDy23ihDVRLfllCDZcY0m5bkzeaT3M3k=
X-Received: by 2002:a9d:8d5:: with SMTP id 79mr5129807otf.345.1616628360209;
 Wed, 24 Mar 2021 16:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <pull.859.git.1616621553.gitgitgadget@gmail.com> <xmqqv99gw6n3.fsf@gitster.g>
In-Reply-To: <xmqqv99gw6n3.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 24 Mar 2021 16:25:48 -0700
Message-ID: <CABPp-BGMhyn1ricXzx539n-09+BYRHPeruNd4MG2PyQzWaRKow@mail.gmail.com>
Subject: Re: [PATCH 0/7] Optimization batch 11: avoid repeatedly detecting
 same renames
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 24, 2021 at 3:04 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > === Basic Optimization idea ===
> >
> > This series avoids repeatedly detecting the same renames in a sequence of
> > merges such as a rebase or cherry-pick of several commits. When there are
> > many renames between the old base and the new base, traditionally all those
> > renames are re-detected for every commit that is transplanted. This
> > optimization avoids redoing that work.
>
> Unless this section is easily understandable, the readers have no
> incentive to read on, but the above is a bit too hand wavy.

Oh, yeah, it's very hand wavy.  I figured the commit messages were the
right place to include the details, and just wanted to give a flavor
of the idea in the cover letter.

> > This one adds a fourth (remember-renames), with some interesting properties:
> >
> >  * unlike basename-guided rename detection, there are no behavioral changes
> >    (there is no heuristic involved)[2].
> >
> >  * like skip-because-irrelevant, this optimization does not apply to all git
> >    commands using the rename machinery. In fact, this one is even more
> >    restrictive since it is ONLY useful for rebases and cherry-picks (not
> >    even merges), and only for second and later commits in a linear series.
>
> So, is it correct to understand that one case this would help is
> this scenario?
>
>  ---o---o---o---X---o---o---o---O ours
>      \
>       A---B---C topic
>
> where there is a side branch A--B--C that touched some files, while
> on our side, there is a commit X that is unknown to the side branch
> that renamed these files.  Now we want to transplant the side topic
> to the tip of our history, replaying the changes A--B--C made to
> these files under their original name to the corresponding files
> that have been renamed.
>
> And each step in this "rebase" is a 3-way merge of commits A, B and
> C onto HEAD, using the parent of the commit being cherrk-picked as a
> virtual common ancestor.  Which means

You generated nearly the same description and diagram I used in the
commit message (the one in 3/7) describing this.  :-)

>  - To transplant A (i.e. the first step), we'd compare the diff of
>    A^..O (i.e. what our side did, including the renames done at X)
>    and diff of A^..A (i.e. what the first commit did in the range),
>    and the former does quite a lot of rename detection.
>
>  - After transplanting B (i.e. the second step), then we'd compare
>    the diff of A^..A' (where A' is A cherry-picked on O, i.e. the

Close, but for transplanting B we do the diff of B^..A', not A^...A'.
(And in this diagram, B^ is A.)  That's critical below...

>    result of the previous step).  If we are lucky, O..A' did not
>    rename anything so the renames done in A^..O (i.e. what we
>    detected during the first step) and A^..A' (i.e. what we should
>    be computing for this second step) should be quite similar.

Again, B^..A' rather than A^..A'.

Luck is not involved here.  If O..A' did rename anything, it's one of
two reasons:

- There were conflicts when trying to transplant A, and when we stop
for conflict resolution, the user added some renames at that point.
- There were renames in A^..A.

In the first case, the presence of conflicts means we drop the cache
and this optimization doesn't try to kick in.  In the second case,
those renames in A' came from A.  Even without this optimization,
since those renames in A' came from A, doing rename detection on A..A'
wouldn't re-detect them and transplanting wouldn't try to reapply
them, so they just aren't relevant anymore -- with or without this
optimization.

>    If we assume that the "quite similar" is good enough, then we can
>    blindly reuse the record of "<path in A^> correspnds to <path in
>    O>" as if it were "<path in A^> corresponds to <path in A'>".

Again, B^ rather than A^ on the last line.

I disagree with the use of the term "blindly" here.  As spelled out in
the third commit message, the transplant of A involved a three-way
content merge of the form:
    A^:oldfile
    O:newfile
    A:oldfile
and produce a new result:
    A':newfile

The point of rename detection is to determine what files are similar
enough to use in a three-way content merge.  In particular, we'd use
rename detection when transplanting B to notice the oldfile -> newfile
rename so that we can do a three-way content merge of the form:
    A:oldfile
    A':newfile
    B:oldfile
and produce a new result:
    B':newfile

But, instead of asking rename detection whether A:oldfile and
A':newfile are similar enough to use together in a three-way content
merge, we could ask ourselves -- do we have any _other_ reason to
believe these files are similar enough to be used in a three-way
content merge?  And the answer that comes back is: these files were
*already* involved in the same three-way content merge -- the one that
A':newfile came from.  It was a three-way content merge with no
conflicts.  (Because when conflicts are triggered we turn this
optimization off.)

>  - Do the same for C, pretending that renames discovered between A^
>    and O is identical to the renames between A^ and B' (i.e. the
>    result of cherry-picking A--B on top of O).

Now you've changed your off-by-one mistake to an off-by-two mistake;
the rename detection is between C^ and B', not A^ and B'.  I think
this error might be critical to why you used terms like "pretend" and
"blindly" and "lucky".  I agree that it would require
luck/blindness/pretending to assume that the renames between A^ and O
are identical to those between A^ and B', but that's not what the
original algorithm would have been using for computing renames; it
would be using C^ and B'.

It's actually quite difficult to generate a case where this
optimization gets a possibly different result.  It requires there were
changes to the content on both sides of history that merge cleanly,
and in particular that need a significant size reduction of the file
by the unrenamed side of history.  If you take the changes on the
*renamed* side of history, which represent <50% changes since it was
detected as a rename, those same changes need to represent a >50%
change when applied to the smaller file.  This is discussed in the
third commit message, as noted in the cover letter:

>> [2] Well, almost no changes. There's technically a very narrow way that this
>> could change the behavior; see the really long "Technically," bullet point
>> in patch 3 for discussion of this.
