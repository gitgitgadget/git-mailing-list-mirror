Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63099C4363F
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 17:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C45760231
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 17:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbhDARr6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 13:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235710AbhDARnI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 13:43:08 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD2FC05BD39
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 06:10:58 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 68-20020a9d0f4a0000b02901b663e6258dso1994059ott.13
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 06:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=3B6TPRVQkiS5rME2+n0JQdEpTvT53KtLlz99nav1yOs=;
        b=VXqGfuTQrg2St3sShfufmRKyXxCCITK2tabun21BWmuX5tPAwdC6fgFDo1WEno+b6f
         EQyJ547vcTNT/t6Nl7tUNLJDRcOrQFfUQV7xsazAeQ9v2AgYyYxbSVsY6xAK9t91oYRd
         YxdA/asPHJWJPTbYIYxU2x9Us5jTDcXAWNlDVOQUa1tM1fs7SAbKvRfoQh79LG30TN5C
         xeRt/8xPIs4S4wwUT85+BEg2sel8XpEss2+6dAntY46J5+hLj17PRsVNY1k0yvbWYiqp
         He9oia2GpePQg2IjdV0iNWDEOIKT3E6q/4gehKFv/gxKU5OpIAf7zI2EPi8gTnpClIFW
         Q+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3B6TPRVQkiS5rME2+n0JQdEpTvT53KtLlz99nav1yOs=;
        b=f/ZtjcAu2YcBV5m02ylF4kC/L5wXNa/GE5MZVrM9sDF9xiAQM8ZcR2BMsNNJthnFo3
         8cAqByBZVdf8X3JrMzU5bqqtIxqLtlgc7Jbq0EklyqakrxDoCYwJuCvLuwo45xGh9GJx
         /Xl88ZppeXv9rEWRf6FBRBQhnjjAqGhQWbncPb2palHt/tXj/4T2Y3o4dquvoT0+y7s0
         SxEaIjYFzsWRoBGGEnKqXr1qr8mTnKJCnBVfTvL7ZOXfPY9LnaegyU3KFbTRkRjO2Nuk
         dkptI8jcZKfy9LpZ5ZbGuHgOoVBRSGrQ00vmIduLaKcks4mNafmbFUDDPe5XjuWuNSU+
         22hg==
X-Gm-Message-State: AOAM532t/Ci6G/7W2t4lFHzMfLP3FPQcwy6qUP7+/x8krhme2xC8ptVx
        QvHVQUF5O49Mf0mOSeSBpgS3tGylFfmodQ==
X-Google-Smtp-Source: ABdhPJxebsCjQloao2ErPUvmSrn/++xQh5mRSVk0AkuGpTX7yCKSz51WCeplL5hLqOn/MtNNBV0Cvw==
X-Received: by 2002:a05:6830:1e3b:: with SMTP id t27mr6781840otr.209.1617282658212;
        Thu, 01 Apr 2021 06:10:58 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:1cff:cd17:c59a:654? ([2600:1700:e72:80a0:1cff:cd17:c59a:654])
        by smtp.gmail.com with ESMTPSA id v136sm1034668oie.15.2021.04.01.06.10.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 06:10:57 -0700 (PDT)
Subject: Re: Detecting when bulk file-system operations complete
To:     Philip Oakley <philipoakley@iee.email>,
        Drew Noakes <drew@drewnoakes.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <CAJd66x6XT7m5Njg2kRyGJ80rU6WNcLifijS98=onJeBz+74rrA@mail.gmail.com>
 <5a1abc6b-52a3-fc12-166f-8af5e7bdff48@iee.email>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9c09459b-2d27-6997-63c1-46c8df52eda7@gmail.com>
Date:   Thu, 1 Apr 2021 09:10:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <5a1abc6b-52a3-fc12-166f-8af5e7bdff48@iee.email>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/31/2021 12:03 PM, Philip Oakley wrote:
> Hi Drew,
> 
> On 31/03/2021 04:39, Drew Noakes wrote:
>> Hi,
>>
>> I develop IDE tooling that watches a repo's workspace and reacts to changes.
>>
>> Bulk file-system changes (i.e. branch switch, rebase, merge,
>> cherry-pick) trigger lots of file system events, and my tooling should
>> ignore intermediary updates. Currently I debounce events with a fixed
>> time span, but would like a more reliable and performant approach to
>> scheduling this reactive work.
>>
>> Can this be done by monitoring the GITDIR in some way? For example, is
>> there a file that's present when these operations are in flight, and
>> which is removed when they complete?
>>
>> If an operation is interrupted (i.e. merge or rebase that hits a
>> conflict) my tooling should consider the bulk operation as complete.
>> This means that detecting a git-rebase-todo file or
>> rebase-merge/rebase-apply folder is not adequate.
>>
>> Any help appreciated. Thanks!
>>
>> Drew.
> You may want to look at the various bits of work on `fsmonitor` etc on
> the mailing list archive
> 
> https://lore.kernel.org/git/?q=fsmonitor
> 
> to ensure that all the different approaches inter-operate with
> reasonable efficiency..

This is an important suggestion. There is an issue with the current
approach of using FS Monitor with Watchman along with Visual Studio
Code and certain Git plugins:

1. When "git status" runs, the FS Monitor hook asks Watchman for
   changes. Watchman puts a "cookie file" in the working directory
   so it knows when the file system events are flushed.

2. VS Code notices this cookie file was written, so it interprets
   that a file was changed in the working directory. It calls
   "git status" to update its markers on the modified files.

This loops forever.

The new version of FS Monitor that Jeff Hostetler is working on
writes the cookie file into the .git directory, which VS Code (and
hopefully other IDEs) do not consider a trigger for running commands
like "git status".

This is just one example of the trickiness that ensues when using
filesystem events.

Thanks,
-Stolee
