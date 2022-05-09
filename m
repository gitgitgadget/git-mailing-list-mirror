Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE19C433FE
	for <git@archiver.kernel.org>; Mon,  9 May 2022 19:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240584AbiEIT2y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 15:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240567AbiEIT2w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 15:28:52 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0771E3EF7
        for <git@vger.kernel.org>; Mon,  9 May 2022 12:24:57 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 202so12840836pgc.9
        for <git@vger.kernel.org>; Mon, 09 May 2022 12:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Vzhfl2TrlUxIoDZcs/rVCgmBycA8wLWV92iCErWOifA=;
        b=i3U/7hcTkJZL400fvWwcfsZ0rk/RU3sR7ZrBx85gO1NceYHQf6zNi8hrhTgT51hD/g
         0WdQkrFh2cjClgLdGPp9giRbtiTSlphkybsfA3uaupQQ32eqZfWvKcuyliiaaOCYQoNH
         TJApcycFwZsU+z3Fxkz12RJzuSsThv2JsOFOX2UPegeu9jrjdrh7lTYq/U8IKLqGQz8b
         nKLoEysrDLWCay6Q3gV2VMXw4LoZTHsykZ29kqdGdU5tx7oLsnxKZN7hw4lJVXnoU5XL
         DL9Nb4mtj1GO8FvFKK/v2tQN7Cvlxjs6eoJhhy1PWN/+dyhs4WnhTJLuwOd2WRSAmzaD
         u9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Vzhfl2TrlUxIoDZcs/rVCgmBycA8wLWV92iCErWOifA=;
        b=X15bE1eRpfiuHZMt4krZPpUd6TRApm/dwelhxED5Z78ENPufK+ZVlZTz4OcBtLC+jW
         TZ/+DtmYaMiyZyxGk4Z438wcJR4Xv0bOZV2fPe/OZrGKjSOzESdgjf1NeMi0DaJO2gcU
         pfS7lH31qNzggflcnX6z1+hFj/cL3ryCSyJ8JeOdkMFaMm3Ptd0sG9gXPqH/l8x6LHQm
         brDb1rDeZQsfdNJNgE2JibJDPTmWiIPksrWDlnUdTaHiT1O7ZkJyklsd28fmMDvuyKBv
         Tj9BnE0a43KNgZIyVDbexNYYyNvLOWeXXtnDiHarY33kef6fsqAtUo1qdKadOq/T3KWk
         Dncw==
X-Gm-Message-State: AOAM532v36ACZdB4O9P+a/KiTGufk16B65wYvgYKpKsh2kIfH5p7I1k8
        Wr08RdMJOfv2wnPXTxxHITQh
X-Google-Smtp-Source: ABdhPJx8rvZbbi64QHt1d7m7jH9RtZXZ88a0pRUO6xLXwV+KhYHFrzJcrKzg9JJTQVtDSvVAF3wNFg==
X-Received: by 2002:a05:6a00:15c2:b0:510:6d56:730 with SMTP id o2-20020a056a0015c200b005106d560730mr17319186pfu.62.1652124297108;
        Mon, 09 May 2022 12:24:57 -0700 (PDT)
Received: from [192.168.0.102] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id s16-20020a632150000000b003c63ae859d3sm7213838pgm.83.2022.05.09.12.24.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 12:24:56 -0700 (PDT)
Message-ID: <65dd1914-137e-d9ba-ee1f-7611e5f71d30@github.com>
Date:   Mon, 9 May 2022 12:24:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v2 5/7] merge-recursive: add merge function arg to
 'merge_recursive_generic'
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.1171.git.1650908957.gitgitgadget@gmail.com>
 <pull.1171.v2.git.1651083378.gitgitgadget@gmail.com>
 <4537d473b937b182cd79b2f3c5673b75d92cab23.1651083378.git.gitgitgadget@gmail.com>
 <CABPp-BHcWjOeVhRD_XKTko0OH2pwYsuCt8PzH=C_0u_gUWe0GQ@mail.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <CABPp-BHcWjOeVhRD_XKTko0OH2pwYsuCt8PzH=C_0u_gUWe0GQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Wed, Apr 27, 2022 at 11:16 AM Victoria Dye via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Victoria Dye <vdye@github.com>
