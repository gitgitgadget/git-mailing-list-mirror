Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83ACFEB64DA
	for <git@archiver.kernel.org>; Sat, 24 Jun 2023 15:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbjFXPUI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Jun 2023 11:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbjFXPUH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2023 11:20:07 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4C81FD7
        for <git@vger.kernel.org>; Sat, 24 Jun 2023 08:20:04 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3113306a595so1976912f8f.1
        for <git@vger.kernel.org>; Sat, 24 Jun 2023 08:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687620003; x=1690212003;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bM+PjcTkAEZly0IIaURZuhG+q5W0aHubOFKbqp7ZPqc=;
        b=GJ03O+M9wez4MfoQH1zMPCT2r4FTlD4+R6mHuLPMLg7haw7qeXwdSVVsuF5pAknLS/
         0I0RjMcIXPbJKHvAJaTLNEhj0aShSlZtkl7MzdvHGPcjD9RpwfA4fdwUT3SxMfHeYm0o
         SZbDb5sre4A8is0pAsCXGa2B4Bl5FKod8DYdvVv8T34j9Pdv132DFyIH2T1M5w1R1NZe
         0ufjPgW82loQ0UKHGjQqLGhx1rmn6wn185vds24jwynT0BQHiOfkIXB5s5KKY1YSbsPn
         54ikhp8c9pYkYvbZFUEDgcQQi66mKMIn/Y8OA8xauHC82SaAjMw3GhpC87fdB0SSUOXD
         kqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687620003; x=1690212003;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bM+PjcTkAEZly0IIaURZuhG+q5W0aHubOFKbqp7ZPqc=;
        b=bFoe4r/0ItfW91INwHl1FOkLBkabQ+Gedtl6/gufnXl1c+Ty4eyudJ71Vy1MshPmcC
         ZbUUn+yiqXWD6iXOGOKuao8PmEehhlJz1sk1dg+ketpJnSyD4bY39QwD+OALQ+UyZ6FW
         pBqxjeL/QslpyRibGGMhk9hqm8ChpJa3DUFJSM/CGN0P+EDCjuRaljASsqq87syQoiao
         GKGiyRTqgo0C+QSmL5Powaa85s1WYAb2mvcCs4wmBmz8eBiKdlSwFElQ3EUy3RZyd7MS
         MTx+vQJPDtGi2CJ/c7AkKNdeWUkmmfehSKXTp3qQN0xIKXhWhTl2K2tIikN8JeXSAec6
         Cg5Q==
X-Gm-Message-State: AC+VfDxr+CtiZGi/OosdcvxAAL9/DACH/5VM/XrPTYVoXPJ2SWIquyY9
        E1DRiM8S0OSQUhznxixn+co=
X-Google-Smtp-Source: ACHHUZ72D8je6KZ4ht1mcg6PabvHdcVscpJoHKOXyIPVXOKDc7NxqR2ElWebb1Wv8xj3aWpzBEOBsA==
X-Received: by 2002:a5d:464e:0:b0:30f:c801:aa7c with SMTP id j14-20020a5d464e000000b0030fc801aa7cmr23846501wrs.43.1687620002803;
        Sat, 24 Jun 2023 08:20:02 -0700 (PDT)
Received: from [192.168.1.212] ([90.255.142.254])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600004cf00b0030e52d4c1bcsm2358183wri.71.2023.06.24.08.20.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 08:20:02 -0700 (PDT)
Message-ID: <03ea5630-2373-2f53-7dbc-406e10ca281c@gmail.com>
Date:   Sat, 24 Jun 2023 16:19:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [EXTERNAL] Re: git apply fails with 'error: git apply: failed to
 read: No such file or directory'
Content-Language: en-US
To:     Premek Vysoky <Premek.Vysoky@microsoft.com>,
        "phillip.wood@dunelm.org.uk" <phillip.wood@dunelm.org.uk>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <AM7PR83MB04183860D4E70F935319E9B9EA23A@AM7PR83MB0418.EURPRD83.prod.outlook.com>
 <fff79e55-cf35-b5ca-6208-dfa7234be33d@gmail.com>
 <AM7PR83MB041804AFB4F0F8E850C51039EA20A@AM7PR83MB0418.EURPRD83.prod.outlook.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
