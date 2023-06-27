Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307A9EB64D9
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 10:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjF0KIW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 06:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjF0KH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 06:07:56 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028023C21
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 03:05:36 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-312826ffedbso4843469f8f.0
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 03:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687860335; x=1690452335;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=i5ABB4Fsf1T1UMUda5nf3fgjXh1d7GSCzM9IXqUAkJY=;
        b=PShJQyKoW/DLBDsW1jRmePQ7VQHQx87ivYpAWrVpbrdNzWNHdEJ05e68uGHhIqXl6d
         k+ei6pJtc1330AC34HnTq2RS/j5CygjCfB0kmqNHamANSoG/cn0xloGmFFjp3zlC7vf0
         nGpWwZL5gYMXOCmQ/lntnxeMU1Yi+hpmnfEATRyk7tBp1CTVr3CKXkf8Uir0QzQuhgit
         2vXwkeTjCh+iqKUecNdJ2dJZ3gNzIoQczjuY4oS6XQAualjx1SHaOabqZB73ET/FLssX
         +3qqiRhItD9XYpRBHCgzCQO+3cpRoM/3NJLqNGHeRV+q1pYhfjpvoo34yx2x5VKhXKOz
         rurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687860335; x=1690452335;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i5ABB4Fsf1T1UMUda5nf3fgjXh1d7GSCzM9IXqUAkJY=;
        b=K6tGW0IC2EvqaZzENRteSmF7dRHyW0zjL2beBMGrewja/CX9aXmg4NgPgQuq0BmNN7
         oRmmDbwpqHqbg5n6RrTL2QA+NNRVO46davv6Gv7DKno7/To5+sOu0DoTKw8qiWaerNSp
         53PuTk2uLu3KtKAtHzibQu51/54KEhIKtwM3DXcMM8HWCKTl5vL19VSKpFwdJtW7IcNt
         bnEVQiLdNEA5d+JFTOoTbWogVwWZeEaWCDTr6TM5T9jPbMbRpoKwNLDgytF5Ijl16ou1
         2f8zvVnoTQwv48CsG1xt2D8ts1ARJLznDhxManQBvS8gBDaxIPAShSxoYtrnVE2hJu7l
         EPgA==
X-Gm-Message-State: AC+VfDwoVyPTNfRECVXllQ8KQ4AL/9Z+8w5zylocN8rWevS5ZU9xFphL
        5HOkECR5ShdDcH/LTbuglfTtXRY8aHU=
X-Google-Smtp-Source: ACHHUZ5cTy32eW+C/xNZkqxyJ1WQVg/CB8xhZCGSjs6jurezhGBJ/qnNKpDkwpbVPpuTfZltm0Wh4g==
X-Received: by 2002:a5d:6884:0:b0:30f:b1e8:8896 with SMTP id h4-20020a5d6884000000b0030fb1e88896mr23975185wru.67.1687860334979;
        Tue, 27 Jun 2023 03:05:34 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.235.211])
        by smtp.gmail.com with ESMTPSA id m8-20020adffe48000000b002c71b4d476asm9969614wrs.106.2023.06.27.03.05.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 03:05:34 -0700 (PDT)
Message-ID: <f6fd39bc-65d4-76e3-94b4-9163194c89dd@gmail.com>
Date:   Tue, 27 Jun 2023 11:05:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] for-each-ref: add --count-matches option
Content-Language: en-US
To:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        vdye@github.com, me@ttaylorr.com, mjcheetham@outlook.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1548.git.1687792197.gitgitgadget@gmail.com>
 <9121e027fb9f157878a9624ce6c834b69cd38472.1687792197.git.gitgitgadget@gmail.com>
 <20230627073007.GD1226768@coredump.intra.peff.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230627073007.GD1226768@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/06/2023 08:30, Jeff King wrote:
> On Mon, Jun 26, 2023 at 03:09:57PM +0000, Derrick Stolee via GitGitGadget wrote:
> 
>> +for pattern in "refs/heads/" "refs/tags/" "refs/remotes"
>> +do
>> +	test_perf "count $pattern: git for-each-ref | wc -l" "
>> +		git for-each-ref $pattern | wc -l
>> +	"
>> +
>> +	test_perf "count $pattern: git for-each-ref --count-match" "
>> +		git for-each-ref --count-matches $pattern
>> +	"
>> +done
> 
> I don't think this is a very realistic perf test, because for-each-ref
> is doing a bunch of work to generate its default format, only to have
> "wc" throw most of it away. Doing:
> 
>    git for-each-ref --format='%(refname)' | wc -l

