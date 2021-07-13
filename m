Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEAAC07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 17:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C5A16128E
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 17:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhGMRk0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 13:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhGMRk0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 13:40:26 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B91C0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 10:37:35 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 75-20020a9d08510000b02904acfe6bcccaso23285226oty.12
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 10:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w76wJ5l+Lxy6u8/boXMIhvSmKSqPJWBYy8Jl0GZV+PI=;
        b=Fol5m1rlt8l7lHqz7J+GFvMfGvFMkTVH8astNsERhVgU5zpoSmQaf+VmRNVDwEswpJ
         5l/Ptiu/sUqHsnDhDtv4JcfQ1/t127oSe3uXwbr8wLCVaxitPFSCcG5HHjYZtIyMva4H
         e6fHriDLF+F/bhzkZYmy/oZzItdFNXASRrVaUkP+iEhtESplOiX0XIF8E7/3q1twwiIO
         FacrMCDbWp84spC6R1dl2cwLYX9lBbqQ3S1pBqyodjJB8w+iuBdbQCrGR38B04IFa8A4
         OY2+lpx0lYb/LqDQ2nhJfIQAQ7q10kbUXHR9TQGnsOpgmCD3lbyZL1Mu+hqSVe+Vqf3G
         YyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w76wJ5l+Lxy6u8/boXMIhvSmKSqPJWBYy8Jl0GZV+PI=;
        b=t/4Y5JKjbFFLJPVgQjWaKKqzCOTm5TCaYT7unYHW6nWAinKs9cIR3PTlGHGgnsn/rD
         RKb5jxKLdI3fe+d5gvVYkQullPM2MpSZ2TcaDZTTQviAiXnyyZGdjAjlcEgyghwskeD0
         6yk0H06bwMUpxk5BHKs5HXQr8NNH1eXxx6IJloK/OfxJXWAcDsgkIft4prT8AoX8part
         4pr8ZYLIlMTbLz27w47OR/qcOfEcnpA3GTCOmbDM3OBbjtyRrmrbF5sInurHU+IpPZ6f
         cmf2cs1S1RkZBWQD46Pkq5eHSVcQxvlNEB9ZFfQr3dGUliTH6HmoD7TchVFnXEhrkXDL
         MbbQ==
X-Gm-Message-State: AOAM5335/Z7+0RJBlIjry/T1vvBbpc8LKjhAdDbASSi3PYUZKnxLl0H4
        8lMLB1Q4QKu5LgrcaCvVqjji9g/w7mHFeWL7qNY=
X-Google-Smtp-Source: ABdhPJz/ssa4nfqw6AEgafhXoBfp9myF3zDtAKhiHAAKAPCUTBexSVFaDI5CDlk+68Ugv87r1hyQxWFOnobe1p/7cSI=
X-Received: by 2002:a9d:73c1:: with SMTP id m1mr4436051otk.162.1626197855286;
 Tue, 13 Jul 2021 10:37:35 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
 <pull.932.v8.git.1626112556.gitgitgadget@gmail.com> <CABPp-BGZ0VNkAcScXLKAX0M3FwmXuZ5ei0o7Nu31L=rpSt6iQA@mail.gmail.com>
 <e7199fc6-bc7b-f556-c10c-12dee04af287@gmail.com>
