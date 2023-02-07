Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B488EC636CD
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 14:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbjBGOze (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 09:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjBGOzd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 09:55:33 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A737EC2
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 06:55:31 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id az4-20020a05600c600400b003dff767a1f1so6397685wmb.2
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 06:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p6c49yliYLmqBMwQL7RhogeSLm5Zpj6RmWhqiGTKmkw=;
        b=I+jSS3oZQygEUos0ag4mlQNh1wS0HBKMQ9+Lt3uiaJcTASnnfaziYxGA+chdS7NRfd
         7l58B/3kF7csWMM79MK1oB2b985wGscGoQGuOwYWXvb/+6dBsgUJxNLI3rKsN7iA7lKT
         Nxc2CO7MFEao2DDsf+Yk8b9m6H2/QUAbT3WZd89JLxDbhOu8mg1KKkHzquZU4m+QYmYE
         Ma7wWB+6vcGQpju7WFa/adNtXdwCTrlR6n/PjGLRxztqOxJlwg0mXMHJ3N6NMZdpu6ix
         k+i5DeGO0eRcGziCipkWmPNvQhGOmGalU4gxUagNlRc2O0peLIWOB6NIJ2w1/bsoaeKj
         ZftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6c49yliYLmqBMwQL7RhogeSLm5Zpj6RmWhqiGTKmkw=;
        b=YwM1mR/jO3MPfDDATkyEDOot0ViJK8SXjCm97Lh4UXqhVEPyU3dxGGcJ3MRgQpWnbL
         k0OzfcEkO+xHom6OIYiiXAJEpXI0mkvIWNyj2kbqWaR4qZLrIwIwRwiC9FyxLRh6u/uw
         HTUw5bfIKWfTHtD1pln04P1kTRzV8uqsMn70wZ4/UoxoVk59VNkq91os3SjCD+8dafE1
         IBeDAuEu3GKCX2Zxa/vNBQ6D34xX1P+zo4KE4Wu+N1VpUlA5j9FwitNHFHsHdnj4qW0V
         +bwWvtkl7TWvU36yvyGyz6C4jKdj812+C3FI0R8qEKemtlBsksyl9MPGUzLZ6TX+V5xK
         F70Q==
X-Gm-Message-State: AO0yUKV4fHPBWH7fg26cRdoxWbA7CGqiWgO5/NAp4wwbHpF2LT/UqnBo
        VCFLuXFoUDG+79JRp09pTXI=
X-Google-Smtp-Source: AK7set8ge0ZK5SRHiKVhZTFCRmYOuXIKIbv5qWfBTmA8DV99i6y9uxilPYrwTz/XxSFejd/nr+mRqg==
X-Received: by 2002:a05:600c:502b:b0:3dc:c05:9db6 with SMTP id n43-20020a05600c502b00b003dc0c059db6mr3279515wmr.33.1675781729965;
        Tue, 07 Feb 2023 06:55:29 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id f12-20020a05600c154c00b003e0238d9101sm2047954wmg.31.2023.02.07.06.55.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 06:55:29 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <d18a5c32-2f15-93ad-ccbf-e8f048edb311@dunelm.org.uk>
Date:   Tue, 7 Feb 2023 14:55:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] diff: teach diff to read gitattribute diff-algorithm
Content-Language: en-US
To:     John Cai <johncai86@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
 <8e73793b0db3e84366a9c6441cc0fdc04f9614a5.1675568781.git.gitgitgadget@gmail.com>
 <230206.865yce7n1w.gmgdl@evledraar.gmail.com>
 <B544D9E8-13C4-4682-9BDA-D6E19B51C91D@gmail.com>
In-Reply-To: <B544D9E8-13C4-4682-9BDA-D6E19B51C91D@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi John

On 06/02/2023 20:37, John Cai wrote:
> On 6 Feb 2023, at 11:39, Ævar Arnfjörð Bjarmason wrote:
>> On Sun, Feb 05 2023, John Cai via GitGitGadget wrote:
>> For some non-nitpicking, I do worry about exposing this as a DoS vector,
>> e.g. here's a diff between two distant points in git.git with the
>> various algorithms:
>>
>> 	$ hyperfine -r 1 -L a patience,minimal,histogram,myers 'git diff --diff-algorithm={a} v2.0.0 v2.28.0'
>> 	Benchmark 1: git diff --diff-algorithm=patience v2.0.0 v2.28.0
>> 	  Time (abs ≡):        42.121 s               [User: 41.879 s, System: 0.144 s]
>> 	
>> 	Benchmark 2: git diff --diff-algorithm=minimal v2.0.0 v2.28.0
>> 	  Time (abs ≡):        35.634 s               [User: 35.473 s, System: 0.160 s]
>> 	
>> 	Benchmark 3: git diff --diff-algorithm=histogram v2.0.0 v2.28.0
>> 	  Time (abs ≡):        46.912 s               [User: 46.657 s, System: 0.228 s]
>> 	
>> 	Benchmark 4: git diff --diff-algorithm=myers v2.0.0 v2.28.0
>> 	  Time (abs ≡):        33.233 s               [User: 33.072 s, System: 0.160 s]
>> 	
>> 	Summary
>> 	  'git diff --diff-algorithm=myers v2.0.0 v2.28.0' ran
>> 	    1.07 times faster than 'git diff --diff-algorithm=minimal v2.0.0 v2.28.0'
>> 	    1.27 times faster than 'git diff --diff-algorithm=patience v2.0.0 v2.28.0'
>> 	    1.41 times faster than 'git diff --diff-algorithm=histogram v2.0.0 v2.28.0'
> 
> Thanks for this analysis. To clarify, .gitconfig's diff.algorithm setting is
> already an attack vector right?

