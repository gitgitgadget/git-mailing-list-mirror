Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08037C433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 00:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8A5A61184
	for <git@archiver.kernel.org>; Thu, 20 May 2021 00:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhETAiA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 20:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhETAh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 20:37:59 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD85C061574
        for <git@vger.kernel.org>; Wed, 19 May 2021 17:36:38 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id c3so14802729oic.8
        for <git@vger.kernel.org>; Wed, 19 May 2021 17:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ydo+v0iyhzLc24fCNCAvc7+la1rLI4QHwHSQCp4fprI=;
        b=NMh7AyHH6iLVN+WQ0EqaARfljorFnhxKHuV/P1SLiSpd/PIZrCFrOu88MZjY8jBmLT
         04I+l7W0d0TuFydVA+W0AlrN11cL0WtYaddoMJd827Qo0+KeUinIU6/C2kWporU2rBn5
         kwB63gImmSyNp6DihUSpjpK+hU358/5HQRDtKrynIeyBWBZQz/0DOXTsdUYZf+eC9aw1
         iPdq0GOIiXk+CqGO8bRbzibFqpek2fnsgxNWWefoUX7vBsjbRtFN/ENCFxdMInJfZuep
         a2YIpRzriTvNdIzgoMUzWLhdjX6RY2fXwk2c74q7p3Wk1mADSsXwi+dikspz4TwfH3SA
         511A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ydo+v0iyhzLc24fCNCAvc7+la1rLI4QHwHSQCp4fprI=;
        b=QN/iwzsMjOF7C8lZ+vI3j8qmfGzaFbzHgL41CXRWpWC9Vss0dOhwlcIJxUtH+Q0N7b
         DyQ/alUVgs6X5hEeMCvdwERX+da4e3QuoAt3HMqGcWLtE6bDexiu0kckeO6DC3c1xAMq
         nJCYkjpnoztP79zSU3dRiED+PfKSk1NGYdZbeiBSSOhObQsKcXDnjHvXdGFRo+6jNP6U
         o6M5qZbl24SzLYlzOxbQv1JFiQC8nw5pvxzRLt04iatRcsz5zkqJp5VnXFNzOISAwg9s
         IgKMUEsX1AhCsCiaekUogvqQYBdMFekGxTjQ+RHPFJHKWlXAoRMYSKkQzWlGHxujY3Q4
         cUYw==
X-Gm-Message-State: AOAM5301k7IXlSdpd2XsIwsNbhA2PNPAu0JShEt3J7T3XRmYUALs4+Fa
        Qr0XZgW5CANLqEltyVAkoSiXvm6A2iSaU6HKCOY36m/O4gM=
X-Google-Smtp-Source: ABdhPJyvrD5gWAXDRxai32WRIeUFfbp8U6GkDXInHiWsQntA2gWgYKZszAMp2bwt9nBUiY/s+qbU7He1jY2oL/M1MkA=
X-Received: by 2002:a05:6808:13d5:: with SMTP id d21mr1395005oiw.31.1621470997306;
 Wed, 19 May 2021 17:36:37 -0700 (PDT)
MIME-Version: 1.0
References: <pull.859.git.1616621553.gitgitgadget@gmail.com>
 <pull.859.v2.git.1620094339.gitgitgadget@gmail.com> <91b6768adf2d1777219fb2d83cc2363f1497dbbd.1620094339.git.gitgitgadget@gmail.com>
 <f0c50259-5627-482b-1daf-b73819cde108@gmail.com>
