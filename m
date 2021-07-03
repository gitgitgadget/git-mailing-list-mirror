Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDC6C07E97
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 05:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDAF0613C0
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 05:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhGCFH3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jul 2021 01:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhGCFH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jul 2021 01:07:29 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D236C061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 22:04:55 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 11so14010783oid.3
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 22:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eZoRyRAUg5NM6DUtLpADRzTK6NuB/iorWs0CRdlWNJs=;
        b=t1/m38sfVtKgJ6w3rfKSE5o8KMSOsC2JYa/5LnOzEsE/fz7jbPsu5yNum+ig5B9Bcx
         TkcvdewXfHhl6UXyq4t6A0MhrsOWhdw+jBpY0MbSJxPEo2Bgoitkt/3NLeGouZGDeTRm
         G6LYtfHsAfftXzDr0bTEwY6R9YpTnOTk9a8bqYM+VAHUMWHBHOaFLUFRv1Hb4LKUNnjx
         QqDp4DnWxz1gP4lNjDNR3FXHu+7ZtItzWPV0B4EyScgC0EAB4doFZIfwyGR5fF8s+ETR
         PfHIBB6yL8N6OKlQanJPayvuqeALUQlNe6TVARy3PXGGOd6m6vHRh/HjzDnYQhy1DhNX
         zGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eZoRyRAUg5NM6DUtLpADRzTK6NuB/iorWs0CRdlWNJs=;
        b=C7kjAiujXynrCYkFN2DR/aUFMS8lp3ZPg620Qyhs+6Fj7GS3rJEwzRNaIzOkIA6j60
         s/UQX/QTL5u3Ee3rzTT7lIleo3IjU6RRrrR7lu1CVC058OlpS8EAVR5ACmeG6RiGLPOA
         8OYPMErKTaP+F/bQ81RSiwxI/m7T89MBBvOpBTsa76N68ftBU7vq3rc3usynSBqG0poE
         lzisSZ36Cg3I5F2cn/BTRJSwTYDYDAid54V3dMLwP0C9kvAeDE/FT8acxWIqTdRUaAcR
         H5q2pX1SvHVE9C2vAFu+Ki+SXCBNARcfj3TUHol4XacWZEeLKnSopNzrhO/WYsjhoUuP
         aaqg==
X-Gm-Message-State: AOAM5300bWk6HCsHMWwv5gYLKXMUSXYjFg4xLmYQ9z3b5dkmocgaMxDD
        bEu44+/e3mpLhF6vYwydDUP4kTmCOO80ykAca7uGgUxCaW1ELw==
X-Google-Smtp-Source: ABdhPJxYYTfBUzu7F7T32aRwBNsyqQvvwt2Xl3jV0+4GICqX44iGLyOijQBSEbiMH/TESGDETzGetBZ+BtrjfLmXuK0=
X-Received: by 2002:aca:ed0b:: with SMTP id l11mr2475294oih.167.1625288694148;
 Fri, 02 Jul 2021 22:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq4kdft122.fsf@gitster.g>
In-Reply-To: <xmqq4kdft122.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 2 Jul 2021 22:04:42 -0700
Message-ID: <CABPp-BGF4K4mAXf6X1rTpTmPCfQgwdhv_VUVg2icGk5Dw7Q1yw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jun 2021, #07; Wed, 30)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 30, 2021 at 3:58 PM Junio C Hamano <gitster@pobox.com> wrote:

I've started reviewing v7 of ds/status-with-sparse-index and will also
look at ds/commit-and-checkout-with-sparse-index afterwards.

> * en/ort-perf-batch-13 (2021-06-28) 5 commits
>  - merge-ort: add prefetching for content merges
>  - diffcore-rename: use a different prefetch for basename comparisons
>  - diffcore-rename: allow different missing_object_cb functions
>  - t6421: add tests checking for excessive object downloads during merge
>  - promisor-remote: output trace2 statistics for number of objects fetched
>
>  Performance tweaks of "git merge -sort" around lazy fetching of objects.

Most of the discussion on this series was actually about related
improvements and ideas, with both Stolee and I agreeing those belong
outside this particular series.

I also tried to ask Jonathan Tan to review since it was based upon his
similar work to do the original prefetching in diffcore-rename, but I
think he's been busy.

I'm not aware of further tweaks needed right now, but it's not at all
clear to me whether I addressed your and Stolee's feedback to each of
your satisfaction.  So this one could potentially be marked "Waiting
for reviews (to finalize)"

> * en/zdiff3 (2021-06-15) 2 commits
>  - update documentation for new zdiff3 conflictStyle
>  - xdiff: implement a zealous diff3, or "zdiff3"
>
>  "Zealous diff3" style of merge conflict presentation has been added.
>
>  Expecting a reroll.
>  cf. <CABPp-BE7-E03+x38EK-=AE5mwwdST+d50hiiud2eY2Nsf3rM5g@mail.gmail.com>

I've got some updates for this RFC series (in part thanks to Phillip's
awesome digging!), including some tests.  However, I've also got a
clear testcase failure, and another
I-know-I-saw-a-real-problem-in-real-testing-but-lost-the-details
issue.  So I may wait a while to resend.

> * pw/diff-color-moved-fix (2021-06-15) 10 commits
>  - diff --color-moved: intern strings
>  - diff --color-moved-ws=allow-indentation-change: improve hash lookups
>  - diff --color-moved: stop clearing potential moved blocks
>  - diff --color-moved: shrink potential moved blocks as we go
>  - diff --color-moved: unify moved block growth functions
>  - diff --color-moved: call comparison function directly
>  - diff --color-moved-ws=allow-indentation-change: simplify and optimize
>  - diff: simplify allow-indentation-change delta calculation
>  - diff --color-moved: avoid false short line matches and bad zebra coloring
>  - diff --color-moved=zebra: fix alternate coloring
>
>  Long-overdue correctness and performance update to "diff
>  --color-moved" feature.
>
>  Waiting for reviews.

I read through the first half the patches or so and didn't spot
anything wrong, though I'm very unfamiliar with this code area and
don't yet understand much of what's going on; it was more of a spot
check.  I'll try to get back to it again, but my review probably won't
be that deep.

> * en/ort-perf-batch-12 (2021-06-09) 4 commits
>  - merge-ort: miscellaneous touch-ups
>  - Fix various issues found in comments
>  - diffcore-rename: avoid unnecessary strdup'ing in break_idx
>  - merge-ort: replace string_list_df_name_compare with faster alternative
>
>  More fix-ups and optimization to "merge -sort".
>
>  Will merge to 'next'.

Sounds good, thanks.  As far as I can tell, I addressed everyone's
feedback a month or more ago (including getting Stolee's Reviewed-by);
no changes since then.

> * ab/send-email-optim (2021-05-28) 13 commits
>  - perl: nano-optimize by replacing Cwd::cwd() with Cwd::getcwd()
>  - send-email: move trivial config handling to Perl
>  - perl: lazily load some common Git.pm setup code
>  - send-email: lazily load modules for a big speedup
>  - send-email: get rid of indirect object syntax
>  - send-email: use function syntax instead of barewords
>  - send-email: lazily shell out to "git var"
>  - send-email: lazily load config for a big speedup
>  - send-email: copy "config_regxp" into git-send-email.perl
>  - send-email: refactor sendemail.smtpencryption config parsing
>  - send-email: remove non-working support for "sendemail.smtpssl"
>  - send-email tests: test for boolean variables without a value
>  - send-email tests: support GIT_TEST_PERL_FATAL_WARNINGS=true
>
>  "git send-email" optimization.
>
>  Will merge to 'next'.

Wahoo!
