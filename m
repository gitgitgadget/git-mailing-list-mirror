Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39417C76196
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 19:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjC1Tqm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 15:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjC1Tql (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 15:46:41 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5B6137
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 12:46:40 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id o44so10074094qvo.4
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 12:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1680032799;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NRCJo4lcv7T0Q4g1uh1dyXPz2hEQ5tNbDLr+pwzmq5c=;
        b=VaUVIYrcGObgxndkR3UwiM4VQXHI2eaf1zY7Fp2AA7SgmBIgraXyNTLQh4K1Bc38we
         k4MGyT91n2Iw/OtpawuLBCxp3sb7Ng1ICCoWEz4VkBoxPtloO9YPSrY8IJSICvo/iiq6
         8Ts3S7ZcHiVxZPstFkbqwvqeWfRW/CpFfJ8Ur7zk63t+fgTv9ejpAs4BGz8PFtq+5MHM
         IZ5tH/jv7ZFP+hbZH/POxXZyzQZNADgtfzdDUt+VmN5eu3kGxIeAvvbBEr6UWq5dKz4F
         dejA/duLfzX6UeeTLEyO9ISFo/CUgQxucDD789vV+Z2qZQfFIO9t8LAdmQc79hdkND7t
         DHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680032799;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NRCJo4lcv7T0Q4g1uh1dyXPz2hEQ5tNbDLr+pwzmq5c=;
        b=qRvEdZ0pvIbDC8Ra8BfzsXcStlstlKwD/rQh9bUeLrDsjjc2aw0XIg/iHW/axElqXx
         ly9BdIyclOYpVX9VLvUbwT1IYukhlEf+spIJ1xw60ZqXhLjPIj2pEUeRiH5idPOm6ct5
         3Xdwd5hppYkwmITc5lv+q2vIODXZQ8B58AoRP/YIBl54/JgOfn4+cy+W7YJjn54jsH8I
         On4Uun5qGB0vn4YegLl2FFShTMO7NQnkyae+Z4CqCn0PSccyhDTC/cwMku/+Zs12v3Iu
         dyHwPciPu47c/KQgdFHoW6FO0PDpS2ASaQBQY29iYLpraVyb0TQcX+Gc4VcOoBbLqmZo
         Bk3w==
X-Gm-Message-State: AAQBX9f6NugQ/MCA7kMPkw7yygLq1mYRo10ZnwSM+J4w1TXnv5rZVfWc
        zB3CfgXKT/2iaazVwW28zGUU
X-Google-Smtp-Source: AKy350aS2I9KnpMQqJLVlf/JVOcpnv/elmdxiKEZU7n1pjFAmVktIF2c5agQsNBjUFSW/kJSG+WI0w==
X-Received: by 2002:a05:6214:29cb:b0:5cb:ab2e:b15c with SMTP id gh11-20020a05621429cb00b005cbab2eb15cmr25023445qvb.30.1680032799179;
        Tue, 28 Mar 2023 12:46:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:5188:124d:a12d:bff? ([2600:1700:e72:80a0:5188:124d:a12d:bff])
        by smtp.gmail.com with ESMTPSA id u12-20020a0cec8c000000b005dd8b93458bsm3996555qvo.35.2023.03.28.12.46.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 12:46:38 -0700 (PDT)
Message-ID: <ff521177-b0ad-c567-c51a-a6c191584d7c@github.com>
Date:   Tue, 28 Mar 2023 15:46:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH] describe: enable sparse index for describe
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Raghul Nanth A via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Raghul Nanth A <nanth.raghul@gmail.com>
References: <pull.1480.git.git.1679926829475.gitgitgadget@gmail.com>
 <xmqqjzz29hkw.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqjzz29hkw.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/27/23 2:26 PM, Junio C Hamano wrote:
> "Raghul Nanth A via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>>  builtin/describe.c                       |   2 +
>>  t/perf/p2000-sparse-operations.sh        |  14 +-
>>  t/t1092-sparse-checkout-compatibility.sh |  10 +
>>  t/t6121-describe-sparse.sh               | 675 +++++++++++++++++++++++
>>  4 files changed, 697 insertions(+), 4 deletions(-)
>>  create mode 100755 t/t6121-describe-sparse.sh
> 
> This copying of a file with 600+ lines only to touch up a handful
> lines (like a 20+ lines patch) is almost criminal.  Imagine the
> effort to keep them in sync over time, when "describe" itself may
> learn new features and improved output, independent from the
> sparse-index compatibility.
> 
> Can't we do better than this with a bit of refactoring?
> 
>> diff --git a/builtin/describe.c b/builtin/describe.c
>> index 5b5930f5c8c..7ff9b5e4b20 100644
>> --- a/builtin/describe.c
>> +++ b/builtin/describe.c
>> @@ -654,6 +654,8 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
>>  			int fd, result;
>>  
>>  			setup_work_tree();
>> +			prepare_repo_settings(the_repository);
>> +			the_repository->settings.command_requires_full_index = 0;
> 
> Offhand, the only case I know that "describe" even _needs_ a working
> tree or the index is when asked to do the "--dirty" thing.  To
> figure out if the working tree files are modified, the code calls
> into run_diff_index(), but has that codepath been made sparse-index
> aware already?

