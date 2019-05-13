Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E537D1F461
	for <e@80x24.org>; Mon, 13 May 2019 11:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbfEMLWw (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 07:22:52 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44105 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfEMLWw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 07:22:52 -0400
Received: by mail-qt1-f195.google.com with SMTP id f24so9764428qtk.11
        for <git@vger.kernel.org>; Mon, 13 May 2019 04:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UYiL0eixqcIFf6lUBLWUuHzVyb8Y3YKCmPGwJRW3/5c=;
        b=GamVt67w3xcUKzqz4KJvBsfXjtACIleRa5j3hVH6MGWcSFei+H06MUvZw1xEOTD3j+
         xAX55KhsmtHmnwwEbKGa+my4KQwBt79fvEPKeV7SEQMtngtL2fVrel6QI7MjvMDCEqGF
         O0Itxr8r365H7tDncOxaeYz/uBi6HuHBRnR7aQNIPmPk4HziWZ9VKpPMseXUqFJdP+XM
         Qxl0HMsB1RghTzhspTiaLxAuG1YB0QERsKX0PpFoNcb+arW73PXrDvoPry1buHbZDdqV
         if9J82EOVkQ8FycLeig0D6F6JtCIE+YnRv4l8J7Pt2o26MAIWQv7jvhpvk1SUVuRjYsF
         HlHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UYiL0eixqcIFf6lUBLWUuHzVyb8Y3YKCmPGwJRW3/5c=;
        b=i8kqQ5Fbab+AKCFNw9iYTuDBukoG9laqteEGq2J7gKRBSdg5o0yqmi2xLifYtxou4s
         URxyDT/Uz3f3eqHvpMEHLdMIpPqEvt2PC4QpiEVK2aVBWYZQ0gQQQkwKcwHPUtVwcdM5
         e0aAR5XYtkM8NjMbj8OhApVDXxmenZRhBO+C+2mSR3ewPwWFXieqwSdQDuZ27uHJug6J
         eWVgGCY2Rulgb1SZeRuet4HeV+X0Yp76zcZr5nwt8niyomEhj1p2L3B1fRIgaKnlSjg0
         AjEfKyrrdyPZvhoR9ZhG2NXEOdc/5aEnFX4+7BACsfEPfuDVSRrV80iDr78q0Y8sfiJB
         SBnA==
X-Gm-Message-State: APjAAAX0QomgH2Qo/t4o0a0VeIgOsATgwPjE9iJDQ2DdI5S0DHwICMAm
        f8REnp+HHEOndX/o1g54W1Q=
X-Google-Smtp-Source: APXvYqw5KQRjkwDh9ov972bqShI+kZzmVkvNq3iIM3AV/gghAJlEj7/ojjnny3Y2MCas7cEP3KBsPw==
X-Received: by 2002:a0c:ae5a:: with SMTP id z26mr21793909qvc.110.1557746571008;
        Mon, 13 May 2019 04:22:51 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:3130:3ffc:dbb9:1565? ([2001:4898:8010:2:1a64:3ffc:dbb9:1565])
        by smtp.gmail.com with ESMTPSA id t10sm8017378qti.83.2019.05.13.04.22.49
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 04:22:50 -0700 (PDT)
Subject: Re: [PATCH v4 02/11] commit-graph: return with errors during write
From:   Derrick Stolee <stolee@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        avarab@gmail.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.112.v3.git.gitgitgadget@gmail.com>
 <pull.112.v4.git.gitgitgadget@gmail.com>
 <a4082b827eb1999f6e46780b4147962d6dd87975.1557411749.git.gitgitgadget@gmail.com>
 <xmqq36ljdp2s.fsf@gitster-ct.c.googlers.com>
 <17829620-1084-74e5-54ad-aa95990f4dbd@gmail.com>
Message-ID: <aa78b56d-bf88-3a04-63f5-b1cfa2c6da82@gmail.com>
Date:   Mon, 13 May 2019 07:22:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <17829620-1084-74e5-54ad-aa95990f4dbd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/13/2019 7:04 AM, Derrick Stolee wrote:
> On 5/12/2019 11:13 PM, Junio C Hamano wrote:
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
>>> @@ -188,14 +187,14 @@ static int graph_write(int argc, const char **argv)
>>>  		UNLEAK(buf);
>>>  	}
>>>  
>>> -	write_commit_graph(opts.obj_dir,
>>> -			   pack_indexes,
>>> -			   commit_hex,
>>> -			   opts.append,
>>> -			   1);
>>> +	result = write_commit_graph(opts.obj_dir,
>>> +				    pack_indexes,
>>> +				    commit_hex,
>>> +				    opts.append,
>>> +				    1);
>>>  
>>>  	UNLEAK(lines);
>>> -	return 0;
>>> +	return result;
>>>  }
>>
>> What were the error values this function used to return?  I am
>> wondering if the callers of this function are prepraed to see the
>> returned values from write_commit_graph() this function stores in
>> 'result' (which presumably are small negative value like our usual
>> internal API convention)?
> 
> The only caller is cmd_commit_graph() and it is in this snippet:
> 
>         if (argc > 0) {
>                 if (!strcmp(argv[0], "read"))
>                         return graph_read(argc, argv);
>                 if (!strcmp(argv[0], "verify"))
>                         return graph_verify(argc, argv);
>                 if (!strcmp(argv[0], "write"))
>                         return graph_write(argc, argv);
>         }
> 
> So these return values are passed directly to the result of the
> builtin. If that is against convention (passing an error code from
> the library to the result of the builtin) then I can modify.

And I see from your other feedback (upon re-reading) that you prefer
translating a negative error value from the library into a "1" here
for the builtin.

As I prepare my next version, I'll have write_commit_graph() return -1
for all errors and have graph_write() translate that to a 1. But I'll
wait to see if you want more specific error codes from write_commit_graph().

-Stolee

