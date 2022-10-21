Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E97C4332F
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 10:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiJUKdD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 06:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiJUKdC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 06:33:02 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B902A1E5756
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 03:32:59 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id p6so1955474plr.7
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 03:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=28V7zyU+9Xo/n/JmjEga1SbsFrxIQah2aoYfGDBRLZs=;
        b=dWLEWrIjHawL6nfPw8tNPZFAKALayQiDygW5lEULxxgmggl/18F3Z7qtIWwtUTYrp2
         GUmyz3+lS3Gy5KRwEWitc790yuYmAIkJvaQOgUs10wgtwS/IWdQsxxdwhaH3ttDrUzWT
         ssWsngHy73xHY/2QUGO4ssroXvAS+54Se6Zn/AeAbY3nnYXxLhhISZSUeRX9U8D+pqjs
         YS/Sn9NrPWEbU6ml15dKqi6H/AUyXPTZRw2qTTxPczpmH1UDf65z9AOyXDIBL1HuB/So
         Xqa8DMyQeGb3n2uxZ3IdjOZ+7bGd1fX4AZ92FKcCXR9aNuFIq442+TZmmEicbaPEFsHI
         aSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=28V7zyU+9Xo/n/JmjEga1SbsFrxIQah2aoYfGDBRLZs=;
        b=3QFztsYBU0kA6GuCUfeqcvuGZSoQlY4+5dWF7BaJ9ZsbAT61jq6ETmrtjU6vKmBeXW
         ZXxG+BqNYbypZSXTrytN8U/iPZEZkHL0/eUlZeQ8Hqh5BanxwzxuTbny0LRZGF/TQNb+
         iw1PF7TnGHQBvWv0OgqXaVCoVF0Zb5kcAIa+uzKccEyr4LNo2yx+FvsLP3VldSOy8rzq
         5KkHRb0qXxel2XEmoA2UmWXWrflPsUCBm2EtUsf2vh5sazUUUebF3L2Rk1320RyWJ8eq
         BTslDzFWYzeKWOmsug6AL4t/H3xrjqfOq0F3tf1aC2gEwOvPwivZL+1qTCw6WYI+pBZl
         RcWA==
X-Gm-Message-State: ACrzQf2kmgQsmJ+Tzw6nwg21+YgbKiMKBjIZNNaIOVLY73qK+eMMzr4B
        FlbkNI6RAEXJ69meyWoaTtOPGv67eYs5sQ==
X-Google-Smtp-Source: AMsMyM7XxIzvfHFfkuoNsJDZismcNjUxS3sgPyZQ4cUSyHXSJjJxaTXlGkfm5Ge2GiqsV+W1SBsVYA==
X-Received: by 2002:a17:90b:4c10:b0:20d:5388:a479 with SMTP id na16-20020a17090b4c1000b0020d5388a479mr21615615pjb.184.1666348379065;
        Fri, 21 Oct 2022 03:32:59 -0700 (PDT)
Received: from [192.168.1.3] ([122.171.202.28])
        by smtp.gmail.com with ESMTPSA id d204-20020a621dd5000000b0056238741ba0sm14741679pfd.79.2022.10.21.03.32.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 03:32:58 -0700 (PDT)
