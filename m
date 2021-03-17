Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3C3C433DB
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 23:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E1BF64E77
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 23:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbhCQXNt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 19:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhCQXNj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 19:13:39 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA15C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 16:13:39 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id j10-20020a4ad18a0000b02901b677a0ba98so980351oor.1
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 16:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ownfgpax+cKMPYsO5v6jVmywvyWmiqaQMYhKjaw1haw=;
        b=gJ0eYH/rWBg8IBednl1KG7Xrw4pu2aYK4Uk4Tq0KBmQtLVwlM0baf8ZWT0w/CZSa35
         4QLA738AggSCrqfo2CIvt+vkePjDZvL8181BkJshFe47svQ4miadP+GhPFf1p0sVkVYs
         IkUcWURzPcgx4pr7chEfzNpdCpEltnElFZ8vgHDmUdqZnNxKX8iohkD/mfr4xXNYcqNG
         AbH6rcYBo0Vhy95QWvIWZyTAuLVGM7VrSXsITlQF600+5gQVDUqwF8menJzhvdQegLGV
         s+7fz3abIWuE/ILlHD3AsJ4YW379PQHZr3MTrPmbsG4t7hBt2kq0ndCp2eRgnzQyncQz
         ww1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ownfgpax+cKMPYsO5v6jVmywvyWmiqaQMYhKjaw1haw=;
        b=M0DCjECbYJrX1h4g3P+UZlbUAw6/2Nsv3pnqp2SxBXMSxLqSqW5RQ5WZA2XnA6C2bG
         mTXQlYRyZUSpe1vYrZ5wUknZ4KSVBm+KrDrw7JASpa4emKu26rJak6UqFZMFmx8TVsaU
         1uSL4kRSUQDwEYaGuaB3+0osDNTmslWR5OX52+epGQBnCpjeRC2DtmbLdFEJ/FhLwUNX
         FXaUPNdgKNn8/6fr+TvB/LmxGYtsyAZluBuxhqyB9hjNCth1pSMrxom97BwwwO+A+JFG
         nCqfwLlcd8iKYe3vW509tkqbYwGvdgTYyh3o/EXL6Q1I6/DdEfH2v7U/mKQhcuqRxwQ9
         q/sA==
X-Gm-Message-State: AOAM531QUQ798CBUPaHJdYkV+h9huIDWOkiU2PY9DgYTeFRxmroXSsFz
        YnTgtB2gb8KwHTPRQ7D7hMQki0GydCkc7iSOa8w8nTforwlKnw==
X-Google-Smtp-Source: ABdhPJxpKCFxOsJCybEbg2d2EDkBAhnQx5+XSL6lCMqCcKyYezNQOCnZh2LdfXHcKLXslc66qgtgnGRswwsxXRtuBy8=
X-Received: by 2002:a4a:eb8a:: with SMTP id d10mr5163956ooj.32.1616022818567;
 Wed, 17 Mar 2021 16:13:38 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqblbhtoa6.fsf@gitster.g>
In-Reply-To: <xmqqblbhtoa6.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 17 Mar 2021 16:13:27 -0700
Message-ID: <CABPp-BGkvUK3Xs6ZsWwv_C_tdJN-84ebBcxZCAoRu+sX7aWQ8g@mail.gmail.com>
Subject: Re: What's cooking in git.git (Mar 2021, #05; Wed, 17)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 17, 2021 at 3:23 PM Junio C Hamano <gitster@pobox.com> wrote:

> Many topics marked as "Will cook in 'next'" should be marked for
> merging to 'master' now, but that hasn't happened yet.  Please
> nominate those that should be kicked back from 'next' to 'seen', if
> there are any.  Please also nominate those that should be among the
> first batch of topics to be in 'master' (after a handful of 2.31
> regression fixes go through 'next' down to 'master', that is).

Will do; I'll also point out a few topics that have been reviewed but
haven't been picked up yet.

> * en/ort-perf-batch-9 (2021-03-10) 8 commits
>  - diffcore-rename: avoid doing basename comparisons for irrelevant sources
>  - merge-ort: skip rename detection entirely if possible
>  - merge-ort: use relevant_sources to filter possible rename sources
>  - merge-ort: precompute whether directory rename detection is needed
>  - merge-ort: introduce wrappers for alternate tree traversal
>  - merge-ort: add data structures for an alternate tree traversal
>  - merge-ort: precompute subset of sources for which we need rename detection
>  - diffcore-rename: enable filtering possible rename sources
>  (this branch uses en/ort-perf-batch-8.)
>
>  More ort.

Can I suggest an alternate title?  "merge-ort optimization of skipping
irrelevant renames" or anything that gets the idea of "skipping
irrelevant renames" in there.

>  Ready?

Yeah, I think it's ready; I'm not aware of any needed changes.
Reviewed by Stolee at [1] and [2]

[1] https://lore.kernel.org/git/c4ce57f2-fc02-a70c-5ecb-0911a551192c@gmail.com/
[2] https://lore.kernel.org/git/4aed9cc6-b133-b398-353c-9618439c7b8b@gmail.com/

Sidenote: This patch series was the single best thing in all of
merge-ort.  I was really hoping more people would read just the cover
letter, even if they read none of the patches or even none of the
other cover letters.  (As Stolee said, 'These are _very_ impressive
numbers for such a "simple" idea.').


> * en/ort-perf-batch-8 (2021-02-26) 10 commits
>   (merged to 'next' on 2021-03-07 at f03b2c1acd)
>  + diffcore-rename: compute dir_rename_guess from dir_rename_counts
>  + diffcore-rename: limit dir_rename_counts computation to relevant dirs
>  + diffcore-rename: compute dir_rename_counts in stages
>  + diffcore-rename: extend cleanup_dir_rename_info()
>  + diffcore-rename: move dir_rename_counts into dir_rename_info struct
>  + diffcore-rename: add function for clearing dir_rename_count
>  + Move computation of dir_rename_count from merge-ort to diffcore-rename
>  + diffcore-rename: add a mapping of destination names to their indices
>  + diffcore-rename: provide basic implementation of idx_possible_rename()
>  + diffcore-rename: use directory rename guided basename comparisons
>  (this branch is used by en/ort-perf-batch-9.)
>
>  Rename detection rework continues.
>
>  Will cook in 'next'.

I think it's ready to merge to master.



--------------------------------------------------
[Not yet cooking]

Here are some reviewed topics that haven't been cooking yet, that I
personally think are worth picking up (at least for seen and probably
for next rather soonish):


* Matheus' add-rm-sparse-checkout work:
https://lore.kernel.org/git/CABPp-BEriPaDY=84=j0tT62+U93jKePTyTKPZA4+dYtSFJaSTg@mail.gmail.com/

* Stolee's first sparse-index series:
https://lore.kernel.org/git/pull.883.v3.git.1615912983.gitgitgadget@gmail.com/

* My ort-perf-batch-10 ("skip even more irrelevant renames") series:
https://lore.kernel.org/git/8422759a-a4a3-4dc6-4ae7-4a61896b9946@gmail.com/;
(the review comment there is addressed by the next patch series in
this list)

* My "declare merge-ort stable" series at
https://lore.kernel.org/git/pull.905.v2.git.1616016485.gitgitgadget@gmail.com/
(though most the reviews were on the separate-at-the-time topic at
https://lore.kernel.org/git/pull.973.v2.git.git.1615271086.gitgitgadget@gmail.com/
).  Actually, only the first 12 patches are reviewed, but the last one
is testing code rather than source code, so close enough for at least
picking up?
