Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4413C1F404
	for <e@80x24.org>; Fri, 23 Feb 2018 19:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754727AbeBWTlU (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 14:41:20 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:42326 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754194AbeBWTlE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 14:41:04 -0500
Received: by mail-qt0-f194.google.com with SMTP id t6so2411221qtn.9
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 11:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=tn3H9uIl83PF+LwHGXnz9P6/SYuTXhMjbMk+Fd3FMGQ=;
        b=t3OsfgHqVGuYs79g3f1RPnXzT+DZdIjuOAJX/SwY33l8r8PyF2c7RU3EfDOPXDWSNR
         1EiNGfDclHb7XU4gWpQTbdFSMfxzlms5eyhrgr8A+fmRSAvpcakPw0vnl5N7c/XLzpid
         BLP5D4SP9g+KHYw7h77cRbP6tH8iNCog0p2FDWAOKjSUDziyV5O4XIuFs+LtSzzLu0DX
         1RrpAYL65zq21fmZ/2VcX8I8h23I0pzXDsXj2uTWPJTfZx8NkFzDOizQznzxV8jEL+37
         zWfVdjdVsXx8zvOZ1J83tSybbhgHdVTyIbs7R8ZqM8Orbavam94IcbSsytXw8f+ohW5k
         NNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=tn3H9uIl83PF+LwHGXnz9P6/SYuTXhMjbMk+Fd3FMGQ=;
        b=RYBdqQIwc64qGRvAJl0fK9s9VOrrHORjgRU3GYwLf736AOTKjK4aLiysQSoxB/r9o/
         0AbTkOaMooVVmo3nqyeNUNao+PqAiTQbLeMUpTdOr/gjBDzGDrghEwVTS1e7AE3dvG+V
         rIfXD3DbZN7q0q8dglXeagcFhMXuRO366WhI2fNRgfeCyC8hHQVL56YAq398ALssLK2w
         S3YwkvL9Ny56mvtGvOWu2i8yAKuwT6R9Y53eEEZzcnZeuhOyyDWUavqoDOHuMCeRuYLB
         6AbI8YiuuNtWng/XskAs40jzc6Zu40UvUMm7EzdXjdJfRcRB/o8OzJPYnfyBrR/32V+L
         gfMQ==
X-Gm-Message-State: APf1xPBPeobivTXg+RmI34REUGv+tyJmkKrkKa9URSVD2MzmkNZtiPGA
        7ra9xNSqZGz4xxTUVuNhCLw=
X-Google-Smtp-Source: AG47ELtr50V/+OCTi5Efpw4HROr0kwIQOdw8x+bU1Hst3AwcN9Cz8aZVINWOyO+QXEI1e9ArcOyhng==
X-Received: by 10.200.25.60 with SMTP id t57mr4552824qtj.81.1519414863488;
        Fri, 23 Feb 2018 11:41:03 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id w56sm2190672qta.65.2018.02.23.11.41.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Feb 2018 11:41:03 -0800 (PST)
Subject: Re: [PATCH v4 08/13] commit-graph: implement --delete-expired
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, peff@peff.net,
        jonathantanmy@google.com, szeder.dev@gmail.com, sbeller@google.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
 <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
 <1519066406-81663-9-git-send-email-dstolee@microsoft.com>
 <xmqqfu5sx3md.fsf@gitster-ct.c.googlers.com>
 <67871288-ea70-69d4-9c3d-5cc946d8dbe2@gmail.com>
 <xmqqo9kftsa5.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8c958ada-b96b-cdc7-594c-c6f6cdb02b70@gmail.com>
Date:   Fri, 23 Feb 2018 14:41:01 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqo9kftsa5.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/23/2018 2:33 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>
>> The (unlikely, but possible) race condition involves two processes (P1
>> and P2):
>>
>> 1. P1 reads from graph-latest to see commit graph file F1.
>> 2. P2 updates graph-latest to point to F2 and deletes F1.
>> 3. P1 tries to read F1 and fails.
>>
>> I could explicitly mention this condition in the message, or we can
>> just let P2 fail by deleting all files other than the one referenced
>> by 'graph-latest'. Thoughts?
> The established way we do this is not to have -latest pointer, I
> would think, and instead, make -latest be the actual thing.  That is
> how $GIT_DIR/index is updated, for example, by first writing into a
> temporary file and then moving it to the final destination.  Is
> there a reason why the same pattern cannot be used?

My thought was that using a fixed name (e.g. 
.git/objects/info/commit-graph) would block making the graph 
incremental. Upon thinking again, this is not the case. That feature 
could be designed with a fixed name for the small, frequently-updated 
file and use .../info/graph-<hash>.graph names for the "base" graph files.

I'll spend some time thinking about the ramifications of this fixed-name 
concept. At the moment, it would remove two commits from this patch 
series, which is nice.

Thanks,
-Stolee