Message-ID: <ad579a6c-8a3b-c226-54e4-b8bcef4930ac@gmail.com>
Date:   Fri, 21 Oct 2022 16:02:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] doc/cat-file: allow --use-mailmap for --batch options
Content-Language: en-US
To:     John Cai <johncai86@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
References: <20220923193543.58635-1-siddharthasthana31@gmail.com>
 <20220926091442.222876-1-siddharthasthana31@gmail.com>
 <750BA887-BECB-471D-8BB2-0B321778F376@gmail.com>
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <750BA887-BECB-471D-8BB2-0B321778F376@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 26/09/22 19:41, John Cai wrote:
> Hi Siddarth,
> 
> On 26 Sep 2022, at 5:14, Siddharth Asthana wrote:
> 
>> The command git cat-file can now use the mailmap mechanism to replace
>> idents with their canonical versions for commit and tag objects. There
>> are several options like `--batch`, `--batch-check` and
>> `--batch-command` that can be combined with `--use-mailmap`. But, the
>> documentation for `--batch`, `--batch-check` and `--batch-command`
>> doesn't say so. This patch fixes that documentation.
>>
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: John Cai <johncai86@gmail.com>
>> Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
>> ---
>>
>> This patch was previously sent as the first patch of a 3 patch series for
>> adding the mailmap support in git cat-file options:
>> https://lore.kernel.org/git/20220916205946.178925-2-siddharthasthana31@gmail.com/
>>
>> Changes in v2:
>> - Fixed the names in trailers in the commit message
>> - Updated the documentation to clearly state that the `--batch-check`,
>>    `--batch-command` and `--batch` options can only be used with
>>    `--textconv`, `--filters` or `--use-mailmap`.
>> - Fixed formating
>>
>>   Documentation/git-cat-file.txt | 45 ++++++++++++++++++++++++----------
>>   1 file changed, 32 insertions(+), 13 deletions(-)
>>
>> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
>> index ec30b5c574..2a8f050a29 100644
>> --- a/Documentation/git-cat-file.txt
>> +++ b/Documentation/git-cat-file.txt
>> @@ -89,26 +89,45 @@ OPTIONS
>>   --batch::
>>   --batch=<format>::
>>   	Print object information and contents for each object provided
>> -	on stdin.  May not be combined with any other options or arguments
>> -	except `--textconv` or `--filters`, in which case the input lines
>> -	also need to specify the path, separated by whitespace.  See the
>> -	section `BATCH OUTPUT` below for details.
>> +	on stdin. May not be combined with any other options or arguments
>> +	except --textconv, --filters or --use-mailmap.
> 
> except --textconv, --filters, or --use-mailmap.
> 
>> +	+
>> +	* When used with `--textconv` or `--filters`, the input lines
>> +	  must specify the path, separated by whitespace. See the section
>> +	  `BATCH OUTPUT` below for details.
>> +	+
>> +	* When used with `--use-mailmap`, the info command shows the size
>> +	  the object, if the idents recorded in it were the ones "corrected"
>> +	  by the mailmap mechanism.
> 
> When used with `--use-mailmap`, the info command shows the size
> the object if the identities recorded in it were replaced
> by the mailmap mechanism.
> 
>>
>>   --batch-check::
>>   --batch-check=<format>::
>> -	Print object information for each object provided on stdin.  May
>> -	not be combined with any other options or arguments except
>> -	`--textconv` or `--filters`, in which case the input lines also
>> -	need to specify the path, separated by whitespace.  See the
>> -	section `BATCH OUTPUT` below for details.
>> +	Print object information for each object provided on stdin. May not be
>> +	combined with any other options or arguments except --textconv, --filters
>> +	or --use-mailmap.
>> +	+
>> +	* When used with `--textconv` or `--filters`, the input lines must
>> +	 specify the path, separated by whitespace. See the section
>> +	 `BATCH OUTPUT` below for details.
>> +	+
>> +	* When used with `--use-mailmap`, the info command shows the size
>> +	  the object, if the idents recorded in it were the ones "corrected"
>> +	  by the mailmap mechanism.
> 
> Same as above
> 
>>   --batch-command::
>>   --batch-command=<format>::
>>   	Enter a command mode that reads commands and arguments from stdin. May
>> -	only be combined with `--buffer`, `--textconv` or `--filters`. In the
>> -	case of `--textconv` or `--filters`, the input lines also need to specify
>> -	the path, separated by whitespace. See the section `BATCH OUTPUT` below
>> -	for details.
>> +	only be combined with `--buffer`, `--textconv`, `--use-mailmap` or
>> +	`--filters`.
>> +	+
>> +	* When used with `--textconv` or `--filters`, the input lines must
>> +	  specify the path, separated by whitespace. See the section
>> +	  `BATCH OUTPUT` below for details.
>> +	+
>> +	* When used with `--use-mailmap`, the info command shows the size the
>> +	  object, if the idents recorded in it were the ones "corrected" by the
>> +	  mailmap mechanism.
> 
> Same as above
> 
>> +
>>   +
>>   `--batch-command` recognizes the following commands:
>>   +
>> -- 
>> 2.38.0.rc1.4.g29ac4cf309.dirty
> 
> thanks!

Thanks a lot for the review John! Will make the suggested changes and 
send the v3 patch.
