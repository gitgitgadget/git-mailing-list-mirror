Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5721EC433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 18:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D9C022CB2
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 18:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pHnF3LNy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387788AbgGaSYS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 14:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387716AbgGaSYR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 14:24:17 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E15C061574
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 11:24:17 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g10so6906452wmc.1
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 11:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rn9H4zDi4PoHyvM5VipYsoJH3SezqQpm1Lk3V1il3x4=;
        b=pHnF3LNyNsu1Yb8ETPBSt2GQburzggA0vr3WGdxJTkVNdFTbF+XKB/TEegi/fBpFGY
         FrV+U+5kaoFwGhk8SDdnzJ+CZz9NRmkThnJUQH3NAH5igEj8ki4vrUik7vU65u2Psm5G
         Ih1BBmqzOYXbXIpc4M8oAs3sNmcDoO/1v3335m7mXLLOtoARFd8DXcJ/eQtrWw7QRsKu
         M8LNICgGs99aoUUcWsD66ix4DOaI61Rr/TgZvi799/dz81hZIrgp2FL9NaG6ryVJtIw0
         zsgPiSkeUhIP4DbTZjEJLsfe5Q8F6saTzPKv1UQ41BI8/8s+Ks7atcmlRLnb7P3WBOef
         cFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rn9H4zDi4PoHyvM5VipYsoJH3SezqQpm1Lk3V1il3x4=;
        b=P5gTuR5V4UomTHmFSAOV53ElLZlq8yUuPCCTS6FXZd9kJzWo2JIgC3wvCTshg8FwEJ
         FSuDz23QMOe+xfCNwzHParQaI+0JB1pOB3i394ke2xiICKigpHGidcbGq9LbB0CldnDC
         EBNVO9tTuHffEteG42BnCARlbbfvjAhn+lcHEAh0GFydLLW2fD7/xLFlWUbvdYr6HbcW
         Zun18j3DY3Z0CiScUaDKRvGcj3HGMgTVVgpq52A1eLVEuTjB4LnKmjKYJgj6gS5VQqZ6
         y6VyqLcWgs87FwUU41yoXEpMXq1LShST8QuKiYYcfxoiIhAtA2Mm+oG7Rc63JeoLCaD8
         STUA==
X-Gm-Message-State: AOAM533PdAja3GvKr5Y18g1T6MJHc3X7k784x1n19u0Di8j9R60P8RCD
        xy8/xwO91NgzO0qNp6PxuiU=
X-Google-Smtp-Source: ABdhPJw4IvU48a7EMls+NplYFfPh9QFcKRsSBWAODW+FI8akO6jS37JhYhqd4EviE9jX4uhADSuEHQ==
X-Received: by 2002:a7b:c306:: with SMTP id k6mr5008652wmj.86.1596219856280;
        Fri, 31 Jul 2020 11:24:16 -0700 (PDT)
Received: from [192.168.0.104] (atoulouse-654-1-421-163.w2-6.abo.wanadoo.fr. [2.6.84.163])
        by smtp.gmail.com with ESMTPSA id k1sm14818118wrw.91.2020.07.31.11.24.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2020 11:24:15 -0700 (PDT)
Subject: Re: [PATCH v1] t6300: fix issues related to %(contents:size)
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
References: <21bb2dad-5845-8cee-8f6a-1089ef7cae3b@gmail.com>
 <20200731174509.9199-1-alban.gruin@gmail.com>
 <20200731174709.GD843002@coredump.intra.peff.net>
