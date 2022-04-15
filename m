Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF2DC433F5
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 14:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354233AbiDOOFn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 10:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354243AbiDOOFm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 10:05:42 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DC3BF32C
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 07:03:13 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id g18so10757286wrb.10
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 07:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Smj9JUK/4LflYGQBlm3pKgkAdy1JGdLqo8RHwQu5E/o=;
        b=NcU3DckgSyi546VSeDeWQ6FTgg5Uzia8dhP5KJriTG5woU5GwkES93go4IMHHQdaRF
         VBS7MWrkms6zy40bPZjctM8zbEqDAcuU1l13NDsWID9la/IpjUzuLyJXnov8n8SZmplW
         Bbmu+7BNnq6z9FsFqHPZpMRX7ldtU4LnktayTwnjqeiO+O8haAeLTf2lUlWfsrWYF81A
         yP5FnzjKH4bKr15FfGYFbE0sDRcIvQxhONQeFeWWt/Wk1ctIqUPL7PKxmQZmf8CkUneG
         dF5Rstp5TWMx0JOX+Fo9pxImzsplDpqAhuEl0X0jPRJkNA2HQ7JCdtZo5Toq33JM91/n
         fSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Smj9JUK/4LflYGQBlm3pKgkAdy1JGdLqo8RHwQu5E/o=;
        b=G8jS1POj4GGIfuKJWAzW4LhEJM6sM0eMmDlC2+SkdIs4xhlEL9bHJh79X5Fl2xp7le
         XZvWHcX/UW3QuokyCVwEAfUqYGQtvrvBIMjq3U195NXsxcyDbqZQ7d5IpP47fQEAT7/8
         n+a7XctZLJzh+aEIgUnrWwPmhQTSK3Kj350xfEn33Sz2FbomNKcYiwQMrZVpqbsQ6oay
         aHkeMH94G1K9xNupeTBkznz8IreNFbfY7QGDSe2j9xckvwDsfwSjxhrrmAUHzpwfuXKl
         RYPFOpSc5uxBhu1zs7Er854WmWTfXcdb/tl8uWqH0mhuJw/yNh/16EqHyxjqUSYCA2a7
         yoHw==
X-Gm-Message-State: AOAM531+xMQfigifFANpjaWn5gt1Zhe0xa5Y7CHaZEUhvtOufxcXiOKO
        uUaie/DnyQBJjBaexv67fITz6tQovrA=
X-Google-Smtp-Source: ABdhPJwINRhb9Aq8Qp50OP/9QWlK/ZGIlFYZPLtNxsOvmHWVTjULAhoT3Oj6epL3SMqsVWle05XLJA==
X-Received: by 2002:a5d:4b52:0:b0:207:a53e:fe56 with SMTP id w18-20020a5d4b52000000b00207a53efe56mr5576642wrs.22.1650031392310;
        Fri, 15 Apr 2022 07:03:12 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id ay41-20020a05600c1e2900b0038e75fda4edsm4682843wmb.47.2022.04.15.07.03.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Apr 2022 07:03:12 -0700 (PDT)
Message-ID: <ef186379-7d59-36e4-068f-b15375e42789@gmail.com>
Date:   Fri, 15 Apr 2022 15:03:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 4/7] rebase --apply: respect GIT_REFLOG_ACTION
Content-Language: en-GB-large
To:     Christian Couder <christian.couder@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1150.git.1645441854.gitgitgadget@gmail.com>
 <58c560d0e19a3fa6dd5de547821c9642089de3fb.1645441854.git.gitgitgadget@gmail.com>
 <CAP8UFD3dx_Mv=X1y11LDy6NOcV0eDq5s92PqdC3LnbBFCi1kxg@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAP8UFD3dx_Mv=X1y11LDy6NOcV0eDq5s92PqdC3LnbBFCi1kxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian

On 07/04/2022 14:59, Christian Couder wrote:
> On Tue, Feb 22, 2022 at 6:41 AM Phillip Wood via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> The reflog messages when finishing a rebase hard code "rebase" rather
>> than using GIT_REFLOG_ACTION.
> 
> Yeah, but GIT_REFLOG_ACTION is something like "pick" or "continue" ...

GIT_REFLOG_ACTION can be set in the environment by the user (or more 
likely a script) to change the command name in reflog messages created 
by rebase. At the moment we respect that for all the messages apart from 
the ones being changed here.

Best Wishes

Phillip

>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>   builtin/rebase.c          | 7 ++++---
>>   t/t3406-rebase-message.sh | 2 +-
>>   2 files changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/builtin/rebase.c b/builtin/rebase.c
>> index 36863117fba..e50361fc2a9 100644
>> --- a/builtin/rebase.c
>> +++ b/builtin/rebase.c
>> @@ -580,10 +580,11 @@ static int move_to_original_branch(struct rebase_options *opts)
>>          if (!opts->onto)
>>                  BUG("move_to_original_branch without onto");
>>
>> -       strbuf_addf(&branch_reflog, "rebase finished: %s onto %s",
>> +       strbuf_addf(&branch_reflog, "%s finished: %s onto %s",
>> +                   getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
>>                      opts->head_name, oid_to_hex(&opts->onto->object.oid));
> 
> ... so this will say "pick finished..." instead of "rebase
> finished..." while it may be better to have something like "rebase
> (pick) finished...", or am I missing something?
> 
>> -       strbuf_addf(&head_reflog, "rebase finished: returning to %s",
>> -                   opts->head_name);
>> +       strbuf_addf(&head_reflog, "%s finished: returning to %s",
>> +                   getenv(GIT_REFLOG_ACTION_ENVIRONMENT), opts->head_name);
> 
> In patch 2/7 GIT_REFLOG_ACTION, instead of
> GIT_REFLOG_ACTION_ENVIRONMENT, is used.
> 
> It looks like GIT_REFLOG_ACTION_ENVIRONMENT is defined in reset.h
> while GIT_REFLOG_ACTION is defined in sequencer.c. Maybe we could get
> rid of one of these two, and use the same everywhere?
> 
>>          ropts.branch = opts->head_name;
>>          ropts.flags = RESET_HEAD_REFS_ONLY;
>>          ropts.branch_msg = branch_reflog.buf;
