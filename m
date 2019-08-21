Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3432B1F461
	for <e@80x24.org>; Wed, 21 Aug 2019 15:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfHUPxe (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Aug 2019 11:53:34 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43315 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfHUPxd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Aug 2019 11:53:33 -0400
Received: by mail-qk1-f196.google.com with SMTP id m2so2228596qkd.10
        for <git@vger.kernel.org>; Wed, 21 Aug 2019 08:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FsS15lRZMKnW1ncPO/EVD2yNDe5Lqk0ZkeJgh23r4Ak=;
        b=EUTvThpSyMFDmtVcUycHC0ViGfaA7+mcqRBXx6ZuGEr3U8zNbLSsZ2gwtZ4AKGKkX4
         L4BS2Q76PR1d7Y5YqkacTWDEzZo6HLuJ6g5g/dG8eO6ngXEo0b3Oaqu5fm6g+n986oQN
         UC5CYWwsygxVT2Y8bYFxnGejRVwnmb3fEHJnPkd7YXsLAl3f7LsR+Uu8Zrm+M03LBixr
         OOtqhSHd2mlnicCjLDLgOFQGZppMApSCYmqw+gXl1lqvR9abkh9ZC3fl2KILfiCeu9U2
         2HL/7kwhCnYz8wg2nlHijQRDZ6/RHKqZvLT3X657WHGEMmApg6CNaaCpgTsgEolh/ERa
         wUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FsS15lRZMKnW1ncPO/EVD2yNDe5Lqk0ZkeJgh23r4Ak=;
        b=VSJTw1+yx80jP7hrM/joQgmcxh9cTwDq64ItQIdYolrJe5tpjPPttUeWQRoCJpGdtt
         8s9MxzmJCsY9hmGsWlsc5WD4zGjYO47eMH1tyeYBdCC+9Ej3mAVGhnc04ziwelQvc+J0
         0TnQiG34bxv2dQwQDRdZqWunIIYMlh9QG6wnMi8eu0hzNZOMUhVvulrSpDz9qy5GE0D2
         HLnBAxgCXV3w85Zfl9GQcgl8OHGFpQQH9YZKKFi/PpcAjmujomTjxvRyoon0wEDfNsbP
         Mp1eAGKuKAsC/UO8Its6R1FacFx4qKvizUIEHosIaiThEieu5Fg2lDCr/R7h/0iyThwv
         Qd7Q==
X-Gm-Message-State: APjAAAWwGHApg9SGYVm/cx/AdXnyFTAy+DMR3BGIOMLsxHeAcigE8UkW
        ugB0IsQ7VemdNj3wHSbZgFM=
X-Google-Smtp-Source: APXvYqxjEFUOFChVt3DOTZ1+Ao04WdiQUQiR736bAsJW3F86hkhKrpmO9NwsXbRP3WsF4a4jZY/Efw==
X-Received: by 2002:a37:a892:: with SMTP id r140mr33117722qke.435.1566402811926;
        Wed, 21 Aug 2019 08:53:31 -0700 (PDT)
Received: from [10.0.1.13] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id o18sm11180724qtt.4.2019.08.21.08.53.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2019 08:53:31 -0700 (PDT)
Subject: Re: [PATCH 2/2] line-log: avoid unnecessary full tree diffs
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>
References: <20190821110424.18184-1-szeder.dev@gmail.com>
 <20190821110424.18184-3-szeder.dev@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e52e867b-af17-d239-11b5-e0c6353acc2f@gmail.com>
Date:   Wed, 21 Aug 2019 11:53:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <20190821110424.18184-3-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/21/2019 7:04 AM, SZEDER Gábor wrote:
> With rename detection enabled the line-level log is able to trace the
> evolution of line ranges across whole-file renames [1].  Alas, to
> achieve that it uses the diff machinery very inefficiently, making the
> operation very slow [2].  And since rename detection is enabled by
> default, the line-level log is very slow by default.
> 
> When the line-level log processes a commit with rename detection
> enabled, it currently does the following (see queue_diffs()):
> 
>   1. Computes a full tree diff between the commit and (one of) its
>      parent(s), i.e. invokes diff_tree_oid() with an empty
>      'diffopt->pathspec'.
>   2. Checks whether any paths in the line ranges were modified.
>   3. Checks whether any modified paths in the line ranges are missing
>      in the parent commit's tree.
>   4. If there is such a missing path, then calls diffcore_std() to
>      figure out whether the path was indeed renamed based on the
>      previously computed full tree diff.
>   5. Continues doing stuff that are unrelated to the slowness.
> 
> So basically the line-level log computes a full tree diff for each
> commit-parent pair in step (1) to be used for rename detection in step
> (4) in the off chance that an interesting path is missing from the
> parent.
> 
> Avoid these expensive and mostly unnecessary full tree diffs by
> limiting the diffs to paths in the line ranges.  This is much cheaper,
> and makes step (2) unnecessary.  If it turns out that an interesting
> path is missing from the parent, then fall back and compute a full
> tree diff, so the rename detection will still work.

I applied your patches and tried them on our VFS-enabled version of Git
(see [1]). Unfortunately, the new logic is still triggering rename
detection, as measured by the number of objects being downloaded.

[1] https://github.com/microsoft/git/pull/182

My *guess* is that the repo has a lot of merge commits, and for many
of those, the file does not exist in the first parent. Since we are
essentially doing a --full-history, this means that edge tries a
rename detection. If we used the file-history simplification route of
traveling along a treesame edge instead of caring about both parents,
then maybe this would be avoided.

I could also be completely wrong about how this line-log code works
with regards to --full-history.

> Care must be taken when to update the pathspec used to limit the diff
> in case of renames.  A path might be renamed on one branch and
> modified on several parallel running branches, and while processing
> commits on these branches the line-level log might have to alternate
> between looking at a path's new and old name.  However, at any one
> time there is only a single 'diffopt->pathspec'.
> 
> So add a step (0) to the above to ensure that the paths in the
> pathspec match the paths in the line ranges associated with the
> currently processed commit, and re-parse the pathspec from the paths
> in the line ranges if they differ.
> 
> The new test cases include a specially crafted piece of history with
> two merged branches and two files, where each branch modifies both
> files, renames on of them, and then modifies both again.  Then two
> separate 'git log -L' invocations check the line-level log of each of
> those two files, which ensures that at least one of those invocations
> have to do that back-and-forth between the file's old and new name (no
> matter which branch is traversed first).  't/t4211-line-log.sh'
> already contains two tests involving renames, they don't don't trigger
> this back-and-forth.
> 
> Avoiding these unnecessary full tree diffs can have huge impact on
> performance, especially in big repositories with big trees and mergy
> history.  Tracing the evolution of a function through the whole
> history:
> 
>   # git.git
>   $ time git --no-pager log -L:read_alternate_refs:sha1-file.c v2.23.0
> 
>   Before:
> 
>     real    0m8.874s
>     user    0m8.816s
>     sys     0m0.057s
> 
>   After:
> 
>     real    0m2.516s
>     user    0m2.456s
>     sys     0m0.060s
> 
>   # linux.git
>   $ time ~/src/git/git --no-pager log \
>     -L:build_restore_work_registers:arch/mips/mm/tlbex.c v5.2
> 
>   Before:
> 
>     real    3m50.033s
>     user    3m48.041s
>     sys     0m0.300s
> 
>   After:
> 
>     real    0m2.599s
>     user    0m2.466s
>     sys     0m0.157s
> 
> That's just over 88x speedup.

