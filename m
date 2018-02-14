Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68C6F1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 19:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162745AbeBNTLX (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:11:23 -0500
Received: from mail-qk0-f179.google.com ([209.85.220.179]:43430 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162681AbeBNTLW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:11:22 -0500
Received: by mail-qk0-f179.google.com with SMTP id i184so16908599qkf.10
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=efrRPQlUinX4c+5YGEY8rZZi02SQiBF70SibBXrG+3c=;
        b=TaFDNX2oEQwIW7xX6fF7v3DxMY9YDWO1y6z9Cv0AmEBB4nDGstUOqM3NbBGOcM7TYf
         fE4699UnNwJTqPP+XLKdD/9Kft7GeygVfMcFDyRDHoU7i8r6qRK0l3++irdysWs9zqoS
         YzE1l1bBWeZ3Pt6pK1676aCSRrcowrUaVEnCxMrxu0KgNH8PgnEEg8xxDn+KZg1YM+lD
         4OY9NCLpBLCHBRC79SNW9bHPIJvcNuivoIK3Dv660Ot09af4EnFMafMFiuKeGoNH5UCq
         +ZOWRvT3PRuB3H54E5JQ0P8dHtRPhDPz6ACjMsz6JUWrRMKGQXaykC8MABIsev+9Uzld
         J11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=efrRPQlUinX4c+5YGEY8rZZi02SQiBF70SibBXrG+3c=;
        b=qEmVUlkGd4eLmvvwwgyEgl21lf+SsWZ/0S6sbwa3RASaHlMHPEhY7oswpyRjzK3Xaa
         tpeI9fGohqtk686iyBuWCWRwY/RcCK/pJ9QffQ+3pxSrC2HX2rJpzXNTZV0gOOQJpqy4
         rM6fzD9e/BO2haDT9OZ1gL68YwGk/nPwuTFTjulJb3iuzKri6xq3bY+/aTC7PDc6yMNc
         xhZIdP5nW/BhHVLzv9Ks86BL4Bjtx6k8smUyx8ZJmWKX0NTapDjAvkheUjF4HLkuKydV
         nT4UokjZJrtCBWV2lpmtyiJrF6em/ttKabVMvOM1+iZIOBgG3Vpu3WrQ/tKyAZEKotzg
         rPJw==
X-Gm-Message-State: APf1xPDhQiAJMgecOqLTm1BJkcCzvvyzy+pG38767Bq9uEtfoZA9fqGO
        HbgSyPb8ywrfDBElAJG/PH8=
X-Google-Smtp-Source: AH8x224m/AS/oph5/kllbhBdY36UvvTCDrBNpokzENhx/EoRfR2l3+2keU8ud8d8EU00lZHk+W0Wlg==
X-Received: by 10.55.203.67 with SMTP id d64mr132994qkj.210.1518635481324;
        Wed, 14 Feb 2018 11:11:21 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id s12sm1549700qtk.88.2018.02.14.11.11.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Feb 2018 11:11:20 -0800 (PST)
Subject: Re: [PATCH v3 00/14] Serialized Git Commit Graph
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
 <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
 <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
 <CAGZ79kbMURmVhnaP4rdho9TpzZ=K+ySkQGgW8TD0x+KgJkqirA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <84ad10eb-4db1-4a3e-9030-6a53283d9877@gmail.com>
Date:   Wed, 14 Feb 2018 14:11:19 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kbMURmVhnaP4rdho9TpzZ=K+ySkQGgW8TD0x+KgJkqirA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/14/2018 1:27 PM, Stefan Beller wrote:
> On Wed, Feb 14, 2018 at 10:15 AM, Derrick Stolee <stolee@gmail.com> wrote:
>> There has been a lot of interesting discussion on this topic. Some of that
>> involves some decently significant changes from v3, so I wanted to summarize
>> my understanding of the feedback and seek out more feedback from reviewers
>> before rolling v4.
>>
>> If we have consensus on these topics, then I'll re-roll on Friday, Feb 16th.
>> Please let me know if you are planning on reviewing v3 and need more time
>> than that.
>>
>>
>> * Graph Storage:
>>
>>      - Move the graph files to a different directory than the "pack"
>> directory. Currently considering ".git/objects/info"
> In my copy of git there is already a file
>
>    $ cat .git/objects/info/packs
>    P pack-8fdfd126aa8c2a868baf1f89788b07b79a4d365b.pack
>
> which seems to be in line with the information provided in
> 'man gitrepository-layout':
>      objects/info
>             Additional information about the object store is
>             recorded in this directory.
>
> The commit graph files are not exactly "additional info about the
> object store" but rather "about the objects". Close enough IMO.
>
> Stefan

Thanks for the tip [1]. I was unfamiliar with it because it doesn't 
exist in repos that don't repack.

[1] 
https://git-scm.com/docs/gitrepository-layout/2.12.0#gitrepository-layout-objectsinfopacks
