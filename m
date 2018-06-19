Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B10611F403
	for <e@80x24.org>; Tue, 19 Jun 2018 12:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966270AbeFSMyf (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 08:54:35 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:41560 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966251AbeFSMyb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 08:54:31 -0400
Received: by mail-qk0-f196.google.com with SMTP id w23-v6so11256743qkb.8
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 05:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=hS8/pE3qOXLEHrd2Rvoise8EiIcJK6YzafyN89HAYoM=;
        b=k8PJ3Ozdeqe0tTHG3kVQvJ6MJejqOpb/0qGMokwuxZQfMyg/KerxaPgDqI2nSql0e+
         j7Ss5Hmr1vDmxwNwzVoHTkjIYHlJbs+ysnJ36g+sTJFP2jfHrgot2J3yzC25q5wy+B38
         ZBhDE2h8GLodiUAM6UYRMDIQtRZrAuB2xQS1Q01lVFJg6V1pHrZaWm887pb5ZXKYEJd+
         lWrlZCFS9wfQYu5qUrqk+JEDVTnCr5x20Q/3uiF63gXVSCGVH0z3c60osUdc/6HBv6JP
         rBE8IAGWMtoqzOfjE85E1lPjOcpU473lHvV4VEtNr2xEVjEaR/y08aQEYmEFEqFXnk8Y
         DdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=hS8/pE3qOXLEHrd2Rvoise8EiIcJK6YzafyN89HAYoM=;
        b=Qup48vEYBawPfdJqVt6BqpPmRDwACmZ6ebwwAHLKh/HCx8qH+Beeky2L1/vMoVr2AU
         g+/w4mmRR9kQH9b3OceqhFbeJyGgatMgqVG+K/BrHorjFjo1ALJ2jPmMk1gLwWFf+x3L
         jpihtuucQlR2Hxc0YCoOtOxVjDipWIGfVoQQ2Bvk1nQDX8qpE5IQKSZtpoNo5euSCovN
         H0IOZlHiH+Kn+ACFTC8/2kXHGtGEiC77PUkElNaw6jrl37TCrPzboZLcj41sz2RC4C9Q
         wtysXl0y2vjLIIaCvjHc4usIOTIVzGs5nWfgKdzEruWSH35ZCP7kc3XU831L0eDTmwAk
         CWog==
X-Gm-Message-State: APt69E1Gscjxaa/pHBgwlM7YdLvC3rJP/OvbE7Mtyn3Sk3FvQkXtj0uZ
        klOlhhdexWpBi6eAyDIyhn4=
X-Google-Smtp-Source: ADUXVKJ3Aw2G/YRg+8yLX0N5B+7y2YxOfA/muEcfBtpl9qDoxP6ITWWwxFwIaX4QjqAsSi+SkpzipQ==
X-Received: by 2002:ae9:c00f:: with SMTP id u15-v6mr13675686qkk.383.1529412870679;
        Tue, 19 Jun 2018 05:54:30 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:d807:51c7:6f48:91e4? ([2001:4898:8010:0:c13d:51c7:6f48:91e4])
        by smtp.gmail.com with ESMTPSA id l5-v6sm15038999qtl.58.2018.06.19.05.54.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 05:54:29 -0700 (PDT)
Subject: Re: [PATCH 05/23] midx: write header information to lockfile
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Martin Fick <mfick@codeaurora.org>
References: <20180607140338.32440-1-dstolee@microsoft.com>
 <20180607140338.32440-6-dstolee@microsoft.com>
 <CACsJy8ALMjiyjcEdFPnR7GTzBVpqVB72VQNkpUWrj9p4nm-OGg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <fa036efb-2164-ee0a-8cbb-4144487b6617@gmail.com>
Date:   Tue, 19 Jun 2018 08:54:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8ALMjiyjcEdFPnR7GTzBVpqVB72VQNkpUWrj9p4nm-OGg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/12/2018 11:00 AM, Duy Nguyen wrote:
> On Thu, Jun 7, 2018 at 7:01 PM Derrick Stolee <stolee@gmail.com> wrote:
>> diff --git a/midx.c b/midx.c
>> index 616af66b13..3e55422a21 100644
>> --- a/midx.c
>> +++ b/midx.c
>> @@ -1,9 +1,62 @@
>>   #include "git-compat-util.h"
>>   #include "cache.h"
>>   #include "dir.h"
>> +#include "csum-file.h"
>> +#include "lockfile.h"
>>   #include "midx.h"
>>
>> +#define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
>> +#define MIDX_VERSION 1
>> +#define MIDX_HASH_VERSION 1 /* SHA-1 */
> ...
>> +static size_t write_midx_header(struct hashfile *f,
>> +                               unsigned char num_chunks,
>> +                               uint32_t num_packs)
>> +{
>> +       char byte_values[4];
>> +       hashwrite_be32(f, MIDX_SIGNATURE);
>> +       byte_values[0] = MIDX_VERSION;
>> +       byte_values[1] = MIDX_HASH_VERSION;
> Quoting from "State of NewHash work, future directions, and discussion" [1]
>
> * If you need to serialize an algorithm identifier into your data
>    format, use the format_id field of struct git_hash_algo.  It's
>    designed specifically for that purpose.
>
> [1] https://public-inbox.org/git/20180612024252.GA141166@aiede.svl.corp.google.com/T/#m5fdd09dcaf31266c45343fb6c0beaaa3e928bc60

Thanks! I'll also use the_hash_algo->rawsz to infer the length of the 
hash function.
