Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACD2C433EF
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 13:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbiBYNvs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 08:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbiBYNvs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 08:51:48 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0611DA448
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 05:51:14 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id j24so7423246oii.11
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 05:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SiPGlPfl0bvMZO6L2AyMyzpnJVpB5xZznET+ZMzZuKc=;
        b=UygoXxtUP5c80N9AhG7bUDJk0Lb8Nf3LJVwHbAGIG7lPz+UnpwSC+Fpw70lt3BpAsE
         RF5K9KEKA4aKG2TyN88/ccfwpqulkvpvVvuo1KSjFMuI4ijgZFQ1M4i98gwc0WYP0Bz+
         FSOQnFTKyojNZ0hOrLxsBXh9mBDGZ2uPw/FSrW8y/G8SaAoK7mjVr/aN9s4KyuhDnRo4
         c2iD+XdvNd1Rzq7zgNonr8DNNj8R4VaXsxKhVQwejO/h6HO8M4LmqyNmptH5IY6P/tw+
         pmUtdzZLjO0F39eYCnSm4uPIGkXzxXWjkoMoSntN2P78jyB8EX+hn4LdQtMplkUo0ge9
         TLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SiPGlPfl0bvMZO6L2AyMyzpnJVpB5xZznET+ZMzZuKc=;
        b=ffcGF1p/ZKug62L1a2wHa2tMvHjbA3r4kkseB0xs8WyO2f1N1Sit8pNnM955MnNE0h
         dK9k8AGKq9xzXk8mG1d33jNB6KRxYwOTNoSWaPZ+GgMp+TL6LGTpSMRv4LMijJ5KvQPe
         yqX2qqJwaqmnpjmOU00t/GIq98p6kzJC74MxfFdf3IYCUjXVB5LqoBDV+fZBQaTKQ6ru
         GwOZ6wj8AN3fENtecNM/CJ2SdsVBrRamhZ/9TdkiiGuTW0BLyO4u0oPLGmN5z/lB6lRN
         eaxjx5UcXh3toFLD1wwqxTS3UkQLK14ru4aZ0UoXgnzyqcBCMAj4cv0P8MFz3UVCObpB
         DrHw==
X-Gm-Message-State: AOAM5317muMesUZSCPE/RHUjfuAIYIMaZD7c4pTPhhvIUaU1j1iCVBEg
        hKPPi8AmMOQqgPhIaVBs4uDkdU4d65qp
X-Google-Smtp-Source: ABdhPJzBMoXMR8WfSx1Kdrbn9lP6t4XxnLqKoSjFDsHCcdAYfhY7Ok7/aUkBdO9cIFyX16Yd7m+cSw==
X-Received: by 2002:a05:6808:120c:b0:2d4:41d3:b7e8 with SMTP id a12-20020a056808120c00b002d441d3b7e8mr1575184oil.241.1645797073468;
        Fri, 25 Feb 2022 05:51:13 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id l8-20020a4ad9c8000000b0031bec309e0asm1081253oou.6.2022.02.25.05.51.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 05:51:12 -0800 (PST)
Message-ID: <756fd005-637d-a067-9949-e87fc15b3bf6@github.com>
Date:   Fri, 25 Feb 2022 08:51:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 2/7] commit-graph: fix ordering bug in generation numbers
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, abhishekkumar8222@gmail.com
References: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
 <6e47ffed25795260c2b8614d4589fb58d892c8df.1645735117.git.gitgitgadget@gmail.com>
 <xmqqh78nkj2x.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqh78nkj2x.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/24/2022 5:15 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>> When computing the generation numbers for a commit-graph, we compute
>> the corrected commit dates and then check if their offsets from the
>> actual dates is too large to fit in the 32-bit Generation Data chunk.
>> However, there is a problem with this approach: if we have parsed the
>> generation data from the previous commit-graph, then we continue the
>> loop because the corrected commit date is already computed.
>>
>> It is incorrect to add an increment to num_generation_data_overflows
>> here, because we might start double-counting commits that are computed
>> because of the depth-first search walk from a commit with an earlier
>> OID.
>>
>> Instead, iterate over the full commit list at the end, checking the
>> offsets to see how many grow beyond the maximum value.
> 
> Hmph, I can see how the new code correctly counts the commits that
> require offsets that are too large, but I am not sure why the fix is
> needed.  The overall loop structure is

It is very subtle, which is why it took me a while to debug this
issue once I managed to trigger it.

>     for each commit ctx->commits.list[i]:
>         continue if generation number has been computed for it already

This is the critical line in the current version. This includes
"continue if the generation number was loaded from the previous
commit-graph file." This means we under-count when building from
an existing commit-graph with overflows.

If we insert an increment here, then we risk double-counting. I
should have described this better.

> 	set up a commit-list for depth first search
> 	while (we are still digging) {
> 		for each parent {
> 			if generation for the parent is not known yet:
> 				push it down and redo
> 			else
> 				compute max of parents' generation number
> 		}
>                 if (all parents' generation number is known) {
> 			set the generation number for ourselves
> 			count if we needed an offset that is too big
> 		}
> 	}
>     }
> 
> The only case where we may double-count near the end of inner loop I
> can think of is when we end up computing generation for the same
> commit in the while () loop.  But isn't that "we dig the same thing
> twice" by itself something we want to fix, regardless of the
> double-counting issue?

By "we dig the same thing twice" I think you mean "we look across
every edge in the commit-graph, and some commits have multiple
direct children." There is no way around this, but we do skip
recalculating generation numbers for parents that are already
computed.

> IOW,
> 
>>  				if (current->date && current->date > max_corrected_commit_date)
>>  					max_corrected_commit_date = current->date - 1;
>>  				commit_graph_data_at(current)->generation = max_corrected_commit_date + 1;
>> -
>> -				if (commit_graph_data_at(current)->generation - current->date > GENERATION_NUMBER_V2_OFFSET_MAX)
>> -					ctx->num_generation_data_overflows++;
>>  			}
>>  		}
>>  	}
> 
> here, before doing the assignment for the "current" commit's
> generation number, if we added
> 
> 		if (commit_graph_data_at(current)->generation !=
> 		    GENERATION_NUMBER_ZERO)
> 			BUG("why are we digging it twice?");
> 
> would it trigger?  If so, isn't that already a bug worth fixing?

This would not trigger, since 'current' did not have its
generation when adding to the stack and it could not possibly
have been added a second time when doing a depth-first search
from that commit.

> Perhaps avoiding the second round, perhaps like this, may be a
> better fix?
> 
> 	while (list) {
> 		struct commit *current = list->item;
> 		struct commit_list *parent;
> 		int all_parents_computed = 1;
> 		timestamp_t max_corrected_commit_date = 0;
> 
> +		if (commit_graph_data_at(current)->generation !=
> +		    GENERATION_NUMBER_ZERO) {
> +			pop_commit(&list);
> +			continue;
> +		}
> +
> 		for (parent = current->parents; parent; parent = parent->next) {
> 
> Or am I grossly misunderstanding why the original code is incorrect
> to have the counting at this place?

Hopefully I cleared up the issue earlier in my reply. Let me
know if this is still confusing.

Thanks,
-Stolee
