Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB4591F404
	for <e@80x24.org>; Mon, 13 Aug 2018 20:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730130AbeHMWzA (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 18:55:00 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:46049 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbeHMWzA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 18:55:00 -0400
Received: by mail-qt0-f194.google.com with SMTP id y5-v6so18791875qti.12
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 13:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I4eNQvA6VEpTGe69ZPz8sIF5ggK0FnJUEHgcmmoZxB8=;
        b=I2id2tkiVhyFxobu5P1NvBE5MXJOqh7Jk6XPTo5f2X5cLaAubH9t/qlhwrAR+Ctgeh
         AyuzBqjG80t9qulQHd443wOcN53u8wtTSYUWUgthuU859OchCWlhN7zrlP/kVk99qwSd
         pYEex+8+HhY/q6ooVZhCfjiIOsre4pm3GnVuerB/GXmN1N94/G/+ual8h79sFARbmEdz
         fyzx3l5BZqQkzGkeBtGp5MK7unDW/uZ5Y7JmZcnLUNUbmN1g6HuyGKiCzE6WaCczX5dp
         3mi2gKRNK3I9a0zJ5HBizlI+HYZXeiN+L5Kp2ed6ZzJZxbnZ2IywiwBvRuWsCmoub+av
         UOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I4eNQvA6VEpTGe69ZPz8sIF5ggK0FnJUEHgcmmoZxB8=;
        b=tz7JnTETYc+khsKYyo9eL76yDezbhaeCPfO8zbec6HC7DTknuJXaICPYkYSE9mlvPX
         DRVicY59ZUWE/9fG7JLYcW9wXKzHlbBcu9Y7xTneqZxb88AbnjJS7D2WIvdoH//L+Jc4
         EW2qTgByjSrbPy0NHdRRpUpVPyJ8dfz0Zpf5eA7a2yFGsQDMERD8FM/5JoA3BPTqROuZ
         JvpIm5FHsDNHMnHp8r+RDf0jwZm7mEsWRGEk6vxEppstRD/paRY8EG2pSkrKPflF9agd
         1zImFZ+ktmLRezDLYRT8dVft5gloA7l9zj0+WWAwSuaCXNoqehUN0LboumZBL6TMTKJE
         yyhw==
X-Gm-Message-State: AOUpUlEvpUQ6KFeaagSBgWG7ni//g/FRiaDJ3Zl+MUlpUtWqbuVMGMkk
        zAxgrpO21hcQCL9bZCHWyJw=
X-Google-Smtp-Source: AA+uWPw6sF9lXo/Ea8f6Tb3m6qbw+T77wdmAg0wFVnjloHAqA1vkhLAswQWMLcNpLTGUZn4XzSXGrw==
X-Received: by 2002:aed:3763:: with SMTP id i90-v6mr18670121qtb.308.1534191075967;
        Mon, 13 Aug 2018 13:11:15 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id k5-v6sm8818037qkf.53.2018.08.13.13.11.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 13:11:15 -0700 (PDT)
Subject: Re: [PATCH v4 2/5] unpack-trees: add performance tracing
To:     Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>, jeffhost@microsoft.com
References: <20180804053723.4695-1-pclouds@gmail.com>
 <20180812081551.27927-1-pclouds@gmail.com>
 <20180812081551.27927-3-pclouds@gmail.com>
 <20180813192526.GC10013@sigill.intra.peff.net>
 <CAGZ79kYLpCZ=JNO7eun3mrhui+rymzr3i-VMLyFvKCxOaFNe-A@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <33dff7ef-e68b-91aa-22b8-e35947e4f7b8@gmail.com>
Date:   Mon, 13 Aug 2018 16:11:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGZ79kYLpCZ=JNO7eun3mrhui+rymzr3i-VMLyFvKCxOaFNe-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/13/2018 3:36 PM, Stefan Beller wrote:
> On Mon, Aug 13, 2018 at 12:25 PM Jeff King <peff@peff.net> wrote:
> 
>> I can buy the argument that it's nice to have some form of profiling
>> that works everywhere, even if it's lowest-common-denominator. I just
>> wonder if we could be investing effort into tooling around existing
>> solutions that will end up more powerful and flexible in the long run.
> 
> The issue AFAICT is that running perf is done by $YOU, the specialist,
> whereas the performance framework put into place here can be
> "turned on for the whole fleet" and the ability to collect data from
> non-specialists is there. (Note: At GitHub you do the serving side,
> whereas Google, MS also control the shipped binary on the client
> side; asking a random engineer to run perf on their Git thing only
> helps their special case and is unstructured; what helps is colorful
> dashboards aggregating all the results from all the people).
> 
> So it really is "works everywhere," but not as you envisioned
> (cross platform vs more machines) ;-)
> 

I currently use GIT_TRACE_PERFORMANCE primarily to communicate 
performance measurements on the mailing list.  While it is convenient 
occasionally to run with it turned on locally, primarily it gives me a 
common reference when communicating with others on the list about 
performance.

We have several excellent profiling tools available on Windows 
(perfview, VS, wpa, etc) so for any detailed investigations, I use 
those.  They obviously don't require any instrumenting in the code.

For our internal end user performance data, we'll use structured logging 
and our custom telemetry solution rather than the GIT_TRACE_PERFORMANCE 
mechanism.  We never ask end users to turn on GIT_TRACE_PERFORMANCE.  If 
we need more than what we can gather using telemetry, we ask them to 
capture a perfview along with other diagnostic data and send it to us 
for evaluation.

