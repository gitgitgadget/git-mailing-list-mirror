Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C030DC63777
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 18:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5794020789
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 18:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIfEq08G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbgK3Sm1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Nov 2020 13:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728534AbgK3Sm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Nov 2020 13:42:26 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CD6C0613D2
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 10:41:46 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id z24so12310848oto.6
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 10:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CU5TszAWLXa28z+yHM7udC6S/0pA8egTUeh8p0M5wrI=;
        b=GIfEq08GZEMTxRL08PRKPN4KmBiPIPOf0yNn5901V2WSK/1RO7IG7lxZScHNlnCx6E
         K09D5820M1iaxLJvrfLn8q8HIQVVj/HOgPAoHnd+s/tGAGUETeIv5bZMgP6MPXnLwffZ
         RghHPS5KED82nA9prJ1kGN6AzusfRrexBxpapb8u3MNL8ads/fjQwAqSWdwnEdzqAfHU
         MEB56YEi4bz7cSf/vFxBsuW6YrYIDms+Qt4o6urBVDWc83uXoqYHpdwTfHTKkprXY5b3
         O4Ssz2FHyz3TBKK/4eSaTJDhBeHzujZMDkHKVka4LPa1MDLYsS4AhJqHv0J5pWCvBcWU
         92ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CU5TszAWLXa28z+yHM7udC6S/0pA8egTUeh8p0M5wrI=;
        b=C33WPg1f7f/U5o+nJoT0FxsFg1dDujyeX5GunUn44oWY5CFELvUdwUoB+Xir3Hrp6g
         PDhIOsbqCpu1evRU40Bc0HEQs8uQxgrQDNLsOr6j5lSqcKp4Yc8y2nlerI/iJj5YyAu9
         oKW3XBb/7DWg6vAcn+3LmGGk8s+hUdNYSmEQsam+ls/b6PREfxixsFBjkHO7QrcIEZ6e
         6jyvKYJznrr3NasI/QPIxbQ5F90ciOQta/rZ6UvcIUO34FJsP4AqWaH6+pnvXzvviqm2
         D4hY50SR24beklZYcHwOlKzdA6EKLi+cVPTynB9CUG9ahlFnzRypCIangJYFwbu3n9JX
         cqhQ==
X-Gm-Message-State: AOAM531PkQcMzUF9VqX7dgJFUVmIoGbNHdnwlKiRVdjxTmw4LOVUqMac
        g9FoceIf0K41DCWK9cUgXS0=
X-Google-Smtp-Source: ABdhPJz5DlaxkIHHxxqcIVTYXpaOTELLDmlmrcsg+ajvHJUzn0S8hzYCDbx3lGALfSYaxyhrYppWUg==
X-Received: by 2002:a9d:7c8c:: with SMTP id q12mr14396015otn.266.1606761705693;
        Mon, 30 Nov 2020 10:41:45 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id t25sm9040110otj.13.2020.11.30.10.41.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 10:41:44 -0800 (PST)
Subject: Re: [PATCH v2 18/24] pack-bitmap-write: build fewer intermediate
 bitmaps
To:     Jonathan Tan <jonathantanmy@google.com>, me@ttaylorr.com
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        peff@peff.net, martin.agren@gmail.com, szeder.dev@gmail.com
References: <5262daa3300114fbaccdbc7393882c5435f95f4f.1605649533.git.me@ttaylorr.com>
 <20201125014633.951649-1-jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ea0c8c5d-6bc3-0dca-4fa1-fb461ed7ccb9@gmail.com>
Date:   Mon, 30 Nov 2020 13:41:44 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <20201125014633.951649-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/24/2020 8:46 PM, Jonathan Tan wrote:
> I've reviewed the commit message already [1]; now let's look at the code.
> 
> [1] https://lore.kernel.org/git/20201124060738.762751-1-jonathantanmy@google.com/
> 
>>  struct bb_commit {
>>  	struct commit_list *reverse_edges;
>> +	struct bitmap *commit_mask;
>>  	struct bitmap *bitmap;
>> -	unsigned selected:1;
>> +	unsigned selected:1,
>> +		 maximal:1;
> 
> The code itself probably should contain comments about the algorithm,
> but I'm not sure of the best way to do it. (E.g. I would say that
> "maximal" should be "When iteration in bitmap_builder_init() reaches
> this bb_commit, this is true iff none of its descendants has or will
> ever have the exact same commit_mask" - but then when do we explain why
> the commit_mask matters?)

Comments are tricky, as they are likely to go stale. In fact,
this algorithm changes dramatically later in this very series!

How much can we expect a reader to inspect the commit history to
discover the lengthy commit message? The message explains the
algorithm and its many subtleties versus reading comments that may
be too specific to this initial version.