That's a good point. I wondered if using a short fixed format string was 
even better so I tried

git init test
cd test
git commit --allow-empty -m initial
seq 0 100000 | sed "s:\(.*\):create refs/heads/some-prefix/\1 $(git 
rev-parse HEAD):" | git update-ref --stdin
git pack-refs --all
hyperfine -L fmt "","--format=%\(refname\)","--format=x" 'git 
for-each-ref {fmt} refs/heads/ | wc -l'

Which gives

Benchmark 1: git for-each-ref  refs/heads/ | wc -l
   Time (mean ± σ):      1.150 s ±  0.010 s    [User: 0.494 s, System: 
0.637 s]
   Range (min … max):    1.140 s …  1.170 s    10 runs

Benchmark 2: git for-each-ref --format=%\(refname\) refs/heads/ | wc -l
   Time (mean ± σ):      66.0 ms ±   0.3 ms    [User: 58.9 ms, System: 
9.5 ms]
   Range (min … max):    65.2 ms …  67.1 ms    43 runs

Benchmark 3: git for-each-ref --format=x refs/heads/ | wc -l
   Time (mean ± σ):      63.0 ms ±   0.5 ms    [User: 54.3 ms, System: 
9.6 ms]
   Range (min … max):    62.3 ms …  65.4 ms    44 runs

Summary
   git for-each-ref --format=x refs/heads/ | wc -l ran
     1.05 ± 0.01 times faster than git for-each-ref 
--format=%\(refname\) refs/heads/ | wc -l
    18.25 ± 0.20 times faster than git for-each-ref  refs/heads/ | wc -l

So on my somewhat slower machine the default format is over an order of 
magnitude slower than using either --format=%(refname) or --format=x and 
the short fixed format is marginally faster. I haven't applied stolee's 
patch but the 3 or 4 times improvement mentioned in the commit message 
seems likely to be from not processing the default format. One thing to 
note is that we're not comparing like-with-like when more than one 
pattern is given as --count-matches gives a separate count for each pattern.

I'm a bit suspicious of the massive speed up I'm seeing by avoiding the 
default format but it appears to be repeatable.

Best Wishes

Phillip

> is much better (obviously you have to remember to do that if you care
> about optimizing your command, but that's true of --count-matches, too).
> 
> Running hyperfine with three variants shows that the command above is
> competitive with --count-matches, though slightly slower (hyperfine
> complains about short commands and outliers because these runtimes are
> so tiny in the first place; I omitted those warnings from the output
> below for readability):
> 
>    Benchmark 1: ./git-for-each-ref refs/remotes/ | wc -l
>      Time (mean ± σ):       6.1 ms ±   0.2 ms    [User: 3.0 ms, System: 3.6 ms]
>      Range (min … max):     5.6 ms …   7.1 ms    397 runs
>    
>    Benchmark 2: ./git-for-each-ref --format="%(refname)" refs/remotes/ | wc -l
>      Time (mean ± σ):       3.3 ms ±   0.2 ms    [User: 2.2 ms, System: 1.5 ms]
>      Range (min … max):     3.0 ms …   4.0 ms    774 runs
>    
>    Benchmark 3: ./git-for-each-ref --count-matches refs/remotes/
>      Time (mean ± σ):       2.4 ms ±   0.1 ms    [User: 1.5 ms, System: 0.9 ms]
>      Range (min … max):     2.2 ms …   3.4 ms    1018 runs
>    
>    Summary
>      './git-for-each-ref --count-matches refs/remotes/' ran
>        1.33 ± 0.10 times faster than './git-for-each-ref --format="%(refname)" refs/remotes/ | wc -l'
>        2.48 ± 0.17 times faster than './git-for-each-ref refs/remotes/ | wc -l'
> 
> I will note this is an unloaded multi-core system, which gives the piped
> version a slight edge. Total CPU is probably more interesting than
> wall-clock time, but all of these are so short that I think the results
> should be taken with a pretty big grain of salt (I had to switch from
> the "powersave" to "performance" CPU governor just to get more
> consistent results).
> 
> -Peff