.gitconfig is under the user's control though whereas .gitattributes is 
attacker controlled if one clones a malicious repository. Having said 
the worst results above are for the historgram algorithm that merge-ort 
uses internally and no one has complained about ort's performance.

> I see how this would be adding another one.
> 
> That being said, here's a separate issue. I benchmarked the usage of
> .gitattributes as introduced in this patch series, and indeed it does look like
> there is additional latency:
> 
> $ echo "* diff-algorithm=patience >> .gitattributes
> $ hyperfine -r 5 'git-bin-wrapper diff --diff-algorithm=patience v2.0.0 v2.28.0'                      ✭
> Benchmark 1: git-bin-wrapper diff --diff-algorithm=patience v2.0.0 v2.28.0
>    Time (mean ± σ):     889.4 ms ± 113.8 ms    [User: 715.7 ms, System: 65.3 ms]
>    Range (min … max):   764.1 ms … 1029.3 ms    5 runs
> 
> $ hyperfine -r 5 'git-bin-wrapper diff v2.0.0 v2.28.0'                                                ✭
> Benchmark 1: git-bin-wrapper diff v2.0.0 v2.28.0
>    Time (mean ± σ):      2.146 s ±  0.368 s    [User: 0.827 s, System: 0.243 s]
>    Range (min … max):    1.883 s …  2.795 s    5 runs
> 
> and I imagine the latency scales with the size of .gitattributes. Although I'm
> not familiar with other parts of the codebase and how it deals with the latency
> introduced by reading attributes files.

Ouch! Thanks for benchmarking that is a suspiciously large slow down. 
I've a feeling the attributes code parses all the .gitattribute files 
from scratch for each path that's queried, so there may be scope for 
making it a bit smarter. I see some slow down but no where near as much


$ hyperfine -r 3 'bin-wrappers/git diff --diff-algorithm=patience 
--no-color --no-color-moved v2.0.0 v2.28.0'
Benchmark 1: bin-wrappers/git diff --diff-algorithm=patience --no-color 
--no-color-moved v2.0.0 v2.28.0
   Time (mean ± σ):      1.996 s ±  0.008 s    [User: 1.706 s, System: 
0.286 s]
   Range (min … max):    1.989 s …  2.004 s    3 runs

$ hyperfine -r 5 'bin-wrappers/git diff --no-color --no-color-moved 
v2.0.0 v2.28.0'
Benchmark 1: bin-wrappers/git diff --no-color --no-color-moved v2.0.0 
v2.28.0
   Time (mean ± σ):      2.238 s ±  0.037 s    [User: 1.880 s, System: 
0.350 s]
   Range (min … max):    2.216 s …  2.303 s    5 runs


Perhaps I'm over simplifying but having read the issue you linked to I 
couldn't help feeling that the majority of users might be satisfied by 
just changing gitlab to use the patience algorithm when generating 
diffs. The idea to use .gitattributes seems to have come from Patrick 
rather than a user request.

This is slightly off topic but one thing I'd really like is a way to 
tell diff use automatically use --diff-words on some files (e.g. 
Documentation/*)

Best Wishes

Phillip

>> Now, all of those are very slow overall, but some much more than
>> others. I seem to recall that the non-default ones also had some
>> pathological cases.
>>
>> Another thing to think about is that we've so far considered the diff
>> algorithm to be purely about presentation, with some notable exceptions
>> such as "patch-id".
>>
>> I've advocated for us getting to the point of having an in-repo
>> .gitconfig or .gitattributes before with a whitelist of settings like
>> diff.context for certain paths, or a diff.orderFile.
>>
>> But those seem easy to promise future behavior for, v.s. an entire diff
>> algorithm (which we of course had before, but now we'd have it in
>> repository data).
>>
>> Maybe that's not a distinction worth worrying about, just putting that
>> out there.
>>
>> I think if others are concerned about the above something that would
>> neatly side-step those is to have it opt-in via the .git/config somehow,
>> similar to e.g. how you can commit *.gpg content, put this in
>> .gitattributes:
>>
>> 	*.gpg diff=gpg
>>
>> But not have it do anything until this is in the repo's .git/config (or
>> similar):
>>
>> 	[diff "gpg"]
>>          	textconv = gpg --no-tty --decrypt
>>
>> For that you could still keep the exact .gitattributes format you have
>> here, i.e.:
>>
>> 	file* diff-algorithm=$STRATEGY
>>
>> But we to pick it up we'd need either:
>>
>> 	[diff-algorithm]
>>          	histogram = myers
>>
>> Or:
>>
>> 	[diff-algorithm "histogram"]
>>          	allow = true
> 
> This would help address slowness from the diff algorithm itself. I'm not opposed
> to adding this config if this attack vector is concerning to people.
> 
> However, it wouldn't help address the additional latency of scanning
> .gitattributes to find the diff algorithm.
> 
> Would a separate config to allow gitattributes be helpful here?
> 
> [diff-algorithm]
> 	attributes = true
> 
>>
>> The former form being one that would allow you to map the .gitattributes
>> of the repo (but maybe that would be redundant to
>> .git/info/attributes)...
