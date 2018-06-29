Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A7131F516
	for <e@80x24.org>; Fri, 29 Jun 2018 23:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754915AbeF2XSp (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 19:18:45 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:43607 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753477AbeF2XSo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 19:18:44 -0400
Received: by mail-yw0-f193.google.com with SMTP id r19-v6so4332660ywc.10
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 16:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nqQQZvx1i8rYcQXRXeWsr/4WgP3fSTm3PKz5TEqhWtY=;
        b=FkNAZvYdS2PQ67lYmXOTfGug8ZA9snwAFiZzkQ0ZT/n3u52F95shfrhwrwy98YTL+X
         HMcDoQ1I0tJ1D3AqcHoQg4shboK7agAOujYYj/2ypGledI5MASypkll2dMT3sM9x0YcM
         XsKaFZENLpvUGNWBaNGiZXCrGcEFejDOcq1Q4DTrId8A8GsQU5TfyA08B60/HCal+ikp
         +sQk6gSbuqDB2BVjMGDVqW9uYAmEbpjKjurlFwm/YVmKvJHafhhGzANV6zZ0H44Kui68
         IfUs6nkJ9wxvEt3iRtqwEFJDCCSOMUStE0tmkP4OMvmGbMJ1YbRuKZ/nYsa27sduwdu5
         hbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nqQQZvx1i8rYcQXRXeWsr/4WgP3fSTm3PKz5TEqhWtY=;
        b=eAyd9EWUNgez3xy0r8uL0i3a18RlANR1IkQUqbBnaR5mZiodwd5aSYybdQ7eZYLWWr
         Mx2A/asfn+Dfoe23uIfHmtIc3OzYkC+Br72fJ1zwwWyhf4H8tJqzIyk5bVAxoHRQtmoz
         PZxBSqvpvQIZYl+dQi0jt/qvx/FgIn+lRyCdm2/BBIuvvXb3h2uEC0pvCNmTykHL9shE
         i91nzcXSHz5/x0s2pjnRUGlgK02ir5+oUwbkpEFVAOc+Puk8PW5GCkbUZWuDbUyXGMZG
         z4yp6fnaNSgma9vA21icYDBsyILc3QWkiE1LvdEr6de9HvyJDRKjj6OUGo31TwFPA5rG
         dKUA==
X-Gm-Message-State: APt69E3FmVAGkE20L+cSesaSl6siXqPcBwvcPMKHl5lOk1fsflWBy9Za
        pioe1sTAOpfETzw294QyoNm08KwFbFKgyBkkTw7tzA==
X-Google-Smtp-Source: AAOMgpfa7Xar7AlY/e0B9Sk8VFZqGv/5FJN51YjocpUGEomMW5F20J57eFbSOqmuiMQtsKTinbP3ObaXg2xHibR4sOI=
X-Received: by 2002:a81:af67:: with SMTP id x39-v6mr4421084ywj.33.1530314322822;
 Fri, 29 Jun 2018 16:18:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180629161223.229661-1-dstolee@microsoft.com> <20180629161223.229661-12-dstolee@microsoft.com>
In-Reply-To: <20180629161223.229661-12-dstolee@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 29 Jun 2018 16:18:31 -0700
Message-ID: <CAGZ79kYM2KF3sKbxWCJQd4mbXNs=0RJiT8x=GP2tAUg4969q4w@mail.gmail.com>
Subject: Re: [RFC PATCH 11/13] commit-reach: make can_all_from_reach... linear
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 29, 2018 at 9:13 AM Derrick Stolee <dstolee@microsoft.com> wrote:
>
> The can_all_from_reach_with_flags() algorithm is currently quadratic in
> the worst case, because it calls the reachable() method for every 'from'
> without tracking which commits have already been walked or which can
> already reach a commit in 'to'.
>
> Rewrite the algorithm to walk each commit a constant number of times.
>
> We also add some optimizations that should work for the main consumer of
> this method: fetch negotitation (haves/wants).
>
> The first step includes using a depth-first-search (DFS) from each from
> commit, sorted by ascending generation number. We do not walk beyond the
> minimum generation number or the minimum commit date. This DFS is likely
> to be faster than the existing reachable() method because we expect
> previous ref values to be along the first-parent history.
>
> If we find a target commit, then we mark everything in the DFS stack as
> a RESULT. This expands the set of targets for the other from commits. We
> also mark the visited commits using 'assign_flag' to prevent re-walking
> the same code.
>
> We still need to clear our flags at the end, which is why we will have a
> total of three visits to each commit.
>
> Performance was measured on the Linux repository using
> 'test-tool reach can_all_from_reach'. The input included rows seeded by
> tag values. The "small" case included X-rows as v4.[0-9]* and Y-rows as
> v3.[0-9]*. This mimics a (very large) fetch that says "I have all major
> v3 releases and want all major v4 releases." The "large" case included
> X-rows as "v4.*" and Y-rows as "v3.*". This adds all release-candidate
> tags to the set, which does not greatly increase the number of objects
> that are considered, but does increase the number of 'from' commits,
> demonstrating the quadratic nature of the previous code.
>
> Small Case
> ----------
>
> Before: 1.45 s
>  After: 0.34 s
>
> Large Case
> ----------
>
> Before: 5.83 s
>  After: 0.37 s
>
> Note how the time increases between the two cases in the two versions.
> The new code increases relative to the number of commits that need to be
> walked, but not directly relative to the number of 'from' commits.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit-reach.c | 122 ++++++++++++++++++++++++++++++-------------------
>  commit-reach.h |   3 +-
>  upload-pack.c  |   5 +-
>  3 files changed, 82 insertions(+), 48 deletions(-)
>
> diff --git a/commit-reach.c b/commit-reach.c
> index 992ad5cdc7..8e24455d9f 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -530,64 +530,88 @@ int commit_contains(struct ref_filter *filter, struct commit *commit,
>         return is_descendant_of(commit, list);
>  }
>
> -static int reachable(struct commit *from, int with_flag, int assign_flag, time_t min_commit_date)
> +static int compare_commits_by_gen(const void *_a, const void *_b)
>  {
> -       struct prio_queue work = { compare_commits_by_commit_date };
> +       const struct commit *a = (const struct commit *)_a;
> +       const struct commit *b = (const struct commit *)_b;
>
> -       prio_queue_put(&work, from);
> -       while (work.nr) {
> -               struct commit_list *list;
> -               struct commit *commit = prio_queue_get(&work);
> -
> -               if (commit->object.flags & with_flag) {
> -                       from->object.flags |= assign_flag;
> -                       break;
> -               }
> -               if (!commit->object.parsed)
> -                       parse_object(&commit->object.oid);
> -               if (commit->object.flags & TMP_MARK)
> -                       continue;
> -               commit->object.flags |= TMP_MARK;
> -               if (commit->date < min_commit_date)
> -                       continue;
> -               for (list = commit->parents; list; list = list->next) {
> -                       struct commit *parent = list->item;
> -                       if (!(parent->object.flags & TMP_MARK))
> -                               prio_queue_put(&work, parent);
> -               }
> -       }
> -       from->object.flags |= TMP_MARK;
> -       clear_commit_marks(from, TMP_MARK);
> -       clear_prio_queue(&work);
> -       return (from->object.flags & assign_flag);
> +       if (a->generation < b->generation)
> +               return -1;
> +       if (a->generation > b->generation)
> +               return 1;
> +       return 0;
>  }
>
>  int can_all_from_reach_with_flag(struct object_array *from,
>                                  int with_flag, int assign_flag,
> -                                time_t min_commit_date)
> +                                time_t min_commit_date,
> +                                uint32_t min_generation)
>  {
> +       struct commit **list = NULL;
>         int i;
> +       int result = 1;
>
> +       ALLOC_ARRAY(list, from->nr);
>         for (i = 0; i < from->nr; i++) {
> -               struct object *from_one = from->objects[i].item;
> +               list[i] = (struct commit *)from->objects[i].item;
>
> -               if (from_one->flags & assign_flag)
> -                       continue;
> -               from_one = deref_tag(from_one, "a from object", 0);
> -               if (!from_one || from_one->type != OBJ_COMMIT) {
> -                       /* no way to tell if this is reachable by
> -                        * looking at the ancestry chain alone, so
> -                        * leave a note to ourselves not to worry about
> -                        * this object anymore.
> -                        */
> -                       from->objects[i].item->flags |= assign_flag;
> -                       continue;
> -               }
> -               if (!reachable((struct commit *)from_one, with_flag,
> -                              assign_flag, min_commit_date))
> +               parse_commit(list[i]);
> +
> +               if (list[i]->generation < min_generation)
>                         return 0;
>         }
> -       return 1;
> +
> +       QSORT(list, from->nr, compare_commits_by_gen);
> +
> +       for (i = 0; i < from->nr; i++) {
> +               /* DFS from list[i] */
> +               struct commit_list *stack = NULL;
> +
> +               list[i]->object.flags |= assign_flag;
> +               commit_list_insert(list[i], &stack);
> +
> +               while (stack) {
> +                       struct commit_list *parent;
> +
> +                       if (stack->item->object.flags & with_flag) {
> +                               pop_commit(&stack);
> +                               continue;
> +                       }
> +
> +                       for (parent = stack->item->parents; parent; parent = parent->next) {
> +                               if (parent->item->object.flags & (with_flag | RESULT))
> +                                       stack->item->object.flags |= RESULT;
> +
> +                               if (!(parent->item->object.flags & assign_flag)) {
> +                                       parent->item->object.flags |= assign_flag;
> +
> +                                       parse_commit(parent->item);

We can use parse_commit here as it would print a warning and keep going?
