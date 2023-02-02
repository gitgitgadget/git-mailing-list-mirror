Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94602C61DA4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 23:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbjBBXrP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 18:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbjBBXrN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 18:47:13 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777936FD1F
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 15:46:59 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id v17so5430572lfd.7
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 15:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x1HNQK35Ysfh+nMTAJe2qU8bS7aWkTbBxk+njvppCbM=;
        b=CEY9RmcHW616oI6AggM51xqScPk5ohFbpSY7mMAMeYZXLTCpqTCTFan7hOLHuFdtW5
         6NAngz1O/01j9q6jSAH1DrX0Um58MsDztixYwpt5axeGNAfrrJ0tF+o9rIs2g3OzF6YI
         +1CSZ7kRlkw3gOCsNXkVc3zyNJrHzfytOAIdj0oCaTSjJKjlzxQgG4qDKKviI7+eouPK
         A4NvGfbTQPjcrNQwMOF4hgwfwBUybxR+YsF92dLi7Xir5umjDW1zPXCFVc0/dzq5vOv3
         ir2uzi8i+NxwRzPk2Xkd0sMOKDliNjo7VWXQ+NkegsSHISc+/ZVsYAI1bZFLsU6WhMCD
         OT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x1HNQK35Ysfh+nMTAJe2qU8bS7aWkTbBxk+njvppCbM=;
        b=TnR7u3AyGyD3J3psTteX6b2j/N7uFH92n4fSKQrzihinidwwngu6olZvFpcQ3g6v76
         xGMQ/6TQmEaVFE9NPM8xMN6bW5ZNy/I7YVi4kacMO4efiBkQ+o8196tISLKhqlPIUBGp
         jryWTWmu08mckr7E9j8JRR/BlSkrUZuHERFx+aKNmCoWPE0C9Q9PFqpbLLd1q8QDrE+m
         FShbUVWVhHC+tL9yvRmioRCoQ/zUvsQ2ZgznkGfGyZfkVpykGKeRbB/wpDGMlD/0u54u
         WQzx0MUqzZCcfryjnwyELWf0T+Kx57fxiHx086EUJKojTM1QX5hr9NOxbmQ/k6ZoZexz
         VIog==
X-Gm-Message-State: AO0yUKVpjGMsdVHusilgL1mxrYlHfBLCHqSAHolA7ZP4+B4iSOv5tcyK
        TjINi6tEkvLB81YgXR/hvtcYgItMCFg02wAsox/uruIt
X-Google-Smtp-Source: AK7set/uJMmQjSp1LbwGbr5ikMAs7zZ8qTzsLWPQ7Ium2TZDnH0dlmHgeq/s2omQs9c8hA5Es29ZUxIu8Fg1uci0sQg=
X-Received: by 2002:a05:6512:3990:b0:4d5:82bb:7d39 with SMTP id
 j16-20020a056512399000b004d582bb7d39mr1093835lfu.129.1675381617382; Thu, 02
 Feb 2023 15:46:57 -0800 (PST)
MIME-Version: 1.0
References: <20230202165137.118741-1-five231003@gmail.com>
In-Reply-To: <20230202165137.118741-1-five231003@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 2 Feb 2023 15:46:45 -0800
Message-ID: <CABPp-BHE=zGT_vPW8+TZn-wqmufhVdGQT-=LXoLQkto6TMrnrA@mail.gmail.com>
Subject: Re: [GSoC][PATCH] merge: use reverse_commit_list() for list reversal
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 2, 2023 at 9:10 AM Kousik Sanagavarapu <five231003@gmail.com> wrote:
>
> Instead of manually doing an in-place list reversal, use the helper
> function reverse_commit_list(), hence improving code readability.
>
> Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
> ---
>
> This patch addresses the issue #1156(Use reverse_commit_list() in more
> places) on gitgitgadget. I also would like to submit this patch as the microproject for
> GSoC 2023.

Looks like this was a suggestion from me, so I'm to blame.  But
looking at it again, I'm not sure builtin/merge.c is actually a good
candidate because...

>  builtin/merge.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 5900b81729..4503dbfeb3 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -736,7 +736,6 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
>                 struct commit *result;
>                 struct commit_list *reversed = NULL;
>                 struct merge_options o;
> -               struct commit_list *j;
>
>                 if (remoteheads->next) {
>                         error(_("Not handling anything other than two heads merge."));
> @@ -757,8 +756,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
>                 o.branch1 = head_arg;
>                 o.branch2 = merge_remote_util(remoteheads->item)->name;
>
> -               for (j = common; j; j = j->next)
> -                       commit_list_insert(j->item, &reversed);

This is not an in-place list reversal; it's creating a new list that
is reversed.  "common" can continue to be used separately from
"reversed" after this point.  (And the new list, "reversed" is
consumed by merge_recursive()/merge_ort_recursive(), so there's
nothing to free.)

> +               reversed = reverse_commit_list(common);

This is an in-place list reversal.  If there's only one merge strategy
being attempted, this may work, since "common" probably won't be used
afterwards.

However, if we have multiple merge strategies that expect to be passed
the common commits -- a situation we probably don't have a testcase
for in the testsuite -- then I think this code change will result in a
use-after-free error.


>                 hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
>                 if (!strcmp(strategy, "ort"))
> --
> 2.25.1
