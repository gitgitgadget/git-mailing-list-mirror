Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5C7C1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 16:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbeGLQnf (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 12:43:35 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33860 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbeGLQnf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 12:43:35 -0400
Received: by mail-qt0-f194.google.com with SMTP id m13-v6so24623467qth.1
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 09:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=YUgmGtkAHxakIyH5OV3PGkPxrifzYCKVZRqMd5zv7E4=;
        b=CyvidqBIvSdH4ZljhGVxk+xw/US17oxB5W3Ua6gQ2CXX+TPyJhqnLq0x7qhf00VmZk
         EqVW1/AAExUXwPXKyfSzzgQFAafeROIkl2eB6SJFvxC5lUtC4c5p2hgn5VSGLsXY7mG7
         kNtj46lN4Kmp5D4T3cQ560Fcd6o9KbcJZnkvUmueA/+4qhcrPfxj7uhkhmvBGyTORFl+
         AgNIwaEs6eq6oC+9Bqw1hZZM9EIWGIju60T3qthCe3Nt0rb8KOd1SIdy27aS6al8ZusC
         9Qlbfj9QZlYYdj3Jias4E40bZ8CVPc+vCwyzWLe8FhxpYhFmE7pZ1AvyEkyuyoPFhGcn
         K8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=YUgmGtkAHxakIyH5OV3PGkPxrifzYCKVZRqMd5zv7E4=;
        b=umfFrXESMMWf96zCjZigETwLpCQvoz6DFSQB/188S0puRaUjXWQazh120VLV+Df+3s
         QON+71PeNrTJ5me/mYi5R/IaQ3FTqEsrzlQrZe6JubHN2nawkOgQX+zUCWnMOZ13X82v
         Ycd1UDfAQXRxslx7yiaGQIiOl0t/SN+fcdBSKjMz+NEOLav+JOkuICZbuo1iW4s4+zLU
         TZ1B9kDyrHEK0EFCF66FY4KurC77rUHyfHErbEVZOVrwPXRSuQaYrZ+QIq0a08YqlrP0
         DOZjBI1HZ7kWwhK3JRWAE+BT5tKB7ULFfvfNlHha2weSj/llmmgRISZdozYzuQ+kTzJc
         36hQ==
X-Gm-Message-State: AOUpUlEOPa/tHM1GJd/dWaJKMI9M9lFB1S/LPgvXaxgL0VrC3CqXzACN
        AbrIOovhOL650FqSrmtXb+ACz1nImF4=
X-Google-Smtp-Source: AAOMgpfImVTmVqAQGgaspUshmoLntoq07stxSXivlovcHhWvV6GMAnmBAQiQVsPKKDdmnhkWr+LuwA==
X-Received: by 2002:a0c:a991:: with SMTP id a17-v6mr3181719qvb.83.1531413197554;
        Thu, 12 Jul 2018 09:33:17 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:7999:2a5f:44db:50fd? ([2001:4898:8010:0:62cf:2a5f:44db:50fd])
        by smtp.gmail.com with ESMTPSA id l61-v6sm13869955qte.67.2018.07.12.09.33.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 09:33:16 -0700 (PDT)
Subject: Re: [PATCH v3 15/24] midx: write object offsets
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= =?UTF-8?Q?_Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <20180625143434.89044-1-dstolee@microsoft.com>
 <20180706005321.124643-1-dstolee@microsoft.com>
 <20180706005321.124643-16-dstolee@microsoft.com>
 <CAPig+cR1BaOTTjg751NO14sAr6UZ0WT_G3Hu59KyiWTASZ8D2A@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e33b0e17-bf32-3ee9-5874-96555ce98cbc@gmail.com>
Date:   Thu, 12 Jul 2018 12:33:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cR1BaOTTjg751NO14sAr6UZ0WT_G3Hu59KyiWTASZ8D2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/6/2018 1:27 AM, Eric Sunshine wrote:
> On Thu, Jul 5, 2018 at 8:54 PM Derrick Stolee <stolee@gmail.com> wrote:
>> The final pair of chunks for the multi-pack-index file stores the object
>> offsets. We default to using 32-bit offsets as in the pack-index version
>> 1 format, but if there exists an offset larger than 32-bits, we use a
>> trick similar to the pack-index version 2 format by storing all offsets
>> at least 2^31 in a 64-bit table; we use the 32-bit table to point into
>> that 64-bit table as necessary.
>>
>> We only store these 64-bit offsets if necessary, so create a test that
>> manipulates a version 2 pack-index to fake a large offset. This allows
>> us to test that the large offset table is created, but the data does not
>> match the actual packfile offsets. The multi-pack-index offset does match
>> the (corrupted) pack-index offset, so a future feature will compare these
>> offsets during a 'verify' step.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
>> @@ -6,25 +6,28 @@ test_description='multi-pack-indexes'
>> +# usage: corrupt_data <file> <pos> [<data>]
>> +corrupt_data() {
> Style: corrupt_data () {
>
>> +       file=$1
>> +       pos=$2
>> +       data="${3:-\0}"
>> +       printf "$data" | dd of="$file" bs=1 seek="$pos" conv=notrunc
>> +}
>> +
>> +# Force 64-bit offsets by manipulating the idx file.
>> +# This makes the IDX file _incorrect_ so be careful to clean up after!
>> +test_expect_success 'force some 64-bit offsets with pack-objects' '
>> +       mkdir objects64 &&
>> +       mkdir objects64/pack &&
>> +       pack64=$(git pack-objects --index-version=2,0x40 objects64/pack/test-64 <obj-list) &&
>> +       idx64=objects64/pack/test-64-$pack64.idx &&
>> +       chmod u+w $idx64 &&
> I guess you don't have to worry about the POSIXPERM prerequisite here
> because the file is already writable on Windows, right?

Correct. And I want this test to still run on Windows.

Thanks,

-Stolee

