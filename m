Return-Path: <SRS0=wu5b=B6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDBDC433DF
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 12:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EC5E207BB
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 12:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="budRlxcC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbgHTMMt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbgHTMMH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Aug 2020 08:12:07 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC15C061385
        for <git@vger.kernel.org>; Thu, 20 Aug 2020 05:12:07 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id m7so1250579qki.12
        for <git@vger.kernel.org>; Thu, 20 Aug 2020 05:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Nf1aiQbdoeLdBBg9WvUpxiscYu1OBs/TpFK5iU2EFDU=;
        b=budRlxcC+1s+pzI5nNnGMY3aPt0Aac9rc+AvB8No9OBT+BPBzsY1zjwBu5ONSol43X
         7T99AGTpo2DBiRH5PNbwCOBFPUA+ZhJXE12RkTyX6sp5IUIE1CSieQPaXz9EldhRZu49
         h4zxh7F4yQ+qftAwMJ4EMoD/1119vRUU/xLJ1dGn2cm6NMboUsEWp8Q8z5Z/zoJEDzrN
         or6labKPZY4XUe/9bf714YCEnjYJwgRFFwptz+1CW+70DKRcJweUCwe3KzZCvi2v45Vs
         rMfB1Up3F7d96+wepsjkd1A4PWYqt17Dc3KR6pZznPn86AES9AC9//HnyGc9wFol1uG1
         R92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nf1aiQbdoeLdBBg9WvUpxiscYu1OBs/TpFK5iU2EFDU=;
        b=GHygbjdy3lvXr5X5IjE4BILzo+f8qwLTwJ0El+oh5W8CnGQ6oqPPMw54BHgdwmDy5v
         31CqOgZyh5X8gBtZjyDZB4OvoGopEqWVRSN6P8ZbN6xnMtlSAJYCHS3bfmpR8mZVnH0q
         0ajlAEDqxPBKNJYLpzZ8BlqqHh2BdNxlaaji2uZzqHeCzrHrJNNltnrTDJa8pNp+7C8H
         5Fx3Rp58/drQospddykVId1u21E8agKuSMyjLqAMkPiDij65ULxZ6ZS4+RYNUwKIHheM
         OOrtd1vKKP/NpF9S7cfjB0WDpABXsUmxhIP6UD01AMnVdmPPf2j3P6jqA6ntxTeQWMzv
         5L5A==
X-Gm-Message-State: AOAM531L++SsRQ0ZPd75djOHcAgC1+oraTk6rsx2SgjswN9o21d9bOs5
        ONqg4v7HQoMsq5OudYve8qE=
X-Google-Smtp-Source: ABdhPJwA20dUPRauYvb7dst8znNgIBvaWGgqRNHQQj0oZOvJX/Mj2OI4x1JsCzyf1biDqMPeOI6GJg==
X-Received: by 2002:a37:4e4d:: with SMTP id c74mr2249939qkb.311.1597925526343;
        Thu, 20 Aug 2020 05:12:06 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:e89e:557a:c4eb:6aef? ([2600:1700:e72:80a0:e89e:557a:c4eb:6aef])
        by smtp.gmail.com with ESMTPSA id f7sm2117992qkj.32.2020.08.20.05.12.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 05:12:05 -0700 (PDT)
Subject: Re: [PATCH 1/7] maintenance: optionally skip --auto process
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.680.git.1597857408.gitgitgadget@gmail.com>
 <90de25d1287595fdedc9dcd194a2e0ac120d4aad.1597857409.git.gitgitgadget@gmail.com>
 <20200820020658.GA31084@danh.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <629e3f77-a80f-2014-1756-dec8d8647326@gmail.com>
Date:   Thu, 20 Aug 2020 08:12:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <20200820020658.GA31084@danh.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/19/2020 10:06 PM, Đoàn Trần Công Danh wrote:
> On 2020-08-19 17:16:42+0000, Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com> wrote:
>> From: Derrick Stolee <dstolee@microsoft.com>
>> @@ -1868,8 +1869,15 @@ int run_processes_parallel_tr2(int n, get_next_task_fn get_next_task,
>>  
>>  int run_auto_maintenance(int quiet)
>>  {
>> +	int enabled;
>>  	struct child_process maint = CHILD_PROCESS_INIT;
>>  
>> +	if (!git_config_get_bool("maintenance.auto", &enabled) &&
>> +	    !enabled) {
>> +		    fprintf(stderr, "enabled: %d\n", enabled);
>> +		return 0;
>> +	    }
> 
> Nit: This block of code is mis-indented (mixed space and tab).

Thanks.
 
> If we're running into inner block, "enabled" will always be "0"
> We can just write:
> 
> 	fprintf(stderr, "enabled: 0\n");
> 
> instead. Writing like that, we have one less thing to worry about
> (whether "enabled" is initialised in git_config_get_bool or not).

Whoops! This fprintf shouldn't even be here, but got accidentally
added during a debugging session. Thanks for noticing!

-Stolee

