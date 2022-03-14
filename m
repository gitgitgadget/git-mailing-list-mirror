Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A34C433F5
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 15:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242799AbiCNP4p (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 11:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235832AbiCNP4o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 11:56:44 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AF6403E5
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 08:55:34 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 132so14212904pga.5
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 08:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=F0rgTlafICBDsATMMsBYxeB35BFQtm7gmaLYVhpQ4Iw=;
        b=MgRkp1ktUqa26XIdb//x9a214s3AYkapP8ulnazNeYbjla74L166mPY/kBxBUS3ajh
         kK3Dcu5k9zEw1tOdGqxHLLed/BhywQIOM+p1W83zSIpLcGaNTc0ALBf08KtcX34MPOiX
         06rOro3aeZADPUiOr5bn656I3eNSQFD0R7CbTmVlXzomiDyGJiJ/XClxUQjxDHDdX/6N
         1VVnFh0QNOhOCnEHfC1xUhtNpggXu/Toj8dii2v65BFWBOvCwxCZ7z44nfYJ83jMYafK
         1gfjbTwrkT1FR3Bh7CUjNSQW95KUyEa0tAQt8crTwLVeJMKmmkisghha3rjqWZ3jnpqa
         Fjgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=F0rgTlafICBDsATMMsBYxeB35BFQtm7gmaLYVhpQ4Iw=;
        b=E0L4lBKIvJ9STxK3lOjXTR5ZuSCcWx3FrhxQ/oSSaWR8TYzgDohAepaHXupMdVW9YT
         xFPaeyLpqqHAmWoTEZO5GWmGBKIUskYzMPwpZfg8CDjGBaP/UELC2eEpyJ3HHHF3baiS
         jT9B10/09YHlpF/D295gkaI4c+WXEh0qKeX4fyZZnSYsCJqm/FtCTaKyTvpDyIDEQ8pk
         ih4okV0URwm2gsrEWfU7rpjlUAgrvBcJ2Mtg1Yt5yaRJ0J9u+ThElHnOTZrwcl71Zfgi
         9PB6xI5+g1Q4aMYm36kSVWbtfsK5aL8aPc5aeQtWvl13oZq3H4rAWiVNAzPtRNTlMfYV
         u8Fg==
X-Gm-Message-State: AOAM5300EyMzrZD3qsZmguN+I+VHc43GTju+PKpE0VF+4LFNhs4fVnNm
        Aixxb2DUtdHY13Kz4G7jId4D
X-Google-Smtp-Source: ABdhPJxqCuzthetsRz1Qgkp3SV9U5LPiv/DdjqzM1ZIGu4voeKSdDpJnQ6EMVzMZgCjKbLwtaaHmsA==
X-Received: by 2002:a63:8448:0:b0:373:a276:767 with SMTP id k69-20020a638448000000b00373a2760767mr20722701pgd.409.1647273334487;
        Mon, 14 Mar 2022 08:55:34 -0700 (PDT)
Received: from [192.168.0.102] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id s8-20020a056a0008c800b004f664655937sm22443725pfu.157.2022.03.14.08.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 08:55:34 -0700 (PDT)
Message-ID: <5742cf75-4a5c-ffc1-7791-891dd47dc956@github.com>
Date:   Mon, 14 Mar 2022 08:55:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.2
Subject: Re: [PATCH 2/5] reset: introduce --[no-]refresh option to --mixed
Content-Language: en-US
To:     Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1170.git.1647043729.gitgitgadget@gmail.com>
 <bda93703013e3576101079d6aa4b821ae4c73fb7.1647043729.git.gitgitgadget@gmail.com>
 <fac1f57c-1bb8-2458-91ce-db5cb55f2e7d@github.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <fac1f57c-1bb8-2458-91ce-db5cb55f2e7d@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee wrote:
> On 3/11/2022 7:08 PM, Victoria Dye via GitGitGadget wrote:
>> From: Victoria Dye <vdye@github.com>
>>
>> Add a new --[no-]refresh option that is intended to explicitly determine
>> whether a mixed reset should end in an index refresh.
>>
>> A few years ago, [1] introduced behavior to the '--quiet' option to skip the
> ...
>> [1] 9ac8125d1a (reset: don't compute unstaged changes after reset when
>>     --quiet, 2018-10-23)
> 
> I believe convention would normally have this listing of the commit in-line
> with your discussion of it. The "[1]" probably works, too, but I can't say
> that I've seen that used except for URLs. Something like:
> 
>   Starting at <commit>, the '--quiet' option skips refresh_index()...
> 
>> call to 'refresh_index(...)' at the end of a mixed reset with the goal of
>> improving performance. However, by coupling behavior that modifies the index
>> with the option that silences logs, there is no way for users to have one
>> without the other (i.e., silenced logs with a refreshed index) without
>> incurring the overhead of a separate call to 'git update-index --refresh'.
>> Furthermore, there is minimal user-facing documentation indicating that
>> --quiet skips the index refresh, potentially leading to unexpected issues
>> executing commands after 'git reset --quiet' that do not themselves refresh
>> the index (e.g., internals of 'git stash', 'git read-tree').
>>
>> To mitigate these issues, '--[no-]refresh' and 'reset.refresh' are
>> introduced to provide a dedicated mechanism for refreshing the index. When
>> either is set, '--quiet' and 'reset.quiet' revert to controlling only
>> whether logs are silenced and do not affect index refresh.
> 
> Well motivated change.
> 
>> +test_index_refreshed () {
>> +
>> +	# To test whether the index is refresh, create a scenario where a
>> +	# command will fail if the index is *not* refreshed:
>> +	#   1. update the worktree to match HEAD & remove file2 in the index
>> +	#   2. reset --mixed to unstage the change from step 1
>> +	#   3. read-tree HEAD~1 (which differs from HEAD in file2)
>> +	# If the index is refreshed in step 2, then file2 in the index will be
>> +	# up-to-date with HEAD and read-tree will succeed (thus failing the
>> +	# test). If the index is *not* refreshed, however, the staged deletion
>> +	# of file2 from step 1 will conflict with the changes from the tree read
>> +	# in step 3, resulting in a failure.
>> +
>> +	# Step 0: start with a clean index
>> +	git reset --hard HEAD &&
>> +
>> +	# Step 1
>> +	git rm --cached file2 &&
>> +
>> +	# Step 2
>> +	git reset $1 --mixed HEAD &&
>> +
>> +	# Step 3
>> +	git read-tree -m HEAD~1
>> +}
>> +
>>  test_expect_success '--mixed refreshes the index' '
>> -	cat >expect <<-\EOF &&
>> -	Unstaged changes after reset:
>> -	M	file2
>> -	EOF
>> -	echo 123 >>file2 &&
>> -	git reset --mixed HEAD >output &&
>> -	test_cmp expect output
>> +	# Verify default behavior (with no config settings or command line
>> +	# options)
>> +	test_index_refreshed &&
>> +'
> 
> It looks like this test ends with an &&. There's also a missing newline
> after the test.
> 
>> +test_expect_success '--mixed --[no-]quiet sets default refresh behavior' '
>> +	# Verify that --[no-]quiet and `reset.quiet` (without --[no-]refresh)
>> +	# determine refresh behavior
>> +
>> +	# Config setting
>> +	test_must_fail test_index_refreshed -c reset.quiet=true &&
> 
> This is failing, but not for the reason you want: It is running
> 
> 	git reset -c --mixed HEAD
> 
> and failing to parse the "-c", I bet.
> 
> Perhaps you want to have two arguments: one for config settings
> and another for arguments, meaning your call in test_index_refreshed
> should be
> 
> 	git $1 reset $2 --mixed HEAD
> 
> and calls like this should be
> 
> 	test_index_refreshed "-c reset.quiet=true" "" &&
> 

As you noted in patch 5, I switched to using `test_config` mostly because I
couldn't figure out how to get this syntax right (although, now that you
point it out, I *definitely* should have seen that). I prefer using the
inline config like this over `test_config`, so I'll update to do what you
suggest here.

>> +	test_index_refreshed -c reset.quiet=true &&
>> +
>> +	# Command line option
>> +	test_must_fail test_index_refreshed --quiet &&
>> +	test_index_refreshed --no-quiet &&
> 
> If you take a change like I recommend above, these would be
> 
> 	test_index_refreshed "" --no-quiet &&
> 
> Thanks,
> -Stolee

