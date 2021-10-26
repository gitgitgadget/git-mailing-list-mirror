Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A4CC433EF
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 16:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 480E260238
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 16:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237738AbhJZQUZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 12:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237523AbhJZQTh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 12:19:37 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B13C06122C
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 09:17:05 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id y17so17940396ilb.9
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 09:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bsex5lYWGIxarQGhwxMduzhm6M5joyK8/jc10nMi3SI=;
        b=SsTCyFVDH5vrWmYMdVhaZMGIr+TSBrqUmPM78NbWJtDWSwvfy03Qqc0X0K0fJsc4cf
         3yeVn56Rth3ZXiskZEF9kbHpi+cVorU/nBFzmAEBuMGsZgO8ana5N+x4R3dd1ICaG1LI
         pXvkZquA8EkR5WvjXArggPk7ZXmVzMvnBRdQzdQd7sboH8YW3hzQ/v3Vfd6UOhJCIbiM
         ZXLX1JiERW0miPx+yt/E65piky0ZzB8fv5ayS5DZwUwpBH7Cz4SphjvVMJc0yieEKNpS
         4RjKLkDGHqfIoG8aWdsbyijppO5J70OwqSSQoVgbtF6LL/KTDcSmd5lLGcr4alVCZbFb
         oS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bsex5lYWGIxarQGhwxMduzhm6M5joyK8/jc10nMi3SI=;
        b=oz3TRT6StbPwwR3AA9swGzT+qFHWlp+cE/KM/VGPf+yEUpusslh8mydOEKtIHEcauk
         EUT/qguf7UBpec7G5DG7dTclpYaK5elZmv+QmRBA8mDe6KH4MXk/UqK0Uf+qhZaHLLOo
         24oHHA/oG2KMZIGm1TxEWhZrtWI730mVsbruL5F0V4gRGuXbJ34Po8tQPwiy3hINFPtE
         V18moA/zDZAlgQaPnnrBds8Ycstg8IJy396IYcCYKuLh0s+HGSodteW3Qo/4nN2hRMnM
         oY09Gif+DcmgZWi3/C1QRx/HMiwpvcD1wTfZqeIeVvI/YGVL1TrDvKXwFARQQrnQ58uA
         Pr3Q==
X-Gm-Message-State: AOAM532np8EJPeBhlNpoQkxynSGshdORETfZhl3HAFFdUDy/g2BVy1eb
        LtQP3MpYSVeZ/vwYtAJVQs8=
X-Google-Smtp-Source: ABdhPJxhBQGIhPGlB22dozedQWlumbt4YW6r0+msaRh5+QZN6QMPaJlcXisYbPH9CPhpjyMIxeP8Gg==
X-Received: by 2002:a92:d08a:: with SMTP id h10mr15036506ilh.59.1635265025087;
        Tue, 26 Oct 2021 09:17:05 -0700 (PDT)
Received: from [192.168.86.115] (097-087-102-211.res.spectrum.com. [97.87.102.211])
        by smtp.gmail.com with ESMTPSA id n25sm10514157ioz.51.2021.10.26.09.17.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 09:17:04 -0700 (PDT)
Message-ID: <086ad119-0739-5ce0-af99-0b1ab1c3d484@gmail.com>
Date:   Tue, 26 Oct 2021 09:17:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH v2 2/2] blame: enable and test the sparse index
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>,
        Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, gitster@pobox.com,
        newren@gmail.com
References: <pull.1050.git.1634232352.gitgitgadget@gmail.com>
 <pull.1050.v2.git.1634332835.gitgitgadget@gmail.com>
 <a0b6a152c754862323e9a5b89ad43ab34b6548f7.1634332836.git.gitgitgadget@gmail.com>
 <YXcZPxYlRLEEwU16@nand.local>
