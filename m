Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772EEC05027
	for <git@archiver.kernel.org>; Fri, 17 Feb 2023 10:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjBQKu1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Feb 2023 05:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjBQKuY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2023 05:50:24 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7B35BBF
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 02:50:19 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id z12-20020a1c4c0c000000b003e21e018039so2130340wmf.3
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 02:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xQVuYT9cSGwZBnA6o9Exj5KNk8AHmw4epVzmYfutgFQ=;
        b=THCPNTN9Pvnbc4+V8c4UxTH2AOs0X1cbpuvA9wPiGXX+/JX4OjWGIs8gUjcHdpCrOG
         I1MXR8OWhnFYkTSED56Rzscqnj+bmK/b7OWFQsFsLqRIGGA2fKp2NU0zLOIY1+W4tgH2
         qi7o+JUyTeMJuFQ1aN6Ni8hiR4Zr8PLq2RNvTI7f1AnO2FiAffj1BVmPRy83M7s08uCl
         poc/1HkcWYC/rAlW+kCIW4EJQ256hqL6gMB6QVGZW9oeU4PjKd+6By+b7/IYSG9L2STl
         aodYeI7w2WzNPR/RhY3eNhOOshtusIjH6/qRcTWiz0VmnMVAxMLlNdojygh+mw6uN0Pn
         GRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xQVuYT9cSGwZBnA6o9Exj5KNk8AHmw4epVzmYfutgFQ=;
        b=6fW4a2/jI+cqcKmy1qQfAVOjlleKhq1WVcvVTgD8ArUsos6Wsi/7GWOWPW2Z5+c+3K
         ufJcp7Dc8An56IV+ND+Ytu1gITdIwt/anhWxo4AHCNU5/6qxFM38kZff1f6mUu7+r5aO
         AOMqxMxweePQihU5+VTtsuk99RVPr1cr956Y31HXXNzgNgdIn3rRcWwW+/59X5cmje7Z
         psDZT/Fb+U3lGgGWtv1wg4cUf4vKbeRlPhITo1A561Rw1RLdmosJ1WUtAt6twMF5s7fe
         o3ICg0na2Sj7+kLxuXU8WRix5z1yq//eWmgR7eeQoeUOkuTB+sGjdjZu/oT37jFMILRL
         GntA==
X-Gm-Message-State: AO0yUKXoevjTpM2Zta5cvd6SxsoRZJ/0NRlg/kuJaifdJY0AqYYbDz5m
        8Mo1sWsC6SAf4soWx4HtkTCH4aPNUxc=
X-Google-Smtp-Source: AK7set+fPsa5vsySKVA8pnKm+ZNlktcL3DmLeLVtT0YyjnJFieNK5gBiz6t5LUBviyc34lBKjCSImg==
X-Received: by 2002:a05:600c:16d3:b0:3dc:5950:b358 with SMTP id l19-20020a05600c16d300b003dc5950b358mr8184796wmn.14.1676631017394;
        Fri, 17 Feb 2023 02:50:17 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id m17-20020a7bce11000000b003e209b45f6bsm5178549wmc.29.2023.02.17.02.50.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 02:50:16 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <437723a1-284d-e96c-9202-ae7bfcb830a9@dunelm.org.uk>
Date:   Fri, 17 Feb 2023 10:50:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] branch: introduce --(no-)has-upstream and --(no-)gone
 options
To:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        karthik.188@gmail.com, gitster@pobox.com
References: <20230216041432.1668365-1-alexhenrie24@gmail.com>
Content-Language: en-US
In-Reply-To: <20230216041432.1668365-1-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex

On 16/02/2023 04:14, Alex Henrie wrote:
> GitHub and GitLab have features to create a branch using the web
> interface, then delete the branch after it is merged. That results in a
> lot of "gone" branches in my local clone, and I frequently find myself
> typing `git branch -v | grep gone`. I don't want `git branch --merged`
> because that would include branches that have been created for future
> work but do not yet have any commits.
> 
> To avoid having to do error-prone string parsing, add options to filter
> branches by tracking status. The --has-upstream option lists branches
> that would be shown with a tracked branch in `git branch -vv` and the
> --gone option further restricts the list to branches that would be shown
> as [gone] in `git branch -v`. The --no-has-upstream and --no-gone
> options are their inverses.
> 
> The new options could be used, for example, to create an alias for
> deleting all branches that are both merged and gone:
> 
> git config alias.branch-prune '!git branch -d `git branch --gone --format="%(refname:short)"`'
> 
> In the future, an optional argument could be added to --has-upstream and
> --no-has-upstream to show or hide branches that track branches on a
> particular remote.

