Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A28371F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 18:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbeKNEl5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 23:41:57 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36412 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbeKNEl5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 23:41:57 -0500
Received: by mail-qk1-f193.google.com with SMTP id o125so21276358qkf.3
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 10:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=pMy10rUh8sl6GtQXqPR8ZR/PWu4OSTe6LEAxINGBIjg=;
        b=mku3sd/0gGlFOwha5kqTwRkxwUtS8cwji9bsk0aOBOCQPrWNTfOhHYvIer5yw7hci4
         ofN3ZDM3+aIHghXW6hgEXDzgovTURWVbk+9n4dAW1b6j125b8pD473Brv1WxLsJunD7t
         5306rUhnx0D3Dqee8GKjJPmhYIQjVWdm6vebHjUNRGtl3uCn9HBwsZWCgEomcBuZr0ns
         YTdC8//ZcwN1bqgezTIJUZDNiduXs/rrVsAoZTDr+Hylw+JP8mWOC1TCxqwaMZ4nlT7h
         QCbcysvIg5tYjH42d5knrSBLqJW6ZSvs6LPRJB/w58QS/Ho6JzByxL1IZ/bB4tIjK6Zz
         nU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pMy10rUh8sl6GtQXqPR8ZR/PWu4OSTe6LEAxINGBIjg=;
        b=gKyxiK3ISXuSbwxd1zNSJ8h3j1IR+aI+yG8o873WPMuSkher3ztSV/UCk4alj0J5VE
         Y58XjShsdJxpFvEgw6y/eKSwl04Bi9/jvqTmwRnqSqNZ3Cstxco8QDHGcb6iH+KZUwdb
         obEkEHK1a4WXaf1L5u3sI4UQOEtM9UZ/Myk9PZRd5o11GqUdjtDajlnSoyVWJ9faLZaE
         jCNZZNc9cfSQxJTxfRX72v3eGwzFDPbv4JRdrOco9nPBDyoCDlqKgWBMaaJ1qX5TPeFs
         CFvqc+O7Z4NBegf/qGfBT/CCInQ1uXS/SuM0RoMRJbI0kK0BTcmtucJnRcNl/GJhdhIH
         kXSg==
X-Gm-Message-State: AGRZ1gIO7ue0gc3IGTa65b28gHObmQhMMWLBrxQJvCKKhvyitsQskdub
        /d4XCBKJtuY9EM/W1zhKwQI=
X-Google-Smtp-Source: AJdET5c/Pf/Yc4p7+B3TFRMzEn/ewVeEfcqgaQp8tYdE1FgucBdVdBDV0XK+D+CQ7GanikHot1+8mQ==
X-Received: by 2002:a37:11e8:: with SMTP id 101mr5833509qkr.286.1542134555285;
        Tue, 13 Nov 2018 10:42:35 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:b86f:fd67:3f75:fa3? ([2001:4898:8010:0:a1a5:fd67:3f75:fa3])
        by smtp.gmail.com with ESMTPSA id r24sm15705105qtr.2.2018.11.13.10.42.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 10:42:34 -0800 (PST)
Subject: Re: [PATCH v5 02/12] sha1-file: provide functions to look up hash
 algorithms
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
References: <20181025024005.154208-1-sandals@crustytoothpaste.net>
 <20181104234458.139223-1-sandals@crustytoothpaste.net>
 <20181104234458.139223-3-sandals@crustytoothpaste.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <06e5bc95-b901-163a-5088-888878187ca2@gmail.com>
Date:   Tue, 13 Nov 2018 13:42:31 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20181104234458.139223-3-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/4/2018 6:44 PM, brian m. carlson wrote:
> +int hash_algo_by_name(const char *name)
> +{
> +	int i;
> +	if (!name)
> +		return GIT_HASH_UNKNOWN;
> +	for (i = 1; i < GIT_HASH_NALGOS; i++)
> +		if (!strcmp(name, hash_algos[i].name))
> +			return i;
> +	return GIT_HASH_UNKNOWN;
> +}
> +

Today's test coverage report [1] shows this method is not covered in the 
test suite. Looking at 'pu', it doesn't have any callers.

Do you have a work in progress series that will use this? Could we add a 
test-tool to exercise this somehow?

Thanks,
-Stolee

[1] 
https://public-inbox.org/git/97be3e21-6a8c-9718-5161-37318f6d685f@gmail.com/
