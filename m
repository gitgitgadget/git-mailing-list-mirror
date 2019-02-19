Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 573711F453
	for <e@80x24.org>; Tue, 19 Feb 2019 07:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725775AbfBSHDu (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 02:03:50 -0500
Received: from rrzmta2.uni-regensburg.de ([194.94.155.52]:49828 "EHLO
        rrzmta2.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfBSHDu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 02:03:50 -0500
Received: from rrzmta2.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 3D32C7E5B3
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 08:03:46 +0100 (CET)
Received: from gwsmtp1.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by rrzmta2.uni-regensburg.de (Postfix) with ESMTP id 1D2747E5D0
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 08:03:46 +0100 (CET)
Received: from uni-regensburg-smtp1-MTA by gwsmtp1.uni-regensburg.de
        with Novell_GroupWise; Tue, 19 Feb 2019 08:03:45 +0100
Message-Id: <5C6BAA4E020000A10002FBFF@gwsmtp1.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.1.0 
Date:   Tue, 19 Feb 2019 08:03:42 +0100
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     "Elijah Newren" <newren@gmail.com>, <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
Subject: Antw: Antw:
References: <5C481202020000A10002F4AE@gwsmtp1.uni-regensburg.de>
 <20190218184147.7563-1-newren@gmail.com>
 <5C481202020000A10002F4AE@gwsmtp1.uni-regensburg.de>
 <0A3130DD0200005B824A10E1@gwsmtp1.uni-regensburg.de>
In-Reply-To: <0A3130DD0200005B824A10E1@gwsmtp1.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>> Elijah Newren <newren@gmail.com> schrieb am 18.02.2019 um 19:41 in
Nachricht
<20190218184147.7563-1-newren@gmail.com>:
> Hi Ulrich,
> 
> Sorry for the late reply...

No problem, thanks for the explanation. I'll "fast forward" directly to the
patch below and comment inline: -- Ulrich

[...]
> ‑‑ 8< ‑‑
> Subject: [PATCH] merge‑options.txt: correct wording of ‑‑no‑commit option
> 
> The former wording implied that ‑‑no‑commit would always cause the
> merge operation to abort and allow the user to make further changes

I think "abort" is not the perfect word, because the merge would rather be
"paused for commit" in my understanding; a "git merge --abort" is different,
right?

> and/or provide a special commit message for the merge commit.  This
> is not the case for fast‑forward merges, as there is no merge commit
> to create.  Without a merge commit, there is no place where it makes
> sense to "stop the merge and allow the user to tweak changes"; doing
> that would require a full rebase of some sort.

...and before trying the merge it's not always obvious whether the merge will
be fast-forward type or not. So actually the outcome of --no-commit depends on
the conents being merged, not on the command line options.

> 
> Modify the wording to correctly address fast‑forward cases as well,
> and suggest using ‑‑no‑ff with ‑‑no‑commit if the point is to ensure
> that the merge aborts.
> 
> Reported‑by: Ulrich Windl <Ulrich.Windl@rz.uni‑regensburg.de>
> Signed‑off‑by: Elijah Newren <newren@gmail.com>
> ‑‑‑
>  Documentation/merge‑options.txt | 12 +++++++++‑‑‑
>  1 file changed, 9 insertions(+), 3 deletions(‑)
> 
> diff ‑‑git a/Documentation/merge‑options.txt
b/Documentation/merge‑options.txt
> index c2a263ba74..d1061b8cf7 100644
> ‑‑‑ a/Documentation/merge‑options.txt
> +++ b/Documentation/merge‑options.txt
> @@ ‑3,9 +3,15 @@
>  	Perform the merge and commit the result. This option can
>  	be used to override ‑‑no‑commit.
>  +
> ‑With ‑‑no‑commit perform the merge but pretend the merge
> ‑failed and do not autocommit, to give the user a chance to
> ‑inspect and further tweak the merge result before committing.
> +With ‑‑no‑commit perform the merge and stop just before creating
> +a merge commit, to give the user a chance to inspect and further
> +tweak the merge result before committing.
> ++
> +Note that fast‑forward updates do not need to create a merge
> +commit and therefore there is no way to stop those merges with
> +‑‑no‑commit.  Thus, if you want to ensure your branch is not
> +changed or updated by the merge command, use ‑‑no‑ff with
> +‑‑no‑commit.
>  
>  ‑‑edit::
>  ‑e::
> ‑‑ 
> 2.21.0.rc1.264.g6c9e06a32d



