Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C5FC4332F
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 16:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiJNQVO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 12:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiJNQVN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 12:21:13 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920D518B765
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 09:21:09 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id l127so4259292iof.12
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 09:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yMCOUOI0iIXp585mO87Rqk34aF3vZusu7R3O/6c0LUg=;
        b=dGSElMrHWCUcv1g8+zgowkf/F5tlrJDqn0LrBV2t6dtawtFgfEQaGuAe0ZI8ej/2Gz
         S14WXRf+lq7CnJFoJ0xMRNEzSzNi9rmdBRDNG2W7N4I6UM6rvhxsVgw3v6WEqK+k2eJm
         vPLdA0+uvvA8JG80twXVf1ldTvCyGW8P7kJz76UGnlLTsogPpy/reOMJch3ZKg4ra3zp
         wmM98ci0PztkB60N9d+vHCvXHUIExabt7j19tWzCwhK2nCsB0TYFmlVe8GnY8meFw/ws
         4MsTk6w6jD4muUREe9DNcI9EvIhZEF0GCpdzEeQz3QHM5By1iHGIejfwB16rpB5WPQ8z
         fFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yMCOUOI0iIXp585mO87Rqk34aF3vZusu7R3O/6c0LUg=;
        b=MQjhmw112gYiwMXGLtB0N2FdnE53jmLBPqQI4tAI/5ggWmRu0DEGXHgFsxTtsbv/D5
         mcezmz2NTwxTGKAlz++Grsh3stJGuVnivSNNFCB3QbV37Wt8bOB5kpyGcjvez3Xo7dRE
         pHqJJjd620mQPQgC9X5DH8MMR4mYz8EP1nDEsiF1MaPArgtS6eFc6MvH2rivtvIXVKqB
         30bu3fdJ7x53bg8ubqD5SI1Y25fZ+gw7LhNMINntbcw4BBkKCKgMBGi0bdol7KB82qRI
         zxtMRIjBzgETfzDHrcPkwJLJhu3SWN3jkQaUPpKDIqROQ4I8d+I2PJLN0JE3uz6Vbk1r
         ZeDg==
X-Gm-Message-State: ACrzQf3+plCxONLecOA1y0vMcKdMmqFK+oLng9pkgOX2KiR5nMTQpD1T
        50N52mWLSElBL27k9P5D5NtA
X-Google-Smtp-Source: AMsMyM63rHwg8tpJ0gPcdyIFXMXJrkxCp+Y3iWOAFbN0Hu4ZB6u57SeULFl8Qbfy8fvaWSALoY0CRw==
X-Received: by 2002:a05:6602:125d:b0:6bc:61ec:29c0 with SMTP id o29-20020a056602125d00b006bc61ec29c0mr2615006iou.81.1665764468303;
        Fri, 14 Oct 2022 09:21:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:8c47:21b5:c860:3399? ([2600:1700:e72:80a0:8c47:21b5:c860:3399])
        by smtp.gmail.com with ESMTPSA id d31-20020a0285a2000000b00363cb638bffsm1255467jai.179.2022.10.14.09.21.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 09:21:07 -0700 (PDT)
Message-ID: <f064ce46-8ed0-a9c1-8df5-5c258677d95f@github.com>
Date:   Fri, 14 Oct 2022 12:21:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3] [OUTREACHY] t1002: modernize outdated conditional
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        nsengaw4c via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, nsengaw4c <nsengiyumvawilberforce@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
References: <pull.1362.v2.git.git.1665733647421.gitgitgadget@gmail.com>
 <pull.1362.v3.git.git.1665734502591.gitgitgadget@gmail.com>
 <xmqqv8om9yaz.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqv8om9yaz.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/14/2022 12:15 PM, Junio C Hamano wrote:
> "nsengaw4c via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Nsengiyumva Wilberforce <nsengiyumvawilberforce@gmail.com>
>>
>> Tests in this script use an unusual and hard to reason about
>> conditional construct
>>
>>     if expression; then false; else :; fi
>>
>> Change them to use more idiomatic construct:
>>
>>     ! expression
>>
>> Cc: Christian Couder  <christian.couder@gmail.com>
>> Cc: Hariom Verma <hariom18599@gmail.com>
>> Signed-off-by: Nsengiyumva  Wilberforce <nsengiyumvawilberforce@gmail.com>
> 
> What are these C: lines for?  I do not think the message I am
> responding to is Cc'ed to them.  There may be a special incantation
> to tell GitGitGadget to Cc to certain folks, but adding Cc: to the
> log message trailer like this does not seem to be it---at least it
> appears that it did not work that way.

GitGitGadget will read the "cc:" lines from the end of the pull request
description, not the commit messages. I'm pretty sure they will be
ignored if there are other lines after them.

Thanks,
-Stolee
