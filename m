Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E37411F404
	for <e@80x24.org>; Wed,  7 Feb 2018 15:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754566AbeBGPKf (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 10:10:35 -0500
Received: from mail-qt0-f170.google.com ([209.85.216.170]:44900 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754503AbeBGPKc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 10:10:32 -0500
Received: by mail-qt0-f170.google.com with SMTP id f18so1864327qth.11
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 07:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=P8iB2p3SEKKBCLxw99BZfPR0ykJerB+EzKVXsiFp1Lo=;
        b=ck4901j2If0c5PztXb+VCoIb3j6Ni8WASbavbcR8s64QurHupUS9Y2syqVTTCItwnZ
         oeJXOqTWHzKlwlIuryXQl4Fy4fI5Nz3+P43BUPwajX3mcVbnjE7d7Qs2QcesjaFIWz8A
         c9VFUb4iIKmFnfdUOxpAYvNPUv5BzoemVtizFzHYR2UGA8TyvwqPcCNC+RvayiNjsQ5N
         gi+cqY7Z9JABm1yoIhZhUFmnuH6nrjdkdKQ7VCa/WhcBfOzmACE10mRwkN6sQFlL0W4w
         eVCb0ShkZjn3Ci2kYB8JrzjZM6R0ZM0lARMTy3Z9uVlIcjSqtCcn3IfGAAyzjdmsjFIA
         jIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=P8iB2p3SEKKBCLxw99BZfPR0ykJerB+EzKVXsiFp1Lo=;
        b=VEKxzuHk6IHtii7dnQkoHCqUWKFWoLUb0VeBBKnpY1YDnCR+PSK7+4qNjmriYr1HAb
         NzFJ/COgzipbJYjUaeDXUibizNSa7AwmF74yiFYYUFfqbhYGqdnB2FzUPZ5OCP4kiCoF
         55ixHRDd6jwOMAQ645sJbVtJZNTc+ytDHtZby/uVwW2kW0KnW8UEZhgI8kpjGfmWs0p7
         13KYv/QaLlwTUA6i62zMXoYQVXGMvQ8jvXGS8Rlp8EaMUVJTNanQdDiRjizPOEhMhH8z
         WjWSfGpLpbF+8wlJtvXcPZ+WC6B6sSJv7hXI5+8+3VwyKN7JvyriqsuyONEXW7ePEkKN
         2FjA==
X-Gm-Message-State: APf1xPDIiDmxTz5L7uGwKgJxmBi2hWKqKDv0LyJQmf9qVU/v3ORX1+J8
        IUacl93nP0358+XuYbiL78o=
X-Google-Smtp-Source: AH8x224sgjcHYq1XoTcmjoHrfDJYhlqzGB+xVFnenU9+i7vPEUvowNhs4INdN0kQhuebo9KV04ptMQ==
X-Received: by 10.237.58.133 with SMTP id o5mr9534902qte.307.1518016231823;
        Wed, 07 Feb 2018 07:10:31 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:202b:7de3:f7b7:31b1? ([2001:4898:8010:0:961:7de3:f7b7:31b1])
        by smtp.gmail.com with ESMTPSA id m7sm1164448qtg.43.2018.02.07.07.10.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Feb 2018 07:10:31 -0800 (PST)
Subject: Re: [PATCH v2 04/14] commit-graph: implement construct_commit_graph()
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, git@jeffhostetler.com,
        Stefan Beller <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
 <1517348383-112294-5-git-send-email-dstolee@microsoft.com>
 <20180202153212.29746-1-szeder.dev@gmail.com>
 <b7f45961-35c8-6e13-646c-9574fb5d56da@gmail.com>
 <CAM0VKj=wmkBNH=psCRztXFrC13RiG1EaSw89Q6LJaNsdJDEFHg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <31192658-5fe6-fcc6-7b9c-8e6b298e2474@gmail.com>
Date:   Wed, 7 Feb 2018 10:10:29 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAM0VKj=wmkBNH=psCRztXFrC13RiG1EaSw89Q6LJaNsdJDEFHg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/7/2018 10:08 AM, SZEDER Gábor wrote:
> On Mon, Feb 5, 2018 at 5:06 PM, Derrick Stolee <stolee@gmail.com> wrote:
>> On 2/2/2018 10:32 AM, SZEDER Gábor wrote:
>>> In my git repo, with 9 pack files at the moment, i.e. not that big a
>>> repo and not that many pack files:
>>>
>>>     $ time ./git commit-graph --write --update-head
>>>     4df41a3d1cc408b7ad34bea87b51ec4ccbf4b803
>>>
>>>     real    0m27.550s
>>>     user    0m27.113s
>>>     sys     0m0.376s
>>>
>>> In comparison, performing a good old revision walk to gather all the
>>> info that is written into the graph file:
>>>
>>>     $ time git log --all --topo-order --format='%H %T %P %cd' |wc -l
>>>     52954
>>>
>>>     real    0m0.903s
>>>     user    0m0.972s
>>>     sys     0m0.058s
>>
>> Two reasons this is in here:
>>
>> (1) It's easier to get the write implemented this way and add the reachable
>> closure later (which I do).
>>
>> (2) For GVFS, we want to add all commits that arrived in a "prefetch pack"
>> to the graph even if we do not have a ref that points to the commit yet. We
>> expect many commits to become reachable soon and having them in the graph
>> saves a lot of time in merge-base calculations.
>>
>> So, (1) is for patch simplicity, and (2) is why I want it to be an option in
>> the final version. See the --stdin-packs argument later for a way to do this
>> incrementally.
>>
>> I expect almost all users to use the reachable closure method with
>> --stdin-commits (and that's how I will integrate automatic updates with
>> 'fetch', 'repack', and 'gc' in a later patch).
> I see.  I was about to ask about the expected use-cases of the
> '--stdin-packs' option, considering how much slower it is to enumerate
> all objects in pack files, but run out of time after patch 10.
>
> The run-time using '--stdin-commits' is indeed great:
>
>    $ time { git for-each-ref --format='%(objectname)' refs/heads/ | ./git
>      commit-graph --write --update-head --stdin-commits ; }
>    82fe9a5cd715ff578f01f7f44e0611d7902d20c8
>
>    real  0m0.985s
>    user  0m0.916s
>    sys   0m0.024s
>
> Considering the run-time difference, I think in the end it would be a
> better default for a plain 'git commit-graph --write' to traverse
> history from all refs, and it should enumerate pack files only if
> explicitly told so via '--stdin-packs'.
>
> To be clear: I'm not saying that traversing history should already be
> the default when introducing construct_commit_graph() and '--write'.  If
> enumerating pack files keeps the earlier patches simpler and easier to
> review, then by all means stick with it, and only change the
> '--stdin-*'-less behavior near the end of the series, when all the
> building blocks are already in place (but then mention this in the early
> commit messages).

I will consider this.

> I have also noticed a segfault when feeding non-commit object names to
> '--stdin-commits', i.e. when I run the above command without restricting
> 'git for-each-ref' to branches and it listed object names of tags as
> well.
>
>    $ git rev-parse v2.16.1 |./git commit-graph --write --update-head
> --stdin-commits
>    error: Object eb5fcb24f69e13335cf6a6a1b1d4553fa2b0f202 not a commit
>    error: Object eb5fcb24f69e13335cf6a6a1b1d4553fa2b0f202 not a commit
>    error: Object eb5fcb24f69e13335cf6a6a1b1d4553fa2b0f202 not a commit
>    Segmentation fault
>
> (gdb) bt
> #0  __memcpy_avx_unaligned ()
>      at ../sysdeps/x86_64/multiarch/memcpy-avx-unaligned.S:126
> #1  0x00000000004ea97c in sha1write (f=0x356bbf0, buf=0x4, count=20)
>      at csum-file.c:104
> #2  0x00000000004d98e1 in write_graph_chunk_data (f=0x356bbf0, hash_len=20,
>      commits=0x3508de0, nr_commits=50615) at commit-graph.c:506
> #3  0x00000000004da9ca in construct_commit_graph (
>      pack_dir=0x8ff360 ".git/objects/pack", pack_indexes=0x0, nr_packs=0,
>      commit_hex=0x8ff790, nr_commits=1) at commit-graph.c:818
> #4  0x000000000044184e in graph_write () at builtin/commit-graph.c:149
> #5  0x0000000000441a8c in cmd_commit_graph (argc=0, argv=0x7fffffffe310,
>      prefix=0x0) at builtin/commit-graph.c:224
> #6  0x0000000000405a0a in run_builtin (p=0x8ad950 <commands+528>, argc=4,
>      argv=0x7fffffffe310) at git.c:346
> #7  0x0000000000405ce4 in handle_builtin (argc=4, argv=0x7fffffffe310)
>      at git.c:555
> #8  0x0000000000405ec8 in run_argv (argcp=0x7fffffffe1cc, argv=0x7fffffffe1c0)
>      at git.c:607
> #9  0x0000000000406079 in cmd_main (argc=4, argv=0x7fffffffe310) at git.c:684
> #10 0x00000000004a85c8 in main (argc=5, argv=0x7fffffffe308)
>      at common-main.c:43

I noticed this while preparing v3. I have a fix, but you now remind me 
that I need to add tags to the test script.

Thanks,
-Stolee
