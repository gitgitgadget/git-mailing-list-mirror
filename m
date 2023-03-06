Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878CDC61DA4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 20:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjCFUSP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 15:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCFUSO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 15:18:14 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584CB311E6
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 12:18:13 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id z6so12088557qtv.0
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 12:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1678133892;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F6xnxZzTDLQA88kzKtAZLfbek8xZ6dT4FmW6N3Ahzvs=;
        b=dn84sI/gm855oXQwKi907da/bfti8Pi3vCkJ6srfSjsrtGpxgf0gfEbvdDFW7lbiwG
         X84NzHZsvoTkjZwECztAtv7IoO4iXGnJckqsH/ZEKqUMS5Fi6v1PnaG7LklyW5qUQL8S
         bCww+0PUVZjQRcHYXW+A8fkY8RpcBwtpPkbW9e460ahvEXcGD6QtyvF5/wMtPLcfC+Xm
         yvLTDTF2zaCXun5MsVheSWUdC24TTNAKe1rs4RyTK+2mCD8oYfwr+UFkhgB8w8HTgFk1
         9EwY0jgZ6N9hQqU/Gt3KYaDUVS7YINhT+1H7mkNFr0f+8yVnm9mKv6hIvGHLiVOnrBY4
         Etiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678133892;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F6xnxZzTDLQA88kzKtAZLfbek8xZ6dT4FmW6N3Ahzvs=;
        b=SuGbpKq+xDPLrtprFDYrMieHaUVH72OZT/yUErnmjfG/PctWHaWFyX2Dhqg63pVB/p
         7DSKkle6+sOcy8cDwTVlvDYK3tDuorCWyvU3OEOqOtKlo7sZ/9hUxNoF6vuTv29pPKmV
         U6bgKFbN1QVYAVdYCwBBRXpEW7mOMFqAAMQyM8kqHiyNOeDOceh46EwHvSHZjhzuX5by
         jsipeY1qAiVJbpogrgyJesRTAyKvvqD41YuXf11eC/rF/YeqI3XMfx7lehxbsNY0EBYo
         UaC9yuTuH+V8YIWpL/1wrshgKX4nlrpfUnIbaLPNyAKJfdCS+yUMpItUkPEm+WteqJpx
         RglA==
X-Gm-Message-State: AO0yUKVTkvIVWcZsebWEt8AD5A5wsiN7HhUMZ1NAwMzqR0ljBmt/08QE
        PS3Ah5YeUnn3QXpV0LIHeTWs
X-Google-Smtp-Source: AK7set/vFEbCp/ePN8uiqZPJm8f2ensrQayPdWzcyjfZIMEwbeK1e2N28qMpntzLYzG8o2F/qQdmEg==
X-Received: by 2002:a05:622a:28a:b0:3bf:daa8:cad3 with SMTP id z10-20020a05622a028a00b003bfdaa8cad3mr18520267qtw.15.1678133892370;
        Mon, 06 Mar 2023 12:18:12 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:142d:d17c:5d14:a6e9? ([2600:1700:e72:80a0:142d:d17c:5d14:a6e9])
        by smtp.gmail.com with ESMTPSA id s144-20020a374596000000b0073bb4312842sm8041137qka.128.2023.03.06.12.18.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 12:18:12 -0800 (PST)
Message-ID: <8be01cb6-8937-faed-0850-4501a2f1ef55@github.com>
Date:   Mon, 6 Mar 2023 15:18:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/8] ahead-behind: new builtin for counting multiple
 commit ranges
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, vdye@github.com
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
 <xmqqedq1ag8d.fsf@gitster.g>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqedq1ag8d.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/6/2023 1:26 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> These numbers can be computed by 'git rev-list --count B..C' and 'git
>> rev-list --count C..B', but there are common needs that benefit from having
>> the checks being done in the same process:
> 
> This makes readers wonder if "git rev-list --count B...C" should be
> the end-user facing UI for this new feature, perhaps?
> 
> Of course if you are checking how C0, C1, C2,... relate to a single
> B, the existing rev-list syntax would not work, and makes a totally
> new subcommand a possibilty.
> 
>>  2. When a branch is updated, a background job checks if any pull requests
>>     that target that branch should be closed because their branches were
>>     merged implicitly by that update. These queries can e batched into 'git
>>     ahead-behind' calls.
>>
>> In that second example, we don't need the full ahead/behind counts (although
>> it is sufficient to look for branches that are "zero commits ahead", meaning
>> they are reachable from the base), so this builtin has an extra '--contains'
>> mode that only checks reachability from the base to each of the tips. 'git
>> ahead-behind --contains' is sort of the reverse of 'git branch --contains'.
> 
> I thought that the reverse of "git branch --contains" was "git
> branch --merged".  "git branch --merged maint ??/\*" is how I cull
> topic branches that have already served their purpose.  
> 
> Isn't closing pull requests because they have been already merged
> the same idea?  "git for-each-ref --merged main refs/pull/\*" or
> something, perhaps?

You are definitely on to something, and I was not aware of --merged as
an option to either of these.

'git branch --merged' has some limitations that tags cannot be used.

'git for-each-ref --merged' is probably sufficient. The only difference
being that it would be nice to specify the matching refs over stdin
with --stdin to avoid long argument lists.

With this in mind, I can update the performance test to look like this
(after updating the setup step to add branches for each line in 'refs')


test_perf 'batch reachability: git ahead-behind --contains' '
	git ahead-behind --contains --base=HEAD --stdin <refs
'

test_perf 'batch reachability: git branch --merged' '
	xargs git branch --merged=HEAD <branches
'

test_perf 'batch reachability: git for-each-ref --merged' '
	xargs git for-each-ref --merged=HEAD <refs
'

And get decent results on all cases with the Linux kernel repository:

Test                                                      this tree      
-------------------------------------------------------------------------
1500.2: ahead-behind counts: git ahead-behind             0.26(0.24+0.01)
1500.3: ahead-behind counts: git rev-list                 4.46(3.91+0.54)
1500.4: batch reachability: git ahead-behind --contains   0.02(0.01+0.01)
1500.5: batch reachability: git branch --merged           0.14(0.13+0.00)
1500.6: batch reachability: git for-each-ref --merged     0.14(0.13+0.00)

So, there is benefit in using this tips_reachable_from_base() method in
the two existing 'git (branch|for-each-ref) --merged' computations. The
API boundary selected in this series might not be the most appropriate
for those builtins, so let's kick out patch 8 from this series for now
and I'll revisit it separately.

Thanks,
-Stolee
