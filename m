Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF3DC433FE
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 13:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10A11619F6
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 13:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbhJBNOH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Oct 2021 09:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbhJBNOG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Oct 2021 09:14:06 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A44C0613EC
        for <git@vger.kernel.org>; Sat,  2 Oct 2021 06:12:20 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v25so9492461wra.2
        for <git@vger.kernel.org>; Sat, 02 Oct 2021 06:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WgvVEX4fa4K4/4G8f7Iv3fSmQcSrF51uiovYPDoxWDA=;
        b=KJEZ5OWOFcui8tysk0kFna+D9Xu/GgmeGD2NKvKJ82ykGVCFNs985++PFIc+fIq+Vu
         86T2qOYTrCYX2+bJONTIsvqUJ2Eg7EQWKu0CDLxW5mHblQbc6Q58lXQbW64xJ1NVMYpe
         1kXyIP480kUmEtwvmEAVgYT2tXUW0uF1Chw9gFCGPB+SmvSl5Liy0o8IUAuaB16PumQ7
         mpwWBHYxPrK9m4dD5d64aD55molAEI7rkHPBo2CefmBH/wpEPXgcFT/UOdBRI8BxCAfq
         sqzPcC4cXHiolgproJOlniQkCO+xugD0x+X7SUb1q+rcfKa/CJZQt48wykbjRj8CGtFA
         Jspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WgvVEX4fa4K4/4G8f7Iv3fSmQcSrF51uiovYPDoxWDA=;
        b=rEqj8f8oEWeZOq659wprZLThnYQT24rZ7teNroKfGduxofTRTH3tdrzyJAuRlJ8AqL
         +A5mt1mXC6UYv6LdlmoC36VkVPxYaedtcpJSY72hUI4dXFgd9XD8YYBsTAo2sAsu6+aA
         ElZxAZnyQ3TdHLXUY08P4UDFimiOuV84f5wuAtZ1IGpcj5VwrJ4nKLBf4KRb2Xq9c/gc
         MZDzmKUID0SfkDp9qrkqNEt3EQjXURIZnEPZsjL5RGwGOixYEbmwIUc3+gq9QddFNnkU
         Q4O+PBch7xKdjNjX7tHWS35mhpLLzqnn0YOmeDy6xQEAF10mMYZ04qBqLntlFAhSjoYk
         HzVQ==
X-Gm-Message-State: AOAM532aA6CUzOT7BczAMhAZj7AOW0di4UYR3XGajwVH5m6s4wrxH6LG
        BwBMEsdLWTIXOufmngNaIUA=
X-Google-Smtp-Source: ABdhPJz0zxTqW9oVE93ZeAu5S2NN/BVMnTF8DfOXKmU3k316ElKNFGC7g6ETZnQ3jQcs5fiV/NzuXA==
X-Received: by 2002:adf:bb0a:: with SMTP id r10mr3297440wrg.23.1633180339580;
        Sat, 02 Oct 2021 06:12:19 -0700 (PDT)
Received: from [192.168.1.201] (178.2.7.51.dyn.plus.net. [51.7.2.178])
        by smtp.googlemail.com with ESMTPSA id k10sm10618333wmr.32.2021.10.02.06.12.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Oct 2021 06:12:19 -0700 (PDT)
Message-ID: <9e5cdff3-a71f-640a-8964-22a7d6b12276@gmail.com>
Date:   Sat, 2 Oct 2021 14:12:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 00/11] rebase: reset_head() related fixes and improvements
Content-Language: en-US
To:     phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
 <xmqqbl482rby.fsf@gitster.g> <xmqq4ka02fc4.fsf@gitster.g>
 <ddf5e9c2-3211-cec2-cd18-2a083e279ccb@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <ddf5e9c2-3211-cec2-cd18-2a083e279ccb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/10/2021 13:27, Phillip Wood wrote:
