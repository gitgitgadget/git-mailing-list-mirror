Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5297A2022A
	for <e@80x24.org>; Mon,  7 Nov 2016 19:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751546AbcKGTUw (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 14:20:52 -0500
Received: from mail-qk0-f173.google.com ([209.85.220.173]:33591 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751496AbcKGTUv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 14:20:51 -0500
Received: by mail-qk0-f173.google.com with SMTP id x190so187677637qkb.0
        for <git@vger.kernel.org>; Mon, 07 Nov 2016 11:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=g5G/M59/Xh3PXzwrt0Y2GoE1s5ET1sF91l3s8qx+Gtk=;
        b=UJBc8gqiF2qoW6fADGnwiyrhSG56dtsvOA6NeQWmBx576K791CzCqRX43I0SDjEyTD
         +KpvbyTB0+A4EDZqGau3wR5MucZzHegwBrhr68rurWIHAg/FLIdiZXbi7UyOf5UX9unn
         vtHWKUXVsv8dnp036oPGGMvV3RyR8jb0iCctoQ4q28eT50Vo2SRLTy3VRZBHu4xte5nY
         DaaaTNzPSD100uOsKkyCUkKlQbf6G0Ic4yt1DO1IYtB7HfWpGRmayona1P2R397UbmAO
         93d9AuD/F3TssouAjyGh9LJsZnkT+Gmt4NR+BBB+K0wpyMsAf0y1A35L7jYTy1LW0cHk
         aPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=g5G/M59/Xh3PXzwrt0Y2GoE1s5ET1sF91l3s8qx+Gtk=;
        b=SZfrQaXeChUGkHgwEuiZbETibjilb/Ic6YXXT9wB+N6U5oRTDfbonMV9KYfjPaRr6G
         Sw1vOpYEP5mQiOOR0aZXXOTnFhwZIqQOtVa+RAlgC8+y5dMfRA3WCD3Ay/Z6+8AVn+Xr
         LZVsweZoR8GUGy+JISRsZ06kcN15xXMmFXexH6NBRprU5Fkkmwv7iIkU66H86ETtsLgF
         cbQkGatVSl6oWLbhn0IaWWlwtqWpX4Mpu3fz8fpC40bzgLeNuFRsxI5r9dHjbE6EuCpI
         zb6/c8nSs212qrGgg+T1g6Jf4Kfxt5jwhO3Lkw+O4UjJHlf6RgBcHZUXS3SSJJFAvPBV
         2nfQ==
X-Gm-Message-State: ABUngveepFETVfRH9u3h39fsNM0DHDokyQCVD6dy6p9q8ntv8fDq7IJkIBvU4JGxbjPXCBUy+spjm3PFuXy0fLK9
X-Received: by 10.55.20.164 with SMTP id 36mr7726480qku.86.1478546024117; Mon,
 07 Nov 2016 11:13:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Mon, 7 Nov 2016 11:13:43 -0800 (PST)
In-Reply-To: <1478543491-6286-1-git-send-email-dturner@twosigma.com>
References: <1478543491-6286-1-git-send-email-dturner@twosigma.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 7 Nov 2016 11:13:43 -0800
Message-ID: <CAGZ79kbp82VssqutEg5=TnciQrGkDRQ3iNm_vUo9eBBGMXQRNg@mail.gmail.com>
Subject: Re: [PATCH] submodules: allow empty working-tree dirs in merge/cherry-pick
To:     David Turner <dturner@twosigma.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 7, 2016 at 10:31 AM, David Turner <dturner@twosigma.com> wrote:
> When a submodule is being merged or cherry-picked into a working
> tree that already contains a corresponding empty directory, do not
> record a conflict.
>
> One situation where this bug appears is:
>
> - Commit 1 adds a submodule

"... at sub1" as inferred by text below.

> - Commit 2 removes that submodule and re-adds it into a subdirectory
>        (sub1 to sub1/sub1).
> - Commit 3 adds an unrelated file.
>
> Now the user checks out commit 1 (first deinitializing the submodule),
> and attempts to cherry-pick commit 3.  Previously, this would fail,
> because the incoming submodule sub1/sub1 would falsely conflict with
> the empty sub1 directory.

So you'd want to achieve:
  $ # on commit 3:
  git checkout <commit 1>
  git cherry-pick <commit 3>

which essentially moves the gitlink back to its original place
(from sub1/sub1 -> sub1).  This sounds reasonable.
But what if the submodule contains a (file/directory)
named sub1? We'd first remove the sub1/sub1 submodule
(and even delete the inner directory?), such that "sub1/"
becomes an empty dir, which is perfect for having a
submodule right there at "sub1/"

>
> This patch ignores the empty sub1 directory, fixing the bug.  We only
> ignore the empty directory if the object being emplaced is a
> submodule, which expects an empty directory.
>
> Signed-off-by: David Turner <dturner@twosigma.com>
> ---
>  merge-recursive.c           | 21 +++++++++++++++------
>  t/t3030-merge-recursive.sh  |  4 ++--
>  t/t3426-rebase-submodule.sh |  3 ---
>  3 files changed, 17 insertions(+), 11 deletions(-)
>
> Note that there are four calls to dir_in_way, and only two of them
> have changed their semantics.  This is because the merge code is quite
> complicated, and I don't fully understand it.

A good approach. I was trying to haggle with unpack-trees.c and
the merging code and put way more on my plate than I could eat
in one sitting. Trying to get the mess sorted now to prepare a patch
series this week.

> So I did not have time
> to analyze the remaining calls to see whether they, too, should be
> changed.

The call in line 1205 (in handle_file, which is only called from
conflict_rename_rename_1to2) may be relevant if we move around
submodules on the same level and modifying it in different branches.
However I think preserving current behavior is ok.

The other one in handle_change_delete also doesn't look obvious
one way or another, so I'd stick with current behavior.

>For me, there are no test failures either way, indicating
> that probably these cases are rare.

The tests have to be crafted for this specific code pattern,

>
> The reason behind the empty_ok parameter (as opposed to just always
> allowing empy directories to be blown away) is found in t6022's 'pair
> rename to parent of other (D/F conflicts) w/ untracked dir'.  This
> test would fail with an unconditional rename, because it wouldn't
> generate the conflict file.

Or the submodule from your commit message contains a "sub1/..." itself.

>  It's not clear how important that
> behavior is (I do not recall ever noticing the file~branch thing
> before), but it seemed better to preserve it in case it was important.
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 9041c2f..e64b48b 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -664,7 +664,13 @@ static char *unique_path(struct merge_options *o, const char *path, const char *
>         return strbuf_detach(&newpath, NULL);
>  }
>
> -static int dir_in_way(const char *path, int check_working_copy)
> +/**
> + * Check whether a directory in the index is in the way of an incoming
> + * file.  Return 1 if so.  If check_working_copy is non-zero, also
> + * check the working directory.  If empty_ok is non-zero, also return
> + * 0 in the case where the working-tree dir exists but is empty.
> + */

Thanks for the documenting comment! This is probably fine as is with just
two boolean parameters. If we'd add more, we might have thought about
adding a flags parameter with bits for each flag.

Looks good to me,
Thanks,
Stefan
