Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFE0C433DB
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 08:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9508164E7E
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 08:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhBHI1p (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 03:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhBHI1n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 03:27:43 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA15C06174A
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 00:27:02 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id y11so13449997otq.1
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 00:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6D2+QdcgY00/c8b9r8NgG181eUcRRlfUTYi3/8+hfCU=;
        b=lH/aOPGZPxQ2pM6kTry3oAUk0p+XW/tOqT1g2j9Q9p+EYSNtR0DKlJ32lx3iKBWGZX
         BwTv4zCCpPbHxwhD5JSEAqGoej2FsEM51+DGeie+w0ETE+6uwYV77A2+fFvsKGQZkKYr
         Klf6CIxUPNMlUjWegOeE+19rukzu0uFs26RQJ56u2HqqfL1issgMMOAlx3LBo+JzLSSY
         1Air35fML5lnw0iMg1kNw/X5PCxSyGWeN8/a00FkSc2ssAZ9juWnlAidhpxZvPB6b5mm
         eIdbyp1JpKXnROS/USoDSHzRFovzDbOvOkj3cgXiERdXIypgYsqGTvtJeCOdp22lA3jm
         N/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6D2+QdcgY00/c8b9r8NgG181eUcRRlfUTYi3/8+hfCU=;
        b=bxOVVjDZfew60HAMpuAj87lJLuHFUbmk9RS9HQk7sf7w3n93Pt2TVWerHWuV/Aupr1
         j+WOobk/+sfz5hYmothh82nKXxtC7GRXTAoQUdQPDRvvC5e4PF/JSkgL/bOOHVRQHYDA
         UsaFwS6s+XAC0AsRsmfluxaCpGWSHT1eKdrv/3vY9U+RvVqHSVaNHo87oSGY+TVZk2XS
         qB1M8nidAh7SCPu8y7OwvezJO8g/ghjQdPKuYzekba81XOo8E3HvsyjrLJzLMnoJj6Sq
         z2cDUdTB6qmeLxR8Rv08s+wFQs5Xf9Mf6qO+bGDxwb1hKkHzrnzg0VCqn4vWA2Fu8H/D
         Jzew==
X-Gm-Message-State: AOAM530QXlyqGpBFNY2ONMMuh8WdJ52Uq1g8wAt+aPo5rmzMdLDaWr0q
        poDGrst18/Px+4upT7tp/5AKgMFrvr1mfVteH6M=
X-Google-Smtp-Source: ABdhPJxrSH4i2X0u3oUZOzDOAwQMCjvI1NddaW7w7hAOFZ0ymGzzHRD4/h3O1/BwueV6iiZ3GOD4WS85gsxeBn8WqLU=
X-Received: by 2002:a9d:7dd3:: with SMTP id k19mr1451002otn.162.1612772822179;
 Mon, 08 Feb 2021 00:27:02 -0800 (PST)
MIME-Version: 1.0
References: <pull.843.git.1612651937.gitgitgadget@gmail.com>
 <1d941c35076e8d515c8ff7ef01d6b9d8c092aaa9.1612651937.git.gitgitgadget@gmail.com>
 <9fbed0f9-032e-3f99-8467-f8a9cfa2d8f1@gmail.com>
In-Reply-To: <9fbed0f9-032e-3f99-8467-f8a9cfa2d8f1@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 8 Feb 2021 00:27:00 -0800
Message-ID: <CABPp-BHPgUHFFzTd7suhqj=zEXQ61vxKU6X9gZvow5a=TLg3iw@mail.gmail.com>
Subject: Re: [PATCH 3/3] diffcore-rename: guide inexact rename detection based
 on basenames
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, Feb 7, 2021 at 6:38 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 2/6/21 5:52 PM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Make use of the new find_basename_matches() function added in the last
> > two patches, to find renames more rapidly in cases where we can match u=
p
> > files based on basenames.
>
> This is a valuable heuristic.
>
> > For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
> > performance work; instrument with trace2_region_* calls", 2020-10-28),
> > this change improves the performance as follows:
> >
> >                             Before                  After
> >     no-renames:       13.815 s =C2=B1  0.062 s    13.138 s =C2=B1  0.08=
6 s
> >     mega-renames:   1799.937 s =C2=B1  0.493 s   169.488 s =C2=B1  0.49=
4 s
> >     just-one-mega:    51.289 s =C2=B1  0.019 s     5.061 s =C2=B1  0.01=
7 s
>
> These numbers are very impressive.
>
> Before I get too deep into reviewing these patches, I do want
> to make it clear that the speed-up is coming at the cost of
> a behavior change. We are restricting the "best match" search
> to be first among files with common base name (although maybe
> I would use 'suffix'?). If we search for a rename among all
> additions and deletions ending the ".txt" we might find a
> similarity match that is 60% and declare that a rename, even
> if there is a ".txt" -> ".md" pair that has a 70% match.

I'm glad you all are open to possible behavioral changes, but I was
proposing a much smaller behavioral change that is quite different
than what you have suggested here.  Perhaps my wording was poor; I
apologize for forgetting that "basename" has different meanings in
different contexts.  Let me try again; I am not treating the filename
extension as special in any manner here; by "basename" I just mean the
portion of the path ignoring any leading directories.  Thus
    src/foo.txt
might be a good match against
    source/foo.txt
but this optimization as a preliminary step would not consider
matching src/foo.txt against any of
    source/bar.txt
    source/foo.md
since the basenames ('bar.txt' and 'foo.md') do not match our original
file's basename ('foo.txt').

Of course, if this preliminary optimization step fails to find another
"foo.txt" to match src/foo.txt against (or finds more than one and
thus doesn't compare against any of them), then the fallback inexact
rename detection matrix might match it against either of those two
latter paths, as it always has.

> This could be documented in a test case, to demonstrate that
> we are making this choice explicitly.
>
> For example, here is a test that passes now, but would
> start failing with your patches (if I understand them
> correctly):
>
> diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
> index c16486a9d41..e4c71fcf3be 100755
> --- a/t/t4001-diff-rename.sh
> +++ b/t/t4001-diff-rename.sh
> @@ -262,4 +262,21 @@ test_expect_success 'diff-tree -l0 defaults to a big=
 rename limit, not zero' '
>         grep "myotherfile.*myfile" actual
>  '
>
> +test_expect_success 'multiple similarity choices' '
> +       test_write_lines line1 line2 line3 line4 line5 \
> +                        line6 line7 line8 line9 line10 >delete.txt &&
> +       git add delete.txt &&
> +       git commit -m "base txt" &&
> +
> +       rm delete.txt &&
> +       test_write_lines line1 line2 line3 line4 line5 \
> +                         line6 line7 line8 >add.txt &&
> +       test_write_lines line1 line2 line3 line4 line5 \
> +                         line6 line7 line8 line9 >add.md &&
> +       git add add.txt add.md &&
> +       git commit -a -m "rename" &&
> +       git diff-tree -M HEAD HEAD^ >actual &&
> +       grep "add.md    delete.txt" actual
> +'
> +
>  test_done
>
> Personally, I'm fine with making this assumption. All of
> our renames are based on heuristics, so any opportunity
> to reduce the number of content comparisons is a win in
> my mind. We also don't report a rename unless there _is_
> an add/delete pair that is sufficiently close in content.
>
> So, in this way, we are changing the optimization function
> that is used to determine the "best" rename available. It
> might be good to update documentation for how we choose
> renames:

Seems reasonable; I'll add some commentary below on the rules...

>
>   An add/delete pair is marked as a rename based on the
>   following similarity function:
>

0. Unless break detection is on, files with the same fullname are
considered the same file even if their content is completely
different.  (With break detection turned on, we can have e.g. both
src/foo.txt -> src/bar.txt and otherdir/baz.txt -> src/foo.txt, i.e.
src/foo.txt can be both a source and a destination of a rename.)

[The merge machinery never turns break detection on, but
diffcore-rename is used by git diff, git log, etc. too, so if we're
documenting the rules we should cover all the cases.]

>   1. If the blob content is identical, then those files
>      are marked as a rename. (Should we break ties here
>      based on the basename?)

find_identical_files() already breaks ties based on basename_same(),
yes.  So there's another area of the code that uses basenames to guide
rename detection already, just in a much more limited fashion.

>   2. Among pairs whose content matches the minimum
>      similarity limit, we optimize for:
>
>      i. among files with the same basename (trailer
>         after final '.') select pairs with highest
>         similarity.

This is an interesting idea, but is not what I implemented.  It is
possible that your suggestion is also a useful optimization; it'd be
hard to know without trying.  However, as noted in optimization batch
8 that I'll be submitting later, I'm worried about having any
optimization pre-steps doing more than O(1) comparisons per path (and
here you suggest comparing each .txt file with all other .txt files);
doing that can interact badly with optimization batch 9.
Additionally, unless we do something to avoid re-comparing files again
when doing the later all-unmatched-files-against-each-other check,
then worst case behavior can approach twice as slow as the original
code.

Anyway, the explanation I'd use for the optimization I've added in
this series is:

       i. if looking through the two sets (of add pairs, and of delete
pairs), there is exactly one file with the same basename from each
set, and they have the minimum similarity, then mark them as a rename

Optimization batch 8 will extend this particular rule.

Optimization batches 9 and 10 will optimize the rename detection more,
but instead of using rule changes, will instead pass in a list of
"irrelevant" sources that can be skipped.  The trick is in determining
source files that are irrelevant and why.  I'm not sure if we want to
also mention in the rules that different areas of the code (the merge
machinery, log --follow, etc.) can make the rename detection focus
just on some "relevant" subset of files.  (Which will also touch on
optimization batch 12.)

>     ii. if no files with the same basename have the
>         minimum similarity, then select pairs with
>         highest similarity across all filenames.

Yes, this will remain as the fallback at the very end.

> The above was written quickly as an attempt, so it will
> require careful editing to actually make sense to end
> users.

Yeah, and we probably also need to mention copy detection above
somehow too, and add more precise wording about how break detection is
involved.
