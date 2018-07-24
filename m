Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F8291F597
	for <e@80x24.org>; Tue, 24 Jul 2018 20:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388977AbeGXVzy (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 17:55:54 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:32833 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388765AbeGXVzy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 17:55:54 -0400
Received: by mail-qt0-f194.google.com with SMTP id c15-v6so5582285qtp.0
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 13:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UyJv0dfRUG62xlL7jTI0o0lmyw4xpXVpDQBHy033qTA=;
        b=bxNIb73m4D4jVLzLksQrw0aokpl71Bjj61zrokRL4XCOLamsa44IdQcjsxd1YZYSXX
         JSUz3E/u4Bdw3yhjyoUXBUS2QIX3reOw3IZWH9Awhf0x8wF07/8e8P9Db3B/uHw/HvaW
         hTvU4cnywhSH9X3QYOWzZc9p5vU7HQRv0Wxsbp7E7amvAmUIEWv/B0JZq8fwg6rrBCGR
         3x5MAUhk8BGiTDoD8EctgpJTLFcn72p9LradjR+cRjBnVZBna5CFDbbt6060Pr7jcwVG
         UakFSrHrIvK6VDWSrarP5bqmqMy/XgX4ReLXCO/EjWsNXGkPR6WV6tfCTxmS6hbgtJS0
         ft4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UyJv0dfRUG62xlL7jTI0o0lmyw4xpXVpDQBHy033qTA=;
        b=H7C0uD2KRF6dXWAskFjMCpJPUSppf917Qo8MklGQcZtoiINqfLHQJPVo62PyaqDe8a
         8HyMalnUiMvjVHBKuo49jEP5Eua2f8D0x6tZEq7tvF4NHMy8hWUeBAfRfXmi3+INrc4K
         397nw71E/4FyvBnWxLSYUD+D9kk6W0Wn4hLy8R/o/kf/jwuiWJQc61Cw4qkIXROnm/Uy
         2TzRlbeZlhiPQ0552CwtNT+cPdhuk7drptgEqGGj6zptyVGdfl/K+jn/FkXSuShHd7cC
         gvV4yS/pUYt6ZK2fljO9ci/s43tfQkm6esuqQs09T92bwcemqPobTEhLnBMlneu2FECO
         529g==
X-Gm-Message-State: AOUpUlF6rbJui0ky4o6P35Z5bjh+hrHGx1yKn7cX6X/VsthN/n752GCq
        UimoMWgnKPaCi0opyMamStgYn0b6
X-Google-Smtp-Source: AAOMgpf1XhNBjwKslfhQBurRHgWfJdhPqPVBM0vwLB4JZG6tMVLW3g8hcGLXo7yuG6U2ho8Fq7Jp6A==
X-Received: by 2002:ac8:3f24:: with SMTP id c33-v6mr17984849qtk.76.1532465258671;
        Tue, 24 Jul 2018 13:47:38 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id y15-v6sm7653354qki.75.2018.07.24.13.47.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 13:47:37 -0700 (PDT)
Subject: Re: [PATCH v1] checkout: optionally speed up "git checkout -b foo"
To:     Junio C Hamano <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <20180724180122.29212-1-benpeart@microsoft.com>
 <xmqqh8koxwwi.fsf@gitster-ct.c.googlers.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <ab8ee481-54fa-a014-69d9-8f621b136766@gmail.com>
Date:   Tue, 24 Jul 2018 16:47:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqh8koxwwi.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/24/2018 3:21 PM, Junio C Hamano wrote:
> Ben Peart <Ben.Peart@microsoft.com> writes:
> 
>> From: Ben Peart <Ben.Peart@microsoft.com>
>>
>> If the new core.optimizecheckout config setting is set to true, speed up
>> "git checkout -b foo" by avoiding the work to merge the working tree.  This
>> is valid because no merge needs to occur - only creating the new branch/
>> updating the refs. Any other options force it through the old code path.
>>
>> This change in behavior is off by default and behind the config setting so
>> that users have to opt-in to the optimized behavior.
> 
> 
> 
> 
>> We've been running with this patch internally for a long time but it was
>> rejected when I submitted it to the mailing list before because it
>> implicitly changes the behavior of checkout -b. Trying it again configured
>> behind a config setting as a potential solution for other optimizations to
>> checkout that could change the behavior as well.
>>
>> https://public-inbox.org/git/20180724042740.GB13248@sigill.intra.peff.net/T/#m75afe3ab318d23f36334cf3a6e3d058839592469
> 
> An incorrect link?  It does not look like a thread that explains
> what was previously submitted but failed.  The last paragraph looks
> like a fine material below the three-dash line.
> 

See my earlier reply about this section in:

https://public-inbox.org/git/xmqqh8koxwwi.fsf@gitster-ct.c.googlers.com/T/#mb31136a09dbc1a963a5a62e840b118ac33043edf

> 
>> Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
>> ---
>>
>> Notes:
>>      Base Ref: master
>>      Web-Diff: https://github.com/benpeart/git/commit/f43d934ce7
>>      Checkout: git fetch https://github.com/benpeart/git checkout-b-v1 && git checkout f43d934ce7
>>
>>   Documentation/config.txt |  6 +++
>>   builtin/checkout.c       | 94 ++++++++++++++++++++++++++++++++++++++++
>>   cache.h                  |  1 +
>>   config.c                 |  5 +++
>>   environment.c            |  1 +
>>   5 files changed, 107 insertions(+)
>>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index a32172a43c..2c4f513bf1 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -911,6 +911,12 @@ core.commitGraph::
>>   	Enable git commit graph feature. Allows reading from the
>>   	commit-graph file.
>>   
>> +core.optimizedCheckout
>> +	Speed up "git checkout -b foo" by skipping much of the work of a
>> +	full checkout command.  This changs the behavior as it will skip
>> +	merging the trees and updating the index and instead only create
>> +	and switch to the new ref.
> 
> By the way, why is it a core.* thing, not checkout.* thing?
> 

I followed the naming convention used by core.sparsecheckout but I'm 
happy to call it whatever people want.

> If a new feature is not necessarily recommendable for normal users
> and it needs to be hidden behind an opt-in knob (I do not have a
> strong opinion if that is or is not the case for this particular
> feature at this point), the documentation for the knob should give a
> bit more than "This chang(e)s the behavior" to the readers, I would
> think, to be intellectually honest ;-).  Let's tell them what bad
> things happen if we pretend that we switched the branch without
> twoway merge and the index update to help them make an informed
> decision.
> 

