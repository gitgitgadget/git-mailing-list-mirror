Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47523C433DB
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 10:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D9086500F
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 10:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbhCPKzb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 06:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbhCPKz0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 06:55:26 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B91C06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 03:55:25 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id z5so16772278plg.3
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 03:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fmR/NvuPtYu1d0XPuqx8WVkCHn2A+F34AxpPqgMgNlc=;
        b=ohLo4+gjSDZDj3V2HxGovFzEd7sbVWr+2zL3gZ23eDMju4bcw4raGOKvGzoNREnWm/
         9MD91bPCNsrAmRR0xb91BhBi4vehVkYEJeiJCGUc33S+w81W1tw0XA9K/t+bDjenae+C
         koiW8q9Zo4RaKDACTjUB7Pt1mypwchiVOZyZLKt6b+U0IJGH/n9glkkaDftcpGqwSniL
         M1tYjhZvxEnIEhcsssl9ZdoGOcCzxDnvuwtn4EXVHYsdQVRSp+APfWCm+UNC4CMl3V+5
         /t2/+mh2a1GIs6FSUaLdRtQkvoSkOExd3AIpTHQ7knEkX6dGBsueqCJuJOPKW9h/3MJv
         Az9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fmR/NvuPtYu1d0XPuqx8WVkCHn2A+F34AxpPqgMgNlc=;
        b=ZgkKQge8SRNmAsuOVJVdxi0BXr0KvlWXG0Fjqn5Zb3m9UQmb6wb9oX0mDglWDBzfX9
         lZ+qQ/3w8Q0x38bpzIEIGPikHrBa3XQjfnawnF4qwlK3ZPCMzTDAgItfGfBa/8Mp19Cx
         px3e8Uru9A1pf3be8BN4wJUPRTkxbqLpBdTpeddiKuyX8DHLFrO44oJtLb+LMMzR6ZxW
         uNEhrynRfgopQXdh0BaQ8sEo6al3qDRRUzi1jv/hPbi58oz1M8u8OrOznQ4fuKN3fTdS
         2C0XlfEaPmPKLkypy6CxJIaakpcw/GyPcac0bzZ6ne/jLxXSSOnedq30ofouz37Qw+TN
         PneA==
X-Gm-Message-State: AOAM532mHM2TjQZEf0JdaWviwyvyK+crVio0ZxC1BPxHUONlpQZrC/7Q
        opSJm9eOUtSh9AAKRc44Q79mu/YbodrzSA==
X-Google-Smtp-Source: ABdhPJwvEF+zR2y0F1xxYiPjC1e8y6JViCDGtl3+tirDuAH3EuMi5dfBefpEmkXAl2YxXh5DXxxpFw==
X-Received: by 2002:a17:903:102:b029:e5:fc29:de83 with SMTP id y2-20020a1709030102b02900e5fc29de83mr16065490plc.31.1615892124432;
        Tue, 16 Mar 2021 03:55:24 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-30.three.co.id. [180.214.232.30])
        by smtp.gmail.com with ESMTPSA id n5sm16057543pfq.44.2021.03.16.03.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 03:55:23 -0700 (PDT)
Subject: Re: [PATCH] fsmonitor: avoid global-buffer-overflow READ when
 checking trivial response
To:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>, git@vger.kernel.org
References: <pull.904.git.1615826363431.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <27cc2d6b-834f-e34b-0949-561b575544da@gmail.com>
Date:   Tue, 16 Mar 2021 17:55:19 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <pull.904.git.1615826363431.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Applied the patch and worked as expected (no overflow  and passed the specified test).

Don't forget to add Tested-by trailer:

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

