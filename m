Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_MIXED_ES shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F2CF20A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 14:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbeLLOE0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 09:04:26 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53]:46464 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbeLLOE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 09:04:26 -0500
Received: by mail-ed1-f53.google.com with SMTP id o10so15605357edt.13
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 06:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Jn9btXbz0tt6vIoDMhn05XFTgcgTqWo4zkP+mp6P42I=;
        b=FJwdq/G+8f2/Jh3rjwmwOD6cfbAfCxW6hWX0oIn7/dDvVAA8hdpGVRhuLDa0s2PbO4
         QwKGlv7INZQpcj1MDv1W5iageizjNrOJvLezrTiO0KhxXUHhJXY6o+Uy3HyofUU8Voma
         3c9Ut0rnnYkk5k1i79yRQQoFLMoq5snCRrIRxu/o2onW+7qD12jsMpJvU+gx67s44XNw
         Y1k3bMheWBUIlOCcv7NfEpj04S/UWkJ+iWyzS4ImfnW7t042baKmWeiRJ1HLDbi/9Lb+
         K1mOP6m9qXp12/HpkjlREewP0RLdkUS3n+/TCJJWjLRJEbGTVvupj2HxdHoNw0TuWLX0
         fjwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Jn9btXbz0tt6vIoDMhn05XFTgcgTqWo4zkP+mp6P42I=;
        b=t46tnQX+yxwALS3uHEdx7hXmrFj5lW+LQZzwcXbO8w9e8tXvobwjNcTiM5nYYA9btY
         gEZIKzopCPJCms1Xd4miDm+RvF5IiEpwkAP++PgUTmFCql59oUZeU4yDnz7TSaAonZhj
         ek6evtVxAxq11GTpbSmIohXBcGUs6gvG8rBbO+PlGw+wMftVS++qLLqQsbgfZqe0feVb
         bWm+fYvNlrGiWAx2S7/94cRzbW6SlWOqfONAP12XIbHG8BH30OZXW66UrIGoHtwPmg3C
         T06crhE6kKI9fRLP+bwXezzfx3ZcnjSS/v4lCr6XOX6uBPaw2h2qORyYTIL9lDXlxiVN
         CfeA==
X-Gm-Message-State: AA+aEWYsswRWXPfwK+LhUVHQgK4RicAOLYI7RtVtYvvYKi/tVHXvkYD3
        fSwiwvKN6t7C29hnyJYGwUZz7Z3bwcU=
X-Google-Smtp-Source: AFSGD/WW+jXYjE2OkPVMxYZoa4BEQZxR80ORqY/XOBB5VZ068lc9N6hSb21q09KTE8DXhkx7GKr6mA==
X-Received: by 2002:a50:8e16:: with SMTP id 22mr19424866edw.32.1544623462472;
        Wed, 12 Dec 2018 06:04:22 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id v20sm5008253edm.29.2018.12.12.06.04.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 06:04:21 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     "Iucha\, Florin" <Florin.Iucha@amd.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: High locking contention during repack?
References: <SN1PR12MB23840AFE62E41D908A40D1B095A70@SN1PR12MB2384.namprd12.prod.outlook.com> <20181212112409.GB30673@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181212112409.GB30673@sigill.intra.peff.net>
Date:   Wed, 12 Dec 2018 15:04:19 +0100
Message-ID: <87wooen8nw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 12 2018, Jeff King wrote:

