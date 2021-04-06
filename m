Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1A4C433ED
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 16:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 438BC613D0
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 16:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346631AbhDFQvq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 12:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbhDFQvn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 12:51:43 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F887C06174A
        for <git@vger.kernel.org>; Tue,  6 Apr 2021 09:51:34 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id j7so11655191qtx.5
        for <git@vger.kernel.org>; Tue, 06 Apr 2021 09:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pukQn2axQcxMb11GlfmqEvz9spm5IKxVbrjoN5zmApU=;
        b=Ai7WF/zEgm6hVbJwrE0Mf7HxqLvMTf/z8fb7XHzuB2PwaF01JH+v5D9nJo+DqSvhTr
         diyRhkeyL1tYc3oS1omGTz6EJdsFGavCv5XBZvZ1GBwxl2wqfSfS5fi2JlQPdwoHfEU7
         jWL9DFjUwS3telhafzXKaq4NAib7sEQMdqC7f0xr+wWn0UJQ7J/fXJGNzE185MKyOPBp
         vJ+8McUZhN6M/z9SdXfXm/4GehRuGxMpQ1034BPMecci7PyB/SlQ1Namu/GZt/xWkmjW
         NY4ohJBipjyFKKGV+xg3ut5PWtF3dNvkgNucN+f7OWy8Y+CbIREQffPesazVyXvjqR9N
         lNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pukQn2axQcxMb11GlfmqEvz9spm5IKxVbrjoN5zmApU=;
        b=Di2nKybib/9/ecJXhgSiZadOhLgNvQd6YUzm2HwGPsv7USGJQh3jSRwgtXBW9Z221s
         hBrRfAHMSHkNsTIg3H14FnPuJoAj0jQe4jtcXM+HRKZQTxPp8kmVQO+1ScmY+gpCu9rB
         JcBE8mCnQW0ze99STaNYa5fUglMPANYFE+ZEC1tTAXgP12mwHk54t2l2iwDW8lAJOTVk
         bA5fHmHkWRQ+CwsIOcWabH0qhNQxmGmHG6i9TCBVOoeQ75Qls6LdcihQkuwKWPFiqmyd
         5WUWF7UNNSwgkl+msa4YkuL0PWVuJD26EMRarJLdEypORezHf2KwaCKOJ8Kr8UTRjovY
         Dkcw==
X-Gm-Message-State: AOAM530XUo1boEGBFvbEb5oqSz7gVr+1fD9T1rjzX/yTDBZ0QWtbLZvf
        oZJfQV2reTo7qlvmTDRS1LQ=
X-Google-Smtp-Source: ABdhPJzyW6CWBCQf8W2B7Rm+7J4ZpkSYDaI8PPLRm1OM1ykn8IxEFv6aZnldvKUVgiSWlJcmga3p/A==
X-Received: by 2002:ac8:7b4d:: with SMTP id m13mr27515111qtu.364.1617727893448;
        Tue, 06 Apr 2021 09:51:33 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:7d35:99dc:7770:379a? ([2600:1700:e72:80a0:7d35:99dc:7770:379a])
        by smtp.gmail.com with ESMTPSA id d10sm16207939qko.70.2021.04.06.09.51.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 09:51:32 -0700 (PDT)
Subject: Re: [PATCH 3/5] refspec: output a refspec item
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Tom Saeger <tom.saeger@oracle.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.924.git.1617627856.gitgitgadget@gmail.com>
 <e10007e1cf8ff0005295f648b9489c11a9427122.1617627856.git.gitgitgadget@gmail.com>
 <20210405165740.brevvzc7hiyg2wj4@brm-x62-17.us.oracle.com>
 <CAPig+cSfzpynO5es+B4=7_Dz-qTHNXpDeUVxs7z5yffQFgWU=A@mail.gmail.com>
 <xmqqzgyc62yl.fsf@gitster.g> <37f0ff6c-b493-35b5-5ca0-92703f82e333@gmail.com>
 <CAPig+cT8aqS1zaVqDSdycj6b9f3y7Mgn6TB9Sc1RY4_WomsY7Q@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c5137224-abca-5ed1-8c8a-540d1a51ab96@gmail.com>
Date:   Tue, 6 Apr 2021 12:51:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cT8aqS1zaVqDSdycj6b9f3y7Mgn6TB9Sc1RY4_WomsY7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/6/2021 11:23 AM, Eric Sunshine wrote:
> On Tue, Apr 6, 2021 at 7:21 AM Derrick Stolee <stolee@gmail.com> wrote:
>> I was not intending to make this re-entrant/thread safe. The intention
>> was to make it easy to consume the formatted string into output such
>> as a printf without needing to store a temporary 'char *' and free() it
>> afterwards. This ensures that the only lost memory over the life of the
>> process is at most one buffer. At minimum, these are things that could
>> be part of the message to justify this design.
> 
> This has the failing that it won't work if someone calls it twice in
> the same printf() or calls it again before even consuming the first
> returned value, so this fails:
> 
>     printf("foo: %s\nbar: %s\n",
>         refspec_item_format(...),
>         refspec_item_format(...));
> 
> as does this:
> 
>     const char *a = refspec_item_format(...);
>     const char *b = refspec_item_format(...);
> 
> Historically this project would "work around" that problem by using
> rotating static buffers in the function, but we've mostly been moving
> away from that for several reasons (can't predict how many buffers
> will be needed, re-entrancy, etc.).
> 
>> So, I'm torn. This seems like a case where there is value in having
>> the return buffer be "owned" by this method, and the expected
>> consumers will use the buffer before calling it again. I'm not sure
>> how important it is to do this the other way.
> 
> If history is any indication, we'd probably end up moving away from
> such an API eventually anyhow.
> 
>> Would it be sufficient to justify this choice in the commit message
>> and comment about it in the method declaration? Or is it worth adding
>> this templating around every caller:
>>
>>         char *buf = refspec_item_format(rsi);
>>         ...
>>         <use 'buf'>
>>         ...
>>         free(buf);
> 
> An alternative would be to have the caller pass in a strbuf to be
> populated by the function. It doesn't reduce the boilerplate needed by
> the caller (still need to create and release the strbuf), but may
> avoid some memory allocations. But if this isn't a critical path and
> won't likely ever be, then passing in strbuf may be overkill.
> 
>> I don't need much convincing to do this, but I hadn't properly
>> described my opinion before. Just a small nudge would convince me to
>> do it this way.
> 
> For the reasons described above and earlier in the thread, avoiding
> the static buffer seems the best course of action.

OK, convinced. I'll return a string that must be freed in my
next version. Thanks!

-Stolee
