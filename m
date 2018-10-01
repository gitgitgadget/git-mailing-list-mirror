Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EC6A1F453
	for <e@80x24.org>; Mon,  1 Oct 2018 19:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbeJBBz0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Oct 2018 21:55:26 -0400
Received: from mout.web.de ([212.227.17.12]:38199 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbeJBBz0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Oct 2018 21:55:26 -0400
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LxODe-1fdvxZ2Zpa-016vD3; Mon, 01
 Oct 2018 21:16:03 +0200
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LxODe-1fdvxZ2Zpa-016vD3; Mon, 01
 Oct 2018 21:16:03 +0200
Subject: Re: [PATCH 15/16] commit-reach: make can_all_from_reach... linear
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.10.git.gitgitgadget@gmail.com>
 <816821eec9ba476ccdfbfdf6e3cdd3619743ea2e.1531746012.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <d1b58614-989f-5998-6c53-c19eee409a2f@web.de>
Date:   Mon, 1 Oct 2018 21:16:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <816821eec9ba476ccdfbfdf6e3cdd3619743ea2e.1531746012.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:NteczQnW4kehkb2QvUJh5GVd5YL60YLdXYsIg/odOEdBN8aRElJ
 veM+foh+1NXBhHtiNHmAa9fjPUm47p2b8MyBZD6520w4lyjtUQWESa3BEisO+vwvcGJ68NZ
 YClMXKKh8EetBTN8Rb8C5f4e3d5OY8BtSPUn52XQDkHxumHVKpaoj0gfF9x+X5BDC/axHMP
 krw8zRApiUfdcc4ooC+Xg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LSU0MxGxy3w=:QrIWozkEwzH9tT8aCKnkTi
 A+xC/S8VAcdG2FoqrcBbrkEa/YMM7baGgtJow8xqF8bDlEt7aY+pVhmo8KYUqaH2Ng3WyY70b
 Dii7ZcZN/BpJL32tiYDz4P0rl4xTxnFQLheS4/NblQIIzzBbrM+s0nRtO5/6umGaVdLq6sBsZ
 jYilj4+bn8F/60uF8NTHVj2SGK6vhuN8/0DBWv6AYOZTEb92PH8jj6okfeKGjkKJlU334stjd
 vyX8MfD1Jymi5XQucrMOEeKy0G6K5SpM7Z1Osoop+wtesV1rQyFdSMCh4HG/3aOAe21/9TsU3
 /ZNxoBtNNCtws31Kdq3IlaT0phj3NkubT+CVD8ST7keUxslN/iT7GhqrA8bavAXIEIFWI2Rnw
 0hHfIOVsdl+O/NzMCen6nMz75XjwT373y2oVeid5OnA1USh4uGJ4Xx/kMAxcca+DvC9hJYD5S
 6r0gRa4vdOFbeNWlp5yCCN1h38PqyE1M0Hzib0LSA3zkOwhCsw5hZM80BdC5aAH5sYtjrHFOw
 umIDaLBWeqZz47/ZC5zJx9p9mnNbU+zrENlrM51LtllSeX8CehCKYWgVmhYEnS/qwWqO+7iTn
 frJCZ2jvLClMrBrZg4DBXFWjKzGJWTvIH2f2lHd49u0L/WTjADoZzMfZtP8fMJOt/MJuEpA6E
 PDS0vv1YjKtQLd/d4Op/ql86Vht9lFXjEBuiE88PWv4oe7Wa8bYzY4ygiFuRtML6s3PsjjCvF
 jnWQYKlGr3xmE97jWRUNUby21HLwIcOOZStU8ah+qG8RICIV316Pp/YAZF6cHoOV/wPFbpxeu
 CL/5Osqr+iJZGNylPeXHfMap5EAKBS+9dEgL6NBnZpUI5i4DtI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.06.2018 um 14:31 schrieb Derrick Stolee via GitGitGadget:
> diff --git a/commit-reach.c b/commit-reach.c
> index c58e50fbb..ac132c8e4 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -513,65 +513,88 @@ int commit_contains(struct ref_filter *filter, struct commit *commit,
>  	return is_descendant_of(commit, list);
>  }
>  
> -int reachable(struct commit *from, int with_flag, int assign_flag,
> -	      time_t min_commit_date)
> +static int compare_commits_by_gen(const void *_a, const void *_b)
>  {
> -	struct prio_queue work = { compare_commits_by_commit_date };
> +	const struct commit *a = (const struct commit *)_a;
> +	const struct commit *b = (const struct commit *)_b;

This cast is bogus.  QSORT gets handed a struct commit **, i.e. an array
of pointers, and qsort(1) passes references to those pointers to the
compare function, and not the pointer values.

As a result it's unlikely that the array is sorted in the intended
order.  Given that, a silly question: Is sorting even necessary here?

Anyway, the patch below should fix it.

>  
> -	prio_queue_put(&work, from);
> -	while (work.nr) {
> -		struct commit_list *list;
> -		struct commit *commit = prio_queue_get(&work);
> -
> -		if (commit->object.flags & with_flag) {
> -			from->object.flags |= assign_flag;
> -			break;
> -		}
> -		if (!commit->object.parsed)
> -			parse_object(the_repository, &commit->object.oid);
> -		if (commit->object.flags & REACHABLE)
> -			continue;
> -		commit->object.flags |= REACHABLE;
> -		if (commit->date < min_commit_date)
> -			continue;
> -		for (list = commit->parents; list; list = list->next) {
> -			struct commit *parent = list->item;
> -			if (!(parent->object.flags & REACHABLE))
> -				prio_queue_put(&work, parent);
> -		}
> -	}
> -	from->object.flags |= REACHABLE;
> -	clear_commit_marks(from, REACHABLE);
> -	clear_prio_queue(&work);
> -	return (from->object.flags & assign_flag);
> +	if (a->generation < b->generation)
> +		return -1;
> +	if (a->generation > b->generation)
> +		return 1;
> +	return 0;
>  }
>  
>  int can_all_from_reach_with_flag(struct object_array *from,
>  				 int with_flag, int assign_flag,
> -				 time_t min_commit_date)
> +				 time_t min_commit_date,
> +				 uint32_t min_generation)
>  {
> +	struct commit **list = NULL;
>  	int i;
> +	int result = 1;
>  
> +	ALLOC_ARRAY(list, from->nr);
>  	for (i = 0; i < from->nr; i++) {
> -		struct object *from_one = from->objects[i].item;
> +		list[i] = (struct commit *)from->objects[i].item;
>  
> -		if (from_one->flags & assign_flag)
> -			continue;
> -		from_one = deref_tag(the_repository, from_one, "a from object", 0);
> -		if (!from_one || from_one->type != OBJ_COMMIT) {
> -			/* no way to tell if this is reachable by
> -			 * looking at the ancestry chain alone, so
> -			 * leave a note to ourselves not to worry about
> -			 * this object anymore.
> -			 */
> -			from->objects[i].item->flags |= assign_flag;
> -			continue;
> -		}
> -		if (!reachable((struct commit *)from_one, with_flag, assign_flag,
> -			       min_commit_date))
> +		parse_commit(list[i]);
> +
> +		if (list[i]->generation < min_generation)
>  			return 0;
>  	}
> -	return 1;
> +
> +	QSORT(list, from->nr, compare_commits_by_gen);

-- >8 --
Subject: [PATCH] commit-reach: fix cast in compare_commits_by_gen()

The elements of the array to be sorted are commit pointers, so the
comparison function gets handed references to these pointers, not
pointers to commit objects.  Cast to the right type and dereference
once to correctly get the commit reference.

Found using Clang's ASan and t5500.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
Has this patch a performance impact?

 commit-reach.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 00e5ceee6f..2f5e592d16 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -529,8 +529,8 @@ int commit_contains(struct ref_filter *filter, struct commit *commit,
 
 static int compare_commits_by_gen(const void *_a, const void *_b)
 {
-	const struct commit *a = (const struct commit *)_a;
-	const struct commit *b = (const struct commit *)_b;
+	const struct commit *a = *(const struct commit * const *)_a;
+	const struct commit *b = *(const struct commit * const *)_b;
 
 	if (a->generation < b->generation)
 		return -1;
-- 
2.19.0