>>
>> Replace the hardcoded 'merge_recursive()' function used by the
>> 'merge_recursive_generic()' with a caller-specific merge function. This will
>> allow us to use 'merge_ort_recursive()' (and therefore avoid the index
>> expansion of 'merge_recursive()') in commands that perform merges with
>> 'merge_recursive_generic()', such as 'git stash pop'.
>>
>> Note that this patch is strictly a refactor; all callers still use
>> 'merge_recursive()', and any changing to 'merge_ort_recursive()' will be
>> done in a later commit.
> 
> I'm not sure if we can gut merge_recursive_generic(), but I don't
> think stash should use it...
> 
>> Signed-off-by: Victoria Dye <vdye@github.com>
>> ---
>>  builtin/am.c              | 2 +-
>>  builtin/merge-recursive.c | 2 +-
>>  builtin/stash.c           | 2 +-
>>  merge-ort.c               | 3 ++-
>>  merge-recursive.c         | 4 ++--
>>  merge-recursive.h         | 9 ++++++++-
>>  6 files changed, 15 insertions(+), 7 deletions(-)
>>
>> diff --git a/builtin/am.c b/builtin/am.c
>> index 0f4111bafa0..6d01185d122 100644
>> --- a/builtin/am.c
>> +++ b/builtin/am.c
>> @@ -1614,7 +1614,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
>>         if (state->quiet)
>>                 o.verbosity = 0;
>>
>> -       if (merge_recursive_generic(&o, &our_tree, &their_tree, 1, bases, &result)) {
>> +       if (merge_recursive_generic(&o, &our_tree, &their_tree, 1, bases, merge_recursive, &result)) {
>>                 repo_rerere(the_repository, state->allow_rerere_autoupdate);
>>                 free(their_tree_name);
>>                 return error(_("Failed to merge in the changes."));
>> diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
>> index b9acbf5d342..687ed1e527b 100644
>> --- a/builtin/merge-recursive.c
>> +++ b/builtin/merge-recursive.c
>> @@ -81,7 +81,7 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
>>         if (o.verbosity >= 3)
>>                 printf(_("Merging %s with %s\n"), o.branch1, o.branch2);
>>
>> -       failed = merge_recursive_generic(&o, &h1, &h2, bases_count, bases, &result);
>> +       failed = merge_recursive_generic(&o, &h1, &h2, bases_count, bases, merge_recursive, &result);
>>
>>         free(better1);
>>         free(better2);
>> diff --git a/builtin/stash.c b/builtin/stash.c
>> index 1bfba532044..16171eb1dab 100644
>> --- a/builtin/stash.c
>> +++ b/builtin/stash.c
>> @@ -554,7 +554,7 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
>>         bases[0] = &info->b_tree;
>>
>>         ret = merge_recursive_generic(&o, &c_tree, &info->w_tree, 1, bases,
>> -                                     &result);
>> +                                     merge_recursive, &result);
>>         if (ret) {
>>                 rerere(0);
>>
>> diff --git a/merge-ort.c b/merge-ort.c
>> index 8545354dafd..4bccdfcf355 100644
>> --- a/merge-ort.c
>> +++ b/merge-ort.c
>> @@ -4737,7 +4737,8 @@ void merge_incore_recursive(struct merge_options *opt,
>>         trace2_region_enter("merge", "incore_recursive", opt->repo);
>>
>>         /* We set the ancestor label based on the merge_bases */
>> -       assert(opt->ancestor == NULL);
>> +       assert(opt->ancestor == NULL ||
>> +              !strcmp(opt->ancestor, "constructed merge base"));
> 
> ...and here's one of the reasons why.  The fact that
> merge_recursive_generic() uses this string when exactly one merge base
> is passed is something that is only correct for git-am; it is wrong
> and actively misleading for git-stash since it has a real merge base
> that is not internally constructed by the operation using the merge
> machinery.  (The merge base it uses is something like $STASH^1, IIRC.)
> 
> In fact, this was half the coin around why merge_recursive_generic()
> wasn't converted when merge-ort was written; see
> https://lore.kernel.org/git/CABPp-BHW61zA+MefvWK47iVZKY97rxc2XZ-NjXzuJxEhgSLqUw@mail.gmail.com/
> and https://lore.kernel.org/git/CABPp-BFr=1iVY739cfh-1Hp82x-Mny-k4y0f3zZ_YuP3PxiGfQ@mail.gmail.com/
> for more details.
> 

All of that makes sense, thanks for the context!

> The use of merge_recursive_generic() by stash is also a bit weird;
> most of the time, stash is going to have actual commits instead of
> just trees.  But stash dereferences those commits to trees, passes
> them to merge_recursive_generic(), and then merge_recursive_generic()
> has to create fake commits containing those trees, because the merge
> machinery wants commits.  It feels a bit like a Rube Goldberg machine.
> Also, stash also always calls merge_recursive_generic() with exactly
> one merge base, which together with having real commits both kind of
> defeat the need for "generic".    I think stash should just use
> merge_trees()/merge_incore_nonrecursive() directly (much as
> sequencer.c does).  The only special case to worry about with stash is
> when c_tree != HEAD^{tree}, i.e. when applying changes on top of
> already present changes instead of just on top of HEAD.  But in that
> case, I think stash should be the thing to create a fake commit rather
> than invoking some wrapper that will create fake commits for all three
> trees.
> 

I'm a bit confused about this. The non-recursive merge functions
('merge_trees()' & 'merge_ort_nonrecursive()' or the lower-level
'merge_incore_nonrecursive()') merge trees, not commits, so performing a
non-recursive merge requires dereferencing commits to trees anyway. I think
I agree with your other message [1] that the 'stash' merge doesn't need to
merge recursively, but that would mean it also doesn't use the commits
*directly* (i.e., as arguments in the merge). 

Apologies if I'm missing something obvious, but I want to make sure I
understand your suggestion.

[1] https://lore.kernel.org/git/CABPp-BFANwZn73w8zrVySB7mh0bQQBdGJjBuSJy50UOeyYT6aA@mail.gmail.com/ 


>>         trace2_region_enter("merge", "merge_start", opt->repo);
>>         merge_start(opt, result);
>> diff --git a/merge-recursive.c b/merge-recursive.c
>> index 1ee6364e8b1..2088f5c5fb3 100644
>> --- a/merge-recursive.c
>> +++ b/merge-recursive.c
>> @@ -3806,6 +3806,7 @@ int merge_recursive_generic(struct merge_options *opt,
>>                             const struct object_id *merge,
>>                             int num_merge_bases,
>>                             const struct object_id **merge_bases,
>> +                           recursive_merge_fn_t merge_fn,
>>                             struct commit **result)
>>  {
>>         int clean;
>> @@ -3829,8 +3830,7 @@ int merge_recursive_generic(struct merge_options *opt,
>>         }
>>
>>         repo_hold_locked_index(opt->repo, &lock, LOCK_DIE_ON_ERROR);
>> -       clean = merge_recursive(opt, head_commit, next_commit, ca,
>> -                               result);
>> +       clean = merge_fn(opt, head_commit, next_commit, ca, result);
>>         if (clean < 0) {
>>                 rollback_lock_file(&lock);
>>                 return clean;
>> diff --git a/merge-recursive.h b/merge-recursive.h
>> index b88000e3c25..6a21f2da538 100644
>> --- a/merge-recursive.h
>> +++ b/merge-recursive.h
>> @@ -53,6 +53,12 @@ struct merge_options {
>>         struct merge_options_internal *priv;
>>  };
>>
>> +typedef int (*recursive_merge_fn_t)(struct merge_options *opt,
>> +                                   struct commit *h1,
>> +                                   struct commit *h2,
>> +                                   struct commit_list *merge_bases,
>> +                                   struct commit **result);
>> +
>>  void init_merge_options(struct merge_options *opt, struct repository *repo);
>>
>>  /* parse the option in s and update the relevant field of opt */
>> @@ -105,7 +111,7 @@ int merge_recursive(struct merge_options *opt,
>>
>>  /*
>>   * merge_recursive_generic can operate on trees instead of commits, by
>> - * wrapping the trees into virtual commits, and calling merge_recursive().
>> + * wrapping the trees into virtual commits, and calling the provided merge_fn.
>>   * It also writes out the in-memory index to disk if the merge is successful.
>>   *
>>   * Outputs:
>> @@ -120,6 +126,7 @@ int merge_recursive_generic(struct merge_options *opt,
>>                             const struct object_id *merge,
>>                             int num_merge_bases,
>>                             const struct object_id **merge_bases,
>> +                           recursive_merge_fn_t merge_fn,
>>                             struct commit **result);
>>
>>  #endif
>> --
>> gitgitgadget

