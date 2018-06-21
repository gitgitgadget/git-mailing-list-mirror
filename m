Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DA881F516
	for <e@80x24.org>; Thu, 21 Jun 2018 17:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751593AbeFURXm (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 13:23:42 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36479 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932508AbeFURXl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 13:23:41 -0400
Received: by mail-qk0-f194.google.com with SMTP id a195-v6so2189411qkg.3
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 10:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=G68hUyhErgphbctmu8wZvWCTK0X0q/cBP4CJeYcb4fQ=;
        b=rs8u3zXlfWhYrEifkeRdzvahMrSblwhQXBthMNvkhauGii4MDLtL4ccJQA3o5o7jki
         pahGKKP6UDI7wdHMg8TNFMYYsEDt6JrOqQe69AWb1YY5G5sHbCnWcN7sBRx7QYESpTfb
         oQV78JZR7ueWS5+za3phAoaW8xvC4YCXPfynWsgyTLnki0NhM/nJIeCXGKNrwVPnnYFv
         PDKOf/t2oOBl8okZ6wO4jbaWwMZraox8pqC8cbchn+5DyQWF7YjhrJ+J7a06JX+HJtry
         pjm4jHXJpqTkKoZxVztOUutSLH3D6MlgkXoXM+8aqnZjgKGG4T8/0dYJl6JXOPmZp8qe
         YrHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=G68hUyhErgphbctmu8wZvWCTK0X0q/cBP4CJeYcb4fQ=;
        b=rZK96cbekThTVpPyBJt5K++pi1an1S6pr9rr0438utmEsPmc1ag/4R4tI1RiYAFjv5
         Wx2trN3lfugbx0RdVNsGY9FRpZutM5MNg0UVRTCq7L/qGVk1puKDPrR7nF/Ul3KCP1bD
         xaN8gByLbkS7NsMNcUS7qGQ3qKltZOUEGePx1icWVn/mnRJlY9oCO13rKqnSK0NMVxMa
         iRfFznPek8Ev6yDrztTnoBwrQ7QL7nQK4aIJyt3+f9E6epBWGEGKSCLIYsa2+rOXRecj
         oJd0TYI1ElBGcLUzMSri6qXkD5WfwveeZF02jawECCm6r24xk9WgnU+8zl7Pr/R/Xktp
         CATw==
X-Gm-Message-State: APt69E1G8d+JK1maTfwHdznDv1VNDABNFrET8lGv5PWq0xWE9jfdvrhP
        ziWKqfW/ehdQr64pk0flj2ZKhfXv
X-Google-Smtp-Source: ADUXVKKlmeNGVLkddnggHKPe8sJaYK9h8N+3H5YhdQdXlR7iIlnHkh2bzTMEyoy7h1qYOku+7rZlFw==
X-Received: by 2002:a37:670c:: with SMTP id b12-v6mr21819692qkc.108.1529601820314;
        Thu, 21 Jun 2018 10:23:40 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:342c:51f1:bd43:3fe6? ([2001:4898:8010:0:1d62:51f1:bd43:3fe6])
        by smtp.gmail.com with ESMTPSA id o66-v6sm4277900qki.93.2018.06.21.10.23.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 10:23:39 -0700 (PDT)
Subject: Re: [PATCH 10/23] midx: write a lookup into the pack names chunk
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Martin Fick <mfick@codeaurora.org>
References: <20180607140338.32440-1-dstolee@microsoft.com>
 <20180607140338.32440-11-dstolee@microsoft.com>
 <CACsJy8C0K_3-=S-sV+jfKdRoF0Ta8eafbOT_B1zOfWCftwz8Bw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <72b3e833-0071-ee94-b91e-c558af4927a0@gmail.com>
Date:   Thu, 21 Jun 2018 13:23:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8C0K_3-=S-sV+jfKdRoF0Ta8eafbOT_B1zOfWCftwz8Bw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/9/2018 12:43 PM, Duy Nguyen wrote:
> On Thu, Jun 7, 2018 at 7:01 PM Derrick Stolee <stolee@gmail.com> wrote:
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>   Documentation/technical/pack-format.txt |  5 +++
>>   builtin/midx.c                          |  7 ++++
>>   midx.c                                  | 56 +++++++++++++++++++++++--
>>   object-store.h                          |  2 +
>>   t/t5319-midx.sh                         | 11 +++--
>>   5 files changed, 75 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
>> index 2b37be7b33..29bf87283a 100644
>> --- a/Documentation/technical/pack-format.txt
>> +++ b/Documentation/technical/pack-format.txt
>> @@ -296,6 +296,11 @@ CHUNK LOOKUP:
>>
>>   CHUNK DATA:
>>
>> +       Packfile Name Lookup (ID: {'P', 'L', 'O', 'O'}) (P * 4 bytes)
>> +           P * 4 bytes storing the offset in the packfile name chunk for
>> +           the null-terminated string containing the filename for the
>> +           ith packfile.
>> +
> Commit message is too light on this one. Why does this need to be
> stored? Isn't the cost of rebuilding this in-core cheap?
>
> Adding this chunk on disk in my opinion only adds more burden. Now you
> have to verify that these offsets actually point to the right place.
This is a very good point. I'll drop the chunk and just read the names 
directly to construct the array of strings.

Thanks,
-Stolee
