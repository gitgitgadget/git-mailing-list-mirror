Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDC9D1F461
	for <e@80x24.org>; Thu, 29 Aug 2019 14:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfH2O1V (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 10:27:21 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45866 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfH2O1U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 10:27:20 -0400
Received: by mail-qt1-f195.google.com with SMTP id k13so3821007qtm.12
        for <git@vger.kernel.org>; Thu, 29 Aug 2019 07:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gYrQkLvjEB749w2yM+JysbLvEEp8mfVeB0qhh/RsyeM=;
        b=IxntHwBMfvWT//YPrF7HP0qEAiFYpTu4DsonXmKIS3SAaMGYNlcnBVjUUeNG3jqpVW
         e1TuYAueh/pgw9dFhf2KNcLqWxfl4rSvVVxGzytELv6o6SJQdsFhkuZlbDCPPFvmvM2f
         376v8+q+KcorgFDNUir0nwVtoXLlzSLEDYPdl4aUWEkvcJIcc8F6GtG/Lf0oUOttPLSc
         99opzqHKoJO6f+RjW+lqz0hgmDcbZx0mTIs3/wEgxJtHepTdwlx5EWE8KQwLKw74Tmpx
         PMvaemb84sMF/JBp24AQrhmEYCVtYPpHu2tjZcOxHwFfma7TMHLXZC3zPeQmq7M1/RqR
         s8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gYrQkLvjEB749w2yM+JysbLvEEp8mfVeB0qhh/RsyeM=;
        b=NDAUQOb+OH4B0GIPKjc+5/p7X3mwB88oxouhjVWoK1qvgrUMkM9bLcAew9EblBNzzh
         Ede3Db9P6mMIIOlemq4Xj0lj8V4qLna3tG85HIL/o+C2/caGiH14ZCBIuLOQW4T1tONV
         H4zRMHMqY7DX8stgWXCpdAy4DI2SYPD+x1/Etn+WQAADQgylPlzeOBo4Y8GRYQFlHZD+
         ybCcfAd0qKDQyn/SyWqYB6cuzYx/az4VZ1kTanygZbHmK/FjPjE57XA6CM6BHQliqyfg
         N9zBy+J+7n1+tKvv2359f+Dx1WlaQaJCf7HShzUdCdVK/1DJlSIP6kHubQFPV0YPraHs
         98nA==
X-Gm-Message-State: APjAAAXYCmTTI8vTniRgKC1YX6gDpFev6qkYH9ZmN0KJSs+OzxYoVjxz
        0oF/W8B2VBaw4m5nFpnhL0w=
X-Google-Smtp-Source: APXvYqysULd9yOI3zQ+WbMRfg+We0QwxBhynplwOwLUy8qRNkAkBOG/ZZ67mGwMnyMwWcbi/TsSvXg==
X-Received: by 2002:ac8:94a:: with SMTP id z10mr9067814qth.283.1567088839606;
        Thu, 29 Aug 2019 07:27:19 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:f9f6:adc0:ae8d:8f1f? ([2001:4898:a800:1012:ab2a:adc0:ae8d:8f1f])
        by smtp.gmail.com with ESMTPSA id n66sm1365499qkf.89.2019.08.29.07.27.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2019 07:27:19 -0700 (PDT)
Subject: Re: [PATCH 1/1] upload-pack: fix race condition in error messages
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.324.git.gitgitgadget@gmail.com>
 <5c313aba7e97cb93e7d07f6d5dfaf0febe8a2f8b.1566956608.git.gitgitgadget@gmail.com>
 <20190828093408.GD8571@szeder.dev>
 <20190828145412.GB14432@sigill.intra.peff.net>
 <20190828153944.GA29715@sigill.intra.peff.net>
 <20190828161552.GE8571@szeder.dev>
 <4d5773f9-4637-d8a3-d683-82624950f319@gmail.com>
 <20190829141307.GE1797@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <131dfa37-0f65-f0c3-6f30-5b6eca12d9c0@gmail.com>
Date:   Thu, 29 Aug 2019 10:27:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <20190829141307.GE1797@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/29/2019 10:13 AM, Jeff King wrote:
> On Thu, Aug 29, 2019 at 08:58:55AM -0400, Derrick Stolee wrote:
> 
>> However, I do have a theory: the process exits before flushing the
>> packet line. Adding this line before exit(1) should fix it:
>>
>> 	packet_writer_flush(writer);
>>
>> I can send this in a v2, but it would be nice if you could test this
>> in your environment that already demonstrated the failure.
> 
> I don't think we should need such a call. For one thing, if it were
> necessary, that would mean we're not writing out the packet at all. But
> your whole problem is that we're writing the message twice, one of which
> comes from the packet.

The problem the flush() was trying to solve was the new "Broken pipe" error,
which I had assumed was due to a communication race. (Looking at the message
more closely now, I see that Szeder was able to repro this broken pipe both
with and without my change. I am still unable to repro the broken pipe.)

> Second is that this is not "flush the output stream", but "write a flush
> packet". The packet_writer_error() function immediately calls write()
> without buffering. And no matter where we are in the conversation, a
> flush packet would not be necessary, because the error packet we send
> would be interpreted immediately by the client as aborting the
> connection.

This clearly shows that my proposed solution is absolutely wrong.

Thanks,
-Stolee

