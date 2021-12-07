Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB497C433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 20:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236947AbhLGUjm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 15:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbhLGUjl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 15:39:41 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B587C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 12:36:11 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id r26so851739oiw.5
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 12:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Yh8Hy73HPUnjYSjc6b/fDquIhRBPIoPsYJNF8sil5pU=;
        b=ksh+PZKdYuE25gEYLhjPbksb/Pa271vbcX0qzHmMPnHGEQldtTCmqyOSiWR7gJcV0o
         AnohwpGX7DGA8Ucy+gh9a0nS7JbMtW3uXEVEFKChmPKBWulO38tqMQQ2CcGF1Nxg+837
         oy9QXfSObnd98H0G90V+PBahD/TExMsB7E8PXIPlr+AclWZjAuBTvUPTjrLroEzakPgk
         OJnvYsE+MKYMstYHZN9j1zCWDyk0Ic2fY+xTX3vgKEozcw8YJd2JnrGHQ8n/ZTDWG4RA
         iubu8yNTMf18B/afJS9SamMMe8EiE+BzdWY7Y89t9e39sMJDo2z5uC3I+TLK8xp0BMW/
         +meg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Yh8Hy73HPUnjYSjc6b/fDquIhRBPIoPsYJNF8sil5pU=;
        b=q346P7Hu3w5ZVMpJHVT3QSTSedknw762cPbR5iCZJP5bbglSrnSmvoUKaIZOjZ5/Yp
         J9mSKl4fUCY3xqLvmsyt7YhxUr5UysO38uPHmJLT1BzC9ISBFa4cGXod2m5x3yIuy0Ln
         xYfeqOJPp466MXp+N9QFMBXu5PFurG50Ia0ioMJxkwLSZR5/x3H/DyAQCbiqvSs2iO9j
         rgCkjcSzNLAA6cdPA0ao1bXrAVRThrY4IU3kGTqa/uRB6OisIDgZw4206Si5jIZCHCt9
         WXkiASVm2VXA3qXAtz83UcoxHucQjt6OhrNc/yA6An/2lSvRlOlZF2BzmPTTeSYdkIyK
         cyJw==
X-Gm-Message-State: AOAM533NiQQNFFQVwE7XjERDRWl2xmHMtJVL+fZxOOUFvbshpf4LX4PL
        E4UpBLpUIXkbbmHrohRxDp+TfdmN+l8=
X-Google-Smtp-Source: ABdhPJzGM+kTKXZnoUVEweqHuACB47XDo2Uc1HO2Tjjnq4ogFkJpuGDndWkPEb0QxkXwePJLygxSSg==
X-Received: by 2002:aca:add3:: with SMTP id w202mr7408960oie.100.1638909370462;
        Tue, 07 Dec 2021 12:36:10 -0800 (PST)
Received: from [192.168.86.121] (097-087-102-211.res.spectrum.com. [97.87.102.211])
        by smtp.gmail.com with ESMTPSA id s13sm127814otv.34.2021.12.07.12.36.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 12:36:10 -0800 (PST)
Message-ID: <6e09ab19-7ffb-e58e-7b08-6e560b421c06@gmail.com>
Date:   Tue, 7 Dec 2021 14:36:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH 3/6] sparse-checkout: enable `set` to initialize
 sparse-checkout mode
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>, Victoria Dye <vdye@github.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
References: <pull.1151.git.git.1638648020.gitgitgadget@gmail.com>
 <a90687eb4c1ea6569250391cd2a8111a0e338316.1638648020.git.gitgitgadget@gmail.com>
 <bb738571-f90c-7df5-2e20-ff716ed8a4f0@github.com>
 <CABPp-BF-7DRmE+DPZOFuCYwSRdD8yk4pPsYpFN4=5fALEkqATg@mail.gmail.com>
