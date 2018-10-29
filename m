Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 809921F453
	for <e@80x24.org>; Mon, 29 Oct 2018 18:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbeJ3Czr (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 22:55:47 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35313 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbeJ3Czr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 22:55:47 -0400
Received: by mail-qt1-f193.google.com with SMTP id a10-v6so10349109qtp.2
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 11:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S7SI24Bs36t0TkaS7q4zylsE0J6JSNA/Z/gB/qTx6Jk=;
        b=knYb/pMRgPJZps9suzYa4PO6KPIpI9V26zoHO2tm2n4DSXKCbikiROFXwtN3Ag1kPT
         ++yzu165iRj0JiVSo3nqeXdp9P5BQQsr2jae8XGB3F6KFXQkvrEewRnNKVUmm+Bt880A
         Ej0lCOsEgLpUFAyc77eebBEcQ/pXuF0DmFMRo/+AyiyxHPjEPknJVi1giStewZnVPJje
         r35Dlna4pUbnwgPmLrb8DdA5nH9J2skvGd5f0iZ7jrzcJgD2f14frNAYW4Sbvh9kGZe4
         SRZuHF75wGhj4kV0juJPNh7wIFKSS2sEksnP8+nAorCy8Vcg3Ic+0PinyrVqpyaDjE0L
         XrVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S7SI24Bs36t0TkaS7q4zylsE0J6JSNA/Z/gB/qTx6Jk=;
        b=BifiyG5OUYo0IiToqMUANse8QM4T3xW4ZaOGK0Pm2IA9843qI+o/O/LE9H/b0AreV/
         TV5Ja27JX+qr9hiRFFInE0BL7QbrOZtt/xDpsSD+p8iF6bOlsiBZ2nsC6ikpI8ST/IDd
         5ZsIZjV7vCu4Irdn3GHL/mfZt2OFD4s+PqZrokFlQ2IpzEdkVsB3SQSZHQOrQOYiJ7uo
         wsPSzZMQ8fbS4CO5dBZ7f0O8tKxwTU34Q7vlyHv9OiTq2jQmHz98LkKDpq4fAZUUvZr5
         qHntVGrRWW+LtnSMQUqa04wTURNCNEw4yLDYBvO/fzjVWH875mYkeEfzYiTL//LC8k8J
         oWLA==
X-Gm-Message-State: AGRZ1gLRKc3FW6MHK8KHugUDEtzX1ZJkJBwzTeVzkwXo5MXhx842wcMC
        aIUh+t28Lja5s4NEaa/bbLg=
X-Google-Smtp-Source: AJdET5canrXZwwfP2nXpkI2aoNcVOEaNAjmGQ5W0+fk6iZlRlGl1+zipRB5tg6OrpuftLXlpeJf2nQ==
X-Received: by 2002:ac8:468d:: with SMTP id g13-v6mr8387341qto.146.1540836363239;
        Mon, 29 Oct 2018 11:06:03 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id l36-v6sm6372959qtc.80.2018.10.29.11.06.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 11:06:02 -0700 (PDT)
Subject: Re: [PATCH v2 06/10] preload-index.c: remove #ifdef NO_PTHREADS
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <20181027071003.1347-1-pclouds@gmail.com>
 <20181027173008.18852-1-pclouds@gmail.com>
 <20181027173008.18852-7-pclouds@gmail.com>
 <0ee246db-d781-9a42-8b8c-3e98c132b0ae@gmail.com>
 <CACsJy8CYnngeA8JcFy83qYxKj3saB21Y32VV3R5o1PY_tkAq5Q@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <2935e3e8-c529-4292-baa3-fc3c9074028b@gmail.com>
Date:   Mon, 29 Oct 2018 14:05:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8CYnngeA8JcFy83qYxKj3saB21Y32VV3R5o1PY_tkAq5Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/29/2018 1:26 PM, Duy Nguyen wrote:
> On Mon, Oct 29, 2018 at 6:21 PM Ben Peart <peartben@gmail.com> wrote:
>> @@ -114,6 +104,9 @@ static void preload_index(struct index_state *index,
>>           threads = index->cache_nr / THREAD_COST;
>>           if ((index->cache_nr > 1) && (threads < 2) &&
>> git_env_bool("GIT_TEST_PRELOAD_INDEX", 0))
>>                   threads = 2;
>> +       cpus = online_cpus();
>> +       if (threads > cpus)
>> +               threads = cpus;
>>           if (threads < 2)
>>                   return;
>>           trace_performance_enter();
> 
> Capping the number of threads to online_cpus() does not always make
> sense. In this case (or at least the original use case where we stat()
> over nfs) we want to issue as many requests to nfs server as possible
> to reduce latency and it has nothing to do with how many cores we
> have. Using more threads than cores might make sense since threads are
> blocked by nfs client, but we still want to send more to the server.
> 

That makes sense.  Some test will be necessary then.

I guess HAVE_THREADS is functionally the same as online_cpus() == 1. 
For some reason, I prefer the latter - probably because I'm typically 
already calling it and so it doesn't feel like a 'special' value/test I 
have to remember. I just know I need to make sure the logic works 
correctly with any number of cps greater than zero. :-)
