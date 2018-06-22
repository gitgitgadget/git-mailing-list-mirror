Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF4B11F516
	for <e@80x24.org>; Fri, 22 Jun 2018 18:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934048AbeFVSj1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 14:39:27 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:39946 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933820AbeFVSj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 14:39:26 -0400
Received: by mail-qt0-f196.google.com with SMTP id j20-v6so177446qtn.7
        for <git@vger.kernel.org>; Fri, 22 Jun 2018 11:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=tO9uKKUBEbPUxLMsi5ssgaiI1lksGzagSDZchZlG/pE=;
        b=qxmYrlhskKNmfk/vwaJjhlHQQkesViIwlUL2UgLXLj8DGIQC3zOsfq3pJKoF7JJHWL
         4Wc+D6Ra+y8N30au7KWyz+7UhR7oEeU2VpBaeiKREdJAjIVsez3c6uvJghDl/gVlWinD
         U1ptt1mOYBGaYU+OcgoTosDw8+iMT3SQtinsXH4+RG6ZIxxJuswY0SH/5D9PwZ/YzgFC
         jJmMsDUMdCYwlcykDG8GtlcEhTJKltPuKvosOFZ7wn5dOsMGVD1Lix874SDgUotd32UZ
         3lbcoIuS3+dGoOfaEpR535/LiCkQGHsw179cG1O3io6+FUhhoAKv8ppmpPNQ7611t2iB
         GLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=tO9uKKUBEbPUxLMsi5ssgaiI1lksGzagSDZchZlG/pE=;
        b=qWI7TsmdiKCxB2S+f3lzdmivIlfwoB+naXG1AtYDJlIuyUWMKkG9l6LJk8tehgjeSm
         8EkgywwlVitAt5qfuFfQIKCUYpJoyxf5zZLIyGEub2lCB+9wJ2XnqCLkwabsyMZCUD8l
         WWbo5nVuOuyksPjwx/y1lxFpWCGaxUXqqfmQ4Q3CI/U9QtmEyddncpGllXZHeNXTNJLs
         k9g14LMcaKr7tIiMbLyp4wgClZ/utyKsH4XpsXFfZ9q9wm12NE8YpyHv+y2l0Li7H3+D
         F6Fuv/AOL3DKnQ1NsdEcIFLsue1p+fF3PXjGB9Wzk13f5HlpQjsty6YOS6pUmX3fSmg8
         2qQg==
X-Gm-Message-State: APt69E0/XmfH+ddYm6rp0kK5vP0nu5BA8YFxJyH8FnyfUYxtxJCGJ7Qf
        qjubEfNF3QG21m8Tq4kuw5c=
X-Google-Smtp-Source: ADUXVKJGCBZSqlsiIjfnLQjPzcVEPzlcBj7vgegkH0AQ1fArcDKyZEktWbciUMJzReZVnqPFrVpoyg==
X-Received: by 2002:ac8:2cb5:: with SMTP id 50-v6mr2523963qtw.64.1529692765499;
        Fri, 22 Jun 2018 11:39:25 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:355a:cab3:6059:73ce? ([2001:4898:8010:0:1e90:cab3:6059:73ce])
        by smtp.gmail.com with ESMTPSA id h43-v6sm6718404qth.6.2018.06.22.11.39.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 11:39:24 -0700 (PDT)
Subject: Re: [PATCH 20/23] midx: use midx in approximate_object_count
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Martin Fick <mfick@codeaurora.org>
References: <20180607140338.32440-1-dstolee@microsoft.com>
 <20180607140338.32440-21-dstolee@microsoft.com>
 <CACsJy8AtkVwGw0+tgpv2AzNZMHGTOfkjHUN-37owaRWuQ_2wKw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <466e191e-6e0c-692c-ff8c-b847f3c4823a@gmail.com>
Date:   Fri, 22 Jun 2018 14:39:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8AtkVwGw0+tgpv2AzNZMHGTOfkjHUN-37owaRWuQ_2wKw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/9/2018 2:03 PM, Duy Nguyen wrote:
> On Thu, Jun 7, 2018 at 4:06 PM Derrick Stolee <stolee@gmail.com> wrote:
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>   packfile.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/packfile.c b/packfile.c
>> index 638e113972..059b2aa097 100644
>> --- a/packfile.c
>> +++ b/packfile.c
>> @@ -819,11 +819,14 @@ unsigned long approximate_object_count(void)
>>   {
>>          if (!the_repository->objects->approximate_object_count_valid) {
>>                  unsigned long count;
>> +               struct midxed_git *m;
>>                  struct packed_git *p;
>>
>>                  prepare_packed_git(the_repository);
>>                  count = 0;
>> -               for (p = the_repository->objects->packed_git; p; p = p->next) {
>> +               for (m = get_midxed_git(the_repository); m; m = m->next)
>> +                       count += m->num_objects;
>> +               for (p = get_packed_git(the_repository); p; p = p->next) {
> Please don't change this line, it's not related to this patch.

Sure. I'll revert that line.

>   Same
> concern applies, if we have already counted objects in midx we should
> ignore packs that belong to it or we double count.

Since we do not put packfiles into the packed_git list if they are 
tracked by the midx, we will not double count.

>
>>                          if (open_pack_index(p))
>>                                  continue;
>>                          count += p->num_objects;
>> --
>> 2.18.0.rc1
>>
>