In-Reply-To: <AM7PR83MB041804AFB4F0F8E850C51039EA20A@AM7PR83MB0418.EURPRD83.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Premek

On 24/06/2023 11:28, Premek Vysoky wrote:
> Hi Phillip,
> 
> Thanks for the fast response! And thanks for the improvement if you decide to make this more obvious.
> I must have used an older git version earlier as I was able to process even 3GB patches easily.
> 
> Too bad there is no override for this..

The limit was added because of concerns about integer overflows with 
larger patches (I've reproduced the commit message below). In principle 
the code could be updated to use size_t rather than int/long to 
accommodate larger patches though I haven't looked how difficult that 
would be and we'd still need to restrict the size of the diff for each 
file as the object store uses long rather than size_t which causes 
problems on LLP64 platforms like windows.

If you want to export a subset of files from a repository then 
git-filter-repo[1] might be a better bet. It uses fast-export and 
fast-import which should be more efficient than generating patches and 
applying them.

Best Wishes

Phillip

[1] https://github.com/newren/git-filter-repo

Here is the commit message from the commit that introduced the limit on 
patch sizes

apply: reject patches larger than ~1 GiB

The apply code is not prepared to handle extremely large files. It uses
"int" in some places, and "unsigned long" in others.

This combination leads to unfortunate problems when switching between
the two types. Using "int" prevents us from handling large files, since
large offsets will wrap around and spill into small negative values,
which can result in wrong behavior (like accessing the patch buffer with
a negative offset).

Converting from "unsigned long" to "int" also has truncation problems
even on LLP64 platforms where "long" is the same size as "int", since
the former is unsigned but the latter is not.

To avoid potential overflow and truncation issues in `git apply`, apply
similar treatment as in dcd1742e56 (xdiff: reject files larger than
~1GB, 2015-09-24), where the xdiff code was taught to reject large
files for similar reasons.

The maximum size was chosen somewhat arbitrarily, but picking a value
just shy of a gigabyte allows us to double it without overflowing 2^31-1
(after which point our value would wrap around to a negative number).
To give ourselves a bit of extra margin, the maximum patch size is a MiB
smaller than a full GiB, which gives us some slop in case we allocate
"(records + 1) * sizeof(int)" or similar.

Luckily, the security implications of these conversion issues are
relatively uninteresting, because a victim needs to be convinced to
apply a malicious patch.

Reported-by: 정재우 <thebound7@gmail.com>
Suggested-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>


> (we're working on a .NET monorepo - https://github.com/dotnet/dotnet - so one of a kind, and we hit these limits at times)
> 
> Cheers,
> Premek
> 
> 
> -----Original Message-----
> From: Phillip Wood <phillip.wood123@gmail.com>
> Sent: Saturday, June 24, 2023 12:09 PM
> To: Premek Vysoky <Premek.Vysoky@microsoft.com>; git@vger.kernel.org
> Subject: [EXTERNAL] Re: git apply fails with 'error: git apply: failed to read: No such file or directory'
> 
> Hi Premek
> 
> Thanks for taking the time to report this issue
> 
> On 23/06/2023 13:42, Premek Vysoky wrote:
>> What did you do before the bug happened? (Steps to reproduce your
>> issue) git clone
>> https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgith
>> ub.com%2Fdotnet%2Fllvm-project&data=05%7C01%7CPremek.Vysoky%40microsof
>> t.com%7Ca9684566250842b65be608db749b030b%7C72f988bf86f141af91ab2d7cd01
>> 1db47%7C1%7C0%7C638231981398613951%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
>> wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7
>> C&sdata=prrT8WKHGtvll2XG%2FKSrxSOplev6eLjjeBGu%2FRQzOMg%3D&reserved=0
>> git -C llvm-project diff --patch --binary --output ../llvm.patch 4b825dc642cb6eb9a060e54bf8d69288fbee4904..30e9e6bc2e9f04e0a75daf4b8088ee91f66069da -- ':(glob)**/*' ':(exclude,glob)**/*.dll' ':(exclude,glob)**/*.Dll' ':(exclude,glob)**/*.exe' ':(exclude,glob)**/*.pdb' ':(exclude,glob)**/*.mdb' ':(exclude,glob)**/*.zip' ':(exclude,glob)**/*.nupkg'
>> mkdir foo
>> git -C foo init
>> git -C foo apply --cached --ignore-space-change ../llvm.patch
>>
>> What did you expect to happen? (Expected behavior) Patch should be
>> created and applied to another folder
>>
>> What happened instead? (Actual behavior) git apply fails with 'error:
>> git apply: failed to read: No such file or directory'
>> (and returns 128)
> 
> This stems from commit f1c0e3946e (apply: reject patches larger than ~1 GiB, 2022-10-25). Unfortunately it does not provide a very helpful error message. I'll submit a patch later to fix that in the next few days.
> 
> Best Wishes
> 
> Phillip
> 
>> What's different between what you expected and what actually happened?
>> There is no error. I tried -v, --reject etc but wasn't able to get any details.
>>
>> Anything else you want to add:
>> This happens in both Windows and Linux environments.
>>
>> I tried analyzing file handlers via procmon.exe and could not see anything. git reads the whole patch and then shuts down. No indication of a file it is trying to open.
>>
>> I tried excluding more files from the patch and then I was able to create/apply the patch, like so:
>>
>> git -C llvm-project diff --patch --binary --output ../llvm.patch 4b825dc642cb6eb9a060e54bf8d69288fbee4904..30e9e6bc2e9f04e0a75daf4b8088ee91f66069da -- ':(glob)**/*' ':(exclude,glob)**/*.dll' ':(exclude,glob)**/*.Dll' ':(exclude,glob)**/*.exe' ':(exclude,glob)**/*.pdb' ':(exclude,glob)**/*.mdb' ':(exclude,glob)**/*.zip' ':(exclude,glob)**/*.nupkg' ':(exclude,glob)bolt' ':(exclude,glob)clang/docs' ':(exclude,glob)clang/www' ':(exclude,glob)flang' ':(exclude,glob)libclc' ':(exclude,glob)lldb' ':(exclude,glob)llvm/docs' ':(exclude,glob)mlir' ':(exclude,glob)openmp' ':(exclude,glob)polly' ':(exclude,glob)pstl' ':(exclude,glob)third-party' ':(exclude,glob)**/tests/**'
>>
>> But if I do the opposite and create a patch with only the previously excluded files, I'd expect that it breaks. But this works as well!
>>
>> git -C llvm-project diff --patch --binary --output ../llvm.patch 4b825dc642cb6eb9a060e54bf8d69288fbee4904..30e9e6bc2e9f04e0a75daf4b8088ee91f66069da -- ':(glob)bolt' ':(glob)clang/docs' ':(glob)clang/www' ':(glob)flang' ':(glob)libclc' ':(glob)lldb' ':(glob)llvm/docs' ':(glob)mlir' ':(glob)openmp' ':(glob)polly' ':(glob)pstl' ':(glob)third-party' ':(glob)**/tests/**' ':(exclude,glob)**/*.dll' ':(exclude,glob)**/*.Dll' ':(exclude,glob)**/*.exe' ':(exclude,glob)**/*.pdb' ':(exclude,glob)**/*.mdb' ':(exclude,glob)**/*.zip' ':(exclude,glob)**/*.nupkg'
>>
>> Only when they are together, git fails. Size of the patch is 1GB but I've had 3GB patches apply successfully before.
>>
>> Please review the rest of the bug report below.
>> You can delete any lines you don't wish to share.
>>
>>
>> [System Info]
>> git version:
>> git version 2.41.0.windows.1
>> cpu: x86_64
>> built from commit: ff94e79c4724635915dbb3d4ba38f6bb91528260
>> sizeof-long: 4
>> sizeof-size_t: 8
>> shell-path: /bin/sh
>> feature: fsmonitor--daemon
>> uname: Windows 10.0 22621
>> compiler info: gnuc: 13.1
>> libc info: no libc information available $SHELL (typically,
>> interactive shell): <unset>
>>
>>
>> [Enabled Hooks]
>> not run from a git repository - no hooks to show