I attempted to explain what the change in behavior was in the same 
sentence by saying what it skips and what it still does.  If that isn't 
intellectually honest, help me know how to better explain it so that it is.

Is this better?

Speed up "git checkout -b <new_branch>" by skipping the twoway merge and 
index update.  Instead, just create a new branch named <new_branch> and 
switch to it.  The working directory and index are left unchanged.

>> +static int needs_working_tree_merge(const struct checkout_opts *opts,
>> +	const struct branch_info *old_branch_info,
>> +	const struct branch_info *new_branch_info)
>> +{
>> +	/*
>> +	 * We must do the merge if we are actually moving to a new
>> +	 * commit tree.
> 
> What's a "commit tree"?  Shouldn't it be just a "commit"?
> 

Sure

>> +	 */
>> +	if (!old_branch_info->commit || !new_branch_info->commit ||
>> +		oidcmp(&old_branch_info->commit->object.oid, &new_branch_info->commit->object.oid))
>> +		return 1;
>> +
>> +	/*
>> +	 * opts->patch_mode cannot be used with switching branches so is
>> +	 * not tested here
>> +	 */
>> +
>> +	/*
>> +	 * opts->quiet only impacts output so doesn't require a merge
>> +	 */
>> +
>> +	/*
>> +	 * Honor the explicit request for a three-way merge or to throw away
>> +	 * local changes
>> +	 */
>> +	if (opts->merge || opts->force)
>> +		return 1;
>> +
>> +	/*
>> +	 * --detach is documented as "updating the index and the files in the
>> +	 * working tree" but this optimization skips those steps so fall through
>> +	 * to the regular code path.
>> +	 */
>> +	if (opts->force_detach)
>> +		return 1;
>> +
>> +	/*
>> +	 * opts->writeout_stage cannot be used with switching branches so is
>> +	 * not tested here
>> +	 */
>> +
>> +	/*
>> +	 * Honor the explicit ignore requests
>> +	 */
>> +	if (!opts->overwrite_ignore || opts->ignore_skipworktree ||
>> +		opts->ignore_other_worktrees)
>> +		return 1;
>> +
>> +	/*
>> +	 * opts->show_progress only impacts output so doesn't require a merge
>> +	 */
>> +
>> +	/*
>> +	 * If we aren't creating a new branch any changes or updates will
>> +	 * happen in the existing branch.  Since that could only be updating
>> +	 * the index and working directory, we don't want to skip those steps
>> +	 * or we've defeated any purpose in running the command.
>> +	 */
>> +	if (!opts->new_branch)
>> +		return 1;
>> +
>> +	/*
>> +	 * new_branch_force is defined to "create/reset and checkout a branch"
>> +	 * so needs to go through the merge to do the reset
>> +	 */
>> +	if (opts->new_branch_force)
>> +		return 1;
>> +
>> +	/*
>> +	 * A new orphaned branch requrires the index and the working tree to be
>> +	 * adjusted to <start_point>
>> +	 */
>> +	if (opts->new_orphan_branch)
>> +		return 1;
>> +
>> +	/*
>> +	 * Remaining variables are not checkout options but used to track state
>> +	 */
>> +
>> +	return 0;
>> +}
> 
> This helper function alone looks like we are creating a maintenance
> nightmare from a quick scan.  How are we going to keep this up to
> date?
> 
> I offhand do not know how "git checkout -b foo" would behave
> differently if we do not do a two-way merge between HEAD and HEAD to
> update the index.  We'd still need to list the local modifications
> and say "Switched to a new branch 'foo'", but that would be a minor
> thing compared to the two-way merge machinery.
> 