It seems that this is a case where we can rely on the existing
changes around run_diff_index(), which is nice. We get a very
easy win for a narrow case.

And I agree about the test case situation. It would suffice to
show some checks that the result is the same across all cases
in t1092 for 'git describe --dirty'. Those should be the only
new correctness tests necessary for this change.

>> diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh

>> @@ -86,7 +89,8 @@ test_expect_success 'setup repo and indexes' '
>>  		git sparse-checkout set $SPARSE_CONE &&
>>  		git config index.version 4 &&
>>  		git update-index --index-version=4 &&
>> -		git checkout HEAD~4
>> +		git checkout HEAD~4 &&
>> +		git tag -a v1.0 -m "Final"
>>  	)
>>  '
> 
> It is unclear from the proposed commit log what the relevance of
> adding a step to create an annotated tag to these tests.  It is not
> like any later step uses that tag to figure out anything.  There may
> be good reasons to add these tags (otherwise you would not be adding
> them to these tests), but please explain why in the proposed log
> message so that future readers of the "git log -p" do not have to
> ask this question.

I imagine that 'git describe' reports something better when a tag
is reachable from HEAD. Would be good to make that clear.

Indeed, when removing these lines and running the test on a repo
without any tags, the test fails with this message:

  fatal: No names found, cannot describe anything.

These tags could be added earlier in the test, in one step:

diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index 3242cfe91a0..ba13317c942 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -45,6 +45,7 @@ test_expect_success 'setup repo and indexes' '
 	git sparse-checkout init --cone &&
 	git sparse-checkout set $SPARSE_CONE &&
 	git checkout -b wide $OLD_COMMIT &&
+	git tag -a v1.0 -m "final" &&
 
 	for l2 in f1 f2 f3 f4
 	do

The tests then run on the four examples cloned from this copy.

>> @@ -125,5 +129,7 @@ test_perf_on_all git checkout-index -f --all
>>  test_perf_on_all git update-index --add --remove $SPARSE_CONE/a
>>  test_perf_on_all "git rm -f $SPARSE_CONE/a && git checkout HEAD -- $SPARSE_CONE/a"
>>  test_perf_on_all git grep --cached --sparse bogus -- "f2/f1/f1/*"
>> +test_perf_on_all git describe --dirty
>> +test_perf_on_all 'echo >> new && git describe --dirty'
>>  
>>  test_done
> 
> Just like '>', '>>' is a rediraction operator and should have SP
> before it (you got it right) and no SP between it and its operand.
> I.e.
> 
> 	echo >>new && git describe --dirty
> 
> You have the same in t1092, I think.

Also, since you are adding these performance tests, it would be
nice to see their results in the commit message. You can get
values without and with this change using (from t/perf/):

GIT_PERF_REPEAT_COUNT=10 ./run HEAD~1 HEAD -- p2000-sparse-operations.sh

For example, I ran this on my machine (after deleting the other tests
so it ran faster) and got these results:

Test                                                      HEAD~1            HEAD                  
--------------------------------------------------------------------------------------------------
2000.2: git describe --dirty (full-v3)                    0.36(0.07+0.32)   0.45(0.08+0.37) +25.0%
2000.3: git describe --dirty (full-v4)                    0.39(0.08+0.32)   0.42(0.08+0.35) +7.7% 
2000.4: git describe --dirty (sparse-v3)                  1.49(0.91+0.58)   0.33(0.04+0.59) -77.9%
2000.5: git describe --dirty (sparse-v4)                  1.48(0.92+0.57)   0.34(0.04+0.60) -77.0%
2000.6: echo >> new && git describe --dirty (full-v3)     0.37(0.07+0.32)   0.44(0.08+0.36) +18.9%
2000.7: echo >> new && git describe --dirty (full-v4)     0.40(0.08+0.32)   0.42(0.08+0.36) +5.0% 
2000.8: echo >> new && git describe --dirty (sparse-v3)   1.59(0.97+0.62)   0.33(0.04+0.57) -79.2%
2000.9: echo >> new && git describe --dirty (sparse-v4)   1.64(0.98+0.64)   0.31(0.03+0.54) -81.1%

Thanks,
-Stolee
