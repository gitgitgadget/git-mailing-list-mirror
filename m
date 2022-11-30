Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9425C352A1
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 10:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235584AbiK3K0P (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 05:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiK3K0O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 05:26:14 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28588131
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 02:26:13 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 2-20020a1c0202000000b003d0760654d3so449473wmc.4
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 02:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Id6QEwgeDKEkI0buAwumvN19Q9b6KebDNxMTc8ZdHFc=;
        b=UXw1yaxDLV8aOb3Po8kbVtnVEbffr9//04eGgIoR6EjhP83ZMHqz10hXP4TRWu6Kk0
         yKL3r7VdLLbLPlDQSTtQL7rMfAqpufKkDQ2NVHP2JEsI8vHC96Ft/n8pewvql3OFdhY6
         HSL13/D36twwRMJfp9wTAa3rh0Pw1+h48JCwo2gD1Jr1wDQKP2c1ESNCKjhUYGd+KPjy
         x9oFaHk9dg9BUyud/06To250MgQJDAAZVkwtBCCQwGN+yQboBtcnupYN5YpuNc9QM19J
         iuYXePhp1uE29cf1Vj+ztEZpGUtbJYdQPtVIXIm+nKr1gB+zQUzF0hXqiIG7ns89Alu6
         0PqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Id6QEwgeDKEkI0buAwumvN19Q9b6KebDNxMTc8ZdHFc=;
        b=2E3G9Ig06UEgcvJ9GIhiAv50f93Zr+QsceV0KNVEjDdU+GSKqtQGZ40DHRSgoeksRw
         VdDGeRSkjGqUg8dD79bp5GtvI0Holw+Nk0JJztDD+4XrBhxNyLk2aZsolIxYO/phCQin
         LUYNpUgoy6IYz/lmivFqu6mhQG72lCpVtzuke6Oj8zp8PvC50f0akQi9pXI6usa8Buy4
         7tQrFMRXDdRVkprVwOxTCkFDUE9gcpMXrMpSU3aojQB4mgCqFZp3hxs4rRJr1YpaU78n
         4P4Jm+kzQF+fnjtmqQEbXnrt3nqVjGeYtFApwB+Bo7byWE2HrZFZSmVn5SH+SEcK5/Iu
         ZMvg==
X-Gm-Message-State: ANoB5pkZ6c4jH57JfpOm4KjyC/VCrGZM3Zt/Nwmm1BXK4chgRcjklwa1
        qTkyhsXLqq3nBB3+AvmD8pg=
X-Google-Smtp-Source: AA0mqf4axsT/WhnpXhE/vNVcztg18BfAJQEOTudQe99rrdloA3iy61rBWidRKyunTWZy2Bi85Y1+Kg==
X-Received: by 2002:a05:600c:5388:b0:3cf:37b1:e581 with SMTP id hg8-20020a05600c538800b003cf37b1e581mr42770956wmb.96.1669803971662;
        Wed, 30 Nov 2022 02:26:11 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id v5-20020adfebc5000000b00241c6729c2bsm1147802wrn.26.2022.11.30.02.26.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 02:26:11 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <778b25b4-8eb2-6d02-3ba5-a21724ff2f2f@dunelm.org.uk>
Date:   Wed, 30 Nov 2022 10:26:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 1/5] run-command: add duplicate_output_fn to
 run_processes_parallel_opts
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
        emilyshaffer@google.com, phillip.wood123@gmail.com,
        myriamanis@google.com
References: <https://lore.kernel.org/git/20221020232532.1128326-1-calvinwan@google.com/>
 <20221108184200.2813458-2-calvinwan@google.com>
 <kl6lo7spqqzg.fsf@chooglen-macbookpro.roam.corp.google.com>
 <221130.86lensiwy0.gmgdl@evledraar.gmail.com>
In-Reply-To: <221130.86lensiwy0.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30/11/2022 09:53, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Nov 29 2022, Glen Choo wrote:
> 
>> Calvin Wan <calvinwan@google.com> writes:
>>
>>> @@ -1680,8 +1683,14 @@ static void pp_buffer_stderr(struct parallel_processes *pp,
>>>   	for (size_t i = 0; i < opts->processes; i++) {
>>>   		if (pp->children[i].state == GIT_CP_WORKING &&
>>>   		    pp->pfd[i].revents & (POLLIN | POLLHUP)) {
>>> -			int n = strbuf_read_once(&pp->children[i].err,
>>> -						 pp->children[i].process.err, 0);
>>> +			struct strbuf buf = STRBUF_INIT;
>>> +			int n = strbuf_read_once(&buf, pp->children[i].process.err, 0);
>>> +			strbuf_addbuf(&pp->children[i].err, &buf);
>>> +			if (opts->duplicate_output)

Shouldn't we be checking if n < 0 before we do this?

>>> +				opts->duplicate_output(&buf, &pp->children[i].err,
>>> +					  opts->data,
>>> +					  pp->children[i].data);
>>> +			strbuf_release(&buf);
>>>   			if (n == 0) {
>>>   				close(pp->children[i].process.err);
>>>   				pp->children[i].state = GIT_CP_WAIT_CLEANUP;
>>
>> A common pattern is that optional behavior does not impose additional
>> costs on the non-optional part. Here, we unconditionally do a
>> strbuf_addbuf() even though we don't use the result in the "else" case.
>>
>> So this might be more idiomatically written as:
>>
>>          int n = strbuf_read_once(&pp->children[i].err,
>>          			 pp->children[i].process.err, 0);
>>   +      if (opts->duplicate_output) {
>>   +          struct strbuf buf = STRBUF_INIT;
>>   +          strbuf_addbuf(&buf, &pp->children[i].err);
>>   +        	opts->duplicate_output(&buf, &pp->children[i].err,
>>   +        		  opts->data,
>>   +        		  pp->children[i].data);
>>   +          strbuf_release(&buf);
>>   +      }
>>
> [...]
> And why does "&buf" exist at all? 

I was wondering that as too

>Why can't we just pass
> &pp->children[i].err, and if this callback cares about the last thing we
> read let's pass it an offset, so it can know what came from the
> strbuf_read_once() (I don't know if it actually cares about that
> either...).

Or we could just pass a `const char*`, `size_t` pair.

> That would avoid the copy entirely.

Is the copying quadratic at the moment? - it looks like each call to 
strbuf_read_once() appends to the buffer and we copy the whole buffer 
each time.

Best Wishes

Phillip