At this point, "maximal" is a property that doesn't mean much
without inspecting the places where we set or check that bit.

>> +		if (c_ent->maximal) {
>> +			if (!c_ent->selected) {
>> +				bitmap_set(c_ent->commit_mask, num_maximal);
>> +				num_maximal++;
>> +			}
>> +
>> +			ALLOC_GROW(bb->commits, bb->commits_nr + 1, bb->commits_alloc);
>> +			bb->commits[bb->commits_nr++] = commit;
> 
> So the order of bit assignments in the commit_mask and the order of
> commits in bb->commits are not the same. In the commit_mask, bits are
> first assigned for selected commits and then the rest for commits we
> discover to be maximal. But in bb->commits, the order follows the
> topologically-sorted iteration. This is fine, but might be worth a
> comment (to add to the already big comment burden...)

This one I waffled on a bit. There _is_ a difference between the
bitmask order and this list order. This isn't a problem as long as
no one attempts to use the bitmasks to navigate into this list.

Further, it is entirely possible that the tests to never demonstrate
that difference, so pointing out may help a future developer from
making that mistake. Could be good to add this comment over the
bb->commits definition:

	/*
	 * 'commits' stores the list of maximal commits, in visited
	 * order. This can be different than the bitmask order for
	 * the selected commits.
	 */

>> +# To ensure the logic for "maximal commits" is exercised, make
>> +# the repository a bit more complicated.
>> +#
>> +#    other                         master
>> +#      *                             *
>> +# (99 commits)                  (99 commits)
>> +#      *                             *
>> +#      |\                           /|
>> +#      | * octo-other  octo-master * |
>> +#      |/|\_________  ____________/|\|
>> +#      | \          \/  __________/  |
>> +#      |  | ________/\ /             |
>> +#      *  |/          * merge-right  *
>> +#      | _|__________/ \____________ |
>> +#      |/ |                         \|
>> +# (l1) *  * merge-left               * (r1)
>> +#      | / \________________________ |
>> +#      |/                           \|
>> +# (l2) *                             * (r2)
>> +#       \____________...____________ |
> 
> What does the ... represent? If a certain number of commits, it would be
> clearer to write that there.

The ... are unnecessary and should be ___ instead. Thanks.
 
>> +#                                   \|
>> +#                                    * (base)
> 
> OK - some of the crosses are unclear, but from the bitmask given below,
> I know where the lines should go.
> 
>> +#
>> +# The important part for the maximal commit algorithm is how
>> +# the bitmasks are extended. Assuming starting bit positions
>> +# for master (bit 0) and other (bit 1), and some flexibility
>> +# in the order that merge bases are visited, the bitmasks at
>> +# the end should be:
>> +#
>> +#      master: 1       (maximal, selected)
>> +#       other: 01      (maximal, selected)
>> +# octo-master: 1
>> +#  octo-other: 01
>> +# merge-right: 111     (maximal)
>> +#        (l1): 111
>> +#        (r1): 111
>> +#  merge-left: 1101    (maximal)
>> +#        (l2): 11111   (maximal)
>> +#        (r2): 111101  (maximal)
>> +#      (base): 1111111 (maximal)
> 
> This makes sense. (l1) and (r1) are not maximal because everything that
> can reach merge-right can also reach them.
> 
> [snip]
> 
>>  test_expect_success 'full repack creates bitmaps' '
>> -	git repack -ad &&
>> +	GIT_TRACE2_EVENT_NESTING=4 GIT_TRACE2_EVENT="$(pwd)/trace" \
>> +		git repack -ad &&
>>  	ls .git/objects/pack/ | grep bitmap >output &&
>> -	test_line_count = 1 output
>> +	test_line_count = 1 output &&
>> +	grep "\"key\":\"num_selected_commits\",\"value\":\"106\"" trace &&
>> +	grep "\"key\":\"num_maximal_commits\",\"value\":\"111\"" trace
> 
> From the diagram and bit masks, I see that the important number for
> "maximal" is 7. Could this test be run twice - one without the crosses
> and one with, and we can verify that the difference between the maximal
> commits is 7? As it is, this 111 number is hard to verify.

This number _is_ hard to verify. It is fragile to many behaviors inside
the code of Git, including the selection algorithm and some hard-coded
limits (there's a reason we insert 100 commits on top of each side).
Further, this number changes as the algorithm is modified.

Perhaps the best way to recognize this number is that it changes by adding
5 to the previous number (these are the 5 "newly maximal" commits, since
two are already selected as tips).

This number changes again later, and the difference is justified by
the number of maximal commits dropping by 4.

Thanks,
-Stolee
