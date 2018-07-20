Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CC721F597
	for <e@80x24.org>; Fri, 20 Jul 2018 19:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388203AbeGTUDm (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 16:03:42 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:38058 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388108AbeGTUDm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 16:03:42 -0400
Received: by mail-qt0-f196.google.com with SMTP id y19-v6so11227067qto.5
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 12:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=CdpdSiXYXu1tLqICy902Zc0gb2upl72+n5LY7BtP9iI=;
        b=lhzxo7qb8DVP2lgBQwq2/fimCkhrxnrAN+TPOXjZgk6X37/9v6u+cJs8oQ0hyRtvus
         Z1sVqygH0Kd5TVnkvoJqCdtanyy4aztLmcpqB26hFtEqh2fMoow420p4ePT8QHDBSyxC
         LtzXaCinFwgBCpwt367XkONLPJkj/5PvPUnClgiZrvS/+hOGFVFWEg/7Sfpn06G0lNtT
         n/fMzGbBd0axSLtFiux1lnJb4I9E5lDXPdBD6FppVEsC86m0QYV/A9I7e6c1u6q3zCsy
         mzxCXpg/ALxfL1D2m6Q1UDMaiu5+PUZ60KfWDQh4/L5HzCm6m3Ffm3M67UMljO47HHHX
         HBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=CdpdSiXYXu1tLqICy902Zc0gb2upl72+n5LY7BtP9iI=;
        b=VzWZwO/G6tSoxuHLaWgtqG8xWqwiWsXkYlGG0AmNwMFnIHbY80DKNsu1RW+fdm/P4i
         Y3/4FJk8FOwm+43J7Equ7s198SmHWECmiDE/8hFxPFxlqaBNyiKOqkbxqrN2zZYqHDVG
         6SRgup+Ta+cSya+xmBCVW/ECDlvR6ivJIlBhrilGLEH/LHofoZnAYWQ9yTPkbSfZuTIg
         7Mvn9B5DxvueTNn1rl18qdzifokRHHqQwDjd2NiG+m2sCjkHafpbm0LJKH9KJEcYyLvT
         mokF7vEcFowSD373eN5Z3/9xdPnksB2RC88cjBMNtuG6O8QVVo1VxMrcr9+B4Ktuuhrj
         OB0w==
X-Gm-Message-State: AOUpUlGpNyhEboSLhSq2XdjufIrRg7Fw/x4NED6e/7ZlZ7bfK3PaM8Cc
        cjglVr5TpIOoDZpGx9+sHO8=
X-Google-Smtp-Source: AAOMgpc5rCuMShqmgUbKqk4kbTFmsmCweCoXeuh3MFvK85czAc+rB1nFoZoE1bftSjqsoOs/3PSwNw==
X-Received: by 2002:ac8:1b4a:: with SMTP id p10-v6mr3162967qtk.221.1532114044976;
        Fri, 20 Jul 2018 12:14:04 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id h4-v6sm1493675qtp.53.2018.07.20.12.14.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 12:14:04 -0700 (PDT)
Subject: Re: [PATCH v2 00/18] Consolidate reachability logic
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>
References: <20180720163227.105950-1-dstolee@microsoft.com>
 <20180720171836.106091-1-dstolee@microsoft.com>
 <CAPig+cRRa9gcvfu9jKy-+DK+Jjj6maCabuOyprVQMeGx4uJrRg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0676494e-8f2d-77ed-acbf-3e082e9fddcb@gmail.com>
Date:   Fri, 20 Jul 2018 15:14:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cRRa9gcvfu9jKy-+DK+Jjj6maCabuOyprVQMeGx4uJrRg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/20/2018 2:09 PM, Eric Sunshine wrote:
> On Fri, Jul 20, 2018 at 1:20 PM Derrick Stolee <dstolee@microsoft.com> wrote:
>> Here is the diff between v1 and v2.
>>
>> diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
>> @@ -67,142 +67,176 @@ test_three_modes () {
>>   test_expect_success 'get_merge_bases_many' '
>>          cat >input <<-\EOF &&
>> +       A:commit-5-7
>> +       X:commit-4-8
>> +       X:commit-6-6
>> +       X:commit-8-3
>>          EOF
>>          {
>> -               printf "get_merge_bases_many(A,X):\n" &&
>> -               git rev-parse commit-5-6 &&
>> -               git rev-parse commit-4-7
>> +               echo "get_merge_bases_many(A,X):" &&
>> +               git rev-parse commit-5-6 \
>> +                             commit-4-7 | sort
> Pipes lose the exit code of the all upstream commands. When a Git
> command is upstream, we'd usually recommend to dump its output to a
> file, then use the file as input to the rest of the pipe so as not to
> lose the Git command's exit code:
>
>      {
>          ...
>          git rev-parse ... >oids &&
>          sort <oids
>      } >expect &&

This approach seems fine to me. I'd hate to be in the case where 
rev-parse reports an error, terminating early, resulting in an incorrect 
expected file, and then having the test pass because the code is 
similarly incorrect. No matter how slim the chances are, I want to avoid 
a false positive there.

> One could argue, in this case, that if git-rev-parse crashes, then it
> won't have the expected output and the test will fail anyhow despite
> not seeing its failed exit code. However, git-rev-parse might crash
> _after_ emitting all the normal, expected output, and that crash would
> be missed altogether, so avoiding git-rev-parse as a pipe upstream is
> a good idea.
>
> However, one could argue that argument by saying that it isn't the job
> of this particular test script to check git-rev-parse's behavior, so
> crashy git-rev-parse ought to be caught elsewhere by some other test
> script. Nevertheless, you'll likely encounter reviewers who don't want
> to see git-rev-parse upstream, even with that argument.
>
> Anyhow, why is that 'sort' even there? It wasn't needed in the
> original. Is git-rev-parse outputting the OID's in random order?

Since the merge-base algorithms provide the commits in an order that 
depends on the implementation (not the functional contract), we decided 
to sort the output commit ids in the output of 'test-tool reach 
<method>'. Thus, we sort the rev-parse output to match.

Thanks,

-Stolee