From:   Alban Gruin <alban.gruin@gmail.com>
Autocrypt: addr=alban.gruin@gmail.com; prefer-encrypt=mutual; keydata=
 mQINBFcsWp4BEAC6dalBNr/CZCvvfeARylnjAaZCxMPwUHXAyf4xotA59sNcyVmaFQ6KxQEs
 R20CSJhO6HqCh4bR9/994vdc4cGuNaWf82eYRYzqCzwFWvFJHj83QgDR2cjtz4frKpj3jSFJ
 No3KBlMmpU8yvSnYaCxjqHxBB+fZwkmmONj/57KdFRU83DvDllQdAxXfxEavL3qUKjVbld29
 o82M2xsN8ZN5KTw7rAMHcigYVnlrgP50euxz3WvfrV+Mky2W7q7m5rTK7eXqOKhewsKcxo0I
 AP+H0Nt91YTmMIAX2Ba25IfHI99kUCLpbHX9xdvj5UH1SZsG84APahdI3CXYibfYIS+qssoo
 72qj7eBIoCFbVS4Q5AINxojio32orGBDE8CaCy3EzTF+vwJ+h4uUKrTX4wyUMy8nXS0UxZqD
 aQsS7Di6LdAHu+4uf064mXdgjehJ2uHAydFnCThMoxckRoSZ70iCPwgconhNrnuTmunJ43BF
 YjAurjg8y3WrMPJuJaI42q0sYbAX21XeayyMI8dzoNwyG6s+v0Udb/uxdYnHhsGx1oXjYCeR
 nyBdVwdMLWFP4XmJH7JueGUZ37TLh719ME6HYRpfM3sh915ywPxKxQYmGC9iXRThXdGK7ipq
 hJM5RtMq4QPGg+/ShgTZaDdFuMnG8Zrq6W+O29h9NB5rQ/UvBwARAQABtCNBbGJhbiBHcnVp
 biA8YWxiYW4uZ3J1aW5AZ21haWwuY29tPokCcAQTAQIAWgIbAwIeAQIXgAULBwgJCgQVCAkK
 BRYAAQIDHxhoa3A6Ly9wb29sLnNrcy1rZXlzZXJ2ZXJzLm5ldC8CGQEWIQS1T1bLFrFdtpxn
 TIMOC58lWpNWKgUCWRSuYAAKCRAOC58lWpNWKoCfEACHmff95NF5OrBKN+GPYo3TOojjgjio
 CREt9BNIU1ltbks33N/84QF1ifjFF5xjK1XpNhZdk2Nxk+Uf3ByAS24i0b7/BM58RX3sJMHd
 mklCbqBGLBTS+bO/3nc+1snb7FPmjoi3IXznQ25ZXiV/9MUABUBZi7odwNhxeI3Hd2PaX/x5
 ZM0BApqhmBrueUd0JKqY7f/7a+0rTJ8fIHV9ml3cVWf72t2BVnxJMeNLSAIT1FaL8Okp8ViO
 t7RfjF0JZsYZouhCcw2fx7U0VxXGu6bONdVGxu07I7G3+vjhd2C/ld0dgRRjx8viA5HecUSf
 bwbviEXlc44TVo8D6tkrKOezctqNTLII498C7gIQZjc+6HmIIQrOzzLX/C27JQbXch+6KtHO
 ThYGzmD0d7EttTRtXnFJFTMbQMMFnc2X+Rh1ubvfp4Zp2U3a7Nh1//4+ikqIAPV8poJcEdQ0
 A6CaGD8pTCMdExDovizfJRU0ZN3AU9UgFsZWkMK7MFyJneRObUf26oXCQH8zVuJEJHrEsYPk
 VHdV1G86d++CdipKqe9iDNBGNa/5Q9IvYEKK6vj4wLS5ZaOwLGfApbsOcDJvFA1ll/KeHvzx
 Ig9dhUnNCtYXKJ1npChigwRbAiAADoTFI2rI69g6ZTTzBd0+9GM4z6RcOJvtGLnViO4tOCmy
 sbwbxA==
Message-ID: <e81ef39d-da2a-6263-787f-a8fe367b98e3@gmail.com>
Date:   Fri, 31 Jul 2020 20:24:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200731174709.GD843002@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 31/07/2020 à 19:47, Jeff King a écrit :
> On Fri, Jul 31, 2020 at 07:45:09PM +0200, Alban Gruin wrote:
> 
>> b6839fda68 (ref-filter: add support for %(contents:size), 2020-07-16)
>> added a new format for ref-filter, and added a function to generate
>> tests for this new feature in t6300.  Unfortunately, it tries to run
>> `test_expect_sucess' instead of `test_expect_success', and writes
>> $expect to `expected', but tries to read `expect'.  Those two issues
>> were probably unnoticed because the script only printed errors, but did
>> not crash.  This fixes these issues.
> 
> Oh, this just crossed with my mail. :)
> 
> Definitely fixes the issue, though I wonder:
> 
>> -		echo $expect >expected
>> -		test_expect_${4:-sucess} $PREREQ "basic atom: $1 contents:size" '
>> +		echo $expect >expect
>> +		test_expect_${4:-success} $PREREQ "basic atom: $1 contents:size" '
>>  			git for-each-ref --format="%(contents:size)" "$ref" >actual &&
>>  			test_cmp expect actual
>>  		'
> 
> Should we instead switch the test_cmp to look at "expected" to be
> consistent with the rest of the tests in this file?
> 
> -Peff
> 

OK, I'm fixing that.

Alban

