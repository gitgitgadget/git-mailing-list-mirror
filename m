Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A839CC433E0
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 23:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AD1E2070E
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 23:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7G4OZnf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgGIXlS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 19:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgGIXlS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 19:41:18 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC96C08C5DD
        for <git@vger.kernel.org>; Thu,  9 Jul 2020 16:41:17 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id h18so1800489qvl.3
        for <git@vger.kernel.org>; Thu, 09 Jul 2020 16:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aO6tLacrc/1KCIRzz5LM+izvnC4Tjr2UbXGo/QFFrhM=;
        b=a7G4OZnfA75iLYPdDJgiv4bktZMEpND91Y4hVYGXNoDlx1DOMnSATCIaz4jLeBwKjg
         HERoC/LfwBiv14O9kEAYm6zZMgyISvGxYxzdKoD23YPPCPOSgF2nG+TsHKaN2W9alA6Y
         f0HoxRXsfaxjvSckrxq8D3pNwVjwSOOB0EuDNYfuFDn5h4T9UKrfpkhOcjmlGJjQ+cbD
         iTaO5ikOoND3WOLVCeM7OlzZubkqxQ6IJp/pr5w/L04sCy6RmmHy9H+On3QWolTcqDpO
         ASGsYNz4ZE9qm8Nxi/CR777NOu+ZP7+Fl6S8Sqsh0y2tGiqgLVZlXaKOBdqE2kSd3kdL
         /cRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aO6tLacrc/1KCIRzz5LM+izvnC4Tjr2UbXGo/QFFrhM=;
        b=uVaBcGM5neB8u6acs+CfmXpLi/vgCgl8xN7MvjqXXbfSjw1hpg1g6Fs4Nty5yUlXQ9
         aDdNTmWx5LGZTCKkJGKwU6VQVQP4JxvDtQOiM/64ZWaJPzxY927JVTseYC3G/b3X62ow
         XTSo9c4otqZI7aOe4bAhTQ7HyXiRp/lOHwUVnQEpzJnCZ/MjFVtsJ3tKlMjVgzYPAAzQ
         zWiUOkw8XjuGDU7XRHQsGZxs/ad+BNKri1bHwyjsHmPVEciTaVhkE4kayVf4pUwCNBB1
         5bOwUgJQcBajv9pPOxKGCG+qOPVrR+sQQqCWqI5P7HPFUcCVTyhP/2uF7cbTukxi3ASa
         gJfA==
X-Gm-Message-State: AOAM532wshWFQtoBMHfZZvDrZPpeKFV4uGTJLnT24Ef7aaZSfdIhy7TQ
        nqSrU89eQKBCHzo1/NHcZI8=
X-Google-Smtp-Source: ABdhPJzvROFWgE9kUnCytPdhVqs+hkPM7oxg7PZkRZX5zA5Av8A46wh8bH8g50fwNLOWa2SBcwUyXA==
X-Received: by 2002:ad4:5a46:: with SMTP id ej6mr65210333qvb.52.1594338077074;
        Thu, 09 Jul 2020 16:41:17 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id n28sm5854551qtf.8.2020.07.09.16.41.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 16:41:16 -0700 (PDT)
Subject: Re: [PATCH 09/21] maintenance: add commit-graph task
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitgitgadget@gmail.com,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, derrickstolee@github.com,
        dstolee@microsoft.com
References: <c8fbd14d41093e12905027ff628b98652cd931d0.1594131695.git.gitgitgadget@gmail.com>
 <20200709022942.39848-1-jonathantanmy@google.com>
 <8dacf017-c445-578c-c82c-f6d6f93469c9@gmail.com>
 <20200709225246.GA664420@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <59d11581-c182-8e00-2698-8b632683808b@gmail.com>
Date:   Thu, 9 Jul 2020 19:41:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <20200709225246.GA664420@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/9/2020 6:52 PM, Jeff King wrote:
> On Thu, Jul 09, 2020 at 07:14:41AM -0400, Derrick Stolee wrote:
> 
>> On 7/8/2020 10:29 PM, Jonathan Tan wrote:
>>>> +static int run_write_commit_graph(struct repository *r)
>>>> +{
>>>> +	int result;
>>>> +	struct argv_array cmd = ARGV_ARRAY_INIT;
>>>> +
>>>> +	argv_array_pushl(&cmd, "-C", r->worktree,
>>>> +			 "commit-graph", "write",
>>>> +			 "--split", "--reachable",
>>>> +			 NULL);
>>>
>>> As mentioned in my reply to an earlier patch (sent a few minutes ago),
>>> this won't work if there are environment variables like GIT_DIR present.
>>
>> Do we not pass GIT_DIR to the subcommand? Or does using "-C" override
>> the GIT_DIR?
> 
> We do pass GIT_DIR to the subcommand, and "-C" does not override it. I
> think this code would work as long as "r" is the_repository, which it
> would be in the current code. But then the "-C" would be doing nothing
> useful (it might change to the top of the worktree if we weren't there
> for some reason, but I don't think "commit-graph write" would care
> either way).
> 
> But if "r" is some other repository, "commit-graph" would continue to
> operate in the parent process repository because of the inherited
> GIT_DIR. Using "--git-dir" would solve that, but as a general practice,
> if you're spawning a sub-process that might be in another repository,
> you should clear any repo-specific environment variables. The list is in
> local_repo_env, which you can feed to the "env" or "env_array" parameter
> of a child_process (see the use in connect.c for an example).
> 
> Even in the current scheme where "r" is always the_repository, I suspect
> this might still be buggy. If we're in a bare repository, presumably
> r->worktree would be NULL.

Ah. I'll investigate this more and work to create a way to
run a subcommand in a given repository. Your pointers will
help a lot.

Thanks,
-Stolee