In-Reply-To: <e7199fc6-bc7b-f556-c10c-12dee04af287@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 13 Jul 2021 10:37:24 -0700
Message-ID: <CABPp-BGs_X0=th9a_sgDPS36WQZaGO-r5DE0p+xgf7vHKUy1uQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/15] Sparse-index: integrate with status
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 13, 2021 at 5:57 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 7/12/2021 3:38 PM, Elijah Newren wrote:
> > On Mon, Jul 12, 2021 at 10:55 AM Derrick Stolee via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >>   9:  237ccf4e43d !  9:  c0b0b58584c unpack-trees: unpack sparse directory entries
> >>      @@ unpack-trees.c: static int find_cache_pos(struct traverse_info *info,
> >>       +  * Check for a sparse-directory entry named "path/".
> >>       +  * Due to the input p->path not having a trailing
> >>       +  * slash, the negative 'pos' value overshoots the
> >>      -+  * expected position by at least one, hence "-2" here.
> >>      ++  * expected position, hence "-2" instead of "-1".
> >>       +  */
> >>       + pos = -pos - 2;
> >>       +
> >>      @@ unpack-trees.c: static int find_cache_pos(struct traverse_info *info,
> >>                 return NULL;
> >>       +
> >>       + /*
> >>      -+  * We might have multiple entries between 'pos' and
> >>      -+  * the actual sparse-directory entry, so start walking
> >>      -+  * back until finding it or passing where it would be.
> >>      ++  * Due to lexicographic sorting and sparse directory
> >>      ++  * entried ending with a trailing slash, our path as a
> >
> > s/entried/entries/ ?
>
> Oops! Yes, that would be a valuable fixup. Thanks for catching it.
>
> >
> >>      ++  * sparse directory (e.g "subdir/") and our path as a
> >>      ++  * file (e.g. "subdir") might be separated by other
> >>      ++  * paths (e.g. "subdir-").
> >>       +  */
> >>       + while (pos >= 0) {
> >>       +         ce = o->src_index->cache[pos];
> > ...
> >>  15:  717a3f49f97 = 14:  dada1b91bdc wt-status: expand added sparse directory entries
> >
> > As I commented over at [1], I would appreciate if we could at least
> > add a comment in the testcase that we know this testcase triggers a
> > bug for both sparse-index and sparse-checkout...and that fixing it
> > might affect the other comments and commands within that testcase in
> > the future...but for now, we're just testing as best we can that the
> > two give the same behavior.
> >
> > [1] https://lore.kernel.org/git/CABPp-BGJ+LTubgS=zvGJjk3kgyfW-7UFEa=qg-0mdyrY32j0pQ@mail.gmail.com/
>
> How do you feel about a new patch that focuses on adding these
> comments, including an older test that had a similar documentation
> of the behavior change? A patch that could be queued on top of
> this series is pasted below the cutline.

Looks good to me.  Re-roll with my Reviewed-by and let's get this
series merged down to next.  :-)

>
> Thanks,
> -Stolee
>
>
> -- >8 --
>
> From 8e69def90f5844c117cc1e9efd673c92b85c9238 Mon Sep 17 00:00:00 2001
> From: Derrick Stolee <dstolee@microsoft.com>
> Date: Tue, 13 Jul 2021 08:50:24 -0400
> Subject: [PATCH 16/15] t1092: document bad sparse-checkout behavior
>
> There are several situations where a repository with sparse-checkout
> enabled will act differently than a normal repository, and in ways that
> are not intentional. The test t1092-sparse-checkout-compatibility.sh
> documents some of these deviations, but a casual reader might think
> these are intentional behavior changes.
>
> Add comments on these tests that make it clear that these behaviors
> should be updated. Using 'NEEDSWORK' helps contributors find that these
> are potential areas for improvement.
>
> Helped-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/t1092-sparse-checkout-compatibility.sh | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 2394c36d881..cabbd42e339 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -392,8 +392,8 @@ test_expect_failure 'blame with pathspec outside sparse definition' '
>         test_all_match git blame deep/deeper2/deepest/a
>  '
>
> -# TODO: reset currently does not behave as expected when in a
> -# sparse-checkout.
> +# NEEDSWORK: a sparse-checkout behaves differently from a full checkout
> +# in this scenario, but it shouldn't.
>  test_expect_failure 'checkout and reset (mixed)' '
>         init_repos &&
>
> @@ -403,8 +403,8 @@ test_expect_failure 'checkout and reset (mixed)' '
>         test_all_match git reset update-folder2
>  '
>
> -# Ensure that sparse-index behaves identically to
> -# sparse-checkout with a full index.
> +# NEEDSWORK: a sparse-checkout behaves differently from a full checkout
> +# in this scenario, but it shouldn't.
>  test_expect_success 'checkout and reset (mixed) [sparse]' '
>         init_repos &&
>
> @@ -524,6 +524,8 @@ test_expect_success 'sparse-index is not expanded' '
>         test_region ! index ensure_full_index trace2.txt
>  '
>
> +# NEEDSWORK: a sparse-checkout behaves differently from a full checkout
> +# in this scenario, but it shouldn't.
>  test_expect_success 'reset mixed and checkout orphan' '
>         init_repos &&
>
> --
