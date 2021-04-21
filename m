Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A58C433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 13:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D26C96144B
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 13:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242288AbhDUNsU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 09:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241688AbhDUNsT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 09:48:19 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D17FC06138A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 06:47:46 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id a18so7460513qtj.10
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 06:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Rrm91XfSa4piX2FLMsA4u0M6Ac+UiIRupn0EqnJSB1M=;
        b=fp3IF9avG5P2nsbdKGxYJWAXEyFGADJV6lmPQObXuOMZ8/XQ/crFNoMlb9iEldZdEx
         aidtK2F56dgHMpXUy4AFWv40BCZE7PIHRatk3u6eeCqPVOMhPD8o7dEaS2GaVARXBHme
         RnADqudedapvHuAWA3fvfODSlmb2njCH5uCvlqR/guRYqiF8UlMOWqNo2kDs8J8KYVDu
         iBRlPhE7krLBlkDaT6G6MNac6bdiS13GdT0zc50/ZkTJMPt8C+HYtUqPmUwUi9vf2cnk
         zeyUZFZXVnUiNxEItN6vF1Ss3BVBeYi4mwuGYkHJ1iva5fWXtdb2GkpIJZ9yaBDW5nLg
         0JkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rrm91XfSa4piX2FLMsA4u0M6Ac+UiIRupn0EqnJSB1M=;
        b=knQbNPuK9bjkJxwz/XeZnhGcWAJ2md0epWNPbIS4X++t0xp2Uz0/bzvowp0/xId3I/
         zHw3997N//5p+I5Y+p9FFH89nRhPAff57yVSgfOisOJKamYS/TjyhGNhX9789OlBJuHC
         Uh+tBy0YNDnQdkw+gtmAbeiujWu0OYKcDxFOiEM66hlq+5RddbfgFGLxlgqsnTUyIu97
         +l/EtDqmqaOBu7mlY1pkT4cTZbBf0vrjWwm5rkYa8/YdMbKzoDAs/68TgRoFhJ9nPN0l
         0Pg4caWMCbu5H/4tYFY9nbIwHPlgQOZXNKDNTbzCq5aeEvDd8Xa9dhO3He8mnZUqdHe7
         QqNg==
X-Gm-Message-State: AOAM530fzVs5I1wL/Y9blmhldt/j/5eo1WtUPCvW53dFWNJy8oH0v9oK
        CDB+zzfMd9MxowKp65p4AzQ=
X-Google-Smtp-Source: ABdhPJz9Ne0Kzdos5OvaZirusXgf4FmNoV26eFvmQ5ZkXTN7oj+QsiC2DbSGyizAtjhJBRHl8qUhGg==
X-Received: by 2002:ac8:60c8:: with SMTP id i8mr14582597qtm.63.1619012865674;
        Wed, 21 Apr 2021 06:47:45 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:e10e:eea5:8b82:2147? ([2600:1700:e72:80a0:e10e:eea5:8b82:2147])
        by smtp.gmail.com with ESMTPSA id m16sm2061296qkm.100.2021.04.21.06.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 06:47:45 -0700 (PDT)
Subject: Re: [PATCH 03/10] dir.c: accept a directory as part of cone-mode
 patterns
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.932.git.1618322497.gitgitgadget@gmail.com>
 <28ca717e6526f0b66df696f3237d72b9bee2ffc3.1618322497.git.gitgitgadget@gmail.com>
 <CABPp-BH8LHA_gvBF2pB2+S_5ttYoesDw_qScNrRiyYBVzPHdGw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <252df328-a615-b2fd-ec52-f37ee4397bc1@gmail.com>
Date:   Wed, 21 Apr 2021 09:47:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <CABPp-BH8LHA_gvBF2pB2+S_5ttYoesDw_qScNrRiyYBVzPHdGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/20/2021 7:21 PM, Elijah Newren wrote:
> On Tue, Apr 13, 2021 at 7:01 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> When we have sparse directory entries in the index, we want to compare
>> that directory against sparse-checkout patterns. Those pattern matching
>> algorithms are built expecting a file path, not a directory path. This
>> is especially important in the "cone mode" patterns which will match
>> files that exist within the "parent directories" as well as the
>> recursive directory matches.
>>
>> If path_matches_pattern_list() is given a directory, we can add a fake
>> filename ("-") to the directory and get the same results as before,
>> assuming we are in cone mode. Since sparse index requires cone mode
>> patterns, this is an acceptable assumption.
> 
> Makes sense; thanks for the good description.
> 
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>  dir.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/dir.c b/dir.c
>> index 166238e79f52..57e22e605cec 100644
>> --- a/dir.c
>> +++ b/dir.c
>> @@ -1378,6 +1378,11 @@ enum pattern_match_result path_matches_pattern_list(
>>         strbuf_addch(&parent_pathname, '/');
>>         strbuf_add(&parent_pathname, pathname, pathlen);
>>
>> +       /* Directory requests should be added as if they are a file */
> 
> "added" or "matched"?  Also, the description seems a bit brief and
> likely to surprise; I'd at least want to expand "file" to "file within
> their given directory" but it might be nice to get some summarized
> version of the commit message or at least state that "-" is just a
> random simple name within the given directory.

I can improve this comment.

>> +       if (parent_pathname.len > 1 &&
> 
> Is this line...
> 
>> +           parent_pathname.buf[parent_pathname.len - 1] == '/')
> 
> to prevent an out-of-bounds indexing?  If so, shouldn't it be "> 0" or
> ">= 1" rather than "> 1"?  And if so, doesn't the strbuf_addch() call
> above ensure the condition is always met?
> 
> Or are we trying to avoid adding the "-" when we parent_pathname is
> just a plain "/"?

I believe plain "/" is impossible. There needs to be a valid tree entry
before that first slash ("a/", for example). But that isn't super
important to the logic here and just adds confusion.

> 
>> +               strbuf_add(&parent_pathname, "-", 1);
>> +
> 
> Sorry for all the questions on such a tiny change.  It makes sense to
> me, I'm just curious whether it'll confuse future code readers.

Yes, let's avoid confusion by doing the simple thing and use "> 0".

Thanks,
-Stolee
