Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C688E1F453
	for <e@80x24.org>; Thu, 24 Jan 2019 19:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbfAXTzG (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 14:55:06 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38874 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732023AbfAXTg7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 14:36:59 -0500
Received: by mail-qk1-f195.google.com with SMTP id m17so4036160qki.5
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 11:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=bcLp+1FwXdTbI7vOT3XBTLjqiBZX43s3wWBfgQnpWM8=;
        b=c/EizYwbTu19U8MST3rpi3yMjrPSsCT+84LNLyjqXC///H4uKXLotqPYGNykezgouq
         EhjjG3dOogu5VaGyCyE4R/SH8Lq7jX25tqmz2EeIcmbbkKD06f6FU/MmapUF8M767X8p
         P5iNSGl+dARpQyIUU3TWd8RWAmoaYpPP4Rf+ZIUE8ZiCrQoizeZytHYH7qEYIJtVmftD
         9ZFP/7wxfE+PYlcswGsAvjiw8y0T+tu99993iSKqV2AEXPHyRg3llcYjShyhe8behozD
         4HdR8j9OqlcCa2ocAzyVFphPCTIkCNzDU/333sVWmXEjkO8MKquaCl569C2E76ATFrTw
         lsBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bcLp+1FwXdTbI7vOT3XBTLjqiBZX43s3wWBfgQnpWM8=;
        b=OvkKES9HV8gZsRYt2AG+ubmh9SRVBdj2B3lzkZtUdgmDoNg2ygYvLVy3CmZUsYKZd7
         Jr1tliuzIaxekxoqcA2Np+rZtZExB8ZQX58YyK55Vj2YJ2yCpBkt5T2F0JGhXqhxkD3M
         CITOx7Cq4MkTH0S1/E6+ATuGLqpuq5XJwIAoLmhFiXLNwCjrcBh2JVKezDMqwqYhJPmB
         weyFxxvoX5rzb6QR5joe+hK7s50QgjMP8K+7jKzuo3xScz2mzgU3Y2ZabFI/FOwuj3wL
         4j+LYcDRmjH8EU1YdIwzrkPgGNwY/7WSRZY1D+xTtRuBb6ai3hNM+UBaxG7dxOD96Zct
         i8NA==
X-Gm-Message-State: AJcUukfGek22t9PRbEmEQ/iGW4AmRavIKSl3qD7Tlnis9pGk+tTUxxqg
        cXpY60VHnhBgrDFCh5xQgYU=
X-Google-Smtp-Source: ALg8bN7cCS8dumxrJYk65VxGxW506Wmr7UXF43sVei3aQEvl9xTqZHODngPln3TeABnstPPAKjyQlA==
X-Received: by 2002:a37:9d10:: with SMTP id g16mr6773769qke.53.1548358618635;
        Thu, 24 Jan 2019 11:36:58 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:a010:321f:4bbb:82c4? ([2001:4898:8010:2:8944:321f:4bbb:82c4])
        by smtp.gmail.com with ESMTPSA id w34sm79975214qtj.27.2019.01.24.11.36.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 11:36:58 -0800 (PST)
Subject: Re: [PATCH v3 7/9] multi-pack-index: prepare 'repack' subcommand
To:     Jonathan Tan <jonathantanmy@google.com>, gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jrnieder@gmail.com, avarab@gmail.com, gitster@pobox.com,
        dstolee@microsoft.com
References: <b39f90ad09265614efd466fee5089354a193ae8c.1547047269.git.gitgitgadget@gmail.com>
 <20190123223845.147378-1-jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d3194048-3907-71d0-1e81-490707f39ff2@gmail.com>
Date:   Thu, 24 Jan 2019 14:36:57 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <20190123223845.147378-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/23/2019 5:38 PM, Jonathan Tan wrote:
>> diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
>> index 6186c4c936..cc63531cc0 100644
>> --- a/Documentation/git-multi-pack-index.txt
>> +++ b/Documentation/git-multi-pack-index.txt
>> @@ -36,6 +36,17 @@ expire::
>>   	have no objects referenced by the MIDX. Rewrite the MIDX file
>>   	afterward to remove all references to these pack-files.
>>   
>> +repack::
>> +	Collect a batch of pack-files whose size are all at most the
>> +	size given by --batch-size, but whose sizes sum to larger
>> +	than --batch-size. The batch is selected by greedily adding
>> +	small pack-files starting with the oldest pack-files that fit
>> +	the size. Create a new pack-file containing the objects the
>> +	multi-pack-index indexes into those pack-files, and rewrite
>> +	the multi-pack-index to contain that pack-file. A later run
>> +	of 'git multi-pack-index expire' will delete the pack-files
>> +	that were part of this batch.
> I see in the subsequent patch that you stop once the batch size is
> matched or exceeded - I see that you mention "whose sizes sum to larger
> than --batch-size", but this leads me to think that if the total so
> happens to not exceed the batch size, don't do anything, but otherwise
> repack *all* the small packs together.
>
> I would write this as:
>
>    Create a new packfile containing the objects in the N least-sized
>    packfiles referenced by the multi-pack-index, where N is the smallest
>    number such that the total size of the packfiles equals or exceeds the
>    given batch size. Rewrite the multi-pack-index to reference the new
>    packfile instead of the N packfiles. A later run of ...

Thanks for the suggestion.

It is slightly wrong, in that we don't sort by size. Instead we sort by 
modified time. That makes is a little complicated, but I'll give it 
another shot using your framing:

         Create a new pack-file containing objects in small pack-files
         referenced by the multi-pack-index. Select the pack-files by
         examining packs from oldest-to-newest, adding a pack if its
         size is below the batch size. Stop adding packs when the sum
         of sizes of the added packs is above the batch size. If the
         total size does not reach the batch size, then do nothing.
         Rewrite the multi-pack-index to reference the new pack-file.
         A later run of 'git multi-pack-index expire' will delete the
         pack-files that were part of this batch.

-Stolee