From:   Lessley Dennington <lessleydennington@gmail.com>
In-Reply-To: <CABPp-BF-7DRmE+DPZOFuCYwSRdD8yk4pPsYpFN4=5fALEkqATg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/7/21 9:04 AM, Elijah Newren wrote:
> On Sat, Dec 4, 2021 at 1:40 PM Victoria Dye <vdye@github.com> wrote:
>>
>> Elijah Newren via GitGitGadget wrote:
>>> From: Elijah Newren <newren@gmail.com>
>>>
>>> The previously suggested workflow:
>>>    git sparse-checkout init ...
>>>    git sparse-checkout set ...
>>>
>>> Suffered from three problems:
>>>    1) It would delete nearly all files in the first step, then
>>>       restore them in the second.  That was poor performance and
>>>       forced unnecessary rebuilds.
>>>    2) The two-step process resulted in two progress bars, which
>>>       was suboptimal from a UI point of view for wrappers that
>>>       invoked both of these commands but only exposed a single
>>>       command to their end users.
>>>    3) With cone mode, the first step would delete nearly all
>>>       ignored files everywhere, because everything was considered
>>>       to be outside of the specified sparsity paths.  (The user was
>>>       not allowed to specify any sparsity paths in the `init` step.)
>>>
>>> Avoid these problems by teaching `set` to understand the extra
>>> parameters that `init` takes and performing any necessary initialization
>>> if not already in a sparse checkout.
>>>
>>
>> I really like this change! It always seemed weird that `set` would
>> implicitly `init`, but without any of the options in `init`.
>>
>>> Signed-off-by: Elijah Newren <newren@gmail.com>
>>> ---
>>>   builtin/sparse-checkout.c | 52 ++++++++++++++++++++++++++++++++++++++-
>>>   1 file changed, 51 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
>>> index e252b82136e..cf6a6c6c3a7 100644
>>> --- a/builtin/sparse-checkout.c
>>> +++ b/builtin/sparse-checkout.c
>>> @@ -682,17 +682,26 @@ static int sparse_checkout_add(int argc, const char **argv, const char *prefix)
>>>   }
>>>
>>>   static char const * const builtin_sparse_checkout_set_usage[] = {
>>> -     N_("git sparse-checkout set (--stdin | <patterns>)"),
>>> +     N_("git sparse-checkout set [--cone] [--[no-]sparse-index] (--stdin | <patterns>)"),
>>
>> Since `cone` is an `OPT_BOOL`, shouldn't it appear in the usage string as
>> `--[no-]cone`? Without a `--no-cone` option, it's not clear how a user would
>> disable cone mode (since `set` preserves the existing cone mode setting if
>> `--cone` isn't given).
> 
> Yeah, fair point.  When copying from init I probably should have double checked.
> 
> Also, it makes me wonder if we should just make cone mode the default...
> 
That was actually my first thought when reviewing this change! It feels
like this would be a great moment to take the leap on that, but I can
also see it warranting a separate series.

>>>        NULL
>>>   };
>>>
>>>   static struct sparse_checkout_set_opts {
>>> +     int cone_mode;
>>> +     int sparse_index;
>>>        int use_stdin;
>>>   } set_opts;
>>>
>>>   static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
>>>   {
>>> +     int mode, record_mode;
>>> +     const char *default_patterns[] = {"/*", "!/*/"};
>>> +
>>>        static struct option builtin_sparse_checkout_set_options[] = {
>>> +             OPT_BOOL(0, "cone", &set_opts.cone_mode,
>>> +                      N_("initialize the sparse-checkout in cone mode")),
>>> +             OPT_BOOL(0, "sparse-index", &set_opts.sparse_index,
>>> +                      N_("toggle the use of a sparse index")),
>>>                OPT_BOOL(0, "stdin", &set_opts.use_stdin,
>>>                         N_("read patterns from standard in")),
>>
>> I know this isn't part of this patch, but is `stdin` really a bool (i.e.
>> someone might specify `--no-stdin`)? If not, I think `OPT_SET_INT` might be
>> more appropriate.
> 
> Good point.  OPT_SET_INT() wouldn't fix it, though; you need to use
> OPT_BOOL_F or OPT_SET_INT_F and pass PARSE_OPT_NONEG as a flag.  I can
> include that.
> 
>>>                OPT_END(),
>>> @@ -700,11 +709,52 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
>>>
>>>        repo_read_index(the_repository);
>>>
>>> +     set_opts.cone_mode = -1;
>>> +     set_opts.sparse_index = -1;
>>> +
>>>        argc = parse_options(argc, argv, prefix,
>>>                             builtin_sparse_checkout_set_options,
>>>                             builtin_sparse_checkout_set_usage,
>>>                             PARSE_OPT_KEEP_UNKNOWN);
>>>
>>> +     /* Determine if we need to record the mode; ensure sparse checkout on */
>>> +     record_mode = (set_opts.cone_mode != -1) || !core_apply_sparse_checkout;
>>> +     core_apply_sparse_checkout = 1;
>>> +
>>> +     /* If not specified, use previous definition of cone mode */
>>> +     if (set_opts.cone_mode == -1 && core_apply_sparse_checkout)
>>
>> I *think* this is supposed go before the `core_apply_sparse_checkout = 1;`
>> above it (if the intention is to only use the pre-existing cone mode setting
>> when already in a sparse checkout). If not, the `core_apply_sparse_checkout`
>> part of the condition is redundant and can be removed entirely.
> 
> Eek.  I had it there originally, then moved it later while doing
> various changes.  This definitely should be later; thanks for
> catching.
> 
>>> +             set_opts.cone_mode = core_sparse_checkout_cone;
>>> +
>>> +     /* Set cone/non-cone mode appropriately */
>>> +     if (set_opts.cone_mode == 1) {
>>> +             mode = MODE_CONE_PATTERNS;
>>> +             core_sparse_checkout_cone = 1;
>>> +     } else {
>>> +             mode = MODE_ALL_PATTERNS;
>>> +     }
>>> +     if (record_mode && set_config(mode))
>>> +             return 1;
>>> +
>>> +     /* Set sparse-index/non-sparse-index mode if specified */
>>> +     if (set_opts.sparse_index >= 0) {
>>> +             if (set_sparse_index_config(the_repository, set_opts.sparse_index) < 0)
>>> +                     die(_("failed to modify sparse-index config"));
>>> +
>>> +             /* force an index rewrite */
>>> +             repo_read_index(the_repository);
>>> +             the_repository->index->updated_workdir = 1;
>>> +     }
>>> +
>>> +     /*
>>> +      * Cone mode automatically specifies the toplevel directory.  For
>>> +      * non-cone mode, if nothing is specified, manually select just the
>>> +      * top-level directory (much as 'init' would do).
>>> +      */
>>> +     if (!core_sparse_checkout_cone && argc == 0) {
>>> +             argv = default_patterns;
>>> +             argc = 2;
>>> +     }
>>> +
>>>        return modify_pattern_list(argc, argv, set_opts.use_stdin, REPLACE);
>>>   }