These performance numbers are great! Please don't let my complaints of
"it doesn't work for my particularly bad example" be a deterrent to this
change. If I figure out what is going on in my case, then I can create
an update on top of your changes.

> diff --git a/line-log.c b/line-log.c
> index fddd91f060..9010e00950 100644
> --- a/line-log.c
> +++ b/line-log.c
> @@ -737,6 +737,22 @@ static struct line_log_data *lookup_line_range(struct rev_info *revs,
>  	return ret;
>  }
>  
> +static int same_paths_in_pathspec_and_range(struct pathspec *pathspec,
> +					    struct line_log_data *range)
> +{
> +	int i;
> +	struct line_log_data *r;
> +
> +	for (i = 0, r = range; i < pathspec->nr && r; i++, r = r->next)
> +		if (strcmp(pathspec->items[i].match, r->path))
> +			return 0;
> +	if (i < pathspec->nr || r)
> +		/* different number of pathspec items and ranges */
> +		return 0;
> +
> +	return 1;
> +}

This method is easy to digest. Looks correct.

> @@ -762,8 +778,7 @@ void line_log_init(struct rev_info *rev, const char *prefix, struct string_list
>  	range = parse_lines(rev->diffopt.repo, commit, prefix, args);
>  	add_line_range(rev, commit, range);
>  
> -	if (!rev->diffopt.detect_rename)
> -		parse_pathspec_from_ranges(&rev->diffopt.pathspec, range);
> +	parse_pathspec_from_ranges(&rev->diffopt.pathspec, range);
>  }

