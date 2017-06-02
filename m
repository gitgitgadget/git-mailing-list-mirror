Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AD7120D0A
	for <e@80x24.org>; Fri,  2 Jun 2017 00:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751122AbdFBAkY (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 20:40:24 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36027 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750851AbdFBAkX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 20:40:23 -0400
Received: by mail-qk0-f195.google.com with SMTP id y201so3461700qka.3
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 17:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ymH9HfFCe+TrTgZKjpYSqyxnm2JT9TcMk3eC4xwHn0Y=;
        b=N5lrYHejeC8GgzCOQWK3AppS5UQKvMgJ0zv2RD4HbZHtiO4Xkq0NcaNzWjmClI7oqV
         LsHbvshYPWWVH7whayJCmBwbNmTnfRcJVJIogI2IPBljiMxrUmrC+NRaooWNjjF8mxnZ
         K/gtr/10m1wqLpOrHaFI1SUHcFbovGyXVcU/hIzKTwaUHhaGTKtzaapAtnXHdYMFk6oX
         xCsTgE3aiRjrGm/fgGyZcFXn0N77Psp2XQHjhOKv5vnyL9RY+dpf5yQrTxPLKiht/6LU
         5w+i9T8LD6xR1778iUuqPc3VWHCJvA3619/OOeZxl/uzD6h+xsJIbCYRCObj+w8cu1ax
         ZQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ymH9HfFCe+TrTgZKjpYSqyxnm2JT9TcMk3eC4xwHn0Y=;
        b=nLpJ8D1PJkRdcgLxfy9T+AcCPz8xfOJb7gKutRCVEVmRCUG9MYULJ+W9ma648R/MBp
         R3JvVIzcWK49Z5RYzFkmSPovYxzJ8WfCZPEcFBZ9XHaiAcmjRNrILe3L2T0ukb8uKLCM
         iU8s6EGm/tB3oyEW5uYD18N9XnCg2bfPUqkc0zOA4mXhXi7vu0ozfeSO3Q+Y4D2uunCT
         DTBOnMZQ8ir2m8bn2dyGTtQ845b8B5ioUtD3XSUODLKQh9J+uWlNg6zqAKXnsCFkj5jC
         +k436cNYOBaztd59xJc9JAxldk1vgU3utoA8b++JtPQ1sAwpDtqeW6hDoMkRvTFShjUe
         9O5w==
X-Gm-Message-State: AKS2vOx+tAuDul+ADrOH9AJVJtUwLJkO/4Oy1BXJeoETi13GaQOvy1Bo
        8X09ZVz9wviMmw==
X-Received: by 10.55.90.196 with SMTP id o187mr5159219qkb.113.1496364022390;
        Thu, 01 Jun 2017 17:40:22 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id q26sm9094370qki.5.2017.06.01.17.40.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Jun 2017 17:40:21 -0700 (PDT)
Subject: Re: [PATCH v4 0/6] Fast git status via a file system watcher
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David Turner <David.Turner@twosigma.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
References: <20170601155105.28356-1-benpeart@microsoft.com>
 <CACBZZX5e58bWuf3NdDYTxu2KyZj29hHONzN=rp-7vXd8nURyWQ@mail.gmail.com>
 <CACBZZX4eZ3G8LQ8O+_BkbkJ-ZXTOkUi9cW=QKYjfHKtmA3pgrA@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <4c3fed40-774b-8ae6-fa1b-50efe6ef552f@gmail.com>
Date:   Thu, 1 Jun 2017 20:40:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CACBZZX4eZ3G8LQ8O+_BkbkJ-ZXTOkUi9cW=QKYjfHKtmA3pgrA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Any chance you can provide me with a bash script that contains the exact 
sequence of commands you are running to get this result?  I've been 
trying to replicate it using your notes but have not been able to.  I'd 
like to see if it is a repo difference, a platform difference, a command 
sequence difference (or something else entirely :)).

Thanks,

Ben

