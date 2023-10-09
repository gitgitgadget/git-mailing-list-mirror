Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F0ACD613C
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 21:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378789AbjJIVtU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 17:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377858AbjJIVtT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 17:49:19 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8259799
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 14:49:17 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-690bccb0d8aso3825317b3a.0
        for <git@vger.kernel.org>; Mon, 09 Oct 2023 14:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1696888157; x=1697492957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o/H2hvTSiaZupqdJKEFrYAfDICTsztiJ4m83oyJLB3c=;
        b=ZLo+Mbk9o4lss+GRiq1iL99pAqxR+QJxXTfDofMY7SEnAvkP3ZQM4QDiaMTuzth0tH
         jv7/fbR+ibgu4My9jMcS9RMbaLw76mHmaQqbS7k0d1JXMsR9TwUpXPl9Et3ET2JhOHeC
         aBAdmotDLdsLkeznScHgvscsYxVk/jS5i83gjEQPorXRP4uunDutcM+XDA6s1xnVOtTg
         aF/jJPeHrZfafLxTseey5WlyMFYR0QBd+9GnhAa01znlAUY9vvY5tgspYL2HkNRo3N7a
         Z5sWNYxcVmy56Pqg1A/+6YrhZ7LBn9/lV8EcRnbIgNPHGWndvvdZig5VOND1NOTCvlTo
         zGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696888157; x=1697492957;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o/H2hvTSiaZupqdJKEFrYAfDICTsztiJ4m83oyJLB3c=;
        b=Uf0VAvF2y0iAyrDHWIr/lgnoc82JuSoshWsbQnLz3zTgqkqZ0oqR3Y16ozFnexT5bF
         SupeWBhawABbctmn7bDOyedmblhwYvorN8AF2eqNnxxwPudsiMABojldILFSKZbvoq8c
         dSmadP6yfqKshKG8XDBGeeIKk8+KfXT9qp0DZenqCQxFpClW2HmILwT7lhOYBnJNlrES
         PBf4clHisdSvPwt/0bKb3rzVUFWDRyyMnxveEPv8CTwLu5+llgRZtYg5zCi3Hnhakm9E
         3D85GZeZ7/NN6yHUtql7yzxWS2g5wbyVdOMPo5uK6NFI7Y945kh6jAT2d2o+svmp/vJU
         sgIA==
X-Gm-Message-State: AOJu0YwBWSRI+XVVxT2ndSlhmxj2DNCzss/mLpIjh7UzcDPzXRZqWo4i
        TItnGHS4oKNBAsgTZN1iGNyGWIGccKDYLkdxTQ==
X-Google-Smtp-Source: AGHT+IGXLO8Z8ABP46LWWvxzHYXv+5WUlBZqDqzhSV9bddZwAwkhtnmZOTUlH4yInXdij7x+wqgOGw==
X-Received: by 2002:a05:6a20:3ca5:b0:13d:d5bd:7593 with SMTP id b37-20020a056a203ca500b0013dd5bd7593mr15478867pzj.12.1696888156830;
        Mon, 09 Oct 2023 14:49:16 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id d25-20020aa78699000000b0068790c41ca2sm6837682pfo.27.2023.10.09.14.49.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 14:49:16 -0700 (PDT)
Message-ID: <28ae03f5-7091-d3f3-8a70-56aba6639640@github.com>
Date:   Mon, 9 Oct 2023 14:49:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 0/4] Performance improvement & cleanup in loose ref
 iteration
Content-Language: en-US
To:     Patrick Steinhardt <ps@pks.im>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1594.git.1696615769.gitgitgadget@gmail.com>
 <ZSPQI2gkLOSdNWLu@tanuki>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <ZSPQI2gkLOSdNWLu@tanuki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt wrote:
