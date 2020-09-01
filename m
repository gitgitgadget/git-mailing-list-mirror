Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EF7C433E2
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 14:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68BC12078B
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 14:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDok3+kV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbgIAObU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728378AbgIAOYV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 10:24:21 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F66C061246
        for <git@vger.kernel.org>; Tue,  1 Sep 2020 07:24:21 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id f142so1063540qke.13
        for <git@vger.kernel.org>; Tue, 01 Sep 2020 07:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F5Bgr0eYdmU8yI1bAOocprtnH7Rzc9+C7hfEh9SgIL8=;
        b=jDok3+kVdnr5aZr/owyo/jjhbLEq2bZoOPONdV6V4K0sXUgUIrH+7rtC8AbJxp2ouv
         O+FgsqT1kkNjyySo54neR+pdu4547e3eTKMt+xX+b47Itf0NG4H2+Je8WIIba9QOVCCM
         uV+hnqY2nmCU6tFRGv1CDnWS+AfVLtSRKls8SkNLnFJh17TIMUFpaZuiN+fpIHzIWx3E
         l8sB47CkUNQxQGfQ3Q1TxAYmtzU676G7ugmjcGM/RKGnvjg7VvJDj9wpBPQzgOVQCpA7
         UjshSwnLxqsmsJE6aRK2LDVSfWapvTDp3uyWZhXoW3fLZ2N8oiPeTvp2FvLS4qobQrBv
         AYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F5Bgr0eYdmU8yI1bAOocprtnH7Rzc9+C7hfEh9SgIL8=;
        b=H3ykh9WDuX26nKMx8wF6fpMCjYJSqmySDYK5xbTs0j3ACQsTGgLx4WhIZHGOxtTimf
         NglglEcCjvlAG+FvAkoIQR8x3hY0bXF+NOQ5EAJyNY3QYUQmfn8WO/MR01lfq4tva0jE
         CCO7zwFp09GWqYSRMkB955gvQai22uP9plJjkMmKx9r52VsAoKOOm8zOLHLNbq0iTQCq
         1FRB7EeA6NmEJDIK8Bj5iJW3FYg0/7k9H8fBsaW83LpjxXjPo6krYjSzsRIDW0ipZ7uK
         ISRyjyMVugiMYVNxYaJFc3K311gVXFBRO4ZjyWbWQty7dePZMLNyJArSbo9RTapjXgrf
         XQWg==
X-Gm-Message-State: AOAM533whpC1r8u8CnUXRjHkJSwvnOzBdluJn3To7d6XV8mvtWS86jH5
        0zDSqOra4RjIMCVlnn82D5atCMJbEOCpGQ==
X-Google-Smtp-Source: ABdhPJwo11znjSlrWmCm2EfGu39x3KXsTYC3DugRWIxW7bCLZFET7OGDPlzK9cMkh7mkpLkLoCgoqg==
X-Received: by 2002:a37:e105:: with SMTP id c5mr2119349qkm.150.1598970260061;
        Tue, 01 Sep 2020 07:24:20 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:5166:a025:6686:ff84? ([2600:1700:e72:80a0:5166:a025:6686:ff84])
        by smtp.gmail.com with ESMTPSA id o28sm1569468qtl.62.2020.09.01.07.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 07:24:19 -0700 (PDT)
Subject: Re: [PATCH] xrealloc: do not reuse pointer freed by zero-length
 realloc()
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <20200901111800.GA3115584@coredump.intra.peff.net>
 <c81b7225-a663-1598-62b3-bd80457d5648@gmail.com>
 <20200901135105.GA3284077@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a176961b-645f-4dcb-3439-596f814891f4@gmail.com>
Date:   Tue, 1 Sep 2020 10:24:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <20200901135105.GA3284077@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/1/2020 9:51 AM, Jeff King wrote:
> On Tue, Sep 01, 2020 at 09:04:36AM -0400, Derrick Stolee wrote:
>> Adding an `if (!size) {free(ptr); return NULL;}` block was what I
>> expected. Was that chosen just so we can rely more on the system
>> realloc(), or is there a performance implication that I'm not
>> seeing?
> 
> I went back and forth on whether to do that or not. This case should
> basically never happen, so I like both the performance and readability
> of only triggering it when realloc() returns NULL. But it would get rid
> of the hand-waving above, and I doubt the performance is measurable.
> 
> If we do handle it up-front, then I think we'd actually want:
> 
>   if (!size) {
>           free(ptr);
> 	  return xmalloc(0);
>   }
> 
> (i.e., to never return NULL for consistency with xmalloc() and
> xcalloc()).

Good point. In that sense, your change makes a lot more
sense for staying consistent without strangeness like xmalloc(0).

>>> @@ -120,7 +120,7 @@ void *xrealloc(void *ptr, size_t size)
>>>  	memory_limit_check(size, 0);
>>>  	ret = realloc(ptr, size);
>>>  	if (!ret && !size)
>>> -		ret = realloc(ptr, 1);
>>> +		ret = realloc(ret, 1);
>>
>> I appreciate all the additional context for such a small change.
> 
> Somebody's got to complete with you for ratio of commit message to diff
> lines. :)

Pretty sure I have a long way to match, but it is important to
have goals.

-Stolee
