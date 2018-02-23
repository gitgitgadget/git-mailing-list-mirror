Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCAAB1F404
	for <e@80x24.org>; Fri, 23 Feb 2018 17:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751845AbeBWRxh (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 12:53:37 -0500
Received: from mail-qk0-f174.google.com ([209.85.220.174]:46053 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbeBWRxg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 12:53:36 -0500
Received: by mail-qk0-f174.google.com with SMTP id g2so11727800qkd.12
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 09:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=PU/6GHnxgT3OV+OXzb6Uk0q2ZOldkhuAfx6HghwKrHg=;
        b=DqziX2+SrBnbd/gMCAlR7BCmJmBibpur/cyiAo5D4HVs2IjlV/WsS9HPmx3G8bwJuc
         j/OtGL0iotPpYjh5HfYf9Kidx9hXXDNW123e/52BuTptFoLDuO7TAzY5r+j8TbEq7IyG
         oE5CudYGP1s/J2rYM4c0aAHQ3MaQ0+UrmviA9Av440vXa9LzRFzmysx/TZ20z+urVBf1
         I/VEUIIr0sTeMftOe5+vO/HYtnx3u6lpXS5dOXuJ1zi7aT2uB+/kxxNtS7zlI2D+lwSA
         7jWIsHsXgWprDPEi/V3GsWJobw5naLKKgWH6CxaWhSxVQmw/E1XVOBLcwdjcz4MpqVey
         VHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=PU/6GHnxgT3OV+OXzb6Uk0q2ZOldkhuAfx6HghwKrHg=;
        b=Ob404R7EQFlkQBHAI5JC3ssVQG4edumBLwgSnUrWSIRE2Da4Ok8k4jEciqjr55J8ka
         kLNsja4oXjhScWypXJmqOqNvGXxlkicwklTdbFetHx6oO/vcS08+MeQIiUM0flTCr3Hg
         ZXTAOgs/pdHbwLnLZPkJGSa33RPqSmOBFTwkugGEikNiKNXkvnX/+yUenwsNw8gIc68y
         InuPHVqKvVrT9Qlhc7m+1m9TMVb0TazK4DQiXbRF2bRJPwYj3L3PsBAHj/QFBKQNbRy/
         8oV8vKdjPOkRkHObUZDGDbuEsVP85nzEgCD99FJ4WMWnNCvrjE1VOIjGqp5oCIX8oVTC
         +Ygg==
X-Gm-Message-State: APf1xPAN/N930msGZsSAwUTqODtj9nsB1Ha9vaIK1Nm5LN3Mpyi1DJ/T
        x3xJhnK5qykp5fUxvzf27cUqm6uptf0=
X-Google-Smtp-Source: AG47ELtCuTeRxICvZyBERJZiZAO7ynxAeCHWQigrNzwH5Ovx6JMgELY4ZU3U/4Vcrct/4jVrWoJDhg==
X-Received: by 10.55.89.193 with SMTP id n184mr3714707qkb.270.1519408415461;
        Fri, 23 Feb 2018 09:53:35 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id 127sm1607465qko.7.2018.02.23.09.53.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Feb 2018 09:53:34 -0800 (PST)
Subject: Re: [PATCH v4 07/13] commit-graph: implement --set-latest
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, peff@peff.net,
        jonathantanmy@google.com, szeder.dev@gmail.com, sbeller@google.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
 <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
 <1519066406-81663-8-git-send-email-dstolee@microsoft.com>
 <xmqqk1v4x4dt.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e7ed962e-aa39-a8e7-2b24-a86dcd30dfa9@gmail.com>
Date:   Fri, 23 Feb 2018 12:53:32 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqk1v4x4dt.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/22/2018 1:31 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>
>>   static struct opts_commit_graph {
>>   	const char *obj_dir;
>>   	const char *graph_file;
>> +	int set_latest;
>>   } opts;
>> ...
>> @@ -89,6 +106,8 @@ static int graph_write(int argc, const char **argv)
>>   		{ OPTION_STRING, 'o', "object-dir", &opts.obj_dir,
>>   			N_("dir"),
>>   			N_("The object directory to store the graph") },
>> +		OPT_BOOL('u', "set-latest", &opts.set_latest,
>> +			N_("update graph-head to written graph file")),
>>   		OPT_END(),
>>   	};
>>   
>> @@ -102,6 +121,9 @@ static int graph_write(int argc, const char **argv)
>>   	graph_name = write_commit_graph(opts.obj_dir);
>>   
>>   	if (graph_name) {
>> +		if (opts.set_latest)
>> +			set_latest_file(opts.obj_dir, graph_name);
>> +
> This feels like a very strange API from potential caller's point of
> view.  Because you have to decide that you are going to mark it as
> the latest one upfront before actually writing the graph file, if
> you forget to pass --set-latest, you have to know how to manually
> mark the file as latest anyway.  I would understand if it were one
> of the following:
>
>   (1) whenever a new commit graph file is written in the
>       objects/info/ directory, always mark it as the latest (drop
>       --set-latest option altogether); or
>
>   (2) make set-latest command that takes a name of an existing graph
>       file in the objects/info/ directory, and sets the latest
>       pointer to point at it (make it separate from 'write' command).
>
> though.

Perhaps the 'write' subcommand should be replaced with 'replace' which 
does the following:

1. Write a new commit graph based on the starting commits (from all 
packs, from specified packs, from OIDs).
2. Update 'graph-latest' to point to that new file.
3. Delete all "expired" commit graph files.

(Hence, we would drop the "--set-latest" and "--delete-expired" options.)

Due to the concerns with concurrency, I really don't want to split these 
operations into independent processes that consumers need to call in 
series. Since this sequence of events is the only real interaction we 
expect (for now), this interface will simplify the design.

The biggest reason I didn't design it like this in the first place is 
that the behavior changes as the patch develops.

Thanks,
-Stolee