> On Fri, Oct 06, 2023 at 06:09:25PM +0000, Victoria Dye via GitGitGadget wrote:
>> While investigating ref iteration performance in builtins like
>> 'for-each-ref' and 'show-ref', I found two small improvement opportunities.
>>
>> The first patch tweaks the logic around prefix matching in
>> 'cache_ref_iterator_advance' so that we correctly skip refs that do not
>> actually match a given prefix. The unnecessary iteration doesn't seem to be
>> causing any bugs in the ref iteration commands that I've tested, but it
>> doesn't hurt to be more precise (and it helps with some other patches I'm
>> working on ;) ).
>>
>> The next three patches update how 'loose_fill_ref_dir' determines the type
>> of ref cache entry to create (directory or regular). On platforms that
>> include d_type information in 'struct dirent' (as far as I can tell, all
>> except NonStop & certain versions of Cygwin), this allows us to skip calling
>> 'stat'. In ad-hoc testing, this improved performance of 'git for-each-ref'
>> by about 20%.
> 
> I've done a small set of benchmarks with my usual test repositories,
> which is linux.git with a bunch of references added. The repository
> comes in four sizes:
> 
> - small: 50k references
> - medium: 500k references
> - high:  1.1m references
> - huge: 12m references
> 
> Unfortunately, I couldn't really reproduce the performance improvements.
> In fact, the new version runs consistently a tiny bit slower than the
> old version:
> 
>     # Old version, which is 3a06386e31 (The fifteenth batch, 2023-10-04).
> 
>     Benchmark 1: git for-each-ref (revision=old,refcount=small)
>       Time (mean ± σ):     135.5 ms ±   1.2 ms    [User: 76.4 ms, System: 59.0 ms]
>       Range (min … max):   134.8 ms … 136.9 ms    3 runs
> 
>     Benchmark 2: git for-each-ref (revision=old,refcount=medium)
>       Time (mean ± σ):     822.7 ms ±   2.2 ms    [User: 697.4 ms, System: 125.1 ms]
>       Range (min … max):   821.1 ms … 825.2 ms    3 runs
> 
>     Benchmark 3: git for-each-ref (revision=old,refcount=high)
>       Time (mean ± σ):      1.960 s ±  0.015 s    [User: 1.702 s, System: 0.257 s]
>       Range (min … max):    1.944 s …  1.973 s    3 runs
> 
>     # New version, which is your tip.
> 
>     Benchmark 4: git for-each-ref (revision=old,refcount=huge)
>       Time (mean ± σ):     16.815 s ±  0.054 s    [User: 15.091 s, System: 1.722 s]
>       Range (min … max):   16.760 s … 16.869 s    3 runs
> 
>     Benchmark 5: git for-each-ref (revision=new,refcount=small)
>       Time (mean ± σ):     136.0 ms ±   0.2 ms    [User: 78.8 ms, System: 57.1 ms]
>       Range (min … max):   135.8 ms … 136.2 ms    3 runs
> 
>     Benchmark 6: git for-each-ref (revision=new,refcount=medium)
>       Time (mean ± σ):     830.4 ms ±  21.2 ms    [User: 691.3 ms, System: 138.7 ms]
>       Range (min … max):   814.2 ms … 854.5 ms    3 runs
> 
>     Benchmark 7: git for-each-ref (revision=new,refcount=high)
>       Time (mean ± σ):      1.966 s ±  0.013 s    [User: 1.717 s, System: 0.249 s]
>       Range (min … max):    1.952 s …  1.978 s    3 runs
> 
>     Benchmark 8: git for-each-ref (revision=new,refcount=huge)
>       Time (mean ± σ):     16.945 s ±  0.037 s    [User: 15.182 s, System: 1.760 s]
>       Range (min … max):   16.910 s … 16.983 s    3 runs
> 
>     Summary
>       git for-each-ref (revision=old,refcount=small) ran
>         1.00 ± 0.01 times faster than git for-each-ref (revision=new,refcount=small)
>         6.07 ± 0.06 times faster than git for-each-ref (revision=old,refcount=medium)
>         6.13 ± 0.17 times faster than git for-each-ref (revision=new,refcount=medium)
>        14.46 ± 0.17 times faster than git for-each-ref (revision=old,refcount=high)
>        14.51 ± 0.16 times faster than git for-each-ref (revision=new,refcount=high)
>       124.09 ± 1.15 times faster than git for-each-ref (revision=old,refcount=huge)
>       125.05 ± 1.12 times faster than git for-each-ref (revision=new,refcount=huge)
> 
> The performance regression isn't all that concerning, but it makes me
> wonder why I see things becoming slower rather than faster. My guess is
> that this is because all my test repositories are well-packed and don't
> have a lot of loose references. But I just wanted to confirm how you
> benchmarked your change and what the underlying shape of your test repo
> was.