> On Wed, Dec 12, 2018 at 03:01:47AM +0000, Iucha, Florin wrote:
>
>> I am running “git-repack  -A -d -f -F --window=250 --depth=250” on a
>> Git repository converted using git-svn.
>
> Sort of tangential to your question, but:
>
>   - Using "-F" implies "-f" already, so you don't need both. That said,
>     you are probably wasting CPU to use "-F", unless you have adjusted
>     zlib compression settings since the last pack. (Whereas using "-f"
>     is useful, if you're willing to pay the CPU tradeoff).
>
>   - Using --depth=250 does not actually decrease the packfile size very
>     much, and results in a packfile which is more expensive for
>     subsequent processes to use. Some experimentation showed that
>     --depth=50 is a sweet spot, and that is the default for both normal
>     "git gc" and "git gc --aggressive" these days.
>
>     See 07e7dbf0db (gc: default aggressive depth to 50, 2016-08-11) for
>     more discussion.

I wonder if the size is still too high. I'd rather take the 5-10%
speedup quoted in that commit than a slight decrease in disk space use.

The git.git repository now with the repack command in that commit
message, with --depth=$n:

    573M    /tmp/git-1
    200M    /tmp/git-2
    118M    /tmp/git-3
    91M     /tmp/git-4
    82M     /tmp/git-5
    77M     /tmp/git-6
    74M     /tmp/git-7
    72M     /tmp/git-8
    71M     /tmp/git-9
    70M     /tmp/git-10
    67M     /tmp/git-15
    66M     /tmp/git-20
    65M     /tmp/git-40
    65M     /tmp/git-35
    65M     /tmp/git-30
    65M     /tmp/git-25
    64M     /tmp/git-50
    64M     /tmp/git-45

Produced via:

    parallel 'rm -rf /tmp/git-{}; cp -Rvp /tmp/git.git/ /tmp/git-{} && git -C /tmp/git-{} repack -adf --depth={} --window=250' ::: {1..10} 15 20 25 30 35 40 45 50

And then the log -S benchmarks:

              s/iter log -S 1 log -S 50 log -S 45 log -S 35 log -S 30 log -S 25 log -S 20 log -S 15 log -S 10 log -S 5
    log -S 1    12.6       --      -26%      -27%      -32%      -36%      -38%      -38%      -39%      -40%     -42%
    log -S 50   9.28      36%        --       -0%       -7%      -13%      -15%      -16%      -18%      -19%     -21%
    log -S 45   9.25      36%        0%        --       -7%      -12%      -15%      -16%      -17%      -19%     -20%
    log -S 35   8.62      46%        8%        7%        --       -6%       -9%      -10%      -11%      -13%     -14%
    log -S 30   8.12      55%       14%       14%        6%        --       -3%       -4%       -6%       -8%      -9%
    log -S 25   7.86      60%       18%       18%       10%        3%        --       -1%       -3%       -5%      -6%
    log -S 20   7.77      62%       19%       19%       11%        4%        1%        --       -2%       -3%      -5%
    log -S 15   7.64      65%       21%       21%       13%        6%        3%        2%        --       -2%      -4%
    log -S 10   7.51      68%       24%       23%       15%        8%        5%        3%        2%        --      -2%
    log -S 5    7.37      71%       26%       25%       17%       10%        7%        5%        4%        2%       --

So we're getting a 20% speedup in log -S by using --depth=5 instead of
--depth=50, neatly at the cost of 20% more disk space, but could also
get a 19% speedup for 8% (--depth=10) more disk space, etc.

Then in rev-list it makes less of a difference, narrowing this down a
bit:

                s/iter rev-list 50 rev-list 25 rev-list 10  rev-list 5
    rev-list 50   1.61          --         -1%         -4%         -5%
    rev-list 25   1.60          1%          --         -3%         -4%
    rev-list 10   1.55          4%          3%          --         -1%
    rev-list 5    1.54          5%          4%          1%          --

It seems to me we should at least move this to --depth=25 by default. A
~15% speedup in log -S & other mass-blob lookups for 1.5% more disk
space seems like a good trade-off. As your commit notes RAM (or disk
space) is not commonly the bottleneck anymore.

>> The system is a 16 core / 32 thread Threadripper with 128GB of RAM and
>> NVMe storage. The repack starts strong, with 32 threads but it fairly
>> quickly gets to 99% done and the number of threads drops to 4 then 3
>> then 2. However, running “dstat 5” I see lots of “sys” time without
>> any IO time (the network traffic you see is caused by SSH).
>
> This sounds mostly normal and expected. The parallel part of a repack is
> the delta search, which is not infinitely parallelizable. Each worker
> thread is given a "chunk" of objects, and it uses a sliding window to
> search for delta pairs through that chunk. You don't want a chunk that
> approaches the window size, since at every chunk boundary you're missing
> delta possibilities.
>
> The default chunk size is about 1/nr_threads of the total list size
> (i.e., we portion out all the work). And then when a thread finishes, we
> take work from the thread with the most work remaining, and portion it
> out. However, at some point the chunks approach their minimum, and we
> stop dividing. So the number of threads will drop, eventually to 1, and
> you'll be waiting on it to finish that final chunk.
>
> So that's all working as planned. Having high sys load does seem a bit
> odd. Most of the effort should be going to reading the mmap'd data from
> disk, zlib-inflating it and computing a fingerprint, and then comparing
> the fingerprints. So that would mostly be user time.
>
>> Running a strace on the running git-repack process shows only these:
>> --- SIGALRM {si_signo=SIGALRM, si_code=SI_KERNEL} ---
>> --- SIGALRM {si_signo=SIGALRM, si_code=SI_KERNEL} ---
>> --- SIGALRM {si_signo=SIGALRM, si_code=SI_KERNEL} ---
>> --- SIGALRM {si_signo=SIGALRM, si_code=SI_KERNEL} ---
>> --- SIGALRM {si_signo=SIGALRM, si_code=SI_KERNEL} ---
>> --- SIGALRM {si_signo=SIGALRM, si_code=SI_KERNEL} ---
>>
>> Any idea on how to debug this? I have ran git-repack under gdb, but it seems to spin on builtin/repack.c line 409.
>
> The heavy lifting here is done by the pack-objects child process, not
> git-repack itself. Try running with GIT_TRACE=1 in the environment to
> see the exact invocation, but timing and debugging:
>
>   git pack-objects --all --no-reuse-delta --delta-base-offset --stdout \
>     </dev/null >/dev/null
>
> should produce interesting results.
>
> The SIGALRM loop you see above is likely just the progress meter
> triggering once per second (the actual worker threads are updating an
> int, and then at least once per second we'll show the int).
>
> -Peff