From:   Lessley Dennington <lessleydennington@gmail.com>
In-Reply-To: <YXcZPxYlRLEEwU16@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/25/21 1:53 PM, Taylor Blau wrote:
> On Fri, Oct 15, 2021 at 09:20:35PM +0000, Lessley Dennington via GitGitGadget wrote:
>> From: Lessley Dennington <lessleydennington@gmail.com>
>>
>> Enable the sparse index for the 'git blame' command. The index was already
>> not expanded with this command, so the most interesting thing to do is to
>> add tests that verify that 'git blame' behaves correctly when the sparse
>> index is enabled and that its performance improves. More specifically, these
>> cases are:
>>
>> 1. The index is not expanded for 'blame' when given paths in the sparse
>> checkout cone at multiple levels.
>>
>> 2. Performance measurably improves for 'blame' with sparse index when given
>> paths in the sparse checkout cone at multiple levels.
>>
>> The `p2000` tests demonstrate a ~60% execution time reduction when running
>> 'blame' for a file two levels deep and and a ~30% execution time reduction
>> for a file three levels deep.
> 
> Eek. What's eating up the other 30% when we have to open up another
> layer of trees?
> 
I'm not sure to be totally honest. However, given these are both pretty 
good time reductions I don't think we should be terribly concerned.
>>
>> Test                                         before  after
>> ----------------------------------------------------------------
>> 2000.62: git blame f2/f4/a (full-v3)         0.31    0.32 +3.2%
>> 2000.63: git blame f2/f4/a (full-v4)         0.29    0.31 +6.9%
>> 2000.64: git blame f2/f4/a (sparse-v3)       0.55    0.23 -58.2%
>> 2000.65: git blame f2/f4/a (sparse-v4)       0.57    0.23 -59.6%
>> 2000.66: git blame f2/f4/f3/a (full-v3)      0.77    0.85 +10.4%
>> 2000.67: git blame f2/f4/f3/a (full-v4)      0.78    0.81 +3.8%
>> 2000.68: git blame f2/f4/f3/a (sparse-v3)    1.07    0.72 -32.7%
>> 2000.99: git blame f2/f4/f3/a (sparse-v4)    1.05    0.73 -30.5%
>>
>> We do not include paths outside the sparse checkout cone because blame
>> currently does not support blaming files outside of the sparse definition.
>> Attempting to do so fails with the following error:
>>
>> fatal: no such path '<path outside sparse definition>' in HEAD.
> 
> Small nit; this error message should be indented with a couple of space
> characters to indicate that it's the output of running Git instead of
> part of your patch message. Not worth a reroll on its own, but something
> to keep in mind for your many future patches :).
> 
Eh, I'm making some changes based on your suggestions anyway, so I'm 
including this in v3. Thanks for letting me know!
>>
>> Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
>> ---
>>   builtin/blame.c                          |  3 +++
>>   t/perf/p2000-sparse-operations.sh        |  2 ++
>>   t/t1092-sparse-checkout-compatibility.sh | 24 +++++++++++++++++-------
>>   3 files changed, 22 insertions(+), 7 deletions(-)
>>
>> diff --git a/builtin/blame.c b/builtin/blame.c
>> index 641523ff9af..af3d81e2bd4 100644
>> --- a/builtin/blame.c
>> +++ b/builtin/blame.c
>> @@ -902,6 +902,9 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>>   	long anchor;
>>   	const int hexsz = the_hash_algo->hexsz;
>>
>> +	prepare_repo_settings(the_repository);
>> +	the_repository->settings.command_requires_full_index = 0;
>> +
> 
> By now we're quite used to seeing this ;). Makes sense to me.
> 
>>   	setup_default_color_by_age();
>>   	git_config(git_blame_config, &output_option);
>>   	repo_init_revisions(the_repository, &revs, NULL);
>> diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
>> index bff93f16e93..9ac76a049b8 100755
>> --- a/t/perf/p2000-sparse-operations.sh
>> +++ b/t/perf/p2000-sparse-operations.sh
>> @@ -115,5 +115,7 @@ test_perf_on_all git reset --hard
>>   test_perf_on_all git reset -- does-not-exist
>>   test_perf_on_all git diff
>>   test_perf_on_all git diff --staged
>> +test_perf_on_all git blame $SPARSE_CONE/a
>> +test_perf_on_all git blame $SPARSE_CONE/f3/a
> 
> Good.
> 
>>   test_done
>> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
>> index e5d15be9d45..960ccf2d150 100755
>> --- a/t/t1092-sparse-checkout-compatibility.sh
>> +++ b/t/t1092-sparse-checkout-compatibility.sh
>> @@ -488,15 +488,16 @@ test_expect_success 'blame with pathspec inside sparse definition' '
>>   	test_all_match git blame deep/deeper1/deepest/a
>>   '
>>
>> -# TODO: blame currently does not support blaming files outside of the
>> -# sparse definition. It complains that the file doesn't exist locally.
>> -test_expect_failure 'blame with pathspec outside sparse definition' '
>> +# Blame does not support blaming files outside of the sparse
>> +# definition, so we verify this scenario.
>> +test_expect_success 'blame with pathspec outside sparse definition' '
>>   	init_repos &&
>>
>> -	test_all_match git blame folder1/a &&
>> -	test_all_match git blame folder2/a &&
>> -	test_all_match git blame deep/deeper2/a &&
>> -	test_all_match git blame deep/deeper2/deepest/a
>> +	test_sparse_match git sparse-checkout set &&
>> +	test_sparse_match test_must_fail git blame folder1/a &&
>> +	test_sparse_match test_must_fail git blame folder2/a &&
>> +	test_sparse_match test_must_fail git blame deep/deeper2/a &&
>> +	test_sparse_match test_must_fail git blame deep/deeper2/deepest/a
>>   '
> 
> test_must_fail used to allow for segfaults, but doesn't these days. So
> this is a good test of "it should fail in sparse checkouts but not
> crash", although I think it would be good to ensure that it's failing in
> the way you expect (i.e., by checking that stderr contains "no such path
> <xyz> in HEAD").
Good suggestion, coming in v3!
>>
>>   test_expect_success 'checkout and reset (mixed)' '
>> @@ -874,6 +875,15 @@ test_expect_success 'sparse-index is not expanded: merge conflict in cone' '
>>   	)
>>   '
>>
>> +test_expect_success 'sparse index is not expanded: blame' '
>> +	init_repos &&
>> +
>> +	ensure_not_expanded blame a &&
>> +	ensure_not_expanded blame deep/a &&
>> +	ensure_not_expanded blame deep/deeper1/a &&
>> +	ensure_not_expanded blame deep/deeper1/deepest/a
>> +'
> 
> Makes sense. Probably just one of these is necessary, but I haven't
> looked into init_repos (or the "setup" test) enough to know for sure.
> Either way, not worth changing.
> 
> Thanks,
> Taylor
> 
