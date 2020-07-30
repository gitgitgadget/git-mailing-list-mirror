Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5977CC433E0
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 19:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33AF320809
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 19:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYBJgPZ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbgG3TCj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 15:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbgG3TCi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 15:02:38 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC9BC061574
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 12:02:37 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id 6so21197135qtt.0
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 12:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ognFo32HGHeNvLaHVJ06o8R5RaQF+JyIz/A0jsuTZ3c=;
        b=nYBJgPZ00HUL64ORz9rb/17vALhFb+xmcQaHY/R63tIKcIFs8CGcfAr2LxsfoHXTkC
         QRcPtA41UhZI1wBLjYbOcPdoficYyv+Y7s3jhEuMzOdm/HMDxoLUjblXFTqZ9k3a5s+E
         9/se7rQNYdK4FdqV36A3s3gOXVnlyts0yGFWalRsW3BboHNJ0maHPkhHHZj9LMHKJDhO
         g9HTq3wqPbpn8Wa7YJ9XP3cvkp3Lbo/IKjqnJF/7coDCbC2e/oCejCH02P5mCBMtZgsV
         KuV9aaA3nnDG10+1fGd9ny4v0ZG1EShTXkngKeRB4XPAgtkJFoPGXr+Wl4vFRNHS+nE4
         2D0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ognFo32HGHeNvLaHVJ06o8R5RaQF+JyIz/A0jsuTZ3c=;
        b=UdjYW3G+6qLFVy9slIYydDu1+d2pJe6nhHyPFVyfJTNbo5QVK2a2jMtNYHh6VFRECY
         XGoNURtVmETQgRyTPX40AMCVBRpr5dNjQCvt0upQc+mraVQcGDMyVbst7dWQL0kOBjm5
         +T78Sm/sxGXHrR3mi3l14TmT/0OxfY06pDHtG4tE7OuANOlCwd/iClGCbigJtfUpKHWW
         USmw8VorXQr8+If2aE0KaJhycYfN+FN0b5TbejvIbEDqBTtx5c7VKgWemZsmqrL2ZlZl
         ra5njr/8Q1WcvL5gCb6kSIpvvJk2TauSAxQvjS9+FhrNw/nvUhtU0emdUqROB/WKUUbT
         J+HA==
X-Gm-Message-State: AOAM532o/6hXCho0/WheRL3rtRQlQP80eeENil5GpI7+Uo6j3I4eHaRG
        9f+ubUk93DqcCbytM3TfEOhL0V+JByeMoQ==
X-Google-Smtp-Source: ABdhPJzrdilYLi7251hTe1dHw+zFYk8kFBpVwZdOT75BGg717PjpSQsCM9UqcTZH2IvQBR1NW20ncg==
X-Received: by 2002:aed:3102:: with SMTP id 2mr119702qtg.212.1596135756531;
        Thu, 30 Jul 2020 12:02:36 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:5cb3:9664:3acf:ecfa? ([2600:1700:e72:80a0:5cb3:9664:3acf:ecfa])
        by smtp.gmail.com with ESMTPSA id 8sm5129203qkh.77.2020.07.30.12.02.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 12:02:35 -0700 (PDT)
Subject: Re: [PATCH v2 11/18] maintenance: auto-size incremental-repack batch
From:   Derrick Stolee <stolee@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
 <478c7f1d0b858755c2c4b98605405214910b6f4c.1595527000.git.gitgitgadget@gmail.com>
 <20200729222334.GE2965447@google.com>
 <b374cb3a-f681-d514-c465-6b3f0b674bcf@gmail.com>
Message-ID: <c0b9876a-9041-3400-25ac-e52568a02074@gmail.com>
Date:   Thu, 30 Jul 2020 15:02:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:79.0) Gecko/20100101
 Thunderbird/79.0
MIME-Version: 1.0
In-Reply-To: <b374cb3a-f681-d514-c465-6b3f0b674bcf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/30/2020 12:57 PM, Derrick Stolee wrote:
> On 7/29/2020 6:23 PM, Emily Shaffer wrote:
>> On Thu, Jul 23, 2020 at 05:56:33PM +0000, Derrick Stolee via GitGitGadget wrote:
>>> diff --git a/builtin/gc.c b/builtin/gc.c
>>> index eb4b01c104..889d97afe7 100644
>>> --- a/builtin/gc.c
>>> +++ b/builtin/gc.c
>>> @@ -1021,19 +1021,65 @@ static int multi_pack_index_expire(void)
>>>  	return result;
>>>  }
>>>  
>>> +#define TWO_GIGABYTES (2147483647)
>>
>> [jonathan tan] This would be easier to understand if it was expressed
>> with bitshift, e.g. 1 << 31
> 
> This is actually ((1 << 31) - 1) because "unsigned long" is 32-bits
> on Windows. But it's better to not use magic numbers and instead use
> operations like this.

Nevermind. This breaks the build on 32-bit machines (even adding a few
"L" characters). I'll replace my magic decimal number with a magic
hexadecimal number.

Thanks,
-Stolee
