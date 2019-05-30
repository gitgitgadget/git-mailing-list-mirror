Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C87C61F609
	for <e@80x24.org>; Thu, 30 May 2019 20:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfE3Uyv (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 May 2019 16:54:51 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43327 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfE3Uyu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 May 2019 16:54:50 -0400
Received: by mail-qt1-f193.google.com with SMTP id z24so8730428qtj.10
        for <git@vger.kernel.org>; Thu, 30 May 2019 13:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nSLjbs7GQ3LW2l7/ollUWrKCnPkWHOepQdy23cDRo7M=;
        b=nedrXBHv4baiAWvuGVSgt4B1Qow7GGknUiiczfvD1BIx367w2pePF1X9a6CkqgrkAY
         mSe3kad4QZwW9lP7hmEVbiOODVllKEXBWxAF0J7WRJFNeYF+lJGpQ0t5umefgXV5R1ug
         uKbyRaNjxoPCDtPmoM+nJpaBdKQ7cfjk2M5JLd2bipIOQNl6oTdgHkVn7tKvWifyheJn
         FJ9WMmu0x+W/mUQC7MrXjf4ahrs/VfraMnIvSWGa1qGQLdIfSmfGI8euKOLvwF/EQ1pi
         0NCiUSss5QV9Q0gqBAxxpkQATrzeUVG6ip1PSxdQxzOogsad+iutIudWrI8HMrX8KF5j
         YKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nSLjbs7GQ3LW2l7/ollUWrKCnPkWHOepQdy23cDRo7M=;
        b=of+ztu7nHvXvxXGHLk7fYUSuM0DH864Pd8Fr7r7RRqML0dKvV/9W11owI2UFDXuWGb
         E0zrJ5SNyw4Axxs4RXYAcoXlNjGx4ZzscZN9LxCTx4Gou/jrr+0GA7yUorhD/jcE3GEw
         tbDaVCGFSB88DCn6bpsamnW+Ctt6HNHrkspIywiFHOSyU2uKBLKAS7jbl5YYtEdEWLNR
         LjmzzKNmfZWq7HDYFeZZa8IdZBjy5CK4H/aMJXWO5dsx46wCfBgdxRylVpyhXPFhVwL4
         zk5DIhwEVQ7SIf7HsQXyqyQFkCs39dnbGtyysLj14Vw+y2hcSdQkL6/ALB7Bho0aOCrI
         fy+g==
X-Gm-Message-State: APjAAAU9T3/+q8r98qFWo4rJyPsgEoABXpKhT2ZarLxzT3XAT96+NO2F
        ECG8mPrBr2oa2uNZBMuu/1g=
X-Google-Smtp-Source: APXvYqzcBZnFcuxxf7FgvT3Dj4QqsKZjGP93ErITpAOPxbkEow52bQEfUrtl+u9q73G4GWModMPb3A==
X-Received: by 2002:ac8:5485:: with SMTP id h5mr5449936qtq.253.1559249689636;
        Thu, 30 May 2019 13:54:49 -0700 (PDT)
Received: from [10.0.1.13] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id k9sm2208403qki.20.2019.05.30.13.54.48
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 13:54:48 -0700 (PDT)
Subject: Re: [PATCH v5 04/16] promisor-remote: implement
 promisor_remote_get_direct()
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
References: <20190409161116.30256-1-chriscool@tuxfamily.org>
 <20190409161116.30256-5-chriscool@tuxfamily.org>
 <b4d69d2b-dc0d-fffb-2909-c54060fe9cd1@gmail.com>
 <nycvar.QRO.7.76.6.1905302235000.44@tvgsbejvaqbjf.bet>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2329a4c7-bfb9-10ce-9d1c-8c754d6dee05@gmail.com>
Date:   Thu, 30 May 2019 16:54:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1905302235000.44@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/30/2019 4:46 PM, Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 30 May 2019, Derrick Stolee wrote:
> 
>> On 4/9/2019 12:11 PM, Christian Couder wrote:
>>> From: Christian Couder <christian.couder@gmail.com>
>>>
>>> +{
>>> +	int i, missing_nr = 0;
>>> +	int *missing = xcalloc(oid_nr, sizeof(*missing));
>>> +	struct object_id *old_oids = *oids;
>>> +	struct object_id *new_oids;
>>> +	int old_fetch_if_missing = fetch_if_missing;
>>> +
>>> +	fetch_if_missing = 0;
>>
>> This global 'fetch_if_missing' swap seems very fragile. I'm guessing you
>> are using it to prevent a loop when calling oid_object_info_extended()
>> below. Can you instead pass a flag to the method that disables the
>> fetch_if_missing behavior?
> 
> FWIW I mentioned the very same concern here:
> https://public-inbox.org/git/nycvar.QRO.7.76.6.1903272300020.41@tvgsbejvaqbjf.bet/
> 
> The situation is *pretty* bad by now. I see `fetch_if_missing` mentioned
> 25 times in `master`, and all but one are in .c files or in cache.h.
> 
> The flag is actually used only in `oid_object_info_extended()`, and that
> function accepts an `unsigned flags`, so one might think that it could be
> extended to accept also a `OBJECT_INFO_LOOKUP_FETCH_IF_MISSING`. But then,
> there are many callers of that function, some of them also pretty low in
> the food chain. For example, `oid_object_info()` (does not accept `flags`)
> or `read_object()` (does not accept flags either).
>
> So it looks as if the idea to pass this flag down the call chain entailed
> a pretty serious avalanche effect.

It could be approached in small bits.

First, add an OBJECT_INFO_NEVER_FETCH_IF_MISSING flag that overrides fetch_if_missing,
and then use the flag in small places like this one. Then, build up to the other
methods as appropriate.

> An alternative that strikes me as inelegant, still, but nevertheless
> better would be to move `fetch_if_missing` into `struct repository`.

This is literally the _least_ we should do to reduce our dependence on
globals. Maybe this happens first, then the flag idea could be done bits
at a time.

Thanks,
-Stolee