With the patch, the index and working directory aren't modified, it does 
still list the local modifications and says "Switched to..."

The changes in behavior come from other inputs.  For example, if you 
turned on sparse checkout and then did a "git checkout -b foo" the old 
code path would update the skip-worktree bit in the index and remove all 
the files from the working directory that were no longer specified in 
the sparse-checkout file.  The new behavior would not do that as it no 
longer updates the index or working directory.

The checkout documentation doesn't _say_ that "git checkout -b foo" will 
also update the working directory after changing the sparse-checkout 
settings but it happens to do that.  Is that a common scenario? No - but 
it is an undocumented behavior that will change if they opt in to this 
new behavior.  At least the documentation for the new flag _does_ let 
the user know the working directory and index won't be changed so if 
they opt in, they shouldn't be too surprised.

> Was the primary reason why the patch "changes the behaviour" because
> nobody could prove that needs_working_tree_merge() helper reliably
> detects that "checkout -b foo" case and that case alone, and show a
> way to make sure it will keep doing so in the future when other new
> features are added to the command?
> 

My concern isn't ensuring that the patch reliably detects "checkout -b", 
the challenge is ensuring it will keep doing so as features are added 
that impact the "-b" option.  The problem of adding a new option and 
having to ensure it behaves properly with all the other options isn't 
new but I agree this does add one more case that has to be handled.

>> @@ -479,6 +565,14 @@ static int merge_working_tree(const struct checkout_opts *opts,
>>   	int ret;
>>   	struct lock_file lock_file = LOCK_INIT;
>>   
>> +	/*
>> +	 * Skip merging the trees, updating the index, and work tree only if we
>> +	 * are simply creating a new branch via "git checkout -b foo."  Any
>> +	 * other options or usage will continue to do all these steps.
>> +	 */
>> +	if (core_optimize_checkout && !needs_working_tree_merge(opts, old_branch_info, new_branch_info))
>> +		return 0;
>> +
>>   	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
>>   	if (read_cache_preload(NULL) < 0)
>>   		return error(_("index file corrupt"));
> 
> Thanks.
> 