> Hi Junio
> 
> On 02/10/2021 05:58, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> When merged with other topics in flight in 'seen', this seems to
>>> fail the t1092 test (most likely, ds/add-rm-with-sparse-index is
>>> what this interacts badly with).
> 
> Oh dear, thanks for letting me know.
> 
>> There are Two CI runs at GitHub:
>>
>>   - https://github.com/git/git/actions/runs/1297117791 (d3a1c4e)
>>   - https://github.com/git/git/actions/runs/1297232973 (a1108c2)
>>
>> The difference between the former (which passes all the tests) and
>> he latter (which fails) are only two topics:
>>
>>      $ git log --first-parent --oneline d3a1c4e..a1108c2
>>      a1108c2b1b Merge branch 'hn/reftable' into seen
>>      e575f29006 Merge branch 'pw/fix-some-issues-in-reset-head' into seen
>>
>> I think the following is the same failure I saw earlier
>>
>>     
>> https://github.com/git/git/runs/3773780195?check_suite_focus=true#step:6:5033 
>>
>>
>> that the write-tree codepath hits assertion failure by detecting a
>> corruption in the cache-tree data structure.
> 
> The test that fails (t1092-sparse-checkout-compatibility.sh:'merge, 
> cherry-pick, and rebase') was introduced by c0b99303db ("t1092: add 
> cherry-pick, rebase tests", 2021-09-08) and is in v2.33.0. It does not 
> test the "apply" backend of rebase, changing it to do so makes it fail 
> on the current master as that backend already uses reset_head() for the 
> initial checkout so it is an existing bug that is exposed by the changes 
> in this series. It seems to be a use-after-free (see below) I'll try and 
> investigate but I've got no idea what is going on at the moment - the 
> index is not my area of expertise.

removing the call to prime_cache_tree() from reset_head() fixes the 
crash. It is called after unpack_trees() and before 
write_locked_index(), I'm not sure what the implications of removing it 
are - why it was there it is needed?

Best Wishes

Phillip

> Best Wishes
> 
> Phillip
> 
> ==74345==ERROR: AddressSanitizer: heap-use-after-free on address 
> 0x606000001b20 at pc 0x557cbe82d3a2 bp 0x7ffdfee08090 sp 0x7ffdfee08080
> READ of size 4 at 0x606000001b20 thread T0
>      #0 0x557cbe82d3a1 in verify_one /home/phil/src/git/cache-tree.c:863
>      #1 0x557cbe82ca9d in verify_one /home/phil/src/git/cache-tree.c:840
>      #2 0x557cbe82ca9d in verify_one /home/phil/src/git/cache-tree.c:840
>      #3 0x557cbe82ca9d in verify_one /home/phil/src/git/cache-tree.c:840
>      #4 0x557cbe830a2b in cache_tree_verify 
> /home/phil/src/git/cache-tree.c:910
>      #5 0x557cbea53741 in write_locked_index 
> /home/phil/src/git/read-cache.c:3250
>      #6 0x557cbeab7fdd in reset_head /home/phil/src/git/reset.c:87
>      #7 0x557cbe72147f in cmd_rebase builtin/rebase.c:2074
>      #8 0x557cbe5bd151 in run_builtin /home/phil/src/git/git.c:461
>      #9 0x557cbe5bd151 in handle_builtin /home/phil/src/git/git.c:714
>      #10 0x557cbe5c0503 in run_argv /home/phil/src/git/git.c:781
>      #11 0x557cbe5c0503 in cmd_main /home/phil/src/git/git.c:912
>      #12 0x557cbe5bad28 in main /home/phil/src/git/common-main.c:52
>      #13 0x7fdd4b82eb24 in __libc_start_main (/usr/lib/libc.so.6+0x27b24)
>      #14 0x557cbe5bcb8d in _start (/home/phil/src/git/git+0x1b9b8d)
> 
> 0x606000001b20 is located 0 bytes inside of 56-byte region 
> [0x606000001b20,0x606000001b58)
> freed by thread T0 here:
>      #0 0x7fdd4bacff19 in __interceptor_free 
> /build/gcc/src/gcc/libsanitizer/asan/asan_malloc_linux.cpp:127
>      #1 0x557cbe82af60 in cache_tree_free 
> /home/phil/src/git/cache-tree.c:35
>      #2 0x557cbe82aee5 in cache_tree_free 
> /home/phil/src/git/cache-tree.c:31
>      #3 0x557cbe82aee5 in cache_tree_free 
> /home/phil/src/git/cache-tree.c:31
>      #4 0x557cbe82aee5 in cache_tree_free 
> /home/phil/src/git/cache-tree.c:31
>      #5 0x557cbeb2557a in ensure_full_index 
> /home/phil/src/git/sparse-index.c:310
>      #6 0x557cbea45c4a in index_name_stage_pos 
> /home/phil/src/git/read-cache.c:588
>      #7 0x557cbe82ce37 in verify_one /home/phil/src/git/cache-tree.c:850
>      #8 0x557cbe82ca9d in verify_one /home/phil/src/git/cache-tree.c:840
>      #9 0x557cbe82ca9d in verify_one /home/phil/src/git/cache-tree.c:840
>      #10 0x557cbe82ca9d in verify_one /home/phil/src/git/cache-tree.c:840
>      #11 0x557cbe830a2b in cache_tree_verify 
> /home/phil/src/git/cache-tree.c:910
>      #12 0x557cbea53741 in write_locked_index 
> /home/phil/src/git/read-cache.c:3250
>      #13 0x557cbeab7fdd in reset_head /home/phil/src/git/reset.c:87
>      #14 0x557cbe72147f in cmd_rebase builtin/rebase.c:2074
>      #15 0x557cbe5bd151 in run_builtin /home/phil/src/git/git.c:461
>      #16 0x557cbe5bd151 in handle_builtin /home/phil/src/git/git.c:714
>      #17 0x557cbe5c0503 in run_argv /home/phil/src/git/git.c:781
>      #18 0x557cbe5c0503 in cmd_main /home/phil/src/git/git.c:912
>      #19 0x557cbe5bad28 in main /home/phil/src/git/common-main.c:52
>      #20 0x7fdd4b82eb24 in __libc_start_main (/usr/lib/libc.so.6+0x27b24)
> 
> previously allocated by thread T0 here:
>      #0 0x7fdd4bad0459 in __interceptor_calloc 
> /build/gcc/src/gcc/libsanitizer/asan/asan_malloc_linux.cpp:154
>      #1 0x557cbebc1807 in xcalloc /home/phil/src/git/wrapper.c:140
>      #2 0x557cbe82b7d8 in cache_tree /home/phil/src/git/cache-tree.c:17
>      #3 0x557cbe82b7d8 in prime_cache_tree_rec 
> /home/phil/src/git/cache-tree.c:763
>      #4 0x557cbe82b837 in prime_cache_tree_rec 
> /home/phil/src/git/cache-tree.c:764
>      #5 0x557cbe82b837 in prime_cache_tree_rec 
> /home/phil/src/git/cache-tree.c:764
>      #6 0x557cbe8304e1 in prime_cache_tree 
> /home/phil/src/git/cache-tree.c:779
>      #7 0x557cbeab7fa7 in reset_head /home/phil/src/git/reset.c:85
>      #8 0x557cbe72147f in cmd_rebase builtin/rebase.c:2074
>      #9 0x557cbe5bd151 in run_builtin /home/phil/src/git/git.c:461
>      #10 0x557cbe5bd151 in handle_builtin /home/phil/src/git/git.c:714
>      #11 0x557cbe5c0503 in run_argv /home/phil/src/git/git.c:781
>      #12 0x557cbe5c0503 in cmd_main /home/phil/src/git/git.c:912
>      #13 0x557cbe5bad28 in main /home/phil/src/git/common-main.c:52
>      #14 0x7fdd4b82eb24 in __libc_start_main (/usr/lib/libc.so.6+0x27b24)
> 
> SUMMARY: AddressSanitizer: heap-use-after-free 
> /home/phil/src/git/cache-tree.c:863 in verify_one
> Shadow bytes around the buggy address:
>    0x0c0c7fff8310: fd fd fd fd fd fd fd fa fa fa fa fa fd fd fd fd
>    0x0c0c7fff8320: fd fd fd fa fa fa fa fa fd fd fd fd fd fd fd fa
>    0x0c0c7fff8330: fa fa fa fa 00 00 00 00 00 00 00 02 fa fa fa fa
>    0x0c0c7fff8340: fd fd fd fd fd fd fd fa fa fa fa fa 00 00 00 00
>    0x0c0c7fff8350: 00 00 00 02 fa fa fa fa fd fd fd fd fd fd fd fa
> =>0x0c0c7fff8360: fa fa fa fa[fd]fd fd fd fd fd fd fa fa fa fa fa
>    0x0c0c7fff8370: 00 00 00 00 00 00 00 02 fa fa fa fa fd fd fd fd
>    0x0c0c7fff8380: fd fd fd fa fa fa fa fa 00 00 00 00 00 00 00 02
>    0x0c0c7fff8390: fa fa fa fa fd fd fd fd fd fd fd fa fa fa fa fa
>    0x0c0c7fff83a0: fd fd fd fd fd fd fd fa fa fa fa fa fd fd fd fd
>    0x0c0c7fff83b0: fd fd fd fa fa fa fa fa 00 00 00 00 00 00 00 fa
> Shadow byte legend (one shadow byte represents 8 application bytes):
>    Addressable:           00
>    Partially addressable: 01 02 03 04 05 06 07
>    Heap left redzone:       fa
>    Freed heap region:       fd
>    Stack left redzone:      f1
>    Stack mid redzone:       f2
>    Stack right redzone:     f3
>    Stack after return:      f5
>    Stack use after scope:   f8
>    Global redzone:          f9
>    Global init order:       f6
>    Poisoned by user:        f7
>    Container overflow:      fc
>    Array cookie:            ac
>    Intra object redzone:    bb
>    ASan internal:           fe
>    Left alloca redzone:     ca
>    Right alloca redzone:    cb
>    Shadow gap:              cc
> ==74345==ABORTING
> 
> 
>> e575f29006 (i.e. without the reftable topic) fails t1092.  If you
>> revert e575f29006^2 (i.e. the "do not fork 'git checkout'") from
>> that merge, all tests pass including t1092.
>>
>> The reftable topic is queued near the tip of 'seen' not necessarily
>> because it _breaks_ CI (I do not think it does), but it needed a
>> handful of fixup commits on top.  The topic needs rerolling with the
>> fixes squashed in.
>>
>> Thanks.
>>
> 

