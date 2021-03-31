Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA84C433C1
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 01:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3F6B619D3
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 01:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbhCaBXv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 21:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhCaBXW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 21:23:22 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4198C061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 18:23:21 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 68-20020a9d0f4a0000b02901b663e6258dso17398188ott.13
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 18:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IBVcLJxD89qinyJZX0UoJRt/2FJxjwyftQfU1vXI4VE=;
        b=Wvmyq0+EhAFlbTHk+9QQaQCNQ8L1zXeC0Ye6TpwdxkEzuQeICIkteI5J5EpSzkaQw2
         J1Sn8mIQWGST8TkaQCbMD/uOIoZrvsqcedl5Kpr9LIKjtyoz7Qs83xwlrO2Yx8uExtZj
         kKugt+AxwXK8uW+L3PYhTNQnEEp9p3DNT6DkMQSJu7t8ZhLVKX0uJL601PoQ0RJYHx1n
         buJ6LdM4KERDdS/oCOynFnfvcdKHNWrcFLJV0hU9j9du8orzHay05Xi77dWuJAkCMlBz
         xL4cu0R0YZh9JuH/Wxyp9e5807acN4Hu4xkiC6unr/jut50Sr16q1ILTw7khhiv64+Y2
         ZnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IBVcLJxD89qinyJZX0UoJRt/2FJxjwyftQfU1vXI4VE=;
        b=GtzbjFw0h3VEOcuGJEtBtOJM8tcP6PmMOn0ro+6IEv1bzeVs4nVFvsiov/1efWqRAl
         E33NCIEHlnHqgTwIZvmtDRC/S1koOxVtpndTWqu9KvlstqqJjg74jNRZ7aoKwP6tKqU0
         cmHF4bAW4xfNaX5QZ0aLiXv9pPEMDtuc4En5HMVSenQNQa7ZXU6Jh2OzoeNwcN7lIDFz
         eDlHftLPjwOQ0agN93HvmAOBckJXLoTr1oTcPPLyiPzTiB0+DP3TaxGLfJfrg/tyGTS0
         ubr0IfiJEKF8n9KZrVhabGce+4S3joVt5fvwzC9n2MJCefpeUJZPShrTQEZlVhg7Mf2r
         AUvQ==
X-Gm-Message-State: AOAM530mLLhsBpAIaVAQd4GE92BfzbK1N52ak34Omli0+Uwn2RfjGiOC
        Wb6BNefYy42aE+37xJXUZ2WVjQbaxxQ6EGHWIQk=
X-Google-Smtp-Source: ABdhPJw+S2DfZmSsaPM7lvpLdtVQ3CqWY6VFkZitQNHqscqlk6AjfRkrmfAQzI1oHu3Gz/mPE6v8YFvqZvBtc+6Zkro=
X-Received: by 2002:a9d:8d5:: with SMTP id 79mr539309otf.345.1617153801119;
 Tue, 30 Mar 2021 18:23:21 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqv99889hh.fsf@gitster.g>
In-Reply-To: <xmqqv99889hh.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 30 Mar 2021 18:23:09 -0700
Message-ID: <CABPp-BEmZ-UGNeWs+XS4o0VWZ8=nqrCwJsSBQFYBBJ8Py2XOZg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Mar 2021, #08; Tue, 30)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Mar 30, 2021 at 5:17 PM Junio C Hamano <gitster@pobox.com> wrote:
> [New Topics]
> ...
> * en/ort-perf-batch-11 (2021-03-25) 7 commits
>  - merge-ort, diffcore-rename: employ cached renames when possible
>  - merge-ort: add helper functions for using cached renames
>  - merge-ort: preserve cached renames for the appropriate side
>  - merge-ort: avoid accidental API mis-use
>  - merge-ort: add code to check for whether cached renames can be reused
>  - merge-ort: populate caches of rename detection results
>  - merge-ort: add data structures for in-memory caching of rename detecti=
on
>  (this branch uses en/ort-perf-batch-10, en/ort-perf-batch-9 and en/ort-r=
eadiness.)

I was actually slightly surprised you picked this one up this early
given the other three in-flight.  I sent it out for review since folks
had reviewed the previous series and discussion on them had been quiet
for a while.

Please note that there is an issue with this series, as noted at
https://lore.kernel.org/git/CABPp-BGrevGj+xrm9bVcX5bp_WRv9cYP+g0hrAtjZK0u=
=3DsTHzQ@mail.gmail.com/,
so even if you merge the other series down, this one needs to be
re-rolled at least once first.  (I know you normally wouldn't merge
quickly, I just wanted to avoid an accidental merge to next based on
topic name similarity.)