On 15/03/21 23.39, Andrzej Hunt via GitGitGadget wrote:
> From: Andrzej Hunt <ajrhunt@google.com>
> 
> query_result can be be an empty strbuf (STRBUF_INIT) - in that case
> trying to read 3 bytes triggers a buffer overflow read (as
> query_result.buf = '\0').
> 
> Therefore we need to check query_result's length before trying to read 3
> bytes.
> 
> This overflow was introduced in:
>    940b94f35c (fsmonitor: log invocation of FSMonitor hook to trace2, 2021-02-03)
> It was found when running the test-suite against ASAN, and can be most
> easily reproduced with the following command:
> 
> make GIT_TEST_OPTS="-v" DEFAULT_TEST_TARGET="t7519-status-fsmonitor.sh" \
> SANITIZE=address DEVELOPER=1 test
> 
> ==2235==ERROR: AddressSanitizer: global-buffer-overflow on address 0x0000019e6e5e at pc 0x00000043745c bp 0x7fffd382c520 sp 0x7fffd382bcc8
> READ of size 3 at 0x0000019e6e5e thread T0
>      #0 0x43745b in MemcmpInterceptorCommon(void*, int (*)(void const*, void const*, unsigned long), void const*, void const*, unsigned long) /home/abuild/rpmbuild/BUILD/llvm-11.0.0.src/build/../projects/compiler-rt/lib/asan/../sanitizer_common/sanitizer_common_interceptors.inc:842:7
>      #1 0x43786d in bcmp /home/abuild/rpmbuild/BUILD/llvm-11.0.0.src/build/../projects/compiler-rt/lib/asan/../sanitizer_common/sanitizer_common_interceptors.inc:887:10
>      #2 0x80b146 in fsmonitor_is_trivial_response /home/ahunt/oss-fuzz/git/fsmonitor.c:192:10
>      #3 0x80b146 in query_fsmonitor /home/ahunt/oss-fuzz/git/fsmonitor.c:175:7
>      #4 0x80a749 in refresh_fsmonitor /home/ahunt/oss-fuzz/git/fsmonitor.c:267:21
>      #5 0x80bad1 in tweak_fsmonitor /home/ahunt/oss-fuzz/git/fsmonitor.c:429:4
>      #6 0x90f040 in read_index_from /home/ahunt/oss-fuzz/git/read-cache.c:2321:3
>      #7 0x8e5d08 in repo_read_index_preload /home/ahunt/oss-fuzz/git/preload-index.c:164:15
>      #8 0x52dd45 in prepare_index /home/ahunt/oss-fuzz/git/builtin/commit.c:363:6
>      #9 0x52a188 in cmd_commit /home/ahunt/oss-fuzz/git/builtin/commit.c:1588:15
>      #10 0x4ce77e in run_builtin /home/ahunt/oss-fuzz/git/git.c:453:11
>      #11 0x4ccb18 in handle_builtin /home/ahunt/oss-fuzz/git/git.c:704:3
>      #12 0x4cb01c in run_argv /home/ahunt/oss-fuzz/git/git.c:771:4
>      #13 0x4cb01c in cmd_main /home/ahunt/oss-fuzz/git/git.c:902:19
>      #14 0x6aca8d in main /home/ahunt/oss-fuzz/git/common-main.c:52:11
>      #15 0x7fb027bf5349 in __libc_start_main (/lib64/libc.so.6+0x24349)
>      #16 0x4206b9 in _start /home/abuild/rpmbuild/BUILD/glibc-2.26/csu/../sysdeps/x86_64/start.S:120
> 
> 0x0000019e6e5e is located 2 bytes to the left of global variable 'strbuf_slopbuf' defined in 'strbuf.c:51:6' (0x19e6e60) of size 1
>    'strbuf_slopbuf' is ascii string ''
> 0x0000019e6e5e is located 126 bytes to the right of global variable 'signals' defined in 'sigchain.c:11:31' (0x19e6be0) of size 512
> SUMMARY: AddressSanitizer: global-buffer-overflow /home/abuild/rpmbuild/BUILD/llvm-11.0.0.src/build/../projects/compiler-rt/lib/asan/../sanitizer_common/sanitizer_common_interceptors.inc:842:7 in MemcmpInterceptorCommon(void*, int (*)(void const*, void const*, unsigned long), void const*, void const*, unsigned long)
> Shadow bytes around the buggy address:
>    0x000080334d70: f9 f9 f9 f9 00 f9 f9 f9 f9 f9 f9 f9 00 00 00 00
>    0x000080334d80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>    0x000080334d90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>    0x000080334da0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>    0x000080334db0: 00 00 00 00 00 00 00 00 00 00 00 00 f9 f9 f9 f9
> =>0x000080334dc0: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9[f9]01 f9 f9 f9
>    0x000080334dd0: f9 f9 f9 f9 03 f9 f9 f9 f9 f9 f9 f9 02 f9 f9 f9
>    0x000080334de0: f9 f9 f9 f9 00 f9 f9 f9 f9 f9 f9 f9 04 f9 f9 f9
>    0x000080334df0: f9 f9 f9 f9 01 f9 f9 f9 f9 f9 f9 f9 00 00 00 00
>    0x000080334e00: f9 f9 f9 f9 00 00 00 00 f9 f9 f9 f9 01 f9 f9 f9
>    0x000080334e10: f9 f9 f9 f9 04 f9 f9 f9 f9 f9 f9 f9 00 f9 f9 f9
> Shadow byte legend (one shadow byte represents 8 application bytes):
>    Addressable:           00
>    Partially addressable: 01 02 03 04 05 06 07
>    Heap left redzone:       fa
>    Freed heap region:       fd
>    Stack left redzone:      f1
>    Stack mid redzone:       f2
>    Stack right redzone:     f3
>    Stack after return:      f5
>    Stack use after scope:   f8
>    Global redzone:          f9
>    Global init order:       f6
>    Poisoned by user:        f7
>    Container overflow:      fc
>    Array cookie:            ac
>    Intra object redzone:    bb
>    ASan internal:           fe
>    Left alloca redzone:     ca
>    Right alloca redzone:    cb
>    Shadow gap:              cc
> 
> Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
> ---
>      fsmonitor: fix overflow read
>      
>      This patch fixes a buffer overflow read in
>      fsmonitor_is_trivial_response().
>      
>      I'm not super familiar with fsmonitor, so I'm not 100% sure what the
>      empty response actually means. Based on my reading of the docs below,
>      this can happen with fsmonitor-watchman v1 when no files have changed.
>      But it could also happen for v2 if the implementation is broken (in
>      which case we also shouldn't overflow)? Either way, I'm guessing the
>      empty response doesn't count as trivial:
>      https://git-scm.com/docs/githooks#_fsmonitor_watchman
>      
>      The other question I had is: can watchman V1 return "/\0" as the trivial
>      response (as it has no token header) - and should we be recognising that
>      too?
>      
>      ATB,
>      
>      Andrzej
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-904%2Fahunt%2Fasan-fsmonitor-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-904/ahunt/asan-fsmonitor-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/904
> 
>   fsmonitor.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fsmonitor.c b/fsmonitor.c
> index 23f8a0c97ebb..ab9bfc60b34e 100644
> --- a/fsmonitor.c
> +++ b/fsmonitor.c
> @@ -185,10 +185,10 @@ static int query_fsmonitor(int version, const char *last_update, struct strbuf *
>   int fsmonitor_is_trivial_response(const struct strbuf *query_result)
>   {
>   	static char trivial_response[3] = { '\0', '/', '\0' };
> -	int is_trivial = !memcmp(trivial_response,
> -				 &query_result->buf[query_result->len - 3], 3);
>   
> -	return is_trivial;
> +	return query_result->len >= 3 &&
> +		!memcmp(trivial_response,
> +			&query_result->buf[query_result->len - 3], 3);
>   }
>   
>   static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
> 
> base-commit: 13d7ab6b5d7929825b626f050b62a11241ea4945
> 

-- 
An old man doll... just what I always wanted! - Clara
