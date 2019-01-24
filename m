Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09E7B1F453
	for <e@80x24.org>; Thu, 24 Jan 2019 17:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbfAXRgN (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 12:36:13 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44690 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727765AbfAXRgN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 12:36:13 -0500
Received: by mail-qk1-f194.google.com with SMTP id o8so3743810qkk.11
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 09:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=zb27xJHJREHfy7l24hV4SoZcJ05LVZj3pGjIzwDr5EE=;
        b=FO2leK3JIva7cdmTOPagZHPzlkpu/BVk64O6xeI4iMAW+FZ70YVli6bIYfZOeLqpQd
         7JbZe1PltGJtyZq0LXxTZvNCxu6AdfxcbwkJWTHbv4mxpVnh7g9scsCKp5s4IFr8qbML
         KTg/YtZV1ANAB20A403+fJ2/5Ex7xAR9BvEYuWfsl9/Yx3N5Hvi/aBZOmHE7KnyCUyqn
         P9EoxGldAgQgwJbWy+vJO9snI3aBjZIPAiEdIzX+iGcwqiDN46k/FQ86jdtUPD1Ho2LK
         KfIWziOEx73+7CsI9B4+Gw5X8TLBIxAFlqCHpXs6H2gSc5dWlg6IiIRoNW+/E24i/89u
         26Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zb27xJHJREHfy7l24hV4SoZcJ05LVZj3pGjIzwDr5EE=;
        b=Y4BZsqkP4dh2PMYS4fq7MACcVfLA1Jv4RPZs7sdLqj2Bf7NK19aJmGQkCOh5ePVa+O
         sljDbpWbLi4fHhv8pfxF+HHGIW+b+6/tqzx4649u6efHv5LEz3m0RTWR9lOhaPmyaP00
         gucAKUMyF9Zbv6FZwxwYYDHhFF+CNBrUREeT8gAJdMlmsWelsVubclKXPnG9ApuorDf7
         eeiXEH5nqOf2MCLiklsp956+YCiYCqjHo08MdyzTnP874m7JMnQOGpbxn/NML6Cmek0f
         XgCzyom0srj1W0G8DcTey5IInMglIGSQWcldT7WUwrSsJ/bMXvlG1+BgWOT05b6Ptc6u
         dPfw==
X-Gm-Message-State: AJcUukfKpRbQeQI2UJ+/spbabxGHn6fTvUihMokCIUHk5Zt8lwKRe7z3
        UH2QRN7FyX2LRcvSAXCq9d8=
X-Google-Smtp-Source: ALg8bN44fhoF8rL2cRso8yszEaL8yXB6ScuWnBJvptEMWy38WrgtPJmGPXAb4rwem1yK1BpUGIJo2g==
X-Received: by 2002:a37:a141:: with SMTP id k62mr6545209qke.280.1548351372701;
        Thu, 24 Jan 2019 09:36:12 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:a010:321f:4bbb:82c4? ([2001:4898:8010:0:8946:321f:4bbb:82c4])
        by smtp.gmail.com with ESMTPSA id w77sm10992839qkb.17.2019.01.24.09.36.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 09:36:11 -0800 (PST)
Subject: Re: [PATCH v3 6/9] multi-pack-index: implement 'expire' verb
To:     Jonathan Tan <jonathantanmy@google.com>, gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jrnieder@gmail.com, avarab@gmail.com, gitster@pobox.com,
        dstolee@microsoft.com
References: <4dbff40e7ad653d9c5c3b19dd63a345a21a73dbd.1547047269.git.gitgitgadget@gmail.com>
 <20190123221354.136961-1-jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <26af4406-1ff8-bb4f-f6fb-5505e2d66df7@gmail.com>
Date:   Thu, 24 Jan 2019 12:36:11 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <20190123221354.136961-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/23/2019 5:13 PM, Jonathan Tan wrote:
> Maybe add a fsck at the end for sanity's sake. Also, I think that
> preservation of .keep packfiles is an important feature, and maybe worth
> a test.
Good points! I forgot to test the .keep stuff directly here because I 
have an equivalent test in VFS for Git, so my wires got crossed.

Thanks,
-Stolee
