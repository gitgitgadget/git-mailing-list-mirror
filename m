Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6CDC433F5
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 15:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347671AbiDZP3X (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 11:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352007AbiDZP3V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 11:29:21 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C21D65B6
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 08:26:11 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id b15so18284034pfm.5
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 08:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=u6m98HwJVDtFeNUwqdSRu7j7TfVZQYjNWhvF8t1qMig=;
        b=ITfWMlbHAITYhgaPQ5VZ4JVFQsLk3rO5zcuYdSaaljZoMVCIV7utUpVw15TuuKH93M
         6VZcEkmH5+/qRePJ1EevB1r4TRGWS42BnVN1KNJQUJo6Ee9q0GIxntwciOLNRVWxljto
         +hxEsLbUTlmpBaoGe9rRGEkCEKvUj3zQt8cpESaydQJjDdsGHD80zdsUNS/X0sQ304rz
         x8f21Glm5zBzt5GPslf/XHQt1nutzKanFupXCgU0dF5MMw8N9NXYs7WzpFoYgwafxcrU
         hYTcd6yFeKvGeNrWw2IOgJTNNplzITqgKwSlChIbHgx0q8XEU3iYF8Uw2K4UNSzGc+kZ
         3chg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=u6m98HwJVDtFeNUwqdSRu7j7TfVZQYjNWhvF8t1qMig=;
        b=xuc3ntdgcBMWaZJ3E9aSHttWR1YgDvSuZvAByeucJdTzSFQQVatHtFRdWXajDLDFL7
         wB+OKIbChQsGafzkGE0K7NqYpPogo7qOV9tGmLvDzmBBmTkv8f4f2j+IBPRrlRKvrG1s
         T+MF/YKo/hidzGzmlIF0xWGtZsi0/0AVdY80mxye73Nmhxu6eLO+nEjYRaiOnNXG0uCy
         aI/DcbF/IbiLyzZawA5NLOEczeAENaWLBQhRHYculA4vW7WnoYJ0Y4hT/D4Ex98bhRiR
         gWKJ4JEPadypEAPeXwYcl12FWbsRQAUrF1V1EkBcWwF/Q+fi9gtwX+cknKRgu6CwhdXt
         WcJA==
X-Gm-Message-State: AOAM530zhHmTezejlr7VXiTZXuMAkyx/IbFBheR3jU7sA/zyt1srzp2E
        7758XRSUYARETUn6Qc6w7ZtzPW1v7hER
X-Google-Smtp-Source: ABdhPJwA/qEOFGNBLMZL/ZFsDv47telXm1mJdc1yCE+UqB5HPR9b9P2Ry7vfwwdts2M6sSEHMkpEIQ==
X-Received: by 2002:a63:d13:0:b0:381:f043:c627 with SMTP id c19-20020a630d13000000b00381f043c627mr20164779pgl.168.1650986770665;
        Tue, 26 Apr 2022 08:26:10 -0700 (PDT)
Received: from [192.168.0.102] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id c18-20020a056a000ad200b004f0f9696578sm17505491pfl.141.2022.04.26.08.26.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 08:26:10 -0700 (PDT)
Message-ID: <f4409521-9812-60d1-bfd1-1dfef0fa0265@github.com>
Date:   Tue, 26 Apr 2022 08:26:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH 2/7] stash: integrate with sparse index
Content-Language: en-US
To:     Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com
References: <pull.1171.git.1650908957.gitgitgadget@gmail.com>
 <f6cf05a5bee9e4ebc174bab0385a13cc1cdb4014.1650908958.git.gitgitgadget@gmail.com>
 <f332fec9-da00-0063-4c88-765fa3639ea1@github.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <f332fec9-da00-0063-4c88-765fa3639ea1@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee wrote:
> On 4/25/2022 1:49 PM, Victoria Dye via GitGitGadget wrote:
>> From: Victoria Dye <vdye@github.com>
>>
>> Enable sparse index in 'git stash' by disabling
>> 'command_requires_full_index'.
> 
>>  ensure_not_expanded () {
>>  	rm -f trace2.txt &&
>> -	echo >>sparse-index/untracked.txt &&
>> +	if test -z $WITHOUT_UNTRACKED_TXT
> 
> Do we need quotes around "$WITHOUT_UNTRACKED_TXT"?
> 
> I mean, I suppose we don't since the tests pass when this variable
> is unset, but I think it is a good practice to be careful about
> empty variables. Or am I wrong?
> 
>> +	then
>> +		echo >>sparse-index/untracked.txt
>> +	fi &&
> 
> 
>> -	ensure_not_expanded checkout-index -f a &&
>> -	ensure_not_expanded checkout-index -f --all &&
>> -	for ref in update-deep update-folder1 update-folder2 update-deep
>> -	do
>> -		echo >>sparse-index/README.md &&
>> -		ensure_not_expanded reset --hard $ref || return 1
>> -	done &&
>> -
> 
> Moving these to be within the stash tests is interesting.
> 

That was unintentional. I originally had the 'stash' cases in the big
'sparse-index is not expanded' test, but decided to move them into their own
test for more appropriate granularity. In doing that, I accidentally took
some of the 'checkout-index' tests with it. I'll move them back in V2.

Thanks for the catch!

>> +test_expect_success 'sparse-index is not expanded: stash' '
>> +	init_repos &&
>> +
>> +	echo >>sparse-index/a &&
>> +	ensure_not_expanded stash &&
>> +	ensure_not_expanded stash list &&
>> +	ensure_not_expanded stash show stash@{0} &&
>> +	! ensure_not_expanded stash apply stash@{0} &&
>> +	ensure_not_expanded stash drop stash@{0} &&
>> +
>> +	echo >>sparse-index/deep/new &&
>> +	! ensure_not_expanded stash -u &&
>> +	(
>> +		WITHOUT_UNTRACKED_TXT=1 &&
>> +		! ensure_not_expanded stash pop
>> +	) &&
>> +
>> +	ensure_not_expanded stash create &&
>> +	oid=$(git -C sparse-index stash create) &&
>> +	ensure_not_expanded stash store -m "test" $oid &&
>> +	ensure_not_expanded reset --hard &&
>> +	! ensure_not_expanded stash pop &&
>> +
>> +	ensure_not_expanded checkout-index -f a &&
>> +	ensure_not_expanded checkout-index -f --all &&
>> +	for ref in update-deep update-folder1 update-folder2 update-deep
>> +	do
>> +		echo >>sparse-index/README.md &&
>> +		ensure_not_expanded reset --hard $ref || return 1
>> +	done
> 
> It is not obvious why that's necessary here. Perhaps a later
> change will build upon these checkout-index commands within
> this test?
> 
> Thanks,
> -Stolee

