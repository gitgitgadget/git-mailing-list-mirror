Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E60C7EE23
	for <git@archiver.kernel.org>; Wed, 31 May 2023 13:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjEaNhQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 May 2023 09:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235251AbjEaNhO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2023 09:37:14 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA980C5
        for <git@vger.kernel.org>; Wed, 31 May 2023 06:37:13 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-bad041bf313so8100462276.0
        for <git@vger.kernel.org>; Wed, 31 May 2023 06:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1685540233; x=1688132233;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v8fDPRGRc03W629DIZwZA0X16uCAOwj7+byUkhfCgeI=;
        b=KEQ59fyz5IYw3f8tJZBOvPUOL1ctN/7ets68ojQMpQBitW5uWpqMqU17hq12UFoyL0
         saYGDM+aXfMH/rIzA1ZlQ6hmpWdFxRFMmAUo4r9ApieKqbsxYvyL+fT4pLGRrcaWtzbT
         cw3p1U8lFL/hvo6JY4nro7uxtGDbFjO+vR3cGF1C+t4wGZJ+KX5hmmwYYHifUjABF3cL
         +eGpjdYOeTOa4QXs7kaU9OSo48ZjYPqWX6A6ulsIt+LgBkxWc/Ewd803QuxU91nS6UOM
         1idQjY72UZH4FSi7q3gK5tJfM/oUeRUkSIh/bFf0XFrIn1wRoe8gNnCBMSCeoYi2Edkw
         wf/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685540233; x=1688132233;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v8fDPRGRc03W629DIZwZA0X16uCAOwj7+byUkhfCgeI=;
        b=DMhc0EzuTbVzh0dqlT5E+RYxSj0jUQjFGm+fgFRZU9hLTpVBdfXJb/lL/JJm4GxQbE
         IzFL/kLt97FrAB5Og5o+QoBILMPHiHEOtQtDVcUSLBk3xQbYe+hwHWgpEOJgVLdzEOYI
         mE4ZxRfmYsuh3oWH4y0QspheNHUjRypiveT3EO7FFDCYjOR5LBHVsmJUtxQr7ZZe94aR
         oIb5iPOL+bf0bIL8MTjWhwWYhs5CYE4Yfn79H22SGnqB/bfquOVCsXtA3JCWFY3iqWt9
         mG9l4YjTBZ4UzTXy0zT4xeEmwl2EbBpmQjFM1e+Mf2TUSTctEyonhbEChx4msc58RdWt
         qj5Q==
X-Gm-Message-State: AC+VfDxSSogCLmXj/wOVzc1X7M/wWiAxJRzFNddUI09ypgj2RTdARIbQ
        2EfEF3m5lQcys6huU3FW4hT7FggBo+2lqJUbZg==
X-Google-Smtp-Source: ACHHUZ4n+hrzEqFgRGSpmaRq106ZmWSQ51+7w9DP67h+A56DEFnOaOJUXnBM49qA4zBmZiz+20NNiA==
X-Received: by 2002:a25:d80e:0:b0:ba8:68b2:d428 with SMTP id p14-20020a25d80e000000b00ba868b2d428mr6077543ybg.62.1685540232948;
        Wed, 31 May 2023 06:37:12 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:f8be:71a0:b37c:7e40? ([2600:1700:e72:80a0:f8be:71a0:b37c:7e40])
        by smtp.gmail.com with ESMTPSA id y16-20020a256410000000b00b9def138173sm4165371ybb.1.2023.05.31.06.37.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 06:37:12 -0700 (PDT)
Message-ID: <ae89feda-0a76-29d7-14ce-662214414638@github.com>
Date:   Wed, 31 May 2023 09:37:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH 1/3] repository: create disable_replace_refs()
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, me@ttaylorr.com,
        gitster@pobox.com
References: <pull.1537.git.1685126617.gitgitgadget@gmail.com>
 <56544abc15d1fce6fb4a0946e709470af9225395.1685126618.git.gitgitgadget@gmail.com>
 <CABPp-BFzA0yVecHK1DEGMpAhewm7oyqEim7BCw7-DTKpUzWnpw@mail.gmail.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CABPp-BFzA0yVecHK1DEGMpAhewm7oyqEim7BCw7-DTKpUzWnpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/31/2023 12:41 AM, Elijah Newren wrote:
> On Fri, May 26, 2023 at 11:43 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:

>> We will never scope this to an in-memory repository as we want to make
>> sure that we never use replace refs throughout the life of the process
>> if this method is called.
> 
> I'm confused; doesn't the 3rd patch do exactly what this paragraph
> says you'll never do?

You mentioned in another reply that you figured it out, but for the sake
of anyone reading here: we _add_ a repo-scoped version for the config,
but we need this globally-scoped one for process-wide disabling the
feature. This could be said more clearly.
 
>> @@ -323,13 +322,13 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
>>         struct option *options = parse_options_concat(builtin_commit_graph_options, common_opts);
>>
>>         git_config(git_default_config, NULL);
>> -
>> -       read_replace_refs = 0;
>>         save_commit_buffer = 0;
>>
>>         argc = parse_options(argc, argv, prefix, options,
>>                              builtin_commit_graph_usage, 0);
>>         FREE_AND_NULL(options);
>>
>> +       disable_replace_refs();
>> +
> 
> In this place and several others in the file, you opt to not just
> replace the assignment with a function call, but move the action line
> to later in the file.  In some cases, much later.
> 
> I don't think it hurts things, but it certainly makes me wonder why it
> was moved.  Did it break for some reason when called earlier?  (Is
> there something trickier about this patch than I expected?)

Generally, I decided to move it after option-parsing, so it wouldn't
be called if we are hitting an option-parse error.

However, these moves were only important for a draft version where
I had not separated the global and local scopes, so calling the method
would also load config.

In this version of the patch, this is not needed at all, and I could
do an in-line replacement. Thanks!

>> diff --git a/repo-settings.c b/repo-settings.c
>> index 7b566d729d0..1df0320bf33 100644
>> --- a/repo-settings.c
>> +++ b/repo-settings.c
>> @@ -3,6 +3,7 @@
>>  #include "repository.h"
>>  #include "midx.h"
>>  #include "compat/fsmonitor/fsm-listen.h"
>> +#include "environment.h"
> 
> Why?  There are no other changes in this file, so I don't see why
> you'd need another include.

Thanks. This is a leftover from a previous version of the patch.
 
>>
>>  static void repo_cfg_bool(struct repository *r, const char *key, int *dest,
>>                           int def)
>> --
>> gitgitgadget
> 
> I think the patch is probably fine, but I saw a few things that made
> me wonder if I had missed something important, highlighted above.

Thank you for pointing them out, as the things that brought you
confusion are cruft from an earlier version but are no longer
valuable in this version.

Thanks,
-Stolee
