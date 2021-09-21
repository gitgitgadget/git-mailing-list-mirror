Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F57C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 18:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0078361211
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 18:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbhIUStJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 14:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbhIUStA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 14:49:00 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE28C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 11:47:31 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id bk29so575800qkb.8
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 11:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Nf0HDA7myUdNUp7oi2EkBNsskQ5+71PQ0kW2jYYduBg=;
        b=jCuTX9dD3X2nxWsJXRgLbU+bHLK8WUN/BHJcEQEsjUtqcjhCGg/CHXE32GI9aal7WF
         g2EHj8VzzEraB/Y7tVorMdNoTUL6Kq/v1iexyOvpRA5ZIgMfFyva6G0EbennXdKAmgH8
         EyNCfVmmH/ilYVJrkLhRsflauxa9luII3UPt0FVb+zxXyBkxKWy99XXiZqmrkPeMz6ge
         B7kxvvfF6jhjHan6eINt5xYKaQUBxXu3Erv/u93j+FkSkmo/UBOhIJvNGU00qhhQbrxy
         gAsN4dI3mFN1hf7z8R/yG8r8kW3bHfBSqNKSMfuHnaF1+cYb3Rq0QsWw31fvd3kTYZSy
         MZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nf0HDA7myUdNUp7oi2EkBNsskQ5+71PQ0kW2jYYduBg=;
        b=H5ar4hvmsp0NntLPHWTmL8WCAU1XYTERWbD6vg5V/z4JbRua4tDiaY3Amdqqo80ua3
         AZZDa8YVIO/bssBd/7A9BlWrz1aRSVRKbjt7PqYW0rVLJ7SogwuOGsfp57dm2f+7B6kP
         hxydmhxFvbqszbtzym0JAV5wjLC9lX5pwnMV449eInylnbnxH+CWMPSn7kYkVPkGrckV
         0ZOy5LLsUIxRfZBHb4/ZAW15E83QWRn4VGfwAN2jAkYEcA6/P0cvm5fW/a1xWR3RBebf
         GxUyQz6SPYDMdNjwwG3L85JV0usJRujCsBB90Lwm8BQKigSbuXS7kp39JbTK8VgfH5OU
         xD7Q==
X-Gm-Message-State: AOAM530/7OrJ8dkqeIj9A3a5dJe7H7+BNrZsqeHYSot0f+VH+WTXVscJ
        au4K1OmRy5D1/Pfp4qWG8Q6CoH99SFREIA==
X-Google-Smtp-Source: ABdhPJwx7JfL5oCb85DRHSBicMBICwXVIH/kKpxN5cyFdLbrJMgrWYcB/tAWER9qcO+A/4IRpJuSUA==
X-Received: by 2002:a37:a7d5:: with SMTP id q204mr13342861qke.236.1632250050434;
        Tue, 21 Sep 2021 11:47:30 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:ace4:98aa:c023:6ae9? ([2600:1700:e72:80a0:ace4:98aa:c023:6ae9])
        by smtp.gmail.com with ESMTPSA id c30sm4917606qtg.50.2021.09.21.11.47.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 11:47:29 -0700 (PDT)
Subject: Re: [PATCH] t/perf/run: fix bin-wrappers computation
To:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com,
        vdye@github.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1044.git.1632239172735.gitgitgadget@gmail.com>
 <YUobWlgSjZDGYSvK@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e461bd13-9d8c-4d95-777b-c5859ee3f18c@gmail.com>
Date:   Tue, 21 Sep 2021 14:47:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YUobWlgSjZDGYSvK@nand.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/21/2021 1:50 PM, Taylor Blau wrote:
> On Tue, Sep 21, 2021 at 03:46:12PM +0000, Derrick Stolee via GitGitGadget wrote:
>> This is critical to successfully computing performance of commands that
>> execute subcommands. The bin-wrappers ensure that the --exec-path is set
>> correctly.
> 
> Just sanity-checking everything you said: with this bug, we'll set
> mydir_abs_wrappers to "/bin-wrappers", then realize that directory
> doesn't exist, and fall back to GIT_TEST_INSTALLED=$mydir_abs. Putting
> 'set -x' at the top of t/perf/run, we can see the relevant section:
> 
>   + mydir=build/73cd7d9420bb7d75207e8149521db375c789a81c
>   + cd build/73cd7d9420bb7d75207e8149521db375c789a81c
>   + pwd
>   + mydir_abs=/home/ttaylorr/src/git/t/perf/build/73cd7d9420bb7d75207e8149521db375c789a81c
>   + mydir_abs_wrappers=/bin-wrappers
>   + test -d /bin-wrappers
>   + GIT_TEST_INSTALLED=/home/ttaylorr/src/git/t/perf/build/73cd7d9420bb7d75207e8149521db375c789a81c
>   + export GIT_TEST_INSTALLED
> 
> OK. But the real problem is in t/test-lib.sh where we read
> "$GIT_TEST_INSTALLED". There we ask for the `--exec-path`, which appears
> to be wrong, at least in my setup. Printing out the $GIT_EXEC_PATH and
> $GIT_TEST_INSTALLED, I get:
> 
>   /home/ttaylorr/local/git/ds.sparse-checkout/libexec/git-core,
>   /home/ttaylorr/src/git/t/perf/build/73cd7d9420bb7d75207e8149521db375c789a81c
> 
> where the former is the branch I happen to have checked out, and the
> latter is the revision that I asked to run performance tests on via
> t/perf/run.
> 
> So I think we'll run the right top-level Git command since the latter
> path ends up first in our $PATH, but the exec path is definitely wrong.

Thanks for digging into this more. This issue with GIT_EXEC_PATH explains
some strangeness I was seeing.

Perhaps there is something more robust to be done around GIT_EXEC_PATH,
but the current fix satisfies my needs.
 
>> diff --git a/t/perf/run b/t/perf/run
>> index d19dec258a2..55219aa4056 100755
>> --- a/t/perf/run
>> +++ b/t/perf/run
>> @@ -74,7 +74,7 @@ set_git_test_installed () {
>>  	mydir=$1
>>
>>  	mydir_abs=$(cd $mydir && pwd)
>> -	mydir_abs_wrappers="$mydir_abs_wrappers/bin-wrappers"
>> +	mydir_abs_wrappers="$mydir_abs/bin-wrappers"
> 
> This fix looks obviously right to me (and gives me the expected output
> from above when I apply it locally).

Thanks,
-Stolee
