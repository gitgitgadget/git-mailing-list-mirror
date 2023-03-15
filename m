Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB216C7618D
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 16:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjCOQMb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 12:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbjCOQME (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 12:12:04 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E3E30E97
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 09:11:17 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d7so16689560qtr.12
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 09:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1678896676;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zRYT8U8OecALGwZhLHyAI+ZeN8xsCwCUU8+tCAoXBl0=;
        b=cJG7E6jFeC/xDhVEV13u2wJ2FmYktrDhz0RT7Yy9TfJEMc4xuL4pzuBROEYUvnfyA+
         W+pGMi0Qdiiz2DahvH7nvrcqsQnkxrDzPWoqPkKwdJi6PNcGkZcbC3Ve1VxrlH/N5MzH
         HG+lS52eCCSorIp2enxA2f7CJ47NFaWx+2E9M/KHJOtLzpNGrhZ6C7eSO5hB9IW5islV
         WNjrTBSL1JKPowfuOq+6yijCKpX9itu4E0BBitrvuh53XAG9itaCjWC05wJmopyHtcS4
         p9smNcxUoBt70pinXacbAmvn0rTDwSktSJORa6TdMhpQVYs3nbPN9no0Zj/tVjA45T2S
         l/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678896676;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zRYT8U8OecALGwZhLHyAI+ZeN8xsCwCUU8+tCAoXBl0=;
        b=liJ0kmExSkfoPIBVmCHeKkZMYZUB4fHygJnHtSfEaQzZ0+Zq7zfz7uEvEe3sTkm9zU
         shwGfvOGnLKDtQZeLH8eOnlyfuWxatWt2+M6L2iolZtBtJft4ioRVTq5zf9XUDvZoU0T
         uWSCwhKseyRf9raBwzQcZIvyu/g4F+lyHwbtbfF1dHHNyqm0SoBSU/dGD5lSEvbQhk1B
         8nP7mX1/DGZz4ZOII2mr0yggyLAiN3iiRrSWydevXAmARaHW6OcvWOOdXrQKvQ3gggYz
         8D5TDxueliK90WCBoNL+P3dbo6pYeODBMfLeOBw+4tBg5rr5rT7rzcRXztjz3eFrT9m9
         eTGA==
X-Gm-Message-State: AO0yUKXaUkHn4eGxvMHbazMkvIL0QNbiOHZmlL6B+XYctLC8C1O2u291
        FUlmlvkzHkSMFYRf7XAMJeze
X-Google-Smtp-Source: AK7set+T4Jmb/6BF3hS+WkIKPc5HPDDn9ej4oi7CPF8ISI8SDBe8BhIDwmTPkmnFcQBjk7YONfdtfA==
X-Received: by 2002:a05:622a:488:b0:3b8:5199:f84a with SMTP id p8-20020a05622a048800b003b85199f84amr860031qtx.3.1678896676250;
        Wed, 15 Mar 2023 09:11:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:b4dd:42a2:285c:8312? ([2600:1700:e72:80a0:b4dd:42a2:285c:8312])
        by smtp.gmail.com with ESMTPSA id u19-20020a37ab13000000b00725d8d6983asm2504955qke.61.2023.03.15.09.11.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 09:11:15 -0700 (PDT)
Message-ID: <17e8437c-4a48-9029-da7f-c858414f781c@github.com>
Date:   Wed, 15 Mar 2023 12:11:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 7/8] for-each-ref: add ahead-behind format atom
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        vdye@github.com, Jeff King <peff@peff.net>
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
 <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
 <82dd6f44a33279551bb638357df4bc82253283e5.1678468864.git.gitgitgadget@gmail.com>
 <230315.868rfyxfus.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <230315.868rfyxfus.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/15/2023 9:57 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Mar 10 2023, Derrick Stolee via GitGitGadget wrote:
> 
>> From: Derrick Stolee <derrickstolee@github.com>

>> +test_description='Commit walk performance tests'
>> +. ./perf-lib.sh
>> +
>> +test_perf_large_repo
>> +
>> +test_expect_success 'setup' '
>> +	git for-each-ref --format="%(refname)" "refs/heads/*" "refs/tags/*" >allrefs &&
>> +	sort -r allrefs | head -n 50 >refs &&
> 
> Some of the point of test_perf_large_repo is being able to point the
> test to an arbitrary sized repo, why "head -n 50" here, instead of just
> doing that filtering when preparing the test repo?

I think it's too much work to expect that the tester removes
all but a small number of refs for testing here. Using all
refs on a repo with may refs would be too slow to be helpful.

This is especially important when running the entire perf
suite on a repo where a large number of refs is _desired_
for some of the other tests.
 
>> +test_expect_success 'ahead-behind requires an argument' '
>> +	test_must_fail git for-each-ref \
>> +		--format="%(ahead-behind)" 2>err &&
>> +	grep "expected format: %(ahead-behind:<ref>)" err
>> +'
>> +
>> +test_expect_success 'missing ahead-behind base' '
>> +	test_must_fail git for-each-ref \
>> +		--format="%(ahead-behind:refs/heads/missing)" 2>err &&
>> +	grep "failed to find '\''refs/heads/missing'\''" err
>> +'
>> +
> 
> Is this grep instead of test_cmp for brevity, or because we'll catch
> this late and spew out other output as well?
> 
> I'd think it would be worth testing that we only emit an error. Even if
> you don't want a full test_cmp we could check the line count too to
> assert that...

A full test_cmp is a little more annoying to write, but
is a stronger test, so sure.

>> +# Run this before doing any signing, so the test has the same results
>> +# regardless of the GPG prereq.
>> +test_expect_success 'git tag --format with ahead-behind' '
>> +	test_when_finished git reset --hard tag-one-line &&
>> +	git commit --allow-empty -m "left" &&
>> +	git tag -a -m left tag-left &&
>> +	git reset --hard HEAD~1 &&
>> +	git commit --allow-empty -m "right" &&
>> +	git tag -a -m left tag-right &&
> 
> Do we really need this --allow-empty insted of just using "test_commit"?
> I.e. is being TREESAME here important?

You missed this in the commit message:

>> [...] Also, the
>> test in t7004 is carefully located to avoid being dependent on the GPG
>> prereq. It also avoids using the test_commit helper, as that will add
>> ticks to the time and disrupt the expected timestampes in later tag
>> tests.

(And I see the "timestampes" typo now.)

Thanks,
-Stolee
