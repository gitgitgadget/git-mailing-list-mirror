Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1076EB64D7
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 13:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjF1NMp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 09:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjF1NMn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 09:12:43 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5312132
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 06:12:41 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fa99742be2so35526965e9.1
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 06:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687957960; x=1690549960;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Pq0FBxW1u5flMeQxe7iS7UTJodND1Zd7W76UCKzkFaU=;
        b=Vp/8tVjvkerTb8kj70i3HI/uy0u1w6d6KD0IKEtB2ZvfMrZRwyr9cntz0WKpL+L3tk
         lxmxPncbICU/HmqJrIOzD1CrPr0Je+Z7fj22F50ASazXHNbI/UgtYncf/VW65yzq+gKU
         9TGP/wVDwgMw3Myn/eCp56d0laILWCxD94GQAlWApB81yoUliRpJsf5HqzoC05CQJ7Nl
         gf2tIytod/hLYHKOriBeDwd2qPo4LMONpqIptA2tj9o1sWS4e1eHrh8TvpALsNN4hJAR
         aUG76BG8SJuztbAQJkczZnWJ6vf2zJULU7UkU/G7tysmxyk0J+KDT+EG4VgG8/kJy71q
         fBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687957960; x=1690549960;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pq0FBxW1u5flMeQxe7iS7UTJodND1Zd7W76UCKzkFaU=;
        b=iQAwz8d2ON61xjDv7h2iWOoePgMOE01gOt8FCDhmJMR69rdjpQNCkW5Dvh1/VF5R0B
         dRvHDj80jzh+0xT3gLgl5hHqTu2a65GD+7tDfZDxIkn1KSg3PrnQuJU74+AYffznNhQv
         DTnQ9X4JbxHyqbJeJXKOpwwyi5Mn72Wpfo/x9aEVknSj22sMNhD7vLcr4XaCfzvItpqE
         9FBWxHFoaq+kQL3HsA+mQLq4BJiUmpByPX5hl9hsqKxLkjs7+ftAKFKcebNamnMGS6I3
         mDb/mrwW6IgKm2+lgciHkJ87Ih4azCEXAwhRJPovPksbxs+Y6S2jopnJvTQCQLv99UXe
         WzDA==
X-Gm-Message-State: AC+VfDxvTntH2/cktEbkxTuFsVUrUkGrAYGrYMVBEwC7hSchD/qJlGgQ
        EIpaA7w3lYKmxuMaKAeocDk=
X-Google-Smtp-Source: ACHHUZ4/UG6OEbHtrQQfPh/60sNjdHMLaL7PrP5tka20+msaCRjTSEi4G4lNMKUAlMIfgVgEwlyffw==
X-Received: by 2002:a05:600c:3799:b0:3fb:a0fc:1ba1 with SMTP id o25-20020a05600c379900b003fba0fc1ba1mr4577650wmr.35.1687957959882;
        Wed, 28 Jun 2023 06:12:39 -0700 (PDT)
Received: from [192.168.1.195] ([90.242.235.211])
        by smtp.googlemail.com with ESMTPSA id y23-20020a7bcd97000000b003fbb2c0fce5sm1268685wmj.25.2023.06.28.06.12.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 06:12:39 -0700 (PDT)
Message-ID: <776c3682-d2eb-d2d7-3ea8-4a7db8cd7842@gmail.com>
Date:   Wed, 28 Jun 2023 14:12:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] for-each-ref: add --count-matches option
Content-Language: en-US
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        vdye@github.com, me@ttaylorr.com, mjcheetham@outlook.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1548.git.1687792197.gitgitgadget@gmail.com>
 <9121e027fb9f157878a9624ce6c834b69cd38472.1687792197.git.gitgitgadget@gmail.com>
 <20230627073007.GD1226768@coredump.intra.peff.net>
 <f6fd39bc-65d4-76e3-94b4-9163194c89dd@gmail.com>
In-Reply-To: <f6fd39bc-65d4-76e3-94b4-9163194c89dd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/06/2023 11:05, Phillip Wood wrote:
> On 27/06/2023 08:30, Jeff King wrote:
>> I don't think this is a very realistic perf test, because for-each-ref
>> is doing a bunch of work to generate its default format, only to have
>> "wc" throw most of it away. Doing:
>>
>>    git for-each-ref --format='%(refname)' | wc -l
> 
> That's a good point. I wondered if using a short fixed format string was 
> even better so I tried
> 
> git init test
> cd test
> git commit --allow-empty -m initial
> seq 0 100000 | sed "s:\(.*\):create refs/heads/some-prefix/\1 $(git 
> rev-parse HEAD):" | git update-ref --stdin
> git pack-refs --all
> hyperfine -L fmt "","--format=%\(refname\)","--format=x" 'git 
> for-each-ref {fmt} refs/heads/ | wc -l'
> 
> Which gives
> [...] 
> Summary
>    git for-each-ref --format=x refs/heads/ | wc -l ran
>      1.05 ± 0.01 times faster than git for-each-ref 
> --format=%\(refname\) refs/heads/ | wc -l
>     18.25 ± 0.20 times faster than git for-each-ref  refs/heads/ | wc -l
> [...] 
> I'm a bit suspicious of the massive speed up I'm seeing by avoiding the 
> default format but it appears to be repeatable.

Having seen Peff's mail [1] I realized that my test repo above is 
looking up the commit from a loose object. If I repack the repository 
then the default format is still slower than using "--format=%(refname)" 
but is much more competitive.

$ git repack -a
Enumerating objects: 2, done.
Counting objects: 100% (2/2), done.
Writing objects: 100% (2/2), done.
Total 2 (delta 0), reused 0 (delta 0), pack-reused 0

$ hyperfine -L fmt "","--format=%\(refname\)","--format=x" 'git 
for-each-ref {fmt} refs/heads/ | wc'
Benchmark 1: git for-each-ref  refs/heads/ | wc -l
   Time (mean ± σ):     111.4 ms ±   1.4 ms    [User: 96.9 ms, System: 
19.6 ms]
   Range (min … max):   109.6 ms … 115.1 ms    25 runs

Benchmark 2: git for-each-ref --format=%\(refname\) refs/heads/ | wc -l
   Time (mean ± σ):      66.7 ms ±   0.7 ms    [User: 59.5 ms, System: 
9.5 ms]
   Range (min … max):    65.6 ms …  68.2 ms    42 runs

Benchmark 3: git for-each-ref --format=x refs/heads/ | wc -l
   Time (mean ± σ):      63.4 ms ±   0.7 ms    [User: 56.3 ms, System: 
8.0 ms]
   Range (min … max):    61.9 ms …  65.1 ms    44 runs

Summary
   git for-each-ref --format=x refs/heads/ | wc -l ran
     1.05 ± 0.02 times faster than git for-each-ref 
--format=%\(refname\) refs/heads/ | wc -l
     1.76 ± 0.03 times faster than git for-each-ref  refs/heads/ | wc -l

So it seems most of the slowdown I was seeing yesterday was due it 
looking up a loose object. I'm surprised repacking makes such a 
difference in a repository that only contains two objects.

Best Wishes

Phillip

[1] 
https://lore.kernel.org/git/20230627195900.GC1280909@coredump.intra.peff.net
