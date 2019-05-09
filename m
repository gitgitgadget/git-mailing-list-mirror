Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7EA31F45F
	for <e@80x24.org>; Thu,  9 May 2019 12:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfEIMLp (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 08:11:45 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42622 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfEIMLp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 08:11:45 -0400
Received: by mail-qk1-f196.google.com with SMTP id d4so1248874qkc.9
        for <git@vger.kernel.org>; Thu, 09 May 2019 05:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C2S83Q5JqdcspSMELb8hx4rRAOh6lP+zXIycBlmGIFo=;
        b=bR51sHV3Po8jMhPY3Lmihy37hdZhNy9a3/aiWUzNKfFTtH320QtDT6enfh2kmwjbfk
         TQpJKdBfL0AiS8Tnl1y8cjpu8t0cW5BZgXRGmeCL+r/NdO5ubyVlWV4N4uZBkcrWmUOZ
         G7QNVRylmNshluNMcDhghatiDnU52lH8RNtMi6GV4x4eTaCoHUjWgXT0vyG5sRlwdx9b
         Bx1WU20fn+QE3/WG8oiiX6WrwcQ1EhNKcq8XX8K+Y7KcONG1x8qqn/17/ciRpY2NRE34
         qhLSvd0tIvJog8/l3KbQRaNxKZ7yt34yKH6YJmMOUjGCrEFlcQ+fyUxmO+UfZyQQwNos
         nbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C2S83Q5JqdcspSMELb8hx4rRAOh6lP+zXIycBlmGIFo=;
        b=AQ3AqngipqyNP13junT1g7UiYitdIIns1QVYkRicUlq+9aCfsHJYyxTD2km+i633nm
         6dj/ILnPcd6nrkVuTmyJ8eJkrs+kww9TKkrcOoySa5UmyRoraunIeH2VaTXaAabs20ou
         hsuc2NMeCYjlgQw02/e/IehzzSdQYN0n/BicE+nNZwdCkFCDNjtz0PXatvr51+xKl81J
         e4RZo/pR1WJI25PbIoVB91biLBFVileAxBwbm1Ce/3qQ98+WwADbrmcEOJm6lgvqvYyN
         76q/4BBy9aZHfvm36ayFYmzl7DJW4EArrxHBWQRu9c4FaoaYdvBPUCk81hUny88FBQ+M
         4knw==
X-Gm-Message-State: APjAAAVCx6KA0OZL4bxnU4P4VR2/GoIs9NWtNdDmf3evAb0LxnzBWXC8
        FaNvzCN+Kw9LFyUvTqIS4iPjtBcD7pg=
X-Google-Smtp-Source: APXvYqyTpzHnWknCK1giNz+VLGKqLx0ieQLJ0VzPe3p53V31zkzFt5K17nZaMuhLuY5AhHBFsY8MMQ==
X-Received: by 2002:a05:620a:16c3:: with SMTP id a3mr2946104qkn.222.1557403904314;
        Thu, 09 May 2019 05:11:44 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:d14c:17a3:d28e:9336? ([2001:4898:8010:0:ba82:17a3:d28e:9336])
        by smtp.gmail.com with ESMTPSA id o44sm1235710qto.36.2019.05.09.05.11.43
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 05:11:43 -0700 (PDT)
Subject: Re: [PATCH 01/19] revision.h: avoid bit fields in struct rev_info
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <20190508111249.15262-1-pclouds@gmail.com>
 <20190508111249.15262-2-pclouds@gmail.com>
 <0509589b-7a92-6c05-e404-65a9b2bf5666@gmail.com>
 <CACsJy8DEjBS-aiWqDe2AU56rJBVZ4Po6c-C7GxR4QDNiGSiZoQ@mail.gmail.com>
 <d018ea8c-6f7f-1587-d56b-af3225d6cf0b@gmail.com>
 <CACsJy8BR9XqEvQfnaBAjdgtp6J=FOhbUDpYCkMN4P4wOcw5Dmg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <554a318d-117a-b223-ee45-7cdcac2054f9@gmail.com>
Date:   Thu, 9 May 2019 08:11:43 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8BR9XqEvQfnaBAjdgtp6J=FOhbUDpYCkMN4P4wOcw5Dmg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/9/2019 5:56 AM, Duy Nguyen wrote:
> On Wed, May 8, 2019 at 10:52 PM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> The biggest issue with my suggestion is that it requires changing the
>> consumers of the options, as they would no longer live directly on the
>> rev_info struct. That would be a big change, even if it could be done
>> with string replacement.
> 
> I agree rev_info has grown "wild". It's quite ancient code. As you
> noted, it's a big change. And since my series is already long (76
> patches), I would rather focus on just one thing, rewriting the
> parsing code with minimum changes to anything else, preferably retain
> the exact same old behavior.
> 
> After that work is done (and no regression found), we could focus on
> reorganizing rev_info, which could be quite "interesting". Some fields
> may be overloaded with different purposes, which I just can't spend
> time investigating now. There's also the problem with freeing
> resources after rev-list is done, which I think we have ignored so
> far.

Thanks for humoring me. I agree with your reasoning.

This series looks good to me.

Thanks,
-Stolee

