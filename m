Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89039C433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 14:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbiBXOao (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 09:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbiBXOam (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 09:30:42 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731A217C419
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 06:30:12 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id v21so3350280wrv.5
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 06:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=454O6/Zb0UkOFz2+1HqDTvDfe0+RnK8wSiNvQZwGppI=;
        b=jPpt2byS4hi9pizM8iT69rpfYZ9SO1+LkQp1+M71OiEo+pqDY1dL7UnAA0MhlGiuMT
         unVtGDMuE/JuDs2cs7tl9N5zLEtsEhwA2LdyEDMiwXxz/oo9HIaGk3e6Lz90QS9h9Fax
         6GYzLP5jj9bMIchODI4IEhP91UmakAT5geZDcLDYL88TJwtsj/576isw/9ryDxMF2qxo
         lVRhxfJrSyNSeG3SPbGohLsjLTSvMCsQnjCUNAfKyB0KTJPpjnTtDKQ19QsA+JjMJIDr
         8fLmtokgOPAD9mZJVvJ8FXl4cpStHlK65l4IjLAlWelowhuvjWwX7zGoEfeN8nalOlmE
         Ulcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=454O6/Zb0UkOFz2+1HqDTvDfe0+RnK8wSiNvQZwGppI=;
        b=6cxWFBTGwoOVcYJCk2b4YwbHOVZGBthm+3rFc977BBRnM5tEFu+R0iZ02dLxARvtpb
         8e8t5wJnc7tB5Rc5vFzYjcbGruG9fX7mxoHEhCRpyDlkEUp2qiJpKaY/wmoABv62JCMn
         5ScbUGQ474hINiYZJHz82Aht4QXus1/a0ns/envpYbIYaNacfn1H132KH5Lbo1bAk5TC
         eqBcM229Gk8xv9At06QL7JxEYALiXe5tap+63w/2mF4BwZMsJyXHcI/kwFwgClGkr3zk
         dotTWMtkOBlsIG6R4fH4N3aq8MJQ0Hgt/dRz1K+UOfUCIU58/GPRnf2V2TSKJgvI6Y6I
         /MYg==
X-Gm-Message-State: AOAM532jPyQkE3fgOZSkwVqdsnXjv0DgBoGFICHZSpu3NVdUBEvdSidH
        PPlt4Wl05JwNWFBYf/vwwDo=
X-Google-Smtp-Source: ABdhPJwVllhavy5F8hfK72wa7FcVSmDhdCxk+/YLDD4znsPAExvB65gPp0lvTidc92XfxKTHUzMlZA==
X-Received: by 2002:a05:6000:3ce:b0:1e4:b2ba:e3e3 with SMTP id b14-20020a05600003ce00b001e4b2bae3e3mr2464216wrg.204.1645713010914;
        Thu, 24 Feb 2022 06:30:10 -0800 (PST)
Received: from [192.168.1.240] ([31.185.185.186])
        by smtp.gmail.com with ESMTPSA id t4sm2726911wmj.10.2022.02.24.06.30.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 06:30:10 -0800 (PST)
Message-ID: <8d44b509-ff19-0629-30f5-ae785c73c3aa@gmail.com>
Date:   Thu, 24 Feb 2022 14:30:08 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/4] a couple of read_key_without_echo() fixes
Content-Language: en-GB-large
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1146.git.1645008873.gitgitgadget@gmail.com>
 <pull.1146.v2.git.1645556015.gitgitgadget@gmail.com>
 <xmqqv8x5s1w3.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqv8x5s1w3.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 23/02/2022 21:34, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> I have added a new patch to the beginning of the series that fixes a case
>> where we did not call restore_term() when leaving read_key_without_echo(). I
>> have also reworded the commit message to patch 2 as SIGINT is actually
>> ignored while the editor is running (we should probably change that code to
>> use wait_after_clean instead).
> 
> All patches looked good.  Thanks.
> 
> Let's mark it for 'next' and below soonish.

That sounds good. I've got a couple more patches based on top of these 
which hopefully fix the remaining problems (notably the macos poll() 
bug). I'll polish and post them next week. Once those are in I hope 
we'll be able to enable the builtin "add -p" by default.

Thanks

Phillip

>>
>> Cover letter for V1:
>>
>> Fix a couple of bugs I noticed when using the builtin "add -p" with
>> interactive.singlekey=true. The first patch is a general fix for the
>> terminal save/restore functionality which forgot to call sigchain_pop() when
>> it restored the terminal. The last two fix reading single keys in
>> non-canonical mode by making sure we wait for an initial key press and only
>> read one byte at a time from the underlying file descriptor.
>>
>> Note that these are untested on windows beyond our CI compiling them
>>
>> Phillip Wood (4):
>>    terminal: always reset terminal when reading without echo
>>    terminal: pop signal handler when terminal is restored
>>    terminal: set VMIN and VTIME in non-canonical mode
>>    add -p: disable stdin buffering when interactive.singlekey is set
>>
>>   add-interactive.c |  2 ++
>>   compat/terminal.c | 29 +++++++++++++++++++++++------
>>   compat/terminal.h |  8 ++++++++
>>   3 files changed, 33 insertions(+), 6 deletions(-)
>>
>>
>> base-commit: b80121027d1247a0754b3cc46897fee75c050b44
>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1146%2Fphillipwood%2Fwip%2Fadd-p-vmin-v2-v2
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1146/phillipwood/wip/add-p-vmin-v2-v2
>> Pull-Request: https://github.com/gitgitgadget/git/pull/1146
>>
>> Range-diff vs v1:
>>
>>   -:  ----------- > 1:  45609d61afc terminal: always reset terminal when reading without echo
>>   1:  9a3c2cea0f9 ! 2:  0020953f1cf terminal: pop signal handler when terminal is restored
>>       @@ Commit message
>>            external caller was removed by e3f7e01b50 ("Revert "editor: save and
>>            reset terminal after calling EDITOR"", 2021-11-22). Any future callers
>>            of save_term() should benefit from having the signal handler set up
>>       -    for them. For example if we reinstate the code to protect against an
>>       -    editor failing to restore the terminal attributes we would want that
>>       -    code to restore the terminal attributes on SIGINT. (As an aside
>>       -    run_command() installs a signal handler that waits for the child
>>       -    before re-raising the signal so we would be guaranteed to restore the
>>       -    settings after the child has exited.)
>>       +    for them.
>>        
>>            Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>>        
>>   2:  02009172e08 = 3:  7ae9b236554 terminal: set VMIN and VTIME in non-canonical mode
>>   3:  6d8423b6e1e = 4:  39b061a471b add -p: disable stdin buffering when interactive.singlekey is set