> [Cooking]
...
> * en/ort-perf-batch-10 (2021-03-18) 8 commits
>  - diffcore-rename: determine which relevant_sources are no longer releva=
nt
>  - merge-ort: record the reason that we want a rename for a file
>  - diffcore-rename: add computation of number of unknown renames
>  - diffcore-rename: check if we have enough renames for directories early=
 on
>  - diffcore-rename: only compute dir_rename_count for relevant directorie=
s
>  - merge-ort: record the reason that we want a rename for a directory
>  - merge-ort, diffcore-rename: tweak dirs_removed and relevant_source typ=
e
>  - diffcore-rename: take advantage of "majority rules" to skip more renam=
es
>  (this branch is used by en/ort-perf-batch-11 and en/ort-readiness; uses =
en/ort-perf-batch-9.)
>
>  I made a mistake of picking these up before they got sufficient
>  exposure to the reviewers and ended up a source of potential mess
>  when it turns out that any of the earlier ones need rewriting (I

Um...are you by chance conflating my comments linked above on
ort-perf-batch-11, the very latest series, with this series?  I
totally agree that ort-perf-batch-11 is in no state for building upon,
hasn't had sufficient review, and even if someone had reviewed it
quickly there hasn't been enough time to allow other reviewers to
chime in...but I haven't sent any subsequent series based on it.

>  probably should stop picking up nested series that exceeds reviewer
>  bandwidth), but how ready is this and subsequent topics?

I think ort-perf-batch-9, ort-perf-batch-10, and ort-readiness are all
ready to merge to next.  All have been reviewed by Stolee to his
satisfaction.  ort-readiness was also reviewed by =C3=86var (and used by
him in testing one of his series and helped him find a bug).

As noted above, ort-perf-batch-11 is not ready; please do not merge that on=
e.

> * en/ort-readiness (2021-03-20) 13 commits
>  - Add testing with merge-ort merge strategy
>  - t6423: mark remaining expected failure under merge-ort as such
>  - Revert "merge-ort: ignore the directory rename split conflict for now"
>  - merge-recursive: add a bunch of FIXME comments documenting known bugs
>  - merge-ort: write $GIT_DIR/AUTO_MERGE whenever we hit a conflict
>  - t: mark several submodule merging tests as fixed under merge-ort
>  - merge-ort: implement CE_SKIP_WORKTREE handling with conflicted entries
>  - t6428: new test for SKIP_WORKTREE handling and conflicts
>  - merge-ort: support subtree shifting
>  - merge-ort: let renormalization change modify/delete into clean delete
>  - merge-ort: have ll_merge() use a special attr_index for renormalizatio=
n
>  - merge-ort: add a special minimal index just for renormalization
>  - merge-ort: use STABLE_QSORT instead of QSORT where required
>  (this branch is used by en/ort-perf-batch-11; uses en/ort-perf-batch-10 =
and en/ort-perf-batch-9.)
>
>  Plug the ort merge backend throughout the rest of the system, and
>  start testing it as a replacement for the recursive backend.

As noted above, this series had two reviewers[1,2].

[1] https://lore.kernel.org/git/87pn09iu3j.fsf@evledraar.gmail.com/
[2] https://lore.kernel.org/git/4da61e15-a490-673a-ef15-800321ac9eea@gmail.=
com/

I'm not aware of any outstanding issues, the reviewers seemed happy as
of 2-3 weeks ago, and I haven't heard anyone else chime in so I'm
inclined to say this one is ready to merge to next.

> * en/ort-perf-batch-9 (2021-03-10) 8 commits
>  - diffcore-rename: avoid doing basename comparisons for irrelevant sourc=
es
>  - merge-ort: skip rename detection entirely if possible
>  - merge-ort: use relevant_sources to filter possible rename sources
>  - merge-ort: precompute whether directory rename detection is needed
>  - merge-ort: introduce wrappers for alternate tree traversal
>  - merge-ort: add data structures for an alternate tree traversal
>  - merge-ort: precompute subset of sources for which we need rename detec=
tion
>  - diffcore-rename: enable filtering possible rename sources
>  (this branch is used by en/ort-perf-batch-10, en/ort-perf-batch-11 and e=
n/ort-readiness.)
>
>  The ort merge backend has been optimized by skipping irrelevant
>  renames.
>
>  Will merge to 'next'.

Thanks, sounds good.