In-Reply-To: <f0c50259-5627-482b-1daf-b73819cde108@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 19 May 2021 17:36:26 -0700
Message-ID: <CABPp-BFdxn9f0-jUjY6Ake_6kX-jeN1EEzpeJeTg+TV4wfepwg@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] merge-ort, diffcore-rename: employ cached
 renames when possible
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 17, 2021 at 7:23 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 5/3/21 10:12 PM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> ...
> > diff --git a/merge-ort.c b/merge-ort.c
> > index 2fc98b803d1c..17dc3deb3c73 100644
> > --- a/merge-ort.c
> > +++ b/merge-ort.c
> > @@ -753,15 +753,48 @@ static void add_pair(struct merge_options *opt,
> >       struct rename_info *renames = &opt->priv->renames;
> >       int names_idx = is_add ? side : 0;
> >
> > -     if (!is_add) {
> > +     if (is_add) {
> > +             if (strset_contains(&renames->cached_target_names[side],
> > +                                 pathname))
> > +                     return;
> > +     } else {
> >               unsigned content_relevant = (match_mask == 0);
> >               unsigned location_relevant = (dir_rename_mask == 0x07);
> >
> > +             /*
> > +              * If pathname is found in cached_irrelevant[side] due to
> > +              * previous pick but for this commit content is relevant,
> > +              * then we need to remove it from cached_irrelevant.
> > +              */
> > +             if (content_relevant)
> > +                     /* strset_remove is no-op if strset doesn't have key */
> > +                     strset_remove(&renames->cached_irrelevant[side],
> > +                                   pathname);
>
> I see, content can become relevant again.
>
> ...
>
> > diff --git a/t/t6429-merge-sequence-rename-caching.sh b/t/t6429-merge-sequence-rename-caching.sh
> > index f47d8924ee73..035edc40b1eb 100755
> > --- a/t/t6429-merge-sequence-rename-caching.sh
> > +++ b/t/t6429-merge-sequence-rename-caching.sh
> > @@ -101,10 +101,10 @@ test_expect_success 'caching renames does not preclude finding new ones' '
> >  # dramatic change in size of the file, but remembering the rename and
> >  # reusing it is reasonable too.
> >  #
> > -# Rename detection (diffcore_rename_extended()) will run twice here; it is
> > -# not needed on the topic side of history for either of the two commits
> > -# being merged, but it is needed on the upstream side of history for each
> > -# commit being picked.
> > +# We do test here that we expect rename detection to only be run once total
> > +# (the topic side of history doesn't need renames, and with caching we
> > +# should be able to only run rename detection on the upstream side one
> > +# time.)
> >  test_expect_success 'cherry-pick both a commit and its immediate revert' '
> >       test_create_repo pick-commit-and-its-immediate-revert &&
> >       (
> > @@ -140,11 +140,11 @@ test_expect_success 'cherry-pick both a commit and its immediate revert' '
> >               GIT_TRACE2_PERF="$(pwd)/trace.output" &&
> >               export GIT_TRACE2_PERF &&
> >
> > -             test_might_fail test-tool fast-rebase --onto HEAD upstream~1 topic &&
> > +             test-tool fast-rebase --onto HEAD upstream~1 topic &&
>
> Here is a change of behavior, but it appears to be a good one!
>
> >               #git cherry-pick upstream~1..topic &&
> >
> >               grep region_enter.*diffcore_rename trace.output >calls &&
> > -             test_line_count = 2 calls
> > +             test_line_count = 1 calls
> >       )
> ...
> > @@ -450,7 +459,7 @@ test_expect_success 'dir rename unneeded, then add new file to old dir' '
> >               #git cherry-pick upstream..topic &&
> >
> >               grep region_enter.*diffcore_rename trace.output >calls &&
> > -             test_line_count = 3 calls &&
> > +             test_line_count = 2 calls &&
> >
> >               git ls-files >tracked &&
> >               test_line_count = 5 tracked &&
> > @@ -516,7 +525,7 @@ test_expect_success 'dir rename unneeded, then rename existing file into old dir
> >               #git cherry-pick upstream..topic &&
> >
> >               grep region_enter.*diffcore_rename trace.output >calls &&
> > -             test_line_count = 4 calls &&
> > +             test_line_count = 3 calls &&
>
> I appreciate that this use of tracing demonstrates a change of
> internal behavior.
>
> >               test_path_is_missing somefile &&
> >               test_path_is_missing olddir/newfile &&
> > @@ -648,9 +657,8 @@ test_expect_success 'caching renames only on upstream side, part 1' '
> >  # for the wrong side of history.
> >  #
> >  #
> > -# This testcase should only need three calls to diffcore_rename_extended(),
> > -# because there are no renames on the topic side of history for picking
> > -# Topic_2.
> > +# This testcase should only need two calls to diffcore_rename_extended(),
> > +# both for the first merge, one for each side of history.
> >  #
> >  test_expect_success 'caching renames only on upstream side, part 2' '
> >       test_setup_topic_rename cache-renames-only-upstream-rename-file &&
> > @@ -677,7 +685,7 @@ test_expect_success 'caching renames only on upstream side, part 2' '
> >               #git cherry-pick upstream..topic &&
> >
> >               grep region_enter.*diffcore_rename trace.output >calls &&
> > -             test_line_count = 3 calls &&
> > +             test_line_count = 2 calls &&
>
> Same here.
>
> As I was reading, I was also thinking that it would be good to
> have some kind of tracing, if only a summary of how often we
> relied upon the cached renames.

That's an interesting thought.  If there are renames that remain
cached, the code always uses them (whether we need the cached rename
or not doesn't matter since we already have it and it is cheap to
use), so a summary would probably be the only thing that would make
sense.

The easiest summary of how often we rely upon cached renames, is
checking if we have enough to avoid calling diffcore_rename_extended()
entirely.  That's precisely what the code above does that you are
responding to.

What more information could we get out?  I guess we could get ever so
slightly more information by tracking how many times we decide that
the cache from a previous merge can be re-used (by tracking the number
of times that cached_valid_side is set to 1 or 2 instead of 0).  Since
we sometimes have some cached renames but not enough to skip rename
detection (because source paths that were irrelevant in previous
commits are marked relevant for the current commit), this would be an
independent number from the region_enter-diffcore_rename count used
above.

> That would present a mechanism
> for the test cases to verify that the rename cache is behaving
> as expected

How so?  I did check something like that above with verifying I was
able to reduce the number of calls to diffcore_rename_extended() while
still getting the expected result (which can only be done if renames
are known).  The only additional thing I can think of we could check
would be a testcase where renames are cached and can be re-used but
it's not enough to avoid calling diffcore_rename_extended().  Did you
have something else in mind?

> but also provides a way to diagnose any issues that
> might arise in the future by asking a user to reproduce a
> problematic rebase/merge with a GIT_TRACE2* target. Such a
> change would fit as a follow-up, and does not need to insert
> into an already heavy patch.

I'm not sure what information could be recorded that would help
diagnose any such issues.  "9 out of 10 commits in your rebase reused
cached renames" just doesn't seem granular enough to help.  Is there
something else you were thinking of recording?


> I have now read all of the patches in this series to the level
> I can. It's all very deep stuff, so the more we can rely on the
> tests to show correctness, the better.
>
> I appreciate the extra tests that you added, which increases my
> confidence in the series.
>
> Thanks,
> -Stolee
