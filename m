Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87236215F4
	for <e@80x24.org>; Tue,  1 May 2018 13:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755294AbeEANFT (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 09:05:19 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:43454 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755236AbeEANFR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 09:05:17 -0400
Received: by mail-qk0-f171.google.com with SMTP id h19so8809337qkj.10
        for <git@vger.kernel.org>; Tue, 01 May 2018 06:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=enu1vPqIJawGcE5d53JTRzsTX7QvkJLOXWeAoz+Vcb0=;
        b=r6YTrSHbAtPNlBOYzrrdtuVe/iX79aFgu4FKmzkghfRY5W2zDpeBfFs8l+rWBEP7X4
         A7FmZ3GCoQw8R5cdIVj3APMe8+zhvUlxsa42ui+99aP5aYDnMLo3OHsS1JpeCpM+1cjH
         mE3YdhBDKoQgQfb7yC/1Huh4kG37rPW48+4KV6ZgYHQteOXkrqZZM3uhKyQXHF6NCqK1
         Ge50ttBaBY5IpgvQDOe/LERbeZOJGa5quyQpFmiH6YfSLJB3LE4BUOxBYtvitWitxqGa
         p+Esxe0mAf6Glq+BU5RwvQVOG4qV58Bt/6iU7gM5Bo0GdamvKFocMvjL8vUj+CNA+hQA
         RzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=enu1vPqIJawGcE5d53JTRzsTX7QvkJLOXWeAoz+Vcb0=;
        b=g3Yfyq9G/mFW2Vf2Gp1UmC9F9DWMYaYkSmo2CzebG33Ybv3ZpM2nmxlrA4zat8ljBD
         m5xs6n9SsZrCh6p61wFTYFTLcZHq46d5e919D7pgCSpp07LXZFkmHRsOHrxFhva6OR+9
         m8eX28bvxMfj/TBDQpARyAoQ8X8j2xI4SgbvRho/OU65VTMSZ8Sw/Ut2yEd86MxzNIvV
         iqfKizBRjWB+4Yz/wrEMdkDCo7mQQu+MAlKqFppWfltR4em19cDaGzDiN9YYHYAJR2AW
         poEh76beWJ7CElx4tcwFAbPafJqPGRQeERjrrA7ZACo89nZtAVymEM627Tetlk8PidWP
         xPXw==
X-Gm-Message-State: ALQs6tAHNF2xOsZ+pjZiDUYrCP9L5LCPiSVZ5L3Z5l3jpYVg7z1IBNpV
        SrSd6iulq+s36A3Dy3bZBZE=
X-Google-Smtp-Source: AB8JxZpjDIle2DV7Veml6uzwaObpWzjKo3t+D1CjVtI94SyQHGnpOAKQVf0q31LjtUiio3vYwbN0jA==
X-Received: by 10.55.100.201 with SMTP id y192mr12163243qkb.293.1525179916779;
        Tue, 01 May 2018 06:05:16 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id m10sm8008232qkh.20.2018.05.01.06.05.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 06:05:16 -0700 (PDT)
Subject: Re: [PATCH 4/9] get_short_oid: sort ambiguous objects by type, then
 SHA-1
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <20180430220734.30133-1-avarab@gmail.com>
 <20180430220734.30133-5-avarab@gmail.com>
 <5f8b1ec1-258d-1acc-133e-a7c248b4083e@gmail.com>
 <87a7tjzkdm.fsf@evledraar.gmail.com>
 <348f193f-47bb-112f-6ef5-571749bb01e2@gmail.com>
 <878t93zh60.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9245fe83-a3f7-c978-b260-4097ce5a99f5@gmail.com>
Date:   Tue, 1 May 2018 09:05:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <878t93zh60.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/1/2018 8:36 AM, Ævar Arnfjörð Bjarmason wrote:
> On Tue, May 01 2018, Derrick Stolee wrote:
>
>> How would sorting in our custom order before de-duplicating fail the
>> de-duplication? We will still pair identical OIDs as consecutive
>> elements and oid_array_for_each_unique only cares about consecutive
>> elements having distinct OIDs, not lex-ordered OIDs.
> Because there's no de-duplication without the array first being sorted
> in oidcmp() order, which oid_array_for_each_unique() checks for and
> re-sorts if !array->sorted. I.e. its de-duplication is just a state
> machine where it won't call the callback if the currently processed
> element has the same SHA1 as the last one.
>
>> Perhaps the noise is because we rely on oid_array_sort() to mark the
>> array as sorted inside oid_array_for_each_unique(), but that could be
>> remedied by calling our QSORT() inside for_each_abbrev() and marking
>> the array as sorted before calling oid_array_for_each_unique().
> As noted above this won't work, because the function inherently relies
> on the array being sorted to be able to de-duplicate. Doing this will
> yield duplicate entries.

I'm confused as to why my suggestion doesn't work, so I made it 
concrete. I sent an alternate commit 6/12 to your v2 series [1].

Thanks,
-Stolee

[1] 
https://public-inbox.org/git/20180501130318.58251-1-dstolee@microsoft.com/T/#u