Rather than adding several new options with hard to understand names I 
wonder if it would be better to add a --filter option that can be 
extended in the future.

--filter upstream[=<pattern>]
   Limit the output to branches whose configured upstream matches
   <pattern>. If the optional pattern is omitted list all branches
   with a configured upstream. To list branches with no configured
   upstream use an empty pattern i.e. "upstream="

--filter pruneable[=<remote>]
   Limit the output to branches whose upstream has been removed by
   "git fetch --prune". If <remote> is given only list those branches
   whose upstream matches that remote.

We could allow --filter with --delete so one could run
     git branch --delete --filter pruneable=origin
to delete all the branches with a missing upstream on the remote origin.

If we wanted we could add "--filter contains=<commit>", "--filter 
merged=<commit>" and "--filter points-at=<commit>" and say the existing 
options are alias for those filters.

I'm not a heavy user of "git branch -v" but I found the talk of "gone" 
branches quite confusing, it might be clearer to say the the upstream 
branch is missing or that the branch is pruneable.

Best Wishes

Phillip


> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>   Documentation/git-branch.txt      | 15 ++++++
>   builtin/branch.c                  | 11 ++++-
>   ref-filter.c                      | 39 ++++++++++++++++
>   ref-filter.h                      |  3 ++
>   t/t3208-branch-tracking-filter.sh | 76 +++++++++++++++++++++++++++++++
>   5 files changed, 143 insertions(+), 1 deletion(-)
>   create mode 100755 t/t3208-branch-tracking-filter.sh
> 
> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> index d382ac69f7..99cd0486dc 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -13,6 +13,8 @@ SYNOPSIS
>   	[--column[=<options>] | --no-column] [--sort=<key>]
>   	[--merged [<commit>]] [--no-merged [<commit>]]
>   	[--contains [<commit>]] [--no-contains [<commit>]]
> +	[--has-upstream | --no-has-upstream]
> +	[--gone | --no-gone]
>   	[--points-at <object>] [--format=<format>]
>   	[(-r | --remotes) | (-a | --all)]
>   	[--list] [<pattern>...]
> @@ -325,6 +327,19 @@ superproject's "origin/main", but tracks the submodule's "origin/main".
>   	detached HEAD (if present) first, then local branches and
>   	finally remote-tracking branches. See linkgit:git-config[1].
>   
> +--has-upstream::
> +	Only list branches that track an upstream branch. Implies `--list`.
> +
> +--no-has-upstream::
> +	Only list branches that do not track an upstream branch. Implies `--list`.
> +
> +--gone::
> +	Only list branches that track a gone upstream branch. Implies `--list` and
> +	`--has-upstream`.
> +
> +--no-gone::
> +	Only list branches that do not track a gone upstream branch. Implies
> +	`--list`.
>   
>   --points-at <object>::
>   	Only list branches of the given object.
> diff --git a/builtin/branch.c b/builtin/branch.c
> index f63fd45edb..5cac6dc3c6 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -680,6 +680,14 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>   		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
>   		OPT_MERGED(&filter, N_("print only branches that are merged")),
>   		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
> +		OPT_SET_INT_F(0, "has-upstream", &filter.has_upstream,
> +			      N_("print only branches that track an upstream branch"), 1, PARSE_OPT_NONEG),
> +		OPT_SET_INT_F(0, "no-has-upstream", &filter.has_upstream,
> +			      N_("print only branches that do not track an upstream branch"), -1, PARSE_OPT_NONEG),
> +		OPT_SET_INT_F(0, "gone", &filter.upstream_gone,
> +			      N_("print only branches that track a gone upstream branch"), 1, PARSE_OPT_NONEG),
> +		OPT_SET_INT_F(0, "no-gone", &filter.upstream_gone,
> +			      N_("print only branches that do not track a gone upstream branch"), -1, PARSE_OPT_NONEG),
>   		OPT_COLUMN(0, "column", &colopts, N_("list branches in columns")),
>   		OPT_REF_SORT(&sorting_options),
>   		OPT_CALLBACK(0, "points-at", &filter.points_at, N_("object"),
> @@ -719,7 +727,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>   		list = 1;
>   
>   	if (filter.with_commit || filter.no_commit ||
> -	    filter.reachable_from || filter.unreachable_from || filter.points_at.nr)
> +	    filter.reachable_from || filter.unreachable_from ||
> +	    filter.points_at.nr || filter.has_upstream || filter.upstream_gone)
>   		list = 1;
>   
>   	noncreate_actions = !!delete + !!rename + !!copy + !!new_upstream +
> diff --git a/ref-filter.c b/ref-filter.c
> index f8203c6b05..a0f629bbf7 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -2358,6 +2358,42 @@ void ref_array_clear(struct ref_array *array)
>   	}
>   }
>   
> +static void do_tracking_filter(struct ref_filter_cbdata *ref_cbdata)
> +{
> +	struct ref_filter *filter = ref_cbdata->filter;
> +	struct ref_array *array = ref_cbdata->array;
> +	int i, old_nr;
> +
> +	old_nr = array->nr;
> +	array->nr = 0;
> +
> +	for (i = 0; i < old_nr; i++) {
> +		struct ref_array_item *item = array->items[i];
> +		const char *branch_name = item->refname;
> +		struct branch *branch;
> +		int num_ours, num_theirs, gone;
> +		const char *base;
> +
> +		skip_prefix(branch_name, "refs/heads/", &branch_name);
> +		branch = branch_get(branch_name);
> +		gone = stat_tracking_info(branch, &num_ours, &num_theirs,
> +					  &base, 0, AHEAD_BEHIND_QUICK) < 0;
> +
> +		if (filter->has_upstream == 1 && !base)
> +			goto remove;
> +		if (filter->has_upstream == -1 && base)
> +			goto remove;
> +		if (filter->upstream_gone == 1 && (!base || !gone))
> +			goto remove;
> +		if (filter->upstream_gone == -1 && base && gone)
> +			goto remove;
> +		array->items[array->nr++] = array->items[i];
> +		continue;
> +remove:
> +		free_array_item(item);
> +	}
> +}
> +
>   #define EXCLUDE_REACHED 0
>   #define INCLUDE_REACHED 1
>   static void reach_filter(struct ref_array *array,
> @@ -2466,6 +2502,9 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
>   	clear_contains_cache(&ref_cbdata.contains_cache);
>   	clear_contains_cache(&ref_cbdata.no_contains_cache);
>   
> +	if (filter->has_upstream || filter->upstream_gone)
> +		do_tracking_filter(&ref_cbdata);
> +
>   	/*  Filters that need revision walking */
>   	reach_filter(array, filter->reachable_from, INCLUDE_REACHED);
>   	reach_filter(array, filter->unreachable_from, EXCLUDE_REACHED);
> diff --git a/ref-filter.h b/ref-filter.h
> index aa0eea4ecf..3d0b321a16 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -57,6 +57,9 @@ struct ref_filter {
>   	struct commit_list *reachable_from;
>   	struct commit_list *unreachable_from;
>   
> +	int has_upstream;
> +	int upstream_gone;
> +
>   	unsigned int with_commit_tag_algo : 1,
>   		match_as_path : 1,
>   		ignore_case : 1,
> diff --git a/t/t3208-branch-tracking-filter.sh b/t/t3208-branch-tracking-filter.sh
> new file mode 100755
> index 0000000000..51e9453ffb
> --- /dev/null
> +++ b/t/t3208-branch-tracking-filter.sh
> @@ -0,0 +1,76 @@
> +#!/bin/sh
> +
> +test_description='branch tracking filter options'
> +
> +. ./test-lib.sh
> +
> +test_expect_success setup '
> +	git init --initial-branch=tracked-present r1 &&
> +	git -C r1 commit --allow-empty -m "Initial commit" &&
> +	git -C r1 branch upstream-only &&
> +	git -C r1 branch untracked &&
> +	git clone r1 r2 &&
> +	cd r2 &&
> +	git checkout -b tracked-gone &&
> +	git push --set-upstream origin tracked-gone &&
> +	git push origin :tracked-gone &&
> +	git branch --no-track untracked &&
> +	git branch downstream-only
> +'
> +
> +test_expect_success 'all local branches' '
> +	git branch >actual &&
> +	cat >expect <<-\EOF &&
> +	  downstream-only
> +	* tracked-gone
> +	  tracked-present
> +	  untracked
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'branch --has-upstream' '
> +	git branch --has-upstream >actual &&
> +	cat >expect <<-\EOF &&
> +	* tracked-gone
> +	  tracked-present
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'branch --no-has-upstream' '
> +	git branch --no-has-upstream >actual &&
> +	cat >expect <<-\EOF &&
> +	  downstream-only
> +	  untracked
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'branch --gone' '
> +	git branch --gone >actual &&
> +	cat >expect <<-\EOF &&
> +	* tracked-gone
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'branch --no-gone' '
> +	git branch --no-gone >actual &&
> +	cat >expect <<-\EOF &&
> +	  downstream-only
> +	  tracked-present
> +	  untracked
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'branch --has-upstream --no-gone' '
> +	git branch --has-upstream --no-gone >actual &&
> +	cat >expect <<-\EOF &&
> +	  tracked-present
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_done
