Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA91C433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 13:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D794611AD
	for <git@archiver.kernel.org>; Tue, 18 May 2021 13:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245342AbhERNz5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 09:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244823AbhERNzx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 09:55:53 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB75C061756
        for <git@vger.kernel.org>; Tue, 18 May 2021 06:54:34 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id q17-20020a4a33110000b029020ebab0e615so324169ooq.8
        for <git@vger.kernel.org>; Tue, 18 May 2021 06:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cP9Obcc0JpD0yt1ygLnPnNwqa/T3OpnX+FVLRSbMS20=;
        b=ktyShktN7OT7e9AFA1EXKSJPvN7FJE9KSqNR9VpwRLm3Sxvz4Re3C+XhA0sJygE2wL
         n8LAdKzQLqTByJmy9XWmZcfDbyjmOLfzVVXHonVAThW0o6eBxxuVur601VMoIVG61FmN
         wgIl+3CqJC0xE4cOqBl6oCMFG7goTQaiIenuFB6f1BW642PtDt1q6pAjNSRn77Y31IO+
         1Q/f7ksrvep4EJqbIXoBrv3NUDgK9qpsHG4JdI/K2EpJZp+8V8E7uQ62zWE4aqB9GH/7
         3lvKyCyTepIDOVBkr8zCiVSq/W2Lkt0/fNtnapljUynNvs5++VGl6cu22Xja+O6v8sfI
         EmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cP9Obcc0JpD0yt1ygLnPnNwqa/T3OpnX+FVLRSbMS20=;
        b=L3Th29kQfsWYzFldXa40XBr89DX+O9a7m5AEApW+jN2mPAeehr5rUabRQM2jzA8oTh
         hXtIxNW5z9ZfqQfR2T02bZrPCqfjmX31jbWemJ8Ty7GKmKeM9QkAjXSq6nrpZQpW20s9
         UpI+qLF8l1LY3nERIzdmWVrSryL/BV13JdexUn6BcZ+dRnzSgQt4+9m97rWhZSeK6HN6
         9gqXEvqXFF8dO9Bjpbn4pu4bAPOSFu8dZolrqL8CcvaOWTrql/GwG9BsZNiLm5RVZhjx
         lPh4Wbziv/A3oo+Udop1vqy4evKFPd0NyHeQ6pSm2LhOkWvaznUMEqoms3gcMqkr2qgj
         GEzw==
X-Gm-Message-State: AOAM533aofZnTnpzKnLiK1E7ggzHIrg0mhV3MRXJg0VTd5E6y0USFIs2
        CKh5+Kiw2LpB7OqmKPzM65M=
X-Google-Smtp-Source: ABdhPJy0kUIcv6Bd+/bB4NawAPSgoGipM+YtYkO5qV0TBptgh1gxXO3ZifO5WzKR025QFNwrJiXb/Q==
X-Received: by 2002:a4a:250e:: with SMTP id g14mr4522786ooa.31.1621346073984;
        Tue, 18 May 2021 06:54:33 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:bcf4:c194:74a1:9906? ([2600:1700:e72:80a0:bcf4:c194:74a1:9906])
        by smtp.gmail.com with ESMTPSA id 16sm3798210otu.79.2021.05.18.06.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 06:54:32 -0700 (PDT)
Subject: Re: [PATCH v2 04/13] fast-rebase: write conflict state to working
 tree, index, and HEAD
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>
References: <pull.859.git.1616621553.gitgitgadget@gmail.com>
 <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
 <887b151c26ff0f175f2da431d77cd377bd066990.1620094339.git.gitgitgadget@gmail.com>
 <30c23689-cdab-143e-159c-93e50c808430@gmail.com>
 <CABPp-BHpLBjyxsb+BM+ssZVHRJnn+DjazSQi6bHRXHET1vqGhg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <34ba20ec-5868-756d-c22a-e865480cea50@gmail.com>
Date:   Tue, 18 May 2021 09:54:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CABPp-BHpLBjyxsb+BM+ssZVHRJnn+DjazSQi6bHRXHET1vqGhg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/17/2021 11:42 PM, Elijah Newren wrote:
> On Mon, May 17, 2021 at 6:32 AM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 5/3/21 10:12 PM, Elijah Newren via GitGitGadget wrote:
>>> From: Elijah Newren <newren@gmail.com>
>>>
>>> Previously, when fast-rebase hit a conflict, it simply aborted and left
>>> HEAD, the index, and the working tree where they were before the
>>> operation started.  While fast-rebase does not support restarting from a
>>> conflicted state, write the conflicted state out anyway as it gives us a
>>> way to see what the conflicts are and write tests that check for them.
>>>
>>> This will be important in the upcoming commits, because sequencer.c is
>>> only superficially integrated with merge-ort.c; in particular, it calls
>>> merge_switch_to_result() after EACH merge instead of only calling it at
>>> the end of all the sequence of merges (or when a conflict is hit).  This
>>> not only causes needless updates to the working copy and index, but also
>>> causes all intermediate data to be freed and tossed, preventing caching
>>> information from one merge to the next.  However, integrating
>>> sequencer.c more deeply with merge-ort.c is a big task, and making this
>>> small extension to fast-rebase.c provides us with a simple way to test
>>> the edge and corner cases that we want to make sure continue working.
>>
>> This seems a noble goal. I'm worried about the ramifications of such
>> a change, specifically about the state an automated process would be in
>> after hitting a conflict.
> 
> Why would an automated process be using test-helper code?  Note that
> this is code from t/helper/test-fast-rebase.c.
...
>> So perhaps this could use a test case to demonstrate the change in
>> behavior? Such a test would want to be created before this commit, then
>> the behavior change is provided as an edit to the test in this commit.
>>
>> But maybe I'm misunderstanding the change here and such a test is
>> inappropriate.
> 
> If this weren't code under t/helper/, I'd agree whole-heartedly with
> the suggestion.

You're right. Ignore me.

-Stolee