I ran my benchmark on my (Intel) Mac with a test repository (single commit,
one file) containing:

- 10k refs/heads/ references
- 10k refs/tags/ references
- 10k refs/special/ references 

All refs in the repository are loose. My Mac has historically been somewhat
slow and inconsistent when it comes to perf testing, though, so I re-ran the
benchmark a bit more formally on an Ubuntu VM (3 warmup iterations followed
by at least 10 iterations per test):

---

Benchmark 1: git for-each-ref (revision=old,refcount=3k)
  Time (mean ± σ):      40.6 ms ±   3.9 ms    [User: 13.2 ms, System: 27.1 ms]
  Range (min … max):    37.2 ms …  59.1 ms    76 runs
 
  Warning: Statistical outliers were detected. Consider re-running this benchmark on a quiet system without any interferences from other programs. It might help to use the '--warmup' or '--prepare' options.
 
Benchmark 2: git for-each-ref (revision=new,refcount=3k)
  Time (mean ± σ):      38.7 ms ±   4.4 ms    [User: 13.8 ms, System: 24.5 ms]
  Range (min … max):    35.1 ms …  57.2 ms    71 runs
 
  Warning: Statistical outliers were detected. Consider re-running this benchmark on a quiet system without any interferences from other programs. It might help to use the '--warmup' or '--prepare' options.
 
Benchmark 3: git for-each-ref (revision=old,refcount=30k)
  Time (mean ± σ):     419.4 ms ±  43.9 ms    [User: 136.4 ms, System: 274.1 ms]
  Range (min … max):   385.1 ms … 528.7 ms    10 runs
 
Benchmark 4: git for-each-ref (revision=new,refcount=30k)
  Time (mean ± σ):     390.4 ms ±  27.2 ms    [User: 133.1 ms, System: 251.6 ms]
  Range (min … max):   360.3 ms … 447.6 ms    10 runs
 
Benchmark 5: git for-each-ref (revision=old,refcount=300k)
  Time (mean ± σ):      4.171 s ±  0.052 s    [User: 1.400 s, System: 2.715 s]
  Range (min … max):    4.118 s …  4.283 s    10 runs
 
Benchmark 6: git for-each-ref (revision=new,refcount=300k)
  Time (mean ± σ):      3.939 s ±  0.054 s    [User: 1.403 s, System: 2.466 s]
  Range (min … max):    3.858 s …  4.026 s    10 runs
 
Summary
  'git for-each-ref (revision=new,refcount=3k)' ran
    1.05 ± 0.16 times faster than 'git for-each-ref (revision=old,refcount=3k)'
   10.08 ± 1.34 times faster than 'git for-each-ref (revision=new,refcount=30k)'
   10.83 ± 1.67 times faster than 'git for-each-ref (revision=old,refcount=30k)'
  101.68 ± 11.63 times faster than 'git for-each-ref (revision=new,refcount=300k)'
  107.67 ± 12.30 times faster than 'git for-each-ref (revision=old,refcount=300k)'

---

So it's not the 20% speedup I saw on my local test repo (it's more like
5-8%), but there does appear to be a consistent improvement. As for your
results, the changes in this series shouldn't affect packed ref operations,
and the difference between old & new doesn't seem to indicate a regression. 

