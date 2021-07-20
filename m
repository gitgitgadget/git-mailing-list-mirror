Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420B2C07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 02:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1579661164
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 02:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242301AbhGTB1E (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 21:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343690AbhGTBLt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 21:11:49 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DF4C061574
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 18:52:28 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id u15so22939158oiw.3
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 18:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BjbBhbGwnc7fYRIZ6pHa7n1PHvLhSuv58ObyulLWOdc=;
        b=fdrFT5U4fuXc6Sl2J33yozuHkLo0v8BsJUnb92QiGKt6eUTpIa/BO7TsJoGjV9SNn5
         544invbmO7IU2PW/Gi5rbm/SWNBYfHAx5ft/VWcwFRJv8UZ8FAnQXnX6EnjIG4glCWyY
         JCaiGu+aNw6iIvDijgLGmxoFD2RI1ZI4Tup37qtZcjiE5zCOcWYeDw/Mvtc9dboMvwNx
         Jo30vC5w571Yba1p6AHAzVpdD95T35rq1bSuGxF7xIDEqOcRNPw2/Sigl+XZz4z8V5Z+
         Msif0RIhJHzpqnee59UQnvW/gTCf7f36tJYYssDBFKWxloDQxMdLaHEN62rqwD702Kv0
         bc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BjbBhbGwnc7fYRIZ6pHa7n1PHvLhSuv58ObyulLWOdc=;
        b=k3YS7tVj7cbhkZg3XWXEVflt6ZWA84tvKd9ZGF7651lvnwpOFQK9nToexUt0PMfyP3
         wAskLN81baaDqUsu1/oMbxh9vjX5Y5ZL0EKlkdytfMvEpa1mq3LxoQtQ8tDNIziIz6yd
         hN6DEzaPW3iJHjjwWoVkZTaf8s5UpC/p44eK+fKJHV3sWSSmyD9fczr5JV88APo1wbmR
         u+4eUSbGD9Qor2U7fq1mh+o4WBGkbjIpQDeeugJRvwkN4+GwL4NU2UrSwVg9+GMDkz2l
         8bEKwdHu6nC6gYKyPxZHI/ICN4vkxWkn97X8T4U57FDRpU4r5dycKK3fZXAYXqqcXmVw
         s3IQ==
X-Gm-Message-State: AOAM533CU+pcB6syjrPcJKCNeDxur6F5qWNGFQuklm8a3CRYOSuhWkWo
        cCtPRSQpoP/cwwAP73XpZso/pVD8SI8zHWnURjE=
X-Google-Smtp-Source: ABdhPJy1F+yUGdUsQ7HLrHOCXyZn+gMm4k9r1X7pk7df58tvMn0MKwSGH/gY47H9apYj0oe+CdvliBAnaLSRd/H14HA=
X-Received: by 2002:aca:d644:: with SMTP id n65mr19330430oig.31.1626745947409;
 Mon, 19 Jul 2021 18:52:27 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq4kcqko6g.fsf@gitster.g>
In-Reply-To: <xmqq4kcqko6g.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 19 Jul 2021 18:52:16 -0700
Message-ID: <CABPp-BFXcNquqrwQ6nZSPy611oaosSbs74FdKWkrvGabnHSpgg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2021, #04; Mon, 19)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 19, 2021 at 4:16 PM Junio C Hamano <gitster@pobox.com> wrote:

> * en/rename-limits-doc (2021-07-15) 4 commits
>  - rename: bump limit defaults yet again
>  - diffcore-rename: treat a rename_limit of 0 as unlimited
>  - doc: clarify documentation for rename/copy limits
>  - diff: correct warning message when renameLimit exceeded
>
>  Update documentation on "git diff -l<n>" and diff.renameLimit.

It also bumps the default limits.  Not sure if that's worth calling
out in the release notes or not.

>  Will merge to 'next'.

Thanks.

> * en/ort-perf-batch-14 (2021-07-13) 7 commits
>  - merge-ort: restart merge with cached renames to reduce process entry cost
>  - merge-ort: avoid recursing into directories when we don't need to
>  - merge-ort: defer recursing into directories when merge base is matched
>  - merge-ort: add a handle_deferred_entries() helper function
>  - merge-ort: add data structures for allowable trivial directory resolves
>  - merge-ort: add some more explanations in collect_merge_info_callback()
>  - merge-ort: resolve paths early when we have sufficient information
>
>  Further optimization on "merge -sort" backend.
>
>  Reviews?

Stolee reviewed it; he posted numerous comments and helpful
suggestions throughout the series.  I sent in a new series
incorporating all his suggestions, though I'm still waiting to hear
back if that addresses things sufficiently for him.

> * ds/commit-and-checkout-with-sparse-index (2021-07-14) 5 commits
>  - checkout: stop expanding sparse indexes
>  - sparse-index: recompute cache-tree
>  - commit: integrate with sparse-index
>  - p2000: compress repo names
>  - p2000: add 'git checkout -' test and decrease depth
>  (this branch uses ds/status-with-sparse-index.)
>
>  "git checkout" and "git commit" learn to work without unnecessarily
>  expanding sparse indexes.
>
>  Will merge to 'next'.

Please wait; he's going to post some fixes.  See
https://lore.kernel.org/git/91b81577-3ff8-3845-75d1-c47e8a42406e@gmail.com/.

> * ds/status-with-sparse-index (2021-07-14) 16 commits
>  - t1092: document bad sparse-checkout behavior
>  - fsmonitor: integrate with sparse index
>  - wt-status: expand added sparse directory entries
>  - status: use sparse-index throughout
>  - status: skip sparse-checkout percentage with sparse-index
>  - diff-lib: handle index diffs with sparse dirs
>  - dir.c: accept a directory as part of cone-mode patterns
>  - unpack-trees: unpack sparse directory entries
>  - unpack-trees: rename unpack_nondirectories()
>  - unpack-trees: compare sparse directories correctly
>  - unpack-trees: preserve cache_bottom
>  - t1092: add tests for status/add and sparse files
>  - t1092: expand repository data shape
>  - t1092: replace incorrect 'echo' with 'cat'
>  - sparse-index: include EXTENDED flag when expanding
>  - sparse-index: skip indexes with unmerged entries
>  (this branch is used by ds/commit-and-checkout-with-sparse-index.)
>
>  "git status" codepath learned to work with sparsely populated index
>  without hydrating it fully.
>
>  Will merge to 'next'.

Yep, sounds good; thanks.