So we always parse the pathspec, even if we don't do detect renames.

> @@ -821,15 +836,29 @@ static void queue_diffs(struct line_log_data *range,
>  			struct diff_queue_struct *queue,
>  			struct commit *commit, struct commit *parent)
>  {
> +	struct object_id *tree_oid, *parent_tree_oid;
> +
>  	assert(commit);
>  
> +	tree_oid = get_commit_tree_oid(commit);
> +	parent_tree_oid = parent ? get_commit_tree_oid(parent) : NULL;
> +
> +	if (opt->detect_rename &&
> +	    !same_paths_in_pathspec_and_range(&opt->pathspec, range)) {
> +		clear_pathspec(&opt->pathspec);
> +		parse_pathspec_from_ranges(&opt->pathspec, range);
> +	}

If we are detecting renames and our pathspec is not up-to-date with the
range, then clear the pathspec and reparse. Makes sense.

>  	DIFF_QUEUE_CLEAR(&diff_queued_diff);
> -	diff_tree_oid(parent ? get_commit_tree_oid(parent) : NULL,
> -		      get_commit_tree_oid(commit), "", opt);
> +	diff_tree_oid(parent_tree_oid, tree_oid, "", opt);

(I rearranged a pair of -/+ lines in the diff to highlight this change.)

Makes sense, parent_tree_oid above was set using the same conditional.

> -	if (opt->detect_rename) {
> +	if (opt->detect_rename && diff_might_be_rename()) {

Here is the crux of the matter: diff_might_be_rename() can prevent
the full tree diff.

> +		/* must look at the full tree diff to detect renames */
> +		clear_pathspec(&opt->pathspec);
> +		DIFF_QUEUE_CLEAR(&diff_queued_diff);
> +
> +		diff_tree_oid(parent_tree_oid, tree_oid, "", opt);
> +
>  		filter_diffs_for_paths(range, 1);
> -		if (diff_might_be_rename())
> -			diffcore_std(opt);
> +		diffcore_std(opt);
>  		filter_diffs_for_paths(range, 0);
>  	}

So before, diff_might_be_rename() already prevented diffcore_std(), but
now it also prevents clearing the pathspec. diff_might_be_rename() has
a simple implementation:

static inline int diff_might_be_rename(void)
{
        int i;
        for (i = 0; i < diff_queued_diff.nr; i++)
                if (!DIFF_FILE_VALID(diff_queued_diff.queue[i]->one)) {
                        /* fprintf(stderr, "diff_might_be_rename found creation of: %s\n", */
                        /*      diff_queued_diff.queue[i]->two->path); */
                        return 1;
                }
        return 0;
}

So yes, it is triggered by any path appearing in the child but not
a parent.

>  	move_diff_queue(queue, &diff_queued_diff);
> diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
> index 1db7bd0f59..8319163744 100755
> --- a/t/t4211-line-log.sh
> +++ b/t/t4211-line-log.sh
> @@ -132,4 +132,86 @@ test_expect_success '--raw is forbidden' '
>  	test_must_fail git log -L1,24:b.c --raw
>  '
>  
> +test_expect_success 'setup for checking fancy rename following' '
> +	git checkout --orphan moves-start &&
> +	git reset --hard &&
> +
> +	printf "%s\n"    12 13 14 15      b c d e   >file-1 &&
> +	printf "%s\n"    22 23 24 25      B C D E   >file-2 &&
> +	git add file-1 file-2 &&
> +	test_tick &&
> +	git commit -m "Add file-1 and file-2" &&
> +	oid_add_f1_f2=$(git rev-parse --short HEAD) &&
> +
> +	git checkout -b moves-main &&
> +	printf "%s\n" 11 12 13 14 15      b c d e   >file-1 &&
> +	git commit -a -m "Modify file-1 on main" &&
> +	oid_mod_f1_main=$(git rev-parse --short HEAD) &&
> +
> +	printf "%s\n" 21 22 23 24 25      B C D E   >file-2 &&
> +	git commit -a -m "Modify file-2 on main #1" &&
> +	oid_mod_f2_main_1=$(git rev-parse --short HEAD) &&
> +
> +	git mv file-1 renamed-1 &&
> +	git commit -m "Rename file-1 to renamed-1 on main" &&
> +
> +	printf "%s\n" 11 12 13 14 15      b c d e f >renamed-1 &&
> +	git commit -a -m "Modify renamed-1 on main" &&
> +	oid_mod_r1_main=$(git rev-parse --short HEAD) &&
> +
> +	printf "%s\n" 21 22 23 24 25      B C D E F >file-2 &&
> +	git commit -a -m "Modify file-2 on main #2" &&
> +	oid_mod_f2_main_2=$(git rev-parse --short HEAD) &&
> +
> +	git checkout -b moves-side moves-start &&
> +	printf "%s\n"    12 13 14 15 16   b c d e   >file-1 &&
> +	git commit -a -m "Modify file-1 on side #1" &&
> +	oid_mod_f1_side_1=$(git rev-parse --short HEAD) &&
> +
> +	printf "%s\n"    22 23 24 25 26   B C D E   >file-2 &&
> +	git commit -a -m "Modify file-2 on side" &&
> +	oid_mod_f2_side=$(git rev-parse --short HEAD) &&
> +
> +	git mv file-2 renamed-2 &&
> +	git commit -m "Rename file-2 to renamed-2 on side" &&
> +
> +	printf "%s\n"    12 13 14 15 16 a b c d e   >file-1 &&
> +	git commit -a -m "Modify file-1 on side #2" &&
> +	oid_mod_f1_side_2=$(git rev-parse --short HEAD) &&
> +
> +	printf "%s\n"    22 23 24 25 26 A B C D E   >renamed-2 &&
> +	git commit -a -m "Modify renamed-2 on side" &&
> +	oid_mod_r2_side=$(git rev-parse --short HEAD) &&
> +
> +	git checkout moves-main &&
> +	git merge moves-side &&
> +	oid_merge=$(git rev-parse --short HEAD)
> +'
> +
> +test_expect_success 'fancy rename following #1' '
> +	cat >expect <<-EOF &&
> +	$oid_merge Merge branch '\''moves-side'\'' into moves-main
> +	$oid_mod_f1_side_2 Modify file-1 on side #2
> +	$oid_mod_f1_side_1 Modify file-1 on side #1
> +	$oid_mod_r1_main Modify renamed-1 on main
> +	$oid_mod_f1_main Modify file-1 on main
> +	$oid_add_f1_f2 Add file-1 and file-2
> +	EOF
> +	git log -L1:renamed-1 --oneline --no-patch >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'fancy rename following #2' '
> +	cat >expect <<-EOF &&
> +	$oid_merge Merge branch '\''moves-side'\'' into moves-main
> +	$oid_mod_r2_side Modify renamed-2 on side
> +	$oid_mod_f2_side Modify file-2 on side
> +	$oid_mod_f2_main_2 Modify file-2 on main #2
> +	$oid_mod_f2_main_1 Modify file-2 on main #1
> +	$oid_add_f1_f2 Add file-1 and file-2
> +	EOF
> +	git log -L1:renamed-2 --oneline --no-patch >actual &&
> +	test_cmp expect actual
> +'

These look to be suitably interesting test cases. Thanks!

Looking at your patch, I can mostly follow the logic, but my
unfamiliarity with the code is keeping me from being confident
in full understanding. I hope someone who is familiar can
chime in, because I really like the direction here.

Hopefully I will have time in the next few weeks to revisit
this and work to resolve my abnormal case.

-Stolee
