Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SORTED_RECIPS shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EBDF21847
	for <e@80x24.org>; Wed,  2 May 2018 13:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751115AbeEBNpZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 09:45:25 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:33494 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbeEBNpY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 09:45:24 -0400
Received: by mail-qk0-f179.google.com with SMTP id c70so11231384qkg.0
        for <git@vger.kernel.org>; Wed, 02 May 2018 06:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=vVpDM+/PgTQNTf2WipVnEUTE/YIVA9/fbFeEi2DqP08=;
        b=FHfuTb289rOI9rJXqQ4rmolR0wj5icCboIkz8RvJNakBIhvSfvK5oEDu056ajRtVLt
         0FmpeGr59ud0s+lfuVLUySYqpTzG0f0MFCee1W34XbfyzVnSn4rN6x9PGdEu70qgGbyZ
         7KbMk8KSqZC+vflgjMGSSg3h95b8NbH46tbB9g9duJm461OT63dwYwCFl/bq9IkbSdaV
         BrAKAQ/HYV/SICuRl/hhCsaQeCEaUv6M9UPxwWaqw6Dclw/Y06XGMKPsR0INVpLe9SmQ
         ueqxfs7/lv2XoVpancarUt3iL4G4ppVlinZvEkKrdaXDA2HrRceyaqypn2q1dr1M/Zn+
         8xyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=vVpDM+/PgTQNTf2WipVnEUTE/YIVA9/fbFeEi2DqP08=;
        b=i1XDHRxvj9SOPVj31gwO7pCLT5BaF+MlicA9MKuBwx4aIdq9n2ctu/Q763wh20GonQ
         0ylZ5g3VuZWbk+VjmkNfIP70qH7EY8e9uu4KnmvVzofuqE+kEv+4UoqLZgatfvkwRHHY
         dFkOiev89hoDQGglmnBBTu6M8MS9l/9UIOjjf44Q9SKvgivNPKce4iCRzdk9QCjOrBOY
         XaGdxaK2Cv42v70JoY9SKn//F8k1uNcZX72KXGxG8qJRYS8T9+spaUveX8Cm4U/VlC9o
         6ViWUS6am03rZ+So90+AHu36tlIQaQpsdfW5nlzjdOVMG60AEOkYB8ov0rcI602mRiJ3
         RBnQ==
X-Gm-Message-State: ALKqPwcQLyAtpOz44HxP5YZu+/4RXN/3a5wBISa3fc8hhb/ij98SCJ6c
        jEfe71OXbv1H1TyOv1GR4zGTOdmGQzc=
X-Google-Smtp-Source: AB8JxZpiPQ7k1VkglW7TQ7Bq9LnSKykAKdJz79IxKKlEr9OHkC8xEViR2pGgGKVT84Ge5xtUq/gELw==
X-Received: by 10.55.87.65 with SMTP id l62mr254328qkb.204.1525268723682;
        Wed, 02 May 2018 06:45:23 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id x49-v6sm10802335qth.18.2018.05.02.06.45.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 May 2018 06:45:23 -0700 (PDT)
Subject: Re: [PATCH v3 00/12] get_short_oid UI improvements
From:   Derrick Stolee <stolee@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20180501120651.15886-1-avarab@gmail.com>
 <20180501184016.15061-1-avarab@gmail.com>
 <f35aeda5-8f41-f457-736e-393e95f530ec@gmail.com>
Message-ID: <385be5ef-7d0d-7e5d-4373-4d85c1a36a0d@gmail.com>
Date:   Wed, 2 May 2018 09:45:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <f35aeda5-8f41-f457-736e-393e95f530ec@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/2/2018 8:42 AM, Derrick Stolee wrote:
> On 5/1/2018 2:40 PM, Ævar Arnfjörð Bjarmason wrote:
>> The biggest change in v3 is the no change at all to the code, but a
>> lengthy explanation of why I didn't go for Derrick's simpler
>> implementation. Maybe I'm wrong about that, but I felt uneasy
>> offloading undocumented (or if I documented it, it would only be for
>> this one edge-case) magic on the oid_array API. Instead I'm just
>> making this patch a bit more complex.
>
> I think that's fair. Thanks for going along with me on the thought 
> experiment.

Also, v3 looks good to me.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>

