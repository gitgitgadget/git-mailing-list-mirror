Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44CEECAAA1
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 16:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiISQpY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 12:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiISQpP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 12:45:15 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DA510FC4
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 09:45:05 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id b23so16083104qtr.13
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 09:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=+91/XyetlhFvr0h+jHGcCoFxp3tJhpjEq+TlCaybnWY=;
        b=PQdco2MX4YJilRoS3PzjSZBCc9qM2Ti7bpQKJanjTCYXCkb3QckUFjDEDWI6oq35aV
         liBKVMgKZqOEEhX8ZJVFV5/EgU1RKq1qvhPc8sbWpYc6aGPbodi8lZ/V6eR8WCoQuRkh
         RTIYIRVImijnlzncT0ZQwC8bHzE1JT0ly4ZucrBYdrf1niDlEamUoKzAwcbZ/FVJUj79
         hAA7jNFeA5cCsua+fTGQO39It0Ur4cj0a3C2I0NPF4lQ7hpqZXYik1SivG2l8K4SYSL2
         xe0HcH6crrF73rodCcVx1f0fbWv7llkQ+zT9iSFdGvh04XyvTSIeEKa9nF31I+0MPyY8
         ZgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=+91/XyetlhFvr0h+jHGcCoFxp3tJhpjEq+TlCaybnWY=;
        b=BmH5oY+yqEfvV6hOX0ox5BmoZ+t1pu1+ELcZtX2xxSH+NScX7kiJGwoHVwgbgbBTu9
         TdkgtazIq/LNiNWDSu6rxsvL3N6Xp+6KEY4Y4JbRLhMNkIMHKamQMei40FNeBv837Y6Z
         GSW1QtwtsdBUUvJplmOmGh/rpv25fYzdzMqg6gABoUwjLS5G2zSjo1XZ2RyQGtEznzj7
         flLWlmLuKUNrIZD+5AXNAM7TqHqutS4Zjux9xCfWcvgBtqWjlbS6IoQLN7UxxrxErxy1
         tfpMtWLccQq75RZi9FMMG5DgNWOH90yteMXLHi1iAZ9LRl71hf6yJQGKCW9Q+/vC6lkv
         12Bw==
X-Gm-Message-State: ACrzQf0LBTa4ZmV0LhYp71USioxKkt9cBWg5gqeMDt+y+Hmv36e0Uz82
        UyuH+4vq5llAHzbx9l7HCQf3D3goc0eh
X-Google-Smtp-Source: AMsMyM4gb5xAVOsO1EUG5j1yu+wpUpp0GGVMHZ5F/Nmh9400h2HEdYeMVhayL8STT8tuKTJ0n0l2xQ==
X-Received: by 2002:ac8:5790:0:b0:35b:fd92:6fb8 with SMTP id v16-20020ac85790000000b0035bfd926fb8mr15421447qta.53.1663605904156;
        Mon, 19 Sep 2022 09:45:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:fd97:43ff:6c00:2cf8? ([2600:1700:e72:80a0:fd97:43ff:6c00:2cf8])
        by smtp.gmail.com with ESMTPSA id h1-20020a05620a244100b006cbcdc6efedsm13452986qkn.41.2022.09.19.09.45.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 09:45:03 -0700 (PDT)
Message-ID: <710c8868-800a-7140-0b47-74784b1e2b1d@github.com>
Date:   Mon, 19 Sep 2022 12:44:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 0/8] [RFC] Enhance credential helper protocol to include
 auth headers
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Matthew John Cheetham <mjcheetham@github.com>
References: <pull.1352.git.1663097156.gitgitgadget@gmail.com>
 <452acd3b-14bd-a3c8-df58-39b5e9edfd0b@github.com>
In-Reply-To: <452acd3b-14bd-a3c8-df58-39b5e9edfd0b@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/19/2022 12:08 PM, Derrick Stolee wrote:
> On 9/13/2022 3:25 PM, Matthew John Cheetham via GitGitGadget wrote:

>> protocol=https
>> host=example.com
>> wwwauth[0]=Bearer realm="login.example", scope="git.readwrite"
>> wwwauth[1]=Basic realm="login.example"
> 
> The important part here is that we provide a way to specify a multi-valued
> key as opposed to a "last one wins" key, right?
> 
> Using empty braces (wwwauth[]) would suffice to indicate this, right? That
> allows us to not care about the values inside the braces. The biggest
> issues I see with a value in the braces are:
> 
> 1. What if it isn't an integer?
> 2. What if we are missing a value?
> 3. What if they come out of order?
> 
> Without a value inside, then the order in which they appear provides
> implicit indices in their multi-valued list.

After looking at the code, it would not be difficult at all to make this
change in-place for these patches. But I won't push too hard if there is
some reason to keep the index values.
 
> Other than that, I support this idea and will start looking at the code
> now.

I took a look and provided feedback as I could. Patches 6 and 7 eluded
me only because I'm so unfamiliar with the http.c code and don't have
time to learn it today.

I mentioned that patches 1-3 could easily be picked up as a topic while
the rest of the series is considered carefully.

I tried to add some mentions of testing, but you've already tested more
than I expected, by adding the headers to the Apache output.

Thanks,
-Stolee

