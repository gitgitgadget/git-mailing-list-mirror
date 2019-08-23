Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C37CB1F461
	for <e@80x24.org>; Fri, 23 Aug 2019 11:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393207AbfHWLxl (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Aug 2019 07:53:41 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46357 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391388AbfHWLxl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Aug 2019 07:53:41 -0400
Received: by mail-qt1-f196.google.com with SMTP id j15so10813476qtl.13
        for <git@vger.kernel.org>; Fri, 23 Aug 2019 04:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=SUJQ+yMn+ayFHiaamU2FlXSTMe2TYB9OcLpIPDJfssw=;
        b=Xz8UKuwf+Pbe7GczNhPJ6++i7rfLvIcOyAjuNBI93IrpgBm9ejihiNsM9q34higkMn
         +iyMVfN7jidK6zSkIcj9ZL+X969iPI+3bkv7eSO6Og5iU/F6AAB0svFf3l23J3YMX4ei
         JM8+NrQc5SQ4WceNXV1GrqV/SfNHjIUhuQC5Z57HLqzoYOYRn87Ni2hbGTMQJauMm2mu
         xch4U54TUkihDhl2+WWXwXdtwK06sYB3kmt/az7VUFg22NfpNGTyWdNfSMH02MiW9fJf
         Il5XAIF+EYzzgmXgh2JIJaC1HiWDlsdj7BFIEMJTGlwFW7HY5KyKd74dyfgbsuBegJbp
         KilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SUJQ+yMn+ayFHiaamU2FlXSTMe2TYB9OcLpIPDJfssw=;
        b=csx5FrpkKYX6bgMW3yYVa+7vnr7t/wOVeS4Aw/JgeL6bvl7Uezq6RVxh1DBE2vDJXU
         sCJCWDdDvP63r/hx1b9OkEbUxxsUpcdCDGggK16lpxlsvgBtgNoGHOutXkMSSxr9QAv8
         RcBVBIp2P6vwalZruhR8691Gx5nj6KRTt0UaTAlFwlXRsMK/Zw8dlw1E/GrZjKx2hOss
         UzTNYlzxtQ4z/45h3NwWSmRpT0/YGw92q5mEESfiaxljK4gzLomjejUfDQmzGEC8tBAY
         CijbU6leKOvwG/sCsnysCNFiNk3WgLcHQUkg740wJcQRX/8JvYMON7PaGv2rd9qvajPV
         /SeQ==
X-Gm-Message-State: APjAAAUcUU8eNeEPziZoUZmKrgf0uT88sSVL/BWkM7QW6IqpHnPAAJ3j
        5F+4lsIsHRN8cozJD47mXDs=
X-Google-Smtp-Source: APXvYqwQKb5ZzcfKhyFyehjWqc48940N6VGpVJQVRfPTz75MgnME4TQwoE4/z/zQRF8yJSkvcSBz1g==
X-Received: by 2002:a05:6214:4cc:: with SMTP id ck12mr3357577qvb.194.1566561220278;
        Fri, 23 Aug 2019 04:53:40 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:15df:50c4:43d1:68bd? ([2001:4898:a800:1012:c712:50c4:43d1:68bd])
        by smtp.gmail.com with ESMTPSA id d2sm1238534qko.26.2019.08.23.04.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2019 04:53:39 -0700 (PDT)
Subject: Re: [PATCH 26/26] midx: switch to using the_hash_algo
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <20190818200427.870753-1-sandals@crustytoothpaste.net>
 <20190818200427.870753-27-sandals@crustytoothpaste.net>
 <4f6b781b-68b8-5bc4-92a2-67caff32024f@gmail.com>
 <20190823021757.GL365197@genre.crustytoothpaste.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <244c8006-d8fa-8440-e799-ba8e41eb40cb@gmail.com>
Date:   Fri, 23 Aug 2019 07:53:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <20190823021757.GL365197@genre.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/22/2019 10:17 PM, brian m. carlson wrote:
> On 2019-08-22 at 14:04:16, Derrick Stolee wrote:
>> On 8/18/2019 4:04 PM, brian m. carlson wrote:
>>> diff --git a/midx.c b/midx.c
>>> index d649644420..f29afc0d2d 100644
>>> --- a/midx.c
>>> +++ b/midx.c
>>> @@ -19,8 +19,7 @@
>>>  #define MIDX_BYTE_NUM_PACKS 8
>>>  #define MIDX_HASH_VERSION 1
>>
>> This hash version "1" is the same as we used in the commit-graph. It's
>> a byte value from the file format, and we've already discussed how it
>> would have been better to use the 4-byte identifier, but that ship has
>> sailed. I'm just pointing this out to say that we are not done in this
>> file yet, but we can get to that when we want to test the midx with
>> multiple hash lengths.
> 
> My approach so far has been to assume everything in the .git directory
> is in the same hash except for the translation functionality. Therefore,
> it doesn't make sense to distinguish between hashes in the midx files,
> because we'll never have files that differ in hash.  So essentially the
> MIDX_HASH_VERSION being 1 is "whatever hash is being used in the .git
> directory", not just SHA-1.
> 
> In addition, the current multi-pack index format isn't capable (from my
> reading of the documentation, at least) of handling multiple hash
> algorithms at once.  So we'd need a midx v2 format for folks who are
> using SHA-256 with SHA-1 compatibility and we could then write separate
> sets of object chunks with an appropriate format identifier, much like
> the proposed pack index v3.

Absolutely, it is not. It would be a great place to store a transition
table, when that is needed.

If we _never_ allow both hashes in the .git folder, then maybe we won't
ever need this and can rely on config options. I imagine that will be
tricky, and updating this byte should only help. We are not ready for
that, anyway.

Thanks,
-Stolee
