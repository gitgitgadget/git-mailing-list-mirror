Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D6221F404
	for <e@80x24.org>; Thu,  8 Feb 2018 17:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752337AbeBHRpV (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 12:45:21 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:46151 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752192AbeBHRpQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 12:45:16 -0500
Received: by mail-qk0-f193.google.com with SMTP id d125so6653401qkg.13
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 09:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M4dCOqiibDBZ2H6KWJQA4foMT+Uf2it5JOCKsqKfIpg=;
        b=FxzECiS89QA9jnbPSmCXtYeRms2INJrAKxJWBZlzYV3X8ZIW2L631OcTmMlhsDAA6U
         guBgD1B1HVE5MzhGXQOI0uyyvWr7gVqO8rMFGoD8pJ/Z0FDjY90OEav6cHvzUTM4vRjH
         Y7sCPPPUb//o1hOx2PtEdP6eE75qs37JKJtFrQlzLQfqQBABCvtGBcPc/zxFj4xHtMs6
         oBmmU9HcnShS01CsRvFERJDR+afn10flMGj+wf7hCJ209dJhj+UrRjPV+d0Jz5LWCBlL
         cApuntKzrVl3qEr1CVJvJM8fh+dPuFf+vQEFNLraNBs5L8B+Kni+moPSBiHMyT/YZZmL
         4nTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M4dCOqiibDBZ2H6KWJQA4foMT+Uf2it5JOCKsqKfIpg=;
        b=glZo1VHviIvZqL6jXsDnzTqMGtAnv3/hbnBoPAnUuC2bW1lSN6vDo4whBn5NDqoYWt
         L/XB+T6cH58j2Q4oT+WNEIKBmeJcT0dNIaMdwVMYp733IvwGdiJZLp09rRd/7LVHHxTK
         p4xHlVl9/+yNVFe8qUmEZToUiOEiyeg/Am23tnsq4caMk5yub8oRgjdh8AcLInTYwhRX
         ljYZp2snplG6Nj5uuqsSjCiMOa52OQhDFCLZd1UAZfM/zdgw86GCE/CUlokq4RugNZkb
         eWzo6nVd4YvVftnyQmR8+IBrR6go0gRJwUoKFXbTQzqFiUU2ais4Y2HDEt/TQMb7wvFE
         tfQw==
X-Gm-Message-State: APf1xPCgQhlXIrZ3iogok0Xtd4DBpCa1aveyuHN6GUyxQ2Q0oMv9pHid
        kHtYe/esqyUczkXYDZpGoD8=
X-Google-Smtp-Source: AH8x226fB1EErblCbAXihUC8YZ67rqn0WTxgZm9W5nTjrDdae1X3gTxjG29CDrBu3UdGLwPnokfPuQ==
X-Received: by 10.55.27.231 with SMTP id m100mr11285qkh.17.1518111915613;
        Thu, 08 Feb 2018 09:45:15 -0800 (PST)
Received: from [192.168.1.105] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id p8sm338090qtj.84.2018.02.08.09.45.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Feb 2018 09:45:14 -0800 (PST)
Subject: Re: [PATCH v1] name-hash: properly fold directory names in
 adjust_dirname_case()
To:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Ben Peart <benpeart@microsoft.com>
Cc:     git@vger.kernel.org, prohaska@zib.de, gitster@pobox.com,
        sunshine@sunshineco.com, novalis@novalis.org
References: <20180208004156.36224-1-benpeart@microsoft.com>
 <20180208172153.GA30760@tor.lan>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <8a6b704f-409d-9a29-2229-d792d0f503ae@gmail.com>
Date:   Thu, 8 Feb 2018 12:45:13 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180208172153.GA30760@tor.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/8/2018 12:21 PM, Torsten Bögershausen wrote:
> On Wed, Feb 07, 2018 at 07:41:56PM -0500, Ben Peart wrote:
> []
> 
>> diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
>> index b29d749bb7..219c96594c 100755
>> --- a/t/t0050-filesystem.sh
>> +++ b/t/t0050-filesystem.sh
>> @@ -80,7 +80,17 @@ test_expect_success 'merge (case change)' '
>>   	git merge topic
>>   '
>>   
>> -
>> +test_expect_success CASE_INSENSITIVE_FS 'add directory (with different case)' '
>> +	git reset --hard initial &&
>> +	mkdir -p dir1 &&
>> +	mkdir -p dir1/dir2 &&
>> +	touch dir1/dir2/a &&
>> +	touch dir1/dir2/b &&
>> +	git add dir1/dir2/a &&
>> +	git add dir1/DIR2/b &&
>> +	camel=$(git ls-files | grep dir2) &&
>> +	test $(echo "$camel" | wc -l) = 2
>> +'
>>   
> 
> There is nothing wrong with with "wc -l", but:
> a more new-style would probably use test_line_count() here.
> 
> My personal favorite would be to spell out what we expect and run a diff.
> When it fails, we can see what fails, and the function would look
> like this:
> 

I agree with you completely that this is a better format and is easier 
to read.  All the new tests I've been writing follow this same pattern.

In this particular test file, I opted (for better and for worse) to 
stick with the style of all the other tests rather than 1) have this one 
test be very different than all the others or 2) rewriting all the 
existing tests in the new style.

> 
> test_expect_success CASE_INSENSITIVE_FS 'add directory (with different case)' '
> 	git reset --hard initial &&
> 	mkdir -p dir1 &&
> 	mkdir -p dir1/dir2 &&
> 	touch dir1/dir2/a &&
> 	touch dir1/dir2/b &&
> 	git add dir1/dir2/a &&
> 	git add dir1/DIR2/b &&
> 	git ls-files | grep dir2 | sort >actual &&
> 	cat >expected <<-\EOF &&
> 	dir1/dir2/a
> 	dir1/dir2/b
> 	EOF
> 	test_cmp expected actual
> '
> 
> 
> 