On 6/1/2017 5:13 PM, Ævar Arnfjörð Bjarmason wrote:
> On Thu, Jun 1, 2017 at 10:51 PM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>> On Thu, Jun 1, 2017 at 5:50 PM, Ben Peart <peartben@gmail.com> wrote:
>>> Changes from V3 include:
>>>   - update test script based on feedback
>>>   - update template hook proc with better post-processing code and make
>>>     it executable
>>
>> I have watchman running finally, so aside from issues applying this I
>> can finally test this. I set up a watch of linux.git:
>>
>> $ watchman watch $PWD
>> $ watchman watch-list|jq '.roots[]'
>> "/home/avar/g/linux"
>>
>> And first, for simplicity, I'll be turning core.fsmonitore on later:
>>
>> $ for c in fsmonitor untrackedCache splitIndex; do git config core.$c
>> false; done
>>
>> On a hot fs cache running "git status" takes me 80ms, but if I flush caches:
>>
>> # free && sync && echo 3 > /proc/sys/vm/drop_caches && free
>>
>> Running "git status" takes me 4s. Now, right after flushing those caches:
>>
>> $ date +%s
>> 1496349235
>> $ time (echo '["query", "/home/avar/g/linux", {"since": 1496349235,
>> "fields":["name"]}]' | watchman -j) | jq '.files[]'
>>
>> real    0m0.664s
>> user    0m0.000s
>> sys     0m0.004s
>> $ touch foo bar
>> $ time (echo '["query", "/home/avar/g/linux", {"since": 1496349235,
>> "fields":["name"]}]' | watchman -j) | jq '.files[]'
>> "bar"
>> "foo"
>>
>> real    0m0.044s
>> user    0m0.000s
>> sys     0m0.000s
>>
>> Without the monitor running "git status' takes me ~2.5s, i.e. from cold cache:
>>
>> $ time GIT_TRACE=1 ~/g/git/git-status
>> 20:34:49.154731 git.c:369               trace: built-in: git 'status'
>> On branch master
>> Your branch is up-to-date with 'origin/master'.
>>
>> Untracked files:
>>    (use "git add <file>..." to include in what will be committed)
>>
>>          bar
>>          foo
>>
>> nothing added to commit but untracked files present (use "git add" to track)
>>
>> real    0m2.546s
>> user    0m0.060s
>> sys     0m0.228s
>>
>> Now, I would expect the case where the working tree isn't in the fs
>> cache to be lightning fast, since the watchman command is really fast
>> (flushed the cache again, turned on the fsmonitor):
>>
>> $ date +%s
>> 1496349523
>> $ time (echo '["query", "/home/avar/g/linux", {"since": 1496349523,
>> "fields":["name"]}]' | watchman -j) | jq '.files[]'
>>
>> real    0m0.529s
>> user    0m0.000s
>> sys     0m0.004s
>> $ touch foo bar
>> $ time (echo '["query", "/home/avar/g/linux", {"since": 1496349523,
>> "fields":["name"]}]' | watchman -j) | jq '.files[]'
>> "bar"
>> "foo"
>>
>> real    0m0.312s
>> user    0m0.000s
>> sys     0m0.000s
>>
>> But if I run "git status" (and I instrumented the hook to dump the
>> changed files) it takes a long time (those 10s are just the disk being
>> slow, but it should be ~0s, right?):
>>
>> $ time GIT_TRACE=1 ~/g/git/git-status
>> 20:39:11.250128 git.c:369               trace: built-in: git 'status'
>> 20:39:14.586720 run-command.c:626       trace: run_command:
>> '.git/hooks/query-fsmonitor' '1' '1496349494197821000'
>> Watchman says these changed: bar foo hi there .git .git/index.lock .git/index
>> On branch master
>> Your branch is up-to-date with 'origin/master'.
>>
>> Untracked files:
>>    (use "git add <file>..." to include in what will be committed)
>>
>>          bar
>>          foo
>>
>> nothing added to commit but untracked files present (use "git add" to track)
>>
>> real    0m10.791s
>> user    0m0.108s
>> sys     0m0.228s
>>
>> If I re-run that it takes ~160-200ms with the hook, 80-120ms without
>> it, so in this case once the data is in the fscache watchman is
>> actually slower.
>>
>> But manually running watchman shows that it's really fast, usually
>> returning within 3ms, I flush the fscache in the middle of this,
>> that's the 600ms time, that could be some global kernel lock or
>> something due to the odd manual proc operation, I haven't actually
>> tested this on a system under memory pressure:
>>
>> $ for i in {1..10}; do (time (printf '["query", "/home/avar/g/linux",
>> {"since": %s, "fields":["name"]}]' $(($(date +%s)-3)) | watchman -j |
>> jq '.files[]')) 2>&1 | grep -e '"' -e ^real && touch $i && sleep 1;
>> done
>> real    0m0.004s
>> "1"
>> real    0m0.003s
>> "2"
>> "1"
>> real    0m0.605s
>> "3"
>> real    0m0.003s
>> "4"
>> "3"
>> real    0m0.003s
>> "5"
>> "4"
>> real    0m0.003s
>> "6"
>> "5"
>> real    0m0.003s
>> "7"
>> "6"
>> real    0m0.003s
>> "8"
>> "7"
>> real    0m0.003s
>> "9"
>> "8"
>> real    0m0.003s
>>
>> So something really odd is going on here. This should be speeding up
>> "git status" a lot, even with a hot fs cache doing stat on all of
>> linux.git takes a lot longer than 3ms, but for some reason it's
>> slower.
> 
> Dug a bit further, with cold cache and no fsmonitor, gprof output from
> -O0 compiled git:
> 
> Each sample counts as 0.01 seconds.
>    %   cumulative   self              self     total
>   time   seconds   seconds    calls  ms/call  ms/call  name
>   37.50      0.03     0.03   123886     0.00     0.00  memihash
>   12.50      0.04     0.01   284727     0.00     0.00  match_basename
>   12.50      0.05     0.01    73989     0.00     0.00  match_pathname
>   12.50      0.06     0.01    59924     0.00     0.00  hashmap_add
>   12.50      0.07     0.01    59847     0.00     0.00  same_name
>   12.50      0.08     0.01    59844     0.00     0.00  hash_index_entry
>    0.00      0.08     0.00   598446     0.00     0.00  git_bswap32
>    0.00      0.08     0.00   259150     0.00     0.00  fspathncmp
>    0.00      0.08     0.00   178731     0.00     0.00  match_pathspec
>    0.00      0.08     0.00   178655     0.00     0.00  do_match_pathspec
> And then cold cache with fsmonitor:
> 
> Each sample counts as 0.01 seconds.
>    %   cumulative   self              self     total
>   time   seconds   seconds    calls  ms/call  ms/call  name
>   66.67      0.04     0.04    96696     0.00     0.00  blk_SHA1_Block
>   16.67      0.05     0.01    59844     0.00     0.00  cache_entry_from_ondisk
>   16.67      0.06     0.01    58869     0.00     0.00  longest_path_match
>    0.00      0.06     0.00  1547157     0.00     0.00  git_bswap32
>    0.00      0.06     0.00  1196893     0.00     0.00  git_bswap32
>    0.00      0.06     0.00   284727     0.00     0.00  match_basename
>    0.00      0.06     0.00   259150     0.00     0.00  fspathncmp
>    0.00      0.06     0.00   178561     0.00     0.00  do_match_pathspec
>    0.00      0.06     0.00   178543     0.00     0.00  match_pathspec
>    0.00      0.06     0.00   145141     0.00     0.00  memory_limit_check
> 
